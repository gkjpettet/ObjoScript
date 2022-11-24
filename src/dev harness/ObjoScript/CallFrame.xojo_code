#tag Class
Protected Class CallFrame
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Func = Nil
		  Self.IP = 0
		  Self.StackBase = 0
		  Self.Locals = ParseJSON("{}") // HACK: case sensitive dictionary.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(func As ObjoScript.Func, ip As Integer, stackBase As Integer)
		  Self.Func = func
		  Self.IP = ip
		  Self.StackBase = stackBase
		  Self.Locals = ParseJSON("{}") // HACK: case sensitive dictionary.
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a single ongoing function call.
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 546869732063616C6C206672616D6527732066756E6374696F6E2E
		Func As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652063616C6C6572277320696E737472756374696F6E20706F696E7465722E
		IP As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 412064696374696F6E617279206F6620746865206C6F63616C207661726961626C65732063757272656E746C7920696E2073636F70652E204B6579203D207661726961626C65206E616D652028537472696E67292C2056616C7565203D20736C6F7420696E64657820286F66667365742066726F6D20537461636B4261736529206F6620746865206C6F63616C207661726961626C652E
		Locals As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D626173656420696E64657820696E2074686520564D277320737461636B207468617420746869732063616C6C6672616D6520636F6E73696465727320697473202262617365222E204C6F63616C73206172652072656C617469766520746F20746869732E
		StackBase As Integer
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
		#tag ViewProperty
			Name="IP"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackBase"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
