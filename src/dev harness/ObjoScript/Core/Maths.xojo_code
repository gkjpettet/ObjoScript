#tag Module
Protected Module Maths
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865204D6174687320636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the Maths class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("You cannot instantiate the Maths class.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604D617468736020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Maths` class or Nil if there is no such method.
		  
		  #Pragma Warning "TODO: Add more methods"
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub E_(vm As ObjoScript.VM)
		  /// Returns the value of `e`, the base of natural logarithms.
		  
		  vm.SetReturn(E)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F6420746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static method to Xojo method addresses.
		  
		  #Pragma Warning "TODO: Add more methods"
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("e()")   = AddressOf E_
		  d.Value("pi()")  = AddressOf Pi_
		  d.Value("tau()") = AddressOf Tau_
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F6620CF802E
		Protected Sub Pi_(vm As ObjoScript.VM)
		  /// Returns the value of π.
		  
		  vm.SetReturn(PI)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F6620CF842C206571756976616C656E7420746F2032202A20CF802E
		Protected Sub Tau_(vm As ObjoScript.VM)
		  /// Returns the value of τ, equivalent to 2 * π.
		  
		  vm.SetReturn(TAU)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E20746865204D6174687320636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseStaticMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected StaticMethods As Dictionary
	#tag EndComputedProperty


	#tag Constant, Name = E, Type = Double, Dynamic = False, Default = \"2.718281828459045", Scope = Protected, Description = 5468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
	#tag EndConstant

	#tag Constant, Name = PI, Type = Double, Dynamic = False, Default = \"3.14159265359", Scope = Protected, Description = 5468652076616C7565206F662060CF806020746F20313120646563696D616C20706C616365732E
	#tag EndConstant

	#tag Constant, Name = TAU, Type = Double, Dynamic = False, Default = \"6.2831853071800001", Scope = Protected, Description = 5468652076616C7565206F6620CF842C206571756976616C656E7420746F2032202A20CF802E
	#tag EndConstant


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
