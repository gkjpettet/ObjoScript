#tag Class
Protected Class VarDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitVarDeclaration(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(identifier As ObjoScript.Token, initialiser As ObjoScript.Expr, location As ObjoScript.Token)
		  mLocation = location
		  Self.Identifier = identifier
		  Self.Initialiser = initialiser
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206076617260206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The `var` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520746F6B656E20726570726573656E74696E672074686973207661726961626C652773206964656E7469666965722E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0
		Initialiser As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E672074686520756E617279206F70657261746F7220696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865207661726961626C6520746F206465636C6172652E
		#tag Getter
			Get
			  Return Identifier.Lexeme
			End Get
		#tag EndGetter
		Name As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
