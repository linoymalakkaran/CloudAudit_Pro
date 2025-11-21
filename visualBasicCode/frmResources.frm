VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmResources 
   Caption         =   "Resources"
   ClientHeight    =   7770
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   8490
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7770
   ScaleWidth      =   8490
   WindowState     =   2  'Maximized
   Begin VB.Frame frameResource 
      Height          =   1935
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   8295
      Begin VB.CommandButton cmdDeleteFile 
         Caption         =   "Del File"
         Height          =   330
         Left            =   6480
         TabIndex        =   4
         Top             =   1200
         Width           =   975
      End
      Begin VB.CommandButton fndResourceNameID 
         Height          =   315
         Left            =   6075
         Picture         =   "frmResources.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   0
         Top             =   465
         Width           =   345
      End
      Begin VB.TextBox txtResourceName 
         Height          =   330
         Left            =   1440
         TabIndex        =   1
         Top             =   465
         Width           =   4620
      End
      Begin VB.CommandButton cmdBrowse 
         Caption         =   "..."
         Height          =   330
         Left            =   6060
         TabIndex        =   2
         Top             =   1200
         Width           =   375
      End
      Begin VB.TextBox txtFilename 
         Height          =   330
         Left            =   1425
         MaxLength       =   250
         TabIndex        =   5
         Top             =   1200
         Width           =   4620
      End
      Begin VB.Label lblName 
         AutoSize        =   -1  'True
         Caption         =   "Resource Name"
         Height          =   225
         Index           =   0
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Width           =   1200
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Select File"
         Height          =   225
         Left            =   120
         TabIndex        =   8
         Top             =   1200
         Width           =   765
      End
   End
   Begin MSComDlg.CommonDialog cdFile 
      Left            =   120
      Top             =   7200
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgSubSections 
      Height          =   5055
      Left            =   120
      TabIndex        =   6
      Top             =   2160
      Width           =   8295
      _cx             =   14631
      _cy             =   8916
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
      FormatString    =   $"frmResources.frx":018A
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   480
      Top             =   7320
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
            Picture         =   "frmResources.frx":021A
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":0374
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":04CE
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":0628
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":0802
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":095C
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":0B36
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":0C90
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":2192
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":236C
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmResources.frx":2546
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2400
      TabIndex        =   3
      Top             =   7335
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
End
Attribute VB_Name = "frmResources"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean, mlngMode As Long
Dim mStream As ADODB.Stream, strOldFile As String

Const grdSSecSelected = 0
Const grdSSecSubSection = 1
Const grdSSecSection = 2
Const grdSSecSubSectionID = 3
Const grdSSecSectionID = 4

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

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameResource.Enabled = blnNewValue
    vsfgSubSections.Enabled = blnNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
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
    txtResourceName = ""
    txtFilename = ""
    strOldFile = ""
    FillSubSectionDetails
End Sub

Private Sub cmdBrowse_Click()
On Local Error Resume Next
    Dim sString As String
    cdFile.Filter = "All Files (*.*)|*.*|JPEG Compressed Image(*.jpg)|*.jpg|Graphic Interchange Format (*.gif)|*.gif|Text Files (*.txt)|*.txt|Excel files(*.xls)|*.xls|Word FIles (*.doc)|*.doc|Microsoft Document Imaging(*.mdi)|*.mdi|PDF FIles (*.pdf)|*.pdf"
    cdFile.ShowOpen
    txtFilename = "" + LTrim(cdFile.FileTitle)
    sString = txtFilename
End Sub

Public Sub FillSubSectionDetails()
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String
    sSql = "SELECT  FSS.Description AS SubSectionName, FS.Description AS SectionName, FSS.SubSectionID AS SubSectionID, FS.SectionID AS SectionID " & _
           "FROM    FilingSubSection FSS LEFT OUTER JOIN FilingSections FS ON FSS.SectionID = FS.SectionID Order By SubSectionName"
    vsfgSubSections.Rows = 1
    With GetRecords(sSql)
        While Not .EOF
            vsfgSubSections.Rows = vsfgSubSections.Rows + 1
            Inc = vsfgSubSections.Rows - 1
            vsfgSubSections.TextMatrix(Inc, grdSSecSubSection) = .Fields("SubSectionName") & ""
            vsfgSubSections.TextMatrix(Inc, grdSSecSection) = .Fields("SectionName") & ""
'            vsfgSubSections.TextMatrix(Inc, grdSSecSectionID) = .Fields("SectionID") & ""
            vsfgSubSections.TextMatrix(Inc, grdSSecSubSectionID) = .Fields("SubSectionID") & ""
            .MoveNext
        Wend
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
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

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, lngResourceID As Long
Dim rsSave As New ADODB.Recordset
    If txtResourceName = "" Then
        pMVE.MsgBox "Please specify a valid resource name.", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    AdoConn.BeginTrans
    lngResourceID = Val(txtResourceName.Tag)
    sSql = "Select * From Resources Where ResourceID = " & lngResourceID
    Set rsSave = GetRecords(sSql)
        With rsSave
            If .EOF Then
                .AddNew
                lngResourceID = GetMaxNo("Resources", "ResourceID")
                .Fields("ResourceID") = lngResourceID
            End If
            .Fields("ResourceName") = txtResourceName.Text
            If Trim(UCase(strOldFile)) <> Trim(UCase(txtFilename)) And txtFilename <> "" Then
                Set mStream = New ADODB.Stream
                mStream.Type = adTypeBinary
                mStream.Open
                mStream.LoadFromFile txtFilename
                .Fields("TemplateFile").Value = mStream.Read
            End If
            For Inc = 1 To vsfgSubSections.Rows - 1
                If vsfgSubSections.ValueMatrix(Inc, grdSSecSelected) <> 0 Then
                    .Fields("SectionID") = 0                                         'vsfgSubSections.ValueMatrix(Inc, grdSSecSectionID) & ""
                    .Fields("SubSectionID") = vsfgSubSections.ValueMatrix(Inc, grdSSecSubSectionID) & ""
                End If
            Next Inc
            SaveDateAndUser rsSave, IsNew
            .Update
            .Close
        End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
    Save = False
End Function
