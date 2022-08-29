#tag Class
Protected Class NumberToken
Inherits ObjoScript.Token
	#tag Method, Flags = &h0
		Sub Constructor(startPos As Integer, lineNumber As Integer, Value As Double, isInteger As Boolean, scriptID As Integer = -1)
		  /// A new number token beginning at script `startPos` on `lineNumber` with `value` and 
		  /// an optional `scriptID`.
		  
		  Super.Constructor(ObjoScript.TokenTypes.Number, startPos, lineNumber, "", scriptID)
		  
		  Self.Value = value
		  Self.IsInteger = isInteger
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54727565206966207468697320697320616E20696E74656765722E
		IsInteger As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206E756D62657227732076616C75652E
		Value As Double
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
				"0 - EOF"
				"1 - EOL"
				"2 - Number"
				"3 - Underscore"
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
			Name="IsInteger"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
