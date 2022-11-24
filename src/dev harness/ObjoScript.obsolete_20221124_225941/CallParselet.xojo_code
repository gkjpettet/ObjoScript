#tag Class
Protected Class CallParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 50617273657320612063616C6C2065787072657373696F6E2E20417373756D657320607061727365726020686173206A75737420636F6E73756D656420746865206028602E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a call expression.
		  /// Assumes `parser` has just consumed the `(`.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var lparen As ObjoScript.Token = parser.Previous
		  
		  Var arguments() As ObjoScript.Expr
		  If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      arguments.Add(parser.Expression)
		    Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the call's arguments.")
		  
		  Return New CallExpr(left, arguments, lparen)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
