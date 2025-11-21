VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmProcedure 
   Caption         =   "Procedure"
   ClientHeight    =   8730
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9270
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8730
   ScaleWidth      =   9270
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdDeleteFile 
      Caption         =   "Del File"
      Height          =   345
      Left            =   8160
      TabIndex        =   15
      Top             =   4815
      Width           =   975
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgSubSections 
      Height          =   3015
      Left            =   60
      TabIndex        =   14
      Top             =   5250
      Width           =   9120
      _cx             =   16087
      _cy             =   5318
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
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   4
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   260
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmProcedure.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   2
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   2
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
   Begin MSComDlg.CommonDialog cdFile 
      Left            =   690
      Top             =   8370
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.TextBox txtFilename 
      Height          =   330
      Left            =   1005
      MaxLength       =   250
      TabIndex        =   12
      Top             =   4815
      Width           =   6660
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "..."
      Height          =   345
      Left            =   7680
      TabIndex        =   11
      Top             =   4815
      Width           =   375
   End
   Begin VB.CommandButton fndQuestionCode 
      Height          =   315
      Left            =   1500
      Picture         =   "frmProcedure.frx":0090
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   390
      Width           =   345
   End
   Begin VB.Frame frameProcedureName 
      Height          =   1485
      Left            =   75
      TabIndex        =   0
      Top             =   0
      Width           =   9105
      Begin VB.TextBox txtQuestion 
         Height          =   465
         Left            =   105
         MultiLine       =   -1  'True
         TabIndex        =   8
         Top             =   915
         Width           =   8880
      End
      Begin VB.TextBox txtCode 
         Height          =   315
         Left            =   105
         TabIndex        =   5
         Top             =   390
         Width           =   1290
      End
      Begin VB.TextBox txtProcedureType 
         Height          =   300
         Left            =   1830
         Locked          =   -1  'True
         TabIndex        =   2
         Top             =   390
         Width           =   2940
      End
      Begin VB.CommandButton fndProcedureTypeID 
         Height          =   315
         Left            =   4785
         Picture         =   "frmProcedure.frx":021A
         Style           =   1  'Graphical
         TabIndex        =   1
         Top             =   390
         Width           =   345
      End
      Begin VB.Label lblQuestion 
         AutoSize        =   -1  'True
         Caption         =   "Question"
         Height          =   195
         Left            =   105
         TabIndex        =   9
         Top             =   690
         Width           =   630
      End
      Begin VB.Label lblCode 
         AutoSize        =   -1  'True
         Caption         =   "Question Code"
         Height          =   195
         Left            =   90
         TabIndex        =   4
         Top             =   165
         Width           =   1050
      End
      Begin VB.Label lblProcedure 
         AutoSize        =   -1  'True
         Caption         =   "Procedure Type"
         Height          =   195
         Index           =   0
         Left            =   1830
         TabIndex        =   3
         Top             =   165
         Width           =   1140
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   1245
      Top             =   8295
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":03A4
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":04FE
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":0658
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":07B2
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":098C
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":0AE6
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":0CC0
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":0E1A
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":231C
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":24F6
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedure.frx":26D0
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   3165
      TabIndex        =   6
      Top             =   8310
      Width           =   6000
      _ExtentX        =   10583
      _ExtentY        =   582
      ButtonWidth     =   1984
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstCtrls"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&New"
            Key             =   "New"
            ImageKey        =   "New"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Delete"
            Key             =   "Delete"
            ImageKey        =   "Delete"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog CD 
      Left            =   105
      Top             =   8370
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgProc 
      Height          =   3180
      Left            =   60
      TabIndex        =   10
      Top             =   1515
      Width           =   9120
      _cx             =   16087
      _cy             =   5609
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
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   10
      Cols            =   4
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmProcedure.frx":28AA
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   0   'False
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   2
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
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Attachment"
      Height          =   195
      Left            =   105
      TabIndex        =   13
      Top             =   4845
      Width           =   810
   End
End
Attribute VB_Name = "frmProcedure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean, mlngMode As Long
Dim mStream As ADODB.Stream, strOldFile As String

Const grdColSlNo = 0
Const grdColAnswer = 1
Const grdColForeColor = 2
Const grdColIsFavourable = 3

Const grdSSecSelected = 0
Const grdSSecSubSection = 1
Const grdSSecSection = 2
Const grdSSecSubSectionID = 3

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    mblnModify = blnNewValue
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameProcedureName.Enabled = blnNewValue
    cmdBrowse.Enabled = blnNewValue
    txtFilename.Enabled = blnNewValue
    cmdDeleteFile.Enabled = blnNewValue
    fndQuestionCode.Enabled = Not blnNewValue
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get IsReadOnly() As Boolean
Dim sSql As String
    sSql = "Select * From UserGroupUsers Where UserID = " & pUserID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("UserGroupID") & "" = "1" Or .Fields("UserGroupID") & "" = "2" Then
                    IsReadOnly = False
                Else
                    IsReadOnly = True
                End If
                .MoveNext
            Wend
            .Close
        End With
End Property

