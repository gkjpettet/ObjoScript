#tag Class
Protected Class CoreListTests
Inherits ObjoScriptTestGroupBase
	#tag Method, Flags = &h0
		Sub AddAllTest()
		  AssertOutputsEqual("core.list.addAll")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CloneTest()
		  AssertOutputsEqual("core.list.clone")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CountTest()
		  AssertOutputsEqual("core.list.count")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FilledTest()
		  AssertOutputsEqual("core.list.filled")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOfTest()
		  AssertOutputsEqual("core.list.indexOf")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertNegativeOutOfBoundsTest()
		  AssertRuntimeError("core.list.insert_negative_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertNonIntegerIndexTest()
		  AssertRuntimeError("core.list.insert_non_integer_index")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertPositiveOutOfBoundsTest()
		  AssertRuntimeError("core.list.insert_positive_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertTest()
		  AssertOutputsEqual("core.list.insert")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MultiplyTest()
		  AssertOutputsEqual("core.list.multiply")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlusTest()
		  AssertOutputsEqual("core.list.plus")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAtNegativeOutOfBoundsTest()
		  AssertRuntimeError("core.list.removeAt_negative_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAtNonIntegerIndexTest()
		  AssertRuntimeError("core.list.removeAt_non_integer_index")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAtPositiveOutOfBoundsTest()
		  AssertRuntimeError("core.list.removeAt_positive_out_of_bounds")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAtTest()
		  AssertOutputsEqual("core.list.removeAt")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveTest()
		  AssertOutputsEqual("core.list.remove")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortFastTest()
		  AssertOutputsEqual("core.list.sortFast")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptNegativeIndicesTest()
		  AssertOutputsEqual("core.list.subscript_negative_indices")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptRangeNegativeTest()
		  AssertRuntimeError("core.list.subscript_range_negative")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubscriptRangeTest()
		  AssertOutputsEqual("core.list.subscript_range")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SwapTest()
		  AssertOutputsEqual("core.list.swap")
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
