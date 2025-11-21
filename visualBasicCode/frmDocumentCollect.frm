VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmDocumentCollect 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Document Collection"
   ClientHeight    =   4560
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7275
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4560
   ScaleWidth      =   7275
   ShowInTaskbar   =   0   'False
   Begin MSComDlg.CommonDialog cdFile 
      Left            =   390
      Top             =   6840
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgDocuments 
      Height          =   2550
      Left            =   45
      TabIndex        =   15
      Top             =   4575
      Visible         =   0   'False
      Width           =   7215
      _cx             =   12726
      _cy             =   4498
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
      Rows            =   50
      Cols            =   10
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmDocumentCollect.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   2
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
      ExplorerBar     =   5
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   30
      Top             =   7320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":0123
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":027D
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":03D7
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":0531
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":070B
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":0865
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":0A3F
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":0B99
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":209B
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":2275
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":244F
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentCollect.frx":2629
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin VB.Frame frameDetails 
      Height          =   4110
      Left            =   30
      TabIndex        =   8
      Top             =   0
      Width           =   7185
      Begin VB.ComboBox cmbDocType 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "frmDocumentCollect.frx":301A
         Left            =   5400
         List            =   "frmDocumentCollect.frx":3024
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1070
         Width           =   1575
      End
      Begin VB.TextBox txtFileSize 
         Height          =   315
         Left            =   5640
         Locked          =   -1  'True
         MaxLength       =   20
         TabIndex        =   2
         Top             =   450
         Width           =   1335
      End
      Begin VB.TextBox txtDescription 
         Height          =   315
         Left            =   240
         MaxLength       =   250
         TabIndex        =   3
         Top             =   1070
         Width           =   5050
      End
      Begin VB.TextBox txtCompany 
         Height          =   315
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   9
         Top             =   3555
         Width           =   6315
      End
      Begin VB.CommandButton fndCompany 
         Height          =   300
         Left            =   6585
         Picture         =   "frmDocumentCollect.frx":303E
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   3555
         Width           =   345
      End
      Begin VB.CommandButton cmdBrowse 
         Caption         =   "..."
         Height          =   330
         Left            =   4920
         TabIndex        =   0
         Top             =   450
         Width           =   375
      End
      Begin VB.TextBox txtMetaFile 
         Height          =   1095
         Left            =   240
         MaxLength       =   5000
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   5
         Top             =   1635
         Width           =   6735
      End
      Begin VB.TextBox txtFilename 
         Height          =   330
         Left            =   240
         Locked          =   -1  'True
         MaxLength       =   250
         TabIndex        =   1
         Top             =   450
         Width           =   4650
      End
      Begin VB.TextBox txtCollectedVia 
         Height          =   315
         Left            =   240
         MaxLength       =   50
         TabIndex        =   6
         Top             =   2985
         Width           =   4425
      End
      Begin MSComCtl2.DTPicker dtpCollectDt 
         Height          =   315
         Left            =   4750
         TabIndex        =   20
         Top             =   3000
         Width           =   2250
         _ExtentX        =   3969
         _ExtentY        =   556
         _Version        =   393216
         CustomFormat    =   "dd/MM/yyyy HH:mm:ss tt"
         Format          =   117899267
         CurrentDate     =   39333
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Document Type"
         Height          =   195
         Index           =   7
         Left            =   5400
         TabIndex        =   19
         Top             =   840
         Width           =   1380
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "File Size"
         Height          =   195
         Index           =   6
         Left            =   5670
         TabIndex        =   17
         Top             =   240
         Width           =   585
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Collected Date && Time"
         Height          =   195
         Index           =   5
         Left            =   4750
         TabIndex        =   16
         Top             =   2775
         Width           =   1575
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Collected Via"
         Height          =   195
         Index           =   4
         Left            =   240
         TabIndex        =   14
         Top             =   2775
         Width           =   930
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Company"
         Height          =   195
         Index           =   3
         Left            =   240
         TabIndex        =   13
         Top             =   3345
         Width           =   660
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Meta File"
         Height          =   195
         Index           =   2
         Left            =   240
         TabIndex        =   12
         Top             =   1425
         Width           =   645
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "File Name"
         Height          =   195
         Index           =   1
         Left            =   240
         TabIndex        =   11
         Top             =   240
         Width           =   705
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Description"
         Height          =   195
         Index           =   0
         Left            =   240
         TabIndex        =   10
         Top             =   840
         Width           =   795
      End
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   1185
      TabIndex        =   18
      Top             =   4200
      Width           =   6030
      _ExtentX        =   10636
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
End
Attribute VB_Name = "frmDocumentCollect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim rsDoc As ADODB.Recordset
Dim mStream As ADODB.Stream
Public lngID As Long, FileExt As String
Dim mblnModify As Boolean
Dim mblnNew As Boolean, strOldFile As String
Dim mCompanyID As Long, mPeriodID As Long, mDefaultPeriodID As Long
Dim mlngFileLen As Long

