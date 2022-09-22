#tag Class
Protected Class VariableExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitVariable(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(identifier As ObjoScript.Token)
		  mIdentifier = identifier
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865207661726961626C65206F72206669656C64206964656E74696669657220746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The variable or field identifier token itself.
		  
		  Return mIdentifier
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746869732069732061206669656C64206C6F6F6B75702E
		#tag Getter
			Get
			  Return mIdentifier.Type = ObjoScript.TokenTypes.FieldIdentifier
			  
			End Get
		#tag EndGetter
		IsField As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865207661726961626C65206F72206669656C64206964656E74696669657220746F6B656E20697473656C662E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207661726961626C652773206E616D652E
		#tag Getter
			Get
			  Return mIdentifier.Lexeme
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty


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
