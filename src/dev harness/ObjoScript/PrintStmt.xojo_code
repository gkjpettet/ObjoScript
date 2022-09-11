#tag Class
Protected Class PrintStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0, Description = 50617274206F66207468652053746D7456697369746F7220696E746572666163652E
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the StmtVisitor interface.
		  
		  Return visitor.VisitPrintStmt(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(expression As ObjoScript.Expr, location As ObjoScript.Token)
		  Self.Expression = Expression
		  mLocation = location
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Location() As ObjoScript.Token
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652065787072657373696F6E20746F207072696E742E
		Expression As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C6F636174696F6E206F662074686520607072696E7460206B6579776F72642E
		Private mLocation As ObjoScript.Token
	#tag EndProperty


End Class
#tag EndClass
