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

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865206D6574686F6420746F20696E766F6B65206F6E20607375706572602E
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

	#tag Property, Flags = &h21, Description = 5468652060737570657260206B6579776F726420746F6B656E2E
		Private mSuperKeyword As ObjoScript.Token
	#tag EndProperty


End Class
#tag EndClass
