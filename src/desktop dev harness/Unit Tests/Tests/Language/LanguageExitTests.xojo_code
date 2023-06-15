#tag Class
Protected Class LanguageExitTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub FunctionInForEachTest()
		  AssertOutputEquals("language.exit.function_in_foreach")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FunctionInWhileTest()
		  AssertOutputEquals("language.exit.function_in_while")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InForLoopTest()
		  AssertOutputEquals("language.exit.in_for_loop")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InFunctionTest()
		  AssertCompilerError("language.exit.in_function")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InMethodTest()
		  AssertCompilerError("language.exit.in_method")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedForEachLoopTest()
		  AssertOutputEquals("language.exit.nested_foreach_loop")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedWhileLoopTest()
		  AssertOutputEquals("language.exit.nested_while_loop")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OutsideLoopTest()
		  AssertCompilerError("language.exit.outside_loop")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopLocalScopesTest()
		  AssertOutputEquals("language.exit.pop_local_scopes")
		  
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
