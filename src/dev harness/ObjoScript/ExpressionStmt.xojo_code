#tag Class
Protected Class ExpressionStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Sub Constructor(expr As ObjoScript.Expr, location As ObjoScript.Token)
		  Self.Expression = Expression
		  mLocation = location
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 2054686520746F6B656E207468617420626567696E7320746869732073746174656D656E742E
		Function Location() As ObjoScript.Token
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Expression As ObjoScript.Expr
	#tag EndProperty

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
