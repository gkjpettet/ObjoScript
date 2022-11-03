#tag Module
Protected Module LibrarySystem
	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E20746865206053797374656D6020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `System` class or Nil if there is no such method.
		  
		  // All methods on `System` are static.
		  If Not isStatic Then Return Nil
		  
		  If signature.CompareCase("clock()") Then
		    Return AddressOf Clock
		    
		  ElseIf signature.CompareCase("print(_)") Then
		    Return AddressOf Print
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206D6963726F7365636F6E64732073696E63652074686520686F7374206170706C69636174696F6E20737461727465642E
		Protected Sub Clock(vm As ObjoScript.VM)
		  /// Returns the number of microseconds since the host application started.
		  ///
		  /// System.clock() -> double
		  
		  vm.SetReturn(System.Microseconds)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206D6963726F7365636F6E64732073696E63652074686520686F7374206170706C69636174696F6E20737461727465642E
		Protected Sub Print(vm As ObjoScript.VM)
		  /// Computes a string representation of the passed argument and raises the VM's 
		  /// Print event.
		  ///
		  /// System.print(what) -> string
		  
		  #Pragma Warning "TODO: Should we return the argument?"
		  
		  vm.RaisePrint(vm.GetSlotAsString(1))
		  
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
