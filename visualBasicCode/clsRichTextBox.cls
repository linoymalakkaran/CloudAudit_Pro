VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRichTextBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private WithEvents oControl As RichTextLib.RichTextBox
Attribute oControl.VB_VarHelpID = -1
' The Event sequence is generally one of the following:
' movement/selection: KeyDown/MouseUp + SelChange
' editing: KeyDown + SelChange + Change
' drag/drop: SelChange + Change
' NB: with a sweeping select, where the mouse-up occurs outside the form, it is possible to select
' text without any SelChange event firing. We check for this at various places using CatchLostSelChange().
' Format of internal 'Long' key code
Private Const K_FLAGS As Integer = 16 'Bit offset from integer keycode to flags
Private Const Shift As Long = vbShiftMask * (2 ^ K_FLAGS)
Private Const CTRL As Long = vbCtrlMask * (2 ^ K_FLAGS)
Private Const ALT As Long = vbAltMask * (2 ^ K_FLAGS)

' Local event context, for deciphering what the user is doing
Private lSelStart0 As Long 'Previous selection status
Private lSelLength0 As Long
Private lSelStart1 As Long 'Current selection status
Private lSelLength1 As Long
Private lKeyCode As Long 'Most recent keycode (iKeyCode OR (iShift << K_FLAGS))
Private sLocalText As String 'Local text ahead-of or behind the cursor, or currently selected
Private lTextLen As Long 'Previous total text length (prior to current change)

' Saved selection context
Private iIgnoreEvents As Integer 'Whether to ignore events we're causing ourselves
Private lSaveSelStart As Long 'Previous .SelStart
Private lSaveSelLength As Long 'Previous .SelLength

Private Enum ChangeType
    CT_Typing = 1
    CT_Delete = 2
    CT_Paste = 3
    CT_Cut = 4
    CT_Move = 5 'Drag/drop text within control
    CT_Copy = 6 'Drag/drop text from elsewhere
End Enum

' UDT describing each text change
Private Type ChangeDesc
    eType As ChangeType 'Change type
    lSelStart0 As Long 'Initial selection status
    lSelLength0 As Long
    sDelete As String 'Text removed
    sInsert As String 'Text inserted
    lSelStart1 As Long 'Final selection status
    lSelLength1 As Long
End Type

' Undo/Redo stack
Private tUnDoStack() As ChangeDesc
Private lSPLast As Long 'Index of last entry added
Private lSPCurr As Long 'Index of current entry

' Notes about stack usage:-
' The Undo and Redo descriptions are stored on the same stack. This avoids having 2 stacks, and complex
' state handling for knowing which to update and when. Initially, SPLast and SPCurr are both -1. As change
' descriptions are pushed, they both increment in unison. If a change in undone then SPCurr steps back. You
' can undo changes until SPCurr goes below 0, or redo them until it gets back up to SPLast. Whenever a new
' change is pushed, SPLast is set to SPCurr beforehand.

Public Sub WatchControl(oRtb As Control)
    'Watches events on the specified RichTextBox, maintains an "Undo" stack for Text changes
    ClearDown
    Set oControl = oRtb
    lTextLen = Len(oControl.Text)
End Sub

Private Sub ClearDown()
    'Initialises class variables to a base state
    Set oControl = Nothing
    lSPCurr = -1
    lSPLast = -1
    lSelStart0 = 0
    lSelLength0 = 0
End Sub

Private Sub Class_Initialize()
    ClearDown
    ReDim tUnDoStack(0 To UNDO_SIZE - 1)
End Sub

Private Sub Class_Terminate()
    Set oControl = Nothing
End Sub

Public Function CanPaste() As Boolean
    'Tests whether there is text data that can be pasted from the clipboard
    Const EM_CANPASTE = (WM_USER + 50)
    CanPaste = (SendMessage(oControl.hwnd, EM_CANPASTE, vbCFText, 0) <> 0)
End Function

Public Function CanCopy() As Boolean
    'Tests whether a selected range is available for a Copy, or Cut, operation
    CanCopy = (oControl.SelLength > 0)
