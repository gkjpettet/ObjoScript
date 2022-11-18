#tag Module
Protected Module Number
	#tag Method, Flags = &h1, Description = 52657475726E73207468652073717561726520726F6F74206F6620746865206E756D6265722E
		Protected Sub Add(vm As ObjoScript.VM)
		  /// Converts this number to a string and adds a value to it.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Note: Number + Number is handled within the VM for performance reasons.
		  /// Number.+(value) -> string
		  
		  Var d As Variant = vm.GetSlotValue(0)
		  Var s As String
		  
		  // Format integers nicely.
		  If d.DoubleValue.IsInteger Then
		    s = d.IntegerValue.ToString
		  Else
		    s = d.DoubleValue.ToString(Locale.Current, "#.#########")
		  End If
		  
		  vm.SetReturn(s + vm.GetSlotAsString(1))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865204E756D62657220636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the Number class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Number class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604E756D6265726020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Number` class or Nil if there is no such method.
		  
		  If isStatic Then
		    
		  Else
		    // INSTANCE METHODS
		    If signature = "+(_)" Then
		      Return AddressOf Add
		      
		    ElseIf signature = "<(_)" Then
		      Return AddressOf Less
		      
		    ElseIf signature = "<=(_)" Then
		      Return AddressOf LessEqual
		      
		    ElseIf signature = ">(_)" Then
		      Return AddressOf Greater
		      
		    ElseIf signature = ">=(_)" Then
		      Return AddressOf GreaterEqual
		      
		    ElseIf signature.CompareCase("sqrt()") Then
		      Return AddressOf Sqrt_
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203E20606F74686572602E
		Protected Sub Greater(vm As ObjoScript.VM)
		  /// Returns `true` if this is > `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.>(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `>(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203E3D20606F74686572602E
		Protected Sub GreaterEqual(vm As ObjoScript.VM)
		  /// Returns `true` if this is >= `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.>=(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `>=(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203C20606F74686572602E
		Protected Sub Less(vm As ObjoScript.VM)
		  /// Returns `true` if this is < `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.<(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `<(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203C3D20606F74686572602E
		Protected Sub LessEqual(vm As ObjoScript.VM)
		  /// Returns `true` if this is <= `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.<=(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `<=(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073717561726520726F6F74206F6620746865206E756D6265722E
		Protected Sub Sqrt_(vm As ObjoScript.VM)
		  /// Returns the square root of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.sqrt() -> double
		  
		  vm.SetReturn(Sqrt(vm.GetSlotValue(0)))
		  
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
