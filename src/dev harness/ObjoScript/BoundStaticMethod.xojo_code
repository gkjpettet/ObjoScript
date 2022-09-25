#tag Class
Protected Class BoundStaticMethod
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(receiver As ObjoScript.Klass, method As ObjoScript.Func)
		  Self.Receiver = receiver
		  Self.Method = method
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120756E6971756520696E74656765722068617368206F662074686973206F626A6563742E
		Function Hash() As Integer
		  /// Returns a unique integer hash of this object. 
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Var v As Variant = Self
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320626F756E64206D6574686F642E
		Function ToString() As String
		  /// Returns a string representation of this bound method.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return "static " + Method.ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As ObjoScript.ValueTypes
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.BoundStaticMethod
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6D70696C6564206D6574686F642E
		Method As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C617373207468697320737461746963206D6574686F6420697320626F756E6420746F2E
		Receiver As ObjoScript.Klass
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
