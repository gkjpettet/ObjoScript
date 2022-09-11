#tag Class
Protected Class ASTTreeView
Inherits DesktopTreeView
Implements ObjoScript.ExprVisitor,ObjoScript.StmtVisitor
	#tag Method, Flags = &h0
		Function VisitBinary(expr As ObjoScript.BinaryExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Binary (" + expr.Operator.ToString + ")")
		  
		  Var left As TreeViewNode = expr.Left.Accept(Self)
		  left.Text = "Left: " + left.Text
		  
		  Var right As TreeViewNode = expr.Right.Accept(Self)
		  right.Text = "Right: " + right.Text
		  
		  node.AppendNode(left)
		  node.AppendNode(right)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBoolean(expr As ObjoScript.BooleanLiteral) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Boolean: " + expr.Value.ToString)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  Me.AppendNode(stmt.Expression.Accept(Self))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitNothing(expr As ObjoScript.NothingLiteral) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  #Pragma Unused expr
		  
		  Var node As New TreeViewNode("Nothing")
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitNumber(expr As ObjoScript.NumberLiteral) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var value As String
		  If expr.IsInteger Then
		    value = expr.Value.ToString(Locale.Current, "#")
		  Else
		    value = expr.Value.ToString
		  End If
		  
		  Var node As New TreeViewNode("Number: " + value)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitPostfix(expr As ObjoScript.PostfixExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Postfix (" + expr.Operator.ToString + ")")
		  
		  node.AppendNode(expr.Operand.Accept(Self))
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitPrintStmt(stmt As ObjoScript.PrintStmt) As Variant
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  Var node As New TreeViewNode("Print")
		  
		  node.AppendNode(stmt.Expression.Accept(Self))
		  
		  Me.AppendNode(node)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitString(expr As ObjoScript.StringLiteral) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("String: " + expr.Value)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitUnary(expr As ObjoScript.UnaryExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Unary (" + expr.Operator.ToString + ")")
		  
		  node.AppendNode(expr.Operand.Accept(Self))
		  
		  Return node
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="171"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="200"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasSelectionColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasInactiveSelectionColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveSelectionColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacHighlightFullRow"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacExpanderStyle"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Native Triangles"
				"1 - Plus"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacDrawTreeLines"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WinHighlightFullRow"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WinDrawTreeLines"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LinuxHighlightFullRow"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LinuxExpanderStyle"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Native Triangles"
				"1 - Plus"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="LinuxDrawTreeLines"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MultiSelection"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBackColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkBackColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Single"
			EditorType="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inches"
				"4 - Millimeters"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DragReceiveBehavior"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - AllNodes"
				"1 - DirectoryNodes"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="NodeHeight"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasNodeColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NodeEvenColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NodeOddColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SystemNodeColors"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasNodeTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NodeTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkNodeTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionSeparator"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Disabled"
				"1 - Mac"
				"2 - Windows"
				"3 - Mac and Windows"
				"4 - Linux"
				"5 - Mac and Linux"
				"6 - Windows and Linux"
				"7 - Mac, Windows and Linux"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="QuartzShading"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasSelectionTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DarkSelectionTextColor"
			Visible=true
			Group="Colors"
			InitialValue=""
			Type="Color"
			EditorType="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