End Function

Public Function CanUndo() As Boolean
    'Tests whether there are text changes that can be undone
    CanUndo = (lSPCurr >= 0)
End Function

Public Function CanRedo() As Boolean
    'Tests whether there are previously undone text changes that can be re-done
    CanRedo = (lSPCurr < lSPLast)
End Function

Private Function DecodeType(eType As ChangeType) As String
    'Decodes a change type and returns a descriptive term
    Select Case eType
    Case CT_Typing: DecodeType = "Typing"
    Case CT_Delete: DecodeType = "Delete"
    Case CT_Paste: DecodeType = "Paste"
    Case CT_Cut: DecodeType = "Cut"
    Case CT_Move: DecodeType = "Move"
    Case CT_Copy: DecodeType = "Copy"
    End Select
End Function

Public Function UndoType() As String
    'Returns a description of the next "undo" type
    If CanUndo() Then
        UndoType = "Undo " & DecodeType(tUnDoStack(lSPCurr).eType)
    Else
        UndoType = "Can't Undo"
    End If
End Function

Public Function RedoType() As String
    'Returns a description of the next "redo" type
    If CanRedo() Then
        RedoType = "Redo " & DecodeType(tUnDoStack(lSPCurr + 1).eType)
    Else
        RedoType = "Can't Redo"
    End If
End Function

