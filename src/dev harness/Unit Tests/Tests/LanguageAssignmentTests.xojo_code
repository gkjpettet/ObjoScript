#tag Class
Protected Class LanguageAssignmentTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AssociativityTest()
		  AssertOutputsEqual("language.assignment.associativity")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GlobalTest()
		  AssertOutputsEqual("language.assignment.global")
		  
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
		Sub IsTest()
		  AssertCompilerError("language.assignment.is")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LocalTest()
		  AssertOutputsEqual("language.assignment.local")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrefixOperatorTest()
		  AssertCompilerError("language.assignment.prefix_operator")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SyntaxTest()
		  AssertOutputsEqual("language.assignment.syntax")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UndefinedTest()
		  AssertRuntimeError("language.assignment.undefined")
		End Sub
	#tag EndMethod


	#tag ViewBehavior
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
