#tag Class
Protected Class ConditionalParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120636F6E646974696F6E616C2065787072657373696F6E2E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D65642074686520603F60206F70657261746F722E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a conditional expression.
		  /// Assumes the parser has just consumed the `if` operator.
		  ///
		  /// a if condition else b
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  /// The precedences used here are taken from the Wren compiler because Bob Nystrom is smarter than I am:
		  /// https://github.com/wren-lang/wren/blob/main/src/vm/wren_compiler.c
		  
		  #Pragma Unused canAssign
		  
		  Var ifKeyword As ObjoScript.Token = parser.Previous
		  
		  // Parse the "then" branch.
		  Var thenBranch As ObjoScript.Expr = parser.ParsePrecedence(Precedences.Conditional)
		  
		  parser.Consume(ObjoScript.TokenTypes.Colon, "Expected the `else` keyword after the 'then' expression of the conditional operator.")
		  
		  // Parse the "else" branch.
		  // I thought this should have an `assignment` precedence but during testing it would seem
		  // `lowest` is required. This *might* be wrong though...
		  Var elseBranch As ObjoScript.Expr = parser.ParsePrecedence(Precedences.Lowest)
		  
		  Return New TernaryExpr(left, thenBranch, elseBranch, ifKeyword)
		  
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
