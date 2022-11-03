#tag Class
Protected Class Lexer
	#tag Method, Flags = &h21, Description = 4372656174657320616E642072657475726E73206120746F6B656E20726570726573656E74696E6720656974686572206120737461746963206F7220696E7374616E6365206669656C64206964656E7469666965722E
		Private Sub AddFieldIdentifier(isStatic As Boolean)
		  /// Creates and adds a token representing either a static or instance field identifier.
		  ///
		  /// Assumes that `mCurrent` points to the character immediately following the last `_` **and** 
		  /// that this character is a letter.
		  /// Field identifiers start with a single underscore, e.g: `_width`.
		  /// Static field identifiers start with two underscores, e.g: `__version`
		  /// Identifiers can contain any combination of letters, underscores or numbers.
		  
		  Var lexeme() As String = Array("_")
		  If isStatic Then lexeme.Add("_")
		  
		  While Peek.IsASCIILetterOrDigitOrUnderscore
		    lexeme.Add(Advance)
		  Wend
		  
		  Var t As ObjoScript.Token
		  If isStatic Then
		    t = MakeToken(ObjoScript.TokenTypes.StaticFieldIdentifier, String.FromArray(lexeme, ""))
		  Else
		    t = MakeToken(ObjoScript.TokenTypes.FieldIdentifier, String.FromArray(lexeme, ""))
		  End If
		  
		  mTokens.Add(t)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417474656D70747320746F2061646420612068657861646563696D616C206C69746572616C20746F6B656E20626567696E6E696E67206174207468652063757272656E7420706F736974696F6E2E2052657475726E732054727565206966207375636365737366756C2E
		Private Function AddHexLiteralToken() As Boolean
		  /// Attempts to add a hex literal token beginning at the current position.
		  /// Returns `True` if successful.
		  ///
		  /// Assumes that `mCurrent` points to the "0" character illustrated below **and** 
		  /// that the next character is definitely a "x":
		  /// ```
		  /// 0xFFA1
		  ///  ^
		  /// ```
		  
		  // Move past the "x" character.
		  Call Advance
		  
		  // We need to see at least one hex character.
		  If Not Peek.IsHexDigit Then
		    // Rewind a character (since we advanced past the "x").
		    mCurrent = mCurrent - 1
		    Return False
		  Else
		    Call Advance
		  End If
		  
		  // Consume all contiguous hex digits.
		  While Peek.IsHexDigit
		    Call Advance
		  Wend
		  
		  // The next character can't alphanumeric or the end of a line.
		  If IsAlpha(Peek) And Not AtEnd Then
		    // Rewind to the character after the token start position.
		    mCurrent = mTokenStart + 1
		    Return False
		  End If
		  
		  // Compute the value. +2 accounts for the "0x" prefix.
		  Var lexeme As String = _
		  mSource.Middle(mTokenStart + 2, mCurrent - mTokenStart - 1)
		  
		  // Create and add this number token.
		  mTokens.Add(ObjoScript.Token.CreateNumber(mTokenStart, _
		  mLineNumber, Integer.FromHex(lexeme), True, mScriptID))
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473206569746865722061207661726961626C65206964656E7469666965722C206B6579776F72642C20626F6F6C65616E206F7220746865206E756C6C20746F6B656E2E
		Private Sub AddIdentifierOrReservedWord()
		  /// Adds either a variable identifier, keyword, boolean or the null token.
		  ///
		  /// Assumes we've already consumed the first character:
		  ///
		  /// ```
		  /// name
		  ///  ^
		  /// ```
		  
		  // Consume all alphanumeric characters and underscores.
		  Var s() As String = Array(Previous)
		  While Peek.IsASCIILetterOrDigitOrUnderscore
		    s.Add(Advance)
		  Wend
		  
		  Var lexeme As String = String.FromArray(s, "")
		  
		  // Use ObjoScript's dictionary of reserved words to determine this token's type.
		  Var type As ObjoScript.TokenTypes = ReservedWords.Lookup(lexeme, ObjoScript.TokenTypes.Identifier)
		  
		  Select Case type
		  Case ObjoScript.TokenTypes.Boolean_, ObjoScript.TokenTypes.ReservedType
		    mTokens.Add(MakeToken(type, lexeme))
		  Case ObjoScript.TokenTypes.This
		    mTokens.Add(MakeToken(type, "this"))
		  Else
		    If type <> ObjoScript.TokenTypes.Identifier Then
		      mTokens.Add(MakeToken(type))
		    ElseIf lexeme.Left(1).IsUppercaseASCIILetter Then
		      mTokens.Add(MakeToken(ObjoScript.TokenTypes.UppercaseIdentifier, lexeme))
		    Else
		      mTokens.Add(MakeToken(ObjoScript.TokenTypes.Identifier, lexeme))
		    End If
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616E6420616464732061206E756D62657220746F6B656E207374617274696E6720617420606D43757272656E74602E
		Private Sub AddNumberToken()
		  /// Consumes and adds a number token starting at `mCurrent`.
		  ///
		  /// Assumes that we have just consumed the first (possibly only) digit:
		  ///
		  /// ```
		  /// 100
		  ///  ^
		  /// ```
		  /// We allow the use of `_` as a digit separator.
		  
		  Var lexeme() As String = Array(Previous)
		  Var char As String
		  
		  While Peek.IsDigitOrUnderscore
		    char = Advance
		    If char <> "_" Then lexeme.Add(char)
		  Wend
		  
		  // Edge case 1: Prohibit a trailing underscore.
		  If Previous = "_" Then
		    Error("Unexpected character. " + _
		    "Underscores can separate digits within a number but a number cannot end with one.")
		  End If
		  
		  // Is this a double?
		  Var isInteger As Boolean = True
		  If Peek = "." And Peek(1).IsDigit Then
		    isInteger = False
		    
		    // Consume the dot.
		    lexeme.Add(Advance)
		    
		    While Peek.IsDigitOrUnderscore
		      char = Advance
		      If char <> "_" Then lexeme.Add(char)
		    Wend
		    
		    // Edge case 2: Prohibit a trailing underscore within a double.
		    If Previous = "_" Then
		      Error("Unexpected character. " + _
		      "Underscores can separate digits within a number but a number cannot end with one.")
		    End If
		  End If
		  
		  // Is there an exponent?
		  If Peek = "e" Then
		    Var nextChar As String = Peek(1)
		    If nextChar = "-" Or nextChar = "+" Then
		      If nextChar = "-" Then isInteger = False
		      // Advance twice to consume the e/E and sign character.
		      lexeme.Add(Advance)
		      lexeme.Add(Advance)
		      While Peek.IsDigit
		        lexeme.Add(Advance)
		      Wend
		      
		    ElseIf nextChar.IsDigit Then
		      // Consume the e/E character.
		      lexeme.Add(Advance)
		      
		      While Peek.IsDigit
		        lexeme.Add(Advance)
		      Wend
		    End If
		  End If
		  
		  // Add this token.
		  mTokens.Add(ObjoScript.Token.CreateNumber(mTokenStart, mLineNumber, _
		  Double.FromString(String.FromArray(lexeme, "")), isInteger, mScriptID))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417474656D70747320746F20616464206120737472696E67206C69746572616C20746F6B656E2E
		Private Sub AddStringToken()
		  /// Attempts to add a string literal token.
		  ///
		  /// String literals begin and end with a double quote ("). 
		  /// They may contain >= 0 escaped double quotes ("").
		  /// This method assumes that the current character being evaluated is 
		  /// immediately after the opening double quote:
		  /// ```
		  /// "Hello"
		  ///  ^
		  /// ```
		  
		  Var lexeme() As String
		  
		  // Keep consuming characters until we hit a `"`.
		  Var terminated As Boolean = False
		  Var c As String
		  While Not AtEnd
		    c = Advance
		    If c = """" Then
		      // If the next character is a `"` then this is an escaped quote.
		      If Match("""") Then
		        lexeme.Add(c)
		        Continue
		      Else
		        terminated = True
		        Exit
		      End If
		    ElseIf c = EndOfLine.UNIX Then
		      Exit
		    End If
		    lexeme.Add(c)
		  Wend
		  
		  // Make sure the literal was terminated.
		  If Not terminated Then
		    Error("Unterminated string literal. Expected a closing double quote.")
		  End If
		  
		  mTokens.Add(New ObjoScript.Token(ObjoScript.TokenTypes.String_, _
		  mTokenStart, mLineNumber, String.FromArray(lexeme, ""), mScriptID))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473207468652070617373656420746F6B656E20746F2074686520696E7465726E616C20606D546F6B656E73602061727261792E
		Private Sub AddToken(token As ObjoScript.Token)
		  /// Adds the passed token to the internal `mTokens` array.
		  
		  // Handle EOLs.
		  If token.Type = ObjoScript.TokenTypes.EOL Then
		    If mTokens.Count = 0 Then
		      // Prevent the first token from being an EOL.
		      Return 
		      
		    ElseIf mParsingList Then
		      // Don't add EOLs when parsing a list literal.
		      // This allows them to spread over multiple lines.
		      Return
		      
		    Else
		      // Disallow contiguous EOLs.
		      If mTokens(mTokens.LastIndex).Type = ObjoScript.TokenTypes.EOL Then
		        Return
		      End If
		    End If
		  End If
		  
		  // Add this token.
		  mTokens.Add(token)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616E642072657475726E73207468652063757272656E742063686172616374657220696E2074686520736F7572636520636F64652E
		Private Function Advance() As String
		  /// Consumes and returns the current character in the source code.
		  
		  mCurrent = mCurrent + 1
		  
		  Return mChars(mCurrent - 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662077652772652061742074686520656E64206F662074686520736F7572636520636F64652E
		Private Function AtEnd() As Boolean
		  /// Returns `True` if we're at the end of the source code.
		  
		  Return mCurrent >= mChars.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616C6C206368617261637465727320756E74696C20454F4C206F7220454F462E20446F6573202A6E6F742A20636F6E73756D652074686520454F4C206966206F6E6520697320726561636865642E
		Private Sub ConsumeComment()
		  /// Consumes all characters until EOL or EOF. Does *not* consume the EOL if one is reached.
		  ///
		  /// Assumes we are at the beginning of a comment.
		  /// In ObjoScript, comments begin with `//`.
		  
		  // Comments go to the end of the line so keep advancing
		  // until we reach a newline or the source code end.
		  Do
		    If Peek = EndOfLine.UNIX Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.EOL))
		      Exit
		      
		    ElseIf AtEnd Then
		      Exit
		      
		    Else
		      Call Advance
		      
		    End If
		  Loop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52616973657320616E20604C65786572457863657074696F6E60206174207468652063757272656E7420706F736974696F6E2E
		Private Sub Error(message As String)
		  /// Raises an `LexerException` at the current position.
		  
		  #Pragma BreakOnExceptions False
		  
		  Var e As New ObjoScript.LexerException(message)
		  e.ScriptID = mScriptID
		  e.LineNumber = mLineNumber
		  
		  // -1 as the tokeniser has already moved past the offending character.
		  e.AbsoluteStartPosition = mCurrent - 1
		  
		  // We know the 0-based index of the current character in the source code 
		  // but we need to translate that to the 0-based index within the 
		  // current line. We'll loop over the array of all characters in the 
		  // source code, counting the newlines until we get to the first 
		  // character of the line we're currently on. We can then compute the 
		  // index of the offending character by subtracting the position of the 
		  // start of this line from the current character position. This is a 
		  // bit convoluted but it'll only happen when there's an unrecoverable 
		  // lexer error so we don't need to care about performance that much.
		  Var newLineCount As Integer = 1
		  Var lineStartCharIndex As Integer = 0
		  For i As Integer = 0 To mChars.LastIndex
		    If newLineCount = mLineNumber Then
		      lineStartCharIndex = i
		      Exit
		    ElseIf mChars(i) = EndOfLine.UNIX Then
		      newLineCount = newLineCount + 1
		    End If
		  Next i
		  
		  // `lineStartCharIndex` now holds the 0-based position in the source 
		  // code of the first character of the line that the error has occurred on.
		  // Compute the relative position of the character causing the 
		  // error on the line.
		  e.LineCharacterPosition = e.AbsoluteStartPosition - lineStartCharIndex
		  
		  Raise e
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E20776520656E636F756E74657220616E20756E64657273636F72652061742074686520656E64206F662061206C696E652E
		Private Sub HandleLineContinuation()
		  /// Called when we encounter an underscore at the end of a line.
		  ///
		  /// Assumes that the subsequent newline character has already been consumed.
		  /// We need to advance past any spaces or tabs until we hit a non-whitespace character.
		  /// If we hit a newline or the end of the source code before we find a non-whitespace 
		  /// character then we raise an error.
		  
		  // Increment the line number.
		  mLineNumber = mLineNumber + 1
		  
		  While MatchSpaceOrTab
		  Wend
		  
		  If AtEnd Then
		    Error("Unexpected end of source code. Expected a non-whitespace character following " + _
		    "the line continuation operator.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C697365732074686520726573657276656420776F7264732064696374696F6E6172792E204B6579203D206B6579776F72642028636173652073656E736974697665292C2056616C7565203D204F626A6F5363726970742E546F6B656E547970657329
		Private Shared Function InitialiseReservedWords() As Dictionary
		  /// Initialises the reserved words dictionary.
		  /// Key = keyword (case sensitive), Value = ObjoScript.TokenTypes)
		  
		  // HACK Create a case sensitive dictionary.
		  Var d As Dictionary = ParseJSON("{}")
		  
		  d.Value("and")         = ObjoScript.TokenTypes.And_
		  d.Value("as")          = ObjoScript.TokenTypes.As_
		  d.Value("assert")      = ObjoScript.TokenTypes.Assert
		  d.Value("breakpoint")  = ObjoScript.TokenTypes.Breakpoint
		  d.Value("class")       = ObjoScript.TokenTypes.Class_
		  d.Value("continue")    = ObjoScript.TokenTypes.Continue_
		  d.Value("constructor") = ObjoScript.TokenTypes.Constructor
		  d.Value("else")        = ObjoScript.TokenTypes.Else_
		  d.Value("exit")        = ObjoScript.TokenTypes.Exit_
		  d.Value("export")      = ObjoScript.TokenTypes.Export
		  d.Value("false")       = ObjoScript.TokenTypes.Boolean_
		  d.Value("for")         = ObjoScript.TokenTypes.For_
		  d.Value("foreach")     = ObjoScript.TokenTypes.ForEach
		  d.Value("foreign")     = ObjoScript.TokenTypes.Foreign
		  d.Value("function")    = ObjoScript.TokenTypes.Function_
		  d.Value("if")          = ObjoScript.TokenTypes.If_
		  d.Value("import")      = ObjoScript.TokenTypes.Import
		  d.Value("in")          = ObjoScript.TokenTypes.In_
		  d.Value("is")          = ObjoScript.TokenTypes.Is_
		  d.Value("not")         = ObjoScript.TokenTypes.Not_
		  d.Value("nothing")     = ObjoScript.TokenTypes.Nothing
		  d.Value("or")          = ObjoScript.TokenTypes.Or_
		  d.Value("return")      = ObjoScript.TokenTypes.Return_
		  d.Value("static")      = ObjoScript.TokenTypes.Static_
		  d.Value("super")       = ObjoScript.TokenTypes.Super_
		  d.Value("then")        = ObjoScript.TokenTypes.Then_
		  d.Value("this")        = ObjoScript.TokenTypes.This
		  d.Value("true")        = ObjoScript.TokenTypes.Boolean_
		  d.Value("var")         = ObjoScript.TokenTypes.Var_
		  d.Value("while")       = ObjoScript.TokenTypes.While_
		  d.Value("xor")         = ObjoScript.TokenTypes.Xor_
		  d.Value("Boolean")     = ObjoScript.TokenTypes.ReservedType
		  d.Value("Number")      = ObjoScript.TokenTypes.ReservedType
		  d.Value("String")      = ObjoScript.TokenTypes.ReservedType
		  d.Value("Function")    = ObjoScript.TokenTypes.ReservedType
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060636020697320636F6E7369646572656420616C7068616E756D657269632E
		Private Function IsAlpha(c As String) As Boolean
		  /// Returns True if `c` is considered alphanumeric.
		  ///
		  /// This is **not** exhaustive because the `ObjoScript.NonAlpha` dictionary
		  /// doesn't contain every non-alpha character.
		  
		  Return Not ObjoScript.NonAlpha.HasKey(c)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061206E657720746F6B656E206F66207468652073706563696669656420747970652E
		Private Function MakeToken(type As ObjoScript.TokenTypes, lexeme As String = "") As ObjoScript.Token
		  /// Returns a new token of the specified type. 
		  
		  If type = ObjoScript.TokenTypes.Boolean_ Then
		    Return ObjoScript.Token.CreateBoolean(mTokenStart, mLineNumber, If(lexeme = "true", True, False), mScriptID)
		  Else
		    Return New ObjoScript.Token(type, mTokenStart, mLineNumber, lexeme, mScriptID)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496620746865206E65787420636861726163746572206D61746368657320606360207468656E206974277320636F6E73756D656420616E6420547275652069732072657475726E65642E204F7468657277697365206974206C6561766573207468652063686172616374657220616C6F6E6520616E642072657475726E732046616C73652E
		Private Function Match(c As String) As Boolean
		  /// If the next character matches `c` then it's consumed and True is returned. 
		  /// Otherwise it leaves the character alone and returns False.
		  
		  If Peek = c Then
		    Call Advance
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496620746865206E65787420636861726163746572206D61746368657320616E79206F6620606368617261637465727360207468656E20697420636F6E73756D657320746865206E6578742063686172616374657220627920616476616E63696E6720616E642072657475726E696E6720547275652E204F74686572776973652C2069742072657475726E732046616C73652E
		Private Function MatchAny(ParamArray characters As String) As Boolean
		  /// If the next character matches any of `characters` then it
		  /// consumes the next character by advancing and returning True. Otherwise, it returns False.
		  
		  For Each c As String In characters
		    If Peek = c Then
		      Call Advance
		      Return True
		    End If
		  Next c
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496620746865206E657874206368617261637465722069732061207370616365206F72206120686F72697A6F6E74616C20746162207468656E20776520636F6E73756D6520697420616E642072657475726E20547275652E204F7468657277697365207765206C65617665207468652063686172616374657220616C6F6E6520616E642072657475726E2046616C73652E
		Private Function MatchSpaceOrTab() As Boolean
		  /// If the next character is a space or a horizontal tab then we consume it and return True. 
		  /// Otherwise we leave the character alone and return False.
		  
		  Var peekCache As String = Peek
		  If peekCache = " " Or peekCache = &u0009 Then
		    Call Advance
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5363616E7320606D4368617273602066726F6D207468652063757272656E742063686172616374657220616E64206164647320746865206E65787420746F6B656E20746F20606D546F6B656E73602E204D6179207261697365206120604C65786572457863657074696F6E602E
		Private Sub NextToken()
		  /// Scans `mChars` from the current character and adds the next token to `mTokens`.
		  /// May raise a `LexerException`.
		  
		  // Store the current position so we know where in `mChars` this token begins.
		  mTokenStart = mCurrent
		  
		  // Skip over meaningless whitespace.
		  SkipWhitespace
		  
		  // Have we reached the end of the source code?
		  If AtEnd Then
		    AddToken(MakeToken(TokenTypes.EOL))
		    AddToken(MakeToken(TokenTypes.EOF))
		    Return
		  End If
		  
		  // Get the character to evaluate.
		  Var c As String = Advance
		  
		  // ====================================================================
		  // Numbers.
		  // ====================================================================
		  If c.IsDigit Then
		    If c = "0" And Peek(1) = "x" Then
		      // Hexadecimal literal (e.g. 0xFF)?
		      If AddHexLiteralToken Then Return
		    Else
		      AddNumberToken
		      Return
		    End If
		  End If
		  
		  // ====================================================================
		  // Single character tokens.
		  // ====================================================================
		  Select Case c
		  Case "("
		    AddToken(MakeToken(ObjoScript.TokenTypes.LParen, c))
		    mUnclosedParenCount = mUnclosedParenCount + 1
		    Return
		    
		  Case ")"
		    AddToken(MakeToken(ObjoScript.TokenTypes.RParen, c))
		    mUnclosedParenCount = mUnclosedParenCount - 1
		    If mUnclosedParenCount < 0 Then Error("Syntax error. Unmatched closing parenthesis.")
		    Return
		    
		  Case "{"
		    AddToken(MakeToken(ObjoScript.TokenTypes.LCurly, c))
		    mUnclosedCurlyCount = mUnclosedCurlyCount + 1
		    Return
		    
		  Case "}"
		    AddToken(MakeToken(ObjoScript.TokenTypes.RCurly, c))
		    mUnclosedCurlyCount = mUnclosedCurlyCount - 1
		    If mUnclosedCurlyCount < 0 Then Error("Syntax error. Unmatched closing curly bracket.")
		    Return
		    
		  Case "["
		    AddToken(MakeToken(ObjoScript.TokenTypes.LSquare, c))
		    mUnclosedSquareCount = mUnclosedSquareCount + 1
		    mParsingList = True
		    Return
		    
		  Case "]"
		    AddToken(MakeToken(ObjoScript.TokenTypes.RSquare, c))
		    mUnclosedSquareCount = mUnclosedSquareCount - 1
		    If mUnclosedSquareCount < 0 Then Error("Syntax error. Unmatched closing square bracket.")
		    If mUnclosedSquareCount = 0 Then mParsingList = False
		    Return
		    
		  Case ","
		    AddToken(MakeToken(ObjoScript.TokenTypes.Comma, c))
		    Return
		    
		  Case "&"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Ampersand, c))
		    Return
		    
		  Case "|"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Pipe, c))
		    Return
		    
		  Case "^"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Caret, c))
		    Return
		    
		  Case "~"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Tilde, c))
		    Return
		    
		  Case ":"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Colon, c))
		    Return
		    
		  Case ";"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Semicolon, c))
		    Return
		    
		  Case "?"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Query, c))
		    Return
		    
		  Case "%"
		    AddToken(MakeToken(ObjoScript.TokenTypes.Percent, c))
		    Return
		  End Select
		  
		  // ====================================================================
		  // Single OR multiple character tokens.
		  // `c` is a character that can occur on its own or can occur in 
		  // combination with one or more characters.
		  // ====================================================================
		  Select Case c
		  Case "="
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.EqualEqual, "=="))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Equal, "="))
		      Return
		    End If
		    
		  Case "."
		    If Match(".") Then
		      If Match(".") Then
		        AddToken(MakeToken(ObjoScript.TokenTypes.DotDotDot, "...")) // ...
		        Return
		      Else
		        AddToken(MakeToken(ObjoScript.TokenTypes.DotDot, "..")) // ..
		        Return
		      End If
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Dot, "."))
		      Return
		    End If
		    
		  Case "+"
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.PlusEqual, "+="))
		      Return
		    ElseIf Match("+") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.PlusPlus, "++"))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Plus, "+"))
		      Return
		    End If
		    
		  Case "-"
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.MinusEqual, "-="))
		      Return
		    ElseIf Match("-") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.MinusMinus, "--"))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Minus, "-"))
		      Return
		    End If
		    
		  Case "*"
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.StarEqual, "*="))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Star, "*"))
		      Return
		    End If
		    
		  Case "/"
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.ForwardSlashEqual, "/="))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.ForwardSlash, "/"))
		      Return
		    End If
		    
		  Case "<"
		    If Match(">") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.NotEqual, "<>"))
		      Return
		    ElseIf Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.LessEqual, "<="))
		      Return
		    ElseIf Match("<") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.LessLess, "<<"))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Less, "<"))
		      Return
		    End If
		    
		  Case ">"
		    If Match("=") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.GreaterEqual, ">="))
		      Return
		    ElseIf Match(">") Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.GreaterGreater, ">>"))
		      Return
		    Else
		      AddToken(MakeToken(ObjoScript.TokenTypes.Greater, ">"))
		      Return
		    End If
		  End Select
		  
		  // ====================================================================
		  // Strings.
		  // ====================================================================
		  If c = """" Then
		    AddStringToken
		    Return
		  End If
		  
		  // ====================================================================
		  // The underscore.
		  // Underscores represent the line continuation marker if they are 
		  // immediately followed by a newline or they can indicate the 
		  // beginning of an identifier.
		  // ====================================================================
		  If c = "_" Then
		    If Match("_") Then
		      If Peek.IsASCIILetter Then // A static field identifier (e.g: `__version`).
		        AddFieldIdentifier(True)
		        Return
		      Else
		        Error("Unexpected character following `__`. Should be a letter.")
		      End If
		    ElseIf Peek.IsASCIILetter Then // A class field identifier (e.g: `_width`).
		      AddFieldIdentifier(False)
		      Return
		    Else
		      // Could be the line continuation marker.
		      // Edge case: Discard trailing whitespace between the underscore and the newline character.
		      While MatchSpaceOrTab
		      Wend
		      
		      // Edge case: Comment after the line continuation marker.
		      If Match("/") And Match("/") Then
		        Do
		          If Peek = EndOfLine.UNIX Then
		            Exit
		          ElseIf AtEnd Then
		            Exit
		          Else
		            Call Advance
		          End If
		        Loop
		      End If
		      
		      If Match(EndOfLine.UNIX) Then // Line continuation marker.
		        HandleLineContinuation
		        Return
		      Else
		        Error("Unexpected character following `_`. Should be a letter or a newline.")
		      End If
		    End If
		  End If
		  
		  // =================================================================
		  // Identifiers, keywords, booleans and null.
		  // =================================================================
		  If c.IsASCIILetter Then
		    AddIdentifierOrReservedWord
		    Return
		  End If
		  
		  // ====================================================================
		  // Danger zone.
		  // ====================================================================
		  Error("Unexpected character `" + c + "`.")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320606D4368617273286D43757272656E74202B2064697374616E636529602062757420646F65736E277420636F6E73756D652069742E20496620776527766520726561636865642074686520656E642069742072657475726E732022222E
		Private Function Peek(distance As Integer = 0) As String
		  /// Returns `mChars(mCurrent + distance)` but doesn't consume it.
		  /// If we've reached the end it returns "".
		  
		  Return If(mCurrent + distance <= mChars.LastIndex, mChars(mCurrent + distance), "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652070726576696F75736C7920636F6E73756D6564206368617261637465722E2049662077652772652063757272656E746C7920617420746865206669727374206368617261637465722069742072657475726E732022222E
		Private Function Previous() As String
		  /// Returns the previously consumed character.
		  /// If we're currently at the first character it returns "".
		  
		  If mCurrent - 1 >= 0 Then
		    Return mChars(mCurrent - 1)
		  Else
		    Return ""
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732060547275656020696620776527766520726561636865642074686520656E64206F662074686520736F7572636520636F64652E
		Private Function ReachedEOF() As Boolean
		  /// Returns `True` if we've reached the end of the source code.
		  
		  If mTokens.Count > 0 And mTokens(mTokens.LastIndex).Type = ObjoScript.TokenTypes.EOF Then
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657365747320746865206C657865722C20726561647920746F20746F6B656E697365206D6F726520736F7572636520636F64652E
		Sub Reset()
		  /// Resets the lexer, ready to tokenise more source code.
		  
		  mChars.ResizeTo(-1)
		  mTokens.ResizeTo(-1)
		  mTokenStart = 0
		  mCurrent = 0
		  mLineNumber = 1
		  mScriptID = 0
		  mSource = ""
		  mUnclosedParenCount = 0
		  mUnclosedCurlyCount = 0
		  mUnclosedSquareCount = 0
		  mParsingList = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416476616E6365732070617374206D65616E696E676C65737320776869746573706163652E
		Private Sub SkipWhitespace()
		  /// Advances past meaningless whitespace.
		  ///
		  /// Updates `mTokenStart` if needed.
		  /// Handles newlines following an underscore token.
		  
		  Do
		    Select Case Peek
		    Case "" // End of the source code.
		      Exit
		      
		    Case " ", &u0009 // Space or horizontal tab.
		      Call Advance
		      
		    Case "/"
		      // Could this be the start of a "//" comment?
		      If Peek(1) = "/" Then
		        ConsumeComment
		      Else
		        Exit
		      End If
		      
		    Case EndOfLine.UNIX
		      // Is the last token an underscore? If so, we remove the underscore
		      // token and omit adding an EOL token. To the parser, this will
		      // appear as though the tokens before the underscore token and those
		      // following this newline are on the same line.
		      If mTokens.Count > 0 And _ 
		        mTokens(mTokens.LastIndex).Type = ObjoScript.TokenTypes.Underscore Then
		        Call mTokens.Pop
		        Call Advance
		        mLineNumber = mLineNumber + 1
		      Else
		        AddToken(MakeToken(ObjoScript.TokenTypes.EOL))
		        Call Advance
		        mLineNumber = mLineNumber + 1
		      End If
		      
		    Else
		      Exit
		      
		    End Select
		  Loop
		  
		  // Update the start position of the next token.
		  mTokenStart = mCurrent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E6973657320756E70726F636573736564204F626A6F5363726970742060736F757263656020636F646520696E746F20616E206172726179206F6620746F6B656E732E206073637269707449446020697320616E206F7074696F6E616C20494420726570726573656E74696E6720746865207363726970742074686520736F75726365206F726967696E6174656420696E2E
		Function Tokenise(source As String, includeEOFToken As Boolean = True, scriptID As Integer = 0) As ObjoScript.Token()
		  /// Tokenises unprocessed ObjoScript `source` code into an array of tokens.
		  /// `scriptID` is an optional ID representing the script the source originated in.
		  ///
		  /// By default, the lexer includes an EOF token at the end. This can optionally be omitted. This
		  /// is useful if several files are being tokenised and concatenated together (since the parser 
		  /// looks for the EOF token to know when it's finished).
		  
		  Reset
		  
		  mScriptID = scriptID
		  
		  // Keep a reference to the source code and default to Unix line endings.
		  mSource = source.ReplaceLineEndings(EndOfLine.UNIX)
		  
		  // Split the source into characters.
		  mChars = mSource.CharacterArray
		  
		  // Split the source into tokens.
		  Do
		    NextToken
		  Loop Until ReachedEOF
		  
		  // Remove the EOF token if requested.
		  If Not includeEOFToken Then Call mTokens.Pop
		  
		  Return mTokens
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 5468652063686172616374657273206F662074686520736F7572636520636F64652063757272656E746C79206265696E67206C657865642E
		Private mChars() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 302D626173656420696E64657820696E20606D43686172736020776865726520746865206C657865722063757272656E746C792069732E
		Private mCurrent As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520312D6261736564206E756D626572206F6620746865206C696E652063757272656E746C79206265696E672070726F6365737365642E
		Private mLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5472756520696620746865206C6578657220697320696E20746865206D6964646C65206F662070617273696E672061206C6973742E
		Private mParsingList As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520286F7074696F6E616C29204944206F6620746865207363726970742063757272656E746C79206265696E67207061727365642E
		Private mScriptID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865207374616E646172646973656420736F7572636520636F6465206265696E672070726F6365737365642E
		Private mSource As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E27732067656E65726174656420736F206661722E
		Private mTokens() As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 302D626173656420696E64657820696E20606D4368617273602074686174207468652063757272656E7420746F6B656E207374617274732061742E
		Private mTokenStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620756E636C6F736564206375726C7920627261636B6574732E
		Private mUnclosedCurlyCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620756E636C6F73656420706172656E7468657365732E
		Private mUnclosedParenCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F6620756E636C6F7365642073717561726520627261636B6574732E
		Private mUnclosedSquareCount As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 416C6C206F66204F626A6F5363726970742773206B6579776F72647320706C7573202274727565222C202266616C73652220616E6420226E756C6C22206D617070656420746F20746865697220746F6B656E207479706520286B6579203D206B6579776F726420737472696E672C2076616C7565203D204F626A6F5363726970742E546F6B656E5479706573292E
		#tag Getter
			Get
			  /// A private dictionary of all of ObjoScript's keywords plus "true", "false"
			  /// and "nothing" mapped to their token type.
			  /// Key = keyword string, value = ObjoScript.TokenTypes.
			  
			  Static d As Dictionary = InitialiseReservedWords
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Shared ReservedWords As Dictionary
	#tag EndComputedProperty


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
