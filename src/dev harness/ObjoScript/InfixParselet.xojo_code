#tag Interface
Protected Interface InfixParselet
	#tag Method, Flags = &h0, Description = 50617273657320616E2065787072657373696F6E206F6363757272696E67206166746572207468652070726F766964656420606C65667460206F706572616E642E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, token As ObjoScript.Token) As ObjoScript.Token
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		An InfixParselet is associated with a token that appears in the middle of the
		expression it parses. Its `Parse()` method will be called after the left-hand
		side has been parsed, and it in turn is responsible for parsing everything
		that comes after the token. 
		
		This is also used for postfix expressions, in which case it simply doesn't consume 
		any more tokens in its `Parse()` call.
		
		
	#tag EndNote


End Interface
#tag EndInterface
