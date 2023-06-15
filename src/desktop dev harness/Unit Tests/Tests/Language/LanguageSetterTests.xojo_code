#tag Class
Protected Class LanguageSetterTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AssociativityTest()
		  AssertOutputEquals("language.setter.associativity")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GroupingTest()
		  AssertCompilerError("language.setter.grouping")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InfixOperatorTest()
		  AssertCompilerError("language.setter.infix_operator")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InstanceTest()
		  AssertOutputEquals("language.setter.instance")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTest()
		  AssertCompilerError("language.setter.is")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrefixOperatorTest()
		  AssertCompilerError("language.setter.prefix_operator")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResultTest()
		  AssertOutputEquals("language.setter.result")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SameNameAsMethodTest()
		  AssertOutputEquals("language.setter.same_name_as_method")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StaticTest()
		  AssertOutputEquals("language.setter.static")
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
