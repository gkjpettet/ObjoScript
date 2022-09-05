#tag Class
Protected Class GrammarRule
	#tag Method, Flags = &h0
		Sub Constructor(prefix As ObjoScript.PrefixParselet, infix As ObjoScript.InfixParselet, precedence As Integer)
		  Self.Prefix = prefix
		  Self.Infix = infix
		  Self.Precedence = precedence
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a grammar rule in the parser table.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 5468652070617273656C657420746F2075736520666F7220616E20696E6669782065787072657373696F6E2077686F7365206C656674206F706572616E6420697320666F6C6C6F77656420627920746869732072756C65277320746F6B656E2E
		Infix As ObjoScript.InfixParselet
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520707265636564656E6365206F6620616E20696E6669782065787072657373696F6E2074686174207573657320746869732072756C65277320746F6B656E20617320616E206F70657261746F722E
		Precedence As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070617273656C657420746F2075736520666F722061207072656669782065787072657373696F6E207374617274696E67207769746820746869732072756C65277320746F6B656E2E
		Prefix As ObjoScript.PrefixParselet
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
End Class
#tag EndClass
