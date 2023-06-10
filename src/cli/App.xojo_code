#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  // Parse any command line options.
		  ParseOptions(args)
		  
		  // Does the user want the version number?
		  If Options.BooleanValue("version") Then
		    Print(ObjoVersion)
		    Return 0
		  End If
		  
		  // REPL or script execution?
		  If Options.FileValue("file") <> Nil Then
		    // Script execution.
		    Return RunScript(Options.FileValue("file"))
		  Else
		    Usage
		  End If
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 436F6D70696C65732060736F757263656020696E746F20616E2065786563757461626C65204F626A6F5363726970742066756E6374696F6E20616E642072657475726E732069742E20496620616E206572726F72206F63637572732C2069742069732070726573656E74656420746F20746865207573657220616E6420746865206170702071756974732E
		Function Compile(source As String) As ObjoScript.Func
		  /// Compiles `source` into an executable ObjoScript function and returns it.
		  /// If an error occurs, it is presented to the user and the app quits.
		  
		  Var compiler As New ObjoScript.Compiler
		  
		  Try
		    Return compiler.Compile(source)
		    
		  Catch le As ObjoScript.LexerException
		    // Something went wrong tokenising the source code.
		    Error(le)
		    
		  Catch pe As ObjoScript.ParserException
		    // One or more parsing error occurred.
		    Error(compiler.ParserErrors, True)
		    
		  Catch ce As ObjoScript.CompilerException
		    // A compilation error occurred.
		    Error(ce)
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E7473206120636F6D70696C6572206572726F7220616E6420717569747320746865206170702E
		Sub Error(ce As ObjoScript.CompilerException)
		  /// Presents a compiler error and quits the app.
		  
		  Print(CLIForecolor("Compiler error on line " + ce.Location.LineNumber.ToString + ":", COLOUR_RED))
		  Print("")
		  Print(CLIForecolor(ce.Message, COLOUR_RED))
		  
		  Quit(Integer(ExitCodes.CompilerError))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E74732061206C6578696E67206572726F7220616E6420717569747320746865206170702E
		Sub Error(le As ObjoScript.LexerException)
		  /// Presents a lexing error and quits the app.
		  
		  Var message As String = _
		  CLIForecolor("Error on line " + le.LineNumber.ToString + ", col " + le.LineCharacterPosition.ToString + ": " + le.Message, COLOUR_RED)
		  
		  Print(message)
		  
		  Quit(Integer(ExitCodes.LexerError))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E7473206F6E65206F72206D6F72652070617273696E67206572726F727320616E64206F7074696F6E616C6C7920717569747320746865206170702E
		Sub Error(errors() As ObjoScript.ParserException, shouldQuit As Boolean)
		  /// Presents one or more parsing errors and optionally quits the app.
		  
		  If errors.Count = 0 Then
		    If shouldQuit Then
		      Quit(Integer(ExitCodes.ParserError))
		    Else
		      Return
		    End If
		  End If
		  
		  If errors.Count = 1 Then
		    Error(errors(0), shouldQuit)
		    Return
		  Else
		    For Each pe As ObjoScript.ParserException In errors
		      Error(pe, False)
		      Print("")
		    Next pe
		  End If
		  
		  If shouldQuit Then
		    Quit(Integer(ExitCodes.ParserError))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E747320612070617273696E67206572726F7220616E64206F7074696F6E616C6C7920717569747320746865206170702E
		Sub Error(pe As ObjoScript.ParserException, shouldQuit As Boolean)
		  /// Presents a parsing error and optionally quits the app.
		  
		  Print(CLIForecolor("Parsing error on line " + pe.Location.LineNumber.ToString + ":", COLOUR_RED))
		  Print(pe.Message)
		  
		  If shouldQuit Then
		    Quit(Integer(ExitCodes.ParserError))
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E7473206120564D2072756E74696D65206572726F7220616E6420717569747320746865206170702E
		Sub Error(vme As ObjoScript.VMException)
		  /// Presents a VM runtime error and quits the app.
		  
		  Print(CLIForecolor("======================", COLOUR_RED))
		  Print(CLIForecolor("RUNTIME ERROR", COLOUR_RED))
		  Print(CLIForecolor("======================", COLOUR_RED))
		  Print("[line " + vme.LineNumber.ToString + "]: " + vme.Message)
		  Print("")
		  Print("STACK DUMP")
		  Print(vme.StackDump)
		  Print("")
		  Print("STACK TRACE")
		  Print("")
		  Print(String.FromArray(vme.VMStackTrace))
		  Print("")
		  
		  Quit(Integer(ExitCodes.RuntimeError))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E747320612067656E65726963206572726F72206D65737361676520616E6420717569747320746865206170702E
		Sub Error(message As String, exitCode As ExitCodes)
		  /// Presents a generic error message and quits the app.
		  
		  Print(CLIForecolor("Error: " + message, COLOUR_RED))
		  
		  Quit(Integer(exitCode))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjoVersion() As String
		  /// Returns a string representation of the interpreter.
		  
		  Return App.MajorVersion.ToString + "." + App.MinorVersion.ToString + "." + App.BugVersion.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5061727365732074686520617267756D656E74732070617373656420746F20746865206170706C69636174696F6E2E
		Sub ParseOptions(args() As String)
		  /// Parses the arguments passed to the application.
		  
		  Options = New ConsoleKit.CKOptionParser
		  Var o As ConsoleKit.CKOption
		  
		  // Display the version number.
		  o = New ConsoleKit.CKOption("v", "version", "Version details.", ConsoleKit.CKOption.OptionTypes.Boolean)
		  Options.AddOption(o)
		  
		  // Run a script.
		  o = New ConsoleKit.CKOption("f", "file", "The script file to run.", ConsoleKit.CKOption.OptionTypes.File)
		  Options.AddOption(o)
		  
		  // Actually parse the arguments.
		  Options.Parse(args)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E7320616E204F626A6F536372697074207363726970742066696C6520286066602920616E642072657475726E7320616E206578697420636F64652E
		Function RunScript(f As FolderItem) As Integer
		  /// Runs an ObjoScript script file (`f`) and returns an exit code.
		  
		  #Pragma BreakOnExceptions False
		  
		  // Get the source code from the file.
		  Var source As String
		  Try
		    Var tin As TextInputStream = TextInputStream.Open(f)
		    source = tin.ReadAll
		    tin.Close
		  Catch e As RuntimeException
		    Error("Unable to read the contents of the script file.", ExitCodes.IOError)
		  End Try
		  
		  // Compile the source to an executable function.
		  // If an error occurs it will be displayed and the app will quit.
		  Var func As ObjoScript.Func = Compile(source)
		  
		  SetupVM
		  
		  // Run the compiled function.
		  Try
		    VM.Interpret(func)
		    Quit(0)
		  Catch e As ObjoScript.VMException
		    Error(e)
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetupVM()
		  /// Setup the VM.
		  
		  VM = New ObjoScript.VM
		  AddHandler VM.Print, AddressOf VMPrintDelegate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320746865207573616765206F662074686520696E74657270726574657220746F20746865207465726D696E616C2E
		Sub Usage()
		  /// Prints the usage of the interpreter to the terminal.
		  
		  Const TAB = &u0009
		  
		  Welcome
		  
		  Print(CLIForecolor("Usage: objo [option]", COLOUR_YELLOW))
		  Print("objo -f" + TAB + TAB + ": Run a script file (`f`)")
		  Print("objo -v" + TAB + TAB + ": Display the interpreter's version number")
		  Print("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520736372697074206861732063616C6C6564206053797374656D2E7072696E74287329602E
		Sub VMPrintDelegate(sender As ObjoScript.VM, s As String)
		  /// The script has called `System.print(s)`.
		  
		  #Pragma Unused sender
		  
		  Print(s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5072696E747320612077656C636F6D65206D6573736167652E
		Sub Welcome()
		  /// Prints a welcome message.
		  
		  Print("")
		  Print("Objo interpreter (v" + ObjoVersion + ")")
		  Print("")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6D6D616E64206C696E65206F7074696F6E207061727365722E
		Options As ConsoleKit.CKOptionParser
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206170702773204F626A6F53637269707420696E7465727072657465722E
		VM As ObjoScript.VM
	#tag EndProperty


	#tag Constant, Name = COLOUR_BLACK, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COLOUR_BLUE, Type = Double, Dynamic = False, Default = \"33", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COLOUR_RED, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COLOUR_WHITE, Type = Double, Dynamic = False, Default = \"255", Scope = Public
	#tag EndConstant

	#tag Constant, Name = COLOUR_YELLOW, Type = Double, Dynamic = False, Default = \"226", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ExitCodes, Type = Integer, Flags = &h0
		None=0
		  IOError
		  LexerError
		  ParserError
		  CompilerError
		RuntimeError
	#tag EndEnum


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
