#tag Interface
Protected Interface PrefixParselet
	#tag Method, Flags = &h0, Description = 5061727365732061207072656669782065787072657373696F6E2E20417373756D6573207468652070726566697820746F6B656E20686173206A757374206265656E20636F6E73756D656420627920746865206070617273657260207768656E2074686973206D6574686F642069732063616C6C65642E
		Function Parse(parser As ObjoScript.Parser) As ObjoScript.Expr
		  
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
