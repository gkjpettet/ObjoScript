#tag Class
Protected Class Klass
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(name As String)
		  Self.Name = name
		  Self.Constructors = New Dictionary
		  Self.Methods = ParseJSON("{}") // HACK: Case sensitive.
		  Self.Setters = ParseJSON("{}") // HACK: Case sensitive.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4120756E6971756520696E7465676572206861736820726570726573656E74696E6720746869732076616C75652E
		Function Hash() As Integer
		  /// A unique integer hash representing this value.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Var v As Variant = Self
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320636C6173732E
		Function ToString() As String
		  /// Returns a string representation of this class.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return Name
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Klass
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636C61737320636F6E7374727563746F727320284B6579203D20636F6E7374727563746F722061726974792C2056616C7565203D204F626A6F5363726970742E46756E63292E
		Constructors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520726567756C617220286E6F6E2D7365747465722920636C617373206D6574686F647320284B6579203D206D6574686F64206E616D652C2056616C7565203D204F626A6F5363726970742E46756E63292E
		Methods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C6173732E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652073657474657220636C617373206D6574686F647320284B6579203D206D6574686F64206E616D652C2056616C7565203D204F626A6F5363726970742E46756E63292E
		Setters As Dictionary
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
			Name="Name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
