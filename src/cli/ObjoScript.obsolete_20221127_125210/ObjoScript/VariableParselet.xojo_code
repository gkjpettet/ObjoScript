#tag Class
Protected Class VariableParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061207661726961626C65206964656E7469666965722E20417373756D657320746865207661726961626C652773206964656E74696669657220746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a variable identifier.
		  /// Assumes the variable's identifier token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var identifier As ObjoScript.Token = parser.Previous
		  
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    // This is an assignment to the variable named `identifier.Lexeme`.
		    Var expression As ObjoScript.Expr = parser.Expression
		    Return New AssignmentExpr(identifier, expression)
		    
		  ElseIf parser.Match(ObjoScript.TokenTypes.LParen) Then
		    // Must be either a global function or local method invocation on `this` since we're seeing `identifier()`.
		    Var arguments() As ObjoScript.Expr
		    If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        arguments.Add(parser.Expression)
		      Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		    End If
		    parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the method call's arguments.")
		    Return New ObjoScript.BareInvocationExpr(identifier, arguments)
		  Else
		    // This is the lookup of a variable named `identifier.Lexeme` or a call to a method with no arguments.
		    Return New ObjoScript.VariableExpr(identifier)
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
