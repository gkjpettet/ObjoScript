#tag Module
Protected Module String_
	#tag Method, Flags = &h1, Description = 436F6E636174656E61746573207468697320737472696E6720776974682074686520617267756D656E7420696E20736C6F74203120616E642072657475726E732074686520726573756C742E
		Protected Sub Add(vm As ObjoScript.VM)
		  /// Concatenates this string with the argument in slot 1 and returns the result.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is value to append.
		  ///
		  /// String.+(other) -> string
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s + vm.GetSlotAsString(1))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520537472696E6720636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the String class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The String class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E6720626567696E7320776974682060707265666978602E
		Protected Sub BeginsWith(vm As ObjoScript.VM)
		  /// Returns True if the string begins with `prefix`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the prefix to check for.
		  ///
		  /// String.beginsWith(prefix) -> boolean
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s.BeginsWith(vm.GetSlotAsString(1), ComparisonOptions.CaseSensitive))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060537472696E676020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `String` class or 
		  /// Nil if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061204C69737420636F6E7461696E696E67207468697320737472696E67277320627974652076616C7565732E
		Protected Sub CodePoints(vm As ObjoScript.VM)
		  /// Returns a List containing this string's UTF-8 codepoints.
		  ///
		  /// Assumes the string is UTF-8 encoded.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.codePoints() -> List
		  
		  // Get the string.
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Create a new instance of the List class.
		  // Note that we are bypassing any constructor's defined by the List class since we're
		  // instantiating one directly. That's OK since I know there's no special setup required
		  // in the constructor.
		  Var list As New ObjoScript.Instance(vm, vm.GetVariable("List"))
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  
		  // Set the List instance's foreign data to an array of codepoints.
		  // Since Objo works with doubles we need to do the same (even though codepoints are integers).
		  Var values() As Variant
		  For Each cp As Double In s.Codepoints
		    values.Add(cp)
		  Next cp
		  ObjoScript.Core.List.ListData(list.ForeignData).Items = values
		  
		  // Return the list.
		  vm.SetReturn(list)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207472756520696620606F7468657260206973206120737562737472696E67206F66207468697320737472696E672E20436173652D73656E73697469766520636F6D70617269736F6E2E
		Protected Sub Contains(vm As ObjoScript.VM)
		  /// Returns true if `other` is a substring of this string. Case-sensitive comparison.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// String.contains(other) -> boolean
		  
		  // Assert `other` is a string.
		  Var other As Variant = vm.GetSlotValue(1)
		  
		  If other.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  vm.SetReturn(vm.GetSlotValue(0).StringValue.Contains(other, ComparisonOptions.CaseSensitive))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E756D626572206F66206368617261637465727320696E2074686520737472696E672E
		Protected Sub Count(vm As ObjoScript.VM)
		  /// Returns the number of characters in the string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.count() -> number
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(CType(s.CharacterCount, Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206E657720737472696E6720636F6E7461696E696E6720746865205554462D3820656E636F64696E67206F662060636F6465706F696E74602E
		Protected Sub FromCodePoint(vm As ObjoScript.VM)
		  /// Returns a new string containing the UTF-8 encoding of `codepoint`.
		  ///
		  /// Assumes: 
		  /// - Slot 1 is an integer number.
		  ///
		  /// String.fromCodepoint(codePoint) -> String
		  
		  #Pragma BreakOnExceptions False
		  
		  // Assert `codePoint` is a positive integer.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(1)) Then
		    vm.Error("The `codePoint` argument should be a positive integer.")
		  End If
		  Var cp As Integer = vm.GetSlotValue(1)
		  If cp < 0 Then
		    vm.Error("The `codePoint` argument should be a positive integer.")
		  End If
		  
		  Var s As String
		  Try
		    s = Text.FromUnicodeCodepoint(cp)
		  Catch e As RuntimeException
		    vm.Error("Invalid code point.")
		  End Try
		  
		  vm.SetReturn(s)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("+(_)")          = AddressOf Add
		  d.Value("beginsWith(_)") = AddressOf BeginsWith
		  d.Value("codePoints()")  = AddressOf CodePoints
		  d.Value("contains(_)")   = AddressOf Contains
		  d.Value("count()")       = AddressOf Count
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("fromCodepoint(_)") = AddressOf FromCodePoint
		  
		  Return d
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20696E7374616E6365206D6574686F647320646566696E6564206F6E2074686520537472696E6720636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseInstanceMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected InstanceMethods As Dictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E2074686520537472696E6720636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
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
