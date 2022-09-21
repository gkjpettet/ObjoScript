#tag Class
Protected Class ReturnStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitReturn(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(keyword As ObjoScript.Token, value As ObjoScript.Expr)
		  mReturnKeyword = keyword
		  Self.Value = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F6620746865206072657475726E60206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `return` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mReturnKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 546865206072657475726E60206B6579776F726420746F6B656E2E
		Private mReturnKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652072657475726E2076616C75652E
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