Public Sub ClearValues()
    txtCode = ""
    txtCode.Tag = ""
    txtProcedureType = ""
    txtProcedureType.Tag = ""
    txtQuestion = ""
    txtFilename = ""
    strOldFile = ""
    FillSubSectionDetails
    vsfgProc.Rows = 1: vsfgProc.Rows = 10
End Sub

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub cmdBrowse_Click()
On Local Error Resume Next
Dim sString As String
    cdFile.Filter = "All Files (*.*)|*.*|JPEG Compressed Image(*.jpg)|*.jpg|Graphic Interchange Format (*.gif)|*.gif|Text Files (*.txt)|*.txt|Excel files(*.xls)|*.xls|Word FIles (*.doc)|*.doc|Microsoft Document Imaging(*.mdi)|*.mdi|PDF FIles (*.pdf)|*.pdf"
    cdFile.ShowOpen
    txtFilename = "" + LTrim(cdFile.FileTitle)
    sString = txtFilename
End Sub

Private Sub cmdDeleteFile_Click()
On Local Error GoTo Err_Exit
Dim sSql As String
    If IsModify Then
        If pMVE.MsgBox("Are you sure to delete template file.", msgYesNo, "AuditMate", msgQuestion, True) Then
            sSql = "Select * from ProcedureQuestions Where QuestionID = " & Val(txtCode.Tag)
            AdoConn.BeginTrans
            With GetRecords(sSql)
                If Not .EOF Then
                    .Fields("FileName") = ""
                    .Fields("TemplateFile") = Null
                    .Update
                End If
                .Close
            End With
            AdoConn.CommitTrans
            txtFilename = ""
        End If
    End If
Exit Sub
Err_Exit:
    AdoConn.RollbackTrans
End Sub

Private Sub fndProcedureTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpProcedureType, , "Name, XProcedureTypeID", txtProcedureType, fndProcedureTypeID, , , 1
End Sub

Private Sub fndQuestionCode_Click()
    ButtonHandling Me, "Open"
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub vsfgProc_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    PutSlNo vsfgProc, grdColSlNo, grdColAnswer
End Sub

Private Sub vsfgProc_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Not (mblnNew Or mblnModify) Then Cancel = True
End Sub

Private Sub vsfgProc_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
    Select Case Col
        Case grdColForeColor
            CD.ShowColor
            vsfgProc.Cell(flexcpBackColor, Row, grdColForeColor) = CD.Color
            vsfgProc.Cell(flexcpText, Row, grdColForeColor) = CD.Color
    End Select
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsSave As New Recordset, Inc As Long
Dim IsInTrans As Boolean, lngQuestionID As Long
Dim rsTmp As New Recordset
    If Trim(txtCode) = "" Then
        pMVE.MsgBox "Procedure Code Not Mentioned", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    If Trim(txtProcedureType) = "" Then
        pMVE.MsgBox "Procedure Type Not Mentioned", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    AdoConn.BeginTrans
    IsInTrans = True
    lngQuestionID = Val(txtCode.Tag)
    sSql = "Select * From ProcedureQuestions Where QuestionID = " & lngQuestionID
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            lngQuestionID = GetMaxNo("ProcedureQuestions", "QuestionID")
            .Fields("QuestionID") = lngQuestionID
        End If
        .Fields("QuestionCode") = txtCode.Text
        .Fields("ProcedureTypeID") = Val(txtProcedureType.Tag)
        .Fields("Question") = txtQuestion.Text
        If txtFilename <> "" Then
            .Fields("FileName") = txtFilename.Text
        End If
        '---File---------------------
        If Trim(UCase(strOldFile)) <> Trim(UCase(txtFilename)) And txtFilename <> "" Then
            Set mStream = New ADODB.Stream
            mStream.Type = adTypeBinary
            mStream.Open
            mStream.LoadFromFile txtFilename
            .Fields("TemplateFile").Value = mStream.Read
        End If
        '----------------------------
        SaveDateAndUser rsSave, IsNew
        .Update
        .Close
    End With
    sSql = "DELETE From ProcedureAnswers Where QuestionID = " & lngQuestionID
    AdoConn.Execute sSql
    sSql = "Select * From ProcedureAnswers Where QuestionID = " & lngQuestionID
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgProc.Rows - 1
            If vsfgProc.ValueMatrix(Inc, grdColSlNo) <> 0 Then
                .AddNew
                .Fields("QuestionID") = lngQuestionID
                .Fields("AnswerID") = vsfgProc.TextMatrix(Inc, grdColSlNo) & ""
                .Fields("Description") = vsfgProc.TextMatrix(Inc, grdColAnswer) & ""
                .Fields("ForeColor") = vsfgProc.ValueMatrix(Inc, grdColForeColor) & ""
                .Fields("IsFavourable") = vsfgProc.ValueMatrix(Inc, grdColIsFavourable) & ""
                .Update
            End If
        Next Inc
        .Close
    End With
    sSql = "DELETE From ProcedureQuestionsSub Where QuestionID = " & lngQuestionID
    AdoConn.Execute sSql
    sSql = "Select * From ProcedureQuestionsSub Where QuestionID = " & lngQuestionID
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgSubSections.Rows - 1
            If vsfgSubSections.ValueMatrix(Inc, grdSSecSelected) <> 0 Then
                .AddNew
                .Fields("SubSectionID") = vsfgSubSections.ValueMatrix(Inc, grdSSecSubSectionID) & ""
                .Fields("QuestionID") = lngQuestionID
                .Update
            End If
        Next Inc
        .Close
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTrans Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Save = False
End Function

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpQuestions, , "XQuestionID", , fndQuestionCode, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtCode.Tag = lngID
        End If
    Else
        strRslt = lngID
        txtCode.Tag = lngID
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(lngID)
        ShowOpen = True
    End Select
