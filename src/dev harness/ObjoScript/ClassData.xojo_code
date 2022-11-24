#tag Class
Protected Class ClassData
	#tag Method, Flags = &h0
		Sub Constructor(declaration As ObjoScript.ClassDeclStmt, superclass As ObjoScript.ClassData)
		  Self.Declaration = declaration
		  
		  // Stores the names of instance fields used by this class.
		  Self.Fields.ResizeTo(-1)
		  
		  // In the runtime, this is the index in the instance's `Fields` array that its accessible fields
		  // start at. Lower indexes are fields available only to its superclass(es).
		  If superclass = Nil Then
		    Self.FieldStartIndex = 0
		  Else
		    Self.Superclass = superclass
		    Self.FieldStartIndex = Self.Superclass.FieldStartIndex + Self.Superclass.FieldCount
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520696E64657820696E20604669656C647360206F6620606669656C6460206F7220602D3160206966206E6F7420666F756E642E
		Function IndexOfField(field As String) As Integer
		  /// The index in `Fields` of `field` or `-1` if not found.
		  
		  For i As Integer = 0 To Self.Fields.LastIndex
		    If Fields(i).CompareCase(field) Then
		      Return i
		    End If
		  Next i
		  
		  Return -1
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About
		Stores data about the current class being compiled.
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520636C617373206465636C617261746174696F6E2073746174656D656E742067656E65726174656420627920746865207061727365722E
		Declaration As ObjoScript.ClassDeclStmt
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F6620696E7374616E6365206669656C64732063726561746564206279207468697320636C6173732E
		#tag Getter
			Get
			  Return Fields.Count
			End Get
		#tag EndGetter
		FieldCount As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 546865206E616D6573206F6620616C6C20696E7374616E6365206669656C64732063726561746564206279207468697320636C61737320696E20746865206F7264657220746865792061726520637265617465642E
		Fields() As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E64657820696E20604669656C6473602074686174206669656C64732062656C6F6E67696E6720746F20696E7374616E636573206F66207468697320636C6173732073746172742061742E204561726C69657220696E646578657320617265207573656420627920636C617373657320667572746865722075702074686520636C617373206869657261726368792E
		FieldStartIndex As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206E616D65206F66207468697320636C6173732E
		#tag Getter
			Get
			  Return Declaration.Name
			End Get
		#tag EndGetter
		Name As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 4F7074696F6E616C20646174612061626F7574207468697320636C61737327207375706572636C6173732E204D6179206265204E696C2E
		Superclass As ObjoScript.ClassData
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520746F74616C206E756D626572206F66206669656C64732075736564206279207468697320636C61737320616E642069747320656E74697265206869657261726368792E
		#tag Getter
			Get
			  Return FieldStartIndex + FieldCount
			End Get
		#tag EndGetter
		TotalFieldCount As Integer
	#tag EndComputedProperty


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
