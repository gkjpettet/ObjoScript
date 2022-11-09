#tag Class
Protected Class LanguageMethodTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub ArityTest()
		  AssertOutputsEqual("language.method.arity")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateInstanceMethodsTest()
		  AssertCompilerError("language.method.duplicate_instance_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateStaticMethodsTest()
		  AssertCompilerError("language.method.duplicate_static_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyBlockTest()
		  AssertOutputsEqual("language.method.empty_block")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptySubscriptDefinitionTest()
		  AssertCompilerError("language.method.empty_subscript_definition")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptySubscriptTest()
		  AssertCompilerError("language.method.empty_subscript")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LongNameTest()
		  AssertOutputsEqual("language.method.long_name")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ManyMethodsTest()
		  AssertOutputsEqual("language.method.many_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotFoundElevenArgumentsTest()
		  AssertRuntimeError("language.method.not_found_eleven_arguments")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotFoundOneArgumentTest()
		  AssertRuntimeError("language.method.not_found_one_argument")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotFoundTwoArgumentsTest()
		  AssertRuntimeError("language.method.not_found_two_arguments")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OperatorsTest()
		  AssertOutputsEqual("language.method.operators")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PermittedDuplicateMethodsTest()
		  AssertOutputsEqual("language.method.permitted_duplicate_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StaticMethodNotFoundTest()
		  AssertRuntimeError("language.method.static_method_not_found")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StaticOperatorsTest()
		  AssertOutputsEqual("language.method.static_operators")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StaticTest()
		  AssertOutputsEqual("language.method.static")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptOperatorsTest()
		  AssertOutputsEqual("language.method.subscript_operators")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptSetterTooManyArgsTest()
		  AssertRuntimeError("language.method.subscript_setter_too_many_arguments")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptTooManyArgsTest()
		  AssertRuntimeError("language.method.subscript_too_many_arguments")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TooManyArgsTest()
		  AssertRuntimeError("language.method.too_many_arguments")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TooManyParamsTest()
		  AssertCompilerError("language.method.too_many_parameters")
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
