#tag Module
Protected Module ObjoScript
	#tag Method, Flags = &h0, Description = 52657475726E732054727565206966206073602065786163746C79206D61746368657320616E797468696E6720696E206076616C756573602E
		Function ExactlyMatches(Extends s As String, values() As String) As Boolean
		  /// Returns True if `s` exactly matches anything in `values`.
		  
		  For Each value As String In values
		    If s.CompareCase(value) Then
		      Return True
		    End If
		  Next value
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h1, Description = 496E766F6B6564207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C61737320697320636F6E73747275637465642E204F6363757273206265666F726520616E79204F626A6F2D646566696E656420636C61737320636F6E7374727563746F72732061726520696E766F6B65642E
		Protected Delegate Sub ForeignAllocateDelegate(vm As ObjoScript . VM, instance As ObjoScript . Instance, arguments() As Variant)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1, Description = 496E766F6B6564207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C6173732069732064657374726F7965642E20606461746160206973207468652068696464656E20666F726569676E2064617461206173736F6369617465642077697468207468697320696E7374616E63652E
		Protected Delegate Sub ForeignDestroyDelegate(data As Variant)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1
		Protected Delegate Sub ForeignMethodDelegate(vm As ObjoScript . VM)
	#tag EndDelegateDeclaration

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
		  Case Variant.TypeInt32, Variant.TypeInt64, Variant.TypeDouble
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
		    Return "and"
		    
		  Case ObjoScript.TokenTypes.As_
		    Return "as"
		    
		  Case ObjoScript.TokenTypes.Assert
		    Return "assert"
		    
		  Case ObjoScript.TokenTypes.Boolean_
		    Return "Boolean"
		    
		  Case ObjoScript.TokenTypes.Breakpoint
		    Return "breakpoint"
		    
		  Case ObjoScript.TokenTypes.Caret
		    Return "^"
		    
		  Case ObjoScript.TokenTypes.Case_
		    Return "Case"
		    
		  Case ObjoScript.TokenTypes.Class_
		    Return "class"
		    
		  Case ObjoScript.TokenTypes.Colon
		    Return "colon"
		    
		  Case ObjoScript.TokenTypes.Comma
		    Return "comma"
		    
		  Case ObjoScript.TokenTypes.Continue_
		    Return "continue"
		    
		  Case ObjoScript.TokenTypes.Constructor
		    Return "constructor"
		    
		  Case ObjoScript.TokenTypes.Do_
		    Return "do"
		    
		  Case ObjoScript.TokenTypes.Dot
		    Return "dot"
		    
		  Case ObjoScript.TokenTypes.DotDotLess
		    Return "exclusive range"
		    
		  Case ObjoScript.TokenTypes.DotDotDot
		    Return "inclusive range"
		    
		  Case ObjoScript.TokenTypes.EOF
		    Return "EOF"
		    
		  Case ObjoScript.TokenTypes.EOL
		    Return "EOL"
		    
		  Case ObjoScript.TokenTypes.Equal
		    Return "="
		    
		  Case ObjoScript.TokenTypes.EqualEqual
		    Return "=="
		    
		  Case ObjoScript.TokenTypes.Else_
		    Return "else"
		    
		  Case ObjoScript.TokenTypes.Exit_
		    Return "exit"
		    
		  Case ObjoScript.TokenTypes.Export
		    Return "export"
		    
		  Case ObjoScript.TokenTypes.FieldIdentifier
		    Return "field identifier"
		    
		  Case ObjoScript.TokenTypes.For_
		    Return "for"
		    
		  Case ObjoScript.TokenTypes.ForEach
		    Return "foeEach"
		    
		  Case ObjoScript.TokenTypes.Foreign
		    Return "foreign"
		    
		  Case ObjoScript.TokenTypes.ForwardSlash
		    Return "/"
		    
		  Case ObjoScript.TokenTypes.ForwardSlashEqual
		    Return "/="
		    
		  Case ObjoScript.TokenTypes.Function_
		    Return "function"
		    
		  Case ObjoScript.TokenTypes.Greater
		    Return ">"
		    
		  Case ObjoScript.TokenTypes.GreaterEqual
		    Return ">="
		    
		  Case ObjoScript.TokenTypes.GreaterGreater
		    Return ">>"
		    
		  Case ObjoScript.TokenTypes.Identifier
		    Return "lowercase identifier"
		    
		  Case ObjoScript.TokenTypes.If_
		    Return "if"
		    
		  Case ObjoScript.TokenTypes.Import
		    Return "import"
		    
		  Case ObjoScript.TokenTypes.In_
		    Return "in"
		    
		  Case ObjoScript.TokenTypes.Is_
		    Return "is"
		    
		  Case ObjoScript.TokenTypes.LCurly
		    Return "lcurly"
		    
		  Case ObjoScript.TokenTypes.Less
		    Return "<"
		    
		  Case ObjoScript.TokenTypes.LessEqual
		    Return "<="
		    
		  Case ObjoScript.TokenTypes.LessLess
		    Return "<<"
		    
		  Case ObjoScript.TokenTypes.Loop_
		    Return "loop"
		    
		  Case ObjoScript.TokenTypes.LParen
		    Return "lparen"
		    
		  Case ObjoScript.TokenTypes.LSquare
		    Return "lsquare"
		    
		  Case ObjoScript.TokenTypes.Minus
		    Return "-"
		    
		  Case ObjoScript.TokenTypes.MinusMinus
		    Return "--"
		    
		  Case ObjoScript.TokenTypes.MinusEqual
		    Return "-="
		    
		  Case ObjoScript.TokenTypes.Not_
		    Return "not"
		    
		  Case ObjoScript.TokenTypes.NotEqual
		    Return "<>"
		    
		  Case ObjoScript.TokenTypes.None
		    Return "NONE"
		    
		  Case ObjoScript.TokenTypes.Nothing
		    Return "nothing"
		    
		  Case ObjoScript.TokenTypes.Number
		    Return "Number"
		    
		  Case ObjoScript.TokenTypes.Or_
		    Return "or"
		    
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
		    
		  Case ObjoScript.TokenTypes.Query
		    Return "query"
		    
		  Case ObjoScript.TokenTypes.RCurly
		    Return "rcurly"
		    
		  Case ObjoScript.TokenTypes.Return_
		    Return "return"
		    
		  Case ObjoScript.TokenTypes.RParen
		    Return "rparen"
		    
		  Case ObjoScript.TokenTypes.RSquare
		    Return "rsquare"
		    
		  Case ObjoScript.TokenTypes.Star
		    Return "*"
		    
		  Case ObjoScript.TokenTypes.StarEqual
		    Return "*="
		    
		  Case ObjoScript.TokenTypes.Semicolon
		    Return "semicolon"
		    
		  Case ObjoScript.TokenTypes.Static_
		    Return "static"
		    
		  Case ObjoScript.TokenTypes.StaticFieldIdentifier
		    Return "static field identifier"
		    
		  Case ObjoScript.TokenTypes.String_
		    Return "String"
		    
		  Case ObjoScript.TokenTypes.Switch
		    Return "Switch"
		    
		  Case ObjoScript.TokenTypes.Super_
		    Return "super"
		    
		  Case ObjoScript.TokenTypes.Then_
		    Return "then"
		    
		  Case ObjoScript.TokenTypes.This
		    Return "this"
		    
		  Case ObjoScript.TokenTypes.Tilde
		    Return "~"
		    
		  Case ObjoScript.TokenTypes.Underscore
		    Return "underscore"
		    
		  Case ObjoScript.TokenTypes.Until_
		    Return "until"
		    
		  Case ObjoScript.TokenTypes.UppercaseIdentifier
		    Return "uppercase identifier"
		    
		  Case ObjoScript.TokenTypes.Var_
		    Return "var"
		    
		  Case ObjoScript.TokenTypes.While_
		    Return "while"
		    
		  Case ObjoScript.TokenTypes.Xor_
		    Return "xor"
		    
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
		    
		  Case ObjoScript.ValueTypes.ForeignMethod
		    Return "Foreign method"
		    
		  Case ObjoScript.ValueTypes.BoundMethod
		    Return "Bound method"
		    
		  Case ObjoScript.ValueTypes.BoundForeignMethod
		    Return "Bound foreign method"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown value type.")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662060766020697320616E20696E746567657220726570726573656E746564206173206120646F75626C652E
		Protected Function VariantIsIntegerDouble(v As Variant) As Boolean
		  /// Returns True if `v` is an integer represented as a double.
		  
		  If v.Type <> Variant.TypeDouble Then
		    Return False
		  Else
		    Return v.DoubleValue = Floor(v.DoubleValue)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73205472756520696620607660206973206120706F73697469766520696E746567657220726570726573656E746564206173206120646F75626C652E
		Protected Function VariantIsPositiveInteger(v As Variant) As Boolean
		  /// Returns True if `v` is a positive integer represented as a double.
		  
		  If v.Type <> Variant.TypeDouble Then
		    Return False
		  Else
		    If v.DoubleValue = Floor(v.DoubleValue) Then
		      Return v.DoubleValue >= 0.0
		    Else
		      Return False
		    End If
		  End If
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Foreign methods call Xojo methods with this delegate's signature when they are invoked.
		
		The receiver of the method (an ObjoScript instance, if a static method, class) will be placed into the VM's API slot 0.
		The arguments to the method can be found in the VM's slot array sequentially from slot 1 onwards.
		
	#tag EndNote

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
			  ")"    : &h0029, _
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
		Constructor
	#tag EndEnum

	#tag Enum, Name = TokenTypes, Type = Integer, Flags = &h1
		Ampersand
		  And_
		  As_
		  Assert
		  Boolean_
		  Breakpoint
		  Caret
		  Case_
		  Class_
		  Colon
		  Comma
		  Constructor
		  Continue_
		  Do_
		  Dot
		  DotDotLess
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
		  ForEach
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
		  Loop_
		  LParen
		  LSquare
		  Minus
		  MinusEqual
		  MinusMinus
		  None
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
		  Query
		  RCurly
		  Return_
		  RParen
		  RSquare
		  Semicolon
		  Star
		  StarEqual
		  Static_
		  StaticFieldIdentifier
		  String_
		  Super_
		  Switch
		  Then_
		  This
		  Tilde
		  Underscore
		  Until_
		  UppercaseIdentifier
		  Var_
		  While_
		Xor_
	#tag EndEnum

	#tag Enum, Name = ValueTypes, Type = Integer, Flags = &h1
		Func
		  Klass
		  Instance
		  ForeignMethod
		  BoundMethod
		BoundForeignMethod
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
