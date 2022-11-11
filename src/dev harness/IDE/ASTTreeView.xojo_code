#tag Class
Protected Class ASTTreeView
Inherits DesktopTreeView
Implements ObjoScript.ExprVisitor,ObjoScript.StmtVisitor
	#tag Method, Flags = &h0, Description = 446973706C61797320606173746020696E20746869732054726565566965772E
		Sub Display(ast() As ObjoScript.Stmt, showStandardLibraryNodes As Boolean)
		  /// Displays `ast` in this TreeView.
		  
		  Me.RemoveAllNodes
		  
		  For Each statement As ObjoScript.Stmt In ast
		    If statement.Location.ScriptID = -1 And Not showStandardLibraryNodes Then Continue
		    Me.AppendNode(statement.Accept(Self))
		  Next statement
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitAssertStmt(stmt As ObjoScript.AssertStmt) As Variant
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  Var node As New TreeViewNode("Assert")
		  
		  node.AppendNode(stmt.Expression.Accept(Self))
		  
		  Return node
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5669736974696E672061207661726961626C652061737369676E6D656E742E
		Function VisitAssignment(expr As ObjoScript.AssignmentExpr) As Variant
		  /// Visiting a variable assignment.
		  
		  Var node As New TreeViewNode("Assign to `" + expr.Name + "`")
		  
		  node.AppendNode(expr.Value.Accept(Self))
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitBareInvocationExpr(bi As ObjoScript.BareInvocationExpr) As Variant
		  Var node As New TreeViewNode("Bare invocation")
		  
		  node.AppendNode(New TreeViewNode("Callee name: " + bi.MethodName))
		  
		  // Optional arguments.
		  If bi.Arguments.Count = 0 Then
		    node.AppendNode(New TreeViewNode("No arguments"))
		  Else
		    Var argNode As New TreeViewNode("Arguments")
		    For Each arg As ObjoScript.Expr In bi.Arguments
		      argNode.AppendNode(arg.Accept(Self))
		    Next arg
		    node.AppendNode(argNode)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

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
		Function VisitBlock(block As ObjoScript.BlockStmt) As Variant
		  Var node As New TreeViewNode("Block")
		  
		  For Each statement As ObjoScript.Stmt In block.Statements
		    node.AppendNode(statement.Accept(Self))
		  Next statement
		  
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
		Function VisitCall(expr As ObjoScript.CallExpr) As Variant
		  Var node As New TreeViewNode("Call")
		  
		  Var calleeNode As New TreeViewNode("Callee")
		  calleeNode.AppendNode(expr.Callee.Accept(Self))
		  node.AppendNode(calleeNode)
		  
		  Var argNode As New TreeViewNode("Arguments")
		  For Each arg As ObjoScript.Expr In expr.Arguments
		    argNode.AppendNode(arg.Accept(Self))
		  Next arg
		  node.AppendNode(argNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617274206F6620746865204F626A6F5363726970742E4578707256697369746F7220696E746572666163652E
		Function VisitClass(c As ObjoScript.ClassExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Return New TreeViewNode("Class: " + c.Name)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitClassDeclaration(c As ObjoScript.ClassDeclStmt) As Variant
		  Var node As New TreeViewNode("Class declaration" + If(c.IsForeign, " (foreign)", ""))
		  
		  // Class name.
		  node.AppendNode(New TreeViewNode("Name: " + c.Name))
		  
		  // Instance methods
		  If c.Methods.Count > 0 Then
		    Var methods As New TreeViewNode("Instance methods")
		    For Each entry As DictionaryEntry In c.Methods
		      Var m As ObjoScript.MethodDeclStmt = entry.Value
		      methods.AppendNode(m.Accept(Self))
		    Next entry
		    node.AppendNode(methods)
		  End If
		  
		  // Static methods
		  If c.StaticMethods.Count > 0 Then
		    Var staticMethods As New TreeViewNode("Static methods")
		    For Each entry As DictionaryEntry In c.StaticMethods
		      Var m As ObjoScript.MethodDeclStmt = entry.Value
		      staticMethods.AppendNode(m.Accept(Self))
		    Next entry
		    node.AppendNode(staticMethods)
		  End If
		  
		  // Foreign methods.
		  If c.ForeignInstanceMethods.Count > 0 Then
		    Var foreignMethods As New TreeViewNode("Foreign instance methods")
		    For Each entry As DictionaryEntry In c.ForeignInstanceMethods
		      Var m As ObjoScript.ForeignMethodDeclStmt = entry.Value
		      foreignMethods.AppendNode(m.Accept(Self))
		    Next entry
		    node.AppendNode(foreignMethods)
		  End If
		  If c.ForeignStaticMethods.Count > 0 Then
		    Var foreignMethods As New TreeViewNode("Foreign static methods")
		    For Each entry As DictionaryEntry In c.ForeignStaticMethods
		      Var m As ObjoScript.ForeignMethodDeclStmt = entry.Value
		      foreignMethods.AppendNode(m.Accept(Self))
		    Next entry
		    node.AppendNode(foreignMethods)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitConstructorDeclaration(c As ObjoScript.ConstructorDeclStmt) As Variant
		  Var node As New TreeViewNode("Constructor")
		  
		  node.AppendNode(New TreeViewNode("Class: " + c.ClassName))
		  
		  // Parameters.
		  Var paramsNode As TreeViewNode
		  If c.Parameters.Count = 0 Then
		    paramsNode = New TreeViewNode("No parameters")
		  Else
		    Var params As String
		    For i As Integer = 0 To c.Parameters.LastIndex
		      params = params + c.Parameters(i).Lexeme
		      If i < c.Parameters.LastIndex Then
		        params = params + ", "
		      End If
		    Next i
		    paramsNode = New TreeViewNode("Parameters: " + params)
		  End If
		  node.AppendNode(paramsNode)
		  
		  // Body.
		  Var bodyNode As TreeViewNode = c.Body.Accept(Self)
		  bodyNode.Text = "Body"
		  node.AppendNode(bodyNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitContinueStmt(stmt As ObjoScript.ContinueStmt) As Variant
		  #Pragma Unused stmt
		  
		  Return New TreeViewNode("Continue")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitExitStmt(stmt As ObjoScript.ExitStmt) As Variant
		  #Pragma Unused stmt
		  
		  Return New TreeViewNode("Exit")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitExpressionStmt(stmt As ObjoScript.ExpressionStmt) As Variant
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  Return stmt.Expression.Accept(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitField(expr As ObjoScript.FieldExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Return New TreeViewNode("Field: " + expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5669736974696E672061206669656C642061737369676E6D656E742E
		Function VisitFieldAssignment(expr As ObjoScript.FieldAssignmentExpr) As Variant
		  /// Visiting a field assignment.
		  
		  Var node As New TreeViewNode("Assign to field `" + expr.Name + "`")
		  
		  node.AppendNode(expr.Value.Accept(Self))
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitForEachStmt(stmt As ObjoScript.ForEachStmt) As Variant
		  Var node As New TreeViewNode("ForEach `" + stmt.LoopCounter.Lexeme + "`")
		  
		  // Range.
		  Var rangeNode As New TreeViewNode("Range:")
		  rangeNode.AppendNode(stmt.Range.Accept(Self))
		  node.AppendNode(rangeNode)
		  
		  // Body.
		  Var body As New TreeViewNode("Body")
		  body.AppendNode(stmt.Body.Accept(Self))
		  node.AppendNode(body)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitForeignMethodDeclaration(fmd As ObjoScript.ForeignMethodDeclStmt) As Variant
		  Var node As New TreeViewNode("Foreign method declaration")
		  
		  node.AppendNode(New TreeViewNode("Name: " + fmd.Name))
		  
		  node.AppendNode(New TreeViewNode("Class: " + fmd.ClassName))
		  
		  node.AppendNode(New TreeViewNode("Is setter: " + If(fmd.IsSetter, "True", "False")))
		  
		  // Parameters.
		  Var paramsNode As TreeViewNode
		  If fmd.Parameters.Count = 0 Then
		    paramsNode = New TreeViewNode("No parameters")
		  Else
		    Var params As String
		    For i As Integer = 0 To fmd.Parameters.LastIndex
		      params = params + fmd.Parameters(i).Lexeme
		      If i < fmd.Parameters.LastIndex Then
		        params = params + ", "
		      End If
		    Next i
		    paramsNode = New TreeViewNode("Parameters: " + params)
		  End If
		  node.AppendNode(paramsNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitForStmt(stmt As ObjoScript.ForStmt) As Variant
		  Var node As New TreeViewNode("For Loop")
		  
		  // Optional initialiser.
		  If stmt.Initialiser <> Nil Then
		    Var initialiser As New TreeViewNode("Initialiser")
		    initialiser.AppendNode(stmt.Initialiser.Accept(Self))
		    node.AppendNode(initialiser)
		  Else
		    node.AppendNode(New TreeViewNode("No initialiser"))
		  End If
		  
		  // Optional condition.
		  If stmt.Condition <> Nil Then
		    Var condition As New TreeViewNode("Condition")
		    condition.AppendNode(stmt.Condition.Accept(Self))
		    node.AppendNode(condition)
		  Else
		    node.AppendNode(New TreeViewNode("No condition"))
		  End If
		  
		  // Optional increment statement.
		  If stmt.Increment <> Nil Then
		    Var increment As New TreeViewNode("Increment statement")
		    increment.AppendNode(stmt.Increment.Accept(Self))
		    node.AppendNode(increment)
		  Else
		    node.AppendNode(New TreeViewNode("No increment statement"))
		  End If
		  
		  // Body.
		  Var body As New TreeViewNode("Body")
		  body.AppendNode(stmt.Body.Accept(Self))
		  node.AppendNode(body)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitFuncDeclaration(f As ObjoScript.FuncDeclStmt) As Variant
		  Var node As New TreeViewNode("Function declaration")
		  
		  // Name.
		  node.AppendNode(New TreeViewNode("Name: " + f.Name.Lexeme))
		  
		  // Parameters.
		  Var paramsNode As TreeViewNode
		  If f.Parameters.Count = 0 Then
		    paramsNode = New TreeViewNode("No parameters")
		  Else
		    Var params As String
		    For i As Integer = 0 To f.Parameters.LastIndex
		      params = params + f.Parameters(i).Lexeme
		      If i < f.Parameters.LastIndex Then
		        params = params + ", "
		      End If
		    Next i
		    paramsNode = New TreeViewNode("Parameters: " + params)
		  End If
		  node.AppendNode(paramsNode)
		  
		  // Body.
		  Var bodyNode As TreeViewNode = f.Body.Accept(Self)
		  bodyNode.Text = "Body"
		  node.AppendNode(bodyNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitIfStmt(ifstmt As ObjoScript.IfStmt) As Variant
		  Var node As New TreeViewNode("If")
		  
		  Var condition As TreeViewNode = New TreeViewNode("Condition")
		  condition.AppendNode(ifstmt.Condition.Accept(Self))
		  node.AppendNode(condition)
		  
		  Var thenBranch As New TreeViewNode("Then")
		  thenBranch.AppendNode(ifstmt.ThenBranch.Accept(Self))
		  node.AppendNode(thenBranch)
		  
		  If ifstmt.ElseBranch <> Nil Then
		    Var elseBranch As New TreeViewNode("Else")
		    elseBranch.AppendNode(ifstmt.ElseBranch.Accept(Self))
		    node.AppendNode(elseBranch)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitIs(expr As ObjoScript.IsExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Is")
		  
		  Var value As TreeViewNode = expr.Value.Accept(Self)
		  value.Text = "Value: " + value.Text
		  
		  Var type As TreeViewNode = expr.Type.Accept(Self)
		  type.Text = "Type: " + type.Text
		  
		  node.AppendNode(value)
		  node.AppendNode(type)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitListLiteral(expr As ObjoScript.ListLiteral) As Variant
		  Var node As TreeViewNode
		  If expr.Elements.Count = 0 Then
		    node = New TreeViewNode("Empty List")
		  Else
		    node = New TreeViewNode("List (" + expr.Elements.Count.ToString + If(expr.Elements.Count = 1, " element)", " elements)"))
		    Var elementsNode As New TreeViewNode("Elements")
		    For Each element As ObjoScript.Expr In expr.Elements
		      elementsNode.AppendNode(element.Accept(Self))
		    Next element
		    node.AppendNode(elementsNode)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitLogical(logical As ObjoScript.LogicalExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode("Logical (" + logical.Operator.ToString + ")")
		  
		  Var left As TreeViewNode = logical.Left.Accept(Self)
		  left.Text = "Left: " + left.Text
		  
		  Var right As TreeViewNode = logical.Right.Accept(Self)
		  right.Text = "Right: " + right.Text
		  
		  node.AppendNode(left)
		  node.AppendNode(right)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitMethodDeclaration(m As ObjoScript.MethodDeclStmt) As Variant
		  Var node As New TreeViewNode("Method declaration")
		  
		  node.AppendNode(New TreeViewNode("Name: " + m.Name))
		  
		  node.AppendNode(New TreeViewNode("Class: " + m.ClassName))
		  
		  node.AppendNode(New TreeViewNode("Is setter: " + If(m.IsSetter, "True", "False")))
		  
		  node.AppendNode(New TreeViewNode("Static: " + If(m.IsStatic, "True", "False")))
		  
		  // Parameters.
		  Var paramsNode As TreeViewNode
		  If m.Parameters.Count = 0 Then
		    paramsNode = New TreeViewNode("No parameters")
		  Else
		    Var params As String
		    For i As Integer = 0 To m.Parameters.LastIndex
		      params = params + m.Parameters(i).Lexeme
		      If i < m.Parameters.LastIndex Then
		        params = params + ", "
		      End If
		    Next i
		    paramsNode = New TreeViewNode("Parameters: " + params)
		  End If
		  node.AppendNode(paramsNode)
		  
		  // Body.
		  Var bodyNode As TreeViewNode = m.Body.Accept(Self)
		  bodyNode.Text = "Body"
		  node.AppendNode(bodyNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitMethodInvocation(m As ObjoScript.MethodInvocationExpr) As Variant
		  Var node As New TreeViewNode("Method invocation")
		  
		  node.AppendNode(New TreeViewNode("Method name: " + m.MethodName))
		  
		  Var operandNode As New TreeViewNode("Operand")
		  operandNode.AppendNode(m.Operand.Accept(Self))
		  node.AppendNode(operandNode)
		  
		  // Optional arguments.
		  If m.Arguments.Count = 0 Then
		    node.AppendNode(New TreeViewNode("No arguments"))
		  Else
		    Var argNode As New TreeViewNode("Arguments")
		    For Each arg As ObjoScript.Expr In m.Arguments
		      argNode.AppendNode(arg.Accept(Self))
		    Next arg
		    node.AppendNode(argNode)
		  End If
		  
		  Return node
		  
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
		Function VisitRange(r As ObjoScript.RangeExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Var node As New TreeViewNode(If(r.Operator.Type = ObjoScript.TokenTypes.DotDot, "Inclusive", "Exclusive") + " range")
		  
		  Var lower As TreeViewNode = r.Lower.Accept(Self)
		  lower.Text = "Lower: " + lower.Text
		  
		  Var upper As TreeViewNode = r.Upper.Accept(Self)
		  upper.Text = "Upper: " + upper.Text
		  
		  node.AppendNode(lower)
		  node.AppendNode(upper)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitReturn(r As ObjoScript.ReturnStmt) As Variant
		  Var node As New TreeViewNode("Return")
		  
		  Var valueNode As New TreeViewNode("Value")
		  valueNode.AppendNode(r.Value.Accept(Self))
		  node.AppendNode(valueNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitStaticField(expr As ObjoScript.StaticFieldExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Return New TreeViewNode("Static field: " + expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5669736974696E67206120737461746963206669656C642061737369676E6D656E742E
		Function VisitStaticFieldAssignment(expr As ObjoScript.StaticFieldAssignmentExpr) As Variant
		  /// Visiting a static field assignment.
		  
		  Var node As New TreeViewNode("Assign to static field `" + expr.Name + "`")
		  
		  node.AppendNode(expr.Value.Accept(Self))
		  
		  Return node
		  
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
		Function VisitSubscript(s As ObjoScript.Subscript) As Variant
		  Var node As New TreeViewNode("Subscript")
		  
		  Var operandNode As New TreeViewNode("Operand")
		  operandNode.AppendNode(s.Operand.Accept(Self))
		  node.AppendNode(operandNode)
		  
		  Var indicesNode As New TreeViewNode("Indices")
		  For Each index As ObjoScript.Expr In s.Indices
		    indicesNode.AppendNode(index.Accept(Self))
		  Next index
		  node.AppendNode(indicesNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSubscriptSetter(s As ObjoScript.SubscriptSetter) As Variant
		  Var node As New TreeViewNode("Subscript Setter")
		  
		  Var operandNode As New TreeViewNode("Operand")
		  operandNode.AppendNode(s.Operand.Accept(Self))
		  node.AppendNode(operandNode)
		  
		  Var indicesNode As New TreeViewNode("Indices")
		  For Each index As ObjoScript.Expr In s.Indices
		    indicesNode.AppendNode(index.Accept(Self))
		  Next index
		  node.AppendNode(indicesNode)
		  
		  Var valueNode As New TreeViewNode("Value to assign")
		  valueNode.AppendNode(s.ValueToAssign.Accept(Self))
		  node.AppendNode(valueNode)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSuperConstructor(s As ObjoScript.SuperConstructorExpr) As Variant
		  Var node As New TreeViewNode("Super constructor")
		  
		  // Optional arguments.
		  If s.Arguments.Count = 0 Then
		    node.AppendNode(New TreeViewNode("No arguments"))
		  Else
		    Var argNode As New TreeViewNode("Arguments")
		    For Each arg As ObjoScript.Expr In s.Arguments
		      argNode.AppendNode(arg.Accept(Self))
		    Next arg
		    node.AppendNode(argNode)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSuperMethodInvocation(s As ObjoScript.SuperMethodInvocationExpr) As Variant
		  Var node As New TreeViewNode("Super method invocation")
		  
		  node.AppendNode(New TreeViewNode("Signature: " + s.Signature))
		  
		  // Optional arguments.
		  If s.Arguments.Count = 0 Then
		    node.AppendNode(New TreeViewNode("No arguments"))
		  Else
		    Var argNode As New TreeViewNode("Arguments")
		    For Each arg As ObjoScript.Expr In s.Arguments
		      argNode.AppendNode(arg.Accept(Self))
		    Next arg
		    node.AppendNode(argNode)
		  End If
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitSuperSetter(s As ObjoScript.SuperSetterExpr) As Variant
		  #Pragma Unused s
		  
		  Var node As New TreeViewNode("Super setter")
		  Var valueNode As New TreeViewNode("Value to assign:")
		  valueNode.AppendNode(s.ValueToAssign.Accept(Self))
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitTernary(t As ObjoScript.TernaryExpr) As Variant
		  Var node As New TreeViewNode("Ternary conditional")
		  
		  Var condition As TreeViewNode = New TreeViewNode("Condition")
		  condition.AppendNode(t.Condition.Accept(Self))
		  node.AppendNode(condition)
		  
		  Var thenBranch As New TreeViewNode("Then")
		  thenBranch.AppendNode(t.ThenBranch.Accept(Self))
		  node.AppendNode(thenBranch)
		  
		  Var elseBranch As New TreeViewNode("Else")
		  elseBranch.AppendNode(t.ElseBranch.Accept(Self))
		  node.AppendNode(elseBranch)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitThis(this As ObjoScript.ThisExpr) As Variant
		  #Pragma Unused this
		  
		  Return New TreeViewNode("This")
		  
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

	#tag Method, Flags = &h0, Description = 50617274206F6620746865204F626A6F5363726970742E53746D7456697369746F7220696E746572666163652E
		Function VisitVarDeclaration(stmt As ObjoScript.VarDeclStmt) As Variant
		  /// Part of the ObjoScript.StmtVisitor interface.
		  
		  Var node As New TreeViewNode("Declare variable")
		  
		  Var nameNode As New TreeViewNode("Name: " + stmt.Name)
		  node.AppendNode(nameNode)
		  
		  Var initialiser As New TreeViewNode("Initialiser")
		  initialiser.AppendNode(stmt.Initialiser.Accept(Self))
		  node.AppendNode(initialiser)
		  
		  Return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitVariable(expr As ObjoScript.VariableExpr) As Variant
		  /// Part of the ObjoScript.ExprVisitor interface.
		  
		  Return New TreeViewNode("Variable: " + expr.Name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VisitWhileStmt(stmt As ObjoScript.WhileStmt) As Variant
		  Var node As New TreeViewNode("While")
		  
		  Var condition As New TreeViewNode("Condition")
		  condition.AppendNode(stmt.Condition.Accept(Self))
		  node.AppendNode(condition)
		  
		  Var body As New TreeViewNode("Body")
		  If stmt.Body = Nil Then
		    body.Text = "Empty body"
		  Else
		    body.AppendNode(stmt.Body.Accept(Self))
		  End If
		  node.AppendNode(body)
		  
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
