#tag Class
Protected Class ForeignMethod
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(signature As String, arity As Integer, method As ObjoScript.ForeignMethodDelegate)
		  Self.Signature = signature
		  Self.Arity = arity
		  Self.Method = method
		  mToString = "foreign " + Signature
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320666F726569676E206D6574686F642E
		Function ToString() As String
		  /// Returns a string representation of this foreign method.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As ObjoScript.ValueTypes
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.ForeignMethod
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E7473207468697320666F726569676E206D6574686F642072657175697265732E
		Arity As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520586F6A6F206D6574686F6420746F20696E766F6B65207768656E207468697320666F726569676E206D6574686F642069732063616C6C65642E
		Method As ObjoScript.ForeignMethodDelegate
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 507265636F6D70757465642076616C756520666F722060546F537472696E672829602E
		Private mToString As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320666F726569676E206D6574686F642773207369676E61747572652E
		Signature As String
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
			Name="Signature"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
