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
		    // Must be a call to the super's constructor (e.g: `super(argN)`).
		    Return ParseSuperConstructor(parser, superKeyword)
		  Else
		    // Must be a super method call (e.g: `super.something()` or `super.setter = something`).
		    parser.Consume(ObjoScript.TokenTypes.Dot, "Expected a `.` after the `super` keyword.")
		    Return ParseSuperMethodCall(parser, superKeyword, canAssign)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612063616C6C20746F2061207375706572636C6173736020636F6E7374727563746F722E20417373756D65732074686520602860206166746572206073757065726020686173206A757374206265656E20636F6E73756D65642E
		Private Function ParseSuperConstructor(parser As ObjoScript.Parser, superKeyword As ObjoScript.Token) As ObjoScript.Expr
		  /// Parses a call to a superclass` constructor.
		  /// Assumes the `(` after `super` has just been consumed.
		  ///
		  /// E.g: super(argN)
		  
		  // Optional arguments.
		  Var arguments() As ObjoScript.Expr
		  If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		    Do
		      arguments.Add(parser.Expression)
		    Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		  End If
		  parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the super constructor's arguments.")
		  
		  Return New ObjoScript.SuperConstructorExpr(superKeyword, arguments)
		  
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
		    isMethodInvocation = True
		    // Assume this is an immediate method invocation on `super` since we're seeing: "super.identifier("
		    // This provides a runtime performance boost for `super` getters.
		    If Not parser.Check(ObjoScript.TokenTypes.RParen) Then
		      Do
		        arguments.Add(parser.Expression)
		      Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		    End If
		    parser.Consume(ObjoScript.TokenTypes.RParen, "Expected a `)` after the method call's arguments.")
		  End If
		  
		  If isMethodInvocation Then
		    Return New ObjoScript.SuperMethodInvocationExpr(superKeyword, methodIdentifier, arguments)
		  Else
		    Return New ObjoScript.SuperExpr(superKeyword, methodIdentifier, valueToAssign)
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
