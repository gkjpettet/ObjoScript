#tag Class
Protected Class NothingLiteral
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitNothing(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(token As ObjoScript.Token)
		  mLocation = token
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E6F7468696E67206C69746572616C20746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The boolean literal token itself.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mLocation As ObjoScript.Token
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
