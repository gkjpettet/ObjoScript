#tag Class
Protected Class SuperExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitSuper(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(superKeyword As ObjoScript.Token, methodIdentifier As ObjoScript.Token, valueToAssign As ObjoScript.Expr)
		  mSuperKeyword = superKeyword
		  Self.Identifier = methodIdentifier
		  Self.ValueToAssign = valueToAssign
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206073757065726020746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The `super` token itself.
		  
		  Return mSuperKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206964656E7469666965722061667465722074686520646F742E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320697320612073657474657220696E766F636174696F6E2E
		#tag Getter
			Get
			  Return ValueToAssign <> Nil
			  
			End Get
		#tag EndGetter
		IsSetter As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966207468697320697320612073657474657220696E766F636174696F6E2C2074686973206973207468652076616C756520746F2061737369676E2E204D6179206265204E696C2E
		ValueToAssign As ObjoScript.Expr
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
		#tag ViewProperty
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
