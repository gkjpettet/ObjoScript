#tag Class
Protected Class LanguageVariableTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub DuplicateLocalTest()
		  AssertCompilerError("language.variable.duplicate_local")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateParameterTest()
		  AssertCompilerError("language.variable.duplicate_parameter")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GlobalInInitialiserTest()
		  AssertRuntimeError("language.variable.global_in_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GlobalWithoutInitialiserTest()
		  AssertOutputsEqual("language.variable.global_without_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalCollideWithFunctionParameterTest()
		  AssertCompilerError("language.variable.local_collide_with_function_parameter")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalCollideWithMethodParameterTest()
		  AssertCompilerError("language.variable.local_collide_with_method_parameter")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalInInitialiserTest()
		  AssertRuntimeError("language.variable.local_in_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalInMiddleOfBlockTest()
		  AssertOutputsEqual("language.variable.local_in_middle_of_block")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalInNestedBlockTest()
		  AssertOutputsEqual("language.variable.local_in_nested_block")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalWithoutInitialiserTest()
		  AssertOutputsEqual("language.variable.local_without_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ManyLocalsTest()
		  AssertOutputsEqual("language.variable.many_locals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ManyNonSimultaneousLocalsTest()
		  AssertOutputsEqual("language.variable.many_nonsimultaneous_locals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewLineAfterEqualsTest()
		  AssertCompilerError("language.variable.newline_after_equals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewlineAfterVarTest()
		  AssertCompilerError("language.variable.newline_after_var")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OutsideMethodTest()
		  AssertOutputsEqual("language.variable.outside_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScopeIfTest()
		  AssertOutputsEqual("language.variable.scope_if")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScopeReuseInDifferentBlocksTest()
		  AssertOutputsEqual("language.variable.scope_reuse_in_different_blocks")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScopeWhileTest()
		  AssertOutputsEqual("language.variable.scope_while")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShadowAndLocalTest()
		  AssertOutputsEqual("language.variable.shadow_and_local")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShadowGlobalTest()
		  AssertOutputsEqual("language.variable.shadow_global")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShadowInInitialiserTest()
		  AssertOutputsEqual("language.variable.shadow_in_initialiser")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShadowLocalTest()
		  AssertOutputsEqual("language.variable.shadow_local")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TooManyLocalsNestedTest()
		  AssertCompilerError("language.variable.too_many_locals_nested")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TooManyLocalsTest()
		  AssertCompilerError("language.variable.too_many_locals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndefinedGlobalTest()
		  AssertRuntimeError("language.variable.undefined_global")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndefinedLocalTest()
		  AssertRuntimeError("language.variable.undefined_local")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseFalseAsVarTest()
		  AssertCompilerError("language.variable.use_false_as_var")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseFieldAsVarTest()
		  AssertCompilerError("language.variable.use_field_as_var")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseNothingAsVarTest()
		  AssertCompilerError("language.variable.use_nothing_as_var")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseThisAsVarTest()
		  AssertCompilerError("language.variable.use_this_as_var")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseTrueAsVarTest()
		  AssertCompilerError("language.variable.use_true_as_var")
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
