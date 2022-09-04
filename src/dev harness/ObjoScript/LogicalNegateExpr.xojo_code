#tag Class
Protected Class LogicalNegateExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0, Description = 606C6F636174696F6E602069732074686520604E6F746020746F6B656E20616E6420606F706572616E6460206973207468652072696768742068616E642065787072657373696F6E2E
		Sub Constructor(location As ObjoScript.Token, operand As ObjoScript.Expr)
		  /// `location` is the `Not` token and `operand` is the right hand expression.
		  
		  mLocation = location
		  mOperand = operand
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520756E617279206F70657261746F7220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The unary operator token.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E672074686520604E6F746020746F6B656E20696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOperand As ObjoScript.Expr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206F706572616E6420746F206265206C6F676963616C6C79206E6567617465642E
		#tag Getter
			Get
			  Return mOperand
			End Get
		#tag EndGetter
		Operand As ObjoScript.Expr
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520756E617279206F70657261746F7220747970652E
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
		#tag ViewProperty
			Name="Operator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ObjoScript.TokenTypes"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
