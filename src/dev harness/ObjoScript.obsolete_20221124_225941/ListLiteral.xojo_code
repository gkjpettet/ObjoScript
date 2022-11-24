#tag Class
Protected Class ListLiteral
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitListLiteral(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lsquare As ObjoScript.Token, elements() As ObjoScript.Expr)
		  mLSquare = lsquare
		  Self.Elements = elements
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520605B6020746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The `[` token itself.
		  
		  Return mLSquare
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20696E697469616C20656C656D656E74732E
		Elements() As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLSquare As ObjoScript.Token
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
