VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmCollectMultipleDocs 
   Caption         =   "Multiple Document Collection"
   ClientHeight    =   5730
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   11160
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5730
   ScaleWidth      =   11160
   WindowState     =   2  'Maximized
   Begin VB.CommandButton fndCompany 
      Height          =   330
      Left            =   6480
      Picture         =   "frmCollectMultipleDocs.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   330
      Width           =   345
   End
   Begin VB.TextBox txtCompany 
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   50
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   330
      Width           =   6435
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgDoc 
      Height          =   4455
      Left            =   45
      TabIndex        =   0
      Top             =   765
      Width           =   11055
      _cx             =   19500
      _cy             =   7858
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9
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
      Cols            =   5
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmCollectMultipleDocs.frx":018A
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   120
      Top             =   5400
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
            Picture         =   "frmCollectMultipleDocs.frx":0250
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":03AA
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":0504
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":065E
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":0838
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":0992
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":0B6C
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":0CC6
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":21C8
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":23A2
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":257C
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCollectMultipleDocs.frx":2756
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   4995
      TabIndex        =   4
      Top             =   5295
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
   Begin MSComDlg.CommonDialog cdFile 
      Left            =   1080
      Top             =   5280
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComCtl2.DTPicker dtpCollectDt 
      Height          =   330
      Left            =   8760
      TabIndex        =   6
      Top             =   330
      Width           =   2370
      _ExtentX        =   4180
      _ExtentY        =   582
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      CustomFormat    =   "dd/MM/yyyy HH:mm:ss tt"
      Format          =   117899267
      CurrentDate     =   40331
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Collected Date && Time"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   5
      Left            =   8715
      TabIndex        =   5
      Top             =   45
      Width           =   1710
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Company"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   3
      Left            =   50
      TabIndex        =   3
      Top             =   50
      Width           =   735
   End
End
Attribute VB_Name = "frmCollectMultipleDocs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public lngID As Long, FileExt As String
Dim rsDoc As New ADODB.Recordset
Dim mStream As New ADODB.Stream
Dim mblnModify As Boolean
Dim mblnNew As Boolean, strOldFile As String
Dim mCompanyID As Long, mPeriodID As Long, mDefaultPeriodID As Long

Const grdFileName = 0
Const grdDescription = 1
Const grdDocumentType = 2
Const grdDocumentSize = 3
Const grdDocumentID = 4
Const grdCols = 5

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
        ClearValues
        lngID = 0
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
    vsfgDoc.Enabled = blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    dtpCollectDt = ServerDateTime
    strOldFile = ""
    If mCompanyID <> 0 Then
        txtCompany.Tag = mCompanyID
        txtCompany = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID)
    End If
    lngID = 0
    vsfgDoc.Cell(flexcpText, 1, grdFileName, vsfgDoc.Rows - 1, vsfgDoc.Cols - 1) = ""
End Sub

Private Sub fndCompany_Click()
    PrepareAndFind cnstSearchTypeGrpCompany, , "Name, XCompanyID", txtCompany, fndCompany
End Sub

Public Function FormatGrid()
On Local Error Resume Next
    With vsfgDoc
        .Cols = grdCols
        .ExtendLastCol = False
        .ColWidth(grdFileName) = 4000
        .ColWidth(grdDescription) = 4000
        .ColWidth(grdDocumentType) = 1800
        .ColWidth(grdDocumentSize) = 1300

        .ColComboList(grdFileName) = "..."
        .ColHidden(grdDocumentID) = True

        .Rows = 3
        .TextMatrix(0, grdFileName) = "File Name"
        .TextMatrix(0, grdDescription) = "Description"
        .TextMatrix(0, grdDocumentType) = "Document Type"
        .TextMatrix(0, grdDocumentSize) = "Doc Size"
    End With
End Function

Private Sub Form_Load()
    FormatGrid
    ButtonHandling Me
    dtpCollectDt.Enabled = False
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub vsfgDoc_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
'    Select Case Col
'        Case grdFileName
'            If vsfgDoc.TextMatrix(Row, grdDocumentType) <> "" Then
'                If Row = vsfgDoc.Rows - 1 Then
'                    vsfgDoc.Rows = vsfgDoc.Rows + 1
'                End If
'            End If
'        Case Else
'
'    End Select
End Sub

Private Sub vsfgDoc_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Row > 0 Then
        Select Case Col
            Case grdFileName
                If vsfgDoc.TextMatrix(Row, grdFileName) <> "" Then
                    vsfgDoc.Cell(flexcpText, Row, grdDocumentType) = "Temporary"
                End If
                If Row = vsfgDoc.Rows - 1 Then
                    vsfgDoc.Rows = vsfgDoc.Rows + 1
                End If
            Case grdDocumentSize
                If Row > 0 And vsfgDoc.TextMatrix(Row, grdDocumentSize) <> "" Then
                    Cancel = True
                End If
            Case Else
                
        End Select
    End If
