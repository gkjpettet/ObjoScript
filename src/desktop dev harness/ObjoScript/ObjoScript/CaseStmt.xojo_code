#tag Class
Protected Class CaseStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitCaseStmt(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(values() As ObjoScript.Expr, body As ObjoScript.Stmt, caseKeyword As ObjoScript.Token)
		  Self.Values = values
		  Self.Body = body
		  mCaseKeyword = caseKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F662074686520606361736560206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `case` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mCaseKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F6479206F66207468697320636173652E
		Body As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520606361736560206B6579776F72642E
		Private mCaseKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652076616C75657320746F206576616C756174652E
		Values() As ObjoScript.Expr
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
