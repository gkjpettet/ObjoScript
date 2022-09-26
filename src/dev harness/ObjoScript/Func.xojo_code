#tag Class
Protected Class Func
Implements ObjoScript.Value
	#tag Method, Flags = &h0, Description = 436F6D707574657320612066756E6374696F6E2F6D6574686F64207369676E617475726520676976656E20697473206E616D6520616E642061726974792E
		Shared Function ComputeSignature(name As String, arity As Integer) As String
		  /// Computes a function/method signature given its name and arity.
		  
		  If arity = 0 Then Return name + "()"
		  
		  Var sig As String = name + "("
		  
		  For i As Integer = 1 To arity
		    sig = sig + "_"
		    If i < arity Then sig = sig + ","
		  Next i
		  
		  Return sig + ")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(name As String, arity As Integer, isSetter As Boolean = False)
		  Self.Name = name
		  Self.Arity = arity
		  Self.Chunk = New ObjoScript.Chunk
		  mSignature = ComputeSignature(name, arity)
		  Self.IsSetter = isSetter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  /// Returns a string representation of this function.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mSignature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Func
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E756D626572206F6620617267756D656E747320746869732066756E6374696F6E2072657175697265732E
		Arity As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206368756E6B206F662062797465636F64652E
		Chunk As ObjoScript.Chunk
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686973206973206120736574746572206D6574686F642E20536574746572732063616E20626520696E766F6B656420696D6D6564696174656C79206265666F726520616E20603D60207369676E2E
		IsSetter As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSignature As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546869732066756E6374696F6E2773206E616D652E
		Name As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546869732066756E6374696F6E2773207369676E61747572652E
		#tag Getter
			Get
			  Return mSignature
			End Get
		#tag EndGetter
		Signature As String
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
		#tag ViewProperty
			Name="Arity"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Signature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsSetter"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
