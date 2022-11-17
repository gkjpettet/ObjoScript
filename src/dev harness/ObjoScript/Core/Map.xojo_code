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

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604D61706020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Map` class or Nil if there is no such method.
		  
		  #Pragma Warning "TODO: Add more methods"
		  
		  #Pragma Unused isStatic
		  
		  If signature.CompareCase("count()") Then
		    Return AddressOf Count
		    
		  ElseIf signature.CompareCase("iterate(_)") Then
		    Return AddressOf Iterate
		    
		  ElseIf signature.CompareCase("iteratorValue(_)") Then
		    Return AddressOf IteratorValue
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		    
		  ElseIf signature = "[_]=(_)" Then
		    Return AddressOf SubscriptSetter
		    
		  ElseIf signature = "[_]" Then
		    Return AddressOf Subscript
		  End If
		  
		End Function
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

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F726520656E747269657320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more entries to iterate or returns the next value in the sequence.
		  ///
		  /// if `iter` is nothing then we should return the first entry.
		  /// Assumes slot 0 contains a Map instance.
		  /// Map.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.Core.Map.MapData = instance.ForeignData
		  
		  If iter IsA ObjoScript.Nothing Then // Return the first entry.
		    If data.Dict.KeyCount = 0 Then
		      // This is an empty map.
		      data.NextValue = False
		    Else
		      data.Index = 0
		      Var kv As New ObjoScript.Instance(vm, vm.KeyValueClass)
		      Var key As Variant = data.Dict.Key(data.Index)
		      kv.ForeignData = key : data.Dict.Value(key)
		      data.NextValue = kv
		    End If
		    
		  Else // Return the next entry.
		    data.Index = data.Index + 1
		    If data.Index <= data.Dict.KeyCount - 1 Then
		      Var kv As New ObjoScript.Instance(vm, vm.KeyValueClass)
		      Var key As Variant = data.Dict.Key(data.Index)
		      kv.ForeignData = key : data.Dict.Value(key)
		      data.NextValue = kv
		    Else
		      data.Index = -1
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
		  /// Assumes slot 0 contains a Map instance.
		  /// We are ignoring `iter` here.
		  /// Map.iterator(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  vm.SetReturn(ObjoScript.Core.Map.MapData(instance.ForeignData).NextValue)
		  
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
		  
		  vm.SetReturn(value)
		  
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
		  
		  Var data As ObjoScript.Core.Map.MapData = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
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
