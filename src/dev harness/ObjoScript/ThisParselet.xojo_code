#tag Class
Protected Class ThisParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 50617273657320607468697360202861206C6F6F6B7570206F662074686520696D706C6963697420607468697360207661726961626C65292E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652060746869736020746F6B656E2E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses `this` (a lookup of the implicit `this` variable).
		  /// Assumes the parser has just consumed the `this` token.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Return New ThisExpr(parser.Previous)
		  
		End Function
	#tag EndMethod


End Class
#tag EndClass
