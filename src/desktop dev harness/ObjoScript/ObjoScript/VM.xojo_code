#tag Class
Protected Class VM
	#tag Method, Flags = &h21, Description = 416464732061206E616D6564206669656C6420746F2074686520636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub AddFieldNameToClass(fieldName As String, fieldIndex As Integer)
		  /// Adds a named field to the class on the top of the stack.
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

	#tag Method, Flags = &h21, Description = 54686520564D2069732072657175657374696E67207468652064656C65676174657320746F20757365207768656E20696E7374616E74696174696E672061206E657720666F726569676E20636C61737320616E64207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C6173732069732064657374726F7965642062792074686520586F6A6F206672616D65776F726B2E2054686973206D6574686F642069732063616C6C6564207768656E2074686520686F7374206170706C69636174696F6E206661696C656420746F2070726F76696465206F6E652E20576520636865636B206F7572207374616E64617264206C69627261726965732E
		Private Function BindCoreForeignClass(className As String) As ObjoScript.ForeignClassDelegates
		  /// The VM is requesting the delegates to use when instantiating a new foreign class and when an 
		  /// instance of a foreign class is destroyed by the Xojo framework. This method is called when 
		  /// the host application failed to provide one.
		  /// We check our standard libraries.
		  ///
		  /// Returns Nil if none defined.
		  
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

	#tag Method, Flags = &h21, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E2054686520686F7374206170706C69636174696F6E2077696C6C2068617665206661696C656420746F2070726F76696465206F6E652E20576520636865636B206F7572207374616E64617264206C69627261726965732E
		Private Function BindCoreForeignMethod(className As String, signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// The VM is requesting the delegate to use when calling the specified foreign method on a class. 
		  /// The host application will have failed to provide one.
		  /// We check our standard libraries.
		  ///
		  /// Returns Nil if none defined.
		  
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

	#tag Method, Flags = &h21, Description = 2243616C6C7322206120636C6173732E20457373656E7469616C6C79207468697320637265617465732061206E657720696E7374616E63652E20446F6573202A2A6E6F742A2A20757064617465206043757272656E744672616D65602E
		Private Sub CallClass(klass As ObjoScript.Klass, argCount As Integer)
		  /// "Calls" a class. Essentially this creates a new instance.
		  /// Does **not** update `CurrentFrame`. 
		  ///
		  /// At the moment this method is called, the stack should look like this:
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
		  
		  // If this is a foreign class, call the `allocate` delegate so the host can do any additional setup needed.
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

	#tag Method, Flags = &h21, Description = 43616C6C73206120636F6D70696C65642066756E6374696F6E2E2060617267436F756E746020697320746865206E756D626572206F6620617267756D656E7473207468617420617265206F6E2074686520737461636B20666F7220746869732066756E6374696F6E2063616C6C2E
		Private Sub CallFunction(f As ObjoScript.Func, argCount As Integer)
		  /// Calls a compiled function.
		  /// `argCount` is the number of arguments that are on the stack for this function call. This is asserted.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Check arity.
		  If argCount <> f.Arity Then
		    Error("Expected " + f.Arity.ToString + " arguments but " + _
		    "got " + argCount.ToString + ".")
		  End If
		  
		  // Make sure we don't overflow with a deep call frame (most likely a user error with 
		  // a runaway recursive issue).
		  If FrameCount >= MAX_FRAMES Then Error("Stack overflow.")
		  
		  // ==============================
		  // Set up the call frame to call.
		  // ==============================
		  Frames(FrameCount).Function_ = f
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

	#tag Method, Flags = &h21, Description = 506572666F726D7320612063616C6C206F6E2056616C756520607660207768696368206578706563747320746F2066696E642060617267436F756E746020617267756D656E747320696E207468652063616C6C20737461636B2E2055706461746573206043757272656E744672616D65602E
		Private Sub CallValue(v As Value, argCount As Integer)
		  /// Performs a call on Value `v` which expects to find `argCount` arguments in the call stack.
		  /// Updates `CurrentFrame`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Select Case v.Type
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

	#tag Method, Flags = &h0, Description = 4372656174657320612063616C6C2068616E646C6520666F722074686520737065636966696564206D6574686F64207369676E617475726520666F722074686520636C61737320696E20736C6F7420302E20417373756D657320736C6F74203020636F6E7461696E7320612076616C696420636C6173732E
		Function CreateHandle(methodSignature As String) As ObjoScript.CallHandle
		  /// Creates a call handle for the specified method signature for the class in slot 0.
		  /// Assumes slot 0 contains a valid class.
		  
		  // Assumes the class for this method is in slot 0.
		  Var receiver As ObjoScript.Klass
		  Try
		    receiver = APISlots(0)
		  Catch e As IllegalCastException
		    Error("Cannot create call handle as expected a class in slot 0.")
		  End Try
		  
		  // Find the method.
		  Var bm As ObjoScript.BoundMethod
		  If receiver.StaticMethods.HasKey(methodSignature) Then
		    If receiver.StaticMethods.Value(methodSignature) IsA ObjoScript.ForeignMethod Then
		      Var method As ObjoScript.ForeignMethod = receiver.StaticMethods.Value(methodSignature)
		      bm = New ObjoScript.BoundMethod(receiver, method, method.Arity, True, True)
		    Else
		      Var method As ObjoScript.Func = receiver.StaticMethods.Value(methodSignature)
		      bm = New ObjoScript.BoundMethod(receiver, method, method.Arity, True, False)
		    End If
		  ElseIf receiver.Methods.HasKey(methodSignature) Then
		    If receiver.Methods.Value(methodSignature) IsA ObjoScript.ForeignMethod Then
		      Var method As ObjoScript.ForeignMethod = receiver.Methods.Value(methodSignature)
		      bm = New ObjoScript.BoundMethod(receiver, method, method.Arity, False, True)
		    Else
		      Var method As ObjoScript.Func = receiver.Methods.Value(methodSignature)
		      bm = New ObjoScript.BoundMethod(receiver, method, method.Arity, False, False)
		    End If
		  Else
		    Error("Cannot create handle for `" + methodSignature + "` as " + receiver.ToString + _
		    " does not have a matching method.")
		  End If
		  
		  Return New ObjoScript.CallHandle(Self, bm)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E6573206120636F6E7374727563746F72206F6E2074686520636C617373206A7573742062656C6F772074686520636F6E7374727563746F72277320626F6479206F6E2074686520737461636B2E2057696C6C20706F702074686520636F6E7374727563746F72206F66662074686520737461636B20627574206C656176652074686520636C61737320696E20706C6163652E
		Private Sub DefineConstructor(argCount As Integer)
		  /// Defines a constructor on the class just below the constructor's body on the stack.
		  /// Will pop the constructor off the stack but leave the class in place.
		  ///
		  /// The constructor's body should be on the top of the stack with its class just beneath it:
		  ///
		  ///                   <---- stack top
		  /// constructor body
		  /// class
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var constructor As ObjoScript.Func = Pop
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  // Constructors are stored on the class by arity.
		  // Therefore klass.Constructors(0) is a constructor with 0 arguments, 
		  // klass.Constructors(2) is a constructor with 2 arguments, etc.
		  If argCount > klass.Constructors.LastIndex Then
		    klass.Constructors.ResizeTo(argCount)
		  End If
		  klass.Constructors(argCount) = constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E6573206120666F726569676E20636C6173732E20417373756D65732074686520636C61737320697320616C7265616479206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub DefineForeignClass()
		  /// Defines a foreign class. Assumes the class is already on the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  // Ask the host applications for the delegates to use.
		  Var fcd As ObjoScript.ForeignClassDelegates = RaiseEvent BindForeignClass(klass.Name)
		  If fcd = Nil Then
		    // The host isn't aware of this class. Check if the core libraries have a delegate for it.
		    fcd = BindCoreForeignClass(klass.Name)
		    If fcd = Nil Then
		      Error("There are no foreign class delegates for `" + klass.Name + "`.")
		    ElseIf fcd.Allocate = Nil Then
		      Error("The delegate for foreign class (" + klass.Name + ") allocation is Nil.")
		    End If
		  End If
		  
		  klass.ForeignDelegates = fcd
		  
		  // If this is one of ObjoScript's built-in types we keep a reference to the class for use elsewhere.
		  // This saves us having to look them up.
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

	#tag Method, Flags = &h21, Description = 446566696E6573206120666F726569676E206D6574686F64207769746820607369676E61747572656020616E642060617269747960206F6E2074686520636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub DefineForeignMethod(signature As String, arity As UInt8, isStatic As Boolean)
		  /// Defines a foreign method with `signature` and `arity` on the class on the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  // Ask the host for the delegate to use. This overrides any specified by the core libraries.
		  Var fmd As ObjoScript.ForeignMethodDelegate = RaiseEvent BindForeignMethod(klass.Name, signature, isStatic)
		  If fmd = Nil Then
		    // The host has not clue. Check if the core libraries have a delegate for this.
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
		  /// Pops the method off the stack but leaves the class in place.
		  ///
		  /// The method's body should be on the top of the stack with its class just beneath it:
		  ///
		  /// method
		  /// class
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var method As ObjoScript.Func = Pop
		  Var klass As ObjoScript.Klass = Peek(0)
		  
		  If isStatic Then
		    // Static method.
		    klass.StaticMethods.Value(signature) = method
		  Else
		    // Instance method.
		    klass.Methods.Value(signature) = method
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 54686520636F6D70696C657220686173206A75737420646566696E65642074686520604E6F7468696E676020636C61737320616E64206C656674206974206F6E2074686520746F70206F662074686520737461636B20666F722075732E20437265617465206F75722073696E676C6520696E7374616E6365206F66204E6F7468696E6720666F7220757365207468726F7567686F75742074686520564D2E
		Private Sub DefineNothing()
		  /// The compiler has just defined the `Nothing` class and left it on the top of the stack for us.
		  /// Create our single instance of Nothing for use throughout the VM.
		  ///
		  /// We'll leave the Nothing class on the stack - the compiler will instrut us to 
		  /// pop it off for us momentarily.
		  
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
		    Var func As ObjoScript.Func = frame.Function_
		    Var funcName As String = If(func.Name = "*main*", "`<main>`", "`" + func.Name + "`")
		    Var s As String = "[line " + func.Chunk.LineForOffset(frame.IP - 1).ToString + "] in " + funcName
		    stackFrames.Add(s)
		  Next i
		  
		  Raise New ObjoScript.VMException(message, CurrentChunk.LineForOffset(offset), stackFrames, StackDump, CurrentChunk.ScriptIDForOffset(offset))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652063757272656E742063616C6C206672616D652E204D6179206265204E696C2E2053686F756C6420626520636F6E736964657265642072656164206F6E6C792E
		Function GetCurrentFrame() As ObjoScript.CallFrame
		  /// Returns the current call frame. May be Nil. Should be considered read only.
		  
		  Return CurrentFrame
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F6620616E20696E7374616E6365206669656C6420617420606669656C64496E646578602066726F6D2074686520696E7374616E63652063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetField(fieldIndex As Integer)
		  /// Retrieves the value of an instance field at `fieldIndex` from the instance currently 
		  /// on the top of the stack and then pushes it on to the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Since instance fields can only be retrieved from within a method,
		  // `this` should be in the method callframe's slot 0.
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
		  
		  // Get the value of the field from the instance and push it on to the stack.
		  Push(instance.Fields(fieldIndex))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C756520696E2074686520737461636B2061742074686520606672616D65602060736C6F74602E2060736C6F74203060206973207468652066756E6374696F6E2E
		Function GetFrameSlotValue(frame As ObjoScript.CallFrame, slot As Integer) As Variant
		  /// Returns the value in the stack at the `frame` `slot`. `slot 0` is the function.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Stack(frame.StackBase + slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473207468652076616C7565206F66206120676C6F62616C207661726961626C65206E616D656420606E616D656020616E6420707573686573206974206F6E20746F2074686520737461636B2E2052616973657320612072756E74696D65206572726F722069662074686520676C6F62616C207661726961626C6520646F65736E27742065786973742E
		Private Sub GetGlobal(name As String)
		  /// Reads the value of a global variable named `name` and pushes it on to the stack.
		  /// Raises a runtime error if the global variable doesn't exist.
		  
		  Var value As Variant = Self.Globals.Lookup(name, Nil)
		  If value = Nil Then
		    Error("Undefined variable `" + name + "`.")
		  Else
		    Push(value)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732074686520737472696E6720726570726573656E746174696F6E206F66207468652076616C756520696E2060736C6F74602E
		Function GetSlotAsString(slot As Integer) As String
		  /// Returns the string representation of the value in `slot`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return StackValueToString(APISlots(slot))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73207468652076616C756520696E2060736C6F74602E204974206D6179206265206120586F6A6F20446F75626C652C20537472696E672C20426F6F6C65616E206F7220616E20604F626A6F5363726970742E56616C7565602E
		Function GetSlotValue(slot As Integer) As Variant
		  /// Returns the value in `slot`. It may be a Xojo Double, String, Boolean or an `ObjoScript.Value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return APISlots(slot)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F66206120737461746963206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E6365206F7220636C6173732063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetStaticField(name As String)
		  /// Retrieves the value of a static field named `name` on the instance or class currently 
		  /// on the top of the stack and then pushes it on to the top of the stack.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // The compiler guarantees that static fields can only be retrieved from within an instance 
		  // method/constructor or a static method. Therefore, we can safely assume that 
		  // either `this` or the class will should be in the method callframe's slot 0.
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

	#tag Method, Flags = &h0, Description = 52657475726E73206120746F702D6C6576656C207661726961626C65206E616D656420606E616D65602E2052657475726E73204E696C206966206E6F7420666F756E642E
		Function GetVariable(name As String) As Variant
		  /// Returns a top-level variable named `name`.
		  /// Returns Nil if not found.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Globals.Lookup(name, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 48616E646C6573207468652060496E68657269746020696E737472756374696F6E2E
		Private Sub Inherit()
		  /// Handles the `Inherit` instruction.
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
		  // instruction should only occur within a class declaration). Therefore, copy all the 
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

	#tag Method, Flags = &h0, Description = 496E697469616C697365732074686520564D20616E6420696E746572707265747320746865207061737365642066756E6374696F6E2E20557365207468697320746F20696E74657270726574206120746F70206C6576656C2066756E6374696F6E2E
		Sub Interpret(f As ObjoScript.Func)
		  /// Initialises the VM and interprets the passed function. 
		  /// Use this to interpret a top level function.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Reset
		  
		  // Push the function to run onto the stack as a runtime value.
		  Push(f)
		  
		  // Call the passed function.
		  CallFunction(f, 0)
		  
		  // The current call frame is the first one.
		  CurrentFrame = Frames(0)
		  
		  Run
		  
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
		  
		  // Query the receiver from the stack. It should be beneath any arguments to the invocation.
		  // We therefore peek argCount distance from the top.
		  // We're inlining the call to `Peek()` here for speed.
		  Var receiver As Variant = Stack(StackTop - argCount - 1)
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

	#tag Method, Flags = &h21, Description = 496E766F6B657320616E206F7665726C6F616465642062696E617279206F70657261746F72206D6574686F64207769746820607369676E617475726560206F6E207468652063616C6C65652028696E7374616E63652F636C6173732920616E64206F706572616E64206F6E2074686520737461636B2E
		Private Sub InvokeBinaryOperator(signature As String)
		  /// Invokes an overloaded binary operator method with `signature` on the 
		  /// callee (instance/class) and operand on the stack.
		  ///
		  /// Raises a VM error if the callee doesn't implement the overloaded operator.
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
		      
		    ElseIf callee IsA ObjoScript.Value Then
		      Error(ObjoScript.Value(callee).ToString + " does not implement `" + signature + "`.")
		    Else
		      Error("Expected a Value.")
		    End If
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4469726563746C7920696E766F6B65732061206D6574686F64207769746820607369676E617475726560206F6E20606B6C617373602E20417373756D65732065697468657220606B6C61737360206F7220616E20696E7374616E6365206F6620606B6C6173736020616E642074686520726571756972656420617267756D656E74732061726520616C7265616479206F6E2074686520737461636B2E20496E7465726E616C6C792063616C6C73206043616C6C56616C75652829602E
		Private Sub InvokeFromClass(klass As ObjoScript.Klass, signature As String, argCount As Integer, isStatic As Boolean)
		  /// Directly invokes a method with `signature` on `klass`. Assumes either `klass` or an instance 
		  /// of `klass` and the required arguments are already on the stack.
		  /// Internally calls `CallValue()`.
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

	#tag Method, Flags = &h0
		Sub InvokeHandle(handle As ObjoScript.CallHandle)
		  /// Invokes the passed call handle.
		  
		  Var bm As ObjoScript.BoundMethod = handle.BoundMethod
		  Var argCount As Integer = bm.Arity
		  
		  // Push the receiver of the call.
		  Push(bm.Receiver)
		  
		  // Push the arguments from the API slots array. The first argument should be in slot 1.
		  For i As Integer = 1 To argCount
		    Push(APISlots(i))
		  Next i
		  
		  // Call the bound method.
		  If bm.IsForeign Then
		    CallForeignMethod(ObjoScript.ForeignMethod(bm.Method), argCount)
		  Else
		    CallFunction(ObjoScript.Func(bm.Method), argCount)
		  End If
		  
		  // Update the current call frame.
		  CurrentFrame = Frames(FrameCount - 1)
		  
		  // If there is no script running in the VM then fire it up.
		  If Not mIsRunning Then Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B6573206120756E617279206F70657261746F72206F7665726C6F61646564206D6574686F64207769746820607369676E617475726560206F6E2074686520696E7374616E63652F636C617373206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub InvokeUnaryOperator(signature As String)
		  /// Invokes a unary operator overloaded method with `signature` on the 
		  /// instance/class on the top of the stack.
		  ///
		  /// Raises a VM runtime error if the instance/class doesn't implement the overloaded operator.
		  /// value   <---- top of the stack
		  
		  Var v As Variant = Peek(0)
		  
		  If v.Type = Variant.TypeDouble Then
		    InvokeFromClass(NumberClass, signature, 0, False)
		    
		  ElseIf v.Type = Variant.TypeString Then
		    InvokeFromClass(StringClass, signature, 0, False)
		    
		  ElseIf v.Type = Variant.TypeBoolean Then
		    InvokeFromClass(BooleanClass, signature, 0, False)
		    
		  ElseIf v IsA ObjoScript.Instance Then
		    InvokeFromClass(ObjoScript.Instance(v).Klass, signature, 0, False)
		    
		  ElseIf v IsA ObjoScript.Klass Then
		    InvokeFromClass(ObjoScript.Klass(v), signature, 0, True)
		    
		  Else
		    Error(ObjoScript.Value(v).ToString + " does not implement `" + signature + "`.")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320547275652069662060766020697320636F6E73696465726564202266616C736579222E
		Shared Function IsFalsey(v As Variant) As Boolean
		  /// Returns True if `v` is considered "falsey".
		  ///
		  /// ObjoScript considers the boolean value `false` and the ObjoScript value `nothing` to
		  /// be False, everything else is True.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return (v.Type = Variant.TypeBoolean And v = False) Or v IsA ObjoScript.Nothing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73205472756520696620606F70636F64656020697320776F7274682073746F7070696E67206F6E2E
		Private Function IsStoppableOpcode(opcode As ObjoScript.VM.Opcodes) As Boolean
		  /// Returns True if `opcode` is worth stopping on.
		  ///
		  /// We stop on the following operations:
		  /// Variable declarations, assignments, assertions, continue, exit, return
		  
		  Select Case opcode
		  Case Opcodes.Assert, Opcodes.SetLocal, Opcodes.SetGlobal, Opcodes.SetGlobalLong, _
		    Opcodes.DefineGlobal, Opcodes.DefineGlobalLong, Opcodes.SetField, _
		    Opcodes.SetStaticField, Opcodes.SetStaticFieldLong, Opcodes.Return_, Opcodes.Loop_, _
		    Opcodes.Call_, Opcodes.Invoke, Opcodes.InvokeLong, Opcodes.Breakpoint
		    Return True
		    
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
		  
		  If (v.Type = Variant.TypeBoolean And v = False) Or v IsA ObjoScript.Nothing Then
		    Return False
		  Else
		    Return True
		  End If
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

	#tag Method, Flags = &h21, Description = 437265617465732061206E6577206B65792076616C756520696E7374616E63652E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865206B657920616E642076616C7565206F6E2074686520737461636B207769746820746865204B657956616C756520636C6173732062656E65617468207468656D2E
		Private Sub NewKeyValue()
		  /// Creates a new key value instance. The compiler will have placed the key and value on the stack
		  /// with the KeyValue class beneath them.
		  ///
		  /// key             <-- top of stack
		  /// value
		  /// KeyValue class
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Call the two argument KeyValue constructor.
		  Call CallClass(Peek(2), 2)
		  
		  // Read the key and value.
		  Var data As Pair = Pop : Pop
		  
		  // The top of the stack will now be a KeyValue instance. Set it's foreign data.
		  Var kv As ObjoScript.Instance = Stack(StackTop - 1)
		  kv.ForeignData = data
		  
		  // Update the current call frame (since CallClass doesn't do this for us) and
		  // we have invoked an actual constructor.
		  CurrentFrame = Frames(FrameCount - 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E657720656D707479204C69737420696E7374616E63652E
		Function NewList() As ObjoScript.Instance
		  /// Creates and returns a new empty List instance.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577204C69737420696E7374616E636520636F6E73697374696E67206F6620606974656D73602E
		Function NewList(items() As String) As ObjoScript.Instance
		  /// Creates and returns a new List instance consisting of `items`.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData(items)
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4372656174657320616E642072657475726E732061206E6577204C69737420696E7374616E636520636F6E73697374696E67206F6620606974656D73602E
		Function NewList(items() As Variant) As ObjoScript.Instance
		  /// Creates and returns a new List instance consisting of `items`.
		  
		  Var list As New ObjoScript.Instance(Self, ListClass)
		  list.ForeignData = New ObjoScript.Core.List.ListData(items)
		  
		  Return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4372656174652061206E6577206C697374206C69746572616C2E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865204C69737420636C617373206F6E2074686520737461636B20616E6420616E7920696E697469616C20656C656D656E74732061626F766520746869732E
		Private Sub NewListLiteral(itemCount As Integer)
		  /// Creates a new list literal. The compiler will have placed the List class on the stack
		  /// and any initial elements above this.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Pop and store any optional initial elements.
		  Var items() As Variant
		  For i As Integer = 1 To itemCount
		    items.AddAt(0, Pop)
		  Next i
		  
		  // Call the default List constructor.
		  Call CallClass(Peek(0), 0)
		  
		  // The top of the stack will now be a List instance.
		  // Add the initial elements to it's foreign data.
		  Var list As ObjoScript.Instance = Stack(StackTop - 1)
		  ObjoScript.Core.List.ListData(list.ForeignData).Items = items
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732061206E6577206D617020696E7374616E63652E2054686520636F6D70696C65722077696C6C206861766520706C6163656420746865204D617020636C617373206F6E2074686520737461636B20616E6420616E7920696E697469616C206B65792D76616C75652070616972732061626F766520746869732E
		Private Sub NewMapLiteral(keyValueCount As Integer)
		  /// Creates a new map instance. The compiler will have placed the Map class on the stack
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
		  
		  // Call the zero argument Map constructor.
		  Call CallClass(Peek(0), 0)
		  
		  // The top of the stack will now be a Map instance.
		  // It's foreign data contains a dictionary that we will set to the key-values we popped off the stack.
		  Var map As ObjoScript.Instance = Stack(StackTop - 1)
		  ObjoScript.Core.Map.MapData(map.ForeignData).Dict = keyValues
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73207468652076616C7565206064697374616E6365602066726F6D2074686520746F70206F662074686520737461636B2E204C6561766573207468652076616C7565206F6E2074686520737461636B2E20412076616C7565206F662060306020776F756C642072657475726E2074686520746F70206974656D2E
		Private Function Peek(distance As Integer) As Variant
		  /// Returns the value `distance` from the top of the stack. 
		  /// Leaves the value on the stack.
		  /// A value of `0` would return the top item.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Return Stack(StackTop - distance - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 506F707320612076616C7565206F6666206F662074686520737461636B2E
		Private Function Pop() As Variant
		  /// Pops a value off of the stack and returns it.
		  
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

	#tag Method, Flags = &h0, Description = 5261697365732074686520564D277320605072696E7460206576656E742C2070617373696E672069742074686520537472696E67206073602E
		Sub RaisePrint(s As String)
		  /// Raises the VM's `Print` event, passing it the String `s`.
		  
		  RaiseEvent Print(s)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526561647320746865206279746520696E206043757272656E744368756E6B60206174207468652063757272656E74206049506020616E642072657475726E732069742E20496E6372656D656E7473207468652049502E
		Private Function ReadByte() As UInt8
		  /// Reads the byte in `CurrentChunk` at the current `IP` and returns it. 
		  /// Increments the IP.
		  
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
		  
		  // I've benchmarked the difference between inlining the ReadByte call here or leaving it as is.
		  // It's actually faster doing it this way. It also helps that it's more readable.
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

	#tag Method, Flags = &h21, Description = 52656164732074776F2062797465732066726F6D206043757272656E744368756E6B60206174207468652063757272656E74206049506020616E642072657475726E73207468656D20617320612055496E7431362E20496E6372656D656E74732074686520495020627920322E
		Private Function ReadUInt16() As UInt16
		  /// Reads two bytes from `CurrentChunk` at the current `IP` and returns them as a UInt16. 
		  /// Increments the IP by 2.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  CurrentFrame.IP = CurrentFrame.IP + 2
		  Return CurrentChunk.ReadUInt16(CurrentFrame.IP - 2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657365747320746865207669727475616C206D616368696E652E
		Sub Reset()
		  /// Resets the virtual machine.
		  
		  mIsRunning = False
		  
		  // Initialise the value stack.
		  StackTop = 0
		  Stack.ResizeTo(-1)
		  Stack.ResizeTo(MAX_STACK * MAX_FRAMES)
		  
		  // Initialise the call frame stack.
		  FrameCount = 0
		  Frames.ResizeTo(-1)
		  Frames.ResizeTo(MAX_FRAMES)
		  // Allocate new call frames up front so we don't incur object creation overhead at runtime.
		  For i As Integer = 0 To Frames.LastIndex
		    Frames(i) = New ObjoScript.CallFrame
		  Next i
		  
		  // The VM will set this once it has defined the `Nothing` class within the runtime.
		  Nothing = Nil
		  
		  Self.Globals = ParseJSON("{}") // HACK: Case sensitive.
		  
		  // Reset the API
		  CallHandles.ResizeTo(-1)
		  APISlots.ResizeTo(-1)
		  APISlots.ResizeTo(MAX_SLOTS)
		  For i As Integer = 0 To APISlots.LastIndex
		    APISlots(i) = Nothing
		  Next i
		  
		  mBooleanClass = Nil
		  mNumberClass = Nil
		  mStringClass = Nil
		  mNothingClass = Nil
		  mKeyValueClass = Nil
		  ListClass = Nil
		  RandomInstance = Nil
		  
		  // Debugger.
		  LastInstructionFrame = Nil
		  mLastStoppedLine = -1
		  LastStoppedScriptID = -1
		  mShouldStop = False
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E732074686520696E7465727072657465722E20417373756D65732069742773206265656E20696E697469616C69736564207072696F7220746F207468697320616E642068617320612076616C69642063616C6C206672616D6520746F20657865637574652E
		Sub Run(stepping As Boolean = False)
		  /// Runs the interpreter. 
		  /// Assumes it's been initialised prior to this and has a valid call frame to execute.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Make sure we have a valid instruction pointer.
		  If CurrentFrame.IP > CurrentChunk.Code.LastIndex Then
		    mIsRunning = False
		    Return
		  End If
		  
		  mIsRunning = True
		  
		  // This is the beating heart of the VM. Everything in this loop is speed critical.
		  While True
		    
		    #If DEBUGGABLE
		      // For maximum performance, we allow developers to disable the ability of the 
		      // VM to debug at all at compile time. This conditional check is therefore 
		      // avoided during each iteration.
		      If Self.DebugMode And CurrentChunk.IsDebug And stepping Then
		        If mShouldStop Then
		          mIsRunning = False
		          RaiseEvent WillStop(LastStoppedScriptID, LastStoppedLine)
		          Return
		        ElseIf ShouldBreak Then
		          mIsRunning = False
		          RaiseEvent WillStop(LastStoppedScriptID, LastStoppedLine)
		          Return
		        End If
		      End If
		    #EndIf
		    
		    Select Case Opcodes(ReadByte)
		    Case Opcodes.Add
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1) + Peek(0), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("+(_)")
		      End If
		      
		    Case Opcodes.Add1
		      // Increment the value on the top of the stack by 1.
		      If Peek(0).Type = Variant.TypeDouble Then
		        Stack(StackTop - 1) = CType(Stack(StackTop - 1) + 1.0, Double)
		      Else
		        Push(1.0)
		        InvokeBinaryOperator("+(_)")
		      End If
		      
		    Case Opcodes.Assert
		      // Pop the message.
		      Var message As String = StackValueToString(Pop)
		      
		      // Pop the condition off the stack. If it's False then raise a runtime error.
		      If IsFalsey(Pop) Then Error("Failed assertion: " + message)
		      
		    Case Opcodes.BitwiseAnd
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        // Bitwise operators work on 32-bit unsigned integers.
		        Stack(StackTop - 2) = Ctype(Peek(1).UInt32Value And Peek(0).UInt32Value, Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("&(_)")
		      End If
		      
		    Case Opcodes.BitwiseNot
		      If Stack(StackTop - 1).Type = Variant.TypeDouble Then
		        // Do the "bitwise not" operation in place for speed.
		        Stack(StackTop - 1) = CType(Not Stack(StackTop - 1).UInt32Value, Double)
		      Else
		        InvokeUnaryOperator("~()")
		      End If
		      
		    Case Opcodes.BitwiseOr
		      If TopOfStackAreNumbers Then
		        // Bitwise operators work on 32-bit unsigned integers.
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1).UInt32Value Or Peek(0).UInt32Value, Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("|(_)")
		      End If
		      
		    Case Opcodes.BitwiseXor
		      If TopOfStackAreNumbers Then
		        // Bitwise operators work on 32-bit unsigned integers.
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1).UInt32Value Xor Peek(0).UInt32Value, Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("^(_)")
		      End If
		      
		    Case Opcodes.Breakpoint
		      // Allows the VM to pause at a manually set break point.
		      // Has no effect in production chunks or if the VM is not in debug mode.
		      If DebugMode And CurrentChunk.IsDebug Then
		        mLastStoppedLine = CurrentChunk.LineForOffset(CurrentFrame.IP - 1)
		        LastStoppedScriptID = CurrentChunk.ScriptIDForOffset(CurrentFrame.IP - 1)
		        LastInstructionFrame = CurrentFrame
		        mIsRunning = False
		        RaiseEvent WillStop(LastStoppedScriptID, LastStoppedLine)
		        Return
		      End If
		      
		    Case Opcodes.Call_
		      Var argcount As Integer = ReadByte
		      // Peek past the arguments to find the function to call.
		      Call CallValue(Peek(argcount), argcount)
		      
		    Case Opcodes.Class_
		      Var className As String = ReadConstantLong
		      Var isForeign As Boolean = (ReadByte = 1)
		      Var fieldCount As Integer = ReadByte
		      Var firstFieldIndex As Integer = ReadByte
		      Push(NewClass(className, isForeign, fieldCount, firstFieldIndex))
		      If isForeign Then
		        DefineForeignClass
		      End If
		      
		    Case Opcodes.Constant_
		      Push(ReadConstant)
		      
		    Case Opcodes.ConstantLong
		      Push(ReadConstantLong)
		      
		    Case Opcodes.Constructor_
		      DefineConstructor(ReadByte)
		      
		    Case Opcodes.DebugFieldName
		      AddFieldNameToClass(ReadConstantLong, ReadByte)
		      
		    Case Opcodes.DefineGlobal
		      // We retrieve the name of the global variable and the value will then be
		      // beneath that on the stack.
		      globals.Value(ReadConstant) = Pop
		      
		    Case Opcodes.DefineGlobalLong
		      // We retrieve the name of the global variable and the value will then be
		      // beneath that on the stack.
		      globals.Value(ReadConstantLong) = Pop
		      
		    Case Opcodes.DefineNothing
		      DefineNothing
		      
		    Case Opcodes.Divide
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1) / Peek(0), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("/(_)")
		      End If
		      
		    Case Opcodes.Equal
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = (Peek(1) = Peek(0))
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("==(_)")
		      End If
		      
		    Case Opcodes.Exit_
		      Error("Unexpected `exit` placeholder instruction. The chunk is invalid.")
		      
		    Case Opcodes.False_ // `false` literal.
		      Push(False)
		      
		    Case Opcodes.ForeignMethod
		      DefineForeignMethod(ReadConstantLong, ReadByte, If(ReadByte = 1, True, False))
		      
		    Case Opcodes.GetField
		      GetField(ReadByte)
		      
		    Case Opcodes.GetGlobal
		      GetGlobal(ReadConstant)
		      
		    Case Opcodes.GetGlobalLong
		      GetGlobal(ReadConstantLong)
		      
		    Case Opcodes.GetLocal
		      // The operand is the stack slot where the local variable lives.
		      // Load the value at that slot and then push it on to the top of the stack.
		      Push(Stack(CurrentFrame.StackBase + ReadByte))
		      
		    Case Opcodes.GetLocalClass
		      // The operand is the stack slot where the local variable lives (should be an instance).
		      // Load it and then push its class onto the stack.
		      Var instance As ObjoScript.Instance = Stack(CurrentFrame.StackBase + ReadByte)
		      Push(instance.Klass)
		      
		    Case Opcodes.GetStaticField
		      GetStaticField(ReadConstant)
		      
		    Case Opcodes.GetStaticFieldLong
		      GetStaticField(ReadConstantLong)
		      
		    Case Opcodes.Greater
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = Peek(1) > Peek(0)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator(">(_)")
		      End If
		      
		    Case Opcodes.GreaterEqual
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = Peek(1) >= Peek(0)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator(">=(_)")
		      End If
		      
		    Case Opcodes.Inherit
		      Inherit
		      
		    Case Opcodes.Invoke
		      Invoke(ReadConstant, ReadByte)
		      
		    Case Opcodes.InvokeLong
		      Invoke(ReadConstantLong, ReadByte)
		      
		    Case Opcodes.Is_
		      InvokeBinaryOperator("is(_)")
		      
		    Case Opcodes.Jump
		      // Unconditionally jump the specified offset from the current instruction pointer.
		      // +2 accounts for the 2 bytes we read.
		      CurrentFrame.IP = CurrentFrame.IP + ReadUInt16 + 2
		      
		    Case Opcodes.JumpIfFalse
		      // Jump `offset` bytes from the current instruction pointer _if_ the value on the top of the stack is falsey.
		      Var offset As UInt16 = ReadUInt16
		      If IsFalsey(Peek(0)) Then
		        CurrentFrame.IP = CurrentFrame.IP + offset
		      End If
		      
		    Case Opcodes.JumpIfTrue
		      // Jump `offset` bytes from the current instruction pointer _if_ the value on the top of the stack is truthy.
		      Var offset As UInt16 = ReadUInt16
		      If IsTruthy(Peek(0)) Then
		        CurrentFrame.IP = CurrentFrame.IP + offset
		      End If
		      
		    Case Opcodes.KeyValue
		      NewKeyValue
		      
		    Case Opcodes.Less
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = Peek(1) < Peek(0)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("<(_)")
		      End If
		      
		    Case Opcodes.LessEqual
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = Peek(1) <= Peek(0)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("<=(_)")
		      End If
		      
		    Case Opcodes.List
		      NewListLiteral(ReadByte)
		      
		    Case Opcodes.Load0
		      Push(CType(0.0, Double))
		      
		    Case Opcodes.Load1
		      Push(CType(1.0, Double))
		      
		    Case Opcodes.Load2
		      Push(CType(2.0, Double))
		      
		    Case Opcodes.LoadMinus1
		      Push(CType(-1.0, Double))
		      
		    Case Opcodes.LoadMinus2
		      Push(CType(-2.0, Double))
		      
		    Case Opcodes.LocalVarDecl
		      // The compiler has declared a new local variable. The first UInt16 operand is the index in the
		      // constant pool of the name of the variable declared. The second one byte operand is the
		      // slot the local occupies.
		      // The compiler will have already emitted `GetLocal`.
		      CurrentFrame.Locals.Value(ReadConstantLong) = ReadByte
		      
		    Case Opcodes.LogicalXor
		      Var b As Variant  = Pop
		      Var a As Variant  = Pop
		      Push(IsTruthy(a) Xor IsTruthy(b))
		      
		    Case Opcodes.Loop_
		      // Unconditionally jump the specified offset back from the current instruction pointer.
		      // +2 accounts for the 2 bytes we read.
		      CurrentFrame.IP = CurrentFrame.IP - ReadUInt16 + 2
		      
		    Case Opcodes.Map
		      NewMapLiteral(ReadByte)
		      
		    Case Opcodes.Method
		      DefineMethod(ReadConstantLong, If(ReadByte = 0, False, True))
		      
		    Case Opcodes.Modulo
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1) Mod Peek(0), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("%(_)")
		      End If
		      
		    Case Opcodes.Multiply
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1) * Peek(0), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("*(_)")
		      End If
		      
		    Case Opcodes.Negate
		      If Peek(0).Type = Variant.TypeDouble Then
		        Stack(StackTop - 1) = -Stack(StackTop - 1).DoubleValue
		      Else
		        Invoke("-()", 0)
		      End If
		      
		    Case Opcodes.Not_
		      If Stack(StackTop - 1).Type = Variant.TypeBoolean Then
		        // "notting" a boolean is so common we'll implement it inline.
		        Stack(StackTop - 1) = Not Stack(StackTop - 1).BooleanValue
		      Else
		        InvokeUnaryOperator("not()")
		      End If
		      
		    Case Opcodes.NotEqual
		      If (Peek(0).Type = Variant.TypeBoolean And Peek(1).Type = Variant.TypeBoolean) _
		        Or TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = Peek(1) <> Peek(0)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("<>(_)")
		      End If
		      
		    Case Opcodes.Nothing // `nothing` literal.
		      Push(Nothing)
		      
		    Case Opcodes.Pop
		      StackTop = StackTop - 1
		      
		    Case Opcodes.PopN
		      // Pop N values off the stack. N is the single byte operand.
		      StackTop = StackTop - ReadByte
		      
		    Case Opcodes.RangeExclusive
		      InvokeBinaryOperator("..<(_)")
		      
		    Case Opcodes.RangeInclusive
		      InvokeBinaryOperator("...(_)")
		      
		    Case Opcodes.Return_
		      // Get the return value off the stack.
		      Var result As Variant = Pop
		      
		      // We always put the return value in slot 0 of `APISlots` so the host application can access it.
		      APISlots(0) = result
		      
		      FrameCount = FrameCount - 1
		      
		      If FrameCount = 0 Then
		        // Exit the VM.
		        StackTop = 0
		        mIsRunning = False
		        RaiseEvent Finished
		        Return
		      End If
		      
		      // Reset the stack top to what it was prior to this call.
		      StackTop = CurrentFrame.StackBase
		      
		      // Push the result to the top of the stack.
		      Push(result)
		      
		      // Drop the frame.
		      CurrentFrame = Frames(FrameCount - 1)
		      
		    Case Opcodes.SetField
		      SetField(ReadByte)
		      
		    Case Opcodes.SetGlobal
		      Self.Globals.Value(ReadConstant) = Peek(0)
		      
		    Case Opcodes.SetGlobalLong
		      Self.Globals.Value(ReadConstantLong) = Peek(0)
		      
		    Case Opcodes.SetLocal
		      // The operand is the stack slot where the local variable lives.
		      // Store the value at the top of the stack in the stack slot corresponding to the local variable.
		      Stack(CurrentFrame.StackBase + ReadByte) = Peek(0)
		      
		    Case Opcodes.SetStaticField
		      SetStaticField(ReadConstant)
		      
		    Case Opcodes.SetStaticFieldLong
		      SetStaticField(ReadConstantLong)
		      
		    Case Opcodes.ShiftLeft
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Bitwise.ShiftLeft(Peek(1).IntegerValue, Peek(0).IntegerValue), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("<<(_)")
		      End If
		      
		    Case Opcodes.ShiftRight
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Bitwise.ShiftRight(Peek(1).IntegerValue, Peek(0).IntegerValue), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator(">>(_)")
		      End If
		      
		    Case Opcodes.Subtract
		      If TopOfStackAreNumbers Then
		        // Pop the stack and replace the top with the answer.
		        Stack(StackTop - 2) = CType(Peek(1) - Peek(0), Double)
		        StackTop = StackTop - 1
		      Else
		        InvokeBinaryOperator("-(_)")
		      End If
		      
		    Case Opcodes.Subtract1
		      // Decrement the value on the top of the stack by 1.
		      If Peek(0).Type = Variant.TypeDouble Then
		        Stack(StackTop - 1) = CType(Stack(StackTop - 1) - 1.0, Double)
		      Else
		        Push(1.0)
		        InvokeBinaryOperator("-(_)")
		      End If
		      
		    Case Opcodes.SuperConstructor
		      SuperConstructor(ReadConstantLong, ReadByte)
		      
		    Case Opcodes.SuperInvoke
		      SuperInvoke(ReadConstantLong, ReadConstantLong, ReadByte)
		      
		    Case Opcodes.SuperSetter
		      SuperInvoke(ReadConstantLong, ReadConstantLong, 1)
		      
		    Case Opcodes.Swap
		      // Swap the two values on the top of the stack.
		      // Do this in-place to avoid Push/Pop calls.
		      //   b       a
		      //   a  -->  b
		      Var b As Variant  = Stack(StackTop - 1)
		      Stack(StackTop - 1) = Stack(StackTop - 2)
		      Stack(StackTop - 2) = b
		      
		    Case Opcodes.True_ // `true` literal.
		      Push(True)
		      
		    Else
		      Error("Unknown opcode: " + CurrentChunk.ReadByte(CurrentFrame.IP - 1).ToString + ".")
		      
		    End Select
		    
		    #If DEBUGGABLE
		      LastInstructionFrame = CurrentFrame
		    #EndIf
		  Wend
		  
		  mIsRunning = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5365747320746865206669656C6420617420606669656C64496E64657860206F6E2074686520696E7374616E63652074686174206973206F6E652066726F6D2074686520746F70206F662074686520737461636B20746F207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2E
		Private Sub SetField(fieldIndex As Integer)
		  /// Sets the field at `fieldIndex` on the instance that is one from the top of 
		  /// the stack to the value on the top of the stack.
		  ///
		  /// |
		  /// | ValueToAssign   <-- top of the stack
		  /// | Instance        <-- the instance that should have the field at `fieldIndex`.
		  /// |
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  // Since fields can only be set from within a method, the compiler should have 
		  // ensured that `this` is in the method callframe's slot 0 (StackBase).
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

	#tag Method, Flags = &h0, Description = 4120636F6E76656E69656E6365206D6574686F6420666F722070757474696E67206120676C6F62616C207661726961626C65206E616D656420607661726961626C654E616D656020696E746F206120737065636966696320736C6F742E2055736566756C20666F722070757368696E6720676C6F62616C20636C617373657320746F20736C6F7420302E2052657475726E732054727565206966207375636365737366756C206F722046616C7365206966207468657265206973206E6F20676C6F62616C207661726961626C6520776974682074686973206E616D652E
		Function SetGlobalToSlot(slot As Integer, variableName As String) As Boolean
		  /// A convenience method for putting a global variable named `variableName` into a specific slot.
		  /// Useful for pushing global classes to slot 0.
		  /// Returns True if successful or False if there is no global variable with this name.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Var globalVariable As Variant = Globals.Lookup(variableName, Nil)
		  
		  If globalVariable = Nil Then
		    Return False
		  Else
		    APISlots(slot) = globalVariable
		    Return True
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F20426F6F6C65616E206062602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturn(b As Boolean)
		  /// Sets the return value of a foreign method to Boolean `b`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = b
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F20446F75626C65206064602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturn(d As Double)
		  /// Sets the return value of a foreign method to Double `d`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = d
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F2056616C7565206076602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturn(v As ObjoScript.Value)
		  /// Sets the return value of a foreign method to Value `v`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F20537472696E67206073602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturn(s As String)
		  /// Sets the return value of a foreign method to String `s`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = s
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652072657475726E2076616C7565206F66206120666F726569676E206D6574686F6420746F2056617269616E74206076602E20496620796F752077616E7420746F2072657475726E206E6F7468696E672066726F6D2061206D6574686F6420796F7520646F6E2774206E65656420746F2063616C6C20746869732E
		Sub SetReturnToVariant(v As Variant)
		  /// Sets the return value of a foreign method to Variant `v`.
		  /// If you want to return nothing from a method you don't need to call this.
		  ///
		  /// Before a foreign method is called the VM has cleared the call frame stack and pushed nothing on to it.
		  /// Setting a return value just requires us to replace the pushed nothing object with `value`.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  Stack(StackTop - 1) = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C7565206F66207468652073706563696669656420564D20736C6F7420746F207468652070617373656420626F6F6C65616E2076616C75652E
		Sub SetSlot(slot As Integer, value As Boolean)
		  /// Sets the value of the specified VM slot to the passed boolean value.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C7565206F66207468652073706563696669656420564D20736C6F7420746F207468652070617373656420646F75626C652076616C75652E
		Sub SetSlot(slot As Integer, value As Double)
		  /// Sets the value of the specified VM slot to the passed double value.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C7565206F66207468652073706563696669656420564D20736C6F7420746F2074686520706173736564204F626A6F5363726970742076616C75652E
		Sub SetSlot(slot As Integer, value As ObjoScript.Value)
		  /// Sets the value of the specified VM slot to the passed ObjoScript value.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53657473207468652076616C7565206F66207468652073706563696669656420564D20736C6F7420746F207468652070617373656420737472696E672076616C75652E
		Sub SetSlot(slot As Integer, value As String)
		  /// Sets the value of the specified VM slot to the passed string value.
		  
		  #Pragma DisableBoundsChecking
		  #Pragma NilObjectChecking False
		  #Pragma StackOverflowChecking False
		  
		  APISlots(slot) = value
		  
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
		  // so we can safely assume that `this` will be in the 
		  // method callframe's slot 0 (StackBase).
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

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662074686520564D2073686F756C6420627265616B202865786974206974732072756E206C6F6F7029206F722046616C73652069662069742073686F756C6420636F6E74696E75652E205472756520696E64696361746573207765277665207265616368656420612073656E7369626C652073746F7070696E6720706F696E742E
		Private Function ShouldBreak() As Boolean
		  /// Returns True if the VM should break (exit its run loop) or False if it should continue.
		  /// True indicates we've reached a sensible stopping point.
		  
		  // Determine the line number and script ID that the VM is currently at.
		  Var frameLine As Integer = CurrentChunk.LineForOffset(CurrentFrame.IP)
		  Var frameScriptID As Integer = CurrentChunk.ScriptIDForOffset(CurrentFrame.IP)
		  
		  // Disallow stopping within the standard library (scriptID -1).
		  If frameScriptID = -1 Then Return False
		  
		  // Don't stop again if we've already stopped on this exact line.
		  If frameLine = mLastStoppedLine And frameScriptID = LastStoppedScriptID Then
		    Return False
		  End If
		  
		  // Get the instruction.
		  Var opcode As Opcodes = Opcodes(CurrentChunk.ReadByte(CurrentFrame.IP))
		  
		  If LastInstructionFrame <> CurrentFrame Or IsStoppableOpcode(opcode) Then
		    // We've reached a new source line on a stoppable opcode.
		    mLastStoppedLine = frameLine
		    LastStoppedScriptID = frameScriptID
		    LastInstructionFrame = CurrentFrame
		    Return True
		  End If
		  
		  // Disassemble each instruction if requested.
		  #Pragma Warning "TODO: Implement execution tracing"
		  // If TraceExecution And frameScriptID <> -1 Then
		  // RaiseEvent DebugPrint(StackDump)
		  // Var offset As Integer = CurrentFrame.IP // New variable as DisassembleInstruction mutates the offset.
		  // RaiseEvent DebugPrint(Self.Debugger.DisassembleInstruction(CurrentChunk, offset))
		  // End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120737461636B2064756D702E
		Private Function StackDump() As String
		  /// Returns a stack dump.
		  
		  Var s() As String
		  
		  For i As Integer = 0 To StackTop - 1
		    Var item As Variant = Stack(i)
		    s.Add("[ " + StackValueToString(item) + " ]")
		  Next i
		  
		  Return String.FromArray(s, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206120564D20737461636B2076616C75652E
		Shared Function StackValueToString(v As Variant) As String
		  /// Returns a string representation of a VM stack value.
		  
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
		      Raise New UnsupportedOperationException("Unable to create a string representation of the stack value.")
		    End If
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53746F70732074686520564D20696620697427732072756E6E696E672E
		Sub Stop()
		  /// Stops the VM if it's running.
		  
		  mShouldStop = True
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
		  
		  // Get the superclass. Since classes are all declared in the top level, it should be in Globals.
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
		  
		  // Get the superclass. Since classes are all declared in the top level, it should be in Globals.
		  // The compiler will have checked that the superclass exists during compilation.
		  Var superclass As ObjoScript.Klass = Globals.Value(superclassName)
		  
		  // Call the correct method.
		  // The compiler will have guaranteed that the superclass has a method with this signature.
		  CallValue(superclass.Methods.Value(signature), argCount)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320547275652069662074686520746F702074776F2076616C75657320617265206E756D6265727320287370656369666963616C6C7920586F6A6F20446F75626C6573292E20417373756D657320746865726520617265206174206C656173742074776F2076616C756573206F6E2074686520737461636B2E
		Private Function TopOfStackAreNumbers() As Boolean
		  /// Returns True if the top two values are numbers (specifically Xojo Doubles).
		  /// Assumes there are at least two values on the stack.
		  
		  Return Stack(StackTop - 2).Type = Variant.TypeDouble And Stack(StackTop - 1).Type = Variant.TypeDouble
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 54686520564D2069732072657175657374696E67207468652064656C65676174657320746F20757365207768656E20696E7374616E74696174696E672061206E657720666F726569676E20636C61737320616E64207768656E20616E20696E7374616E6365206F66206120666F726569676E20636C6173732069732064657374726F7965642062792074686520586F6A6F206672616D65776F726B2E2052657475726E696E67204E696C206D65616E732074686520636C61737320697320756E6B6E6F776E20746F2074686520686F7374206170706C69636174696F6E2E
		Event BindForeignClass(className As String) As ObjoScript.ForeignClassDelegates
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520564D2069732072657175657374696E67207468652064656C656761746520746F20757365207768656E2063616C6C696E67207468652073706563696669656420666F726569676E206D6574686F64206F6E206120636C6173732E205468697320697320706572666F726D6564206F6E636520666F72206561636820666F726569676E206D6574686F642C207768656E2074686520636C617373206973206669727374206465636C617265642E
		Event BindForeignMethod(className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520564D206861732066696E697368656420657865637574696F6E2E
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 6073602069732074686520726573756C74206F66206576616C756174696E67206120607072696E74602065787072657373696F6E2E
		Event Print(s As String)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 54686520564D2069732061626F757420746F2073746F702062656361757365206974206861732068697420612060627265616B706F696E74602073746174656D656E74206F7220686173206265656E2072657175657374656420746F2073746F702E
		Event WillStop(scriptID As Integer, lineNumber As Integer)
	#tag EndHook


	#tag Property, Flags = &h21, Description = 54686520736C6F742061727261792E205573656420746F20706173732064617461206265747765656E2074686520564D20616E642074686520686F737420586F6A6F206170706C69636174696F6E2E
		Private APISlots(-1) As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E20426F6F6C65616E20636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mBooleanClass
			End Get
		#tag EndGetter
		BooleanClass As ObjoScript.Klass
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 436F6E7461696E7320616C6C20626F756E64206D6574686F647320637265617465642061732063616C6C2068616E646C65732062792074686520564D2E
		Private CallHandles() As ObjoScript.CallHandle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  /// Returns the chunk we're currently reading from.
			  /// It's owned by the function whose call frame we're currently in.
			  
			  #Pragma DisableBoundsChecking
			  #Pragma NilObjectChecking False
			  #Pragma StackOverflowChecking False
			  
			  Return CurrentFrame.Function_.Chunk
			  
			End Get
		#tag EndGetter
		Private CurrentChunk As ObjoScript.Chunk
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 5468652063757272656E742063616C6C206672616D652E
		Private CurrentFrame As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662054727565207468656E2074686520564D20697320696E206C6F7720706572666F726D616E6365206465627567206D6F646520616E642063616E20696E7465726163742077697468206368756E6B7320636F6D70696C656420696E206465627567206D6F646520746F2070726F7669646520646562756767696E6720696E666F726D6174696F6E2E
		DebugMode As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F66206F6E676F696E672066756E6374696F6E2063616C6C732E
		Private FrameCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652063616C6C206672616D6520737461636B2E
		Private Frames(-1) As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F7265732074686520564D277320676C6F62616C207661726961626C65732E204B6579203D207661726961626C65206E616D652028537472696E67292C2056616C7565203D207661726961626C652076616C7565202856617269616E74292E
		Private Globals As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 547275652069662074686520564D2069732063757272656E746C7920657865637574696E6720636F64652E
		#tag Getter
			Get
			  Return mIsRunning
			  
			End Get
		#tag EndGetter
		IsRunning As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204B657956616C756520636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
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

	#tag Property, Flags = &h21, Description = 546865204944206F6620746865207363726970742074686520564D206C6173742073746F7070656420696E2E20602D316020666F7220746865207374616E64617264206C6962726172792E
		Private LastStoppedScriptID As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204C69737420636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private ListClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E20426F6F6C65616E20636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mBooleanClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 547275652069662074686520564D2069732063757272656E746C7920657865637574696E6720636F64652E
		Private mIsRunning As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204B657956616C756520636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mKeyValueClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206F6620636F64652074686520564D206C6173742073746F70706564206F6E2E
		Private mLastStoppedLine As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204E6F7468696E6720636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mNothingClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E204E756D62657220636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mNumberClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 49662054727565207468656E2074686520564D2073686F756C642073746F7020617420746865206E657874206F70706F7274756E69747920287072696F7220746F20746865206E65787420696E737472756374696F6E206665746368292E204F6E6C7920776F726B73207768656E206044656275674D6F64656020697320547275652E
		Private mShouldStop As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 41207265666572656E636520746F20746865206275696C742D696E20537472696E6720636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		Private mStringClass As ObjoScript.Klass
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 53696E676C65746F6E20696E7374616E6365206F6620606E6F7468696E67602E
		Nothing As ObjoScript.Nothing
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204E6F7468696E6720636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mNothingClass
			End Get
		#tag EndGetter
		NothingClass As ObjoScript.Klass
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E204E756D62657220636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mNumberClass
			End Get
		#tag EndGetter
		NumberClass As ObjoScript.Klass
	#tag EndComputedProperty

	#tag Property, Flags = &h0, Description = 5468652073696E676C65746F6E2052616E646F6D20696E7374616E63652E2057696C6C206265204E696C20756E74696C206669727374206163636573736564207468726F75676820604D617468732E72616E646F6D2829602E
		RandomInstance As ObjoScript.Instance
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520564D277320737461636B2E2057696C6C20636F6E7461696E206F6E6C7920426F6F6C65616E732C20446F75626C65732C20537472696E6773206F7220636C617373657320696D706C656D656E74696E672074686520604F626A6F5363726970742E56616C75656020696E746572666163652E
		Private Stack(-1) As Variant
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506F696E747320746F2074686520696E64657820696E2060537461636B60206A75737420706173742074686520656C656D656E7420636F6E7461696E696E672074686520746F702076616C75652E205468657265666F726520603060206D65616E732074686520737461636B20697320656D7074792E20497427732074686520696E64657820746865206E6578742076616C75652077696C6C2062652070757368656420746F2E
		Private StackTop As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 41207265666572656E636520746F20746865206275696C742D696E20537472696E6720636C6173732E204D6179206265204E696C207768696C737420626F6F74737472617070696E672E
		#tag Getter
			Get
			  Return mStringClass
			End Get
		#tag EndGetter
		StringClass As ObjoScript.Klass
	#tag EndComputedProperty


	#tag Constant, Name = DEBUGGABLE, Type = Boolean, Dynamic = False, Default = \"True", Scope = Public, Description = 49662046616C7365207468656E20616C6C20646562756767696E67206361706162696C6974696573206F662074686520564D206172652072656D6F7665642061742061707020636F6D70696C652074696D652E20557365207468697320666F72206D6178696D756D20706572666F726D616E636520696620796F75722061707020646F6573206E6F74206E65656420656E64207573657220737465702D646562756767696E67206F662074686520564D2E
	#tag EndConstant

	#tag Constant, Name = MAX_FRAMES, Type = Double, Dynamic = False, Default = \"63", Scope = Private, Description = 54686520757070657220626F756E6473206F66207468652063616C6C206672616D6520737461636B2E
	#tag EndConstant

	#tag Constant, Name = MAX_SLOTS, Type = Double, Dynamic = False, Default = \"255", Scope = Private, Description = 54686520757070657220626F756E6473206F66207468652041504920736C6F742061727261792E204C696D6974656420746F2032353520617267756D656E74732073696E63652074686520617267756D656E7420636F756E7420666F72206D616E79206F70636F64657320697320612073696E676C6520627974652E
	#tag EndConstant

	#tag Constant, Name = MAX_STACK, Type = Double, Dynamic = False, Default = \"255", Scope = Private, Description = 54686520757070657220626F756E6473206F662074686520737461636B2E
	#tag EndConstant


	#tag Enum, Name = Opcodes, Type = UInt8, Flags = &h0
		Add
		  Add1
		  Assert
		  BitwiseAnd
		  BitwiseNot
		  BitwiseOr
		  BitwiseXor
		  Breakpoint
		  Call_
		  Class_
		  Constant_
		  ConstantLong
		  Constructor_
		  DebugFieldName
		  DefineGlobal
		  DefineGlobalLong
		  DefineNothing
		  Divide
		  Equal
		  Exit_
		  False_
		  ForeignMethod
		  GetField
		  GetGlobal
		  GetGlobalLong
		  GetLocal
		  GetLocalClass
		  GetStaticField
		  GetStaticFieldLong
		  Greater
		  GreaterEqual
		  Inherit
		  Invoke
		  InvokeLong
		  Is_
		  Jump
		  JumpIfFalse
		  JumpIfTrue
		  KeyValue
		  Less
		  LessEqual
		  List
		  Load0
		  Load1
		  Load2
		  LoadMinus1
		  LoadMinus2
		  LocalVarDecl
		  LogicalXor
		  Loop_
		  Map
		  Method
		  Modulo
		  Multiply
		  Negate
		  Not_
		  NotEqual
		  Nothing
		  Pop
		  PopN
		  RangeExclusive
		  RangeInclusive
		  Return_
		  SetField
		  SetGlobal
		  SetGlobalLong
		  SetLocal
		  SetStaticField
		  SetStaticFieldLong
		  ShiftLeft
		  ShiftRight
		  Subtract
		  Subtract1
		  SuperConstructor
		  SuperInvoke
		  SuperSetter
		  Swap
		True_
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
			Name="LastStoppedLine"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
