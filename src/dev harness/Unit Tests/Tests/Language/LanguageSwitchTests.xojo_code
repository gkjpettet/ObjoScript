#tag Class
Protected Class LanguageSwitchTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub ElseTest()
		  AssertOutputEquals("language.switch.else")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FunctionValueFunctionCaseTest()
		  AssertOutputEquals("language.switch.function_value_function_case")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IfWithinSwitchTest()
		  AssertOutputEquals("language.switch.if_within_switch")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingCaseTest()
		  AssertCompilerError("language.switch.missing_case")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultipleCasesTest()
		  AssertOutputEquals("language.switch.multiple_cases")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedTest()
		  AssertOutputEquals("language.switch.nested")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleCase1Test()
		  AssertOutputEquals("language.switch.single_case1")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleCase2Test()
		  AssertOutputEquals("language.switch.single_case2")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleCase3Test()
		  AssertOutputEquals("language.switch.single_case3")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwitchOnFunctionObjectTest()
		  AssertRuntimeError("language.switch.switch_on_function_object")
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
