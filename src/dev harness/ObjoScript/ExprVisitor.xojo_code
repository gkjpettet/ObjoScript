#tag Interface
Protected Interface ExprVisitor
	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061207661726961626C652061737369676E6D656E742E
		Function VisitAssignment(expr As ObjoScript.AssignmentExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206261726520696E766F636174696F6E2E20456974686572206120676C6F62616C2066756E6374696F6E2063616C6C206F722061206C6F63616C206D6574686F6420696E766F636174696F6E2E
		Function VisitBareInvocationExpr(bi As ObjoScript.BareInvocationExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120626172652063616C6C20746F20607375706572602028652E673A20607375706572286172674E2960206F722060737570657260292E
		Function VisitBareSuperInvocation(s As ObjoScript.BareSuperInvocationExpr) As Variant
		  
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

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612063616C6C2065787072657373696F6E2E
		Function VisitCall(expr As ObjoScript.CallExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120636C617373206964656E7469666965722E20546869732069732061206C6F6F6B7570206F7065726174696F6E2E
		Function VisitClass(c As ObjoScript.ClassExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206669656C642E20546869732069732061206C6F6F6B7570206F7065726174696F6E2E
		Function VisitField(expr As ObjoScript.FieldExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206669656C642061737369676E6D656E742E
		Function VisitFieldAssignment(expr As ObjoScript.FieldAssignmentExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720616E20606973602065787072657373696F6E2E
		Function VisitIs(expr As ObjoScript.IsExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206C697374206C69746572616C2C20652E673A205B312C20322C20335D2E
		Function VisitListLiteral(expr As ObjoScript.ListLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206C6F676963616C2065787072657373696F6E2E
		Function VisitLogical(logical As ObjoScript.LogicalExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061206D6574686F6420696E766F636174696F6E206F6E206120636C617373206F7220696E7374616E63652E
		Function VisitMethodInvocation(m As ObjoScript.MethodInvocationExpr) As Variant
		  
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

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612072616E6765206F70657261746F722065787072657373696F6E2E
		Function VisitRange(r As ObjoScript.RangeExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737461746963206669656C642E20546869732069732061206C6F6F6B7570206F7065726174696F6E2E
		Function VisitStaticField(expr As ObjoScript.StaticFieldExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737461746963206669656C642061737369676E6D656E742E
		Function VisitStaticFieldAssignment(expr As ObjoScript.StaticFieldAssignmentExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737472696E67206C69746572616C2E
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737562736372697074206D6574686F642C20652E673A20615B315D2E
		Function VisitSubscript(s As ObjoScript.Subscript) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120737562736372697074207365747465722C20652E673A20615B315D203D2076616C75652E
		Function VisitSubscriptSetter(s As ObjoScript.SubscriptSetter) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E6720612060737570657260206D6574686F6420696E766F636174696F6E2E
		Function VisitSuperMethodInvocation(s As ObjoScript.SuperMethodInvocationExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120736574746572206D6574686F64206F6E20607375706572602E
		Function VisitSuperSetter(s As ObjoScript.SuperSetterExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E672061207465726E61727920636F6E646974696F6E616C2065787072657373696F6E2E
		Function VisitTernary(t As ObjoScript.TernaryExpr) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652076697369746F72206973207669736974696E67206120607468697360206C6F6F6B75702E
		Function VisitThis(this As ObjoScript.ThisExpr) As Variant
		  
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
