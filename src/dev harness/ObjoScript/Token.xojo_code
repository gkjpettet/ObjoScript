#tag Class
Protected Class Token
	#tag Method, Flags = &h0, Description = 41206E657720746F6B656E206F662060747970656020626567696E6E696E672061742073637269707420607374617274506F7360206F6E20606C696E654E756D62657260207769746820616E206F7074696F6E616C20606C6578656D656020616E6420607363726970744944602E
		Sub Constructor(type As TokenTypes, startPos As Integer, lineNumber As Integer, lexeme As String = "", scriptID As Integer = 0)
		  /// A new token of `type` beginning at script `startPos` on `lineNumber` with an 
		  /// optional `lexeme` and `scriptID`.
		  
		  Self.Type = type
		  Self.StartPosition = startPos
		  Self.LineNumber = lineNumber
		  Self.Lexeme = lexeme
		  Self.ScriptID = scriptID
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E657720626F6F6C65616E20746F6B656E2E
		Shared Function CreateBoolean(startPos As Integer, lineNumber As Integer, value As Boolean, scriptID As Integer = -1) As ObjoScript.Token
		  /// Returns a new boolean token.
		  
		  Var t As New ObjoScript.Token(ObjoScript.TokenTypes.Boolean_, startPos, lineNumber, "", scriptID)
		  t.BooleanValue = value
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061206E6577206E756D62657220746F6B656E2E
		Shared Function CreateNumber(startPos As Integer, lineNumber As Integer, value As Double, isInteger As Boolean, scriptID As Integer = -1) As ObjoScript.Token
		  /// Returns a new number token.
		  
		  Var t As New ObjoScript.Token(ObjoScript.TokenTypes.Number, startPos, lineNumber, "", scriptID)
		  t.NumberValue = value
		  t.IsInteger = isInteger
		  
		  Return t
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 49662074686973206973206120626F6F6C65616E20746F6B656E2C2074686973206973207468652076616C75652E204D65616E696E676C65737320666F72206F7468657220746F6B656E2074797065732E
		BooleanValue As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746869732069732061206E756D62657220746F6B656E2C20746869732069732054727565206966206974277320616E20696E74656765722E204D65616E696E676C65737320666F72206F7468657220746F6B656E2074797065732E
		IsInteger As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120737461746963206669656C64206964656E7469666965722E20
		IsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652061637475616C2063686172616374657273206F66207468697320746F6B656E2E204E6F7420657665727920746F6B656E2070726F76696465732061206C6578656D652E
		Lexeme As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520312D6261736564206C696E65206E756D6265722074686174207468697320746F6B656E206F6363757273206F6E2E
		LineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496620746869732069732061206E756D62657220746F6B656E2C2074686973206973207468652076616C75652E204D65616E696E676C65737320666F72206F7468657220746F6B656E2074797065732E
		NumberValue As Double
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C204944206F662074686520736372697074207468697320746F6B656E206F63637572732077697468696E2E
		ScriptID As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D6261736564206162736F6C75746520706F736974696F6E20696E20746865207363726970742074686174207468697320746F6B656E206F63637572732061742E
		StartPosition As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746F6B656E277320747970652E
		Type As ObjoScript.TokenTypes
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
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ObjoScript.TokenTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Ampersand"
				"1 - And_"
				"2 - As_"
				"3 - Assert"
				"4 - Boolean_"
				"5 - Breakpoint"
				"6 - Caret"
				"7 - Class_"
				"8 - Colon"
				"9 - Comma"
				"10 - Construct"
				"11 - Continue_"
				"12 - Dot"
				"13 - DotDot"
				"14 - DotDotDot"
				"15 - Else_"
				"16 - EOF"
				"17 - EOL"
				"18 - Equal"
				"19 - EqualEqual"
				"20 - Exit_"
				"21 - Export"
				"22 - FieldIdentifier"
				"23 - For_"
				"24 - Foreign"
				"25 - ForwardSlash"
				"26 - ForwardSlashEqual"
				"27 - Function_"
				"28 - Greater"
				"29 - GreaterEqual"
				"30 - GreaterGreater"
				"31 - Identifier"
				"32 - If_"
				"33 - Import"
				"34 - In_"
				"35 - Is_"
				"36 - LCurly"
				"37 - Less"
				"38 - LessEqual"
				"39 - LessLess"
				"40 - LParen"
				"41 - LSquare"
				"42 - Minus"
				"43 - MinusEqual"
				"44 - MinusMinus"
				"45 - Not_"
				"46 - NotEqual"
				"47 - Nothing"
				"48 - Number"
				"49 - Or_"
				"50 - Percent"
				"51 - Pipe"
				"52 - Plus"
				"53 - PlusEqual"
				"54 - PlusPlus"
				"55 - Print"
				"56 - Query"
				"57 - RCurly"
				"58 - Return_"
				"59 - RParen"
				"60 - RSquare"
				"61 - Star"
				"62 - StarEqual"
				"63 - Static_"
				"64 - String_"
				"65 - This"
				"66 - Tilde"
				"67 - Underscore"
				"68 - Var_"
				"69 - While_"
				"70 - Xor_"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lexeme"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartPosition"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScriptID"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BooleanValue"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsInteger"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStatic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NumberValue"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
