#tag Class
Protected Class SuperSetterExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitSuperSetter(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(superKeyword As ObjoScript.Token, methodIdentifier As ObjoScript.Token, valueToAssign As ObjoScript.Expr)
		  mSuperKeyword = superKeyword
		  Self.Identifier = methodIdentifier
		  Self.ValueToAssign = valueToAssign
		  mSignature = ObjoScript.Func.ComputeSignature(methodIdentifier.Lexeme, 1, True)
		  
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

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207369676E6174757265206F66207468652073657474657220746F20696E766F6B652E
		#tag Getter
			Get
			  Return mSignature
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652076616C756520746F2061737369676E2E
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
