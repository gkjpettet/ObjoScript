#tag Class
Protected Class LanguageSuperTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub CallDifferentArityTest()
		  AssertOutputEquals("language.super.call_different_arity")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CallOtherMethodTest()
		  AssertOutputEquals("language.super.call_other_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ImplicitNameTest()
		  AssertOutputEquals("language.super.implicit_name")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndirectlyInheritedTest()
		  AssertOutputEquals("language.super.indirectly_inherited")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedInvocationTest()
		  AssertOutputEquals("language.super.nested_invocation")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NestedSettersTest()
		  AssertOutputEquals("language.super.nested_setters")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NoSuperclassMethodTest()
		  AssertCompilerError("language.super.no_superclass_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperAtTopLevelTest()
		  AssertCompilerError("language.super.super_at_top_level")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperInInheritedMethodTest()
		  AssertOutputEquals("language.super.super_in_inherited_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperInStaticMethodTest()
		  AssertOutputEquals("language.super.super_in_static_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SuperInTopLevelFunctionTest()
		  AssertCompilerError("language.super.super_in_top_level_function")
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
