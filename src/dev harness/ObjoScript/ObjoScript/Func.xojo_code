#tag Class
Protected Class Func
Implements ObjoScript.Value,ObjoScript.Method
	#tag Method, Flags = &h0, Description = 52657475726E7320746865206172697479206F662061206D6574686F64207769746820607369676E6174757265602E
		Shared Function ComputeArityFromSignature(signature As String, vm As ObjoScript.VM) As Integer
		  /// Returns the arity of a method with `signature`.
		  
		  // Handle common cases quickly.
		  If signature.Contains("()") Then
		    Return 0
		    
		  ElseIf signature.Contains("(_)") Then
		    Return 1
		    
		  ElseIf signature.Contains("(_,_)") Then
		    Return 2
		  End If
		  
		  Var chars() As String = signature.Split("")
		  Var lparenIndex, rparenIndex As Integer = -1
		  For i As Integer = 0 To chars.LastIndex
		    Select Case chars(i)
		    Case "("
		      If lparenIndex <> -1 Then
		        // We've already seen a `(`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      Else
		        lparenIndex = i
		      End If
		      
		    Case ")"
		      If rparenIndex <> -1 Then
		        // We've already seen a `)`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      ElseIf lparenIndex = -1 Then
		        // We've found a `)` before a `(`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      Else
		        rparenIndex = i
		      End If
		    End Select
		  Next i
		  
		  If lparenIndex = -1 Or rparenIndex = -1 Then
		    vm.Error("Invalid signature: `" + signature + "`.")
		  End If
		  
		  // Get the contents between the parentheses (e.g. "(_,_,_)" becomes "_,_,_")
		  Var contents As String = signature.Middle(lparenIndex + 1, rparenIndex - lparenIndex - 1)
		  
		  If contents.Contains("_") Then
		    Return contents.Split("_").Count - 1
		  Else
		    Return 0
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574657320612066756E6374696F6E2F6D6574686F64207369676E617475726520676976656E20697473206E616D6520616E642061726974792E
		Shared Function ComputeSignature(name As String, arity As Integer, isSetter As Boolean) As String
		  /// Computes a function/method signature given its name and arity.
		  
		  If isSetter And arity <> 1 Then
		    Raise New InvalidArgumentException("Setters must have exactly one parameter.")
		  End If
		  
		  If arity = 0 Then Return name + "()"
		  
		  Var sig As String = name + If(isSetter, "=", "") + "("
		  
		  For i As Integer = 1 To arity
		    sig = sig + "_"
		    If i < arity Then sig = sig + ","
		  Next i
		  
		  Return sig + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D7075746573206120737562736372697074207369676E617475726520676976656E206974732061726974792E
		Shared Function ComputeSubscriptSignature(arity As Integer, isSetter As Boolean) As String
		  /// Computes a subscript signature given its arity.
		  ///
		  /// If this is a subscript setter then the arity is one greater than the 
		  /// index count (since the last parameter is the value to assign).
		  /// Examples:
		  /// ```
		  /// [index, indexN]
		  /// [index, indexN]=(value)
		  /// ```
		  
		  If isSetter And arity < 2 Then
		    Raise New InvalidArgumentException("Subscript setters must have at least two parameters.")
		  End If
		  
		  Var sig As String = "["
		  
		  Var paramCount As Integer = If(isSetter, arity - 1, arity)
		  
		  For i As Integer = 1 To paramCount
		    sig = sig + "_"
		    If i < paramCount Then sig = sig + ","
		  Next i
		  
		  sig = sig + "]"
		  
		  If isSetter Then
		    sig = sig + "=(_)"
		  End If
		  
		  Return sig
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(name As String, parameterTokens() As ObjoScript.Token, isSetter As Boolean, debugMode As Boolean)
		  Self.Name = name
		  
		  For Each paramToken As ObjoScript.Token In parameterTokens
		    Self.Parameters.Add(paramToken.Lexeme)
		  Next paramToken
		  Self.Arity = parameters.Count
		  
		  Self.Chunk = New ObjoScript.Chunk(debugMode)
		  Self.IsSetter = isSetter
		  mSignature = ComputeSignature(name, arity, isSetter)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732066756E6374696F6E2773207369676E61747572652E
		Function Signature() As String
		  /// This function's signature.
		  ///
		  /// Part of the ObjoScript.Method interface.
		  
		  Return mSignature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  /// Returns a string representation of this function.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mSignature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Func
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E747320746869732066756E6374696F6E2072657175697265732E
		Arity As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206368756E6B206F662062797465636F64652E
		Chunk As ObjoScript.Chunk
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973206973206120736574746572206D6574686F642E20536574746572732063616E20626520696E766F6B656420696D6D6564696174656C79206265666F726520616E20603D60207369676E2E
		IsSetter As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206E616D652E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F6620746869732066756E6374696F6E277320706172616D65746572732028696E206F72646572292E204D617920626520656D7074792E
		Parameters() As String
	#tag EndProperty


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
			Name="Arity"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
