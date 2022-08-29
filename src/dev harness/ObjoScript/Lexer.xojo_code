#tag Class
Protected Class Lexer
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
		  
		  // Compute the lexeme. +2 accounts for the "0x" prefix.
		  Var lexeme As String = _
		  mSource.Middle(mTokenStart + 2, mCurrent - mTokenStart - 1)
		  
		  // Create and add this token.
		  mTokens.Add(New ObjoScript.Token(ObjoScript.TokenTypes.HexLiteral, mTokenStart, _
		  mLineNumber, lexeme, mScriptID))
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 41646473207468652070617373656420746F6B656E20746F2074686520696E7465726E616C20606D546F6B656E73602061727261792E
		Private Sub AddToken(token As ObjoScript.Token)
		  /// Adds the passed token to the internal `mTokens` array.
		  
		  // Handle EOLs.
		  If token.Type = ObjoScript.TokenTypes.EOL Then
		    If mTokens.Count = 0 Then
		      // Prevent the first token from being an EOL.
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

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616C6C206368617261637465727320756E74696C20454F4C206F7220454F462E
		Private Sub ConsumeComment()
		  /// Consumes all characters until EOL or EOF.
		  ///
		  /// Assumes we are at the beginning of a comment.
		  /// In ObjoScript, comments begin with `//`.
		  
		  // Comments go to the end of the line so keep advancing
		  // until we reach a newline or the source code end.
		  Do
		    If Peek = EndOfLine.UNIX Then
		      AddToken(MakeToken(ObjoScript.TokenTypes.EOL))
		      mLineNumber = mLineNumber + 1
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

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060636020697320636F6E7369646572656420616C7068616E756D657269632E
		Private Function IsAlpha(c As String) As Boolean
		  /// Returns True if `c` is considered alphanumeric.
		  ///
		  /// This is **not** exhaustive because the `ObjoScript.NonAlpha` dictionary
		  /// doesn't contain every non-alpha character.
		  
		  Return Not ObjoScript.NonAlpha.HasKey(c)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061206E657720746F6B656E206F66207468652073706563696669656420747970652E205573656420666F7220746F6B656E7320776974686F7574206C6578656D65732E
		Private Function MakeToken(type As ObjoScript.TokenTypes) As ObjoScript.Token
		  /// Returns a new token of the specified type. 
		  /// Used for tokens without lexemes.
		  
		  Return New ObjoScript.Token(type, mTokenStart, mLineNumber, "", mScriptID)
		  
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
		  // NUMBERS
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
		  mScriptID = -1
		  mSource = ""
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
		Function Tokenise(source As String, scriptID As Integer = -1) As ObjoScript.Token()
		  /// Tokenises unprocessed ObjoScript `source` code into an array of tokens.
		  /// `scriptID` is an optional ID representing the script the source originated in.
		  
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

	#tag Property, Flags = &h21, Description = 54686520286F7074696F6E616C29204944206F6620746865207363726970742063757272656E746C79206265696E67207061727365642E
		Private mScriptID As Integer = -1
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
