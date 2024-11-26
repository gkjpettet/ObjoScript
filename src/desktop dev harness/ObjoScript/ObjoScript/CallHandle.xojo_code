#tag Class
Protected Class CallHandle
	#tag Method, Flags = &h0
		Sub Constructor(vm As ObjoScript.VM, bm As ObjoScript.BoundMethod)
		  mVM = New WeakRef(vm)
		  mBoundMethod = bm
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Invoke()
		  If VM <> Nil Then VM.InvokeHandle(Self)
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mBoundMethod
			End Get
		#tag EndGetter
		BoundMethod As ObjoScript.BoundMethod
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mBoundMethod As ObjoScript.BoundMethod
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVM As WeakRef
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mVM = Nil Or mVM.Value = Nil Then
			    Return Nil
			  Else
			    Return ObjoScript.VM(mVM.Value)
			  End If
			  
			End Get
		#tag EndGetter
		VM As ObjoScript.VM
	#tag EndComputedProperty


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
