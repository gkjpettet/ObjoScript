#tag Class
Protected Class CallFrame
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Func = Nil
		  Self.IP = 0
		  Self.StackBase = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(func As ObjoScript.Func, ip As Integer, stackBase As Integer)
		  Self.Func = func
		  Self.IP = ip
		  Self.StackBase = stackBase
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
			Name="Func"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
