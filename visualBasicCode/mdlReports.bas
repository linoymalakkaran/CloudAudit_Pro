Attribute VB_Name = "mdlReports"
Option Explicit

Public pblnIsInsideSelChangeEvent As Boolean
Public Const pcnstRptParamSep = "¦"

Public Const grdConfigureTitle As Byte = 0
Public Const grdConfigureObjTypeID As Byte = 1
Public Const grdConfigureType As Byte = 2
Public Const grdConfigureDescription As Byte = 3
Public Const grdConfigureTableID As Byte = 4
Public Const grdConfigureAcTypeID As Byte = 5
Public Const grdConfigureAcTypeName As Byte = 6
Public Const grdConfigureData As Byte = 7
Public Const grdConfigureOrientation As Byte = 8
Public Const grdConfigureParentSlNo As Byte = 9
Public Const grdConfigureLevelNo As Byte = 10
Public Const cnstConfigureCols As Byte = 11

Public Enum ReportObjectTypes
    objtpText = 1
    objtpTable = 2
    objtpDiagram = 3
    objtpPicture = 4
    objtpPageBreak = 5
    objtpLine = 6
    objtpRectangle = 7
    objtpOval = 8
End Enum

Public Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal hWnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

' Clipboard messages
Public Const WM_COPY As Long = &H301
Public Const WM_CUT As Long = &H300
Public Const WM_PASTE As Long = &H302

Public Const WM_USER As Long = &H400
Private Const WM_NOTIFY = &H4E
Private Const WM_SETTEXT = &HC

Private Const CFM_BACKCOLOR = &H4000000
Private Const CFE_AUTOBACKCOLOR = CFM_BACKCOLOR
Private Const CFM_UNDERLINETYPE = 8388608

Private Const EC_LEFTMARGIN = &H1
Private Const EC_RIGHTMARGIN = &H2
Private Const EC_USEFONTINFO = &HFFFF&
Private Const EM_SETMARGINS = &HD3&
Private Const EM_GETMARGINS = &HD4&

Private Const EM_SETTYPOGRAPHYOPTIONS = WM_USER + 202
Private Const EM_GETTYPOGRAPHYOPTIONS = WM_USER + 203
Private Const EM_GETEVENTMASK = WM_USER + 59
Private Const EM_GETCHARFORMAT = WM_USER + 58
Private Const EM_GETPARAFORMAT = WM_USER + 61
Public Const EM_REQUESTRESIZE = WM_USER + 65
Private Const EM_SETBKGNDCOLOR = WM_USER + 67
Private Const EM_SETCHARFORMAT = WM_USER + 68
Private Const EM_SETEVENTMASK = WM_USER + 69
Private Const EM_SETPARAFORMAT = WM_USER + 71
Private Const EM_PASTE = &H302
Private Const EM_LINEFROMCHAR = &HC9
Private Const EM_LINEINDEX = &HBB
Private Const EM_GETLINECOUNT = &HBA
Private Const EM_LINESCROLL = &HB6
Private Const EM_LINELENGTH = &HC1

Private Const EN_REQUESTRESIZE = &H701
Private Const ENM_REQUESTRESIZE As Long = &H40000

Private Const GWL_WNDPROC = (-4)

Private Const PFA_LEFT = 1
Private Const PFA_RIGHT = 2
Private Const PFA_CENTER = 3
Private Const PFA_JUSTIFY = &H4

Private Const PFM_ALIGNMENT = &H8&
Private Const PFM_LINESPACING = &H100

Private Const SCF_SELECTION = &H1&

Private Const SWP_SHOWWINDOW = &H40
Private Const SWP_NOMOVE = &H2

Private Const LF_FACESIZE = 32
    
Private Const TO_ADVANCEDTYPOGRAPHY = 1

Public Const UNDO_SIZE As Long = 20 'Initial stack size
Public Const UNDO_INCR As Long = 5 'Stack increment size

Public Const VBNullPtr = 0&

Private Const MAX_TAB_STOPS = 32

Private Type nmhdr
   hwndFrom As Long
   idfrom As Long
   code As Long
End Type

Private Type REQSIZE
   nmhdr As nmhdr
   RECT As RECT
End Type

Private rResize As REQSIZE ' <--- Pointer to REQSIZE Structure
Private MaskHdr As nmhdr   ' <--- Pointer to nmhdr Structure

Private Type PARAFORMAT2
    cbSize As Long
    dwMask As Long
    wNumbering As Integer
    wEffects As Integer
    dxStartIndent As Long
    dxRightIndent As Long
    dxOffset As Long
    wAlignment As Integer
    cTabCount As Integer
    rgxTabs(MAX_TAB_STOPS - 1) As Long
    dySpaceBefore As Long
    dySpaceAfter As Long
    dyLineSpacing As Long
    sStyle As Integer
    bLineSpacingRule As Byte
    bOutlineLevel As Byte
    wShadingWeight As Integer
    wShadingStyle As Integer
    wNumberingStart As Integer
    wNumberingStyle As Integer
    wNumberingTab As Integer
    wBorderSpace As Integer
    wBorderWidth As Integer
    wBorders As Integer
End Type

Private Type CharFormat2
    cbSize As Long
    dwMask As Long
    dwEffects As Long
    yHeight As Long
    yOffset As Long
    crTextColor As Long
    bCharSet As Byte
    bPitchAndFamily As Byte
    szFaceName As String * 32
    wPad2 As Integer
    wWeight As Integer
    sSpacing As Integer
    crBackColor As Long
    LCID As Long
    dwReserved As Long
    sStyle As Integer
    wKerning As Integer
    bUnderlineType As Byte
    bAnimation As Byte
    bRevAuthor As Byte
    bReserved1 As Byte
End Type

Public Enum ERECParagraphAlignmentConstants
    ercParaLeft = PFA_LEFT
    ercParaCentre = PFA_CENTER
    ercParaRight = PFA_RIGHT
    ercParaJustify = PFA_JUSTIFY
End Enum

Public Enum LineSpacingRules
    lnspSingle = 0
    lnspOneAndAHalf = 1
    lnspDouble = 2
    lnspCustom1 = 3
    lnspCustom2 = 4
    lnspCustom3 = 5
End Enum

Public Enum ReportTableProperties
    rptTblBackColor = 0
    rptTblForeColor = 1
    rptTblColWidth = 2
    rptTblUnderline = 3
    rptTblIsBold = 4
    rptTblFontSize = 5
    rptTblIsItalic = 6
    rptTblAlignment = 7
    rptTblFontName = 8
    rptTblRowHeight = 9
    rptTblText = 10
    rptTblColSpan = 11
    rptTblRowSpan = 12
    rptTblCols = 13             'total updatable table properties columns
    rptTblRows = 14
End Enum

Public Const cnstRptTblPropertyCount = 13

Public Enum ReportTableTypes
    rptTTCustomTable = 1
    rptTTTableOfContents = 2
    rptTTGeneralSchedule = 3
    rptTTSplitSchedule = 4
    rptTTFixedAssetsSchedule = 5
    rptTTEquitySchedule = 6
    rptTTBalanceSheet = 7
    rptTTCashFlow = 8
    rptTTProfitAndLoss = 9
    rptTTCashEquivalents = 10
    rptTTLiabilitySchedule = 11
    rptTTSchedules = 12
End Enum

Public Enum ReportTypes
    rptTypeAuditReport = 1
    rptTypeTemplate = 2
    rptTypeTemporary = 3
End Enum

Public Enum ReportObjectProperties
    rptObjTypeID = 0
    rptObjName = 1
    rptObjTextRtf = 2
    rptObjPaperSize = 3
    rptObjMarginLeft = 4
    rptObjMarginTop = 5
    rptObjMarginRight = 6
    rptObjMarginBottom = 7
    rptObjOrientation = 8
    rptObjypeID = 9
    rptObjLeft = 10
    rptObjX1 = 10 'for line object only
    rptObjTop = 11
    rptObjY1 = 11 'for line object only
    rptObjWidth = 12
    rptObjX2 = 12 'for line object only
    rptObjHeight = 13
    rptObjY2 = 13 'for line object only
    rptObjBorderTypeID = 14
    rptObjNoOfRows = 15
    rptObjNoOfCols = 16
    rptObjTableTypeID = 17
    rptObjAcTypeID = 18
    rptObjTableTypeName = 19
    rptObjAcTypeName = 20
    rptObjGridColCount = 21
    rptObjPicture = 21 'for picture object only
End Enum

Public Enum UnderlineStyle
    usNone = 0 'No underlining.
    usNormal = 1 'Standard underlining across all words.
    usWord = 2 'Standard underlining broken between words.
    usDouble = 3 'Double line underlining.
    usDotted = 4 'Dotted underlining.
    usDash = 5 'Dashed underlining.
    usDashDot = 6 'Dash-dot ("-.-.") underlining.
    usDashDotDot = 7 'Dash-dot-dot ("-..-..") underlining.
    usWave = 8 'Wave underlining (like spelling mistakes in MS Word).
    usThick = 9 'Extra thick standard underlining.
    usHairLine = 10 'Extra thin standard underlining.
    usDoubleWave = 11 'Double thickness wave underlining.
    usHeavyWave = 12 'Thick wave underlining.
    usLongDash = 13 'Extra long dash underlining.
End Enum

Public Enum UnderlineColor
    uclrBlack = &H0
    uclrBlue = &H10
    uclrCyan = &H20
    uclrLimeGreen = &H30
    uclrMagenta = &H40
    uclrRed = &H50
    uclrYellow = &H60
    uclrWhite = &H70
    uclrDarkBlue = &H80
    uclrDarkCyan = &H90
    uclrGreen = &HA0
    uclrDarkMagenta = &HB0
    uclrBrown = &HC0
    uclrOliveGreen = &HD0
    uclrDarkGray = &HE0
    uclrGray = &HF0
End Enum

Private mlngOldWndProc As Long
Public plngActiveCntrlHeightMax As Long
Public plngActiveCntrlWidth As Long
Public plngActiveCntrlHWnd As Long
Public pblnIsInSetTextStyle As Boolean
Public Const pcnstHeadingChar = 183
'Public Const pcnstColWidthRatioFromGridToPrint = 1 '0.8905
'Public Const pcnstRowHeightRatioFromGridToPrint = 1
Public Const pcnstTagStart = "<"
Public Const pcnstTagEnd = ">"

Public Enum RGBValues
    rgbRed = 1
    rgbGreen = 2
    rgbBlue = 3
End Enum

Public Enum MarginTypes
    mtLeftMargin = EC_LEFTMARGIN
    mtRightMargin = EC_RIGHTMARGIN
End Enum