End Function

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are You Sure To Delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "DELETE FROM ProcedureAnswers WHERE QuestionID = " & Val(txtCode.Tag)
    AdoConn.Execute sSql
    sSql = "DELETE FROM ProcedureQuestionsSub WHERE QuestionID = " & Val(txtCode.Tag)
    AdoConn.Execute sSql
    sSql = "DELETE FROM ProcedureQuestions WHERE QuestionID = " & Val(txtCode.Tag)
    AdoConn.Execute sSql
    AdoConn.CommitTrans
    Delete = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Delete = False
End Function

Public Function ValueCollect(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, rsTmp As New ADODB.Recordset
    ClearValues
    sSql = "SELECT PRC.*, PRT.ProcedureTypeName FROM ProcedureQuestions PRC, ProcedureTypes PRT WHERE PRC.ProcedureTypeID = PRT.ProcedureTypeID " & _
           "AND PRC.QuestionID = " & lngID
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        If Not .EOF Then
            txtCode.Tag = lngID
            txtCode = .Fields("QuestionCode") & ""
            txtProcedureType = .Fields("ProcedureTypeName") & ""
            txtProcedureType.Tag = Val(.Fields("ProcedureTypeID") & "")
            txtQuestion = .Fields("Question") & ""
            txtFilename = .Fields("FileName") & ""
            strOldFile = txtFilename
        End If
        .Close
    End With
    'Getting Columns
    sSql = "SELECT *  FROM ProcedureAnswers WHERE QuestionId= " & lngID
    With GetRecords(sSql)
        If Not .EOF Then
            While Not .EOF
                vsfgProc.Rows = vsfgProc.Rows + 1: Inc = Inc + 1
                vsfgProc.TextMatrix(Inc, grdColSlNo) = Val(.Fields("AnswerID") & "")
                vsfgProc.TextMatrix(Inc, grdColAnswer) = .Fields("Description") & ""
                vsfgProc.TextMatrix(Inc, grdColForeColor) = IIf(Val(.Fields("Forecolor") & "") = 0, "", Val(.Fields("Forecolor") & ""))
                vsfgProc.Cell(flexcpBackColor, Inc, grdColForeColor) = IIf(Val(.Fields("Forecolor") & "") = 0, vbBlack, Val(.Fields("Forecolor") & ""))
                vsfgProc.TextMatrix(Inc, grdColIsFavourable) = IIf(.Fields("IsFavourable") & "" = "True", -1, 0)
                .MoveNext
            Wend
        Else
            vsfgProc.Rows = 1: vsfgProc.Rows = 10
      End If
    End With
    sSql = "SELECT *  FROM ProcedureQuestionsSub WHERE QuestionId= " & lngID
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgSubSections.Rows - 1
                If vsfgSubSections.ValueMatrix(Inc, grdSSecSubSectionID) = Val(.Fields("SubSectionID") & "") Then
                    vsfgSubSections.TextMatrix(Inc, grdSSecSelected) = -1
                    Exit For
                End If
            Next Inc
            .MoveNext
        Wend
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub vsfgProc_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        vsfgProc.TextMatrix(vsfgProc.Row, vsfgProc.Col) = ""
    End If
End Sub

Public Sub FillSubSectionDetails()
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String
    sSql = "SELECT  FSS.Description AS SubSectionName, FS.Description AS SectionName, FSS.SubSectionID AS SubSectionID " & _
           "FROM    FilingSubSection FSS LEFT OUTER JOIN FilingSections FS ON FSS.SectionID = FS.SectionID Order By SubSectionName"
    vsfgSubSections.Rows = 1
    With GetRecords(sSql)
        While Not .EOF
            vsfgSubSections.Rows = vsfgSubSections.Rows + 1
            Inc = vsfgSubSections.Rows - 1
            vsfgSubSections.TextMatrix(Inc, grdSSecSubSection) = .Fields("SubSectionName") & ""
            vsfgSubSections.TextMatrix(Inc, grdSSecSection) = .Fields("SectionName") & ""
            vsfgSubSections.TextMatrix(Inc, grdSSecSubSectionID) = .Fields("SubSectionID") & ""
            .MoveNext
        Wend
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgSubSections_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Not (IsNew Or IsModify) Then
        Cancel = True
        Exit Sub
    End If
    Select Case Col
        Case grdSSecSelected
        Case Else
            Cancel = True
    End Select
End Sub
