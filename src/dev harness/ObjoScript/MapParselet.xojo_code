#tag Class
Protected Class MapParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206C697374206C69746572616C2E20417373756D6573206120605B6020686173206A757374206265656E20636F6E73756D656420627920746865207061727365722E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a map literal.
		  /// Assumes a `{` has just been consumed by the parser.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var lcurly As ObjoScript.Token = parser.Previous
		  
		  // Parse the optional values.
		  Var keyValues() As Pair
		  If Not parser.Check(ObjoScript.TokenTypes.RCurly) Then
		    Do
		      keyValues.Add(ParseKeyValue(parser))
		    Loop Until Not parser.Match(ObjoScript.TokenTypes.Comma)
		  End If
		  
		  parser.Consume(ObjoScript.TokenTypes.RCurly, "Expected a `}` after the Map's key-values.")
		  
		  Return New ObjoScript.MapLiteral(lcurly, keyValues)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5061727365732061204D6170206C69746572616C206B65792D76616C756520706169722E204C6566743A204E756D6265722F537472696E672F426F6F6C65616E2F4E6F7468696E672C2052696768743A20604F626A6F5363726970742E45787072602E
		Private Function ParseKeyValue(parser As ObjoScript.Parser) As Pair
		  /// Parses a Map literal key-value pair.
		  /// Left: `ObjoScript.Expr`, Right: `ObjoScript.Expr`.
		  
		  Var key As ObjoScript.Expr = parser.Expression
		  
		  parser.Consume(ObjoScript.TokenTypes.Colon, "Expected a `:` after the key.")
		  
		  Var value As ObjoScript.Expr = parser.Expression
		  
		  Return key : value
		  
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
