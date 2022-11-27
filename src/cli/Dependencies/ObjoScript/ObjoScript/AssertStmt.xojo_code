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
		Sub Constructor(condition As ObjoScript.Expr, message As ObjoScript.Expr, location As ObjoScript.Token)
		  Self.Condition = condition
		  Self.Message = message
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


	#tag Property, Flags = &h0, Description = 54686520636F6E646974696F6E20746F2061737365727420697320547275652E
		Condition As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206D65737361676520746F20646973706C61792069662074686520636F6E646974696F6E2069732066616C73652E
		Message As ObjoScript.Expr
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
