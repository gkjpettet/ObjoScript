#tag Class
Protected Class AssertStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0, Description = 50617274206F66207468652053746D7456697369746F7220696E746572666163652E
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the StmtVisitor interface.
		  
		  Return visitor.VisitAssertStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(expression As ObjoScript.Expr, location As ObjoScript.Token)
		  Self.Expression = Expression
		  mLocation = location
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F6620746865206061737365727460206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `assert` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652065787072657373696F6E20746F2061737365727420697320547275652E
		Expression As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C6F636174696F6E206F6620746865206061737365727460206B6579776F72642E
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
