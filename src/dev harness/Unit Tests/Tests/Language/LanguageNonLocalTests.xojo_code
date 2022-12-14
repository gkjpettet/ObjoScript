#tag Class
Protected Class LanguageNonLocalTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AssignmentTest()
		  AssertOutputEquals("language.non_local.assignment")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateNonLocalTest()
		  AssertCompilerError("language.non_local.duplicate_nonlocal")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InBlockScopeTest()
		  AssertOutputEquals("language.non_local.in_block_scope")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalNameForwardDeclareTest()
		  AssertRuntimeError("language.non_local.localname_forward_declare")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MutualRecursionTest()
		  AssertOutputEquals("language.non_local.mutual_recursion")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NonLocalInInitialiserTest()
		  AssertRuntimeError("language.non_local.nonlocal_in_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NonLocalWithoutInitialiserTest()
		  AssertOutputEquals("language.non_local.nonlocal_without_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotDefinedTest()
		  AssertRuntimeError("language.non_local.not_defined")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseInFunctionBeforeDefinitionTest()
		  AssertOutputEquals("language.non_local.use_in_function_before_definition")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseInFunctionTest()
		  AssertOutputEquals("language.non_local.use_in_function")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseInMethodBeforeDeclarationTest()
		  AssertOutputEquals("language.non_local.use_in_method_before_declaration")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseInMethodTest()
		  AssertOutputEquals("language.non_local.use_in_method")
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
