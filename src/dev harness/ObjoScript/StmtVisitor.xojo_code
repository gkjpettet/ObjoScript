#tag Interface
Protected Interface StmtVisitor
	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720616E2065787072657373696F6E2073746174656D656E742E
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120607072696E74602073746174656D656E742E
		Function VisitPrintStmt(stmt As ObjoScript.PrintStmt) As Variant
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
