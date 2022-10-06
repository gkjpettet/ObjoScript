#tag Class
Protected Class ObjoScriptTestGroupBase
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub AssertOutputsEqual(testName As String)
		  /// Compiles the test source for `testName`, runs it and asserts that its output matches the expected output.
		  ///
		  /// Expects `testName` to be in the format: topic.subtopic.testName
		  
		  Var func As ObjoScript.Func = CompileTest(testName)
		  Var expected As String = GetExpectedResult(testName)
		  Var result As String = RunFunc(func)
		  Assert.AreEqual(result, expected)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4C6F6164732074686520736F7572636520636F646520666F72207468652074657374206E616D65642060746573744E616D65602C20636F6D70696C65732069742028616C6F6E6720776974682074686520564D2773207374616E64617264206C6962726172792920616E642072657475726E732074686520726573756C74696E672066756E6374696F6E2E
		Function CompileTest(testName As String) As ObjoScript.Func
		  /// Loads the source code for the test named `testName`, compiles it (along with the VM's standard library)
		  /// and returns the resulting function.
		  ///
		  /// Expects `testName` to be in the format: topic.subtopic.testName
		  /// This mirrors the folder structure of the bundled tests (which are in tests/source/topic/subtopic/)
		  /// NB: We do not expect `.objo` to be appended to testName.
		  
		  // Get the required test.
		  Var parts() As String = testName.Split(".")
		  If parts.Count <> 3 Then
		    Raise New InvalidArgumentException("Invalid testName format (" + testName + "). Expected topic.subtopic.testName")
		  End If
		  
		  // Add the .objo extension to the test name.
		  parts(2) = parts(2) + ".objo"
		  
		  Var f As FolderItem = SpecialFolder.Resource("tests")
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests` folder.")
		  End If
		  f = f.Child("source")
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/source` folder.")
		  End If
		  f = f.Child(parts(0)) // topic
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/source/`" + parts(0) + " folder.")
		  End If
		  f = f.Child(parts(1)) // subtopic
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/source/`" + parts(0) + "/" + parts(1) + " folder.")
		  End If
		  f = f.Child(parts(2)) // test file
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/source/`" + parts(0) + "/" + parts(1) + parts(2) + " test file.")
		  End If
		  
		  // Get the source code to compile.
		  Var tin As TextInputStream = TextInputStream.Open(f)
		  Var source As String = tin.ReadAll
		  tin.Close
		  
		  Compiler = New ObjoScript.Compiler
		  Return Compiler.Compile(source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520657870656374656420726573756C742066726F6D2072756E6E696E67207468652074657374206E616D65642060746573744E616D65602E
		Function GetExpectedResult(testName As String) As String
		  /// Returns the expected result from running the test named `testName`.
		  ///
		  /// Expects `testName` to be in the format: topic.subtopic.testName
		  /// This mirrors the folder structure of the bundled tests (which are in tests/expected/topic/subtopic/)
		  /// NB: We do not expect a file extension to be appended to testName.
		  
		  // Get the expected results file.
		  Var parts() As String = testName.Split(".")
		  If parts.Count <> 3 Then
		    Raise New InvalidArgumentException("Invalid testName format (" + testName + "). Expected topic.subtopic.testName")
		  End If
		  
		  // Add the .txt extension to the test name.
		  parts(2) = parts(2) + ".txt"
		  
		  Var f As FolderItem = SpecialFolder.Resource("tests")
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests` folder.")
		  End If
		  f = f.Child("expected")
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/expected` folder.")
		  End If
		  f = f.Child(parts(0)) // topic
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/expected/`" + parts(0) + " folder.")
		  End If
		  f = f.Child(parts(1)) // subtopic
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/expected/`" + parts(0) + "/" + parts(1) + " folder.")
		  End If
		  f = f.Child(parts(2)) // test file
		  If f = Nil Then
		    Raise New InvalidArgumentException("Unable to retrieve the `tests/expected/`" + parts(0) + "/" + parts(1) + parts(2) + " test file.")
		  End If
		  
		  // Get the expected result as a string
		  Var tin As TextInputStream = TextInputStream.Open(f)
		  Var expected As String = tin.ReadAll
		  tin.Close
		  
		  Return expected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E73206066756E636020696E2061206E657720564D20616E642072657475726E7320616C6C207072696E746564206F7574707574206173206120737472696E672E
		Function RunFunc(func As ObjoScript.Func) As String
		  /// Runs `func` in a new VM and returns all printed output as a string.
		  
		  var vm As New ObjoScript.VM
		  AddHandler vm.Print, AddressOf VMPrintDelegate
		  
		  mPrintBuffer = ""
		  
		  vm.Interpret(func)
		  
		  RemoveHandler vm.Print, AddressOf VMPrintDelegate
		  
		  Return mPrintBuffer.TrimRight
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VMPrintDelegate(sender As ObjoScript.VM, s As String)
		  #Pragma Unused sender
		  
		  mPrintBuffer = mPrintBuffer + s + EndOfLine
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Compiler As ObjoScript.Compiler
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPrintBuffer As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Duration"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailedTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeGroup"
			Visible=false
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
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
			Name="IsRunning"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NotImplementedCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PassedTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SkippedTestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StopTestOnFail"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
End Class
#tag EndClass
