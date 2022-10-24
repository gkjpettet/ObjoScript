#tag Class
Protected Class XUICELineToken
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor(startAbsolute As Integer, startLocal As Integer, length As Integer, lineNumber As Integer, type As String = "default", fallback As String = "default")
		  /// Default constructor.
		  ///
		  /// - `startAbsolute` is the absolute 0-based position of the start of this token within
		  ///   the original source code.
		  /// - `startLocal` is the 0-based position on this token's line that this token starts at.
		  /// - `length` is the length of this token in characters.
		  /// - `lineNumber` is the 1-based line number this token is on.
		  /// - `type` is this token's type as a string. This is used in themes to style 
		  ///   the token in the editor.
		  /// - `fallback` is the token's fallback type to use if `type` isn't available in the current theme.
		  
		  Self.StartAbsolute = startAbsolute
		  Self.StartLocal = startLocal
		  Self.Length = length
		  Self.LineNumber = lineNumber
		  Self.Type = type
		  Self.FallbackType = fallback
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54727565206966207468697320746F6B656E2068617320646174612077697468207468652073706563696669656420286361736520696E73656E7369746976652920606B6579602E
		Function HasDataKey(key As String) As Boolean
		  /// True if this token has data with the specified (case insensitive) `key`.
		  
		  If mData = Nil Then Return False
		  Return mData.HasKey(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520646174612076616C7565206173736F636961746564207769746820606B657960206F72206064656661756C7460206966207468657265206973206E6F206D61746368696E67206B65792E
		Function LookupData(key As String, default As Variant) As Variant
		  /// Returns the data value associated with `key` or `default` if there is no matching key.
		  
		  If mData = Nil Then Return Default
		  Return mData.Lookup(key, Default)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5365747320746865206461746120606B65796020746F206076616C7565602E2057696C6C206F766572777269746520746865206578697374696E672076616C7565206F6620606B65796020696620616C7265616479207365742E
		Sub SetData(key As String, value As Variant)
		  /// Sets the data `key` to `value`. Will overwrite the existing value of `key` if already set.
		  
		  If mData = Nil Then mData = New Dictionary
		  mData.Value(key) = value
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		Represents a token in the code editor.
		
		Whenever text is entered / edited in the code editor it is _tokenised_ into _tokens_. A
		token is the atomic unit of styling in the editor and they are generated by _formatters_.
		
		Tokens contain data that tells the code editor their position in the code editor and their
		_type_. A token's type determine's how it is styled by the editor (e.g. the colour of text, 
		whether it is bold, etc).
		
	#tag EndNote


	#tag ComputedProperty, Flags = &h0, Description = 302D626173656420706F736974696F6E206F662074686520656E64206F66207468697320746F6B656E206C6F63616C20746F2074686973206C696E652E
		#tag Getter
			Get
			  Return StartLocal + Length
			End Get
		#tag EndGetter
		EndLocal As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 54686520746F6B656E207479706520746F20757365206966207468652063757272656E74207468656D6520646F65736E277420737570706F727420746865207072696D61727920225479706522207374796C652E
		FallbackType As String = "default"
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206C656E677468206F66207468697320746F6B656E20696E20636861726163746572732E
		Length As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520312D6261736564206E756D626572206F6620746865206C696E65207468697320746F6B656E2062656C6F6E677320746F2E
		LineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 4261636B696E672064696374696F6E61727920666F7220616E79206172626974726172792064617461207468697320746F6B656E206D617920636F6E7461696E2E
		Protected mData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206162736F6C75746520302D626173656420737461727420706F736974696F6E206F66207468697320746F6B656E20696E20746865206F726967696E616C20736F7572636520746578742E
		StartAbsolute As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520302D6261736564206C6F63616C20706F736974696F6E206F66207468697320746F6B656E2077686572652060306020697320746865207374617274206F662074686973206C696E652E
		StartLocal As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320746F6B656E277320747970652E205573656420746F2064657465726D696E6520686F7720746F207374796C652069742E
		Type As String = "default"
	#tag EndProperty


	#tag Constant, Name = TYPE_COMMENT, Type = String, Dynamic = False, Default = \"comment", Scope = Public, Description = 5468652067656E6572696320636F6D6D656E7420746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_DEFAULT, Type = String, Dynamic = False, Default = \"default", Scope = Public, Description = 5468652064656661756C7420746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_ERROR, Type = String, Dynamic = False, Default = \"error", Scope = Public, Description = 546865206572726F7220746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_IDENTIFIER, Type = String, Dynamic = False, Default = \"identifier", Scope = Public, Description = 5468652067656E65726963206964656E74696669657220746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_KEYWORD, Type = String, Dynamic = False, Default = \"keyword", Scope = Public, Description = 5468652067656E65726963206B6579776F726420746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_NUMBER, Type = String, Dynamic = False, Default = \"number", Scope = Public, Description = 5468652067656E65726963206E756D62657220746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_OPERATOR, Type = String, Dynamic = False, Default = \"operator", Scope = Public, Description = 5468652067656E65726963206F70657261746F7220746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant

	#tag Constant, Name = TYPE_STRING, Type = String, Dynamic = False, Default = \"string", Scope = Public, Description = 5468652067656E6572696320737472696E6720746F6B656E20747970652E2047756172616E7465656420746F20626520646566696E65642077697468696E20612076616C6964207468656D652E
	#tag EndConstant


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
			Name="EndLocal"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Length"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartAbsolute"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartLocal"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="default"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FallbackType"
			Visible=false
			Group="Behavior"
			InitialValue="default"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
