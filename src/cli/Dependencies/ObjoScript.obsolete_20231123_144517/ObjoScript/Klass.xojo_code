#tag Class
Protected Class Klass
Implements ObjoScript.Value,ObjoScript.MethodReceiver
	#tag Method, Flags = &h0
		Sub Constructor(name As String, isForeign As Boolean, fieldCount As Integer, firstFieldIndex As Integer)
		  Self.Name = name
		  Self.Methods = ParseJSON("{}") // HACK: Case sensitive.
		  Self.StaticMethods = ParseJSON("{}") // HACK: Case sensitive.
		  Self.StaticFields = ParseJSON("{}") // HACK: Case sensitive.
		  Self.IsForeign = isForeign
		  Self.FieldCount = fieldCount
		  Self.FirstFieldIndex = firstFieldIndex
		  Self.Fields.ResizeTo(fieldCount - 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612028686F706566756C6C792920756E6971756520686173682076616C756520666F72207468697320636C6173732E
		Function Hash() As Integer
		  /// Returns a (hopefully) unique hash value for this class.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return Variant(Self).Hash
		  
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


	#tag Property, Flags = &h0, Description = 54686520636C61737320636F6E7374727563746F72732E2054686520696E6465782069732074686520617267756D656E7420636F756E742E
		Constructors() As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746F74616C206E756D626572206F6620696E7374616E6365206669656C64732075736564206279207468697320636C6173732028696E636C7564696E6720696E68657269746564206669656C6473292E
		FieldCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53746F72657320746865206E616D6573206F66207468697320636C61737327206669656C64732E204F6E6C7920696E6465786573203E3D206046697273744669656C64496E64657860206172652076616C69642E20546869732070726F7065727479206973206F6E6C792075736564207768656E20646562756767696E6720616E642077696C6C206F6E6C792062652076616C69642069662074686520564D2069732072756E6E696E6720612064656275676761626C65206368756E6B2E
		Fields() As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E64657820696E20604669656C647360206F6620746865206669727374206F66207468697320636C61737327206669656C64732E204C6F77657220696E646578657320696E64696361746520746865206669656C642062656C6F6E677320746F20746865207375706572636C617373206869657261726368792E
		FirstFieldIndex As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662074686973206973206120666F726569676E20636C6173732C207468657365206172652074686520636C6173732064656C65676174657320746F2063616C6C2075706F6E20696E7374616E74696174696F6E20616E64206465737472756374696F6E2E204D6179206265204E696C2E
		ForeignDelegates As ObjoScript.ForeignClassDelegates
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120666F726569676E20636C6173732E
		IsForeign As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C6173732720696E7374616E6365206D6574686F647320284B6579203D207369676E61747572652C2056616C7565203D206046756E6360206F722060466F726569676E4D6574686F6460292E
		Methods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C6173732E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C6173732720737461746963206669656C647320284B6579203D206E616D652C2056616C7565203D2056617269616E74292E
		StaticFields As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C617373272073746174696320636C617373206D6574686F647320284B6579203D206D6574686F64206E616D652C2056616C7565203D206046756E6360206F722060466F726569676E4D6574686F6460292E
		StaticMethods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C61737327207375706572636C6173732E204D6179206265204E696C2E
		Superclass As ObjoScript.Klass
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
		#tag ViewProperty
			Name="IsForeign"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FieldCount"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FirstFieldIndex"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
