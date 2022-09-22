#tag Class
Protected Class Instance
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(klass As ObjoScript.Klass)
		  Self.Klass = klass
		  mName = Self.Klass.Name + " instance"
		  Self.Fields = New Dictionary
		  
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

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320696E7374616E63652E
		Function ToString() As String
		  /// Returns a string representation of this instance.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Instance
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320696E7374616E636527732070726976617465206669656C647320284B6579203D206E616D652C2056616C7565203D2056617269616E74292E
		Fields As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468697320696E7374616E6365277320636C6173732E
		Klass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320696E7374616E6365277320707265636F6D7075746564206E616D6520286372656174656420617420636F6E737472756374696F6E292E
		Private mName As String
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