#tag Class
Protected Class SuperConstructorExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitSuperConstructor(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(superKeyword As ObjoScript.Token, arguments() As ObjoScript.Expr)
		  mSuperKeyword = superKeyword
		  Self.Arguments = arguments
		  mSignature = ObjoScript.Func.ComputeSignature("constructor", arguments.Count, False)
		  
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

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520636F6E7374727563746F722773207369676E61747572652E
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
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
