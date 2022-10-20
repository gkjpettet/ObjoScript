#tag Class
Protected Class VM
	#tag Method, Flags = &h21, Description = 4173736572747320746861742060616020616E64206062602061726520626F746820646F75626C65732C206F74686572776973652072616973657320612072756E74696D65206572726F722E
		Private Sub AssertNumbers(a As Variant, b As Variant)
		  /// Asserts that `a` and `b` are both doubles, otherwise raises a runtime error.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If a.Type <> Variant.TypeDouble Or b.Type <> Variant.TypeDouble Then
		    Error("Both operands must be numbers. Instead got " + ValueToString(a) + " and " + ValueToString(b))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52616973657320612072756E74696D65206572726F722069662060616020616E642060626020617265206E6F74207468652073616D6520747970652E
		Private Sub AssertSameType(a As Variant, b As Variant)
		  /// Raises a runtime error if `a` and `b` are not the same type.
		  ///
		  /// Assumes neither `a` or `b` are Nil.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If a.Type <> b.Type Then
		    Error("Both operands must be the same type. Instead got " + ValueToString(a) + " and " + ValueToString(b))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E2054686520686F7374206170706C69636174696F6E2077696C6C2068617665206661696C656420746F2070726F76696465206F6E652E2052657475726E73204E696C206966206E6F6E6520646566696E65642E
		Private Function BindCoreForeignClass(className As String) As ObjoScript.ForeignClassDelegates
		  /// The VM is requesting the delegates to use when instantiating a new foreign class and when an instance of a 
		  /// foreign class is destroyed by the Xojo framework.
		  ///
		  /// The host application will have failed to provide one. Returns Nil if none defined.
		  ///
		  /// We check our standard libraries.
		  
		  If className.CompareCase("Range") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.LibraryCore.Range.Allocate, Nil)
		    
		  ElseIf className.CompareCase("List") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.LibraryCore.List.Allocate, Nil)
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E2054686520686F7374206170706C69636174696F6E2077696C6C2068617665206661696C656420746F2070726F76696465206F6E652E2052657475726E73204E696C206966206E6F6E6520646566696E65642E
		Private Function BindCoreForeignMethod(className As String, signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// The VM is requesting the delegate to use when calling the specified foreign method on a class. 
		  /// The host application will have failed to provide one. Returns Nil if none defined.
		  ///
		  /// We check our standard libraries.
		  
		  If className.CompareCase("System") Then
		    Return LibrarySystem.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Range") Then
		    Return LibraryCore.Range.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("List") Then
		    Return LibraryCore.List.BindForeignMethod(signature, isStatic)
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 42696E6473206120726567756C6172206D6574686F64206E616D656420606E616D656020746F2074686520636C617373206F7220696E7374616E6365206F6E2074686520746F70206F662074686520737461636B2E20417373657274732074686520746F70206F662074686520737461636B20697320616E20696E7374616E6365206F7220636C6173732E
		Private Sub BindMethod(name As String)
		  /// Binds a regular method named `name` to the class or instance on the top of the stack.
		  /// Asserts the top of the stack is an instance or class.
		  
		  // Check we have an instance or a class on the top of the stack.
		  Var receiver As Variant = Peek(0)
		  Var isStatic As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    isStatic = True
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Methods can only be invoked on classes and instances.")
		  End If
		  
		  // Get the correct method. It might be Objo native or foreign.
		  // It's either on the instance's class
		  // or it'll be a static method on the class on the top of the stack.
		  Var method As Variant
		  If isStatic Then
		    method = ObjoScript.Klass(receiver).StaticMethods.Lookup(name, Nil)
		    If method = Nil Then
		      Error("Undefined static method `" + name + "` on " + ObjoScript.Klass(receiver).ToString + ".")
		    End If
		    
		  Else
		    method = ObjoScript.Instance(receiver).klass.Methods.Lookup(name, Nil)
		    If method = Nil Then
		      Error("Undefined instance method `" + name + "` on " + ObjoScript.Instance(receiver).klass.ToString + ".")
		    End If
		  End If
		  
		  // Bind this method to the class/instance which is currently on the top of the stack.
		  Var bound As Variant
		  If method IsA ObjoScript.Func Then
		    bound = New ObjoScript.BoundMethod(receiver, method, isStatic, False)
		  ElseIf method IsA ObjoScript.ForeignMethod Then
		    bound = New ObjoScript.BoundMethod(receiver, method, isStatic, True)
		  Else
		    Error("Expected either a compiled function or a foreign method.")
		  End If
		  
		  // Pop off the class/instance.
		  Call Pop
		  
		  // Push the bound method on to the stack.
		  Push(bound)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 2243616C6C7322206120636C6173732E20457373656E7469616C6C79207468697320637265617465732061206E657720696E7374616E63652E20446F6573202A2A6E6F742A2A20757064617465206043757272656E744672616D65602E
		Private Sub CallClass(klass As ObjoScript.Klass, argCount As Integer)
		  /// "Calls" a class. Essentially this creates a new instance.
		  /// Does **not** update `CurrentFrame`. 
		  ///
		  /// At the moment this method is called, the stack looks like this:
		  /// |           <--- StackTop
		  /// | argN      
		  /// | arg1
		  /// | klass
		  
		  // Replace the class with a new blank instance of that class.
		  Stack(StackTop - argCount - 1) = New ObjoScript.Instance(klass)
		  
		  // Invoke the constructor (if defined).
		  Var constructor As ObjoScript.Func
		  If argCount <= klass.Constructors.LastIndex Then
		    constructor = klass.Constructors(argCount)
		  End If
		  
		  // We allow a class to omit providing a default (zero parameter) constructor.
		  If constructor = Nil And argCount <> 0 Then
		    Error("There is no `" + klass.Name + "` constructor that expects " + argCount.ToString + If(argCount = 1, " argument.", "arguments."))
		  End If
		  
		  // If this is a foreign class, call the allocate delegate so the host can do any additional setup needed.
		  If klass.IsForeign Then
		    Var args() As Variant
		    Var stackBase As Integer = StackTop - argCount - 1
		    For i As Integer = 1 To argCount
		      args.Add(Stack(stackBase + i))
		    Next i
		    klass.ForeignDelegates.Allocate.Invoke(Self, Stack(stackBase), args)
		  End If
		  
		  // Invoke the constructor if defined.
		  If constructor <> Nil Then CallFunction(constructor, argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C73206120666F726569676E206D6574686F64206F6E2074686520636C6173732F696E7374616E6365206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub CallForeignMethod(fm As ObjoScript.ForeignMethod, argCount As Integer)
		  /// Calls a foreign method.
		  ///
		  /// At this moment, the stack looks like this:
		  ///
		  /// |           <--- StackTop
		  /// | argN      
		  /// | arg1
		  /// | receiver
		  
		  // Check we have the correct number of arguments.
		  If argCount <> fm.Arity Then
		    Error("Expected " + fm.Arity.ToString + " arguments but " + _
		    "got " + argCount.ToString + ".")
		  End If
		  
		  // Move the receiver and arguments from the stack to the API slots.
		  // The receiver will always be in slot 0 with the arguments following in their declared order.
		  // Note that the APISlots array will contain nonsense data outside the bounds of the arguments.
		  For i As Integer = argCount DownTo 0
		    APISlots(i) = Pop
		  Next i
		  
		  // Push nothing on to the stack in case the method doesn't set a return value.
		  Push(Nothing)
		  
		  // Call the foreign method.
		  fm.Method.Invoke(Self)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C73206120636F6D70696C65642066756E6374696F6E2E2060617267436F756E746020697320746865206E756D626572206F6620617267756D656E7473206F6E2074686520737461636B20666F7220746869732066756E6374696F6E2063616C6C2E
		Private Sub CallFunction(f As ObjoScript.Func, argCount As Integer)
		  /// Calls a compiled function.
		  /// `argCount` is the number of arguments on the stack for this function call.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Check we have the correct number of arguments.
		  If argCount <> f.Arity Then
		    Error("Expected " + f.Arity.ToString + " arguments but " + _
		    "got " + argCount.ToString + ".")
		  End If
		  
		  // Make sure we don't overflow with a deep call frame (most likely a user error with 
		  // a runaway recursive issue).
		  If FrameCount = MAX_FRAMES Then
		    Error("Stack overflow.")
		  End If
		  
		  // ==============================
		  // Set up the call frame to call.
		  // ==============================
		  Frames(FrameCount).Func = f
		  Frames(FrameCount).IP = 0
		  // -1 to skip over local stack slot 0 which contains the function being called.
		  Frames(FrameCount).StackBase = StackTop - argCount - 1
		  If Self.DebugMode Then
		    // Need to clear out any locals previously defined.
		    Frames(FrameCount).Locals = ParseJSON("{}") // HACK: Case sensitive dictionary
		  End If
		  
		  // Update the call frame counter, thereby essentially pushing the call frame onto the call stack.
		  FrameCount = FrameCount + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506572666F726D7320612063616C6C206F6E20607660207768696368206578706563747320746F2066696E642060617267436F756E746020617267756D656E747320696E207468652063616C6C20737461636B2E2055706461746573206043757272656E744672616D65602E
		Private Sub CallValue(v As Variant, argCount As Integer)
		  /// Performs a call on `v` which expects to find `argCount` arguments in the call stack.
		  /// Updates `CurrentFrame`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If v IsA ObjoScript.Value = False Then
		    Error("Can only call functions, classes and methods.")
		  End If
		  
		  Select Case ObjoScript.Value(v).Type
		  Case ObjoScript.ValueTypes.Klass
		    CallClass(ObjoScript.Klass(v), argCount)
		    
		  Case ObjoScript.ValueTypes.Func
		    CallFunction(ObjoScript.Func(v), argCount)
		    
		  Case ObjoScript.ValueTypes.BoundMethod
		    // Put the receiver of the call (the instance before the dot) in slot 0 for the upcoming call frame.
		    Stack(StackTop - argCount - 1) = ObjoScript.BoundMethod(v).Receiver
		    
		    // Call the bound method.
		    If ObjoScript.BoundMethod(v).IsForeign Then
		      CallForeignMethod(ObjoScript.ForeignMethod(ObjoScript.BoundMethod(v).Method), argCount)
		    Else
		      CallFunction(ObjoScript.Func(ObjoScript.BoundMethod(v).Method), argCount)
		    End If
		    
		  Case ObjoScript.ValueTypes.ForeignMethod
		    CallForeignMethod(ObjoScript.ForeignMethod(v), argCount)
		    
		  Else
		    Error("Can only call functions, classes and methods.")
		  End Select
		  
		  // Update the current call frame.
		  CurrentFrame = Frames(FrameCount - 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Reset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061207265757361626C652068616E646C6520746F20612063616C6C2061206D6574686F64207769746820607369676E617475726560206F6E2074686520636C6173732F696E7374616E63652063757272656E746C7920696E20736C6F7420302E
		Function CreateHandle(signature As String) As ObjoScript.CallHandle
		  /// Returns a reusable handle to a call a method with `signature` on the class/instance currently in slot 0.
		  ///
		  /// The method can then be called again in the future using `VM.InvokeHandle()`.
		  
		  Var argCount As Integer = ObjoScript.Func.ComputeArityFromSignature(signature, Self)
		  
		  // Check we have an instance or a class in slot 0.
		  Var receiver As Variant = APISlots(0)
		  Var isStatic As Boolean = False
		  Var isConstructor As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    If signature.Left(11).Compare("constructor") = 0 Then
		      isConstructor = True
		    Else
		      isStatic = True
		    End If
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Methods can only be invoked on classes and instances.")
		  End If
		  
		  // Get the correct method. It might be Objo native or foreign.
		  // It's either on the instance's class or its superclass
		  // or it'll be a method on the class on the top of the stack.
		  Var method As Variant
		  If isStatic Then
		    method = ObjoScript.Klass(receiver).StaticMethods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("Undefined static method `" + signature + "` on " + ObjoScript.Klass(receiver).ToString + ".")
		    End If
		    
		  ElseIf isConstructor Then
		    Var klass As ObjoScript.Klass = ObjoScript.Klass(receiver)
		    If argCount > klass.Constructors.LastIndex Then
		      Error("Undefined constructor `" + signature + "` on " + klass.ToString + ".")
		    End If
		    
		    method = klass.Constructors(argCount)
		    If method = Nil Then
		      Error("Undefined constructor `" + signature + "` on " + ObjoScript.Klass(receiver).ToString + ".")
		    End If
		    
		  Else
		    method = ObjoScript.Instance(receiver).klass.Methods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("Undefined instance method `" + signature + "` on " + ObjoScript.Instance(receiver).klass.ToString + ".")
		    End If
		  End If
		  
		  // Bind this method to the class/instance which is currently on the top of the stack.
		  Var bound As Variant
		  If method IsA ObjoScript.Func Then
		    bound = New ObjoScript.BoundMethod(receiver, method, isStatic, False)
		  ElseIf method IsA ObjoScript.ForeignMethod Then
		    bound = New ObjoScript.BoundMethod(receiver, method, isStatic, True)
		  End If
		  
		  // Add this bound method to the VM's cache of call handles and return it.
		  CallHandles.Add(bound)
		  Return New ObjoScript.CallHandle(CallHandles.LastIndex, argCount, isConstructor)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174652061206E6577206C697374206C69746572616C2E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865204C69737420636C617373206F6E2074686520737461636B20616E6420616E7920696E697469616C20656C656D656E74732061626F766520746869732E
		Private Sub CreateListLiteral(elementCount As Integer)
		  /// Create a new list literal. The compiler will have placed the List class on the stack
		  /// and any initial elements above this.
		  
		  // Pop and store any optional initial elements.
		  Var elements() As Variant
		  
		  For i As Integer = 1 To elementCount
		    elements.AddAt(0, Pop)
		  Next i
		  
		  // Call the default list constructor.
		  Call CallClass(Peek(0), 0)
		  
		  // The top of the stack will now be a List instance.
		  // Add the initial elements to it's foreign data.
		  Var list As ObjoScript.Instance = Stack(StackTop - 1)
		  list.ForeignData = elements
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206368756E6B207765206172652063757272656E746C792072656164696E672066726F6D2E2049742773206F776E6564206279207468652066756E6374696F6E2077686F73652063616C6C206672616D65207765206172652063757272656E746C7920696E2E
		Private Function CurrentChunk() As ObjoScript.Chunk
		  /// Returns the chunk we are currently reading from. It's owned by the function whose 
		  /// call frame we are currently in.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return CurrentFrame.Func.Chunk
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E6573206120636F6E7374727563746F72206F6E2074686520636C617373206A7573742062656C6F772074686520636F6E7374727563746F72277320626F6479206F6E2074686520737461636B2E
		Private Sub DefineConstructor(argCount As Integer)
		  /// Defines a constructor on the class just below the constructor's body on the stack.
		  ///
		  /// The constructor's body should be on the top of the stack with its class just beneath it.
		  
		  Var constructor As ObjoScript.Func = Peek(0)
		  Var klass As ObjoScript.Klass = Peek(1)
		  
		  // Constructors are stored on the class by arity.
		  If argCount > klass.Constructors.LastIndex Then
		    klass.Constructors.ResizeTo(argCount)
		  End If
		  klass.Constructors(argCount) = constructor
		  
		  // Pop the constructor's body off the stack.
		  Call Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E6573206120666F726569676E20636C6173732E20417373756D657320746861742074686520636C61737320697320616C7265616479206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub DefineForeignClass()
		  /// Defines a foreign class. Assumes that the class is already on the top of the stack.
		  
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  // Ask the host for the delegates to use.
		  Var fcd As ObjoScript.ForeignClassDelegates = RaiseEvent BindForeignClass(klass.Name)
		  If fcd = Nil Then
		    // Check if the core libraries have a delegate for this class.
		    fcd = BindCoreForeignClass(klass.Name)
		    If fcd = Nil Then
		      Error("There are no foreign class delegates for `" + klass.Name + "`.")
		    ElseIf fcd.Allocate = Nil Then
		      Error("The delegate for foreign class (" + klass.Name + ") allocation is Nil.")
		    End If
		  End If
		  
		  klass.ForeignDelegates = fcd
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061206D6574686F64207769746820607369676E61747572656020616E642060617269747960206F6E2074686520636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub DefineForeignMethod(signature As String, arity As UInt8, isStatic As Boolean)
		  /// Defines a method with `signature` and `arity` on the class on the top of the stack.
		  
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  // Ask the host for the delegate to use. This overrides any specified by the core libraries.
		  Var fmd As ObjoScript.ForeignMethodDelegate = RaiseEvent BindForeignMethod(klass.Name, signature, isStatic)
		  If fmd = Nil Then
		    // Check if the core libraries have a delegate for this.
		    fmd = BindCoreForeignMethod(klass.Name, signature, isStatic)
		    If fmd = Nil Then
		      Error("The host application failed to return a foreign method delegate for " + klass.Name + "." + signature + ".")
		    End If
		  End If
		  
		  // Create the foreign method.
		  Var method As New ObjoScript.ForeignMethod(signature, arity, fmd)
		  
		  If isStatic Then
		    // Static method.
		    klass.StaticMethods.Value(signature) = method
		  Else
		    // Instance method.
		    klass.Methods.Value(signature) = method
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061206D6574686F64206E616D656420606E616D6560206F6E2074686520636C617373206A7573742062656C6F7720746865206D6574686F64277320626F6479206F6E2074686520737461636B2E
		Private Sub DefineMethod(signature As String, isStatic As Boolean)
		  /// Defines a method with `signature` on the class just below the method's body on the stack.
		  ///
		  /// The method's body should be on the top of the stack with its class just beneath it.
		  
		  Var method As ObjoScript.Func = Peek(0)
		  Var klass As ObjoScript.Klass = Peek(1)
		  
		  If isStatic Then
		    // Static method.
		    klass.StaticMethods.Value(signature) = method
		  Else
		    // Instance method.
		    klass.Methods.Value(signature) = method
		  End If
		  
		  // Pop the method's body off the stack.
		  Call Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526169736573206120564D457863657074696F6E206174207468652063757272656E742049502028756E6C657373206F746865727769736520737065636966696564292E
		Sub Error(message As String, offset As Integer = -1)
		  /// Raises a VMException at the current IP (unless otherwise specified).
		  
		  #Pragma BreakOnExceptions False
		  
		  // Default to the current IP if no offset is provided.
		  offset = If(offset = -1, CurrentFrame.IP, offset)
		  
		  // Create a rudimentary stack trace.
		  Var stackFrames() As String
		  For i As Integer = FrameCount - 1 DownTo 0
		    Var frame As ObjoScript.CallFrame = Frames(i)
		    Var func As ObjoScript.Func = frame.Func
		    Var funcName As String = If(func.Name = "", "`<main>`", "`" + func.Name + "`")
		    Var s As String = "[line " + func.Chunk.LineForOffset(frame.IP - 1).ToString + "] in " + funcName
		    stackFrames.Add(s)
		  Next i
		  
		  Raise New ObjoScript.VMException(message, CurrentChunk.LineForOffset(offset), stackFrames, StackDump, CurrentChunk.ScriptIDForOffset(offset))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E742063616C6C206672616D652E20546869732073686F756C6420626520636F6E7369646572656420726561642D6F6E6C792E
		Function GetCurrentFrame() As CallFrame
		  /// Returns the current call frame. This should be considered read-only.
		  
		  Return CurrentFrame
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F6620616E20696E7374616E6365206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E63652063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetField(name As String)
		  /// Retrieves the value of an instance field named `name` on the instance currently on the top of the 
		  /// stack and then pushes it on to the top of the stack.
		  
		  // Since instance fields can only be retrieved from within a method we can safely assume that `this` should be in the 
		  // method callframe's slot 0 (it should have been placed there by `CallValue()`).
		  Var instance As ObjoScript.Instance
		  If Stack(CurrentFrame.StackBase) IsA ObjoScript.Instance Then
		    instance = Stack(CurrentFrame.StackBase)
		  Else
		    // Error.
		    If Stack(CurrentFrame.StackBase) IsA ObjoScript.Klass Then
		      Error("You cannot access an instance field from a static method.")
		    Else
		      Error("Only instances have fields.")
		    End If
		  End If
		  
		  // Get the value of the field from the instance.
		  Var value As Variant = instance.Fields.Lookup(name, Nil)
		  
		  // If the field doesn't exist then we create it.
		  If value = Nil Then
		    instance.Fields.Value(name) = Nothing
		    value = Nothing
		  End If
		  
		  // Push the value on to the stack.
		  Push(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520737472696E6720726570726573656E746174696F6E206F66207468652076616C756520696E2060736C6F74602E
		Function GetSlotAsString(slot As Integer) As String
		  /// Returns the string representation of the value in `slot`.
		  
		  Return ValueToString(APISlots(slot))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C756520696E2060736C6F74602E204974206D6179206265206120646F75626C652C20737472696E67206F7220616E20604F626A6F5363726970742E56616C7565602E
		Function GetSlotValue(slot As Integer) As Variant
		  /// Returns the value in `slot`. It may be a double, string or an `ObjoScript.Value`.
		  
		  Return APISlots(slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F66206120737461746963206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E6365206F7220636C6173732063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetStaticField(name As String)
		  /// Retrieves the value of a static field named `name` on the instance or class currently on the top of the 
		  /// stack and then pushes it on to the top of the stack.
		  
		  // The compiler guarantees that static fields can only be retrieved from within an instance 
		  // method/constructor or a static method, we can safely assume that either `this` or the class 
		  // should be in the method callframe's slot 0 (it should have been placed there by `CallValue()`).
		  Var tmp As Variant = Stack(CurrentFrame.StackBase)
		  Var receiver As ObjoScript.Klass
		  If tmp IsA ObjoScript.Klass Then
		    receiver = tmp
		  ElseIf tmp IsA ObjoScript.Instance Then
		    receiver = ObjoScript.Instance(tmp).Klass
		  Else
		    Error("Only classes and instances have static fields.")
		  End If
		  
		  // Get the value of the static field from the receiver.
		  Var value As Variant = receiver.StaticFields.Lookup(name, Nil)
		  
		  // If the static field doesn't exist then we create it.
		  If value = Nil Then
		    receiver.StaticFields.Value(name) = Nothing
		    value = Nothing
		  End If
		  
		  // Push the value on to the stack.
		  Push(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C756520696E2074686520737461636B2061742074686520606672616D65602060736C6F74602E2060736C6F74203060206973207468652066756E6374696F6E20616E642C205468656E2077652068617665206F7074696F6E616C2066756E6374696F6E20617267756D656E747320616E64207468656E20616E79206C6F63616C7320646566696E656420696E207468652066756E6374696F6E2E
		Function GetValueAtFrameSlot(frame As ObjoScript.CallFrame, slot As Integer) As Variant
		  /// Returns the value in the stack at the `frame` `slot`. `slot 0` is the function and, 
		  /// Then we have optional function arguments and then any locals defined in the function.
		  
		  Return Stack(frame.StackBase + slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4C6F6F6B73207570206120746F702D6C6576656C207661726961626C65206E616D656420606E616D656020616E64207075747320697420696E207468652041504920736C6F742060736C6F74602E2052657475726E73205472756520696620666F756E64206F722046616C736520696620746865207661726961626C6520646F6573206E6F742065786973742E
		Function GetVariable(name As String, slot As Integer) As Boolean
		  /// Looks up a top-level variable named `name` and puts it in the API slot `slot`.
		  /// Returns True if found or False if the variable does not exist.
		  
		  Var value As Variant = Globals.Lookup(name, Nil)
		  If value <> Nil Then
		    APISlots(slot) = Globals.Lookup(name, Nil)
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandleStepping(stepMode As VM.StepModes) As Boolean
		  /// Returns True if the VM should exit its run loop or False if it should continue.
		  /// True indicates we've reached a sensible stopping point.
		  
		  If stepMode = VM.StepModes.None Then Return False
		  
		  Var frameLine As Integer = CurrentChunk.LineForOffset(CurrentFrame.IP)
		  Var frameScriptID As Integer = CurrentChunk.ScriptIDForOffset(CurrentFrame.IP)
		  
		  Var opcode As UInt8 = CurrentChunk.ReadByte(CurrentFrame.IP)
		  If frameScriptID <> -1 Then // Disallow stopping within the standard library (scriptID < 0).
		    If frameLine <> mLastStoppedLine Or frameScriptID <> LastStoppedScriptID Then
		      If LastInstructionFrame <> CurrentFrame Or IsStoppableOpcode(opcode, stepMode) Then
		        // We've reached a new source line on a stoppable opcode.
		        mLastStoppedLine = frameLine
		        LastStoppedScriptID = frameScriptID
		        LastInstructionFrame = CurrentFrame
		        Return True
		      End If
		    End If
		  End If
		  
		  // Disassemble each instruction if requested.
		  If TraceExecution And frameScriptID <> -1 Then
		    RaiseEvent DebugPrint(StackDump)
		    RaiseEvent DebugPrint(Self.Debugger.DisassembleInstruction(-1, -1, CurrentChunk, CurrentFrame.IP))
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C657320746865204F505F494E484552495420696E737472756374696F6E2E
		Private Sub Inherit()
		  /// Handles the OP_INHERIT instruction.
		  ///
		  /// The compiler ensures that the stack looks like this when a class declaration specifies
		  /// the class has a superclass.
		  ///
		  /// | superclass  <-- top of the stack.
		  /// | subclass
		  
		  // Make sure the top of the stack is a class to inherit from.
		  If Peek(0) IsA ObjoScript.Klass = False Then
		    Error("Can only inherit from other classes.")
		  End If
		  
		  Var superclass As ObjoScript.Klass = Peek(0)
		  Var subclass As ObjoScript.Klass = Peek(1)
		  
		  // At this point, no methods have been defined on the subclass (since this
		  // opcode should only occur within a class declaration). Therefore, copy all the 
		  // superclass' methods to the class on the stack.
		  // NB: We **don't** inherit static methods and setters or constructors.
		  subclass.Methods = superclass.Methods.Clone
		  
		  // This class should keep a reference to its superclass. Do this and pop it off the stack.
		  subclass.Superclass = Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662060696E737460206973206F66206074797065602E2057616C6B7320746865207375706572636C61737320686965726172636879206966206E65636573736172792E
		Shared Function InstanceIsOfType(inst As ObjoScript.Instance, type As String) As Boolean
		  /// Returns True if `inst` is of `type`. Walks the superclass hierarchy if necessary.
		  
		  If inst.Klass.Name.CompareCase(type) Then
		    Return True
		  Else
		    // Check the class hierarchy.
		    Var parent As ObjoScript.Klass = inst.Klass.Superclass
		    While parent <> Nil
		      If parent.Name.CompareCase(type) Then
		        Return True
		      Else
		        parent = parent.Superclass
		      End If
		    Wend
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E697469616C697365732074686520564D20616E6420696E7465727072657473206066756E63602E20557365207468697320746F20696E74657270726574206120746F70206C6576656C2066756E6374696F6E2E
		Sub Interpret(func As ObjoScript.Func, stepMode As VM.StepModes = VM.StepModes.None)
		  /// Initialises the VM and interprets `func`. Use this to interpret a top level function.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Reset
		  
		  // Push the function to run onto the stack as a runtime value.
		  Push(func)
		  
		  // Call the passed function.
		  CallFunction(func, 0)
		  
		  // The current call frame is the first one.
		  CurrentFrame = Frames(0)
		  
		  Run(stepMode)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B65732061206D6574686F64206F6E20616E20696E7374616E6365206F66206120636C6173732E2054686520726563656976657220636F6E7461696E696E6720746865206D6574686F642073686F756C64206265206F6E2074686520737461636B20616C6F6E67207769746820616E7920617267756D656E74732069742072657175697265732E
		Private Sub Invoke(signature As String, argCount As Integer)
		  /// Invokes a method on an instance of a class. The receiver containing the method should be on the stack
		  /// along with any arguments it requires.
		  ///
		  /// |
		  /// | argN <-- top of stack
		  /// | arg1
		  /// | instance/class
		  
		  // Grab the receiver from the stack. It should be beneath any arguments to the invocation.
		  Var receiver As Variant = Peek(argCount)
		  Var isStatic As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    isStatic = True
		    
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Only classes and instances have methods.")
		  End If
		  
		  If isStatic Then
		    // This is a static method invocation.
		    InvokeFromClass(ObjoScript.Klass(receiver), signature, argCount, True)
		    
		  Else
		    // The method is directly on the instance.
		    InvokeFromClass(ObjoScript.Instance(receiver).Klass, signature, argCount, False)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4469726563746C7920696E766F6B65732061206D6574686F64207769746820607369676E617475726560206F6E20606B6C617373602E20417373756D65732065697468657220606B6C61737360206F7220616E20696E7374616E6365206F6620606B6C6173736020616E642074686520726571756972656420617267756D656E74732061726520616C7265616479206F6E2074686520737461636B2E
		Private Sub InvokeFromClass(klass As ObjoScript.Klass, signature As String, argCount As Integer, isStatic As Boolean)
		  /// Directly invokes a method with `signature` on `klass`. Assumes either `klass` or an instance 
		  /// of `klass` and the required arguments are already on the stack.
		  ///
		  /// |
		  /// | argN <-- top of stack
		  /// | arg1
		  /// | instance or class
		  
		  Var method As Variant
		  If isStatic Then
		    method = klass.StaticMethods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("There is no static method with signature `" +signature + "` on `" + klass.ToString + "`.")
		    End If
		  Else
		    method = klass.Methods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("There is no instance method with signature `" + signature + "` on `" + klass.ToString + "`.")
		    End If
		  End If
		  
		  CallValue(method, argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496E766F6B657320612063616C6C2068616E646C652E20417373756D657320616E7920617267756D656E74732068617665206265656E20706C6163656420696E2074686520617070726F70726961746520736C6F74732028617267756D656E742031203D20736C6F742031292E
		Sub InvokeHandle(handle As ObjoScript.CallHandle)
		  /// Invokes a call handle. Assumes any arguments have been placed in the appropriate slots (argument 1 = slot 1).
		  ///
		  /// Call handles are merely a wrapper around the index in `CallHandles()` of the bound method to call.
		  ///
		  /// Set the stack up like this:
		  /// | argN         <-- top
		  /// | arg1
		  /// | method (or klass if handle.IsConstructor)
		  
		  Var bound As ObjoScript.BoundMethod = CallHandles(handle.Index)
		  
		  If handle.IsConstructor Then
		    // We need to push the handle's receiver (which we're assuming is a klass) on to the stack
		    // before the arguments because that is the arrangement `CallClass()` expects.
		    Push(bound.Receiver)
		  End If
		  
		  // Push the arguments from APISlots (starting at slot 1).
		  For i As Integer = 1 To handle.ArgCount
		    Push(APISlots(i))
		  Next i
		  
		  If handle.IsConstructor Then
		    CallClass(bound.Receiver, handle.ArgCount)
		    // Update the current call frame (since CallClass doesn't do this for us).
		    CurrentFrame = Frames(FrameCount - 1)
		  Else
		    InvokeFromClass(bound.Receiver, bound.Method.Signature, handle.ArgCount, bound.IsStatic)
		  End If
		  
		  Run
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662060766020697320636F6E73696465726564202266616C736579222E
		Private Function IsFalsey(v As Variant) As Boolean
		  /// Returns True if `v` is considered "falsey".
		  ///
		  /// Objo considers the boolean value `false` and the Objo value `nothing` to
		  /// be False, everything else is True.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return (v.Type = Variant.TypeBoolean And v = False) Or v IsA ObjoScript.Nothing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73205472756520696620606F70636F64656020697320776F7274682073746F7070696E67206F6E20676976656E207468652060737465704D6F6465602E
		Private Function IsStoppableOpcode(opcode As UInt8, stepMode As VM.StepModes) As Boolean
		  /// Returns True if `opcode` is worth stopping on given the `stepMode`.
		  
		  // Stop on the following operations:
		  // Variable declarations, assignments, assertions, continue, exit, return
		  Select Case stepMode
		  Case VM.StepModes.StepInto
		    Select Case opcode
		    Case OP_ASSERT, OP_SET_LOCAL, OP_SET_GLOBAL, OP_SET_GLOBAL_LONG, _
		      OP_DEFINE_GLOBAL, OP_DEFINE_GLOBAL_LONG, OP_SET_FIELD, OP_SET_FIELD_LONG, _
		      OP_SET_STATIC_FIELD, OP_SET_STATIC_FIELD_LONG, OP_RETURN, OP_LOOP, OP_CALL, _
		      OP_INVOKE, OP_INVOKE_LONG
		      Return True
		      
		    Else
		      Return False
		    End Select
		    
		  Case VM.StepModes.StepOver
		    Raise New UnsupportedOperationException("Stepping into not yet implemented.")
		    
		  Else
		    Return False
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73205472756520696620607660206973202A6E6F742A20636F6E73696465726564202266616C736579222E
		Private Function IsTruthy(v As Variant) As Boolean
		  /// Returns True if `v` is *not* considered "falsey".
		  ///
		  /// Objo considers the boolean value `false` and the Objo value `nothing` to
		  /// be False, everything else is True.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Not IsFalsey(v)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652076616C7565206064697374616E6365602066726F6D2074686520746F70206F662074686520737461636B2E204C6561766573207468652076616C7565206F6E2074686520737461636B2E20412076616C7565206F662060306020776F756C642072657475726E2074686520746F70206974656D2E
		Private Function Peek(distance As Integer) As Variant
		  /// Returns the value `distance` from the top of the stack. Leaves the value on the stack. A value of `0` would return the top item.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Stack(StackTop - distance - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506F707320612076616C7565206F6666206F662074686520737461636B2E
		Private Function Pop() As Variant
		  /// Pops a value off of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  StackTop = StackTop - 1
		  Return Stack(StackTop)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50757368657320612076616C7565206F6E746F2074686520737461636B2E
		Private Sub Push(value As Variant)
		  /// Pushes a value onto the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop) = value
		  StackTop = StackTop + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265747269657665732074686520676C6F62616C207661726961626C65206E616D656420606E616D656020616E64207075747320697420696E20415049536C6F742060736C6F74602E20526169736573206120564D20657863657074696F6E20696620746865207661726961626C652063616E6E6F7420626520666F756E642E
		Sub PutGlobalVariable(name As String, slot As Integer)
		  /// Retrieves the global variable named `name` and puts it in APISlot `slot`.
		  /// Raises a VM exception if the variable cannot be found.
		  
		  Var variable As Variant = Globals.Lookup(name, Nil)
		  If variable <> Nil Then
		    APISlots(slot) = variable
		  Else
		    Error("API error. There is no global variable `" + name + "`.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5261697365732074686520564D277320605072696E7460206576656E742C2070617373696E67206974206073602E
		Sub RaisePrint(s As String)
		  /// Raises the VM's `Print` event, passing it `s`.
		  
		  RaiseEvent Print(s)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526561647320746865206279746520696E20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E732069742E20496E6372656D656E7473207468652049502E
		Private Function ReadByte() As UInt8
		  /// Reads the byte in `Chunk` at the current `IP` and returns it. Increments the IP.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  CurrentFrame.IP = CurrentFrame.IP + 1
		  Return CurrentChunk.ReadByte(CurrentFrame.IP - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E6720612073696E676C652062797465206F706572616E642E20496E6372656D656E74732049502E
		Private Function ReadConstant() As Variant
		  /// Reads a constant from the chunk's constant pool using a single byte operand. Increments IP.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return CurrentChunk.Constants(ReadByte)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E672074776F2062797465206F706572616E64732E20496E6372656D656E74732049502E
		Private Function ReadConstantLong() As Variant
		  /// Reads a constant from the chunk's constant pool using two byte operands. Increments IP.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return CurrentChunk.Constants(ReadUInt16)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656164732074776F2062797465732066726F6D20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E73207468656D20617320612055496E7431362E20496E6372656D656E74732074686520495020627920322E
		Private Function ReadUInt16() As UInt16
		  /// Reads two bytes from `Chunk` at the current `IP` and returns them as a UInt16. Increments the IP by 2.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  CurrentFrame.IP = CurrentFrame.IP + 2
		  Return CurrentChunk.ReadUInt16(CurrentFrame.IP - 2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5265736574732074686520564D2E
		Sub Reset()
		  /// Resets the VM.
		  
		  StackTop = 0
		  Stack.ResizeTo(-1)
		  Stack.ResizeTo(MAX_STACK * MAX_FRAMES)
		  
		  FrameCount = 0
		  Frames.ResizeTo(-1)
		  Frames.ResizeTo(MAX_FRAMES)
		  // Allocate new call frames up front so we don't incur object creation overhead at runtime.
		  For i As Integer = 0 To Frames.LastRowIndex
		    Frames(i) = New ObjoScript.CallFrame
		  Next i
		  
		  Nothing = New ObjoScript.Nothing
		  
		  Self.Globals = ParseJSON("{}") // HACK: Case sensitive.
		  
		  CallHandles.ResizeTo(-1)
		  
		  APISlots.ResizeTo(-1)
		  APISlots.ResizeTo(MAX_SLOTS)
		  For i As Integer = 0 To APISlots.LastIndex
		    APISlots(i) = Nothing
		  Next i
		  
		  mLastStoppedLine = -1
		  LastStoppedScriptID = -1
		  mShouldStop = False
		  LastInstructionFrame = Nil
		  
		  Self.Debugger = New ObjoScript.Debugger
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E732074686520696E7465727072657465722E20417373756D657320697420686173206265656E20696E697469616C69736564207072696F7220746F207468697320616E642068617320612076616C69642063616C6C206672616D6520746F20657865637574652E
		Sub Run(stepMode As ObjoScript.VM.StepModes = ObjoScript.VM.StepModes.None)
		  /// Runs the interpreter. Assumes it has been initialised prior to this and has a valid call frame to execute.
		  
		  // Make sure we don't try to step in with an out of bounds instruction pointer.
		  If CurrentFrame.IP > CurrentChunk.Code.LastIndex Then Return
		  
		  While True
		    
		    If Self.DebugMode And CurrentChunk.IsDebug Then
		      If mShouldStop Then Return
		      If HandleStepping(stepMode) Then Return
		    End If
		    
		    Select Case ReadByte
		    Case OP_RETURN
		      // Get the return value off the stack.
		      Var result As Variant = Pop
		      
		      // We always put the return value in slot 0 of `APISlots` so the host application can access it.
		      APISlots(0) = result
		      
		      FrameCount = FrameCount - 1
		      
		      If FrameCount = 0 Then
		        // Exit the VM.
		        Call Pop
		        StackTop = 0
		        Return
		      End If
		      
		      // Reset the stack top to what it was prior to this call.
		      StackTop = CurrentFrame.StackBase
		      
		      // Push the result to the top of the stack.
		      Push(result)
		      
		      // Drop the frame.
		      CurrentFrame = Frames(FrameCount - 1)
		      
		    Case OP_CONSTANT
		      Var constant As Variant = ReadConstant
		      Push(constant)
		      
		    Case OP_CONSTANT_LONG
		      Var constant As Variant = ReadConstantLong
		      Push(constant)
		      
		    Case OP_LOAD_0
		      Push(CType(0, Double))
		      
		    Case OP_LOAD_1
		      Push(CType(1, Double))
		      
		    Case OP_LOAD_MINUS1
		      Push(CType(-1, Double))
		      
		    Case OP_NEGATE
		      If Peek(0).Type <> Variant.TypeDouble Then
		        Error("Operand must be a number.")
		      End If
		      // In this instruction, the answer replaces what's currently at the top of the stack.
		      // Rather than pop, negate then push we'll do it in situ as it's ~6x faster.
		      Stack(StackTop - 1) = -Stack(StackTop - 1).DoubleValue
		      
		    Case OP_ADD
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      If a.Type = Variant.TypeDouble And b.Type = Variant.TypeDouble Then
		        // Both numbers.
		        Push(a.DoubleValue + b.DoubleValue)
		      ElseIf a.Type = Variant.TypeString And b.Type = Variant.TypeString Then
		        // Both strings.
		        Push(a.StringValue + b.StringValue)
		      ElseIf a.Type = Variant.TypeString Or b.Type = Variant.TypeString Then
		        // One of the operands is a string.
		        Push(ValueToString(a) + ValueToString(b))
		      Else
		        Error("Both operands must be numbers or at least one operand must be a string.")
		      End If
		      
		    Case OP_SUBTRACT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue - b.DoubleValue)
		      
		    Case OP_DIVIDE
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue / b.DoubleValue)
		      
		    Case OP_MULTIPLY
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a.DoubleValue * b.DoubleValue)
		      
		    Case OP_MODULO
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(CType(a.DoubleValue Mod b.DoubleValue, Double))
		      
		    Case OP_NOT
		      // Since unary operators don't change the stack and operate on the top of the stack, we'll 
		      // simply do the operation in situ as it's faster than pop-pushing.
		      Stack(StackTop - 1) = IsFalsey(Stack(StackTop - 1))
		      
		    Case OP_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      Push(ValuesEqual(a, b))
		      
		    Case OP_NOT_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      Push(Not ValuesEqual(a, b))
		      
		    Case OP_GREATER
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a > b)
		      
		    Case OP_GREATER_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a >= b)
		      
		    Case OP_LESS
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a < b)
		      
		    Case OP_LESS_EQUAL
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      Push(a <= b)
		      
		    Case OP_TRUE
		      Push(True)
		      
		    Case OP_FALSE
		      Push(False)
		      
		    Case OP_NOTHING
		      Push(Nothing)
		      
		    Case OP_POP
		      Call Pop
		      
		    Case OP_POP_N
		      // Pop N values off the stack. N is the operand.
		      StackTop = StackTop - ReadByte
		      
		    Case OP_SHIFT_LEFT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Ctype(Bitwise.ShiftLeft(a.IntegerValue, b.IntegerValue), Double))
		      
		    Case OP_SHIFT_RIGHT
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Ctype(Bitwise.ShiftRight(a.IntegerValue, b.IntegerValue), Double))
		      
		    Case OP_BITWISE_AND
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // Bitwise operators always work on 32-bit unsigned integers.
		      Push(Ctype(a.UInt32Value And b.UInt32Value, Double))
		      
		    Case OP_BITWISE_OR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // Bitwise operators always work on 32-bit unsigned integers.
		      Push(Ctype(a.UInt32Value Or b.UInt32Value, Double))
		      
		    Case OP_BITWISE_XOR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // Bitwise operators always work on 32-bit unsigned integers.
		      Push(Ctype(a.UInt32Value Xor b.UInt32Value, Double))
		      
		    Case OP_BITWISE_NOT
		      // Bitwise operators always work on 32-bit unsigned integers.
		      Var v As Variant = Pop
		      If v.Type <> Variant.TypeDouble Then
		        Error("Expected a number. Instead got `" + ValueToString(v) + "`.")
		      Else
		        Push(CType(Not v.UInt32Value, Double))
		      End If
		      
		    Case OP_ASSERT
		      // Pop the top of the stack. If it's False then raise a runtime error.
		      If IsFalsey(Pop) Then
		        Error("Failed assertion.")
		      End If
		      
		    Case OP_DEFINE_GLOBAL
		      // Define a global variable, the name of which requires a single byte operand to get its index.
		      Var name As String = ReadConstant
		      // The value of the variable is on the top of the stack.
		      globals.Value(name) = Pop
		      
		    Case OP_DEFINE_GLOBAL_LONG
		      // Define a global variable, the name of which requires a two byte operand to get its index.
		      Var name As String = ReadConstantLong
		      // The value of the variable is on the top of the stack.
		      globals.Value(name) = Pop
		      
		    Case OP_GET_GLOBAL
		      // Get the name of the variable.
		      Var name As String = ReadConstant
		      // Read its value from the globals dictionary, raising a runtime error if it doesn't exist.
		      Var value As Variant = Self.Globals.Lookup(name, Nil)
		      If value = Nil Then
		        Error("Undefined variable `" + name + "`.")
		      Else
		        Push(value)
		      End If
		      
		    Case OP_GET_GLOBAL_LONG
		      // Get the name of the variable.
		      Var name As String = ReadConstantLong
		      // Read its value from the globals dictionary, raising a runtime error if it doesn't exist.
		      Var value As Variant = Self.Globals.Lookup(name, Nil)
		      If value = Nil Then
		        Error("Undefined variable `" + name + "`.")
		      Else
		        Push(value)
		      End If
		      
		    Case OP_SET_GLOBAL
		      // Get the global variable's name (requires a single byte operand to get its index).
		      Var name As String = ReadConstant
		      // Assign the value at the top of the stack to this variable, leaving the value on the stack.
		      If Self.Globals.HasKey(name) Then
		        Self.Globals.Value(name) = Peek(0)
		      Else
		        Error("Undefined variable `" + name + "`.")
		      End If
		      
		    Case OP_SET_GLOBAL_LONG
		      // Get the global variable's name (requires a two byte operand to get its index).
		      Var name As String = ReadConstantLong
		      // Assign the value at the top of the stack to this variable, leaving the value on the stack.
		      If Self.Globals.HasKey(name) Then
		        Self.Globals.Value(name) = Peek(0)
		      Else
		        Error("Undefined variable `" + name + "`.")
		      End If
		      
		    Case OP_GET_LOCAL
		      // The operand is the stack slot where the local variable lives.
		      // Load the value at that index and then push it on to the top of the stack.
		      Push(Stack(CurrentFrame.StackBase + ReadByte))
		      
		    Case OP_LOCAL_VAR_DEC
		      If DebugMode Then // Only required for debugging.
		        // The compiler has declared a new local variable. The first UInt16 operand is the index in the
		        // constant pool of the name of the variable declared. The second one byte operand is the
		        // slot the local occupies.
		        // The compiler will have already emitted OP_GET_LOCAL.
		        CurrentFrame.Locals.Value(ReadConstantLong) = ReadByte
		      End If
		      
		    Case OP_GET_LOCAL_CLASS
		      // The operand is the stack slot where the local variable lives.
		      // This local variable should be an instance. Load it and then push its
		      // class onto the stack.
		      Var instance As ObjoScript.Instance = Stack(CurrentFrame.StackBase + ReadByte)
		      // Load the value at that index and then push it on to the top of the stack.
		      Push(instance.Klass)
		      
		    Case OP_SET_LOCAL
		      // The operand is the stack slot where the local variable lives.
		      // Store the value at the top of the stack in the stack slot corresponding to the local variable.
		      Stack(CurrentFrame.StackBase + ReadByte) = Peek(0)
		      
		    Case OP_JUMP
		      // Unconditionally jump `offset` bytes from the current instruction pointer.
		      Var offset As UInt16 = ReadUInt16
		      CurrentFrame.IP = CurrentFrame.IP + offset
		      
		    Case OP_JUMP_IF_FALSE
		      // Jump `offset` bytes from the current instruction pointer _if_ the value on the top of the stack is falsey.
		      Var offset As UInt16 = ReadUInt16
		      If IsFalsey(Peek(0)) Then
		        CurrentFrame.IP = CurrentFrame.IP + offset
		      End If
		      
		    Case OP_JUMP_IF_TRUE
		      // Jump `offset` bytes from the current instruction pointer _if_ the value on the top of the stack is truthy.
		      Var offset As UInt16 = ReadUInt16
		      If IsTruthy(Peek(0)) Then
		        CurrentFrame.IP = CurrentFrame.IP + offset
		      End If
		      
		    Case OP_LOGICAL_XOR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      Push(IsTruthy(a) Xor IsTruthy(b))
		      
		    Case OP_LOOP
		      // Unconditionally jump `offset` bytes _back_ from the current instruction pointer.
		      Var offset AS UInt16 = ReadUInt16
		      CurrentFrame.IP = CurrentFrame.IP - offset
		      
		    Case OP_RANGE
		      // The compiler will have placed the Range class, lower and upper bounds on the stack
		      // (in that order).
		      Call CallValue(Peek(2), 2)
		      
		    Case OP_EXIT
		      Error("Unexpected `exit` placeholder instruction. The chunk is invalid.")
		      
		    Case OP_CALL
		      // We peek past the arguments to find the function to call.
		      Var argcount As Integer = ReadByte
		      Call CallValue(Peek(argcount), argcount)
		      
		    Case OP_CLASS
		      Var className As String = ReadConstantLong
		      Var isForeign As Boolean = ReadByte = 1
		      Push(New ObjoScript.Klass(className, isForeign))
		      If isForeign Then
		        DefineForeignClass
		      End If
		      
		    Case OP_METHOD
		      DefineMethod(ReadConstantLong, If(ReadByte = 0, False, True))
		      
		    Case OP_GETTER
		      BindMethod(ReadConstant)
		      
		    Case OP_GETTER_LONG
		      BindMethod(ReadConstantLong)
		      
		    Case OP_SETTER
		      Setter(ReadConstant)
		      
		    Case OP_SETTER_LONG
		      Setter(ReadConstantLong)
		      
		    Case OP_GET_FIELD
		      GetField(ReadConstant)
		      
		    Case OP_GET_FIELD_LONG
		      GetField(ReadConstantLong)
		      
		    Case OP_SET_FIELD
		      SetField(ReadConstant)
		      
		    Case OP_SET_FIELD_LONG
		      SetField(ReadConstantLong)
		      
		    Case OP_CONSTRUCTOR
		      DefineConstructor(ReadByte)
		      
		    Case VM.OP_INVOKE
		      Invoke(ReadConstant, ReadByte)
		      
		    Case VM.OP_INVOKE_LONG
		      Invoke(ReadConstantLong, ReadByte)
		      
		    Case OP_INHERIT
		      Inherit
		      
		    Case OP_SUPER_SETTER
		      SuperInvoke(ReadConstantLong, ReadConstantLong, 1)
		      
		    Case OP_SUPER_INVOKE
		      SuperInvoke(ReadConstantLong, ReadConstantLong, ReadByte)
		      
		    Case OP_SUPER_CONSTRUCTOR
		      SuperConstructor(ReadConstantLong, ReadByte)
		      
		    Case OP_GET_STATIC_FIELD
		      GetStaticField(ReadConstant)
		      
		    Case OP_GET_STATIC_FIELD_LONG
		      GetStaticField(ReadConstantLong)
		      
		    Case OP_SET_STATIC_FIELD
		      SetStaticField(ReadConstant)
		      
		    Case OP_SET_STATIC_FIELD_LONG
		      SetStaticField(ReadConstantLong)
		      
		    Case OP_FOREIGN_METHOD
		      DefineForeignMethod(ReadConstantLong, ReadByte, If(ReadByte = 1, True, False))
		      
		    Case OP_IS
		      // value `is` type
		      // The compiler will have ensured that `type` is a string.
		      Push(ValueIsType(Pop, Pop))
		      
		    Case OP_LIST
		      CreateListLiteral(ReadByte)
		      ' Var elementCount As Integer = ReadByte
		      ' Call CallValue(Peek(elementCount), 0)
		      
		    End Select
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 536574732061206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E63652074686174206973206F6E652066726F6D2074686520746F70206F662074686520737461636B20746F207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub SetField(name As String)
		  /// Sets a field named `name` on the instance that is one from the top of the stack to the value on the top of the stack.
		  ///
		  /// |
		  /// | ValueToAssign   <-- top of the stack
		  /// | Instance        <-- the instance that should have the field named `name`.
		  /// |
		  
		  // Since fields can only be set from within a method we can safely assume that `this` should be in the 
		  // method callframe's slot 0/StackBase (it should have been placed there by `CallValue()`).
		  Var instance As ObjoScript.Instance
		  If Stack(CurrentFrame.StackBase) IsA ObjoScript.Instance Then
		    instance = Stack(CurrentFrame.StackBase)
		  Else
		    // Error.
		    If Stack(CurrentFrame.StackBase) IsA ObjoScript.Klass Then
		      Error("You cannot set an instance field from a static method.")
		    Else
		      Error("Only instances have fields.")
		    End If
		  End If
		  
		  // Set the field to the value on the top of the stack and pop it off.
		  // If the field has never been assigned to before then we create it.
		  Var value As Variant = Pop
		  instance.Fields.Value(name) = value
		  
		  // Push the value back on the stack (since this is an expression).
		  Push(value)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F206076616C7565602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturn(value As Variant)
		  /// Sets the return value of a foreign method to `value`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  Stack(StackTop - 1) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20646F75626C652076616C7565206064602E
		Sub SetSlot(slot As Integer, d As Double)
		  /// Sets `slot` to double value `d`.
		  
		  APISlots(slot) = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F2060696E7374616E6365602E
		Sub SetSlot(slot As Integer, instance As ObjoScript.Instance)
		  /// Sets `slot` to `instance`.
		  
		  APISlots(slot) = instance
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20606B6C617373602E
		Sub SetSlot(slot As Integer, klass As ObjoScript.Klass)
		  /// Sets `slot` to `klass`.
		  
		  APISlots(slot) = klass
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20737472696E672076616C7565206073602E
		Sub SetSlot(slot As Integer, s As String)
		  /// Sets `slot` to string value `s`.
		  
		  APISlots(slot) = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20606E6F7468696E67602E
		Sub SetSlotNothing(slot As Integer)
		  /// Sets `slot` to `nothing`.
		  
		  APISlots(slot) = Nothing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 53657473206120737461746963206669656C64206E616D656420606E616D6560206F6E2074686520636C61737320286F7220696E7374616E6365277320636C617373292074686174206973206F6E652066726F6D2074686520746F70206F662074686520737461636B20746F207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub SetStaticField(name As String)
		  /// Sets a static field named `name` on the class (or instance's class) that is one from the top of the 
		  /// stack to the value on the top of the stack.
		  ///
		  /// |
		  /// | ValueToAssign       <-- top of the stack
		  /// | class or instance   <-- should have the static field named `name`.
		  /// |
		  
		  // The compiler guarantees that static fields can only be set from within a method or constructor 
		  // so we can safely assume that `this` should be in the 
		  // method callframe's slot 0/StackBase (it should have been placed there by `CallValue()`).
		  Var tmp As Variant = Stack(CurrentFrame.StackBase)
		  Var receiver As ObjoScript.Klass
		  If tmp IsA ObjoScript.Klass Then
		    receiver = ObjoScript.Klass(tmp)
		  ElseIf tmp IsA ObjoScript.Instance Then
		    receiver = ObjoScript.Instance(tmp).Klass
		  Else
		    // Error.
		    Error("Only classes and instances have static fields.")
		  End If
		  
		  // Set the static field to the value on the top of the stack and pop it off.
		  // If the static field has never been assigned to before then we create it.
		  Var value As Variant = Pop
		  receiver.StaticFields.Value(name) = value
		  
		  // Push the value back on the stack (since this is an expression).
		  Push(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C73207468652073657474657220666F722074686520696E7374616E6365206F6E652066726F6D2074686520746F70206F662074686520737461636B2C2070617373696E6720696E207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2061732074686520706172616D657465722E
		Private Sub Setter(signature As String)
		  /// Calls the setter for the instance or class one from the top of the stack, passing in the 
		  /// value on the top of the stack as the parameter.
		  ///
		  /// |
		  /// | ValueToAssign   <-- top of the stack
		  /// | instance or class
		  
		  // Check we have a class/instance in the correct place.
		  Var receiver As Variant = Peek(1)
		  Var isStatic As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    isStatic = True
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Setters can only be invoked on classes or instances.")
		  End If
		  
		  // Get the value to assign. This will be the parameter to the setter method.
		  Var value As Variant = Pop
		  
		  // Get the correct method. It's either on the instance or a class.
		  Var setter As Variant
		  If isStatic Then
		    setter = ObjoScript.Klass(receiver).StaticMethods.Lookup(signature, Nil)
		    If setter = Nil Then
		      Error("Undefined static setter `" + signature + "` on " + ObjoScript.Klass(receiver).ToString + ".")
		    End If
		    
		  Else
		    setter = ObjoScript.Instance(receiver).klass.Methods.Lookup(signature, Nil)
		    If setter = Nil Then
		      Error("Undefined instance setter `" + signature + "` on " + ObjoScript.Instance(receiver).klass.ToString + ".")
		    End If
		  End If
		  
		  Var bound As Variant
		  // Bind this method to the instance which is currently on the top of the stack.
		  If setter IsA ObjoScript.Func Then
		    bound = New ObjoScript.BoundMethod(receiver, setter, isStatic, False)
		  ElseIf setter IsA ObjoScript.ForeignMethod Then
		    bound = New ObjoScript.BoundMethod(receiver, setter, isStatic, True)
		  Else
		    Error("Expected either a compiled function or a foreign method.")
		  End If
		  
		  // Pop off of the class/instance
		  Call Pop
		  
		  // Push the bound method on to the stack.
		  Push(bound)
		  
		  // Push the value to assign back on the stack.
		  Push(value)
		  
		  // Call the method.
		  CallValue(bound, 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737461636B2064756D702E
		Private Function StackDump() As String
		  /// Returns a stack dump.
		  
		  Var s() As String
		  
		  For i As Integer = 0 To StackTop - 1
		    Var item As Variant = Stack(i)
		    s.Add("[ " + ValueToString(item) + " ]")
		  Next i
		  
		  Return String.FromArray(s, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 496D6D6564696174656C792073746F70732074686520564D2E20446F6573206E6F742072657365742069742E205468697320636F756C64206C656176652074686520564D20696E20616E20756E737461626C652073746174652E
		Sub Stop()
		  /// Immediately stops the VM. Does not reset it. This could leave the VM in an unstable state.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B65732074686520737065636966696564207375706572636C61737320636F6E7374727563746F72206F6E20616E20696E7374616E63652E2054686520696E7374616E63652073686F756C64206265206F6E2074686520737461636B20616C6F6E67207769746820616E7920617267756D656E74732069742072657175697265732E
		Private Sub SuperConstructor(superclassName As String, argCount As Integer)
		  /// Invokes the specified superclass constructor on an instance. The instance should be on the stack
		  /// along with any arguments it requires.
		  ///
		  /// |
		  /// | argN <-- top of stack
		  /// | arg1
		  /// | instance
		  
		  // Get the super class. Since classes are all declared in the top level, it should be in Globals.
		  // The compiler will have checked that the superclass exists during compilation.
		  Var superclass As ObjoScript.Klass = Globals.Value(superclassName)
		  
		  // Call the correct constructor.
		  // The compiler will have guaranteed that the superclass has a constructor with the correct arity.
		  CallValue(superclass.Constructors(argcount), argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B65732074686520737065636966696564206D6574686F64206F6E20746865207375706572636C617373206F662074686520696E7374616E6365206F6E2074686520737461636B2E2054686520726571756972656420617267756D656E74732073686F756C6420616C736F206265206F6E2074686520737461636B2E
		Private Sub SuperInvoke(superclassName As String, signature As String, argCount As Integer)
		  /// Invokes the specified method on the superclass of the instance on the stack. 
		  /// The required arguments should also be on the stack.
		  ///
		  /// |
		  /// | argN <-- top of stack
		  /// | arg1
		  /// | instance
		  
		  // Get the super class. Since classes are all declared in the top level, it should be in Globals.
		  // The compiler will have checked that the superclass exists during compilation.
		  Var superclass As ObjoScript.Klass = Globals.Value(superclassName)
		  
		  // Call the correct method.
		  // The compiler will have guaranteed that the superclass has a method with this signature.
		  CallValue(superclass.Methods.Value(signature), argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620746865204F626A6F53637269707420737461636B206076616C756560206973206F66206074797065602E
		Shared Function ValueIsType(type As String, value As Variant) As Boolean
		  /// Returns True if the ObjoScript stack `value` is of `type`.
		  ///
		  /// `value` should be one of the following:
		  /// 1. Double.
		  /// 2. String.
		  /// 3. Boolean.
		  /// 4. Klass.
		  /// 5. Instance.
		  /// 6. nothing.
		  /// 7. Func.
		  
		  If value = Nil Then Return False
		  
		  If value.Type = Variant.TypeDouble And type.Compare("Number", ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  If value.Type = Variant.TypeString And type.Compare("String", ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  If value.Type = Variant.TypeBoolean And type.Compare("Boolean", ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  If value IsA ObjoScript.Klass And ObjoScript.Klass(value).Name.Compare(type, ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  If value IsA ObjoScript.Instance Then
		    Return InstanceIsOfType(value, type)
		  End If
		  
		  If value IsA ObjoScript.Nothing And type.Compare("nothing", ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  If value IsA ObjoScript.Func And type.Compare("Function", ComparisonOptions.CaseSensitive) = 0 Then
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547275652069662076616C7565732060616020616E64206062602061726520636F6E7369646572656420657175616C2062792074686520564D2E
		Private Function ValuesEqual(a As Variant, b As Variant) As Boolean
		  /// True if values `a` and `b` are considered equal by the VM.
		  ///
		  /// Assumes neither `a` or `b` are Nil.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If a.Type <> b.Type Then Return False
		  
		  Select Case a.Type
		    // ===================
		    // Doubles & Booleans.
		    // ===================
		  Case Variant.TypeDouble, Variant.TypeBoolean
		    Return a = b
		    
		  Case Variant.TypeString
		    // ===================
		    // Strings.
		    // ===================
		    // Case sensitive comparison.
		    Return a.StringValue.Compare(b.StringValue, ComparisonOptions.CaseSensitive) = 0
		    
		  Else
		    // ===================
		    // "Nothing".
		    // ===================
		    If a IsA ObjoScript.Nothing And b IsA ObjoScript.Nothing Then
		      Return True
		    End If
		    
		    // ===================
		    // Instances.
		    // ===================
		    If a IsA ObjoScript.Instance And b IsA ObjoScript.Instance Then
		      Return a = b
		    End If
		    
		    // ===================
		    // Klasses.
		    // ===================
		    If a IsA ObjoScript.Klass And b IsA ObjoScript.Klass Then
		      Return ObjoScript.Klass(a).Name.CompareCase(ObjoScript.Klass(b).Name)
		    End If
		  End Select
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206120564D2076616C75652E
		Shared Function ValueToString(v As Variant) As String
		  /// Returns a string representation of a VM value.
		  
		  Select Case v.Type
		  Case Variant.TypeString
		    Return v.StringValue
		    
		  Case Variant.TypeBoolean
		    If v Then
		      Return "true"
		    Else
		      Return "false"
		    End If
		    
		  Case Variant.TypeDouble
		    If v.DoubleValue.IsInteger Then
		      Return CType(v, Integer).ToString
		    Else
		      Return v.DoubleValue.ToString
		    End If
		    
		  Else
		    If v IsA ObjoScript.Nothing Then
		      Return "nothing"
		      
		    ElseIf v IsA ObjoScript.Value Then
		      Return ObjoScript.Value(v).ToString
		      
		    Else
		      // This shouldn't happen.
		      Raise New UnsupportedOperationException("Unable to create a string representation of the value.")
		    End If
		  End Select
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 54686520564D2069732072657175657374696E67207468652064656C65676174657320746F20757365207768656E20696E7374616E74696174696E672061206E657720666F726569676E20636C61737320616E64207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C6173732069732064657374726F7965642062792074686520586F6A6F206672616D65776F726B2E
		Event BindForeignClass(className As String) As ObjoScript.ForeignClassDelegates
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E205468697320697320706572666F726D6564206F6E636520666F72206561636820666F726569676E206D6574686F642C207768656E2074686520636C617373206973206669727374206465636C617265642E
		Event BindForeignMethod(className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 6073602069732061206465627567206D6573736167652066726F6D2074686520564D2E
		Event DebugPrint(s As String)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 6073602069732074686520726573756C74206F66206576616C756174696E67206120607072696E74602065787072657373696F6E2E
		Event Print(s As String)
	#tag EndHook


	#tag Note, Name = Opcodes
		UInt8 : OPCODE (operand byte count)
		
		0:  OP_RETURN (0)
		1:  OP_CONSTANT (1)
		2:  OP_CONSTANT_LONG (2)
		3:  OP_NEGATE (0)
		4:  OP_ADD (0)
		5:  OP_SUBTRACT (0)
		6:  OP_DIVIDE (0)
		7:  OP_MULTIPLY (0)
		8:  OP_MODULO (0)
		9:  OP_NOT (0)
		10: OP_EQUAL (0)
		11: OP_GREATER (0)
		12: OP_LESS (0)
		13: OP_LESS_EQUAL (0)
		14: OP_GREATER_EQUAL (0)
		15: OP_NOT_EQUAL (0)
		16: OP_TRUE (0)
		17: OP_FALSE (0)
		18: OP_NOTHING (0)
		19: OP_POP (0)
		20: OP_SHIFT_LEFT (0)
		21: OP_SHIFT_RIGHT (0)
		22: OP_BITWISE_AND (0)
		23: OP_BITWISE_OR (0)
		24: OP_BITWISE_XOR (0)
		25: OP_LOAD_1 (0)
		26: OP_LOAD_0 (0)
		27: OP_LOAD_MINUS1 (0)
		28: OP_LOCAL_VAR_DEC (3)
		29: OP_ASSERT (0)
		30: OP_DEFINE_GLOBAL (1)
		31: OP_DEFINE_GLOBAL_LONG (2)
		32: OP_GET_GLOBAL (1)
		33: OP_GET_GLOBAL_LONG (2)
		34: OP_SET_GLOBAL (1)
		35: OP_SET_GLOBAL_LONG (2)
		36: OP_POP_N (1)
		37: OP_GET_LOCAL (1)
		38: OP_SET_LOCAL (1)
		39: OP_JUMP_IF_FALSE (2)
		40: OP_JUMP (2)
		41: OP_JUMP_IF_TRUE (2)
		42: OP_LOGICAL_XOR (0)
		43: OP_LOOP (2)
		44: OP_RANGE (0)
		45: OP_BITWISE_NOT (0)
		46: OP_EXIT (0)
		47: OP_CALL (1)
		48: OP_CLASS (3)
		49: OP_GET_LOCAL_CLASS (1)
		50: OP_METHOD (3)
		51: OP_IS (0)
		52: OP_SETTER (1)
		53: OP_SETTER_LONG (2)
		54: OP_GETTER (1)
		55: OP_GETTER_LONG (2)
		56: OP_GET_FIELD (1)
		57: OP_GET_FIELD_LONG (2)
		58: OP_SET_FIELD (1)
		59: OP_SET_FIELD_LONG (2)
		60: OP_CONSTRUCTOR (1)
		61: OP_INVOKE (2)
		62: OP_INVOKE_LONG (3)
		63: OP_INHERIT (0)
		64: OP_LIST (1)
		65: **Unused**
		66: OP_SUPER_SETTER (4)
		67: **Unused**
		68: OP_SUPER_INVOKE (4)
		69: **Unused**
		70: OP_SUPER_CONSTRUCTOR (3)
		71: **Unused**
		72: OP_GET_STATIC_FIELD (1)
		73: OP_GET_STATIC_FIELD_LONG (2)
		74: OP_SET_STATIC_FIELD (1)
		75: OP_SET_STATIC_FIELD_LONG (2)
		76: OP_FOREIGN_METHOD (3)
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520736C6F742061727261792E205573656420746F20706173732064617461206265747765656E2074686520564D20616E642074686520686F737420586F6A6F206170706C69636174696F6E2E
		Private APISlots(-1) As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436F6E7461696E7320616C6C20626F756E64206D6574686F647320637265617465642061732043616C6C48616E646C65732062792074686520564D2E
		Private CallHandles() As ObjoScript.BoundMethod
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E742063616C6C206672616D652E
		Private CurrentFrame As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520564D27732064656275676765722E
		Private Debugger As ObjoScript.Debugger
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520564D20697320696E206C6F7720706572666F726D616E6365206465627567206D6F646520616E642063616E20696E7465726163742077697468206368756E6B7320636F6D70696C656420696E206465627567206D6F646520746F2070726F7669646520646562756767696E6720696E666F726D6174696F6E2E
		DebugMode As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E756D626572206F66206F6E676F696E672066756E6374696F6E2063616C6C732E
		FrameCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120737461636B206F662063616C6C206672616D65732E
		Private Frames(-1) As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F7265732074686520564D277320676C6F62616C207661726961626C65732E204B6579203D207661726961626C65206E616D652028537472696E67292C2056616C7565203D207661726961626C652076616C7565202856617269616E74292E
		Private Globals As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063616C6C206672616D6520647572696E67207468652070726576696F757320696E737472756374696F6E2E
		Private LastInstructionFrame As ObjoScript.CallFrame
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 546865206C696E65206E756D6265722074686520564D206C6173742073746F70706564206F6E2E2057696C6C20626520602D31602069662074686520564D206861732079657420746F2073746F70206F6E2061206C696E652E
		#tag Getter
			Get
			  Return mLastStoppedLine
			End Get
		#tag EndGetter
		LastStoppedLine As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 546865204944206F6620746865207363726970742074686520564D206C6173742073746F7070656420696E2E20602D316020666F7220746865207374616E64617264206C6962726172792E205479706963616C6C792060306020666F72206D6F737420736372697074732E
		Private LastStoppedScriptID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206F6620636F64652074686520564D206C6173742073746F70706564206F6E2E
		Private mLastStoppedLine As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520564D2073686F756C642073746F7020617420746865206E657874206F70706F7274756E69747920287072696F7220746F20746865206E65787420696E737472756374696F6E206665746368292E204F6E6C7920776F726B73207768656E206044656275674D6F64656020697320547275652E
		Private mShouldStop As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53696E676C65746F6E20696E7374616E6365206F6620224E6F7468696E67222E
		Private Nothing As ObjoScript.Nothing
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4B6579203D206F70636F64652028496E7465676572292C2056616C7565203D206E756D626572206F66206279746573207573656420666F72206F706572616E64732E
		#tag Getter
			Get
			  Static d As New Dictionary( _
			  OP_RETURN                 : 0, _
			  OP_CONSTANT               : 1, _
			  OP_CONSTANT_LONG          : 2, _
			  OP_NEGATE                 : 0, _
			  OP_ADD                    : 0, _
			  OP_SUBTRACT               : 0, _
			  OP_DIVIDE                 : 0, _
			  OP_MULTIPLY               : 0, _
			  OP_MODULO                 : 0, _
			  OP_NOT                    : 0, _
			  OP_EQUAL                  : 0 , _
			  OP_GREATER                : 0, _
			  OP_LESS                   : 0, _
			  OP_LESS_EQUAL             : 0, _
			  OP_GREATER_EQUAL          : 0, _
			  OP_NOT_EQUAL              : 0, _
			  OP_TRUE                   : 0, _
			  OP_FALSE                  : 0, _
			  OP_NOTHING                : 0, _
			  OP_POP                    : 0, _
			  OP_SHIFT_LEFT             : 0, _
			  OP_SHIFT_RIGHT            : 0, _
			  OP_BITWISE_AND            : 0, _
			  OP_BITWISE_OR             : 0, _
			  OP_BITWISE_XOR            : 0, _
			  OP_LOAD_1                 : 0, _
			  OP_LOAD_0                 : 0, _
			  OP_LOAD_MINUS1            : 0, _
			  OP_ASSERT                 : 0, _
			  OP_DEFINE_GLOBAL          : 1, _
			  OP_DEFINE_GLOBAL_LONG     : 2, _
			  OP_GET_GLOBAL             : 1, _
			  OP_GET_GLOBAL_LONG        : 2, _
			  OP_SET_GLOBAL             : 1, _
			  OP_SET_GLOBAL_LONG        : 2, _
			  OP_POP_N                  : 1, _
			  OP_GET_LOCAL              : 1, _
			  OP_SET_LOCAL              : 1, _
			  OP_JUMP_IF_FALSE          : 2, _
			  OP_JUMP                   : 2, _
			  OP_JUMP_IF_TRUE           : 2, _
			  OP_LOGICAL_XOR            : 0, _
			  OP_LOOP                   : 2, _
			  OP_RANGE                  : 0, _
			  OP_EXIT                   : 0, _
			  OP_CALL                   : 1, _
			  OP_CLASS                  : 3, _
			  OP_METHOD                 : 3, _
			  OP_SETTER                 : 1, _
			  OP_SETTER_LONG            : 2, _
			  OP_GETTER                 : 1, _
			  OP_GETTER_LONG            : 2, _
			  OP_GET_FIELD              : 1, _
			  OP_GET_FIELD_LONG         : 2, _
			  OP_SET_FIELD              : 1, _
			  OP_SET_FIELD_LONG         : 2, _
			  OP_CONSTRUCTOR            : 1, _
			  OP_INVOKE                 : 2, _
			  OP_INVOKE_LONG            : 3, _
			  OP_INHERIT                : 0, _
			  OP_SUPER_SETTER           : 4, _
			  OP_SUPER_INVOKE           : 4, _
			  OP_GET_STATIC_FIELD       : 1, _
			  OP_GET_STATIC_FIELD_LONG  : 2, _
			  OP_SET_STATIC_FIELD       : 1, _
			  OP_SET_STATIC_FIELD_LONG  : 2, _
			  OP_FOREIGN_METHOD         : 3, _
			  OP_IS                     : 0, _
			  OP_GET_LOCAL_CLASS        : 1, _
			  OP_LOCAL_VAR_DEC          : 3, _
			  OP_BITWISE_NOT            : 0, _
			  OP_SUPER_CONSTRUCTOR      : 3, _
			  OP_LIST                   : 1 _
			  )
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Shared OpcodeOperandMap As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 54686520564D277320737461636B2E
		Private Stack(-1) As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506F696E747320746F2074686520696E64657820696E2060537461636B60206A757374202A706173742A2074686520656C656D656E7420636F6E7461696E696E672074686520746F702076616C75652E205468657265666F726520603060206D65616E732074686520737461636B20697320656D7074792E20497427732074686520696E64657820746865206E6578742076616C75652077696C6C2062652070757368656420746F2E
		Private StackTop As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520564D2077696C6C206F75747075742028766961206974732044656275675072696E74206576656E74292074686520737461636B20636F6E74656E747320616E642063757272656E74206F70636F64652061732069742065786563757465732E
		TraceExecution As Boolean = False
	#tag EndProperty


	#tag Constant, Name = CONSTRUCTOR_SIG_0, Type = String, Dynamic = False, Default = \"constructor()", Scope = Private, Description = 507265636F6D7075746564207369676E617475726520666F722061207A65726F20617267756D656E7420636F6E7374727563746F72207369676E61747572652E
	#tag EndConstant

	#tag Constant, Name = CONSTRUCTOR_SIG_1, Type = String, Dynamic = False, Default = \"constructor(_)", Scope = Private, Description = 507265636F6D7075746564207369676E617475726520666F7220612073696E676C6520617267756D656E7420636F6E7374727563746F72207369676E61747572652E
	#tag EndConstant

	#tag Constant, Name = CONSTRUCTOR_SIG_2, Type = String, Dynamic = False, Default = \"constructor(_\x2C_)", Scope = Private, Description = 507265636F6D7075746564207369676E617475726520666F7220612074776F20617267756D656E7420636F6E7374727563746F72207369676E61747572652E
	#tag EndConstant

	#tag Constant, Name = MAX_FRAMES, Type = Double, Dynamic = False, Default = \"63", Scope = Public, Description = 54686520757070657220626F756E6473206F66207468652063616C6C206672616D6520737461636B2E
	#tag EndConstant

	#tag Constant, Name = MAX_SLOTS, Type = Double, Dynamic = False, Default = \"255", Scope = Public, Description = 54686520757070657220626F756E6473206F66207468652041504920736C6F742061727261792E204C696D6974656420746F2032353520617267756D656E74732073696E63652074686520617267756D656E7420636F756E7420666F72206D616E79206F70636F64657320697320612073696E676C6520627974652E
	#tag EndConstant

	#tag Constant, Name = MAX_STACK, Type = Double, Dynamic = False, Default = \"255", Scope = Public, Description = 54686520757070657220626F756E6473206F662074686520737461636B2E
	#tag EndConstant

	#tag Constant, Name = OP_ADD, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_ASSERT, Type = Double, Dynamic = False, Default = \"29", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_AND, Type = Double, Dynamic = False, Default = \"22", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_NOT, Type = Double, Dynamic = False, Default = \"45", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_OR, Type = Double, Dynamic = False, Default = \"23", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_XOR, Type = Double, Dynamic = False, Default = \"24", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CALL, Type = Double, Dynamic = False, Default = \"47", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CLASS, Type = Double, Dynamic = False, Default = \"48", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CONSTANT, Type = Double, Dynamic = False, Default = \"1", Scope = Public, Description = 5468652061646420636F6E7374616E74206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_CONSTANT_LONG, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 5468652061646420636F6E7374616E74202831362D62697429206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_CONSTRUCTOR, Type = Double, Dynamic = False, Default = \"60", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DEFINE_GLOBAL, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DEFINE_GLOBAL_LONG, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DIVIDE, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_EQUAL, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_EXIT, Type = Double, Dynamic = False, Default = \"46", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_FALSE, Type = Double, Dynamic = False, Default = \"17", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_FOREIGN_METHOD, Type = Double, Dynamic = False, Default = \"76", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GETTER, Type = Double, Dynamic = False, Default = \"54", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GETTER_LONG, Type = Double, Dynamic = False, Default = \"55", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_FIELD, Type = Double, Dynamic = False, Default = \"56", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_FIELD_LONG, Type = Double, Dynamic = False, Default = \"57", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_GLOBAL, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_GLOBAL_LONG, Type = Double, Dynamic = False, Default = \"33", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_LOCAL, Type = Double, Dynamic = False, Default = \"37", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_LOCAL_CLASS, Type = Double, Dynamic = False, Default = \"49", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_STATIC_FIELD, Type = Double, Dynamic = False, Default = \"72", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GET_STATIC_FIELD_LONG, Type = Double, Dynamic = False, Default = \"73", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GREATER, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GREATER_EQUAL, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INHERIT, Type = Double, Dynamic = False, Default = \"63", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INVOKE, Type = Double, Dynamic = False, Default = \"61", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INVOKE_LONG, Type = Double, Dynamic = False, Default = \"62", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_IS, Type = Double, Dynamic = False, Default = \"51", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_JUMP, Type = Double, Dynamic = False, Default = \"40", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_JUMP_IF_FALSE, Type = Double, Dynamic = False, Default = \"39", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_JUMP_IF_TRUE, Type = Double, Dynamic = False, Default = \"41", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LESS, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LESS_EQUAL, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LIST, Type = Double, Dynamic = False, Default = \"64", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_0, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_1, Type = Double, Dynamic = False, Default = \"25", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_MINUS1, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOCAL_VAR_DEC, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOGICAL_XOR, Type = Double, Dynamic = False, Default = \"42", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOOP, Type = Double, Dynamic = False, Default = \"43", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_METHOD, Type = Double, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_MODULO, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_MULTIPLY, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NEGATE, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOT, Type = Double, Dynamic = False, Default = \"9", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOTHING, Type = Double, Dynamic = False, Default = \"18", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_NOT_EQUAL, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_POP, Type = Double, Dynamic = False, Default = \"19", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_POP_N, Type = Double, Dynamic = False, Default = \"36", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_RANGE, Type = Double, Dynamic = False, Default = \"44", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_RETURN, Type = Double, Dynamic = False, Default = \"0", Scope = Public, Description = 5468652072657475726E206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_SETTER, Type = Double, Dynamic = False, Default = \"52", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SETTER_LONG, Type = Double, Dynamic = False, Default = \"53", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_FIELD, Type = Double, Dynamic = False, Default = \"58", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_FIELD_LONG, Type = Double, Dynamic = False, Default = \"59", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_GLOBAL, Type = Double, Dynamic = False, Default = \"34", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_GLOBAL_LONG, Type = Double, Dynamic = False, Default = \"35", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_LOCAL, Type = Double, Dynamic = False, Default = \"38", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_STATIC_FIELD, Type = Double, Dynamic = False, Default = \"74", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SET_STATIC_FIELD_LONG, Type = Double, Dynamic = False, Default = \"75", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SHIFT_LEFT, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SHIFT_RIGHT, Type = Double, Dynamic = False, Default = \"21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUBTRACT, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_CONSTRUCTOR, Type = Double, Dynamic = False, Default = \"70", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_INVOKE, Type = Double, Dynamic = False, Default = \"68", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_SETTER, Type = Double, Dynamic = False, Default = \"66", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_TRUE, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant


	#tag Enum, Name = StepModes, Type = Integer, Flags = &h0
		None
		  StepInto
		StepOver
	#tag EndEnum


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
			Name="DebugMode"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TraceExecution"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FrameCount"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastStoppedLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
