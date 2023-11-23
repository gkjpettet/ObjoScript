#tag Class
Protected Class FieldParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h21, Description = 53796E7468657369736573206120636F6D706F756E642061737369676E6D656E742065787072657373696F6E2066726F6D20612073696E676C652065787072657373696F6E2E20417373756D657320606F70657261746F726020697320612076616C696420636F6D706F756E642061737369676E6D656E74206F70657261746F7220282B3D2C202D3D2C202A3D2C202F3D292E
		Private Function CompoundAssign(parser As ObjoScript.Parser, assignee As ObjoScript.Expr, expression As ObjoScript.Expr, operator As ObjoScript.Token, isStatic As Boolean) As ObjoScript.Expr
		  /// Synthesises a compound assignment expression from a single expression.
		  /// Assumes `operator` is a valid compound assignment operator (+=, -=, *=, /=).
		  ///
		  /// E.g: If the parser sees this statement:
		  ///
		  /// ```objo
		  /// assignee operator= expression
		  /// ```
		  ///
		  /// We need to synthesise this:
		  ///
		  /// ```objo
		  /// assignee = assignee operator expression
		  /// ```
		  ///
		  /// We return either a static or instance field assignment expression for the compiler.
		  
		  // Synthesise the correct binary operator token.
		  Var opType As ObjoScript.TokenTypes
		  Select Case operator.Type
		  Case ObjoScript.TokenTypes.PlusEqual
		    opType = ObjoScript.TokenTypes.Plus
		  Case ObjoScript.TokenTypes.MinusEqual
		    opType = ObjoScript.TokenTypes.Minus
		  Case ObjoScript.TokenTypes.StarEqual
		    opType = ObjoScript.TokenTypes.Star
		  Case ObjoScript.TokenTypes.ForwardSlashEqual
		    opType = ObjoScript.TokenTypes.ForwardSlash
		  Else
		    parser.Error("Unsupported field compound assignment operator: `" + operator.Type.ToString + "`.")
		  End Select
		  Var binOp As New ObjoScript.Token(opType, operator.StartPosition, operator.LineNumber, "", operator.ScriptID)
		  
		  // Synthesise the binary operation to assign to assignee.
		  Var bin As New ObjoScript.BinaryExpr(assignee, binOp, expression)
		  
		  // Return a new assignment expression.
		  If isStatic Then
		    Return New StaticFieldAssignmentExpr(assignee.Location, bin)
		  Else
		    Return New FieldAssignmentExpr(assignee.Location, bin)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5061727365732061206669656C64206964656E7469666965722E204569746865722061206669656C6420616363657373206F722061206669656C642061737369676E6D656E742E20417373756D657320746865206669656C64206964656E74696669657220746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a field identifier. Either a field access or a field assignment.
		  /// Assumes the field identifier token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var identifier As ObjoScript.Token = parser.Previous
		  Var isStatic As Boolean = If(identifier.Type = ObjoScript.TokenTypes.StaticFieldIdentifier, True, False)
		  
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    // This is an assignment to the field named `identifier.Lexeme`.
		    Var expression As ObjoScript.Expr = parser.Expression
		    If isStatic Then
		      Return New StaticFieldAssignmentExpr(identifier, expression)
		    Else
		      Return New FieldAssignmentExpr(identifier, expression)
		    End If
		    
		  ElseIf canAssign And _
		    parser.Match(ObjoScript.TokenTypes.PlusEqual, ObjoScript.TokenTypes.MinusEqual, _
		    ObjoScript.TokenTypes.StarEqual, ObjoScript.TokenTypes.ForwardSlashEqual) Then
		    Var operator As ObjoScript.Token = parser.Previous
		    // This is a compound assignment to the field named `identifier.Lexeme`.
		    Var expression As ObjoScript.Expr = parser.Expression
		    If isStatic Then
		      Return CompoundAssign(parser, New StaticFieldExpr(identifier), expression, operator, True)
		    Else
		      Return CompoundAssign(parser, New FieldExpr(identifier), expression, operator, False)
		    End If
		    
		  Else
		    // This is the lookup of a field named `identifier.Lexeme`.
		    If isStatic Then
		      Return New StaticFieldExpr(identifier)
		    Else
		      Return New FieldExpr(identifier)
		    End If
		  End If
		  
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
