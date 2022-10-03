#tag Class
Protected Class Compiler
Implements ObjoScript.ExprVisitor,ObjoScript.StmtVisitor
	#tag Method, Flags = &h21, Description = 41646473206076616C75656020746F207468652063757272656E742066756E6374696F6E277320636F6E7374616E7420706F6F6C20616E642072657475726E732069747320696E64657820696E2074686520706F6F6C2E
		Private Function AddConstant(value As Variant) As Integer
		  /// Adds `value` to the current function's constant pool and returns its index in the pool.
		  
		  Var index As Integer = CurrentChunk.AddConstant(value)
		  
		  If index > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("To many constants in the chunk.")
		  End If
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547261636B732061206C6F63616C207661726961626C6520696E207468652063757272656E742073636F70652E
		Private Sub AddLocal(identifier As ObjoScript.Token, initialised As Boolean = False)
		  /// Tracks a local variable in the current scope.
		  
		  If locals.Count > MAX_LOCALS Then
		    Error("Too many local variables in scope.")
		  End If
		  
		  // Set the local's depth to `-1` if not yet initialised.
		  Locals.Add(New ObjoScript.LocalVariable(identifier, If(initialised, ScopeDepth, -1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320616E2061737369676E6D656E7420746F2061207661726961626C65206E616D656420606E616D65602E
		Private Sub Assignment(name As String)
		  /// Compiles an assignment to a variable named `name`.
		  ///
		  /// The value to assign will already be on the top of the stack.
		  
		  Var arg As Integer = ResolveLocal(name)
		  If arg <> -1 Then
		    // Set a local variable.
		    EmitBytes(ObjoScript.VM.OP_SET_LOCAL, arg)
		  Else
		    // Set a global variable.
		    // Add the name of the variable to the constant pool and get its index.
		    Var index As Integer = AddConstant(name)
		    If index <= 255 Then
		      // We only need a single byte operand to specify the index of the assignee's name in the constant pool.
		      EmitBytes(ObjoScript.VM.OP_SET_GLOBAL, index)
		    Else
		      // We need two bytes for the operand.
		      EmitByte(ObjoScript.VM.OP_SET_GLOBAL_LONG)
		      EmitUInt16(index)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652061627374726163742073796E7461782074726565206C61737420636F6D70696C6564206279207468697320636F6D70696C65722E2049742073686F756C6420626520636F6E7369646572656420726561642D6F6E6C792E
		Function AST() As ObjoScript.Stmt()
		  /// Returns the abstract syntax tree last compiled by this compiler.
		  /// It should be considered read-only.
		  
		  Return mAST
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BeginScope()
		  /// Begins a new scope.
		  
		  ScopeDepth = ScopeDepth + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320726177204F626A6F20736F7572636520636F646520696E746F206120746F70206C6576656C2066756E6374696F6E2E204D6179207261697365206120604C65786572457863657074696F6E602C2060506172736572457863657074696F6E60206F722060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(source As String) As ObjoScript.Func
		  /// Compiles raw Objo source code into a top level function. 
		  /// May raise a `LexerException`, `ParserException` or `CompilerException` if an error occurs.
		  
		  Reset
		  
		  // Tokenise. This may raise a LexerException, therefore aborting compilation.
		  mStopWatch.Start
		  mTokens = Lexer.Tokenise(source)
		  mStopWatch.Stop
		  mTokeniseTime = mStopWatch.ElapsedMilliseconds
		  
		  // Parse.
		  mStopWatch.Start
		  mAST = Parser.Parse(Tokens)
		  mStopWatch.Stop
		  mParseTime = mStopWatch.ElapsedMilliseconds
		  
		  If Parser.HasError Then
		    Var message As String
		    If Parser.Errors.Count = 1 Then
		      message = "A parsing error occurred."
		    Else
		      message = Parser.Errors.Count.ToString + " parsing errors occurred."
		    End If
		    #Pragma BreakOnExceptions False
		    Raise New ObjoScript.ParserException(message, Parser.Errors(0).Location)
		  End If
		  
		  // Compile.
		  Return CompileMainFunction(ast)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612066756E6374696F6E206465636C61726174696F6E20696E746F20612066756E6374696F6E2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(name As String, parameters() As ObjoScript.Token, body As ObjoScript.BlockStmt, type As ObjoScript.FunctionTypes, shouldResetFirst As Boolean = True) As ObjoScript.Func
		  /// Compiles a function declaration into a function. Raises a `CompilerException` if an error occurs.
		  ///
		  /// Resets by default but if this is being called internally (after the compiler has tokenised and parsed the source) 
		  /// then we skip resetting by setting `shouldResetFirst` to True.
		  
		  mStopWatch.Start
		  
		  If shouldResetFirst Then Reset
		  
		  Func = New ObjoScript.Func(name, parameters.Count)
		  Self.Type = type
		  
		  If type <> ObjoScript.FunctionTypes.TopLevel Then
		    BeginScope
		    
		    // Compile the parameters.
		    If parameters.Count > 255 Then
		      Error("Functions cannot have more than 255 parameters.")
		    End If
		    Func.Arity = parameters.Count
		    
		    For Each p As ObjoScript.Token In parameters
		      DeclareVariable(p)
		      DefineVariable(0) // The index value doesn't matter as the parameters are local.
		    Next p
		  End If
		  
		  // Compile the body of the function.
		  mAST = body.Statements
		  For Each stmt As ObjoScript.Stmt In mAST
		    Call stmt.Accept(Self)
		  Next stmt
		  
		  // Handle an empty body/AST.
		  Var endLocation As ObjoScript.Token
		  If mAST.Count = 0 Then
		    // Synthesise a fake end location token.
		    endLocation = New ObjoScript.Token(ObjoScript.TokenTypes.EOF, 0, 1)
		  ElseIf mAST(mAST.LastIndex) IsA ObjoScript.BlockStmt Then
		    endLocation = ObjoScript.BlockStmt(mAST(mAST.LastIndex)).ClosingBrace
		  Else
		    endLocation = mAST(mAST.LastIndex).Location
		  End If
		  
		  // Wind down the compiler.
		  EndCompiler(endLocation)
		  
		  mStopWatch.Stop
		  mCompileTime = mStopWatch.ElapsedMilliseconds
		  
		  Return Func
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B657320616E206172726179206F662073746174656D656E747320616E642072657475726E732074686520636F6D70696C656420656E7472792D6C6576656C20226D61696E222066756E6374696F6E2E
		Private Function CompileMainFunction(body() As ObjoScript.Stmt) As ObjoScript.Func
		  /// Takes an array of statements and returns the compiled entry-level "main" function.
		  
		  // Synthesise a token for the (non-existent) opening and closing curly braces and the 
		  // (non-existent) `function` keyword of this implicit main function.
		  Var openingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.LCurly, 0, 0, "", -1)
		  Var closingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.RCurly, 0, 0, "", -1)
		  
		  // Empty parameters.
		  Var params() As ObjoScript.Token
		  
		  Return Compile("", params, New ObjoScript.BlockStmt(body, openingBrace, closingBrace), ObjoScript.FunctionTypes.TopLevel, False)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Reset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206368756E6B207468697320636F6D70696C65722069732063757272656E746C7920636F6D70696C696E6720696E746F2E
		Function CurrentChunk() As ObjoScript.Chunk
		  /// Returns the chunk this compiler is currently compiling into.
		  
		  Return Func.Chunk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 466F72206C6F63616C207661726961626C65732C20746869732069732074686520706F696E742061742077686963682074686520636F6D70696C6572207265636F726473207468656972206578697374656E63652E
		Sub DeclareVariable(identifier As ObjoScript.Token, initialised As Boolean = False)
		  /// For local variables, this is the point at which the compiler records their existence.
		  ///
		  /// `identifier` is the token representing the variable's name in the original source code.
		  /// If `initialised` then marks the local as initialised immediately (relevant for functions).
		  
		  // Global variables are late bound so the compiler doesn't keep track of
		  // which declarations for them it has seen.
		  If ScopeDepth = 0 Then Return
		  
		  // Ensure that another variable has not been declared in current scope with this name.
		  Var name As String = identifier.Lexeme
		  For i As Integer = Locals.Count - 1 DownTo 0
		    Var local As ObjoScript.LocalVariable = Locals(i)
		    If local.Depth <> -1 And local.Depth < ScopeDepth Then
		      Exit
		    End If
		    
		    If name = local.Name Then
		      Error("There is already a variable with this name (" + name + ") in this scope.")
		    End If
		  Next i
		  
		  // Must be a local variable. Add it to the list of variables in the current scope.
		  AddLocal(identifier, initialised)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446566696E65732061207661726961626C6520617320726561647920746F207573652E
		Sub DefineVariable(index As Integer)
		  /// Defines a variable as ready to use.
		  ///
		  /// For globals it outputs the instructions required to define a global variable whose name is stored in the
		  /// constant pool at `index`.
		  /// For locals, it marks the variable as ready for use by setting its `Depth` property to the current scope depth.
		  
		  // Nothing to do if this is a local variable definition.
		  If ScopeDepth > 0 Then
		    MarkInitialised
		    Return
		  End If
		  
		  If index <= 255 Then
		    // We only need a single byte operand to specify the index of the variable's name in the constant pool.
		    EmitBytes(ObjoScript.VM.OP_DEFINE_GLOBAL, index)
		  Else
		    // We need two bytes for the operand.
		    EmitByte(ObjoScript.VM.OP_DEFINE_GLOBAL_LONG)
		    EmitUInt16(index)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 47656E65726174657320636F646520746F2064697363617264206C6F63616C207661726961626C65732061742060646570746860206F7220677265617465722E20446F6573202A6E6F742A2061637475616C6C7920756E6465636C617265207661726961626C6573206F7220706F7020616E792073636F7065732E2052657475726E7320746865206E756D626572206F66206C6F63616C207661726961626C65732074686174207765726520656C696D696E617465642E
		Private Function DiscardLocals(depth As Integer) As Integer
		  /// Generates code to discard local variables at `depth` or greater. Does *not*
		  /// actually undeclare variables or pop any scopes. 
		  /// Returns the number of local variables that were eliminated.
		  ///
		  /// This is called directly when compiling "exit" statements to ditch the local variables
		  /// before jumping out of the loop even though they are still in scope *past*
		  /// the exit instruction.
		  
		  If ScopeDepth < 0 Then
		    Error("Cannot exit top-level scope.")
		  End If
		  
		  Var local As Integer = Locals.LastIndex
		  While local >= 0 And Locals(local).Depth >= depth
		    EmitByte(ObjoScript.VM.OP_POP)
		    local = local - 1
		  Wend
		  
		  Return Locals.Count - local - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320612073696E676C65206279746520746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E
		Private Sub EmitByte(b As UInt8, location As ObjoScript.Token = Nil)
		  /// Appends a single byte to the current chunk at the current location. An optional `location` can be provided.
		  
		  If location = Nil Then location = mLocation
		  
		  CurrentChunk.WriteByte(b, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E64732074776F20627974657320746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E
		Private Sub EmitBytes(b1 As UInt8, b2 As UInt8, location As ObjoScript.Token = Nil)
		  /// Appends two bytes to the current chunk at the current location. An optional `location` can be provided.
		  
		  If location = Nil Then location = mLocation
		  
		  CurrentChunk.WriteByte(b1, location)
		  CurrentChunk.WriteByte(b2, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473206076616C75656020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C206174207468652063757272656E74206C6F636174696F6E2E2052657475726E732074686520696E64657820696E2074686520636F6E7374616E7420706F6F6C206F7220602D31602069662068617320646564696361746564206F70636F6465206163636573736F722E20507573686573206076616C756560206F6E20746F2074686520737461636B2E
		Private Function EmitConstant(value As Variant, location As ObjoScript.Token = Nil) As Integer
		  /// Adds `value` to the current chunk's constant pool at the current location.
		  /// Returns the index in the constant pool or `-1` if has dedicated opcode accessor.
		  /// Pushes `value` on to the stack.
		  
		  If location = Nil Then location = mLocation
		  
		  // Common cases.
		  // The VM has dedicated instructions for producing certain numeric constants that are commonly used.
		  If value.Type = Variant.TypeDouble Then
		    Select Case value
		    Case 0
		      EmitByte(ObjoScript.VM.OP_LOAD_0, location)
		      Return -1
		    Case 1
		      EmitByte(ObjoScript.VM.OP_LOAD_1, location)
		      Return -1
		    End Select
		  End If
		  
		  Var index As Integer = AddConstant(value)
		  
		  If index <= 255 Then
		    // We only need a single byte operand to specify the index of the constant.
		    EmitBytes(ObjoScript.VM.OP_CONSTANT, index, location)
		  Else
		    // We need two bytes for the operand.
		    EmitByte(ObjoScript.VM.OP_CONSTANT_LONG, location)
		    EmitUInt16(index, location)
		  End If
		  
		  Return index
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320616E20696E737472756374696F6E20746F20676574206120676C6F62616C207661726961626C652077686F7365206E616D652069732073746F72656420696E2074686520636F6E7374616E7420706F6F6C2061742060696E6465786020616E642070757368206974206F6E746F2074686520737461636B2E
		Private Sub EmitGetGlobal(index As Integer, location As ObjoScript.Token = Nil)
		  /// Emits an instruction to get a global variable whose name is stored in 
		  /// the constant pool at `index` and push it onto the stack.
		  ///
		  /// It's a convenience method that exists to simplify the fact that there are two GET_GLOBAL 
		  // instructions which depend on the size of `index`.
		  
		  location = If(location = Nil, mLocation, location)
		  
		  If index <= 255 Then
		    // We only need a single byte operand to specify the index of the variable's name in the constant pool.
		    EmitBytes(ObjoScript.VM.OP_GET_GLOBAL, index, location)
		  Else
		    // We need two bytes for the operand.
		    EmitByte(ObjoScript.VM.OP_GET_GLOBAL_LONG, location)
		    EmitUInt16(index, location)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 49662060696E64657860203C3D20323535207468656E206073686F72744F70636F64656020697320656D697474656420666F6C6C6F776564206279207468652073696E676C6520627974652060696E646578602E204F746865727769736520606C6F6E674F70636F64656020697320656D697474656420666F6C6C6F776564206279207468652074776F20627974652060696E646578602E
		Private Sub EmitIndexedOpcode(shortOpcode As UInt8, longOpcode As UInt8, index As Integer, location As ObjoScript.Token = Nil)
		  /// If `index` <= 255 then `shortOpcode` is emitted followed by the single byte `index`. Otherwise `longOpcode` is emitted
		  /// followed by the two byte `index`.
		  
		  location = If(location = Nil, mLocation, location)
		  
		  If index <= 255 Then
		    // We only need a single byte operand to specify the index.
		    EmitBytes(shortOpcode, index, location)
		  Else
		    // We need two bytes for the operand.
		    EmitByte(longOpcode, location)
		    EmitUInt16(index, location)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732074686520606A756D70496E737472756374696F6E60206F63637572696E6720617420736F7572636520606C6F636174696F6E6020286F72207468652063757272656E74206C6F636174696F6E206966204E696C2920616E6420777269746573206120706C616365686F6C64657220282668464646462920666F7220746865206A756D70206F66667365742E2052657475726E7320746865206F6666736574206F6620746865206A756D7020696E737472756374696F6E2E
		Private Function EmitJump(jumpInstruction As UInt8, location As ObjoScript.Token = Nil) As Integer
		  /// Emits the `jumpInstruction` occuring at source `location` (or the current location if Nil) 
		  /// and writes a placeholder (&hFFFF) for the jump offset.
		  /// Returns the offset of the jump instruction.
		  ///
		  /// We can jump a maximum of &hFFFF (65,535) bytes.
		  
		  location = If(location = Nil, mLocation, location)
		  
		  EmitByte(jumpInstruction, location)
		  
		  EmitByte(&hff, location)
		  EmitByte(&hff, location)
		  
		  Return CurrentChunk.Length - 2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732061206E6577206C6F6F7020696E737472756374696F6E20776869636820756E636F6E646974696F6E616C6C79206A756D7073206261636B776172647320746F20606C6F6F705374617274602E20496620606C6F636174696F6E60206973204E696C20776520757365207468652063757272656E74206C6F636174696F6E2E
		Private Sub EmitLoop(loopStart As Integer, location As ObjoScript.Token = Nil)
		  /// Emits a new loop instruction which unconditionally jumps backwards to `loopStart`.
		  /// If `location` is Nil we use the current location.
		  
		  location = If(location = Nil, mLocation, location)
		  
		  EmitByte(ObjoScript.VM.OP_LOOP)
		  
		  // Compute the offset to subtract from the VM's instruction pointer.
		  // +2 accounts for OP_LOOP's own operands which we also need to jump over.
		  Var offset As Integer = CurrentChunk.Length - loopStart + 2
		  
		  // The maximal amount of code that can be jumped over is UInt16 max.
		  If offset > 65535 Then
		    Error("Maximal loop body size exceeded.")
		  End If
		  
		  // Emit the 16-bit offset.
		  EmitUInt16(offset, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320612072657475726E20696E737472756374696F6E2C2064656661756C74696E6720746F2072657475726E696E67204E6F7468696E67206F6E2066756E6374696F6E2072657475726E732E2044656661756C747320746F207468652063757272656E74206C6F636174696F6E2E
		Private Sub EmitReturn(location As ObjoScript.Token = Nil)
		  /// Emits a return instruction, defaulting to returning Nothing on function returns.
		  /// Defaults to the current location.
		  
		  If Self.Type = ObjoScript.FunctionTypes.Constructor Then
		    // Rather than return "Nothing", constructors must default to 
		    // returning `this` which will be in slot 0 of the call frame.
		    EmitBytes(ObjoScript.VM.OP_GET_LOCAL, 0, location)
		  Else
		    EmitByte(ObjoScript.VM.OP_NOTHING, location)
		  End If
		  
		  EmitByte(ObjoScript.VM.OP_RETURN, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320616E20756E7369676E656420696E7465676572202862696720656E6469616E20666F726D61742C206D6F7374207369676E69666963616E7420627974652066697273742920746F207468652063757272656E74206368756E6B2E205468652063757272656E74206C6F636174696F6E206973207573656420756E6C657373206F7468657277697365207370656369666965642E
		Private Sub EmitUInt16(i16 As UInt16, location As ObjoScript.Token = Nil)
		  /// Appends an unsigned integer (big endian format, most significant byte first) to the current chunk.
		  /// The current location is used unless otherwise specified.
		  
		  If location = Nil Then location = mLocation
		  
		  CurrentChunk.WriteUInt16(i16, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C6564207768656E2074686520636F6D70696C65722066696E69736865732E
		Sub EndCompiler(location As ObjoScript.Token)
		  /// Called when the compiler finishes.
		  
		  EmitReturn(location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E6473207468652063757272656E7420696E6E65726D6F7374206C6F6F702E205061746368657320757020616C6C206A756D707320616E64206578697473206E6F772074686174207765206B6E6F772077686572652074686520656E64206F6620746865206C6F6F702069732E
		Private Sub EndLoop()
		  /// Ends the current innermost loop. Patches up all jumps and exits now that
		  /// we know where the end of the loop is.
		  
		  // Jump back to the start of the current loop if the condition evaluates to truthy.
		  EmitLoop(CurrentLoop.Start, CurrentLoop.StartToken)
		  
		  // Back-patch the jump.
		  PatchJump(CurrentLoop.ExitJump)
		  
		  // The condition must have been falsey - pop the condition off the stack.
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		  // Find any `exit` placeholder instructions (which will be OP_EXIT in the
		  // bytecode) and replace them with real jumps.
		  Var i As Integer = CurrentLoop.BodyOffset
		  While i < CurrentChunk.Length
		    If CurrentChunk.Code(i) = ObjoScript.VM.OP_EXIT Then
		      CurrentChunk.Code(i) = ObjoScript.VM.OP_JUMP
		      PatchJump(i + 1)
		      i = i + 3
		    Else
		      // Skip this instruction and its operands.
		      i = i + 1 + OperandByteCountForOpcode(CurrentChunk.Code(i))
		    End If
		  Wend
		  
		  // Mark that we're exiting this loop.
		  CurrentLoop = CurrentLoop.Enclosing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456E6473207468652063757272656E742073636F70652E
		Private Sub EndScope()
		  /// Ends the current scope.
		  
		  ScopeDepth = ScopeDepth - 1
		  
		  // Remove any locals declared in this scope by popping them off the top of the stack.
		  Var popCount As Integer = 0
		  While Locals.Count > 0 And Locals(Locals.LastIndex).Depth > ScopeDepth
		    popCount = popCount + 1
		    // And removing them from the currently tracked locals array.
		    Call Locals.Pop
		  Wend
		  
		  // It's more efficient to pop multiple values off the stack at once, therefore we use OP_POP_N.
		  If popCount > 0 Then
		    EmitBytes(ObjoScript.VM.OP_POP_N, popCount)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526169736573206120436F6D70696C6572457863657074696F6E20617420606C6F636174696F6E602E
		Private Sub Error(message As String, location As ObjoScript.Token = Nil)
		  /// Raises a CompilerException at the current location. If the error is not at the current location,
		  /// `location` may be passed instead.
		  
		  #Pragma BreakOnExceptions False
		  
		  If location = Nil Then location = mLocation
		  
		  Raise New ObjoScript.CompilerException(message, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320746865204F505F4A554D505F49465F46414C534520696E737472756374696F6E207573656420746F207465737420746865206C6F6F7020636F6E646974696F6E20616E6420706F74656E7469616C6C79206578697420746865206C6F6F702E204B6565707320747261636B206F662074686520696E737472756374696F6E20736F2077652063616E207061746368206974206C61746572206F6E6365207765206B6E6F772077686572652074686520656E64206F662074686520626F64792069732E
		Private Sub ExitLoopIfFalse()
		  /// Emits the OP_JUMP_IF_FALSE instruction and an OP_POP used to test the loop condition and
		  /// potentially exit the loop. Keeps track of the instruction so we can patch it
		  /// later once we know where the end of the body is.
		  ///
		  /// Assumes a loop is currently being compiled.
		  
		  Self.CurrentLoop.ExitJump = EmitJump(ObjoScript.VM.OP_JUMP_IF_FALSE)
		  
		  // Pop the condition before executing the body.
		  EmitByte(ObjoScript.VM.OP_POP)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732061206C6F676963616C2060616E64602065787072657373696F6E2E
		Private Sub LogicalAnd(logical As ObjoScript.BinaryExpr)
		  /// Compiles a logical `and` expression.
		  ///
		  /// Assumes `logical` is a logical `and` expression.
		  
		  mLocation = logical.Location
		  
		  // Compile the left hand operand to leave it on the VM's stack.
		  Call logical.Left.Accept(Self)
		  
		  // Since the logical operators short circuit, if the left hand operand is false then the 
		  // whole expression is false so we jump over the right operand and leave the left
		  // operand on the top of the stack.
		  Var endJump As Integer = EmitJump(ObjoScript.VM.OP_JUMP_IF_FALSE, logical.Location)
		  
		  // If the left hand operand was false then we need to pop it off the stack.
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		  // Compile the right hand operand.
		  Call logical.Right.Accept(Self)
		  
		  // Back-patch the jump instruction.
		  PatchJump(endJump)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732061206C6F676963616C2060616E64602065787072657373696F6E2E
		Private Sub LogicalOr(logical As ObjoScript.BinaryExpr)
		  /// Compiles a logical `or` expression.
		  ///
		  /// Assumes `logical` is a logical `or` expression.
		  
		  mLocation = logical.Location
		  
		  // Compile the left hand operand to leave it on the VM's stack.
		  Call logical.Left.Accept(Self)
		  
		  // Since the logical operators short circuit, if the left hand operand is true then
		  // we jump over the right hand operand.
		  Var endJump As Integer = EmitJump(ObjoScript.VM.OP_JUMP_IF_TRUE, logical.Location)
		  
		  // If the left operand was false we need to pop it off the stack.
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		  // The right hand operand only gets evaluated if the left operand was false.
		  Call logical.Right.Accept(Self)
		  
		  // Back-patch the jump instruction.
		  PatchJump(endJump)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732074686520626F6479206F662061206C6F6F7020616E6420747261636B732069747320657874656E7420736F207468617420636F6E7461696E6564202265786974222073746174656D656E74732063616E2062652068616E646C656420636F72726563746C792E
		Private Sub LoopBody(body As ObjoScript.Stmt)
		  /// Compiles the body of a loop and tracks its extent so that contained "break"
		  /// statements can be handled correctly.
		  
		  Self.CurrentLoop.BodyOffset = CurrentChunk.Length
		  
		  // Compile the optional loop body.
		  If body <> Nil Then
		    Call body.Accept(Self)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D61726B7320746865206D6F737420726563656E74206C6F63616C207661726961626C6520617320696E697469616C697365642062792073657474696E67206974732073636F70652064657074682E
		Private Sub MarkInitialised()
		  /// Marks the most recent local variable as initialised by setting its scope depth.
		  
		  If ScopeDepth = 0 Then Return
		  
		  If Locals.Count > 0 Then
		    Locals(Locals.LastIndex).Depth = ScopeDepth
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732072657472696576696E672061207661726961626C65206E616D656420606E616D65602E
		Private Sub NamedVariable(name As String)
		  /// Compiles retrieving a variable named `name`.
		  
		  Var arg As Integer = ResolveLocal(name)
		  If arg <> -1 Then
		    // Retrieve a local variable.
		    EmitBytes(ObjoScript.VM.OP_GET_LOCAL, arg)
		  Else
		    // Retrieve a global variable.
		    // Add the name of the variable to the constant pool and get its index.
		    Var index As Integer = AddConstant(name)
		    // Push the variable on to the stack.
		    EmitGetGlobal(index)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206E756D626572206F66206279746573207573656420666F72206F706572616E647320666F7220606F70636F6465602E
		Private Function OperandByteCountForOpcode(opcode As Integer) As Integer
		  /// Returns the number of bytes used for operands for `opcode`.
		  
		  If ObjoScript.VM.OpcodeOperandMap.HasKey(opcode) Then
		    Return ObjoScript.VM.OpcodeOperandMap.Value(opcode)
		  Else
		    Error("Unrecognised opcode: " + opcode.ToString)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616E792070617273657220657863657074696F6E732074686174206F6363757272656420647572696E67207468652070617273696E672070686173652E204D617920626520656D7074792E
		Function ParserErrors() As ObjoScript.ParserException()
		  /// Returns an array of any parser exceptions that occurred during the parsing phase. May be empty.
		  
		  Return Parser.Errors
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B657320746865206F666673657420696E207468652063757272656E74206368756E6B206F6620746865207374617274206F662061206A756D7020706C616365686F6C64657220616E64207265706C616365732074686520706C616365686F6C6465722077697468207468652074686520616D6F756E74206E656564656420746F20616464656420746F2074686520564D277320495020746F20636175736520697420746F206A756D7020746F207468652063757272656E7420706F736974696F6E20696E20746865206368756E6B2E
		Private Sub PatchJump(offset As Integer)
		  /// Takes the offset in the current chunk of the start of a jump placeholder and 
		  /// replaces the placeholder with the the amount needed to added to the VM's IP to 
		  /// cause it to jump to the current position in the chunk.
		  
		  // Compute the distance to jump to get from the end of the placeholder operand to 
		  // the current offset in the chunk.
		  // -2 to adjust for the bytecode for the jump offset itself.
		  Var jumpDistance As Integer = CurrentChunk.Length - offset - 2
		  
		  // The maximum amount of code that can be jumped over is UInt16 max.
		  If jumpDistance > 65535 Then
		    Error("Maximum jump distance exceeded.")
		  End If
		  
		  // Replace the 16-bit placeholder with the jump distance.
		  Var msb As UInt8 = Floor(jumpDistance / 256)
		  CurrentChunk.Code(offset) = msb
		  CurrentChunk.Code(offset + 1) = jumpDistance - (msb * 256)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C6573206120222B2B22206F7220222D2D2220706F73746669782065787072657373696F6E2E20417373756D657320606578707260206973206120222B2B22206F7220222D2D222065787072657373696F6E2E
		Private Sub PostFixIncrementDecrement(postfix As ObjoScript.PostfixExpr)
		  /// Compiles a "++" or "--" postfix expression.
		  /// Assumes `postfix` is a "++" or "--" expression.
		  
		  // The "++" and "--" operators require a variable name as their left hand operand.
		  If postfix.Operand IsA ObjoScript.VariableExpr = False Then
		    Error("The postfix `" + postfix.Operator.ToString + "` operator expects a variable name as its operand.")
		  End If
		  
		  // Compile the operand.
		  Call postfix.Operand.Accept(Self)
		  
		  Select Case postfix.Operator
		  Case ObjoScript.TokenTypes.PlusPlus
		    // Increment the value on the top of the stack by 1.
		    EmitByte(ObjoScript.VM.OP_LOAD_1)
		    EmitByte(ObjoScript.VM.OP_ADD)
		    
		  Case ObjoScript.TokenTypes.MinusMinus
		    // Decrement the value on the top of the stack by 1.
		    EmitByte(ObjoScript.VM.OP_LOAD_1)
		    EmitByte(ObjoScript.VM.OP_SUBTRACT)
		  End Select
		  
		  // Do the assignment.
		  Assignment(ObjoScript.VariableExpr(postfix.Operand).Name)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520636F6D70696C657220736F206974277320726561647920746F20636F6D70696C6520616761696E2E
		Sub Reset()
		  /// Resets the compiler so it's ready to compile again.
		  
		  Lexer = New ObjoScript.Lexer
		  mTokens.ResizeTo(-1)
		  mAST.ResizeTo(-1)
		  Parser = New ObjoScript.Parser
		  mTokeniseTime = 0
		  mParseTime = 0
		  mCompileTime = 0
		  mStopWatch = New ObjoScript.StopWatch(False)
		  ScopeDepth = 0
		  
		  Locals.RemoveAll
		  // Claim slot 0 in the stack for the VM's internal use.
		  // For methods and constructors it will be `this`.
		  Var name As String = ""
		  Select Case Type
		  Case ObjoScript.FunctionTypes.Method, ObjoScript.FunctionTypes.Constructor
		    name = "this"
		  End Select
		  Var synthetic As New ObjoScript.Token(ObjoScript.TokenTypes.Identifier, 0, 1, name, -1)
		  Locals.Add(New ObjoScript.LocalVariable(synthetic, 0))
		  
		  CurrentLoop = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520737461636B20696E646578206F6620746865206C6F63616C207661726961626C65206E616D656420606E616D6560206F7220602D3160206966207468657265206973206E6F206D61746368696E67206C6F63616C207661726961626C6520776974682074686174206E616D652E
		Private Function ResolveLocal(name As String) As Integer
		  /// Returns the stack index of the local variable named `name` or `-1` if there is 
		  /// no matching local variable with that name.
		  ///
		  /// This works because when we declare a local variable we append it to Locals.
		  /// This means that the first declared variable is at index 0, the next one index 1 and so on.
		  /// Therefore the Locals array in the compiler has the _exact_ same layout as the VM's stack
		  /// will have at runtime. This means the variable's index in Locals is the same as its 
		  /// stack slot.
		  
		  // Walk the list of local variables that are currently in scope.
		  // If one is named `name` then we've found it.
		  // We walk backwards so we find the _last_ declared variable named `name`
		  // which ensures that inner local variables correctly shadow locals with the
		  // same name in surrounding scopes.
		  Var local As ObjoScript.LocalVariable
		  For i As Integer = Locals.LastIndex DownTo 0
		    local = Locals(i)
		    If name = local.Name Then
		      // Ensure that this local variable has been initialised.
		      If local.Depth = -1 Then
		        Error("You can't read a local variable in its own initialiser.")
		      End If
		      Return i
		    End If
		  Next i
		  
		  // There is no local variable with this name. It should therefore be assumed to be global.
		  Return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D61726B732074686520626567696E6E696E67206F662061206C6F6F702E204B6565707320747261636B206F66207468652063757272656E7420696E737472756374696F6E20736F207765206B6E6F77207768617420746F206C6F6F70206261636B20746F2061742074686520656E64206F662074686520626F64792E
		Private Sub StartLoop(location As ObjoScript.Token = Nil)
		  /// Marks the beginning of a loop. Keeps track of the current instruction so we
		  /// know what to loop back to at the end of the body.
		  
		  location = If(location = Nil, mLocation, location)
		  
		  Var newLoop As New ObjoScript.LoopData
		  newLoop.Enclosing = Self.CurrentLoop
		  newLoop.Start = CurrentChunk.Length
		  newLoop.ScopeDepth = ScopeDepth
		  newLoop.StartToken = location
		  
		  Self.CurrentLoop = newLoop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520746F6B656E73207468697320636F6D70696C657220697320636F6D70696C696E672E204D617920626520656D7074792069662074686520636F6D70696C65722077617320696E737472756374656420746F20636F6D70696C6520616E20415354206469726563746C792E2053686F756C6420626520636F6E7369646572656420726561642D6F6E6C792E
		Function Tokens() As ObjoScript.Token()
		  /// The tokens this compiler is compiling. May be empty if the compiler was instructed to compile an AST directly.
		  /// Should be considered read-only.
		  
		  Return mTokens
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E2060617373657274602073746174656D656E742E
		Function VisitAssertStmt(stmt As ObjoScript.AssertStmt) As Variant
		  /// Compiles an `assert` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  Var assertLocation As ObjoScript.Token = stmt.Location
		  
		  // Compile the expression.
		  Call stmt.Expression.Accept(Self)
		  
		  EmitByte(ObjoScript.VM.OP_ASSERT, assertLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C652061207661726961626C652061737369676E6D656E742E
		Function VisitAssignment(expr As ObjoScript.AssignmentExpr) As Variant
		  /// Compile a variable assignment.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Evaluate the value to assign.
		  Call expr.Value.Accept(Self)
		  
		  // Assign the value at the top of the stack to this variable.
		  Assignment(expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612062696E6172792065787072657373696F6E2E
		Function VisitBinary(expr As ObjoScript.BinaryExpr) As Variant
		  /// Compiles a binary expression.
		  ///
		  ///
		  /// a OP b becomes: OP  
		  ///                 b   ← top of the stack
		  ///                 a
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = expr.Location
		  
		  // Compile the left and right operands - this will leave them on the stack.
		  Call expr.Left.Accept(Self)  // a
		  Call expr.Right.Accept(Self) // b
		  
		  // Emit the correct opcode for the binary operator.
		  Select Case expr.Operator
		  Case ObjoScript.TokenTypes.Plus
		    EmitByte(ObjoScript.VM.OP_ADD)
		    
		  Case ObjoScript.TokenTypes.Minus
		    EmitByte(ObjoScript.VM.OP_SUBTRACT)
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    EmitByte(ObjoScript.VM.OP_DIVIDE)
		    
		  Case ObjoScript.TokenTypes.Star
		    EmitByte(ObjoScript.VM.OP_MULTIPLY)
		    
		  Case ObjoScript.TokenTypes.Percent
		    EmitByte(ObjoScript.VM.OP_MODULO)
		    
		  Case ObjoScript.TokenTypes.Less
		    EmitByte(ObjoScript.VM.OP_LESS)
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    EmitByte(ObjoScript.VM.OP_LESS_EQUAL)
		    
		  Case ObjoScript.TokenTypes.Greater
		    EmitByte(ObjoScript.VM.OP_GREATER)
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    EmitByte(ObjoScript.VM.OP_GREATER_EQUAL)
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    EmitByte(ObjoScript.VM.OP_EQUAL)
		    
		  Case ObjoScript.TokenTypes.NotEqual
		    EmitByte(ObjoScript.VM.OP_NOT_EQUAL)
		    
		  Case ObjoScript.TokenTypes.LessLess
		    EmitByte(ObjoScript.VM.OP_SHIFT_LEFT)
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    EmitByte(ObjoScript.VM.OP_SHIFT_RIGHT)
		    
		  Case ObjoScript.TokenTypes.Ampersand
		    EmitByte(ObjoScript.VM.OP_BITWISE_AND)
		    
		  Case ObjoScript.TokenTypes.And_
		    LogicalAnd(expr)
		    
		  Case ObjoScript.TokenTypes.Caret
		    EmitByte(ObjoScript.VM.OP_BITWISE_XOR)
		    
		  Case ObjoScript.TokenTypes.DotDot
		    EmitByte(ObjoScript.VM.OP_INCLUSIVE_RANGE)
		    
		  Case ObjoScript.TokenTypes.DotDotDot
		    EmitByte(ObjoScript.VM.OP_EXCLUSIVE_RANGE)
		    
		  Case ObjoScript.TokenTypes.Is_
		    #Pragma Warning "TODO: Implement IS operator"
		    Error("The `is` operator has not yet been implemented.")
		    
		  Case ObjoScript.TokenTypes.Or_
		    LogicalOr(expr)
		    
		  Case ObjoScript.TokenTypes.Pipe
		    EmitByte(ObjoScript.VM.OP_BITWISE_OR)
		    
		  Case ObjoScript.TokenTypes.Xor_
		    EmitByte(ObjoScript.VM.OP_LOGICAL_XOR)
		    
		  Else
		    Error("Unknown binary operator """ + expr.Operator.ToString + """")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBlock(block As ObjoScript.BlockStmt) As Variant
		  /// Compile a block of statements.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  BeginScope
		  
		  For Each s As ObjoScript.Stmt In block.Statements
		    Call s.Accept(Self)
		  Next s
		  
		  EndScope
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456D697473206120626F6F6C65616E20636F6E7374616E742E
		Function VisitBoolean(expr As ObjoScript.BooleanLiteral) As Variant
		  /// Emits a boolean constant.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = expr.Location
		  
		  If expr.Value = True Then
		    EmitByte(ObjoScript.VM.OP_TRUE)
		  Else
		    EmitByte(ObjoScript.VM.OP_FALSE)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitCall(expr As ObjoScript.CallExpr) As Variant
		  /// Compiles a call expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Track where we are.
		  mLocation = expr.Location
		  
		  // Compile the callee.
		  Call expr.Callee.Accept(Self)
		  
		  // Check the argument count is within the limit.
		  If expr.Arguments.Count > 255 Then
		    Error("A call cannot have more than 255 arguments.")
		  End If
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In expr.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the call instruction with the number of arguments as its operand.
		  EmitBytes(ObjoScript.VM.OP_CALL, expr.Arguments.Count)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120636C617373206465636C61726174696F6E2E
		Function VisitClassDeclaration(c As ObjoScript.ClassDeclStmt) As Variant
		  /// Compile a class declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = c.Location
		  
		  If Self.Type <> ObjoScript.FunctionTypes.TopLevel Then
		    Error("Classes can only be declared within the top level of a script.")
		  End If
		  
		  If c.HasSuperclass And c.Name.Compare(c.Superclass, ComparisonOptions.CaseSensitive) = 0 Then
		    Error("A class cannot inherit from itself.")
		  End If
		  
		  DeclareVariable(c.Identifier)
		  
		  // Add the name of the class to the function's constants pool.
		  Var index As Integer = AddConstant(c.Name)
		  
		  // Emit the "declare class" opcode (which one depends on the index in the constant pool).
		  // This will push the class on to the top of the stack.
		  If index <= 255 Then
		    EmitBytes(ObjoScript.VM.OP_CLASS, index, c.Location)
		  Else
		    EmitByte(ObjoScript.VM.OP_CLASS_LONG, c.Location)
		    EmitUInt16(index, c.Location)
		  End If
		  
		  // Define the class as a global variable.
		  DefineVariable(index)
		  
		  // Push the class back on to the stack so the methods can find it.
		  EmitGetGlobal(index)
		  
		  If c.HasSuperclass Then
		    // Look up the superclass and push it on to the stack.
		    NamedVariable(c.Superclass)
		    // Tell the VM that this class inherits from the class on the stack.
		    // The VM will pop the superclass off the stack when its done handling the inheritance.
		    EmitByte(ObjoScript.VM.OP_INHERIT, c.Location)
		  End If
		  
		  // Compile any foreign method declarations.
		  For Each fmd As ObjoScript.ForeignMethodDeclStmt In c.ForeignMethods
		    Call fmd.Accept(Self)
		  Next fmd
		  
		  // Compile any constructors.
		  For Each constructor As ObjoScript.ConstructorDeclStmt In c.Constructors
		    Call constructor.Accept(Self)
		  Next constructor
		  
		  // Compile any static methods.
		  For Each sm As ObjoScript.MethodDeclStmt In c.StaticMethods
		    Call sm.Accept(Self)
		  Next sm
		  
		  // Compile any instance methods.
		  For Each m As ObjoScript.MethodDeclStmt In c.Methods
		    Call m.Accept(Self)
		  Next m
		  
		  // Pop the class off the stack.
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120636C61737320636F6E7374727563746F722E
		Function VisitConstructorDeclaration(c As ObjoScript.ConstructorDeclStmt) As Variant
		  /// Compiles a class constructor.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  /// To define a new constructor, the VM needs three things:
		  ///  1. The constructor's signature.
		  ///  2. The function that is the constructor's body.
		  ///  3. The class to bind the constructor to.
		  
		  mLocation = c.Location
		  
		  // Add the constructor's signature to the function's constants pool.
		  Var index As Integer = AddConstant(c.Signature)
		  
		  // Compile the body.
		  Var compiler As New ObjoScript.Compiler
		  Var body As ObjoScript.Func = compiler.Compile(c.Signature, c.Parameters, c.Body, ObjoScript.FunctionTypes.Constructor)
		  
		  // Store the compiled constructor body as a constant in this function's constant pool
		  // and push it on to the stack.
		  Call EmitConstant(body)
		  
		  // Emit the "declare constructor" opcode, the operand is the index of the constructor's signature in the constants pool.
		  EmitByte(VM.OP_CONSTRUCTOR, c.Location)
		  EmitUInt16(index, c.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612060636F6E74696E7565602073746174656D656E742E
		Function VisitContinueStmt(stmt As ObjoScript.ContinueStmt) As Variant
		  /// Compiles a `continue` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  
		  If CurrentLoop = Nil Then
		    Error("Cannot use `continue` outside of a loop.")
		  End If
		  
		  // Since we will be jumping out of the scope, make sure any locals in it
		  // are discarded first.
		  Call DiscardLocals(CurrentLoop.ScopeDepth + 1)
		  
		  // Emit a jump back to the top of the current loop.
		  EmitLoop(CurrentLoop.Start)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120646F742065787072657373696F6E20286D6574686F6420696E766F636174696F6E292E
		Function VisitDot(dot As ObjoScript.DotExpr) As Variant
		  /// Compile a dot expression (method invocation).
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = dot.Location
		  
		  // Compile the operand to put it on the stack.
		  Call dot.Operand.Accept(Self)
		  
		  // Load the signature into the constant pool.
		  Var index As Integer = AddConstant(dot.Signature)
		  
		  If dot.IsSetter Then
		    // Compile the value to assign.
		    Call dot.ValueToAssign.Accept(Self)
		    EmitIndexedOpcode(ObjoScript.VM.OP_SETTER, ObjoScript.VM.OP_SETTER_LONG, index)
		  Else
		    EmitIndexedOpcode(ObjoScript.VM.OP_GETTER, ObjoScript.VM.OP_GETTER_LONG, index)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6520616E206065786974602073746174656D656E742E
		Function VisitExitStmt(stmt As ObjoScript.ExitStmt) As Variant
		  /// Compile an `exit` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  
		  If CurrentLoop = Nil Then
		    Error("Cannot use the `exit` keyword outside of a loop.")
		  End If
		  
		  // Since we will be jumping out of the scope, make sure any locals in it are
		  // discarded first.
		  Call DiscardLocals(CurrentLoop.ScopeDepth + 1)
		  
		  // Emit a placeholder instruction for the jump to the end of the body. When
		  // we're done compiling the loop body and know where the end is, we'll
		  // replace these with a jump instruction with the appropriate offset.
		  // We use `OP_EXIT` as the placeholder.
		  Call EmitJump(ObjoScript.VM.OP_EXIT)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E2065787072657373696F6E2073746174656D656E742E
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  /// Compiles an expression statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  
		  // Compile the expression.
		  Call stmt.Expression.Accept(Self)
		  
		  // An expression statement evaluates the expression and *discards the result*.
		  EmitByte(ObjoScript.VM.OP_POP)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C652072657472696576696E672061206669656C642E
		Function VisitField(expr As ObjoScript.FieldExpr) As Variant
		  /// Compile retrieving a field.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("Fields can only be accessed from within a method or constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(expr.Name)
		  
		  // Push the field on to the stack.
		  EmitIndexedOpcode(ObjoScript.VM.OP_GET_FIELD, ObjoScript.VM.OP_GET_FIELD_LONG, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C652061206669656C642061737369676E6D656E742E
		Function VisitFieldAssignment(expr As ObjoScript.FieldAssignmentExpr) As Variant
		  /// Compile a field assignment.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Evaluate the value to assign, leaving it on the top of the stack.
		  Call expr.Value.Accept(Self)
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("Fields can only be accessed from within a method or constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(expr.Name)
		  
		  // Emit the set field instruction.
		  EmitIndexedOpcode(ObjoScript.VM.OP_SET_FIELD, ObjoScript.VM.OP_SET_FIELD_LONG, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120666F726569676E206D6574686F64206465636C61726174696F6E2E
		Function VisitForeignMethodDeclaration(fmd As ObjoScript.ForeignMethodDeclStmt) As Variant
		  /// Compiles a foreign method declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  /// To define a new foreign method, the VM needs three things:
		  ///  1. The name of the method.
		  ///  2. The arity of the method.
		  /// At runtime, the class to bind to should be on the top of the stack.
		  
		  mLocation = fmd.Location
		  
		  // Add the signature of the method to the function's constants pool.
		  Var index As Integer = AddConstant(fmd.Signature)
		  
		  // Emit the "declare foreign method" opcode.
		  // The operands are the index of the method's signature in the constants pool, 
		  // the number of arguments the method expects, 
		  // and if it's an instance (0) or static (1) method.
		  EmitIndexedOpcode(ObjoScript.VM.OP_FOREIGN_METHOD, ObjoScript.VM.OP_FOREIGN_METHOD_LONG, index)
		  EmitByte(fmd.Arity)
		  EmitByte(If(fmd.IsStatic, 1, 0))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6520612060666F7260206C6F6F702E
		Function VisitForStmt(stmt As ObjoScript.ForStmt) As Variant
		  /// Compile a `for` loop.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  BeginScope
		  
		  // Track the current location.
		  mLocation = stmt.Location
		  
		  // Compile the optional initialiser.
		  If stmt.Initialiser <> Nil Then
		    Call stmt.Initialiser.Accept(Self)
		  End If
		  
		  StartLoop
		  
		  // Compile the optional condition.
		  If stmt.Condition <> Nil Then
		    Call stmt.Condition.Accept(Self)
		  Else
		    // No condition provided. Set it to true (infinite loop).
		    EmitByte(ObjoScript.VM.OP_TRUE)
		  End If
		  
		  // Emit code to exit the loop if the condition is falsey.
		  ExitLoopIfFalse
		  
		  // Compile the loop's body.
		  LoopBody(stmt.Body)
		  
		  // Compile the optional increment expression. This is essentially inserted after the 
		  // body of the loop.
		  If stmt.Increment <> Nil Then
		    Call stmt.Increment.Accept(Self)
		    // Pop the increment expression result off the stack.
		    EmitByte(ObjoScript.VM.OP_POP, stmt.Increment.Location)
		  End If
		  
		  EndLoop
		  
		  EndScope
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612066756E6374696F6E206465636C61726174696F6E2E
		Function VisitFuncDeclaration(funcDecl As ObjoScript.FuncDeclStmt) As Variant
		  /// Compiles a function declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = funcDecl.Location
		  
		  // Since we don't support closures, we only allow functions to be declared
		  // at the top level of a script (i.e. not within other functions, methods, class declarations, etc).
		  If Self.Type <> ObjoScript.FunctionTypes.TopLevel Then
		    Error("Functions can only be declared within the top level of a script.")
		  End If
		  
		  DeclareVariable(funcDecl.Name, True)
		  
		  // Compile the function body.
		  Var compiler As New ObjoScript.Compiler
		  Var f As ObjoScript.Func = compiler.Compile(funcDecl.Name.Lexeme, funcDecl.Parameters, funcDecl.Body, ObjoScript.FunctionTypes.Func)
		  
		  // Store the compiled function as a constant in this function's constant pool.
		  Call EmitConstant(f)
		  
		  Var index As Integer
		  If ScopeDepth = 0 Then
		    // Global function. Add the name of the function to the function's constants pool.
		    index = AddConstant(funcDecl.Name.Lexeme)
		  End If
		  
		  DefineVariable(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E20606966602073746174656D656E742E
		Function VisitIfStmt(ifstmt As ObjoScript.IfStmt) As Variant
		  /// Compiles an `if` statement.
		  
		  // Compile the condition - this will leave the result on the top of the stack at runtime.
		  Call ifstmt.Condition.Accept(Self)
		  
		  // Emit the "jump if false" instruction. We'll patch this with the proper offset to jump
		  // if condition = false _after_ we've compiled the "then branch".
		  Var thenJump As Integer = EmitJump(ObjoScript.VM.OP_JUMP_IF_FALSE, ifstmt.Location)
		  
		  // When the condition is truthy we pop the value off the top of the stack before the 
		  // code inside the "then branch".
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		  // Compile the "then branch" statement(s).
		  Call ifstmt.ThenBranch.Accept(Self)
		  
		  // Emit the "unconditional jump" instruction. We'll patch this with the proper offset to jump
		  // if condition = true _after_ we've compiled the "else branch".
		  Var elseJump As Integer = EmitJump(ObjoScript.VM.OP_JUMP, ifstmt.Location)
		  
		  PatchJump(thenJump)
		  
		  // When the condition is falsey we pop the value off the top of the stack before the 
		  // code inside the "else branch".
		  EmitByte(ObjoScript.VM.OP_POP)
		  
		  // Compile the optional "else" branch statements.
		  If ifstmt.ElseBranch <> Nil Then
		    Call ifstmt.ElseBranch.Accept(Self)
		  End If
		  
		  PatchJump(elseJump)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120636C617373206D6574686F64206465636C61726174696F6E2E
		Function VisitMethodDeclaration(m As ObjoScript.MethodDeclStmt) As Variant
		  /// Compiles a class method declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  /// To define a new method, the VM needs three things:
		  ///  1. The name of the method.
		  ///  2. The function that is the method body.
		  ///  3. The class to bind the method to.
		  
		  mLocation = m.Location
		  
		  // Add the signature of the method to the function's constants pool.
		  Var index As Integer = AddConstant(m.Signature)
		  
		  // Compile the body.
		  Var compiler As New ObjoScript.Compiler
		  Var body As ObjoScript.Func = compiler.Compile(m.Name, m.Parameters, m.Body, ObjoScript.FunctionTypes.Method)
		  body.IsSetter = m.IsSetter
		  
		  // Store the compiled method body as a constant in this function's constant pool
		  // and push it on to the stack.
		  Call EmitConstant(body)
		  
		  // Emit the "declare method" or "declare static method" opcode.
		  // The operand is the index of the method's signature in the constants pool.
		  If m.IsStatic Then
		    EmitIndexedOpcode(ObjoScript.VM.OP_STATIC_METHOD, ObjoScript.VM.OP_STATIC_METHOD_LONG, index)
		  Else
		    EmitByte(VM.OP_METHOD, m.Location)
		    EmitUInt16(index)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120676574746572206D6574686F6420696E766F636174696F6E2E
		Function VisitMethodInvocation(m As ObjoScript.MethodInvocationExpr) As Variant
		  /// Compiles a getter method invocation.
		  ///
		  /// E.g: operand.method(arg1, arg2)
		  /// The OP_INVOKE instruction is a fusion of OP_GETTER and OP_CALL.
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = m.Location
		  
		  // Compile the operand to put it on the stack.
		  Call m.Operand.Accept(Self)
		  
		  // Load the method's signature into the constant pool.
		  Var index As Integer = AddConstant(m.Signature)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In m.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the OP_INVOKE instruction and the index of the method's signature in the constant pool
		  EmitIndexedOpcode(ObjoScript.VM.OP_INVOKE, ObjoScript.VM.OP_INVOKE_LONG, index, m.Location)
		  
		  // Emit the argument count.
		  EmitByte(m.Arguments.Count, m.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456D69747320224E6F7468696E67222E
		Function VisitNothing(expr As ObjoScript.NothingLiteral) As Variant
		  /// Emits "Nothing".
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = expr.Location
		  
		  EmitByte(ObjoScript.VM.OP_NOTHING)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456D6974732061206E756D626572206C69746572616C2E
		Function VisitNumber(expr As ObjoScript.NumberLiteral) As Variant
		  /// Emits a number literal.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = expr.Location
		  
		  Call EmitConstant(expr.Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120706F73742D6669782065787072657373696F6E2E
		Function VisitPostfix(expr As ObjoScript.PostfixExpr) As Variant
		  /// Compile a post-fix expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Store the current location.
		  mLocation = expr.Location
		  
		  If expr.Operator = ObjoScript.TokenTypes.PlusPlus Or expr.Operator = ObjoScript.TokenTypes.MinusMinus Then
		    PostFixIncrementDecrement(expr)
		  Else
		    Error("Unknown postfix operator `" + expr.Operator.ToString + "`.")
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732061207072696E742073746174656D656E742E
		Function VisitPrintStmt(stmt As ObjoScript.PrintStmt) As Variant
		  /// Compiles a print statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  Var printLocation As ObjoScript.Token = stmt.Location
		  
		  // Compile the expression.
		  Call stmt.Expression.Accept(Self)
		  
		  EmitByte(ObjoScript.VM.OP_PRINT, printLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612072657475726E2073746174656D656E742E
		Function VisitReturn(r As ObjoScript.ReturnStmt) As Variant
		  /// Compiles a return statement.
		  
		  If Self.Type = ObjoScript.FunctionTypes.TopLevel Then
		    Error("Cannot use the `return` keyword in top-level code.")
		  End If
		  
		  mLocation = r.Location
		  
		  // Handle the return value. If none was specified then the parser will synthesis a NothingLiteral.
		  If Self.Type = ObjoScript.FunctionTypes.Constructor Then
		    // Constructors must always return `this` which will be at slot 0 in the call frame.
		    If r.Value IsA ObjoScript.NothingLiteral Then
		      EmitBytes(ObjoScript.VM.OP_GET_LOCAL, 0)
		    Else
		      Error("Can't return a value from a constructor.")
		    End If
		  Else
		    // Compile the return value.
		    Call r.Value.Accept(Self)
		  End If
		  
		  EmitByte(ObjoScript.VM.OP_RETURN, r.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C652072657472696576696E67206120737461746963206669656C642E
		Function VisitStaticField(expr As ObjoScript.StaticFieldExpr) As Variant
		  /// Compile retrieving a static field.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("Static fields can only be accessed from within a method or a constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(expr.Name)
		  
		  // Push the field on to the stack.
		  EmitIndexedOpcode(ObjoScript.VM.OP_GET_STATIC_FIELD, ObjoScript.VM.OP_GET_STATIC_FIELD_LONG, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120737461746963206669656C642061737369676E6D656E742E
		Function VisitStaticFieldAssignment(expr As ObjoScript.StaticFieldAssignmentExpr) As Variant
		  /// Compile a static field assignment.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Evaluate the value to assign, leaving it on the top of the stack.
		  Call expr.Value.Accept(Self)
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("Static fields can only be accessed from within a method or constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(expr.Name)
		  
		  // Emit the set static field instruction.
		  EmitIndexedOpcode(ObjoScript.VM.OP_SET_STATIC_FIELD, ObjoScript.VM.OP_SET_STATIC_FIELD_LONG, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 456D697473206120737472696E6720636F6E7374616E742E
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  /// Emits a string constant.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  mLocation = expr.Location
		  
		  Call EmitConstant(expr.Value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120607375706572602065787072657373696F6E2E
		Function VisitSuper(s As ObjoScript.SuperExpr) As Variant
		  /// Compiles a `super` expression.
		  ///
		  /// The runtime needs three things to execute a `super` expression.
		  ///  1. The instance.
		  ///  2. The superclass.
		  ///  3. The name of the method to invoke.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = s.Location
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("`super` can only be used within a method or constructor.")
		  End If
		  
		  // Push `this` onto the stack. It's always at slot 0 of the call frame.
		  EmitBytes(ObjoScript.VM.OP_GET_LOCAL, 0)
		  
		  // Load the method's name into the constant pool.
		  Var index As Integer = AddConstant(s.Identifier.Lexeme)
		  
		  If s.IsSetter Then
		    // Compile the value to assign.
		    Call s.ValueToAssign.Accept(Self)
		    // Emit the `super` setter instruction with the index in the constant pool of the method name to invoke.
		    EmitIndexedOpcode(ObjoScript.VM.OP_SUPER_SETTER, ObjoScript.VM.OP_SUPER_SETTER_LONG, index)
		  Else
		    // Emit the `super` getter instruction with the index in the constant pool of the method name to invoke.
		    EmitIndexedOpcode(ObjoScript.VM.OP_SUPER_GETTER, ObjoScript.VM.OP_SUPER_GETTER_LONG, index)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120676574746572206D6574686F6420696E766F636174696F6E206F6E20607375706572602E
		Function VisitSuperMethodInvocation(s As ObjoScript.SuperMethodInvocationExpr) As Variant
		  /// Compiles a getter method invocation on `super`.
		  ///
		  /// E.g: super.method(arg1, arg2)
		  /// The OP_SUPER_INVOKE instruction is a fusion of OP_SUPER_GETTER and OP_CALL.
		  /// This is an optimisation for the runtime.
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = s.Location
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("`super` can only be used within a method or constructor.")
		  End If
		  
		  // Push `this` onto the stack. It's always at slot 0 of the call frame.
		  EmitBytes(ObjoScript.VM.OP_GET_LOCAL, 0)
		  
		  // Load the method's name into the constant pool.
		  Var index As Integer = AddConstant(s.MethodName)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In s.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the OP_SUPER_INVOKE instruction and the index of the method's name in the constant pool
		  EmitIndexedOpcode(ObjoScript.VM.OP_SUPER_INVOKE, ObjoScript.VM.OP_SUPER_INVOKE_LONG, index, s.Location)
		  
		  // Emit the argument count.
		  EmitByte(s.Arguments.Count, s.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732061206074686973602065787072657373696F6E2E
		Function VisitThis(this As ObjoScript.ThisExpr) As Variant
		  /// Compiles a `this` expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = this.Location
		  
		  If Self.Type <> ObjoScript.FunctionTypes.Method And Self.Type <> ObjoScript.FunctionTypes.Constructor Then
		    Error("`this` can only be used within a method or constructor.")
		  End If
		  
		  // `this` is always at slot 0 of the call frame.
		  EmitBytes(ObjoScript.VM.OP_GET_LOCAL, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120756E6172792065787072657373696F6E2E
		Function VisitUnary(expr As ObjoScript.UnaryExpr) As Variant
		  /// Compile a unary expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  mLocation = expr.Location
		  
		  // Emit the operator instruction.
		  Select Case expr.Operator
		  Case ObjoScript.TokenTypes.Minus
		    // We can compile negation of numeric literals more efficiently
		    // by letting the compiler negate the value and then emitting it as a constant.
		    If expr.Operand IsA ObjoScript.NumberLiteral Then
		      If ObjoScript.NumberLiteral(expr.Operand).Value = 1 Then
		        // -1 is a special case since it's used so often.
		        EmitByte(ObjoScript.VM.OP_LOAD_Minus1, expr.Operand.Location)
		      Else
		        Call EmitConstant(-ObjoScript.NumberLiteral(expr.Operand).Value, expr.Operand.Location)
		      End If
		    Else
		      // Compile the operand.
		      Call expr.Operand.Accept(Self)
		      // Emit the negate instruction.
		      EmitByte(ObjoScript.VM.OP_NEGATE)
		    End If
		    
		  Case ObjoScript.TokenTypes.Not_
		    // Compile the operand.
		    Call expr.Operand.Accept(Self)
		    // Emit the not instruction.
		    EmitByte(ObjoScript.VM.OP_NOT)
		    
		  Else
		    Error("Unknown unary operator: " + expr.Operator.ToString)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732061207661726961626C65206465636C61726174696F6E2E
		Function VisitVarDeclaration(stmt As ObjoScript.VarDeclStmt) As Variant
		  /// Compiles a variable declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  mLocation = stmt.Location
		  
		  // Compile the initialiser.
		  Call stmt.Initialiser.Accept(Self)
		  
		  DeclareVariable(stmt.Identifier)
		  
		  Var index As Integer = -1 // -1 is a deliberate invalid index.
		  If ScopeDepth = 0 Then
		    // Global variable declaration. Add the name of the variable to the constant pool and get its index.
		    index = AddConstant(stmt.Name)
		  End If
		  
		  DefineVariable(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732072657472696576696E672061206E616D6564207661726961626C652E
		Function VisitVariable(expr As ObjoScript.VariableExpr) As Variant
		  /// Compiles retrieving a named variable.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  NamedVariable(expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120607768696C6560206C6F6F702E
		Function VisitWhileStmt(stmt As ObjoScript.WhileStmt) As Variant
		  /// Compile a `while` loop.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  // Track our location.
		  mLocation = stmt.Location
		  
		  StartLoop
		  
		  // Compile the condition.
		  Call stmt.Condition.Accept(Self)
		  
		  ExitLoopIfFalse
		  
		  LoopBody(stmt.Body)
		  
		  EndLoop
		  
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5468652074696D652074616B656E20746F20636F6D70696C65207468652041535420286D696C6C697365636F6E6473292E
		#tag Getter
			Get
			  Return mCompileTime
			End Get
		#tag EndGetter
		CompileTime As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E7420696E6E65726D6F7374206C6F6F70206265696E6720636F6D70696C65642C206F72204E696C206966206E6F7420696E2061206C6F6F702E
		Private CurrentLoop As ObjoScript.LoopData
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066756E6374696F6E2063757272656E746C79206265696E6720636F6D70696C65642E
		Func As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D70696C65722773206C657865722E205573656420746F20746F6B656E69736520736F7572636520636F64652E
		Private Lexer As ObjoScript.Lexer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F63616C207661726961626C657320746861742061726520696E2073636F70652E
		Locals() As ObjoScript.LocalVariable
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652061627374726163742073796E7461782074726565207468697320636F6D70696C657220697320636F6D70696C696E672E
		Private mAST() As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCompileTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E2074686520636F6D70696C65722069732063757272656E746C7920636F6D70696C696E672E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mParseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 496E7465726E616C2073746F7020776174636820666F722074696D696E6720686F77206C6F6E672074686520766172696F757320737461676573206F6620636F6D70696C6174696F6E2074616B652E
		Private mStopWatch As ObjoScript.StopWatch
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokeniseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E73207468697320636F6D70696C657220697320636F6D70696C696E672E204D617920626520656D7074792069662074686520636F6D70696C65722077617320696E737472756374656420746F20636F6D70696C6520616E20415354206469726563746C792E
		Private mTokens() As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D70696C65722773207061727365722E205573656420746F20706172736520736F7572636520636F646520746F6B656E732E
		Private Parser As ObjoScript.Parser
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074696D652074616B656E20746F2070617273652074686520736F7572636520636F646520286D696C6C697365636F6E6473292E
		#tag Getter
			Get
			  Return mParseTime
			End Get
		#tag EndGetter
		ParseTime As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E742073636F70652064657074682E2030203D20676C6F62616C2073636F70652E
		Private ScopeDepth As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652074696D652074616B656E20746F20746F6B656E6973652074686520736F7572636520636F646520286D696C6C697365636F6E6473292E
		#tag Getter
			Get
			  Return mTokeniseTime
			End Get
		#tag EndGetter
		TokeniseTime As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520746F74616C2074696D652074616B656E20746F206C65782C20706172736520616E6420636F6D70696C652074686520736F7572636520636F646520286D696C6C697365636F6E6473292E
		#tag Getter
			Get
			  Return mTokeniseTime + mParseTime + mCompileTime
			End Get
		#tag EndGetter
		TotalTime As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652074797065206F662066756E6374696F6E2063757272656E746C79206265696E6720636F6D70696C65642E
		Type As ObjoScript.FunctionTypes = ObjoScript.FunctionTypes.TopLevel
	#tag EndProperty


	#tag Constant, Name = MAX_LOCALS, Type = Double, Dynamic = False, Default = \"256", Scope = Public, Description = 546865206D6178696D756D206E756D626572206F66206C6F63616C207661726961626C657320746861742063616E20626520696E2073636F7065206174206F6E652074696D652E204C696D6974656420746F206F6E6520627974652064756520746F2074686520696E737472756374696F6E2773206F706572616E642073697A652E
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TokeniseTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParseTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CompileTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TotalTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="ObjoScript.FunctionTypes.TopLevel"
			Type="ObjoScript.FunctionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - TopLevel"
				"1 - Func"
				"2 - Method"
				"3 - Constructor"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
