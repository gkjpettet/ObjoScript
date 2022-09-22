#tag Module
Protected Module ObjoScript
	#tag Method, Flags = &h0, Description = 52657475726E73207468652068617368206F66207468697320646F75626C652E
		Function Hash(Extends d As Double) As Integer
		  /// Returns the hash of this double.
		  
		  Var v As Variant = d
		  Return v.Hash
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652068617368206F66207468697320696E74656765722E
		Function Hash(Extends i As Integer) As Integer
		  /// Returns the hash of this integer.
		  
		  Var v As Variant = i
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652068617368206F66207468697320737472696E672E
		Function Hash(Extends s As String) As Integer
		  /// Returns the hash of this string.
		  
		  Var v As Variant = s
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662060646020697320616E20696E74656765722E
		Function IsInteger(Extends d As Double) As Boolean
		  /// Returns True if `d` is an integer.
		  
		  Return d = Floor(d)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320697320616E20696E7465676572206F72206120646F75626C652E
		Function IsNumber(Extends v As Variant) As Boolean
		  /// True if this is an integer or a double.
		  
		  If v = Nil Then Return False
		  
		  Select Case v.Type
		  Case Variant.TypeInteger, Variant.TypeDouble
		    Return True
		  Else
		    Return False
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320746F6B656E20747970652E
		Function ToString(Extends t As ObjoScript.TokenTypes) As String
		  /// Returns a string representation of this token type.
		  
		  Select Case t
		  Case ObjoScript.TokenTypes.Ampersand
		    Return "&"
		    
		  Case ObjoScript.TokenTypes.And_
		    Return "And"
		    
		  Case ObjoScript.TokenTypes.As_
		    Return "As"
		    
		  Case ObjoScript.TokenTypes.Assert
		    Return "Assert"
		    
		  Case ObjoScript.TokenTypes.Boolean_
		    Return "Boolean"
		    
		  Case ObjoScript.TokenTypes.Breakpoint
		    Return "Breakpoint"
		    
		  Case ObjoScript.TokenTypes.Caret
		    Return "^"
		    
		  Case ObjoScript.TokenTypes.Class_
		    Return "Class"
		    
		  Case ObjoScript.TokenTypes.Colon
		    Return "Colon"
		    
		  Case ObjoScript.TokenTypes.Comma
		    Return "Comma"
		    
		  Case ObjoScript.TokenTypes.Continue_
		    Return "Continue"
		    
		  Case ObjoScript.TokenTypes.Construct
		    Return "Construct"
		    
		  Case ObjoScript.TokenTypes.Dot
		    Return "Dot"
		    
		  Case ObjoScript.TokenTypes.DotDot
		    Return "Inclusive Range"
		    
		  Case ObjoScript.TokenTypes.DotDotDot
		    Return "Exclusive Range"
		    
		  Case ObjoScript.TokenTypes.EOF
		    Return "EOF"
		    
		  Case ObjoScript.TokenTypes.EOL
		    Return "EOL"
		    
		  Case ObjoScript.TokenTypes.Equal
		    Return "="
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    Return "=="
		    
		  Case ObjoScript.TokenTypes.Else_
		    Return "Else"
		    
		  Case ObjoScript.TokenTypes.Exit_
		    Return "Exit"
		    
		  Case ObjoScript.TokenTypes.Export
		    Return "Export"
		    
		  Case ObjoScript.TokenTypes.FieldIdentifier
		    Return "Field Identifier"
		    
		  Case ObjoScript.TokenTypes.For_
		    Return "For"
		    
		  Case ObjoScript.TokenTypes.ForEach
		    Return "ForEach"
		    
		  Case ObjoScript.TokenTypes.Foreign
		    Return "Foreign"
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    Return "/"
		    
		  Case ObjoScript.TokenTypes.ForwardSlashEqual
		    Return "/="
		    
		  Case ObjoScript.TokenTypes.Function_
		    Return "Function"
		    
		  Case ObjoScript.TokenTypes.Greater
		    Return ">"
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    Return ">="
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    Return ">>"
		    
		  Case ObjoScript.TokenTypes.Identifier
		    Return "Identifier"
		    
		  Case ObjoScript.TokenTypes.If_
		    Return "If"
		    
		  Case ObjoScript.TokenTypes.Import
		    Return "Import"
		    
		  Case ObjoScript.TokenTypes.In_
		    Return "In"
		    
		  Case ObjoScript.TokenTypes.Is_
		    Return "Is"
		    
		  Case ObjoScript.TokenTypes.LCurly
		    Return "LCurly"
		    
		  Case ObjoScript.TokenTypes.Less
		    Return "<"
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    Return "<="
		    
		  Case ObjoScript.TokenTypes.LessLess
		    Return "<<"
		    
		  Case ObjoScript.TokenTypes.LParen
		    Return "LParen"
		    
		  Case ObjoScript.TokenTypes.LSquare
		    Return "LSquare"
		    
		  Case ObjoScript.TokenTypes.Minus
		    Return "-"
		    
		  Case ObjoScript.TokenTypes.MinusMinus
		    Return "--"
		    
		  Case ObjoScript.TokenTypes.MinusEqual
		    Return "-="
		    
		  Case ObjoScript.TokenTypes.Not_
		    Return "Not"
		    
		  Case ObjoScript.TokenTypes.NotEqual
		    Return "<>"
		    
		  Case ObjoScript.TokenTypes.Nothing
		    Return "Nothing"
		    
		  Case ObjoScript.TokenTypes.Number
		    Return "Number"
		    
		  Case ObjoScript.TokenTypes.Or_
		    Return "Or"
		    
		  Case ObjoScript.TokenTypes.Percent
		    Return "%"
		    
		  Case ObjoScript.TokenTypes.Pipe
		    Return "|"
		    
		  Case ObjoScript.TokenTypes.Plus
		    Return "+"
		    
		  Case ObjoScript.TokenTypes.PlusEqual
		    Return "+="
		    
		  Case ObjoScript.TokenTypes.PlusPlus
		    Return "++"
		    
		  Case ObjoScript.TokenTypes.Print
		    Return "Print"
		    
		  Case ObjoScript.TokenTypes.Query
		    Return "Query"
		    
		  Case ObjoScript.TokenTypes.RCurly
		    Return "RCurly"
		    
		  Case ObjoScript.TokenTypes.Return_
		    Return "Return"
		    
		  Case ObjoScript.TokenTypes.RParen
		    Return "RParen"
		    
		  Case ObjoScript.TokenTypes.RSquare
		    Return "RSquare"
		    
		  Case ObjoScript.TokenTypes.Star
		    Return "*"
		    
		  Case ObjoScript.TokenTypes.StarEqual
		    Return "*="
		    
		  Case ObjoScript.TokenTypes.Semicolon
		    Return "Semicolon"
		    
		  Case ObjoScript.TokenTypes.Static_
		    Return "Static"
		    
		  Case ObjoScript.TokenTypes.String_
		    Return "String"
		    
		  Case ObjoScript.TokenTypes.Then_
		    Return "Then"
		    
		  Case ObjoScript.TokenTypes.This
		    Return "This"
		    
		  Case ObjoScript.TokenTypes.Tilde
		    Return "~"
		    
		  Case ObjoScript.TokenTypes.Underscore
		    Return "Underscore"
		    
		  Case ObjoScript.TokenTypes.Var_
		    Return "Var"
		    
		  Case ObjoScript.TokenTypes.While_
		    Return "While"
		    
		  Case ObjoScript.TokenTypes.Xor_
		    Return "Xor"
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown token type.")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620746869732076616C756520747970652E
		Function ToString(Extends type As ObjoScript.ValueTypes) As String
		  /// Returns a string representation of this value type.
		  
		  Select Case type
		  Case ObjoScript.ValueTypes.Func
		    Return "Function"
		    
		  Case ObjoScript.ValueTypes.Klass
		    Return "Class"
		    
		  Case ObjoScript.ValueTypes.Instance
		    Return "Instance"
		    
		  Case ObjoScript.ValueTypes.BoundMethod
		    Return "Bound method"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown value type.")
		  End Select
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Values
		The VM's stack is a Variant array. Values on the stack are stored as follows:
		
		- Nothing     : Objo Nothing 
		- Numbers     : Xojo Double
		- Booleans    : Xojo Boolean
		- Strings     : Xojo String
		- Functions   : ObjoScript.Func
		- Classes     : ObjoScript.Klass
		- Instances   : ObjoScript.Instance
		- Method calls: ObjoScript.BoundMethod
		
	#tag EndNote


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


	#tag Enum, Name = FunctionTypes, Type = Integer, Flags = &h1, Description = 54686520646966666572656E74207479706573206F662066756E6374696F6E2E
		TopLevel
		  Func
		Method
	#tag EndEnum

	#tag Enum, Name = TokenTypes, Type = Integer, Flags = &h1
		Ampersand
		  And_
		  As_
		  Assert
		  Boolean_
		  Breakpoint
		  Caret
		  Class_
		  Colon
		  Comma
		  Construct
		  Continue_
		  Dot
		  DotDot
		  DotDotDot
		  Else_
		  EOF
		  EOL
		  Equal
		  EqualEqual
		  Exit_
		  Export
		  FieldIdentifier
		  For_
		  Foreign
		  ForwardSlash
		  ForwardSlashEqual
		  Function_
		  Greater
		  GreaterEqual
		  GreaterGreater
		  Identifier
		  If_
		  Import
		  In_
		  Is_
		  LCurly
		  Less
		  LessEqual
		  LessLess
		  LParen
		  LSquare
		  Minus
		  MinusEqual
		  MinusMinus
		  Not_
		  NotEqual
		  Nothing
		  Number
		  Or_
		  Percent
		  Pipe
		  Plus
		  PlusEqual
		  PlusPlus
		  Print
		  Query
		  RCurly
		  Return_
		  RParen
		  RSquare
		  Star
		  StarEqual
		  Static_
		  String_
		  This
		  Tilde
		  Underscore
		  Var_
		  While_
		  Xor_
		  Then_
		  ForEach
		Semicolon
	#tag EndEnum

	#tag Enum, Name = ValueTypes, Type = Integer, Flags = &h1
		Func
		  Klass
		  Instance
		BoundMethod
	#tag EndEnum


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
End Module
#tag EndModule
