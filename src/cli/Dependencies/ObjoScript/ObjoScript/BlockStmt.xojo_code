#tag Class
Protected Class BlockStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitBlock(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(statements() As ObjoScript.Stmt, openingBrace As ObjoScript.Token, closingBrace As ObjoScript.Token)
		  Self.Statements = statements
		  mOpeningBrace = openingBrace
		  Self.ClosingBrace = closingBrace
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468697320626C6F636B2773206F70656E696E67206375726C792062726163652E
		Function Location() As ObjoScript.Token
		  /// The location of this block's opening curly brace.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mOpeningBrace
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636C6F73696E67206272616365206F66207468697320626C6F636B2E
		ClosingBrace As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206F70656E696E6720627261636520746F6B656E2E
		Private mOpeningBrace As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320626C6F636B27732073746174656D656E74732E
		Statements() As ObjoScript.Stmt
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
