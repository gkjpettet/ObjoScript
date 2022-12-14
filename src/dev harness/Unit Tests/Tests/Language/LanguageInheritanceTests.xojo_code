#tag Class
Protected Class LanguageInheritanceTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub DoNotInheritStaticMethodsTest()
		  AssertRuntimeError("language.inheritance.do_not_inherit_static_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFieldsTest()
		  AssertOutputEquals("language.inheritance.inherit_fields")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromBooleanTest()
		  AssertCompilerError("language.inheritance.inherit_from_boolean")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromListTest()
		  AssertCompilerError("language.inheritance.inherit_from_list")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromNonClassTest()
		  AssertCompilerError("language.inheritance.inherit_from_nonclass")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromNothingTest()
		  AssertCompilerError("language.inheritance.inherit_from_nothing")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromNumberTest()
		  AssertCompilerError("language.inheritance.inherit_from_number")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritFromStringTest()
		  AssertCompilerError("language.inheritance.inherit_from_string")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InheritMethodsTest()
		  AssertOutputEquals("language.inheritance.inherit_methods")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTest()
		  AssertOutputEquals("language.inheritance.is")
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
