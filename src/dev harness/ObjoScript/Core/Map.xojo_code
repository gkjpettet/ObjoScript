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
		  
		  #Pragma Unused isStatic
		  
		  #Pragma Warning "TODO: Implement the iterator protocol"
		  
		  If signature.CompareCase("count()") Then
		    Return AddressOf Count
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		    
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
