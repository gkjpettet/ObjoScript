#tag Class
Protected Class SuperMethodInvocationExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitSuperMethodInvocation(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(superKeyword As ObjoScript.Token, methodIdentifier As ObjoScript.Token, arguments() As ObjoScript.Expr)
		  mSuperKeyword = superKeyword
		  Self.Arguments = arguments
		  mIdentifier = methodIdentifier
		  mSignature = ObjoScript.ComputeSignature(mIdentifier.Lexeme, arguments.Count, False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206964656E746966696572206F6620746865206D6574686F6420746F20696E766F6B65206F6E20607375706572602028692E652E20697473206E616D65292E
		Function Location() As ObjoScript.Token
		  /// The identifier of the method to invoke on `super` (i.e. its name).
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mIdentifier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520617267756D656E747320746F207061737320746F20746865206D6574686F642063616C6C206F6E20607375706572602E204D617920626520656D7074792E
		Arguments() As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206D6574686F64206964656E74696665722E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865207369676E6174757265206F6620746865206D6574686F6420746F20696E766F6B65206F6E20607375706572602E
		#tag Getter
			Get
			  Return mSignature
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty


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
			Name="Signature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
