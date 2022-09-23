#tag Class
Protected Class FieldParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206669656C64206964656E7469666965722E204569746865722061206669656C6420616363657373206F722061206669656C642061737369676E6D656E742E20417373756D657320746865206669656C64206964656E74696669657220746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a field identifier. Either a field access or a field assignment.
		  /// Assumes the field identifier token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var identifier As ObjoScript.Token = parser.Previous
		  
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    // This is an assignment to the field named `identifier.Lexeme`.
		    Var expression As ObjoScript.Expr = parser.Expression
		    Return New FieldAssignmentExpr(identifier, expression)
		  Else
		    // This is the lookup of a field named `identifier.Lexeme`.
		    Return New FieldExpr(identifier)
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
