#tag Class
Protected Class UnaryParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120756E617279206F70657261746F722E20417373756D657320746865206F70657261746F7220686173206A757374206265656E20636F6E73756D656420627920746865207061727365722E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a generic unary operator. 
		  /// Assumes the operator has just been consumed by the parser.
		  ///
		  /// Parses prefix unary "-", "~" and "Not" expressions.
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var token As ObjoScript.Token = parser.Previous
		  
		  // Parse the operand.
		  Var right As ObjoScript.Expr = parser.ParsePrecedence(ObjoScript.Precedences.Unary)
		  
		  Return New ObjoScript.UnaryExpr(token, right)
		  
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
