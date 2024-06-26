#tag Class
Protected Class StringLiteral
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitString(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(token As ObjoScript.Token)
		  mLocation = token
		  Value = token.Lexeme
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520737472696E67206C69746572616C20746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The string literal token itself.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320737472696E6727732076616C75652E
		Value As String
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
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
