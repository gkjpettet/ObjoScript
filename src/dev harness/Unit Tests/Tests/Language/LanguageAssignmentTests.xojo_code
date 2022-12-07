#tag Class
Protected Class LanguageAssignmentTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AssociativityTest()
		  AssertOutputEquals("language.assignment.associativity")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FieldCompoundAssignmentTest()
		  AssertOutputEquals("language.assignment.field_compound_assignment")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GlobalTest()
		  AssertOutputEquals("language.assignment.global")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupingTest()
		  AssertCompilerError("language.assignment.grouping")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InfixOperatorTest()
		  AssertCompilerError("language.assignment.infix_operator")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalTest()
		  AssertOutputEquals("language.assignment.local")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrefixOperatorTest()
		  AssertCompilerError("language.assignment.prefix_operator")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StaticFieldCompoundAssignmentTest()
		  AssertOutputEquals("language.assignment.static_field_compound_assignment")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SyntaxTest()
		  AssertOutputEquals("language.assignment.syntax")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndefinedTest()
		  AssertRuntimeError("language.assignment.undefined")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VariableCompoundAssignmentTest()
		  AssertOutputEquals("language.assignment.variable_compound_assignment")
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
