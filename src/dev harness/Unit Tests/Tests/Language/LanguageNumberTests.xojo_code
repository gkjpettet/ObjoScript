#tag Class
Protected Class LanguageNumberTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub HexLiteralsTest()
		  AssertOutputEquals("language.number.hex_literals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LiteralsTest()
		  AssertOutputEquals("language.number.literals")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScientificDoubleExponentTest()
		  AssertCompilerError("language.number.scientific_double_exponent")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScientificDoubleMissingExponentTest()
		  AssertCompilerError("language.number.scientific_double_missing_exponent")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScientificMissingFractionalPartTest()
		  AssertRuntimeError("language.number.scientific_missing_fractional_part")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScientificMultipleExponentSignsTest()
		  AssertCompilerError("language.number.scientific_multiple_exponent_signs")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScientificMultipleExponentsTest()
		  AssertCompilerError("language.number.scientific_multiple_exponents")
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
