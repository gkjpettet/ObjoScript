#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  // Parse any command line options.
		  ParseOptions(args)
		  
		  // Does the user want the version number?
		  If Options.BooleanValue("version") Then
		    PrintVersion
		    Return 0
		  End If
		  
		  // REPL or script execution?
		  If args.Count = 0 Then
		    // REPL
		    Repl
		  ElseIf Options.FileValue("file") <> Nil Then
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
		    Error(le.Message, ExitCodes.LexerError)
		    
		  Catch pe As ObjoScript.ParserException
		    // One or more parsing errors occurred.
		    Var errors() As ObjoScript.ParserException = compiler.ParserErrors
		    If errors.Count = 1 Then
		      Error(errors(0).Message, ExitCodes.ParserError)
		    Else
		      Var errorMessages() As String
		      For Each err As ObjoScript.ParserException In errors
		        errorMessages.Add(err.Message)
		      Next err
		      Error(errorMessages, ExitCodes.ParserError)
		    End If
		    
		  Catch ce As ObjoScript.CompilerException
		    // A compilation error occurred.
		    Error(ce.Message, ExitCodes.CompilerError)
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E747320746865206572726F72206D6573736167657320616E64207175697473207468652061707020776974682074686520696E74656765722076616C7565206F662074686520737065636966696564206065786974436F6465602E
		Sub Error(messages() As String, exitCode As ExitCodes)
		  /// Presents the error messages and quits the app with the integer value of the specified `exitCode`.
		  
		  For Each message As String In messages
		    Print(message)
		  Next message
		  
		  Quit(Integer(exitCode))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50726573656E747320746865206572726F7220606D6573736167656020616E64207175697473207468652061707020776974682074686520696E74656765722076616C7565206F662074686520737065636966696564206065786974436F6465602E
		Sub Error(message As String, exitCode As ExitCodes)
		  /// Presents the error `message` and quits the app with the integer value of the specified `exitCode`.
		  
		  Print(message)
		  Quit(Integer(exitCode))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 5061727365732074686520617267756D656E74732070617373656420746F20746865206170706C69636174696F6E2E
		Sub ParseOptions(args() As String)
		  /// Parses the arguments passed to the application.
		  
		  // If there are no arguments we start the interpreter in interactive mode (REPL mode).
		  If args.Count = 0 Then
		    Repl
		    Return
		  End If
		  
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

	#tag Method, Flags = &h0, Description = 5072696E7473207468652063757272656E742076657273696F6E20746F2074686520636F6E736F6C652E
		Sub PrintVersion()
		  /// Prints the current version to the console.
		  
		  Print("objoCLI v" + App.MajorVersion.ToString + "." + App.MinorVersion.ToString + "." + App.BugVersion.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E2074686520696E74657270726574657220696E20696E746572616374697665206D6F64652E
		Sub Repl()
		  /// Run the interpreter in interactive mode.
		  
		  #Pragma Warning "TODO"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52756E7320616E204F626A6F536372697074207363726970742066696C6520286066602920616E642072657475726E7320616E206578697420636F64652E
		Function RunScript(f As FolderItem) As Integer
		  /// Runs an ObjoScript script file (`f`) and returns an exit code.
		  
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
		    Error(e.Message, ExitCodes.RuntimeError)
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
		  
		  #Pragma Warning "TODO"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686520736372697074206861732063616C6C6564206053797374656D2E7072696E74287329602E
		Sub VMPrintDelegate(sender As ObjoScript.VM, s As String)
		  /// The script has called `System.print(s)`.
		  
		  #Pragma Unused sender
		  
		  Print(s)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636F6D6D616E64206C696E65206F7074696F6E207061727365722E
		Options As ConsoleKit.CKOptionParser
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206170702773204F626A6F53637269707420696E7465727072657465722E
		VM As ObjoScript.VM
	#tag EndProperty


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
