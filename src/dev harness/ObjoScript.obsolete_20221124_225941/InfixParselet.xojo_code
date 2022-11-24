#tag Interface
Protected Interface InfixParselet
	#tag Method, Flags = &h0, Description = 50617273657320616E2065787072657373696F6E206F6363757272696E67206166746572207468652070726F766964656420606C65667460206F706572616E642E20417373756D65732074686520696E66697820746F6B656E20686173206A757374206265656E20636F6E73756D656420627920746865207061727365722E
		Function Parse(parser As ObjoScript.Parser, left As ObjoScript.Expr, canAssign As Boolean) As ObjoScript.Expr
		  
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
End Interface
#tag EndInterface
