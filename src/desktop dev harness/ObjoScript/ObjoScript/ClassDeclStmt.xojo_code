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
		Sub Constructor(superclass As String, identifier As ObjoScript.Token, constructors() As ObjoScript.ConstructorDeclStmt, staticMethods As Dictionary, methods As Dictionary, foreignInstanceMethods As Dictionary, foreignStaticMethods As Dictionary, classKeyword As ObjoScript.Token, isForeign As Boolean)
		  Self.Superclass = superclass
		  Self.Identifier = identifier
		  Self.Constructors = constructors
		  Self.StaticMethods = staticMethods
		  Self.Methods = methods
		  Self.ForeignInstanceMethods = foreignInstanceMethods
		  Self.ForeignStaticMethods = foreignStaticMethods
		  mClassKeyword = classKeyword
		  Self.IsForeign = isForeign
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966207468697320636C6173732068617320616E20696E7374616E6365206D6574686F64207769746820607369676E6174757265602E
		Function HasMethodWithSignature(signature As String, isStatic As Boolean) As Boolean
		  /// Returns True if this class has a method with `signature`.
		  /// If `isStatic` is `True` then static methods are search. If `False` then
		  /// only instance methods are searched.
		  
		  
		  If isStatic Then
		    // Check static native methods.
		    For Each entry As DictionaryEntry In Self.StaticMethods
		      Var m As ObjoScript.MethodDeclStmt = entry.Value
		      If m.Signature.CompareCase(signature) Then
		        Return True
		      End If
		    Next entry
		    
		    // Check static foreign methods.
		    For Each entry As DictionaryEntry In Self.ForeignStaticMethods
		      Var m As ObjoScript.ForeignMethodDeclStmt = entry.Value
		      If m.Signature.CompareCase(signature) Then
		        Return True
		      End If
		    Next entry
		  Else
		    // Check native methods.
		    For Each entry As DictionaryEntry In Self.Methods
		      Var m As ObjoScript.MethodDeclStmt = entry.Value
		      If m.Signature.CompareCase(signature) Then
		        Return True
		      End If
		    Next entry
		    
		    // Check foreign methods.
		    For Each entry As DictionaryEntry In Self.ForeignInstanceMethods
		      Var m As ObjoScript.ForeignMethodDeclStmt = entry.Value
		      If m.Signature.CompareCase(signature) Then
		        Return True
		      End If
		    Next entry
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652060636C61737360206B6579776F7264206C6F636174696F6E2E
		Function Location() As ObjoScript.Token
		  /// The `class` keyword location.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mClassKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320636C617373277320636F6E7374727563746F72206465636C61726174696F6E732E204D617920626520656D7074792E
		Constructors() As ObjoScript.ConstructorDeclStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C617373277320666F726569676E20696E7374616E6365206D6574686F64206465636C61726174696F6E732E204B6579203D207369676E61747572652C2056616C7565203D20466F726569676E4D6574686F644465636C53746D742E
		ForeignInstanceMethods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C617373277320666F726569676E20737461746963206D6574686F64206465636C61726174696F6E732E204B6579203D207369676E61747572652C2056616C7565203D20466F726569676E4D6574686F644465636C53746D742E
		ForeignStaticMethods As Dictionary
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

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120666F726569676E20636C6173732E
		IsForeign As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060636C61737360206B6579776F726420746F6B656E2E
		Private mClassKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C6173732773206D6574686F64206465636C61726174696F6E732E204B6579203D207369676E61747572652C2056616C7565203D204D6574686F644465636C53746D742E
		Methods As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F662074686520636C61737320746F206465636C6172652E
		#tag Getter
			Get
			  Return Identifier.Lexeme
			  
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320636C617373277320737461746963206D6574686F64206465636C61726174696F6E732E204B6579203D207369676E61747572652C2056616C7565203D204D6574686F644465636C53746D742E
		StaticMethods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C6173732773207375706572636C6173732E202222206966206E6F6E652E
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
		#tag ViewProperty
			Name="HasSuperclass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Superclass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsForeign"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
