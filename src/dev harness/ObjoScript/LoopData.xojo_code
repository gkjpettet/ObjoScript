#tag Class
Protected Class LoopData
	#tag Note, Name = About
		Stores book-keeping information about the current loop being compiled. 
		
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 4F6666736574206F662074686520666972737420696E737472756374696F6E206F662074686520626F6479206F6620746865206C6F6F702E
		BodyOffset As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C6F6F7020656E636C6F73696E672074686973206F6E65206F72204E696C206966207468697320697320746865206F757465726D6F7374206C6F6F702E
		Enclosing As ObjoScript.LoopData
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4F6666736574206F662074686520617267756D656E7420666F7220746865206A756D7020696E737472756374696F6E207573656420746F206578697420746865206C6F6F702E2053746F72656420736F2077652063616E207061746368206974206F6E6365207765206B6E6F7720776865726520746865206C6F6F7020656E64732E
		ExitJump As Integer
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4465707468206F66207468652073636F70652873292074686174206E65656420746F2062652065786974656420696620616E206065786974602069732068697420696E7369646520746865206C6F6F702E
		ScopeDepth As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 496D6E646578206F662074686520696E737472756374696F6E207468617420746865206C6F6F702073686F756C64206A756D70206261636B20746F2E
		Start As Integer
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