Public Enum ReportGeneratorObjectTypes
    RGObjCommonPageHeader = 1
    RGObjFrontPage = 2
    RGObjTableOfContents = 3
    RGObjIndependentAuditorsReport = 4
    RGObjBalanceSheet = 5
    RGObjStatementOfIncome = 6
    RGObjShareholdersEquity = 7
    RGObjCashFlows = 8
    RGObjNotesToTheFinancialStatements = 9
    RGObjSubHeading = 10
    RGObjHeader = 11
    RGObjText = 12
    RGObjTable = 13
End Enum

Public Enum PreviewTypes
    pvtPreview = 0
    pvtPrint = 1
    pvtTesting = 2
End Enum

'Multiple undo redo start
'// View Types
Public Enum ERECViewModes
    ercDefault = 0
    ercWordWrap = 1
    ercWYSIWYG = 2
End Enum

'// Undo Types
Public Enum ERECUndoTypeConstants
    ercUID_UNKNOWN = 0
    ercUID_TYPING = 1
    ercUID_DELETE = 2
    ercUID_DRAGDROP = 3
    ercUID_CUT = 4
    ercUID_PASTE = 5
End Enum

'// Text Modes
Public Enum TextMode
    TM_PLAINTEXT = 1
    TM_RICHTEXT = 2 ' /* default behavior */
    TM_SINGLELEVELUNDO = 4
    TM_MULTILEVELUNDO = 8 ' /* default behavior */
    TM_SINGLECODEPAGE = 16
    TM_MULTICODEPAGE = 32 ' /* default behavior */
End Enum

Public Const EM_SETTEXTMODE = (WM_USER + 89)
Public Const EM_UNDO = &HC7
Public Const EM_REDO = (WM_USER + 84)
Public Const EM_CANPASTE = (WM_USER + 50)
Public Const EM_CANUNDO = &HC6&
Public Const EM_CANREDO = (WM_USER + 85)
Public Const EM_GETUNDONAME = (WM_USER + 86)
Public Const EM_GETREDONAME = (WM_USER + 87)

Public Property Get UndoType(ByRef rtfText As RichTextLib.RichTextBox) As ERECUndoTypeConstants
    UndoType = SendMessageLong(rtfText.hWnd, EM_GETUNDONAME, 0, 0)
End Property

Public Property Get RedoType(ByRef rtfText As RichTextLib.RichTextBox) As ERECUndoTypeConstants
    RedoType = SendMessageLong(rtfText.hWnd, EM_GETREDONAME, 0, 0)
End Property

Public Property Get CanPaste(ByRef rtfText As RichTextLib.RichTextBox) As Boolean
   CanPaste = SendMessageLong(rtfText.hWnd, EM_CANPASTE, 0, 0)
End Property

Public Property Get CanCopy(ByRef rtfText As RichTextLib.RichTextBox) As Boolean
   If rtfText.SelLength > 0 Then
      CanCopy = True
   End If
End Property

Public Property Get CanUndo(ByRef rtfText As RichTextLib.RichTextBox) As Boolean
    CanUndo = SendMessageLong(rtfText.hWnd, EM_CANUNDO, 0, 0)
End Property

Public Property Get CanRedo(ByRef rtfText As RichTextLib.RichTextBox) As Boolean
    CanRedo = SendMessageLong(rtfText.hWnd, EM_CANREDO, 0, 0)
End Property

'// Methods
Public Sub Undo(ByRef rtfText As RichTextLib.RichTextBox)
    SendMessageLong rtfText.hWnd, EM_UNDO, 0, 0
End Sub

Public Sub Redo(ByRef rtfText As RichTextLib.RichTextBox)
    SendMessageLong rtfText.hWnd, EM_REDO, 0, 0
End Sub

Public Sub Cut(ByRef rtfText As RichTextLib.RichTextBox)
   SendMessageLong rtfText.hWnd, WM_CUT, 0, 0
End Sub

Public Sub Copy(ByRef rtfText As RichTextLib.RichTextBox)
   SendMessageLong rtfText.hWnd, WM_COPY, 0, 0
End Sub

Public Sub Paste(ByRef rtfText As RichTextLib.RichTextBox)
   SendMessageLong rtfText.hWnd, WM_PASTE, 0, 0
End Sub

Public Sub Clear(ByRef rtfText As RichTextLib.RichTextBox)
   rtfText.SelText = Empty
End Sub

'// Returns the undo/redo type
Public Function TranslateUndoType(ByVal eType As ERECUndoTypeConstants) As String
    Select Case eType
        Case ercUID_UNKNOWN
           TranslateUndoType = "Last Action"
        Case ercUID_TYPING
           TranslateUndoType = "Typing"
        Case ercUID_PASTE
           TranslateUndoType = "Paste"
        Case ercUID_DRAGDROP
           TranslateUndoType = "Drag Drop"
        Case ercUID_DELETE
           TranslateUndoType = "Delete"
        Case ercUID_CUT
           TranslateUndoType = "Cut"
    End Select
End Function
'Multiple undo redo end

Public Sub SetAlignment(lhWnd As Long, ByVal eAlign As ERECParagraphAlignmentConstants)
Dim tP2 As PARAFORMAT2, lR As Long
    tP2.dwMask = PFM_ALIGNMENT
    tP2.cbSize = Len(tP2)
    tP2.wAlignment = eAlign
    lR = SendMessageLong(lhWnd, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY)
    lR = SendMessage(lhWnd, EM_SETPARAFORMAT, 0, tP2)
End Sub

Public Function GetAlignment(lhWnd As Long) As ERECParagraphAlignmentConstants
Dim tP2 As PARAFORMAT2, lR As Long
    tP2.dwMask = PFM_ALIGNMENT
    tP2.cbSize = Len(tP2)
    lR = SendMessageLong(lhWnd, EM_GETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY)
    lR = SendMessage(lhWnd, EM_GETPARAFORMAT, 0, tP2)
    GetAlignment = tP2.wAlignment
End Function

Public Function SetLineSpacing(lhWnd As Long, lnspLineSpacing As LineSpacingRules, Optional lngCustomLineSpacing As Long = 0)
Dim tP2 As PARAFORMAT2, lR As Long
    tP2.dwMask = PFM_LINESPACING
    tP2.cbSize = Len(tP2)
    tP2.bLineSpacingRule = lnspLineSpacing
    tP2.dyLineSpacing = lngCustomLineSpacing
    lR = SendMessageLong(lhWnd, EM_SETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY)
    lR = SendMessage(lhWnd, EM_SETPARAFORMAT, 0, tP2)
End Function

Public Function GetLineSpacing(lhWnd As Long, Optional lngCustomLineSpacing As Long = 0) As LineSpacingRules
Dim tP2 As PARAFORMAT2, lR As Long
    tP2.dwMask = PFM_LINESPACING
    tP2.cbSize = Len(tP2)
    lR = SendMessageLong(lhWnd, EM_GETTYPOGRAPHYOPTIONS, TO_ADVANCEDTYPOGRAPHY, TO_ADVANCEDTYPOGRAPHY)
    lR = SendMessage(lhWnd, EM_GETPARAFORMAT, 0, tP2)
    lngCustomLineSpacing = tP2.dyLineSpacing
    GetLineSpacing = tP2.bLineSpacingRule
End Function

Public Sub PastePicture(lnghWnd As Long, ipdPicture As IPictureDisp)
    Clipboard.SetData ipdPicture
    SendMessage lnghWnd, EM_PASTE, 0, 0
End Sub

Public Function GetSelBackColor(lnghWnd As Long) As Long
    ' We need to ask the RTB for the backcolor of the current selection.
    ' This is done using SendMessage with a format structure which the RTB will fill in for us.
Dim cfTmp As CharFormat2
    cfTmp.dwMask = CFM_BACKCOLOR
    cfTmp.cbSize = Len(cfTmp)
    SendMessage lnghWnd, EM_GETCHARFORMAT, SCF_SELECTION, cfTmp
    GetSelBackColor = cfTmp.crBackColor
End Function

Public Sub SetSelBackColor(lnghWnd As Long, ByVal lngColor As Long)
    ' Here we do relatively the same thing as in Get, but we are telling the RTB to set
    ' the color this time instead of returning it to us.
Dim cfTmp As CharFormat2
    cfTmp.crBackColor = lngColor
    cfTmp.dwMask = CFM_BACKCOLOR
    cfTmp.cbSize = Len(cfTmp)
    SendMessage lnghWnd, EM_SETCHARFORMAT, SCF_SELECTION, cfTmp
End Sub
        
Public Function GetTextStyle(ByRef rtbRichText As RichTextBox) As String
Dim lngPos As Long, strTextStyle As String
    strTextStyle = "Normal"
    With rtbRichText
        If .SelStart > 0 Then
            lngPos = InStr(.SelStart, .Text, vbCrLf)
            If lngPos = 0 Then
                lngPos = Len(.Text)
            Else
                lngPos = lngPos - 1
            End If
            If lngPos > 0 Then
                If Mid(.Text, lngPos, 1) = Chr(pcnstHeadingChar) Then
                    strTextStyle = "Heading"
                End If
            End If
        End If
    End With
    GetTextStyle = strTextStyle
End Function

Public Sub SetTextStyle(ByRef rtbRichText As RichTextBox, strTextStyle As String)
On Local Error Resume Next
Dim lngPos As Long, lngOldSelStart As Long, lngOldSelLength As Long
    If Not pblnIsInSetTextStyle Then
        pblnIsInSetTextStyle = True
        With rtbRichText
            lngPos = InStr(.SelStart, .Text, vbCrLf)
            If lngPos = 0 Then
                lngPos = Len(.Text)
            Else
                lngPos = lngPos - 1
            End If
            If lngPos > 0 Then
                lngOldSelStart = .SelStart
                lngOldSelLength = .SelLength
                If strTextStyle = "Heading" And Mid(.Text, lngPos, 1) <> Chr(pcnstHeadingChar) Then
                    .SelStart = lngPos
                    .SelLength = 0
                    .SelText = Chr(pcnstHeadingChar)
                ElseIf strTextStyle <> "Heading" And Mid(.Text, lngPos, 1) = Chr(pcnstHeadingChar) Then
                    .SelStart = lngPos - 1
                    .SelLength = 1
                    .SelText = Replace(.SelText, Chr(pcnstHeadingChar), "")
                End If
                .SelStart = lngOldSelStart
                .SelLength = lngOldSelLength
            End If
        End With
        pblnIsInSetTextStyle = False
    End If
End Sub

