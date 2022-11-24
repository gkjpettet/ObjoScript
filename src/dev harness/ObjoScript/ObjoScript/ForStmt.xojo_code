#tag Class
Protected Class ForStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitForStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(initialiser As ObjoScript.Stmt, condition As ObjoScript.Expr, increment As ObjoScript.Expr, body As ObjoScript.Stmt, forKeyword As ObjoScript.Token)
		  Self.Initialiser = initialiser
		  Self.Condition = condition
		  Self.Increment = increment
		  Self.Body = body
		  mForKeyword = forKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468652060666F7260206B6579776F726420696E20746865206F726967696E616C20736F7572636520636F64652E
		Function Location() As ObjoScript.Token
		  /// The location of the `for` keyword in the original source code.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mForKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F6479206F66207468652060666F7260206C6F6F702E
		Body As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206C6F6F7020636F6E646974696F6E2E204D6179206265204E696C2E
		Condition As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2065787072657373696F6E20746F206576616C756174652061742074686520656E64206F662065616368206C6F6F7020697465726174696F6E2E204D6179206265204E696C2E
		Increment As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C206C6F6F7020696E697469616C697365722E204D6179206265204E696C2E
		Initialiser As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060666F7260206B6579776F726420696E20746865206F726967696E616C20736F7572636520636F64652E
		Private mForKeyword As ObjoScript.Token
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
