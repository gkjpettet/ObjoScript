#tag Class
Protected Class Parser
	#tag Method, Flags = &h21, Description = 416476616E63657320746F20746865206E65787420746F6B656E2C2073746F72696E672061207265666572656E636520746F207468652070726576696F757320746F6B656E2E
		Private Sub Advance()
		  /// Advances to the next token, storing a reference to the previous token.
		  
		  #Pragma BreakOnExceptions False
		  
		  Previous = Current
		  mCurrentIndex = mCurrentIndex + 1
		  Current = mTokens(mCurrentIndex)
		  
		  Exception e As OutOfBoundsException
		    Error("Unexpected end of file.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416476616E63657320746F20746865206E65787420746F6B656E2C2073746F72696E6720616E642072657475726E696E67207265666572656E636520746F207468652070726576696F757320746F6B656E2E
		Private Function Advance() As ObjoScript.Token
		  /// Advances to the next token, storing and returning reference to the previous token.
		  
		  #Pragma BreakOnExceptions False
		  
		  Previous = Current
		  mCurrentIndex = mCurrentIndex + 1
		  Current = mTokens(mCurrentIndex)
		  Return Previous
		  
		  Exception e As OutOfBoundsException
		    Error("Unexpected end of file.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E206173736572742073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206061737365727460206B6579776F72642E
		Private Function AssertStatement() As ObjoScript.Stmt
		  /// Parses an assert statement. Assumes the parser has just consumed the `assert` keyword.
		  ///
		  /// Format:
		  /// ```objo
		  /// assert(condition, message)
		  /// ```
		  
		  // Store the location of the assert keyword.
		  Var location As ObjoScript.Token = Previous
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the `assert` keyword.")
		  
		  Var condition As ObjoScript.Expr = Expression
		  
		  Consume(ObjoScript.TokenTypes.Comma, "Expected a comma after the condition.")
		  
		  Var message As ObjoScript.Expr = Expression
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after the assert message.")
		  
		  ConsumeNewLine("Expected a new line EOL after the assert statement.")
		  
		  Return New ObjoScript.AssertStmt(condition, message, location)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620776527766520726561636865642074686520656E64206F662074686520746F6B656E2073747265616D2E
		Private Function AtEnd() As Boolean
		  /// True if we've reached the end of the token stream.
		  
		  Return mCurrentIndex > mTokens.LastIndex Or Current.Type = ObjoScript.TokenTypes.EOF
		  
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

	#tag Method, Flags = &h21, Description = 50617273657320612060627265616B706F696E74602073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652060627265616B706F696E7460206B6579776F72642E
		Private Function BreakpointStatement() As ObjoScript.Stmt
		  /// Parses a `breakpoint` statement.
		  /// Assumes the parser has just consumed the `breakpoint` keyword.
		  
		  Var keyword As ObjoScript.Token = Previous
		  
		  ConsumeNewLine("Expected a newline after the `breakpoint` statement.")
		  
		  Return New BreakpointStmt(keyword)
		  
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
		Private Function ClassDeclaration(isForeign As Boolean) As ObjoScript.Stmt
		  /// Parses a class declaration statement.
		  /// Assumes the parser has just consumed the `class` keyword token.
		  
		  Var classKeyword As ObjoScript.Token = Previous
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.UppercaseIdentifier, _
		  "Expected a class name beginning with an uppercase letter.")
		  
		  Var className As String = identifier.Lexeme
		  
		  // Optional superclass.
		  Var superClass As String = ""
		  If Match(ObjoScript.TokenTypes.Is_) Then
		    // Edge case: Attempting to inherit from a built-in type.
		    If Current.Lexeme.ExactlyMatches(ObjoTypes) Then
		      Error("Classes cannot inherit from built-in types.")
		    End If
		    superClass = Consume(ObjoScript.TokenTypes.UppercaseIdentifier, _
		    "Expected a superclass name. Superclasses must begin with an uppercase letter.").Lexeme
		  End If
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the class name.")
		  
		  // Optional new line.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Optional constructors and methods.
		  Var methods As Dictionary = ParseJSON("{}") // HACK: Case sensitive dictonary.
		  Var staticMethods As Dictionary = ParseJSON("{}") // HACK: Case sensitive dictonary.
		  Var foreignInstance As Dictionary = ParseJSON("{}") // HACK: Case sensitive dictonary.
		  Var foreignStatic As Dictionary = ParseJSON("{}") // HACK: Case sensitive dictonary.
		  Var constructors(), cdecl As ObjoScript.ConstructorDeclStmt
		  Var constructorArities As New Dictionary // Key = arity: Value = Nil
		  While Not Check(ObjoScript.TokenTypes.RCurly, ObjoScript.TokenTypes.EOF)
		    // -----------
		    // CONSTRUCTOR
		    // -----------
		    If Match(ObjoScript.TokenTypes.Constructor) Then
		      cdecl = ConstructorDeclaration(className)
		      If constructorArities.HasKey(cdecl.Arity) Then
		        Var s As String = If(cdecl.Arity = 1, "a single parameter", cdecl.Arity.ToString + " parameters")
		        Error("A constructor with " + s + " has already been declared.")
		      Else
		        constructors.Add(cdecl)
		      End If
		      
		    ElseIf Match(ObjoScript.TokenTypes.Foreign) Then
		      // -----------------------------------
		      // FOREIGN METHOD (INSTANCE OR STATIC)
		      // -----------------------------------
		      Var f As ObjoScript.ForeignMethodDeclStmt
		      If Match(ObjoScript.TokenTypes.Static_) Then
		        f = ForeignMethodDeclaration(className, True)
		        If staticMethods.HasKey(f.Signature) Or foreignStatic.HasKey(f.Signature) Then
		          Error("Duplicate method definition: " + f.Signature, f.Location)
		        Else
		          foreignStatic.Value(f.Signature) = f
		        End If
		      Else
		        f = ForeignMethodDeclaration(className, False)
		        If methods.HasKey(f.Signature) Or foreignInstance.HasKey(f.Signature) Then
		          Error("Duplicate method definition: " + f.Signature, f.Location)
		        Else
		          foreignInstance.Value(f.Signature) = f
		        End If
		      End If
		      
		    ElseIf Match(ObjoScript.TokenTypes.Static_) Then
		      // --------------------
		      // NATIVE STATIC METHOD
		      // --------------------
		      Var sm As ObjoScript.MethodDeclStmt = MethodDeclaration(className, True)
		      
		      If staticMethods.HasKey(sm.Signature) Then
		        Error("Duplicate method definition: " + sm.Signature, sm.Location)
		      End If
		      If foreignInstance.HasKey(sm.Signature) And ObjoScript.ForeignMethodDeclStmt(foreignInstance.Value(sm.Signature)).IsStatic Then
		        Error("Duplicate method definition: " + sm.Signature, sm.Location)
		      End If
		      
		      staticMethods.Value(sm.Signature) = sm
		      
		    Else
		      Var m As ObjoScript.MethodDeclStmt = MethodDeclaration(className, False)
		      
		      If methods.HasKey(m.Signature) Then
		        // ----------------------
		        // NATIVE INSTANCE METHOD
		        // ----------------------
		        Error("Duplicate method definition: " + m.Signature, m.Location)
		      End If
		      If foreignInstance.HasKey(m.Signature) And Not ObjoScript.ForeignMethodDeclStmt(foreignInstance.Value(m.Signature)).IsStatic Then
		        Error("Duplicate method definition: " + m.Signature, m.Location)
		      End If
		      methods.Value(m.Signature) = m
		      
		    End If
		    
		    // Optional new line.
		    Call Match(ObjoScript.TokenTypes.EOL)
		  Wend
		  
		  Consume(ObjoScript.TokenTypes.RCurly, "Expected a `}` after the class body.")
		  
		  Return New ObjoScript.ClassDeclStmt(superClass, identifier, constructors, staticMethods, methods, foreignInstance, foreignStatic, classKeyword, isForeign)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  InitialiseGrammar
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506172736573206120636C61737320636F6E7374727563746F72206465636C61726174696F6E2E
		Private Function ConstructorDeclaration(className As String) As ObjoScript.ConstructorDeclStmt
		  /// Parses a class constructor declaration.
		  ///
		  /// Assumes the parser has just consumed the `constructor` keyword.
		  /// ```
		  /// constructor(params){}
		  /// ```
		  
		  Var keyword As ObjoScript.Token = Previous
		  
		  Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the `constructor` keyword.")
		  
		  // Optional parameters.
		  Var params() As ObjoScript.Token
		  If Not Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      params.Add(Consume(ObjoScript.TokenTypes.Identifier, "Expected parameter name."))
		    Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after the constructor's parameters.")
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the constructor's parameters.")
		  
		  Var body As ObjoScript.BlockStmt = ObjoScript.BlockStmt(Block)
		  
		  Return New ConstructorDeclStmt(className, params, body, keyword)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D6174636865732060657870656374656460207468656E206974277320636F6E73756D65642E204966206E6F742C20776520726169736520616E20657863657074696F6E207769746820606D657373616765602E
		Sub Consume(expected As ObjoScript.TokenTypes, message As String = "")
		  /// If the current token matches `expected` then it's consumed.
		  /// If not, we raise an exception with `message`.
		  
		  #Pragma BreakOnExceptions False
		  
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
		  
		  #Pragma BreakOnExceptions False
		  
		  If Current.Type <> expected Then
		    message = If(message = "", "Expected " + expected.ToString + " but got " + Current.Type.ToString + " instead.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		    Return Previous
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D61746368657320616E79206F662074686520746F6B656E7320696E20606578706563746564282960207468656E206974277320636F6E73756D656420616E642072657475726E65642E204966206E6F742C20776520726169736520616E20657863657074696F6E207769746820606D657373616765602E
		Function Consume(message As String, ParamArray expected() As ObjoScript.TokenTypes) As ObjoScript.Token
		  /// If the current token matches any of the tokens in `expected()` then it's consumed and returned.
		  /// If not, we raise an exception with `message`.
		  
		  #Pragma BreakOnExceptions False
		  
		  For Each type As ObjoScript.TokenTypes In expected
		    If Current.Type = type Then
		      Advance
		      Return Previous
		    End If
		  Next type
		  
		  Raise New ObjoScript.ParserException(message, Current)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417373657274732074686174207468652063757272656E7420746F6B656E20697320616E20454F4C2E20496620736F20697420697320636F6E73756D65642E204F746865727769736520616E206572726F72207769746820746865206F7074696F6E616C20606D6573736167656020697320637265617465642E
		Private Sub ConsumeNewLine(message As String = "")
		  /// Asserts that the current token is an EOL. If so it is consumed. 
		  /// Otherwise an error with the optional `message` is created.
		  
		  #Pragma BreakOnExceptions False
		  
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
		    Return ClassDeclaration(False)
		    
		  ElseIf Match(ObjoScript.TokenTypes.Foreign) Then
		    Consume(ObjoScript.TokenTypes.Class_, "Expected `class` after the `foreign` keyword.")
		    Return ClassDeclaration(True)
		    
		  Else
		    Return Statement
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526169736573206120506172736572457863657074696F6E206174207468652063757272656E74206C6F636174696F6E2E20496620746865206572726F72206973206E6F74206174207468652063757272656E74206C6F636174696F6E2C20606C6F636174696F6E60206D61792062652070617373656420696E73746561642E
		Sub Error(message As String, location As ObjoScript.Token = Nil)
		  /// Raises a ParserException at the current location. If the error is not at the current location,
		  /// `location` may be passed instead.
		  
		  #Pragma BreakOnExceptions False
		  
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
		  /// foreach i in RANGE {
		  ///  statements
		  /// }
		  /// ```
		  
		  Var foreachKeyword As ObjoScript.Token = Previous
		  
		  Var loopCounter As ObjoScript.Token = _
		  Consume(ObjoScript.TokenTypes.Identifier, "Expected a name for the loop counter after `foreach`.")
		  
		  Consume(ObjoScript.TokenTypes.In_, "Expected the `in` keyword after the loop counter name.")
		  
		  Var rangeExpr As ObjoScript.Expr = Expression
		  
		  // Optional newline.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Expect a block.
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the range expression.")
		  Var body As ObjoScript.Stmt = Block()
		  
		  Return New ForEachStmt(foreachKeyword, loopCounter, rangeExpr, body)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506172736573206120666F726569676E20636C617373206D6574686F64206465636C61726174696F6E2028696E7374616E6365206F7220737461746963292E
		Private Function ForeignMethodDeclaration(className As String, isStatic As Boolean) As ObjoScript.ForeignMethodDeclStmt
		  /// Parses a foreign class method declaration (instance or static).
		  ///
		  /// Like native Wren methods, there are two types of foreign methods: regular and setters.
		  /// Regular methods may or may not return values and can accept any number of arguments.
		  /// Setters do not return a value and must have one argument. Format:
		  /// ```
		  /// age=(value){} // Note the `=` to denote it's a setter.
		  /// ```
		  /// If `isStatic` is True then this is a static method declaration.
		  
		  // Handle operators differently.
		  If Match(OverloadableOperators) Then
		    Return ObjoScript.ForeignMethodDeclStmt(OverloadedOperator(className, Previous, isStatic, True))
		  End If
		  
		  // Get the identifier
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
		  
		  Consume(ObjoScript.TokenTypes.EOL, "Expected a new line after foreign method declaration.")
		  
		  Return New ForeignMethodDeclStmt(className, identifier, isSetter, isStatic, params)
		  
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
		  Var name As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier, "Expected a function name. They must begin with a lowercase letter.")
		  
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
		  
		  mRules = New Dictionary( _
		  TokenTypes.Ampersand            : BinaryOperator(Precedences.BitwiseAnd), _
		  TokenTypes.And_                 : LogicalOperator(Precedences.LogicalAnd), _
		  TokenTypes.Assert               : Unused, _
		  TokenTypes.As_                  : Unused, _
		  TokenTypes.Boolean_             : Prefix(New LiteralParselet), _
		  TokenTypes.Breakpoint           : Unused, _
		  TokenTypes.Caret                : BinaryOperator(Precedences.BitwiseXor), _
		  TokenTypes.Class_               : Unused, _
		  TokenTypes.Colon                : NewRule(Nil, New KeyValueParselet, Precedences.Range), _
		  TokenTypes.Comma                : Unused, _
		  TokenTypes.Constructor          : Unused, _
		  TokenTypes.Continue_            : Unused, _
		  TokenTypes.Dot                  : NewRule(Nil, New DotParselet, Precedences.Call_), _
		  TokenTypes.DotDot               : NewRule(Nil, New RangeParselet, Precedences.Range), _
		  TokenTypes.DotDotDot            : NewRule(Nil, New RangeParselet, Precedences.Range), _
		  TokenTypes.Else_                : Unused, _
		  TokenTypes.EOF                  : Unused, _
		  TokenTypes.EOL                  : Unused, _
		  TokenTypes.Equal                : Unused, _
		  TokenTypes.EqualEqual           : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Exit_                : Unused, _
		  TokenTypes.Export               : Unused, _
		  TokenTypes.FieldIdentifier      : Prefix(New FieldParselet), _
		  TokenTypes.Foreign              : Unused, _
		  TokenTypes.ForwardSlash         : BinaryOperator(Precedences.Factor), _
		  TokenTypes.ForwardSlashEqual    : Unused, _
		  TokenTypes.For_                 : Unused, _
		  TokenTypes.ForEach              : Unused, _
		  TokenTypes.Function_            : Unused, _
		  TokenTypes.Greater              : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterEqual         : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterGreater       : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.Identifier           : Prefix(New VariableParselet), _
		  TokenTypes.If_                  : NewRule(Nil, New ConditionalParselet, Precedences.Assignment), _
		  TokenTypes.Import               : Unused, _
		  TokenTypes.In_                  : Unused, _
		  TokenTypes.Is_                  : NewRule(Nil, New IsParselet, Precedences.Is_), _
		  TokenTypes.LCurly               : Prefix(New MapParselet), _
		  TokenTypes.Less                 : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessEqual            : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessLess             : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.LParen               : NewRule(New GroupParselet, New CallParselet, Precedences.Call_), _
		  TokenTypes.LSquare              : NewRule(New ListParselet, New SubscriptParselet, Precedences.Call_), _
		  TokenTypes.Minus                : Operator, _
		  TokenTypes.MinusMinus           : Postfix, _
		  TokenTypes.MinusEqual           : Unused, _
		  TokenTypes.NotEqual             : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Nothing              : Prefix(New LiteralParselet), _
		  TokenTypes.Not_                 : Prefix(New UnaryParselet), _
		  TokenTypes.Number               : Prefix(New LiteralParselet), _
		  TokenTypes.Or_                  : LogicalOperator(Precedences.LogicalOr), _
		  TokenTypes.Percent              : BinaryOperator(Precedences.Factor), _
		  TokenTypes.Pipe                 : BinaryOperator(Precedences.BitwiseOr), _
		  TokenTypes.Plus                 : BinaryOperator(Precedences.Term), _
		  TokenTypes.PlusEqual            : Unused, _
		  TokenTypes.PlusPlus             : Postfix, _
		  TokenTypes.Query                : Unused, _
		  TokenTypes.RCurly               : Unused, _
		  TokenTypes.Return_              : Unused, _
		  TokenTypes.RParen               : Unused, _
		  TokenTypes.RSquare              : Unused, _
		  TokenTypes.Semicolon            : Unused, _
		  TokenTypes.Star                 : BinaryOperator(Precedences.Factor), _
		  TokenTypes.StarEqual            : Unused, _
		  TokenTypes.Static_              : Unused, _
		  TokenTypes.StaticFieldIdentifier: Prefix(New FieldParselet), _
		  TokenTypes.String_              : Prefix(New LiteralParselet), _
		  TokenTypes.Super_               : Prefix(New SuperParselet), _
		  TokenTypes.Then_                : Unused, _
		  TokenTypes.This                 : Prefix(New ThisParselet), _
		  TokenTypes.Tilde                : NewRule(New UnaryParselet, Nil, Precedences.None), _
		  TokenTypes.Underscore           : Unused, _
		  TokenTypes.UppercaseIdentifier : Prefix(New ClassParselet), _
		  TokenTypes.Var_                 : Unused, _
		  TokenTypes.While_               : Unused, _
		  TokenTypes.Xor_                 : LogicalOperator(Precedences.LogicalXor) _
		  )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F722061206C6F676963616C206F70657261746F722E
		Private Function LogicalOperator(precedence As Integer) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a logical operator.
		  
		  Return New ObjoScript.GrammarRule(Nil, New LogicalParselet(precedence), precedence)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D61746368657320616E79206F66207468652073706563696669656420747970657320697420697320636F6E73756D656420616E64207468652066756E6374696F6E2072657475726E7320547275652E204F7468657277697365206974206A7573742072657475726E732046616C73652E
		Function Match(types() As ObjoScript.TokenTypes) As Boolean
		  /// If the current token matches any of the specified types it is consumed and 
		  /// the function returns True. Otherwise it just returns False.
		  
		  If Check(types) Then
		    Advance
		    Return True
		  End If
		  
		  Return False
		  
		End Function
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

	#tag Method, Flags = &h21, Description = 506172736573206120636C617373206D6574686F64206465636C61726174696F6E2028696E7374616E6365206F7220737461746963292E
		Private Function MethodDeclaration(className As String, isStatic As Boolean) As ObjoScript.MethodDeclStmt
		  /// Parses a class method declaration (instance or static).
		  ///
		  /// There are two types of methods: regular and setters.
		  /// Regular methods may or may not return values and can accept any number of arguments.
		  /// Setters do not return a value and must have one argument. Format:
		  /// ```
		  /// age=(value){} // Note the `=` to denote it's a setter.
		  /// ```
		  /// If `isStatic` is True then this is a static method declaration.
		  
		  // Handle operators differently.
		  If Match(OverloadableOperators) Then
		    Return ObjoScript.MethodDeclStmt(OverloadedOperator(className, Previous, isStatic, False))
		  End If
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier)
		  
		  // Setter?
		  Var isSetter As Boolean = Match(ObjoScript.TokenTypes.Equal)
		  
		  // Optional parameters.
		  Var params() As ObjoScript.Token
		  Var hasParens As Boolean = False
		  If Match(ObjoScript.TokenTypes.LParen) Then
		    hasParens = True
		    
		    If Not Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        params.Add(Consume(ObjoScript.TokenTypes.Identifier, "Expected parameter name."))
		      Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		    End If
		  End If
		  
		  // Setters must have exactly one parameter.
		  If isSetter And params.Count <> 1 Then
		    Error("Setters must have exactly one parameter.", identifier)
		  End If
		  
		  If hasParens Then
		    Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after method parameters.")
		  End If
		  
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after method parameters.")
		  
		  Var body As ObjoScript.BlockStmt = ObjoScript.BlockStmt(Block)
		  
		  Return New MethodDeclStmt(className, identifier, isSetter, isStatic, params, body)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F72206372656174696E672061206E6577204772616D6D617252756C652077697468206120736C696768746C792073686F727465722073796E7461782E
		Private Function NewRule(prefix As ObjoScript.PrefixParselet, infix As ObjoScript.InfixParselet, precedence As Integer) As ObjoScript.GrammarRule
		  /// Convenience method for creating a new GrammarRule with a slightly shorter syntax.
		  
		  Return New ObjoScript.GrammarRule(prefix, infix, precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320616E206172726179206F66204F626A6F2773206275696C742D696E20747970657320746861742063616E6E6F7420626520696E686572697465642066726F6D2E
		Private Shared Function ObjoTypes() As String()
		  /// Returns an array of Objo's built-in types that cannot be inherited from.
		  
		  Static types() As String = Array( _
		  "Boolean", _
		  "List", _
		  "Map", _
		  "Nothing", _
		  "Number", _
		  "String", _
		  "System" _
		  )
		  
		  Return types
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120756E61727920616E642062696E617279206F70657261746F722E
		Private Function Operator(rightAssociative As Boolean = False, precedence As Integer = ObjoScript.Precedences.Term) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a unary and binary operator.
		  
		  Return New ObjoScript.GrammarRule(New UnaryParselet, New BinaryParselet(precedence, rightAssociative), precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320616E206172726179206F6620746865206F70657261746F72732074686174206D6179206265206F7665726C6F616465642E
		Shared Function OverloadableOperators() As ObjoScript.TokenTypes()
		  /// Returns an array of the operators that may be overloaded.
		  
		  Static operators() As ObjoScript.TokenTypes = Array( _
		  ObjoScript.TokenTypes.Ampersand, _
		  ObjoScript.TokenTypes.DotDot, _
		  ObjoScript.TokenTypes.DotDotDot, _
		  ObjoScript.TokenTypes.EqualEqual, _
		  ObjoScript.TokenTypes.ForwardSlash, _
		  ObjoScript.TokenTypes.Greater, _
		  ObjoScript.TokenTypes.GreaterEqual, _
		  ObjoScript.TokenTypes.GreaterGreater, _
		  ObjoScript.TokenTypes.Is_, _
		  ObjoScript.TokenTypes.Less, _
		  ObjoScript.TokenTypes.LessEqual, _
		  ObjoScript.TokenTypes.LessLess, _
		  ObjoScript.TokenTypes.LSquare, _
		  ObjoScript.TokenTypes.Minus, _
		  ObjoScript.TokenTypes.NotEqual, _
		  ObjoScript.TokenTypes.Percent, _
		  ObjoScript.TokenTypes.Pipe, _
		  ObjoScript.TokenTypes.Not_, _
		  ObjoScript.TokenTypes.Plus, _
		  ObjoScript.TokenTypes.Star, _
		  ObjoScript.TokenTypes.Tilde _
		  )
		  
		  Return operators
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060747970656020697320616E206F7665726C6F616461626C6520756E617279206F70657261746F7220747970652E
		Private Function OverloadableUnaryOperator(type As ObjoScript.TokenTypes) As Boolean
		  /// Returns True if `type` is an overloadable unary operator type.
		  
		  Select Case type
		  Case ObjoScript.TokenTypes.Minus, ObjoScript.TokenTypes.Not_, ObjoScript.TokenTypes.Tilde
		    Return True
		    
		  Else
		    Return False
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E206F7665726C6F6164656420606F70657261746F72602E2052657475726E73206569746865722061204D6574686F644465636C53746D74206F72206120466F726569676E4D6574686F644465636C53746D742E
		Private Function OverloadedOperator(className As String, operator As ObjoScript.Token, isStatic As Boolean, isForeign As Boolean) As ObjoScript.Stmt
		  /// Parses an overloaded `operator`. Returns either a MethodDeclStmt or a ForeignMethodDeclStmt.
		  ///
		  /// Assumes `operator` is an overloadable operator.
		  /// Assumes the last consumed token is the operator to overload.
		  /// Examples:
		  /// ```
		  /// -() {body} // prefix (i.e. unary) `-`
		  /// +(a) {body} // infix `+`
		  /// [a] {body} // single index subscript getter
		  /// [a, b] {body} // multi-index subscript getter
		  /// [a]=(value) // single index subscript setter
		  /// [a, b]=(value) // single index subscript setter
		  /// ```
		  /// Note: foreign methods do not have a body.
		  
		  // Every declaration needs an opening parenthesis after the operator *except* subscripts.
		  If operator.Type <> ObjoScript.TokenTypes.LSquare Then
		    Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after the overloaded operator.")
		  End If
		  
		  // Parameter(s).
		  Var params() As ObjoScript.Token
		  If Not Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      params.Add(Consume(ObjoScript.TokenTypes.Identifier, "Expected parameter name."))
		    Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  // Closer after parameter/index(es).
		  If operator.Type = ObjoScript.TokenTypes.LSquare Then
		    Consume(ObjoScript.TokenTypes.RSquare, "Expected a closing square bracket after indices.")
		  Else
		    Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after method parameters.")
		  End If
		  
		  // Subscript setter?
		  // The value to assign becomes the last parameter.
		  Var isSetter As Boolean = False
		  If Match(ObjoScript.TokenTypes.Equal) Then
		    // Must have at least one parameter already.
		    If params.Count = 0 Then
		      Error("Subscript setters require at least one index after the `[`.")
		    End If
		    If operator.Type = ObjoScript.TokenTypes.LSquare Then
		      isSetter = True
		      Consume(ObjoScript.TokenTypes.LParen, "Expected an opening parenthesis after `=`.")
		      params.Add(Consume(ObjoScript.TokenTypes.Identifier))
		      Consume(ObjoScript.TokenTypes.RParen, "Expected a closing parenthesis after the value to assign to overloaded subscript setter.")
		    Else
		      Error("Unexpected `=` token. Only overloaded subscript operators may be setters.")
		    End If
		  End If
		  
		  // Check the correct number of parameters have been specified.
		  If params.Count = 0 Then
		    // Only overloadable unary operators may have zero parameters.
		    If Not OverloadableUnaryOperator(operator.Type) Then
		      Error("`" + operator.Type.ToString + "` is not an overloadable unary operator.")
		    End If
		  ElseIf params.Count > 1 And operator.Type <> ObjoScript.TokenTypes.LSquare Then
		    // Only subscripts can have more than one parameter.
		    Error("Only subscript methods may have more than one parameter.")
		  End If
		  
		  If isForeign Then
		    // Foreign methods don't have a body so we're done.
		    Return New ForeignMethodDeclStmt(className, operator, isSetter, isStatic, params)
		  Else
		    // Consume the method's body.
		    Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after method parameters.")
		    Var body As ObjoScript.BlockStmt = ObjoScript.BlockStmt(Block)
		    Return New MethodDeclStmt(className, operator, isSetter, isStatic, params, body)
		  End If
		  
		  
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
		  Errors.Add(e)
		  
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
		      // Superfluous EOL?
		      Call Match(ObjoScript.TokenTypes.EOL)
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
		    Error("Invalid assignment target.")
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
		    If Not Check(ObjoScript.TokenTypes.RParen, ObjoScript.TokenTypes.RCurly) Then
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
		    
		  ElseIf Match(ObjoScript.TokenTypes.Assert) Then
		    Return AssertStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Exit_) Then
		    Return ExitStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Continue_) Then
		    Return ContinueStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Return_) Then
		    Return ReturnStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Breakpoint) Then
		    Return BreakpointStatement
		    
		  ElseIf Match(ObjoScript.TokenTypes.Switch) Then
		    Return SwitchStatement
		    
		  Else
		    Return ExpressionStatement
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612060737769746368602073746174656D656E742E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D65642074686520607377697463686020746F6B656E2E
		Private Function SwitchStatement() As ObjoScript.Stmt
		  /// Parses a `switch` statement. Assumes the parser has just consumed the `switch` token.
		  ///
		  /// ```
		  /// switch consider {
		  ///  case value1 {}
		  ///  case value2, value3 {}
		  ///  else {}
		  /// }
		  /// ```
		  
		  Var switchKeyword As ObjoScript.Token = Previous
		  
		  Var consider As ObjoScript.Expr = Expression
		  
		  // Optional newline.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Opening brace.
		  Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the switch expression to consider.")
		  
		  Var cases() As ObjoScript.CaseStmt
		  While Match(ObjoScript.TokenTypes.Case_)
		    Var caseKeyword As ObjoScript.Token = Previous
		    
		    // Get this case's value(s).
		    Var values() As ObjoScript.Expr
		    Do
		      values.Add(Expression)
		    Loop Until Not Match(ObjoScript.TokenTypes.Comma)
		    
		    // Optional newline.
		    Call Match(ObjoScript.TokenTypes.EOL)
		    
		    // Consume the body block.
		    Consume(ObjoScript.TokenTypes.LCurly, "Expected a block after the case's value(s).")
		    Var body As ObjoScript.Stmt = Block
		    
		    // Optional newline.
		    Call Match(ObjoScript.TokenTypes.EOL)
		    
		    cases.Add(New ObjoScript.CaseStmt(values, body, caseKeyword))
		  Wend
		  
		  // Optional `else` case.
		  Var elseCase As ObjoScript.ElseCaseStmt
		  If Match(ObjoScript.TokenTypes.Else_) Then
		    Var elseKeyword As ObjoScript.Token = Previous
		    
		    // Optional newline.
		    Call Match(ObjoScript.TokenTypes.EOL)
		    
		    // Body.
		    Consume(ObjoScript.TokenTypes.LCurly, "Expected a `{` after the `else` keyword.")
		    elseCase = New ObjoScript.ElseCaseStmt(Block, elseKeyword)
		  End If
		  
		  // Optional newline.
		  Call Match(ObjoScript.TokenTypes.EOL)
		  
		  // Closing brace.
		  Consume(ObjoScript.TokenTypes.RCurly, "Expected a `}` after the final switch case.")
		  
		  Return New ObjoScript.SwitchStmt(consider, cases, elseCase, switchKeyword)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E207468652070617273657220656E746572732070616E6963206D6F64652E20547269657320746F206765742074686520706172736572206261636B20746F20612073746174652077686572652069742063616E20636F6E74696E75652070617273696E672E
		Private Sub Synchronise()
		  /// Called when the parser enters panic mode.
		  /// Tries to get the parser back to a state where it can continue parsing.
		  ///
		  /// We do this by discarding tokens until we hit a statement boundary.
		  
		  If AtEnd Then Return
		  
		  Advance
		  
		  While Not AtEnd
		    Select Case Current.Type
		    Case ObjoScript.TokenTypes.Class_, ObjoScript.TokenTypes.Function_
		      // Hopefully we're synchronised now.
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
		  
		  Var identifier As ObjoScript.Token = Consume(ObjoScript.TokenTypes.Identifier, "Expected a variable name. Variable names must be lowercase.")
		  
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
