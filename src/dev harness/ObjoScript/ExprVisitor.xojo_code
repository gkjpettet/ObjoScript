#tag Interface
Protected Interface ExprVisitor
	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612062696E6172792065787072657373696F6E2E
		Function VisitBinary(expr As ObjoScript.BinaryExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206E756D626572206C69746572616C2E
		Function VisitNumber(expr As ObjoScript.NumberExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120756E6172792065787072657373696F6E2E
		Function VisitUnary(expr As ObjoScript.UnaryExpr) As Variant
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
