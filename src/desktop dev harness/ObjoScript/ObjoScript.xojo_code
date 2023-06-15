#tag Module
Protected Module ObjoScript
	#tag Method, Flags = &h0, Description = 52657475726E7320746865206172697479206F662061206D6574686F64207769746820607369676E6174757265602E
		Function ComputeArityFromSignature(signature As String, vm As ObjoScript.VM) As Integer
		  /// Returns the arity of a method with `signature`.
		  
		  // Handle common cases quickly.
		  If signature.Contains("()") Then
		    Return 0
		    
		  ElseIf signature.Contains("(_)") Then
		    Return 1
		    
		  ElseIf signature.Contains("(_,_)") Then
		    Return 2
		  End If
		  
		  Var chars() As String = signature.Split("")
		  Var lparenIndex, rparenIndex As Integer = -1
		  For i As Integer = 0 To chars.LastIndex
		    Select Case chars(i)
		    Case "("
		      If lparenIndex <> -1 Then
		        // We've already seen a `(`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      Else
		        lparenIndex = i
		      End If
		      
		    Case ")"
		      If rparenIndex <> -1 Then
		        // We've already seen a `)`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      ElseIf lparenIndex = -1 Then
		        // We've found a `)` before a `(`.
		        vm.Error("Invalid signature: `" + signature + "`.")
		      Else
		        rparenIndex = i
		      End If
		    End Select
		  Next i
		  
		  If lparenIndex = -1 Or rparenIndex = -1 Then
		    vm.Error("Invalid signature: `" + signature + "`.")
		  End If
		  
		  // Get the contents between the parentheses (e.g. "(_,_,_)" becomes "_,_,_")
		  Var contents As String = signature.Middle(lparenIndex + 1, rparenIndex - lparenIndex - 1)
		  
		  If contents.Contains("_") Then
		    Return contents.Split("_").Count - 1
		  Else
		    Return 0
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D707574657320612066756E6374696F6E2F6D6574686F64207369676E617475726520676976656E20697473206E616D6520616E642061726974792E
		Function ComputeSignature(name As String, arity As Integer, isSetter As Boolean) As String
		  /// Computes a function/method signature given its name and arity.
		  
		  If isSetter And arity <> 1 Then
		    Raise New InvalidArgumentException("Setters must have exactly one parameter.")
		  End If
		  
		  If arity = 0 Then Return name + "()"
		  
		  Var sig As String = name + If(isSetter, "=", "") + "("
		  
		  For i As Integer = 1 To arity
		    sig = sig + "_"
		    If i < arity Then sig = sig + ","
		  Next i
		  
		  Return sig + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6D7075746573206120737562736372697074207369676E617475726520676976656E206974732061726974792E
		Function ComputeSubscriptSignature(arity As Integer, isSetter As Boolean) As String
		  /// Computes a subscript signature given its arity.
		  ///
		  /// If this is a subscript setter then the arity is one greater than the 
		  /// index count (since the last parameter is the value to assign).
		  /// Examples:
		  /// ```
		  /// [index, indexN]
		  /// [index, indexN]=(value)
		  /// ```
		  
		  If isSetter And arity < 2 Then
		    Raise New InvalidArgumentException("Subscript setters must have at least two parameters.")
		  End If
		  
		  Var sig As String = "["
		  
		  Var paramCount As Integer = If(isSetter, arity - 1, arity)
		  
		  For i As Integer = 1 To paramCount
		    sig = sig + "_"
		    If i < paramCount Then sig = sig + ","
		  Next i
		  
		  sig = sig + "]"
		  
		  If isSetter Then
		    sig = sig + "=(_)"
		  End If
		  
		  Return sig
		  
		End Function
	#tag EndMethod

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

	#tag DelegateDeclaration, Flags = &h1, Description = 496E766F6B6564207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C61737320697320636F6E73747275637465642E204F6363757273206265666F726520616E79204F626A6F5363726970742D646566696E656420636C61737320636F6E7374727563746F72732061726520696E766F6B65642E
		Protected Delegate Sub ForeignAllocateDelegate(vm As ObjoScript . VM, instance As ObjoScript . Instance, arguments() As Variant)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1, Description = 496E766F6B6564207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C6173732069732064657374726F7965642E20606461746160206973207468652068696464656E20666F726569676E2064617461206173736F6369617465642077697468207468697320696E7374616E63652E206064617461602063616E206265206D616E6970756C617465642062792063616C6C696E6720586F6A6F20636F646520627574206E6F74206279204F626A6F5363726970742E
		Protected Delegate Sub ForeignDestroyDelegate(data As Variant)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h1, Description = 416E20696E766F6B61626C6520666F726569676E2028586F6A6F20636F646529206D6574686F642E
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

	#tag Method, Flags = &h0, Description = 52657475726E73207468652068756D616E2D7265616461626C65206E616D65206F6620616E206F70636F64652E
		Function ToString(Extends opcode As ObjoScript.VM.Opcodes) As String
		  /// Returns the human-readable name of an opcode.
		  
		  Select Case opcode
		  Case VM.Opcodes.Add
		    Return "Add"
		    
		  Case VM.Opcodes.Add1
		    Return "Add1"
		    
		  Case VM.Opcodes.Assert
		    Return "Assert"
		    
		  Case VM.Opcodes.BitwiseAnd
		    Return "BitwiseAnd"
		    
		  Case VM.Opcodes.BitwiseNot
		    Return "BitwiseNot"
		    
		  Case VM.Opcodes.BitwiseOr
		    Return "BitwiseOr"
		    
		  Case VM.Opcodes.BitwiseXor
		    Return "BitwiseXor"
		    
		  Case VM.Opcodes.Breakpoint
		    Return "Breakpoint"
		    
		  Case VM.Opcodes.Call_
		    Return "Call"
		    
		  Case VM.Opcodes.Class_
		    Return "Class"
		    
		  Case VM.Opcodes.ConstantLong
		    Return "ConstantLong"
		    
		  Case VM.Opcodes.Constant_
		    Return "Constant"
		    
		  Case VM.Opcodes.Constructor_
		    Return "Constructor"
		    
		  Case VM.Opcodes.DebugFieldName
		    Return "DebugFieldName"
		    
		  Case VM.Opcodes.DefineGlobal
		    Return "DefineGlobal"
		    
		  Case VM.Opcodes.DefineGlobalLong
		    Return "DefineGlobalLong"
		    
		  Case VM.Opcodes.DefineNothing
		    Return "DefineNothing"
		    
		  Case VM.Opcodes.Divide
		    Return "Divide"
		    
		  Case VM.Opcodes.Equal
		    Return "Equal"
		    
		  Case VM.Opcodes.Exit_
		    Return "Exit"
		    
		  Case VM.Opcodes.False_
		    Return "False"
		    
		  Case VM.Opcodes.ForeignMethod
		    Return "ForeignMethod"
		    
		  Case VM.Opcodes.GetField
		    Return "GetField"
		    
		  Case VM.Opcodes.GetGlobal
		    Return "GetGlobal"
		    
		  Case VM.Opcodes.GetGlobalLong
		    Return "GetGLobalLong"
		    
		  Case VM.Opcodes.GetLocal
		    Return "GetLocal"
		    
		  Case VM.Opcodes.GetLocalClass
		    Return "GetLocalClass"
		    
		  Case VM.Opcodes.GetStaticField
		    Return "GetStaticField"
		    
		  Case VM.Opcodes.GetStaticFieldLong
		    Return "GetStaticFieldLong"
		    
		  Case VM.Opcodes.Greater
		    Return "Greater"
		    
		  Case VM.Opcodes.GreaterEqual
		    Return "GreaterEqual"
		    
		  Case VM.Opcodes.Inherit
		    Return "Inherit"
		    
		  Case VM.Opcodes.Invoke
		    Return "Invoke"
		    
		  Case VM.Opcodes.InvokeLong
		    Return "InvokeLong"
		    
		  Case VM.Opcodes.Is_
		    Return "Is"
		    
		  Case VM.Opcodes.Jump
		    Return "Jump"
		    
		  Case VM.Opcodes.JumpIfFalse
		    Return "JumpIfFalse"
		    
		  Case VM.Opcodes.JumpIfTrue
		    Return "JumpIfTrue"
		    
		  Case VM.Opcodes.KeyValue
		    Return "KeyValue"
		    
		  Case VM.Opcodes.Less
		    Return "Less"
		    
		  Case VM.Opcodes.LessEqual
		    Return "LessEqual"
		    
		  Case VM.Opcodes.List
		    Return "List"
		    
		  Case VM.Opcodes.Load0
		    Return "Load0"
		    
		  Case VM.Opcodes.Load1
		    Return "Load1"
		    
		  Case VM.Opcodes.Load2
		    Return "Load2"
		    
		  Case VM.Opcodes.LoadMinus1
		    Return "LoadMinus1"
		    
		  Case VM.Opcodes.LoadMinus2
		    Return "LoadMinus2"
		    
		  Case VM.Opcodes.LocalVarDecl
		    Return "LocalVarDecl"
		    
		  Case VM.Opcodes.LogicalXor
		    Return "LogicalXor"
		    
		  Case VM.Opcodes.Loop_
		    Return "Loop"
		    
		  Case VM.Opcodes.Map
		    Return "Map"
		    
		  Case VM.Opcodes.Method
		    Return "Method"
		    
		  Case VM.Opcodes.Modulo
		    Return "Modulo"
		    
		  Case VM.Opcodes.Multiply
		    Return "Multiply"
		    
		  Case VM.Opcodes.Negate
		    Return "Negate"
		    
		  Case VM.Opcodes.Not_
		    Return "Not"
		    
		  Case VM.Opcodes.NotEqual
		    Return "NotEqual"
		    
		  Case VM.Opcodes.Nothing
		    Return "Nothing"
		    
		  Case VM.Opcodes.Pop
		    Return "Pop"
		    
		  Case VM.Opcodes.PopN
		    Return "PopN"
		    
		  Case VM.Opcodes.RangeExclusive
		    Return "RangeExclusive"
		    
		  Case VM.Opcodes.RangeInclusive
		    Return "RangeInclusive"
		    
		  Case VM.Opcodes.Return_
		    Return "Return"
		    
		  Case VM.Opcodes.SetField
		    Return "SetField"
		    
		  Case VM.Opcodes.SetGlobal
		    Return "setGlobal"
		    
		  Case VM.Opcodes.SetGlobalLong
		    Return "SetGlobalLong"
		    
		  Case VM.Opcodes.SetLocal
		    Return "setLocal"
		    
		  Case VM.Opcodes.SetStaticField
		    Return "SetStaticField"
		    
		  Case VM.Opcodes.SetStaticFieldLong
		    Return "SetStaticFieldLong"
		    
		  Case VM.Opcodes.ShiftLeft
		    Return "ShiftLeft"
		    
		  Case VM.Opcodes.ShiftRight
		    Return "ShiftRight"
		    
		  Case VM.Opcodes.Subtract
		    Return "Subtract"
		    
		  Case VM.Opcodes.Subtract1
		    Return "Subtract1"
		    
		  Case VM.Opcodes.SuperConstructor
		    Return "SuperConstructor"
		    
		  Case VM.Opcodes.SuperInvoke
		    Return "SuperInvoke"
		    
		  Case VM.Opcodes.SuperSetter
		    Return "SuperSetter"
		    
		  Case VM.Opcodes.Swap
		    Return "Swap"
		    
		  Case VM.Opcodes.True_
		    Return "True"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown opcode.")
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

	#tag Note, Name = Foreign class delegates
		ForeignAllocateDelegate
		-----------------------
		Invoked when an instance of a foreign class is constructed. 
		Invoked before any ObjoScript-defined class constructors are invoked.
		
		ForeignMethodDelegate
		---------------------
		An invokable Xojo-method that can be called via a call handle.
		
		ForeignDestroyDelegate(data as Variant)
		---------------------------------------
		Invoked when an instance of a foreign class is destroyed. 
		`data` is the hidden foreign data associated with this instance. 
		`data` can be manipulated by calling Xojo code but not by ObjoScript.
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


	#tag Constant, Name = Version, Type = String, Dynamic = False, Default = \"2.0.0", Scope = Protected, Description = 5468652073656D616E7469632076657273696F6E2E
	#tag EndConstant


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
