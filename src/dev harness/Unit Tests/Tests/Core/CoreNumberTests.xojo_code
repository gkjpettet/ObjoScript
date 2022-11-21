#tag Class
Protected Class CoreNumberTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AbsTest()
		  AssertOutputsEqual("core.number.abs")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ACosTest()
		  AssertOutputsEqual("core.number.acos")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ASinTest()
		  AssertOutputsEqual("core.number.asin")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ATanTest()
		  AssertOutputsEqual("core.number.atan")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CeilTest()
		  AssertOutputsEqual("core.number.ceil")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CosTest()
		  AssertOutputsEqual("core.number.cos")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpTest()
		  AssertOutputsEqual("core.number.exp")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsIntegerTest()
		  AssertOutputsEqual("core.number.isInteger")
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
