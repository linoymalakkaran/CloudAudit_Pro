VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmDocumentDefinition 
   Caption         =   "Document Definition"
   ClientHeight    =   8820
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7320
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8820
   ScaleWidth      =   7320
   WindowState     =   2  'Maximized
   Begin VB.Frame frameDetails 
      Height          =   2205
      Left            =   15
      TabIndex        =   3
      Top             =   2445
      Width           =   7065
      Begin VB.TextBox txtDocDescription 
         Height          =   285
         Left            =   2325
         TabIndex        =   10
         Top             =   345
         Width           =   4560
      End
      Begin VB.TextBox txtRemarks 
         Height          =   1275
         Left            =   120
         TabIndex        =   5
         Top             =   855
         Width           =   6780
      End
      Begin VB.TextBox txtCode 
         Height          =   285
         Left            =   120
         TabIndex        =   4
         Top             =   360
         Width           =   2190
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Remarks"
         Height          =   195
         Left            =   120
         TabIndex        =   9
         Top             =   660
         Width           =   630
      End
      Begin VB.Label txtDescription 
         AutoSize        =   -1  'True
         Caption         =   "Description"
         Height          =   195
         Left            =   2565
         TabIndex        =   8
         Top             =   150
         Width           =   795
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Document Code"
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   150
         Width           =   1155
      End
      Begin VB.Label Label1 
         Caption         =   "Label1"
         Height          =   45
         Left            =   1740
         TabIndex        =   6
         Top             =   480
         Width           =   45
      End
   End
   Begin VB.Frame frameBin 
      Height          =   2460
      Left            =   15
      TabIndex        =   0
      Top             =   -15
      Width           =   7080
      Begin VSFlex8Ctl.VSFlexGrid VsfgBin 
         Height          =   2205
         Left            =   60
         TabIndex        =   12
         Top             =   165
         Width           =   6945
         _cx             =   12250
         _cy             =   3889
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
         FormatString    =   $"frmDocumentDefinition.frx":0000
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
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Available Documents in Bin Directory"
         Height          =   195
         Left            =   90
         TabIndex        =   11
         Top             =   135
         Width           =   2610
      End
   End
   Begin VSFlex8Ctl.VSFlexGrid VsfgDocuments 
      Height          =   1935
      Left            =   75
      TabIndex        =   1
      Top             =   5145
      Width           =   6930
      _cx             =   12224
      _cy             =   3413
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
      BackColorBkg    =   -2147483639
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
      Rows            =   50
      Cols            =   4
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   315
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmDocumentDefinition.frx":012B
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
      Left            =   45
      Top             =   8130
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
            Picture         =   "frmDocumentDefinition.frx":01B0
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":030A
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":0464
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":05BE
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":0798
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":08F2
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":0ACC
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":0C26
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":2128
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":2302
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":24DC
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentDefinition.frx":26B6
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   150
      TabIndex        =   2
      Top             =   4770
      Width           =   6810
      _ExtentX        =   12012
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
Attribute VB_Name = "frmDocumentDefinition"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim rsDoc As ADODB.Recordset, rsSave As ADODB.Recordset
Dim mPeriodID As Long, mCompanyID As Long, Inc As Long
Public BinDocID As Long, DocumentsID As Long, mstrFileExt As String
Dim mblnModify As Boolean
Dim mblnNew As Boolean
Public lngID As Long

Const grdDefined = 0
Const grdCode = 1
Const grdFileExt = 2
Const grdFileName = 3
Const grdDescription = 4
Const grdCollecteddate = 5
Const grdDocumentID = 6
Const grdvsfgcode = 0
Const grdvsfgDescription = 1
Const grdRemarks = 2
Const grdvsfgDocID = 3

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
    DisplayDataInGrid
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
    frameBin.Enabled = blnNewValue
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    mstrFileExt = ""
    DisplayInVSFgGrid
    lngID = 0
