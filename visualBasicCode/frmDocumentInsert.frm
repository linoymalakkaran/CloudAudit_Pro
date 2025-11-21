VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmDocumentInsert 
   Caption         =   "Form1"
   ClientHeight    =   4650
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7290
   LinkTopic       =   "Form1"
   ScaleHeight     =   4650
   ScaleWidth      =   7290
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frameDetails 
      Height          =   4110
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7185
      Begin VB.TextBox TxtCollectedVia 
         Height          =   315
         Left            =   240
         MaxLength       =   50
         TabIndex        =   8
         Top             =   2985
         Width           =   4425
      End
      Begin VB.TextBox txtFilename 
         Height          =   330
         Left            =   240
         MaxLength       =   250
         TabIndex        =   7
         Top             =   1050
         Width           =   6330
      End
      Begin VB.TextBox TxtMetaFile 
         Height          =   1095
         Left            =   240
         MaxLength       =   5000
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   6
         Top             =   1635
         Width           =   6735
      End
      Begin VB.CommandButton cmdBrowse 
         Caption         =   "..."
         Height          =   345
         Left            =   6600
         TabIndex        =   5
         Top             =   1050
         Width           =   375
      End
      Begin VB.CommandButton fndCompany 
         Height          =   300
         Left            =   6585
         Picture         =   "frmDocumentInsert.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   3555
         Width           =   345
      End
      Begin VB.TextBox txtCompany 
         Height          =   315
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   3
         Top             =   3555
         Width           =   6315
      End
      Begin VB.TextBox txtDescription 
         Height          =   315
         Left            =   255
         MaxLength       =   250
         TabIndex        =   2
         Top             =   420
         Width           =   5355
      End
      Begin VB.TextBox txtDocCode 
         Height          =   315
         Left            =   5640
         MaxLength       =   20
         TabIndex        =   1
         Top             =   420
         Width           =   1335
      End
      Begin MSComCtl2.DTPicker dtpCollectDt 
         Height          =   315
         Left            =   4725
         TabIndex        =   9
         Top             =   2985
         Width           =   2250
         _ExtentX        =   3969
         _ExtentY        =   556
         _Version        =   393216
         CustomFormat    =   "dd/MM/yyyy HH:mm:ss tt"
         Format          =   52363267
         CurrentDate     =   39333
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Description"
         Height          =   195
         Index           =   0
         Left            =   285
         TabIndex        =   16
         Top             =   210
         Width           =   795
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "File Name"
         Height          =   195
         Index           =   1
         Left            =   240
         TabIndex        =   15
         Top             =   840
         Width           =   705
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Meta File"
         Height          =   195
         Index           =   2
         Left            =   240
         TabIndex        =   14
         Top             =   1425
         Width           =   645
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
         Caption         =   "Collected Via"
         Height          =   195
         Index           =   4
         Left            =   240
         TabIndex        =   12
         Top             =   2775
         Width           =   930
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Collected Date && Time"
         Height          =   195
         Index           =   5
         Left            =   4725
         TabIndex        =   11
         Top             =   2775
         Width           =   1575
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Code"
         Height          =   195
         Index           =   6
         Left            =   5670
         TabIndex        =   10
         Top             =   210
         Width           =   375
      End
   End
   Begin MSComDlg.CommonDialog cdFile 
      Left            =   3210
      Top             =   5010
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   660
      Top             =   4785
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
            Picture         =   "frmDocumentInsert.frx":018A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":02E4
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":043E
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":0598
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":0772
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":08CC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":0AA6
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":0C00
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":2102
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":22DC
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":24B6
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentInsert.frx":2690
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   195
      TabIndex        =   17
      Top             =   4200
      Width           =   6885
      _ExtentX        =   12144
      _ExtentY        =   582
      ButtonWidth     =   1746
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstCtrls"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
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
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Help"
            Key             =   "Help"
            ImageKey        =   "Help"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmDocumentInsert"
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

