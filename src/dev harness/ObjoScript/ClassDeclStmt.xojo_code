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
		Sub Constructor(superclass As String, identifier As ObjoScript.Token, constructors() As ObjoScript.ConstructorDeclStmt, staticMethods() As ObjoScript.MethodDeclStmt, methods() As ObjoScript.MethodDeclStmt, foreignMethods() As ObjoScript.ForeignMethodDeclStmt, classKeyword As ObjoScript.Token)
		  Self.Superclass = superclass
		  Self.Identifier = identifier
		  Self.Constructors = constructors
		  Self.StaticMethods = staticMethods
		  Self.Methods = methods
		  Self.ForeignMethods = foreignMethods
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

	#tag Property, Flags = &h0, Description = 5468697320636C6173732720666F726569676E206D6574686F64206465636C61726174696F6E732E204D617920626520656D7074792E
		ForeignMethods() As ObjoScript.ForeignMethodDeclStmt
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320636C617373206861732061207375706572636C6173732E
		#tag Getter
			Get
			  Return Superclass <> ""
			  
			End Get
		#tag EndGetter
		HasSuperclass As Boolean
	#tag EndComputedProperty

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

	#tag Property, Flags = &h0, Description = 5468697320636C6173732720737461746963206D6574686F64206465636C61726174696F6E732E204D617920626520656D7074792E
		StaticMethods() As ObjoScript.MethodDeclStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C61737327207375706572636C6173732E202222206966206E6F6E652E
		Superclass As String
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
