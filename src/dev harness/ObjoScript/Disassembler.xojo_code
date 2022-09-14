#tag Class
Protected Class Disassembler
	#tag Method, Flags = &h0, Description = 5072696E74732074686520636F6E7374616E7420696E737472756374696F6E2773206E616D652C2074686520636F6E7374616E74277320696E64657820696E2074686520636F6E7374616E7420706F6F6C20616E64206120726570726573656E746174696F6E206F66207468652076616C7565206F66207468617420636F6E7374616E742E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Function ConstantInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer) As Integer
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
		  Case ObjoScript.VM.OP_CONSTANT
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "CONSTANT"
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG
		    // Two byte operand.
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "CONSTANT_LONG"
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "DEFINE GLOBAL"
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL_LONG
		    // Two byte operand.
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "DEFINE_GLOBAL_LONG"
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "GET GLOBAL"
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL_LONG
		    // Two byte operand.
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "GET_GLOBAL_LONG"
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "SET GLOBAL"
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL_LONG
		    // Two byte operand.
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "SET_GLOBAL_LONG"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown constant opcode.")
		  End Select
		  
		  // Print the instruction name.
		  Print(name.JustifyLeft(2 * COL_WIDTH))
		  
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  Print(indexCol.JustifyLeft(COL_WIDTH))
		  
		  // Print the constant's value.
		  Var constant As Variant = chunk.Constants(constantIndex)
		  PrintLine(ObjoScript.VM.ValueToString(constant))
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C65732074686520606368756E6B60206E616D656420606368756E6B4E616D656020696E746F20612068756D616E2D7265616461626C6520737472696E672E
		Sub Disassemble(chunk As ObjoScript.Chunk, chunkName As String, displayScriptID As Boolean = False)
		  /// Disassembles the `chunk` named `chunkName` into a human-readable string.
		  ///
		  /// If `displayScriptID` is True then the scriptID stored for each byte is also displayed.
		  
		  PrintLine("== " + chunkName + " ==")
		  
		  Var previousLine, previousScriptID As Integer = -1
		  Var previousOffset, offset As Integer = 0
		  While offset < chunk.Length
		    previousOffset = offset
		    offset = DisassembleInstruction(previousLine, previousScriptID, chunk, offset, displayScriptID)
		    previousLine = chunk.LineForOffset(previousOffset)
		    previousScriptID = chunk.ScriptIDForOffset(previousOffset)
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
		  Var line As Integer = chunk.LineForOffset(offset)
		  Var scriptID As Integer = chunk.ScriptIDForOffset(offset)
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
		  Var opcode As UInt8 = chunk.Code(offset)
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_CONSTANT_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_RETURN
		    Return SimpleInstruction("RETURN", offset)
		    
		  Case ObjoScript.VM.OP_NEGATE
		    Return SimpleInstruction("NEGATE", offset)
		    
		  Case ObjoScript.VM.OP_ADD
		    Return SimpleInstruction("ADD", offset)
		    
		  Case ObjoScript.VM.OP_SUBTRACT
		    Return SimpleInstruction("SUBTRACT", offset)
		    
		  Case ObjoScript.VM.OP_DIVIDE
		    Return SimpleInstruction("DIVIDE", offset)
		    
		  Case ObjoScript.VM.OP_MULTIPLY
		    Return SimpleInstruction("MULTIPLY", offset)
		    
		  Case ObjoScript.VM.OP_MODULO
		    Return SimpleInstruction("MODULO", offset)
		    
		  Case ObjoScript.VM.OP_NOT
		    Return SimpleInstruction("NOT", offset)
		    
		  Case ObjoScript.VM.OP_EQUAL
		    Return SimpleInstruction("EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_NOT_EQUAL
		    Return SimpleInstruction("NOT_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_LESS
		    Return SimpleInstruction("LESS", offset)
		    
		  Case ObjoScript.VM.OP_LESS_EQUAL
		    Return SimpleInstruction("LESS_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_GREATER
		    Return SimpleInstruction("GREATER", offset)
		    
		  Case ObjoScript.VM.OP_GREATER_EQUAL
		    Return SimpleInstruction("GREATER_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_FALSE
		    Return SimpleInstruction("FALSE", offset)
		    
		  Case ObjoScript.VM.OP_TRUE
		    Return SimpleInstruction("TRUE", offset)
		    
		  Case ObjoScript.VM.OP_NOTHING
		    Return SimpleInstruction("NOTHING", offset)
		    
		  Case ObjoScript.VM.OP_POP
		    Return SimpleInstruction("POP", offset)
		    
		  Case ObjoScript.VM.OP_SHIFT_LEFT
		    Return SimpleInstruction("SHIFT LEFT", offset)
		    
		  Case ObjoScript.VM.OP_SHIFT_RIGHT
		    Return SimpleInstruction("SHIFT RIGHT", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_AND
		    Return SimpleInstruction("BITWISE AND", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_OR
		    Return SimpleInstruction("BITWISE OR", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_XOR
		    Return SimpleInstruction("BITWISE XOR", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_0
		    Return SimpleInstruction("LOAD 0", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_1
		    Return SimpleInstruction("LOAD 1", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_MINUS1
		    Return SimpleInstruction("LOAD -1", offset)
		    
		  Case ObjoScript.VM.OP_PRINT
		    Return SimpleInstruction("PRINT", offset)
		    
		  Case ObjoScript.VM.OP_ASSERT
		    Return SimpleInstruction("ASSERT", offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_POP_N
		    Return TwoByteInstruction("POP_N", chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL
		    Return TwoByteInstruction("GET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_LOCAL
		    Return TwoByteInstruction("SET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP
		    Return JumpInstruction("OP_JUMP", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_FALSE
		    Return JumpInstruction("OP_JUMP_IF_FALSE", False, chunk, offset)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320746865206E616D65206F662061206A756D7020696E737472756374696F6E202855496E743136206F706572616E642920616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E20496620606E6567617469766560207468656E20746869732069732061206261636B7761726473206A756D702E
		Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the name of a jump instruction (UInt16 operand) and returns the offset for the next instruction.
		  /// If `negative` then this is a backwards jump.
		  ///
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  NAME  OFFSET -> DESTINATION
		  
		  // Print the instruction name.
		  Print(name.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the destination offset
		  Var jump As Integer = chunk.ReadUInt16(offset + 1)
		  Var destination As Integer = offset + 3 + If(negative, -1, 1) * jump
		  Var destCol As String = offset.ToString + " -> " + destination.ToString
		  PrintLine(destCol.JustifyLeft(COL_WIDTH * 2))
		  
		  Return offset + 3
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320746865206E616D65206F6620746869732073696D706C6520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Function SimpleInstruction(instructionName As String, offset As Integer) As Integer
		  /// Prints the name of a simple instruction (single byte, no operands) and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  NAME
		  
		  PrintLine(instructionName.JustifyLeft(COL_WIDTH))
		  
		  Return offset + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320746865206E616D65206F6620612074776F206279746520696E737472756374696F6E202873696E676C6520627974652C206F6E65206F706572616E642920616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Function TwoByteInstruction(name As String, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the name of a two byte instruction (single byte, one operand) and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  NAME  OPERAND_VALUE
		  
		  // Print the instruction name.
		  Print(name.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the operand's value.
		  Var operand As Integer = chunk.ReadByte(offset + 1)
		  PrintLine(operand.ToString.JustifyLeft(COL_WIDTH))
		  
		  Return offset + 2
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 526169736564207768656E657665722074686520646973617373656D626C65722077616E747320746F2061646473206120737472696E6720746F20697473206F75747075742E20417373756D657320746869732077696C6C20626520636F6E636174656E61746564207769746820616E792070726576696F75732063616C6C7320746F20605072696E742829602E
		Event Print(s As String)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 526169736564207768656E657665722074686520646973617373656D626C65722077616E747320746F2061646473206120737472696E6720746F20697473206F757470757420616E64207465726D696E61746520697420776974682061206E65776C696E652E
		Event PrintLine(s As String)
	#tag EndHook


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
	#tag EndConstant


End Class
#tag EndClass
