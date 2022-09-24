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
		Sub Constructor(identifier As ObjoScript.Token, constructors() As ObjoScript.ConstructorDeclStmt, methods() As ObjoScript.MethodDeclStmt, classKeyword As ObjoScript.Token)
		  Self.Identifier = identifier
		  Self.Constructors = constructors
		  Self.Methods = methods
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


	#tag Property, Flags = &h0, Description = 5468697320636C6173732720636F6E7374727563746F72206465636C61726174696F6E732E204D617920626520656D7074792E
		Constructors() As ObjoScript.ConstructorDeclStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C61737327206E616D6520746F6B656E2E
		Identifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060636C61737360206B6579776F726420746F6B656E2E
		Private mClassKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C61737327206D6574686F64206465636C61726174696F6E732E204D617920626520656D7074792E
		Methods() As ObjoScript.MethodDeclStmt
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
