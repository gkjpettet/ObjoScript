#tag Class
Protected Class Parser
	#tag Method, Flags = &h21, Description = 416476616E63657320746F20746865206E65787420746F6B656E2C2073746F72696E672061207265666572656E636520746F207468652070726576696F757320746F6B656E2E
		Private Sub Advance()
		  /// Advances to the next token, storing a reference to the previous token.
		  
		  Previous = Current
		  mCurrentIndex = mCurrentIndex + 1
		  Current = mTokens(mCurrentIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E206173736572742073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206061737365727460206B6579776F72642E
		Private Function AssertStatement() As ObjoScript.Stmt
		  /// Parses an assert statement. Assumes the parser has just consumed the `assert` keyword.
		  ///
		  /// Format:
		  /// ```objo
		  /// assert(EXPRESSION)
		  /// ```
		  
		  // Store the location of the assert keyword.
		  Var location As ObjoScript.Token = Previous
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the `assert` keyword.")
		  
		  Var expr As ObjoScript.Expr = Expression
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after the assert expression.")
		  
		  ConsumeNewLine("Expected a new line EOL after the assert statement.")
		  
		  Return New ObjoScript.AssertStmt(expr, location)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620776527766520726561636865642074686520656E64206F662074686520746F6B656E2073747265616D2E
		Private Function AtEnd() As Boolean
		  /// True if we've reached the end of the token stream.
		  
		  Return mCurrentIndex > mTokens.LastRowIndex Or Current.Type = ObjoScript.TokenTypes.EOF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F7220612062696E617279206F70657261746F722E
		Private Function BinaryOperator(precedence As Integer, rightAssociative As Boolean = False) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a binary operator.
		  
		  Return New ObjoScript.GrammarRule(Nil, New BinaryParselet(precedence, rightAssociative), precedence)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 506172736573206120626C6F636B206F662073746174656D656E74732E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206C656164696E6720607B602E
		Function Block() As ObjoScript.Stmt
		  /// Parses a block of statements.
		  /// Assumes the parser has just consumed the leading `{`.
		  
		  Var openingBrace As ObjoScript.Token = Previous
		  
		  Var statements() As ObjoScript.Stmt
		  
		  // Consume an optional new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  While Not Check(ObjoScript.TokenTypes.RCurly, ObjoScript.TokenTypes.EOF)
		    statements.Add(Declaration)
		    
		    // Optional new line.
		    Call Match(ObjoScript.TokenTypes.EOL)
		  Wend
		  
		  Var closingBrace As ObjoScript.Token = _
		  Consume(ObjoScript.TokenTypes.RCurly, "Expected a closing brace after block.")
		  
		  // Edge case: The else keyword is permitted after a closing brace in if statements.
		  If Not Check(ObjoScript.TokenTypes.Else_) Then
		    ConsumeNewLine
		  End If
		  
		  Return New ObjoScript.BlockStmt(statements, openingBrace, closingBrace)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074727565206966207468652063757272656E7420746F6B656E206D61746368657320616E79206F6620746865207370656369666965642074797065732E2053696D696C617220746F20604D617463682829602062757420646F6573204E4F5420636F6E73756D65207468652063757272656E7420746F6B656E2069662074686572652069732061206D617463682E
		Function Check(types() As ObjoScript.TokenTypes) As Boolean
		  /// Returns true if the current token matches any of the specified types.
		  /// Similar to `Match()` but does NOT consume the current token if there is a match.
		  
		  For Each type As ObjoScript.TokenTypes In types
		    If Current.Type = type Then Return True
		  Next type
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074727565206966207468652063757272656E7420746F6B656E206D61746368657320616E79206F6620746865207370656369666965642074797065732E2053696D696C617220746F20604D617463682829602062757420646F6573204E4F5420636F6E73756D65207468652063757272656E7420746F6B656E2069662074686572652069732061206D617463682E
		Function Check(ParamArray types As ObjoScript.TokenTypes) As Boolean
		  /// Returns true if the current token matches any of the specified types.
		  /// Similar to `Match()` but does NOT consume the current token if there is a match.
		  
		  For Each type As ObjoScript.TokenTypes In types
		    If Current.Type = type Then Return True
		  Next type
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506172736573206120636C617373206465636C61726174696F6E2073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652060636C61737360206B6579776F726420746F6B656E2E
		Private Function ClassDeclaration() As ObjoScript.Stmt
		  /// Parses a class declaration statement.
		  /// Assumes the parser has just consumed the `class` keyword token.
		  
		  Var classKeyword As ObjoScript.Token = Previous
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier, "Expected a class name.")
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the class name.")
		  
		  // Optional new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Optional methods.
		  Var methods() As ObjoScript.MethodDeclStmt
		  While Not Check(ObjoScript.TokenTypes.RCurly, ObjoScript.TokenTypes.EOF)
		    methods.Add(MethodDeclaration(identifier.Lexeme))
		    
		    // Optional new line.
		    Call Match(ObjoScript.TokenTypes.EOL)
		  Wend
		  
		  Consume(ObjoScript.TokenTypes.RCurly, "Expected a `}` after the class body.")
		  
		  Return New ObjoScript.ClassDeclStmt(identifier, methods, classKeyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  InitialiseGrammar
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D6174636865732060657870656374656460207468656E206974277320636F6E73756D65642E204966206E6F742C20776520726169736520616E20657863657074696F6E207769746820606D657373616765602E
		Sub Consume(expected As ObjoScript.TokenTypes, message As String = "")
		  /// If the current token matches `expected` then it's consumed.
		  /// If not, we raise an exception with `message`.
		  
		  If Current.Type <> expected Then
		    message = If(message = "", "Expected " + expected.ToString + " but got " + Current.Type.ToString + " instead.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D6174636865732060657870656374656460207468656E206974277320636F6E73756D656420616E642072657475726E65642E204966206E6F742C20776520726169736520616E20657863657074696F6E207769746820606D657373616765602E
		Function Consume(expected As ObjoScript.TokenTypes, message As String = "") As ObjoScript.Token
		  /// If the current token matches `expected` then it's consumed and returned.
		  /// If not, we raise an exception with `message`.
		  
		  If Current.Type <> expected Then
		    message = If(message = "", "Expected " + expected.ToString + " but got " + Current.Type.ToString + " instead.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		    Return Previous
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417373657274732074686174207468652063757272656E7420746F6B656E20697320616E20454F4C2E20496620736F20697420697320636F6E73756D65642E204F746865727769736520616E206572726F72207769746820746865206F7074696F6E616C20606D6573736167656020697320637265617465642E
		Private Sub ConsumeNewLine(message As String = "")
		  /// Asserts that the current token is an EOL. If so it is consumed. 
		  /// Otherwise an error with the optional `message` is created.
		  
		  '#Pragma BreakOnExceptions False
		  
		  If Current.Type <> ObjoScript.TokenTypes.EOL Then
		    message = If(message = "", "Expected a new line.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612060636F6E74696E7565602073746174656D656E742E20417373756D6573207468652060636F6E74696E756560206B6579776F726420686173206A757374206265656E20636F6E73756D65642E
		Private Function ContinueStatement() As ObjoScript.Stmt
		  /// Parses a `continue` statement.
		  /// Assumes the `continue` keyword has just been consumed.
		  
		  Var continueKeyword As ObjoScript.Token = Previous
		  
		  ConsumeNewLine("Expected a new line after the `continue` keyword.")
		  
		  Return New ObjoScript.ContinueStmt(continueKeyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273652061206465636C61726174696F6E20696E746F2061206053746D74602E
		Private Function Declaration() As ObjoScript.Stmt
		  /// Parse a declaration into a `Stmt`.
		  ///
		  /// An ObjoScript program is a series of statements. Statements produce a side effect. 
		  /// Declarations are a type of statement that bind new identifiers.
		  /// Regular statements produce side effects but do not introduce new bindings.
		  
		  // Skip superfluous new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  If Match(ObjoScript.TokenTypes.Var_) Then
		    Return VarDeclaration
		    
		  ElseIf Match(ObjoScript.TokenTypes.Function_) Then
		    Return FunctionDeclaration
		    
		  ElseIf Match(ObjoScript.TokenTypes.Class_) Then
		    Return ClassDeclaration
		    
		  Else
		    Return Statement
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526169736573206120506172736572457863657074696F6E206174207468652063757272656E74206C6F636174696F6E2E20496620746865206572726F72206973206E6F74206174207468652063757272656E74206C6F636174696F6E2C20606C6F636174696F6E60206D61792062652070617373656420696E73746561642E
		Sub Error(message As String, location As ObjoScript.Token = Nil)
		  /// Raises a ParserException at the current location. If the error is not at the current location,
		  /// `location` may be passed instead.
		  
		  '#Pragma BreakOnExceptions False
		  
		  If location = Nil Then location = Current
		  
		  Raise New ObjoScript.ParserException(message, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E206065786974602073746174656D656E742E20417373756D65732074686520606578697460206B6579776F726420686173206A757374206265656E20636F6E73756D65642E
		Private Function ExitStatement() As ObjoScript.Stmt
		  /// Parses an `exit` statement.
		  /// Assumes the `exit` keyword has just been consumed.
		  
		  Var exitKeyword As ObjoScript.Token = Previous
		  
		  ConsumeNewLine("Expected a new line after the `exit` keyword.")
		  
		  Return New ObjoScript.ExitStmt(exitKeyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E2065787072657373696F6E2E
		Function Expression() As ObjoScript.Expr
		  /// Parses an expression.
		  
		  // Parse the lowest precedence level which subsumes all of the higher
		  // precedence expressions too.
		  Return ParsePrecedence(Precedences.Lowest)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E2065787072657373696F6E20616E6420777261707320697420757020696E7369646520612073746174656D656E742E20607465726D696E61746F72602077696C6C20626520636F6E73756D65642E
		Private Function ExpressionStatement(terminator As ObjoScript.TokenTypes = ObjoScript.TokenTypes.EOL) As ObjoScript.Stmt
		  /// Parses an expression and wraps it up inside a statement.
		  /// `terminator` will be consumed.
		  ///
		  /// `terminator` is the token that is required to occur after the declaration to be valid.
		  
		  // Skip superfluous new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Store the location of the start of the expression.
		  Var location As ObjoScript.Token = Current
		  
		  // Consume the expression.
		  Var expr As ObjoScript.Expr = Expression
		  
		  // Most expression statements expect a new line after them but some (such as within a
		  // `for` loop initialiser) require something else (e.g. a semicolon).
		  If terminator = ObjoScript.TokenTypes.EOL Or terminator = ObjoScript.TokenTypes.EOF Then
		    // Edge case: This statement immediately precedes the closing brace of a block.
		    If Check(ObjoScript.TokenTypes.RCurly) Then
		      // Do nothing.
		    Else
		      ConsumeNewLine("Expected a new line or EOF after expression statement.")
		    End If
		  Else
		    Consume(terminator, "Expected a " + terminator.ToString + " after the expression.")
		  End If
		  
		  Return New ObjoScript.ExpressionStmt(expr, location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612060666F7260206C6F6F702E20417373756D65732077652068617665206A75737420636F6E73756D6564207468652060666F7260206B6579776F72642E
		Private Function ForEachStatement() As ObjoScript.Stmt
		  /// Parses a `forEach` loop.
		  /// Assumes we have just consumed the `foreach` keyword.
		  ///
		  /// Syntax:
		  ///
		  /// ```objo
		  /// forEach i in RANGE {
		  ///  statements
		  /// }
		  /// ```
		  
		  #Pragma Warning "TODO: Implement foreach statements"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612060666F7260206C6F6F702E20417373756D65732077652068617665206A75737420636F6E73756D6564207468652060666F7260206B6579776F72642E
		Private Function ForStatement() As ObjoScript.Stmt
		  /// Parses a `for` loop.
		  /// Assumes we have just consumed the `for` keyword.
		  ///
		  /// Syntax:
		  ///
		  /// ```objo
		  /// for (initialiser?; condition?; incrementExpression?) {
		  ///  statements
		  /// }
		  /// ```
		  
		  Var forKeyword As ObjoScript.Token = Previous
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected a `(` after the `for` keyword.")
		  
		  Var initialiser As ObjoScript.Stmt = Nil
		  If Match(ObjoScript.TokenTypes.Semicolon) Then
		    // No initialiser.
		  ElseIf Match(ObjoScript.TokenTypes.Var_) Then
		    // Variable declaration.
		    initialiser = VarDeclaration(ObjoScript.TokenTypes.Semicolon)
		  Else
		    // Just an expression.
		    initialiser = ExpressionStatement(ObjoScript.TokenTypes.Semicolon)
		  End If
		  
		  // Optional condition to exit the loop.
		  Var condition As ObjoScript.Expr = Nil
		  If Not Match(ObjoScript.TokenTypes.Semicolon) Then
		    condition = Expression
		    Consume(ObjoScript.TokenTypes.Semicolon, "Expected a semicolon after the loop condition.")
		  End If
		  
		  // Optional increment expression.
		  Var increment As ObjoScript.Expr = Nil
		  If Not Match(ObjoScript.TokenTypes.RParen) Then
		    increment = Expression
		    Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the loop's increment expression.")
		  End If
		  
		  // Optional newline.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Expect a block.
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the `for` clauses.")
		  Var body As ObjoScript.Stmt = Block()
		  
		  Return New ObjoScript.ForStmt(initialiser, condition, increment, body, forKeyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612066756E6374696F6E206465636C61726174696F6E2E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206066756E6374696F6E60206B6579776F72642E
		Private Function FunctionDeclaration() As ObjoScript.Stmt
		  /// Parses a function declaration.
		  /// Assumes the parser has just consumed the `function` keyword.
		  
		  // Store the location of the function keyword.
		  Var funcLocation As ObjoScript.Token = Previous
		  
		  // Get the name of the function.
		  Var name As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier, "Expected a function name.")
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the function's name.")
		  
		  // Optional parameters.
		  Var params() As ObjoScript.Token
		  If Not Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      params.Add(Consume(ObjoScript.TokenTypes.Identifier, "Expected parameter name."))
		    Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after function parameters.")
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after function parameters.")
		  
		  Var body As ObjoScript.BlockStmt = ObjoScript.BlockStmt(Block)
		  
		  Return New FuncDeclStmt(name, params, body, funcLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206772616D6D61722072756C6520666F7220746865207370656369666965642060746F6B656E602E
		Private Function GetRule(token As ObjoScript.TokenTypes) As ObjoScript.GrammarRule
		  /// Returns the grammar rule for the specified `token`.
		  
		  #Pragma BreakOnExceptions False
		  
		  Return mRules.Value(token)
		  
		  Exception e As KeyNotFoundException
		    Error("There is no grammar rule for the `" + token.ToString + "` token.")
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E20606966602073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206069666020746F6B656E2E
		Private Function IfStatement() As ObjoScript.Stmt
		  /// Parses an `if` statement. Assumes the parser has just consumed the `if` token.
		  
		  Var ifKeyword As ObjoScript.Token = Previous
		  
		  Var condition As ObjoScript.Expr = Expression
		  
		  // Parse the "then" branch.
		  Var thenBranch As ObjoScript.Stmt
		  If Match(ObjoScript.TokenTypes.Then_) Then
		    // Single line if.
		    thenBranch = Statement
		  ElseIf Match(ObjoScript.TokenTypes.LCurly) Then
		    thenBranch = Block
		  Else
		    Error("Expected `then` or a `{` after the condition.")
		  End If
		  
		  // Optional else statement.
		  Var elseBranch As ObjoScript.Stmt = Nil
		  If Match(ObjoScript.TokenTypes.Else_) Then
		    If Match(ObjoScript.TokenTypes.If_) Then
		      elseBranch = IfStatement
		    ElseIf Match(ObjoScript.TokenTypes.LCurly) Then
		      elseBranch = Block
		    Else
		      Error("Expected a `{` or another `if` statement after the `else` keyword.")
		    End If
		  End If
		  
		  Return New ObjoScript.IfStmt(condition, thenBranch, elseBranch, ifKeyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C6973657320746865207061727365722773206772616D6D61722072756C65732E
		Private Sub InitialiseGrammar()
		  /// Initialises the parser's grammar rules.
		  
		  #Pragma Warning "TODO"
		  ' 1. Add LCurly
		  ' 2. Add Lsquare
		  
		  mRules = New Dictionary( _
		  TokenTypes.Ampersand         : BinaryOperator(Precedences.BitwiseAnd), _
		  TokenTypes.And_              : BinaryOperator(Precedences.LogicalAnd), _
		  TokenTypes.Assert            : Unused, _
		  TokenTypes.As_               : Unused, _
		  TokenTypes.Boolean_          : Prefix(New LiteralParselet), _
		  TokenTypes.Breakpoint        : Unused, _
		  TokenTypes.Caret             : BinaryOperator(Precedences.BitwiseXor), _
		  TokenTypes.Class_            : Unused, _
		  TokenTypes.Colon             : Unused, _
		  TokenTypes.Comma             : Unused, _
		  TokenTypes.Construct         : Unused, _
		  TokenTypes.Continue_         : Unused, _
		  TokenTypes.Dot               : NewRule(Nil, New DotParselet, Precedences.Call_), _
		  TokenTypes.DotDot            : BinaryOperator(Precedences.Range), _
		  TokenTypes.DotDotDot         : BinaryOperator(Precedences.Range), _
		  TokenTypes.Else_             : Unused, _
		  TokenTypes.EOF               : Unused, _
		  TokenTypes.EOL               : Unused, _
		  TokenTypes.Equal             : Unused, _
		  TokenTypes.EqualEqual        : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Exit_             : Unused, _
		  TokenTypes.Export            : Unused, _
		  TokenTypes.FieldIdentifier   : Unused, _
		  TokenTypes.Foreign           : Unused, _
		  TokenTypes.ForwardSlash      : BinaryOperator(Precedences.Factor), _
		  TokenTypes.ForwardSlashEqual : Unused, _
		  TokenTypes.For_              : Unused, _
		  TokenTypes.Function_         : Unused, _
		  TokenTypes.Greater           : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterEqual      : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterGreater    : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.Identifier        : Prefix(New VariableParselet), _
		  TokenTypes.If_               : Unused, _
		  TokenTypes.Import            : Unused, _
		  TokenTypes.In_               : Unused, _
		  TokenTypes.Is_               : BinaryOperator(Precedences.Is_), _
		  TokenTypes.LCurly            : Unused, _
		  TokenTypes.Less              : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessEqual         : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessLess          : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.LParen            : NewRule(New GroupParselet,  New CallParselet, Precedences.Call_), _
		  TokenTypes.LSquare           : Unused, _
		  TokenTypes.Minus             : Operator, _
		  TokenTypes.MinusMinus        : Postfix, _
		  TokenTypes.MinusEqual        : Unused, _
		  TokenTypes.NotEqual          : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Nothing           : Unused, _
		  TokenTypes.Not_              : Prefix(New UnaryParselet), _
		  TokenTypes.Number            : Prefix(New LiteralParselet), _
		  TokenTypes.Or_               : BinaryOperator(Precedences.LogicalOr), _
		  TokenTypes.Percent           : BinaryOperator(Precedences.Factor), _
		  TokenTypes.Pipe              : BinaryOperator(Precedences.BitwiseOr), _
		  TokenTypes.Plus              : BinaryOperator(Precedences.Term), _
		  TokenTypes.PlusEqual         : Unused, _
		  TokenTypes.PlusPlus          : Postfix, _
		  TokenTypes.Print             : Unused, _
		  TokenTypes.Query             : Unused, _
		  TokenTypes.RCurly            : Unused, _
		  TokenTypes.Return_           : Unused, _
		  TokenTypes.RParen            : Unused, _
		  TokenTypes.RSquare           : Unused, _
		  TokenTypes.Semicolon         : Unused, _
		  TokenTypes.Star              : BinaryOperator(Precedences.Factor), _
		  TokenTypes.StarEqual         : Unused, _
		  TokenTypes.Static_           : Unused, _
		  TokenTypes.String_           : Prefix(New LiteralParselet), _
		  TokenTypes.Then_             : Unused, _
		  TokenTypes.This              : Unused, _
		  TokenTypes.Tilde             : NewRule(New UnaryParselet, Nil, Precedences.None), _
		  TokenTypes.Underscore        : Unused, _
		  TokenTypes.Var_              : Unused, _
		  TokenTypes.While_            : Unused, _
		  TokenTypes.Xor_              : BinaryOperator(Precedences.LogicalXor) _
		  )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D61746368657320616E79206F66207468652073706563696669656420747970657320697420697320636F6E73756D656420616E64207468652066756E6374696F6E2072657475726E7320547275652E204F7468657277697365206974206A7573742072657475726E732046616C73652E
		Function Match(ParamArray types As ObjoScript.TokenTypes) As Boolean
		  /// If the current token matches any of the specified types it is consumed and 
		  /// the function returns True. Otherwise it just returns False.
		  
		  If Check(types) Then
		    Advance
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MethodDeclaration(className As String) As ObjoScript.MethodDeclStmt
		  /// Parses a class method declaration.
		  ///
		  /// There are two types of methods: regular and setters.
		  /// Regular methods may or may not return values and can accept any number of arguments.
		  /// Setters do not return a value and must have one argument. Format:
		  /// ```
		  /// age=(value){} // Note the `=` to denote it's a setter.
		  /// ```
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier)
		  
		  // Setter?
		  Var isSetter As Boolean = Match(ObjoScript.TokenTypes.Equal)
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the method's name.")
		  
		  // Optional parameters.
		  Var params() As ObjoScript.Token
		  If Not Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      params.Add(Consume(ObjoScript.TokenTypes.Identifier, "Expected parameter name."))
		    Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  // Setters must have exactly one parameter.
		  If isSetter And params.Count <> 1 Then
		    Error("Setters must have exactly one parameter.", identifier)
		  End If
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after method parameters.")
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after method parameters.")
		  
		  Var body As ObjoScript.BlockStmt = ObjoScript.BlockStmt(Block)
		  
		  Return New MethodDeclStmt(className, identifier, isSetter, params, body)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F72206372656174696E672061206E6577204772616D6D617252756C652077697468206120736C696768746C792073686F727465722073796E7461782E
		Private Function NewRule(prefix As ObjoScript.PrefixParselet, infix As ObjoScript.InfixParselet, precedence As Integer) As ObjoScript.GrammarRule
		  /// Convenience method for creating a new GrammarRule with a slightly shorter syntax.
		  
		  Return New ObjoScript.GrammarRule(prefix, infix, precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120756E61727920616E642062696E617279206F70657261746F722E
		Private Function Operator(rightAssociative As Boolean = False, precedence As Integer = ObjoScript.Precedences.Term) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a unary and binary operator.
		  
		  Return New ObjoScript.GrammarRule(New UnaryParselet, New BinaryParselet(precedence, rightAssociative), precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50757473207468652070617273657220696E746F2070616E6963206D6F64652E
		Private Sub Panic(e As ObjoScript.ParserException)
		  /// Puts the parser into panic mode. 
		  ///
		  /// We try to put the parser back into a usable state once it has encountered an error.
		  /// This allows the parser to keep parsing even though an error has occurred without causing 
		  /// all subsequent code to be misinterpreted.
		  ///
		  /// `e` contains details of the error that triggered panic mode.
		  
		  // Add this error to our array of errors.
		  Errors.AddRow(e)
		  
		  // Try to recover.
		  Synchronise
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E206172726179206F6620746F6B656E7320696E746F20616E2061627374726163742073796E74617820747265652E
		Function Parse(tokens() As ObjoScript.Token) As ObjoScript.Stmt()
		  /// Parses an array of tokens into an abstract syntax tree.
		  
		  Reset
		  
		  // Keep a reference to the passed in array of tokens.
		  mTokens = tokens
		  
		  // Prime the pump.
		  Advance
		  
		  While Not AtEnd
		    Try
		      mAST.Add(Declaration)
		    Catch e As ObjoScript.ParserException
		      Panic(e)
		    End Try
		  Wend
		  
		  Return mAST
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E642072657475726E7320616E2065787072657373696F6E2061742074686520676976656E20707265636564656E6365206C6576656C206F72206869676865722E
		Function ParsePrecedence(precedence As Integer) As ObjoScript.Expr
		  /// Parses and returns an expression at the given precedence level or higher.
		  ///
		  /// This is the main entry point for the top-down operator precedence parser.
		  
		  Advance
		  
		  // The prefix token will be the previously consumed one.
		  Var rule As ObjoScript.GrammarRule = GetRule(Previous.Type)
		  
		  Var prefix As ObjoScript.PrefixParselet = rule.Prefix
		  If prefix  = Nil Then
		    Error("Expected an expression. Instead got `" + Current.Type.ToString + "`.")
		  End If
		  
		  // Track if the precedence of the surrounding expression is low enough to
		  // allow an assignment inside this one. We can't parse an assignment like
		  // a normal expression because it requires us to handle the LHS specially
		  // (it needs to be an lvalue, not an rvalue). 
		  // So, for each of the kinds of expressions that are valid 
		  /// lvalues (e.g. names, subscripts, fields, etc) we pass in whether or not 
		  // it appears in a context loose enough to allow "=". 
		  // If so, it will parse the "=" itself and handle it appropriately.
		  Var canAssign As Boolean = precedence <= Precedences.Conditional
		  
		  Var left As ObjoScript.Expr = prefix.Parse(Self, canAssign)
		  
		  While precedence < GetRule(Current.Type).Precedence
		    Advance
		    Var infix As ObjoScript.InfixParselet = GetRule(Previous.Type).Infix
		    left = infix.Parse(Self, left, canAssign)
		  Wend
		  
		  If canAssign And Match(ObjoScript.TokenTypes.Equal) Then
		    Error("Invalid assigment token.")
		  End If
		  
		  Return left
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120706F7374666978206F70657261746F722E
		Private Function Postfix() As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a postfix operator.
		  
		  Return New ObjoScript.GrammarRule(Nil, New ObjoScript.PostfixParselet, ObjoScript.Precedences.Postfix)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120707265666978206F70657261746F722E
		Private Function Prefix(prefixParselet As ObjoScript.PrefixParselet, precedence As Integer = ObjoScript.Precedences.None) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a prefix operator.
		  
		  Return New ObjoScript.GrammarRule(prefixParselet, Nil, precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061207072696E742073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D65642074686520607072696E7460206B6579776F72642E
		Private Function PrintStatement() As ObjoScript.Stmt
		  /// Parses a print statement. Assumes the parser has just consumed the `print` keyword.
		  ///
		  /// Format:
		  /// ```objo
		  /// print(EXPRESSION)
		  /// ```
		  
		  // Store the location of the print keyword.
		  Var location As ObjoScript.Token = Previous
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the `print` keyword.")
		  
		  Var expr As ObjoScript.Expr = Expression
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after the print expression.")
		  
		  ConsumeNewLine("Expected a new line EOL after the print statement.")
		  
		  Return New ObjoScript.PrintStmt(expr, location)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657365747320746865207061727365722C20726561647920746F20706172736520616761696E2E
		Private Sub Reset()
		  /// Resets the parser, ready to parse again.
		  
		  mAST.ResizeTo(-1)
		  Previous = Nil
		  Current = Nil
		  mCurrentIndex = -1
		  Errors.ResizeTo(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061206072657475726E602073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206072657475726E60206B6579776F72642E
		Private Function ReturnStatement() As ObjoScript.Stmt
		  /// Parses a `return` statement.
		  /// Assumes the parser has just consumed the `return` keyword.
		  
		  Var returnKeyword As ObjoScript.Token = Previous
		  
		  Var returnValue As ObjoScript.Expr
		  If Match(ObjoScript.TokenTypes.EOL, ObjoScript.TokenTypes.EOF) Then
		    returnValue = New ObjoScript.NothingLiteral(returnKeyword)
		  Else
		    returnValue = Expression
		    If Not Check(ObjoScript.TokenTypes.RParen) Then
		      ConsumeNewLine("Expected a new line or closing brace after the return statement value.")
		    End If
		  End If
		  
		  Return New ReturnStmt(returnKeyword, returnValue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612073746174656D656E742E
		Private Function Statement() As ObjoScript.Stmt
		  /// Parses a statement.
		  
		  If Match(ObjoScript.TokenTypes.LCurly) Then
		    Return Block
		    
		  ElseIf Match(ObjoScript.TokenTypes.If_) Then
		    Return IfStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.While_) Then
		    Return WhileStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.For_) Then
		    Return ForStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.ForEach) Then
		    Return ForEachStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Print) Then
		    Return PrintStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Assert) Then
		    Return AssertStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Exit_) Then
		    Return ExitStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Continue_) Then
		    Return ContinueStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Return_) Then
		    Return ReturnStatement
		    
		  Else
		    Return ExpressionStatement
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E207468652070617273657220656E746572732070616E6963206D6F64652E20547269657320746F206765742074686520706172736572206261636B20746F20612073746174652077686572652069742063616E20636F6E74696E75652070617273696E672E
		Private Sub Synchronise()
		  /// Called when the parser enters panic mode.
		  /// Tries to get the parser back to a state where it can continue parsing.
		  ///
		  /// We do this by discarding tokens until we hit a statement boundary.
		  
		  Advance
		  
		  While Not AtEnd
		    If Previous.Type = ObjoScript.TokenTypes.EOL Then
		      Return
		    End If
		    
		    Select Case Current.Type
		    Case ObjoScript.TokenTypes.Assert, ObjoScript.TokenTypes.Breakpoint, _
		      ObjoScript.TokenTypes.Class_, ObjoScript.TokenTypes.Continue_, _
		      ObjoScript.TokenTypes.Else_, ObjoScript.TokenTypes.Exit_, _
		      ObjoScript.TokenTypes.Export, ObjoScript.TokenTypes.Foreign, _
		      ObjoScript.TokenTypes.For_, ObjoScript.TokenTypes.Function_, _
		      ObjoScript.TokenTypes.If_, ObjoScript.TokenTypes.Import, _
		      ObjoScript.TokenTypes.Print, ObjoScript.TokenTypes.Return_, _
		      ObjoScript.TokenTypes.Static_, ObjoScript.TokenTypes.Var_, _
		      ObjoScript.TokenTypes.While_
		      // This token is the start of a statement. Hopefully we're synchronised now.
		      Return
		    End Select
		    
		    Advance
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577204772616D6D617252756C65207468617420697320756E757365642E
		Private Function Unused() As ObjoScript.GrammarRule
		  /// Convenience method for returning a new GrammarRule that is unused.
		  
		  Return New GrammarRule(Nil, Nil, Precedences.None)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061207661726961626C65206465636C61726174696F6E2E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206076617260206B6579776F72642E20607465726D696E61746F72602077696C6C20626520636F6E73756D65642E
		Private Function VarDeclaration(terminator As ObjoScript.TokenTypes = ObjoScript.TokenTypes.EOL) As ObjoScript.Stmt
		  /// Parses a variable declaration. Assumes the parser has just consumed the `var` keyword.
		  /// `terminator` will be consumed.
		  ///
		  /// Format:
		  /// ```objo
		  /// VAR IDENTIFIER (EQUAL expression)?
		  /// ```
		  /// 
		  /// If an initialiser expression is not provided then the variable is initialised to Nothing.
		  /// `terminator` is the token that is required to occur after the declaration to be valid.
		  
		  // Store the location of the var keyword.
		  Var varLocation As ObjoScript.Token = Previous
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier, "Expected a variable name.")
		  
		  Var initialiser As ObjoScript.Expr = New ObjoScript.NothingLiteral(varLocation)
		  If Match(ObjoScript.TokenTypes.Equal) Then
		    initialiser = Expression
		  End If
		  
		  // Most variable declarations expect a new line after them but some (such as within a
		  // `for` loop initialiser) require something else (e.g. a semicolon).
		  If terminator = ObjoScript.TokenTypes.EOL Or terminator = ObjoScript.TokenTypes.EOF Then
		    ConsumeNewLine("Expected a new line or EOF after a variable declaration.")
		  Else
		    Consume(terminator, "Expected a " + terminator.ToString + " after the variable declaration.")
		  End If
		  
		  Return New VarDeclStmt(identifier, initialiser, varLocation)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506172736573206120607768696C65602073746174656D656E742E20417373756D65732074686520607768696C656020746F6B656E20686173206A757374206265656E20636F6E73756D65642E
		Private Function WhileStatement() As ObjoScript.Stmt
		  /// Parses a `while` statement.
		  /// Assumes the `while` token has just been consumed.
		  
		  Var whileKeyword As ObjoScript.Token = Previous
		  
		  Var condition As ObjoScript.Expr = Expression
		  
		  // Optional new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Body.
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the `while` condition.")
		  Var body As ObjoScript.Stmt = Block
		  
		  Return New ObjoScript.WhileStmt(condition, body, whileKeyword)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Precedences Enum Notes
		Lower precedence = low "binding power"
		The ordering of the enums is CRUCIAL. Xojo automatically assigns increasing values to enums from top to bottom.
		
		None         :
		Assignment   : =
		Lowest       :
		Assignment   : =
		Conditional  : ?:
		LogicalOr    : or
		LogicalAnd   : and
		Equality     : == <>
		Is           : is
		Comparison   : < > <= >=
		BitwiseOr    : |
		BitwiseXor   : ^
		BitwiseAnd   : &
		BitwiseShift : << >>
		Range        : .. ...
		Term         : + -
		Factor       : * / %
		Unary        : - not ~ ++
		Call         : . () []
		Primary      :
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520746F6B656E2063757272656E746C79206265696E67206576616C75617465642E
		Current As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 416E79206572726F72732074686174206D61792068617665206F6363757272656420647572696E67207468652070617273696E672070726F636573732E
		Errors() As ObjoScript.ParserException
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686572652061726520616E7920706172736572206572726F72732E204966207468657265206172652C2074686579206172652073746F7265642077697468696E20605061727365722E4572726F7273602E
		#tag Getter
			Get
			  Return Errors.Count > 0
			End Get
		#tag EndGetter
		HasError As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652061627374726163742073796E7461782074726565206265696E6720636F6E737472756374656420627920746865207061727365722E
		Private mAST() As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E64657820696E20606D546F6B656E7360206F662074686520746F6B656E2063757272656E746C79206265696E672070726F6365737365642E
		Private mCurrentIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436F6E7461696E7320746865206772616D6D61722072756C657320666F7220746865207061727365722E204B6579203D204F626A6F5363726970742E546F6B656E54797065732C2056616C7565203D204F626A6F5363726970742E4772616D6D617252756C652E
		Private mRules As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206172726179206F6620746F6B656E7320746861742074686973207061727365722077696C6C2070726F636573732E
		Private mTokens() As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070726576696F75736C79206576616C756174656420746F6B656E202877696C6C206265204E696C207768656E207468652070617273657220626567696E73292E
		Previous As ObjoScript.Token
	#tag EndProperty


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
			Name="HasError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
