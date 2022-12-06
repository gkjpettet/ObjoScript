#tag Class
Protected Class CoreFSItemTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub NameTest()
		  AssertOutputEquals("core.fsitem.name")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PathTest()
		  #Pragma Warning "TODO: Test on Windows and Linux"
		  
		  // Get and compile the source code for the test.
		  Var source As String = GetTestSourceCode("core.fsitem.path")
		  Var func As ObjoScript.Func = CompileTest(source)
		  
		  // Get the output of the compiled test.
		  Var result As String = RunFunc(func)
		  
		  Assert.IsTrue(result.EndsWith("path.txt"), "Output:" + EndOfLine + EndOfLine + result, source)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReadLinesTest()
		  AssertOutputEquals("core.fsitem.readlines")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResourcesTest()
		  #Pragma Warning "TODO: Test on Windows and Linux"
		  
		  // Get and compile the source code for the test.
		  Var source As String = GetTestSourceCode("core.fsitem.resources")
		  Var func As ObjoScript.Func = CompileTest(source)
		  
		  // Get the output of the compiled test.
		  Var result As String = RunFunc(func)
		  
		  Assert.IsTrue(result.EndsWith("Contents/Resources"), "Output:" + EndOfLine + EndOfLine + result, source)
		  
		End Sub
	#tag EndMethod


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
			Name="IsRunning"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TestCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
End Class
#tag EndClass
