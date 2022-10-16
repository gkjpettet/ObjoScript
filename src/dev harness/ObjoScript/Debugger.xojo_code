#tag Class
Protected Class Debugger
	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E6473206120636F6E7374616E74206C6F6164696E6720696E737472756374696F6E20746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E20416464732074686520696E737472756374696F6E2773206E616D652C2074686520636F6E7374616E74277320696E64657820696E2074686520636F6E7374616E7420706F6F6C20616E64206120726570726573656E746174696F6E206F66207468652076616C7565206F66207468617420636F6E7374616E742E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function ConstantInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends a constant loading instruction to it. It then appends that line to `s`.
		  /// Adds the instruction's name, the constant's index in the constant pool and a representation of the value of that constant.
		  /// Returns the offset for the next instruction.
		  ///
		  /// Some instructions use a single byte operand, others use a two byte operand. The operand is the index of the constant in the constant pool.
		  /// Format:
		  /// OFFSET  LINE  SCRIPT_ID?  INSTRUCTION_NAME  POOL_INDEX  CONSTANT_VALUE
		  
		  // Get and print the index in the constant pool.
		  Var constantIndex, newOffset As Integer
		  Var name As String
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT
		    constantIndex = chunk.ReadByte(offset + 1)
		    newOffset = offset + 2
		    name = "CONSTANT"
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG
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
		  
		  // Append the instruction name.
		  line = line + name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the index in the pool.
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  line = line + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // Append the constant's value as a (short) string.
		  Var constant As Variant = chunk.Constants(constantIndex)
		  line = line + ObjoScript.VM.ValueToString(constant)
		  
		  // Append the line to `s`.
		  s.Add(line)
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C6573207468652062797465636F64652077697468696E20606368756E6B602C20617070656E64696E672074686520726573756C7420746F207468652070617373656420737472696E67206172726179206073602E
		Sub DisassembleBytecode(chunk As ObjoScript.Chunk, s() As String, displayScriptID As Boolean = False)
		  /// Disassembles the bytecode within `chunk`, appending the result to the passed string array `s`. 
		  ///
		  /// If `displayScriptID` is True then the scriptID stored for each byte is also displayed.
		  
		  Var previousLine, previousScriptID As Integer = -1
		  Var previousOffset, offset As Integer = 0
		  While offset < chunk.Length
		    previousOffset = offset
		    offset = DisassembleInstruction(s, previousLine, previousScriptID, chunk, offset, displayScriptID)
		    previousLine = chunk.LineForOffset(previousOffset)
		    previousScriptID = chunk.ScriptIDForOffset(previousOffset)
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686520636F6E74656E7473206F6620612066756E6374696F6E20696E636C7564696E6720697427732065786563757461626C6520636F646520616E6420636F6E7374616E74732E
		Function DisassembleFunction(f As ObjoScript.Func, displayScriptID As Boolean = False) As String
		  /// Returns a string representation of the contents of a function including it's executable code and constants.
		  ///
		  /// If `displayScriptID` is True then the scriptID stored for each byte is also displayed.
		  
		  If f = Nil Then Return ""
		  If f.Chunk = Nil Then Return ""
		  
		  Var s() As String
		  
		  // Function header.
		  s.Add("==============================")
		  If f.Name = "" Then
		    s.Add("Main Function" + f.Signature)
		  Else
		    s.Add("Function " + If(f.IsSetter, "(setter)", "") + ": " + f.Signature)
		  End If
		  s.Add("==============================")
		  // Parameters.
		  If f.Parameters.Count = 0 Then
		    s.Add("Params: None")
		  Else
		    Var tmp As String = "Params: "
		    For i As Integer = 0 To f.Parameters.LastIndex
		      tmp = tmp + f.Parameters(i) + If(i < f.Parameters.LastIndex, ", ", "")
		    Next i
		    s.Add(tmp)
		  End If
		  
		  // Constant count.
		  s.Add("Constants: " + If(f.Chunk.Constants.Count = 0, "None", f.Chunk.Constants.Count.ToString))
		  s.Add("==============================")
		  
		  // Bytecode.
		  DisassembleBytecode(f.Chunk, s, displayScriptID)
		  s.Add("==============================")
		  
		  // Display the function's constants pool.
		  If f.Chunk.Constants.Count = 0 Then
		    s.Add("Constants Pool: Empty")
		  Else
		    s.Add("Constants Pool")
		    Var constantLimit As Integer = f.Chunk.Constants.Count - 1
		    For i As Integer = 0 To constantLimit
		      Var constantRepresentation As String
		      Var indexCol As String = i.ToString(Locale.Current, "00000").JustifyLeft(COL_WIDTH)
		      constantRepresentation = constantRepresentation + indexCol
		      Var constant As Variant = f.Chunk.Constants.ItemAt(i)
		      If constant IsA ObjoScript.Func Then
		        // Dump this function.
		        constantRepresentation = constantRepresentation + EndOfLine + DisassembleFunction(ObjoScript.Func(constant), displayScriptID)
		      Else
		        constantRepresentation = constantRepresentation + ObjoScript.VM.ValueToString(constant)
		      End If
		      s.Add(constantRepresentation)
		    Next i
		  End If
		  
		  s.Add("==============================")
		  If f.Name = "" Then
		    s.Add("End Main Function" + f.Signature)
		  Else
		    s.Add("End Function: " + f.Signature)
		  End If
		  s.Add("==============================")
		  
		  Return String.FromArray(s, EndOfLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C657320612073696E676C6520696E737472756374696F6E2077697468696E20606368756E6B6020617420606F6666736574602E2052657475726E732074686520646973617373656D626C79206173206120737472696E672E
		Function DisassembleInstruction(previousLine As Integer, previousScriptID As Integer, chunk As ObjoScript.Chunk, offset As Integer, displayScriptID As Boolean = False) As String
		  /// Disassembles a single instruction within `chunk` at `offset`. Returns the disassembly as a string.
		  ///
		  /// If `displayScriptID` is True then we also display the script ID associated with each byte.
		  
		  Var s() As String
		  
		  Call DisassembleInstruction(s, previousLine, previousScriptID, chunk, offset, displayScriptID)
		  
		  Return String.FromArray(s, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446973617373656D626C657320612073696E676C6520696E737472756374696F6E2077697468696E20606368756E6B6020617420606F6666736574602E20417070656E64732074686520646973617373656D626C7920746F2074686520737472696E67206172726179206073602E2052657475726E7320746865206F6666736574206F6620746865205F6E6578745F20696E737472756374696F6E2E
		Private Function DisassembleInstruction(s() As String, previousLine As Integer, previousScriptID As Integer, chunk As ObjoScript.Chunk, offset As Integer, displayScriptID As Boolean = False) As Integer
		  /// Disassembles a single instruction within `chunk` at `offset`. Appends the disassembly to the string array `s`.
		  /// Returns the offset of the _next_ instruction.
		  ///
		  /// If `displayScriptID` is True then we also display the script ID associated with each byte.
		  
		  // We need a string that represents this disassembled instruction line.
		  Var line As String = ""
		  
		  // This instruction's offset in the chunk.
		  Var offsetCol As String = offset.ToString(Locale.Current, "00000")
		  line = line + offsetCol.JustifyLeft(COL_WIDTH)
		  
		  // This instruction's line number. If it's the same as the previous instruction
		  // *and* from the script then we show a "|" instead.
		  Var lineNum As Integer = chunk.LineForOffset(offset)
		  Var scriptID As Integer = chunk.ScriptIDForOffset(offset)
		  Var lineCol As String
		  If offset > 0 And lineNum = previousLine And scriptID = previousScriptID Then
		    lineCol = "|"
		  Else
		    lineCol = lineNum.ToString(Locale.Current, "#####")
		  End If
		  line = line + lineCol.JustifyLeft(COL_WIDTH)
		  
		  // Optional script ID?
		  If displayScriptID Then
		    Var scriptIDCol As String = scriptID.ToString(Locale.Current, "#####")
		    line = line + scriptIDCol.JustifyLeft(COL_WIDTH)
		  End If
		  
		  // Print the details about the instruction.
		  Var opcode As UInt8 = chunk.Code(offset)
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_CONSTANT_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_RETURN
		    Return SimpleInstruction("RETURN", offset, line, s)
		    
		  Case ObjoScript.VM.OP_NEGATE
		    Return SimpleInstruction("NEGATE", offset, line, s)
		    
		  Case ObjoScript.VM.OP_ADD
		    Return SimpleInstruction("ADD", offset, line, s)
		    
		  Case ObjoScript.VM.OP_SUBTRACT
		    Return SimpleInstruction("SUBTRACT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_DIVIDE
		    Return SimpleInstruction("DIVIDE", offset, line, s)
		    
		  Case ObjoScript.VM.OP_MULTIPLY
		    Return SimpleInstruction("MULTIPLY", offset, line, s)
		    
		  Case ObjoScript.VM.OP_MODULO
		    Return SimpleInstruction("MODULO", offset, line, s)
		    
		  Case ObjoScript.VM.OP_NOT
		    Return SimpleInstruction("NOT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_EQUAL
		    Return SimpleInstruction("EQUAL", offset, line, s)
		    
		  Case ObjoScript.VM.OP_NOT_EQUAL
		    Return SimpleInstruction("NOT_EQUAL", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LESS
		    Return SimpleInstruction("LESS", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LESS_EQUAL
		    Return SimpleInstruction("LESS_EQUAL", offset, line, s)
		    
		  Case ObjoScript.VM.OP_GREATER
		    Return SimpleInstruction("GREATER", offset, line, s)
		    
		  Case ObjoScript.VM.OP_GREATER_EQUAL
		    Return SimpleInstruction("GREATER_EQUAL", offset, line, s)
		    
		  Case ObjoScript.VM.OP_FALSE
		    Return SimpleInstruction("FALSE", offset, line, s)
		    
		  Case ObjoScript.VM.OP_TRUE
		    Return SimpleInstruction("TRUE", offset, line, s)
		    
		  Case ObjoScript.VM.OP_NOTHING
		    Return SimpleInstruction("NOTHING", offset, line, s)
		    
		  Case ObjoScript.VM.OP_POP
		    Return SimpleInstruction("POP", offset, line, s)
		    
		  Case ObjoScript.VM.OP_SHIFT_LEFT
		    Return SimpleInstruction("SHIFT LEFT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_SHIFT_RIGHT
		    Return SimpleInstruction("SHIFT RIGHT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_BITWISE_AND
		    Return SimpleInstruction("BITWISE AND", offset, line, s)
		    
		  Case ObjoScript.VM.OP_BITWISE_OR
		    Return SimpleInstruction("BITWISE OR", offset, line, s)
		    
		  Case ObjoScript.VM.OP_BITWISE_XOR
		    Return SimpleInstruction("BITWISE XOR", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOGICAL_XOR
		    Return SimpleInstruction("LOGICAL XOR", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOAD_0
		    Return SimpleInstruction("LOAD 0", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOAD_1
		    Return SimpleInstruction("LOAD 1", offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOAD_MINUS1
		    Return SimpleInstruction("LOAD -1", offset, line, s)
		    
		  Case ObjoScript.VM.OP_ASSERT
		    Return SimpleInstruction("ASSERT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_POP_N
		    Return Instruction8BitOperand("POP_N", chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL
		    Return Instruction8BitOperand("GET LOCAL", chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SET_LOCAL
		    Return Instruction8BitOperand("SET LOCAL", chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_JUMP
		    Return JumpInstruction("OP_JUMP", False, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_FALSE
		    Return JumpInstruction("OP_JUMP_IF_FALSE", False, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_TRUE
		    Return JumpInstruction("OP_JUMP_IF_TRUE", False, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOOP
		    Return JumpInstruction("OP_LOOP", True, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_RANGE
		    Return SimpleInstruction("OP_RANGE", offset, line, s)
		    
		  Case ObjoScript.VM.OP_EXIT
		    Return SimpleInstruction("OP_EXIT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_CALL
		    Return Instruction8BitOperand("OP_CALL", chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_CLASS
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_METHOD
		    Return MethodInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SETTER
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GETTER
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_FIELD
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SET_FIELD
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SET_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_CONSTRUCTOR
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_INVOKE
		    Return InvokeInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
		    Return InvokeInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_INHERIT
		    Return SimpleInstruction("OP_INHERIT", offset, line, s)
		    
		  Case ObjoScript.VM.OP_SUPER_GETTER
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE
		    Return InvokeInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE_LONG
		    Return InvokeInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD, ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    Return MethodInstruction(opcode, chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_IS
		    Return SimpleInstruction("OP_IS", offset, line, s)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL_CLASS
		    Return Instruction8BitOperand("GET LOCAL CLASS", chunk, offset, line, s)
		    
		  Case ObjoScript.VM.OP_LOCAL_VAR_DEC
		    Return LocalVarDec(chunk, offset, line, s)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E647320616E20696E737472756374696F6E20746861742074616B657320612073696E676C6520382D626974206F706572616E6420746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function Instruction8BitOperand(name As String, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends an instruction that takes a single 8-bit operand to it. It then appends that line to `s`.
		  /// Returns the offset for the next instruction.
		  ///
		  /// Format:
		  /// OFFSET  LINE_NUMBER  SCRIPT_ID?  INSTRUCTION_NAME  OPERAND_VALUE
		  
		  // Add the instruction name.
		  line = line + name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Add the operand's value.
		  Var operand As Integer = chunk.ReadByte(offset + 1)
		  line = line + operand.ToString.JustifyLeft(COL_WIDTH)
		  
		  // Append the line to `s`.
		  s.Add(line)
		  
		  Return offset + 2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E647320616E20696E766F6B652F73757065725F696E766F6B6520696E737472756374696F6E20746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function InvokeInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends an invoke/super_invoke instruction to it. It then appends that line to `s`.
		  /// Returns the offset for the next instruction.
		  ///
		  /// Prints the instruction's name, the constant's index in the pool, the method's name and the argument count.
		  ///
		  /// Format:
		  /// OFFSET  LINE  SCRIPT_ID?  INSTRUCTION  METHOD_NAME_INDEX  METHOD_NAME  ARGCOUNT
		  
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
		  
		  // Append the instruction's name.
		  line = line + instructionName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the index in the pool.
		  Var indexCol As String = index.ToString(Locale.Current, "#####")
		  line = line + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // Append the method's name.
		  Var methodNameValue As Variant = chunk.Constants(index)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  line = line + methodName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  line = line + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the line to `s`.
		  s.Add(line)
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E64732061206A756D7020696E737472756374696F6E20696E737472756374696F6E20746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends a jump instruction instruction to it. It then appends that line to `s`.
		  /// Returns the offset for the next instruction.
		  //
		  /// Jump instructions take a two byte operand (the jump offset) 
		  /// If `negative` then this is a backwards jump.
		  ///
		  /// Format:
		  /// OFFSET  LINE  SCRIPT_ID?  INSTRUCTION_NAME  OFFSET -> DESTINATION
		  
		  // Append the instruction's name to the line.
		  line = line + name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the destination offset to the line.
		  Var jump As Integer = chunk.ReadUInt16(offset + 1)
		  Var destination As Integer = offset + 3 + If(negative, -1, 1) * jump
		  Var destCol As String = offset.ToString + " -> " + destination.ToString
		  line = line + destCol.JustifyLeft(COL_WIDTH * 2)
		  
		  // Append the instruction line to `s`.
		  s.Add(line)
		  
		  Return offset + 3
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function LocalVarDec(chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends details about the OP_LOCAL_VAR_DEC instruction to it. 
		  /// It then appends that line to `s`.
		  /// Returns the offset for the next instruction.
		  /// 
		  /// This instruction takes a 2 bytes (name index) and a one byte (slot index) operand.
		  ///
		  /// Format:
		  /// OFFSET  LINE  SCRIPT_ID?  VAR_NAME  SLOT
		  
		  Var instruction As String = "OP_LOCAL_VAR_DEC"
		  
		  // Append the instruction name.
		  line = line + instruction.JustifyLeft(2 * COL_WIDTH)
		  
		  // Get the index of the name of the variable in the chunk's constant pool.
		  Var index As Integer = chunk.ReadUInt16(offset + 1)
		  
		  // Get the local slot.
		  Var slot As Integer = chunk.ReadByte(offset + 3)
		  
		  // Append the name of the variable.
		  Var varName As String = chunk.Constants(index)
		  varName = varName.JustifyLeft(2 * COL_WIDTH)
		  line = line + varName
		  
		  // Append the slot.
		  line = line + slot.ToString
		  
		  // Append the line to `s`
		  s.Add(line)
		  
		  Return offset + 4
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E64732061206D6574686F6420696E737472756374696F6E20696E737472756374696F6E20746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function MethodInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends a method instruction instruction to it. It then appends that line to `s`.
		  /// Returns the offset for the next instruction.
		  ///
		  /// We display the instruction's name, the index of the method's name in the constant pool, the method name and if it's a static or instance method.
		  ///
		  /// The METHOD instruction takes a two byte operand (for the index of the method's signature in the constant pool) and a single byte
		  /// operand specifying if the method is static (1) or instance (0).
		  /// The FOREIGN_METHOD instruction first takes a two byte operand for the index of the signature in the constant pool. It then
		  /// takes a single byte operand specifying the arity (we don't print this) and finally a single byte operand
		  /// specifying if the method is static (1) or instance (0).
		  /// Format:
		  /// OFFSET  LINE  SCRIPT_ID?  INSTRUCTION_NAME  POOL_INDEX  METHOD_NAME  STATIC/INSTANCE?
		  
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
		  
		  // Append the instructions name.
		  line = line + name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the constant pool index.
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  line = line + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // Append the method's name.
		  Var methodNameValue As Variant = chunk.Constants(constantIndex)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  line = line + methodName.JustifyLeft(COL_WIDTH * 2)
		  
		  // Append if this a static or instance method.
		  line = line + If(isStatic, "Static", "Instance")
		  
		  // Append the line to `s`.
		  s.Add(line)
		  
		  Return newOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5072696E747320746865206E616D65206F6620746869732073696D706C6520696E737472756374696F6E20616E642072657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function SimpleInstruction(instructionName As String, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends a simple instruction to it. It then appends that line to `s`.
		  /// Finally returns the offset for the next instruction.
		  ///
		  /// Simple instructions are a single byte and take no operands.
		  /// Format:
		  /// OFFSET  LINE_NUMBER  SCRIPT_ID?  INSTRUCTION_NAME
		  
		  line = line + instructionName.JustifyLeft(COL_WIDTH)
		  
		  s.Add(line)
		  
		  Return offset + 1
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
	#tag EndConstant


End Class
#tag EndClass
