#tag Module
Protected Module Object_
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520604F626A6563746020636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the `Object` class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Object class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604F626A6563746020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Object` class or Nil if there is no such method.
		  
		  
		  If isStatic Then
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		    
		  ElseIf signature.CompareCase("type()") Then
		    Return AddressOf Type
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612064656661756C7420726570726573656E746174696F6E206F6620746865206F626A656374206173206120737472696E672E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns a default representation of the object as a string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is an instance.
		  ///
		  /// Object.toString() -> string
		  
		  Var instance As ObjoScript.Instance = ObjoScript.Instance(vm.GetSlotValue(0))
		  
		  vm.SetReturn(instance.Klass.Name + " instance")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686973206F626A65637427732074797065206173206120537472696E672E
		Protected Sub Type(vm As ObjoScript.VM)
		  /// Returns this object's type as a String.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is the value / instance.
		  ///
		  /// Object.type() -> string
		  
		  Var value As Variant = vm.GetSlotValue(0)
		  
		  Var type As String
		  If value.Type = Variant.TypeDouble Then
		    type = "Number"
		  ElseIf value.Type = Variant.TypeBoolean Then
		    type = "Boolean"
		  ElseIf value.Type = Variant.TypeString Then
		    type = "String"
		  Else
		    // Assume slot 0 is an instance.
		    type = ObjoScript.Instance(value).Klass.Name
		  End If
		  
		  vm.SetReturn(type)
		  
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
