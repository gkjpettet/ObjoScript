#tag Class
Protected Class Subscript
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitSubscript(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lsquare As ObjoScript.Token, operand As ObjoScript.Expr, indices() As ObjoScript.Expr)
		  mLSquare = lsquare
		  Self.Operand = operand
		  Self.Indices = indices
		  mSignature = ObjoScript.ComputeSubscriptSignature(indices.Count, False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520605B6020746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The `[` token itself.
		  
		  Return mLSquare
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520696E646963657320746F20746865207375627363726970742063616C6C2E20546865726520697320616C77617973206174206C65617374206F6E6520696E6465782E
		Indices() As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLSquare As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F706572616E6420746F2063616C6C20606F70657261746F725F73756273637269707460206F6E2E
		Operand As ObjoScript.Expr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207369676E6174757265206F662074686973207375627363726970742063616C6C2E
		#tag Getter
			Get
			  Return mSignature
			End Get
		#tag EndGetter
		Signature As String
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
			Name="Signature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
