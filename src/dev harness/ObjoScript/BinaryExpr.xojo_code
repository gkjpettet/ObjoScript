#tag Class
Protected Class BinaryExpr
Implements ObjoScript.Expr
	#tag Method, Flags = &h0
		Sub Constructor(left As ObjoScript.Expr, operator As ObjoScript.Token, right As ObjoScript.Expr)
		  Self.Left = left
		  mLocation = operator
		  Self.Right = right
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Location() As ObjoScript.Token
		  /// Part of the ObjoScript.Expr interface.
		  
		  Return mLocation
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206C6566742068616E64206F706572616E642E
		Left As ObjoScript.Expr
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520746F6B656E20726570726573656E74696E672074686520756E617279206F70657261746F7220696E20746865206F726967696E616C20746F6B656E2073747265616D2E
		Private mLocation As ObjoScript.Token
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652062696E617279206F70657261746F7220747970652E
		#tag Getter
			Get
			  Return mLocation.Type
			End Get
		#tag EndGetter
		Operator As ObjoScript.TokenTypes
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652072696768742068616E64206F706572616E642E
		Right As ObjoScript.Expr
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
			Name="Operator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ObjoScript.TokenTypes"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
