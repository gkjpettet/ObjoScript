#tag Class
Protected Class Disassembler
	#tag Method, Flags = &h21, Description = 5072696E74732074686520636F6E7374616E7420696E737472756374696F6E2773206E616D652C2074686520636F6E7374616E74277320696E64657820696E2074686520636F6E7374616E7420706F6F6C20616E64206120726570726573656E746174696F6E206F66207468652076616C7565206F66207468617420636F6E7374616E742E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function ConstantInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the constant instruction's name, the constant's index in the constant pool and 
		  /// a representation of the value of that constant.
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
		    
		  Case ObjoScript.VM.OP_CLASS
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    Var isForeign As Boolean = If(chunk.ReadByte(offset + 3) = 1, True, False)
		    newOffset = offset + 4
		    name = "CLASS" + If(isForeign, " (foreign)", "")
		    
		  Case ObjoScript.VM.OP_CONSTRUCTOR
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "CONSTRUCTOR"
		    
		  Case ObjoScript.VM.OP_GETTER
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "GETTER"
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "GETTER_LONG"
		    
		  Case ObjoScript.VM.OP_SETTER
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "SETTER"
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "SETTER_LONG"
		    
		  Case ObjoScript.VM.OP_SET_FIELD
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "SET_FIELD"
		    
		  Case ObjoScript.VM.OP_SET_FIELD_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "SET_FIELD_LONG"
		    
		  Case ObjoScript.VM.OP_GET_FIELD
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "GET_FIELD"
		    
		  Case ObjoScript.VM.OP_GET_FIELD_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "GET_FIELD_LONG"
		    
		  Case ObjoScript.VM.OP_SUPER_GETTER
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "SUPER_GETTER"
		    
		  Case ObjoScript.VM.OP_SUPER_GETTER_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "SUPER_GETTER_LONG"
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "SUPER_SETTER"
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "SUPER_SETTER_LONG"
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "GET_STATIC_FIELD"
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    newOffset = offset + 3
		    name = "GET_STATIC_FIELD_LONG"
		    
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
		Function Disassemble(chunk As ObjoScript.Chunk, chunkName As String, displayScriptID As Boolean = False) As String
		  /// Disassembles the `chunk` named `chunkName` into a human-readable string.
		  ///
		  /// If `displayScriptID` is True then the scriptID stored for each byte is also displayed.
		  
		  mBuffer = ""
		  
		  PrintLine("== " + chunkName + " ==")
		  
		  Var previousLine, previousScriptID As Integer = -1
		  Var previousOffset, offset As Integer = 0
		  While offset < chunk.Length
		    previousOffset = offset
		    offset = DisassembleInstruction(previousLine, previousScriptID, chunk, offset, displayScriptID)
		    previousLine = chunk.LineForOffset(previousOffset)
		    previousScriptID = chunk.ScriptIDForOffset(previousOffset)
		  Wend
		  
		  Return mBuffer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446973617373656D626C657320612073696E676C6520696E737472756374696F6E2077697468696E20606368756E6B6020617420606F6666736574602E2052657475726E7320746865206F6666736574206F6620746865205F6E6578745F20696E737472756374696F6E2E
		Private Function DisassembleInstruction(previousLine As Integer, previousScriptID As Integer, chunk As ObjoScript.Chunk, offset As Integer, displayScriptID As Boolean = False) As Integer
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
		    
		  Case ObjoScript.VM.OP_LOGICAL_XOR
		    Return SimpleInstruction("LOGICAL XOR", offset)
		    
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
		    
		  Case ObjoScript.VM.OP_JUMP_IF_TRUE
		    Return JumpInstruction("OP_JUMP_IF_TRUE", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_LOOP
		    Return JumpInstruction("OP_LOOP", True, chunk, offset)
		    
		  Case ObjoScript.VM.OP_RANGE
		    Return SimpleInstruction("OP_RANGE", offset)
		    
		  Case ObjoScript.VM.OP_EXIT
		    Return SimpleInstruction("OP_EXIT", offset)
		    
		  Case ObjoScript.VM.OP_CALL
		    Return TwoByteInstruction("OP_CALL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_CLASS
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_METHOD
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SETTER
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GETTER
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_FIELD
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_FIELD
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_CONSTRUCTOR
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_INVOKE
		    Return InvokeInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
		    Return InvokeInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_INHERIT
		    Return SimpleInstruction("OP_INHERIT", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_GETTER
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE
		    Return InvokeInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE_LONG
		    Return InvokeInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD, ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_IS
		    Return SimpleInstruction("OP_IS", offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL_NAME
		    Return GetLocalNameInstruction(chunk, offset)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E747320746865204F505F4745545F4C4F43414C5F4E414D4520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function GetLocalNameInstruction(chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the OP_GET_LOCAL_NAME instruction and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  OPCODE  VARIABLE_NAME  SLOT
		  
		  Var instructionName As String = "GET_LOCAL_NAME"
		  Var slot, newOffset, index As Integer
		  
		  slot = chunk.ReadByte(offset + 1)
		  index = chunk.ReadUInt16(offset + 2)
		  newOffset = offset + 4
		  
		  // Print the instruction name.
		  Print(instructionName.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the local variable's name.
		  Var variableNameValue As Variant = chunk.Constants(index)
		  Var variableName As String = ObjoScript.VM.ValueToString(variableNameValue)
		  Print(variableName.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the slot.
		  Print(slot.ToString.JustifyLeft(2 * COL_WIDTH))
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E74732074686520696E766F6B652F73757065725F696E766F6B6520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function InvokeInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the invoke/super_invoke instruction and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  OPCODE  METHOD_NAME_INDEX  METHOD_NAME  ARGCOUNT
		  
		  Var instructionName As String
		  Var index, newOffset, argCount As Integer
		  Select Case opcode
		  Case ObjoScript.VM.OP_INVOKE
		    instructionName = "OP_INVOKE"
		    index = chunk.ReadByte(offset + 1)
		    argCount = chunk.ReadByte(offset + 2)
		    newOffset = offset + 3
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
		    instructionName = "OP_INVOKE_LONG"
		    index = chunk.ReadUInt16(offset + 1)
		    argCount = chunk.ReadByte(offset + 3)
		    newOffset = offset + 4
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE
		    instructionName = "OP_SUPER_INVOKE"
		    index = chunk.ReadByte(offset + 1)
		    argCount = chunk.ReadByte(offset + 2)
		    newOffset = offset + 3
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE_LONG
		    instructionName = "OP_SUPER_INVOKE_LONG"
		    index = chunk.ReadUInt16(offset + 1)
		    argCount = chunk.ReadByte(offset + 3)
		    newOffset = offset + 4
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown invoke opcode.")
		  End Select
		  
		  // Print the instruction name.
		  Print(instructionName.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the index.
		  Var indexCol As String = index.ToString(Locale.Current, "#####")
		  Print(indexCol.JustifyLeft(COL_WIDTH))
		  
		  // Print the method's name.
		  Var methodNameValue As Variant = chunk.Constants(index)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  Print(methodName.JustifyLeft(2 * COL_WIDTH))
		  
		  // Print the argument count.
		  Print(argCount.ToString.JustifyLeft(2 * COL_WIDTH))
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E747320746865206E616D65206F662061206A756D7020696E737472756374696F6E202855496E743136206F706572616E642920616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E20496620606E6567617469766560207468656E20746869732069732061206261636B7761726473206A756D702E
		Private Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, offset As Integer) As Integer
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

	#tag Method, Flags = &h21, Description = 5072696E74732074686520696E737472756374696F6E2773206E616D652C2074686520696E646578206F6620746865206D6574686F642773206E616D6520696E2074686520636F6E7374616E7420706F6F6C2C20746865206D6574686F64206E616D6520616E642069662069742773206120736574746572206F72206E6F742E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function MethodInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer) As Integer
		  /// Prints the instruction's name, the index of the method's name in the constant pool, the method name and if it's a setter or not.
		  /// Returns the offset for the next instruction.
		  ///
		  /// The METHOD instruction takes a two byte operand (for the index of the method's signature in the constant pool).
		  /// The FOREIGN_METHOD instruction takes three bytes of operands (2 for the index of the signature in the constant pool 
		  /// and one specifying if the method is static (1) or instance (0)).
		  /// Format:
		  /// OFFSET  LINE  (OPTIONAL SCRIPT ID)  OPCODE  POOL_INDEX  METHOD_NAME   STATIC/INSTANCE?
		  
		  // Get and print the index in the constant pool.
		  Var constantIndex, newOffset As Integer
		  Var isStatic As Boolean
		  Var name As String
		  Select Case opcode
		  Case ObjoScript.VM.OP_METHOD
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    isStatic = If(chunk.ReadByte(offset + 3) = 1, True, False)
		    newOffset = offset + 4
		    name = "METHOD"
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    Call chunk.ReadByte(offset + 3) // The method's arity. We won't print this.
		    isStatic = If(chunk.ReadByte(offset + 4) = 1, True, False)
		    newOffset = offset + 5
		    name = "FOREIGN_METHOD"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown constant opcode.")
		  End Select
		  
		  // Print the instruction name.
		  Print(name.JustifyLeft(2 * COL_WIDTH))
		  
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  Print(indexCol.JustifyLeft(COL_WIDTH))
		  
		  // Print the method's name.
		  Var methodNameValue As Variant = chunk.Constants(constantIndex)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  Print(methodName.JustifyLeft(COL_WIDTH))
		  
		  // Static or instance?
		  Var type As String = If(isStatic, "Static", "Instance")
		  PrintLine(type.JustifyLeft(COL_WIDTH))
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Print(s As String)
		  mBuffer = mBuffer + s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PrintLine(s As String)
		  mBuffer = mBuffer + s + EndOfLine
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E747320746865206E616D65206F6620746869732073696D706C6520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function SimpleInstruction(instructionName As String, offset As Integer) As Integer
		  /// Prints the name of a simple instruction (single byte, no operands) and returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE  NAME
		  
		  PrintLine(instructionName.JustifyLeft(COL_WIDTH))
		  
		  Return offset + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E747320746865206E616D65206F6620612074776F206279746520696E737472756374696F6E202873696E676C6520627974652C206F6E65206F706572616E642920616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function TwoByteInstruction(name As String, chunk As ObjoScript.Chunk, offset As Integer) As Integer
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


	#tag Property, Flags = &h21
		Private mBuffer As String
	#tag EndProperty


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
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
	#tag EndViewBehavior
End Class
#tag EndClass