Public Function GetUnderlineStyle(ByVal lnghWnd As Long) As UnderlineStyle
Dim Fmt As CharFormat2
    Fmt.cbSize = Len(Fmt)
    SendMessage lnghWnd, EM_GETCHARFORMAT, SCF_SELECTION, Fmt
    If Fmt.dwMask And CFM_UNDERLINETYPE = 0 Then
        GetUnderlineStyle = usNone
    Else
        GetUnderlineStyle = Fmt.bUnderlineType Mod 16
    End If
End Function

Public Sub SetUnderlineStyle(ByVal lnghWnd As Long, usUnderlineStyle As UnderlineStyle)
Dim Fmt As CharFormat2, uclrColor As UnderlineColor
    Fmt.cbSize = Len(Fmt)
    uclrColor = GetUnderlineColor(lnghWnd)
    If usUnderlineStyle = usNone Then
        uclrColor = uclrBlack
    End If
    Fmt.dwMask = CFM_UNDERLINETYPE
    Fmt.bUnderlineType = usUnderlineStyle + uclrColor * 16
    SendMessage lnghWnd, EM_SETCHARFORMAT, SCF_SELECTION, Fmt
End Sub

Public Function GetUnderlineColor(ByVal lnghWnd As Long) As UnderlineColor
Dim Fmt As CharFormat2
    Fmt.cbSize = Len(Fmt)
    SendMessage lnghWnd, EM_GETCHARFORMAT, SCF_SELECTION, Fmt
    If Fmt.dwMask And CFM_UNDERLINETYPE = 0 Then
        GetUnderlineColor = uclrBlack
    Else
        GetUnderlineColor = (Fmt.bUnderlineType - (Fmt.bUnderlineType Mod 16))
    End If
End Function

Public Sub SetUnderlineColor(ByVal lnghWnd As Long, uclrColor As UnderlineColor)
Dim Fmt As CharFormat2, usStyle As UnderlineStyle
    Fmt.cbSize = Len(Fmt)
    usStyle = GetUnderlineStyle(lnghWnd)
    If usStyle = usNone Then
        uclrColor = uclrBlack
    End If
    Fmt.dwMask = CFM_UNDERLINETYPE
    Fmt.bUnderlineType = usStyle + (uclrColor * 16)
    SendMessage lnghWnd, EM_SETCHARFORMAT, SCF_SELECTION, Fmt
End Sub

Public Function GetLineCount(ByVal lnghWnd As Long) As Long
    GetLineCount = SendMessage(lnghWnd, EM_GETLINECOUNT, ByVal 0&, ByVal 0&)
End Function

Public Function GetLineStart(ByRef rtbText As RichTextBox) As Long
Dim lngLineNo As Long
    lngLineNo = rtbText.GetLineFromChar(rtbText.SelStart) + 1
    GetLineStart = SendMessage(rtbText.hWnd, EM_LINEINDEX, ByVal lngLineNo - 1, ByVal 0&)
End Function

Public Function GetLineLength(ByRef rtbText As RichTextBox) As Long
Dim lngLineStart As Long
    lngLineStart = GetLineStart(rtbText)
    GetLineLength = SendMessage(rtbText.hWnd, EM_LINELENGTH, ByVal lngLineStart, ByVal 0&)
End Function

Private Sub SetLeftRightMargin(ByVal mtMarginType As MarginTypes, ByVal lnghWnd As Long, ByVal lngMargin As Long)
    SendMessageLong lnghWnd, EM_SETMARGINS, mtMarginType, lngMargin
End Sub

'' Call SetWindowLong to instantiate the Window Procedure by passing the
'' Address of MyWndProc.
'Public Sub NewWindowProc(lngHWnd As Long)
'   On Local Error Resume Next
'   mlngOldWndProc = SetWindowLong(lngHWnd, GWL_WNDPROC, AddressOf MyWndProc)
'End Sub

'' Once the Hook is in place, All messages will be processed by this
'' function. Test for a WM_NOTIFY and parse the lParam to search for a
'' specific value. In this case we are looking for EN_REQUESTRESIZE in the
'' nmhdr structure. If an EN_REQUESTRESIZE is found then grab the next
'' structure(REQSIZE) from the lParam.
'Public Function MyWndProc(ByVal hwnd As Long, ByVal Msg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
'    On Local Error Resume Next
'    Select Case Msg
'    Case WM_NOTIFY
'         Call CopyMemory(MaskHdr, ByVal lParam, Len(MaskHdr))
'         If MaskHdr.code = EN_REQUESTRESIZE Then
'            Call CopyMemory(rResize, ByVal lParam, Len(rResize))
'            If rResize.rect.Bottom < plngActiveCntrlHeightMax Then
'                Call SetWindowPos(plngActiveCntrlHWnd, VBNullPtr, 0, 0, plngActiveCntrlWidth, rResize.rect.Bottom, SWP_SHOWWINDOW Or SWP_NOMOVE)
'            Else
'                Call SetWindowPos(plngActiveCntrlHWnd, VBNullPtr, 0, 0, plngActiveCntrlWidth, plngActiveCntrlHeightMax, SWP_SHOWWINDOW Or SWP_NOMOVE)
'            End If
'        End If
'    Case Else 'Handle other messages here.
'    End Select
'    'Reset windowproc
'    MyWndProc = CallWindowProc(mlngOldWndProc, hwnd, Msg, wParam, lParam)
'End Function

'Public Sub ResetWindProc(hwnd As Long)
'    On Error Resume Next
'    'Call SetWindowLong to remove the Windows Hook from app.
'    Call SetWindowLong(hwnd, GWL_WNDPROC, mlngOldWndProc)
'End Sub

'Public Sub SetMask(lngHWnd As Long)
'    On Local Error Resume Next
'    Dim lngCurrentMask As Long, lngNewMask As Long
'    'Set the Event Mask to be called.
'    lngCurrentMask = SendMessage(lngHWnd, EM_GETEVENTMASK, 0, 0)
'    lngNewMask = (lngCurrentMask Or ENM_REQUESTRESIZE)
'    Call SendMessage(lngHWnd, EM_SETEVENTMASK, 0, ENM_REQUESTRESIZE)
'End Sub

Public Function GetReportObjectName(ByVal ObjType As ReportObjectTypes) As String
    Select Case ObjType
        Case objtpText
            GetReportObjectName = "Text"
        Case objtpTable
            GetReportObjectName = "Table"
        Case objtpDiagram
            GetReportObjectName = "Diagram"
        Case objtpPicture
            GetReportObjectName = "Picture"
        Case objtpPageBreak
            GetReportObjectName = "Page Break"
        Case objtpLine
            GetReportObjectName = "Line"
        Case objtpRectangle
            GetReportObjectName = "Rectangle"
        Case objtpOval
            GetReportObjectName = "Oval"
    End Select
End Function

Public Function GetPrintAlignment(ByVal vsasAlignment As VSFlex8Ctl.AlignmentSettings) As VSPrinter8LibCtl.TextAlignSettings
    Select Case vsasAlignment
        Case flexAlignCenterBottom
            GetPrintAlignment = taCenterBottom
        Case flexAlignCenterCenter
            GetPrintAlignment = taCenterMiddle
        Case flexAlignCenterTop
            GetPrintAlignment = taCenterTop
        Case flexAlignLeftBottom
            GetPrintAlignment = taLeftBottom
        Case flexAlignLeftCenter
            GetPrintAlignment = taLeftMiddle
        Case flexAlignLeftTop
            GetPrintAlignment = taLeftTop
        Case flexAlignRightBottom
            GetPrintAlignment = taRightBottom
        Case flexAlignRightCenter
            GetPrintAlignment = taRightMiddle
        Case flexAlignRightTop
            GetPrintAlignment = taRightTop
    End Select
End Function

Public Function GetFlexGridAlignment(ByVal vspaAlignment As VSPrinter8LibCtl.TextAlignSettings) As VSFlex8Ctl.AlignmentSettings
    Select Case vspaAlignment
        Case taCenterBottom
            GetFlexGridAlignment = flexAlignCenterBottom
        Case taCenterMiddle
            GetFlexGridAlignment = flexAlignCenterCenter
        Case taCenterTop
            GetFlexGridAlignment = flexAlignCenterTop
        Case taLeftBottom
            GetFlexGridAlignment = flexAlignLeftBottom
        Case taLeftMiddle
            GetFlexGridAlignment = flexAlignLeftCenter
        Case taLeftTop
            GetFlexGridAlignment = flexAlignLeftTop
        Case taRightBottom
            GetFlexGridAlignment = flexAlignRightBottom
        Case taRightMiddle
            GetFlexGridAlignment = flexAlignRightCenter
        Case taRightTop
            GetFlexGridAlignment = flexAlignRightTop
    End Select
End Function

Public Function SQLDataTypeNumericDateStringImageOrBoolean(ByVal DataType As DataTypeEnum) As String
    Select Case DataType
        Case adBoolean
            'Boolean
            SQLDataTypeNumericDateStringImageOrBoolean = "B"
        Case adBigInt, adCurrency, adDecimal, adDouble, adEmpty, adError, adInteger, adNumeric, adSingle, adSmallInt, _
            adTinyInt, adUnsignedBigInt, adUnsignedInt, adUnsignedSmallInt, adUnsignedTinyInt, adVarNumeric
            'Numeric
            SQLDataTypeNumericDateStringImageOrBoolean = "N"
        Case adDate, adDBDate, adDBTime, adDBTimeStamp, adFileTime
            'Date
            SQLDataTypeNumericDateStringImageOrBoolean = "D"
        Case adBSTR, adChapter, adChar, adGUID, adLongVarChar, adLongVarWChar, _
            adPropVariant, adUserDefined, adVarChar, adVariant, adVarWChar, adWChar
            'String
            SQLDataTypeNumericDateStringImageOrBoolean = "S"
        Case adBinary, adIDispatch, adLongVarBinary, adVarBinary, adIUnknown
            'Image
            SQLDataTypeNumericDateStringImageOrBoolean = "I"
    End Select
End Function

Public Sub ShowTableInImmediateWindow(objObject As Object, Index As Long)
Dim RowInc As Long, ColInc As Long, strRow As String
    With objObject
        For RowInc = 0 To .Rows(Index) - 1
            strRow = ""
            For ColInc = 0 To .Cols(Index) - 1
                strRow = strRow & "|" & .TextMatrix(Index, RowInc, ColInc) & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab
            Next ColInc
            Debug.Print strRow
        Next RowInc
    End With
End Sub

Public Function GetSingleValueFromSQL(sSql As String) As String
On Local Error Resume Next
    GetSingleValueFromSQL = ""
    With GetRecords(sSql)
        If Not .BOF Then
            GetSingleValueFromSQL = .Fields(0).Value
        End If
        .Close
    End With
End Function

