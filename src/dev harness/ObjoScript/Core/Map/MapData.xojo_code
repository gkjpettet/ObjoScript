#tag Class
Protected Class MapData
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Dict = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620746865206D61702E
		Function ToString() As String
		  /// Returns a string representation of the map.
		  
		  #Pragma Warning "TODO: Implement this properly"
		  
		  Return "Map instance (" + Count.ToString + If(Count = 1, " entry", "entries") + ")"
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206B65797320696E207468652064696374696F6E6172792E
		#tag Getter
			Get
			  Return Dict.keyCount
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652061637475616C20586F6A6F2064696374696F6E61727920636F6E7461696E696E672074686520646174612E
		Dict As Dictionary
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
			Name="Count"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
