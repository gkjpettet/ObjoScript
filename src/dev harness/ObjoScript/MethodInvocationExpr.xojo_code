#tag Class
Protected Class MethodInvocationExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitMethodInvocation(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(operand As ObjoScript.Expr, identifier As ObjoScript.Token, arguments() As ObjoScript.Expr)
		  Self.Operand = operand
		  Self.Arguments = arguments
		  mIdentifier = identifier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206964656E746966696572206F6620746865206D6574686F6420746F20696E766F6B652028692E652E20697473206E616D65292E
		Function Location() As ObjoScript.Token
		  /// The identifier of the method to invoke (i.e. its name).
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mIdentifier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520617267756D656E747320746F207061737320746F20746865206D6574686F642063616C6C2E204D617920626520656D7074792E
		Arguments() As ObjoScript.Expr
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865206D6574686F6420746F20696E766F6B652E
		#tag Getter
			Get
			  Return mIdentifier.Lexeme
			End Get
		#tag EndGetter
		MethodName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865206D6574686F64206964656E74696665722E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206F706572616E6420746865206D6574686F642062656C6F6E677320746F202873686F756C64206576616C7561746520746F20616E20696E7374616E6365206F7220636C617373292E
		Operand As ObjoScript.Expr
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