End Sub

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         lngID = 0
         txtDocDescription.SetFocus
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
         txtDocDescription.SetFocus
         Highlight
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Function DisplayDataInGrid()
On Local Error GoTo Err_Exit
    VsfgBin.Rows = 1
    Set rsDoc = New ADODB.Recordset
    rsDoc.CursorLocation = adUseClient
    Dim sSql As String, Inc As Long, sSqlTmp As String
    Dim FileExt As String
    sSqlTmp = "SELECT BinDocumentID From AuditMain.dbo.Documents"
    sSql = "Select DocumentCode as Code, FileExt, FileName, Description,CollectedDate,DocumentID, 0 AS IsExists, 1 AS Ord " & _
           "From DocumentBin Where DocumentID NOT IN (" & sSqlTmp & ") AND CompanyID= " & mCompanyID & _
           " Union " & _
           "Select DocumentCode as Code, FileExt, FileName, Description,CollectedDate,DocumentID, 1 AS IsExists, 2 AS Ord " & _
           "From DocumentBin Where DocumentID IN (" & sSqlTmp & ") AND CompanyID= " & mCompanyID & _
           "Order By Ord, DocumentID Desc"
    Inc = 1
    With GetRecords(sSql, AdoConnDoc)
        While .EOF <> True
            VsfgBin.Rows = VsfgBin.Rows + 1
            VsfgBin.TextMatrix(Inc, grdCode) = .Fields("Code") & ""
            VsfgBin.TextMatrix(Inc, grdDefined) = .Fields("IsExists") & ""
            SetExtPic Inc, Trim(.Fields("FileExt") & "")
            VsfgBin.TextMatrix(Inc, grdFileName) = .Fields("FileName") & ""
            VsfgBin.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
            VsfgBin.TextMatrix(Inc, grdCollecteddate) = .Fields("CollectedDate") & ""
            VsfgBin.TextMatrix(Inc, grdDocumentID) = .Fields("DocumentId") & ""
            Inc = Inc + 1
            .MoveNext
        Wend
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function ShowOpenInTxts(ByVal DocID As Variant) As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    Dim sSql As String
    With VsfgBin
        BinDocID = .ValueMatrix(.Row, grdDocumentID)
        If BinDocID = 0 Then
            ShowOpenInTxts = False
            Exit Function
        End If
       sSql = "Select DocumentCode as Code, Description, FileName, FileExt, CollectedDate, MetaFile As Document,DocumentID From DocumentBin Where DocumentID=" & BinDocID & "  Order By DocumentID desc"
        With GetRecords(sSql, AdoConnDoc)
            If Not .EOF Then
                txtCode = .Fields("Code") & ""
                txtDocDescription.Text = .Fields("Description") & ""
                txtRemarks = .Fields("Document") & ""
                mstrFileExt = .Fields("FileExt") & ""
            Else
                ShowError "Not a valid record!"
            End If
        End With
    End With
   ShowOpenInTxts = True
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub Form_Load()
    ButtonHandling Me
    VsfgDocuments.CellPictureAlignment = flexPicAlignStretch
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub VsfgBin_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub VsfgBin_DblClick()
    ShowOpenInTxts (lngID)
    'ButtonHandling Me, "Open"
End Sub

Private Sub VsfgBin_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    VsfgBin.ToolTipText = VsfgBin.Text
End Sub

Private Sub VsfgBin_RowColChange()
    SelectRow VsfgBin
End Sub

