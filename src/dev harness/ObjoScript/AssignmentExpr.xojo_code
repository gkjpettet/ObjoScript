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
		  mLocation = identifier
		  Self.Value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207661726961626C652773206964656E74696669657220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The variable's identifier token.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865207661726961626C652773206964656E74696669657220746F6B656E2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865207661726961626C6520746F2061737369676E20746F2E
		#tag Getter
			Get
			  Return mLocation.Lexeme
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
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
