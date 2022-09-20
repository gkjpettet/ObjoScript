#tag Class
Protected Class Value
	#tag Method, Flags = &h0
		Function AsFunction() As ObjoScript.Func
		  /// Returns this value as a `Func` object.
		  /// If this value is not a `Func` it raises an `UnsupportedOperationException`.
		  
		  Return mValue
		  
		  Exception e As IllegalCastException
		    Raise New UnsupportedOperationException("Cannot cast a value of type `" + Type.ToString + "` to `Func`.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(v As Variant)
		  If v IsA ObjoScript.Func Then
		    Self.mValue = v
		    Self.Type = ObjoScript.ValueTypes.Func
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown value type.")
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120756E6971756520696E7465676572206861736820726570726573656E74696E672074686973206F626A6563742E
		Function Hash() As Integer
		  /// A unique hash representing this value.
		  
		  Select Case Type
		  Case ObjoScript.ValueTypes.Func
		    Return mValue.Hash
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown value type.")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620746869732076616C75652E
		Function ToString() As String
		  /// Returns a string representation of this value.
		  
		  Select Case Type
		  Case ObjoScript.ValueTypes.Func
		    Return ObjoScript.Func(mValue).ToString
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown value type.")
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865207261772076616C75652E
		Private mValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Type As ObjoScript.ValueTypes
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
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ObjoScript.ValueTypes"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
