#tag Class
Protected Class RangeParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 50617273657320612072616E6765206F70657261746F722E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652072616E6765206F70657261746F7220746F6B656E2E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a range operator.
		  /// Assumes the parser has just consumed the range operator token.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var operator As ObjoScript.Token = parser.Previous
		  
		  Var right As ObjoScript.Expr = parser.ParsePrecedence(Precedences.Range)
		  
		  Return New ObjoScript.RangeExpr(left, operator, right)
		  
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