Public Function Save() As Boolean
On Error GoTo Err_Exit
Dim IsInTran As Boolean, rsSave As ADODB.Recordset
    If BinDocID = 0 Then
        pMVE.MsgBox "No valid document specified.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    If Trim(txtDescription) = "" Then
        pMVE.MsgBox "Description not mentioned.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    If Trim(txtCode) = "" Then
        pMVE.MsgBox "Document Code not mentioned.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
      '--------------------------------------------------------------------------------------
    AdoConnDoc.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords("Select * From  Documents Where DocumentID = " & lngID, AdoConn)
    With rsSave
        If .EOF Then
            .AddNew
            lngID = GetMaxNo("Documents", "DocumentID", , AdoConn)
            .Fields("DocumentID") = lngID
        End If
        .Fields("CompanyID") = mCompanyID
        .Fields("PeriodID") = mPeriodID
        .Fields("DocumentName") = txtDocDescription
        .Fields("DocumentTypeID") = DocTypeConstants.cnstDocTypeScannedDocuments
        .Fields("RefNo") = txtCode
        .Fields("BinDocumentID") = BinDocID
        .Fields("FileExt") = Trim(mstrFileExt)
        .Fields("Remarks") = txtRemarks
        .Update
        .Close
    End With
   AdoConnDoc.CommitTrans
    Save = True
    DisplayDataInGrid
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConnDoc.RollbackTrans
    End If
    ShowError
End Function

Public Function DisplayInVSFgGrid()
    On Local Error GoTo Err_Exit
    Inc = 1
    Me.VsfgDocuments.Rows = 2
    Dim sSql As String
    sSql = " Select  RefNo,DocumentName,Remarks , DocumentID From Documents Order By DocumentID desc"
    With GetRecords(sSql, AdoConn)
    While .EOF <> True
        Me.VsfgDocuments.Rows = VsfgDocuments.Rows + 1
        Me.VsfgDocuments.TextMatrix(Inc, grdvsfgcode) = .Fields("RefNo") & ""
        Me.VsfgDocuments.TextMatrix(Inc, grdvsfgDescription) = .Fields("DocumentName") & ""
        Me.VsfgDocuments.TextMatrix(Inc, grdRemarks) = .Fields("Remarks") & ""
        Me.VsfgDocuments.TextMatrix(Inc, grdvsfgDocID) = .Fields("DocumentID") & ""
        Inc = Inc + 1
    .MoveNext
     Wend
    End With
    Exit Function
Err_Exit:
    ShowError
End Function

Public Sub SetExtPic(Row As Long, strExt As String)
On Local Error Resume Next
    strExt = LCase(strExt)
    Err.Clear
    VsfgBin.Cell(flexcpPicture, Row, grdFileExt) = Nothing
    VsfgBin.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
    If Err.Number <> 0 Then
        VsfgBin.Cell(flexcpPicture, Row, grdFileExt) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
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
Dim Inc As Long
    Dim sSql As String
    With VsfgDocuments
        lngID = .ValueMatrix(.Row, grdvsfgDocID)
        If lngID = 0 Then
            ShowOpen = False
            Exit Function
        End If
        sSql = " Select  RefNo, DocumentName, Remarks ,DocumentID, FileExt, BinDocumentID From Documents where DocumentID= " & lngID & " "
        With GetRecords(sSql, AdoConn)
            If Not .EOF Then
                txtCode = .Fields("RefNo") & ""
                txtDocDescription.Text = .Fields("DocumentName") & ""
                txtRemarks = .Fields("Remarks") & ""
                mstrFileExt = .Fields("FileExt") & ""
                BinDocID = Val(.Fields("BinDocumentID") & "")
                lngID = Val(.Fields("DocumentID") & "")
            Else
                ShowError "Not a Valid Record!"
            End If
        End With
    End With
    ShowOpen = True
Exit Function
Err_Exit:
    ShowError
End Function

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
    Dim sSql As String
    If pMVE.MsgBox("Delete " & txtDocDescription.Text & "", msgOK, "AuditMate", msgQuestion, True) Then
        sSql = " Delete From Documents Where DocumentID =" & lngID
        AdoConn.BeginTrans
        AdoConn.Execute (sSql)
        AdoConn.CommitTrans
    End If
    Delete = True
    DisplayInVSFgGrid
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
End Function
