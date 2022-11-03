#tag Module
Protected Module List
	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Add(vm As ObjoScript.VM)
		  /// Appends an item to the end of the list. Returns the added item.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// - Slot 1 is the item to append.
		  /// List.add(item) -> item
		  
		  Var item As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  data.Items.Add(item)
		  
		  vm.SetReturn(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 41206E6577204C69737420696E7374616E6365206973206265696E6720616C6C6F63617465642E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// A new List instance is being allocated.
		  ///
		  /// constructor()
		  
		  If args.Count = 0 Then
		    instance.ForeignData = New ObjoScript.LibraryCore.List.ListData
		  Else
		    vm.Error("Invalid number of arguments (expected 0, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604C6973746020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `List` class or Nil if there is no such method.
		  
		  #Pragma Unused isStatic
		  
		  If signature.CompareCase("add(_)") Then
		    Return AddressOf Add
		    
		  ElseIf signature.CompareCase("count()") Then
		    Return AddressOf Count
		    
		  ElseIf signature.CompareCase("iterate(_)") Then
		    Return AddressOf Iterate
		    
		  ElseIf signature.CompareCase("iteratorValue(_)") Then
		    Return AddressOf IteratorValue
		    
		  ElseIf signature.CompareCase("removeAt(_)") Then
		    Return AddressOf RemoveAt
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		    
		  ElseIf signature = "[_]=(_)" Then
		    Return AddressOf SubscriptSetter
		    
		  ElseIf signature = "[_]" Then
		    Return AddressOf Subscript
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206974656D7320696E20746865206C6973742E
		Protected Sub Count(vm As ObjoScript.VM)
		  /// Returns the number of items in the list.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// List.count() -> count
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn(CType(data.Items.Count, Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the next value in the sequence.
		  ///
		  /// if `iter` is nothing then we should return the first item.
		  /// Assumes slot 0 contains a List instance.
		  /// List.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = instance.ForeignData
		  
		  If iter IsA ObjoScript.Nothing Then
		    // Return the first item.
		    If data.Items.Count = 0 Then
		      // This is an empty list.
		      data.NextValue = False
		    Else
		      data.Index = 0
		      data.NextValue = data.Items(0)
		    End If
		  Else
		    // Return the next element.
		    data.Index = data.Index + 1.0
		    If data.Index <= data.Items.LastIndex Then
		      data.NextValue = data.Items(data.Index)
		    Else
		      data.NextValue = False
		    End If
		  End If
		  
		  vm.SetReturn(data.NextValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E657874206974657261746F722076616C75652E
		Protected Sub IteratorValue(vm As ObjoScript.VM)
		  /// Returns the next iterator value.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// We are ignoring `iter` here.
		  /// List.iterator(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  vm.SetReturn(ObjoScript.LibraryCore.List.ListData(instance.ForeignData).NextValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub RemoveAt(vm As ObjoScript.VM)
		  /// Removes the element at `index`.
		  /// Returns the removed value.
		  ///
		  /// If `index` is negative it counts backwards from the end of the list where `-1` is the last element.
		  /// Elements are shifted up to fill in where the removed element was.
		  /// It is a runtime error if `index` is not an integer or is out of bounds.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// - Slot 1 is the index.
		  /// List.removeAt(index) -> item
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  // Determine the index, accounting for backwards counting.
		  Var index As Integer = vm.GetSlotValue(1)
		  index = If(index >= 0, index, data.Count + index)
		  
		  // Bounds check.
		  If index > data.LastIndex Then
		    vm.Error("List index is out of bounds.")
		  End If
		  
		  // Remove the item.
		  Var item As Variant = data.Items(index)
		  data.Items.RemoveAt(index)
		  
		  // Return the removed item.
		  vm.SetReturn(item)
		  
		  Exception e1 As IllegalCastException
		    vm.Error("Expected an integer index.")
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Subscript(vm As ObjoScript.VM)
		  /// Returns the value at the specified index.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// - Slot 1 is the index (needs to be an integer double).
		  /// List.[index]
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var rawIndex As Variant = vm.GetSlotValue(1)
		  
		  // The index must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(rawIndex) Then
		    vm.Error("Subscript index must be an integer.")
		  End If
		  Var index As Integer = rawIndex
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = instance.ForeignData
		  
		  // Bounds check.
		  If index < 0 Then
		    vm.Error("Subscript index must be >= 0.")
		  ElseIf index > data.Items.LastIndex Then
		    vm.Error("Subscript index out of bounds (" + index.ToString + ").")
		  End If
		  
		  vm.SetReturn(data.Items(index))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub SubscriptSetter(vm As ObjoScript.VM)
		  /// Assigns a value to a specified index.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// - Slot 1 is the index (needs to be an integer double).
		  /// - Slot 2 is the value to assign.
		  /// List.[index]=(value)
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var rawIndex As Variant = vm.GetSlotValue(1)
		  Var value As Variant = vm.GetSlotValue(2)
		  
		  // The index must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(rawIndex) Then
		    vm.Error("Subscript index must be an integer.")
		  End If
		  Var index As Integer = rawIndex
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = instance.ForeignData
		  
		  // Bounds check.
		  If index < 0 Then
		    vm.Error("Subscript index must be >= 0.")
		  ElseIf index > data.Items.LastIndex Then
		    vm.Error("Subscript index out of bounds (" + index.ToString + ").")
		  End If
		  
		  data.Items(index) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320617272617920696E2074686520666F726D61743A20225B6974656D312C206974656D4E5D222E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns a string representation of this array in the format: "[item1, itemN]".
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// List.toString -> String
		  
		  Var data As ObjoScript.LibraryCore.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn(data.ToString)
		  
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
