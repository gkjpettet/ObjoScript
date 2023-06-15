#tag Class
Protected Class DoStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitDoStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(condition As ObjoScript.Expr, body As ObjoScript.Stmt, doKeyword As ObjoScript.Token)
		  Self.Condition = condition
		  Self.Body = body
		  mDoKeyword = doKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652060646F60206B6579776F726420746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// The `do` keyword token.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mDoKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F6479206F6620746865206C6F6F702E
		Body As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F6F7020636F6E646974696F6E20746F206576616C756174652E
		Condition As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060646F60206B6579776F726420746F6B656E2E
		Private mDoKeyword As ObjoScript.Token
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
