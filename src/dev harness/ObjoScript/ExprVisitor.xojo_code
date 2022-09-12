#tag Interface
Protected Interface ExprVisitor
	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061207661726961626C652061737369676E6D656E742E
		Function VisitAssignment(expr As ObjoScript.AssignmentExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612062696E6172792065787072657373696F6E2E
		Function VisitBinary(expr As ObjoScript.BinaryExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120626F6F6C65616E206C69746572616C2E
		Function VisitBoolean(expr As ObjoScript.BooleanLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206E6F7468696E67206C69746572616C2E
		Function VisitNothing(expr As ObjoScript.NothingLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206E756D626572206C69746572616C2E
		Function VisitNumber(expr As ObjoScript.NumberLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120706F73746669782065787072657373696F6E2E
		Function VisitPostfix(expr As ObjoScript.PostfixExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737472696E67206C69746572616C2E
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120756E6172792065787072657373696F6E2E
		Function VisitUnary(expr As ObjoScript.UnaryExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206E616D6564207661726961626C652E20546869732069732061206C6F6F6B7570206F7065726174696F6E2E
		Function VisitVariable(expr As ObjoScript.VariableExpr) As Variant
		  
		End Function
	#tag EndMethod


End Interface
#tag EndInterface
