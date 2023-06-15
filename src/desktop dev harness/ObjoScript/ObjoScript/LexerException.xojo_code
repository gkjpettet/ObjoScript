#tag Class
Protected Class LexerException
Inherits RuntimeException
	#tag Property, Flags = &h0, Description = 4162736F6C75746520302D626173656420706F736974696F6E20696E2074686520736372697074206F6620746865207374617274206F6620746865206572726F722E
		AbsoluteStartPosition As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 302D626173656420706F736974696F6E206F6E20746865206C696E65206F6620746865206368617261637465722063617573696E6720746865206572726F722E
		LineCharacterPosition As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520312D6261736564206E756D626572206F662074686520736F7572636520636F6465206C696E6520746865206572726F72206F63637572726564206F6E2E
		LineNumber As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520286F7074696F6E616C29204944206F662074686520736372697074207468617420746865206572726F72206F6363757272656420696E2E
		ScriptID As Integer = -1
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Message"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="AbsoluteStartPosition"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineCharacterPosition"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
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
	#tag EndViewBehavior
End Class
#tag EndClass
