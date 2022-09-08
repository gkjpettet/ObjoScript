#tag Class
Protected Class BinaryParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0
		Sub Constructor(precedence As Integer, rightAssociative As Boolean = False)
		  mPrecedence = precedence
		  Self.RightAssociative = rightAssociative
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320612062696E617279206F70657261746F722E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D656420746865206F70657261746F7220746F6B656E2E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a binary operator.
		  /// Assumes the parser has just consumed the operator token.
		  ///
		  /// The only difference when parsing, "+", "-", "*", "/", and "^" is precedence and
		  /// associativity, so we can use a single parselet class for all of those.
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  Var operator As ObjoScript.Token = parser.Previous
		  
		  // To handle right-associative operators like "^", we allow a slightly
		  // lower precedence when parsing the right-hand side. This will let a
		  // parselet with the same precedence appear on the right, which will then
		  // take *this* parselet's result as its left-hand argument.
		  Var right As ObjoScript.Expr = _
		  parser.ParsePrecedence(If(RightAssociative, mPrecedence - 1, mPrecedence))
		  
		  Return New ObjoScript.BinaryExpr(left, operator, right)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mPrecedence As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5472756520696620746869732070617273656C65742069732072696768742D6173736F636961746976652C2046616C7365206966206974206973206C6566742D6173736F636961746976652E
		RightAssociative As Boolean = False
	#tag EndProperty


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
		#tag ViewProperty
			Name="RightAssociative"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
