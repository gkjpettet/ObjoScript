#tag Class
Protected Class GroupParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732074686520706172656E746865736573207573656420746F2067726F757020616E2065787072657373696F6E2E
		Function Parse(parser As ObjoScript.Parser, token As ObjoScript.Token) As ObjoScript.Expr
		  /// Parses the parentheses used to group an expression.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var expression As ObjoScript.Expr = parser.Expression
		  
		  parser.Consume(ObjoScript.TokenTypes.RParen)
		  
		  Return expression
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
