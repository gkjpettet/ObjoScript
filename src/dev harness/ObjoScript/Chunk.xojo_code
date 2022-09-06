#tag Class
Protected Class Chunk
	#tag Method, Flags = &h0, Description = 416464732061206E756D6572696320636F6E7374616E7420746F2074686520636F6E7374616E74207461626C652E2052657475726E732074686520696E64657820696E20746865207461626C65206F6620746865206E65776C7920616464656420636F6E7374616E742E
		Function AddConstant(d As Double) As Integer
		  /// Adds a numeric constant to the constant table.
		  /// Returns the index in the table of the newly added constant.
		  ///
		  /// Note that indexes are reused if the passed-in constant already exists in the table.
		  
		  Return Constants.Add(d)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 41646473206120737472696E6720636F6E7374616E7420746F2074686520636F6E7374616E74207461626C652E2052657475726E732074686520696E64657820696E20746865207461626C65206F6620746865206E65776C7920616464656420636F6E7374616E742E
		Function AddConstant(s As String) As Integer
		  /// Adds a string constant to the constant table.
		  /// Returns the index in the table of the newly added constant.
		  ///
		  /// Note that indexes are reused if the passed-in constant already exists in the table.
		  
		  Return Constants.Add(s)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Constants = New ObjoScript.ValueSet
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5772697465732061206279746520746F2074686973206368756E6B2E
		Sub Write(byte As Integer, lineNumber As Integer)
		  /// Writes a byte to this chunk.
		  
		  Code.Add(byte)
		  Lines.Add(lineNumber)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726974657320616E206F70636F64652028617320616E20696E74656765722920746F2074686973206368756E6B2E
		Sub Write(opcode As ObjoScript.Opcodes, lineNumber As Integer)
		  /// Writes an opcode (as an integer) to this chunk.
		  
		  Code.Add(Integer(opcode))
		  Lines.Add(lineNumber)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686973206368756E6B2773207261772062797465636F64652E
		Code() As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206368756E6B277320737472696E6720616E64206E756D6572696320636F6E7374616E74732E
		Constants As ObjoScript.ValueSet
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206279746573206F6620636F646520696E20746865206368756E6B2E
		#tag Getter
			Get
			  Return Code.Count
			End Get
		#tag EndGetter
		Length As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 53746F72657320746865206C696E65206E756D62657220666F722074686520636F72726573706F6E64696E67206279746520696E2060436F64652829602E20
		Lines() As Integer
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
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
