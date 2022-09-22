#tag Class
Protected Class Klass
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(name As String)
		  Self.Name = name
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4120756E6971756520696E7465676572206861736820726570726573656E74696E6720746869732076616C75652E
		Function Hash() As Integer
		  /// A unique integer hash representing this value.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Var v As Variant = Self
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320636C6173732E
		Function ToString() As String
		  /// Returns a string representation of this class.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return Name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Klass
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C6173732E
		Name As String
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
			Name="Name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
