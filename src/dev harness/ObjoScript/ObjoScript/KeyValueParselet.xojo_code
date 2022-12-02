#tag Class
Protected Class KeyValueParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061206B65792D76616C756520706169722E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D65642074686520603A6020746F6B656E2E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses a key-value pair.
		  /// Assumes the parser has just consumed the `:` token.
		  ///
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  #Pragma Warning "BROKEN: Precedence is wrong - interfere with conditionals"
		  ' Also can't do this: 
		  ' var a = 1 : 2
		  
		  #Pragma Unused canAssign
		  
		  Var colon As ObjoScript.Token = parser.Previous
		  
		  Var right As ObjoScript.Expr = parser.Expression
		  
		  Return New KeyValueExpr(colon, left, right)
		  
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
