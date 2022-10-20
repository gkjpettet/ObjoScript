#tag Class
Protected Class ListParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206C697374206C69746572616C2E20417373756D6573206120605B6020686173206A757374206265656E20636F6E73756D656420627920746865207061727365722E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a list literal.
		  /// Assumes a `[` has just been consumed by the parser.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var lsquare As ObjoScript.Token = parser.Previous
		  
		  // Parse the optional values.
		  Var values() As ObjoScript.Expr
		  If Not parser.Check(ObjoScript.TokenTypes.RSquare) Then
		    Do
		      values.Add(parser.Expression)
		    Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		  End If
		  parser.Consume(ObjoScript.TokenTypes.RSquare, "Expected a `]` after the List's values.")
		  
		  Return New ObjoScript.ListLiteral(lsquare, values)
		  
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