Const grdCode = 0
Const grdDescription = 1
Const grdFileExt = 2
Const grdFileName = 3
Const grdCompanyName = 4
Const grdCollecteddate = 5
Const grdDocumentID = 6

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
        ClearValues
        lngID = 0
        txtDescription.SetFocus
        cmbDocType.Text = "Temporary"
    Else
        ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         txtDescription.SetFocus
         Highlight
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
Dim sSql As String
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    mPeriodID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal blnNewValue As Long)
    mCompanyID = blnNewValue
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    dtpCollectDt = ServerDateTime
    strOldFile = ""
'    DisplayDataInGrid
    If mCompanyID <> 0 Then
        txtCompany.Tag = mCompanyID
        txtCompany = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID)
    End If
    lngID = 0
End Sub

Private Sub cmdBrowse_Click()
On Local Error Resume Next
Dim sString As String, strDescription As String, strExt As String
Dim strFileLen As String, lngFileLen As Long
    cdFile.InitDir = "C:\My Documents"
    cdFile.Filter = "All Files (*.*)|*.*|JPEG Compressed Image(*.jpg)|*.jpg|Graphic Interchange Format (*.gif)|*.gif|Text Files (*.txt)|*.txt|Excel files(*.xls)|*.xls|Word FIles (*.doc)|*.doc|Microsoft Document Imaging(*.mdi)|*.mdi|PDF FIles (*.pdf)|*.pdf"
    cdFile.ShowOpen
    txtFilename = "" + LTrim(cdFile.FileTitle)
    sString = txtFilename
    strExt = GetExtension(sString, True)
    strFileLen = FileLen(txtFilename)
    lngFileLen = Val(strFileLen) / 1024
    mlngFileLen = lngFileLen
    txtFileSize = lngFileLen & " kb"
    strDescription = Replace(txtFilename, strExt, "")
    txtDescription = strDescription
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, rsSave As ADODB.Recordset
Dim strCompanyCode As String
    'Ref No: 016-12/07/09, Sunday 12 July 2009 -------------
    strCompanyCode = PickValue("Companies", "CompanyCode", "CompanyID = " & pActiveCompanyID)

    FileExt = Mid(txtFilename, InStr(1, txtFilename, ".") + 1)
    If Trim(txtDescription) = "" Then
        pMVE.MsgBox "Description Not Mentioned.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    If Trim(txtFilename) = "" Then
        pMVE.MsgBox "File Name Not Mentioned.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    If Val(txtCompany.Tag) = 0 Then
        pMVE.MsgBox "Company Name Not Mentioned.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    If mlngFileLen > "1024" Then
        pMVE.MsgBox "File size exceeded the limit provided. Please Correct it And Try Again.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    '--------------------------------------------------------------------------------------
    AdoConnDoc.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords("Select * From  DocumentBin Where DocumentID = " & lngID, AdoConnDoc)
    With rsSave
        If .EOF Then
            .AddNew
