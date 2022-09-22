#tag Class
Protected Class Value
	#tag Method, Flags = &h0, Description = 52657475726E7320746869732076616C7565206173206120604B6C61737360206F626A6563742E20496620746869732076616C7565206973206E6F74206120604B6C617373602069742072616973657320616E2060556E737570706F727465644F7065726174696F6E457863657074696F6E602E
		Function AsClass() As ObjoScript.Klass
		  /// Returns this value as a `Klass` object.
		  /// If this value is not a `Klass` it raises an `UnsupportedOperationException`.
		  
		  Return mValue
		  
		  Exception e As IllegalCastException
		    Raise New UnsupportedOperationException("Cannot cast a value of type `" + Type.ToString + "` to `Klass`.")
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsFunction() As ObjoScript.Func
		  /// Returns this value as a `Func` object.
		  /// If this value is not a `Func` it raises an `UnsupportedOperationException`.
		  
		  Return mValue
		  
		  Exception e As IllegalCastException
		    Raise New UnsupportedOperationException("Cannot cast a value of type `" + Type.ToString + "` to `Func`.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746869732076616C7565206173206120604B6C61737360206F626A6563742E20496620746869732076616C7565206973206E6F74206120604B6C617373602069742072616973657320616E2060556E737570706F727465644F7065726174696F6E457863657074696F6E602E
		Function AsInstance() As ObjoScript.Instance
		  /// Returns this value as an `Instance` object.
		  /// If this value is not an `Instance` it raises an `UnsupportedOperationException`.
		  
		  Return mValue
		  
		  Exception e As IllegalCastException
		    Raise New UnsupportedOperationException("Cannot cast a value of type `" + Type.ToString + "` to `Instance`.")
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(v As Variant)
		  If v IsA ObjoScript.Instance Then
		    mValue = v
		    Type = ObjoScript.ValueTypes.Instance
		    
		  ElseIf v IsA ObjoScript.Func Then
		    mValue = v
		    Type = ObjoScript.ValueTypes.Func
		    
		  ElseIf v IsA ObjoScript.Klass Then
		    mValue = v
		    Type = ObjoScript.ValueTypes.Klass
		    
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
		  Case ObjoScript.ValueTypes.Instance
		    Return ObjoScript.Instance(mValue).Klass.Name + " instance"
		    
		  Case ObjoScript.ValueTypes.Func
		    Return ObjoScript.Func(mValue).ToString
		    
		  Case ObjoScript.ValueTypes.Klass
		    Return ObjoScript.Klass(mValue).ToString
		    
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
			EditorType="Enum"
			#tag EnumValues
				"0 - Func"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
