#tag Class
Protected Class RangeExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Function Accept(visitor As ObjoScript.ExprVisitor) As Variant
		  /// Part of the ExprVisitor interface.
		  
		  Return visitor.VisitRange(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(lower As ObjoScript.Expr, operator As ObjoScript.Token, upper As ObjoScript.Expr)
		  Self.Lower = lower
		  mOperator = operator
		  Self.Upper = upper
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5468652072616E6765206F70657261746F7220746F6B656E2E
		Function Location() As ObjoScript.Token
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mOperator
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 54727565206966207468697320697320616E20696E636C75736976652072616E67652065787072657373696F6E20282E2E292E2046616C7365206966206578636C757369766520282E2E2E292E
		#tag Getter
			Get
			  Return mOperator.Type = ObjoScript.TokenTypes.DotDot
			  
			End Get
		#tag EndGetter
		Inclusive As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206C6F77657220626F756E6473206F66207468652072616E67652E
		Lower As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOperator As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652072616E676572206F70657261746F7220746F6B656E2E
		#tag Getter
			Get
			  Return mOperator
			End Get
		#tag EndGetter
		Operator As ObjoScript.Token
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520757070657220626F756E6473206F66207468652072616E67652E2057686574686572207468697320697320696E636C757369766520282E2E29206F72206578636C757369766520282E2E2E2920646570656E6473206F6E20746865206F70657261746F722E
		Upper As ObjoScript.Expr
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
			Name="Lower"
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
				"56 - Print"
				"57 - Query"
				"58 - RCurly"
				"59 - ReservedType"
				"60 - Return_"
				"61 - RParen"
				"62 - RSquare"
				"63 - Semicolon"
				"64 - Star"
				"65 - StarEqual"
				"66 - Static_"
				"67 - StaticFieldIdentifier"
				"68 - String_"
				"69 - Super_"
				"70 - This"
				"71 - Tilde"
				"72 - Underscore"
				"73 - Var_"
				"74 - While_"
				"75 - Xor_"
				"76 - Then_"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
