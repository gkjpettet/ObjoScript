#tag Class
Protected Class IsExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitIs(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(value As ObjoScript.Expr, type As ObjoScript.Token, isKeyword As ObjoScript.Token)
		  Self.Value = value
		  mIsKeyword = isKeyword
		  Self.Type = type
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Location() As ObjoScript.Token
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mIsKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E67207468652060697360206B6579776F726420696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mIsKeyword As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865207479706520746F6B656E2E
		Type As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652076616C756520746F20746865206C656674206F66207468652060697360206B6579776F72642E
		Value As ObjoScript.Expr
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
