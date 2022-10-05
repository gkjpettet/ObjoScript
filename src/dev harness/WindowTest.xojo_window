#tag DesktopWindow
Begin DesktopWindow WindowTest
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
   Height          =   720
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   924989439
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "ObjoScript Dev Harness"
   Type            =   0
   Visible         =   True
   Width           =   1272
   Begin SimpleTextArea Code
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   655
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   0
      ValidationMask  =   ""
      Visible         =   True
      Width           =   603
   End
   Begin DesktopButton ButtonClear
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Clear"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   635
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopLabel Info
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Info"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   603
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   621
      Index           =   -2147483648
      Left            =   635
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   5
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Value           =   2
      Visible         =   True
      Width           =   617
      Begin DesktopListBox TokensListbox
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   5
         ColumnWidths    =   "200, 60, 60, *, 60"
         DefaultRowHeight=   20
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   601
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Type	Line	Abs Pos	Value	Script ID"
         Italic          =   False
         Left            =   635
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   617
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin ASTTreeView ASTView
         AutoDeactivate  =   True
         BackColor       =   &cFFFFFF00
         ColumnCount     =   1
         DarkBackColor   =   &c2D2D2D00
         DarkNodeTextColor=   &cFFFFFF00
         DarkSelectionTextColor=   &cFFFFFF00
         DragReceiveBehavior=   1
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         HasBackColor    =   False
         HasBorder       =   True
         HasHeader       =   False
         HasInactiveSelectionColor=   False
         HasNodeColor    =   False
         HasNodeTextColor=   False
         HasSelectionColor=   False
         HasSelectionTextColor=   False
         Height          =   601
         InactiveSelectionColor=   &cD3D3D300
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   635
         LinuxDrawTreeLines=   False
         LinuxExpanderStyle=   0
         LinuxHighlightFullRow=   True
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MacDrawTreeLines=   False
         MacExpanderStyle=   0
         MacHighlightFullRow=   True
         MultiSelection  =   False
         NodeEvenColor   =   &cFFFFFF00
         NodeHeight      =   18
         NodeOddColor    =   &cFFFFFF00
         NodeTextColor   =   &c00000000
         QuartzShading   =   False
         Scope           =   2
         SelectionColor  =   &c478A1A00
         SelectionSeparator=   0
         SelectionTextColor=   &cFFFFFF00
         SystemNodeColors=   True
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   54
         UseFocusRing    =   False
         Visible         =   True
         Width           =   617
         WinDrawTreeLines=   True
         WinHighlightFullRow=   False
      End
      Begin DesktopListBox ErrorsListbox
         AllowAutoDeactivate=   True
         AllowAutoHideScrollbars=   True
         AllowExpandableRows=   False
         AllowFocusRing  =   False
         AllowResizableColumns=   False
         AllowRowDragging=   False
         AllowRowReordering=   False
         Bold            =   False
         ColumnCount     =   4
         ColumnWidths    =   "*, 60, 60, 60"
         DefaultRowHeight=   -1
         DropIndicatorVisible=   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         GridLineStyle   =   0
         HasBorder       =   True
         HasHeader       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         HeadingIndex    =   -1
         Height          =   601
         Index           =   -2147483648
         InitialParent   =   "Panel"
         InitialValue    =   "Message	Line	AbsPos	Script ID"
         Italic          =   False
         Left            =   635
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         RequiresSelection=   False
         RowSelectionType=   0
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   3
         TabStop         =   True
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   617
         _ScrollOffset   =   0
         _ScrollWidth    =   -1
      End
      Begin DesktopTextArea Output
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   601
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   635
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   5
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   617
      End
      Begin DesktopTextArea DisassemblerOutput
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   601
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Italic          =   False
         Left            =   635
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   4
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   54
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   617
      End
   End
   Begin DesktopBevelButton ButtonAST
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   0
      Bold            =   False
      ButtonStyle     =   1
      Caption         =   "AST"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   22
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   1192
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   60
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopBevelButton ButtonTokens
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   0
      Bold            =   False
      ButtonStyle     =   1
      Caption         =   "Tokens"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   22
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   1120
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   60
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopBevelButton ButtonErrors
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   0
      Bold            =   False
      ButtonStyle     =   1
      Caption         =   "Errors"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   22
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   1048
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   60
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopBevelButton ButtonDisassembler
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   0
      Bold            =   False
      ButtonStyle     =   1
      Caption         =   "Disassembler"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   22
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   930
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   106
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopButton ButtonCompile
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Compile"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   1172
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopBevelButton ButtonOutput
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      BackgroundColor =   &c00000000
      BevelStyle      =   0
      Bold            =   False
      ButtonStyle     =   1
      Caption         =   "Output"
      CaptionAlignment=   3
      CaptionDelta    =   0
      CaptionPosition =   1
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      HasBackgroundColor=   False
      Height          =   22
      Icon            =   0
      IconAlignment   =   0
      IconDeltaX      =   0
      IconDeltaY      =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   857
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MenuStyle       =   0
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   61
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopButton ButtonRun
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Run"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   1080
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   16
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopButton ButtonTest
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Test"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   727
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin DesktopCheckBox CheckBoxDebugMode
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Debug Mode"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   968
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   687
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      VisualState     =   0
      Width           =   100
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Reset
		  SwitchToPanel(PANEL_AST)
		  
		  Disassembler = New ObjoScript.Disassembler
		  Addhandler Disassembler.Print, AddressOf DisassemblerPrintDelegate
		  Addhandler Disassembler.PrintLine, AddressOf DisassemblerPrintLineDelegate
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Function Compile() As Boolean
		  #Pragma BreakOnExceptions False
		  
		  Reset(False)
		  
		  SwitchToPanel(PANEL_DISASSEMBLER_OUTPUT)
		  
		  Compiler.DebugMode = CheckBoxDebugMode.Value
		  
		  Try
		    Func = Compiler.Compile(Code.Text)
		    
		    // Show the tokens.
		    UpdateTokensListbox(Compiler.Tokens)
		    
		    // Show the AST.
		    ASTView.Display(Compiler.AST)
		    
		    // Disassemble the chunk.
		    Disassembler.Disassemble(Func.Chunk, "Test")
		    Info.Text = "Compilation successful (" + Compiler.TotalTime.ToString(Locale.Current, "#.#") + " ms)."
		    
		    // Successful compilation.
		    Return True
		    
		  Catch le As ObjoScript.LexerException
		    DisplayLexerError(le)
		    
		    Return False
		    
		  Catch pe As ObjoScript.ParserException
		    // Show the tokens.
		    UpdateTokensListbox(Compiler.Tokens)
		    
		    DisplayParserErrors(Compiler.ParserErrors)
		    
		    Return False
		    
		  Catch ce As ObjoScript.CompilerException
		    // Show the tokens.
		    UpdateTokensListbox(Compiler.Tokens)
		    
		    // Show the AST.
		    ASTView.Display(Compiler.AST)
		    
		    DisplayCompilerError(ce)
		    
		    Return False
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320612073656E7369626C652064656661756C74206D6F6E6F737061636520666F6E74206E616D6520666F722074686520706C6174666F726D207765277265206F6E2E
		Function DefaultMonospaceFont() As String
		  /// Returns a sensible default monospace font name for the platform we're on.
		  
		  #If TargetMacOS Then
		    Return "Menlo"
		    
		  #ElseIf TargetWindows Then
		    Return "Consolas"
		    
		  #ElseIf TargetLinux Then
		    Return "DejaVu Sans Mono"
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DisassemblerPrintDelegate(sender As ObjoScript.Disassembler, s As String)
		  #Pragma Unused sender
		  
		  mDisassemblerOutput.Add(s)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DisassemblerPrintLineDelegate(sender As ObjoScript.Disassembler, s As String)
		  #Pragma Unused sender
		  
		  mDisassemblerOutput.Add(s)
		  DisassemblerOutput.Text = DisassemblerOutput.Text + String.FromArray(mDisassemblerOutput) + EndOfLine
		  mDisassemblerOutput.ResizeTo(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973706C6179732064657461696C732061626F7574206120636F6D70696C6572206572726F7220696E2074686520496E666F206C6162656C2E
		Sub DisplayCompilerError(e As ObjoScript.CompilerException)
		  /// Displays details about a compiler error in the Info label.
		  
		  Info.Text = e.Location.LineNumber.ToString + ": " + e.Message
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973706C6179732064657461696C732061626F75742061206C6578657220657863657074696F6E20696E2074686520496E666F206C6162656C2E
		Sub DisplayLexerError(e As ObjoScript.LexerException)
		  /// Displays details about a lexer exception in the Info label.
		  
		  Info.Text = e.LineNumber.ToString + ", " + e.LineCharacterPosition.ToString + ": " + e.Message
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973706C61797320616E79206572726F72732074686174206F6363757272656420647572696E672070617273696E672E
		Sub DisplayParserErrors(errors() As ObjoScript.ParserException)
		  /// Displays any errors that occurred during parsing.
		  
		  If errors.Count = 1 Then
		    Info.Text = "A parsing error occurred."
		  Else
		    Info.Text = errors.Count.ToString + " parsing errors occurred."
		  End If
		  
		  UpdateParsingErrorsListbox(errors)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 446973706C6179732064657461696C732061626F7574206120564D2072756E74696D65206572726F7220696E2074686520496E666F206C6162656C2E
		Sub DisplayVMError(e As ObjoScript.VMException)
		  /// Displays details about a VM runtime error in the Info label.
		  
		  Info.Text = e.LineNumber.ToString + ": " + e.Message
		  
		  Var s() As String
		  s.Add("======================")
		  s.Add("RUNTIME ERROR")
		  s.Add("======================")
		  s.Add("[line " + e.LineNumber.ToString + "]: " + e.Message) + EndOfLine
		  s.Add("STACK TRACE") + EndOfLine + EndOfLine
		  Output.Text = Output.Text + EndOfLine + String.FromArray(s, EndOfLine) + String.FromArray(e.VMStackTrace, EndOfLine)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset(clearSource As Boolean = True)
		  If clearSource Then Code.Text = ""
		  
		  TokensListbox.RemoveAllRows
		  
		  ASTView.RemoveAllNodes
		  
		  ErrorsListbox.RemoveAllRows
		  
		  Output.Text = ""
		  
		  Info.Text = ""
		  
		  DisassemblerOutput.Text = ""
		  mDisassemblerOutput.ResizeTo(-1)
		  
		  Compiler = New ObjoScript.Compiler
		  Func = Nil
		  
		  // Remove associated handlers.
		  If VM <> Nil Then
		    RemoveHandler VM.Print, AddressOf VMPrintDelegate
		    RemoveHandler VM.BindForeignMethod, AddressOf VMBindForeignMethodDelegate
		  End If
		  
		  VM = New ObjoScript.VM
		  AddHandler VM.Print, AddressOf VMPrintDelegate
		  AddHandler VM.BindForeignMethod, AddressOf VMBindForeignMethodDelegate
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Run()
		  Reset(False)
		  
		  If Not Compile Then Return
		  
		  SwitchToPanel(PANEL_OUTPUT)
		  
		  Vm.DebugMode = CheckBoxDebugMode.Value
		  
		  Try
		    Var watch As New ObjoScript.StopWatch(True)
		    VM.Interpret(Func)
		    watch.Stop
		    Info.Text = "Compile: " + Compiler.CompileTime.ToString(Locale.Current, "#.#") + " ms. Execute: " + watch.ElapsedMilliseconds.ToString + " ms"
		  Catch e As ObjoScript.VMException
		    DisplayVMError(e)
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SwitchToPanel(id As Integer)
		  Select Case id
		  Case PANEL_AST
		    ButtonAST.Value = True
		    ButtonTokens.Value = False
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = False
		    ButtonOutput.Value = False
		    Panel.SelectedPanelIndex = id
		    
		  Case PANEL_TOKENS
		    ButtonAST.Value = False
		    ButtonTokens.Value = True
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = False
		    ButtonOutput.Value = False
		    Panel.SelectedPanelIndex = id
		    
		  Case PANEL_ERRORS
		    ButtonAST.Value = False
		    ButtonTokens.Value = False
		    ButtonErrors.Value = True
		    ButtonDisassembler.Value = False
		    ButtonOutput.Value = False
		    Panel.SelectedPanelIndex = PANEL_ERRORS
		    
		  Case PANEL_DISASSEMBLER_OUTPUT
		    ButtonAST.Value = False
		    ButtonTokens.Value = False
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = True
		    ButtonOutput.Value = False
		    Panel.SelectedPanelIndex = PANEL_DISASSEMBLER_OUTPUT
		    
		  Case PANEL_OUTPUT
		    ButtonAST.Value = False
		    ButtonTokens.Value = False
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = False
		    ButtonOutput.Value = True
		    Panel.SelectedPanelIndex = PANEL_OUTPUT
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown panel ID.")
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 55706461746573207468652070617273696E67206572726F7273206C697374626F7820776974682074686520636F6E74656E7473206F6620606572726F7273602E
		Sub UpdateParsingErrorsListbox(errors() As ObjoScript.ParserException)
		  /// Updates the parsing errors listbox with the contents of `errors`.
		  
		  ErrorsListbox.RemoveAllRows
		  
		  If errors.Count = 0 Then Return
		  
		  For Each e As ObjoScript.ParserException In errors
		    ErrorsListbox.AddRow(e.Message, e.Location.LineNumber.ToString, e.Location.StartPosition.ToString, e.Location.ScriptID.ToString)
		  Next e
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 557064617465732074686520746F6B656E73206C697374626F7820776974682074686520706173736564206172726179206F662060746F6B656E73602E
		Sub UpdateTokensListbox(tokens() As ObjoScript.Token)
		  /// Updates the tokens listbox with the passed array of `tokens`.
		  ///
		  /// type, line, abs pos, value, script ID.
		  
		  TokensListbox.RemoveAllRows
		  
		  Var type, value As String
		  For Each t As ObjoScript.Token In tokens
		    
		    // Compute the value and type.
		    Select Case t.Type
		    Case ObjoScript.TokenTypes.Number
		      If t.IsInteger Then
		        value = t.NumberValue.ToString(Locale.Current, "#")
		        type = "Number (int)"
		      Else
		        value = t.NumberValue.ToString
		        type = "Number (double)"
		      End If
		      
		    Case ObjoScript.TokenTypes.Boolean_
		      value = t.BooleanValue.ToString
		      type = t.Type.ToString
		      
		    Else
		      value = t.Lexeme
		      type = t.Type.ToString
		    End Select
		    
		    TokensListbox.AddRow(type, t.LineNumber.ToString, t.StartPosition.ToString, value, t.ScriptID.ToString)
		    
		  Next t
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 43616C6C65642062792074686520564D207768656E206974206E65656473206120666F726569676E206D6574686F642064656C65676174652E2049732063616C6C6564206F6E636520666F72206561636820666F726569676E206D6574686F6420647572696E6720636C617373206465636C61726174696F6E2E
		Function VMBindForeignMethodDelegate(sender As ObjoScript.VM, className As String, methodSignature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Called by the VM when it needs a foreign method delegate. 
		  /// Is called once for each foreign method during class declaration.
		  
		  #Pragma Unused sender
		  #Pragma Unused isStatic
		  
		  If className.Compare("System", ComparisonOptions.CaseSensitive) = 0 Then
		    If methodSignature.Compare("clock()", ComparisonOptions.CaseSensitive) = 0 Then
		      Return AddressOf ObjoSystem.Clock
		    End If
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VMPrintDelegate(sender As ObjoScript.VM, s As String)
		  #Pragma Unused sender
		  
		  Output.Text = Output.Text + s + EndOfLine
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Compiler As ObjoScript.Compiler
	#tag EndProperty

	#tag Property, Flags = &h0
		Disassembler As ObjoScript.Disassembler
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520636F6D70696C656420746F702D6C6576656C2066756E6374696F6E2E
		Func As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisassemblerOutput() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		VM As ObjoScript.VM
	#tag EndProperty


	#tag Constant, Name = PANEL_AST, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_DISASSEMBLER_OUTPUT, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_ERRORS, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_OUTPUT, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PANEL_TOKENS, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ButtonClear
	#tag Event
		Sub Pressed()
		  Reset
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Output
	#tag Event
		Sub Opening()
		  Me.FontName = DefaultMonospaceFont
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events DisassemblerOutput
	#tag Event
		Sub Opening()
		  Me.FontName = DefaultMonospaceFont
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonAST
	#tag Event
		Sub Pressed()
		  SwitchToPanel(PANEL_AST)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonTokens
	#tag Event
		Sub Pressed()
		  SwitchToPanel(PANEL_TOKENS)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonErrors
	#tag Event
		Sub Pressed()
		  SwitchToPanel(PANEL_ERRORS)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonDisassembler
	#tag Event
		Sub Pressed()
		  SwitchToPanel(PANEL_DISASSEMBLER_OUTPUT)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonCompile
	#tag Event
		Sub Pressed()
		  /// Compile the source code in `Code` but don't run it.
		  
		  Call Compile
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonOutput
	#tag Event
		Sub Pressed()
		  SwitchToPanel(PANEL_OUTPUT)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonRun
	#tag Event
		Sub Pressed()
		  /// Compile and run the source code in `Code`.
		  
		  Run
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonTest
	#tag Event
		Sub Pressed()
		  // Assumes the source code has been compiled and run once.
		  
		  // Put the "GameEngine" class into slot 0.
		  VM.PutGlobalVariable("GameEngine", 0)
		  
		  // Create a handle to the game engine's update(_) method.
		  Var gameEngineUpdate As ObjoScript.CallHandle = VM.CreateHandle("update(_)", 1)
		  
		  For i As Integer = 1 To 10
		    // Put the argument in slot 1.
		    VM.SetSlot(1, i)
		    
		    // Call the handle.
		    VM.InvokeHandle(gameEngineUpdate)
		  Next i
		  
		  // Put the "Person" class into slot 0.
		  VM.PutGlobalVariable("Person", 0)
		  
		  // Create a handle to the Person's constructor(_) method.
		  Var newPerson1 As ObjoScript.CallHandle = VM.CreateHandle("constructor(_)", 1)
		  // And to the constructor(_,_) method.
		  Var newPerson2 As ObjoScript.CallHandle = VM.CreateHandle("constructor(_,_)", 2)
		  
		  // Create a new person called "Maebh".
		  VM.SetSlot(1, "Maebh")
		  VM.InvokeHandle(newPerson1)
		  
		  // Get the instance created.
		  Var maebh As ObjoScript.Instance = VM.GetSlotValue(0)
		  
		  // Create a new person called "Aoife Pettet".
		  VM.SetSlot(1, "Aoife")
		  VM.SetSlot(2, "Pettet")
		  VM.InvokeHandle(newPerson2)
		  
		  // Get the instance created.
		  Var aoife As ObjoScript.Instance = VM.GetSlotValue(0)
		  
		  #Pragma Unused maebh
		  #Pragma Unused aoife
		  
		  Break
		  
		  Exception e
		    MessageBox(e.Message)
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
