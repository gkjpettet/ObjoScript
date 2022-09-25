#tag Class
Protected Class SuperParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120607375706572602065787072657373696F6E2E20417373756D6573207468652060737570657260746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a `super` expression.
		  /// Assumes the `super`token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var superKeyword As ObjoScript.Token = parser.Previous
		  
		  parser.Consume(ObjoScript.TokenTypes.Dot, "Expected a `.` after the `super` keyword.")
		  
		  // Get the method to invoke on `super`.
		  Var methodIdentifier As ObjoScript.Token = _
		  parser.Consume(ObjoScript.TokenTypes.Identifier, "Expected a method name after the dot.")
		  
		  // This may be a setter call so parse the value to assign if the precedence allows.
		  Var valueToAssign As ObjoScript.Expr = Nil
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    valueToAssign = parser.Expression
		  End If
		  
		  Return New ObjoScript.SuperExpr(superKeyword, methodIdentifier, valueToAssign)
		  
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
