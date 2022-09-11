#tag Class
Protected Class VM
	#tag Method, Flags = &h21, Description = 4173736572747320746861742060616020616E64206062602061726520626F746820646F75626C65732C206F74686572776973652072616973657320612072756E74696D65206572726F722E
		Private Sub AssertNumbers(a As Variant, b As Variant)
		  /// Asserts that `a` and `b` are both doubles, otherwise raises a runtime error.
		  
		  If a.Type <> Variant.TypeDouble Or b.Type <> Variant.TypeDouble Then
		    Error("Both operands must be numbers.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52616973657320612072756E74696D65206572726F722069662060616020616E642060626020617265206E6F74207468652073616D6520747970652E
		Private Sub AssertSameType(a As Variant, b As Variant)
		  /// Raises a runtime error if `a` and `b` are not the same type.
		  ///
		  /// Assumes neither `a` or `b` are Nil.
		  
		  If a.Type <> b.Type Then
		    Error("Both operands must be the same type.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Disassembler = New ObjoScript.Disassembler
		  AddHandler Disassembler.Print, AddressOf DisassemblerPrintDelegate
		  AddHandler Disassembler.PrintLine, AddressOf DisassemblerPrintLineDelegate
		  
		  Reset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E74282960206576656E742E
		Private Sub DisassemblerPrintDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `Print()` event.
		  ///
		  /// We will add `s` to our disassembler output buffer until the disassembler raises its `PrintLine()` event.
		  
		  #If DebugBuild
		    DisassemblerOutput.Add(s)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E744C696E65282960206576656E742E
		Private Sub DisassemblerPrintLineDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `PrintLine()` event.
		  ///
		  /// Dump the contents of the disassembler's buffer and `s` to the debug log.
		  
		  #If DebugBuild
		    DisassemblerOutput.Add(s)
		    System.DebugLog(String.FromArray(DisassemblerOutput))
		    DisassemblerOutput.ResizeTo(-1)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526169736573206120564D457863657074696F6E206174207468652063757272656E742049502028756E6C657373206F746865727769736520737065636966696564292E
		Private Sub Error(message As String, offset As Integer = -1)
		  /// Raises a VMException at the current IP (unless otherwise specified).
		  
		  // Default to the current IP if no offset is provided.
		  offset = If(offset = -1, IP, offset)
		  
		  Raise New ObjoScript.VMException(message, Chunk.LineForOffset(offset), Chunk.ScriptIDForOffset(offset))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Interpret(chunk As ObjoScript.Chunk)
		  Self.Chunk = chunk
		  Self.IP = 0
		  Run
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060766020697320636F6E73696465726564202266616C736579222E
		Private Function IsFalsey(v As Variant) As Boolean
		  /// Returns True if `v` is considered "falsey".
		  ///
		  /// Objo considers the boolean value `false` and the Objo value `nothing` to
		  /// be False, everything else is True.
		  
		  Return (v.Type = Variant.TypeBoolean And v = False) Or v IsA ObjoScript.Nothing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652076616C7565206064697374616E6365602066726F6D2074686520746F70206F662074686520737461636B2E204C6561766573207468652076616C7565206F6E2074686520737461636B2E20412076616C7565206F662060306020776F756C642072657475726E2074686520746F70206974656D2E
		Private Function Peek(distance As Integer) As Variant
		  /// Returns the value `distance` from the top of the stack. Leaves the value on the stack. A value of `0` would return the top item.
		  
		  Return Stack(StackTop - distance - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506F707320612076616C7565206F6666206F662074686520737461636B2E
		Private Function Pop() As Variant
		  /// Pops a value off of the stack.
		  
		  StackTop = StackTop - 1
		  Return Stack(StackTop)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50757368657320612076616C7565206F6E746F2074686520737461636B2E
		Private Sub Push(value As Variant)
		  /// Pushes a value onto the stack.
		  
		  Stack(StackTop) = value
		  StackTop = StackTop + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526561647320746865206279746520696E20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E732069742E20496E6372656D656E7473207468652049502E
		Private Function ReadByte() As UInt8
		  /// Reads the byte in `Chunk` at the current `IP` and returns it. Increments the IP.
		  
		  IP = IP + 1
		  Return Chunk.ReadByte(IP - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E6720612073696E676C652062797465206F706572616E642E20496E6372656D656E74732049502E
		Private Function ReadConstant() As Variant
		  /// Reads a constant from the chunk's constant pool using a single byte operand. Increments IP.
		  
		  // The bytecode at `IP` gives us the index in the constant pool.
		  
		  Return Chunk.Constants(ReadByte)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E672074776F2062797465206F706572616E64732E20496E6372656D656E74732049502E
		Private Function ReadConstantLong() As Variant
		  /// Reads a constant from the chunk's constant pool using two byte operands. Increments IP.
		  
		  // The bytecode at `IP` gives us the index in the constant pool.
		  
		  Return Chunk.Constants(ReadUInt16)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656164732074776F2062797465732066726F6D20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E73207468656D20617320612055496E7431362E20496E6372656D656E74732074686520495020627920322E
		Private Function ReadUInt16() As UInt16
		  /// Reads two bytes from `Chunk` at the current `IP` and returns them as a UInt16. Increments the IP by 2.
		  
		  IP = IP + 2
		  Return Chunk.ReadUInt16(IP - 2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520564D2E
		Sub Reset()
		  /// Resets the VM.
		  
		  StackTop = 0
		  Nothing = New ObjoScript.Nothing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Run()
		  While True
		    // Disassemble each instruction if requested.
		    #If DebugBuild And TRACE_EXECUTION
		      Var s() As String
		      For i As Integer = 0 To StackTop - 1
		        Var item As Variant = Stack(i)
		        If item IsA ObjoScript.Value Then
		          s.Add("[ " + ObjoScript.Value(item).ToString + " ]")
		        Else
		          s.Add("[ " + item.StringValue + " ]")
		        End If
		      Next i
		      System.DebugLog(String.FromArray(s, ""))
		      Call Disassembler.DisassembleInstruction(-1, -1, Chunk, IP)
		    #EndIf
		    
		    Select Case ReadByte
		    Case OP_RETURN
		      Var top As Variant = Pop
		      If top IsA ObjoScript.Value Then
		        System.DebugLog(ObjoScript.Value(top).ToString)
		      Else
		        System.DebugLog(top.StringValue)
		      End If
		      Return
		      
		    Case OP_CONSTANT
		      Var constant As Variant = ReadConstant
		      Push(constant)
		      
		    Case OP_CONSTANT_LONG
		      Var constant As Variant = ReadConstantLong
		      Push(constant)
		      
		    Case OP_LOAD_0
		      Push(CType(0, Double))
		      
		    Case OP_LOAD_1
		      Push(CType(1, Double))
		      
		    Case OP_LOAD_MINUS1
		      Push(CType(-1, Double))
		      
		    Case OP_NEGATE
		      If Peek(0).Type <> Variant.TypeDouble Then
		        Error("Operand must be a number.")
		      End If
		      // In this instruction, the answer replaces what's currently at the top of the stack.
		      // Rather than pop, negate then push we'll do it in situ as it's ~6x faster.
		      Stack(StackTop - 1) = -Stack(StackTop - 1).DoubleValue
		      
		    Case OP_ADD
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      If a.Type = Variant.TypeDouble And b.Type = Variant.TypeDouble Then
		        // Both numbers.
		        Push(a.DoubleValue + b.DoubleValue)
		      ElseIf a.Type = Variant.TypeString And b.Type = Variant.TypeString Then
		        // Both strings.
		        Push(a.StringValue + b.StringValue)
		      ElseIf a.Type = Variant.TypeString Or b.Type = Variant.TypeString Then
		        // One of the operands is a string.
		        Push(ValueToString(a) + ValueToString(b))
		      Else
		        Error("Both operands must be numbers or at least one operand must be a string.")
		      End If
		      
		    Case OP_SUBTRACT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue - b.DoubleValue)
		      
		    Case OP_DIVIDE
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue / b.DoubleValue)
		      
		    Case OP_MULTIPLY
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue * b.DoubleValue)
		      
		    Case OP_MODULO
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue Mod b.DoubleValue)
		      
		    Case OP_NOT
		      // Since unary operators don't change the stack and operate on the top of the stack, we'll 
		      // simply do the operation in situ as it's faster than pop-pushing.
		      Stack(StackTop - 1) = IsFalsey(Stack(StackTop - 1))
		      
		    Case OP_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      Push(ValuesEqual(a, b))
		      
		    Case OP_NOT_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      Push(Not ValuesEqual(a, b))
		      
		    Case OP_GREATER
		      Var b As Variant
		      Var a As Variant
		      AssertNumbers(a, b)
		      Push(a > b)
		      
		    Case OP_GREATER_EQUAL
		      Var b As Variant
		      Var a As Variant
		      AssertNumbers(a, b)
		      Push(a >= b)
		      
		    Case OP_LESS
		      Var b As Variant
		      Var a As Variant
		      AssertNumbers(a, b)
		      Push(a < b)
		      
		    Case OP_LESS_EQUAL
		      Var b As Variant
		      Var a As Variant
		      AssertNumbers(a, b)
		      Push(a <= b)
		      
		    Case OP_TRUE
		      Push(True)
		      
		    Case OP_FALSE
		      Push(False)
		      
		    Case OP_NOTHING
		      Push(Nothing)
		      
		    Case OP_POP
		      Call Pop
		      
		    Case OP_SHIFT_LEFT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Bitwise.ShiftLeft(a.IntegerValue, b.IntegerValue))
		      
		    Case OP_SHIFT_RIGHT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Bitwise.ShiftRight(a.IntegerValue, b.IntegerValue))
		      
		    Case OP_BITWISE_AND
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(a.IntegerValue And b.IntegerValue)
		      
		    Case OP_BITWISE_OR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(a.IntegerValue Or b.IntegerValue)
		      
		    Case OP_BITWISE_XOR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(a.IntegerValue Xor b.IntegerValue)
		      
		    Case OP_PRINT
		      // Pop the top value off the stack and print it via the VM's `Print` event.
		      RaiseEvent Print(ValueToString(Pop))
		      
		    End Select
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662076616C7565732060616020616E64206062602061726520636F6E7369646572656420657175616C2062792074686520564D2E
		Private Function ValuesEqual(a As Variant, b As Variant) As Boolean
		  /// True if values `a` and `b` are considered equal by the VM.
		  ///
		  /// Assumes neither `a` or `b` are Nil.
		  
		  #Pragma Warning "TODO: Handle objects"
		  
		  If a.Type <> b.Type Then Return False
		  
		  Select Case a.Type
		  Case Variant.TypeDouble, Variant.TypeBoolean
		    Return a = b
		    
		  Case Variant.TypeString
		    If STRING_COMPARISON_RESPECTS_CASE Then
		      // Case sensitive comparison.
		      Return a.StringValue.Compare(b.StringValue, ComparisonOptions.CaseSensitive) = 0
		    Else
		      // Case insensitive comparison.
		      Return a = b
		    End If
		  Else
		    If a IsA ObjoScript.Nothing And b IsA ObjoScript.Nothing Then
		      Return True
		    End If
		    
		    Error("Unexpected value type.")
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206120564D2076616C75652E
		Private Function ValueToString(v As Variant) As String
		  /// Returns a string representation of a VM value.
		  
		  #Pragma Warning "TODO: Support instances"
		  
		  Select Case v.Type
		  Case Variant.TypeString, Variant.TypeDouble, Variant.TypeBoolean
		    Return v.StringValue
		    
		  Else
		    If v IsA ObjoScript.Nothing Then
		      Return "Nothing"
		      
		    Else
		      Error("Unable to create a string representation of the value.")
		    End If
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 6073602069732074686520726573756C74206F66206576616C756174696E67206120607072696E74602065787072657373696F6E2E
		Event Print(s As String)
	#tag EndHook


	#tag Property, Flags = &h0, Description = 546865206368756E6B206F6620636F6465207468697320564D2069732063757272656E746C7920696E74657270726574696E672E
		Chunk As ObjoScript.Chunk
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Disassembler As ObjoScript.Disassembler
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520737472696E6773207061737365642062792074686520646973617373656D626C6572277320605072696E74282960206576656E742061726520616464656420746F2074686973206275666665722E204974277320636C6561726564207768656E2074686520646973617373656D626C6572207261697365732069747320605072696E744C696E65282960206576656E742E
		Private DisassemblerOutput() As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E737472756374696F6E20706F696E7465722E2054686520696E64657820696E20746865206368756E6B27732060436F646560206172726179206F662074686520696E737472756374696F6E202A61626F757420746F2062652065786563757465642A2E
		IP As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53696E676C65746F6E20696E7374616E6365206F6620224E6F7468696E67222E
		Private Nothing As ObjoScript.Nothing
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520564D277320737461636B2E
		Private Stack(VM.STACK_MAX) As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506F696E747320746F2074686520696E64657820696E2060537461636B60206A757374202A706173742A2074686520656C656D656E7420636F6E7461696E696E672074686520746F702076616C75652E205468657265666F726520603060206D65616E732074686520737461636B20697320656D7074792E20497427732074686520696E64657820746865206E6578742076616C75652077696C6C2062652070757368656420746F2E
		Private StackTop As Integer = 0
	#tag EndProperty


	#tag Constant, Name = OP_ADD, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_AND, Type = Double, Dynamic = False, Default = \"22", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_OR, Type = Double, Dynamic = False, Default = \"23", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_XOR, Type = Double, Dynamic = False, Default = \"24", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CONSTANT, Type = Double, Dynamic = False, Default = \"1", Scope = Public, Description = 5468652061646420636F6E7374616E74206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_CONSTANT_LONG, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 5468652061646420636F6E7374616E74202831362D62697429206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_DIVIDE, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_EQUAL, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_FALSE, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GREATER, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GREATER_EQUAL, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LESS, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LESS_EQUAL, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_0, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_1, Type = Double, Dynamic = False, Default = \"25", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_MINUS1, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_MODULO, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_MULTIPLY, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NEGATE, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOT, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOTHING, Type = Double, Dynamic = False, Default = \"18", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOT_EQUAL, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_POP, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_PRINT, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_RETURN, Type = Double, Dynamic = False, Default = \"0", Scope = Public, Description = 5468652072657475726E206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_SHIFT_LEFT, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SHIFT_RIGHT, Type = Double, Dynamic = False, Default = \"21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUBTRACT, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_TRUE, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = STACK_MAX, Type = Double, Dynamic = False, Default = \"255", Scope = Public, Description = 54686520757070657220626F756E6473206F662074686520737461636B2E
	#tag EndConstant

	#tag Constant, Name = STRING_COMPARISON_RESPECTS_CASE, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public, Description = 54686520636173652073656E7369746976697479206F6620737472696E6720636F6D70617269736F6E73207768656E207573696E672074686520603D3D60206F70657261746F722E
	#tag EndConstant

	#tag Constant, Name = TRACE_EXECUTION, Type = Boolean, Dynamic = False, Default = \"True", Scope = Public, Description = 496620547275652028616E6420746869732069732061206465627567206275696C6429207468656E2074686520564D2077696C6C206F757470757420646562756720696E666F726D6174696F6E20746F207468652073797374656D206465627567206C6F672E204E6F2065666665637420696E20636F6D70696C656420617070732E
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
			Name="IP"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
