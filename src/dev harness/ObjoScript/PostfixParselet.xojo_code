#tag Class
Protected Class PostfixParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 50617273657320706F737466697820756E61727920222B2B222065787072657373696F6E732E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses postfix unary "++" expressions.
		  /// Assumes the parser has just consumed the operator token.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  Return New PostfixExpr(left, parser.Previous)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
