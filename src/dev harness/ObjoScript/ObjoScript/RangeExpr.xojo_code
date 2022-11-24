#tag Class
Protected Class RangeExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitRange(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lower As ObjoScript.Expr, operator As ObjoScript.Token, upper As ObjoScript.Expr)
		  Self.Lower = lower
		  mOperator = operator
		  Self.Upper = upper
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072616E6765206F70657261746F7220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mOperator
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320697320616E20696E636C75736976652072616E67652065787072657373696F6E20282E2E292E2046616C7365206966206578636C757369766520282E2E2E292E
		#tag Getter
			Get
			  Return mOperator.Type = ObjoScript.TokenTypes.DotDot
			  
			End Get
		#tag EndGetter
		Inclusive As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206C6F77657220626F756E6473206F66207468652072616E67652E
		Lower As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOperator As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652072616E676572206F70657261746F7220746F6B656E2E
		#tag Getter
			Get
			  Return mOperator
			End Get
		#tag EndGetter
		Operator As ObjoScript.Token
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520757070657220626F756E6473206F66207468652072616E67652E2057686574686572207468697320697320696E636C757369766520282E2E29206F72206578636C757369766520282E2E2E2920646570656E6473206F6E20746865206F70657261746F722E
		Upper As ObjoScript.Expr
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Inclusive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
