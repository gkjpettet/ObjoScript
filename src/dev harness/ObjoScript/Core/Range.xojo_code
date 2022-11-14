#tag Module
Protected Module Range
	#tag Method, Flags = &h1, Description = 41206E65772052616E676520696E7374616E6365206973206265696E6720616C6C6F63617465642E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// A new Range instance is being allocated.
		  ///
		  /// constructor()
		  /// constructor(lower, upper)
		  
		  If args.Count = 0 Then
		    instance.ForeignData = New RangeData(0, 0)
		    
		  ElseIf args.Count = 2 Then
		    // Ensure we've been passed two numbers.
		    If args(0).Type <> Variant.TypeDouble Then
		      vm.Error("The `lower` bounds argument should be a number. Instead got " + ObjoScript.VM.ValueToString(args(0)) + ".")
		    End If
		    If args(1).Type <> Variant.TypeDouble Then
		      vm.Error("The `upper` bounds argument should be a number. Instead got " + ObjoScript.VM.ValueToString(args(1)) + ".")
		    End If
		    instance.ForeignData = New RangeData(args(0).DoubleValue, args(1).DoubleValue)
		  Else
		    vm.Error("Invalid number of arguments (expected 0 or 2, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E20746865206052616E67656020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Range` class or Nil if there is no such method.
		  
		  #Pragma Unused isStatic
		  
		  If signature.CompareCase("iterate(_)") Then
		    Return AddressOf Iterate
		    
		  ElseIf signature.CompareCase("iteratorValue(_)") Then
		    Return AddressOf IteratorValue
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the next value in the sequence.
		  ///
		  /// if `iter` is nothing then we should return the first item.
		  /// Assumes slot 0 contains a Range instance.
		  /// Range.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  Var data As ObjoScript.Core.Range.RangeData = instance.ForeignData
		  
		  If iter IsA ObjoScript.Nothing Then
		    data.NextValue = data.LowerBound
		  Else
		    If data.NextValue < data.UpperBound Then
		      data.NextValue = data.NextValue.DoubleValue + 1
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
		  /// Assumes slot 0 contains a Range instance.
		  /// We are ignoring `iter` here.
		  /// Range.iterator(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  vm.SetReturn(ObjoScript.Core.Range.RangeData(instance.ForeignData).NextValue)
		  
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