'            If pServer = pServerLocal Then
'                lngID = GetRangeMaxNo("DocumentBin", "DocumentID", mPeriodID * cnstDocIDLocalMaxCount, (mPeriodID * cnstDocIDLocalMaxCount) + cnstDocIDLocalMaxCount, AdoConnDoc)
'            Else
'                lngID = GetRangeMaxNo("DocumentBin", "DocumentID", mPeriodID * cnstDocIDMaxCount, (mPeriodID * cnstDocIDMaxCount) + cnstDocIDMaxCount, AdoConnDoc)
'            End If
            'Ref No: 016-12/07/09, Sunday 12 July 2009 -------------
            If pServer = pServerLocal Then
                lngID = GetRangeMaxNo("DocumentBin", "DocumentID", strCompanyCode * cnstDocIDLocalMaxCount, (strCompanyCode * cnstDocIDLocalMaxCount) + cnstDocIDLocalMaxCount, AdoConnDoc)
            Else
                lngID = GetRangeMaxNo("DocumentBin", "DocumentID", strCompanyCode * cnstDocIDMaxCount, (strCompanyCode * cnstDocIDMaxCount) + cnstDocIDMaxCount, AdoConnDoc)
            End If
'            lngID = GetMaxNo("DocumentBin", "DocumentID", , AdoConnDoc)
            .Fields("DocumentID") = lngID
            .Fields("IsRead") = False
            .Fields("IsCheckOut") = False
            .Fields("CheckOutPath") = ""
        End If
        .Fields("Documentcode") = 0
        .Fields("CompanyID") = Val(txtCompany.Tag)
        .Fields("FileName") = txtFilename.Text
        .Fields("DocumentType") = IIf(cmbDocType.Text = "Permanent", 1, 0)
        .Fields("Description") = txtDescription
        .Fields("Metafile") = txtMetaFile
        .Fields("CollectedVia") = txtCollectedVia
        .Fields("CollectedDate") = dtpCollectDt
        .Fields("FileExt") = Left(FileExt, 10)
        .Fields("DocSize") = txtFileSize
        If Trim(UCase(strOldFile)) <> Trim(UCase(txtFilename)) Then
            Set mStream = New ADODB.Stream
            mStream.Type = adTypeBinary
            mStream.Open
            mStream.LoadFromFile txtFilename
            .Fields("Docfile").Value = mStream.Read
        End If
        SaveDateAndUser rsSave, IsNew
        .Update
        .Close
    End With
    AdoConnDoc.CommitTrans
    Save = True
'    DisplayDataInGrid
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConnDoc.RollbackTrans
    End If
    ShowError
End Function

Private Sub fndCompany_Click()
    PrepareAndFind cnstSearchTypeGrpCompany, , "Name, XCompanyID", txtCompany, fndCompany
End Sub

Private Sub Form_Load()
    Align Me
    ClearValues
    ButtonHandling Me
'    DisplayDataInGrid
    VsfgDocuments.CellPictureAlignment = flexPicAlignStretch
    dtpCollectDt.Enabled = False
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub txtCompany_KeyDown(KeyCode As Integer, Shift As Integer)
    fndCompany_Click
End Sub

'Public Function DisplayDataInGrid()
'On Local Error GoTo Err_exit
'    VsfgDocuments.Rows = 1
'    Set rsDoc = New ADODB.Recordset
'    rsDoc.CursorLocation = adUseClient
'    Dim sSql As String, Inc As Long
'    Dim FileExt As String
'    sSql = "SELECT DocumentBin.DocumentCode AS Code, DocumentBin.Description, DocumentBin.FileName, DocumentBin.FileExt,eAuditMain.dbo.Companies.CompanyName ,DocumentBin.CollectedDate,DocumentBin.DocumentID, DocumentBin.CollectedVia, DocumentBin.MetaFile FROM DocumentBin LEFT OUTER JOIN " & _
'           "eAuditMain.dbo.Companies ON DocumentBin.CompanyID = eAuditMain.dbo.Companies.CompanyID ORDER BY DocumentBin.UpdateDate DESC"
'    Inc = 1
'    With GetRecords(sSql, AdoConnDoc)
'        While .EOF <> True
'            VsfgDocuments.Rows = VsfgDocuments.Rows + 1
'            VsfgDocuments.TextMatrix(Inc, grdCode) = .Fields("Code") & ""
'            VsfgDocuments.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
'            VsfgDocuments.TextMatrix(Inc, grdFileName) = .Fields("FileName") & ""
'            SetExtPic Inc, Trim(.Fields("FileExt") & "")
'            VsfgDocuments.TextMatrix(Inc, grdCompanyName) = .Fields("CompanyName") & ""
'            VsfgDocuments.TextMatrix(Inc, grdCollecteddate) = .Fields("CollectedDate") & ""
'            VsfgDocuments.TextMatrix(Inc, grdDocumentID) = .Fields("DocumentId") & ""
'            Inc = Inc + 1
'            .MoveNext
'        Wend
'    End With
'Exit Function
'Err_exit:
'    ShowError
'End Function

