#tag Class
Protected Class MethodDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitMethodDeclaration(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(className As String, identifier As ObjoScript.Token, isSetter As Boolean, params() As ObjoScript.Token, body As ObjoScript.BlockStmt)
		  Self.ClassName = className
		  mIdentifier = identifier
		  Self.IsSetter = isSetter
		  Self.Parameters = params
		  Self.Body = body
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206964656E74696669657220746F6B656E20666F722074686973206D6574686F6420696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Function Location() As ObjoScript.Token
		  /// The identifier token for this method in the original token stream.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mIdentifier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686973206D6574686F64277320626F64792E
		Body As ObjoScript.BlockStmt
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C6173732074686973206D6574686F642062656C6F6E677320746F2E
		ClassName As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 576865746865722074686973206D6574686F64206973206120736574746572206F72206120726567756C6172206D6574686F642E
		IsSetter As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206964656E74696669657220746F6B656E20666F722074686973206D6574686F6420696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F6620746865206D6574686F642E
		#tag Getter
			Get
			  Return mIdentifier.Lexeme
			  
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686973206D6574686F64277320706172616D657465727320617320746865206964656E7469666965727320696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Parameters() As ObjoScript.Token
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
			Name="ClassName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
