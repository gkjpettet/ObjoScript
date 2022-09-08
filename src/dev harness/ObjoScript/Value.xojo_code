#tag Class
Protected Class Value
Implements ObjoScript.Comparable
	#tag Method, Flags = &h0
		Sub Constructor(d As Double)
		  Self.Type = Value.Types.Number
		  Self.Data = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(type As ObjoScript.Value.Types, data As Variant)
		  Self.Type = type
		  Self.Data = data
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120756E6971756520696E7465676572206861736820726570726573656E74696E672074686973206F626A6563742E
		Function Hash() As Integer
		  /// Returns a unique integer hash representing this object.
		  ///
		  /// Part of the ObjoScript.Comparable interface.
		  
		  Select Case Self.Type
		  Case Value.Types.Nothing
		    // This clashes with the integer value `0` obviously.
		    Return 0
		    
		  Case Value.Types.Number
		    Return data.Hash
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown value type.")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  /// Returns a string representation of this value.
		  
		  Select Case Self.Type
		  Case Value.Types.Nothing
		    Return "Nothing"
		    
		  Case Value.Types.Number
		    Return data.StringValue
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown value type.")
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546869732076616C756527732061637475616C20646174612E
		Data As Variant
	#tag EndProperty

	#tag Property, Flags = &h0
		Type As ObjoScript.Value.Types = ObjoScript.Value.Types.Nothing
	#tag EndProperty


	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Number
		Nothing
	#tag EndEnum


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
