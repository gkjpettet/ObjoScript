#tag Interface
Protected Interface StmtVisitor
	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720616E2060617373657274602073746174656D656E742E
		Function VisitAssertStmt(stmt As ObjoScript.AssertStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120626C6F636B206F662073746174656D656E74732E
		Function VisitBlock(block As ObjoScript.BlockStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720616E2065787072657373696F6E2073746174656D656E742E
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612060666F7260206C6F6F702E
		Function VisitForStmt(stmt As ObjoScript.ForStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720616E20606966602073746174656D656E742E
		Function VisitIfStmt(ifstmt As ObjoScript.IfStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120607072696E74602073746174656D656E742E
		Function VisitPrintStmt(stmt As ObjoScript.PrintStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061207661726961626C65206465636C61726174696F6E2E
		Function VisitVarDeclaration(stmt As ObjoScript.VarDeclStmt) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120607768696C6560206C6F6F702E
		Function VisitWhileStmt(stmt As ObjoScript.WhileStmt) As Variant
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
