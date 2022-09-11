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
      PanelCount      =   4
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   False
      Tooltip         =   ""
      Top             =   54
      Transparent     =   False
      Value           =   3
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
      Begin SimpleTextArea Output
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   False
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
         UnicodeMode     =   0
         ValidationMask  =   ""
         Visible         =   True
         Width           =   617
         Begin DesktopTextArea DisassemblerOutput
            AllowAutoDeactivate=   True
            AllowFocusRing  =   False
            AllowSpellChecking=   True
            AllowStyledText =   True
            AllowTabs       =   False
            BackgroundColor =   &cFFFFFF
            Bold            =   False
            Enabled         =   True
            FontName        =   "Menlo"
            FontSize        =   0.0
            FontUnit        =   0
            Format          =   ""
            HasBorder       =   True
            HasHorizontalScrollbar=   False
            HasVerticalScrollbar=   True
            Height          =   601
            HideSelection   =   True
            Index           =   -2147483648
            InitialParent   =   "Output"
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
            Scope           =   0
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
      Left            =   1080
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
		Sub Compile()
		  #Pragma BreakOnExceptions False
		  
		  Reset(False)
		  
		  SwitchToPanel(PANEL_DISASSEMBLER_OUTPUT)
		  
		  Var chunk As ObjoScript.Chunk
		  Try
		    chunk = Compiler.Compile(Code.Text)
		    
		    // Show the tokens.
		    UpdateTokensListbox(Compiler.Tokens)
		    
		    // Show the AST.
		    UpdateASTView(Compiler.AST)
		    
		    // Disassemble the chunk.
		    Disassembler.Disassemble(chunk, "Test")
		    Info.Text = "Compilation successful."
		    
		  Catch le As ObjoScript.LexerException
		    DisplayLexerError(le)
		    
		  Catch pe As ObjoScript.ParserException
		    DisplayParserErrors(Compiler.ParserErrors)
		    
		  Catch ce As ObjoScript.CompilerException
		    DisplayCompilerError(ce)
		  End Try
		  
		End Sub
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
		  
		  VM = New ObjoScript.VM
		  
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
		    Panel.SelectedPanelIndex = id
		    
		  Case PANEL_TOKENS
		    ButtonAST.Value = False
		    ButtonTokens.Value = True
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = False
		    Panel.SelectedPanelIndex = id
		    
		  Case PANEL_ERRORS
		    ButtonAST.Value = False
		    ButtonTokens.Value = False
		    ButtonErrors.Value = True
		    ButtonDisassembler.Value = False
		    Panel.SelectedPanelIndex = PANEL_ERRORS
		    
		  Case PANEL_DISASSEMBLER_OUTPUT
		    ButtonAST.Value = False
		    ButtonTokens.Value = False
		    ButtonErrors.Value = False
		    ButtonDisassembler.Value = True
		    Panel.SelectedPanelIndex = PANEL_DISASSEMBLER_OUTPUT
		    
		  Else
		    Raise New UnsupportedOperationException("Unknown panel ID.")
		  End Select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 557064617465732074686520415354207669657720746F20636F6E7461696E20746865207061737365642060617374602E
		Sub UpdateASTView(ast() As ObjoScript.Stmt)
		  /// Updates the AST view to contain the passed `ast`.
		  
		  For Each stmt As ObjoScript.Stmt In ast
		    Call stmt.Accept(ASTView)
		  Next stmt
		  
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


	#tag Property, Flags = &h0
		Compiler As ObjoScript.Compiler
	#tag EndProperty

	#tag Property, Flags = &h0
		Disassembler As ObjoScript.Disassembler
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
		  /// Compile the source code in `Code` and run it.
		  
		  Compile
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
