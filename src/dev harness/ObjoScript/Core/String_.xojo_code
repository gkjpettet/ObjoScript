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

	#tag Method, Flags = &h1, Description = 52657475726E732074727565206966207468697320737472696E6720656E647320776974682060737566666978602E20436173652D696E73656E7369746976652E
		Protected Sub EndsWith(vm As ObjoScript.VM)
		  /// Returns true if this string ends with `suffix`. Case-insensitive.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// String.endsWith(suffix) -> boolean
		  
		  // Assert `suffix` is a string.
		  Var suffix As Variant = vm.GetSlotValue(1)
		  
		  If suffix.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  vm.SetReturn(vm.GetSlotValue(0).StringValue.EndsWith(suffix, ComparisonOptions.CaseSensitive))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074727565206966207468697320737472696E6720656E647320776974682060737566666978602E2054686520606361736553656E7369746976656020617267756D656E742064657465726D696E657320636173652D73656E73697469766974792E
		Protected Sub EndsWithCaseSensitivity(vm As ObjoScript.VM)
		  /// Returns true if this string ends with `suffix`. The `caseSensitive` argument determines case-sensitivity.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// - Slot 2 is the `caseSensitive` argument
		  /// String.endsWith(suffix, caseSensitive) -> boolean
		  
		  // Assert `suffix` is a string.
		  Var suffix As Variant = vm.GetSlotValue(1)
		  If suffix.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  If vm.IsFalsey(vm.GetSlotValue(2)) Then
		    // Case-insensitive.
		    vm.SetReturn(vm.GetSlotValue(0).StringValue.EndsWith(suffix, ComparisonOptions.CaseInsensitive))
		  Else
		    // Case sensitive.
		    vm.SetReturn(vm.GetSlotValue(0).StringValue.EndsWith(suffix, ComparisonOptions.CaseSensitive))
		  End If
		  
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

	#tag Method, Flags = &h1, Description = 52657475726E732074686520706F736974696F6E206F6620746865206669727374206F6363757272656E6365206F6620606F746865726020696E73696465207468697320737472696E67206F7220602D3160206966206E6F7420666F756E642E20436173652073656E7369746976652E
		Protected Sub IndexOf(vm As ObjoScript.VM)
		  /// Returns the position of the first occurrence of `other` inside this string or `-1` if not found. Case sensitive.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// String.indexOf(other) -> number
		  
		  // Assert `other` is a string.
		  Var other As Variant = vm.GetSlotValue(1)
		  
		  If other.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  vm.SetReturn(CType(vm.GetSlotValue(0).StringValue.IndexOf(0, other, ComparisonOptions.CaseSensitive), Double))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520706F736974696F6E206F6620606F746865726020696E73696465207468697320737472696E67206F7220602D3160206966206E6F7420666F756E642E20426567696E7320617420696E64657820607374617274602E2054686520606361736553656E7369746976656020617267756D656E742064657465726D696E657320636173652073656E73697469766974792E
		Protected Sub IndexOfCaseSensitivity(vm As ObjoScript.VM)
		  /// Returns the position of `other` inside this string or `-1` if not found.
		  /// Begins at index `start`.
		  /// The `caseSensitive` argument determines case sensitivity.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// - Slot 2 is an integer number.
		  /// - Slot 3 is the `caseSensitive` argument.
		  /// String.indexOf(other, start, caseSensitive) -> number
		  
		  // Assert `other` is a string.
		  Var other As Variant = vm.GetSlotValue(1)
		  If other.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  // Assert `start` is a positive integer.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(2)) Then
		    vm.Error("The `start` argument should be a positive integer.")
		  End If
		  Var start As Integer = vm.GetSlotValue(2)
		  If start < 0 Then
		    vm.Error("The `start` argument should be a positive integer.")
		  End If
		  
		  If vm.IsFalsey(vm.GetSlotValue(3)) Then
		    // Case-insensitive.
		    vm.SetReturn(CType(vm.GetSlotValue(0).StringValue.IndexOf(start, other, ComparisonOptions.CaseInsensitive), Double))
		  Else
		    // Case sensitive.
		    vm.SetReturn(CType(vm.GetSlotValue(0).StringValue.IndexOf(start, other, ComparisonOptions.CaseSensitive), Double))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732074686520706F736974696F6E206F6620746865206669727374206F6363757272656E6365206F6620606F746865726020696E73696465207468697320737472696E67206F7220602D3160206966206E6F7420666F756E642E2054686520606361736553656E7369746976656020617267756D656E742064657465726D696E657320636173652073656E73697469766974792E
		Protected Sub IndexOfStart(vm As ObjoScript.VM)
		  /// Returns the position of `other` inside this string or `-1` if not found.
		  /// Begins at index `start`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// - Slot 2 is an integer number.
		  /// String.indexOf(other, start) -> number
		  
		  // Assert `other` is a string.
		  Var other As Variant = vm.GetSlotValue(1)
		  If other.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  // Assert `start` is a positive integer.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(2)) Then
		    vm.Error("The `start` argument should be a positive integer.")
		  End If
		  Var start As Integer = vm.GetSlotValue(2)
		  If start < 0 Then
		    vm.Error("The `start` argument should be a positive integer.")
		  End If
		  
		  vm.SetReturn(CType(vm.GetSlotValue(0).StringValue.IndexOf(start, other, ComparisonOptions.CaseSensitive), Double))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("+(_)")             = AddressOf Add
		  d.Value("codePoints()")     = AddressOf CodePoints
		  d.Value("contains(_)")      = AddressOf Contains
		  d.Value("count()")          = AddressOf Count
		  d.Value("endsWith(_)")      = AddressOf EndsWith
		  d.Value("endsWith(_,_)")    = AddressOf EndsWithCaseSensitivity
		  d.Value("indexOf(_)")       = AddressOf IndexOf
		  d.Value("indexOf(_,_)")     = AddressOf IndexOfStart
		  d.Value("indexOf(_,_,_)")   = AddressOf IndexOfCaseSensitivity
		  d.Value("iterate(_)")       = AddressOf Iterate
		  d.Value("iteratorValue(_)") = AddressOf IteratorValue
		  d.Value("left(_)")          = AddressOf Left
		  d.Value("lowercase()")      = AddressOf Lowercase
		  d.Value("middle(_)")        = AddressOf Middle
		  d.Value("middle(_,_)")      = AddressOf MiddleLength
		  d.Value("replace(_,_)")     = AddressOf Replace
		  d.Value("replaceAll(_,_)")  = AddressOf ReplaceAll
		  d.Value("right(_)")         = AddressOf Right
		  d.Value("split(_)")         = AddressOf Split
		  d.Value("startsWith(_)")    = AddressOf StartsWith
		  d.Value("startsWith(_,_)")  = AddressOf StartsWithCaseSensitivity
		  d.Value("titlecase()")      = AddressOf TitleCase
		  d.Value("trim()")           = AddressOf Trim
		  d.Value("trim(_)")          = AddressOf TrimChars
		  d.Value("trimEnd()")        = AddressOf TrimEnd
		  d.Value("trimEnd(_)")       = AddressOf TrimEndChars
		  d.Value("trimStart()")      = AddressOf TrimStart
		  d.Value("trimStart(_)")     = AddressOf TrimStartChars
		  d.Value("uppercase()")      = AddressOf Uppercase
		  
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

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206368617261637465727320746F2069746572617465206F722072657475726E732074686520696E64657820696E2074686520737472696E67206F6620746865206E657874206368617261637465722E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more characters to iterate or returns the index in the string 
		  /// of the next character.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a Xojo string.
		  /// - Slot 1 is the `iter` argument.
		  ///
		  /// if `iter` is nothing then we should return 0 or false if an empty string.
		  /// `iter` should be the index in the string of the previous character.
		  /// Assumes slot 0 contains a Xojo string.
		  /// String.iterate(iter) -> number or false
		  
		  // Get the string and precompute its last valid index
		  Var s As String = vm.GetSlotValue(0)
		  Var sLastIndex As Integer = s.Length - 1
		  
		  Var iter As Variant = vm.GetSlotValue(1)
		  If iter IsA ObjoScript.Nothing Then
		    If s = "" Then
		      vm.SetReturn(False)
		    Else
		      vm.SetReturn(0.0) // Must be a double as the VM's stack uses doubles internally.
		    End If
		    
		  Else
		    // Assert that the `iter` index is a positive integer.
		    If Not ObjoScript.VariantIsPositiveInteger(iter) Then
		      vm.Error("The iterator must be a positive integer.")
		    End If
		    Var index As Double = iter
		    
		    // Return the next index or False if there are no more characters.
		    If index >= sLastIndex Then
		      vm.SetReturn(False)
		    Else
		      vm.SetReturn(index + 1.0)
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E657874206974657261746F722076616C75652E
		Protected Sub IteratorValue(vm As ObjoScript.VM)
		  /// Returns the next iterator value.
		  ///
		  /// Assumes:
		  /// - Slot 0 is a Xojo string.
		  /// - Slot 1 is an integer.
		  ///
		  /// Uses `iter` to determine the next value in the iteration. It should be an index into the string.
		  /// String.iteratorValue(iter) -> value
		  
		  #Pragma BreakOnExceptions False
		  
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert that `iter` is a positive integer.
		  If Not ObjoScript.VariantIsPositiveInteger(vm.GetSlotValue(1)) Then
		    vm.Error("The iterator must be a positive integer.")
		  End If
		  Var index As Integer = vm.GetSlotValue(1)
		  
		  Try
		    vm.SetReturn(s.Middle(index, 1))
		  Catch e As OutOfBoundsException
		    vm.Error("The iterator is out of bounds (" + index.ToString + ").")
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652066697273742060636F756E746020636861726163746572732066726F6D207468697320737472696E672E
		Protected Sub Left(vm As ObjoScript.VM)
		  /// Returns the first `count` characters from this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a number
		  ///
		  /// String.left(count) -> string
		  ///
		  /// If `count` is greater than the length of the string then a runtime error occurs.
		  
		  #Pragma BreakOnExceptions False
		  
		  // Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `count` is a positive integer.
		  Var count As Variant = vm.GetSlotValue(1)
		  If Not ObjoScript.VariantIsPositiveInteger(count) Then
		    vm.Error("The `count` argument must be a positive integer.")
		  End If
		  
		  Try
		    vm.SetReturn(s.LeftCharacters(count))
		  Catch e As OutOfBoundsException
		    vm.Error("The `count` argument is out of bounds (" + count.IntegerValue.ToString + ").")
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C6F776572636173652076657273696F6E206F66207468697320737472696E672E
		Protected Sub Lowercase(vm As ObjoScript.VM)
		  /// Returns a lowercase version of this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.lowercase() -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.Lowercase)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206120706F7274696F6E206F66207468697320737472696E6720626567696E6E696E6720617420696E646578206073746172746020756E74696C2074686520656E64206F662074686520737472696E672E
		Protected Sub Middle(vm As ObjoScript.VM)
		  /// Returns the a portion of this string beginning at index `start` until the end of the string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a number
		  ///
		  /// String.middle(start) -> string
		  
		  #Pragma BreakOnExceptions False
		  
		  // Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `start` is a positive integer.
		  Var start As Variant = vm.GetSlotValue(1)
		  If Not ObjoScript.VariantIsPositiveInteger(start) Then
		    vm.Error("The `start` argument must be a positive integer.")
		  End If
		  
		  Try
		    vm.SetReturn(s.MiddleCharacters(start))
		  Catch e As OutOfBoundsException
		    vm.Error("The `start` argument is out of bounds (" + start.IntegerValue.ToString + ").")
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320606C656E67746860206368617261637465727320626567696E6E696E6720617420607374617274602066726F6D207468697320737472696E672E
		Protected Sub MiddleLength(vm As ObjoScript.VM)
		  /// Returns `length` characters beginning at `start` from this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a number
		  /// - Slot 2 is a number
		  ///
		  /// String.middle(start< length) -> string
		  
		  #Pragma BreakOnExceptions False
		  
		  // Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `start` and `length` are positive integers.
		  Var start As Variant = vm.GetSlotValue(1)
		  If Not ObjoScript.VariantIsPositiveInteger(start) Then
		    vm.Error("The `start` argument must be a positive integer.")
		  End If
		  Var length As Variant = vm.GetSlotValue(2)
		  If Not ObjoScript.VariantIsPositiveInteger(length) Then
		    vm.Error("The `start` argument must be a positive integer.")
		  End If
		  
		  Try
		    vm.SetReturn(s.MiddleCharacters(start, length))
		  Catch e As OutOfBoundsException
		    vm.Error("Out of bounds error.")
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5265706C6163657320746865206669727374206F6363757272656E6365206F662060776861746020696E207468697320737472696E672077697468206077697468602E20436173652D696E73656E7369746976652E
		Protected Sub Replace(vm As ObjoScript.VM)
		  /// Replaces the first occurrence of `what` in this string with `with`.
		  /// Case-sensitive.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is `what` (the string to search for)
		  /// - Slot 2 is `with` (the replacement string)
		  ///
		  /// String.replace(what, with) -> string
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `what` and `with` are strings.
		  If Not vm.GetSlotValue(1).Type = Variant.TypeString Then
		    vm.Error("The `what` argument must be a string.")
		  ElseIf Not vm.GetSlotValue(2).Type = Variant.TypeString Then
		    vm.Error("The `with` argument must be a string.")
		  End If
		  
		  vm.SetReturn(s.ReplaceBytes(vm.GetSlotValue(1), vm.GetSlotValue(2)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 5265706C6163657320616C6C206F6363757272656E636573206F662060776861746020696E207468697320737472696E672077697468206077697468602E20436173652D73656E7369746976652E
		Protected Sub ReplaceAll(vm As ObjoScript.VM)
		  /// Replaces all occurrences of `what` in this string with `with`.
		  /// Case-sensitive.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is `what` (the string to search for)
		  /// - Slot 2 is `with` (the replacement string)
		  ///
		  /// String.replaceAll(what, with) -> string
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `what` and `with` are strings.
		  If Not vm.GetSlotValue(1).Type = Variant.TypeString Then
		    vm.Error("The `what` argument must be a string.")
		  ElseIf Not vm.GetSlotValue(2).Type = Variant.TypeString Then
		    vm.Error("The `with` argument must be a string.")
		  End If
		  
		  vm.SetReturn(s.ReplaceAllBytes(vm.GetSlotValue(1), vm.GetSlotValue(2)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652066697273742060636F756E746020636861726163746572732066726F6D207468697320737472696E672E
		Protected Sub Right(vm As ObjoScript.VM)
		  /// Returns the last `count` characters from this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a number
		  ///
		  /// String.right(count) -> string
		  ///
		  /// If `count` is greater than the length of the string then a runtime error occurs.
		  
		  #Pragma BreakOnExceptions False
		  
		  // Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `count` is a positive integer.
		  Var count As Variant = vm.GetSlotValue(1)
		  If Not ObjoScript.VariantIsPositiveInteger(count) Then
		    vm.Error("The `count` argument must be a positive integer.")
		  End If
		  
		  Try
		    vm.SetReturn(s.RightCharacters(count))
		  Catch e As OutOfBoundsException
		    vm.Error("The `count` argument is out of bounds (" + count.IntegerValue.ToString + ").")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C697374206F66206F6E65206F72206D6F726520737472696E6773207365706172617465642062792060736570617261746F72602E
		Protected Sub Split(vm As ObjoScript.VM)
		  /// Returns a list of one or more strings separated by `separator`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is a string.
		  /// String.split(separator) -> list
		  ///
		  /// If `separator` is an empty string then a list of this string's characters are returned.
		  
		  Var s As String = vm.GetSlotValue(0)
		  
		  // Assert `separator` is a string.
		  If Not vm.GetSlotValue(1).Type = Variant.TypeString Then
		    vm.Error("The `separator` argument must be a string.")
		  End If
		  
		  // Split the string.
		  Var columns() As String = s.Split(vm.GetSlotValue(1))
		  
		  // Create a new list instance.
		  Var list As ObjoScript.Instance = New ObjoScript.Instance(vm, vm.ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  
		  // The Xojo compiler isn't smart enough to let us assign our array of
		  // strings the the list's Variant Items array so we need to loop 
		  // through it.
		  For Each column As String In columns
		    ObjoScript.Core.List.ListData(list.ForeignData).Items.Add(column)
		  Next column
		  
		  // Return the list.
		  vm.SetReturn(list)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E672073746172747320776974682060707265666978602E20436173652D73656E7369746976652E
		Protected Sub StartsWith(vm As ObjoScript.VM)
		  /// Returns True if the string starts with `prefix`. Case-sensitive.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the prefix to check for.
		  ///
		  /// String.startsWith(prefix) -> boolean
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s.BeginsWith(vm.GetSlotAsString(1), ComparisonOptions.CaseSensitive))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E672073746172747320776974682060707265666978602E2054686520606361736553656E7369746976656020617267756D656E742064657465726D696E657320636173652D73656E73697469766974792E
		Protected Sub StartsWithCaseSensitivity(vm As ObjoScript.VM)
		  /// Returns True if the string starts with `prefix`. The `caseSensitive` argument determines case-sensitivity.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the prefix to check for.
		  /// - Slot 2 is the `caseSensitive` argument.
		  ///
		  /// String.startsWith(prefix, caseSensitive) -> boolean
		  
		  // Assert `prefix` is a string.
		  Var prefix As Variant = vm.GetSlotValue(1)
		  If prefix.Type <> Variant.TypeString Then
		    vm.Error("The argument must be a string.")
		  End If
		  
		  If vm.IsFalsey(vm.GetSlotValue(2)) Then
		    // Case-insensitive.
		    vm.SetReturn(vm.GetSlotValue(0).StringValue.BeginsWith(prefix, ComparisonOptions.CaseInsensitive))
		  Else
		    // Case sensitive.
		    vm.SetReturn(vm.GetSlotValue(0).StringValue.BeginsWith(prefix, ComparisonOptions.CaseSensitive))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061207469746C65636173652076657273696F6E206F66207468697320737472696E672E
		Protected Sub Titlecase(vm As ObjoScript.VM)
		  /// Returns a titlecase version of this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.titlecase() -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.Titlecase)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820776869746573706163652072656D6F7665642066726F6D2074686520626567696E6E696E6720616E6420656E642E
		Protected Sub Trim(vm As ObjoScript.VM)
		  /// Returns this string with whitespace removed from the beginning and end.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.trim() -> string
		  /// Whitespace characters are defined here: http://www.unicode.org/Public/UNIDATA/PropList.txt
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.Trim)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820606368617273602072656D6F7665642066726F6D2074686520626567696E6E696E6720616E6420656E642E
		Protected Sub TrimChars(vm As ObjoScript.VM)
		  /// Returns this string with `chars` removed from the beginning and end.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the `chars` argument.
		  ///
		  /// String.trim(chars) -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.Trim(vm.GetSlotAsString(1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820776869746573706163652072656D6F7665642066726F6D2074686520656E642E
		Protected Sub TrimEnd(vm As ObjoScript.VM)
		  /// Returns this string with whitespace removed from the end.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.trimEnd() -> string
		  /// Whitespace characters are defined here: http://www.unicode.org/Public/UNIDATA/PropList.txt
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.TrimRight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820606368617273602072656D6F7665642066726F6D2074686520656E642E
		Protected Sub TrimEndChars(vm As ObjoScript.VM)
		  /// Returns this string with `chars` removed from the end.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the `chars` argument
		  ///
		  /// String.trimEnd(chars) -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.TrimRight(vm.GetSlotAsString(1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820776869746573706163652072656D6F7665642066726F6D2074686520626567696E6E696E672E
		Protected Sub TrimStart(vm As ObjoScript.VM)
		  /// Returns this string with whitespace removed from the beginning.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.trimStart() -> string
		  /// Whitespace characters are defined here: http://www.unicode.org/Public/UNIDATA/PropList.txt
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.TrimLeft)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320737472696E67207769746820606368617273602072656D6F7665642066726F6D2074686520626567696E6E696E672E
		Protected Sub TrimStartChars(vm As ObjoScript.VM)
		  /// Returns this string with `chars` removed from the beginning.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the `chars` argument
		  ///
		  /// String.trimStart(chars) -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.TrimLeft(vm.GetSlotAsString(1)))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320616E207570706572636173652076657273696F6E206F66207468697320737472696E672E
		Protected Sub Uppercase(vm As ObjoScript.VM)
		  /// Returns an uppercase version of this string.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  ///
		  /// String.uppercase() -> string
		  
		  Var s As String = vm.GetSlotValue(0)
		  vm.SetReturn(s.Uppercase)
		  
		End Sub
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
