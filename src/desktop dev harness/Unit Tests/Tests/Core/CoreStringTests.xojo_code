#tag Class
Protected Class CoreStringTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AddTest()
		  AssertOutputEquals("core.string.add")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CodepointsTest()
		  AssertOutputEquals("core.string.codepoints")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ContainsTest()
		  AssertOutputEquals("core.string.contains")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CountTest()
		  AssertOutputEquals("core.string.count")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EndsWithTest()
		  AssertOutputEquals("core.string.endsWith")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForEachTest()
		  AssertOutputEquals("core.string.foreach")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FromCodepointTest()
		  AssertOutputEquals("core.string.fromCodepoint")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexNegativeArgumentTest()
		  AssertRuntimeError("core.string.index_negative_argument")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOfTest()
		  AssertOutputEquals("core.string.indexOf")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOutOfBoundsTest()
		  AssertRuntimeError("core.string.index_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexTest()
		  AssertOutputEquals("core.string.index")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LeftTest()
		  AssertOutputEquals("core.string.left")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LowercaseTest()
		  AssertOutputEquals("core.string.lowercase")
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
		  AssertOutputEquals("core.string.middle")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultiplyTest()
		  AssertOutputEquals("core.string.multiply")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceAllTest()
		  AssertOutputEquals("core.string.replaceAll")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReplaceTest()
		  AssertOutputEquals("core.string.replace")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RightTest()
		  AssertOutputEquals("core.string.right")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SplitTest()
		  AssertOutputEquals("core.string.split")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartsWithTest()
		  AssertOutputEquals("core.string.startsWith")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TitlecaseTest()
		  AssertOutputEquals("core.string.titlecase")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimEndTest()
		  AssertOutputEquals("core.string.trimEnd")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimStartTest()
		  AssertOutputEquals("core.string.trimStart")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TrimTest()
		  AssertOutputEquals("core.string.trim")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UppercaseTest()
		  AssertOutputEquals("core.string.uppercase")
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
