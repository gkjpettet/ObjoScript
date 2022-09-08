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

	#tag Method, Flags = &h0, Description = 526561647320616E20756E7369676E65642031362D62697420696E746567657220626567696E6E696E6720617420606F6666736574602066726F6D2074686973206368756E6B27732062797465636F64652E
		Function ReadUInt16(offset As Integer) As UInt16
		  /// Reads an unsigned 16-bit integer beginning at `offset` from this chunk's bytecode.
		  ///
		  /// Data is stored in big endian format (most significant byte first).
		  /// uint16 = (msb * 256) + lsb
		  
		  Return (Code(offset) * 256) + Code(offset + 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526561647320616E20756E7369676E6564206279746520696E746567657220626567696E6E696E6720617420606F6666736574602066726F6D2074686973206368756E6B27732062797465636F64652E
		Function ReadUInt8(offset As Integer) As UInt8
		  /// Reads an unsigned byte integer beginning at `offset` from this chunk's bytecode.
		  
		  Return Code(offset)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726974657320616E206F70636F646520746F2074686973206368756E6B2E
		Sub WriteOpcode(opcode As ObjoScript.Opcodes, token As ObjoScript.Token)
		  /// Writes an opcode to this chunk.
		  ///
		  /// The opcode is cast to an Integer but is actually stored as a UInt8.
		  
		  Code.Add(Integer(opcode))
		  Lines.Add(token.LineNumber)
		  ScriptID.Add(token.ScriptID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 57726974657320616E20756E7369676E65642031362D62697420696E746567657220746F2074686973206368756E6B27732062797465636F646520617272617920617420606C696E654E756D626572602E
		Sub WriteUInt16(i16 As UInt16, token As ObjoScript.Token)
		  /// Writes an unsigned 16-bit integer to this chunk's bytecode array.
		  ///
		  /// The integer is written in big endian format (most significant byte first).
		  /// `token` is the parser token that generated this byte of data.
		  /// Write the high byte, then the low byte.
		  /// Taken from: https://ifnotnil.com/t/converting-a-uint16-to-two-uint8s/278/8?u=garry
		  
		  Var msb As UInt8 = i16 / 256
		  Var lsb As UInt8 = i16
		  Code.Add(msb)
		  Code.Add(lsb)
		  
		  // Write twice as we're writing two bytes.
		  Lines.Add(token.LineNumber)
		  Lines.Add(token.LineNumber)
		  ScriptID.Add(token.ScriptID)
		  ScriptID.Add(token.ScriptID)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5772697465732061206279746520746F2074686973206368756E6B2E
		Sub WriteUInt8(i8 As UInt8, token As ObjoScript.Token)
		  /// Writes a byte to this chunk.
		  ///
		  /// `token` is the parser token that generated this byte of data.
		  
		  Code.Add(i8)
		  Lines.Add(token.LineNumber)
		  ScriptID.Add(token.ScriptID)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686973206368756E6B2773207261772062797465636F64652E
		Code() As UInt8
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
		Lines() As UInt32
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53746F726573207468652073637269707420494420666F722074686520636F72726573706F6E64696E67206279746520696E2060436F64652829602E2044656661756C747320746F206030602E
		ScriptID() As UInt16
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
