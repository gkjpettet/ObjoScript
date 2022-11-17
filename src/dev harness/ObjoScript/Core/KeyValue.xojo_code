#tag Module
Protected Module KeyValue
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865204B657956616C756520636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the KeyValue class constructor.
		  ///
		  /// constructor()
		  /// constructor(key, value)
		  
		  If args.Count = 0 Then
		    instance.ForeignData = vm.Nothing : vm.Nothing
		  ElseIf args.Count = 2 Then
		    instance.ForeignData = args(0) : args(1)
		  Else
		    vm.Error("Invalid number of arguments (expected 0 or 2, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060426F6F6C65616E6020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Boolean` class or Nil if there is no such method.
		  
		  // All methods on `Boolean` are instance methods.
		  If isStatic Then Return Nil
		  
		  If signature.CompareCase("key()") Then
		    Return AddressOf GetKey
		    
		  ElseIf signature.CompareCase("key=(_)") Then
		    Return AddressOf SetKey
		    
		  ElseIf signature.CompareCase("value()") Then
		    Return AddressOf GetValue
		    
		  ElseIf signature.CompareCase("value=(_)") Then
		    Return AddressOf SetValue
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206B65792E
		Protected Sub GetKey(vm As ObjoScript.VM)
		  /// Returns the key.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a KeyValue instance.
		  ///
		  /// KeyValue.key() -> value
		  
		  vm.SetReturn(Pair(ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData).Left)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C75652E
		Protected Sub GetValue(vm As ObjoScript.VM)
		  /// Returns the value.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a KeyValue instance.
		  ///
		  /// KeyValue.value() -> value
		  
		  vm.SetReturn(Pair(ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData).Right)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5365747320746865206B65792E
		Protected Sub SetKey(vm As ObjoScript.VM)
		  /// Sets the key.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a KeyValue instance.
		  /// - Slot 1 is the new key.
		  ///
		  /// KeyValue.key=(k)
		  
		  Var kv As ObjoScript.Instance = vm.GetSlotValue(0)
		  kv.ForeignData = vm.GetSlotValue(1) :  Pair(kv.ForeignData).Right
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 53657473207468652076616C75652E
		Protected Sub SetValue(vm As ObjoScript.VM)
		  /// Sets the value.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a KeyValue instance.
		  /// - Slot 1 is the new value.
		  ///
		  /// KeyValue.value=(v)
		  
		  Var kv As ObjoScript.Instance = vm.GetSlotValue(0)
		  kv.ForeignData = Pair(kv.ForeignData).Left : vm.GetSlotValue(1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686973206B65792D76616C7565206173206120737472696E672028226B6579203A2076616C756522292E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns this key-value as a string ("key : value").
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Pair
		  ///
		  /// KeyValue.toString() -> string
		  
		  vm.SetReturn(vm.GetSlotAsString(0))
		  
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
