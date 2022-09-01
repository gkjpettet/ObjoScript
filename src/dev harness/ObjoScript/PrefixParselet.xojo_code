#tag Interface
Protected Interface PrefixParselet
	#tag Method, Flags = &h0, Description = 50617273657320616E2065787072657373696F6E206F6363757272696E67206166746572207468652070726F76696465642060746F6B656E602E
		Function Parse(parser As ObjoScript.Parser, token As ObjoScript.Token) As ObjoScript.Expr
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		A PrefixParselet is associated with a token that appears at the beginning of an expression. 
		Its `Parse()` method will be called with the consumed leading token, and the
		parselet is responsible for parsing anything that comes after that token.
		
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
