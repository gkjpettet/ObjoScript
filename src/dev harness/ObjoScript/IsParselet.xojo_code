#tag Class
Protected Class IsParselet
Implements ObjoScript.InfixParselet
	#tag Method, Flags = &h0, Description = 506172736573207468652060697360206F70657261746F722E20417373756D6573207468652070617273657220686173206A75737420636F6E73756D6564207468652060697360206B6579776F72642E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  /// Parses the `is` operator.
		  /// Assumes the parser has just consumed the `is` keyword.
		  ///
		  /// `value is type` (where type is an identifier or a reserved type name).
		  /// Part of the ObjoScript.InfixParselet interface.
		  
		  #Pragma Unused canAssign
		  
		  Var isKeyword As ObjoScript.Token = parser.Previous
		  
		  // Get the type.
		  Var type As ObjoScript.Token = parser.Consume("Expected a type name after the `is` keyword.", _
		  ObjoScript.TokenTypes.UppercaseIdentifier, ObjoScript.TokenTypes.ReservedType, ObjoScript.TokenTypes.Nothing)
		  
		  Return New IsExpr(left, type, isKeyword)
		  
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
