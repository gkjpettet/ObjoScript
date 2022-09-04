#tag Class
Protected Class NumberParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206E756D626572206C69746572616C2E20417373756D657320746865206E756D626572206C69746572616C20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser) As ObjoScript.Expr
		  /// Parses a number literal.
		  /// Assumes the number literal has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Return New ObjoScript.NumberExpr(parser.Previous)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
