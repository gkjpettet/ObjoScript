#tag Class
Protected Class AssignmentExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitAssignment(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(identifier As ObjoScript.Token, value As ObjoScript.Expr)
		  mIdentifier = identifier
		  Self.Value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207661726961626C65206F72206669656C642773206964656E74696669657220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The variable or field's identifier token.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mIdentifier
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320697320616E2061737369676E6D656E7420746F2061206669656C642E
		#tag Getter
			Get
			  Return mIdentifier.Type = ObjoScript.TokenTypes.FieldIdentifier
			End Get
		#tag EndGetter
		IsField As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865207661726961626C65206F72206669656C642773206964656E74696669657220746F6B656E2E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865207661726961626C6520746F2061737369676E20746F2E
		#tag Getter
			Get
			  Return mIdentifier.Lexeme
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652065787072657373696F6E20746F2061737369676E20746F2074686973207661726961626C652E
		Value As ObjoScript.Expr
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
			Name="IsField"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
