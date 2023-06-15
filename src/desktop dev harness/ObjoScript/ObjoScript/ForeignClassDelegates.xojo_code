#tag Class
Protected Class ForeignClassDelegates
	#tag Method, Flags = &h0
		Sub Constructor(allocate As ObjoScript.ForeignAllocateDelegate, destroy As ObjoScript.ForeignDestroyDelegate)
		  If allocate = Nil Then
		    Raise New InvalidArgumentException("The `Allocate` delegate must not be Nil.")
		  End If
		  
		  Self.Allocate = allocate
		  Self.Destroy = destroy
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		These methods are invoked by the VM when interacting with foreign classes.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5768656E657665722061206E657720696E7374616E6365206F66207468697320666F726569676E20636C61737320697320637265617465642C2074686973206D6574686F6420697320696E766F6B65642E
		Allocate As ObjoScript.ForeignAllocateDelegate
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4D6179206265204E696C2E2049662070726573656E742C20746869732077696C6C20626520696E766F6B6564207768656E6576657220616E20696E7374616E6365206F662074686520666F726569676E20636C6173732069732064657374726F7965642062792074686520586F6A6F206672616D65776F726B2E
		Destroy As ObjoScript.ForeignDestroyDelegate
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
