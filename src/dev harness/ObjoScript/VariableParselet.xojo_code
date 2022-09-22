#tag Class
Protected Class VariableParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061207661726961626C652F6669656C64206964656E7469666965722E204569746865722061207661726961626C652F6669656C6420616363657373206F722061207661726961626C652F6669656C642061737369676E6D656E742E20417373756D657320746865207661726961626C652F6669656C64206964656E74696669657220746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a variable/field identifier. Either a variable/field access or a variable/field assignment.
		  /// Assumes the variable/field identifier token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var identifier As ObjoScript.Token = parser.Previous
		  
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    // This is an assignment to the variable/field named `identifier.Lexeme`.
		    Var expression As ObjoScript.Expr = parser.Expression
		    Return New AssignmentExpr(identifier, expression)
		  Else
		    // This is the lookup of a variable/field named `identifier.Lexeme`.
		    Return New VariableExpr(identifier)
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
