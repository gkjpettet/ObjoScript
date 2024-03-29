#tag Module
Protected Module Map
	#tag Method, Flags = &h1, Description = 41206E6577204D617020696E7374616E6365206973206265696E6720616C6C6F63617465642E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// A new Map instance is being allocated.
		  ///
		  /// constructor()
		  
		  If args.Count = 0 Then
		    instance.ForeignData = New ObjoScript.Core.Map.MapData
		  Else
		    vm.Error("Invalid number of arguments (expected 0, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662061204D617020696E7374616E63652E
		Protected Function AsString(map As ObjoScript.Instance) As String
		  /// Returns a string representation of a Map instance.
		  ///
		  /// Assumes `map` actually is a Map instance.
		  
		  Var data As ObjoScript.Core.Map.MapData = map.ForeignData
		  
		  Var s() As String
		  
		  For Each entry As DictionaryEntry In data.Dict
		    s.Add(ObjoScript.VM.StackValueToString(entry.Key) + " : " + ObjoScript.VM.StackValueToString(entry.Value))
		  Next entry
		  
		  Return "{" + String.FromArray(s, ", ") + "}"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604D61706020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Map` class or Nil if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52656D6F76657320616C6C20656E74726965732066726F6D20746865206D61702E
		Protected Sub Clear(vm As ObjoScript.VM)
		  /// Removes all entries from the map.
		  ///
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.clear() -> nothing
		  
		  Var map As ObjoScript.Instance = vm.GetSlotValue(0)
		  map.ForeignData = New ObjoScript.Core.Map.MapData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207472756520696620746865206D617020636F6E7461696E7320606B657960206F722066616C736520696620697420646F65736E27742E
		Protected Sub ContainsKey(vm As ObjoScript.VM)
		  /// Returns true if the map contains `key` or false if it doesn't.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Map instance.
		  /// - Slot 1 is the key.
		  /// Map.containsKey(key) -> boolean
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  Var key As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.Core.Map.MapData = instance.ForeignData
		  
		  vm.SetReturn(data.Dict.HasKey(key))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206B65797320696E20746865206D61702E
		Protected Sub Count(vm As ObjoScript.VM)
		  /// Returns the number of keys in the map.
		  ///
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.count() -> count
		  
		  Var data As ObjoScript.Core.Map.MapData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn(CType(data.Count, Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("clear()")          = AddressOf Clear
		  d.Value("containsKey(_)")   = AddressOf ContainsKey
		  d.Value("count()")          = AddressOf Count
		  d.Value("iterate(_)")       = AddressOf Iterate
		  d.Value("iteratorValue(_)") = AddressOf IteratorValue
		  d.Value("keys()")           = AddressOf Keys
		  d.Value("remove(_)")        = AddressOf Remove
		  d.Value("toString()")       = AddressOf ToString
		  d.Value("values()")         = AddressOf Values
		  d.Value("[_]=(_)")          = AddressOf SubscriptSetter
		  d.Value("[_]")              = AddressOf Subscript
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E732074686520696E64657820696E207468652064696374696F6E6172792773204B657973206172726179206F6620746865206E6578742076616C756520696E20746865206D61702E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the index in the 
		  /// dictionary's Keys array of the next value in the map.
		  ///
		  /// if `iter` is nothing then we should return the first index.
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  Var keys() As Variant = ObjoScript.Core.Map.MapData(instance.ForeignData).Dict.Keys
		  
		  If iter IsA ObjoScript.Nothing Then
		    // Return the index of the first key or false if the map is empty.
		    // Note we return `0.0` not `0` since the VM expects doubles on the stack.
		    If keys.Count = 0 Then
		      vm.SetReturn(False)
		    Else
		      vm.SetReturn(0.0)
		    End If
		    
		  Else
		    // If `iter <> nothing` then assert it's an integer.
		    If Not ObjoScript.VariantIsIntegerDouble(iter) Then
		      vm.Error("The iterator must be an integer.")
		    End If
		    
		    // Return the next index unless we've reached the end of the keys array when we return false.
		    If iter < 0 Or iter >= keys.LastIndex Then
		      vm.SetReturn(false)
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
		  /// - Slot 0 is a Map instance.
		  /// - Slot 1 is an integer.
		  ///
		  /// Uses `iter` to determine the next value in the iteration. It should be an index in the dictionary's Keys array.
		  /// Map.iteratorValue(iter) -> value
		  ///
		  /// Xojo guarantees that order of the keys in the backing dictionary is stable (at least until the dictionary is modified).
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  // `iter` must be an integer.
		  If Not ObjoScript.VariantIsIntegerDouble(iter) Then
		    vm.Error("The iterator must be an integer.")
		  End If
		  Var index As Integer = iter
		  
		  // Get the dictionary's keys.
		  Var keys() As Variant = ObjoScript.Core.Map.MapData(instance.ForeignData).Dict.Keys
		  
		  // Bounds check.
		  If index < 0 Or index > keys.LastIndex Then
		    vm.Error("The iterator is out of bounds.")
		  End If
		  
		  // Create a new KeyValue instance.
		  Var kv As New ObjoScript.Instance(vm, vm.KeyValueClass)
		  kv.ForeignData = keys(index) : ObjoScript.Core.Map.MapData(instance.ForeignData).Dict.Value(keys(index))
		  
		  // Return the KeyValue instance.
		  vm.SetReturn(kv)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C69737420636F6E7461696E696E672074686973206D61702773206B6579732E20546865206F72646572206F6620746865206B65797320697320756E646566696E6564206275742069742069732067756172616E74656564207468617420616C6C206B6579732077696C6C2062652072657475726E65642E
		Protected Sub Keys(vm As ObjoScript.VM)
		  /// Returns a list containing this map's keys. The order of the keys is undefined but it is 
		  /// guaranteed that all keys will be returned.
		  ///
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.keys() -> List
		  
		  Var map As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var data As Dictionary = ObjoScript.Core.Map.MapData(map.ForeignData).Dict
		  
		  // Return a new list instance containing the map's keys.
		  vm.SetReturn(vm.NewList(data.Keys))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52656D6F76657320606B65796020616E64207468652076616C7565206173736F63696174656420776974682069742066726F6D20746865206D61702E2052657475726E73207468652076616C75652E20496620606B65796020776173206E6F742070726573656E742C2072657475726E73206E6F7468696E672E
		Protected Sub Remove(vm As ObjoScript.VM)
		  /// Removes `key` and the value associated with it from the map. Returns the value.
		  /// If `key` was not present, returns nothing.
		  ///
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.remove(key) -> value or nothing
		  
		  Var data As ObjoScript.Core.Map.MapData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  Var key As Variant = vm.GetSlotValue(1)
		  
		  If data.Dict.HasKey(key) Then
		    Var value As Variant = data.Dict.Value(key)
		    data.Dict.Remove(key)
		    Core.SetReturn(vm, value)
		  Else
		    Core.SetReturn(vm, vm.Nothing)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C756520666F722074686520737065636966696564206B65792E
		Protected Sub Subscript(vm As ObjoScript.VM)
		  /// Returns the value for the specified key.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Map instance.
		  /// - Slot 1 is the key.
		  /// Map.[key]
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  Var key As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.Core.Map.MapData = instance.ForeignData
		  
		  Var value As Variant = data.Dict.Lookup(key, vm.Nothing)
		  
		  Core.SetReturn(vm, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 41737369676E7320612076616C756520746F206120737065636966696564206B65792E
		Protected Sub SubscriptSetter(vm As ObjoScript.VM)
		  /// Assigns a value to a specified key.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Map instance.
		  /// - Slot 1 is the key.
		  /// - Slot 2 is the value to assign.
		  /// Map.[key]=(value)
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  Var key As Variant = vm.GetSlotValue(1)
		  
		  Var value As Variant = vm.GetSlotValue(2)
		  
		  Var data As ObjoScript.Core.Map.MapData = instance.ForeignData
		  
		  data.Dict.Value(key) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686973206D61702E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns a string representation of this map.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Map instance.
		  /// Map.toString -> String
		  
		  vm.SetReturn(AsString(vm.GetSlotValue(0)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C69737420636F6E7461696E696E672074686973206D61702773206B6579732E20546865206F72646572206F6620746865206B65797320697320756E646566696E6564206275742069742069732067756172616E74656564207468617420616C6C206B6579732077696C6C2062652072657475726E65642E
		Protected Sub Values(vm As ObjoScript.VM)
		  /// Returns a list containing this map's values. The order of the values is undefined but it is 
		  /// guaranteed that all values will be returned.
		  ///
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.values() -> List
		  
		  Var map As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var data As Dictionary = ObjoScript.Core.Map.MapData(map.ForeignData).Dict
		  
		  // Return a new list instance containing the map's values.
		  vm.SetReturn(vm.NewList(data.Values))
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20696E7374616E6365206D6574686F647320646566696E6564206F6E20746865204D617020636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseInstanceMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected InstanceMethods As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E20746865204D617020636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseStaticMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected StaticMethods As Dictionary
	#tag EndComputedProperty


	#tag Constant, Name = Untitled, Type = , Dynamic = False, Default = \"", Scope = Protected
	#tag EndConstant


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