Const grdCode = 0
Const grdDescription = 1
Const grdFileExt = 2
Const grdFileName = 3
Const grdCompanyName = 4
Const grdCollecteddate = 9
Const grdDocumentID = 7
    
Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    dtpCollectDt = ServerDateTime
    strOldFile = ""
    'DisplayDataInGrid
    lngID = 0
End Sub

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         lngID = 0
         txtDescription.SetFocus
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

Private Sub cmdBrowse_Click()
On Local Error Resume Next
    Dim sString As String
    cdFile.InitDir = "C:\MyDocuments"
    cdFile.Filter = "All Files (*.*)|*.*|JPEG Compressed Image(*.jpg)|*.jpg|Graphic Interchange Format (*.gif)|*.gif|Text Files (*.txt)|*.txt|Excel files(*.xls)|*.xls|Word FIles (*.doc)|*.doc|Microsoft Document Imaging(*.mdi)|*.mdi|PDF FIles (*.pdf)|*.pdf"
    cdFile.ShowOpen
    txtFilename = "" + LTrim(cdFile.FileTitle)
    sString = txtFilename
End Sub

Public Function Save() As Boolean
On Error GoTo Err_Exit
Dim IsInTran As Boolean, rsSave As ADODB.Recordset
    FileExt = Mid(txtFilename, InStr(1, txtFilename, ".") + 1)
    If Trim(txtDescription) = "" Then
        pMVE.MsgBox "Description Not Mentioned.", msgOK, , msgCritical, True
        Save = False
        Exit Function
    End If
    If Trim(txtFilename) = "" Then
        pMVE.MsgBox "File Not Mentioned.", msgOK, , msgCritical, True
        Save = False
        Exit Function
    End If
    If Val(txtCompany.Tag) = 0 Then
        pMVE.MsgBox "Company Not Mentioned.", msgOK, , msgCritical, True
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
            lngID = GetMaxNo("DocumentBin", "DocumentID", , AdoConnDoc)
            .Fields("DocumentID") = lngID
        End If
        .Fields("Documentcode") = txtDocCode
        .Fields("CompanyID") = Val(txtCompany.Tag)
        .Fields("FileName") = txtFilename.Text
        .Fields("Description") = txtDescription
        .Fields("Metafile") = TxtMetaFile
        .Fields("CollectedVia") = TxtCollectedVia
        .Fields("CollectedDate") = dtpCollectDt
        .Fields("FileExt") = Left(FileExt, 10)
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
    pMVE.MsgBox "Document Uploaded Successfully.", msgOK, , msgInformation, True
    AdoConnDoc.CommitTrans
    Save = True
    'DisplayDataInGrid
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConnDoc.RollbackTrans
    End If
    ShowError
End Function

Private Sub fndCompany_Click()
   PrepareAndFind cnstSearchTypeGrpCompany, , "Name, XCompanyID", txtCompany, fndCompany, , , 1
End Sub

Private Sub Form_Load()
    ClearValues
    ButtonHandling Me
    If pbSave = True Then
       ShowOpen (plnDocID)
        ButtonHandling Me, "Open"
     Else
        ButtonHandling Me, "New"
    End If
     
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub txtCompany_KeyDown(KeyCode As Integer, Shift As Integer)
    fndCompany_Click
End Sub

