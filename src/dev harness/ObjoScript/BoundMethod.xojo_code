#tag Class
Protected Class BoundMethod
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(receiver As Variant, method As ObjoScript.Func, isStatic As Boolean)
		  Self.Receiver = receiver
		  Self.Method = method
		  Self.IsStatic = isStatic
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320626F756E64206D6574686F642E
		Function ToString() As String
		  /// Returns a string representation of this bound method.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return Method.ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As ObjoScript.ValueTypes
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.BoundMethod
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120737461746963206D6574686F642E
		IsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6D70696C656420626F756E64206D6574686F642E
		Method As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C617373206F7220696E7374616E63652074686973206D6574686F6420697320626F756E6420746F2E
		Receiver As Variant
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
	#tag EndViewBehavior
End Class
#tag EndClass
