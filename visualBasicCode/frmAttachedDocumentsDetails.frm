VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmAttachedDocumentsDetails 
   Caption         =   "Attached Documents Details"
   ClientHeight    =   8385
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14475
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8385
   ScaleWidth      =   14475
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgAttachedDoc 
      Height          =   5490
      Left            =   45
      TabIndex        =   0
      Top             =   105
      Width           =   14370
      _cx             =   25347
      _cy             =   9684
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      BackColorFixed  =   -2147483633
      ForeColorFixed  =   -2147483630
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   1
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   1
      Cols            =   1
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   320
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmAttachedDocumentsDetails.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   1
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   5
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   0
      ShowComboButton =   1
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      DataMode        =   0
      VirtualData     =   -1  'True
      DataMember      =   ""
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
End
Attribute VB_Name = "frmAttachedDocumentsDetails"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Const grdAttachedIcon = 0
Const grdAttachedSubSection = 1
Const grdAttachedParticulars = 2
Const grdAttachedDocument = 3
Const grdAttachedLinkDescription = 4
Const grdAttachedFileDescription = 5
Const grdAttachedFileSize = 6
Const grdAttachedDocID = 7
Const grdAttachedSubSectionID = 8
Const grdAttachedAcTypeID = 9
Const grdAttachedAcID = 10
Const grdAttachedProcedureID = 11
Const grdAttachedDoc = 12
Const grdAttachedCols = 13

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID & " AND UserID = " & pUserID
        With GetRecords(sSql1)
            If Not .EOF Then
                If .Fields("IsBlocked") = True Then
                    IsReadOnly = True
                Else
                    IsReadOnly = False
                End If
            Else
                IsReadOnly = True
            End If
            .Close
        End With
    sSql = "Select DetachedBy From Companies Where CompanyID = " & pActiveCompanyID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("DetachedBy") <> "" Then
                    IsReadOnly = True
                End If
                .MoveNext
            Wend
            .Close
        End With
'    sSql3 = "Select FinalisedBy From Periods Where PeriodID = " & pActivePeriodID
'        With GetRecords(sSql3)
'            While Not .EOF
'                If .Fields("FinalisedBy") <> "" Then
'                    IsReadOnly = True
'                End If
'                .MoveNext
'            Wend
'            .Close
'        End With
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
Dim sSql As String
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
    ShowAttachedDocuments
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub SetPicture(Row As Long, Col As Long, strExt As String, VSFG As VSFlexGrid)
On Local Error Resume Next
    strExt = LCase(strExt)
    Err.Clear
    VSFG.Cell(flexcpPicture, Row, Col) = Nothing
    VSFG.Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
    If Err.Number <> 0 Then
        VSFG.Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
    End If
End Sub

