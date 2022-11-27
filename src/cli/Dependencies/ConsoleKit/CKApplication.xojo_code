#tag Class
Protected Class CKApplication
Inherits ConsoleApplication
	#tag Method, Flags = &h0, Description = 44656661756C7420636F6E7374727563746F722E
		Sub Constructor()
		  /// Default constructor.
		  
		  // Enable ANSI escape code sequence processing in Windows Command Prompt.
		  // Full credit to Lawrence Johnson: 
		  // https://forum.xojo.com/t/determine-shell-terminal-running-in/70187/3
		  
		  #If TargetWindows Then
		    Declare Function GetStdHandle Lib "Kernel32" (HandleType As Integer) As Integer
		    Declare Function GetConsoleMode Lib "Kernel32" (SourceHandle As Integer, ByRef Options as Integer) As Integer
		    Declare Function SetConsoleMode Lib "Kernel32" (SourceHandle As Integer, Options as Integer) As Integer
		    Const STD_OUTPUT_HANDLE = -11
		    Const ENABLE_VIRTUAL_TERMINAL_PROCESSING = &h0004
		    
		    Var h, cOpts As Integer
		    h = GetStdHandle(STD_OUTPUT_HANDLE)
		    Call GetConsoleMode(h, cOpts)
		    cOpts = (cOpts Or ENABLE_VIRTUAL_TERMINAL_PROCESSING)
		    Call SetConsoleMode(h, cOpts)
		  #EndIf
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		The superclass for `ConsoleKit`-based applications.
		
	#tag EndNote


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
