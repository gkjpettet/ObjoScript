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
      Left            =   1080
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
   Begin DesktopListBox TokensListbox
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
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
      Height          =   655
      Index           =   -2147483648
      InitialValue    =   "Type	Line	Abs Pos	Value	ID"
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   617
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
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
   Begin DesktopButton ButtonParse
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Parse"
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
      Scope           =   2
      TabIndex        =   5
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
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 446973706C6179732064657461696C732061626F75742061206C6578657220657863657074696F6E20696E2074686520496E666F206C6162656C2E
		Sub DisplayLexerError(e As ObjoScript.LexerException)
		  /// Displays details about a lexer exception in the Info label.
		  
		  Info.Text = e.LineNumber.ToString + ", " + e.LineCharacterPosition.ToString + ": " + e.Message
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  Code.Text = ""
		  TokensListbox.RemoveAllRows
		  Info.Text = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 557064617465732074686520746F6B656E73206C697374626F78207769746820746865207061737365642060746F6B656E73602E
		Sub UpdateTokensListbox(tokens() As ObjoScript.Token)
		  /// Updates the tokens listbox with the passed `tokens`.
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


#tag EndWindowCode

#tag Events ButtonClear
	#tag Event
		Sub Pressed()
		  Reset
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonParse
	#tag Event
		Sub Pressed()
		  TokensListbox.RemoveAllRows
		  
		  Var tokens() As ObjoScript.Token
		  
		  Var lexer As New ObjoScript.Lexer
		  Var parser As New ObjoScript.Parser
		  Var ast() As ObjoScript.Stmt
		  
		  Try
		    tokens = lexer.Tokenise(Code.Text)
		    UpdateTokensListbox(tokens)
		    
		    Info.Text = "Successfully tokenised."
		    
		    ast = parser.Parse(tokens)
		    
		  Catch e As ObjoScript.LexerException
		    DisplayLexerError(e)
		  End Try
		  
		End Sub
	#tag EndEvent
#tag EndEvents
