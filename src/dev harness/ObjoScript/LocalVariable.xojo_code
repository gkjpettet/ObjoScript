#tag Class
Protected Class LocalVariable
	#tag Method, Flags = &h0
		Sub Constructor(identifier As ObjoScript.Token, depth As Integer)
		  Self.Identifier = identifier
		  Self.Depth = depth
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a local variable in the compiler.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652073636F7065206465707468206F662074686520626C6F636B2074686973207661726961626C6520776173206465636C617265642077697468696E2E20602D316020696E6469636174657320746865207661726961626C6520686173206E6F7420796574206265656E20696E697469616C697365642E
		Depth As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746F6B656E20696E2074686520736F7572636520636F646520726570726573656E74696E672074686973206C6F63616C207661726961626C652773206E616D6520286964656E746966696572292E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686973206C6F63616C207661726961626C652773206E616D652E
		#tag Getter
			Get
			  Return Identifier.Lexeme
			End Get
		#tag EndGetter
		Name As String
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
