#tag Class
Protected Class Debugger
	#tag Method, Flags = &h21, Description = 446973617373656D626C6573207468652062797465636F64652077697468696E20606368756E6B602C2072657475726E696E672069742061732061206054726565566965774E6F6465602E
		Private Function BytecodeToNode(chunk As ObjoScript.Chunk) As TreeViewNode
		  /// Disassembles the bytecode within `chunk`, returning it as a `TreeViewNode`.
		  
		  Var chunkNode As New TreeViewNode("Bytecode")
		  
		  Var offset As Integer = 0
		  While offset < chunk.Length
		    chunkNode.AppendNode(InstructionToNode(chunk, offset))
		  Wend
		  
		  Return chunkNode
		  
		End Function
	#tag EndMethod

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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F66206120636F6E7374616E74206C6F6164696E6720696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function ConstantInstructionDetails(opcode As UInt8, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of a constant loading instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Some instructions use a single byte operand, others use a two byte operand. The operand is the index of the constant in the constant pool.
		  /// Format:
		  /// INSTRUCTION_NAME  POOL_INDEX  CONSTANT_VALUE
		  
		  // Get index of the constant.
		  Var constantIndex As Integer
		  
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_DEFINE_GLOBAL, ObjoScript.VM.OP_GET_GLOBAL, _
		    ObjoScript.VM.OP_SET_GLOBAL, ObjoScript.VM.OP_GETTER, ObjoScript.VM.OP_SETTER, _
		    ObjoScript.VM.OP_SET_FIELD, ObjoScript.VM.OP_GET_FIELD, ObjoScript.VM.OP_SUPER_GETTER, _
		    ObjoScript.VM.OP_SUPER_SETTER, ObjoScript.VM.OP_GET_STATIC_FIELD
		    constantIndex = chunk.ReadByte(offset + 1)
		    offset = offset + 2
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG, ObjoScript.VM.OP_DEFINE_GLOBAL_LONG, _
		    ObjoScript.VM.OP_GET_GLOBAL_LONG, ObjoScript.VM.OP_SET_GLOBAL_LONG, ObjoScript.VM.OP_CONSTRUCTOR, _
		    ObjoScript.VM.OP_GETTER_LONG, ObjoScript.VM.OP_SETTER_LONG, ObjoScript.VM.OP_SET_FIELD_LONG, _
		    ObjoScript.VM.OP_GET_FIELD_LONG, ObjoScript.VM.OP_SUPER_GETTER_LONG, ObjoScript.VM.OP_SUPER_SETTER_LONG, _
		    ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    offset = offset + 3
		    
		  Case ObjoScript.VM.OP_CLASS
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    Var isForeign As Boolean = If(chunk.ReadByte(offset + 3) = 1, True, False)
		    name = name + If(isForeign, " (foreign)", "")
		    offset = offset + 4
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown constant opcode.")
		  End Select
		  
		  // The instruction' name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Its index in the pool.
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  details = details + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // The constant's value as a (short) string.
		  Var constant As Variant = chunk.Constants(constantIndex)
		  details = details + ObjoScript.VM.ValueToString(constant)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732060636F6E7374616E74602028776869636820697320617373756D656420746F20626520612076616C75652077697468696E20612066756E6374696F6E277320636F6E7374616E7420706F6F6C292061732061206054726565566965774E6F6465602E2060696E646578602069732074686520696E646578206F662074686520636F6E7374616E7420696E2074686520706F6F6C
		Private Function ConstantToNode(index As Integer, constant As Variant) As TreeViewNode
		  /// Returns `constant` (which is assumed to be a value within a function's constant pool) as a `TreeViewNode`.
		  /// `index` is the index of the constant in the pool
		  
		  Var indexCol As String = index.ToString(Locale.Current, "00000")
		  
		  If constant.Type = Variant.TypeDouble Then
		    Return New TreeViewNode(indexCol + " Number: " + constant.StringValue)
		    
		  ElseIf constant.Type = Variant.TypeString Then
		    Return New TreeViewNode(indexCol + " String: """ + constant + """")
		    
		  ElseIf constant.Type = Variant.TypeBoolean Then
		    Return New TreeViewNode(indexCol + " Boolean: " + If(constant.BooleanValue, "true", "false"))
		    
		  ElseIf constant IsA ObjoScript.Nothing Then
		    Return New TreeViewNode(indexCol + " nothing")
		    
		  ElseIf constant IsA ObjoScript.Func Then
		    Var funcNode As New TreeViewNode(indexCol + " Function")
		    funcNode.AppendNode(FunctionToTreeViewNode(ObjoScript.Func(constant)))
		    Return funcNode
		  Else
		    Raise New InvalidArgumentException("Unknown constant type.")
		  End If
		  
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

	#tag Method, Flags = &h0, Description = 446973617373656D626C65732060666020746F2061206054726565566965774E6F64656020666F7220646973706C617920696E206120604465736B746F705472656556696577602E
		Function FunctionToTreeViewNode(f As ObjoScript.Func) As TreeViewNode
		  /// Disassembles `f` to a `TreeViewNode` for display in a `DesktopTreeView`.
		  
		  // Function title.
		  Var funcTitle As String
		  If f.Name = "" Then
		    funcTitle = "Main Function" + f.Signature
		  Else
		    funcTitle = "Function " + If(f.IsSetter, "(setter)", "") + ": " + f.Signature
		  End If
		  Var funcNode As New TreeViewNode(funcTitle)
		  
		  // Function parameters.
		  Var paramsTitle As String
		  If f.Parameters.Count = 0 Then
		    paramsTitle = "0 Parameters"
		  Else
		    paramsTitle = "Parameters: "
		    For i As Integer = 0 To f.Parameters.LastIndex
		      paramsTitle = paramsTitle + f.Parameters(i) + If(i = f.Parameters.LastIndex, "", ", ")
		    Next i
		  End If
		  funcNode.AppendNode(New TreeViewNode(paramsTitle))
		  
		  // Constants pool.
		  Var constantsNode As TreeViewNode
		  If f.Chunk.Constants.Count = 0 Then
		    constantsNode = New TreeViewNode("Constants Pool: Empty")
		  Else
		    Var count As Integer = f.Chunk.Constants.Count
		    constantsNode = New TreeViewNode("Constants Pool: " + count.ToString + If(count = 1, " item", " items"))
		    Var constantsLimit As Integer = f.Chunk.Constants.Count - 1
		    For i As Integer = 0 To constantsLimit
		      constantsNode.AppendNode(ConstantToNode(i, f.Chunk.Constants.ItemAt(i)))
		    Next i
		  End If
		  funcNode.AppendNode(constantsNode)
		  
		  // Bytecode.
		  funcNode.AppendNode(BytecodeToNode(f.Chunk))
		  
		  Return funcNode
		  
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E737472756374696F6E2028617420606F6666736574602920746861742074616B657320612073696E676C652062797465206F706572616E6420616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function Instruction8BitOperandDetails(name As String, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of an instruction (at `offset`) that takes a single byte operand and increments `offset` to point to the next instruction.
		  ///
		  /// Format:
		  /// INSTRUCTION_NAME  OPERAND_VALUE
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the operand's value.
		  Var operand As Integer = chunk.ReadByte(offset + 1)
		  details = details + operand.ToString.JustifyLeft(COL_WIDTH)
		  
		  offset = offset + 2
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656164732074686520696E737472756374696F6E20617420606F6666736574602066726F6D20606368756E6B6020616E642072657475726E732069742061732061206054726565566965774E6F6465602E20496E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function InstructionToNode(chunk As ObjoScript.Chunk, ByRef offset As Integer) As TreeViewNode
		  /// Reads the instruction at `offset` from `chunk` and returns it as a `TreeViewNode`. 
		  /// Increments `offset` to point to the next instruction.
		  
		  // The instruction's offset in the chunk.
		  Var offsetString As String = offset.ToString(Locale.Current, "00000")
		  
		  // Get the instruction's line number and script ID from the offset now as it will be mutated shortly.
		  Var lineNum As Integer = chunk.LineForOffset(offset)
		  Var scriptID As Integer = chunk.ScriptIDForOffset(offset)
		  
		  Var details As String
		  Var opcode As UInt8 = chunk.Code(offset)
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_CONSTANT_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "CONSTANT", offset)
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "CONSTANT_LONG", offset)
		    
		  Case ObjoScript.VM.OP_RETURN
		    details = SimpleInstructionDetails("RETURN", offset)
		    
		  Case ObjoScript.VM.OP_NEGATE
		    details = SimpleInstructionDetails("NEGATE", offset)
		    
		  Case ObjoScript.VM.OP_ADD
		    details = SimpleInstructionDetails("ADD", offset)
		    
		  Case ObjoScript.VM.OP_SUBTRACT
		    details = SimpleInstructionDetails("SUBTRACT", offset)
		    
		  Case ObjoScript.VM.OP_DIVIDE
		    details = SimpleInstructionDetails("DIVIDE", offset)
		    
		  Case ObjoScript.VM.OP_MULTIPLY
		    details = SimpleInstructionDetails("MULTIPLY", offset)
		    
		  Case ObjoScript.VM.OP_MODULO
		    details = SimpleInstructionDetails("MODULO", offset)
		    
		  Case ObjoScript.VM.OP_NOT
		    details = SimpleInstructionDetails("NOT", offset)
		    
		  Case ObjoScript.VM.OP_EQUAL
		    details = SimpleInstructionDetails("EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_NOT_EQUAL
		    details = SimpleInstructionDetails("NOT_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_LESS
		    details = SimpleInstructionDetails("LESS", offset)
		    
		  Case ObjoScript.VM.OP_LESS_EQUAL
		    details = SimpleInstructionDetails("LESS_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_GREATER
		    details = SimpleInstructionDetails("GREATER", offset)
		    
		  Case ObjoScript.VM.OP_GREATER_EQUAL
		    details = SimpleInstructionDetails("GREATER_EQUAL", offset)
		    
		  Case ObjoScript.VM.OP_FALSE
		    details = SimpleInstructionDetails("FALSE", offset)
		    
		  Case ObjoScript.VM.OP_TRUE
		    details = SimpleInstructionDetails("TRUE", offset)
		    
		  Case ObjoScript.VM.OP_NOTHING
		    details = SimpleInstructionDetails("NOTHING", offset)
		    
		  Case ObjoScript.VM.OP_POP
		    details = SimpleInstructionDetails("POP", offset)
		    
		  Case ObjoScript.VM.OP_SHIFT_LEFT
		    details = SimpleInstructionDetails("SHIFT LEFT", offset)
		    
		  Case ObjoScript.VM.OP_SHIFT_RIGHT
		    details = SimpleInstructionDetails("SHIFT RIGHT", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_AND
		    details = SimpleInstructionDetails("BITWISE AND", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_OR
		    details = SimpleInstructionDetails("BITWISE OR", offset)
		    
		  Case ObjoScript.VM.OP_BITWISE_XOR
		    details = SimpleInstructionDetails("BITWISE XOR", offset)
		    
		  Case ObjoScript.VM.OP_LOGICAL_XOR
		    details = SimpleInstructionDetails("LOGICAL XOR", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_0
		    details = SimpleInstructionDetails("LOAD 0", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_1
		    details = SimpleInstructionDetails("LOAD 1", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_MINUS1
		    details = SimpleInstructionDetails("LOAD -1", offset)
		    
		  Case ObjoScript.VM.OP_ASSERT
		    details = SimpleInstructionDetails("ASSERT", offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL
		    details = ConstantInstructionDetails(opcode, chunk, "DEFINE_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "DEFINE_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL
		    details = ConstantInstructionDetails(opcode, chunk, "GET_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "GET_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL
		    details = ConstantInstructionDetails(opcode, chunk, "SET_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "SET_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_POP_N
		    details = Instruction8BitOperandDetails("POP_N", chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL
		    details = Instruction8BitOperandDetails("GET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_LOCAL
		    details = Instruction8BitOperandDetails("SET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP
		    details = JumpInstructionDetails("OP_JUMP", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_FALSE
		    details = JumpInstructionDetails("OP_JUMP_IF_FALSE", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_TRUE
		    details = JumpInstructionDetails("OP_JUMP_IF_TRUE", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_LOOP
		    details = JumpInstructionDetails("OP_LOOP", True, chunk, offset)
		    
		  Case ObjoScript.VM.OP_RANGE
		    details = SimpleInstructionDetails("OP_RANGE", offset)
		    
		  Case ObjoScript.VM.OP_EXIT
		    details = SimpleInstructionDetails("OP_EXIT", offset)
		    
		  Case ObjoScript.VM.OP_CALL
		    details = Instruction8BitOperandDetails("OP_CALL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_CLASS
		    details = ConstantInstructionDetails(opcode, chunk, "CLASS", offset)
		    
		  Case ObjoScript.VM.OP_METHOD
		    details = MethodInstructionDetails(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_SETTER
		    details = ConstantInstructionDetails(opcode, chunk, "SETTER", offset)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "SETTER_LONG", offset)
		    
		  Case ObjoScript.VM.OP_GETTER
		    details = ConstantInstructionDetails(opcode, chunk, "GETTER", offset)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "GETTER_LONG", offset)
		    
		  Case ObjoScript.VM.OP_GET_FIELD
		    details = ConstantInstructionDetails(opcode, chunk, "GET_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_GET_FIELD_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "GET_FIELD_LONG", offset)
		    
		  Case ObjoScript.VM.OP_SET_FIELD
		    details = ConstantInstructionDetails(opcode, chunk, "SET_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_SET_FIELD_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "SET_FIELD_LONG", offset)
		    
		  Case ObjoScript.VM.OP_CONSTRUCTOR
		    details = ConstantInstructionDetails(opcode, chunk, "CONSTRUCTOR", offset)
		    
		  Case ObjoScript.VM.OP_INVOKE
		    details = InvokeInstructionDetails(opcode, chunk, "INVOKE", offset)
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
		    details = InvokeInstructionDetails(opcode, chunk, "INVOKE_LONG", offset)
		    
		  Case ObjoScript.VM.OP_INHERIT
		    details = SimpleInstructionDetails("OP_INHERIT", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_GETTER
		    details = ConstantInstructionDetails(opcode, chunk, "SUPER_GETTER", offset)
		    
		  Case ObjoScript.VM.OP_GETTER_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "GETTER_LONG", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER
		    details = ConstantInstructionDetails(opcode, chunk, "SUPER_SETTER", offset)
		    
		  Case ObjoScript.VM.OP_SETTER_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "SETTER_LONG", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE
		    details = InvokeInstructionDetails(opcode, chunk, "SUPER_INVOKE", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE_LONG
		    details = InvokeInstructionDetails(opcode, chunk, "SUPER_INVOKE_LONG", offset)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD
		    details = ConstantInstructionDetails(opcode, chunk, "GET_STATIC_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    details = ConstantInstructionDetails(opcode, chunk, "GET_STATIC_FIELD_LONG", offset)
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    details = MethodInstructionDetails(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_IS
		    details = SimpleInstructionDetails("OP_IS", offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL_CLASS
		    details = Instruction8BitOperandDetails("GET LOCAL CLASS", chunk, offset)
		    
		  Case ObjoScript.VM.OP_LOCAL_VAR_DEC
		    details = LocalVarDecDetails(chunk, offset)
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		  
		  Var node As New TreeViewNode(offsetString + ": " + details)
		  node.AppendNode(New TreeViewNode("Line: " + lineNum.ToString))
		  node.AppendNode(New TreeViewNode("ScriptID: " + scriptID.ToString))
		  
		  Return node
		  
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B6520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function InvokeInstructionDetails(opcode As UInt8, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of an invoke/super_invoke instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the constant's index in the pool, the method's name and the argument count.
		  ///
		  /// Format:
		  /// INSTRUCTION  METHOD_NAME_INDEX  METHOD_NAME  ARGCOUNT
		  
		  Var index, argCount As Integer
		  Select Case opcode
		  Case ObjoScript.VM.OP_INVOKE, ObjoScript.VM.OP_SUPER_INVOKE
		    index = chunk.ReadByte(offset + 1)
		    argCount = chunk.ReadByte(offset + 2)
		    offset = offset + 3
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG, ObjoScript.VM.OP_SUPER_INVOKE_LONG
		    index = chunk.ReadUInt16(offset + 1)
		    argCount = chunk.ReadByte(offset + 3)
		    offset = offset + 4
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown invoke opcode.")
		  End Select
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the index in the pool.
		  Var indexCol As String = index.ToString(Locale.Current, "#####")
		  details = details + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // Append the method's name.
		  Var methodNameValue As Variant = chunk.Constants(index)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  details = details + methodName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54616B65732061207061727469616C6C7920636F6E737472756374656420606C696E656020616E6420617070656E64732061206A756D7020696E737472756374696F6E20746F2069742E204974207468656E20617070656E64732074686174206C696E6520746F206073602E2052657475726E7320746865206F666673657420666F7220746865206E65787420696E737472756374696F6E2E
		Private Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, offset As Integer, line As String, s() As String) As Integer
		  /// Takes a partially constructed `line` and appends a jump instruction to it. It then appends that line to `s`.
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F662061206A756D7020696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function JumpInstructionDetails(name As String, negative As Boolean, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a jump instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Jump instructions take a two byte operand (the jump offset) 
		  /// If `negative` then this is a backwards jump.
		  ///
		  /// Format:
		  /// INSTRUCTION_NAME  OFFSET -> DESTINATION
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the destination offset.
		  Var jump As Integer = chunk.ReadUInt16(offset + 1)
		  Var destination As Integer = offset + 3 + If(negative, -1, 1) * jump
		  Var destCol As String = offset.ToString + " -> " + destination.ToString
		  details = details + destCol.JustifyLeft(COL_WIDTH * 2)
		  
		  offset = offset + 3
		  
		  Return details
		  
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620746865204F505F4C4F43414C5F5641525F44454320696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function LocalVarDecDetails(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of the OP_LOCAL_VAR_DEC instruction at `offset` and increments `offset` to point to the next instruction.
		  /// 
		  /// This instruction takes a 2 bytes (name index) and a one byte (slot index) operand.
		  ///
		  /// Format:
		  /// VAR_NAME  SLOT
		  
		  Var name As String = "OP_LOCAL_VAR_DEC"
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Get the index of the name of the variable in the chunk's constant pool.
		  Var index As Integer = chunk.ReadUInt16(offset + 1)
		  
		  // Get the local slot.
		  Var slot As Integer = chunk.ReadByte(offset + 3)
		  
		  // Append the name of the variable.
		  Var varName As String = chunk.Constants(index)
		  varName = varName.JustifyLeft(2 * COL_WIDTH)
		  details = details + varName
		  
		  // Append the slot.
		  details = details + slot.ToString
		  
		  offset = offset + 4
		  
		  Return details
		  
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F662061206D6574686F6420696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function MethodInstructionDetails(opcode As UInt8, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a method instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// We return the instruction's name, the index of the method's name in the constant pool, the method name and if it's a static or instance method.
		  ///
		  /// The METHOD instruction takes a two byte operand (for the index of the method's signature in the constant pool) and a single byte
		  /// operand specifying if the method is static (1) or instance (0).
		  /// The FOREIGN_METHOD instruction first takes a two byte operand for the index of the signature in the constant pool. It then
		  /// takes a single byte operand specifying the arity (we don't print this) and finally a single byte operand
		  /// specifying if the method is static (1) or instance (0).
		  /// Format:
		  /// INSTRUCTION_NAME  POOL_INDEX  METHOD_NAME  STATIC/INSTANCE?
		  
		  Var constantIndex As Integer
		  Var isStatic As Boolean
		  Var name As String
		  Select Case opcode
		  Case ObjoScript.VM.OP_METHOD
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    isStatic = If(chunk.ReadByte(offset + 3) = 1, True, False)
		    offset = offset + 4
		    name = "METHOD"
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    Call chunk.ReadByte(offset + 3) // The method's arity. We won't print this.
		    isStatic = If(chunk.ReadByte(offset + 4) = 1, True, False)
		    offset = offset + 5
		    name = "FOREIGN_METHOD"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown method opcode.")
		  End Select
		  
		  // The instructions name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the constant pool index.
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  details = details + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // Append the method's name.
		  Var methodNameValue As Variant = chunk.Constants(constantIndex)
		  Var methodName As String = ObjoScript.VM.ValueToString(methodNameValue)
		  details = details + methodName.JustifyLeft(COL_WIDTH * 2)
		  
		  // Append if this a static or instance method.
		  details = details + If(isStatic, "Static", "Instance")
		  
		  Return details
		  
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620612073696D706C6520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function SimpleInstructionDetails(instructionName As String, ByRef offset As Integer) As String
		  /// Returns the details of a simple instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Simple instructions are a single byte and take no operands.
		  /// Format:
		  /// INSTRUCTION_NAME
		  
		  offset = offset + 1
		  
		  Return instructionName.JustifyLeft(COL_WIDTH)
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
	#tag EndConstant


End Class
#tag EndClass