Public Function GetRGBValue(ByVal lngColor As Long, ByVal rgbValue As RGBValues) As Integer
    If rgbValue > 0 And rgbValue < 4 And lngColor > -1 And lngColor < 16777216 Then
        GetRGBValue = lngColor \ 256 ^ (rgbValue - 1) And 255
    Else
        GetRGBValue = -1
    End If
End Function

Public Function RepeatString(ByVal strString As String, lngFrom As Long, lngTo As Long, Optional lngFrom1 As Long = 0, Optional strSeparatedBy As String = "") As String
'Req No: 225/07-07, 283/07-01
Dim Inc As Long, Inc1 As Long, strTmp As String
    Inc1 = lngFrom1 - 1
    strTmp = ""
    For Inc = lngFrom To lngTo
        Inc1 = Inc1 + 1
        strTmp = strTmp & IIf(strTmp = "", "", strSeparatedBy) & Replace(Replace(strString, "$R$", Inc), "$R1$", Inc1)
    Next Inc
    RepeatString = strTmp
End Function

Public Function CreateRTF(ByVal strText As String, Optional strFontName As String = "", _
                          Optional sglFontSize As Single = 0, Optional blnBold As Boolean = False, _
                          Optional blnItalic As Boolean = False, Optional blnUnderLine As Boolean = False, _
                          Optional epaAlign As ERECParagraphAlignmentConstants = ercParaJustify, Optional lngColor As Long = 0) As String
Dim strAlign As String, strTextRTF As String, strColor As String
Dim intRed As Integer, intGreen As Integer, intBlue As Integer
    If Left(strText, 6) = "{\rtf1" Then
        strTextRTF = strText
    Else
        Select Case epaAlign
            Case ercParaCentre
                strAlign = "\qc"
            Case ercParaJustify
                strAlign = "\qj"
            Case ercParaLeft
                strAlign = ""
            Case ercParaRight
                strAlign = "\qr"
            Case Else
                strAlign = "\qj"
        End Select
        strColor = ""
        If lngColor <> 0 Then
            intRed = GetRGBValue(lngColor, rgbRed)
            intGreen = GetRGBValue(lngColor, rgbGreen)
            intBlue = GetRGBValue(lngColor, rgbBlue)
            If intRed > -1 And intGreen > -1 And intBlue > -1 Then
                strColor = "{\colortbl ;\red" & intRed & "\green" & intGreen & "\blue" & intBlue & ";}" & vbCrLf
            End If
        End If
        strTextRTF = "{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil\fcharset0 " & IIf(strFontName = "", "MS Sans Serif", strFontName) & ";}}" & vbCrLf & strColor & "\viewkind4\uc1\pard" & strAlign & "\lang1033" & IIf(blnUnderLine, "\ul", "") & IIf(blnBold, "\b", "") & IIf(blnItalic, "\i", "") & "\f0\fs" & IIf(sglFontSize <= 0, 17, sglFontSize * 2) & " " & Replace(strText, vbCrLf, vbCrLf & "\par ") & vbCrLf & "\par }" & vbCrLf
    End If
    CreateRTF = strTextRTF
End Function

Public Sub OpenDocumentFile(strFileName As String, lngDocID As Long)
On Local Error GoTo Err_Exit
Dim strExt As String, strWorkDirectory As String, strTmpFileName As String
Dim strFilePath As String, sSql As String
    If strFileName <> "" Then
        strExt = Mid(strFileName, InStr(1, strFileName, "."))
        If GetApplicationData("WorkDirectory") = "" Or GetApplicationData("CheckOutPath") = "" Then
            pMVE.MsgBox "Please specify Working Directory and Checkout Directory", msgOK, "AuditMate", msgCritical, True
            Exit Sub
        Else
            strWorkDirectory = GetApplicationData("WorkDirectory")
        End If
        If Right(Trim(strWorkDirectory), 1) <> "\" Then
            strWorkDirectory = strWorkDirectory & "\"
        End If
        
        strTmpFileName = GetTickCount
        strFilePath = strWorkDirectory & strTmpFileName & strExt
        sSql = "SELECT DocFile FROM DocumentBin WHERE  DocumentID = " & lngDocID
        If ExtractDocument(GetRecords(sSql, AdoConnDoc), "DocFile", strFilePath) Then
            Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
        End If
    Else
        pMVE.MsgBox "Invalid filename.", msgOK, "AuditMate", msgCritical, True
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub LoadReports(ByVal lngReportID As Long, ByRef vpPreview As VSPrinter8LibCtl.VSPrinter, Optional crptReports As clsReports = Nothing)
On Local Error GoTo Err_Exit
Dim RowInc As Long, ColInc As Long, crptTmp As New clsReports, ObjInc As Long
Dim dblTableHeight As Double, dblTableWidth As Double, strPicFileName As String
Dim sSql As String, cgTagValue As New clsGrid, strTextRTF As String, blnIsNewPage As Boolean
Dim dblMarginLeftTmp As Double
    If crptReports Is Nothing Then
        crptTmp.ValueCollect lngReportID
    Else
        Set crptTmp = crptReports
    End If
    With cgTagValue
        .Rows = 1
        .Cols = 2
        .IndexCol = 0
    End With
    RowInc = -1
    sSql = "SELECT * FROM ReportTags ORDER BY TagID"
    With GetRecords(sSql)
        While Not .EOF
            RowInc = RowInc + 1
            cgTagValue.Rows = RowInc + 1
            sSql = !TagSQL
            sSql = Replace(sSql, "$CompanyID$", crptTmp.CompanyID)
            sSql = Replace(sSql, "$PeriodID$", crptTmp.PeriodID)
            cgTagValue.TextMatrix(RowInc, 0) = !TagName
            cgTagValue.TextMatrix(RowInc, 1) = GetSingleValueFromSQL(sSql)
            .MoveNext
        Wend
        .Close
    End With
    blnIsNewPage = False
    With vpPreview
        .PaperSize = crptTmp.PaperSize
        .Orientation = crptTmp.Orientation
        .StartDoc
        .BrushStyle = bsTransparent
        .MarginLeft = crptTmp.MarginLeft
        .MarginTop = crptTmp.MarginTop
        .MarginRight = crptTmp.MarginRight
        .MarginBottom = crptTmp.MarginBottom
        For ObjInc = 1 To crptTmp.ObjectCount
            If crptTmp.ObjectProperty(ObjInc, rptObjPaperSize) > -1 Then
                .PaperSize = crptTmp.ObjectProperty(ObjInc, rptObjPaperSize)
            End If
            If crptTmp.ObjectProperty(ObjInc, rptObjOrientation) > -1 Then
                .Orientation = crptTmp.ObjectProperty(ObjInc, rptObjOrientation)
            End If
            If crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft) > -1 Then
                .MarginLeft = crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft)
            End If
            If crptTmp.ObjectProperty(ObjInc, rptObjMarginTop) > -1 Then
                .MarginTop = crptTmp.ObjectProperty(ObjInc, rptObjMarginTop)
            End If
            If crptTmp.ObjectProperty(ObjInc, rptObjMarginRight) > -1 Then
                .MarginRight = crptTmp.ObjectProperty(ObjInc, rptObjMarginRight)
            End If
            If crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom) > -1 Then
                .MarginBottom = crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom)
            End If
            If blnIsNewPage Then
                .NewPage
                blnIsNewPage = False
            End If
            .CurrentX = Val(crptTmp.ObjectProperty(ObjInc, rptObjLeft))
            .CurrentY = Val(crptTmp.ObjectProperty(ObjInc, rptObjTop))
            Select Case crptTmp.ObjectProperty(ObjInc, rptObjTypeID)
            Case objtpText
                strTextRTF = Replace(crptTmp.ObjectProperty(ObjInc, rptObjTextRtf), "\'b7", "") 'Chr(pcnstHeadingChar)
                With cgTagValue
                    For RowInc = 0 To .Rows - 1
                        strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(.TextMatrix(RowInc, 0), vbUpperCase) & pcnstTagEnd, StrConv(cgTagValue.TextMatrixOnColIndex(.TextMatrix(RowInc, 0), 1), vbUpperCase))
                        strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(.TextMatrix(RowInc, 0), vbProperCase) & pcnstTagEnd, cgTagValue.TextMatrixOnColIndex(.TextMatrix(RowInc, 0), 1))
                        strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(.TextMatrix(RowInc, 0), vbLowerCase) & pcnstTagEnd, StrConv(cgTagValue.TextMatrixOnColIndex(.TextMatrix(RowInc, 0), 1), vbLowerCase))
                    Next RowInc
                End With
                .TextBox strTextRTF, crptTmp.ObjectProperty(ObjInc, rptObjLeft), crptTmp.ObjectProperty(ObjInc, rptObjTop), crptTmp.ObjectProperty(ObjInc, rptObjWidth), 0, , True
                If .TextHei > Val(crptTmp.ObjectProperty(ObjInc, rptObjHeight)) Then
                    .TextBox CreateRTF("Some text are outside the printable area.", , 15, True, True, False), 100, 100, 6000, 0
                End If
                .TextBox strTextRTF, crptTmp.ObjectProperty(ObjInc, rptObjLeft), crptTmp.ObjectProperty(ObjInc, rptObjTop), crptTmp.ObjectProperty(ObjInc, rptObjWidth), crptTmp.ObjectProperty(ObjInc, rptObjHeight)
            Case objtpLine
                 .DrawLine crptTmp.ObjectProperty(ObjInc, rptObjX1), crptTmp.ObjectProperty(ObjInc, rptObjY1), crptTmp.ObjectProperty(ObjInc, rptObjX2), crptTmp.ObjectProperty(ObjInc, rptObjY2)
            Case objtpRectangle
                .DrawRectangle crptTmp.ObjectProperty(ObjInc, rptObjLeft), crptTmp.ObjectProperty(ObjInc, rptObjTop), Val(crptTmp.ObjectProperty(ObjInc, rptObjLeft)) + Val(crptTmp.ObjectProperty(ObjInc, rptObjWidth)), Val(crptTmp.ObjectProperty(ObjInc, rptObjTop)) + Val(crptTmp.ObjectProperty(ObjInc, rptObjHeight))
            Case objtpOval
                .DrawEllipse crptTmp.ObjectProperty(ObjInc, rptObjLeft), crptTmp.ObjectProperty(ObjInc, rptObjTop), Val(crptTmp.ObjectProperty(ObjInc, rptObjLeft)) + Val(crptTmp.ObjectProperty(ObjInc, rptObjWidth)), Val(crptTmp.ObjectProperty(ObjInc, rptObjTop)) + Val(crptTmp.ObjectProperty(ObjInc, rptObjHeight))
            Case objtpPicture
                strPicFileName = App.Path & IIf(Right(App.Path, 1) = "\", "", "\") & "tmp.pic"
                crptTmp.ObjectProperty(ObjInc, rptObjPicture).SaveToFile strPicFileName, adSaveCreateOverWrite
                .DrawPicture LoadPicture(strPicFileName), crptTmp.ObjectProperty(ObjInc, rptObjLeft), crptTmp.ObjectProperty(ObjInc, rptObjTop), crptTmp.ObjectProperty(ObjInc, rptObjWidth), crptTmp.ObjectProperty(ObjInc, rptObjHeight)
            Case objtpTable
                dblMarginLeftTmp = .MarginLeft
                'If .MarginLeft > Val(crptTmp.ObjectProperty(ObjInc, rptObjLeft)) Then
                .MarginLeft = Val(crptTmp.ObjectProperty(ObjInc, rptObjLeft))
                'End If
                .StartTable
                .TableBorder = crptTmp.ObjectProperty(ObjInc, rptObjBorderTypeID)
                .TableCell(tcCols) = 0
                .TableCell(tcRows) = 0
                dblTableHeight = 0
                dblTableWidth = 0
                With crptTmp
                    For RowInc = 0 To .ObjectTableRows(ObjInc) - 1
                        For ColInc = 0 To .ObjectTableCols(ObjInc) - 1
                            If vpPreview.TableCell(tcRows) < RowInc + 1 Then
                                dblTableHeight = dblTableHeight + Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc))
                                If dblTableHeight - 500 <= Val(.ObjectProperty(ObjInc, rptObjHeight)) Then
                                    vpPreview.TableCell(tcRows) = RowInc + 1
                                End If
                                dblTableWidth = 0
                            End If
                            dblTableWidth = dblTableWidth + Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc))
                            If vpPreview.TableCell(tcCols) < ColInc + 1 Then
                                If dblTableWidth - 500 <= Val(.ObjectProperty(ObjInc, rptObjWidth)) Then
                                    vpPreview.TableCell(tcCols) = ColInc + 1
                                End If
                            End If
                            If .ReportTypeID = rptTypeTemporary Then
                                dblTableHeight = 0
                                dblTableWidth = 0
                            End If
                            If dblTableHeight - 500 <= Val(.ObjectProperty(ObjInc, rptObjHeight)) _
                                And dblTableWidth - 500 <= Val(.ObjectProperty(ObjInc, rptObjWidth)) Then
                                If Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc)) > -1 Then
                                    vpPreview.TableCell(tcColWidth, , ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc))
                                End If
                                If Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc)) > -1 Then
                                    vpPreview.TableCell(tcRowHeight, RowInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc))
                                End If
                                If Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc)) > -1 Then
                                    vpPreview.TableCell(tcBackColor, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc))
                                End If
                                If Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc)) > -1 Then
                                    vpPreview.TableCell(tcForeColor, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc))
                                End If
                                vpPreview.TableCell(tcFontUnderline, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblUnderline, RowInc, ColInc))
                                vpPreview.TableCell(tcFontBold, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblIsBold, RowInc, ColInc))
                                If Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc)) > 0 Then
                                    vpPreview.TableCell(tcFontSize, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc))
                                End If
                                vpPreview.TableCell(tcFontItalic, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblIsItalic, RowInc, ColInc))
                                vpPreview.TableCell(tcAlign, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblAlignment, RowInc, ColInc))
                                If .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc) <> "" Then
                                    vpPreview.TableCell(tcFont, RowInc + 1, ColInc + 1) = .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc)
                                End If
                                vpPreview.TableCell(tcText, RowInc + 1, ColInc + 1) = .ObjectTableCell(ObjInc, rptTblText, RowInc, ColInc)
                                If Val(.ObjectTableCell(ObjInc, rptTblColSpan, RowInc, ColInc)) > 1 Then
                                    vpPreview.TableCell(tcColSpan, RowInc + 1, ColInc + 1) = Val(.ObjectTableCell(ObjInc, rptTblColSpan, RowInc, ColInc))
                                End If
                            Else
                                vpPreview.TextBox CreateRTF("Some text are outside the printable area.", , 15, True, True, False), 100, 100, 6000, 0
                            End If
                        Next ColInc
                    Next RowInc
                End With
                .EndTable
                .MarginLeft = dblMarginLeftTmp
            Case objtpPageBreak
                If .PageCount > 3 Then
                    .MarginFooter = 600
                    .HdrFontName = "Times New Roman"
                    'Ref No: 041-03/11/08 ------
                    .HdrFontSize = 11
                    .Footer = "|-" & .PageCount - 2 & "-"
                Else
                    .Footer = ""
                End If
                blnIsNewPage = True
            End Select
        Next ObjInc
        If .PageCount > 3 Then
            .MarginFooter = 600
            .HdrFontName = "Times New Roman"
            'Ref No: 041-03/11/08 ----------
            .HdrFontSize = 11
            .Footer = "|-" & .PageCount - 2 & "-"
        Else
            .Footer = ""
        End If
        .EndDoc
    End With
    crptTmp.Clear
    Set crptTmp = Nothing
