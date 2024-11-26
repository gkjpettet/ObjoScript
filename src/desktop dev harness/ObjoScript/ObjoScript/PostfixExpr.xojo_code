#tag Class
Protected Class PostfixExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitPostfix(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 606F70657261746F726020697320746865206F70657261746F7220746F6B656E2028652E672E602B2B602920616E6420606F706572616E646020697320746865206C6566742068616E642065787072657373696F6E2E
		Sub Constructor(operand As ObjoScript.Expr, operator As ObjoScript.Token)
		  /// `operator` is the operator token (e.g.`++`) and `operand` is the left hand expression.
		  
		  mOperand = operand
		  mLocation = operator
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520706F7374666978206F70657261746F7220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The postfix operator token.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E672074686520756E617279206F70657261746F7220696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOperand As ObjoScript.Expr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F706572616E6420666F72207468697320706F7374666978206F7065726174696F6E2E
		#tag Getter
			Get
			  Return mOperand
			End Get
		#tag EndGetter
		Operand As ObjoScript.Expr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520706F7374666978206F70657261746F7220747970652E
		#tag Getter
			Get
			  Return mLocation.Type
			End Get
		#tag EndGetter
		Operator As ObjoScript.TokenTypes
	#tag EndComputedProperty


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
