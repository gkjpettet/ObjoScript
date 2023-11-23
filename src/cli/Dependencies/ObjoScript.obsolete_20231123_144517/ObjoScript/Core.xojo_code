#tag Module
Protected Module Core
	#tag Method, Flags = &h1, Description = 436F6E76656E69656E6365206D6574686F6420666F722073657474696E67207468652072657475726E2076616C7565206F66206120564D207768656E207468652076616C7565206973206F6E6C79206B6E6F776E20746F20626520612056617269616E742E
		Protected Sub SetReturn(vm As ObjoScript.VM, value As Variant)
		  /// Convenience method for setting the return value of a VM when the value is only known to be a Variant.
		  
		  Select Case value.Type
		  Case Variant.TypeString
		    vm.SetReturn(value.StringValue)
		    
		  Case Variant.TypeDouble
		    vm.SetReturn(value.DoubleValue)
		    
		  Case Variant.TypeBoolean
		    vm.SetReturn(value.BooleanValue)
		    
		  Else
		    If value IsA ObjoScript.Value Then
		      vm.SetReturn(ObjoScript.Value(value))
		    Else
		      vm.Error("Unable to set return value as expected Double, Boolean, String or ObjoScript.Value.")
		    End If
		  End Select
		End Sub
	#tag EndMethod


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