Private Sub DumpStack()
    'Diagnostic procedure for showing the contents of the undo stack
    Dim lEntry As Long, sSP As String
    Debug.Print "Undo stack..."
    For lEntry = lSPLast To 0 Step -1
        sSP = IIf(lEntry = lSPCurr, vbTab & "<-- Curr", "")
        With tUnDoStack(lEntry)
            Debug.Print "(" & CStr(lEntry) & ") = " & DecodeType(.eType) & " (Del=""" & _
                .sDelete & """, Ins=""" & .sInsert & """)" & sSP
            Debug.Print "lDel="; Len(.sDelete); ", lIns="; Len(.sInsert) '??
        End With
    Next lEntry
End Sub

Private Sub PushChange(eType As ChangeType, sDelete As String, sInsert As String)
    ' Records a new textual change on the undo stack
    ' Attempt to merge multiple instances of typing. These have to be consecutive, both in
    ' terms of screen position and the operations being recorded.
    If eType = CT_Typing And Len(sDelete) = 0 Then
        If lSPCurr >= 0 And lSPLast = lSPCurr Then
            With tUnDoStack(lSPCurr)
                If .eType = eType And .lSelStart1 = lSelStart0 Then
                    .sInsert = .sInsert & sInsert
                    .lSelStart1 = lSelStart1
                    DumpStack
                    Exit Sub
                End If
            End With
        End If
    End If
    ' No merging possible. Record a new stack entry. NB: this cancels any previous "redo" possibilities
    lSPCurr = lSPCurr + 1
    lSPLast = lSPCurr
    If lSPCurr > UBound(tUnDoStack) Then
        ReDim Preserve tUnDoStack(0 To UBound(tUnDoStack) + UNDO_INCR)
    End If
    With tUnDoStack(lSPCurr)
        .eType = eType
        .lSelStart0 = lSelStart0
        .lSelLength0 = lSelLength0
        .sDelete = sDelete
        .sInsert = sInsert
        .lSelStart1 = lSelStart1
        .lSelLength1 = lSelLength1
    End With
    DumpStack
End Sub

Private Sub ApplyChange(lEntry As Long)
    ' Re-apply the change associated with the specified entry on the undo stack
    Dim lInsert As Long, lDelete As Long
    With tUnDoStack(lEntry)
        Select Case .eType
        Case CT_Typing, CT_Paste, CT_Copy, CT_Move
            lInsert = Len(.sInsert)
            lDelete = Len(.sDelete)
            If lDelete > 0 Then
                oControl.SelStart = .lSelStart0
                oControl.SelLength = lDelete
                oControl.SelText = ""
            End If
            If .lSelLength1 = 0 Then
                oControl.SelStart = .lSelStart1 - lInsert
            Else
                oControl.SelStart = .lSelStart1
                Debug.Assert (lInsert = .lSelLength1)
            End If
            oControl.SelText = .sInsert
        Case CT_Delete, CT_Cut
            lDelete = Len(.sDelete)
            oControl.SelStart = IIf(.lSelStart0 < .lSelStart1, .lSelStart0, .lSelStart1)
            oControl.SelLength = lDelete
            oControl.SelText = ""
        End Select
        ' Set a new selection status to be restored later
        lSaveSelStart = .lSelStart1
        lSaveSelLength = .lSelLength1
        lSelStart1 = lSaveSelStart
        lSelLength1 = lSaveSelLength
    End With
End Sub

Private Sub UndoChange(lEntry As Long)
    ' Undo the change associated with the specified entry on the undo stack
    Dim lInsert As Long, lDelete As Long
    With tUnDoStack(lEntry)
        Select Case .eType
        Case CT_Typing, CT_Paste, CT_Copy, CT_Move
            lInsert = Len(.sInsert)
            lDelete = Len(.sDelete)
            If .lSelLength1 = 0 Then
                oControl.SelStart = .lSelStart1 - lInsert
            Else
                oControl.SelStart = .lSelStart1
                Debug.Assert (lInsert = .lSelLength1)
            End If
            oControl.SelLength = lInsert
            oControl.SelText = ""
            If lDelete > 0 Then
                oControl.SelStart = .lSelStart0
                oControl.SelText = .sDelete
            End If
        Case CT_Delete, CT_Cut
            oControl.SelStart = IIf(.lSelStart0 < .lSelStart1, .lSelStart0, .lSelStart1)
            oControl.SelText = .sDelete
        End Select
        ' Set a new selection status to be restored later
        lSaveSelStart = .lSelStart0
        lSaveSelLength = .lSelLength0
        lSelStart1 = lSaveSelStart
        lSelLength1 = lSaveSelLength
    End With
End Sub

Public Sub Cut()
    ' Cut any currently selected text and hold it on the clipboard
    Const WM_CUT As Long = &H300
    CatchLostSelChange
    lKeyCode = CTRL + vbKeyX
    SendMessage oControl.hwnd, WM_CUT, 0, 0
End Sub

Public Sub Copy()
    ' Copy any currently selected text onto the clipboard
    Const WM_COPY As Long = &H301
    lKeyCode = CTRL + vbKeyC
    SendMessage oControl.hwnd, WM_COPY, 0, 0
End Sub

Public Sub Paste()
    ' Paste any text currently held on the clipboard
    Const WM_PASTE As Long = &H302
    CatchLostSelChange
    lKeyCode = CTRL + vbKeyV
    SendMessage oControl.hwnd, WM_PASTE, 0, 0
End Sub

Public Sub Undo()
    ' Undo the previous change, if possible
    If CanUndo() Then
        bSaveSelection
        On Error GoTo ErrHandler
        UndoChange lSPCurr
        lSPCurr = lSPCurr - 1
        RestoreSelection
        DumpStack
    End If
Exit Sub
ErrHandler:
    ' Cleanup before reporting error
    RestoreSelection
    MsgBox Err.Description, vbExclamation
End Sub

Public Sub ReDo()
    ' Re-apply the previously undone change, if possible
    If CanRedo() Then
        bSaveSelection
        On Error GoTo ErrHandler
        lSPCurr = lSPCurr + 1
        ApplyChange lSPCurr
        RestoreSelection
        DumpStack
    End If
Exit Sub
ErrHandler:
    ' Cleanup before reporting error
    RestoreSelection
    MsgBox Err.Description, vbExclamation
End Sub

Private Sub EmptySysUndo()
    ' Empties the one-level undo buffer associated with the control. This prevents the default handling of
    ' keys such as ^Z/^Y competing with our own undo/redo support.
    Const EM_EMPTYUNDOBUFFER As Long = &HCD
    SendMessage oControl.hwnd, EM_EMPTYUNDOBUFFER, 0, 0
End Sub


Private Sub CatchLostSelChange()
    ' It is possible to cause a text selection but without the SelChange event firing (see module
    ' header comments). This procedure is called at various places to spot a lost SelChange event and
    ' to make amends.
    If oControl.SelStart <> lSelStart1 Or oControl.SelLength <> lSelLength1 Then
        Debug.Print "Caught lost SelChange"
        RecordSelChange
    End If
End Sub

Private Sub RecordSelChange()
    ' Records the details of a change in selection
    With oControl
        lSelStart0 = lSelStart1
        lSelLength0 = lSelLength1
        lSelStart1 = .SelStart
        lSelLength1 = .SelLength
        If lSelLength1 > 0 Then sLocalText = .SelText
    End With
End Sub

Public Function CharIndexFromLine(ByVal lLine As Long) As Long
    ' Returns the character index (0-based) for the start of the specified line (0-based).
    ' Returns -1 if no such line.
    Const EM_LINEINDEX = &HBB
    If lLine < 0 Then
        CharIndexFromLine = -1
    Else
        CharIndexFromLine = SendMessage(oControl.hwnd, EM_LINEINDEX, lLine, 0)
    End If
End Function

Public Function LineFromCharIndex(ByVal lCharIndex As Long) As Long
    ' Returns the line number (0-based) of the specified character index (0-based). Returns -1 if
    ' there's no such character.
    If lCharIndex < 0 Then
        LineFromCharIndex = -1
    Else
        LineFromCharIndex = oControl.GetLineFromChar(lCharIndex)
    End If
End Function

Public Function LineLength(ByVal lCharIndex As Long)
    ' Returns the line length of the line corresponding to the specified character index. The length
    ' includes only the text of the line, not any terminating CRLF
    Const EM_LINELENGTH = &HC1
    If lCharIndex < 0 Then Err.Raise 5
    LineLength = SendMessage(oControl.hwnd, EM_LINELENGTH, lCharIndex, 0)
End Function

Public Sub LineSpan(ByVal lCharIndex As Long, ByRef lBOL As Long, ByRef lEOL As Long)
    ' Returns the span of the line containing the specified character index. An index of -1 => current line.
    ' Bol is the first character index. lEol is the last character index+1. lEol=lBol if the line is empty.
    Dim lLine As Long
    If lCharIndex < -1 Then Err.Raise 5
    If lCharIndex < 0 Then lCharIndex = oControl.SelStart
    lLine = LineFromCharIndex(lCharIndex)
    lBOL = CharIndexFromLine(lLine)
    lEOL = lBOL + LineLength(lBOL)
End Sub

Private Sub SaveAhead()
    ' Saves a copy of the text forwards from the cursor on the current line. This is to facilitate
    ' recording a 'delete word forwards' operation
    Dim lBOL As Long, lEOL As Long
    With oControl
        LineSpan .SelStart, lBOL, lEOL
        .SelLength = lEOL - .SelStart + 2
        sLocalText = .SelText
    End With
End Sub

Private Sub SaveBehind()
    ' Saves a copy of the text backwards from the cursor on the current line. This is to facilitate
    ' recording a 'delete word backwards' operation
    Dim lBOL As Long, lEOL As Long, lLen As Long
    With oControl
        LineSpan .SelStart, lBOL, lEOL
        lLen = .SelStart - lBOL
        If lBOL > 0 Then
            lBOL = lBOL - 2: lLen = lLen + 2
        End If
        .SelStart = lBOL
        .SelLength = lLen
        sLocalText = .SelText
    End With
End Sub

Private Function bSaveSelection() As Boolean
    ' Saves the current visible selection, and temporarily disables handling any further events. This is
    ' typically done just before we start recording or applying a text change ourselves. It may be recursed.
    ' The return value indicates whether event handling was previously enabled.
    ' If events currently not disabled, save visible context
    If iIgnoreEvents = 0 Then
        With oControl
            lSaveSelStart = .SelStart
            lSaveSelLength = .SelLength
        End With
        bSaveSelection = True
    End If
    ' Disable event handling
    iIgnoreEvents = iIgnoreEvents + 1
End Function

Private Sub RestoreSelection()
    ' Restores the current visible selection, and re-enables event handling. This is typically done just
    ' after we have finished recording or applying a text change. It may be recursed
    ' If handling restored, restore visible context
    If iIgnoreEvents = 1 Then
        With oControl
            .SelStart = lSaveSelStart
            .SelLength = lSaveSelLength
        End With
    End If
    ' Re-enable event handling. NB: Cannot do this first as restoring the visible context will
    ' deliver further events
    iIgnoreEvents = iIgnoreEvents - 1
End Sub

Private Sub oControl_Change()
    ' A data change has occurred in the control. If some fool has pasted an OLE object into our text-only
    ' edit window then remove it, otherwise record the change on the undo stack
    If bSaveSelection() Then
        On Error GoTo ErrHandler
        With oControl
            If .OLEObjects.Count > 0 Then
                Debug.Print "**** Inserted object"
                ' Remove the OLE object
                .OLEObjects.Clear
                ' Reset the character position, and any replaced text
                .SelStart = lSelStart0
                If lSelLength0 > 0 Then .SelText = sLocalText
                ' Set a new selection status to be restored later
                lSaveSelStart = lSelStart0
                lSaveSelLength = lSelLength0
                lSelStart1 = lSaveSelStart
                lSelLength1 = lSaveSelLength
            Else
                Debug.Print "Change: TextLen="; Len(.Text)
                DoChange
                lTextLen = Len(.Text)
            End If
        End With
    End If
    RestoreSelection
    ' Make sure there's nothing that the control can undo by itself, without us
    EmptySysUndo
Exit Sub
ErrHandler:
    ' Cleanup before reporting error
    RestoreSelection
    MsgBox Err.Description, vbExclamation
End Sub

Private Sub oControl_KeyDown(iKeyCode As Integer, iShift As Integer)
    ' A key has been pressed in the control. Record the keystroke, and perform any actions that are
    ' appropriate when just seeing the key depressed.
    CatchLostSelChange
    If bSaveSelection() Then
        On Error GoTo ErrHandler
        Debug.Print "KeyDown: KeyCode="; iKeyCode; ", Shift="; iShift
        lKeyCode = iKeyCode Or ((iShift And (vbCtrlMask Or vbShiftMask Or vbAltMask)) * (2 ^ K_FLAGS))
        DoKey
    End If
    RestoreSelection
Exit Sub
ErrHandler:
    ' Cleanup before reporting error
    RestoreSelection
    MsgBox Err.Description, vbExclamation
End Sub

Private Sub oControl_SelChange()
    ' The current selection point has changed in the control. Keep track of it
    If bSaveSelection() Then
        Debug.Print "SelChange: SelStart="; oControl.SelStart; ", SelLength="; oControl.SelLength; ", TextLen="; Len(oControl.Text)
        RecordSelChange
    End If
    RestoreSelection
End Sub

Private Sub DoKey()
    ' Look at the current keystroke. Some keys must be acted upon as soon as they 're seen as there will
    ' be no subsequent Change event to call DoChange() from.
    Select Case lKeyCode
    Case 0
    Case vbKeyDelete
        If lSelLength1 = 0 Then SaveAhead
    Case CTRL + vbKeyDelete
        If lSelLength1 = 0 Then SaveAhead
    Case vbKeyBack
        If lSelLength1 = 0 Then SaveBehind
    Case CTRL + vbKeyBack
        If lSelLength1 = 0 Then SaveBehind
    Case CTRL + vbKeyC, CTRL + vbKeyInsert
        Debug.Print "**** Copy"
        ' No Change event will be raised for this operation
    Case CTRL + vbKeyV, Shift + vbKeyInsert
    Case CTRL + vbKeyX, Shift + vbKeyDelete
    Case CTRL + vbKeyZ, ALT + vbKeyBack
        Debug.Print "**** Undo"
        Undo
    Case CTRL + vbKeyY, CTRL + Shift + vbKeyZ, ALT + Shift + vbKeyBack
        Debug.Print "**** ReDo"
        ReDo
    Case Else
    End Select
End Sub

Private Sub DoChange()
    ' A textual change has occurred. Decipher how and what it did, and then record it on our undo stack
    Dim lLen As Long
    CatchLostSelChange
    Debug.Print "DoChange: SelStart(SelLength) = " & CStr(lSelStart0) & "(" & CStr(lSelLength0) & _
        ") -> "; CStr(lSelStart1) & "(" & CStr(lSelLength1) & ")"
    Select Case lKeyCode
    Case 0
        If lSelLength0 > 0 And lSelLength1 = lSelLength0 Then
            Debug.Print "**** Move within control"
            PushChange CT_Move, sLocalText, sLocalText
        Else
            ' Drag and drop from external source always inserts, never replaces any selected range.
            ' Also, any previous selected location is irrelevant since the hover cursor was used.
            ' Hence we must simulate one
            Debug.Print "**** Copy in from elsewhere"
            lLen = Len(oControl.Text) - lTextLen
            lSelStart0 = lSelStart1 - lLen
            lSelLength0 = 0
            oControl.SelStart = lSelStart0
            oControl.SelLength = lLen
            PushChange CT_Copy, "", oControl.SelText
        End If
    Case vbKeyDelete
        If lSelLength0 > 0 Then
            Debug.Print "**** Delete range"
            PushChange CT_Delete, sLocalText, ""
        Else
            Debug.Print "**** Delete character forwards"
            PushChange CT_Delete, Left$(sLocalText, lTextLen - Len(oControl.Text)), ""
        End If


    Case CTRL + vbKeyDelete
        Debug.Print "**** Delete word forwards"
        PushChange CT_Delete, Left$(sLocalText, lTextLen - Len(oControl.Text)), ""
    Case vbKeyBack
        If lSelLength0 > 0 Then
            Debug.Print "**** Delete range"
            PushChange CT_Delete, sLocalText, ""
        Else
            Debug.Print "**** Delete character backwards"
            PushChange CT_Delete, Right$(sLocalText, lSelStart0 - lSelStart1), ""
        End If
    Case CTRL + vbKeyBack
        Debug.Print "**** Delete word backwards"
        PushChange CT_Delete, Right$(sLocalText, lSelStart0 - lSelStart1), ""
    Case CTRL + vbKeyC, CTRL + vbKeyInsert
        ' Already handled in DoKey
    Case CTRL + vbKeyV, Shift + vbKeyInsert
        oControl.SelStart = lSelStart0
        oControl.SelLength = lSelStart1 - lSelStart0
        If lSelLength0 > 0 Then
            Debug.Print "**** Paste with replacement"
            PushChange CT_Paste, sLocalText, oControl.SelText
        Else
            Debug.Print "**** Paste"
            PushChange CT_Paste, "", oControl.SelText
        End If
    Case CTRL + vbKeyX, Shift + vbKeyDelete
        Debug.Print "**** Cut"
        PushChange CT_Cut, sLocalText, ""
    Case CTRL + vbKeyZ, ALT + vbKeyBack
        ' Already handled in DoKey
    Case CTRL + vbKeyY, CTRL + Shift + vbKeyZ, ALT + Shift + vbKeyBack
        ' Already handled in DoKey
    Case Else
        oControl.SelStart = lSelStart0
        oControl.SelLength = lSelStart1 - lSelStart0
        If lSelLength0 > 0 Then
            Debug.Print "**** Replacement by character"
            PushChange CT_Typing, sLocalText, oControl.SelText
        Else
            Debug.Print "**** Character insertion"
            PushChange CT_Typing, "", oControl.SelText
        End If
    End Select
    ' Erase record of this keystroke now
    lKeyCode = 0
End Sub
