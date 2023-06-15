#tag Module
Protected Module System_
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865206053797374656D6020636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the `System` class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("You cannot instantiate the System class.")
		End Sub
	#tag EndMethod

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

	#tag Method, Flags = &h1, Description = 436F6D7075746573206120737472696E6720726570726573656E746174696F6E206F66207468652070617373656420617267756D656E7420616E64207261697365732074686520564D2773205072696E74206576656E742E2052657475726E73207468652076616C7565207072696E7465642E
		Protected Sub Print(vm As ObjoScript.VM)
		  /// Computes a string representation of the passed argument and raises the VM's 
		  /// Print event. Returns the value printed.
		  ///
		  /// System.print(what) -> what
		  
		  vm.RaisePrint(vm.GetSlotAsString(1))
		  
		  // Return the value printed.
		  Core.SetReturn(vm, vm.GetSlotValue(1))
		  
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