Public Sub SetExtPic(Row As Long, strExt As String)
On Local Error Resume Next
    strExt = LCase(strExt)
    Err.Clear
    VsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = Nothing
    VsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
    If Err.Number <> 0 Then
        VsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
    End If
End Sub

Private Sub vsfgDocuments_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub
Private Sub VsfgDocuments_DblClick()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(ByVal DocID As Variant) As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, strFileLen As String, lngFileLen As Long
    Dim sSql As String
    With VsfgDocuments
        lngID = DocID '.ValueMatrix(.Row, grdDocumentID)
        If lngID = 0 Then
            ShowOpen = False
            Exit Function
        End If
        sSql = "SELECT DocumentBin.DocumentCode AS Code, DocumentBin.Description, DocumentBin.CompanyID, DocumentBin.FileName, DocumentBin.FileExt,DocumentBin.DocumentType, AuditMain.dbo.Companies.CompanyName ,DocumentBin.CollectedDate,DocumentBin.DocumentID, DocumentBin.CollectedVia, DocumentBin.MetaFile FROM DocumentBin LEFT OUTER JOIN  AuditMain.dbo.Companies ON DocumentBin.CompanyID = AuditMain.dbo.Companies.CompanyID where DocumentBin.DocumentID =" & lngID & "   ORDER BY DocumentBin.UpdateDate DESC"
        With GetRecords(sSql, AdoConnDoc)
            If Not .EOF Then
'                txtDocCode.Text = .Fields("Code") & ""
                txtDescription.Text = .Fields("Description") & ""
                txtFilename = .Fields("fileName") & ""
'                strFileLen = FileLen(txtFilename)
'                lngFileLen = Val(strFileLen) / 1024
'                txtFileSize = lngFileLen & " kb"
                strOldFile = txtFilename
                txtCompany = .Fields("CompanyName") & ""
                txtCompany.Tag = .Fields("CompanyID") & ""
                txtCollectedVia.Text = .Fields("CollectedVia") & ""
                dtpCollectDt.Value = .Fields("CollectedDate") & ""
                txtMetaFile.Text = .Fields("Metafile") & ""
                cmbDocType.Text = IIf(.Fields("DocumentType") & "", "Permanent", "Temporary")
            Else
                ShowError "Not a valid record!"
            End If
        End With
    End With
    ShowOpen = True
Exit Function
Err_Exit:
    ShowError
End Function

'Ref No: 066-07/02/09 -------------
Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
    Dim sSql As String
    If pMVE.MsgBox("Delete " & txtFilename.Text & "", msgYesNo, "AuditMate", msgQuestion, True) Then
        sSql = "Select * From DocumentSubLinks Where DocumentID = " & lngID
        With GetRecords(sSql)
            If Not .EOF Then
                pMVE.MsgBox "Document is linked to the filing section. Could not delete", msgOK, "AuditMate", msgInformation, True
                Exit Function
            Else
                sSql = "Delete From DocumentBin Where DocumentID =" & lngID
                AdoConnDoc.BeginTrans
                AdoConnDoc.Execute sSql
                AdoConnDoc.CommitTrans
                Delete = True
            End If
        End With
'        sSql = "Delete From DocumentBin Where DocumentID =" & lngID
'        AdoConnDoc.BeginTrans
'        AdoConnDoc.Execute sSql
'        AdoConnDoc.CommitTrans
'        Delete = True
    Else
        Delete = False
    End If
Exit Function
Err_Exit:
    AdoConnDoc.RollbackTrans
    ShowError
    Delete = False
End Function

Private Sub vsfgDocuments_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    VsfgDocuments.ToolTipText = VsfgDocuments.Text
End Sub

Private Sub vsfgDocuments_RowColChange()
    SelectRow VsfgDocuments
End Sub

Public Sub ShowSpecifiedDocument(lngDocID As Long)
On Local Error Resume Next
    If lngDocID > 0 Then
        ButtonHandling Me, "Open", lngDocID
    Else
        ButtonHandling Me, "New"
    End If
End Sub