Exit Sub
Err_Exit:
    ShowError
    crptTmp.Clear
    Set crptTmp = Nothing
End Sub

Public Sub PopulateFonts(ByRef cmbFontName As ComboBox)
Dim Inc As Long
    With cmbFontName
        .Clear
        For Inc = 0 To Screen.FontCount - 1
            .AddItem Screen.Fonts(Inc)
        Next Inc
    End With
End Sub

Public Sub ChangeSelection(ByRef cntrlControl As Control, ByRef frmForm As Form)
On Local Error Resume Next
    pblnIsInsideSelChangeEvent = True
    If Not pblnIsInSetTextStyle Then
        With cntrlControl
            'Selecting Bold , Italic  and Undierline Tool Bar Buttons
            frmForm.tbrText.Buttons("Bold").Value = IIf(.SelBold, tbrPressed, tbrUnpressed)
            frmForm.tbrText.Buttons("Italic").Value = IIf(.SelItalic, tbrPressed, tbrUnpressed)
            frmForm.tbrText.Buttons("Underline").Value = IIf(.SelUnderline, tbrPressed, tbrUnpressed)
            'Seleting Left, Right, Center and Justify Tool bar Buttons
            Select Case GetAlignment(.hWnd)
                Case ercParaLeft
                    frmForm.tbrText.Buttons("Left").Value = tbrPressed
                Case ercParaRight
                    frmForm.tbrText.Buttons("Right").Value = tbrPressed
                Case ercParaCentre
                    frmForm.tbrText.Buttons("Center").Value = tbrPressed
                Case ercParaJustify
                    frmForm.tbrText.Buttons("Justify").Value = tbrPressed
            End Select
            If IsNull(.SelFontName) Then
                frmForm.cmbFontName.Text = ""
            Else
                frmForm.cmbFontName.Text = .SelFontName
            End If
            If IsNull(.SelFontSize) Then
                frmForm.cmbFontSize.Text = ""
            Else
                frmForm.cmbFontSize.Text = .SelFontSize
            End If
            If frmForm.Name = "frmReportDesigner" Then
                frmForm.cmbTextStyle.Text = GetTextStyle(cntrlControl)
            End If
            With frmForm.tbrText.Buttons("Line Spacing")
                .ButtonMenus("LS1.0") = "  1.0"
                .ButtonMenus("LS1.5") = "  1.5"
                .ButtonMenus("LS2.0") = "  2.0"
                Select Case GetLineSpacing(cntrlControl.hWnd)
                    Case lnspSingle
                        .ButtonMenus("LS1.0") = "* 1.0"
                    Case lnspOneAndAHalf
                        .ButtonMenus("LS1.5") = "* 1.5"
                    Case lnspDouble
                        .ButtonMenus("LS2.0") = "* 2.0"
                End Select
            End With
        End With
    End If
    pblnIsInsideSelChangeEvent = False
End Sub

Public Sub PopulateTemplates(ByRef cmbTemplate As ComboBox)
On Local Error GoTo Err_Exit
Dim sSql As String, strTemplateName As String
    strTemplateName = cmbTemplate.Text
    cmbTemplate.Clear
    sSql = "SELECT TemplateID, TemplateName FROM ReportTemplates ORDER BY TemplateName"
    With GetRecords(sSql)
        While Not .EOF
            cmbTemplate.AddItem !TemplateName
            cmbTemplate.ItemData(cmbTemplate.ListCount - 1) = !TemplateID
            .MoveNext
        Wend
        .Close
    End With
    cmbTemplate.Text = strTemplateName
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub PopulateReportTags(ByRef cgTagValue As clsGrid, ByVal lngCompanyID As Long, _
                              ByVal lngPeriodID As Long, Optional ByRef btnTag As MSComctlLib.Button = Nothing)
Dim sSql As String, bmTmp As MSComctlLib.ButtonMenu, Inc As Long
    If Not btnTag Is Nothing Then
        btnTag.ButtonMenus.Clear
    End If
    cgTagValue.Rows = 1
    cgTagValue.Cols = 3
    Inc = -1
    sSql = "SELECT * FROM ReportTags ORDER BY TagID"
    With GetRecords(sSql)
        While Not .EOF
            If Not btnTag Is Nothing Then
                Set bmTmp = btnTag.ButtonMenus.Add(, !TagName, !TagName)
                bmTmp.Tag = !TagSQL
            End If
            Inc = Inc + 1
            cgTagValue.Rows = Inc + 1
            cgTagValue.TextMatrix(Inc, 0) = !TagName
            sSql = !TagSQL
            sSql = Replace(sSql, "$CompanyID$", lngCompanyID)
            sSql = Replace(sSql, "$PeriodID$", lngPeriodID)
            cgTagValue.TextMatrix(Inc, 1) = GetSingleValueFromSQL(sSql)
            cgTagValue.TextMatrix(Inc, 2) = sSql
            .MoveNext
        Wend
        .Close
    End With
End Sub

Private Function ReplaceTags(ByVal strTmp As String, ByRef cgTagValue As clsGrid) As String
Dim Inc As Long, strTagName As String, strTagValue As String
    With cgTagValue
        For Inc = 0 To .Rows - 1
            strTagName = .TextMatrix(Inc, 0)
            strTagValue = .TextMatrix(Inc, 1)
            strTmp = Replace(strTmp, pcnstTagStart & StrConv(strTagName, vbUpperCase) & pcnstTagEnd, _
                StrConv(strTagValue, vbUpperCase))
            strTmp = Replace(strTmp, pcnstTagStart & StrConv(strTagName, vbProperCase) & pcnstTagEnd, strTagValue)
            strTmp = Replace(strTmp, pcnstTagStart & StrConv(strTagName, vbLowerCase) & pcnstTagEnd, _
                StrConv(strTagValue, vbLowerCase))
        Next Inc
    End With
    ReplaceTags = strTmp
