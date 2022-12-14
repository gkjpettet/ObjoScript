#tag Class
Protected Class LiteralParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206C69746572616C2028652E672E206E756D6265722C20626F6F6C65616E2C20657463292E20417373756D657320746865206C69746572616C277320746F6B656E20686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a literal (e.g. number, boolean, etc).
		  /// Assumes the literal's token has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var literal As ObjoScript.Token = parser.Previous
		  
		  Select Case literal.Type
		  Case ObjoScript.TokenTypes.Number
		    Return New ObjoScript.NumberLiteral(literal)
		    
		  Case ObjoScript.TokenTypes.Boolean_
		    Return New ObjoScript.BooleanLiteral(literal)
		    
		  Case ObjoScript.TokenTypes.Nothing
		    Return New ObjoScript.NothingLiteral(literal)
		    
		  Case ObjoScript.TokenTypes.String_
		    Return New ObjoScript.StringLiteral(literal)
		    
		  Else
		    Raise New UnsupportedOperationException("Unexpected literal type.")
		  End Select
		  
		End Function
	#tag EndMethod


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
