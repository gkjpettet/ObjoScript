#tag Module
Protected Module Nothing
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520604E6F7468696E676020636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the `Nothing` class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Nothing class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604E6F7468696E676020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Nothing` class or Nil if there is no such method.
		  
		  // There are no static methods on the `Nothing` class.
		  If isStatic Then Return Nil
		  
		  If signature.CompareCase("not()") Then
		    Return AddressOf Not_
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		  End If
		   
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320747275652073696E636520606E6F7468696E676020697320636F6E736964657265642066616C73652E
		Protected Sub Not_(vm As ObjoScript.VM)
		  /// Returns true since `nothing` is considered false.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a nothing instance.
		  ///
		  /// Nothing.not() -> boolean
		  
		  vm.SetReturn(true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320226E6F7468696E67222E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns "nothing".
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a nothing instance.
		  ///
		  /// Nothing.toString() -> string
		  
		  vm.SetReturn("nothing")
		  
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
