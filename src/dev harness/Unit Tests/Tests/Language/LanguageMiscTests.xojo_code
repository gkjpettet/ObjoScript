#tag Class
Protected Class LanguageMiscTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub BitwisePrecedenceTest()
		  AssertOutputEquals("language.misc.bitwise_precedence")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChainedTest()
		  AssertOutputEquals("language.misc.chained")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyBlockTest()
		  AssertOutputEquals("language.misc.empty_block")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyFileTest()
		  AssertOutputEquals("language.misc.empty_file")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyValueConstructorTest()
		  AssertOutputEquals("language.misc.keyvalue_constructor")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyValueEqualityTest()
		  AssertOutputEquals("language.misc.keyvalue_equality")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NoTrailingNewlineTest()
		  AssertOutputEquals("language.misc.no_trailing_newline")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrecedenceTest()
		  AssertOutputEquals("language.misc.precedence")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SemicolonTest()
		  AssertCompilerError("language.misc.semicolon")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnexpectedCharacterTest()
		  AssertCompilerError("language.misc.unexpected_character")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WhitespaceTest()
		  AssertOutputEquals("language.misc.whitespace")
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
