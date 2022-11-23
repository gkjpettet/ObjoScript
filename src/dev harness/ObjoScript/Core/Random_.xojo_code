#tag Module
Protected Module Random_
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E67207468652052616E646F6D20636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the Random class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Random class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E20746865206052616E646F6D6020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Random` class or 
		  /// Nil if there is no such method.
		  
		  If isStatic Then
		    Return Nil
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance methods to Xojo 
		  /// method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("inRange(_,_)") = AddressOf InRange
		  d.Value("lessThan(_)") =  AddressOf LessThan
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612072616E646F6D20696E746567657220696E207468652072616E676520606D696E6020746F20606D61786020696E636C75736976652E
		Protected Sub InRange(vm As ObjoScript.VM)
		  /// Returns a random integer in the range `min` to `max` inclusive.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Random instance.
		  /// - Slot 1 is `min`
		  /// - Slot 2 is `max`
		  /// Random.inRange(min, max) -> integer number
		  
		  // Assert `min` and `max` are integer numbers.
		  If Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(1)) Then
		    vm.Error("The `min` argument must be an integer.")
		  ElseIf Not ObjoScript.VariantIsIntegerDouble(vm.GetSlotValue(2)) Then
		    vm.Error("The `max` argument must be an integer.")
		  End If
		  Var min As Integer = vm.GetSlotValue(1)
		  Var max As Integer = vm.GetSlotValue(2)
		  
		  vm.SetReturn(CType(System.Random.InRange(min, max), Double))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320612072616E646F6D20696E7465676572202860726573756C7460292077686572653A206030203C3D20726573756C74203C207570706572602E
		Protected Sub LessThan(vm As ObjoScript.VM)
		  /// Returns a random integer (`result`) where: `0 <= result < upper`.
		  ///
		  /// Assumes:
		  /// - Slot 0 contains a Random instance.
		  /// - Slot 1 is `upper`
		  /// Random.lessThan(upper) -> integer number
		  
		  // Assert `upper` is a number >= 0.
		  If Not vm.GetSlotValue(1).Type = Variant.TypeDouble Then
		    vm.Error("The `upper` argument must be a positive number.")
		  End If
		  Var upper As Double = vm.GetSlotValue(1)
		  
		  If upper < 0.0 Then
		    vm.Error("The `upper` argument must be a positive number.")
		  End If
		  
		  vm.SetReturn(CType(System.Random.LessThan(upper), Double))
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20696E7374616E6365206D6574686F647320646566696E6564206F6E207468652052616E646F6D20636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseInstanceMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected InstanceMethods As Dictionary
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
