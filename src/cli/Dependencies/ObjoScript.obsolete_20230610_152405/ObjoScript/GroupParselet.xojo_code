#tag Class
Protected Class GroupParselet
Implements ObjoScript.PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732074686520706172656E746865736573207573656420746F2067726F757020616E2065787072657373696F6E2E20417373756D6573207468652060286020686173206A757374206265656E20636F6E73756D6564206279207468652060706172736572602E
		Function Parse(parser As ObjoScript.Parser, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses the parentheses used to group an expression.
		  /// Assumes the `(` has just been consumed by the `parser`.
		  ///
		  /// Part of the ObjoScript.PrefixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var expression As ObjoScript.Expr = parser.Expression
		  
		  parser.Consume(ObjoScript.TokenTypes.RParen)
		  
		  Return expression
		  
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
