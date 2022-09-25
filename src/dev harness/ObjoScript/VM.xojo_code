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

	#tag Method, Flags = &h21, Description = 42696E6473206120726567756C6172202867657474657229206D6574686F64206E616D656420606E616D656020746F2074686520636C617373206F7220696E7374616E6365206F6E2074686520746F70206F662074686520737461636B2E20417373657274732074686520746F70206F662074686520737461636B20697320616E20696E7374616E6365206F7220636C6173732E
		Private Sub BindMethod(name As String, onSuper As Boolean)
		  /// Binds a regular (getter) method named `name` to the class or instance on the top of the stack.
		  /// Asserts the top of the stack is an instance or class.
		  ///
		  /// If `onSuper` is True then we look for the method on the instance's superclass, otherwise
		  /// we look on the instance's class.
		  
		  // Check we have an instance or a class on the top of the stack.
		  Var receiver As Variant = Peek(0)
		  Var isStatic As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    isStatic = True
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Methods can only be invoked on class and instances.")
		  End If
		  
		  // Get the correct method. It's either on the instance's class or its superclass
		  // or it'll be a static method on the class on the top of the stack.
		  Var method As ObjoScript.Func
		  If onSuper And Not isStatic Then
		    If ObjoScript.Instance(receiver).Klass.Superclass = Nil Then
		      Error("`" + ObjoScript.Instance(receiver).Klass.ToString + "` does not have a superclass.")
		    Else
		      method = ObjoScript.Instance(receiver).Klass.Superclass.Methods.Lookup(name, Nil)
		    End If
		    If method = Nil Then
		      Error("Undefined instance method `" + name + "` on " + ObjoScript.Instance(receiver).klass.Superclass.ToString + ".")
		    End If
		    
		  ElseIf isStatic Then
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
		  
		  Var bound As Variant
		  If isStatic Then
		    // Bind this method to the class which is currently on the top of the stack.
		    bound = New ObjoScript.BoundStaticMethod(receiver, method)
		  Else
		    // Bind this method to the instance which is currently on the top of the stack.
		    bound = New ObjoScript.BoundMethod(receiver, method)
		  End If
		  
		  // Pop off of the instance or class.
		  Call Pop
		  
		  // Push the bound method on to the stack.
		  Push(bound)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 2243616C6C7322206120636C6173732E20457373656E7469616C6C79207468697320637265617465732061206E657720696E7374616E63652E
		Private Sub CallClass(klass As ObjoScript.Klass, argCount As Integer)
		  /// "Calls" a class. Essentially this creates a new instance.
		  
		  Stack(StackTop - argCount - 1) = New ObjoScript.Instance(klass)
		  
		  // Invoke the constructor (if defined). 
		  // We allow a class to omit providing a default (zero parameter) constructor.
		  Var constructor As ObjoScript.Func = klass.Constructors.Lookup(argCount, Nil)
		  If constructor <> Nil Then
		    CallFunction(constructor, argCount)
		  ElseIf argCount <> 0 Then
		    Error("The default `" + klass.Name + "` constructor expected 0 arguments but got " + argCount.ToString + ".")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C7320612066756E6374696F6E2E2060617267436F756E746020697320746865206E756D626572206F6620617267756D656E7473206F6E2074686520737461636B20666F7220746869732066756E6374696F6E2063616C6C2E
		Private Sub CallFunction(f As ObjoScript.Func, argCount As Integer)
		  /// Calls a function. `argCount` is the number of arguments on the stack for this function call.
		  
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
		    CallFunction(ObjoScript.BoundMethod(v).Method, argCount)
		    
		  Case ObjoScript.ValueTypes.BoundStaticMethod
		    // Put the receiver of the call (the class before the dot) in slot 0 for the upcoming call frame.
		    Stack(StackTop - argCount - 1) = ObjoScript.BoundStaticMethod(v).Receiver
		    
		    // Call the bound static method.
		    CallFunction(ObjoScript.BoundStaticMethod(v).Method, argCount)
		    
		  Else
		    Error("Can only call functions, classes and methods.")
		  End Select
		  
		  // Update the current call frame.
		  CurrentFrame = Frames(FrameCount - 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Disassembler = New ObjoScript.Disassembler
		  AddHandler Disassembler.Print, AddressOf DisassemblerPrintDelegate
		  AddHandler Disassembler.PrintLine, AddressOf DisassemblerPrintLineDelegate
		  
		  Reset
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
		Private Sub DefineConstructor(arity As Integer)
		  /// Defines a constructor on the class just below the constructor's body on the stack.
		  ///
		  /// The constructor's body should be on the top of the stack with its class just beneath it.
		  /// Since the compiler guarantees that there will never be two constructors with the same arity, 
		  /// we use the constructor's arity as the key in the class' `Constructor` dictonary to store it.
		  
		  Var constructor As ObjoScript.Func = Peek(0)
		  Var klass As ObjoScript.Klass = Peek(1)
		  
		  klass.Constructors.Value(arity) = constructor
		  
		  // Pop the constructor's body off the stack.
		  Call Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 446566696E65732061206D6574686F64206E616D656420606E616D6560206F6E2074686520636C617373206A7573742062656C6F7720746865206D6574686F64277320626F6479206F6E2074686520737461636B2E
		Private Sub DefineMethod(name As String, setter As UInt8, isStatic As Boolean)
		  /// Defines a method named `name` on the class just below the method's body on the stack.
		  ///
		  /// The method's body should be on the top of the stack with its class just beneath it.
		  /// This is a setter method if setter = 1, otherwise it's a regular method.
		  
		  Var method As ObjoScript.Func = Peek(0)
		  Var klass As ObjoScript.Klass = Peek(1)
		  
		  If isStatic Then
		    If setter = 0 Then
		      // Regular static method.
		      klass.StaticMethods.Value(name) = method
		    Else
		      // Static setter.
		      klass.StaticSetters.Value(name) = method
		    End If
		  Else
		    If setter = 0 Then
		      // Regular method.
		      klass.Methods.Value(name) = method
		    Else
		      // Setter.
		      klass.Setters.Value(name) = method
		    End If
		  End If
		  
		  // Pop the method's body off the stack.
		  Call Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E74282960206576656E742E
		Private Sub DisassemblerPrintDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `Print()` event.
		  ///
		  /// We will add `s` to our disassembler output buffer until the disassembler raises its `PrintLine()` event.
		  
		  #Pragma Unused sender
		  
		  #If DebugBuild
		    DisassemblerOutput.Add(s)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E744C696E65282960206576656E742E
		Private Sub DisassemblerPrintLineDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `PrintLine()` event.
		  ///
		  /// Dump the contents of the disassembler's buffer and `s` to the debug log.
		  
		  #Pragma Unused sender
		  
		  #If DebugBuild
		    DisassemblerOutput.Add(s)
		    System.DebugLog(String.FromArray(DisassemblerOutput))
		    DisassemblerOutput.ResizeTo(-1)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526169736573206120564D457863657074696F6E206174207468652063757272656E742049502028756E6C657373206F746865727769736520737065636966696564292E
		Private Sub Error(message As String, offset As Integer = -1)
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
		  
		  Raise New ObjoScript.VMException(message, CurrentChunk.LineForOffset(offset), stackFrames, CurrentChunk.ScriptIDForOffset(offset))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526574726965766573207468652076616C7565206F662061206669656C64206E616D656420606E616D6560206F6E2074686520696E7374616E63652063757272656E746C79206F6E2074686520746F70206F662074686520737461636B20616E64207468656E20707573686573206974206F6E20746F2074686520746F70206F662074686520737461636B2E
		Private Sub GetField(name As String)
		  /// Retrieves the value of a field named `name` on the instance currently on the top of the 
		  /// stack and then pushes it on to the top of the stack.
		  
		  // Since fields can only be retrieved from within a method we can safely assume that `this` should be in the 
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
		  
		  If value = Nil Then
		    Error("Undefined field `" + name + "` on class `" + instance.Klass.Name + "`.")
		  End If
		  
		  // Push the value on to the stack.
		  Push(value)
		  
		End Sub
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
		  subclass.Setters = superclass.Setters.Clone
		  
		  // This class should keep a reference to its superclass. Do this and pop it off the stack.
		  subclass.Superclass = Pop
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E766F6B65732061206D6574686F64206F6E20616E20696E7374616E636520286F722069747320737570657229206F72206120636C6173732E2054686520726563656976657220636F6E7461696E696E6720746865206D6574686F642073686F756C64206265206F6E2074686520737461636B20616C6F6E67207769746820616E7920617267756D656E74732069742072657175697265732E
		Private Sub Invoke(methodName As String, argCount As Integer, onSuper As Boolean)
		  /// Invokes a method on an instance (or its super) or a class. The receiver containing the method should be on the stack
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
		  
		  // Is this a call to a method on the receiver's superclass?
		  If onSuper And Not isStatic Then
		    If ObjoScript.Instance(receiver).Klass.Superclass = Nil Then
		      Error("`" + ObjoScript.Instance(receiver).Klass.ToString + "` does not have a superclass.")
		    End If
		    InvokeFromClass(ObjoScript.Instance(receiver).Klass.Superclass, methodName, argCount, False)
		    
		  ElseIf isStatic Then
		    // This is a static method invocation.
		    InvokeFromClass(ObjoScript.Klass(receiver), methodName, argCount, True)
		    
		  Else
		    // The method is directly on the instance.
		    InvokeFromClass(ObjoScript.Instance(receiver).Klass, methodName, argCount, False)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4469726563746C7920696E766F6B65732061206D6574686F642063616C6C656420606D6574686F644E616D6560206F6E20606B6C617373602E20417373756D65732065697468657220606B6C61737360206F7220616E20696E7374616E6365206F6620606B6C6173736020616E642074686520726571756972656420617267756D656E74732061726520616C7265616479206F6E2074686520737461636B2E
		Private Sub InvokeFromClass(klass As ObjoScript.Klass, methodName As String, argCount As Integer, isStatic As Boolean)
		  /// Directly invokes a method called `methodName` on `klass`. Assumes either `klass` or an instance 
		  /// of `klass` and the required arguments are already on the stack.
		  ///
		  /// |
		  /// | argN <-- top of stack
		  /// | arg1
		  /// | instance or class
		  
		  Var method As Variant
		  If isStatic Then
		    method = klass.StaticMethods.Lookup(methodName, Nil)
		    If method = Nil Then
		      Error("There is no static method named `" + methodName + "` on `" + klass.ToString + "`.")
		    End If
		  Else
		    method = klass.Methods.Lookup(methodName, Nil)
		    If method = Nil Then
		      Error("There is no instance method named `" + methodName + "` on `" + klass.ToString + "`.")
		    End If
		  End If
		  
		  CallFunction(method, argCount)
		  
		  // Update the current call frame.
		  CurrentFrame = Frames(FrameCount - 1)
		  
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
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E7320612066756E6374696F6E2E
		Sub Run(func As ObjoScript.Func)
		  /// Runs a function.
		  
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
		  
		  While True
		    // Disassemble each instruction if requested.
		    #If DebugBuild And TRACE_EXECUTION
		      Var s() As String
		      For i As Integer = 0 To StackTop - 1
		        Var item As Variant = Stack(i)
		        s.Add("[ " + ValueToString(item) + " ]")
		      Next i
		      System.DebugLog(String.FromArray(s, ""))
		      Call Disassembler.DisassembleInstruction(-1, -1, CurrentChunk, CurrentFrame.IP)
		    #EndIf
		    
		    Select Case ReadByte
		    Case OP_RETURN
		      // Get the return value off the stack.
		      Var result As Variant = Pop
		      
		      FrameCount = FrameCount - 1
		      
		      If FrameCount = 0 Then
		        // Exit the VM.
		        Call Pop
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
		      // If a or b are doubles, they are truncated to integers.
		      Push(Ctype(a.IntegerValue And b.IntegerValue, Double))
		      
		    Case OP_BITWISE_OR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Ctype(a.IntegerValue Or b.IntegerValue, Double))
		      
		    Case OP_BITWISE_XOR
		      Var b As Variant = Pop
		      Var a As Variant = Pop
		      AssertNumbers(a, b)
		      // If a or b are doubles, they are truncated to integers.
		      Push(Ctype(a.IntegerValue Xor b.IntegerValue, Double))
		      
		    Case OP_PRINT
		      // Pop the top value off the stack and print it via the VM's `Print` event.
		      RaiseEvent Print(ValueToString(Pop))
		      
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
		      
		    Case OP_INCLUSIVE_RANGE
		      Var upper As Variant = Pop
		      Var lower As Variant = Pop
		      AssertNumbers(lower, upper)
		      // Internally, we represent ranges as a pair of doubles.
		      Push(lower : upper)
		      
		    Case OP_EXCLUSIVE_RANGE
		      Var upper As Variant = Pop
		      Var lower As Variant = Pop
		      AssertNumbers(lower, upper)
		      // Internally, we represent ranges as a pair of doubles.
		      Push(lower : upper.DoubleValue - 1)
		      
		    Case OP_EXIT
		      Error("Unexpected `exit` placeholder instruction. The chunk is invalid.")
		      
		    Case OP_CALL
		      // We peek past the arguments to find the function to call.
		      Var argcount As Integer = ReadByte
		      Call CallValue(Peek(argcount), argcount)
		      
		    Case OP_CLASS
		      Var className As String = ReadConstant
		      Push(New ObjoScript.Klass(className))
		      
		    Case OP_CLASS_LONG
		      Var className As String = ReadConstantLong
		      Push(New ObjoScript.Klass(className))
		      
		    Case OP_METHOD
		      DefineMethod(ReadConstant, ReadByte, False)
		      
		    Case OP_METHOD_LONG
		      DefineMethod(ReadConstantLong, ReadByte, False)
		      
		    Case OP_GETTER
		      BindMethod(ReadConstant, False)
		      
		    Case OP_GETTER_LONG
		      BindMethod(ReadConstantLong, False)
		      
		    Case OP_SETTER
		      Setter(ReadConstant, False)
		      
		    Case OP_SETTER_LONG
		      Setter(ReadConstantLong, False)
		      
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
		      Invoke(ReadConstant, ReadByte, False)
		      
		    Case VM.OP_INVOKE_LONG
		      Invoke(ReadConstantLong, ReadByte, False)
		      
		    Case OP_INHERIT
		      Inherit
		      
		    Case OP_SUPER_GETTER
		      BindMethod(ReadConstant, True)
		      
		    Case OP_SUPER_GETTER_LONG
		      BindMethod(ReadConstantLong, True)
		      
		    Case OP_SUPER_SETTER
		      Setter(ReadConstant, True)
		      
		    Case OP_SUPER_SETTER_LONG
		      Setter(ReadConstantLong, True)
		      
		    Case OP_SUPER_INVOKE
		      Invoke(ReadConstant, ReadByte, True)
		      
		    Case OP_SUPER_INVOKE_LONG
		      Invoke(ReadConstantLong, ReadByte, True)
		      
		    Case OP_STATIC_METHOD
		      DefineMethod(ReadConstant, ReadByte, True)
		      
		    Case OP_STATIC_METHOD_LONG
		      DefineMethod(ReadConstantLong, ReadByte, True)
		      
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

	#tag Method, Flags = &h21, Description = 43616C6C73207468652073657474657220666F722074686520696E7374616E6365206F6E652066726F6D2074686520746F70206F662074686520737461636B2C2070617373696E6720696E207468652076616C7565206F6E2074686520746F70206F662074686520737461636B2061732074686520706172616D657465722E
		Private Sub Setter(name As String, onSuper As Boolean)
		  /// Calls the setter for the instance or class one from the top of the stack, passing in the 
		  /// value on the top of the stack as the parameter.
		  ///
		  /// |
		  /// | ValueToAssign   <-- top of the stack
		  /// | instance or class
		  ///
		  /// If `onSuper` is True then we look for the method on the instance's superclass, otherwise
		  /// we look on the instance's class.
		  
		  // Check we have a class or instance in the correct place.
		  Var receiver As Variant = Peek(1)
		  Var isStatic As Boolean = False
		  If receiver IsA ObjoScript.Klass Then
		    isStatic = True
		  ElseIf receiver IsA ObjoScript.Instance = False Then
		    Error("Setters can only be invoked on classes or instances.")
		  End If
		  
		  // Get the value to assign. This will be the parameter to the setter method.
		  Var value As Variant = Pop
		  
		  // Get the correct method. It's either on the instance or its superclass or is 
		  // a static setter on a class.
		  Var setter As ObjoScript.Func
		  If onSuper And Not isStatic Then
		    If ObjoScript.Instance(receiver).Klass.Superclass = Nil Then
		      Error("`" + ObjoScript.Instance(receiver).Klass.ToString + "` does not have a superclass.")
		    Else
		      setter = ObjoScript.Instance(receiver).Klass.Superclass.Setters.Lookup(name, Nil)
		    End If
		    If setter = Nil Then
		      Error("Undefined instance setter `" + name + "` on " + ObjoScript.Instance(receiver).klass.Superclass.ToString + ".")
		    End If
		    
		  ElseIf isStatic Then
		    setter = ObjoScript.Klass(receiver).StaticSetters.Lookup(name, Nil)
		    If setter = Nil Then
		      Error("Undefined static setter `" + name + "` on " + ObjoScript.Klass(receiver).ToString + ".")
		    End If
		    
		  Else
		    setter = ObjoScript.Instance(receiver).klass.Setters.Lookup(name, Nil)
		    If setter = Nil Then
		      Error("Undefined instance setter `" + name + "` on " + ObjoScript.Instance(receiver).klass.ToString + ".")
		    End If
		  End If
		  
		  Var bound As Variant
		  If isStatic Then
		    // Bind this static method to the class which is currently on the top of the stack.
		    bound = New ObjoScript.BoundStaticMethod(receiver, setter)
		  Else
		    // Bind this method to the instance which is currently on the top of the stack.
		    bound = New ObjoScript.BoundMethod(receiver, setter)
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
		    // Ranges.
		    // ===================
		    // Ranges are stored internally as pairs of doubles (lower : upper)
		    If a IsA Pair And b IsA Pair Then
		      Var aPair As Pair = a
		      Var bPair As Pair = b
		      If aPair.Left = bPair.Left And aPair.Right = bPair.Right Then
		        Return True
		      End If
		    End If
		    
		    // ===================
		    // Instances.
		    // ===================
		    If a IsA ObjoScript.Instance And b IsA ObjoScript.Instance Then
		      Return a = b
		    End If
		    
		    Error("Unexpected value type.")
		  End Select
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66206120564D2076616C75652E
		Shared Function ValueToString(v As Variant) As String
		  /// Returns a string representation of a VM value.
		  
		  Select Case v.Type
		  Case Variant.TypeDouble
		    If v.DoubleValue.IsInteger Then
		      Return CType(v, Integer).ToString
		    Else
		      Return v.DoubleValue.ToString
		    End If
		    
		  Case Variant.TypeString, Variant.TypeBoolean
		    Return v.StringValue
		    
		  Else
		    If v IsA ObjoScript.Value Then
		      Return ObjoScript.Value(v).ToString
		      
		    ElseIf v IsA ObjoScript.Nothing Then
		      Return "Nothing"
		      
		    ElseIf v IsA Pair Then
		      // Ranges are stored internally as pairs of doubles (lower : upper)
		      Var vPair As Pair = v
		      Return vPair.Left.StringValue + " : " + vPair.Right.StringValue
		      
		    Else
		      // This shouldn't happen.
		      Raise New UnsupportedOperationException("Unable to create a string representation of the value.")
		    End If
		  End Select
		End Function
	#tag EndMethod


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
		28: OP_PRINT (0)
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
		44: OP_INCLUSIVE_RANGE (0)
		45: OP_EXCLUSIVE_RANGE (0)
		46: OP_EXIT (0)
		47: OP_CALL (1)
		48: OP_CLASS (1)
		49: OP_CLASS_LONG (2)
		50: OP_METHOD (2)
		51: OP_METHOD_LONG (3)
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
		64: OP_SUPER_GETTER (1)
		65: OP_SUPER_GETTER_LONG (2)
		66: OP_SUPER_SETTER (1)
		67: OP_SUPER_SETTER_LONG (2)
		68: OP_SUPER_INVOKE (2)
		69: OP_SUPER_INVOKE_LONG (3)
		70: OP_STATIC_METHOD (2)
		71: OP_STATIC_METHOD_LONG (3)
	#tag EndNote


	#tag Property, Flags = &h21, Description = 5468652063757272656E742063616C6C206672616D652E
		Private CurrentFrame As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Disassembler As ObjoScript.Disassembler
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520737472696E6773207061737365642062792074686520646973617373656D626C6572277320605072696E74282960206576656E742061726520616464656420746F2074686973206275666665722E204974277320636C6561726564207768656E2074686520646973617373656D626C6572207261697365732069747320605072696E744C696E65282960206576656E742E
		Private DisassemblerOutput() As String
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206E756D626572206F66206F6E676F696E672066756E6374696F6E2063616C6C732E
		Private FrameCount As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120737461636B206F662063616C6C206672616D65732E
		Private Frames(-1) As ObjoScript.CallFrame
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53746F7265732074686520564D277320676C6F62616C207661726961626C65732E204B6579203D207661726961626C65206E616D652028537472696E67292C2056616C7565203D207661726961626C652076616C7565202856617269616E74292E
		Private Globals As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 53696E676C65746F6E20696E7374616E6365206F6620224E6F7468696E67222E
		Private Nothing As ObjoScript.Nothing
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 4B6579203D206F70636F64652028496E7465676572292C2056616C7565203D206E756D626572206F66206279746573207573656420666F72206F706572616E64732E
		#tag Getter
			Get
			  Static d As New Dictionary( _
			  OP_RETURN             : 0, _
			  OP_CONSTANT           : 1, _
			  OP_CONSTANT_LONG      : 2, _
			  OP_NEGATE             : 0, _
			  OP_ADD                : 0, _
			  OP_SUBTRACT           : 0, _
			  OP_DIVIDE             : 0, _
			  OP_MULTIPLY           : 0, _
			  OP_MODULO             : 0, _
			  OP_NOT                : 0, _
			  OP_EQUAL              : 0 , _
			  OP_GREATER            : 0, _
			  OP_LESS               : 0, _
			  OP_LESS_EQUAL         : 0, _
			  OP_GREATER_EQUAL      : 0, _
			  OP_NOT_EQUAL          : 0, _
			  OP_TRUE               : 0, _
			  OP_FALSE              : 0, _
			  OP_NOTHING            : 0, _
			  OP_POP                : 0, _
			  OP_SHIFT_LEFT         : 0, _
			  OP_SHIFT_RIGHT        : 0, _
			  OP_BITWISE_AND        : 0, _
			  OP_BITWISE_OR         : 0, _
			  OP_BITWISE_XOR        : 0, _
			  OP_LOAD_1             : 0, _
			  OP_LOAD_0             : 0, _
			  OP_LOAD_MINUS1        : 0, _
			  OP_PRINT              : 0, _
			  OP_ASSERT             : 0, _
			  OP_DEFINE_GLOBAL      : 1, _
			  OP_DEFINE_GLOBAL_LONG : 2, _
			  OP_GET_GLOBAL         : 1, _
			  OP_GET_GLOBAL_LONG    : 2, _
			  OP_SET_GLOBAL         : 1, _
			  OP_SET_GLOBAL_LONG    : 2, _
			  OP_POP_N              : 1, _
			  OP_GET_LOCAL          : 1, _
			  OP_SET_LOCAL          : 1, _
			  OP_JUMP_IF_FALSE      : 2, _
			  OP_JUMP               : 2, _
			  OP_JUMP_IF_TRUE       : 2, _
			  OP_LOGICAL_XOR        : 0, _
			  OP_LOOP               : 2, _
			  OP_INCLUSIVE_RANGE    : 0, _
			  OP_EXCLUSIVE_RANGE    : 0, _
			  OP_EXIT               : 0, _
			  OP_CALL               : 1, _
			  OP_CLASS              : 1, _
			  OP_CLASS_LONG         : 2, _ 
			  OP_METHOD             : 2, _
			  OP_METHOD_LONG        : 3, _
			  OP_SETTER             : 1, _
			  OP_SETTER_LONG        : 2, _
			  OP_GETTER             : 1, _
			  OP_GETTER_LONG        : 2, _
			  OP_GET_FIELD          : 1, _
			  OP_GET_FIELD_LONG     : 2, _
			  OP_SET_FIELD          : 1, _
			  OP_SET_FIELD_LONG     : 2, _
			  OP_CONSTRUCTOR        : 1, _
			  OP_INVOKE             : 2, _
			  OP_INVOKE_LONG        : 3, _
			  OP_INHERIT            : 0, _
			  OP_SUPER_GETTER       : 1, _
			  OP_SUPER_GETTER_LONG  : 2, _
			  OP_SUPER_SETTER       : 1, _
			  OP_SUPER_SETTER_LONG  : 2, _
			  OP_SUPER_INVOKE       : 2, _
			  OP_SUPER_INVOKE_LONG  : 3, _
			  OP_STATIC_METHOD      : 2, _
			  OP_STATIC_METHOD_LONG : 3 _
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


	#tag Constant, Name = MAX_FRAMES, Type = Double, Dynamic = False, Default = \"63", Scope = Public, Description = 54686520757070657220626F756E6473206F66207468652063616C6C206672616D6520737461636B2E
	#tag EndConstant

	#tag Constant, Name = MAX_STACK, Type = Double, Dynamic = False, Default = \"255", Scope = Public, Description = 54686520757070657220626F756E6473206F662074686520737461636B2E
	#tag EndConstant

	#tag Constant, Name = OP_ADD, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_ASSERT, Type = Double, Dynamic = False, Default = \"29", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_AND, Type = Double, Dynamic = False, Default = \"22", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_OR, Type = Double, Dynamic = False, Default = \"23", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_BITWISE_XOR, Type = Double, Dynamic = False, Default = \"24", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CALL, Type = Double, Dynamic = False, Default = \"47", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CLASS, Type = Double, Dynamic = False, Default = \"48", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_CLASS_LONG, Type = Double, Dynamic = False, Default = \"49", Scope = Public
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

	#tag Constant, Name = OP_EXCLUSIVE_RANGE, Type = Double, Dynamic = False, Default = \"45", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_EXIT, Type = Double, Dynamic = False, Default = \"46", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_FALSE, Type = Double, Dynamic = False, Default = \"17", Scope = Public
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

	#tag Constant, Name = OP_GREATER, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_GREATER_EQUAL, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INCLUSIVE_RANGE, Type = Double, Dynamic = False, Default = \"44", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INHERIT, Type = Double, Dynamic = False, Default = \"63", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INVOKE, Type = Double, Dynamic = False, Default = \"61", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_INVOKE_LONG, Type = Double, Dynamic = False, Default = \"62", Scope = Public
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

	#tag Constant, Name = OP_LOAD_0, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_1, Type = Double, Dynamic = False, Default = \"25", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOAD_MINUS1, Type = Double, Dynamic = False, Default = \"27", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOGICAL_XOR, Type = Double, Dynamic = False, Default = \"42", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_LOOP, Type = Double, Dynamic = False, Default = \"43", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_METHOD, Type = Double, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_METHOD_LONG, Type = Double, Dynamic = False, Default = \"51", Scope = Public
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

	#tag Constant, Name = OP_PRINT, Type = Double, Dynamic = False, Default = \"28", Scope = Public
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

	#tag Constant, Name = OP_SHIFT_LEFT, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SHIFT_RIGHT, Type = Double, Dynamic = False, Default = \"21", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_STATIC_METHOD, Type = Double, Dynamic = False, Default = \"70", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_STATIC_METHOD_LONG, Type = Double, Dynamic = False, Default = \"71", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUBTRACT, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_GETTER, Type = Double, Dynamic = False, Default = \"64", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_GETTER_LONG, Type = Double, Dynamic = False, Default = \"65", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_INVOKE, Type = Double, Dynamic = False, Default = \"68", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_INVOKE_LONG, Type = Double, Dynamic = False, Default = \"69", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_SETTER, Type = Double, Dynamic = False, Default = \"66", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_SUPER_SETTER_LONG, Type = Double, Dynamic = False, Default = \"67", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OP_TRUE, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TRACE_EXECUTION, Type = Boolean, Dynamic = False, Default = \"False", Scope = Public, Description = 496620547275652028616E6420746869732069732061206465627567206275696C6429207468656E2074686520564D2077696C6C206F757470757420646562756720696E666F726D6174696F6E20746F207468652073797374656D206465627567206C6F672E204E6F2065666665637420696E20636F6D70696C656420617070732E
	#tag EndConstant


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
	#tag EndViewBehavior
End Class
#tag EndClass
