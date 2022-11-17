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
		    If signature = "==(_)" Then
		      Return AddressOf EqualStatic
		      
		    ElseIf signature = "<>(_)" Then
		      Return AddressOf NotEqualStatic
		      
		    ElseIf signature.CompareCase("is(_)") Then
		      Return AddressOf Is_
		    End If
		    
		  ElseIf signature = "==(_)" Then
		    Return AddressOf Equal
		    
		  ElseIf signature = "<>(_)" Then
		    Return AddressOf NotEqual
		    
		  ElseIf signature.CompareCase("is(_)") Then
		    Return AddressOf Is_
		    
		  ElseIf signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		    
		  ElseIf signature.CompareCase("type()") Then
		    Return AddressOf Type
		    
		  ElseIf signature.CompareCase("superType()") Then
		    Return AddressOf SuperType
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520636C617373206F6620606F626A60206D6174636865736074797065602E
		Protected Function ClassesEqual(obj As Variant, type As String) As Boolean
		  /// Returns True if the class of `obj` matches`type`.
		  
		  If obj.Type = Variant.TypeDouble Then
		    Return type.CompareCase("Number")
		    
		  ElseIf obj.Type = Variant.TypeBoolean Then
		    Return type.CompareCase("Boolean")
		    
		  ElseIf obj.Type = Variant.TypeString Then
		    Return type.CompareCase("String")
		    
		  ElseIf obj IsA ObjoScript.Instance Then
		    Return ObjoScript.Instance(obj).Klass.Name.CompareCase(type)
		    
		  ElseIf obj IsA ObjoScript.Klass Then
		    Return ObjoScript.Klass(obj).Name.CompareCase(type)
		    
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612064656661756C7420726570726573656E746174696F6E206F6620746865206F626A656374206173206120737472696E672E
		Protected Sub Equal(vm As ObjoScript.VM)
		  /// Compares two objects using built-in equality. This compares value types by value 
		  /// and all other objects are compared by reference: two objects are equal only if they are the exact 
		  /// same object.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo double/string/boolean, an instance or a class.
		  /// - Slot 1 is a Xojo double/string/boolean, an instance or a class.
		  ///
		  /// Object.==(other) -> boolean
		  
		  vm.SetReturn(ValuesEqual(vm.GetSlotValue(0), vm.GetSlotValue(1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6D70617265732074686973206F626A656374277320636C617373207769746820606F74686572602E
		Protected Sub EqualStatic(vm As ObjoScript.VM)
		  /// Compares this object's class with `other`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo double/string/boolean, an instance or a class.
		  /// - Slot 1 is a Xojo string.
		  ///
		  /// static Object.==(other) -> boolean
		  
		  Var obj As Variant = vm.GetSlotValue(0)
		  Var other As Variant = vm.GetSlotValue(1)
		  Var type As String
		  
		  // If `other` isn't a string or a class then the comparison is false.
		  If other IsA ObjoScript.Klass Then
		    type = ObjoScript.Klass(other).Name
		  ElseIf other.Type = Variant.TypeString Then
		    type = other
		  Else
		    vm.SetReturn(False)
		  End If
		  
		  vm.SetReturn(ClassesEqual(obj, type))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060696E737460206973206F66206074797065602E2057616C6B7320746865207375706572636C61737320686965726172636879206966206E65636573736172792E
		Private Function InstanceIsOfType(inst As ObjoScript.Instance, type As String) As Boolean
		  /// Returns True if `inst` is of `type`. Walks the superclass hierarchy if necessary.
		  
		  If inst.Klass.Name.CompareCase(type) Then
		    Return True
		  Else
		    // Check the class hierarchy.
		    Var parent As ObjoScript.Klass = inst.Klass.Superclass
		    While parent <> Nil
		      If parent.Name.CompareCase(type) Then
		        Return True
		      Else
		        parent = parent.Superclass
		      End If
		    Wend
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686973206F626A656374277320636C617373206F72206F6E65206F6620697473207375706572636C617373657320697320606F74686572602E
		Protected Sub Is_(vm As ObjoScript.VM)
		  /// Returns True if this object's class or one of its superclasses is `other`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo double/string/boolean/pair, an instance or a class.
		  /// - Slot 1 is a Xojo double/string/boolean/pair, an instance or a class.
		  ///
		  /// Object.is(other) -> boolean
		  
		  Var this As Variant = vm.GetSlotValue(0)
		  Var other As Variant = vm.GetSlotValue(1)
		  
		  Select Case this.Type
		  Case Variant.TypeDouble
		    If other.Type = Variant.TypeDouble Then
		      vm.SetReturn(True)
		      Return
		    ElseIf other.Type = Variant.TypeString And other.StringValue.CompareCase("Number") Then
		      vm.SetReturn(True)
		      Return
		    Else
		      vm.SetReturn(TypeFromVariant(other).CompareCase("Number"))
		      Return
		    End If
		    
		  Case Variant.TypeBoolean
		    If other.Type = Variant.TypeBoolean Then
		      vm.SetReturn(True)
		      Return
		    ElseIf other.Type = Variant.TypeString And other.StringValue.CompareCase("Boolean") Then
		      vm.SetReturn(True)
		      Return
		    Else
		      vm.SetReturn(TypeFromVariant(other).CompareCase("Boolean"))
		      Return
		    End If
		    
		  Case Variant.TypeString
		    If other.Type = Variant.TypeString Then
		      vm.SetReturn(True)
		      Return
		    ElseIf other.Type = Variant.TypeString And other.StringValue.CompareCase("String") Then
		      vm.SetReturn(True)
		      Return
		    Else
		      vm.SetReturn(TypeFromVariant(other).CompareCase("String"))
		      Return
		    End If
		  End Select
		  
		  If this IsA ObjoScript.Instance Then
		    If other.Type = Variant.TypeString Then
		      vm.SetReturn(InstanceIsOfType(ObjoScript.Instance(this), other))
		      Return
		    Else
		      vm.SetReturn(InstanceIsOfType(ObjoScript.Instance(this), TypeFromVariant(other)))
		      Return
		    End If
		    
		  ElseIf this IsA ObjoScript.Klass Then
		    If other.Type = Variant.TypeString Then
		      vm.SetReturn(ObjoScript.Klass(this).Name.CompareCase(other))
		      Return
		    Else
		      vm.SetReturn(ObjoScript.Klass(this).Name.CompareCase(TypeFromVariant(other)))
		      Return
		    End If
		    
		  Else
		    vm.SetReturn(False)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612064656661756C7420726570726573656E746174696F6E206F6620746865206F626A656374206173206120737472696E672E
		Protected Sub NotEqual(vm As ObjoScript.VM)
		  /// Compares two objects using built-in equality. This compares value types by value 
		  /// and all other objects are compared by reference: two objects are equal only if they are the exact 
		  /// same object.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo double/string/boolean, an instance or a class.
		  /// - Slot 1 is a Xojo double/string/boolean, an instance or a class.
		  ///
		  /// Object.<>(other) -> boolean
		  
		  vm.SetReturn(Not ValuesEqual(vm.GetSlotValue(0), vm.GetSlotValue(1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 436F6D70617265732074686973206F626A656374277320636C617373207769746820606F74686572602E
		Protected Sub NotEqualStatic(vm As ObjoScript.VM)
		  /// Compares this object's class with `other`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo double/string/boolean, an instance or a class.
		  /// - Slot 1 is a Xojo string.
		  ///
		  /// static Object.<>(other) -> boolean
		  
		  Var obj As Variant = vm.GetSlotValue(0)
		  Var other As Variant = vm.GetSlotValue(1)
		  Var type As String
		  
		  // If `other` isn't a string or a class then the comparison is true.
		  If other IsA ObjoScript.Klass Then
		    type = ObjoScript.Klass(other).Name
		  ElseIf other.Type = Variant.TypeString Then
		    type = other
		  Else
		    vm.SetReturn(True)
		  End If
		  
		  vm.SetReturn(Not ClassesEqual(obj, type))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686973206F626A65637427732073757065722074797065206173206120537472696E672E
		Protected Sub SuperType(vm As ObjoScript.VM)
		  /// Returns this object's super type as a String.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is the value / instance.
		  ///
		  /// Object.superType() -> string
		  
		  Var value As Variant = vm.GetSlotValue(0)
		  
		  Var type As String
		  If value.Type = Variant.TypeDouble Then
		    type = "Object"
		    
		  ElseIf value.Type = Variant.TypeBoolean Then
		    type = "Object"
		    
		  ElseIf value.Type = Variant.TypeString Then
		    type = "Object"
		    
		  ElseIf value IsA ObjoScript.Instance Then
		    If ObjoScript.Instance(value).Klass = Nil Then
		      type = "Nothing"
		    Else
		      type = ObjoScript.Instance(value).Klass.Name
		    End If
		    
		  ElseIf value IsA ObjoScript.Klass Then
		    type = ObjoScript.Klass(value).Name
		    
		  Else
		    vm.Error("Unknown value type.")
		  End If
		  
		  vm.SetReturn(type)
		  
		End Sub
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
		    
		  ElseIf value IsA ObjoScript.Instance Then
		    type = ObjoScript.Instance(value).Klass.Name
		    
		  ElseIf value IsA ObjoScript.Klass Then
		    type = ObjoScript.Klass(value).Name
		    
		  Else
		    vm.Error("Unknown value type.")
		  End If
		  
		  vm.SetReturn(type)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652074797065206F66206076616C756560206173206120537472696E672E
		Private Function TypeFromVariant(value As Variant) As String
		  /// Returns the type of `value` as a String.
		  ///
		  /// Assumes:`v` is not Nil.
		  
		  If value.Type = Variant.TypeDouble Then
		    Return "Number"
		    
		  ElseIf value.Type = Variant.TypeBoolean Then
		    Return "Boolean"
		    
		  ElseIf value.Type = Variant.TypeString Then
		    Return "String"
		    
		  ElseIf value IsA ObjoScript.Instance Then
		    Return ObjoScript.Instance(value).Klass.Name
		    
		  ElseIf value IsA ObjoScript.Klass Then
		    Return ObjoScript.Klass(value).Name
		    
		  ElseIf value IsA ObjoScript.Func Then
		    Return "Function"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown value type.")
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValuesEqual(a As Variant, b As Variant) As Boolean
		  /// Returns True if `a` and `b` are considered equal.
		  ///
		  /// Compares two objects using built-in equality. This compares value types by value 
		  /// and all other objects are compared by reference: two objects are equal only if they are the exact 
		  /// same object.
		  
		  Select Case a.Type
		    // ===================
		    // Doubles & Booleans.
		    // ===================
		  Case Variant.TypeDouble, Variant.TypeBoolean
		    Return a = b
		    
		  Case Variant.TypeString
		    // ===================
		    // Strings.
		    // ===================
		    // Case sensitive comparison.
		    Return a.StringValue.CompareCase(b.StringValue)
		    
		  Else
		    // ===================
		    // "Nothing".
		    // ===================
		    If a IsA ObjoScript.Nothing And b IsA ObjoScript.Nothing Then
		      Return True
		    End If
		    
		    // ===================
		    // Instances.
		    // ===================
		    If a IsA ObjoScript.Instance And b IsA ObjoScript.Instance Then
		      If ObjoScript.Instance(a).Klass.Name.CompareCase("KeyValue") And ObjoScript.Instance(b).Klass.Name.CompareCase("KeyValue") Then
		        // KeyValues.
		        Var aPair As Pair = ObjoScript.Instance(a).ForeignData
		        Var bPair As Pair = ObjoScript.Instance(b).ForeignData
		        Return (aPair.Left = bPair.Left) And (aPair.Right = bPair.Right)
		      Else
		        Return a = b
		      End If
		    End If
		    
		    // ===================
		    // Klasses.
		    // ===================
		    If a IsA ObjoScript.Klass And b IsA ObjoScript.Klass Then
		      Return ObjoScript.Klass(a).Name.CompareCase(ObjoScript.Klass(b).Name)
		    End If
		  End Select
		End Function
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
