#tag Class
Protected Class NumberExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Sub Constructor(token As ObjoScript.Token)
		  mLocation = token
		  IsInteger = token.IsInteger
		  Value = token.NumberValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206E756D626572206C69746572616C20746F6B656E20697473656C662E
		Function Location() As ObjoScript.Token
		  /// The number literal token itself.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Represents a number literal.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54727565206966207468697320697320616E20696E7465676572206C69746572616C2E
		IsInteger As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686973206E756D62657227732076616C75652E
		Value As Double
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
