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
		  Var valueToAssign As ObjoScript.Expr = Nil
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    valueToAssign = parser.Expression
		  End If
		  
		  Return New ObjoScript.DotExpr(left, identifier, valueToAssign)
		End Function
	#tag EndMethod


End Class
#tag EndClass
