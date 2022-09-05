#tag Class
Protected Class UnaryParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120756E617279206F70657261746F722E20417373756D657320746865206F70657261746F7220686173206A757374206265656E20636F6E73756D656420627920746865207061727365722E
		Function Parse(parser As ObjoScript.Parser) As ObjoScript.Expr
		  /// Parses a generic unary operator. 
		  /// Assumes the operator has just been consumed by the parser.
		  ///
		  /// Parses prefix unary "-", "~" and "Not" expressions.
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var token As ObjoScript.Token = parser.Previous
		  
		  // Parse the operand.
		  Var right As ObjoScript.Expr = parser.ParsePrecedence(ObjoScript.Precedences.Unary)
		  
		  Return New ObjoScript.UnaryExpr(token, right)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
