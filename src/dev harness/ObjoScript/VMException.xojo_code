#tag Class
Protected Class VMException
Inherits RuntimeException
	#tag Method, Flags = &h0
		Sub Constructor(message As String, lineNumber As Integer, scriptID As Integer = -1)
		  Super.Constructor(message)
		  
		  Self.LineNumber = lineNumber
		  Self.ScriptID = scriptID
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206C696E65206E756D6265722074726967676572696E67207468697320564D20657863657074696F6E2E
		LineNumber As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865204944206F6620746865207363726970742074726967676572696E67207468697320564D20657863657074696F6E2E
		ScriptID As Integer = 0
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
