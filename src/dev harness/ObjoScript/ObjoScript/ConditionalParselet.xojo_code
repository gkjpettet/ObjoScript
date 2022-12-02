#tag Class
Protected Class ConditionalParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120636F6E646974696F6E616C2065787072657373696F6E2E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652060696660206F70657261746F722E
		Function Parse(parser As ObjoScript.Parser, thenBranch As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a conditional expression.
		  /// Assumes the parser has just consumed the `if` operator.
		  ///
		  /// thenBranch if condition else elseBranch
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  /// The precedences used here are taken from the Wren compiler because Bob Nystrom is smarter than I am:
		  /// https://github.com/wren-lang/wren/blob/main/src/vm/wren_compiler.c
		  
		  #Pragma Unused canAssign
		  
		  Var ifKeyword As ObjoScript.Token = parser.Previous
		  
		  // Parse the condition branch.
		  Var condition As ObjoScript.Expr = parser.ParsePrecedence(Precedences.Conditional)
		  
		  parser.Consume(ObjoScript.TokenTypes.Else_, "Expected the `else` keyword after the condition.")
		  
		  // Parse the "else" branch.
		  // I thought this should have an `assignment` precedence but during testing it would seem
		  // `lowest` is required. This *might* be wrong though...
		  Var elseBranch As ObjoScript.Expr = parser.ParsePrecedence(Precedences.Lowest)
		  
		  Return New TernaryExpr(condition, thenBranch, elseBranch, ifKeyword)
		  
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
