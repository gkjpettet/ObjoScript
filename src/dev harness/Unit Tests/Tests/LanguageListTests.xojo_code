#tag Class
Protected Class LanguageListTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub DuplicateCommaTest()
		  AssertCompilerError("language.list.duplicate_comma")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DuplicateTrailingCommaTest()
		  AssertCompilerError("language.list.duplicate_trailing_comma")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EmptyListWithCommaTest()
		  AssertCompilerError("language.list.empty_list_with_comma")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EOFAfterCommaTest()
		  AssertCompilerError("language.list.eof_after_comma")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EOFAfterElementTest()
		  AssertCompilerError("language.list.eof_after_element")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GrowShrinkTest()
		  AssertOutputsEqual("language.list.grow_shrink")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NewlinesTest()
		  AssertOutputsEqual("language.list.newlines")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrailingCommaTest()
		  AssertCompilerError("language.list.trailing_comma")
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
