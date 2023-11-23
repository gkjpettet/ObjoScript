#tag Class
Protected Class Compiler
Implements ObjoScript.ExprVisitor,ObjoScript.StmtVisitor
	#tag Method, Flags = &h21, Description = 41646473206120446F75626C652076616C75652060646020746F207468652063757272656E742066756E6374696F6E277320636F6E7374616E7420706F6F6C20616E642072657475726E732069747320696E64657820696E2074686520706F6F6C2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620746865206D6178696D756D206E756D626572206F6620636F6E7374616E747320686173206265656E20726561636865642E
		Private Function AddConstant(d As Double) As Integer
		  /// Adds a Double value `d` to the current function's constant pool and returns its index in the pool.
		  /// Raises a `CompilerException` if the maximum number of constants has been reached.
		  
		  Var index As Integer = CurrentChunk.AddConstant(d)
		  
		  If index > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("To many constants in the chunk.")
		  End If
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473206076616C75656020746F207468652063757272656E742066756E6374696F6E277320636F6E7374616E7420706F6F6C20616E642072657475726E732069747320696E64657820696E2074686520706F6F6C2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620746865206D6178696D756D206E756D626572206F6620636F6E7374616E747320686173206265656E20726561636865642E
		Private Function AddConstant(value As ObjoScript.Value) As Integer
		  /// Adds `value` to the current function's constant pool and returns its index in the pool.
		  /// Raises a `CompilerException` if the maximum number of constants has been reached.
		  
		  Var index As Integer = CurrentChunk.AddConstant(value)
		  
		  If index > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("To many constants in the chunk.")
		  End If
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473206120537472696E672076616C75652060736020746F207468652063757272656E742066756E6374696F6E277320636F6E7374616E7420706F6F6C20616E642072657475726E732069747320696E64657820696E2074686520706F6F6C2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620746865206D6178696D756D206E756D626572206F6620636F6E7374616E747320686173206265656E20726561636865642E
		Private Function AddConstant(s As String) As Integer
		  /// Adds a String value `s` to the current function's constant pool and returns its index in the pool.
		  /// Raises a `CompilerException` if the maximum number of constants has been reached.
		  
		  Var index As Integer = CurrentChunk.AddConstant(s)
		  
		  If index > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("To many constants in the chunk.")
		  End If
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547261636B7320746865206578697374656E6365206F66206120676C6F62616C207661726961626C65206E616D656420606E616D65602E
		Private Sub AddGlobal(name As String)
		  /// Tracks the existence of a global variable named `name`.
		  
		  // Only the outermost compiler stores the names of defined globals.
		  OutermostCompiler.KnownGlobals.Value(name) = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547261636B732061206C6F63616C207661726961626C6520696E207468652063757272656E742073636F70652E
		Private Sub AddLocal(identifier As ObjoScript.Token, initialised As Boolean = False)
		  /// Tracks a local variable in the current scope.
		  
		  If Locals.Count >= MAX_LOCALS Then
		    Error("Too many local variables in scope.")
		  End If
		  
		  // Set the local's depth to `-1` if not yet initialised.
		  Locals.Add(New ObjoScript.LocalVariable(identifier, If(initialised, ScopeDepth, -1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320616E2061737369676E6D656E7420746F2061207661726961626C65206F7220736574746572206E616D656420606E616D65602E
		Private Sub Assignment(name As String)
		  /// Compiles an assignment to a variable or setter named `name`.
		  ///
		  /// The value to assign is assumed to already be on the top of the stack.
		  
		  // Check for the simplest case (an assignment to a local variable).
		  Var stackIndex As Integer = ResolveLocal(name)
		  If stackIndex <> -1 Then
		    If stackIndex > 255 Then
		      Error("Too many local variables in scope (the maximum is 255).")
		    End If
		    EmitOpcode8(VM.Opcodes.SetLocal, stackIndex)
		    // We're done.
		    Return
		  End If
		  
		  Var isSetter As Boolean = False
		  Var assumeGlobal As Boolean = False
		  
		  // Compute the signature, assuming it's a setter method. 
		  // This will be ignored if it transpires this is not a setter method call.
		  Var signature As String = ObjoScript.ComputeSignature(name, 1, True)
		  
		  // Is this actually a call to a setter method?
		  If CompilingMethodOrConstructor Then
		    
		    If HierarchyContains(CurrentClass, signature, False) Then
		      // Instance setter method.
		      isSetter = True
		      If Self.IsStaticMethod Then
		        Error("Cannot call an instance setter method from within a static method.")
		      Else
		        // Slot 0 of the call frame will be the instance. Push it onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocal, 0)
		      End If
		      
		    ElseIf HierarchyContains(CurrentClass, signature, True) Then
		      // Static setter method.
		      isSetter = True
		      If Self.IsStaticMethod Then
		        // We're calling a static method from within a static method. Therefore, slot 0 of the call frame 
		        // will be the CLASS. Push it onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocal, 0)
		      Else
		        // We're calling a static method from within an instance method. Therefore, slot 0 of the 
		        // call frame will be the INSTANCE. Push its class onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocalClass, 0)
		      End If
		      
		    Else
		      // Can't find a local variable or setter with this name. Assume it's a global variable.
		      assumeGlobal = True
		      
		    End If
		    
		  Else
		    // Since we're not within a method or a constructor we'll assume this is an assignment to 
		    // a global variable.
		    assumeGlobal = True
		  End If
		  
		  If assumeGlobal Then
		    If GlobalExists(name) Then
		      // Add the name of the variable to the constant pool and get its index.
		      Var constantIndex As Integer = AddConstant(name)
		      EmitOpcode8Or16(VM.Opcodes.SetGlobal, VM.Opcodes.SetGlobalLong, constantIndex)
		    Else
		      Error("Undefined global variable `" + name + "`.")
		    End If
		    
		  ElseIf isSetter Then
		    // Currently, the top of the stack is the class (if this is a static method) or the instance
		    // (if an instance method) containing the setter and underneath it is the setter's argument. 
		    // We need to swap this.
		    EmitOpcode(VM.Opcodes.Swap)
		    
		    // Load the method's signature into the constant pool.
		    Var signatureIndex As Integer = AddConstant(signature)
		    
		    // Emit the `invoke` instruction and the index of the setter's signature in the constant pool.
		    EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, signatureIndex)
		    
		    // Emit the argument count (always 1 for setters).
		    EmitByte(1)
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

	#tag Method, Flags = &h21, Description = 506572666F726D7320612062696E617279206F7065726174696F6E206F6E2074776F206E756D65726963206C69746572616C732C20606C6566746020616E64206072696768746020616E642074656C6C732074686520564D20746F207075742074686520726573756C74206F6E2074686520737461636B2E
		Private Sub BinaryLiterals(operator As ObjoScript.TokenTypes, left As Double, right As Double)
		  /// Performs a binary operation on two numeric literals, `left` and `right` and tells
		  /// the VM to put the result on the stack.
		  ///
		  /// This is an optimisation for binary operators where both operands are known in 
		  /// advance to be numeric literals.
		  
		  Select Case operator
		  Case ObjoScript.TokenTypes.Plus
		    Var result As Double = left + right
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Minus
		    Var result As Double = left - right
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    Var result As Double = left / right
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Star
		    Var result As Double = left * right
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Percent
		    Var result As Double = left Mod right
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Less
		    EmitOpcode(If(left < right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    EmitOpcode(If(left <= right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.Greater
		    EmitOpcode(If(left > right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    EmitOpcode(If(left >= right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    EmitOpcode(If(left = right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.NotEqual
		    EmitOpcode(If(left <> right, VM.Opcodes.True_, VM.Opcodes.False_))
		    
		  Case ObjoScript.TokenTypes.LessLess
		    Var leftInt As Integer = left
		    Var rightInt As Integer = right
		    Var result As Double = Bitwise.ShiftLeft(leftInt, rightInt)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    Var leftInt As Integer = left
		    Var rightInt As Integer = right
		    Var result As Double = Bitwise.ShiftRight(leftInt, rightInt)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Ampersand
		    Var leftInt As UInt32 = left
		    Var rightInt As UInt32 = right
		    Var result As Double = CType(leftInt And rightInt, Double)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Caret
		    Var leftInt As UInt32 = left
		    Var rightInt As UInt32 = right
		    Var result As Double = CType(leftInt Xor rightInt, Double)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Case ObjoScript.TokenTypes.Pipe
		    Var leftInt As UInt32 = left
		    Var rightInt As UInt32 = right
		    Var result As Double = CType(leftInt Or rightInt, Double)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, CurrentChunk.AddConstant(result))
		    
		  Else
		    Error("Unknown binary operator """ + operator.ToString + """")
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320612063616C6C20746F206120676C6F62616C2066756E6374696F6E2E205468657265206973206E6F2067756172616E746565207468617420612066756E6374696F6E2065786973747320676C6F62616C6C7920776974682074686973206E616D652E20546861742069732064657465726D696E65642061742072756E74696D652E
		Private Sub CallGlobalFunction(name As String, arguments() As ObjoScript.Expr, location As ObjoScript.Token)
		  /// Compiles a call to a global function.
		  /// There is no guarantee that a function exists globally with this name.
		  /// That is determined at runtime.
		  
		  CurrentLocation = location
		  
		  // Sanity check.
		  If arguments.Count > 255 Then
		    Error("A call cannot have more than 255 arguments.")
		  End If
		  
		  // Add the name of the method to the constant pool and get its index.
		  Var functionNameIndex As Integer = AddConstant(name)
		  
		  // Retrieve the global function now stored in the constant pool and put it on the stack.
		  EmitOpcode8Or16(VM.Opcodes.GetGlobal, VM.Opcodes.GetGlobalLong, functionNameIndex, location)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `call` instruction with the number of arguments as its operand.
		  EmitOpcode8(VM.Opcodes.Call_, arguments.Count)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320612063616C6C20746F2061206C6F63616C207661726961626C652E
		Private Sub CallLocalVariable(stackSlot As Integer, arguments() As ObjoScript.Expr, location As ObjoScript.Token)
		  /// Compiles a call to a local variable.
		  ///
		  /// E.g:
		  ///
		  /// ```objo
		  /// localVariable() # <-- where this is known to be a local variable.
		  /// ```
		  
		  CurrentLocation = location
		  
		  // Sanity checks.
		  If stackSlot > 255 Then
		    Error("The local variable slot must be <= 255.")
		  End If
		  If arguments.Count > 255 Then
		    Error("A call cannot have more than 255 arguments.")
		  End If
		  
		  // Tell the VM to push the local variable at `stackSlot` to the top of the stack.
		  EmitOpcode8(VM.Opcodes.GetLocal, stackSlot)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `call` instruction with the number of arguments as its operand.
		  EmitOpcode8(VM.Opcodes.Call_, arguments.Count)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C207573652E20436F6E636174656E61746573206120636173652073746174656D656E7427732076616C756573207573696E6720746865206C6F676963616C20606F7260206F70657261746F7220696E746F20612073696E676C6520636F6E646974696F6E20746861742063616E206265207573656420696E20616E20606966602073746174656D656E742E
		Private Function CaseValuesToCondition(case_ As ObjoScript.CaseStmt, switchLocation As ObjoScript.Token) As ObjoScript.Expr
		  /// Internal use. Concatenates a case statement's values using the logical `or` 
		  /// operator into a single condition that can be used in an `if` statement.
		  ///
		  /// E.g: 
		  ///
		  /// ```objo
		  /// case 10, 20, true, "a"
		  /// ```
		  ///
		  /// becomes:
		  ///
		  /// ```objo
		  /// consider* == 10 or consider* == 20 or consider* == true or consider* == "a"
		  /// ```
		  
		  If case_.Values.Count = 0 Then
		    Raise New InvalidArgumentException("Did not expect an empty `values()` array.")
		  End If
		  
		  // Create a statement to produce the value of the hidden `consider*` variable.
		  Var consider As New ObjoScript.VariableExpr(SyntheticIdentifier("consider*", switchLocation.ScriptID))
		  
		  // Create a synthetic `or` token.
		  Var orToken As New ObjoScript.Token(ObjoScript.TokenTypes.Or_, case_.Location.StartPosition, _
		  case_.Location.LineNumber, "or", case_.Location.ScriptID)
		  
		  // Create a synthetic `==` token for the comparison of the case value to `consider*`.
		  Var equalToken As New ObjoScript.Token(ObjoScript.TokenTypes.EqualEqual, case_.Location.StartPosition, _
		  case_.Location.LineNumber, "==", case_.Location.ScriptID)
		  
		  // Quick exit? If there's only one value then it just needs to be compared to `consider*`.
		  If case_.Values.Count = 1 Then
		    Return New ObjoScript.BinaryExpr(consider, equalToken, case_.Values(0))
		  End If
		  
		  // Clone the passed array.
		  Var stack() As ObjoScript.Expr
		  For Each value As ObjoScript.Expr In case_.Values
		    stack.Add(value)
		  Next value
		  
		  // Iterate the stack to create a logical or expression.
		  While stack.Count > 1
		    Var left As Variant = stack(0)
		    Var right As Variant = stack(1)
		    
		    // The expressions need to be equality checks against `consider*`.
		    left = New ObjoScript.BinaryExpr(consider, equalToken, left)
		    right = New ObjoScript.BinaryExpr(consider, equalToken, right)
		    
		    // Remove the left and right expressions from the stack.
		    stack.RemoveAt(0)
		    stack.RemoveAt(0)
		    
		    // Push the logical or expression to the front of the stack.
		    stack.AddAt(0, New ObjoScript.LogicalExpr(left, orToken, right))
		  Wend
		  
		  // stack(0) should now be the logical or expression we need.
		  Return stack(0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320726177204F626A6F53637269707420736F7572636520636F646520696E746F206120746F70206C6576656C2066756E6374696F6E2E2050726570656E64732074686520636F646520776974682074686520636F7265206C69627261727920736F7572636520636F64652070726F7669646520647572696E67207468697320636F6D70696C6572277320696E7374616E74696174696F6E2E20526169736573206120604C65786572457863657074696F6E602C2060506172736572457863657074696F6E60206F722060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(source As String, debugMode As Boolean) As ObjoScript.Func
		  /// Compiles raw ObjoScript source code into a top level function. 
		  /// Prepends the code with the core library source code provide during this
		  /// compiler's instantiation.
		  /// Raises a `LexerException`, `ParserException` or `CompilerException` if an error occurs.
		  
		  Reset
		  
		  mDebugMode = debugMode
		  
		  // Import and tokenise the standard libraries first.
		  Var coreTokens() As ObjoScript.Token = Lexer.Tokenise(CoreLibrarySource, False, CORE_LIBRARY_SCRIPT_ID)
		  
		  // Tokenise the user's source code. This may raise a LexerException, therefore aborting compilation.
		  StopWatch.Start
		  mTokens = Lexer.Tokenise(source)
		  StopWatch.Stop
		  mTokeniseTime = StopWatch.ElapsedMilliseconds
		  
		  // Prepend the core tokens to the source code tokens.
		  For i As Integer = coreTokens.LastIndex DownTo 0
		    mTokens.AddAt(0, coreTokens(i))
		  Next i
		  
		  // Parse.
		  StopWatch.Start
		  mAST = Parser.Parse(mTokens)
		  StopWatch.Stop
		  mParseTime = StopWatch.ElapsedMilliseconds
		  
		  If Parser.HasError Then
		    Var message As String
		    If Parser.Errors.Count = 1 Then
		      message = Parser.Errors(0).Message
		    Else
		      message = Parser.Errors.Count.ToString + " parsing errors occurred."
		    End If
		    #Pragma BreakOnExceptions False
		    Raise New ObjoScript.ParserException(message, Parser.Errors(0).Location)
		  End If
		  
		  // Compile the top level `*main*` function.
		  // Synthesise tokens for the opening and closing curly braces.
		  Var openingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.LCurly, 0, 0, "", MAIN_SCRIPT_ID)
		  Var closingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.RCurly, 0, 0, "", MAIN_SCRIPT_ID)
		  
		  // The "*main*" function has no parameters.
		  Var params() As ObjoScript.Token
		  
		  Return Compile("*main*", params, New ObjoScript.BlockStmt(mAST, openingBrace, closingBrace), FunctionTypes.TopLevel, Nil, False, Self.DebugMode, False, Nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E642072657475726E7320612066756E6374696F6E2E2052616973657320612060436F6D70696C6572457863657074696F6E6020696620616E206572726F72206F63637572732E
		Function Compile(name As String, parameters() As ObjoScript.Token, body As ObjoScript.BlockStmt, type As FunctionTypes, currentClass As ObjoScript.ClassData, isStaticMethod As Boolean, debugMode As Boolean, shouldReset As Boolean, enclosingCompiler As ObjoScript.Compiler) As ObjoScript.Func
		  /// Compiles and returns a function. Raises a `CompilerException` if an error occurs.
		  ///
		  /// Resets the compiler by default but this can be overridden by setting `shouldReset` to `True`.
		  
		  If shouldReset Then Reset
		  
		  // Start timing how long the process takes.
		  StopWatch.Start
		  
		  // Should we produce debug or production level bytecode?
		  mDebugMode = debugMode
		  
		  // Create a new function that we'll compile into.
		  MyFunction = New ObjoScript.Func(name, parameters, False, debugMode)
		  
		  Self.CurrentClass = currentClass
		  Self.Enclosing = enclosingCompiler
		  Self.Type = type
		  Self.IsStaticMethod = isStaticMethod
		  
		  If Self.Type <> FunctionTypes.TopLevel Then
		    BeginScope
		    
		    // Compile the parameters.
		    If parameters.Count > 255 Then
		      Error("Functions cannot have more than 255 parameters.")
		    End If
		    
		    For Each p As ObjoScript.Token In parameters
		      DeclareVariable(p, False, False)
		      DefineVariable(0) // The index value doesn't matter as the parameters are local.
		    Next p
		  End If
		  
		  // Compile the body of the function.
		  For Each stmt As ObjoScript.Stmt In body.Statements
		    Call stmt.Accept(Self)
		  Next stmt
		  
		  // Determine the end location for this AST.
		  Var endLocation As ObjoScript.Token
		  If body.Statements.Count = 0 Then
		    // Synthesise a fake end location token.
		    endLocation = New ObjoScript.Token(ObjoScript.TokenTypes.EOF, 0, 1, "", body.ClosingBrace.ScriptID)
		  ElseIf body.Statements(body.Statements.LastIndex) IsA ObjoScript.BlockStmt Then
		    endLocation = ObjoScript.BlockStmt(body.Statements(body.Statements.LastIndex)).ClosingBrace
		  Else
		    endLocation = body.Statements(body.Statements.LastIndex).Location
		  End If
		  
		  // Wind down the compiler.
		  EndCompiler(endLocation)
		  
		  // Stop timing.
		  StopWatch.Stop
		  mCompileTime = StopWatch.ElapsedMilliseconds
		  
		  Return MyFunction
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C6573206120222B2B22206F7220222D2D2220706F73746669782065787072657373696F6E2E20417373756D657320606578707260206973206120222B2B22206F7220222D2D222065787072657373696F6E2E
		Private Sub CompilePostfix(postfix As ObjoScript.PostfixExpr)
		  /// Compiles a "++" or "--" postfix expression.
		  /// Assumes `postfix` is a "++" or "--" expression.
		  
		  // The `++` and `--` operators require a variable or field as their left hand operand.
		  Select Case postfix.Operand
		  Case IsA ObjoScript.VariableExpr, IsA ObjoScript.FieldExpr, IsA ObjoScript.StaticFieldExpr
		    // Allowed.
		  Else
		    Error("The postfix `" + postfix.Operator.ToString + "` operator expects a variable or field as its operand.")
		  End Select
		  
		  // Compile the operand.
		  Call postfix.Operand.Accept(Self)
		  
		  // Manipulate the operand.
		  Select Case postfix.Operator
		  Case ObjoScript.TokenTypes.PlusPlus
		    // Increment the value on the top of the stack by 1.
		    EmitOpcode(VM.Opcodes.Add1)
		    
		  Case ObjoScript.TokenTypes.MinusMinus
		    // Decrement the value on the top of the stack by 1.
		    EmitOpcode(Vm.Opcodes.Subtract1)
		  End Select
		  
		  // Do the assignment.
		  Select Case postfix.Operand
		  Case IsA ObjoScript.VariableExpr
		    Assignment(ObjoScript.VariableExpr(postfix.Operand).Name)
		    
		  Case IsA ObjoScript.FieldExpr
		    FieldAssignment(ObjoScript.FieldExpr(postfix.Operand).Name)
		    
		  Case IsA ObjoScript.StaticFieldExpr
		    StaticFieldAssignment(ObjoScript.StaticFieldExpr(postfix.Operand).Name)
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420746861742072657475726E73206054727565602069662074686520636F6D70696C657220697320636F6D70696C696E672061206D6574686F64206F7220636F6E7374727563746F722E
		Private Function CompilingMethodOrConstructor() As Boolean
		  /// Convenience method that returns `True` if the compiler is compiling a method or constructor.
		  
		  Return Self.Type = FunctionTypes.Method Or Self.Type = FunctionTypes.Constructor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E7374616E7469617465732061206E657720636F6D70696C65722E2060636F72654C696272617279536F75726365602069732074686520736F7572636520636F646520666F722074686520636F7265206C6962726172792E20546869732077696C6C20626520636F6D70696C6564206265666F726520616E79207573657220736F7572636520636F64652E204974206D6179206265206F6D69747465642E
		Sub Constructor(coreLibrarySource As String = "")
		  /// Instantiates a new compiler.
		  /// `coreLibrarySource` is the source code for the core library. 
		  /// This will be compiled before any user source code. It may be omitted.
		  
		  Self.CoreLibrarySource = coreLibrarySource
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 466F72206C6F63616C207661726961626C65732C20746869732069732074686520706F696E742061742077686963682074686520636F6D70696C6572207265636F726473207468656972206578697374656E63652E
		Private Sub DeclareVariable(identifier As ObjoScript.Token, initialised As Boolean, trackAsGlobal As Boolean)
		  /// For local variables, this is the point at which the compiler records their existence.
		  ///
		  /// `identifier` is the token representing the variable's name in the original source code.
		  /// If `initialised` then the compiler marks the local as initialised immediately (relevant for functions).
		  
		  CurrentLocation = identifier
		  
		  If trackAsGlobal Then
		    If GlobalExists(identifier.Lexeme) Then
		      Error("Redefined global identifier `" + identifier.Lexeme + "`.")
		    Else
		      AddGlobal(identifier.Lexeme)
		    End If
		  End If
		  
		  // If this is a global variable we're now done.
		  If ScopeDepth = 0 Then Return
		  
		  // Ensure that another variable has not been declared in current scope with this name.
		  Var name As String = identifier.Lexeme
		  For i As Integer = Locals.Count - 1 DownTo 0
		    Var local As ObjoScript.LocalVariable = Locals(i)
		    If local.Depth <> -1 And local.Depth < ScopeDepth Then
		      Exit
		    End If
		    
		    If name = local.Name Then
		      Error("Redefined variable `" + name + "`.")
		    End If
		  Next i
		  
		  // Must be a local variable. Add it to the list of variables in the current scope.
		  AddLocal(identifier, initialised)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061207661726961626C6520617320726561647920746F207573652E
		Private Sub DefineVariable(index As Integer)
		  /// Defines a variable as ready to use.
		  ///
		  /// For globals it outputs the instructions required to define a global variable whose name is stored in the
		  /// constant pool at `index`.
		  /// For locals, it marks the variable as ready for use by setting its `Depth` property to the current scope depth.
		  
		  If ScopeDepth > 0 Then
		    // Local variable definition.
		    If Locals.Count > 0 Then
		      Locals(Locals.LastIndex).Depth = ScopeDepth
		    End If
		  Else
		    // Global variable definition.
		    EmitOpcode8or16(ObjoScript.VM.Opcodes.DefineGlobal, ObjoScript.VM.Opcodes.DefineGlobalLong, index)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 47656E65726174657320636F646520666F722074686520564D20746F2064697363617264206C6F63616C207661726961626C65732061742060646570746860206F7220677265617465722E20446F6573202A6E6F742A2061637475616C6C7920756E6465636C617265207661726961626C6573206F7220706F7020616E792073636F7065732E2052657475726E7320746865206E756D626572206F66206C6F63616C207661726961626C65732074686174207765726520656C696D696E617465642E
		Private Function DiscardLocals(depth As Integer) As Integer
		  /// Generates code for the VM to discard local variables at `depth` or greater. Does *not*
		  /// actually undeclare variables or pop any scopes. 
		  /// Returns the number of local variables that were eliminated.
		  ///
		  /// This is called directly when compiling `continue` and `exit` statements to ditch the local variables
		  /// before jumping out of the loop even though they are still in scope *past*
		  /// the exit instruction.
		  
		  If ScopeDepth < 0 Then
		    Error("Cannot exit top-level scope.")
		  End If
		  
		  // Figure out how many locals we need to pop.
		  Var local As Integer = Locals.LastIndex
		  Var discardCount As Integer = 0
		  While local >= 0 And Locals(local).Depth >= depth
		    discardCount = discardCount + 1
		    local = local - 1
		  Wend
		  
		  EmitOpcode8(VM.Opcodes.PopN, discardCount)
		  
		  Return discardCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320612073696E676C65206279746520746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E
		Private Sub EmitByte(b As UInt8, location As ObjoScript.Token = Nil)
		  /// Appends a single byte to the current chunk at the current location. 
		  /// An optional `location` can be provided.
		  
		  CurrentChunk.WriteByte(b, If(location = Nil, CurrentLocation, location))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4164647320446F75626C652060646020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C206174207468652063757272656E74206C6F636174696F6E20616E642070757368657320697420746F2074686520737461636B2E2052657475726E732074686520696E64657820696E2074686520636F6E7374616E7420706F6F6C206F7220602D3160206966207468652076616C756520686173206120646564696361746564206F70636F6465206163636573736F722E
		Private Function EmitConstant(d As Double, location As ObjoScript.Token = Nil) As Integer
		  /// Adds Double `d` to the current chunk's constant pool at the current location and pushes it to the stack.
		  /// Returns the index in the constant pool or `-1` if the value has a dedicated opcode accessor.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  // The VM has dedicated instructions for producing certain numeric constants that are commonly used.
		  Select Case d
		  Case 0.0
		    EmitOpcode(VM.Opcodes.Load0, location)
		    Return -1
		  Case 1.0
		    EmitOpcode(VM.Opcodes.Load1, location)
		    Return -1
		  Case 2.0
		    EmitOpcode(VM.Opcodes.Load2, location)
		    Return -1
		  Else
		    Var index As Integer = AddConstant(d)
		    EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, index, location)
		    Return index
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416464732056616C75652060766020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C206174207468652063757272656E74206C6F636174696F6E20616E642070757368657320697420746F2074686520737461636B2E2052657475726E732074686520696E64657820696E2074686520636F6E7374616E7420706F6F6C206F7220602D3160206966207468652076616C756520686173206120646564696361746564206F70636F6465206163636573736F722E
		Private Function EmitConstant(v As ObjoScript.Value, location As ObjoScript.Token = Nil) As Integer
		  /// Adds Value `v` to the current chunk's constant pool at the current location and pushes it to the stack.
		  /// Returns the index in the constant pool or `-1` if the value has a dedicated opcode accessor.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  Var index As Integer = AddConstant(v)
		  
		  EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, index, location)
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4164647320537472696E672060736020746F207468652063757272656E74206368756E6B277320636F6E7374616E7420706F6F6C206174207468652063757272656E74206C6F636174696F6E20616E642070757368657320697420746F2074686520737461636B2E2052657475726E732074686520696E64657820696E2074686520636F6E7374616E7420706F6F6C2E
		Private Function EmitConstant(s As String, location As ObjoScript.Token = Nil) As Integer
		  /// Adds String `s` to the current chunk's constant pool at the current location and pushes it to the stack.
		  /// Returns the index in the constant pool.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  Var index As Integer = AddConstant(s)
		  
		  EmitOpcode8Or16(VM.Opcodes.Constant_, VM.Opcodes.ConstantLong, index, location)
		  
		  Return index
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732074686520606A756D70496E737472756374696F6E60206F63637572696E6720617420736F7572636520606C6F636174696F6E6020286F72207468652063757272656E74206C6F636174696F6E206966204E696C2920616E6420777269746573206120706C616365686F6C64657220282668464646462920666F7220746865206A756D70206F66667365742E2052657475726E7320746865206F6666736574206F6620746865206A756D7020696E737472756374696F6E2E
		Private Function EmitJump(jumpInstruction As ObjoScript.VM.Opcodes, location As ObjoScript.Token = Nil) As Integer
		  /// Emits the `jumpInstruction` occuring at source `location` (or the current location if Nil) 
		  /// and writes a placeholder (&hFFFF) for the jump offset.
		  /// Returns the offset of the jump instruction.
		  ///
		  /// We can jump a maximum of &hFFFF (65535) bytes.
		  
		  location = If(location = Nil, CurrentLocation, location)
		  
		  EmitOpcode(jumpInstruction, location)
		  
		  EmitByte(&hff, location)
		  EmitByte(&hff, location)
		  
		  Return CurrentChunk.Length - 2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732061206E6577206C6F6F7020696E737472756374696F6E20776869636820756E636F6E646974696F6E616C6C79206A756D7073206261636B776172647320746F20606C6F6F705374617274602E20496620606C6F636174696F6E60206973204E696C20776520757365207468652063757272656E74206C6F636174696F6E2E
		Private Sub EmitLoop(loopStart As Integer, location As ObjoScript.Token = Nil)
		  /// Emits a new loop instruction which unconditionally jumps backwards to `loopStart`.
		  /// If `location` is Nil we use the current location.
		  
		  location = If(location = Nil, CurrentLocation, location)
		  
		  EmitOpcode(VM.Opcodes.Loop_)
		  
		  // Compute the offset to subtract from the VM's instruction pointer.
		  // +2 accounts for the `loop` instruction's own operands which we also need to jump over.
		  Var offset As Integer = CurrentChunk.Length - loopStart + 2
		  
		  If offset > MAX_JUMP Then
		    Error("Maximal loop body size exceeded.")
		  End If
		  
		  // Emit the 16-bit offset.
		  EmitUInt16(offset, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320616E206F70636F6465202855496E74382920746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E
		Private Sub EmitOpcode(opcode As ObjoScript.VM.Opcodes, location As ObjoScript.Token = Nil)
		  /// Appends an opcode (UInt8) to the current chunk at the current location. 
		  /// An optional `location` can be provided.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  CurrentChunk.WriteByte(UInt8(opcode), location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320616E206F70636F6465202855496E74382920616E6420612031362D626974206F706572616E6420746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E20417373756D657320606F706572616E64602063616E206669742077697468696E2074776F2062797465732E
		Private Sub EmitOpcode16(opcode As ObjoScript.VM.Opcodes, operand As Integer, location As ObjoScript.Token = Nil)
		  /// Appends an opcode (UInt8) and a 16-bit operand to the current chunk at the current location. 
		  /// An optional `location` can be provided.
		  /// Assumes `operand` can fit within two bytes.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  EmitOpcode(opcode, location)
		  EmitUInt16(operand, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320616E206F70636F6465202855496E74382920616E6420616E20382D626974206F706572616E6420746F207468652063757272656E74206368756E6B206174207468652063757272656E74206C6F636174696F6E2E20416E206F7074696F6E616C20606C6F636174696F6E602063616E2062652070726F76696465642E20417373756D657320606F706572616E64602063616E20626520726570726573656E74656420627920612073696E676C6520627974652E
		Private Sub EmitOpcode8(opcode As ObjoScript.VM.Opcodes, operand As Integer, location As ObjoScript.Token = Nil)
		  /// Appends an opcode (UInt8) and an 8-bit operand to the current chunk at the current location. 
		  /// An optional `location` can be provided.
		  /// Assumes `operand` can be represented by a single byte.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  CurrentChunk.WriteByte(UInt8(opcode), location)
		  CurrentChunk.WriteByte(operand, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320616E206F70636F646520666F6C6C6F77656420627920606F706572616E64602E20606F706572616E6460206D6179206279206F6E65206F722074776F20627974657320696E206C656E6774682E20496620606F706572616E6460206973206F6E652062797465207468656E206073686F72744F70636F64656020697320656D6974746564206265666F726520746865206F706572616E642C206F746865727769736520606C6F6E674F70636F64656020697320656D69747465642E2049662060696E64657860203C3D20323535207468656E206073686F72744F70636F64656020697320656D697474656420666F6C6C6F776564206279207468652073696E676C6520627974652060696E646578602E204F746865727769736520606C6F6E674F70636F64656020697320656D697474656420666F6C6C6F776564206279207468652074776F20627974652060696E646578602E
		Private Sub EmitOpcode8Or16(shortOpcode As ObjoScript.VM.Opcodes, longOpcode As ObjoScript.VM.Opcodes, operand As Integer, location As ObjoScript.Token = Nil)
		  /// Emits an opcode followed by `operand`. `operand` may by one or two bytes in length. If `operand` is
		  /// one byte then `shortOpcode` is emitted before the operand, otherwise `longOpcode` is emitted.
		  /// If `index` <= 255 then `shortOpcode` is emitted followed by the single byte `index`. Otherwise `longOpcode` is emitted
		  /// followed by the two byte `index`.
		  
		  location = If(location = Nil, CurrentLocation, location)
		  
		  If operand < 0 Or operand > ObjoScript.Chunk.MAX_CONSTANTS Then
		    Error("Operand is out of range (expected 0 <= operand < " + ObjoScript.Chunk.MAX_CONSTANTS.ToString + ").", location)
		  End If
		  
		  If operand <= 255 Then
		    // We only need a single byte operand.
		    EmitOpcode8(shortOpcode, operand, location)
		  Else
		    // We need two bytes for the operand.
		    EmitOpcode16(longOpcode, operand, location)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320612072657475726E20696E737472756374696F6E2C2064656661756C74696E6720746F2072657475726E696E6720606E6F7468696E6760206F6E2066756E6374696F6E2072657475726E732E2044656661756C747320746F207468652063757272656E74206C6F636174696F6E2E
		Private Sub EmitReturn(location As ObjoScript.Token = Nil)
		  /// Emits a return instruction, defaulting to returning `nothing` on function returns.
		  /// Defaults to the current location.
		  
		  If Self.Type = FunctionTypes.Constructor Then
		    // Rather than return `nothing`, constructors must default to 
		    // returning `this` which will be in slot 0 of the call frame.
		    EmitOpcode8(ObjoScript.VM.Opcodes.GetLocal, 0, location)
		  Else
		    EmitOpcode(ObjoScript.VM.Opcodes.Nothing, location)
		  End If
		  
		  EmitOpcode(ObjoScript.VM.Opcodes.Return_, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417070656E647320616E20756E7369676E656420696E7465676572202862696720656E6469616E20666F726D61742C206D6F7374207369676E69666963616E7420627974652066697273742920746F207468652063757272656E74206368756E6B2E205468652063757272656E74206C6F636174696F6E206973207573656420756E6C657373206F7468657277697365207370656369666965642E
		Private Sub EmitUInt16(i16 As UInt16, location As ObjoScript.Token = Nil)
		  /// Appends an unsigned integer (big endian format, most significant byte first) to the current chunk.
		  /// The current location is used unless otherwise specified.
		  
		  If location = Nil Then location = CurrentLocation
		  
		  CurrentChunk.WriteUInt16(i16, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E7465726E616C6C792063616C6C6564207768656E2074686520636F6D70696C65722066696E69736865732E
		Private Sub EndCompiler(location As ObjoScript.Token)
		  /// Internally called when the compiler finishes.
		  
		  // We implicitly return an appropriate value if the user did not explictly specify one.
		  If MyFunction.Chunk.Code.Count = 0 Then
		    // Empty function.
		    EmitReturn(location)
		    
		  ElseIf MyFunction.Chunk.Code(MyFunction.Chunk.Code.LastIndex) <> UInt8(ObjoScript.VM.Opcodes.Return_) Then
		    // The function's last instruction was not a return.
		    EmitReturn(location)
		  End If
		  
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
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Find any `exit` placeholder instructions (which will be `exit_` in the
		  // bytecode) and replace them with real jumps.
		  Var i As Integer = CurrentLoop.BodyOffset
		  While i < CurrentChunk.Length
		    If CurrentChunk.Code(i) = UInt8(VM.Opcodes.Exit_) Then
		      CurrentChunk.Code(i) = UInt8(VM.Opcodes.Jump)
		      PatchJump(i + 1)
		      i = i + 3
		    Else
		      // Skip this instruction and its operands.
		      i = i + 1 + OperandByteCountForOpcode(ObjoScript.VM.Opcodes(CurrentChunk.Code(i)))
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
		  
		  // It's more efficient to pop multiple values off the stack at once, therefore we use `popN`.
		  If popCount > 0 Then
		    EmitOpcode8(VM.Opcodes.PopN, popCount)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526169736573206120436F6D70696C6572457863657074696F6E20617420606C6F636174696F6E602E
		Private Sub Error(message As String, location As ObjoScript.Token = Nil)
		  /// Raises a `CompilerException` at the current location. If the error is not at the current location,
		  /// `location` may be passed instead.
		  
		  #Pragma BreakOnExceptions False
		  
		  If location = Nil Then location = CurrentLocation
		  
		  Raise New ObjoScript.CompilerException(message, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D69747320746865204F505F4A554D505F49465F46414C534520696E737472756374696F6E207573656420746F207465737420746865206C6F6F7020636F6E646974696F6E20616E6420706F74656E7469616C6C79206578697420746865206C6F6F702E204B6565707320747261636B206F662074686520696E737472756374696F6E20736F2077652063616E207061746368206974206C61746572206F6E6365207765206B6E6F772077686572652074686520656E64206F662074686520626F64792069732E
		Private Sub ExitLoopIfFalse()
		  /// Emits the `JumpIfFalse` instruction and a `pop` instruction.
		  /// Used to test the loop condition and
		  /// potentially exit the loop. Keeps track of the instruction so we can patch it
		  /// later once we know where the end of the body is.
		  ///
		  /// Assumes a loop is currently being compiled.
		  
		  Self.CurrentLoop.ExitJump = EmitJump(VM.Opcodes.JumpIfFalse)
		  
		  // Pop the condition before executing the body.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 456D6974732074686520604A756D704966547275656020696E737472756374696F6E20616E6420612060706F706020696E737472756374696F6E20746F207465737420746865206C6F6F7020636F6E646974696F6E20616E6420706F74656E7469616C6C79206578697420746865206C6F6F702E204B6565707320747261636B206F662074686520696E737472756374696F6E20736F2077652063616E207061746368206974206C61746572206F6E6365207765206B6E6F772077686572652074686520656E64206F662074686520626F64792069732E
		Private Sub ExitLoopIfTrue()
		  /// Emits the `JumpIfTrue` instruction and a `pop` instruction to test the loop condition and
		  /// potentially exit the loop. Keeps track of the instruction so we can patch it
		  /// later once we know where the end of the body is.
		  ///
		  /// Assumes a loop is currently being compiled.
		  
		  Self.CurrentLoop.ExitJump = EmitJump(VM.Opcodes.JumpIfTrue)
		  
		  // Pop the condition before executing the body.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41737369676E73207468652076616C7565206F6E2074686520746F70206F662074686520737461636B20746F2074686520737065636966696564206669656C642E
		Private Sub FieldAssignment(fieldName As String)
		  /// Assigns the value on the top of the stack to the specified field.
		  
		  If Not CompilingMethodOrConstructor Then
		    Error("Fields can only be accessed from within a method or constructor.")
		  End If
		  
		  If Self.IsStaticMethod Then
		    Error("Instance fields can only be accessed from within an instance method, not a static method.")
		  End If
		  
		  // Get the index of the field to access at runtime.
		  Var fieldIndex As Integer = FieldIndex(fieldName)
		  If fieldIndex > 255 Then
		    Error("Classes cannot have more than 255 fields, including inherited ones.")
		  End If
		  
		  EmitOpcode8(Vm.Opcodes.SetField, fieldIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206669656C6420696E646578206F6620606669656C644E616D656020666F72202A746869732A20636C61737320286E6F7420616E79207375706572636C6173736573292E20546869732069732074686520696E646578207468652072756E74696D652077696C6C206163636573732E204966207468657265206973206E6F206669656C6420776974682074686973206E616D65207468656E2061206E6577206F6E6520697320637265617465642E
		Private Function FieldIndex(fieldName As String) As Integer
		  /// Returns the field index of `fieldName` for *this* class (not any superclasses). 
		  /// This is the index the runtime will access.
		  /// If there is no field with this name then a new one is created.
		  
		  For i As Integer = 0 To CurrentClass.Fields.LastIndex
		    If CurrentClass.Fields(i).CompareCase(fieldName) Then
		      Return CurrentClass.FieldStartIndex + i
		    End If
		  Next i
		  
		  // Doesn't exist yet. Add it.
		  CurrentClass.Fields.Add(fieldName)
		  
		  Return CurrentClass.FieldStartIndex + CurrentClass.Fields.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436865636B73207468697320636F6D70696C65722773206B6E6F776E20636C617373657320616E6420616C6C206F662069747320656E636C6F73696E6720636F6D70696C65727320666F72206120636C617373206E616D65642060636C6173734E616D65602E2052657475726E732074686520636C6173732064617461206F72204E696C206966206E6F7420666F756E642E
		Private Function FindClass(className As String) As ObjoScript.ClassData
		  /// Checks this compiler's known classes and all of its enclosing compilers for 
		  /// a class named `className`.
		  /// Returns the class data or Nil if not found.
		  
		  // Known to this compiler?
		  If KnownClasses.HasKey(className) Then
		    Return KnownClasses.Value(className)
		  End If
		  
		  // Walk the compiler hierarchy.
		  Var parent As ObjoScript.Compiler = Enclosing
		  While parent <> Nil
		    If parent.KnownClasses.HasKey(className) Then
		      Return parent.KnownClasses.Value(className)
		    Else
		      parent = parent.Enclosing
		    End If
		  Wend
		  
		  // Unknown class.
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C6573207468652073796E74686573697365642060666F72656163686020636F6E646974696F6E3A2060697465722A203D207365712A2E6974657261746528697465722A2960
		Private Sub ForEachCondition()
		  /// Compiles the synthesised `foreach` condition: `iter* = seq*.iterate(iter*)`
		  ///
		  /// Internally called from within `VisitForEachStmt()`.
		  
		  Var iter As New ObjoScript.VariableExpr(SyntheticIdentifier("iter*"))
		  Var seq As New ObjoScript.VariableExpr(SyntheticIdentifier("seq*"))
		  Var invocation As New ObjoScript.MethodInvocationExpr(seq, SyntheticIdentifier("iterate"), Array(iter), False)
		  Var assign As New AssignmentExpr(SyntheticIdentifier("iter*"), invocation)
		  
		  Call assign.Accept(Self)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C6573207468652060666F726561636860206C6F6F7020636F756E7465722061737369676E6D656E743A2060766172204C4F4F505F434F554E544552203D207365712A2E6974657261746F7256616C756528697465722A2960
		Private Sub ForEachLoopCounter(loopCounter As ObjoScript.Token)
		  /// Compiles the `foreach` loop counter assignment: `var LOOP_COUNTER = seq*.iteratorValue(iter*)`
		  ///
		  /// Internally called from within `VisitForEachStmt()`.
		  
		  Var iter As New ObjoScript.VariableExpr(SyntheticIdentifier("iter*"))
		  Var seq As New ObjoScript.VariableExpr(SyntheticIdentifier("seq*"))
		  Var invocation As New ObjoScript.MethodInvocationExpr(seq, SyntheticIdentifier("iteratorValue"), Array(iter), False)
		  Var dec As New ObjoScript.VarDeclStmt(SyntheticIdentifier(loopCounter.Lexeme), invocation, CurrentLocation)
		  
		  Call dec.Accept(Self)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54656C6C732074686520564D20746F20726574726965766573206120676C6F62616C207661726961626C65206E616D656420606E616D65602E
		Private Sub GetGlobalVariable(name As String)
		  /// Tells the VM to retrieves a global variable named `name`.
		  
		  // Get the index of the variable in the constant pool (or add it and
		  // then get its index if not already present).
		  Var index As Integer = AddConstant(name)
		  
		  // Push the variable on to the stack.
		  EmitOpcode8Or16(VM.Opcodes.GetGlobal, VM.Opcodes.GetGlobalLong, index, CurrentLocation)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732054727565206966206120676C6F62616C206E616D657320606E616D65602068617320616C7265616479206265656E20646566696E6564206279207468697320636F6D70696C657220636861696E2E
		Private Function GlobalExists(name As String) As Boolean
		  /// Returns True if a global names `name` has already been defined by this compiler chain.
		  
		  Return OutermostCompiler.KnownGlobals.HasKey(name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060737562636C617373602068617320286F722068617320696E68657269746564292061206D6574686F64207769746820607369676E6174757265602E20606973537461746963602064657465726D696E65732077686574686572206F72206E6F742077652073656172636820737461746963206F7220696E7374616E6365206D6574686F64732E204F6E6C7920736561726368657320737461746963202A2A6F722A2A20696E7374616E6365206D6574686F64732E204E6F7420626F74682E
		Private Function HierarchyContains(subclass As ObjoScript.ClassData, signature As String, isStatic As Boolean) As Boolean
		  /// Returns True if `subclass` has (or has inherited) a method with `signature`.
		  /// `isStatic` determines whether or not we search static or instance methods.
		  /// Only searches static **or** instance methods. Not both.
		  
		  If subclass = Nil Then Return False
		  
		  If subclass.Declaration.HasMethodWithSignature(signature, isStatic) Then
		    Return True
		  Else
		    If subclass.Superclass <> Nil Then
		      Return HierarchyContains(FindClass(subclass.Superclass.Name), signature, isStatic)
		    Else
		      Return False
		    End If
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732061206C6F676963616C2060616E64602065787072657373696F6E2E
		Private Sub LogicalAnd(logical As ObjoScript.LogicalExpr)
		  /// Compiles a logical `and` expression.
		  
		  CurrentLocation = logical.Location
		  
		  // Compile the left hand operand to leave it on the VM's stack.
		  Call logical.Left.Accept(Self)
		  
		  // Since `and` short circuits, if the left hand operand is false then the 
		  // whole expression is false so we jump over the right operand and leave the left
		  // operand on the top of the stack.
		  Var endJump As Integer = EmitJump(VM.Opcodes.JumpIfFalse, logical.Location)
		  
		  // If the left hand operand was false then we need to pop it off the stack.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Compile the right hand operand.
		  Call logical.Right.Accept(Self)
		  
		  // Back-patch the jump instruction.
		  PatchJump(endJump)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732061206C6F676963616C2060616E64602065787072657373696F6E2E
		Private Sub LogicalOr(logical As ObjoScript.LogicalExpr)
		  /// Compiles a logical `or` expression.
		  
		  CurrentLocation = logical.Location
		  
		  // Compile the left hand operand to leave it on the VM's stack.
		  Call logical.Left.Accept(Self)
		  
		  // Since the logical operators short circuit, if the left hand operand is true then
		  // we jump over the right hand operand.
		  Var endJump As Integer = EmitJump(VM.Opcodes.JumpIfTrue, logical.Location)
		  
		  // If the left operand was false we need to pop it off the stack.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // The right hand operand only gets evaluated if the left operand was false.
		  Call logical.Right.Accept(Self)
		  
		  // Back-patch the jump instruction.
		  PatchJump(endJump)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732074686520626F6479206F662061206C6F6F7020616E6420747261636B732069747320657874656E7420736F207468617420636F6E7461696E65642060627265616B602073746174656D656E74732063616E2062652068616E646C656420636F72726563746C792E
		Private Sub LoopBody(body As ObjoScript.Stmt)
		  /// Compiles the body of a loop and tracks its extent so that contained `break`
		  /// statements can be handled correctly.
		  
		  Self.CurrentLoop.BodyOffset = CurrentChunk.Length
		  
		  // Compile the optional loop body.
		  If body <> Nil Then
		    Call body.Accept(Self)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F642E204D61726B7320746865206D6F737420726563656E74206C6F63616C207661726961626C6520617320696E697469616C697365642062792073657474696E67206974732073636F70652064657074682E
		Private Sub MarkInitialised()
		  /// Convenience method.
		  /// Marks the most recent local variable as initialised by setting its scope depth.
		  
		  If ScopeDepth = 0 Then Return
		  
		  If Locals.Count > 0 Then
		    Locals(Locals.LastIndex).Depth = ScopeDepth
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206E756D626572206F66206279746573207573656420666F72206F706572616E647320666F7220606F70636F6465602E
		Private Function OperandByteCountForOpcode(opcode As ObjoScript.VM.Opcodes) As Integer
		  /// Returns the number of bytes used for operands for `opcode`.
		  
		  If OpcodeOperand.HasKey(opcode) Then
		    Return OpcodeOperand.Value(opcode)
		  Else
		    Error("Unrecognised opcode: " + opcode.ToString)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320616E206F7074696D697365642060666F726561636860206C6F6F7020776865726520746865206C6F77657220286061602920616E6420757070657220286062602920626F756E647320617265206C69746572616C20696E746567657273206173207468697320697320666173746572207468616E20746865206D6F726520636F6D706C6578206974657261626C6520696D706C656D656E746174696F6E2E
		Private Sub OptimisedForEach(aValue As Double, bValue As Double, loopCounterToken As ObjoScript.Token, body As ObjoScript.BlockStmt, location As ObjoScript.Token)
		  /// Compiles an optimised `foreach` loop where the lower (`aValue`) and upper (`bValue`) bounds
		  /// are literal integers as this is faster than the more complex iterable implementation.
		  ///
		  /// Synthesises a `for` statement depending on whether `bValue` is greater or less than `aValue`.
		  /// Before calling this function, the compiler will have converted things to an inclusive foreach.
		  ///
		  /// Translates:
		  ///
		  /// ```objo
		  /// foreach i in a...b {
		  ///  body 
		  /// }
		  /// ```
		  ///
		  /// To:
		  ///
		  /// ```objo
		  /// for (var i = a; i <= b; i++) {
		  ///   body
		  /// }
		  /// ```
		  ///
		  /// Since number ranges allow counting backwards:
		  ///
		  /// ```objo
		  /// # b >= a (e.g: a...b). Count upwards.
		  /// for (var i = a i <= b i++) {
		  ///  body
		  /// }
		  ///
		  /// # b < a (e.g: a...b). Count backwards.
		  /// for (var i = b i >= a i--) {
		  ///  body
		  /// }
		  /// ```
		  
		  CurrentLocation = location
		  
		  Var forKeyword As New ObjoScript.Token(ObjoScript.TokenTypes.For_, 0, 0, "", location.ScriptID)
		  
		  // The loop counter needs to be a variable lookup expression.
		  Var loopCounter As New VariableExpr(loopCounterToken)
		  
		  // ==================================
		  // Initialiser (var i = a)
		  // ==================================
		  Var aToken As New ObjoScript.Token(ObjoScript.TokenTypes.Number, 0, 0, "", location.ScriptID)
		  aToken.NumberValue = aValue
		  aToken.IsInteger = True
		  Var bToken As New ObjoScript.Token(ObjoScript.TokenTypes.Number, 0, 0, "", location.ScriptID)
		  bToken.NumberValue = bValue
		  bToken.IsInteger = True
		  
		  Var initialiser As ObjoScript.VarDeclStmt = _
		  New ObjoScript.VarDeclStmt(loopCounterToken, New ObjoScript.NumberLiteral(aToken), location)
		  
		  // ==================================
		  // Condition (e.g: i <= a)
		  // ==================================
		  Var operator As ObjoScript.Token
		  If aValue <= bValue Then
		    // E.g: 1(a)...5(b)
		    // Count up from a to b.
		    // i <= b
		    operator = New ObjoScript.Token(ObjoScript.TokenTypes.LessEqual, 0, 0, "", location.ScriptID)
		  Else
		    // E.g: 5(a)...1(b)
		    // count down from a to b.
		    // i >= b
		    operator = New ObjoScript.Token(ObjoScript.TokenTypes.GreaterEqual, 0, 0, "", location.ScriptID)
		  End If
		  Var b As New ObjoScript.NumberLiteral(bToken)
		  Var condition As ObjoScript.BinaryExpr = New ObjoScript.BinaryExpr(loopCounter, operator, b)
		  
		  // ==================================
		  // Post-body expression
		  // ==================================
		  Var postbodyOperator As ObjoScript.Token
		  If aValue <= bValue Then
		    // E.g: 1(a)...5(b)
		    // Count up from a to b.
		    postbodyOperator = New ObjoScript.Token(ObjoScript.TokenTypes.PlusPlus, 0, 0, "", location.ScriptID)
		  Else
		    // E.g: 5(a)...1(b)
		    // count down from a to b.
		    postbodyOperator = New ObjoScript.Token(ObjoScript.TokenTypes.MinusMinus, 0, 0, "", location.ScriptID)
		  End If
		  Var postBodyExpr As New PostfixExpr(loopCounter, postbodyOperator)
		  
		  // Synthesise the `for` statement.
		  Var forStmt As New ObjoScript.ForStmt(initialiser, condition, postBodyExpr, body, forKeyword)
		  
		  // Compile.
		  Call forStmt.Accept(Self)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620616E792070617273657220657863657074696F6E732074686174206F6363757272656420647572696E67207468652070617273696E672070686173652E204D617920626520656D7074792E
		Function ParserErrors() As ObjoScript.ParserException()
		  /// Returns an array of any parser exceptions that occurred during the parsing phase. May be empty.
		  
		  If Parser = Nil Then
		    Var errs() As ObjoScript.ParserException
		    Return errs
		  Else
		    Return Parser.Errors
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B657320746865206F666673657420696E207468652063757272656E74206368756E6B206F6620746865207374617274206F662061206A756D7020706C616365686F6C64657220616E64207265706C61636573207468617420706C616365686F6C6465722077697468207468652074686520616D6F756E74206E656564656420746F20616464656420746F2074686520564D277320495020746F20636175736520697420746F206A756D7020746F207468652063757272656E7420706F736974696F6E20696E20746865206368756E6B2E
		Private Sub PatchJump(offset As Integer)
		  /// Takes the offset in the current chunk of the start of a jump placeholder and 
		  /// replaces that placeholder with the the amount needed to added to the VM's IP to 
		  /// cause it to jump to the current position in the chunk.
		  
		  // Compute the distance to jump to get from the end of the placeholder operand to 
		  // the current offset in the chunk.
		  // -2 to adjust for the bytecode for the jump offset itself.
		  Var jumpDistance As Integer = CurrentChunk.Length - offset - 2
		  
		  If jumpDistance > MAX_JUMP Then
		    Error("Maximum jump distance exceeded.")
		  End If
		  
		  // Replace the 16-bit placeholder with the jump distance.
		  Var msb As UInt8 = Floor(jumpDistance / 256)
		  CurrentChunk.Code(offset) = msb
		  CurrentChunk.Code(offset + 1) = jumpDistance - (msb * 256)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  /// Resets the compiler so it's ready to compile again.
		  
		  ScopeDepth = 0
		  
		  StopWatch = New ObjoScript.StopWatch(False)
		  mCompileTime = 0
		  
		  mAST.ResizeTo(-1)
		  mParseTime = 0
		  
		  mTokens.ResizeTo(-1)
		  mTokeniseTime = 0
		  
		  Lexer = New ObjoScript.Lexer
		  Parser = New ObjoScript.Parser
		  
		  // ===================
		  // LOCALS
		  // ===================
		  Locals.RemoveAll
		  // Claim slot 0 in the stack for the VM's internal use.
		  // For methods and constructors it will be `this`.
		  Var name As String = ""
		  Select Case Type
		  Case FunctionTypes.Method, FunctionTypes.Constructor
		    name = "this"
		  End Select
		  Var synthetic As New ObjoScript.Token(ObjoScript.TokenTypes.Identifier, 0, 1, name, -1)
		  Locals.Add(New ObjoScript.LocalVariable(synthetic, 0))
		  
		  CurrentLoop = Nil
		  CurrentClass = Nil
		  KnownClasses = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  Enclosing = Nil
		  KnownGlobals = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520737461636B20696E646578206F6620746865206C6F63616C207661726961626C65206E616D656420606E616D6560206F7220602D3160206966207468657265206973206E6F206D61746368696E67206C6F63616C207661726961626C6520776974682074686174206E616D652E20496620602D31602069732072657475726E65642C20617373756D6520286D617962652066616C73656C7929207468617420746865207661726961626C6520697320676C6F62616C2E
		Private Function ResolveLocal(name As String) As Integer
		  /// Returns the stack index of the local variable named `name` or `-1` if there is 
		  /// no matching local variable with that name.
		  /// If `-1` is returned, assume (maybe falsely) that the variable is global.
		  ///
		  /// This works because when we declare a local variable we append it to `Locals`.
		  /// This means that the first declared variable is at index 0, the next one index 1 and so on.
		  /// Therefore the `Locals` array in the compiler has the _exact_ same layout as the VM's stack
		  /// will have at runtime. This means the variable's index in `Locals` is the same as its 
		  /// stack slot, relative to its call frame.
		  
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
		  
		  location = If(location = Nil, CurrentLocation, location)
		  
		  Var newLoop As New ObjoScript.LoopData
		  newLoop.Enclosing = Self.CurrentLoop
		  newLoop.Start = CurrentChunk.Length
		  newLoop.ScopeDepth = ScopeDepth
		  newLoop.StartToken = location
		  
		  Self.CurrentLoop = newLoop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41737369676E73207468652076616C7565206F6E2074686520746F70206F662074686520737461636B20746F2074686520737461746963206669656C64206E616D656420606669656C644E616D65602E
		Private Sub StaticFieldAssignment(fieldName As String)
		  /// Assigns the value on the top of the stack to the static field named `fieldName`.
		  
		  If Not CompilingMethodOrConstructor Then
		    Error("Static fields can only be accessed from within a method or constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(fieldName)
		  
		  // Tell the VM to assign the value on the top of the stack to this field.
		  EmitOpcode8Or16(VM.Opcodes.SetStaticField, VM.Opcodes.SetStaticFieldLong, index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C657320612063616C6C20746F2061207375706572636C61737320636F6E7374727563746F722E
		Private Sub SuperConstructorInvocation(arguments() As ObjoScript.Expr, location As ObjoScript.Token)
		  /// Compiles a call to a superclass constructor.
		  ///
		  /// E.g: `super` or `super(argN)`.
		  /// Assumes the compiler is currenting compiling a constructor and that the 
		  /// current class being compiled has a superclass.
		  
		  CurrentLocation = location
		  
		  // Check the superclass has a constructor with this many arguments.
		  If arguments.Count > 0 Then
		    Var superHasMatchingConstructor As Boolean = False
		    For Each constructor As ObjoScript.ConstructorDeclStmt In CurrentClass.Superclass.Declaration.Constructors
		      If constructor.Arity = arguments.Count Then
		        superHasMatchingConstructor = True
		        Exit
		      End If
		    Next constructor
		    If Not superHasMatchingConstructor Then
		      Error("The superclass (`" + CurrentClass.Superclass.Name + "`) of `" + CurrentClass.Name + _
		      "` does not define a constructor with " + arguments.Count.ToString + " arguments.")
		    End If
		  End If
		  
		  // Load the superclass' name into the constant pool.
		  Var superNameIndex As Integer = AddConstant(CurrentClass.Superclass.Name)
		  
		  // Push `this` onto the stack. It's always at slot 0 of the call frame.
		  EmitOpcode8(VM.Opcodes.GetLocal, 0)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `SuperConstructor` instruction, the index of the superclass' name
		  // and the argument count.
		  EmitOpcode(VM.Opcodes.SuperConstructor, location)
		  EmitUInt16(superNameIndex, location)
		  EmitByte(arguments.Count, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6D70696C65732061206D6574686F6420696E766F636174696F6E206F6E20607375706572602E20452E673A2073757065722E6D6574686F6428617267312C2061726732292E
		Private Sub SuperMethodInvocation(signature As String, arguments() As ObjoScript.Expr, location As ObjoScript.Token)
		  /// Compiles a method invocation on `super`. E.g: super.method(arg1, arg2).
		  ///
		  /// Assumes the compiling is currently compiling a method within a class
		  /// and that the current class has a superclass.
		  
		  CurrentLocation = location
		  
		  // Assert that we're currently compiling a class.
		  If CurrentClass = Nil Then
		    Error("`super` can only be used within a method or constructor.")
		  End If
		  
		  // Check the superclass has a matching method.
		  If Not HierarchyContains(CurrentClass.Superclass, signature, False) Then
		    Error("The superclass (`" + CurrentClass.Superclass.Name + "`) of `" + _
		    CurrentClass.Name + "` does not define `" + signature + "`.")
		  End If
		  
		  // Load the superclass' name into the constant pool.
		  Var superNameIndex As Integer = AddConstant(CurrentClass.Superclass.Name)
		  
		  // Push `this` onto the stack. It's always at slot 0 of the call frame.
		  EmitOpcode8(VM.Opcodes.GetLocal, 0)
		  
		  // Load the method's signature into the constant pool.
		  Var signatureIndex As Integer = AddConstant(signature)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `superInvoke` instruction, the superclass name, the index of the 
		  // method's signature in the constant pool and the argument count.
		  EmitOpcode(VM.Opcodes.SuperInvoke, location)
		  EmitUInt16(superNameIndex, location)
		  EmitUInt16(signatureIndex, location)
		  EmitByte(arguments.Count, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44652D73756761727320612060737769746368602073746174656D656E7420746F206120636861696E656420606966602073746174656D656E7420656E636C6F7365642077697468696E206120626C6F636B2E
		Private Function SwitchToIfBlock(stmt As ObjoScript.SwitchStmt) As ObjoScript.BlockStmt
		  /// De-sugars a `switch` statement to a chained `if` statement enclosed within a block.
		  ///
		  /// We de-sugar the switch statement to a series of `if` statements.
		  /// We only evaluate the `consider` expression once and make it available as a 
		  /// secret local variable (`consider*`).
		  ///
		  /// ```objo
		  /// switch consider {
		  ///  case a, b {
		  ///   // First case.
		  ///  }
		  ///  case is < 10 {
		  ///   // Second case.
		  ///  }
		  ///  else {
		  ///   // Default case.
		  ///  }
		  /// }
		  /// ```
		  ///
		  /// becomes:
		  ///
		  /// ```objo
		  /// {
		  ///  var consider* = consider
		  ///  if (a == consider*) or (b == consider*) {
		  ///    // First case.
		  ///  } else if consider* < 10 {
		  ///    // Second case.
		  ///  } else {
		  //     // Default case.
		  ///  }
		  /// }
		  /// ```
		  ///
		  /// Assumes the switch statement contains at least one case.
		  
		  // Create an array to hold the statements of the block we will return.
		  Var statements() As ObjoScript.Stmt
		  
		  // First we need to declare a variable named `consider*` and assign to it the switch statement's
		  // `consider` expression.
		  Var consider As New ObjoScript.VarDeclStmt(SyntheticIdentifier("consider*", stmt.Location.ScriptID), _
		  stmt.Consider, stmt.Location)
		  statements.Add(consider)
		  
		  // We'll use a stack to avoid recursion.
		  Var stack() As ObjoScript.Stmt
		  For Each expr As ObjoScript.CaseStmt In stmt.Cases
		    stack.Add(ObjoScript.Stmt(expr))
		  Next expr
		  
		  // Create a new `if` statement from the first case that will contain the other cases.
		  Var if_ As New ObjoScript.IfStmt(CaseValuesToCondition(stmt.Cases(0), stmt.Location), stmt.Cases(0).Body, Nil, stmt.Cases(0).Location)
		  
		  // Add the parent `if` to the front of the stack.
		  stack.AddAt(0, ObjoScript.Stmt(if_))
		  
		  While stack.Count > 1
		    // The front of the stack is always the `if` statement we're going to return.
		    Var parentIf As ObjoScript.IfStmt = ObjoScript.IfStmt(stack(0))
		    
		    // The adjacent value in the stack will be the next case.
		    Var case_ As ObjoScript.CaseStmt = ObjoScript.CaseStmt(stack(1))
		    
		    // Remove the left and right values from the stack.
		    stack.RemoveAt(0)
		    stack.RemoveAt(0)
		    
		    // Create an "elseif" branch from this case.
		    Var elif As New ObjoScript.IfStmt(CaseValuesToCondition(case_, stmt.Location), case_.Body, Nil, case_.Location)
		    
		    // Set this elseif statement as the "else" branch of the preceding if statement.
		    parentIf.ElseBranch = elif
		    
		    // Add the parent `if` to the front of the stack.
		    stack.AddAt(0, ObjoScript.Stmt(parentIf))
		  Wend
		  
		  // Optional final switch "else" case.
		  If stmt.ElseCase <> Nil Then
		    ObjoScript.IfStmt(ObjoScript.IfStmt(stack(0)).ElseBranch).ElseBranch = stmt.ElseCase.Body
		  End If
		  
		  // stack(0) should be the `if` statement we need.
		  statements.Add(ObjoScript.IfStmt(stack(0)))
		  
		  // Wrap these statements in a synthetic block and return.
		  Var openingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.LCurly, 0, 0, "{", stmt.Location.ScriptID)
		  Var closingBrace As New ObjoScript.Token(ObjoScript.TokenTypes.LCurly, 0, 0, "}", stmt.Location.ScriptID)
		  Return New ObjoScript.BlockStmt(statements, openingBrace, closingBrace)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320612073796E746865746963206964656E74696669657220746F6B656E206174206C696E6520302C20706F732030207769746820606C6578656D656020696E20607363726970744944602E
		Private Function SyntheticIdentifier(lexeme As String, scriptID As Integer = -1) As ObjoScript.Token
		  /// Returns a synthetic identifier token at line 0, pos 0 with `lexeme` in `scriptID`.
		  
		  Return New ObjoScript.Token(ObjoScript.TokenTypes.Identifier, 0, 0, lexeme, scriptID)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520746F6B656E73207468697320636F6D70696C657220697320636F6D70696C696E672E204D617920626520656D7074792069662074686520636F6D70696C65722077617320696E737472756374656420746F20636F6D70696C6520616E20415354206469726563746C792E2053686F756C6420626520636F6E7369646572656420726561642D6F6E6C792E
		Function Tokens() As ObjoScript.Token()
		  /// The tokens this compiler is compiling. 
		  /// May be empty if the compiler was instructed to compile an AST directly.
		  /// Should be considered read-only.
		  
		  Return mTokens
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitAssertStmt(stmt As ObjoScript.AssertStmt) As Variant
		  /// Compiles an `assert` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Compile the condition.
		  Call stmt.Condition.Accept(Self)
		  
		  // Compile the message.
		  Call stmt.Message.Accept(Self)
		  
		  EmitOpcode(VM.Opcodes.Assert, stmt.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitAssignment(expr As ObjoScript.AssignmentExpr) As Variant
		  /// Compiles the assignment of a value to a variable.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Evaluate the value to be assigned.
		  Call expr.Value.Accept(Self)
		  
		  Assignment(expr.Name)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612062617265206D6574686F6420696E766F636174696F6E2E204D75737420626520656974686572206120676C6F62616C2066756E6374696F6E2063616C6C206F722061206C6F63616C206D6574686F6420696E766F636174696F6E206F6E20607468697360
		Function VisitBareInvocationExpr(expr As ObjoScript.BareInvocationExpr) As Variant
		  /// Compiles a bare method invocation.
		  /// Must be either a global function call or a local method invocation on `this`
		  ///
		  /// E.g: 
		  ///
		  /// ```objo
		  /// someIdentifier()
		  /// ```
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Sanity checks.
		  If expr.Arguments.Count > 255 Then
		    Error("An invocation cannot have more than 255 arguments.")
		  End If
		  
		  // Simplest case - are we invoking a local variable?
		  Var stackSlot As Integer = ResolveLocal(expr.MethodName)
		  If stackSlot <> -1 Then
		    CallLocalVariable(stackSlot, expr.Arguments, expr.Location)
		    // We're done.
		    Return Nil
		  End If
		  
		  // Is this an instance or static method invocation called from within a class?
		  Var isMethod As Boolean = False
		  Var isStatic As Boolean = False
		  If HierarchyContains(CurrentClass, expr.Signature, False) Then
		    isMethod = True
		  ElseIf HierarchyContains(CurrentClass, expr.Signature, True) Then
		    isMethod = True
		    isStatic = True
		  End If
		  
		  // Shall we assume this is this a call to a global function?
		  If Not isMethod Then
		    CallGlobalFunction(expr.MethodName, expr.Arguments, expr.Location)
		    // We're done.
		    Return Nil
		  End If
		  
		  If isStatic Then
		    If Self.IsStaticMethod Then
		      // Calling a static method from within a static method. 
		      // Slot 0 of the call frame will be the CLASS.
		      EmitOpcode8(VM.Opcodes.GetLocal, 0)
		    Else
		      // Calling a static method from within an instance method.
		      // Slot 0 of the call frame will be the INSTANCE. Push IT'S class onto the stack.
		      EmitOpcode8(VM.Opcodes.GetLocalClass, 0)
		    End If
		  Else
		    If Self.IsStaticMethod Then
		      Error("Cannot call an instance method from within a static method.")
		    Else
		      // We're calling an instance method.
		      // Slot 0 of the call frame will be the INSTANCE. Push it onto the stack.
		      EmitOpcode8(VM.Opcodes.GetLocal, 0)
		    End If
		  End If
		  
		  // The class (if this is a static method) or the instance will be on the top of the stack.
		  // Load the method's signature into the constant pool.
		  Var signatureIndex As Integer = AddConstant(expr.Signature)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In expr.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `invoke` instruction and the index of the method's signature in the constant pool.
		  EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, signatureIndex, expr.Location)
		  
		  // Emit the argument count.
		  EmitByte(expr.Arguments.Count, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732061206261726520737570657220696E766F636174696F6E2E20452E673A2060737570657260206F7220607375706572286172674E2960
		Function VisitBareSuperInvocation(expr As ObjoScript.BareSuperInvocationExpr) As Variant
		  /// Compiles a bare super invocation. E.g: `super` or `super(argN)`
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Sanity checks.
		  If Not CompilingMethodOrConstructor Then
		    Error("`super` can only be used within a method or constructor.")
		  End If
		  If CurrentClass = Nil Then
		    Error("`super` can only be used within a class.")
		  End If
		  If CurrentClass.Superclass = Nil Then
		    Error("Class `" + CurrentClass.Name + "` does not have a superclass.")
		  End If
		  
		  // Are we calling the superclass' constructor?
		  If Self.Type = FunctionTypes.Constructor Then
		    // Assert that calls to constructors require parentheses (even when there are no arguments).
		    // This is an ObjoScript language requirement.
		    If Not expr.HasParentheses Then
		      Error("A superclass constructor must have an argument list, even if empty.")
		    End If
		    SuperConstructorInvocation(expr.Arguments, expr.Location)
		    // We're done.
		    Return Nil
		  End If
		  
		  If Self.Type = FunctionTypes.Method Then
		    // This is a call to a method on the superclass with the same name as 
		    // the method that we're currently compiling.
		    SuperMethodInvocation(MyFunction.Signature, expr.Arguments, expr.Location)
		    // We're done.
		    Return Nil
		  End If
		  
		  Error("`super` can only be used within a method or constructor.")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBinary(expr As ObjoScript.BinaryExpr) As Variant
		  /// Compiles a binary expression.
		  ///
		  /// a OP b becomes: OP  
		  ///                 b   ← top of the stack
		  ///                 a
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  If Optimise Then
		    // As an optimisation, if both operands are numeric literals, we can do the arithmetic upfront 
		    // and just tell the VM to produce the result.
		    If expr.Left IsA NumberLiteral And expr.Right IsA NumberLiteral Then
		      BinaryLiterals(expr.Operator, NumberLiteral(expr.Left).Value, NumberLiteral(expr.Right).Value)
		      Return Nil
		    End If
		  End If
		  
		  // Compile the left and right operands to put them on the stack.
		  Call expr.Left.Accept(Self)  // a
		  Call expr.Right.Accept(Self) // b
		  
		  // Emit the correct opcode for the binary operator.
		  Select Case expr.Operator
		  Case ObjoScript.TokenTypes.Plus
		    EmitOpcode(VM.Opcodes.Add)
		    
		  Case ObjoScript.TokenTypes.Minus
		    EmitOpcode(VM.Opcodes.Subtract)
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    EmitOpcode(VM.Opcodes.Divide)
		    
		  Case ObjoScript.TokenTypes.Star
		    EmitOpcode(VM.Opcodes.Multiply)
		    
		  Case ObjoScript.TokenTypes.Percent
		    EmitOpcode(VM.Opcodes.Modulo)
		    
		  Case ObjoScript.TokenTypes.Less
		    EmitOpcode(VM.Opcodes.Less)
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    EmitOpcode(VM.Opcodes.LessEqual)
		    
		  Case ObjoScript.TokenTypes.Greater
		    EmitOpcode(VM.Opcodes.Greater)
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    EmitOpcode(VM.Opcodes.GreaterEqual)
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    EmitOpcode(VM.Opcodes.Equal)
		    
		  Case ObjoScript.TokenTypes.NotEqual
		    EmitOpcode(VM.Opcodes.NotEqual)
		    
		  Case ObjoScript.TokenTypes.LessLess
		    EmitOpcode(VM.Opcodes.ShiftLeft)
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    EmitOpcode(VM.Opcodes.ShiftRight)
		    
		  Case ObjoScript.TokenTypes.Ampersand
		    EmitOpcode(VM.Opcodes.BitwiseAnd)
		    
		  Case ObjoScript.TokenTypes.Caret
		    EmitOpcode(VM.Opcodes.BitwiseXor)
		    
		  Case ObjoScript.TokenTypes.Pipe
		    EmitOpcode(VM.Opcodes.BitwiseOr)
		    
		  Else
		    Error("Unknown binary operator """ + expr.Operator.ToString + """")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65206120626C6F636B206F662073746174656D656E74732E
		Function VisitBlock(stmt As ObjoScript.BlockStmt) As Variant
		  /// Compile a block of statements.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  BeginScope
		  
		  For Each statement As ObjoScript.Stmt In stmt.Statements
		    Call statement.Accept(Self)
		  Next statement
		  
		  EndScope
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBoolean(expr As ObjoScript.BooleanLiteral) As Variant
		  /// The VM should produce a boolean constant.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  If expr.Value Then
		    EmitOpcode(ObjoScript.VM.Opcodes.True_)
		  Else
		    EmitOpcode(ObjoScript.VM.Opcodes.False_)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBreakpointStmt(stmt As ObjoScript.BreakpointStmt) As Variant
		  /// Compiles a breakpoint.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  If Not Self.DebugMode Then
		    // Break points have no effect in production builds.
		    Return Nil
		  Else
		    EmitOpcode(VM.Opcodes.Breakpoint)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612063616C6C2065787072657373696F6E2E20452E673A20606964656E7469666965722829602E
		Function VisitCall(expr As ObjoScript.CallExpr) As Variant
		  /// Compiles a call expression. E.g: `identifier()`.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Track where we are.
		  CurrentLocation = expr.Location
		  
		  // Sanity check.
		  If expr.Arguments.Count > 255 Then
		    Error("A call cannot have more than 255 arguments.")
		  End If
		  
		  // Compile the callee.
		  Call expr.Callee.Accept(Self)
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In expr.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `call` instruction with the number of arguments as its operand.
		  EmitOpcode8(VM.Opcodes.Call_, expr.Arguments.Count)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitCaseStmt(stmt As ObjoScript.CaseStmt) As Variant
		  /// Compiles a case within a `switch` statement.
		  ///
		  /// Part of the `ObjoScript.StmtVisitor` interface.
		  
		  // The compiler doesn't visit this as switch statements are compiled into chained `if` statements.
		  #Pragma Unused stmt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732072657472696576696E67206120676C6F62616C20636C6173732E
		Function VisitClass(expr As ObjoScript.ClassExpr) As Variant
		  /// Compiles retrieving a global class.
		  ///
		  /// In Objo, classes are always defined globally.
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Add the name of the class to the constant pool and get its index.
		  Var nameIndex As Integer = AddConstant(expr.Name)
		  
		  // Tell the VM to retrieve the requested global variable (which we're assuming is a class)
		  // and push it on to the stack.
		  EmitOpcode8Or16(VM.Opcodes.GetGlobal, VM.Opcodes.GetGlobalLong, nameIndex, CurrentLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120636C617373206465636C61726174696F6E2E
		Function VisitClassDeclaration(stmt As ObjoScript.ClassDeclStmt) As Variant
		  /// Compiles a class declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Sanity checks.
		  // The class must be declared in the outermost scope (we don't allow nested classes).
		  If ScopeDepth > 0 Then
		    Error("Nested classes are not permitted. Classes may only be declared globally.")
		  End If
		  
		  // Class names must be unique (since they're in the global namespace).
		  If FindClass(stmt.Name) <> Nil Then
		    Error("Redefined class `" + stmt.Name + "`.")
		  End If
		  
		  // We only allow classes to be declared at the top level of a script.
		  If Self.Type <> FunctionTypes.TopLevel Then
		    Error("Classes can only be declared within the top level of a script.")
		  End If
		  
		  // Are we bootstrapping (i.e. compiling `Object` for the first time)?
		  Var bootStrapping As Boolean = False
		  If stmt.Name.CompareCase("Object") And FindClass("Object") = Nil Then
		    Bootstrapping = True
		  End If
		  
		  // ================================
		  // SUPERCLASS
		  // ================================
		  // We don't need to do this if we're compiling `Object` for the first time.
		  Var superclass As ObjoScript.ClassData = Nil
		  If Not bootstrapping Then
		    If Not stmt.HasSuperclass Then
		      // All classes (except for `Object`) implicitly inherit `Object`.
		      stmt.Superclass = "Object"
		    End If
		    
		    // Check the superclass is valid and store a reference to it.
		    If stmt.Name.CompareCase(stmt.Superclass) Then
		      Error("A class cannot inherit from itself.")
		    Else
		      superclass = FindClass(stmt.Superclass)
		      If superclass = Nil Then
		        Error("Class `" + stmt.Name + "` inherits class `" + stmt.Superclass + "` but there is no class with this name.")
		      End If
		    End If
		  End If
		  
		  // ================================
		  // DECLARE THE CLASS
		  // ================================
		  // Store data about the class we're about to compile.
		  CurrentClass = New ObjoScript.ClassData(stmt, superclass)
		  KnownClasses.Value(stmt.Name) = CurrentClass
		  
		  // Declare the class name as a global variable.
		  DeclareVariable(stmt.Identifier, False, True)
		  
		  // Add the name of the class to the function's constants pool.
		  Var classNameIndex As Integer = AddConstant(stmt.Name)
		  
		  // Emit the "declare class" opcode. This will push the class on to the top of the stack.
		  EmitOpcode(VM.Opcodes.Class_, stmt.Location)
		  
		  // The first operand is the index of the name of the class.
		  EmitUInt16(classNameIndex, stmt.Location)
		  
		  // The second operand tells the VM if this is a foreign class (1) or not (0).
		  EmitByte(If(stmt.IsForeign, 1, 0))
		  
		  // The third operand is the total number of fields the class contains (for the entire hierarchy).
		  // We don't know this yet so we will need to back-patch this with the actual number after we're
		  // done compiling the methods and constructors.
		  // For now, we'll emit the maximum number or permitted fields.
		  EmitByte(255)
		  Var numFieldsOffset As Integer = CurrentChunk.Code.LastIndex
		  
		  // The fourth operand is the index in `Klass.Fields` of the first of *this* class' fields.
		  // Earlier indexes are the fields of superclasses.
		  // Strictly speaking, this is only needed for debug stepping in the VM but we'll emit it
		  // even for production code to simplify the VM's implementation.
		  // Classes are declared infrequently so I don't think this will have a meaningful performance penalty.
		  EmitByte(CurrentClass.FieldStartIndex)
		  
		  // Define the class as a global variable.
		  DefineVariable(classNameIndex)
		  
		  // Push the class on to the stack so the methods can find it.
		  EmitOpcode8Or16(VM.Opcodes.GetGlobal, VM.Opcodes.GetGlobalLong, classNameIndex, stmt.Location)
		  
		  // ================================
		  // INHERITANCE
		  // ================================
		  If Not bootstrapping Then
		    If stmt.HasSuperclass Then
		      // Look up the superclass by name and push it on to the top of the stack. Classes are always globally defined.
		      EmitOpcode8Or16(VM.Opcodes.GetGlobal, VM.Opcodes.GetGlobalLong, AddConstant(stmt.Superclass), stmt.Location)
		      
		      // Tell the VM that this class inherits from the class on the top of the stack.
		      // The VM will pop the superclass off the stack when its done handling the inheritance.
		      EmitOpcode(VM.Opcodes.Inherit, stmt.Location)
		    End If
		  End If
		  
		  // ================================
		  // FOREIGN METHOD DECLARATIONS
		  // ================================
		  For Each entry As DictionaryEntry In stmt.ForeignInstanceMethods
		    Var fm As ObjoScript.ForeignMethodDeclStmt = entry.Value
		    Call fm.Accept(Self)
		  Next entry
		  For Each entry As DictionaryEntry In stmt.ForeignStaticMethods
		    Var fm As ObjoScript.ForeignMethodDeclStmt = entry.Value
		    Call fm.Accept(Self)
		  Next entry
		  
		  // ================================
		  // CONSTRUCTORS
		  // ================================
		  For Each constructor As ObjoScript.ConstructorDeclStmt In stmt.Constructors
		    Call constructor.Accept(Self)
		  Next constructor
		  
		  // ================================
		  // STATIC METHODS
		  // ================================
		  For Each entry As DictionaryEntry In stmt.StaticMethods
		    Var sm As ObjoScript.MethodDeclStmt = entry.Value
		    Call sm.Accept(Self)
		  Next entry
		  
		  // ================================
		  // INSTANCE METHODS
		  // ================================
		  For Each entry As DictionaryEntry In stmt.Methods
		    Var m As ObjoScript.MethodDeclStmt = entry.Value
		    Call m.Accept(Self)
		  Next entry
		  
		  // ================================
		  // VALIDATION
		  // ================================
		  // Field count.
		  If CurrentClass.TotalFieldCount > 255 Then
		    Error("Class `" + stmt.Name + "` has exceed the maximum number of fields (255). This includes inherited ones.")
		  End If
		  
		  // Disallow foreign classes from inheriting from classes with fields. 
		  // I'm doing this because Wren does and Bob Nystrom must have a good reason for this :)
		  If stmt.IsForeign And CurrentClass.TotalFieldCount > CurrentClass.FieldCount Then
		    Error("Foreign class `" + CurrentClass.Name + "` may not inherit from a class with fields.")
		  End If
		  
		  // ================================
		  // BACKPATCH FIELDS
		  // ================================
		  // Replace our placeholder with the actual number of fields for this class.
		  CurrentChunk.Code(numFieldsOffset) = CurrentClass.TotalFieldCount
		  
		  // ================================
		  // DEBUGGING DATA
		  // ================================
		  If Self.DebugMode Then
		    // Tell the VM the name and index of all of this class' fields so we can see them in the debugger.
		    // The first operand is the index of the field's name in the constant pool.
		    // The second operand is the index of the field in `Klass.Fields`.
		    For i As Integer = 0 To CurrentClass.Fields.LastIndex
		      Var fieldNameIndex As Integer = AddConstant(CurrentClass.Fields(i))
		      EmitOpcode(VM.Opcodes.DebugFieldName)
		      EmitUInt16(fieldNameIndex)
		      EmitByte(CurrentClass.FieldStartIndex + i)
		    Next i
		  End If
		  
		  // ================================
		  // NOTHING EDGE CASE
		  // ================================
		  // We're compiling the built-in type `Nothing`.
		  // Since the VM keeps just one instance of Nothing, we need to tell it to create it now that
		  // the class has been defined.
		  // There's a special instruction for that.
		  If stmt.Name.CompareCase("Nothing") Then
		    EmitOpcode(VM.Opcodes.DefineNothing)
		  End If
		  
		  // ================================
		  // TIDY UP
		  // ================================
		  // Pop the class off the stack.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // We're no longer compiling a class.
		  CurrentClass = Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitConstructorDeclaration(stmt As ObjoScript.ConstructorDeclStmt) As Variant
		  /// Compiles a class constructor.
		  ///
		  /// To define a new constructor, the VM needs three things:
		  ///  1. The constructor's argument count.
		  ///  2. The function that is the constructor's body.
		  ///  3. The class to bind the constructor to.
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Sanity check.
		  If stmt.Parameters.Count > 255 Then
		    Error("The maximum number of parameters for a constructor is 255.")
		  End If
		  
		  // Compile the body. We need a new compiler for this.
		  Var compiler As New ObjoScript.Compiler
		  Var body As ObjoScript.Func = compiler.Compile("constructor", stmt.Parameters, stmt.Body, FunctionTypes.Constructor, CurrentClass, False, Self.DebugMode, True, Self)
		  
		  // Store the compiled constructor body as a constant in this function's constant pool
		  // and push it on to the stack.
		  Call EmitConstant(body)
		  
		  // Emit the "declare constructor" opcode. The operand is the argument count.
		  EmitOpcode8(VM.Opcodes.Constructor_, stmt.Parameters.Count, stmt.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitContinueStmt(stmt As ObjoScript.ContinueStmt) As Variant
		  /// Compiles a `continue` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  If CurrentLoop = Nil Then
		    Error("Cannot use `continue` outside of a loop.")
		  End If
		  
		  // Since we'll be jumping out of the scope, make sure any locals in it
		  // are discarded first.
		  Call DiscardLocals(CurrentLoop.ScopeDepth + 1)
		  
		  // Emit a jump back to the top of the current loop.
		  EmitLoop(CurrentLoop.Start)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612060646F60206C6F6F702E
		Function VisitDoStmt(stmt As ObjoScript.DoStmt) As Variant
		  /// Compiles a `do` loop.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  StartLoop
		  
		  LoopBody(stmt.Body)
		  
		  Call stmt.Condition.Accept(Self)
		  
		  ExitLoopIfTrue
		  
		  EndLoop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitElseCaseStmt(stmt As ObjoScript.ElseCaseStmt) As Variant
		  /// Compiles the `else` case of a `switch` statement.
		  ///
		  /// Part of the `ObjoScript.StmtVisitor` interface.
		  
		  // The compiler doesn't visit this as switch statements are compiled into chained `if` statements.
		  #Pragma Unused stmt
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E206065786974602073746174656D656E742E
		Function VisitExitStmt(stmt As ObjoScript.ExitStmt) As Variant
		  /// Compiles an `exit` statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  If CurrentLoop = Nil Then
		    Error("Cannot use the `exit` keyword outside of a loop.")
		  End If
		  
		  // Since we'll be jumping out of the scope, make sure any locals in it are
		  // discarded first.
		  Call DiscardLocals(CurrentLoop.ScopeDepth + 1)
		  
		  // Emit a placeholder instruction for the jump to the end of the body. When
		  // we're done compiling the loop body and know where the end is, we'll
		  // replace these with a jump instruction with the appropriate offset.
		  // We use the `exit` opcode as the placeholder.
		  Call EmitJump(ObjoScript.VM.Opcodes.Exit_)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320616E2065787072657373696F6E2073746174656D656E742E
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  /// Compiles an expression statement.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Compile the expression.
		  Call stmt.Expression.Accept(Self)
		  
		  // An expression statement evaluates the expression and, importantly, *discards the result*.
		  EmitOpcode(VM.Opcodes.Pop)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732072657472696576696E6720616E20696E7374616E6365206669656C642E
		Function VisitField(expr As ObjoScript.FieldExpr) As Variant
		  /// Compiles retrieving an instance field.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Assert that field access is valid.
		  If Not CompilingMethodOrConstructor Then
		    Error("Instance fields can obly be accessed from within an instance method or constructor.")
		  End If
		  If Self.IsStaticMethod Then
		    Error("Instance fields can only be accessed from within an instance method, not a static method.")
		  End If
		  
		  // Get the index in this class' `Fields` array to access at runtime.
		  Var fieldIndex As Integer  = FieldIndex(expr.Name)
		  If fieldIndex > 255 Then
		    Error("Classes cannot have more than 255 fields, including inherited ones.")
		  End If
		  
		  // Tell the VM to produce the field's value.
		  EmitOpcode8(VM.Opcodes.GetField, fieldIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732061206669656C642061737369676E6D656E742E
		Function VisitFieldAssignment(expr As ObjoScript.FieldAssignmentExpr) As Variant
		  /// Compiles a field assignment.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Evaluate the value to assign, leaving it on the top of the stack.
		  Call expr.Value.Accept(Self)
		  
		  // Assign the value on the top of the stack to this field.
		  FieldAssignment(expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitForEachStmt(stmt As ObjoScript.ForEachStmt) As Variant
		  /// Compiles a `foreach` loop.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  ///
		  /// This ObjoScript code:
		  ///
		  /// ```
		  /// foreach i in iterable {
		  ///   print i
		  /// }
		  ///```
		  ///
		  /// Is translated to this:
		  ///
		  /// ```
		  ///  var iter* = nothing
		  ///  var seq* = iterable
		  ///  while (iter* = seq*.iterate(iter*)) {
		  ///   var i = seq*.iteratorValue(iter*)
		  ///   System.print(i)
		  ///  }
		  /// ```
		  /// Note that `iter*` and `seq*` are invalid variable names and are internally declared by the compiler.
		  /// On each iteration, we call `iterate()` on `seq*`, passing in the current iterator value (`iter*`).
		  /// In the first iteration, we pass in `nothing`. 
		  /// The job of `seq*` is to take that iterator and advance it to the next element in the sequence.
		  /// In the case where `iter* = nothing` then `seq*` should advance to the first element. 
		  /// `seq*` then returns either the new iterator, or `false` to indicate that there are no more elements.
		  ///
		  /// If false is returned, the VM exits out of the loop and we’re done. 
		  /// If anything else is returned, that means that we have advanced to a new valid element. To get that, 
		  /// The VM then calls `iteratorValue()` on `seq*` and passes in the iterator value that it just got from calling `iterate()`. 
		  /// The sequence uses that to look up and return the appropriate element.
		  
		  If Self.Optimise Then
		    // Optimisation: If the range expression is a numeric literal range (e.g. 1...5) then
		    // compile this as a `for` loop.
		    If stmt.Range IsA RangeExpr Then
		      Var range As ObjoScript.RangeExpr = ObjoScript.RangeExpr(stmt.Range)
		      If range.Lower IsA NumberLiteral And NumberLiteral(range.Lower).IsInteger And _
		        range.Upper IsA NumberLiteral And NumberLiteral(range.Upper).IsInteger Then
		        Var a As Double = NumberLiteral(range.Lower).Value
		        Var b As Double = NumberLiteral(range.Upper).Value
		        If Not range.Inclusive Then
		          If a < b Then // E.g: 1..<5
		            b  = b - 1
		          ElseIf a > b Then // E.g: 5..<1
		            b = b + 1
		          Else
		            // E.g: 5..<5. This doesn't make sense.
		            Error("A numeric literal exclusive range requires that the operands have different values") 
		          End If
		        End If
		        OptimisedForEach(a, b, stmt.LoopCounter, stmt.Body, stmt.Location)
		        Return Nil
		      End If
		    End If
		  End If
		  
		  CurrentLocation = stmt.Location
		  
		  BeginScope
		  
		  // Declare iter* as nothing.
		  EmitOpcode(VM.Opcodes.Nothing)
		  DeclareVariable(SyntheticIdentifier("iter*"), False, False)
		  MarkInitialised
		  
		  // Declare seq* equal to `stmt.Range`
		  Call stmt.Range.Accept(Self)
		  DeclareVariable(SyntheticIdentifier("seq*"), False, False)
		  MarkInitialised
		  
		  StartLoop
		  
		  // Compile the condition: iter* = seq*.iterate(iter*)
		  ForEachCondition
		  
		  ExitLoopIfFalse
		  
		  // Bind the loop variable in its own scope. This ensures we get a fresh
		  // variable each iteration so that closures for it don't all see the same one.
		  BeginScope
		  
		  // Declare the loop counter and assign to it the value of `iter*`.
		  // `var LOOP_COUNTER = seq*.iteratorValue(iter*)`
		  ForEachLoopCounter(stmt.LoopCounter)
		  
		  // Compile the body as defined in the source.
		  LoopBody(stmt.Body)
		  
		  // Loop variable scope.
		  EndScope
		  
		  EndLoop
		  
		  // Hidden variables
		  EndScope
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitForeignMethodDeclaration(stmt As ObjoScript.ForeignMethodDeclStmt) As Variant
		  /// Compiles a foreign method declaration.
		  ///
		  /// To define a new foreign method, the VM needs three things:
		  ///  1. The name of the method.
		  ///  2. The arity of the method.
		  ///  3. Whether or not this is an instance or static method.
		  /// At runtime, the class to bind to should be on the top of the stack.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Add the signature of the method to the function's constants pool.
		  Var sigIndex As Integer = AddConstant(stmt.Signature)
		  
		  // Emit the "declare foreign method" opcode.
		  // The operands are the index of the method's signature in the constants pool, 
		  // the number of arguments the method expects, 
		  // and if it's an instance (0) or static (1) method.
		  EmitOpcode(VM.Opcodes.ForeignMethod)
		  EmitUInt16(sigIndex)
		  EmitByte(stmt.Arity)
		  EmitByte(If(stmt.IsStatic, 1, 0))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6520612060666F7260206C6F6F702E
		Function VisitForStmt(stmt As ObjoScript.ForStmt) As Variant
		  /// Compile a `for` loop.
		  ///
		  /// ```objo
		  /// for (initialiser? ; condition? ; increment?) {
		  ///  statements
		  /// }
		  /// ```
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  BeginScope
		  
		  CurrentLocation = stmt.Location
		  
		  // Optional initialiser.
		  If stmt.Initialiser <> Nil Then
		    Call stmt.Initialiser.Accept(Self)
		  End If
		  
		  StartLoop
		  
		  // Optional condition.
		  If stmt.Condition <> Nil Then
		    Call stmt.Condition.Accept(Self)
		  Else
		    // No condition provided. Set it to true (infinite loop).
		    EmitOpcode(VM.Opcodes.True_)
		  End If
		  
		  // Emit code to exit the loop if the condition is falsey.
		  ExitLoopIfFalse
		  
		  // Compile the loop's body.
		  LoopBody(stmt.Body)
		  
		  // Compile the optional increment expression. It gets inserted after the body of the loop.
		  If stmt.Increment <> Nil Then
		    Call stmt.Increment.Accept(Self)
		    // Pop the increment expression result off the stack.
		    EmitOpcode(VM.Opcodes.Pop, stmt.Increment.Location)
		  End If
		  
		  EndLoop
		  
		  EndScope
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitFuncDeclaration(stmt As ObjoScript.FuncDeclStmt) As Variant
		  /// Compiles a function declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Since we don't support closures, we only allow functions to be declared
		  // at the top level of a script (i.e. not within other functions, methods, class declarations, etc).
		  If Self.Type <> FunctionTypes.TopLevel Then
		    Error("Functions can only be declared within the top level of a script.")
		  End If
		  
		  // We also don't allow functions to be declared within loops.
		  If CurrentLoop <> Nil Then
		    Error("Cannot declare functions within a loop.")
		  End If
		  
		  DeclareVariable(stmt.Name, True, True)
		  
		  // Compile the function body.
		  Var compiler As New ObjoScript.Compiler
		  Var f As ObjoScript.Func = compiler.Compile(stmt.Name.Lexeme, stmt.Parameters, stmt.Body, FunctionTypes.Func, CurrentClass, False, Self.DebugMode, True, Self)
		  
		  // Store the compiled function as a constant in this function's constant pool and push it
		  // on to the stack.
		  Call EmitConstant(f)
		  
		  Var index As Integer = 0
		  If ScopeDepth = 0 Then
		    // Global function. Add the name of the function to the function's constants pool.
		    index = AddConstant(stmt.Name.Lexeme)
		  End If
		  
		  DefineVariable(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitIfStmt(stmt As ObjoScript.IfStmt) As Variant
		  /// Compiles an `if` statement.
		  
		  // Compile the condition - this will leave the result on the top of the stack at runtime.
		  Call stmt.Condition.Accept(Self)
		  
		  // Emit the "jump if false" instruction. We'll patch this with the proper offset to jump
		  // if condition = false after we've compiled the "then branch".
		  Var thenJump As Integer = EmitJump(VM.Opcodes.JumpIfFalse, stmt.Location)
		  
		  // When the condition is truthy we pop the value off the top of the stack before the 
		  // code inside the "then branch".
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Compile the "then branch" statement(s).
		  Call stmt.ThenBranch.Accept(Self)
		  
		  // Emit the "unconditional jump" instruction. We'll patch this with the proper offset to jump
		  // if condition = true after we've compiled the "else branch".
		  Var elseJump As Integer = EmitJump(VM.Opcodes.Jump, stmt.Location)
		  
		  PatchJump(thenJump)
		  
		  // When the condition is falsey we pop the value off the top of the stack before the 
		  // code inside the "else branch".
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Compile the optional "else" branch statement.
		  If stmt.ElseBranch <> Nil Then
		    Call stmt.ElseBranch.Accept(Self)
		  End If
		  
		  PatchJump(elseJump)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitIs(expr As ObjoScript.IsExpr) As Variant
		  /// Compiles an `is` expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Compile the value operand - this will leave it on the stack.
		  Call expr.Value.Accept(Self)
		  
		  // Compile the type to put it on the stack.
		  Call expr.Type.Accept(Self)
		  
		  // Emit the instruction.
		  EmitOpcode(VM.Opcodes.is_, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitKeyValue(expr As ObjoScript.KeyValueExpr) As Variant
		  /// Compiles a key-value literal.
		  ///
		  /// Part of the ObjScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Retrieve the KeyValue class. It should have been defined globally in the standard library.
		  GetGlobalVariable("KeyValue")
		  
		  // Compile the value.
		  Call expr.Value.Accept(Self)
		  
		  // Compile the key.
		  Call expr.Key.Accept(Self)
		  
		  // Tell the VM to create a new KeyValue instance.
		  EmitOpcode(VM.Opcodes.KeyValue, expr.Location)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitListLiteral(expr As ObjoScript.ListLiteral) As Variant
		  /// Compiles a list literal.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Retrieve the List class. It should have been defined globally in the standard library.
		  GetGlobalVariable("List")
		  
		  // Make sure no more than 255 initial elements are defined.
		  If expr.Elements.Count > 255 Then
		    Error("The maximum number of initial elements for a list is 255.")
		  End If
		  
		  // Any initial elements need compiling to leave them on the top of the stack.
		  For Each element As ObjoScript.Expr In expr.Elements
		    Call element.Accept(Self)
		  Next element
		  
		  // Tell the VM to create a List instance with the optional initial elements.
		  EmitOpcode8(VM.Opcodes.List, expr.Elements.Count, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitLogical(expr As ObjoScript.LogicalExpr) As Variant
		  /// The compiler is visiting a logical expression (or, and, xor).
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  Select Case expr.Operator
		  Case ObjoScript.TokenTypes.And_
		    LogicalAnd(expr)
		    
		  Case ObjoScript.TokenTypes.Or_
		    LogicalOr(expr)
		    
		  Case ObjoScript.TokenTypes.Xor_
		    Call expr.Left.Accept(Self)
		    Call expr.Right.Accept(Self)
		    EmitOpcode(VM.Opcodes.LogicalXor)
		    
		  Else
		    Error("Unsupported logical operator: " + expr.Operator.ToString)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitMapLiteral(expr As ObjoScript.MapLiteral) As Variant
		  /// Compiles a Map literal.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Retrieve the Map class. It should have been defined globally in the standard library.
		  GetGlobalVariable("Map")
		  
		  // Make sure no more than 255 initial key-value pairs are defined.
		  If expr.KeyValues.Count > 255 Then
		    Error("The maximum number of initial key-value pairs for a map is 255.")
		  End If
		  
		  // Compile the key-value pairs.
		  // We compile in reverse order compared to how they were parsed which means the first key-value 
		  // popped off the stack by the VM will be the first one in the literal. 
		  // E.g: {a : b, c : d} compiles to:
		  // a         <-- stack top
		  // b
		  // c
		  // d
		  // Map class
		  For i As Integer = expr.KeyValues.LastIndex DownTo 0
		    Var kv As ObjoScript.KeyValueExpr = expr.KeyValues(i)
		    // Compile the value.
		    Call kv.Value.Accept(Self)
		    // Compile the key.
		    Call kv.Key.Accept(Self)
		  Next i
		  
		  // Tell the VM to create a Map instance with the optional initial key-values.
		  EmitOpcode8(VM.Opcodes.Map, expr.KeyValues.Count, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120636C617373206D6574686F64206465636C61726174696F6E2E
		Function VisitMethodDeclaration(stmt As ObjoScript.MethodDeclStmt) As Variant
		  /// Compiles a class method declaration.
		  ///
		  /// To define a new method, the VM needs four things:
		  ///  1. The class to bind the method to on the stack.
		  ///  2. The function that is the method body to be on the stack.
		  ///  3. The name of the method.
		  ///  4. Whether this is an instance or static method.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Assert the parameter count is <= 255 (since that's the maximum that can be called).
		  If stmt.Parameters.Count > 255 Then
		    Error("The maximum number of parameters is 255.")
		  End If
		  
		  // Add the signature of the method to the function's constants pool.
		  Var sigIndex As Integer = AddConstant(stmt.Signature)
		  
		  // Compile the body.
		  Var compiler As New ObjoScript.Compiler
		  Var body As ObjoScript.Func = compiler.Compile(stmt.Name, stmt.Parameters, stmt.Body, FunctionTypes.Method, CurrentClass, stmt.IsStatic, Self.DebugMode, True, Self)
		  body.IsSetter = stmt.IsSetter
		  
		  // Store the compiled method body as a constant in this function's constant pool
		  // and push it on to the stack.
		  Call EmitConstant(body)
		  
		  // Emit the "declare method" opcode.
		  // The first (two byte) operand is the index of the method's signature in the constants pool,
		  // the second operand is `1` if this is a static method or `0` if it's an instance method.
		  EmitOpcode(VM.Opcodes.Method)
		  EmitUInt16(sigIndex)
		  EmitByte(If(stmt.IsStatic, 1, 0))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitMethodInvocation(expr As ObjoScript.MethodInvocationExpr) As Variant
		  /// Compiles a method invocation.
		  ///
		  /// E.g: operand.method(arg1, arg2)
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Compile the operand to put it on the stack.
		  Call expr.Operand.Accept(Self)
		  
		  // Load the method's signature into the constant pool.
		  Var index As Integer = AddConstant(expr.Signature)
		  
		  // Assert that the argument count is <= 255.
		  If expr.Arguments.Count > 255 Then
		    Error("The maximum number of arguments is 255.")
		  End If
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In expr.Arguments
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Emit the `invoke` instruction and the index of the method's signature in the constant pool.
		  EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, index, expr.Location)
		  
		  // Emit the argument count.
		  EmitByte(expr.Arguments.Count, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitNothing(expr As ObjoScript.NothingLiteral) As Variant
		  /// Tell the VM to push the singleton `nothing` instance to the stack.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  EmitOpcode(ObjoScript.VM.Opcodes.Nothing)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520564D2073686F756C642070726F647563652061206E756D6572696320636F6E7374616E742E
		Function VisitNumber(expr As ObjoScript.NumberLiteral) As Variant
		  /// The VM should produce a numeric constant.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // The VM has dedicated instructions for producing certain integer constants that are commonly used.
		  If expr.IsInteger Then
		    Select Case expr.Value
		    Case 0.0
		      EmitOpcode(ObjoScript.VM.Opcodes.Load0)
		      Return Nil
		    Case 1.0
		      EmitOpcode(ObjoScript.VM.Opcodes.Load1)
		      Return Nil
		    Case 2.0
		      EmitOpcode(ObjoScript.VM.Opcodes.Load2)
		      Return Nil
		    End Select
		  End If
		  
		  // Store this number in the chunk's constant table.
		  Var index As Integer = CurrentChunk.AddConstant(expr.Value)
		  EmitOpcode8Or16(ObjoScript.VM.Opcodes.Constant_, ObjoScript.VM.Opcodes.ConstantLong, index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitPostfix(expr As ObjoScript.PostfixExpr) As Variant
		  /// Compiles a postfix expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  If expr.Operator = ObjoScript.TokenTypes.PlusPlus Or expr.Operator = ObjoScript.TokenTypes.MinusMinus Then
		    CompilePostfix(expr)
		  Else
		    Error("Unknown postfix operator `" + expr.Operator.ToString + "`.")
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitRange(expr As ObjoScript.RangeExpr) As Variant
		  /// Compiles an inclusive (...) or exclusive (..<) range expression.
		  ///
		  /// a RANGE_OP b becomes: 
		  ///  RANGE_OP  
		  ///  b   ← top of the stack
		  ///  a
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Compile the left and right operands - this will leave them on the stack.
		  Call expr.Lower.Accept(Self) // a
		  Call expr.Upper.Accept(Self) // b
		  
		  If expr.Inclusive Then
		    EmitOpcode(VM.Opcodes.RangeInclusive)
		  Else
		    EmitOpcode(VM.Opcodes.RangeExclusive)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitReturn(stmt As ObjoScript.ReturnStmt) As Variant
		  /// Compiles a return statement.
		  
		  If Self.Type = FunctionTypes.TopLevel Then
		    Error("Cannot use the `return` keyword in top-level code.")
		  End If
		  
		  CurrentLocation = stmt.Location
		  
		  // Handle the return value. If none was specified then the parser should have synthesised 
		  // a NothingLiteral for us.
		  If Self.Type = FunctionTypes.Constructor Then
		    // Constructors must always return `this` which will be at slot 0 in the call frame.
		    If stmt.Value IsA ObjoScript.NothingLiteral Then
		      EmitOpcode8(VM.Opcodes.GetLocal, 0)
		    Else
		      Error("Can't return a value from a constructor.")
		    End If
		  Else
		    // Compile the return value.
		    Call stmt.Value.Accept(Self)
		  End If
		  
		  EmitOpcode(VM.Opcodes.Return_, stmt.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732072657472696576696E67206120737461746963206669656C642E
		Function VisitStaticField(expr As ObjoScript.StaticFieldExpr) As Variant
		  /// Compiles retrieving a static field.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  If Not CompilingMethodOrConstructor Then
		    Error("Static fields can only be accessed from within a method or a constructor.")
		  End If
		  
		  // Add the name of the field to the constant pool and get its index.
		  Var index As Integer = AddConstant(expr.Name)
		  
		  // Tell the VM to push the field's value on to the stack.
		  EmitOpcode8Or16(VM.Opcodes.GetStaticField, VM.Opcodes.GetStaticFieldLong, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C6573206120737461746963206669656C642061737369676E6D656E742E
		Function VisitStaticFieldAssignment(expr As ObjoScript.StaticFieldAssignmentExpr) As Variant
		  /// Compiles a static field assignment.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Evaluate the value to assign, leaving it on the top of the stack.
		  Call expr.Value.Accept(Self)
		  
		  StaticFieldAssignment(expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520564D2073686F756C642070726F64756365206120737472696E67206C69746572616C2E
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  /// The VM should produce a string literal.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Store the string in the chunk's constant table.
		  Var index As Integer = CurrentChunk.AddConstant(expr.Value)
		  
		  // Tell the VM to read the constant and push to the stack.
		  EmitOpcode8Or16(ObjoScript.VM.Opcodes.Constant_, ObjoScript.VM.Opcodes.ConstantLong, index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSubscript(expr As ObjoScript.Subscript) As Variant
		  /// Compiles a subscript method call.
		  ///
		  /// E.g: operand[1]
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Compile the operand to put it on the stack.
		  Call expr.Operand.Accept(Self)
		  
		  // Load the signature into the constant pool.
		  Var sigIndex As Integer = AddConstant(expr.Signature)
		  
		  If expr.Indices.Count > 255 Then
		    Error("The maximum number of subscript indexes is 255.")
		  End If
		  
		  // Compile the indices.
		  For Each i As ObjoScript.Expr In expr.Indices
		    Call i.Accept(Self)
		  Next i
		  
		  // Emit the `invoke` instruction and the index of the method's signature in the constant pool.
		  EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, sigIndex, expr.Location)
		  
		  // Emit the index count.
		  EmitByte(expr.Indices.Count, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSubscriptSetter(expr As ObjoScript.SubscriptSetter) As Variant
		  /// Compiles a subscript setter call.
		  ///
		  /// E.g: a[1] = value
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Load the signature into the constant pool.
		  Var sigIndex As Integer = AddConstant(expr.Signature)
		  
		  // Compile the operand to put it on the stack.
		  Call expr.Operand.Accept(Self)
		  
		  // 254 not 255 because the value to assign to a setter has to be accounted for.
		  If expr.Indices.Count > 254 Then
		    Error("The maximum number of subscript indexes is 254.")
		  End If
		  
		  // Compile the arguments.
		  For Each arg As ObjoScript.Expr In expr.Indices
		    Call arg.Accept(Self)
		  Next arg
		  
		  // Compile the value to assign.
		  Call expr.ValueToAssign.Accept(Self)
		  
		  // Emit the `invoke` instruction and the index of the signature in the constant pool.
		  EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, sigIndex, expr.Location)
		  
		  // Emit the argument count.
		  // +1 because the value to assign is passed as the last argument to the setter method.
		  EmitByte(expr.Indices.Count + 1, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSuperMethodInvocation(expr As ObjoScript.SuperMethodInvocationExpr) As Variant
		  /// Compiles a method invocation on `super`.
		  ///
		  /// E.g: super.method(arg1, arg2)
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  SuperMethodInvocation(expr.Signature, expr.Arguments, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSuperSetter(expr As ObjoScript.SuperSetterExpr) As Variant
		  /// Compiles a `super` setter expression.
		  ///
		  /// The runtime needs three things to execute a `super` setter expression.
		  ///  1. The superclass name.
		  ///  2. The signature of the setter
		  ///  3. The value to assign.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  If NOt CompilingMethodOrConstructor Then
		    Error("`super` can only be used within a method or constructor.")
		  End If
		  
		  // Check this class actually has a superclass.
		  If CurrentClass.Superclass = Nil Then
		    Error("Class `" + CurrentClass.Name + "` does not have a superclass.")
		  End If
		  
		  // Check the superclass has a matching setter.
		  Var superHasMatchingSetter As Boolean = False
		  For Each entry As DictionaryEntry In CurrentClass.Superclass.Declaration.Methods
		    Var method As ObjoScript.MethodDeclStmt = entry.Value
		    If Not method.IsSetter Then Continue
		    If method.Signature.CompareCase(expr.Signature) Then
		      superHasMatchingSetter = True
		      Exit
		    End If
		  Next entry
		  If Not superHasMatchingSetter Then
		    Error("The superclass (`" + CurrentClass.Superclass.Name + "`) of `" + CurrentClass.Name + "` does not define a setter `" + expr.Signature + "`.")
		  End If
		  
		  // Load the superclass' name into the constant pool.
		  Var superNameIndex As Integer = AddConstant(CurrentClass.Superclass.Name)
		  
		  // Push `this` onto the stack. It's always at slot 0 of the call frame.
		  EmitOpcode8(VM.Opcodes.GetLocal, 0)
		  
		  // Load the setter's signature into the constant pool.
		  Var sigIndex As Integer = AddConstant(expr.Signature)
		  
		  // Compile the value to assign.
		  Call expr.ValueToAssign.Accept(Self)
		  
		  // Emit the `superSetter` instruction, the superclass name index and the index of the 
		  // method's signature in the constant pool.
		  EmitOpcode(VM.Opcodes.SuperSetter, expr.Location)
		  EmitUInt16(superNameIndex, expr.Location)
		  EmitUInt16(sigIndex, expr.Location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C657320612060737769746368602073746174656D656E742E
		Function VisitSwitchStmt(stmt As ObjoScript.SwitchStmt) As Variant
		  /// Compiles a `switch` statement.
		  ///
		  /// Part of the `ObjoScript.StmtVisitor` interface.
		  
		  // Validate the switch statement first.
		  If stmt.Cases.Count = 0 Then
		    Error("A switch statement must include at least one case.")
		  End If
		  
		  // Convert this switch statement to an `if...else` statement contained within a block.
		  Var block As ObjoScript.BlockStmt = SwitchToIfBlock(stmt)
		  
		  // Visit the newly created `if` statement.
		  Call block.Accept(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitTernary(expr As ObjoScript.TernaryExpr) As Variant
		  /// Compiles a ternary conditional expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Compile the condition - this will leave the result on the top of the stack at runtime.
		  Call expr.Condition.Accept(Self)
		  
		  // Emit the "jump if false" instruction. We'll patch this with the proper offset to jump
		  // if condition = false after we've compiled the "then branch".
		  Var thenJump As Integer = EmitJump(VM.Opcodes.JumpIfFalse, expr.Location)
		  
		  // Pop the condition if it was true before executing the "then branch".
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Compile the "then branch" statement(s).
		  Call expr.ThenBranch.Accept(Self)
		  
		  // Emit the "unconditional jump" instruction. We'll patch this with the proper offset to jump
		  // if condition = true _after_ we've compiled the "else branch".
		  Var elseJump As Integer = EmitJump(VM.Opcodes.Jump, expr.Location)
		  
		  PatchJump(thenJump)
		  
		  // Pop the condition if it was false before executing the "else branch".
		  EmitOpcode(VM.Opcodes.Pop)
		  
		  // Compile the "else" branch.
		  Call expr.ElseBranch.Accept(Self)
		  
		  PatchJump(elseJump)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitThis(expr As ObjoScript.ThisExpr) As Variant
		  /// Compiles a `this` expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  If Not CompilingMethodOrConstructor Then
		    Error("`this` can only be used within a method or constructor.")
		  End If
		  
		  // `this` is always at slot 0 of the call frame.
		  // `this` can be an instance or a class.
		  EmitOpcode8(VM.Opcodes.GetLocal, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitUnary(expr As ObjoScript.UnaryExpr) As Variant
		  /// Compile a unary expression.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  CurrentLocation = expr.Location
		  
		  // Emit the correct operator instruction.
		  Select Case expr.Operator
		  Case ObjoScript.TokenTypes.Minus
		    // We can compile negation of numeric literals more efficiently
		    // by letting the compiler negate the value and then emitting it as a constant.
		    If expr.Operand IsA ObjoScript.NumberLiteral Then
		      Select Case ObjoScript.NumberLiteral(expr.Operand).Value
		      Case 1.0
		        // Dedicated opcode as common case.
		        EmitOpcode(VM.Opcodes.LoadMinus1, expr.Operand.Location)
		      Case 2.0
		        // Dedicated opcode as common case.
		        EmitOpcode(VM.Opcodes.LoadMinus2, expr.Operand.Location)
		      Else
		        Call EmitConstant(-ObjoScript.NumberLiteral(expr.Operand).Value, expr.Operand.Location)
		      End Select
		    Else
		      // Compile the operand.
		      Call expr.Operand.Accept(Self)
		      // Emit the negate instruction.
		      EmitOpcode(VM.Opcodes.Negate)
		    End If
		    
		  Case ObjoScript.TokenTypes.Not_
		    // Compile the operand.
		    Call expr.Operand.Accept(Self)
		    // Emit the not instruction.
		    EmitOpcode(VM.Opcodes.Not_)
		    
		  Case ObjoScript.TokenTypes.Tilde
		    // Compile the operand.
		    Call expr.Operand.Accept(Self)
		    // Emit the bitwise not instruction.
		    EmitOpcode(VM.Opcodes.BitwiseNot)
		    
		  Else
		    Error("Unknown unary operator: " + expr.Operator.ToString)
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitVarDeclaration(stmt As ObjoScript.VarDeclStmt) As Variant
		  /// Compiles a variable declaration.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  CurrentLocation = stmt.Location
		  
		  // Compile the initialiser.
		  Call stmt.Initialiser.Accept(Self)
		  
		  DeclareVariable(stmt.Identifier, False, ScopeDepth = 0)
		  
		  Var varNameIndex As Integer = -1 // -1 is a deliberate invalid index.
		  If ScopeDepth = 0 Then
		    // Global variable declaration. Add the name of the variable to the constant pool and get its index.
		    varNameIndex = AddConstant(stmt.Name)
		  End If
		  
		  DefineVariable(varNameIndex)
		  
		  // =====================================
		  // DEBUGGER
		  // =====================================
		  // Support for named local variables.
		  If DebugMode And ScopeDepth > 0 Then
		    // This is a local variable declaration. Tell the VM to record the name and location of
		    // the variable for debugging.
		    EmitOpcode(VM.Opcodes.LocalVarDecl, stmt.Location)
		    varNameIndex = AddConstant(stmt.Name)
		    EmitUInt16(varNameIndex)
		    
		    Var localSlot As Integer = ResolveLocal(stmt.Name)
		    If localSlot < 0 Or localSlot > 255 Then
		      Error("Invalid local variable stack slot")
		    End If
		    EmitByte(localSlot) 
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D70696C65732072657472696576696E672061206E616D6564207661726961626C65206F7220616E20696E766F636174696F6E20746F2061206D6574686F642077697468206E6F20617267756D656E74732E
		Function VisitVariable(expr As ObjoScript.VariableExpr) As Variant
		  /// Compiles retrieving a named variable or an invocation to a method with no arguments.
		  ///
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  // Is this a local variable retrieval?
		  Var slot As Integer = ResolveLocal(expr.Name)
		  If slot <> -1 Then
		    // Yes it is.
		    EmitOpcode8(VM.Opcodes.GetLocal, slot)
		    Return Nil
		  End If
		  
		  // This might be a getter call so compute its signature now.
		  Var signature As String = ObjoScript.ComputeSignature(expr.Name, 0, False)
		  Var isGetter As Boolean = False
		  
		  If CompilingMethodOrConstructor Then
		    Var hasInstance As Boolean = HierarchyContains(CurrentClass, signature, False)
		    Var hasStatic As Boolean = HierarchyContains(CurrentClass, signature, True)
		    
		    If Self.IsStaticMethod Then
		      // Within a static method, we can only call other static methods on this class.
		      If hasInstance And Not hasStatic Then
		        Error("Cannot call an instance method from within a static method.")
		      ElseIf hasStatic Then
		        // We're calling a static method from within a static method. Therefore, slot 0 of the call frame 
		        // will be the class. Push it onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocal, 0)
		        isGetter = True
		      Else
		        // Not a local variable or a static getter method - assume we're retrieving a global variable.
		        GetGlobalVariable(expr.Name)
		      End If
		    Else
		      // Within an instance method, we can call instance or static methods.
		      If hasInstance Then
		        // Slot 0 of the call frame will be the instance. Push it onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocal, 0)
		        isGetter = True
		      ElseIf hasStatic Then
		        // We're calling a static method from within an instance method. Therefore, slot 0 of the 
		        // call frame will be the instance. Push its class onto the stack.
		        EmitOpcode8(VM.Opcodes.GetLocalClass, 0)
		        isGetter = True
		      Else
		        // Not a local variable or a getter method - assume we're retrieving a global variable.
		        GetGlobalVariable(expr.Name)
		      End If
		    End If
		    
		  Else
		    // Not a local variable or a getter method - assume we're retrieving a global variable.
		    GetGlobalVariable(expr.Name)
		  End If
		  
		  If isGetter Then
		    // Load the getter's signature into the constant pool.
		    Var index As Integer = AddConstant(signature)
		    
		    // Emit the `invoke` instruction and the index of the getter's signature in the constant pool
		    EmitOpcode8Or16(VM.Opcodes.Invoke, VM.Opcodes.InvokeLong, index)
		    
		    // Emit the argument count (always 0 for setters).
		    EmitByte(0)
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitWhileStmt(stmt As ObjoScript.WhileStmt) As Variant
		  /// Compile a `while` loop.
		  ///
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  // Track our location.
		  CurrentLocation = stmt.Location
		  
		  StartLoop
		  
		  // Compile the condition.
		  Call stmt.Condition.Accept(Self)
		  
		  ExitLoopIfFalse
		  
		  LoopBody(stmt.Body)
		  
		  EndLoop
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206C61737420636F6D70696C6174696F6E20746F6F6B2E
		#tag Getter
			Get
			  Return mCompileTime
			End Get
		#tag EndGetter
		CompileTime As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520636F7265206C69627261727920736F7572636520636F64652E
		Private CoreLibrarySource As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 52657475726E7320746865206368756E6B207468697320636F6D70696C65722069732063757272656E746C7920636F6D70696C696E6720696E746F2E
		#tag Getter
			Get
			  Return MyFunction.Chunk
			End Get
		#tag EndGetter
		Private CurrentChunk As ObjoScript.Chunk
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 446174612061626F75742074686520636C6173732063757272656E746C79206265696E6720636F6D70696C6564206F72204E696C2069662074686520636F6D70696C65722069736E27742063757272656E746C7920636F6D70696C696E67206120636C6173732E
		Private CurrentClass As ObjoScript.ClassData
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E2074686520636F6D70696C65722069732063757272656E746C7920636F6D70696C696E672E
		Private CurrentLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E7420696E6E65726D6F7374206C6F6F70206265696E6720636F6D70696C65642C206F72204E696C206966206E6F7420696E2061206C6F6F702E
		Private CurrentLoop As ObjoScript.LoopData
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 49662054727565207468656E2074686520636F6D70696C65722077696C6C20696E636C756465206164646974696F6E616C20646562756767696E6720696E666F726D6174696F6E20696E20636F6D70696C6564206368756E6B732E204465627567206368756E6B7320617265206C65737320706572666F726D616E74207468616E2070726F64756374696F6E206368756E6B732E
		#tag Getter
			Get
			  Return mDebugMode
			End Get
		#tag EndGetter
		DebugMode As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320636F6D70696C6572277320656E636C6F73696E6720636F6D70696C65722028696620616E79292E204D6179206265204E696C2E204E656564656420617320636F6D70696C6572732063616E2063616C6C206F7468657220636F6D70696C65727320746F20636F6D70696C652066756E6374696F6E732C206D6574686F64732C206574632E
		Enclosing As ObjoScript.Compiler
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54727565206966207468697320636F6D70696C657220697320636F6D70696C696E67206120737461746963206D6574686F642E
		Private IsStaticMethod As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C617373657320616C726561647920636F6D70696C65642062792074686520636F6D70696C65722E204B6579203D20436C617373206E616D652028636173652073656E736974697665292C2056616C7565203D204F626A6F5363726970742E436C61737344617461
		KnownClasses As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 436F6E7461696E7320746865206E616D6573206F6620657665727920676C6F62616C207661726961626C65206465636C6172656420617320746865206B65792E204F6E6C7920746865206F757465726D6F737420636F6D70696C6572206B6565707320747261636B206F66206465636C61726564207661726961626C65732E204368696C6420636F6D70696C6572732C20616464206E657720676C6F62616C7320746F20746865206F757465726D6F737420706172656E742E205468657265666F72652C206D617920626520656D707479206576656E20696620746865726520617265206B6E6F776E20676C6F62616C732E204B6579203D20676C6F62616C206E616D652028537472696E67292C2056616C7565203D204E696C2E
		Protected KnownGlobals As Dictionary
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

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206C61737420636F6D70696C6174696F6E20746F6F6B2E
		Private mCompileTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520636F6D70696C65722077696C6C20696E636C756465206164646974696F6E616C20646562756767696E6720696E666F726D6174696F6E20696E20636F6D70696C6564206368756E6B732E204465627567206368756E6B7320617265206C65737320706572666F726D616E74207468616E2070726F64756374696F6E206368756E6B732E
		Private mDebugMode As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206D6F737420726563656E742070617273696E6720706861736520746F6F6B2E
		Private mParseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206C617374206D6F737420726563656E74206C6578696E6720706861736520746F6F6B2E
		Private mTokeniseTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E73207468697320636F6D70696C657220697320636F6D70696C696E672E204D617920626520656D7074792069662074686520636F6D70696C65722077617320696E737472756374656420746F20636F6D70696C6520616E20415354206469726563746C792E
		Private mTokens() As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066756E6374696F6E2063757272656E746C79206265696E6720636F6D70696C65642E
		MyFunction As ObjoScript.Func
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 5374617469632064696374696F6E617279206D617070696E67206F70636F64657320746F207468656972206F706572616E6420636F756E74732E204B6579203D204F626A6F5363726970742E564D2E4F70636F6465732C2056616C7565203D206E756D626572206F66206279746573207573656420666F722074686973206F70636F64652E
		#tag Getter
			Get
			  Static d As New Dictionary( _
			  VM.Opcodes.Add                : 0, _
			  VM.Opcodes.Add1               : 0, _
			  VM.Opcodes.Assert             : 0, _
			  VM.Opcodes.BitwiseAnd         : 0, _
			  VM.Opcodes.BitwiseNot         : 0, _
			  VM.Opcodes.BitwiseOr          : 0, _
			  VM.Opcodes.BitwiseXor         : 0, _
			  VM.Opcodes.Breakpoint         : 0, _
			  VM.Opcodes.Call_              : 1, _ // argument count
			  VM.Opcodes.Class_             : 5, _ // className constant index (2 bytes), isForeign (0 false, 1 true), hierarchy field count, fieldStartIndex
			  VM.Opcodes.ConstantLong       : 2, _ // constant pool index (2 bytes)
			  VM.Opcodes.Constant_          : 1, _ // constant pool index (1 byte)
			  VM.Opcodes.Constructor_       : 1, _ // parameter count
			  VM.Opcodes.DebugFieldName     : 3, _ // field name index in constant pool (2 bytes), index of the field in `Klass.Fields`
			  VM.Opcodes.DefineGlobal       : 1, _ // constant pool index of the constant's name (1 byte)
			  VM.Opcodes.DefineGlobalLong   : 2, _ // constant pool index of the constant's name (2 bytes)
			  VM.Opcodes.DefineNothing      : 0, _
			  VM.Opcodes.Divide             : 0, _
			  VM.Opcodes.Equal              : 0, _
			  VM.Opcodes.Exit_              : 0, _
			  VM.Opcodes.False_             : 0, _
			  VM.Opcodes.ForeignMethod      : 4, _ // constant pool index of the signature (2 bytes), arity (1 byte), isStatic (0 false, 1 true)
			  VM.Opcodes.GetField           : 1, _ // index in the current class' `Fields` array to access
			  VM.Opcodes.GetGlobal          : 1, _ // constant pool index of the name of the class (1 byte)
			  VM.Opcodes.GetGlobalLong      : 1, _ // constant pool index of the name of the class (2 bytes)
			  VM.Opcodes.GetLocal           : 1, _ // stack slot where the local variable is
			  VM.Opcodes.GetLocalClass      : 1, _ // stack slot where the local variable is. The VM push it's class on to the stack.
			  VM.Opcodes.GetStaticField     : 1, _ // constant pool index (1 byte) of the name of the static field
			  VM.Opcodes.GetStaticFieldLong : 2, _ // constant pool index (2 bytes) of the name of the static field
			  VM.Opcodes.Greater            : 0, _
			  VM.Opcodes.GreaterEqual       : 0, _
			  VM.Opcodes.Inherit            : 0, _
			  VM.Opcodes.Invoke             : 2, _ // constant pool index (1 byte) of the method to invoke's signature, argument count
			  VM.Opcodes.InvokeLong         : 3, _ // constant pool index (2 bytes) of the method to invoke's signature, argument count
			  VM.Opcodes.Is_                : 0, _
			  VM.Opcodes.Jump               : 2, _ // the number of bytes to jump (2 byte operand)
			  VM.Opcodes.JumpIfFalse        : 2, _ // the number of bytes to jump (2 byte operand)
			  VM.Opcodes.JumpIfTrue         : 2, _ // the number of bytes to jump (2 byte operand)
			  VM.Opcodes.KeyValue           : 0, _
			  VM.Opcodes.Less               : 0, _
			  VM.Opcodes.LessEqual          : 0, _
			  VM.Opcodes.List               : 1, _ // the number of initial elements (1 byte)
			  VM.Opcodes.Load0              : 0, _
			  VM.Opcodes.Load1              : 0, _
			  VM.Opcodes.Load2              : 0, _
			  VM.Opcodes.LoadMinus1         : 0, _
			  VM.Opcodes.LoadMinus2         : 0, _
			  VM.Opcodes.LocalVarDecl       : 3, _ // constant pool index (2 bytes) of the name of the local variable, stack slot where the variable is (1 byte)
			  VM.Opcodes.LogicalXor         : 0, _
			  VM.Opcodes.Loop_              : 2, _ // the number of bytes to jump (2 byte operand)
			  VM.Opcodes.Map                : 1, _ // the number of initial key-value pairs (1 byte)
			  VM.Opcodes.Method             : 3, _ // constant pool index (2 bytes) of the method signature, isStatic (0 = false, 1 = true)
			  VM.Opcodes.Modulo             : 0, _
			  VM.Opcodes.Multiply           : 0, _
			  VM.Opcodes.Negate             : 0, _
			  VM.Opcodes.Not_               : 0, _
			  VM.Opcodes.NotEqual           : 0, _
			  VM.Opcodes.Nothing            : 0, _
			  VM.Opcodes.Pop                : 0, _
			  VM.Opcodes.PopN               : 1, _ // the number of values to pop off the stack
			  VM.Opcodes.RangeExclusive     : 0, _
			  VM.Opcodes.RangeInclusive     : 0, _
			  VM.Opcodes.Return_            : 0, _
			  VM.Opcodes.SetField           : 1, _ // the index of the field (1 byte)
			  VM.Opcodes.SetGlobal          : 1, _ // constant pool index (1 byte) of the name of the variable to get
			  VM.Opcodes.SetGlobalLong      : 2, _ // constant pool index (2 bytes) of the name of the variable to get
			  VM.Opcodes.SetLocal           : 1, _ // the stack slot where the local variable is
			  VM.Opcodes.SetStaticField     : 1, _ // constant pool index (1 byte) of the static field name to assign the value on the top of the stack to
			  VM.Opcodes.SetStaticFieldLong : 2, _ // constant pool index (2 bytes) of the static field name to assign the value on the top of the stack to
			  VM.Opcodes.ShiftLeft          : 0, _
			  VM.Opcodes.ShiftRight         : 0, _
			  VM.Opcodes.Subtract           : 0, _
			  VM.Opcodes.Subtract1          : 0, _
			  VM.Opcodes.SuperConstructor   : 3, _ // constant pool index of the name of the superclass (2 bytes), argument count (1 byte)
			  VM.Opcodes.SuperInvoke        : 5, _ // constant pool index of the name of the superclass (2 bytes), constant pool index of the method name (2 bytes), argument count (1 byte)
			  VM.Opcodes.SuperSetter        : 4, _ // constant pool index of the name of the superclass (2 bytes), constant pool index of the setter signature (2 bytes)
			  VM.Opcodes.Swap               : 0, _
			  VM.Opcodes.True_              : 0 _
			  )
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Private Shared OpcodeOperand As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520636F6D70696C65722077696C6C2074727920746F206F7074696D69736520636F646520776865726520706F737369626C652E
		Optimise As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 52657475726E7320746865206F757465726D6F737420636F6D70696C65722E20546869732069732074686520636F6D70696C657220636F6D70696C696E6720746865206D61696E2066756E6374696F6E2E204974206D6179206265207468697320636F6D70696C65722E
		#tag Getter
			Get
			  Var outermost As ObjoScript.Compiler = Self
			  While outermost.Enclosing <> Nil
			    outermost = outermost.Enclosing
			  Wend
			  
			  Return outermost
			  
			End Get
		#tag EndGetter
		OutermostCompiler As ObjoScript.Compiler
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520636F6D70696C65722773207061727365722E205573656420746F20706172736520736F7572636520636F646520746F6B656E732E
		Private Parser As ObjoScript.Parser
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206D6F737420726563656E742070617273696E6720706861736520746F6F6B2E
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

	#tag Property, Flags = &h21
		Private StopWatch As StopWatch
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206D696C6C697365636F6E647320746865206C617374206D6F737420726563656E74206C6578696E6720706861736520746F6F6B2E
		#tag Getter
			Get
			  Return mTokeniseTime
			End Get
		#tag EndGetter
		TokeniseTime As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652074797065206F662066756E6374696F6E2063757272656E746C79206265696E6720636F6D70696C65642E
		Type As FunctionTypes = FunctionTypes.TopLevel
	#tag EndProperty


	#tag Constant, Name = CORE_LIBRARY_SCRIPT_ID, Type = Double, Dynamic = False, Default = \"-1", Scope = Public, Description = 546865207363726970742049442076616C75652074686520636F6D70696C6572207573657320666F722074686520636F7265206C6962726172792E
	#tag EndConstant

	#tag Constant, Name = MAIN_SCRIPT_ID, Type = Double, Dynamic = False, Default = \"-2", Scope = Public, Description = 5468652073637269707420494420757365642062792074686520636F6D70696C657220666F72207468652073796E746865746963206F70656E696E6720616E6420636C6F73696E67206272616365732061726F756E6420746865202A6D61696E2A2066756E6374696F6E2E
	#tag EndConstant

	#tag Constant, Name = MAX_JUMP, Type = Double, Dynamic = False, Default = \"65535", Scope = Private, Description = 546865206D6178696D756D206A756D702064697374616E636520696E206279746573202855496E743136206D6178292E
	#tag EndConstant

	#tag Constant, Name = MAX_LOCALS, Type = Double, Dynamic = False, Default = \"256", Scope = Private, Description = 546865206D6178696D756D206E756D626572206F66206C6F63616C207661726961626C657320746861742063616E20626520696E2073636F7065206174206F6E652074696D652E204C696D6974656420746F206F6E6520627974652064756520746F2074686520696E737472756374696F6E2773206F706572616E642073697A652E
	#tag EndConstant


	#tag Enum, Name = FunctionTypes, Type = Integer, Flags = &h21, Description = 54686520646966666572656E74207479706573206F662066756E6374696F6E2E
		TopLevel
		  Func
		  Method
		Constructor
	#tag EndEnum


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
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="FunctionTypes.TopLevel"
			Type="FunctionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - TopLevel"
				"1 - Func"
				"2 - Method"
				"3 - Constructor"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DebugMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="ParseTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="Optimise"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
