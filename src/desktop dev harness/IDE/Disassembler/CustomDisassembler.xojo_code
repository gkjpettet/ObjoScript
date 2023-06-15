#tag Class
Protected Class CustomDisassembler
Inherits ObjoScript.Disassembler
	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)), Description = 446973617373656D626C6573207468652062797465636F64652077697468696E20606368756E6B602C2072657475726E696E672069742061732061206054726565566965774E6F6465602E
		Protected Function BytecodeToNode(chunk As ObjoScript.Chunk, includeStandardLibraryBytecode As Boolean = True) As TreeViewNode
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

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)), Description = 52657475726E732060636F6E7374616E74602028776869636820697320617373756D656420746F20626520612076616C75652077697468696E20612066756E6374696F6E277320636F6E7374616E7420706F6F6C292061732061206054726565566965774E6F6465602E2060696E646578602069732074686520696E646578206F662074686520636F6E7374616E7420696E2074686520706F6F6C
		Protected Function ConstantToNode(index As Integer, constant As Variant) As TreeViewNode
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

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)), Description = 446973617373656D626C65732066756E6374696F6E2060666020746F2061206054726565566965774E6F64656020666F7220646973706C617920696E206120604465736B746F705472656556696577602E
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

	#tag Method, Flags = &h1, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)), Description = 52656164732074686520696E737472756374696F6E20617420606F6666736574602066726F6D20606368756E6B6020616E642072657475726E732069742061732061206054726565566965774E6F6465602E20496E6372656D656E747320606F66667365746020746F20706F696E7420746F20746865206E65787420696E737472756374696F6E2E
		Protected Function InstructionToNode(chunk As ObjoScript.Chunk, ByRef offset As Integer) As TreeViewNode
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
