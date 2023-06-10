#tag Class
Protected Class ForeignMethodDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitForeignMethodDeclaration(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(className As String, identifier As ObjoScript.Token, isSetter As Boolean, isStatic As Boolean, params() As ObjoScript.Token)
		  Self.ClassName = className
		  mIdentifier = identifier
		  Self.IsSetter = isSetter
		  Self.IsStatic = isStatic
		  Self.Parameters = params
		  
		  If identifier.Type = ObjoScript.TokenTypes.LSquare Then
		    mSignature = ObjoScript.ComputeSubscriptSignature(Self.Parameters.Count, isSetter)
		  Else
		    mSignature = ObjoScript.ComputeSignature(Self.Name, Self.Parameters.Count, isSetter)
		  End If
		  
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


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E7473207468697320666F726569676E206D6574686F6420657870656374732E
		#tag Getter
			Get
			  Return Parameters.Count
			  
			End Get
		#tag EndGetter
		Arity As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C617373207468697320666F726569676E206D6574686F642062656C6F6E677320746F2E
		ClassName As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 57686574686572207468697320666F726569676E206D6574686F64206973206120736574746572206F72206120726567756C6172206D6574686F642E
		IsSetter As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54727565206966207468697320697320612073746174696320666F726569676E206D6574686F64206465636C61726174696F6E2E
		IsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206964656E74696669657220746F6B656E20666F72207468697320666F726569676E206D6574686F6420696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mIdentifier As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F662074686520666F726569676E206D6574686F642E
		#tag Getter
			Get
			  Return mIdentifier.Lexeme
			  
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468697320666F726569676E206D6574686F64277320706172616D657465727320617320746865206964656E7469666965727320696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Parameters() As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686973206D6574686F642773207369676E61747572652E
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
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStatic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Arity"
			Visible=false
			Group="Behavior"
			InitialValue=""
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
