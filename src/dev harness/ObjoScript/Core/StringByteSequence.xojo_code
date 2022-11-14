#tag Module
Protected Module StringByteSequence
	#tag Method, Flags = &h1, Description = 41206E657720537472696E674279746553657175656E636520696E7374616E6365206973206265696E6720616C6C6F63617465642E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// A new StringByteSequence instance is being allocated.
		  ///
		  /// constructor(string)
		  
		  If args.Count <> 1 Then
		    vm.Error("Invalid number of arguments (expected a string argument, got " + args.Count.ToString + ") arguments.")
		  Else
		    #Pragma Warning "TODO"
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060537472696E676020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `String` class or Nil if there is no such method.
		  
		  If isStatic Then
		    Return Nil
		    
		  Else
		    If signature = "[_]" Then
		      Return AddressOf Subscript
		      
		    ElseIf signature = "count()" Then
		      Return AddressOf Count
		      
		    ElseIf signature.CompareCase("iterate(_)") Then
		      Return AddressOf Iterate
		      
		    ElseIf signature.CompareCase("iteratorValue(_)") Then
		      Return AddressOf IteratorValue
		    End If
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206174207468652073706563696669656420696E6465782E
		Protected Sub Count(vm As ObjoScript.VM)
		  /// Returns the number of bytes in the string.
		  ///
		  /// Assumes slot 0 contains a StringByteSequence instance.
		  
		  #Pragma Warning "TODO"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the next value in the sequence.
		  ///
		  /// if `iter` is nothing then we should return the first item.
		  /// Assumes slot 0 contains a StringByteSequence instance.
		  /// StringByteSequence.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  #Pragma Warning "TODO"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E657874206974657261746F722076616C75652E
		Protected Sub IteratorValue(vm As ObjoScript.VM)
		  /// Returns the next iterator value.
		  ///
		  /// Assumes slot 0 contains a StringByteSequence instance.
		  /// We are ignoring `iter` here.
		  /// StringByte.iterator(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  #Pragma Warning "TODO"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206174207468652073706563696669656420696E6465782E
		Protected Sub Subscript(vm As ObjoScript.VM)
		  /// Returns the value at the specified index.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a StringByteSequence instance.
		  /// - Slot 1 is the index (needs to be an integer double).
		  /// StringByteSequence.[index]
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var rawIndex As Variant = vm.GetSlotValue(1)
		  
		  // The index must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(rawIndex) Then
		    vm.Error("Subscript index must be an integer.")
		  End If
		  Var index As Integer = rawIndex
		  
		  #Pragma Warning "TODO"
		  
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
