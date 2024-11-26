#tag Class
Protected Class BoundMethod
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(receiver As ObjoScript.MethodReceiver, method As ObjoScript.Method, arity As Integer, isStatic As Boolean, isForeign As Boolean)
		  Self.Receiver = receiver
		  Self.Method = method
		  Self.Arity = arity
		  Self.IsStatic = isStatic
		  Self.IsForeign = isForeign
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612028686F706566756C6C792920756E6971756520686173682076616C756520666F72207468697320626F756E64206D6574686F642E
		Function Hash() As Integer
		  /// Returns a (hopefully) unique hash value for this bound method.
		  ///
		  /// We hash and combine a few of this object's properties in a balance between 
		  /// true uniqueness and the time is takes to hash.
		  /// Part of the ObjoScript.Value interface.
		  
		  Var v As Variant = Self
		  
		  Return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320626F756E64206D6574686F642E
		Function ToString() As String
		  /// Returns a string representation of this bound method.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  If IsForeign Then
		    Return ObjoScript.ForeignMethod(Method).ToString
		  Else
		    Return ObjoScript.Func(Method).ToString
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As ObjoScript.ValueTypes
		  /// Part of the ObjoScript.Value interface.
		  
		  If IsForeign Then
		    Return ObjoScript.ValueTypes.BoundForeignMethod
		  Else
		    Return ObjoScript.ValueTypes.BoundMethod
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Arity As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120666F726569676E206D6574686F64206F722046616C73652069662069742773206E6174697665204F626A6F53637269707420636F64652E
		IsForeign As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120737461746963206D6574686F64206F722046616C7365206966206974277320616E20696E7374616E6365206D6574686F642E
		IsStatic As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 4966204973466F726569676E207468656E207468697320697320612060466F726569676E4D6574686F64602C206F746865727769736520697427732061206046756E63602E
		Method As ObjoScript.Method
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636C617373206F7220696E7374616E63652074686973206D6574686F6420697320626F756E6420746F2E
		Receiver As ObjoScript.MethodReceiver
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
			Name="IsForeign"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsStatic"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
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
	#tag EndViewBehavior
End Class
#tag EndClass
