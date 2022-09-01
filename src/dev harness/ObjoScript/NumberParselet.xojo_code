#tag Class
Protected Class NumberParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206E756D626572206C69746572616C2E
		Function Parse(parser As ObjoScript.Parser, token As ObjoScript.Token) As ObjoScript.Expr
		  /// Parses a number literal.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Return New ObjoScript.NumberExpr(token)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
