#tag Class
Protected Class ElseCaseStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitElseCaseStmt(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(body As ObjoScript.Stmt, elseKeyword As ObjoScript.Token)
		  Self.Body = body
		  mElseKeyword = elseKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468652060656C736560206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `else` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mElseKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F647920746F20657865637574652E
		Body As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060656C736560206B6579776F72642E
		Private mElseKeyword As ObjoScript.Token
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