End Function

Public Function GetTextFromImageData(ByRef fldDataField As ADODB.Field) As String
On Local Error Resume Next
Dim stmTmp As New ADODB.Stream, strTmp As String
    If Not IsNull(fldDataField.Value) Then
        stmTmp.Type = adTypeBinary
        stmTmp.Open
        stmTmp.Write fldDataField.Value
        stmTmp.Position = 0
        stmTmp.Type = adTypeText
        strTmp = stmTmp.ReadText
        stmTmp.Close
    End If
    Set stmTmp = Nothing
    GetTextFromImageData = strTmp
End Function

Private Function VSFGridAlignmentToVSPrinterAlignment(ByVal vsasAlignment As VSFlex8Ctl.AlignmentSettings) As VSPrinter8LibCtl.TextAlignSettings
    Select Case vsasAlignment
        Case flexAlignCenterBottom
            VSFGridAlignmentToVSPrinterAlignment = taCenterBottom
        Case flexAlignCenterCenter
            VSFGridAlignmentToVSPrinterAlignment = taCenterMiddle
        Case flexAlignCenterTop
            VSFGridAlignmentToVSPrinterAlignment = taCenterTop
        Case flexAlignLeftBottom
            VSFGridAlignmentToVSPrinterAlignment = taLeftBottom
        Case flexAlignLeftCenter
            VSFGridAlignmentToVSPrinterAlignment = taLeftMiddle
        Case flexAlignLeftTop
            VSFGridAlignmentToVSPrinterAlignment = taLeftTop
        Case flexAlignRightBottom
            VSFGridAlignmentToVSPrinterAlignment = taRightBottom
        Case flexAlignRightCenter
            VSFGridAlignmentToVSPrinterAlignment = taRightMiddle
        Case flexAlignRightTop
            VSFGridAlignmentToVSPrinterAlignment = taRightTop
    End Select
End Function

Public Sub SetLevel(ByRef vsfgConfigure As VSFlex8Ctl.VSFlexGrid, ByVal Row As Long, Optional ByVal lngLevelChange As Long = 0)
On Local Error Resume Next
    With vsfgConfigure
        If .TextMatrix(Row, grdConfigureType) = "Main" Then
            .TextMatrix(Row, grdConfigureLevelNo) = 0
        Else
            .TextMatrix(Row, grdConfigureLevelNo) = .ValueMatrix(Row, grdConfigureLevelNo) + lngLevelChange
            If .ValueMatrix(Row, grdConfigureLevelNo) <= 0 Or .ValueMatrix(Row, grdConfigureLevelNo) > 10 Then
                .TextMatrix(Row, grdConfigureLevelNo) = 1
            End If
        End If
        .RowOutlineLevel(Row) = .ValueMatrix(Row, grdConfigureLevelNo)
        .IsSubtotal(Row) = True
    End With
End Sub

Public Sub ValueCollectReportGenerate(ByRef vsfgConfigure As VSFlex8Ctl.VSFlexGrid, ByVal lngPeriodID As Long, _
                                      Optional ByRef cgTmp As clsGrid = Nothing)
On Local Error Resume Next
Dim Inc As Long
    If cgTmp Is Nothing Then
        Set cgTmp = New clsGrid
        ValueCollectReportGenerateClsGrid cgTmp, lngPeriodID
    End If
    cgTmp.SetValuesToGrid vsfgConfigure
    With vsfgConfigure
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdConfigureParentSlNo) = 0 Then
                SetLevel vsfgConfigure, Inc
            Else
                SetLevel vsfgConfigure, Inc, .ValueMatrix(.ValueMatrix(Inc, grdConfigureParentSlNo), grdConfigureLevelNo) + 1
            End If
            Select Case .TextMatrix(Inc, grdConfigureType)
                Case "Main"
                    .Cell(flexcpFontBold, Inc, 0, Inc, .Cols - 1) = True
                Case "Sub"
                    .Cell(flexcpFontBold, Inc, 0, Inc, .Cols - 1) = True
                Case Else
                    .Cell(flexcpFontBold, Inc, 0, Inc, .Cols - 1) = False
            End Select
        Next Inc
    End With
    cgTmp.Clear
    Set cgTmp = Nothing
End Sub

