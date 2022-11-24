#tag Class
Protected Class BareSuperInvocationExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitBareSuperInvocation(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(superKeyword As ObjoScript.Token, arguments() As ObjoScript.Expr, hasParentheses As Boolean)
		  mSuperKeyword = superKeyword
		  Self.Arguments = arguments
		  Self.HasParentheses = hasParentheses
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206073757065726020746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The `super` token itself.
		  
		  Return mSuperKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20617267756D656E747320746F207061737320746F20746865207375706572277320636F6E7374727563746F722E
		Arguments() As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E207468652060737570657260206B6579776F72642077617320666F6C6C6F77656420627920706172656E7468657365732E
		HasParentheses As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
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