'Public Function DisplayDataInGrid()
'On Local Error GoTo Err_Exit
'    vsfgDocuments.Rows = 1
'    Set rsDoc = New ADODB.Recordset
'    rsDoc.CursorLocation = adUseClient
'    Dim sSql As String, Inc As Long
'    Dim FileExt As String
'    sSql = "SELECT DocumentBin.DocumentCode AS Code, DocumentBin.Description, DocumentBin.FileName, DocumentBin.FileExt,eAuditMain.dbo.Companies.CompanyName ,DocumentBin.CollectedDate,DocumentBin.DocumentID, DocumentBin.CollectedVia, DocumentBin.MetaFile FROM DocumentBin LEFT OUTER JOIN " & _
'           "eAuditMain.dbo.Companies ON DocumentBin.CompanyID = eAuditMain.dbo.Companies.CompanyID ORDER BY DocumentBin.UpdateDate DESC"
'    Inc = 1
'    With GetRecords(sSql, AdoConnDoc)
'        While .EOF <> True
'            vsfgDocuments.Rows = vsfgDocuments.Rows + 1
'            vsfgDocuments.TextMatrix(Inc, grdCode) = .Fields("Code") & ""
'            vsfgDocuments.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
'            vsfgDocuments.TextMatrix(Inc, grdFileName) = .Fields("FileName") & ""
'            SetExtPic Inc, Trim(.Fields("FileExt") & "")
'            vsfgDocuments.TextMatrix(Inc, grdCompanyName) = .Fields("CompanyName") & ""
'            vsfgDocuments.TextMatrix(Inc, grdCollecteddate) = .Fields("CollectedDate") & ""
'            vsfgDocuments.TextMatrix(Inc, grdDocumentID) = .Fields("DocumentId") & ""
'            Inc = Inc + 1
'            .MoveNext
'        Wend
'    End With
'Exit Function
'Err_Exit:
'    ShowError
'End Function

'Public Sub SetExtPic(Row As Long, strExt As String)
'On Local Error Resume Next
'    strExt = LCase(strExt)
'    Err.Clear
'    vsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = Nothing
'    vsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
'    If Err.Number <> 0 Then
'        vsfgDocuments.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
'    End If
End Sub

Private Sub vsfgDocuments_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub VsfgDocuments_DblClick()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(ByVal DocID As Variant) As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    Dim sSql As String
        If DocID = 0 Then
            ShowOpen = False
            Exit Function
        End If
        sSql = "SELECT DocumentBin.DocumentCode AS Code, DocumentBin.Description, DocumentBin.CompanyID, DocumentBin.FileName, DocumentBin.FileExt,eAuditMain.dbo.Companies.CompanyName ,DocumentBin.CollectedDate,DocumentBin.DocumentID, DocumentBin.CollectedVia, DocumentBin.MetaFile FROM DocumentBin LEFT OUTER JOIN  eAuditMain.dbo.Companies ON DocumentBin.CompanyID = eAuditMain.dbo.Companies.CompanyID where DocumentBin.DocumentID =" & DocID & "   ORDER BY DocumentBin.UpdateDate DESC"
        With GetRecords(sSql, AdoConnDoc)
            If Not .EOF Then
                txtDocCode.Text = .Fields("Code") & ""
                txtDescription.Text = .Fields("Description") & ""
                txtFilename = .Fields("fileName") & ""
                strOldFile = txtFilename
                txtCompany = .Fields("CompanyName") & ""
                txtCompany.Tag = .Fields("CompanyID") & ""
                TxtCollectedVia.Text = .Fields("CollectedVia") & ""
                dtpCollectDt.Value = .Fields("CollectedDate") & ""
                TxtMetaFile.Text = .Fields("Metafile") & ""
            Else
                ShowError "Not a valid record!"
            End If
        End With
      ShowOpen = True
Exit Function
Err_Exit:
    ShowError
End Function

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
    Dim sSql As String
    If pMVE.MsgBox("Delete " & txtFilename.Text & "", msgOK, , msgQuestion, True) Then
        sSql = " Delete From DocumentBin Where DocumentID =" & lngID
        AdoConnDoc.BeginTrans
        AdoConnDoc.Execute (sSql)
        AdoConnDoc.CommitTrans
    End If
    Delete = True
   ' DisplayDataInGrid
Exit Function
Err_Exit:
    AdoConnDoc.RollbackTrans
    ShowError
End Function

Private Sub vsfgDocuments_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    VsfgDocuments.ToolTipText = VsfgDocuments.Text
End Sub

Private Sub vsfgDocuments_RowColChange()
    SelectRow VsfgDocuments
End Sub


