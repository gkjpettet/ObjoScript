#tag Class
Protected Class App
Inherits XUIApp
	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
		  // Create a new IDE window instance.
		  
		  Var w As New WinIDE(Nil)
		  w.Show
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
		  /// Open an ObjoScript file.
		  
		  Var f As FolderItem = FolderItem.ShowOpenFileDialog(DocumentTypes.ObjoScript)
		  
		  If f = Nil Then Return True
		  
		  Var w As New WinIDE(f)
		  w.Show
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function WindowTests() As Boolean Handles WindowTests.Action
		  WinObjoScriptUnitTests.Show
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


End Class
#tag EndClass
