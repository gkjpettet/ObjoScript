#tag DesktopWindow
Begin DesktopWindow WinIDE
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   820
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   910139391
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "ObjoScript Editor"
   Type            =   0
   Visible         =   True
   Width           =   1090
   Begin XUICodeEditor Editor
      AllowAutocomplete=   True
      AllowAutoCompleteInComments=   True
      AllowInertialScrolling=   True
      AutocompleteCombo=   "XUICodeEditor.AutocompleteCombos.Tab"
      AutocompletePopupFontName=   "System"
      AutocompletePopupFontSize=   12
      AutoDeactivate  =   True
      BackgroundColor =   &c00000000
      BlinkCaret      =   True
      BorderColor     =   &c00000000
      CaretColour     =   &c00000000
      CaretType       =   1
      ContentType     =   "XUICodeEditor.ContentTypes.SourceCode"
      CurrentLineHighlightColor=   &c00000000
      CurrentLineNumberColor=   &c00000000
      DisplayLineNumbers=   False
      DrawBlockLines  =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   12
      HasBottomBorder =   False
      HasLeftBorder   =   False
      HasRightBorder  =   False
      HasTopBorder    =   False
      Height          =   779
      HighlightCurrentLine=   False
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LineNumberColor =   &c00000000
      LineNumberFontSize=   12
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MinimumAutocompletionLength=   2
      MinimumParseInterval=   500
      Scope           =   0
      SelectionColour =   &c00000000
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      VerticalLinePadding=   0
      Visible         =   True
      Width           =   1090
   End
   Begin DesktopLabel Info
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   784
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   791
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   295
   End
   Begin Timer InfoTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Period          =   500
      RunMode         =   2
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function CancelClosing(appQuitting As Boolean) As Boolean
		  #Pragma Unused appQuitting
		  
		  If Self.Changed Then
		    // Prompt the user to save changes.
		    Select Case SaveChangesDialog
		    Case SavePromptChoices.DontSave
		      // Allow the window to close.
		      Return False
		    Case SavePromptChoices.Cancel
		      // Prevent the window closing.
		      Return True
		    Case SavePromptChoices.Save
		      Return Not SaveFile(File)
		    End Select
		  Else
		    // Allow the window to close.
		    Return False
		  End If
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  // Edit menu
		  EditCopy.Enabled = Editor.TextSelected
		  EditCut.Enabled = Editor.TextSelected
		  EditRedo.Enabled = UndoManager.CanRedo
		  EditSelectAll.Enabled = Editor.Contents.Length > 0
		  EditUndo.Enabled = UndoManager.CanUndo
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // Create an undo manager.
		  UndoManager = New XUIUndoManager
		  
		  // We have to assign the code editor's undo manager here because the window's Opening event fires 
		  // after the editor's Opening event.
		  Editor.UndoManager = Self.UndoManager
		  
		  Editor.Formatter = New XUICEObjoScriptFormatter
		  
		  Editor.Theme = XUICETheme.FromFile(SpecialFolder.Resource("EditorTheme.toml"))
		  
		  // Increase the default font a little.
		  Editor.FontSize = 14
		  
		  // Enable autocompletion.
		  Editor.AllowAutocomplete = True
		  
		  // Initialise a basic autocompletion engine.
		  InitialiseAutocomplete
		  
		  If File <> Nil And File.Exists Then
		    Var tin As TextInputStream = TextInputStream.Open(File)
		    Var s As String = tin.ReadAll
		    tin.Close
		    s = s.ReplaceLineEndings(EndOfLine.UNIX)
		    Editor.Insert(s, 0, False, True, False)
		  End If
		  
		  Self.Changed = False
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
		  // Copies the contents of the current selection in the editor to the clipboard.
		  
		  Var c As New Clipboard
		  If Editor.TextSelected Then
		    c.Text = Editor.CurrentSelection.ToString
		  Else
		    c.Text = ""
		  End If
		  c.Close
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
		  // Cuts the contents of the current selection in the editor and puts it on the clipboard.
		  
		  Var c As New Clipboard
		  If Editor.TextSelected Then
		    c.Text = Editor.CurrentSelection.ToString
		  Else
		    c.Text = ""
		  End If
		  c.Close
		  
		  Editor.DeleteSelection(True, True, True, "Cut Text")
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
		  // Pastes the contents of the clipboard into the editor.
		  
		  // Get the clipboard text (replacing any line endings with UNIX ones).
		  Var c As New Clipboard
		  Var t As String = c.Text.ReplaceLineEndings(&u0A)
		  c.Close
		  
		  // Insert the text.
		  If t.CharacterCount > 0 Then
		    If Editor.TextSelected Then
		      Editor.ReplaceCurrentSelection(t)
		    Else
		      Editor.Insert(t, Editor.CaretPosition, True)
		    End If
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditRedo() As Boolean Handles EditRedo.Action
		  If UndoManager.CanRedo Then
		    UndoManager.Redo
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditSelectAll() As Boolean Handles EditSelectAll.Action
		  // Select everything in the editor.
		  
		  Self.Editor.SelectAll
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditUndo() As Boolean Handles EditUndo.Action
		  If UndoManager.CanUndo Then
		    UndoManager.Undo
		  End If
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileCloseWindow() As Boolean Handles FileCloseWindow.Action
		  Self.Close
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

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
		Function FileSave() As Boolean Handles FileSave.Action
		  Call SaveFile(Self.File)
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSaveAs() As Boolean Handles FileSaveAs.Action
		  Call SaveFile(Nil)
		  
		  Return True
		  
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub Constructor(file As FolderItem)
		  Self.File = file
		  
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C6973657320746865206175746F636F6D706C65746520656E67696E652E
		Private Sub InitialiseAutocomplete()
		  /// Initialises the autocomplete engine.
		  
		  AutocompleteEngine = New BasicAutocompleteEngine(True)
		  
		  AutocompleteEngine.AddOption("and")
		  AutocompleteEngine.AddOption("as")
		  AutocompleteEngine.AddOption("assert")
		  AutocompleteEngine.AddOption("breakpoint")
		  AutocompleteEngine.AddOption("class")
		  AutocompleteEngine.AddOption("continue")
		  AutocompleteEngine.AddOption("constructor")
		  AutocompleteEngine.AddOption("else")
		  AutocompleteEngine.AddOption("exit")
		  AutocompleteEngine.AddOption("export")
		  AutocompleteEngine.AddOption("false")
		  AutocompleteEngine.AddOption("foreach")
		  AutocompleteEngine.AddOption("foreign")
		  AutocompleteEngine.AddOption("function")
		  AutocompleteEngine.AddOption("if")
		  AutocompleteEngine.AddOption("import")
		  AutocompleteEngine.AddOption("in")
		  AutocompleteEngine.AddOption("is")
		  AutocompleteEngine.AddOption("not")
		  AutocompleteEngine.AddOption("nothing")
		  AutocompleteEngine.AddOption("or")
		  AutocompleteEngine.AddOption("print")
		  AutocompleteEngine.AddOption("return")
		  AutocompleteEngine.AddOption("static")
		  AutocompleteEngine.AddOption("super")
		  AutocompleteEngine.AddOption("then")
		  AutocompleteEngine.AddOption("this")
		  AutocompleteEngine.AddOption("true")
		  AutocompleteEngine.AddOption("var")
		  AutocompleteEngine.AddOption("while")
		  AutocompleteEngine.AddOption("xor")
		  
		  AutocompleteEngine.AddOption("Boolean")
		  AutocompleteEngine.AddOption("Number")
		  AutocompleteEngine.AddOption("Function")
		  AutocompleteEngine.AddOption("Range")
		  AutocompleteEngine.AddOption("String")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 54686572652061726520756E7361766564206368616E6765732E2050726573656E7420746865207573657220776974682061206469616C6F672061736B696E67207468656D207768617420746F20646F2E
		Function SaveChangesDialog() As SavePromptChoices
		  /// There are unsaved changes. Present the user with a dialog asking them what to do.
		  
		  Var d As New MessageDialog
		  Var b As MessageDialogButton
		  d.Icon = MessageDialog.GraphicCaution
		  d.ActionButton.Caption = "Save"
		  d.CancelButton.Visible = True
		  d.AlternateActionButton.Visible = True // Don't save button.
		  d.AlternateActionButton.Caption = "Don't Save"
		  d.Message = "Do you want to save changes to this document before closing?"
		  d.Explanation = "If you don't save, your changes will be lost. "
		  
		  b = d.ShowModal
		  Select Case b
		  Case d.ActionButton
		    Return SavePromptChoices.Save
		  Case d.AlternateActionButton
		    Return SavePromptChoices.DontSave
		  Case d.CancelButton
		    Return SavePromptChoices.Cancel
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 53617665732074686520636F6E74656E7473206F662074686520656469746F7220746F206066602E2049662060666020697320604E696C60207468656E2077652070726F6D707420746865207573657220666F7220612073617665206C6F636174696F6E2E2052657475726E7320547275652069662074686520636F6E74656E74732077657265207361766564206F722046616C7365206966206E6F742E
		Function SaveFile(f As FolderItem) As Boolean
		  /// Saves the contents of the editor to `f`. If `f` is `Nil` then we prompt the user
		  /// for a save location.
		  /// Returns True if the contents were saved or False if not.
		  
		  Self.Changed = True
		  
		  If f = Nil Or Not f.Exists Then
		    f = FolderItem.ShowSaveFileDialog(DocumentTypes.ObjoScript, "New ObjoScript file.objo_script")
		  End If
		  
		  If f = Nil Then Return False
		  
		  Var tout As TextOutputStream = TextOutputStream.Create(f)
		  tout.Write(Editor.Contents)
		  tout.Close
		  
		  Self.File = f
		  
		  Self.Changed = False
		  
		  Return True
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 412076657279206261736963204F626A6F536372697074206175746F636F6D706C65746520656E67696E652E
		AutocompleteEngine As BasicAutocompleteEngine
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652066696C65206265696E67206564697465642E2057696C6C206265204E696C2069662061206E65772066696C65207468617420686173206E65766572206265656E2073617665642E
		File As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520756E646F206D616E6167657220666F7220746869732077696E646F772E
		UndoManager As XUIUndoManager
	#tag EndProperty


	#tag Enum, Name = SavePromptChoices, Type = Integer, Flags = &h0
		Cancel
		  DontSave
		Save
	#tag EndEnum


