#tag Class
Protected Class BinaryExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitBinary(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(left As ObjoScript.Expr, operator As ObjoScript.Token, right As ObjoScript.Expr)
		  Self.Left = left
		  mLocation = operator
		  Self.Right = right
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468652062696E617279206F70657261746F7220696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Function Location() As ObjoScript.Token
		  /// The location of the binary operator in the original token stream.
		  ///
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206C6566742068616E64206F706572616E642E
		Left As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E67207468652062696E617279206F70657261746F7220696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652062696E617279206F70657261746F7220747970652E
		#tag Getter
			Get
			  Return mLocation.Type
			End Get
		#tag EndGetter
		Operator As ObjoScript.TokenTypes
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652072696768742068616E64206F706572616E642E
		Right As ObjoScript.Expr
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
			InitialValue=""
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
			Name="Operator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ObjoScript.TokenTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Ampersand"
				"1 - And_"
				"2 - As_"
				"3 - Assert"
				"4 - Boolean_"
				"5 - Breakpoint"
				"6 - Caret"
				"7 - Class_"
				"8 - Colon"
				"9 - Comma"
				"10 - Constructor"
				"11 - Continue_"
				"12 - Dot"
				"13 - DotDot"
				"14 - DotDotDot"
				"15 - Else_"
				"16 - EOF"
				"17 - EOL"
				"18 - Equal"
				"19 - EqualEqual"
				"20 - Exit_"
				"21 - Export"
				"22 - FieldIdentifier"
				"23 - For_"
				"24 - ForEach"
				"25 - Foreign"
				"26 - ForwardSlash"
				"27 - ForwardSlashEqual"
				"28 - Function_"
				"29 - Greater"
				"30 - GreaterEqual"
				"31 - GreaterGreater"
				"32 - Identifier"
				"33 - If_"
				"34 - Import"
				"35 - In_"
				"36 - Is_"
				"37 - LCurly"
				"38 - Less"
				"39 - LessEqual"
				"40 - LessLess"
				"41 - LParen"
				"42 - LSquare"
				"43 - Minus"
				"44 - MinusEqual"
				"45 - MinusMinus"
				"46 - Not_"
				"47 - NotEqual"
				"48 - Nothing"
				"49 - Number"
				"50 - Or_"
				"51 - Percent"
				"52 - Pipe"
				"53 - Plus"
				"54 - PlusEqual"
				"55 - PlusPlus"
				"56 - Query"
				"57 - RCurly"
				"58 - Return_"
				"59 - RParen"
				"60 - RSquare"
				"61 - Semicolon"
				"62 - Star"
				"63 - StarEqual"
				"64 - Static_"
				"65 - StaticFieldIdentifier"
				"66 - String_"
				"67 - Super_"
				"68 - This"
				"69 - Tilde"
				"70 - Underscore"
				"71 - UppercaseIdentifier"
				"72 - Var_"
				"73 - While_"
				"74 - Xor_"
				"75 - Then_"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
