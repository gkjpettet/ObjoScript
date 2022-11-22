#tag Module
Protected Module Number
	#tag Method, Flags = &h1, Description = 52657475726E7320746865206162736F6C7574652076616C7565206F6620746865206E756D6265722E
		Protected Sub Abs_(vm As ObjoScript.VM)
		  /// Returns the absolute value of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.abs() -> Number
		  
		  vm.SetReturn(CType(Abs(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652061726320636F73696E65206F6620746865206E756D6265722E
		Protected Sub ACos_(vm As ObjoScript.VM)
		  /// Returns the arc cosine of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.acos() -> Number
		  
		  vm.SetReturn(CType(ACos(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073717561726520726F6F74206F6620746865206E756D6265722E
		Protected Sub Add(vm As ObjoScript.VM)
		  /// Converts this number to a string and adds a value to it.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Note: Number + Number is handled within the VM for performance reasons.
		  /// Number.+(value) -> string
		  
		  Var d As Variant = vm.GetSlotValue(0)
		  Var s As String
		  
		  // Format integers nicely.
		  If d.DoubleValue.IsInteger Then
		    s = d.IntegerValue.ToString
		  Else
		    s = d.DoubleValue.ToString(Locale.Current, "#.#########")
		  End If
		  
		  vm.SetReturn(s + vm.GetSlotAsString(1))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865204E756D62657220636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the Number class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Number class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652061726373696E65206F6620746865206E756D6265722E
		Protected Sub ASin_(vm As ObjoScript.VM)
		  /// Returns the arc sine of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.asin() -> Number
		  
		  vm.SetReturn(CType(ASin(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206172632074616E67656E74206F6620746865206E756D6265722E
		Protected Sub ATan_(vm As ObjoScript.VM)
		  /// Returns the arc tangent of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.atan() -> Number
		  
		  vm.SetReturn(CType(ATan(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604E756D6265726020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Number` class or Nil if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652061726320636F73696E65206F6620746865206E756D6265722E
		Protected Sub Ceil_(vm As ObjoScript.VM)
		  /// Returns the value specified rounded up to the nearest whole number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.ceil() -> Number
		  
		  vm.SetReturn(CType(Ceil(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520636F73696E65206F6620746865206E756D6265722E
		Protected Sub Cos_(vm As ObjoScript.VM)
		  /// Returns the cosine of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.cos() -> Number
		  
		  vm.SetReturn(CType(Cos(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652061726320636F73696E65206F6620746865206E756D6265722E
		Protected Sub Exp_(vm As ObjoScript.VM)
		  /// Returns the exponential e (Euler’s number) raised to the number. 
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.exp() -> Number
		  
		  vm.SetReturn(CType(Exp(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C75652073706563696669656420726F756E64656420646F776E20746F20746865206E6561726573742077686F6C65206E756D6265722E
		Protected Sub Floor_(vm As ObjoScript.VM)
		  /// Returns the value specified rounded down to the nearest whole number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.floor() -> Number
		  
		  vm.SetReturn(CType(Floor(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203E20606F74686572602E
		Protected Sub Greater(vm As ObjoScript.VM)
		  /// Returns `true` if this is > `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.>(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `>(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203E3D20606F74686572602E
		Protected Sub GreaterEqual(vm As ObjoScript.VM)
		  /// Returns `true` if this is >= `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.>=(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `>=(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo method addresses.
		  
		  #Pragma Warning "TODO: Add more methods"
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("+(_)")        = AddressOf Add
		  d.Value("<(_)")        = AddressOf Less
		  d.Value("<=(_)")       = AddressOf LessEqual
		  d.Value(">(_)")        = AddressOf Greater
		  d.Value(">=(_)")       = AddressOf GreaterEqual
		  d.Value("..(_)")       = AddressOf RangeInclusive
		  d.Value("...(_)")      = AddressOf RangeExclusive
		  d.Value("abs()")       = AddressOf Abs_
		  d.Value("acos()")      = AddressOf ACos_
		  d.Value("asin()")      = AddressOf ASin_
		  d.Value("atan()")      = AddressOf ATan_
		  d.Value("ceil()")      = AddressOf Ceil_
		  d.Value("cos()")       = AddressOf Cos_
		  d.Value("exp()")       = AddressOf Exp_
		  d.Value("floor()")     = AddressOf Floor_
		  d.Value("log()")       = AddressOf Log_
		  d.Value("isInteger()") = AddressOf IsInteger
		  d.Value("max(_)")      = AddressOf Max_
		  d.Value("min(_)")      = AddressOf Min_
		  d.Value("pow(_)")      = AddressOf Pow_
		  d.Value("round()")     = AddressOf Round_
		  d.Value("sign()")      = AddressOf Sign_
		  d.Value("sqrt()")      = AddressOf Sqrt_
		  d.Value("sin()")       = AddressOf Sin_
		  d.Value("tan()")       = AddressOf Tan_
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static methods to Xojo method addresses.
		  
		  #Pragma Warning "TODO: Add more methods"
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206E756D62657220697320616E20696E74656765722E
		Protected Sub IsInteger(vm As ObjoScript.VM)
		  /// Returns `true` if this number is an integer.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  
		  Var num As Double = vm.GetSlotValue(0)
		  vm.SetReturn(num = Floor(num))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203C20606F74686572602E
		Protected Sub Less(vm As ObjoScript.VM)
		  /// Returns `true` if this is < `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.<(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `<(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206074727565602069662074686973206973203C3D20606F74686572602E
		Protected Sub LessEqual(vm As ObjoScript.VM)
		  /// Returns `true` if this is <= `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Note: Number < Number is handled within the VM for performance reasons.
		  /// Number.<=(other) -> boolean
		  
		  // Since this is handled in the VM, we'll just raise a runtime error. If we don't do this, 
		  // The VM will spit out an error saying that `Number` doesn't implement `<=(_)`. It obviously
		  // does so this is cleaner.
		  vm.Error("Both operands must be numbers.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C75652073706563696669656420726F756E64656420646F776E20746F20746865206E6561726573742077686F6C65206E756D6265722E
		Protected Sub Log_(vm As ObjoScript.VM)
		  /// Returns the natural logarithm of the value specified.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.log() -> Number
		  
		  vm.SetReturn(CType(Log(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6178696D756D2076616C7565207768656E20636F6D706172696E672074686973206E756D62657220616E6420606F74686572602E
		Protected Sub Max_(vm As ObjoScript.VM)
		  /// Returns the maximum value when comparing this number and `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Slot 1 should be a number.
		  /// Number.max(other) -> Number
		  
		  If Not vm.GetSlotValue(1).Type = Variant.TypeDouble Then
		    vm.Error("The argument to `max(_)` should be a Number.")
		  End If
		  
		  vm.SetReturn(CType(Max(vm.GetSlotValue(0), vm.GetSlotValue(1)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D696E696D756D2076616C7565207768656E20636F6D706172696E672074686973206E756D62657220616E6420606F74686572602E
		Protected Sub Min_(vm As ObjoScript.VM)
		  /// Returns the minimum value when comparing this number and `other`.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Slot 1 should be a number.
		  /// Number.min(other) -> Number
		  
		  If Not vm.GetSlotValue(1).Type = Variant.TypeDouble Then
		    vm.Error("The argument to `min(_)` should be a Number.")
		  End If
		  
		  vm.SetReturn(CType(Min(vm.GetSlotValue(0), vm.GetSlotValue(1)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5261697365732074686973206E756D626572202874686520626173652920746F2060706F776572602E2052657475726E73206E616E206966207468652062617365206973206E656761746976652E
		Protected Sub Pow_(vm As ObjoScript.VM)
		  /// Raises this number (the base) to `power`. Returns nan if the base is negative.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Slot 1 should be a number.
		  /// Number.pow(power) -> Number
		  
		  If Not vm.GetSlotValue(1).Type = Variant.TypeDouble Then
		    vm.Error("The argument to `pow(_)` should be a Number.")
		  End If
		  
		  vm.SetReturn(CType(Pow(vm.GetSlotValue(0), vm.GetSlotValue(1)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C697374207769746820656C656D656E74732072616E67696E672066726F6D2074686973206E756D62657220746F206075707065726020286578636C7573697665292E
		Protected Sub RangeExclusive(vm As ObjoScript.VM)
		  /// Returns a list with elements ranging from this number to `upper` (exclusive).
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Number...upper -> List
		  
		  Var lower As Double = vm.GetSlotValue(0)
		  Var upper As Double = vm.GetSlotValue(1)
		  
		  Var values() As Variant
		  
		  If lower = upper Then
		    // Empty array.
		  Else
		    If upper > lower Then
		      upper = upper - 1.0
		      Var value As Double = lower
		      While value <= upper
		        values.Add(value)
		        value = value + 1.0
		      Wend
		    Else // lower > upper
		      upper = upper + 1.0
		      Var value As Double = lower
		      While value >= upper
		        values.Add(value)
		        value = value - 1.0
		      Wend
		    End If
		  End If
		  
		  // Create a new lists with values.
		  Var list As New ObjoScript.Instance(vm, vm.ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  ObjoScript.Core.List.ListData(list.ForeignData).Items = values
		  
		  vm.SetReturn(list)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C697374207769746820656C656D656E74732072616E67696E672066726F6D2074686973206E756D62657220746F20607570706572602028696E636C7573697665292E
		Protected Sub RangeInclusive(vm As ObjoScript.VM)
		  /// Returns a list with elements ranging from this number to `upper` (inclusive).
		  ///
		  /// Since this is a built-in type, slot 0 will be a double.
		  /// Number..upper -> List
		  
		  Var lower As Double = vm.GetSlotValue(0)
		  Var upper As Double = vm.GetSlotValue(1)
		  
		  Var values() As Variant
		  
		  If lower = upper Then
		    values.Add(lower)
		  ElseIf upper > lower Then
		    Var value As Double = lower
		    While value <= upper
		      values.Add(value)
		      value = value + 1.0
		    Wend
		  Else // lower > upper
		    Var value As Double = lower
		    While value >= upper
		      values.Add(value)
		      value = value - 1.0
		    Wend
		  End If
		  
		  // Create a new lists with values.
		  Var list As New ObjoScript.Instance(vm, vm.ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  ObjoScript.Core.List.ListData(list.ForeignData).Items = values
		  
		  vm.SetReturn(list)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C756520726F756E64656420746F20746865206E65617265737420696E74656765722E
		Protected Sub Round_(vm As ObjoScript.VM)
		  /// Returns the value rounded to the nearest integer.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.round() -> Number
		  
		  vm.SetReturn(CType(Round(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073717561726520726F6F74206F6620746865206E756D6265722E
		Protected Sub Sign_(vm As ObjoScript.VM)
		  /// Returns the sign of the number, expressed as a -1, 1 or 0, for negative/positive numbers, and zero.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.sign() -> double
		  
		  vm.SetReturn(CType(Sign(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073696E65206F6620746865206E756D6265722E
		Protected Sub Sin_(vm As ObjoScript.VM)
		  /// Returns the sine of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.sin() -> Number
		  
		  vm.SetReturn(CType(Sin(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073717561726520726F6F74206F6620746865206E756D6265722E
		Protected Sub Sqrt_(vm As ObjoScript.VM)
		  /// Returns the square root of the number.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.sqrt() -> double
		  
		  vm.SetReturn(CType(Sqrt(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652073696E65206F6620746865206E756D6265722E
		Protected Sub Tan_(vm As ObjoScript.VM)
		  /// Returns the tangent of this number, where this number is in radians.
		  ///
		  /// Since this is a built-in type, slot 0 will be a double (not an instance object).
		  /// Number.tan() -> Number
		  
		  vm.SetReturn(CType(Tan(vm.GetSlotValue(0)), Double))
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20696E7374616E6365206D6574686F647320646566696E6564206F6E20746865204E756D62657220636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseInstanceMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected InstanceMethods As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E20746865204E756D62657220636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
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
