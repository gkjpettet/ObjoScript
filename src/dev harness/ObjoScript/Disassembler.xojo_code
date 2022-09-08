#tag Class
Protected Class Disassembler
	#tag Method, Flags = &h0, Description = 5072696E74732074686520636F6E7374616E7420696E737472756374696F6E2773206E616D652C2074686520636F6E7374616E74277320696E64657820696E2074686520636F6E7374616E7420706F6F6C20616E64206120726570726573656E746174696F6E206F66207468652076616C7565206F66207468617420636F6E7374616E742E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Function ConstantInstruction(opcode As ObjoScript.Opcodes, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the constant instruction's name, the constant's index in the constant pool and a representation of the value of that constant.
		  /// Returns the offset for the next instruction.
		  ///
		  /// The constant instruction takes a single byte operand (the index of the constant in the constant pool).
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  NAME  POOL_INDEX  CONSTANT_VALUE
		  
		  // Get and print the index in the constant pool.
		  Var constantIndex, newOffset As Integer
		  Var name As String
		  Select Case opcode
		  Case ObjoScript.Opcodes.Constant
		    constantIndex = chunk.ReadUInt8(offset + 1)
		    newOffset = offset + 2
		    name = "CONSTANT"
		  Case ObjoScript.Opcodes.ConstantLong
		    // Two byte operand.
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "CONSTANT_LONG"
		  Else
		    Raise New UnsupportedOperationException("Unknown constant opcode.")
		  End Select
		  
		  // Print the instruction name.
		  Print(name.JustifyLeft(2 * COL_WIDTH))
		  
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  Print(indexCol.JustifyLeft(COL_WIDTH))
		  
		  // Print the constant's value.
		  Print(chunk.Constants(constantIndex) + EndOfLine)
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C65732074686520606368756E6B60206E616D656420606368756E6B4E616D656020696E746F20612068756D616E2D7265616461626C6520737472696E672E
		Sub Disassemble(chunk As ObjoScript.Chunk, chunkName As String, displayScriptID As Boolean = False)
		  /// Disassembles the `chunk` named `chunkName` into a human-readable string.
		  ///
		  /// If `displayScriptID` is True then the scriptID stored for each byte is also displayed.
		  
		  Print("== " + chunkName + " ==" + EndOfLine)
		  
		  Var previousLine, previousScriptID As Integer = -1
		  Var previousOffset, offset As Integer = 0
		  While offset < chunk.Length
		    previousOffset = offset
		    offset = DisassembleInstruction(previousLine, previousScriptID, chunk, offset, displayScriptID)
		    previousLine = chunk.Lines(previousOffset)
		    previousScriptID = chunk.ScriptID(previousOffset)
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C657320612073696E676C6520696E737472756374696F6E2077697468696E20606368756E6B6020617420606F6666736574602E2052657475726E7320746865206F6666736574206F6620746865205F6E6578745F20696E737472756374696F6E2E
		Function DisassembleInstruction(previousLine As Integer, previousScriptID As Integer, chunk As ObjoScript.Chunk, offset As Integer, displayScriptID As Boolean = False) As Integer
		  /// Disassembles a single instruction within `chunk` at `offset`. Returns the offset of the _next_ instruction.
		  ///
		  /// If `displayScriptID` is True then we also display the script ID associated with each byte.
		  
		  // This instruction's offset in the chunk.
		  Var offsetCol As String = offset.ToString(Locale.Current, "00000")
		  Print(offsetCol.JustifyLeft(COL_WIDTH))
		  
		  // This instruction's line number. If it's the same as the previous instruction
		  // *and* from the script then we show a "|" instead.
		  Var line As Integer = chunk.Lines(offset)
		  Var scriptID As Integer = chunk.ScriptID(offset)
		  Var lineCol As String
		  If offset > 0 And line = previousLine And scriptID = previousScriptID Then
		    lineCol = "|"
		  Else
		    lineCol = line.ToString(Locale.Current, "#####")
		  End If
		  Print(lineCol.JustifyLeft(COL_WIDTH))
		  
		  // Optional script ID?
		  If displayScriptID Then
		    Var scriptIDCol As String = scriptID.ToString(Locale.Current, "#####")
		    Print(scriptIDCol.JustifyLeft(COL_WIDTH))
		  End If
		  
		  // Print the details about the instruction.
		  Var instruction As Integer = chunk.Code(offset)
		  Var opcode As ObjoScript.Opcodes = ObjoScript.Opcodes(instruction)
		  Select Case opcode
		  Case ObjoScript.Opcodes.Constant, ObjoScript.Opcodes.ConstantLong
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.Opcodes.Return_
		    Return SimpleInstruction("RETURN", offset)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + instruction.ToString + ").")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320746865206E616D65206F6620746869732073696D706C6520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Function SimpleInstruction(instructionName As String, offset As Integer) As Integer
		  /// Prints the name of a simple instruction (single byte, no operands) and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  NAME
		  
		  Print(instructionName.JustifyLeft(COL_WIDTH) + EndOfLine)
		  
		  Return offset + 1
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 526169736564207768656E657665722074686520646973617373656D626C65722077616E747320746F207072696E74206120737472696E67206F75747075742E20496D706C656D656E74696E672074686973206576656E7420776F756C6420616C6C6F7720796F7520746F2C20666F72206578616D706C652C2072656469726563742074686520646973617373656D626C65722773206F757470757420746F2074686520646562756720636F6E736F6C65206F7220612054657874417265612E
		Event Print(s As String)
	#tag EndHook


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"8", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
	#tag EndConstant


End Class
#tag EndClass
