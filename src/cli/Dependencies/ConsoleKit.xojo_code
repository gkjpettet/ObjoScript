#tag Module
Protected Module ConsoleKit
	#tag Method, Flags = &h1, Description = 436C6561727320746865206C696E652074686520637572736F722069732063757272656E746C79206F6E20696E20706173736564206F75747075742073747265616D2C2064656661756C74696E6720746F207374646F75742E
		Protected Sub ClearLine(where As StandardOutputStream = Nil)
		  /// Clears the line the cursor is currently on in passed output stream, defaulting to stdout.
		  
		  If where = Nil Then where = stdout
		  
		  where.Write(ESC + "2K")
		  where.Flush
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436C656172732074686520706173736564206F75747075742073747265616D2C2064656661756C74696E6720746F207374646F75742E
		Protected Sub ClearScreen(where As StandardOutputStream = Nil)
		  /// Clears the passed output stream, defaulting to stdout.
		  
		  If where = Nil Then where = stdout
		  
		  where.Write(ESC + "2J")
		  where.Flush
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726170732060736020696E2061206261636B636F6C6F7572206F662076616C75652060636F6C6F72436F646560207375697461626C6520666F722075736520696E206120434C4920746F6F6C2E2060636F6C6F7572436F6465602073686F756C64206265206030202D20323535602E
		Function CLIBackcolor(Extends s As String, colourCode As Integer) As String
		  /// Wraps `s` in a backcolour of value `colorCode` suitable for use in a CLI tool. `colourCode` should be `0 - 255`.
		  
		  Return s.CLIFormatted(False, False, False, -1, colourCode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726170732060736020696E2061206261636B636F6C6F7572206F662076616C75652060636F6C6F72436F646560207375697461626C6520666F722075736520696E206120434C4920746F6F6C2E2060636F6C6F7572436F6465602073686F756C64206265206030202D20323535602E
		Function CLIBackcolor(s As String, colourCode As Integer) As String
		  /// Wraps `s` in a backcolour of value `colorCode` suitable for use in a CLI tool. `colourCode` should be `0 - 255`.
		  
		  Return s.CLIFormatted(False, False, False, -1, colourCode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020626F6C6420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIBold(Extends s As String) As String
		  /// Makes `s` bold for use in a CLI tool.
		  
		  Return s.CLIFormatted(True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020626F6C6420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIBold(s As String) As String
		  /// Makes `s` bold for use in a CLI tool.
		  
		  Return s.CLIFormatted(True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726170732060736020696E206120666F7265636F6C6F7572206F662076616C75652060636F6C6F72436F646560207375697461626C6520666F722075736520696E206120434C4920746F6F6C2E2060636F6C6F7572436F6465602073686F756C64206265206030202D20323535602E
		Function CLIForecolor(Extends s As String, colourCode As Integer) As String
		  /// Wraps `s` in a forecolour of value `colorCode` suitable for use in a CLI tool. `colourCode` should be `0 - 255`.
		  
		  Return s.CLIFormatted(False, False, False, colourCode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726170732060736020696E206120666F7265636F6C6F7572206F662076616C75652060636F6C6F72436F646560207375697461626C6520666F722075736520696E206120434C4920746F6F6C2E2060636F6C6F7572436F6465602073686F756C64206265206030202D20323535602E
		Function CLIForecolor(s As String, colourCode As Integer) As String
		  /// Wraps `s` in a forecolour of value `colorCode` suitable for use in a CLI tool. `colourCode` should be `0 - 255`.
		  
		  Return s.CLIFormatted(False, False, False, colourCode)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120666F726D61747465642076657273696F6E206F662060736020666F72206F757470757474696E6720746F207374616E64617264206F75742E
		Function CLIFormatted(Extends s As String, bold As Boolean = False, underlined As Boolean = False, inverted As Boolean = False, foreColor As Integer = -1, backColor As Integer = -1) As String
		  /// Returns a formatted version of `s` for outputting to standard out.
		  ///
		  /// Both `foreColor` and `backColor` should be `0 - 255` if specified.
		  
		  // Sanity checks.
		  If foreColor < -1 Or foreColor > 255 Then
		    Raise New InvalidArgumentException("The forecolor must be 0 - 255 or `-1`")
		  End If
		  If backColor < -1 Or backColor > 255 Then
		    Raise New InvalidArgumentException("The backcolor must be 0 - 255 or `-1`")
		  End If
		  
		  Var tmp() As String
		  If foreColor = -1 Then
		    tmp.Add(ESC + FORECOLOR_DEFAULT + "m")
		  Else
		    tmp.Add(ESC + "38;5;" + foreColor.ToString + "m")
		  End If
		  If backColor = -1 Then
		    tmp.Add(ESC + BACKCOLOR_DEFAULT + "m")
		  Else
		    tmp.Add(ESC + "48;5;" + backColor.ToString + "m")
		  End If
		  tmp.Add(ESC + If(bold, BOLD_ON, BOLD_OFF) + "m")
		  tmp.Add(ESC + If(underlined, UNDERLINE_ON, UNDERLINE_OFF) + "m")
		  tmp.Add(ESC + If(inverted, INVERTED_ON, INVERTED_OFF) + "m")
		  tmp.Add(s)
		  tmp.Add(Reset)
		  
		  Return String.FromArray(tmp, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120666F726D61747465642076657273696F6E206F662060736020666F72206F757470757474696E6720746F207374616E64617264206F75742E
		Function CLIFormatted(s As String, bold As Boolean = False, underlined As Boolean = False, inverted As Boolean = False, foreColor As Integer = -1, backColor As Integer = -1) As String
		  /// Returns a formatted version of `s` for outputting to standard out.
		  ///
		  /// Both `foreColor` and `backColor` should be `0 - 255` if specified.
		  
		  // Sanity checks.
		  If foreColor < -1 Or foreColor > 255 Then
		    Raise New InvalidArgumentException("The forecolor must be 0 - 255 or `-1`")
		  End If
		  If backColor < -1 Or backColor > 255 Then
		    Raise New InvalidArgumentException("The backcolor must be 0 - 255 or `-1`")
		  End If
		  
		  Var tmp() As String
		  If foreColor = -1 Then
		    tmp.Add(ESC + FORECOLOR_DEFAULT + "m")
		  Else
		    tmp.Add(ESC + "38;5;" + foreColor.ToString + "m")
		  End If
		  If backColor = -1 Then
		    tmp.Add(ESC + BACKCOLOR_DEFAULT + "m")
		  Else
		    tmp.Add(ESC + "48;5;" + backColor.ToString + "m")
		  End If
		  tmp.Add(ESC + If(bold, BOLD_ON, BOLD_OFF) + "m")
		  tmp.Add(ESC + If(underlined, UNDERLINE_ON, UNDERLINE_OFF) + "m")
		  tmp.Add(ESC + If(inverted, INVERTED_ON, INVERTED_OFF) + "m")
		  tmp.Add(s)
		  tmp.Add(Reset)
		  
		  Return String.FromArray(tmp, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020696E766572746564202F20726576657273656420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIInverted(Extends s As String) As String
		  /// Makes `s` inverted / reversed for use in a CLI tool.
		  
		  Return s.CLIFormatted(False, False, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020696E766572746564202F20726576657273656420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIInverted(s As String) As String
		  /// Makes `s` inverted / reversed for use in a CLI tool.
		  
		  Return s.CLIFormatted(False, False, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020756E6465726C696E656420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIUnderlined(Extends s As String) As String
		  /// Makes `s` underlined for use in a CLI tool.
		  
		  Return s.CLIFormatted(False, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4D616B65732060736020756E6465726C696E656420666F722075736520696E206120434C4920746F6F6C2E
		Function CLIUnderlined(s As String) As String
		  /// Makes `s` underlined for use in a CLI tool.
		  
		  Return s.CLIFormatted(False, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6F7665732074686520637572736F7220696E20607768657265602060706C616365736020646F776E2E2044656661756C747320746F205374644F75742E
		Protected Sub CursorDown(places As Integer = 1, where As StandardOutputStream = Nil)
		  /// Moves the cursor in `where` `places` down. Defaults to StdOut.
		  ///
		  /// `places` should be >= 0.
		  
		  CursorMove(CursorDirections.Down, places, where)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6F7665732074686520637572736F7220696E20607768657265602060706C6163657360206C6566742E2044656661756C747320746F205374644F75742E
		Protected Sub CursorLeft(places As Integer = 1, where As StandardOutputStream = Nil)
		  /// Moves the cursor in `where` `places` left. Defaults to StdOut.
		  ///
		  /// `places` should be >= 0.
		  
		  CursorMove(CursorDirections.Left, places, where)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4D6F7665732074686520637572736F7220696E20607768657265602060706C616365736020696E2074686520646972656374696F6E207370656369666965642E2044656661756C747320746F205374644F75742E
		Private Sub CursorMove(cursorDirection As CursorDirections, places As Integer = 1, where As StandardOutputStream = Nil)
		  /// Moves the cursor in `where` `places` in the direction specified. Defaults to StdOut.
		  ///
		  /// `places` should be >= 0.
		  
		  // Default to stdout.
		  If where = Nil Then where = stdout
		  
		  // Sanity check.
		  If places < 1 Then
		    Raise New InvalidArgumentException("Must move the cursor >= 0 places.")
		  End If
		  
		  Var direction As String
		  Select Case cursorDirection
		  Case CursorDirections.Up
		    direction = "A"
		  Case CursorDirections.Down
		    direction = "B"
		  Case CursorDirections.Right
		    direction = "C"
		  Case CursorDirections.Left
		    direction = "D"
		  End Select
		  
		  where.Write(ESC + places.ToString + direction)
		  where.Flush
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6F7665732074686520637572736F7220696E20607768657265602060706C61636573602072696768742E2044656661756C747320746F205374644F75742E
		Protected Sub CursorRight(places As Integer = 1, where As StandardOutputStream = Nil)
		  /// Moves the cursor in `where` `places` right. Defaults to StdOut.
		  ///
		  /// `places` should be >= 0.
		  
		  CursorMove(CursorDirections.Right, places, where)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 4D6F7665732074686520637572736F7220696E20607768657265602060706C61636573602075702E2044656661756C747320746F205374644F75742E
		Protected Sub CursorUp(places As Integer = 1, where As StandardOutputStream = Nil)
		  /// Moves the cursor in `where` `places` up. Defaults to StdOut.
		  ///
		  /// `places` should be >= 0.
		  
		  CursorMove(CursorDirections.Up, places, where)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54686520414E5349207265736574206573636170652073657175656E636520746F2070757420746865207465726D696E616C206261636B20746F206974732064656661756C742073657474696E67732E
		Protected Function Reset() As String
		  /// The ANSI reset escape sequence to put the terminal back to its default settings.
		  
		  Return ESC + "0m"
		End Function
	#tag EndMethod


	#tag Constant, Name = BACKCOLOR_DEFAULT, Type = String, Dynamic = False, Default = \"49", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BOLD_OFF, Type = String, Dynamic = False, Default = \"22", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BOLD_ON, Type = String, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ESC, Type = String, Dynamic = False, Default = \"\x1B[", Scope = Private, Description = 546865206F70656E696E6720414E5349206573636170652073657175656E6365202860267531625B60292E
	#tag EndConstant

	#tag Constant, Name = FORECOLOR_DEFAULT, Type = String, Dynamic = False, Default = \"39", Scope = Private
	#tag EndConstant

	#tag Constant, Name = INVERTED_OFF, Type = String, Dynamic = False, Default = \"27", Scope = Private
	#tag EndConstant

	#tag Constant, Name = INVERTED_ON, Type = String, Dynamic = False, Default = \"7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UNDERLINE_OFF, Type = String, Dynamic = False, Default = \"24", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UNDERLINE_ON, Type = String, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant


	#tag Enum, Name = CursorDirections, Flags = &h21
		Left
		  Right
		  Up
		Down
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
	#tag EndViewBehavior
End Module
#tag EndModule
