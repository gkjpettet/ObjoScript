#tag Class
Protected Class CallHandle
	#tag Method, Flags = &h0
		Sub Constructor(index As Integer, argCount As Integer)
		  mIndex = index
		  mArgCount = argCount
		  
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E747320746869732063616C6C2072657175697265732E
		#tag Getter
			Get
			  Return mArgCount
			End Get
		#tag EndGetter
		ArgCount As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E646578206F6620746869732068616E646C6520696E2074686520564D277320696E7465726E616C206043616C6C48616E646C65732829602061727261792E
		#tag Getter
			Get
			  Return mIndex
			End Get
		#tag EndGetter
		Index As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mArgCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndex As Integer = -1
	#tag EndProperty


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
		#tag ViewProperty
			Name="mIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
