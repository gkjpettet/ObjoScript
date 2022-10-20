#tag Class
Protected Class SubscriptParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061207375627363726970742065787072657373696F6E2E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D65642074686520605B6020746F6B656E2E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a subscript expression.
		  /// Assumes the parser has just consumed the `[` token.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var lsquare As ObjoScript.Token = parser.Previous
		  
		  // Parse the index(es).
		  Var indexes() As ObjoScript.Expr
		  If Not parser.Check(ObjoScript.TokenTypes.RSquare) Then
		    Do
		      indexes.Add(parser.Expression)
		    Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  parser.Consume(ObjoScript.TokenTypes.RSquare, "Expected a `]` after the List's values.")
		  
		  // There must be at least one index.
		  If indexes.Count = 0 Then
		    parser.Error("At least one subscript index is required.")
		  End If
		  
		  // This may be a subscript setter so parse the value to assign if the precedence allows.
		  Var valueToAssign As ObjoScript.Expr = Nil
		  Var isSetter As Boolean = False
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    isSetter = True
		    valueToAssign = parser.Expression
		  End If
		  
		  If isSetter Then
		    Return New ObjoScript.SubscriptSetter(lsquare, left, indexes, valueToAssign)
		  Else
		    Return New ObjoScript.Subscript(lsquare, left, indexes)
		  End If
		  
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
