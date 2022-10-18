#tag Class
Protected Class LanguageConditionalTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub MissingColon2Test()
		  AssertCompilerError("language.conditional.missing_colon_2")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingColonTest()
		  AssertCompilerError("language.conditional.missing_colon")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingConditionTest()
		  AssertCompilerError("language.conditional.missing_condition")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingElseTest()
		  AssertCompilerError("language.conditional.missing_else")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingQuestionTest()
		  AssertCompilerError("language.conditional.missing_question")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MissingThenTest()
		  AssertCompilerError("language.conditional.missing_then")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewlineAfterColonTest()
		  AssertCompilerError("language.conditional.newline_after_colon")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewlineAfterQuestionTest()
		  AssertCompilerError("language.conditional.newline_after_question")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrecedenceTest()
		  AssertOutputsEqual("language.conditional.precedence")
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
