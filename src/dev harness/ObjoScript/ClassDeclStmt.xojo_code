#tag Class
Protected Class ClassDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitClassDeclaration(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(identifier As ObjoScript.Token, body As BlockStmt, classKeyword As ObjoScript.Token)
		  Self.Identifier = identifier
		  Self.Body = body
		  mClassKeyword = classKeyword
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652060636C61737360206B6579776F7264206C6F636174696F6E2E
		Function Location() As ObjoScript.Token
		  /// The `class` keyword location.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mClassKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636C617373206465636C61726174696F6E277320626F64792E
		Body As ObjoScript.BlockStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C61737327206E616D6520746F6B656E2E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060636C61737360206B6579776F726420746F6B656E2E
		Private mClassKeyword As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F662074686520636C61737320746F206465636C6172652E
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
