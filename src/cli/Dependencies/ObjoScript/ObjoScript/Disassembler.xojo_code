#tag Class
Protected Class Disassembler
	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F66206120636C61737320696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function ClassInstruction(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  details = details + (ObjoScript.VM.StackValueToString(className).JustifyLeft(COL_WIDTH))
		  
		  // Append the field count.
		  details = details + fieldCount.ToString.JustifyLeft(COL_WIDTH)
		  
		  // Append the first field index.
		  details = details + fieldFirstIndex.ToString
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F66206120636F6E7374616E74206C6F6164696E6720696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function ConstantInstruction(opcode As ObjoScript.VM.Opcodes, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of a constant loading instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Some instructions use a single byte operand, others use a two byte operand. The operand is the index of the constant in the constant pool.
		  /// Format:
		  /// INSTRUCTION_NAME  POOL_INDEX  CONSTANT_VALUE
		  
		  // Get index of the constant.
		  Var constantIndex As Integer
		  
		  Select Case opcode
		  Case VM.Opcodes.Constant_, VM.Opcodes.DefineGlobal, VM.Opcodes.GetGlobal, _
		    VM.Opcodes.SetGlobal, VM.Opcodes.SetField, VM.Opcodes.SetStaticField, _
		    VM.Opcodes.GetField, VM.Opcodes.GetStaticField
		    constantIndex = chunk.ReadByte(offset + 1)
		    offset = offset + 2
		    
		  Case VM.Opcodes.ConstantLong, VM.Opcodes.DefineGlobalLong, _
		    VM.Opcodes.GetGlobalLong, VM.Opcodes.SetGlobalLong, VM.Opcodes.Constructor_, _
		    VM.Opcodes.SetStaticFieldLong, VM.Opcodes.GetStaticFieldLong
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    offset = offset + 3
		    
		  Case VM.Opcodes.Class_
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
		  details = details + ObjoScript.VM.StackValueToString(constant)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620746865204F505F44454255475F4649454C445F4E414D4520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function DebugFieldName(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h0, Description = 52656164732074686520696E737472756374696F6E20617420606F6666736574602066726F6D20606368756E6B6020616E642072657475726E73206974206173206120737472696E672E204D75746174657320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Function DisassembleInstruction(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
		  /// Reads the instruction at `offset` from `chunk` and returns it as a string.
		  /// Mutates `offset` to point to the next instruction.
		  
		  Var opcode As VM.Opcodes = VM.Opcodes(chunk.Code(offset))
		  Select Case opcode
		  Case VM.Opcodes.Constant_
		    Return ConstantInstruction(opcode, chunk, "CONSTANT", offset)
		    
		  Case VM.Opcodes.ConstantLong
		    Return ConstantInstruction(opcode, chunk, "CONSTANT_LONG", offset)
		    
		  Case VM.Opcodes.Return_
		    Return SimpleInstruction("RETURN", offset)
		    
		  Case VM.Opcodes.Negate
		    Return SimpleInstruction("NEGATE", offset)
		    
		  Case VM.Opcodes.Add
		    Return SimpleInstruction("ADD", offset)
		    
		  Case VM.Opcodes.Add1
		    Return SimpleInstruction("ADD1", offset)
		    
		  Case VM.Opcodes.Subtract
		    Return SimpleInstruction("SUBTRACT", offset)
		    
		  Case VM.Opcodes.Subtract1
		    Return SimpleInstruction("SUBTRACT1", offset)
		    
		  Case VM.Opcodes.Divide
		    Return SimpleInstruction("DIVIDE", offset)
		    
		  Case VM.Opcodes.Multiply
		    Return SimpleInstruction("MULTIPLY", offset)
		    
		  Case VM.Opcodes.Modulo
		    Return SimpleInstruction("MODULO", offset)
		    
		  Case VM.Opcodes.Not_
		    Return SimpleInstruction("NOT", offset)
		    
		  Case VM.Opcodes.Equal
		    Return SimpleInstruction("EQUAL", offset)
		    
		  Case VM.Opcodes.NotEqual
		    Return SimpleInstruction("NOT_EQUAL", offset)
		    
		  Case VM.Opcodes.Less
		    Return SimpleInstruction("LESS", offset)
		    
		  Case VM.Opcodes.LessEqual
		    Return SimpleInstruction("LESS_EQUAL", offset)
		    
		  Case VM.Opcodes.Greater
		    Return SimpleInstruction("GREATER", offset)
		    
		  Case VM.Opcodes.GreaterEqual
		    Return SimpleInstruction("GREATER_EQUAL", offset)
		    
		  Case VM.Opcodes.False_
		    Return SimpleInstruction("FALSE", offset)
		    
		  Case VM.Opcodes.True_
		    Return SimpleInstruction("TRUE", offset)
		    
		  Case VM.Opcodes.Nothing
		    Return SimpleInstruction("NOTHING", offset)
		    
		  Case VM.Opcodes.Pop
		    Return SimpleInstruction("POP", offset)
		    
		  Case VM.Opcodes.ShiftLeft
		    Return SimpleInstruction("SHIFT LEFT", offset)
		    
		  Case VM.Opcodes.ShiftRight
		    Return SimpleInstruction("SHIFT RIGHT", offset)
		    
		  Case VM.Opcodes.BitwiseAnd
		    Return SimpleInstruction("BITWISE AND", offset)
		    
		  Case VM.Opcodes.BitwiseOr
		    Return SimpleInstruction("BITWISE OR", offset)
		    
		  Case VM.Opcodes.BitwiseXor
		    Return SimpleInstruction("BITWISE XOR", offset)
		    
		  Case VM.Opcodes.BitwiseNot
		    Return SimpleInstruction("BITWISE NOT", offset)
		    
		  Case VM.Opcodes.LogicalXor
		    Return SimpleInstruction("LOGICAL XOR", offset)
		    
		  Case VM.Opcodes.Load0
		    Return SimpleInstruction("LOAD 0", offset)
		    
		  Case VM.Opcodes.Load1
		    Return SimpleInstruction("LOAD 1", offset)
		    
		  Case VM.Opcodes.LoadMinus1
		    Return SimpleInstruction("LOAD -1", offset)
		    
		  Case VM.Opcodes.LoadMinus2
		    Return SimpleInstruction("LOAD -2", offset)
		    
		  Case VM.Opcodes.Assert
		    Return SimpleInstruction("ASSERT", offset)
		    
		  Case VM.Opcodes.DefineGlobal
		    Return ConstantInstruction(opcode, chunk, "DEFINE_GLOBAL", offset)
		    
		  Case VM.Opcodes.DefineGlobalLong
		    Return ConstantInstruction(opcode, chunk, "DEFINE_GLOBAL_LONG", offset)
		    
		  Case VM.Opcodes.GetGlobal
		    Return ConstantInstruction(opcode, chunk, "GET_GLOBAL", offset)
		    
		  Case VM.Opcodes.GetGlobalLong
		    Return ConstantInstruction(opcode, chunk, "GET_GLOBAL_LONG", offset)
		    
		  Case VM.Opcodes.SetGlobal
		    Return ConstantInstruction(opcode, chunk, "SET_GLOBAL", offset)
		    
		  Case VM.Opcodes.SetGlobalLong
		    Return ConstantInstruction(opcode, chunk, "SET_GLOBAL_LONG", offset)
		    
		  Case VM.Opcodes.PopN
		    Return Instruction8BitOperand("POP_N", chunk, offset)
		    
		  Case VM.Opcodes.GetLocal
		    Return Instruction8BitOperand("GET LOCAL", chunk, offset)
		    
		  Case VM.Opcodes.SetLocal
		    Return Instruction8BitOperand("SET LOCAL", chunk, offset)
		    
		  Case VM.Opcodes.Jump
		    Return JumpInstruction("JUMP", False, chunk, offset)
		    
		  Case VM.Opcodes.JumpIfFalse
		    Return JumpInstruction("JUMP_IF_FALSE", False, chunk, offset)
		    
		  Case VM.Opcodes.JumpIfTrue
		    Return JumpInstruction("JUMP_IF_TRUE", False, chunk, offset)
		    
		  Case VM.Opcodes.Loop_
		    Return JumpInstruction("LOOP", True, chunk, offset)
		    
		  Case VM.Opcodes.RangeInclusive
		    Return SimpleInstruction("RANGE_INCLUSIVE", offset)
		    
		  Case VM.Opcodes.RangeExclusive
		    Return SimpleInstruction("RANGE_EXCLUSIVE", offset)
		    
		  Case VM.Opcodes.Exit_
		    Return SimpleInstruction("EXIT", offset)
		    
		  Case VM.Opcodes.Call_
		    Return Instruction8BitOperand("CALL", chunk, offset)
		    
		  Case VM.Opcodes.Class_
		    Return ClassInstruction(chunk, offset)
		    
		  Case VM.Opcodes.Method
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case VM.Opcodes.GetField
		    Return FieldInstruction(chunk, "GET_FIELD", offset)
		    
		  Case VM.Opcodes.SetField
		    Return FieldInstruction(chunk, "SET_FIELD", offset)
		    
		  Case VM.Opcodes.SetStaticField
		    Return ConstantInstruction(opcode, chunk, "SET_STATIC_FIELD", offset)
		    
		  Case VM.Opcodes.SetStaticFieldLong
		    Return ConstantInstruction(opcode, chunk, "SET_STATIC_FIELD_LONG", offset)
		    
		  Case VM.Opcodes.Constructor_
		    Return Instruction8BitOperand("CONSTRUCTOR", chunk, offset)
		    
		  Case VM.Opcodes.Invoke
		    Return InvokeInstruction(opcode, chunk, "INVOKE", offset)
		    
		  Case VM.Opcodes.InvokeLong
		    Return InvokeInstruction(opcode, chunk, "INVOKE_LONG", offset)
		    
		  Case VM.Opcodes.Inherit
		    Return SimpleInstruction("INHERIT", offset)
		    
		  Case VM.Opcodes.SuperSetter
		    Return SuperSetter(chunk, offset)
		    
		  Case VM.Opcodes.SuperInvoke
		    Return SuperInvoke(chunk, offset)
		    
		  Case VM.Opcodes.GetStaticField
		    Return ConstantInstruction(opcode, chunk, "GET_STATIC_FIELD", offset)
		    
		  Case VM.Opcodes.GetStaticFieldLong
		    Return ConstantInstruction(opcode, chunk, "GET_STATIC_FIELD_LONG", offset)
		    
		  Case VM.Opcodes.ForeignMethod
		    Return MethodInstruction(opcode, chunk, offset)
		    
		  Case VM.Opcodes.Is_
		    Return SimpleInstruction("IS", offset)
		    
		  Case VM.Opcodes.GetLocalClass
		    Return Instruction8BitOperand("GET LOCAL CLASS", chunk, offset)
		    
		  Case VM.Opcodes.LocalVarDecl
		    Return LocalVarDec(chunk, offset)
		    
		  Case VM.Opcodes.SuperConstructor
		    Return SuperConstructor(chunk, offset)
		    
		  Case VM.Opcodes.List
		    Return Instruction8BitOperand("LIST", chunk, offset)
		    
		  Case VM.Opcodes.Swap
		    Return SimpleInstruction("SWAP", offset)
		    
		  Case VM.Opcodes.DebugFieldName
		    Return DebugFieldName(chunk, offset)
		    
		  Case VM.Opcodes.DefineNothing
		    Return SimpleInstruction("DEFINE_NOTHING", offset)
		    
		  Case VM.Opcodes.Map
		    Return Instruction8BitOperand("MAP", chunk, offset)
		    
		  Case VM.Opcodes.KeyValue
		    Return SimpleInstruction("KEYVALUE", offset)
		    
		  Case VM.Opcodes.Breakpoint
		    Return SimpleInstruction("BREAKPOINT", offset)
		    
		  Case VM.Opcodes.Load2
		    Return SimpleInstruction("LOAD2", offset)
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown opcode (byte value: " + opcode.ToString + ").")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F662061206669656C64206765742F73657420696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function FieldInstruction(chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620616E20696E737472756374696F6E2028617420606F6666736574602920746861742074616B657320612073696E676C652062797465206F706572616E6420616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function Instruction8BitOperand(name As String, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B6520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function InvokeInstruction(opcode As ObjoScript.VM.Opcodes, chunk As ObjoScript.Chunk, name As String, ByRef offset As Integer) As String
		  /// Returns the details of an invoke instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Prints the instruction's name, the constant's index in the pool, the method's signature and the argument count.
		  ///
		  /// Format:
		  /// INSTRUCTION  METHOD_NAME_INDEX  METHOD_NAME  ARGCOUNT
		  
		  Var index, argCount As Integer
		  Select Case opcode
		  Case VM.Opcodes.Invoke
		    index = chunk.ReadByte(offset + 1)
		    argCount = chunk.ReadByte(offset + 2)
		    offset = offset + 3
		    
		  Case VM.Opcodes.InvokeLong
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
		  Var methodName As String = ObjoScript.VM.StackValueToString(methodNameValue)
		  details = details + methodName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F662061206A756D7020696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function JumpInstruction(name As String, negative As Boolean, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620746865204F505F4C4F43414C5F5641525F44454320696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function LocalVarDec(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F662061206D6574686F6420696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function MethodInstruction(opcode As ObjoScript.VM.Opcodes, chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  Case VM.Opcodes.Method
		    constantIndex = chunk.ReadUInt16(offset + 1)
		    isStatic = If(chunk.ReadByte(offset + 3) = 1, True, False)
		    offset = offset + 4
		    name = "METHOD"
		    
		  Case VM.Opcodes.ForeignMethod
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
		  Var methodName As String = ObjoScript.VM.StackValueToString(methodNameValue)
		  details = details + methodName.JustifyLeft(COL_WIDTH * 2)
		  
		  // Append if this a static or instance method.
		  details = details + If(isStatic, "Static", "Instance")
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620612073696D706C6520696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function SimpleInstruction(instructionName As String, ByRef offset As Integer) As String
		  /// Returns the details of a simple instruction at `offset` and increments `offset` to point to the next instruction.
		  ///
		  /// Simple instructions are a single byte and take no operands.
		  /// Format:
		  /// INSTRUCTION_NAME
		  
		  offset = offset + 1
		  
		  Return instructionName.JustifyLeft(COL_WIDTH)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B652F73757065725F636F6E7374727563746F7220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function SuperConstructor(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  ObjoScript.VM.StackValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620616E20696E766F6B652F73757065725F696E766F6B652F73757065725F636F6E7374727563746F7220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function SuperInvoke(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  ObjoScript.VM.StackValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the signature name.
		  Var sig As String = _
		  ObjoScript.VM.StackValueToString(chunk.Constants(sigIndex))
		  details = details + sig.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the argument count.
		  details = details + argCount.ToString.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652064657461696C73206F6620612073757065725F73657474657220696E737472756374696F6E20617420606F66667365746020616E6420696E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function SuperSetter(chunk As ObjoScript.Chunk, ByRef offset As Integer) As String
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
		  ObjoScript.VM.StackValueToString(chunk.Constants(superNameIndex))
		  details = details + superclassName.JustifyLeft(2 * COL_WIDTH)
		  
		  // Append the signature name.
		  Var sig As String = _
		  ObjoScript.VM.StackValueToString(chunk.Constants(sigIndex))
		  details = details + sig.JustifyLeft(2 * COL_WIDTH)
		  
		  Return details
		  
		End Function
	#tag EndMethod


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
