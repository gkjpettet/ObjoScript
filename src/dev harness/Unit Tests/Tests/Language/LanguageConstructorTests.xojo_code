#tag Class
Protected Class LanguageConstructorTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub CannotBeStaticTest()
		  AssertCompilerError("language.constructor.cannot_be_static")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CannotReturnValueTest()
		  AssertCompilerError("language.constructor.cannot_return_value")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefaultTest()
		  AssertOutputEquals("language.constructor.default")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NoParameterListTest()
		  AssertCompilerError("language.constructor.no_parameter_list")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotInheritedTest()
		  AssertRuntimeError("language.constructor.not_inherited")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReturnWithoutValueTest()
		  AssertOutputEquals("language.constructor.return_without_value")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperclassTest()
		  AssertOutputEquals("language.constructor.superclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperMustHaveMethodTest()
		  AssertCompilerError("language.constructor.super_must_have_method")
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
