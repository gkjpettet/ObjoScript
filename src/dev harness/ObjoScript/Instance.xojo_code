#tag Class
Protected Class Instance
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(vm As ObjoScript.VM, klass As ObjoScript.Klass)
		  Self.Klass = klass
		  mName = Self.Klass.Name + " instance"
		  
		  // Fields are initialised to nothing.
		  Fields.ResizeTo(klass.FieldCount - 1)
		  For i As Integer = 0 To Fields.LastIndex
		    Fields(i) = vm.Nothing
		  Next i
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320696E7374616E63652E
		Function ToString() As String
		  /// Returns a string representation of this instance.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Instance
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 5468697320696E7374616E63652773206669656C64732E204C6F77657220696E6465786573206D6179206265206669656C6473207574696C69736564206279207375706572636C61737365732E
		Fields() As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966207468697320697320616E20696E7374616E6365206F66206120666F726569676E20636C6173732C2074686973206973207573656420746F2073746F726520616E7920696E7374616E636520646174612E204974206973206F6E6C792061636365737365642062792074686520686F7374206170706C69636174696F6E2E
		ForeignData As Variant
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 41207265666572656E636520746F207468697320696E7374616E6365277320636C6173732E
		Klass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468697320696E7374616E6365277320707265636F6D7075746564206E616D6520286372656174656420617420636F6E737472756374696F6E292E
		Private mName As String
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
