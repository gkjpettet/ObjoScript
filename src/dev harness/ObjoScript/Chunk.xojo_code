#tag Class
Protected Class Chunk
	#tag Method, Flags = &h0
		Sub Constructor()
		  Constants = New PrimitiveSet
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686973206368756E6B2773207261772062797465636F64652E
		Bytecode() As UInt8
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206368756E6B277320737472696E6720616E64206E756D6572696320636F6E7374616E74732E
		Constants As PrimitiveSet
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53746F72657320746865206C696E65206E756D62657220666F722074686520636F72726573706F6E64696E67206279746520696E206042797465636F64652829602E20
		Lines() As Integer
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
			Name="Bytecode()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
