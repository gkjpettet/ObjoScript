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
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
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
		    instance.ForeignData = New ObjoScript.Core.List.ListData
		  Else
		    vm.Error("Invalid number of arguments (expected 0, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686520606C6973746020696E2074686520666F726D61743A20225B6974656D312C206974656D4E5D222E
		Protected Function AsString(list As ObjoScript.Instance) As String
		  /// Returns a string representation of the `list` in the format: "[item1, itemN]".
		  ///
		  /// Assumes `list` is a List instance.
		  
		  Var items() As Variant = ObjoScript.Core.List.ListData(list.ForeignData).Items
		  Var s() As String
		  
		  For Each item As Variant In items
		    s.Add(ObjoScript.VM.ValueToString(item))
		  Next item
		  
		  Return "[" + String.FromArray(s, ", ") + "]"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604C6973746020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `List` class or Nil if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52656D6F76657320616C6C20656C656D656E74732066726F6D20746865206C6973742E
		Protected Sub Clear(vm As ObjoScript.VM)
		  /// Removes all elements from the list.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// List.clear() -> nothing
		  
		  ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData = New ObjoScript.Core.List.ListData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061207368616C6C6F7720636C6F6E65206F662074686973206C6973742E
		Protected Sub Clone(vm As ObjoScript.VM)
		  /// Returns a shallow clone of this list.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// List.clone() -> List
		  
		  vm.SetReturn(CloneList(vm.GetSlotValue(0), vm))
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732061207368616C6C6F7720636C6F6E65206F662074686973206C6973742E
		Private Function CloneList(list As ObjoScript.Instance, vm As ObjoScript.VM) As ObjoScript.Instance
		  /// Returns a shallow clone of `list`.
		  /// Assumes `list` is a List instance.
		  
		  Var data As ObjoScript.Core.List.ListData = list.ForeignData
		  
		  Var newList As New ObjoScript.Instance(vm, vm.ListClass)
		  Var newListData As New ObjoScript.Core.List.ListData
		  
		  For Each item As Variant In data.Items
		    newListData.Items.Add(item)
		  Next item
		  
		  newList.ForeignData = newListData
		  
		  Return newList
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206974656D7320696E20746865206C6973742E
		Protected Sub Count(vm As ObjoScript.VM)
		  /// Returns the number of items in the list.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// List.count() -> count
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn(CType(data.Items.Count, Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 437265617465732061206E6577206C6973742077697468206073697A656020656C656D656E74732C20616C6C2073657420746F2060656C656D656E74602E
		Protected Sub Filled(vm As ObjoScript.VM)
		  /// Creates a new list with `size` elements, all set to `element`.
		  ///
		  /// Setup:
		  /// - Slot 0 is the List class.
		  /// - Slot 1 should be a non-negative integer (runtime error otherwise).
		  /// - Slot 2 is the element to replicate.
		  /// List.filled(size, element) -> List instance
		  
		  #Pragma BreakOnExceptions False
		  
		  Var size As Variant = vm.GetSlotValue(1)
		  Var element As Variant = vm.GetSlotValue(2)
		  
		  // Assert index is a non-negative integer.
		  If Not ObjoScript.VariantIsIntegerDouble(size) Then
		    vm.Error("Size must be an integer.")
		    If size < 0 Then
		      vm.Error("Size cannot be negative.")
		    End If
		  End If
		  
		  // Create the list.
		  Var list As New ObjoScript.Instance(vm, vm.ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  For i As Integer = 1 To size
		    ObjoScript.Core.List.ListData(list.ForeignData).Items.Add(element)
		  Next i
		  
		  // Return the new list.
		  vm.SetReturn(list)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520696E646578206F66206076616C75656020696E20746865206C6973742C20696620666F756E642E204966206E6F7420666F756E642069742072657475726E7320602D31602E
		Protected Sub IndexOf(vm As ObjoScript.VM)
		  /// Returns the index of `value` in the list, if found. If not found it returns `-1`.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a List instance.
		  /// - Slot 1 is the value.
		  /// List.indexOf(value) -> number
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn( CType(data.Items.IndexOf(vm.GetSlotValue(1)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("add(_)")           = AddressOf Add
		  d.Value("clear()")          = AddressOf Clear
		  d.Value("clone()")          = AddressOf Clone
		  d.Value("count()")          = AddressOf Count
		  d.Value("indexOf(_)")       = AddressOf IndexOf
		  d.Value("insert(_,_)")      = AddressOf Insert
		  d.Value("iterate(_)")       = AddressOf Iterate
		  d.Value("iteratorValue(_)") = AddressOf IteratorValue
		  d.Value("remove(_)")        = AddressOf Remove
		  d.Value("removeAt(_)")      = AddressOf RemoveAt
		  d.Value("swap(_,_)")        = AddressOf Swap
		  d.Value("toString()")       = AddressOf ToString
		  d.Value("[_]=(_)")          = AddressOf SubscriptSetter
		  d.Value("[_]")              = AddressOf Subscript
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("filled(_,_)") = AddressOf Filled
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 496E736572747320606974656D602061742060696E6465786020696E20746865206C69737420616E642072657475726E732074686520696E736572746564206974656D2E
		Protected Sub Insert(vm As ObjoScript.VM)
		  /// Inserts `item` at `index` in the list and returns the inserted item.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a List instance.
		  /// - Slot 1 is the index to insert at.
		  /// - Slot 2 is the item to insert.
		  ///
		  /// List.insert(index, item) -> item
		  ///
		  /// The index may be one past the last index in the list to append an element.
		  /// If `index` is < 0 it counts backwards from the end of the list. It bases the
		  /// computation on the length of the list after inserted the element, so 
		  /// that -1 will append the element, not insert it before the last element.
		  ///
		  /// If `index` is not an integer or is out of bounds, a runtime error occurs.
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  // Get `index` and assert it's an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(1)) Then
		    vm.Error("Index must be an integer.")
		  End
		  Var index As Integer = vm.GetSlotValue(1)
		  
		  // Get the value to insert.
		  Var value As Variant = vm.GetSlotValue(2)
		  
		  // Append?
		  If index = data.LastIndex + 1 Then
		    data.Items.Add(value)
		    vm.SetReturn(value)
		    Return
		  End If
		  
		  // Assert `index` is within bounds and recompute if necessary.
		  If index > data.LastIndex + 1 Then
		    vm.Error("Index is out of bounds.")
		  ElseIf index < 0 Then
		    If Abs(index) > data.Count + 1 Then
		      vm.Error("Index is out of bounds.")
		    Else
		      index = data.Count + index + 1
		    End If
		  End If
		  
		  data.Items.AddAt(index, value)
		  
		  vm.SetReturn(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E732074686520696E64657820696E20746865206172726179206F6620746865206E6578742076616C756520696E20746865206C6973742E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the index in the array 
		  /// of the next value in the list.
		  ///
		  /// if `iter` is nothing then we should return the first index.
		  /// Assumes slot 0 contains a List instance.
		  /// List.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  Var data As ObjoScript.Core.List.ListData = instance.ForeignData
		  
		  If iter IsA ObjoScript.Nothing Then
		    // Return the index of the first item or false if the list is empty.
		    // Note we return `0.0` not `0` since the VM expects doubles on the stack.
		    If data.Items.Count = 0 Then
		      vm.SetReturn(False)
		    Else
		      vm.SetReturn(0.0)
		    End If
		    
		  Else
		    // If `iter <> nothing` then assert it's an integer.
		    If Not ObjoScript.VariantIsIntegerDouble(iter) Then
		      vm.Error("The iterator must must be an integer.")
		    End If
		    
		    // Return the next index unless we've reached the end of the array when we return false.
		    If iter < 0 Or iter >= data.LastIndex Then
		      vm.SetReturn(False)
		    Else
		      vm.SetReturn(iter.DoubleValue + 1.0)
		    End If
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E657874206974657261746F722076616C75652E
		Protected Sub IteratorValue(vm As ObjoScript.VM)
		  /// Returns the next iterator value.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a List instance.
		  /// - Slot 1 is an integer.
		  ///
		  /// Uses `iter` to determine the next value in the iteration. It should be an index in the array.
		  /// List.iteratorValue(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  // `iter` must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(iter) Then
		    vm.Error("The iterator must must be an integer.")
		  End If
		  Var index As Integer = iter
		  
		  Var data As ObjoScript.Core.List.ListData = instance.ForeignData
		  
		  If index < 0 Or index > data.LastIndex Then
		    vm.Error("The iterator is out of bounds.")
		  End If
		  
		  vm.SetReturn(ObjoScript.Core.List.ListData(instance.ForeignData).Items(index))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52656D6F766573207468652066697273742076616C756520666F756E642074686174206D6174636865732074686520676976656E206076616C7565602E20547261696C696E6720656C656D656E747320617265207368696674656420757020746F2066696C6C20696E207768657265207468652072656D6F76656420656C656D656E74207761732E2052657475726E73207468652072656D6F7665642076616C756520696620666F756E64206F72206E6F7468696E67206966206E6F7420666F756E642E
		Protected Sub Remove(vm As ObjoScript.VM)
		  /// Removes the first value found that matches the given `value`.
		  /// Trailing elements are shifted up to fill in where the removed element was.
		  /// Returns the removed value if found or nothing if not found.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a List instance.
		  /// - Slot 1 is the value.
		  /// List.remove(value) -> value or nothing
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  Var value As Variant = vm.GetSlotValue(1)
		  Var index As Integer = data.Items.IndexOf(value)
		  
		  If index = -1 Then
		    vm.SetReturn(vm.Nothing)
		  Else
		    data.Items.RemoveAt(index)
		    vm.SetReturn(value)
		  End If
		  
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
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  // Get `index` and assert it's an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(1)) Then
		    vm.Error("Index must be an integer.")
		  End
		  Var index As Integer = vm.GetSlotValue(1)
		  
		  // Adjust `index`, accounting for backwards counting.
		  index = If(index >= 0, index, data.Count + index)
		  
		  // Bounds check.
		  If index > data.LastIndex Or index < 0 Then
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
		  Var arg As Variant = vm.GetSlotValue(1)
		  
		  // The index must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(arg) Then
		    vm.Error("Subscript index must be an integer.")
		  End If
		  Var index As Integer = arg
		  
		  Var data As ObjoScript.Core.List.ListData = instance.ForeignData
		  
		  // Adjust `index`, accounting for backwards counting.
		  index = If(index >= 0, index, data.Count + index)
		  
		  // Bounds check.
		  If index > data.LastIndex Or index < 0 Then
		    vm.Error("List index is out of bounds.")
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
		  
		  Var data As ObjoScript.Core.List.ListData = instance.ForeignData
		  
		  // Bounds check.
		  If index < 0 Then
		    vm.Error("Subscript index must be >= 0.")
		  ElseIf index > data.Items.LastIndex Then
		    vm.Error("Subscript index out of bounds (" + index.ToString + ").")
		  End If
		  
		  data.Items(index) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 53776170732076616C75657320696E7369646520746865206C6973742061726F756E642E2050757473207468652076616C75652066726F6D2060696E646578306020696E2060696E646578316020616E64207468652076616C75652066726F6D2060696E64657831602061742060696E646578306020696E20746865206C6973742E
		Protected Sub Swap(vm As ObjoScript.VM)
		  /// Swaps values inside the list around. Puts the value from `index0` in `index1`
		  /// and the value from `index1` at `index0` in the list.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a List instance.
		  /// - Slot 1 is `index0`
		  /// - Slot 2 is `index1`
		  ///
		  /// List.swap(index0, index1) -> nothing
		  
		  Var data As ObjoScript.Core.List.ListData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  // Get the indexes and assert they are both integers.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(1)) Then
		    vm.Error("Index0 must be an integer.")
		  End
		  Var index0 As Integer = vm.GetSlotValue(1)
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(2)) Then
		    vm.Error("Index1 must be an integer.")
		  End
		  Var index1 As Integer = vm.GetSlotValue(2)
		  
		  // Bounds check.
		  If index0 < 0 Or index0 > data.LastIndex Then
		    vm.Error("Index0 is out of bounds.")
		  ElseIf index1 < 0 Or index1 > data.LastIndex Then
		    vm.Error("Index1 is out of bounds.")
		  End If
		  
		  // Swap.
		  Var tmp As Variant = data.Items(index0)
		  data.Items(index0) = data.Items(index1)
		  data.Items(index1) = tmp
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320617272617920696E2074686520666F726D61743A20225B6974656D312C206974656D4E5D222E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns a string representation of this array in the format: "[item1, itemN]".
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a List instance.
		  /// List.toString -> String
		  
		  vm.SetReturn(AsString(vm.GetSlotValue(0)))
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20696E7374616E6365206D6574686F647320646566696E6564206F6E20746865204C69737420636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseInstanceMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected InstanceMethods As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E20746865204C69737420636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseStaticMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected StaticMethods As Dictionary
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
End Module
#tag EndModule