#tag EndWindowCode

#tag Events Editor
	#tag Event , Description = 54686520656469746F722069732061626F757420746F20626520646973706C617965642E
		Sub Opening()
		  Me.HighlightDelimitersAroundCaret = True
		  
		  Editor.ContentType = XUICodeEditor.ContentTypes.SourceCode
		  
		  Me.HighlightCurrentLine = True
		  
		  Me.BorderColor = New ColorGroup(&cD7D9D9, &c2A2A2A)
		End Sub
	#tag EndEvent
	#tag Event , Description = 54686520636F646520656469746F722069732061736B696E6720666F72206175746F636F6D706C6574696F6E206F7074696F6E7320666F72207468652073706563696669656420607072656669786020617420606361726574436F6C756D6E60206F6E206C696E65206E756D626572206063617265744C696E65602E20596F752073686F756C642072657475726E204E696C20696620746865726520617265206E6F6E652E
		Function AutocompleteDataForPrefix(prefix As String, caretLine As Integer, caretColumn As Integer) As XUICEAutocompleteData
		  #Pragma Unused caretLine
		  #Pragma Unused caretColumn
		  
		  Return AutocompleteEngine.DataForPrefix(prefix)
		  
		End Function
	#tag EndEvent
	#tag Event , Description = 546865207465787420636F6E74656E7473206F662074686520656469746F7220686173206368616E6765642E
		Sub ContentsDidChange()
		  Self.Changed = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events InfoTimer
	#tag Event
		Sub Action()
		  Info.Text = "Ln " + Editor.CaretLineNumber.ToString + ", Col " + _
		  Editor.CaretColumn.ToString
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Windows Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
