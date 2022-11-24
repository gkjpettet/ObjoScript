#tag Class
Protected Class CallExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return visitor.VisitCall(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(callee As ObjoScript.Expr, arguments() As ObjoScript.Expr, lparen As ObjoScript.Token)
		  Self.Callee = callee
		  Self.Arguments = arguments
		  mLocation = lparen
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206F70656E696E6720706172656E7468657369732E
		Function Location() As ObjoScript.Token
		  /// The opening parenthesis.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520617267756D656E747320746F207468652063616C6C2E
		Arguments() As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652063616C6C65652E
		Callee As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F70656E696E6720706172656E7468657369732E
		Private mLocation As ObjoScript.Token
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
