#tag Class
Protected Class CoreNumberTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AbsTest()
		  AssertOutputEquals("core.number.abs")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ACosTest()
		  AssertOutputEquals("core.number.acos")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ASinTest()
		  AssertOutputEquals("core.number.asin")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ATanTest()
		  AssertOutputEquals("core.number.atan")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CeilTest()
		  AssertOutputEquals("core.number.ceil")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CosTest()
		  AssertOutputEquals("core.number.cos")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpTest()
		  AssertOutputEquals("core.number.exp")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FloorTest()
		  AssertOutputEquals("core.number.floor")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsIntegerTest()
		  AssertOutputEquals("core.number.isInteger")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LogTest()
		  AssertOutputEquals("core.number.log")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxTest()
		  AssertOutputEquals("core.number.max")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinTest()
		  AssertOutputEquals("core.number.min")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PowTest()
		  AssertOutputEquals("core.number.pow")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RoundTest()
		  AssertOutputEquals("core.number.round")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SignTest()
		  AssertOutputEquals("core.number.sign")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SinTest()
		  AssertOutputEquals("core.number.sin")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SqrtTest()
		  AssertOutputEquals("core.number.sqrt")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TanTest()
		  AssertOutputEquals("core.number.tan")
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
