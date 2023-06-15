#tag Class
Protected Class TernaryExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitTernary(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(condition As ObjoScript.Expr, thenBranch As ObjoScript.Expr, elseBranch As ObjoScript.Expr, ifKeyword As ObjoScript.Token)
		  Self.Condition = condition
		  Self.ThenBranch = thenBranch
		  Self.ElseBranch = elseBranch
		  mIfKeyword = ifKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206069666020746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The `if` token.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mIfKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6E646974696F6E20746F206576616C756174652E
		Condition As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652065787072657373696F6E20746F206576616C756174652069662060436F6E646974696F6E60206576616C756174657320746F2066616C73652E
		ElseBranch As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIfKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0
		ThenBranch As ObjoScript.Expr
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
	#tag EndViewBehavior
End Class
#tag EndClass