End Sub

Private Sub vsfgDoc_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
Dim sString As String, strExt As String, strFileName As String
Dim strFileLen As String, lngFileLen As Long
    If Row > 0 Then
        Select Case Col
            Case grdFileName
                cdFile.InitDir = "C:\My Documents"
                cdFile.Filter = "All Files (*.*)|*.*|JPEG Compressed Image(*.jpg)|*.jpg|Graphic Interchange Format (*.gif)|*.gif|Text Files (*.txt)|*.txt|Excel files(*.xls)|*.xls|Word FIles (*.doc)|*.doc|Microsoft Document Imaging(*.mdi)|*.mdi|PDF FIles (*.pdf)|*.pdf"
                cdFile.ShowOpen
                vsfgDoc.TextMatrix(Row, grdFileName) = "" + LTrim(cdFile.FileTitle)
                sString = vsfgDoc.TextMatrix(Row, grdFileName)
                strExt = GetExtension(sString, True)
                strFileName = Replace(sString, strExt, "")
                vsfgDoc.TextMatrix(Row, grdDescription) = strFileName
                strFileLen = FileLen(vsfgDoc.TextMatrix(Row, grdFileName))
                lngFileLen = Val(strFileLen) / 1024
                vsfgDoc.TextMatrix(Row, grdDocumentSize) = lngFileLen & " kb"
            Case Else
                
        End Select
    End If
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, IsInTran As Boolean
Dim strCompanyCode As String, lngID As Long
    strCompanyCode = PickValue("Companies", "CompanyCode", "CompanyID = " & pActiveCompanyID)
    For Inc = 1 To vsfgDoc.Rows - 1
        If vsfgDoc.TextMatrix(Inc, grdFileName) <> "" Then
            FileExt = Mid(vsfgDoc.TextMatrix(Inc, grdFileName), InStr(1, vsfgDoc.TextMatrix(Inc, grdFileName), ".") + 1)
            If Val(txtCompany.Tag) = 0 Then
                pMVE.MsgBox "Company Name Not Mentioned.", msgOK, "AuditMate", msgCritical, True
                Save = False
                Exit Function
            End If
            sSql = "Select * From  DocumentBin Where 1=2"
            With GetRecords(sSql, AdoConnDoc)
                If .EOF Then
                    .AddNew
                    If pServer = pServerLocal Then
                        lngID = GetRangeMaxNo("DocumentBin", "DocumentID", strCompanyCode * cnstDocIDLocalMaxCount, (strCompanyCode * cnstDocIDLocalMaxCount) + cnstDocIDLocalMaxCount, AdoConnDoc)
                    Else
                        lngID = GetRangeMaxNo("DocumentBin", "DocumentID", strCompanyCode * cnstDocIDMaxCount, (strCompanyCode * cnstDocIDMaxCount) + cnstDocIDMaxCount, AdoConnDoc)
                    End If
                    .Fields("DocumentID") = lngID
                    .Fields("IsRead") = False
                    .Fields("IsCheckOut") = False
                    .Fields("CheckOutPath") = ""
                End If
                .Fields("Documentcode") = ""
                .Fields("CompanyID") = Val(txtCompany.Tag)
                .Fields("FileName") = vsfgDoc.TextMatrix(Inc, grdFileName)
                .Fields("DocumentType") = IIf(vsfgDoc.TextMatrix(Inc, grdDocumentType) = "Permanent", 1, 0)
                .Fields("Description") = vsfgDoc.TextMatrix(Inc, grdDescription)
                .Fields("Metafile") = ""
                .Fields("CollectedVia") = "Scan"
                .Fields("CollectedDate") = dtpCollectDt
                .Fields("FileExt") = Left(FileExt, 10)
                .Fields("DocSize") = vsfgDoc.TextMatrix(Inc, grdDocumentSize)
                If Trim(UCase(strOldFile)) <> Trim(UCase(vsfgDoc.TextMatrix(Inc, grdFileName))) Then
                    Set mStream = New ADODB.Stream
                    mStream.Type = adTypeBinary
                    mStream.Open
                    mStream.LoadFromFile vsfgDoc.TextMatrix(Inc, grdFileName)
                    .Fields("Docfile").Value = mStream.Read
                End If
                .Fields("CreateDate") = dtpCollectDt
                .Fields("UpdateDate") = dtpCollectDt
                .Fields("CreateUser") = pUserID
                .Fields("UpdateUser") = pUserID
                .Update
            End With
        End If
    Next Inc
    Save = True
    ClearValues
Exit Function
Err_Exit:
    Save = False
    ShowError
End Function

Private Sub vsfgDoc_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
    If vsfgDoc.Rows > 0 Then
        If KeyCode = vbKeyDelete Then
            vsfgDoc.RemoveItem vsfgDoc.Row
        End If
    End If
End Sub
