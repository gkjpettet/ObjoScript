#tag Class
Protected Class ConstructorDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitConstructorDeclaration(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(className As String, params() As ObjoScript.Token, body As ObjoScript.BlockStmt, constructorKeyword As ObjoScript.Token)
		  Self.ClassName = className
		  Self.Parameters = params
		  Self.Body = body
		  mConstructorKeyword = constructorKeyword
		  mSignature = ObjoScript.Func.ComputeSignature("constructor", params.Count, False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652060636F6E7374727563746F7260206B6579776F726420696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Function Location() As ObjoScript.Token
		  /// The `constructor` keyword in the original token stream.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mConstructorKeyword
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620706172616D6574657273207468697320636F6E7374727563746F7220657870656374732E
		#tag Getter
			Get
			  Return Parameters.Count
			  
			End Get
		#tag EndGetter
		Arity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320636F6E7374727563746F72277320626F64792E
		Body As ObjoScript.BlockStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C617373207468697320636F6E7374727563746F722062656C6F6E677320746F2E
		ClassName As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652060636F6E7374727563746F7260206B6579776F726420746F6B656E2E
		Private mConstructorKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320636F6E7374727563746F722773207369676E61747572652E
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636F6E7374727563746F72277320706172616D657465727320617320746865206964656E7469666965727320696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Parameters() As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468697320636F6E7374727563746F722773207369676E61747572652E
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
			Name="ClassName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Signature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
