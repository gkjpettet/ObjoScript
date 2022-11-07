#tag Class
Protected Class Debugger
	#tag Method, Flags = &h21, Description = 446973617373656D626C6573207468652062797465636F64652077697468696E20606368756E6B602C2072657475726E696E672069742061732061206054726565566965774E6F6465602E
		Private Function BytecodeToNode(chunk As ObjoScript.Chunk, includeStandardLibraryBytecode As Boolean = True) As TreeViewNode
		  /// Disassembles the bytecode within `chunk`, returning it as a `TreeViewNode`.
		  ///
		  /// If `includeStandardLibraryBytecode` is False then we don't add these nodes.
		  
		  Var chunkNode As New TreeViewNode("Bytecode")
		  
		  Var offset As Integer = 0
		  While offset < chunk.Length
		    Var instructionNode As TreeViewNode = InstructionToNode(chunk, offset)
		    If Not includeStandardLibraryBytecode Then
		      If instructionNode.ItemData <> Nil And instructionNode.ItemData.DoubleValue < 0 Then
		        // This bytecode originated in the standard library and the user doesn't want to include it.
		        Continue
		      End If
		    End If
		    chunkNode.AppendNode(instructionNode)
		  Wend
		  
		  Return chunkNode
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F66206120636C61737320696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function ClassInstruction(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a class instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// We return the instruction's name, the index of the class' name in the constant pool, the class name, whether
		  /// it's a foreign class, the total number of fields used by the class and the index of the first field in 
		  /// `Klass.Fields`.
		  /// Format:
		  /// INSTRUCTION_NAME  POOL_INDEX  CLASS_NAME  FIELD_COUNT  FIRST_FIELD_INDEX
		  
		  // Get index of the constant.
		  Var constantIndex As Integer = chunk.ReadUInt16(offset + 1)
		  
		  // Compute the name and whether the class is foreign.
		  Var isForeign As Boolean = If(chunk.ReadByte(offset + 3) = 1, True, False)
		  Var name As String = "CLASS" + If(isForeign, " (foreign)", "")
		  
		  // Get the number of fields.
		  Var fieldCount As Integer = chunk.ReadByte(offset + 4)
		  
		  // Get the index of the first field.
		  Var fieldFirstIndex As Integer = chunk.ReadByte(offset + 5)
		  
		  // Adjust the offset to the new value.
		  offset = offset + 6
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Its index in the pool.
		  Var indexCol As String = constantIndex.ToString(Locale.Current, "#####")
		  details = details + indexCol.JustifyLeft(COL_WIDTH)
		  
		  // The class' name.
		  Var className As Variant = chunk.Constants(constantIndex)
		  details = details + (ObjoScript.VM.ValueToString(className).JustifyLeft(COL_WIDTH))
		  
		  // Append the field count.
		  details = details + fieldCount.ToString.JustifyLeft(COL_WIDTH)
		  
		  // Append the first field index.
		  details = details + fieldFirstIndex.ToString
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F66206120636F6E7374616E74206C6F6164696E6720696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function ConstantInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of a constant loading instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Some instructions use a single byte operand, others use a two byte operand. The operand is the index of the constant in the constant pool.
		  /// Format:
		  /// INSTRUCTION_NAME  POOL_INDEX  CONSTANT_VALUE
		  
		  // Get index of the constant.
		  Var constantIndex As Integer
		  
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_DEFINE_GLOBAL, ObjoScript.VM.OP_GET_GLOBAL, _
		    ObjoScript.VM.OP_SET_GLOBAL, ObjoScript.VM.OP_SET_FIELD, ObjoScript.VM.OP_SET_STATIC_FIELD, _
		    ObjoScript.VM.OP_GET_FIELD, ObjoScript.VM.OP_GET_STATIC_FIELD
		    constantIndex = chunk.ReadByte(offset + 1)
		    offset = offset + 2
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG, ObjoScript.VM.OP_DEFINE_GLOBAL_LONG, _
		    ObjoScript.VM.OP_GET_GLOBAL_LONG, ObjoScript.VM.OP_SET_GLOBAL_LONG, ObjoScript.VM.OP_CONSTRUCTOR, _
		    ObjoScript.VM.OP_SET_STATIC_FIELD_LONG, _
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
		  
		  // The instruction's name.
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
		    funcNode.AppendNode(DisassembleFunction(ObjoScript.Func(constant)))
		    Return funcNode
		  Else
		    Raise New InvalidArgumentException("Unknown constant type.")
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620746865204F505F44454255475F4649454C445F4E414D4520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function DebugFieldName(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of the OP_DEBUG_FIELD_NAME instruction at `offset` and increments `offset` to point to the next instruction.
		  /// 
		  /// This instruction takes a two byte (field name index) and a one byte (`Klass.Fields` index) operand.
		  ///
		  /// Format:
		  /// FIELD_NAME  INDEX
		  
		  Var name As String = "DEBUG_FIELD_NAME"
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // Get the index of the name of the field in the chunk's constant pool.
		  Var poolIndex As Integer = chunk.ReadUInt16(offset + 1)
		  
		  // Get the `Klass.Fields` index.
		  Var index As Integer = chunk.ReadByte(offset + 3)
		  
		  // Append the name of the field.
		  Var fieldName As String = chunk.Constants(poolIndex)
		  fieldName = fieldName.JustifyLeft(2 * COL_WIDTH)
		  details = details + fieldName
		  
		  // Append the index.
		  details = details + index.ToString
		  
		  // Adjust the offset.
		  offset = offset + 4
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973617373656D626C65732066756E6374696F6E2060666020746F2061206054726565566965774E6F64656020666F7220646973706C617920696E206120604465736B746F705472656556696577602E
		Function DisassembleFunction(f As ObjoScript.Func, includeStandardLibraryBytecode As Boolean = True) As TreeViewNode
		  /// Disassembles function `f` to a `TreeViewNode` for display in a `DesktopTreeView`.
		  ///
		  /// If `includeStandardLibraryBytecode` is False then we don't add these nodes.
		  
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
		  funcNode.AppendNode(BytecodeToNode(f.Chunk, includeStandardLibraryBytecode))
		  
		  Return funcNode
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52656164732074686520696E737472756374696F6E20617420606F6666736574602066726F6D20606368756E6B6020616E642072657475726E73206974206173206120737472696E672E204D75746174657320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Function DisassembleInstruction(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Reads the instruction at `offset` from `chunk` and returns it as a string.
		  /// Mutates `offset` to point to the next instruction.
		  
		  Var opcode As UInt8 = chunk.Code(offset)
		  Select Case opcode
		  Case ObjoScript.VM.OP_CONSTANT, ObjoScript.VM.OP_CONSTANT_LONG
		    Return ConstantInstruction(opcode, chunk, "CONSTANT", offset)
		    
		  Case ObjoScript.VM.OP_CONSTANT_LONG
		    Return ConstantInstruction(opcode, chunk, "CONSTANT_LONG", offset)
		    
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
		    
		  Case ObjoScript.VM.OP_BITWISE_NOT
		    Return SimpleInstruction("BITWISE NOT", offset)
		    
		  Case ObjoScript.VM.OP_LOGICAL_XOR
		    Return SimpleInstruction("LOGICAL XOR", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_0
		    Return SimpleInstruction("LOAD 0", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_1
		    Return SimpleInstruction("LOAD 1", offset)
		    
		  Case ObjoScript.VM.OP_LOAD_MINUS1
		    Return SimpleInstruction("LOAD -1", offset)
		    
		  Case ObjoScript.VM.OP_ASSERT
		    Return SimpleInstruction("ASSERT", offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL
		    Return ConstantInstruction(opcode, chunk, "DEFINE_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, "DEFINE_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, "GET_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_GET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, "GET_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL
		    Return ConstantInstruction(opcode, chunk, "SET_GLOBAL", offset)
		    
		  Case ObjoScript.VM.OP_SET_GLOBAL_LONG
		    Return ConstantInstruction(opcode, chunk, "SET_GLOBAL_LONG", offset)
		    
		  Case ObjoScript.VM.OP_POP_N
		    Return Instruction8BitOperand("POP_N", chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL
		    Return Instruction8BitOperand("GET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_SET_LOCAL
		    Return Instruction8BitOperand("SET LOCAL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP
		    Return JumpInstruction("JUMP", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_FALSE
		    Return JumpInstruction("JUMP_IF_FALSE", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_JUMP_IF_TRUE
		    Return JumpInstruction("JUMP_IF_TRUE", False, chunk, offset)
		    
		  Case ObjoScript.VM.OP_LOOP
		    Return JumpInstruction("LOOP", True, chunk, offset)
		    
		  Case ObjoScript.VM.OP_RANGE
		    Return SimpleInstruction("RANGE", offset)
		    
		  Case ObjoScript.VM.OP_EXIT
		    Return SimpleInstruction("EXIT", offset)
		    
		  Case ObjoScript.VM.OP_CALL
		    Return Instruction8BitOperand("CALL", chunk, offset)
		    
		  Case ObjoScript.VM.OP_CLASS
		    Return ClassInstruction(chunk, offset)
		    
		  Case ObjoScript.VM.OP_METHOD
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_FIELD
		    Return FieldInstruction(chunk, "GET_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_SET_FIELD
		    Return FieldInstruction(chunk, "SET_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_SET_STATIC_FIELD
		    Return ConstantInstruction(opcode, chunk, "SET_STATIC_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_SET_STATIC_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, "SET_STATIC_FIELD_LONG", offset)
		    
		  Case ObjoScript.VM.OP_CONSTRUCTOR
		    Return Instruction8BitOperand("CONSTRUCTOR", chunk, offset)
		    
		  Case ObjoScript.VM.OP_INVOKE
		    Return InvokeInstruction(opcode, chunk, "INVOKE", offset)
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
		    Return InvokeInstruction(opcode, chunk, "INVOKE_LONG", offset)
		    
		  Case ObjoScript.VM.OP_INHERIT
		    Return SimpleInstruction("INHERIT", offset)
		    
		  Case ObjoScript.VM.OP_SUPER_SETTER
		    Return SuperSetter(chunk, offset)
		    
		  Case ObjoScript.VM.OP_SUPER_INVOKE
		    Return SuperInvoke(chunk, offset)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD
		    Return ConstantInstruction(opcode, chunk, "GET_STATIC_FIELD", offset)
		    
		  Case ObjoScript.VM.OP_GET_STATIC_FIELD_LONG
		    Return ConstantInstruction(opcode, chunk, "GET_STATIC_FIELD_LONG", offset)
		    
		  Case ObjoScript.VM.OP_FOREIGN_METHOD
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case ObjoScript.VM.OP_IS
		    Return SimpleInstruction("IS", offset)
		    
		  Case ObjoScript.VM.OP_GET_LOCAL_CLASS
		    Return Instruction8BitOperand("GET LOCAL CLASS", chunk, offset)
		    
		  Case ObjoScript.VM.OP_LOCAL_VAR_DEC
		    Return LocalVarDec(chunk, offset)
		    
		  Case ObjoScript.VM.OP_SUPER_CONSTRUCTOR
		    Return SuperConstructor(chunk, offset)
		    
		  Case ObjoScript.VM.OP_LIST
		    Return Instruction8BitOperand("LIST", chunk, offset)
		    
		  Case ObjoScript.VM.OP_SWAP
		    Return SimpleInstruction("SWAP", offset)
		    
		  Case ObjoScript.VM.OP_DEBUG_FIELD_NAME
		    Return DebugFieldName(chunk, offset)
		    
		  Case ObjoScript.VM.OP_DEFINE_NOTHING
		    Return SimpleInstruction("DEFINE_NOTHING", offset)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F662061206669656C64206765742F73657420696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function FieldInstruction(chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of a field get/set instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// The operand is the index of the field in the instance's `Fields` array.
		  /// Format:
		  /// INSTRUCTION_NAME  FIELDS_INDEX
		  
		  // Get index of the constant.
		  Var fieldIndex As Integer = chunk.ReadByte(offset + 1)
		  
		  // The instruction's name.
		  Var details As String = name.JustifyLeft(2 * COL_WIDTH)
		  
		  // The field index.
		  Var fieldIndexCol As String = fieldIndex.ToString(Locale.Current, "#####")
		  details = details + fieldIndexCol
		  
		  offset = offset + 2
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E737472756374696F6E2028617420606F6666736574602920746861742074616B657320612073696E676C652062797465206F706572616E6420616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function Instruction8BitOperand(name As String, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  
		  Var details As String = DisassembleInstruction(chunk, offset)
		  
		  Var node As New TreeViewNode(offsetString + ": " + details)
		  node.AppendNode(New TreeViewNode("Line: " + lineNum.ToString))
		  node.AppendNode(New TreeViewNode("ScriptID: " + scriptID.ToString))
		  
		  // Store the script ID as data on the node so we can filter it.
		  node.ItemData = scriptID
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B652F73757065725F636F6E7374727563746F7220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function InvokeInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of an invoke/super_invoke/super_constructor instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the constant's index in the pool, the method's signature and the argument count.
		  ///
		  /// Format:
		  /// INSTRUCTION  METHOD_NAME_INDEX  METHOD_NAME  ARGCOUNT
		  
		  Var index, argCount As Integer
		  Select Case opcode
		  Case ObjoScript.VM.OP_INVOKE
		    index = chunk.ReadByte(offset + 1)
		    argCount = chunk.ReadByte(offset + 2)
		    offset = offset + 3
		    
		  Case ObjoScript.VM.OP_INVOKE_LONG
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F662061206A756D7020696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620746865204F505F4C4F43414C5F5641525F44454320696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function LocalVarDec(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of the OP_LOCAL_VAR_DEC instruction at `offset` and increments `offset` to point to the next instruction.
		  /// 
		  /// This instruction takes a two byte (name index) and a one byte (slot index) operand.
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F662061206D6574686F6420696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function MethodInstruction(opcode As UInt8, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620612073696D706C6520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function SimpleInstruction(instructionName As String, ByRef offset As Integer) As String
		  /// Returns the details of a simple instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Simple instructions are a single byte and take no operands.
		  /// Format:
		  /// INSTRUCTION_NAME
		  
		  offset = offset + 1
		  
		  Return instructionName.JustifyLeft(COL_WIDTH)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B652F73757065725F636F6E7374727563746F7220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function SuperConstructor(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a super_constructor instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the superclass's name and the argument count.
		  ///
		  /// Format:
		  /// INSTRUCTION  SUPERCLASS_NAME  ARGCOUNT
		  
		  Var superNameIndex, argCount As Integer
		  superNameIndex = chunk.ReadUInt16(offset + 1)
		  argCount = chunk.ReadByte(offset + 3)
		  offset = offset + 4
		  
		  // The instruction's name.
		  Var details As String = "SUPER_CONSTRUCTOR"
		  details = details.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the superclass name.
		  Var superclassName As String = _
		  ObjoScript.VM.ValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B652F73757065725F636F6E7374727563746F7220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function SuperInvoke(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a super_invoke instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the superclass's name, the method signature to invoke and the argument count.
		  ///
		  /// Format:
		  /// INSTRUCTION  SUPERCLASS_NAME  SIGNATURE   ARGCOUNT
		  
		  Var superNameIndex, sigIndex, argCount As Integer
		  superNameIndex = chunk.ReadUInt16(offset + 1)
		  sigIndex = chunk.ReadUInt16(offset + 3)
		  argCount = chunk.ReadByte(offset + 5)
		  offset = offset + 6
		  
		  // The instruction's name.
		  Var details As String = "SUPER_INVOKE"
		  details = details.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the superclass name.
		  Var superclassName As String = _
		  ObjoScript.VM.ValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the signature name.
		  Var sig As String = _
		  ObjoScript.VM.ValueToString(chunk.Constants(sigIndex))
		  details = details + sig.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652064657461696C73206F6620612073757065725F73657474657220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Private Function SuperSetter(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Returns the details of a super_setter instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the superclass's name and the setter signature to invoke.
		  ///
		  /// Format:
		  /// INSTRUCTION  SUPERCLASS_NAME  SIGNATURE
		  
		  Var superNameIndex, sigIndex As Integer
		  superNameIndex = chunk.ReadUInt16(offset + 1)
		  sigIndex = chunk.ReadUInt16(offset + 3)
		  offset = offset + 5
		  
		  // The instruction's name.
		  Var details As String = "SUPER_SETTER"
		  details = details.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the superclass name.
		  Var superclassName As String = _
		  ObjoScript.VM.ValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the signature name.
		  Var sig As String = _
		  ObjoScript.VM.ValueToString(chunk.Constants(sigIndex))
		  details = details + sig.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = COL_WIDTH, Type = Double, Dynamic = False, Default = \"10", Scope = Private, Description = 5468652077696474682061207374616E6461726420636F6C756D6E20696E2074686520646973617373656D626C79206F75747075742E
	#tag EndConstant


End Class
#tag EndClass
