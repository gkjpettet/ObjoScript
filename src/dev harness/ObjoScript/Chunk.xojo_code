#tag Class
Protected Class Chunk
	#tag Method, Flags = &h0, Description = 416464732061206E756D6572696320636F6E7374616E7420746F2074686520636F6E7374616E74207461626C652E2052657475726E732074686520696E64657820696E20746865207461626C65206F6620746865206E65776C7920616464656420636F6E7374616E742E
		Function AddConstant(v As Variant) As Integer
		  /// Adds a constant to the constant table.
		  /// Returns the index in the table of the newly added constant.
		  ///
		  /// Note that indexes are reused if the passed-in constant already exists in the table.
		  
		  Return Constants.Add(v)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Constants = New ObjoScript.ValueSet
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206C696E65206E756D62657220666F7220746865206279746520636F646520617420606F6666736574602E
		Function LineForOffset(offset As Integer) As UInt32
		  /// Returns the line number for the byte code at `offset`.
		  ///
		  /// This is abstracted out to its own method in case I ever implement any 
		  /// compression for how the line numbers are stored.
		  
		  Return Lines(offset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526561647320616E20756E7369676E6564206279746520696E746567657220626567696E6E696E6720617420606F6666736574602066726F6D2074686973206368756E6B27732062797465636F64652E
		Function ReadByte(offset As Integer) As UInt8
		  /// Reads an unsigned byte integer beginning at `offset` from this chunk's bytecode.
		  
		  Return Code(offset)
		  
		End Function
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

	#tag Method, Flags = &h0, Description = 52657475726E73207468652073637269707420494420666F7220746865206279746520636F646520617420606F6666736574602E
		Function ScriptIDForOffset(offset As Integer) As UInt16
		  /// Returns the script ID for the byte code at `offset`.
		  ///
		  /// This is abstracted out to its own method in case I ever implement any 
		  /// compression for how the script IDs are stored.
		  
		  Return ScriptID(offset)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5772697465732061206279746520746F2074686973206368756E6B2E
		Sub WriteByte(b As UInt8, token As ObjoScript.Token)
		  /// Writes a byte to this chunk.
		  ///
		  /// `token` is the parser token that generated this byte of data.
		  
		  Code.Add(b)
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


	#tag Property, Flags = &h0, Description = 54686973206368756E6B2773207261772062797465636F64652E
		Code() As UInt8
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206368756E6B277320636F6E7374616E74732E
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

	#tag Property, Flags = &h21, Description = 53746F72657320746865206C696E65206E756D62657220666F722074686520636F72726573706F6E64696E67206279746520696E2060436F64652829602E20
		Private Lines() As UInt32
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F726573207468652073637269707420494420666F722074686520636F72726573706F6E64696E67206279746520696E2060436F64652829602E2044656661756C747320746F206030602E
		Private ScriptID() As UInt16
	#tag EndProperty


	#tag Constant, Name = MAX_CONSTANTS, Type = Double, Dynamic = False, Default = \"65534", Scope = Public, Description = 546865206D6178696D756D207065726D69737369626C6520696E646578206F66206120636F6E7374616E7420696E2061206368756E6B277320636F6E7374616E7420706F6F6C2E
	#tag EndConstant


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
