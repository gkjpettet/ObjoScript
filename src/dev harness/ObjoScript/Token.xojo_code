#tag Class
Protected Class Token
	#tag Method, Flags = &h0, Description = 41206E657720746F6B656E206F662060747970656020626567696E6E696E672061742073637269707420607374617274506F7360206F6E20606C696E654E756D62657260207769746820616E206F7074696F6E616C20606C6578656D656020616E6420607363726970744944602E
		Sub Constructor(type As TokenTypes, startPos As Integer, lineNumber As Integer, lexeme As String = "", scriptID As Integer = -1)
		  /// A new token of `type` beginning at script `startPos` on `lineNumber` with an 
		  /// optional `lexeme` and `scriptID`.
		  
		  Self.Type = type
		  Self.StartPosition = startPos
		  Self.LineNumber = lineNumber
		  Self.Lexeme = lexeme
		  Self.ScriptID = scriptID
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652061637475616C2063686172616374657273206F66207468697320746F6B656E2E204E6F7420657665727920746F6B656E2070726F76696465732061206C6578656D652E
		Lexeme As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520312D6261736564206C696E65206E756D6265722074686174207468697320746F6B656E206F6363757273206F6E2E
		LineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C204944206F662074686520736372697074207468697320746F6B656E206F63637572732077697468696E2E
		ScriptID As Integer = -1
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lexeme"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
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
	#tag EndViewBehavior
End Class
#tag EndClass
