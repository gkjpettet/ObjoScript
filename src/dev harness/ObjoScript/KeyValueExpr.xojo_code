#tag Class
Protected Class KeyValueExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitKeyValue(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(colon As ObjoScript.Token, key As ObjoScript.Expr, value As ObjoScript.Expr)
		  mColon = colon
		  Self.Key = key
		  Self.Value = value
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520636F6C6F6E20746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The colon token.
		  
		  Return mColon
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206B65792E
		Key As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520636F6C6F6E20746F6B656E2E
		Private mColon As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652076616C75652E
		Value As ObjoScript.Expr
	#tag EndProperty


	#tag ViewBehavior
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
			Name="Name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
