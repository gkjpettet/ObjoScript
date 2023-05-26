#tag Class
Protected Class ForEachStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitForEachStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(foreachKeyword As ObjoScript.Token, loopCounter As ObjoScript.Token, rangeExpr As ObjoScript.Expr, body As ObjoScript.BlockStmt)
		  mForeachKeyword = foreachKeyword
		  Self.LoopCounter = loopCounter
		  Self.Range = rangeExpr
		  Self.Body = body
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468652060666F726561636860206B6579776F726420696E20746865206F726967696E616C20736F7572636520636F64652E
		Function Location() As ObjoScript.Token
		  /// The location of the `foreach` keyword in the original source code.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mForeachKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520626F6479206F662074686520666F72656163682073746174656D656E742E
		Body As ObjoScript.BlockStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F6F7020636F756E746572206964656E74696669657220746F6B656E2E
		LoopCounter As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForeachKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652072616E67652065787072657373696F6E2E
		Range As ObjoScript.Expr
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
