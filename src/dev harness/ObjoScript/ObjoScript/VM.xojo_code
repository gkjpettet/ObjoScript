#tag Class
Protected Class VM
	#tag Method, Flags = &h21
		Private Sub AddFieldNameToClass(fieldName As String, fieldIndex As Integer)
		  /// Add a named field to the class on the top of the stack.
		  ///
		  /// When the compiler is building a debuggable chunk, it will emit the names and indexes 
		  /// of all of a class' fields. 
		  /// The compiler will have ensured that the class to add to is on the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  klass.Fields(fieldIndex) = fieldName
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If className.CompareCase("Boolean") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Boolean_.Allocate, Nil)
		    
		  ElseIf className.CompareCase("FSItem") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.FSItem.Allocate, Nil)
		    
		  ElseIf className.CompareCase("KeyValue") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.KeyValue.Allocate, Nil)
		    
		  ElseIf className.CompareCase("List") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.List.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Map") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Map.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Maths") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Maths.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Nothing") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Nothing.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Number") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Number.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Object") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Object_.Allocate, Nil)
		    
		  ElseIf className.CompareCase("Random") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.Random_.Allocate, Nil)
		    
		  ElseIf className.CompareCase("String") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.String_.Allocate, Nil)
		    
		  ElseIf className.CompareCase("System") Then
		    Return New ObjoScript.ForeignClassDelegates(AddressOf ObjoScript.Core.System_.Allocate, Nil)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E2054686520686F7374206170706C69636174696F6E2077696C6C2068617665206661696C656420746F2070726F76696465206F6E652E2052657475726E73204E696C206966206E6F6E6520646566696E65642E
		Private Function BindCoreForeignMethod(className As String, signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// The VM is requesting the delegate to use when calling the specified foreign method on a class. 
		  /// The host application will have failed to provide one. Returns Nil if none defined.
		  ///
		  /// We check our standard libraries.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  If className.CompareCase("Boolean") Then
		    Return Core.Boolean_.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("FSItem") Then
		    Return Core.FSItem.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("KeyValue") Then
		    Return Core.KeyValue.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("List") Then
		    Return Core.List.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Map") Then
		    Return Core.Map.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Maths") Then
		    Return Core.Maths.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Nothing") Then
		    Return Core.Nothing.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Number") Then
		    Return Core.Number.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Object") Then
		    Return Core.Object_.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("Random") Then
		    Return Core.Random_.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("String") Then
		    Return Core.String_.BindForeignMethod(signature, isStatic)
		    
		  ElseIf className.CompareCase("System") Then
		    Return Core.System_.BindForeignMethod(signature, isStatic)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 2243616C6C7322206120636C6173732E20457373656E7469616C6C79207468697320637265617465732061206E657720696E7374616E63652E
		Private Sub CallClass(klass As ObjoScript.Klass, argCount As Integer)
		  /// "Calls" a class. Essentially this creates a new instance.
		  ///
		  /// At the moment this method is called, the stack looks like this:
		  /// |           <--- StackTop
		  /// | argN      
		  /// | arg1
		  /// | klass
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Replace the class with a new blank instance of that class.
		  Stack(StackTop - argCount - 1) = New ObjoScript.Instance(Self, klass)
		  
		  // Invoke the constructor (if defined).
		  Var constructor As ObjoScript.Func
		  If argCount <= klass.Constructors.LastIndex Then
		    constructor = klass.Constructors(argCount)
		  End If
		  
		  // We allow a class to omit providing a default (zero parameter) constructor.
		  If constructor = Nil And argCount <> 0 Then
		    Error("There is no `" + klass.Name + "` constructor that expects " + argCount.ToString + If(argCount = 1, " argument.", " arguments."))
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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

	#tag Method, Flags = &h21, Description = 43616C6C73206120636F6D70696C65642066756E6374696F6E2E2060617267436F756E746020697320746865206E756D626572206F6620617267756D656E7473206F6E2074686520737461636B20666F7220746869732066756E6374696F6E2063616C6C2E20546869732069732061737365727465642E
		Private Sub CallFunction(f As ObjoScript.Func, argCount As Integer)
		  /// Calls a compiled function.
		  /// `argCount` is the number of arguments on the stack for this function call. This is asserted.
		  
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
		  If FrameCount >= MAX_FRAMES Then
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

	#tag Method, Flags = &h21, Description = 506572666F726D7320612063616C6C206F6E20607660207768696368206578706563747320746F2066696E642060617267436F756E746020617267756D656E747320696E207468652063616C6C20737461636B2E
		Private Sub CallValue(v As Variant, argCount As Integer)
		  /// Performs a call on `v` which expects to find `argCount` arguments in the call stack.
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var argCount As Integer = ObjoScript.ComputeArityFromSignature(signature, Self)
		  
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

	#tag Method, Flags = &h21, Description = 437265617465732061206E6577206B65792076616C756520696E7374616E63652E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865206B657920616E642076616C7565206F6E2074686520737461636B207769746820746865204B657956616C756520636C6173732062656E65617468207468656D2E
		Private Sub CreateKeyValue()
		  /// Creates a new key value instance. The compiler will have placed the key and value on the stack
		  /// with the KeyValue class beneath them.
		  ///
		  /// key             <-- top of stack
		  /// value
		  /// KeyValue class
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Call the 2 argument KeyValue constructor.
		  Call CallClass(Peek(2), 2)
		  
		  // Read the key and value.
		  Var data As Pair = Pop : Pop
		  
		  // The top of the stack will now be a KeyValue instance.
		  // Set it's foreign data.
		  Var kv As ObjoScript.Instance = Stack(StackTop - 1)
		  kv.ForeignData = data
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174652061206E6577206C697374206C69746572616C2E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865204C69737420636C617373206F6E2074686520737461636B20616E6420616E7920696E697469616C20656C656D656E74732061626F766520746869732E
		Private Sub CreateListLiteral(itemCount As Integer)
		  /// Create a new list literal. The compiler will have placed the List class on the stack
		  /// and any initial elements above this.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Pop and store any optional initial elements.
		  Var items() As Variant
		  For i As Integer = 1 To itemCount
		    items.AddAt(0, Pop)
		  Next i
		  
		  // Call the default list constructor.
		  Call CallClass(Peek(0), 0)
		  
		  // The top of the stack will now be a List instance.
		  // Add the initial elements to it's foreign data.
		  Var list As ObjoScript.Instance = Stack(StackTop - 1)
		  ObjoScript.Core.List.ListData(list.ForeignData).Items = items
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174652061206E6577206D6170206C69746572616C2E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865204D617020636C617373206F6E2074686520737461636B20616E6420616E7920696E697469616C206B65792D76616C75652070616972732061626F766520746869732E
		Private Sub CreateMapLiteral(keyValueCount As Integer)
		  /// Create a new map literal. The compiler will have placed the Map class on the stack
		  /// and any initial key-value pairs above this.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Pop and store any optional initial key-values.
		  // These are compiled so the key is above the value on the stack.
		  Var keyValues As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  For i As Integer = 1 To keyValueCount
		    keyValues.Value(Pop) = Pop
		  Next i
		  
		  // Call the 0 argument Map constructor.
		  Call CallClass(Peek(0), 0)
		  
		  // The top of the stack will now be a Map instance.
		  // It's foreign data contains a dictionary that we will set to the key-values we popped off the stack.
		  Var map As ObjoScript.Instance = Stack(StackTop - 1)
		  ObjoScript.Core.Map.MapData(map.ForeignData).Dict = keyValues
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  // If this is one of Objo's built-in types we keep a reference to the class for use elsewhere.
		  // All the built-in types are foreign classes.
		  If klass.Name.CompareCase("Boolean") Then
		    mBooleanClass = klass
		    
		  ElseIf klass.Name.CompareCase("KeyValue") Then
		    mKeyValueClass = klass
		    
		  ElseIf klass.Name.CompareCase("List") Then
		    ListClass = klass
		    
		  ElseIf klass.Name.CompareCase("Nothing") Then
		    mNothingClass = klass
		    
		  ElseIf klass.Name.CompareCase("Number") Then
		    mNumberClass = klass
		    
		  ElseIf klass.Name.CompareCase("String") Then
		    mStringClass = klass
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061206D6574686F64207769746820607369676E61747572656020616E642060617269747960206F6E2074686520636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub DefineForeignMethod(signature As String, arity As UInt8, isStatic As Boolean)
		  /// Defines a method with `signature` and `arity` on the class on the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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

	#tag Method, Flags = &h21, Description = 54686520636F6D70696C657220686173206A75737420646566696E65642074686520604E6F7468696E676020636C61737320616E64206C656674206974206F6E2074686520746F70206F662074686520737461636B20666F722075732E20437265617465206F75722073696E676C6520696E7374616E6365206F66204E6F7468696E6720666F7220757365207468726F7567686F75742074686520564D2E
		Private Sub DefineNothing()
		  /// The compiler has just defined the `Nothing` class and left it on the top of the stack for us.
		  /// Create our single instance of Nothing for use throughout the VM.
		  ///
		  /// We'll leave the Nothing class on the stack - the compiler will pop it off for us momentarily.
		  
		  Nothing = New ObjoScript.Nothing(Self, NothingClass)
		  
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

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F6620616E20696E7374616E6365206669656C6420617420606669656C64496E646578602066726F6D2074686520696E7374616E63652063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetField(fieldIndex As Integer)
		  /// Retrieves the value of an instance field at `fieldIndex` from the instance currently on the top of the 
		  /// stack and then pushes it on to the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  Var value As Variant = instance.Fields(fieldIndex)
		  
		  // Push the value on to the stack.
		  Push(value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520737472696E6720726570726573656E746174696F6E206F66207468652076616C756520696E2060736C6F74602E
		Function GetSlotAsString(slot As Integer) As String
		  /// Returns the string representation of the value in `slot`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return ValueToString(APISlots(slot))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C756520696E2060736C6F74602E204974206D6179206265206120646F75626C652C20737472696E67206F7220616E20604F626A6F5363726970742E56616C7565602E
		Function GetSlotValue(slot As Integer) As Variant
		  /// Returns the value in `slot`. It may be a double, string or an `ObjoScript.Value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return APISlots(slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F66206120737461746963206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E6365206F7220636C6173732063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetStaticField(name As String)
		  /// Retrieves the value of a static field named `name` on the instance or class currently on the top of the 
		  /// stack and then pushes it on to the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Stack(frame.StackBase + slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207570206120746F702D6C6576656C207661726961626C65206E616D656420606E616D65602E2052657475726E73204E696C206966206E6F7420666F756E642E
		Function GetVariable(name As String) As Variant
		  /// Returns up a top-level variable named `name`.
		  /// Returns Nil if not found.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Globals.Lookup(name, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4C6F6F6B73207570206120746F702D6C6576656C207661726961626C65206E616D656420606E616D656020616E64207075747320697420696E207468652041504920736C6F742060736C6F74602E2052657475726E73205472756520696620666F756E64206F722046616C736520696620746865207661726961626C6520646F6573206E6F742065786973742E
		Function GetVariableInSlot(name As String, slot As Integer) As Boolean
		  /// Looks up a top-level variable named `name` and puts it in the API slot `slot`.
		  /// Returns True if found or False if the variable does not exist.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		    Var offset As Integer = CurrentFrame.IP // New variable as DisassembleInstruction mutates the offset.
		    RaiseEvent DebugPrint(Self.Debugger.DisassembleInstruction(CurrentChunk, offset))
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
		  // NB: We don't inherit static methods or constructors **unless** the immediate
		  // superclass is `Object`. In this case, we inherit the static methods.
		  // This allows `Object` to provide static operator overloads.
		  subclass.Methods = superclass.Methods.Clone
		  If superclass.Name.CompareCase("Object") Then
		    subclass.StaticMethods = superclass.StaticMethods.Clone
		  End If
		  
		  // This class should keep a reference to its superclass. Do this and pop it off the stack.
		  subclass.Superclass = Pop
		  
		End Sub
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Grab the receiver from the stack. It should be beneath any arguments to the invocation.
		  Var receiver As Variant = Peek(argCount)
		  Var isStatic As Boolean = False
		  Var klass As ObjoScript.Klass
		  If receiver.Type = Variant.TypeDouble Then
		    klass = NumberClass
		    
		  ElseIf receiver.Type = Variant.TypeString Then
		    klass = StringClass
		    
		  ElseIf receiver IsA ObjoScript.Klass Then
		    klass = ObjoScript.Klass(receiver)
		    isStatic = True
		    
		  ElseIf receiver IsA ObjoScript.Instance Then
		    klass = ObjoScript.Instance(receiver).Klass
		    
		  ElseIf receiver.Type = Variant.TypeBoolean Then
		    klass = BooleanClass
		    
		  Else
		    Error("Only classes and instances have methods.")
		  End If
		  
		  If isStatic Then
		    // This is a static method invocation.
		    InvokeFromClass(klass, signature, argCount, True)
		    
		  Else
		    // The method is directly on the instance.
		    InvokeFromClass(klass, signature, argCount, False)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B657320616E206F7665726C6F616465642062696E617279206F70657261746F72206D6574686F64207769746820607369676E617475726560206F6E2074686520696E7374616E63652F636C61737320616E64206F706572616E64206F6E2074686520737461636B2E
		Private Sub InvokeBinaryOperator(signature As String)
		  /// Invokes an overloaded binary operator method with `signature` on the 
		  /// instance/class and operand on the stack.
		  ///
		  /// Raises a VM runtime error if the callee doesn't implement the overloaded operator.
		  /// operand              <---- top of the stack
		  /// callee to invoke on  <---- should be class/instance
		  
		  Var callee As Variant = Peek(1)
		  
		  Select Case callee.Type
		  Case Variant.TypeString
		    InvokeFromClass(StringClass, signature, 1, False)
		    
		  Case Variant.TypeDouble
		    InvokeFromClass(NumberClass, signature, 1, False)
		    
		  Case Variant.TypeBoolean
		    InvokeFromClass(BooleanClass, signature, 1, False)
		    
		  Else
		    If callee IsA ObjoScript.Instance Then
		      InvokeFromClass(ObjoScript.Instance(callee).Klass, signature, 1, False)
		      
		    ElseIf callee IsA ObjoScript.Klass Then
		      InvokeFromClass(ObjoScript.Klass(callee), signature, 1, True)
		      
		    Else
		      Error(ValueToString(callee) + " does not implement `" + signature + "`.")
		    End If
		  End Select
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var method As Variant
		  If isStatic Then
		    method = klass.StaticMethods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("There is no static method with signature `" + signature + "` on `" + klass.ToString + "`.")
		    End If
		  Else
		    method = klass.Methods.Lookup(signature, Nil)
		    If method = Nil Then
		      Error("`" + klass.ToString + "` instance does not implement `" + signature + "`.")
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
		  Else
		    InvokeFromClass(bound.Receiver, bound.Method.Signature, handle.ArgCount, bound.IsStatic)
		  End If
		  
		  Run
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B6573206120756E617279206F70657261746F72206F7665726C6F6164206D6574686F64207769746820607369676E617475726560206F6E2074686520696E7374616E63652F636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub InvokeUnaryOperator(signature As String)
		  /// Invokes a unary operator overload method with `signature` on the instance/class on the top of the stack.
		  ///
		  /// Raises a VM runtime error if the instance/class doesn't implement the operator overload.
		  /// value   <---- top of the stack
		  
		  Var value As Variant = Peek(0)
		  
		  If value.Type = Variant.TypeDouble Then
		    InvokeFromClass(NumberClass, signature, 0, False)
		    
		  ElseIf value.Type = Variant.TypeString Then
		    InvokeFromClass(StringClass, signature, 0, False)
		    
		  ElseIf value.Type = Variant.TypeBoolean Then
		    InvokeFromClass(BooleanClass, signature, 0, False)
		    
		  ElseIf value IsA ObjoScript.Instance Then
		    InvokeFromClass(ObjoScript.Instance(value).Klass, signature, 0, False)
		    
		  ElseIf value IsA ObjoScript.Klass Then
		    InvokeFromClass(ObjoScript.Klass(value), signature, 0, True)
		    
		  Else
		    Error(ValueToString(value) + " does not implement `" + signature + "`.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662060766020697320636F6E73696465726564202266616C736579222E
		Shared Function IsFalsey(v As Variant) As Boolean
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
		      OP_DEFINE_GLOBAL, OP_DEFINE_GLOBAL_LONG, OP_SET_FIELD, _
		      OP_SET_STATIC_FIELD, OP_SET_STATIC_FIELD_LONG, OP_RETURN, OP_LOOP, OP_CALL, _
		      OP_INVOKE, OP_INVOKE_LONG, OP_BREAKPOINT
		      Return True
		      
		    Else
		      Return False
		    End Select
		    
		  Case VM.StepModes.StepOver
		    Raise New UnsupportedOperationException("Stepping over is not yet implemented.")
		    
		  Else
		    Return False
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73205472756520696620607660206973202A6E6F742A20636F6E73696465726564202266616C736579222E
		Shared Function IsTruthy(v As Variant) As Boolean
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

	#tag Method, Flags = &h21, Description = 4372656174657320616E642072657475726E732061206E657720636C6173732E
		Private Function NewClass(className As String, isForeign As Boolean, fieldCount As Integer, firstFieldIndex As Integer) As ObjoScript.Klass
		  /// Creates and returns a new class.
		  
		  Var klass As New ObjoScript.Klass(className, isForeign, fieldCount, firstFieldIndex)
		  
		  // All classes (except `Object`, obviously) inherit Object's static methods.
		  If Not klass.Name.CompareCase("Object") Then
		    klass.StaticMethods = ObjoScript.Klass(Globals.Value("Object")).StaticMethods.Clone
		  End If
		  
		  Return klass
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E657720656D707479206C6973742E
		Function NewList() As ObjoScript.Instance
		  /// Creates and returns a new empty list.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577206C69737420636F6E73697374696E67206F6620606974656D73602E
		Function NewList(items() As String) As ObjoScript.Instance
		  /// Creates and returns a new list consisting of `items`.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData(items)
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577206C69737420636F6E73697374696E67206F6620606974656D73602E
		Function NewList(items() As Variant) As ObjoScript.Instance
		  /// Creates and returns a new list consisting of `items`.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData(items)
		  
		  Return list
		  
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

	#tag Method, Flags = &h21, Description = 506F70732074686520746F702076616C7565206F66662074686520737461636B20616E64207265706C61636573207468652076616C756520756E6465726E656174682077697468206076602E205468652065666665637420697320746F207265647563652074686520737461636B2068656967687420627920312E
		Private Sub PopAndReplaceTop(v As Variant)
		  /// Pops the top value off the stack and replaces the value underneath with `v`.
		  /// The effect is to reduce the stack height by 1.
		  ///
		  /// This method exists as several operations require us to pop two values off the stack
		  /// and then immediately push one back. This method saves a few method calls.
		  
		  Stack(StackTop - 2) = v
		  StackTop = StackTop - 1
		  
		End Sub
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
		  For i As Integer = 0 To Frames.LastIndex
		    Frames(i) = New ObjoScript.CallFrame
		  Next i
		  
		  // This will be set by the VM once it has defined the `Nothing` class within the runtime.
		  Nothing = Nil
		  
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
		  
		  mBooleanClass = Nil
		  mNumberClass = Nil
		  mStringClass = Nil
		  mNothingClass = Nil
		  mKeyValueClass = Nil
		  ListClass = Nil
		  
		  RandomInstance = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E732074686520696E7465727072657465722E20417373756D657320697420686173206265656E20696E697469616C69736564207072696F7220746F207468697320616E642068617320612076616C69642063616C6C206672616D6520746F20657865637574652E
		Sub Run(stepMode As ObjoScript.VM.StepModes = ObjoScript.VM.StepModes.None)
		  /// Runs the interpreter. 
		  /// Assumes it has been initialised prior to this and has a valid call frame to execute.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Make sure we don't try to step in with an out of bounds instruction pointer.
		  If CurrentFrame.IP > CurrentChunk.Code.LastIndex Then Return
		  
		  While True
		    
		    If Self.DebugMode And CurrentChunk.IsDebug Then
		      If mShouldStop Then
		        RaiseEvent WillStop(Self.LastStoppedScriptID, Self.LastStoppedLine)
		        Return
		      End If
		      If HandleStepping(stepMode) Then
		        RaiseEvent WillStop(Self.LastStoppedScriptID, Self.LastStoppedLine)
		        Return
		      End If
		    End If
		    
		    Select Case ReadByte
		    Case OP_RETURN
		      // Get the return value off the stack.
		      Var result As Variant = Pop
		      
		      // We always put the return value in slot 0 of `APISlots` so the host application can access it.
		      APISlots(0) = result
		      
		      // If this is the last frame, exit the VM.
		      // We check if FrameCount is 1, not 0 here because we haven't actually
		      // dropped the frame yet.
		      If FrameCount = 1 Then
		        StackTop = 0
		        RaiseEvent Finished
		        Return
		      End If
		      
		      // Reset the stack top to what it was prior to this call.
		      StackTop = CurrentFrame.StackBase
		      
		      // Drop the frame.
		      FrameCount = FrameCount - 1
		      
		      // Push the result to the top of the stack.
		      Push(result)
		      
		    Case OP_CONSTANT
		      Push(ReadConstant)
		      
		    Case OP_CONSTANT_LONG
		      Push(ReadConstantLong)
		      
		    Case OP_LOAD_0
		      Push(CType(0, Double))
		      
		    Case OP_LOAD_1
		      Push(CType(1, Double))
		      
		    Case OP_LOAD_2
		      Push(CType(2, Double))
		      
		    Case OP_LOAD_MINUS1
		      Push(CType(-1, Double))
		      
		    Case OP_LOAD_MINUS2
		      Push(CType(-2, Double))
		      
		    Case OP_NEGATE
		      If Peek(0).Type = Variant.TypeDouble Then
		        Stack(StackTop - 1) = -Stack(StackTop - 1).DoubleValue
		      ElseIf Peek(0) IsA ObjoScript.Instance Then
		        InvokeFromClass(ObjoScript.Instance(Peek(0)).Klass, "-()", 0, False)
		      ElseIf Peek(0) IsA ObjoScript.Klass Then
		        InvokeFromClass(ObjoScript.Klass(Peek(0)), "-()", 0, True)
		      Else
		        Error(ValueToString(Peek(0)) + " does not implement `+(_)`.")
		      End If
		      
		    Case OP_ADD
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(CType(Peek(1) + Peek(0), Double))
		      Else
		        InvokeBinaryOperator("+(_)")
		      End If
		      
		    Case OP_ADD1
		      If Peek(0).Type = Variant.TypeDouble Then
		        Push(CType(Pop, Double) + 1.0)
		      Else
		        Push(1.0)
		        InvokeBinaryOperator("+(_)")
		      End If
		      
		    Case OP_SUBTRACT
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(CType(Peek(1) - Peek(0), Double))
		      Else
		        InvokeBinaryOperator("-(_)")
		      End If
		      
		    Case OP_SUBTRACT1
		      If Peek(0).Type = Variant.TypeDouble Then
		        Push(CType(Pop, Double) - 1.0)
		      Else
		        Push(1.0)
		        InvokeBinaryOperator("-(_)")
		      End If
		      
		    Case OP_DIVIDE
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(CType(Peek(1) / Peek(0), Double))
		      Else
		        InvokeBinaryOperator("/(_)")
		      End If
		      
		    Case OP_MULTIPLY
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(CType(Peek(1) * Peek(0), Double))
		      Else
		        InvokeBinaryOperator("*(_)")
		      End If
		      
		    Case OP_MODULO
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(CType(Peek(1) Mod Peek(0), Double))
		      Else
		        InvokeBinaryOperator("%(_)")
		      End If
		      
		    Case OP_NOT
		      If Stack(StackTop - 1).Type = Variant.TypeBoolean Then
		        // "notting" a boolean is so common we'll implement it inline.
		        Stack(StackTop - 1) = Not Stack(StackTop - 1).BooleanValue
		      Else
		        InvokeUnaryOperator("not()")
		      End If
		      
		    Case OP_EQUAL
		      InvokeBinaryOperator("==(_)")
		      
		    Case OP_NOT_EQUAL
		      InvokeBinaryOperator("<>(_)")
		      
		    Case OP_GREATER
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Peek(1).DoubleValue > Peek(0).DoubleValue)
		      Else
		        InvokeBinaryOperator(">(_)")
		      End If
		      
		    Case OP_GREATER_EQUAL
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Peek(1).DoubleValue >= Peek(0).DoubleValue)
		      Else
		        InvokeBinaryOperator(">=(_)")
		      End If
		      
		    Case OP_LESS
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Peek(1).DoubleValue < Peek(0).DoubleValue)
		      Else
		        InvokeBinaryOperator("<(_)")
		      End If
		      
		    Case OP_LESS_EQUAL
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Peek(1).DoubleValue <= Peek(0).DoubleValue)
		      Else
		        InvokeBinaryOperator("<=(_)")
		      End If
		      
		    Case OP_TRUE
		      Push(True)
		      
		    Case OP_FALSE
		      Push(False)
		      
		    Case OP_NOTHING
		      Push(Nothing)
		      
		    Case OP_POP
		      StackTop = StackTop - 1
		      
		    Case OP_POP_N
		      // Pop N values off the stack. N is the operand.
		      StackTop = StackTop - ReadByte
		      
		    Case OP_SHIFT_LEFT
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Ctype(Bitwise.ShiftLeft(Peek(1).IntegerValue, Peek(0).IntegerValue), Double))
		      Else
		        InvokeBinaryOperator("<<(_)")
		      End If
		      
		    Case OP_SHIFT_RIGHT
		      If TopOfStackAreNumbers Then
		        PopAndReplaceTop(Ctype(Bitwise.ShiftRight(Peek(1).IntegerValue, Peek(0).IntegerValue), Double))
		      Else
		        InvokeBinaryOperator(">>(_)")
		      End If
		      
		    Case OP_BITWISE_AND
		      If TopOfStackAreNumbers Then
		        // Bitwise operators work on 32-bit unsigned integers.
		        PopAndReplaceTop(Ctype(Peek(1).UInt32Value And Peek(0).UInt32Value, Double))
		      Else
		        InvokeBinaryOperator("&(_)")
		      End If
		      
		    Case OP_BITWISE_OR
		      If TopOfStackAreNumbers Then
		        // Bitwise operators work on 32-bit unsigned integers.
		        PopAndReplaceTop(Ctype(Peek(1).UInt32Value Or Peek(0).UInt32Value, Double))
		      Else
		        InvokeBinaryOperator("|(_)")
		      End If
		      
		    Case OP_BITWISE_XOR
		      If TopOfStackAreNumbers Then
		        // Bitwise operators work on 32-bit unsigned integers.
		        PopAndReplaceTop(Ctype(Peek(1).UInt32Value Xor Peek(0).UInt32Value, Double))
		      Else
		        InvokeBinaryOperator("^(_)")
		      End If
		      
		    Case OP_BITWISE_NOT
		      If Stack(StackTop - 1).Type = Variant.TypeDouble Then
		        // Do the "bitwise not" operation in place for speed.
		        Stack(StackTop - 1) = CType(Not Stack(StackTop - 1).UInt32Value, Double)
		      Else
		        InvokeUnaryOperator("~()")
		      End If
		      
		    Case OP_ASSERT
		      // Pop the message.
		      Var message As String = ValueToString(Pop)
		      
		      // Pop the condition off the stack. If it's False then raise a runtime error.
		      If IsFalsey(Pop) Then Error("Failed assertion: " + message)
		      
		    Case OP_DEFINE_GLOBAL
		      // Define a global variable, the name of which requires a single byte operand to get its index.
		      Var name As String = ReadConstant
		      
		      // Is there a variable with this name already defined in the global scope?
		      If globals.HasKey(name) Then
		        Error("Redefined global variable `" + name + "`.")
		      End If
		      
		      // The value of the variable is on the top of the stack.
		      globals.Value(name) = Pop
		      
		    Case OP_DEFINE_GLOBAL_LONG
		      // Define a global variable, the name of which requires a two byte operand to get its index.
		      Var name As String = ReadConstantLong
		      
		      // Is there a variable with this name already defined in the global scope?
		      If globals.HasKey(name) Then
		        Error("Redefined global variable `" + name + "`.")
		      End If
		      
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
		      // Load the value at that slot and then push it on to the top of the stack.
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
		      Var b As Variant  = Pop
		      Var a As Variant  = Pop
		      Push(IsTruthy(a) Xor IsTruthy(b))
		      
		    Case OP_LOOP
		      // Unconditionally jump `offset` bytes _back_ from the current instruction pointer.
		      Var offset AS UInt16 = ReadUInt16
		      CurrentFrame.IP = CurrentFrame.IP - offset
		      
		    Case OP_RANGE_INCLUSIVE
		      InvokeBinaryOperator("...(_)")
		      
		    Case OP_RANGE_EXCLUSIVE
		      InvokeBinaryOperator("..<(_)")
		      
		    Case OP_EXIT
		      Error("Unexpected `exit` placeholder instruction. The chunk is invalid.")
		      
		    Case OP_CALL
		      // We peek past the arguments to find the function to call.
		      Var argcount As Integer = ReadByte
		      Call CallValue(Peek(argcount), argcount)
		      
		    Case OP_CLASS
		      Var className As String = ReadConstantLong
		      Var isForeign As Boolean = ReadByte = 1
		      Var fieldCount As Integer = ReadByte
		      Var firstFieldIndex As Integer = ReadByte
		      Push(NewClass(className, isForeign, fieldCount, firstFieldIndex))
		      If isForeign Then
		        DefineForeignClass
		      End If
		      
		    Case OP_METHOD
		      DefineMethod(ReadConstantLong, If(ReadByte = 0, False, True))
		      
		    Case OP_GET_FIELD
		      GetField(ReadByte)
		      
		    Case OP_SET_FIELD
		      SetField(ReadByte)
		      
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
		      InvokeBinaryOperator("is(_)")
		      
		    Case OP_LIST
		      CreateListLiteral(ReadByte)
		      
		    Case OP_MAP
		      CreateMapLiteral(ReadByte)
		      
		    Case OP_SWAP
		      // Swap the two values on the top of the stack.
		      // Do this in-place to avoid Push/Pop calls.
		      ' b        a
		      ' a   -->  b
		      Var b As Variant  = Stack(StackTop - 1)
		      Stack(StackTop - 1) = Stack(StackTop - 2)
		      Stack(StackTop - 2) = b
		      
		    Case OP_DEBUG_FIELD_NAME
		      AddFieldNameToClass(ReadConstantLong, ReadByte)
		      
		    Case OP_DEFINE_NOTHING
		      DefineNothing
		      
		    Case OP_KEYVALUE
		      CreateKeyValue
		      
		    Case OP_BREAKPOINT
		      // Exists to allow the VM to pause at a manually set break point.
		      mLastStoppedLine = CurrentChunk.LineForOffset(CurrentFrame.IP - 1)
		      LastStoppedScriptID = CurrentChunk.ScriptIDForOffset(CurrentFrame.IP - 1)
		      LastInstructionFrame = CurrentFrame
		      RaiseEvent WillStop(Self.LastStoppedScriptID, mLastStoppedLine)
		      Return
		      
		    End Select
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865206669656C6420617420606669656C64496E64657860206F6E2074686520696E7374616E63652074686174206973206F6E652066726F6D2074686520746F70206F662074686520737461636B20746F207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub SetField(fieldIndex As Integer)
		  /// Sets the field at `fieldIndex` on the instance that is one from the top of the stack to the value on the top of the stack.
		  ///
		  /// |
		  /// | ValueToAssign   <-- top of the stack
		  /// | Instance        <-- the instance that should have the field at `fieldIndex`.
		  /// |
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  Var value As Variant = Pop
		  instance.Fields(fieldIndex) = value
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20626F6F6C65616E2076616C7565206062602E
		Sub SetSlot(slot As Integer, b As Boolean)
		  /// Sets `slot` to boolean value `b`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = b
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20646F75626C652076616C7565206064602E
		Sub SetSlot(slot As Integer, d As Double)
		  /// Sets `slot` to double value `d`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F2060696E7374616E6365602E
		Sub SetSlot(slot As Integer, instance As ObjoScript.Instance)
		  /// Sets `slot` to `instance`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = instance
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20606B6C617373602E
		Sub SetSlot(slot As Integer, klass As ObjoScript.Klass)
		  /// Sets `slot` to `klass`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = klass
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20737472696E672076616C7565206073602E
		Sub SetSlot(slot As Integer, s As String)
		  /// Sets `slot` to string value `s`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 536574732060736C6F746020746F20606E6F7468696E67602E
		Sub SetSlotNothing(slot As Integer)
		  /// Sets `slot` to `nothing`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
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
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Get the super class. Since classes are all declared in the top level, it should be in Globals.
		  // The compiler will have checked that the superclass exists during compilation.
		  Var superclass As ObjoScript.Klass = Globals.Value(superclassName)
		  
		  // Call the correct method.
		  // The compiler will have guaranteed that the superclass has a method with this signature.
		  CallValue(superclass.Methods.Value(signature), argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662074686520746F702074776F2076616C75657320617265206E756D626572732E20417373756D657320746865726520617265206174206C656173742074776F2076616C756573206F6E2074686520737461636B2E
		Private Function TopOfStackAreNumbers() As Boolean
		  /// Returns True if the top two values are numbers.
		  /// Assumes there are at least two values on the stack.
		  
		  Return Peek(1).Type = Variant.TypeDouble And Peek(0).Type = Variant.TypeDouble
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206120564D2076616C75652E
		Shared Function ValueToString(v As Variant) As String
		  /// Returns a string representation of a VM value.
		  
		  Select Case v.Type
		  Case Variant.TypeString
		    Return v.StringValue
		    
		  Case Variant.TypeBoolean
		    Return If(v, "true", "false")
		    
		  Case Variant.TypeDouble
		    If v.DoubleValue.IsInteger Then
		      Return CType(v, Integer).ToString
		    Else
		      If v.DoubleValue.IsNotANumber Then
		        // Always return NaN, not -NaN as is returned on some platforms.
		        Return "NaN"
		      Else
		        Return v.DoubleValue.ToString(Locale.Current, "#.#########")
		      End If
		    End If
		    
		  Else
		    If v IsA ObjoScript.Nothing Then
		      Return "nothing"
		      
		    ElseIf v IsA ObjoScript.Instance Then
		      If ObjoScript.Instance(v).Klass.Name.CompareCase("KeyValue") Then
		        Return ObjoScript.Core.KeyValue.AsString(v)
		        
		      ElseIf ObjoScript.Instance(v).Klass.Name.CompareCase("Map") Then
		        Return ObjoScript.Core.Map.AsString(v)
		        
		      ElseIf ObjoScript.Instance(v).Klass.Name.CompareCase("List") Then
		        Return ObjoScript.Core.List.AsString(v)
		        
		      Else
		        Return ObjoScript.Instance(v).ToString
		      End If
		      
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

	#tag Hook, Flags = &h0, Description = 54686520564D206861732066696E697368656420657865637574696E672E
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 6073602069732074686520726573756C74206F66206576616C756174696E67206120607072696E74602065787072657373696F6E2E
		Event Print(s As String)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520564D2069732061626F757420746F2073746F702062656361757365206974206861732068697420612060627265616B706F696E74602073746174656D656E74206F7220686173207265616368656420746865206E657874206C696E65207768696C737420737465702D646562756767696E672E
		Event WillStop(scriptID As Integer, lineNumber As Integer)
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
		44: OP_RANGE_INCLUSIVE (0)
		45: OP_BITWISE_NOT (0)
		46: OP_EXIT (0)
		47: OP_CALL (1)
		48: OP_CLASS (5)
		49: OP_GET_LOCAL_CLASS (1)
		50: OP_METHOD (3)
		51: OP_IS (0)
		52: OP_SWAP (0)
		53: OP_DEBUG_FIELD_NAME (3)
		54: OP_DEFINE_NOTHING (0)
		55: OP_MAP (1)
		56: OP_GET_FIELD (1)
		57: OP_KEYVALUE (0)
		58: OP_SET_FIELD (1)
		59: OP_BREAKPOINT (0)
		60: OP_CONSTRUCTOR (1)
		61: OP_INVOKE (2)
		62: OP_INVOKE_LONG (3)
		63: OP_INHERIT (0)
		64: OP_LIST (1)
		65: OP_RANGE_EXCLUSIVE (0)
		66: OP_SUPER_SETTER (4)
		67: OP_LOAD_MINUS2 (0)
		68: OP_SUPER_INVOKE (5)
		69: **Unused**
		70: OP_SUPER_CONSTRUCTOR (3)
		71: **Unused**
		72: OP_GET_STATIC_FIELD (1)
		73: OP_GET_STATIC_FIELD_LONG (2)
		74: OP_SET_STATIC_FIELD (1)
		75: OP_SET_STATIC_FIELD_LONG (2)
		76: OP_FOREIGN_METHOD (4)
		77: OP_LOAD_2 (0)
		78: OP_ADD1 (0)
		79: OP_SUBTRACT1 (0)
		
	#tag EndNote


	#tag Property, Flags = &h21, Description = 54686520736C6F742061727261792E205573656420746F20706173732064617461206265747765656E2074686520564D20616E642074686520686F737420586F6A6F206170706C69636174696F6E2E
		Private APISlots(-1) As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E20426F6F6C65616E206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mBooleanClass
			End Get
		#tag EndGetter
		BooleanClass As ObjoScript.Klass
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 436F6E7461696E7320616C6C20626F756E64206D6574686F647320637265617465642061732043616C6C48616E646C65732062792074686520564D2E
		Private CallHandles() As ObjoScript.BoundMethod
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 5468652063757272656E742063616C6C206672616D652E
		#tag Getter
			Get
			  Return Frames(FrameCount - 1)
			  
			End Get
		#tag EndGetter
		CurrentFrame As ObjoScript.CallFrame
	#tag EndComputedProperty

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

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204B657956616C7565206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mKeyValueClass
			End Get
		#tag EndGetter
		KeyValueClass As ObjoScript.Klass
	#tag EndComputedProperty

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

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204C697374206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private ListClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E20426F6F6C65616E206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mBooleanClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204B657956616C7565206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mKeyValueClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206F6620636F64652074686520564D206C6173742073746F70706564206F6E2E
		Private mLastStoppedLine As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204E6F7468696E67206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mNothingClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204E756D626572206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mNumberClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520564D2073686F756C642073746F7020617420746865206E657874206F70706F7274756E69747920287072696F7220746F20746865206E65787420696E737472756374696F6E206665746368292E204F6E6C7920776F726B73207768656E206044656275674D6F64656020697320547275652E
		Private mShouldStop As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E20537472696E67206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mStringClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53696E676C65746F6E20696E7374616E6365206F6620224E6F7468696E67222E
		Nothing As ObjoScript.Nothing
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204E6F7468696E67206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mNothingClass
			End Get
		#tag EndGetter
		NothingClass As ObjoScript.Klass
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204E756D626572206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mNumberClass
			End Get
		#tag EndGetter
		NumberClass As ObjoScript.Klass
	#tag EndComputedProperty

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
			  OP_RANGE_INCLUSIVE        : 0, _
			  OP_EXIT                   : 0, _
			  OP_CALL                   : 1, _
			  OP_CLASS                  : 5, _
			  OP_METHOD                 : 3, _
			  OP_GET_FIELD              : 1, _
			  OP_SET_FIELD              : 1, _
			  OP_CONSTRUCTOR            : 1, _
			  OP_INVOKE                 : 2, _
			  OP_INVOKE_LONG            : 3, _
			  OP_INHERIT                : 0, _
			  OP_SUPER_SETTER           : 4, _
			  OP_SUPER_INVOKE           : 5, _
			  OP_GET_STATIC_FIELD       : 1, _
			  OP_GET_STATIC_FIELD_LONG  : 2, _
			  OP_SET_STATIC_FIELD       : 1, _
			  OP_SET_STATIC_FIELD_LONG  : 2, _
			  OP_FOREIGN_METHOD         : 4, _
			  OP_IS                     : 0, _
			  OP_GET_LOCAL_CLASS        : 1, _
			  OP_LOCAL_VAR_DEC          : 3, _
			  OP_BITWISE_NOT            : 0, _
			  OP_SUPER_CONSTRUCTOR      : 3, _
			  OP_LIST                   : 1, _
			  OP_SWAP                   : 0, _
			  OP_DEBUG_FIELD_NAME       : 3, _
			  OP_DEFINE_NOTHING         : 0, _
			  OP_MAP                    : 1, _
			  OP_KEYVALUE               : 0, _
			  OP_BREAKPOINT             : 0, _
			  OP_RANGE_EXCLUSIVE        : 0, _
			  OP_LOAD_2                 : 0, _
			  OP_ADD1                   : 0, _
			  OP_SUBTRACT1              : 0, _
			  OP_LOAD_MINUS2            : 0 _
			  )
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Shared OpcodeOperandMap As Dictionary
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652073696E676C65746F6E2052616E646F6D20696E7374616E63652E2057696C6C206265204E696C20756E74696C206669727374206163636573736564207468726F75676820604D617468732E72616E646F6D2829602E
		RandomInstance As ObjoScript.Instance
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520564D277320737461636B2E
		Private Stack(-1) As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506F696E747320746F2074686520696E64657820696E2060537461636B60206A757374202A706173742A2074686520656C656D656E7420636F6E7461696E696E672074686520746F702076616C75652E205468657265666F726520603060206D65616E732074686520737461636B20697320656D7074792E20497427732074686520696E64657820746865206E6578742076616C75652077696C6C2062652070757368656420746F2E
		Private StackTop As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E20537472696E67206B6C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mStringClass
			End Get
		#tag EndGetter
		StringClass As ObjoScript.Klass
	#tag EndComputedProperty

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

	#tag Constant, Name = OP_ADD1, Type = Double, Dynamic = False, Default = \"78", Scope = Public
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

	#tag Constant, Name = OP_BREAKPOINT, Type = Double, Dynamic = False, Default = \"59", Scope = Public
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

	#tag Constant, Name = OP_DEBUG_FIELD_NAME, Type = Double, Dynamic = False, Default = \"53", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DEFINE_GLOBAL, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DEFINE_GLOBAL_LONG, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_DEFINE_NOTHING, Type = Double, Dynamic = False, Default = \"54", Scope = Public
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

	#tag Constant, Name = OP_GET_FIELD, Type = Double, Dynamic = False, Default = \"56", Scope = Public
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

	#tag Constant, Name = OP_KEYVALUE, Type = Double, Dynamic = False, Default = \"57", Scope = Public
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

	#tag Constant, Name = OP_LOAD_2, Type = Double, Dynamic = False, Default = \"77", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_MINUS1, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_MINUS2, Type = Double, Dynamic = False, Default = \"67", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOCAL_VAR_DEC, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOGICAL_XOR, Type = Double, Dynamic = False, Default = \"42", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOOP, Type = Double, Dynamic = False, Default = \"43", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_MAP, Type = Double, Dynamic = False, Default = \"55", Scope = Public
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

	#tag Constant, Name = OP_RANGE_EXCLUSIVE, Type = Double, Dynamic = False, Default = \"65", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_RANGE_INCLUSIVE, Type = Double, Dynamic = False, Default = \"44", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_RETURN, Type = Double, Dynamic = False, Default = \"0", Scope = Public, Description = 5468652072657475726E206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_SET_FIELD, Type = Double, Dynamic = False, Default = \"58", Scope = Public
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

	#tag Constant, Name = OP_SUBTRACT1, Type = Double, Dynamic = False, Default = \"79", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_CONSTRUCTOR, Type = Double, Dynamic = False, Default = \"70", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_INVOKE, Type = Double, Dynamic = False, Default = \"68", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_SETTER, Type = Double, Dynamic = False, Default = \"66", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SWAP, Type = Double, Dynamic = False, Default = \"52", Scope = Public
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
