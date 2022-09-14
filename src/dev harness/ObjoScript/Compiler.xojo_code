#tag Class
Protected Class Compiler
Implements ObjoScript.ExprVisitor, ObjoScript.StmtVisitor
	#tag Method, Flags = &h21, Description = 41646473206076616C75656020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C20616E642072657475726E732069747320696E64657820696E2074686520706F6F6C2E
		Private Function AddConstant(value As Variant) As Integer
		  /// Adds `value` to the current chunk's constant pool and returns its index in the pool.
		  
		  Var index As Integer = CurrentChunk.AddConstant(value)
		  
		  If index > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("To many constants in the chunk.")
		  End If
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547261636B732061206C6F63616C207661726961626C6520696E207468652063757272656E742073636F70652E
		Private Sub AddLocal(identifier As ObjoScript.Token)
		  /// Tracks a local variable in the current scope.
		  
		  If locals.Count > MAX_LOCALS Then
		    Error("Too many local variables in scope.")
		  End If
		  
		  // Set the local's depth to `-1`. This indicates the local is not yet initialised.
		  Locals.Add(New ObjoScript.LocalVariable(identifier, -1))
		  
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

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E2061627374726163742073796E746178207472656520696E746F2061206368756E6B2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(abstractTree() As ObjoScript.Stmt, shouldResetFirst As Boolean = True) As ObjoScript.Chunk
		  /// Compiles an abstract syntax tree into a chunk. Raises a `CompilerException` if an error occurs.
		  ///
		  /// Resets by default but if this is being called internally (after the compiler has tokenised and parsed the source) 
		  /// then we skip resetting by setting `shouldResetFirst` to True.
		  
		  mStopWatch.Start
		  
		  If shouldResetFirst Then Reset
		  
		  mCompilingChunk = New ObjoScript.Chunk
		  mAST = abstractTree
		  
		  For Each stmt As ObjoScript.Stmt In mAST
		    Call stmt.Accept(Self)
		  Next stmt
		  
		  // Handle an empty AST.
		  Var endLocation As ObjoScript.Token
		  If mAST.Count = 0 Then
		    // Synthesise a fake end location token.
		    endLocation = New ObjoScript.Token(ObjoScript.TokenTypes.EOF, 0, 1)
		  Else
		    endLocation = mAST(mAST.LastIndex).Location
		  End If
		  
		  // Wind down the compiler.
		  EndCompiler(endLocation)
		  
		  mStopWatch.Stop
		  mCompileTime = mStopWatch.ElapsedMilliseconds
		  
		  Return CurrentChunk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320726177204F626A6F20736F7572636520636F646520696E746F2061206368756E6B2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(source As String) As ObjoScript.Chunk
		  /// Compiles raw Objo source code into a chunk. May raise a `LexerException`, `ParserException` or `CompilerException` if an error occurs.
		  
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
		  Return Compile(mAST, False)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206368756E6B207468697320636F6D70696C65722069732063757272656E746C7920636F6D70696C696E6720696E746F2E
		Function CurrentChunk() As ObjoScript.Chunk
		  /// Returns the chunk this compiler is currently compiling into.
		  
		  Return mCompilingChunk
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 466F72206C6F63616C207661726961626C65732C20746869732069732074686520706F696E742061742077686963682074686520636F6D70696C6572207265636F726473207468656972206578697374656E63652E
		Sub DeclareVariable(identifier As ObjoScript.Token)
		  /// For local variables, this is the point at which the compiler records their existence.
		  ///
		  /// `identifier` is the token representing the variable's name in the original source code.
		  
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
		  AddLocal(identifier)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061207661726961626C6520617320726561647920746F207573652E
		Private Sub DefineVariable(index As Integer)
		  /// Defines a variable as ready to use.
		  ///
		  /// For globals it outputs the instructions required to define a global variable whose name is stored in the
		  /// constant pool at `index`.
		  /// For locals, it marks the variable as ready for use by setting its `Depth` property to the current scope depth.
		  
		  // Nothing to do if this is a local variable definition.
		  If ScopeDepth > 0 Then
		    // Mark this local variable as initialised by setting its scope depth.
		    Locals(Locals.LastIndex).Depth = ScopeDepth
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

	#tag Method, Flags = &h21, Description = 41646473206076616C75656020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C206174207468652063757272656E74206C6F636174696F6E2E20416E20616C7465726E617469766520606C6F636174696F6E602063616E206265207370656369666965642E
		Private Sub EmitConstant(value As Variant, location As ObjoScript.Token = Nil)
		  /// Adds `value` to the current chunk's constant pool at the current location. An alternative `location` can be specified.
		  
		  If location = Nil Then location = mLocation
		  
		  // Common cases.
		  // The VM has dedicated instructions for producing certain numeric constants that are commonly used.
		  If value.Type = Variant.TypeDouble Then
		    Select Case value
		    Case 0
		      EmitByte(ObjoScript.VM.OP_LOAD_0, location)
		      Return
		    Case 1
		      EmitByte(ObjoScript.VM.OP_LOAD_1, location)
		      Return
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
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732074686520606A756D70496E737472756374696F6E60206F63637572696E6720617420736F7572636520606C6F636174696F6E6020616E6420777269746573206120706C616365686F6C64657220282668464646462920666F7220746865206A756D70206F66667365742E2052657475726E7320746865206F6666736574206F6620746865206A756D7020696E737472756374696F6E2E
		Private Function EmitJump(jumpInstruction As UInt8, location As ObjoScript.Token) As Integer
		  /// Emits the `jumpInstruction` occuring at source `location` and writes a placeholder (&hFFFF) for the jump offset.
		  /// Returns the offset of the jump instruction.
		  ///
		  /// We can jump a maximum of &hFFFF (65,535) bytes.
		  
		  EmitByte(jumpInstruction, location)
		  
		  EmitByte(&hff, location)
		  EmitByte(&hff, location)
		  
		  Return CurrentChunk.Length - 2
		  
		End Function
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
		  
		  // For now we will emit an OP_RETURN.
		  EmitByte(ObjoScript.VM.OP_RETURN, location)
		  
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
		  
		  Var arg As Integer = ResolveLocal(expr.Name)
		  
		  If arg <> -1 Then
		    // Set a local variable.
		    EmitBytes(ObjoScript.VM.OP_SET_LOCAL, arg)
		  Else
		    // Set a global variable.
		    // Add the name of the variable to the constant pool and get its index.
		    Var index As Integer = AddConstant(expr.Name)
		    If index <= 255 Then
		      // We only need a single byte operand to specify the index of the assignee's name in the constant pool.
		      EmitBytes(ObjoScript.VM.OP_SET_GLOBAL, index)
		    Else
		      // We need two bytes for the operand.
		      EmitByte(ObjoScript.VM.OP_SET_GLOBAL_LONG)
		      EmitUInt16(index)
		    End If
		  End If
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
		    #Pragma Warning "TODO: Implement DOTDOT operator"
		    Error("The `..` operator has not yet been implemented.")
		    
		  Case ObjoScript.TokenTypes.DotDotDot
		    #Pragma Warning "TODO: Implement DOTDOTDOT operator"
		    Error("The `...` operator has not yet been implemented.")
		    
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
		  
		  EmitConstant(expr.Value)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitPostfix(expr As ObjoScript.PostfixExpr) As Variant
		  // Part of the ObjoScript.ExprVisitor interface.
		  #Pragma Warning  "Don't forget to implement this method!"
		  
		  mLocation = expr.Location
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

	#tag Method, Flags = &h0, Description = 456D697473206120737472696E6720636F6E7374616E742E
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  /// Emits a string constant.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  mLocation = expr.Location
		  
		  EmitConstant(expr.Value)
		  
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
		        EmitConstant(-ObjoScript.NumberLiteral(expr.Operand).Value, expr.Operand.Location)
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

	#tag Method, Flags = &h0, Description = 436F6D70696C652072657472696576696E672061206E616D6564207661726961626C652E
		Function VisitVariable(expr As ObjoScript.VariableExpr) As Variant
		  /// Compile retrieving a named variable.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  #Pragma Warning "TODO: Find a way to track the name of locals in the VM for runtime debugging"
		  
		  Var arg As Integer = ResolveLocal(expr.Name)
		  
		  If arg <> -1 Then
		    // Retrieve a local variable.
		    EmitBytes(ObjoScript.VM.OP_GET_LOCAL, arg)
		  Else
		    // Retrieve a global variable.
		    // Add the name of the variable to the constant pool and get its index.
		    Var index As Integer = AddConstant(expr.Name)
		    If index <= 255 Then
		      // We only need a single byte operand to specify the index of the variable's name in the constant pool.
		      EmitBytes(ObjoScript.VM.OP_GET_GLOBAL, index)
		    Else
		      // We need two bytes for the operand.
		      EmitByte(ObjoScript.VM.OP_GET_GLOBAL_LONG)
		      EmitUInt16(index)
		    End If
		  End If
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

	#tag Property, Flags = &h21, Description = 546865206368756E6B2077652772652063757272656E746C7920636F6D70696C696E6720746F2E
		Private mCompilingChunk As ObjoScript.Chunk
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
	#tag EndViewBehavior
End Class
#tag EndClass