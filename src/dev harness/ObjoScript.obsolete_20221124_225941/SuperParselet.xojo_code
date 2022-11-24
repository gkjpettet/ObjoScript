#tag Class
Protected Class SuperParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 506172736573206120607375706572602065787072657373696F6E2E20417373756D657320746865206073757065726020746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a `super` expression.
		  /// Assumes the `super` token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  Var superKeyword As ObjoScript.Token = parser.Previous
		  
		  If parser.Match(ObjoScript.TokenTypes.LParen) Then
		    // A bare invocation on `super` (e.g: `super(argN)`).
		    Return ParseBareSuper(parser, superKeyword, True)
		    
		  ElseIf parser.Match(ObjoScript.TokenTypes.Dot) Then
		    // Must be a super method call (e.g: `super.something()` or `super.setter = something`).
		    Return ParseSuperMethodCall(parser, superKeyword, canAssign)
		    
		  Else
		    // `super` on its own.
		    Return ParseBareSuper(parser, superKeyword, False)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061206261726520696E766F636174696F6E206F6E20607375706572602E
		Private Function ParseBareSuper(parser As ObjoScript.Parser, superKeyword As ObjoScript.Token, consumedLParen As Boolean) As ObjoScript.Expr
		  /// Parses a bare invocation on `super`.
		  ///
		  /// E.g: super(argN) or `super`
		  
		  // Optional arguments.
		  Var arguments() As ObjoScript.Expr
		  If consumedLParen Then
		    If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        arguments.Add(parser.Expression)
		      Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		    End If
		    parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the super constructor's arguments.")
		  End If
		  
		  Return New ObjoScript.BareSuperInvocationExpr(superKeyword, arguments, consumedLParen)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061207375706572206D6574686F642063616C6C2E20417373756D65732074686520602E60206166746572206073757065726020686173206A757374206265656E20636F6E73756D65642E
		Private Function ParseSuperMethodCall(parser As ObjoScript.Parser, superKeyword As ObjoScript.Token, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a super method call.
		  /// Assumes the `.` after `super` has just been consumed.
		  ///
		  /// E.g: `super.identifier(argN)` or `super.identifier = something`
		  
		  // Get the method to invoke on `super`.
		  Var methodIdentifier As ObjoScript.Token = _
		  parser.Consume(ObjoScript.TokenTypes.Identifier, "Expected a method name after the dot.")
		  
		  // This may be a setter call so parse the value to assign if the precedence allows.
		  Var valueToAssign As ObjoScript.Expr = Nil
		  Var arguments() As ObjoScript.Expr
		  Var isMethodInvocation As Boolean = False
		  If canAssign And parser.Match(ObjoScript.TokenTypes.Equal) Then
		    valueToAssign = parser.Expression
		    
		  ElseIf parser.Match(ObjoScript.TokenTypes.LParen) Then
		    // This is an immediate method invocation on `super` since we're seeing: "super.identifier("
		    isMethodInvocation = True
		    If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        arguments.Add(parser.Expression)
		      Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		    End If
		    parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the method call's arguments.")
		    
		  Else
		    // This is an immediate method invocation on `super` with zero arguments: "super.identifier"
		    isMethodInvocation = True
		  End If
		  
		  If isMethodInvocation Then
		    Return New ObjoScript.SuperMethodInvocationExpr(superKeyword, methodIdentifier, arguments)
		  Else
		    Return New ObjoScript.SuperSetterExpr(superKeyword, methodIdentifier, valueToAssign)
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