Public Sub ShowAttachedDocuments()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strParticulars As String
Dim strFileSize As String, lngActualFileSize As Long, strFile As String

    sSql = "SELECT    FSS.Description AS SubSection, " & _
                "(SELECT   AcTypeDescription FROM AcTypes AT WHERE AT.AcTypeID = DSL.AcTypeID) AS AcTypeDescription, " & _
                "(SELECT   AcName FROM AcHeads AH WHERE AH.AcID = DSL.AcID) AS AcName, " & _
                "(SELECT   PQ.Question FROM ProcedureQuestions PQ WHERE PQ.QuestionID = DSL.ProcedureID) AS ProcedureName, " & _
                "          DSL.RefNo, DSL.Description, DB.FileName, DB.Description AS DocumentName, DB.FileExt, DB.DocFile, DB.DocSize, " & _
                "          DSL.SubSectionID, DSL.PeriodID, DSL.ProcedureID, DSL.AcTypeID, DSL.AcID,  DSL.DocumentID " & _
                "FROM      DocumentSubLinks DSL INNER JOIN FilingSubSection FSS ON DSL.SubSectionID = FSS.SubSectionID INNER JOIN " & _
                "          AuditDocument.dbo.DocumentBin DB ON DB.DocumentID = DSL.DocumentID Where (DSL.PeriodID = " & mPeriodID & ") AND DSL.ResourceID Is NULL " & _
                "Order By  DSL.DocLinkID"
    vsfgAttachedDoc.Rows = 1
    With GetRecords(sSql, AdoConn)
        While Not .EOF
            strFile = ""
            strFileSize = ""
            lngActualFileSize = 0
            vsfgAttachedDoc.Rows = vsfgAttachedDoc.Rows + 1
            Inc = vsfgAttachedDoc.Rows - 1
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedDocument) = .Fields("FileName") & ""
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedSubSection) = .Fields("SubSection") & ""
            
            If .Fields("AcTypeDescription") & "" <> "" Then
                strParticulars = "Account Type : " & .Fields("AcTypeDescription") & ""
            ElseIf .Fields("AcName") & "" <> "" Then
                strParticulars = "Account Head : " & .Fields("AcName") & ""
            ElseIf .Fields("ProcedureName") & "" <> "" Then
                strParticulars = "Procedures : " & .Fields("ProcedureName") & ""
            End If
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedParticulars) = strParticulars
'            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedRefNo) = .Fields("RefNo") & ""
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedLinkDescription) = .Fields("Description") & ""
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedFileDescription) = .Fields("DocumentName") & ""
'            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedDoc) = .Fields("DocFile") & ""
'            strFile = .Fields("DocFile") & ""
'            strFileSize = FileLen(strFile)
'            lngActualFileSize = Val(strFileSize) / 1024
'            lngActualFileSize = Round(lngActualFileSize, 1)
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedFileSize) = .Fields("DocSize") & ""
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedDocID) = Val(.Fields("DocumentID") & "")
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedSubSectionID) = Val(.Fields("SubSectionID") & "")
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedAcTypeID) = Val(.Fields("AcTypeID") & "")
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedAcID) = Val(.Fields("AcID") & "")
            vsfgAttachedDoc.TextMatrix(Inc, grdAttachedProcedureID) = Val(.Fields("ProcedureID") & "")
            SetPicture Inc, grdAttachedIcon, Trim(.Fields("FileExt") & ""), vsfgAttachedDoc
            .MoveNext
        Wend
        If vsfgAttachedDoc.Rows > 1 Then
            vsfgAttachedDoc.Cell(flexcpPictureAlignment, 1, grdAttachedIcon, vsfgAttachedDoc.Rows - 1, grdAttachedIcon) = flexAlignCenterCenter
            vsfgAttachedDoc.Cell(flexcpForeColor, 1, grdAttachedDocument, vsfgAttachedDoc.Rows - 1, grdAttachedDocument) = RGB(100, 100, 255)
            vsfgAttachedDoc.Cell(flexcpFontBold, 1, grdAttachedDocument, vsfgAttachedDoc.Rows - 1, grdAttachedDocument) = True
            
            vsfgAttachedDoc.Cell(flexcpForeColor, 1, grdAttachedParticulars, vsfgAttachedDoc.Rows - 1, grdAttachedParticulars) = RGB(255, 100, 100)
            vsfgAttachedDoc.Cell(flexcpFontBold, 1, grdAttachedParticulars, vsfgAttachedDoc.Rows - 1, grdAttachedParticulars) = True
            
            vsfgAttachedDoc.Cell(flexcpForeColor, 1, grdAttachedFileDescription, vsfgAttachedDoc.Rows - 1, grdAttachedFileDescription) = RGB(255, 180, 0)
            vsfgAttachedDoc.Cell(flexcpFontBold, 1, grdAttachedFileDescription, vsfgAttachedDoc.Rows - 1, grdAttachedFileDescription) = True
        End If
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub Form_Load()
    With vsfgAttachedDoc
        .Width = GetProportionalValue(15400, False)
        .Height = GetProportionalValue(9900)
        
        .Cols = grdAttachedCols
        
        .ColWidth(grdAttachedIcon) = 400
        .ColWidth(grdAttachedSubSection) = 2000
        .ColWidth(grdAttachedParticulars) = 3000
        .ColWidth(grdAttachedFileSize) = 800
        .ColWidth(grdAttachedDocument) = 3000
        .ColWidth(grdAttachedLinkDescription) = 3000
        .ColWidth(grdAttachedFileDescription) = 2500
        
        .ColHidden(grdAttachedDocID) = True
        .ColHidden(grdAttachedAcTypeID) = True
        .ColHidden(grdAttachedAcID) = True
        .ColHidden(grdAttachedProcedureID) = True
        .ColHidden(grdAttachedSubSectionID) = True
        .ColHidden(grdAttachedDoc) = True
        
        .TextMatrix(0, grdAttachedSubSection) = "Sub Section"
        .TextMatrix(0, grdAttachedParticulars) = "Linked to"
        .TextMatrix(0, grdAttachedFileSize) = "File Size"
        .TextMatrix(0, grdAttachedDocument) = "Filename"
        .TextMatrix(0, grdAttachedLinkDescription) = "Linking Description"
        .TextMatrix(0, grdAttachedFileDescription) = "File Description"
    End With
End Sub

Private Sub Form_Resize()
    WindowState = vbMaximized
End Sub

Private Sub vsfgAttachedDoc_DblClick()
On Local Error GoTo Err_Exit
Dim strIDType As String, lngID As Long
    With vsfgAttachedDoc
        If .ValueMatrix(.Row, grdAttachedAcTypeID) <> 0 Then
            strIDType = "ACCOUNTTYPE"
            lngID = .ValueMatrix(.Row, grdAttachedAcTypeID)
        ElseIf .ValueMatrix(.Row, grdAttachedAcID) <> 0 Then
            strIDType = "ACCOUNTHEAD"
            lngID = .ValueMatrix(.Row, grdAttachedAcID)
        ElseIf .ValueMatrix(.Row, grdAttachedProcedureID) <> 0 Then
            strIDType = "PROCEDURES"
            lngID = .ValueMatrix(.Row, grdAttachedProcedureID)
        End If
        '-----------------------------------------------------------------------------------------------------
        If .Row > 0 Then
            Select Case .Col
            Case grdAttachedDocument
                OpenDocumentFile .TextMatrix(.Row, grdAttachedDocument), .ValueMatrix(.Row, grdAttachedDocID)
            Case grdAttachedParticulars
                ShowRelatedDocuments .ValueMatrix(.Row, grdAttachedSubSectionID), mPeriodID, strIDType, lngID
                ShowAttachedDocuments
            Case grdAttachedFileDescription
                ShowDocument .ValueMatrix(.Row, grdAttachedDocID)
            End Select
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgAttachedDoc_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgAttachedDoc.ToolTipText = vsfgAttachedDoc.Text
End Sub

Private Sub vsfgAttachedDoc_RowColChange()
    SelectRow vsfgAttachedDoc, , , RGB(220, 220, 250)
End Sub
