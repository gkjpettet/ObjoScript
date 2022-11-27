#tag Class
Protected Class IfStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the StmtVisitor interface.
		  
		  Return visitor.VisitIfStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(condition As ObjoScript.Expr, thenBranch As ObjoScript.Stmt, elseBranch As ObjoScript.Stmt, ifKeyword As ObjoScript.Token)
		  Self.Condition = condition
		  Self.ThenBranch = thenBranch
		  Self.ElseBranch = elseBranch
		  mIfKeyword = ifKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Location() As ObjoScript.Token
		  /// The location of the `if` keyword.
		  
		  Return mIfKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206069666020636F6E646974696F6E20746F206576616C756174652E
		Condition As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2060656C736560206272616E63682073746174656D656E74732E204D6179206265204E696C2E
		ElseBranch As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206069666020746F6B656E20696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mIfKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652073746174656D656E7420286D61796265206120626C6F636B2920746F20657865637574652069662060436F6E646974696F6E60206576616C756174657320746F20547275652061742072756E74696D652E
		ThenBranch As ObjoScript.Stmt
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