Public Sub ValueCollectReportGenerateClsGrid(ByRef cgConfigure As clsGrid, ByVal lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, stmTmp As New ADODB.Stream
    cgConfigure.Rows = 1
    cgConfigure.Cols = cnstConfigureCols
    Inc = 0
    sSql = "SELECT ARO.*, AcT.AcTypeDescription, TT.TableTypeName, AROT.ObjTypeName, AROT.ObjType FROM AuditReportObjects ARO INNER JOIN AuditReportObjectTypes AROT ON AROT.ObjTypeID = ARO.ObjTypeID LEFT OUTER JOIN AcTypes AcT ON AcT.AcTypeID = ARO.AcTypeID LEFT OUTER JOIN TableTypes TT ON TT.TableTypeID = ARO.TableTypeID WHERE ARO.PeriodID = " & lngPeriodID & " ORDER BY ARO.ObjSlNo"
    With GetRecords(sSql)
        While Not .EOF
            Inc = Inc + 1
            cgConfigure.Rows = Inc + 1
            cgConfigure.TextMatrix(Inc, grdConfigureAcTypeID) = !AcTypeID & ""
            cgConfigure.TextMatrix(Inc, grdConfigureAcTypeName) = !AcTypeDescription & ""
            cgConfigure.TextMatrix(Inc, grdConfigureDescription) = !Description & ""
            cgConfigure.TextMatrix(Inc, grdConfigureObjTypeID) = !ObjTypeID
            cgConfigure.TextMatrix(Inc, grdConfigureTableID) = !TableTypeID & ""
            cgConfigure.TextMatrix(Inc, grdConfigureTitle) = !ObjTypeName
            cgConfigure.TextMatrix(Inc, grdConfigureType) = !ObjType
            cgConfigure.TextMatrix(Inc, grdConfigureOrientation) = IIf(!IsOrientationLandscape, 1, 0)
            cgConfigure.TextMatrix(Inc, grdConfigureParentSlNo) = !ParentObjSlNo & ""
            If !AcTypeDescription & "" <> "" Then
                cgConfigure.TextMatrix(Inc, grdConfigureDescription) = !AcTypeDescription & ""
            End If
            If !TableTypeName & "" <> "" Then
                cgConfigure.TextMatrix(Inc, grdConfigureTitle) = cgConfigure.TextMatrix(Inc, grdConfigureTitle) & _
                    " - " & !TableTypeName & ""
            End If
            If IsNull(!Data) Then
                cgConfigure.TextMatrix(Inc, grdConfigureData) = ""
            Else
                'stmTmp.Type = adTypeBinary
                'stmTmp.Open
                'stmTmp.Write !Data
                'stmTmp.Position = 0
                'stmTmp.Type = adTypeText
                'vsfgConfigure.TextMatrix(Inc, grdConfigureData) = stmTmp.ReadText
                'stmTmp.Close
                cgConfigure.TextMatrix(Inc, grdConfigureData) = GetTextFromImageData(.Fields("Data"))
            End If
            .MoveNext
        Wend
        .Close
    End With
    Set stmTmp = Nothing
Exit Sub
Err_Exit:
    ShowError
    Set stmTmp = Nothing
End Sub

Public Sub SaveReportGenerate(ByRef cgRptObjs As clsGrid, ByVal lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
Dim stmTmp As New ADODB.Stream, rsTmp As New ADODB.Recordset
    AdoConn.BeginTrans
    sSql = "DELETE FROM AuditReportObjects WHERE PeriodID = " & lngPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM AuditReportObjects WHERE PeriodID = " & lngPeriodID
    With rsTmp
        .Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
        For Inc = 1 To cgRptObjs.Rows - 1
            .AddNew
            !PeriodID = lngPeriodID
            !ObjSlNo = Inc
            !ObjTypeID = cgRptObjs.ValueMatrix(Inc, grdConfigureObjTypeID)
            !Description = cgRptObjs.TextMatrix(Inc, grdConfigureDescription)
            !IsOrientationLandscape = (cgRptObjs.ValueMatrix(Inc, grdConfigureOrientation) = 1)
            If cgRptObjs.ValueMatrix(Inc, grdConfigureTableID) = 0 Then
                !TableTypeID = Null
            Else
                !TableTypeID = cgRptObjs.ValueMatrix(Inc, grdConfigureTableID)
            End If
            If cgRptObjs.ValueMatrix(Inc, grdConfigureAcTypeID) = 0 Then
                !AcTypeID = Null
            Else
                !AcTypeID = cgRptObjs.ValueMatrix(Inc, grdConfigureAcTypeID)
            End If
            If cgRptObjs.TextMatrix(Inc, grdConfigureData) = "" Then
                !Data = Null
            Else
                stmTmp.Type = adTypeText
                stmTmp.Open
                stmTmp.WriteText cgRptObjs.TextMatrix(Inc, grdConfigureData)
                stmTmp.Position = 0
                stmTmp.Type = adTypeBinary
                !Data = stmTmp.Read
                stmTmp.Close
            End If
            If cgRptObjs.ValueMatrix(Inc, grdConfigureParentSlNo) = 0 Then
                !ParentObjSlNo = Null
            Else
                !ParentObjSlNo = cgRptObjs.ValueMatrix(Inc, grdConfigureParentSlNo)
            End If
            .Update
        Next Inc
        .Close
    End With
    AdoConn.CommitTrans
    Set stmTmp = Nothing
Exit Sub
Err_Exit:
    ShowError
    AdoConn.RollbackTrans
    Set stmTmp = Nothing
End Sub
 
Public Sub PrintReportGenerate(ByVal pvtPVType As PreviewTypes, ByVal lngCompanyID As Long, ByVal lngPeriodID As Long, _
                               Optional ByRef cgTagValue As clsGrid = Nothing, Optional ByRef ctblTOC As clsTable = Nothing, _
                               Optional ByVal lngCurrentSlNo As Long = 0, Optional ByRef cgRptObjs As clsGrid = Nothing, _
                               Optional ByRef vsPreview As VSPrinter8LibCtl.VSPrinter = Nothing)
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, ctblTmp As New clsTable, RowInc As Long, ColInc As Long
Dim strCommonHeader As String, strPageHeader As String
Dim rgotParentTypeID As ReportGeneratorObjectTypes, strData As String, lngRow As Long, lngCol As Long
Dim vsPreviewTmp As VSPrinter8LibCtl.VSPrinter, lngTOCRow As Long, strMainDescription As String
Dim dblFixToPageWidth As Double, dblTblWidth As Double, strSubDescription As String, dblMarginTmp As Double
Dim lngCurrentPageNo As Long, arrLevels() As Long, arrLevelSeq() As String
Dim blnIsTagValuesNewlyPopulated As Boolean, blnIsRptObjsNewlyPopulated As Boolean
    If vsPreview Is Nothing Then
        Unload frmPreview
        Set vsPreviewTmp = frmPreview.vpPreview
    Else
        Set vsPreviewTmp = vsPreview
    End If
    vsPreviewTmp.Clear
    blnIsRptObjsNewlyPopulated = False
    blnIsTagValuesNewlyPopulated = False
    If cgTagValue Is Nothing Then
        Set cgTagValue = New clsGrid
        PopulateReportTags cgTagValue, lngCompanyID, lngPeriodID
        blnIsTagValuesNewlyPopulated = True
    End If
    vsPreviewTmp.Tag = pcnstRptParamSep & pcnstRptParamSep
    If Not ctblTOC Is Nothing Then
        With ctblTOC
            .Clear
            .Cell(rptTblCols) = 2
            .Cell(rptTblRows) = 1
            .Cell(rptTblText, 0, 1) = "Page"
            .Cell(rptTblIsBold, 0, 1) = True
            .Cell(rptTblAlignment, 0, 1) = flexAlignCenterCenter
            .Cell(rptTblRowHeight, 0, 0) = 600
            .Cell(rptTblRowHeight, 0, 1) = 600
            .Cell(rptTblFontName, 0, 0) = "Times New Roman"
            .Cell(rptTblFontName, 0, 1) = "Times New Roman"
            'Ref No: 041-03/11/08 -------
            .Cell(rptTblFontSize, 0, 0) = 11
            .Cell(rptTblFontSize, 0, 1) = 11
        End With
        lngTOCRow = 0
    End If
    rgotParentTypeID = 0
    If cgRptObjs Is Nothing Then
        blnIsRptObjsNewlyPopulated = True
        Set cgRptObjs = New clsGrid
        ValueCollectReportGenerateClsGrid cgRptObjs, lngPeriodID
    End If
    With vsPreviewTmp
        .MarginTop = "2.22cm"
        .MarginBottom = "0.85cm"
        .MarginLeft = "2.82cm"
        .MarginRight = "2.52cm"                 '"2.22cm"
        .Header = ""
        .Footer = ""
        .StartDoc
        .PenColor = vbBlack
        .PenStyle = psSolid
        .PenWidth = 10
        For Inc = 1 To cgRptObjs.Rows - 1
            ReDim Preserve arrLevels(Inc), arrLevelSeq(Inc)
            arrLevelSeq(Inc) = ""
            With cgRptObjs
                If .ValueMatrix(Inc, grdConfigureParentSlNo) <= 0 Then
                    arrLevels(Inc) = 0
                Else
                    arrLevels(Inc) = arrLevels(.ValueMatrix(Inc, grdConfigureParentSlNo)) + 1
                    If .TextMatrix(Inc, grdConfigureDescription) <> "" Then
                        arrLevelSeq(Inc) = arrLevelSeq(.ValueMatrix(Inc, grdConfigureParentSlNo)) & _
                            pcnstRptParamSep & .TextMatrix(Inc, grdConfigureDescription)
                    End If
                End If
            End With
            Select Case cgRptObjs.TextMatrix(Inc, grdConfigureType)
            Case "Main"
                rgotParentTypeID = cgRptObjs.ValueMatrix(Inc, grdConfigureObjTypeID)
                strPageHeader = ""
                Select Case rgotParentTypeID
                Case RGObjCommonPageHeader
                Case RGObjFrontPage
                    .MarginTop = "2.22cm"
                    .MarginBottom = "0.85cm"
                    .MarginLeft = "2.82cm"
                    .MarginRight = "2.52cm"                     '"3.01cm"
                Case Else
                    strMainDescription = ReplaceTags(cgRptObjs.TextMatrix(Inc, grdConfigureDescription), cgTagValue)
                    If Not ctblTOC Is Nothing And rgotParentTypeID <> RGObjTableOfContents And lngTOCRow > 0 Then
                        If Val(ctblTOC.Cell(rptTblText, lngTOCRow, 1)) <> .PageCount - 2 Then
                            ctblTOC.Cell(rptTblText, lngTOCRow, 1) = ctblTOC.Cell(rptTblText, lngTOCRow, 1) & "-" & .PageCount - 2
                        End If
                    End If
                    vsPreviewTmp.Tag = pcnstRptParamSep & pcnstRptParamSep
                    .Orientation = cgRptObjs.ValueMatrix(Inc, grdConfigureOrientation)
                    If .Orientation = orLandscape Then
                        .MarginTop = "3.49cm"
                        .MarginBottom = "0.85cm"
                        .MarginLeft = "2.22cm"
                        .MarginRight = "2.02cm"                 '"2.39cm"
                    Else
                        .MarginTop = "2.22cm"
                        .MarginBottom = "0.85cm"
                        .MarginLeft = "2.82cm"                  '"3.01cm"
                        .MarginRight = "2.52cm"
                    End If
                    .NewPage
                    vsPreviewTmp.Tag = strCommonHeader & pcnstRptParamSep & pcnstRptParamSep & strMainDescription
                    If Not ctblTOC Is Nothing And rgotParentTypeID <> RGObjTableOfContents Then
                        lngTOCRow = lngTOCRow + 1
                        ctblTOC.Cell(rptTblRows) = lngTOCRow + 1
                        ctblTOC.Cell(rptTblText, lngTOCRow, 0) = cgRptObjs.TextMatrix(Inc, grdConfigureDescription)
                        ctblTOC.Cell(rptTblText, lngTOCRow, 1) = .PageCount - 2
                        ctblTOC.Cell(rptTblColWidth, lngTOCRow, 0) = 7000
                        ctblTOC.Cell(rptTblColWidth, lngTOCRow, 1) = 1500
                        ctblTOC.Cell(rptTblAlignment, lngTOCRow, 0) = flexAlignLeftCenter
                        ctblTOC.Cell(rptTblAlignment, lngTOCRow, 1) = flexAlignCenterCenter
                        ctblTOC.Cell(rptTblRowHeight, lngTOCRow, 0) = 600
                        ctblTOC.Cell(rptTblRowHeight, lngTOCRow, 1) = 600
                        ctblTOC.Cell(rptTblIsBold, lngTOCRow, 0) = True
                        ctblTOC.Cell(rptTblIsBold, lngTOCRow, 1) = True
                        ctblTOC.Cell(rptTblFontName, lngTOCRow, 0) = "Times New Roman"
                        ctblTOC.Cell(rptTblFontName, lngTOCRow, 1) = "Times New Roman"
                        'Ref No: 041-03/11/08 -------------
                        ctblTOC.Cell(rptTblFontSize, lngTOCRow, 0) = 11
                        ctblTOC.Cell(rptTblFontSize, lngTOCRow, 1) = 11
                    End If
                End Select
            Case Else
                strData = cgRptObjs.TextMatrix(Inc, grdConfigureData)
                Select Case cgRptObjs.ValueMatrix(Inc, grdConfigureObjTypeID)
                Case RGObjHeader
                    If rgotParentTypeID = RGObjCommonPageHeader Then
                        strCommonHeader = ReplaceTags(strData, cgTagValue)
                        strPageHeader = ""
                    Else
                        strPageHeader = ReplaceTags(strData, cgTagValue)
                        vsPreviewTmp.Tag = strCommonHeader & pcnstRptParamSep & strPageHeader & pcnstRptParamSep & strMainDescription
                        .TextRTF = strCommonHeader
                        If strPageHeader <> "" Then
                            .CurrentY = .CurrentY + 100
                            .TextRTF = Replace(strPageHeader, "$SectionTitle$", strMainDescription)
                        End If
                        .DrawLine .MarginLeft, .CurrentY + 20, .PageWidth - .MarginRight, .CurrentY + 20
                    End If
                Case RGObjText, RGObjSubHeading
                    If cgRptObjs.TextMatrix(Inc, grdConfigureType) = "Sub" Then
                        strSubDescription = ReplaceTags(cgRptObjs.TextMatrix(Inc, grdConfigureDescription), cgTagValue)
                        If strSubDescription <> "" Then
                            vsPreviewTmp.Tag = strCommonHeader & pcnstRptParamSep & strPageHeader & pcnstRptParamSep & _
                                strMainDescription & arrLevelSeq(cgRptObjs.ValueMatrix(Inc, grdConfigureParentSlNo))
                            If .Orientation = cgRptObjs.ValueMatrix(Inc, grdConfigureOrientation) Then
                                If .CurrentY > .PageHeight - (.MarginBottom + 2000) Then
                                    .NewPage
                                Else
                                    .CurrentY = .CurrentY + 100
                                End If
                            Else
                                .Orientation = cgRptObjs.ValueMatrix(Inc, grdConfigureOrientation)
                                If .Orientation = orLandscape Then
                                    .MarginTop = "3.49cm"
                                    .MarginBottom = "0.85cm"
                                    .MarginLeft = "2.22cm"
                                    .MarginRight = "2.39cm"
                                Else
                                    .MarginTop = "2.22cm"
                                    .MarginBottom = "0.85cm"
                                    .MarginLeft = "2.82cm"                      '"3.81cm"
                                    .MarginRight = "2.52cm"
                                End If
                                .NewPage
                            End If
                            vsPreviewTmp.Tag = strCommonHeader & pcnstRptParamSep & strPageHeader & pcnstRptParamSep & _
                                strMainDescription & arrLevelSeq(Inc)
                            If arrLevels(Inc) >= 2 Then
                                dblMarginTmp = .MarginLeft
                                .MarginLeft = 1500
                            End If
                            'Ref No: 041-03/11/08 -------
                            If arrLevels(Inc) > 2 Then
                                .TextRTF = CreateRTF(strSubDescription, "Times New Roman", 11, True, True)
                                .CurrentY = .CurrentY + 100
                            Else
                                .TextRTF = CreateRTF(strSubDescription, "Times New Roman", 11, True)
                                .CurrentY = .CurrentY + 100
                            End If
                            If arrLevels(Inc) >= 2 Then
                                .MarginLeft = dblMarginTmp
                            End If
                        End If
                    End If
                    Select Case rgotParentTypeID
                    Case RGObjFrontPage
                        'front page
                        .CurrentY = 4100
                    Case RGObjIndependentAuditorsReport
'                        .CurrentY = .CurrentY + 100
                        .CurrentY = .CurrentY + 1800
                        'Ref No: 041-03/11/08 ---------
                        .TextRTF = CreateRTF(strMainDescription, "Times New Roman", 11, True)
                        .CurrentY = .CurrentY + 100
                        'Ref No: 041-03/11/08 ---------
                        vsPreviewTmp.Tag = strCommonHeader & pcnstRptParamSep & CreateRTF("$SectionTitle$", "Times New Roman", 11, True) & pcnstRptParamSep & strMainDescription
                    Case RGObjNotesToTheFinancialStatements
                        dblMarginTmp = .MarginLeft
                        .MarginLeft = 1500
                    End Select
                    .TextRTF = Replace(ReplaceTags(strData, cgTagValue), "$SectionTitle$", IIf(strSubDescription = "", strMainDescription, strSubDescription))
                    If rgotParentTypeID = RGObjNotesToTheFinancialStatements Then
                        .MarginLeft = dblMarginTmp
                    End If
                Case RGObjTable
                    If strData <> "" Then
                        If rgotParentTypeID = RGObjNotesToTheFinancialStatements Then
                            dblMarginTmp = .MarginLeft
                            If cgRptObjs.ValueMatrix(Inc, grdConfigureTableID) = rptTTCustomTable Then
                                .MarginLeft = 2000
                            Else
                                .MarginLeft = .MarginLeft - 100
                            End If
                        End If
                        ctblTmp.SetGridData strData
                        dblFixToPageWidth = 1
                        If cgRptObjs.ValueMatrix(Inc, grdConfigureTableID) = rptTTTableOfContents Then
                            .CurrentY = .CurrentY + 100
                        Else
                            .CurrentY = .CurrentY + 100
                            dblTblWidth = 0
                            For ColInc = 0 To ctblTmp.Cell(rptTblCols) - 1
                                dblTblWidth = dblTblWidth + ctblTmp.Cell(rptTblColWidth, 0, ColInc)
                            Next ColInc
                            If dblTblWidth > 0 Then
                                'dblFixToPageWidth = IIf(.Orientation = orLandscape, 14300, 8600) / dblTblWidth
                                dblFixToPageWidth = (.PageWidth - (.MarginLeft + .MarginRight)) / dblTblWidth
                            End If
                        End If
                        .TableBorder = tbNone
                        .StartTable
                        .TableBorder = ctblTmp.BorderType
                        .TableCell(tcCols) = ctblTmp.Cell(rptTblCols)
                        .TableCell(tcRows) = ctblTmp.Cell(rptTblRows)
                        For RowInc = 0 To ctblTmp.Cell(rptTblRows) - 1
                            lngRow = RowInc + 1
                            For ColInc = 0 To ctblTmp.Cell(rptTblCols) - 1
                                lngCol = ColInc + 1
                                .TableCell(tcAlign, lngRow, lngCol) = VSFGridAlignmentToVSPrinterAlignment(ctblTmp.Cell(rptTblAlignment, RowInc, ColInc))
                                .TableCell(tcBackColor, lngRow, lngCol) = ctblTmp.Cell(rptTblBackColor, RowInc, ColInc)
                                If ctblTmp.Cell(rptTblColWidth, RowInc, ColInc) > 0 Then
                                    If ctblTmp.Cell(rptTblColWidth, RowInc, ColInc) > 800 Then
                                        .TableCell(tcColWidth, lngRow, lngCol) = ctblTmp.Cell(rptTblColWidth, RowInc, ColInc) * dblFixToPageWidth
                                    Else
                                        .TableCell(tcColWidth, lngRow, lngCol) = ctblTmp.Cell(rptTblColWidth, RowInc, ColInc)
                                    End If
                                End If
                                .TableCell(tcFontName, lngRow, lngCol) = ctblTmp.Cell(rptTblFontName, RowInc, ColInc)
                                .TableCell(tcFontSize, lngRow, lngCol) = IIf(ctblTmp.Cell(rptTblFontSize, RowInc, ColInc) <= 0, 11, ctblTmp.Cell(rptTblFontSize, RowInc, ColInc))
                                .TableCell(tcForeColor, lngRow, lngCol) = ctblTmp.Cell(rptTblForeColor, RowInc, ColInc)
                                .TableCell(tcFontBold, lngRow, lngCol) = ctblTmp.Cell(rptTblIsBold, RowInc, ColInc)
                                .TableCell(tcFontItalic, lngRow, lngCol) = ctblTmp.Cell(rptTblIsItalic, RowInc, ColInc)
                                .TableCell(tcRowHeight, lngRow, lngCol) = ctblTmp.Cell(rptTblRowHeight, RowInc, ColInc)
                                .TableCell(tcText, lngRow, lngCol) = ctblTmp.Cell(rptTblText, RowInc, ColInc)
                                .TableCell(tcFontUnderline, lngRow, lngCol) = ctblTmp.Cell(rptTblUnderline, RowInc, ColInc)
                                If Val(ctblTmp.Cell(rptTblColSpan, RowInc, ColInc)) > 1 Then
                                    .TableCell(tcColSpan, lngRow, lngCol) = Val(ctblTmp.Cell(rptTblColSpan, RowInc, ColInc))
                                End If
                            Next ColInc
                            If cgRptObjs.ValueMatrix(Inc, grdConfigureTableID) <> rptTTCustomTable _
                                And rgotParentTypeID = RGObjNotesToTheFinancialStatements And (lngRow = 1 Or lngRow = 2) Then
                                .TableCell(tcRowHeight, lngRow) = 0
                            End If
                        Next RowInc
                        .EndTable
                        If rgotParentTypeID = RGObjNotesToTheFinancialStatements Then
                            .MarginLeft = dblMarginTmp
                        End If
                    End If
                    ctblTmp.Clear
                End Select
            End Select
            If lngCurrentSlNo = Inc Then
                lngCurrentPageNo = .PageCount
            End If
        Next Inc
        If Not ctblTOC Is Nothing And rgotParentTypeID <> RGObjTableOfContents And lngTOCRow > 0 Then
            If Val(ctblTOC.Cell(rptTblText, lngTOCRow, 1)) <> .PageCount - 2 Then
                ctblTOC.Cell(rptTblText, lngTOCRow, 1) = ctblTOC.Cell(rptTblText, lngTOCRow, 1) & "-" & .PageCount - 2
            End If
        End If
        .EndDoc
        'Ref No: 041-03/11/08 -------------
        .HdrFontSize = 11
        .HdrFontName = "Times New Roman"
        .HdrFontBold = False
        For Inc = 1 To .PageCount
            If Inc > 3 Then
                .StartOverlay Inc, True
                .CurrentX = .MarginLeft
                .CurrentY = .PageHeight - .MarginBottom
                .TextAlign = taCenterTop
                vsPreviewTmp = "-" & Inc - 2 & "-"
                .EndOverlay
            End If
        Next Inc
    End With
    Set ctblTmp = Nothing
    Select Case pvtPVType
    Case pvtPreview
        If vsPreview Is Nothing Then
            If lngCurrentPageNo > 0 Then
                frmPreview.vpPreview.PreviewPage = lngCurrentPageNo
            End If
            frmPreview.Show
        End If
    Case pvtPrint
        vsPreviewTmp.PrintDoc
        If vsPreview Is Nothing Then
            Unload frmPreview
        End If
    Case pvtTesting
        If vsPreview Is Nothing Then
            Unload frmPreview
        End If
    End Select
    If blnIsTagValuesNewlyPopulated Then
        cgTagValue.Clear
        Set cgTagValue = Nothing
    End If
    If blnIsRptObjsNewlyPopulated Then
        cgRptObjs.Clear
        Set cgRptObjs = Nothing
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub OnPreviewNewPage(ByRef vpPreview As VSPrinter8LibCtl.VSPrinter)
Dim strTextRTF As String, arrTmp() As String, lngPos As Long, Inc As Long, dblMarginTmp As Double
Dim strCommonHeader As String, strPageHeader As String, strMainDescription As String
    arrTmp = Split(vpPreview.Tag, pcnstRptParamSep)
    If UBound(arrTmp) >= 2 Then
        strCommonHeader = arrTmp(0)
        strPageHeader = arrTmp(1)
        strMainDescription = arrTmp(2)
    End If
    If strCommonHeader <> "" Or strPageHeader <> "" Or strMainDescription <> "" Then
        With vpPreview
            dblMarginTmp = .MarginLeft
            If .Orientation = orLandscape Then
                .MarginLeft = "2.22cm"
            Else
                .MarginLeft = "2.82cm"
            End If
            .TextRTF = strCommonHeader
            If strPageHeader <> "" Then
            'Ref No:1 - 23/06/2009--------
                .CurrentY = .CurrentY + 100
'                .CurrentY = .CurrentY + 500
                lngPos = InStr(1, strPageHeader, "$SectionTitle$")
                If lngPos > 0 Then
                    lngPos = InStr(lngPos, strPageHeader, vbCrLf)
                    If lngPos > 0 Then
                        strPageHeader = Mid(strPageHeader, 1, lngPos - 1) & "$C$" & Mid(strPageHeader, lngPos)
                        strTextRTF = Replace(strPageHeader, "$SectionTitle$", strMainDescription)
                    Else
                        strTextRTF = Replace(strPageHeader, "$SectionTitle$", strMainDescription & "$C$")
                    End If
                Else
                    strTextRTF = strPageHeader
                End If
'                strTextRTF = Replace(strTextRTF, "$C$", "\b0 (continued)" & vbCrLf & "\par \b ")
                strTextRTF = Replace(strTextRTF, "$C$", "\b0 (continued)" & vbCrLf & "\b ")
                .TextRTF = strTextRTF
            End If
            .DrawLine .MarginLeft, .CurrentY + 20, .PageWidth - .MarginRight, .CurrentY + 20
'            .CurrentY = .CurrentY + 500
            .CurrentY = .CurrentY + 150
            For Inc = 3 To UBound(arrTmp)
                If arrTmp(Inc) <> "" Then
                    If Inc > 3 Then
                        dblMarginTmp = .MarginLeft
                        .MarginLeft = 1500
                    End If
                    'Ref No: 041-03/11/08 -------------
                    .TextRTF = Replace(CreateRTF(arrTmp(Inc) & "$C$", "Times New Roman", 11, True), "$C$", "\b0 (continued)" & vbCrLf & "\b ")
                    .CurrentY = .CurrentY + 150
                    If Inc > 3 Then
                        .MarginLeft = dblMarginTmp
                    End If
                End If
            Next Inc
            .MarginLeft = dblMarginTmp
        End With
    End If
End Sub
