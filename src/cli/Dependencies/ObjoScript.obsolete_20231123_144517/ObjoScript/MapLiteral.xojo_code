#tag Class
Protected Class MapLiteral
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitMapLiteral(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lcurly As ObjoScript.Token, keyValues() As ObjoScript.KeyValueExpr)
		  mLCurly = lcurly
		  Self.KeyValues = keyValues
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520607B6020746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The `{` token itself.
		  
		  Return mLCurly
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20696E697469616C206B65792D76616C7565732E
		KeyValues() As ObjoScript.KeyValueExpr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLCurly As ObjoScript.Token
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
