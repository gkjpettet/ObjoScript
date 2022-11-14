#tag Module
Protected Module String_
	#tag Method, Flags = &h1, Description = 436F6E636174656E61746573207468697320737472696E6720776974682074686520617267756D656E7420696E20736C6F74203120616E642072657475726E732074686520726573756C742E
		Protected Sub Add(vm As ObjoScript.VM)
		  /// Concatenates this string with the argument in slot 1 and returns the result.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is value to append.
		  ///
		  /// String.+(other) -> string
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s + vm.GetSlotAsString(1))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520537472696E6720636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the String class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The String class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E6720626567696E7320776974682060707265666978602E
		Protected Sub BeginsWith(vm As ObjoScript.VM)
		  /// Returns True if the string begins with `prefix`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the prefix to check for.
		  ///
		  /// String.beginsWith(prefix) -> boolean
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s.BeginsWith(vm.GetSlotAsString(1), ComparisonOptions.CaseSensitive))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060537472696E676020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `String` class or Nil if there is no such method.
		  
		  If isStatic Then
		    
		  Else
		    If signature = "+(_)" Then
		      Return AddressOf Add
		      
		    ElseIf signature.CompareCase("beginsWith(_)") Then
		      Return AddressOf BeginsWith
		      
		    ElseIf signature.CompareCase("bytes()") Then
		      Return AddressOf Bytes
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E6720626567696E7320776974682060707265666978602E
		Protected Sub Bytes(vm As ObjoScript.VM)
		  /// Returns a sequence that can be used to access the raw bytes of this string.
		  ///
		  /// Ignores encoding.
		  /// In addition to the methods provided by the `Sequence` class, the returned 
		  /// object also has a subscript operator that can be used to directly index bytes.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.bytes() -> StringByteSequence
		  
		  // Get the string.
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Put the class name in slot 0.
		  vm.SetSlot(0, "StringByteSequence")
		  
		  // Put the single parameter in slot 1.
		  vm.SetSlot(1, s)
		  
		  // Create the instance. It will be placed in slot 0.
		  vm.NewInstance(1)
		  
		  // Return the instance.
		  vm.SetReturn(vm.GetSlotValue(0))
		  
		  
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
