#tag Class
Protected Class DotExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitDot(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(operand As ObjoScript.Expr, identifer As ObjoScript.Token, valueToAssign As ObjoScript.Expr)
		  Self.Operand = operand
		  Self.Identifier = identifer
		  Self.ValueToAssign = valueToAssign
		  mSignature = ObjoScript.Func.ComputeSignature(identifier.Lexeme, If(valueToAssign = Nil, 0, 1), If(valueToAssign = Nil, False, True))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206964656E74696669657220666F6C6C6F77696E672074686520646F742E
		Function Location() As ObjoScript.Token
		  /// The identifier following the dot.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return Identifier
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206964656E7469666965722061667465722074686520646F742E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320697320612073657474657220696E766F636174696F6E2E
		#tag Getter
			Get
			  Return ValueToAssign <> Nil
			  
			End Get
		#tag EndGetter
		IsSetter As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 4120707265636F6D7075746564207369676E617475726520666F72207468697320736574746572206F72206765747465722E
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F706572616E642074686520646F7420697320616374696E672075706F6E2E
		Operand As ObjoScript.Expr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207369676E61747572652E
		#tag Getter
			Get
			  Return mSignature
			  
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4966207468697320697320612073657474657220696E766F636174696F6E2C2074686973206973207468652076616C756520746F2061737369676E2E204D6179206265204E696C2E
		ValueToAssign As ObjoScript.Expr
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
		#tag ViewProperty
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
