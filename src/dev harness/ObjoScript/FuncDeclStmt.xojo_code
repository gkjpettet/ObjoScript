#tag Class
Protected Class FuncDeclStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitFuncDeclaration(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(name As ObjoScript.Token, params() As ObjoScript.Token, body As ObjoScript.BlockStmt, funcKeyword As ObjoScript.Token)
		  Self.Name = name
		  Self.Parameters = params
		  Self.Body = body
		  mFuncKeyword = funcKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206066756E6374696F6E60206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The `function` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mFuncKeyword
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468652066756E6374696F6E277320626F64792E
		Body As ObjoScript.BlockStmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206066756E6374696F6E60206B6579776F72642E
		Private mFuncKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066756E6374696F6E2773206E616D6520617320746865206964656E74696669657220746F6B656E20696E2074686520736F7572636520636F64652E
		Name As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066756E6374696F6E277320706172616D657465727320286D617920626520656D707479292E
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
			Name="Name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
