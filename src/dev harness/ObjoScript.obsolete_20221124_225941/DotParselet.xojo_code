#tag Class
Protected Class DotParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 5061727365732074686520646F74206F70657261746F722E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses the dot operator.
		  /// Assumes the parser has just consumed the dot.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  // Get the name of the method to invoke.
		  Var identifier As ObjoScript.Token = parser.Consume(ObjoScript.TokenTypes.Identifier, "Expected a method name after the dot.")
		  
		  // This may be a setter call so parse the value to assign if the precedence allows.
		  // The value to assign becomes the argument.
		  Var arguments() As ObjoScript.Expr
		  Var isSetter As Boolean = False
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    isSetter = True
		    arguments.Add(parser.Expression)
		    
		  ElseIf parser.Match(ObjoScript.TokenTypes.LParen) Then
		    If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        arguments.Add(parser.Expression)
		      Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		    End If
		    parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the method call's arguments.")
		  End If
		  
		  Return New ObjoScript.MethodInvocationExpr(left, identifier, arguments, isSetter)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
