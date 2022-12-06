#tag Module
Protected Module FSItem
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E67207468652046534974656D20636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the FSItem class constructor.
		  ///
		  /// constructor(path)
		  
		  If args.Count <> 1 Then
		    vm.Error("Invalid number of arguments (expected 1, got " + args.Count.ToString + ").")
		  End If
		  
		  // Assert that `path` is a string.
		  If args(0).Type <> Variant.TypeString Then
		    vm.Error("The `path` argument must be a string.")
		  End If
		  Var path As String = args(0)
		  
		  Try
		    instance.ForeignData = New FolderItem(path, FolderItem.PathModes.Native)
		  Catch e As RuntimeException
		    vm.Error("Invalid file path `" + path + "`.")
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E20746865206046534974656D6020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `FSItem` class or Nil 
		  /// if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return InstanceMethods.Lookup(signature, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20696E7374616E6365206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseInstanceMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign instance 
		  /// methods to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("path()")      = AddressOf Path
		  d.Value("readLines()") = AddressOf ReadLines
		  d.Value("toString()")  = AddressOf ToString
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F647320746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static methods to 
		  /// Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("resources()") = AddressOf Resources
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207061746820746F20746869732066696C652073797374656D206974656D2E
		Protected Sub Path(vm As ObjoScript.VM)
		  /// Returns the path to this file system item.
		  ///
		  /// Assumes slot 0 is a FSItem instance.
		  /// FSItem.path() -> string
		  
		  Var file As FolderItem = ObjoScript.Instance(vm.GetSlotValue(0)).ForeignData
		  
		  vm.SetReturn(file.NativePath)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732061206C6973742077686572652065616368206974656D2069732061206C696E6520696E207468652066696C652E
		Protected Sub ReadLines(vm As ObjoScript.VM)
		  /// Returns a list where each item is a line in the file.
		  ///
		  /// FSItem.readLines() -> List
		  
		  Var file As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  // Error checks.
		  If file.ForeignData = Nil Or FolderItem(file.ForeignData).Exists = False Then
		    vm.Error("The file does not exist.")
		  ElseIf FolderItem(file.ForeignData).IsFolder Then
		    vm.Error("Cannot read lines from a folder.")
		  ElseIf Not FolderItem(file.ForeignData).IsReadable Then
		    vm.Error("Cannot read file.")
		  End If
		  
		  Var tin As TextInputStream
		  Var lines() As String
		  Try
		    tin = TextInputStream.Open(file.ForeignData)
		    While Not tin.EndOfFile
		      lines.Add(tin.ReadLine)
		    Wend
		  Catch e As RuntimeException
		    vm.Error("An error occurred whilst reading the file: `" + e.Message + "`.")
		  Finally
		    tin.Close
		  End Try
		  
		  vm.SetReturn(vm.NewList(lines))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865207061746820746F20746865207265736F757263657320666F6C646572206F662074686520686F7374206170706C69636174696F6E2E
		Protected Sub Resources(vm As ObjoScript.VM)
		  /// Returns the path to the resources folder of the host application.
		  ///
		  /// FSItem.resources() -> string
		  
		  vm.SetReturn(SpecialFolder.Resources.NativePath)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620746869732046534974656D2E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns a string representation of this FSItem.
		  ///
		  /// FSItem.toString() -> string
		  
		  vm.SetReturn(FolderItem(vm.GetSlotValue(0)).NativePath)
		  
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
