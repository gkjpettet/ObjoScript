#tag Class
Protected Class SwitchStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the StmtVisitor interface.
		  
		  Return visitor.VisitSwitchStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(consider As ObjoScript.Expr, cases() As ObjoScript.CaseStmt, elseCase As ObjoScript.ElseCaseStmt, switchKeyword As ObjoScript.Token)
		  Self.Consider = consider
		  Self.Cases = cases
		  Self.ElseCase = elseCase
		  mSwitchKeyword = switchKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F6620746865206073776974636860206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `switch` keyword.
		  
		  Return mSwitchKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2063617365732E
		Cases() As ObjoScript.CaseStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652060737769746368602076616C756520746F20636F6E73696465722E
		Consider As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C2060656C73656020636173652E204D6179206265204E696C2E
		ElseCase As ObjoScript.ElseCaseStmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520607377697463686020746F6B656E20696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mSwitchKeyword As ObjoScript.Token
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
