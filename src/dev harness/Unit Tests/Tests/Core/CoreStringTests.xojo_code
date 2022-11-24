#tag Class
Protected Class CoreStringTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AddTest()
		  AssertOutputsEqual("core.string.add")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CodepointsTest()
		  AssertOutputsEqual("core.string.codepoints")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContainsTest()
		  AssertOutputsEqual("core.string.contains")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CountTest()
		  AssertOutputsEqual("core.string.count")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndsWithTest()
		  AssertOutputsEqual("core.string.endsWith")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForEachTest()
		  AssertOutputsEqual("core.string.foreach")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FromCodepointTest()
		  AssertOutputsEqual("core.string.fromCodepoint")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOfTest()
		  AssertOutputsEqual("core.string.indexOf")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LeftTest()
		  AssertOutputsEqual("core.string.left")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LowercaseTest()
		  AssertOutputsEqual("core.string.lowercase")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MiddleLengthOutOfBoundsTest()
		  AssertRuntimeError("core.string.middle_length_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MiddleNegativeStartTest()
		  AssertRuntimeError("core.string.middle_negative_start")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MiddleTest()
		  AssertOutputsEqual("core.string.middle")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultiplyTest()
		  AssertOutputsEqual("core.string.multiply")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAllTest()
		  AssertOutputsEqual("core.string.replaceAll")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceTest()
		  AssertOutputsEqual("core.string.replace")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RightTest()
		  AssertOutputsEqual("core.string.right")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SplitTest()
		  AssertOutputsEqual("core.string.split")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartsWithTest()
		  AssertOutputsEqual("core.string.startsWith")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TitlecaseTest()
		  AssertOutputsEqual("core.string.titlecase")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimEndTest()
		  AssertOutputsEqual("core.string.trimEnd")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimStartTest()
		  AssertOutputsEqual("core.string.trimStart")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimTest()
		  AssertOutputsEqual("core.string.trim")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UppercaseTest()
		  AssertOutputsEqual("core.string.uppercase")
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
