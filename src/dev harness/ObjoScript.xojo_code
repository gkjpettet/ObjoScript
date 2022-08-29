#tag Module
Protected Module ObjoScript
	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320746F6B656E20747970652E
		Function ToString(Extends t As ObjoScript.TokenTypes) As String
		  /// Returns a string representation of this token type.
		  
		  Select Case t
		  Case ObjoScript.TokenTypes.Bang
		    Return "Bang"
		    
		  Case ObjoScript.TokenTypes.Boolean_
		    Return "Boolean"
		    
		  Case ObjoScript.TokenTypes.BangEqual
		    Return "BangEqual"
		    
		  Case ObjoScript.TokenTypes.Colon
		    Return "Colon"
		    
		  Case ObjoScript.TokenTypes.Comma
		    Return "Comma"
		    
		  Case ObjoScript.TokenTypes.Dot
		    Return "Dot"
		    
		  Case ObjoScript.TokenTypes.DotDot
		    Return "DotDot"
		    
		  Case ObjoScript.TokenTypes.DotDotDot
		    Return "DotDotDot"
		    
		  Case ObjoScript.TokenTypes.EOF
		    Return "EOF"
		    
		  Case ObjoScript.TokenTypes.EOL
		    Return "EOL"
		    
		  Case ObjoScript.TokenTypes.Equal
		    Return "Equal"
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    Return "EqualEqual"
		    
		  Case ObjoScript.TokenTypes.FieldIdentifier
		    Return "Field Identifier"
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    Return "ForwardSlash"
		    
		  Case ObjoScript.TokenTypes.ForwardSlashEqual
		    Return "ForwardSlashEqual"
		    
		  Case ObjoScript.TokenTypes.Greater
		    Return "Greater"
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    Return "GreaterEqual"
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    Return "GreaterGreater"
		    
		  Case ObjoScript.TokenTypes.Identifier
		    Return "Identifier"
		    
		  Case ObjoScript.TokenTypes.LCurly
		    Return "LCurly"
		    
		  Case ObjoScript.TokenTypes.Less
		    Return "Less"
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    Return "LessEqual"
		    
		  Case ObjoScript.TokenTypes.LessLess
		    Return "LessLess"
		    
		  Case ObjoScript.TokenTypes.LParen
		    Return "LParen"
		    
		  Case ObjoScript.TokenTypes.LSquare
		    Return "LSquare"
		    
		  Case ObjoScript.TokenTypes.Minus
		    Return "Minus"
		    
		  Case ObjoScript.TokenTypes.MinusEqual
		    Return "MinusEqual"
		    
		  Case ObjoScript.TokenTypes.Null
		    Return "Null"
		    
		  Case ObjoScript.TokenTypes.Number
		    Return "Number"
		    
		  Case ObjoScript.TokenTypes.Percent
		    Return "Percent"
		    
		  Case ObjoScript.TokenTypes.PercentEqual
		    Return "PercentEqual"
		    
		  Case ObjoScript.TokenTypes.Plus
		    Return "Plus"
		    
		  Case ObjoScript.TokenTypes.PlusEqual
		    Return "PlusEqual"
		    
		  Case ObjoScript.TokenTypes.PlusPlus
		    Return "PlusPlus"
		    
		  Case ObjoScript.TokenTypes.Query
		    Return "Query"
		    
		  Case ObjoScript.TokenTypes.RCurly
		    Return "RCurly"
		    
		  Case ObjoScript.TokenTypes.RParen
		    Return "RParen"
		    
		  Case ObjoScript.TokenTypes.RSquare
		    Return "RSquare"
		    
		  Case ObjoScript.TokenTypes.Star
		    Return "Star"
		    
		  Case ObjoScript.TokenTypes.StarEqual
		    Return "StarEqual"
		    
		  Case ObjoScript.TokenTypes.String_
		    Return "String"
		    
		  Case ObjoScript.TokenTypes.Underscore
		    Return "Underscore"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown token type.")
		  End Select
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E73206E6F6E2D616C7068616E756D6572696320636861726163746572732E204B6579203D20537472696E672C2056616C7565203D2048657820756E69636F646520636F6465706F696E742E
		#tag Getter
			Get
			  Static dict As New Dictionary( _
			  &u0A : &h0A, _
			  &u0009 : &h0009, _
			  " "    : &h0020, _
			  "!"    : &h0021, _
			  """"   : &h0022, _
			  "#"    : &h0023, _
			  "$"    : &h0024, _
			  "%"    : &h0025, _
			  "&"    : &h0026, _
			  "'"    : &h0027, _
			  "("    : &h0028, _
			  ")"    : &h0028, _
			  "*"    : &h002A, _
			  "+"    : &h002B, _
			  ","    : &h002C, _
			  "-"    : &h002D, _
			  "."    : &h002E, _
			  "/"    : &h002F, _
			  ":"    : &h003A, _
			  ";"    : &h003B, _
			  "<"    : &h003C, _
			  "="    : &h003D, _
			  ">"    : &h003E, _
			  "?"    : &h003F, _
			  "@"    : &h0040, _
			  "["    : &h005B, _
			  "\"    : &h005C, _
			  "]"    : &h005D, _
			  "^"    : &h005E, _
			  "_"    : &h005F, _
			  "`"    : &h0060, _
			  "{"    : &h007B, _
			  "|"    : &h007C, _
			  "}"    : &h007D, _
			  "~"    : &h007E, _
			  "±"    : &h00B1, _
			  "§"    : &h00A7, _
			  "£"    : &h00A3)
			  
			  Return dict
			  
			End Get
		#tag EndGetter
		Protected NonAlpha As Dictionary
	#tag EndComputedProperty


	#tag Enum, Name = TokenTypes, Type = Integer, Flags = &h1
		Bang
		  BangEqual
		  Boolean_
		  Colon
		  Comma
		  Dot
		  DotDot
		  DotDotDot
		  EOF
		  EOL
		  Equal
		  EqualEqual
		  FieldIdentifier
		  ForwardSlash
		  ForwardSlashEqual
		  Greater
		  GreaterEqual
		  GreaterGreater
		  Identifier
		  LCurly
		  Less
		  LessEqual
		  LessLess
		  LParen
		  LSquare
		  Minus
		  MinusEqual
		  Null
		  Number
		  Percent
		  PercentEqual
		  Plus
		  PlusEqual
		  PlusPlus
		  Query
		  RCurly
		  RParen
		  RSquare
		  Star
		  StarEqual
		  String_
		Underscore
	#tag EndEnum


End Module
#tag EndModule
