VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmDocumentLinking 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Document Linking"
   ClientHeight    =   6570
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9345
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6570
   ScaleWidth      =   9345
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtRemarks 
      Height          =   375
      Left            =   720
      TabIndex        =   14
      Top             =   6000
      Visible         =   0   'False
      Width           =   6375
   End
   Begin VB.TextBox txtDescription 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   2520
      TabIndex        =   10
      Top             =   1365
      Width           =   6690
   End
   Begin VB.TextBox txtRefNo 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   90
      TabIndex        =   8
      Top             =   1365
      Width           =   1965
   End
   Begin VB.Frame frameDocuments 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4305
      Left            =   90
      TabIndex        =   0
      Top             =   1665
      Width           =   9120
      Begin VB.CheckBox chkShowAll 
         Caption         =   "Show All"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   4800
         TabIndex        =   6
         Top             =   4060
         Width           =   1485
      End
      Begin AIFCmp1.asxPowerButton cmdRemoveAll 
         Height          =   390
         Left            =   4275
         TabIndex        =   3
         Top             =   2955
         Width           =   435
         _ExtentX        =   767
         _ExtentY        =   688
         Caption         =   ">>"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgUnLinkedDoc 
         Height          =   3735
         Left            =   4800
         TabIndex        =   1
         Top             =   285
         Width           =   4110
         _cx             =   7250
         _cy             =   6588
         Appearance      =   2
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
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
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   3
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   5
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   450
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmDocumentLinking.frx":0000
         ScrollTrack     =   0   'False
         ScrollBars      =   3
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
      Begin VSFlex8Ctl.VSFlexGrid vsfgLinkedDoc 
         Height          =   3750
         Left            =   105
         TabIndex        =   2
         Top             =   270
         Width           =   4095
         _cx             =   7223
         _cy             =   6615
         Appearance      =   2
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
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
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   3
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   6
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   450
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmDocumentLinking.frx":00AC
         ScrollTrack     =   0   'False
         ScrollBars      =   3
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
      Begin AIFCmp1.asxPowerButton cmdAddAll 
         Height          =   390
         Left            =   4280
         TabIndex        =   4
         Top             =   1620
         Width           =   435
         _ExtentX        =   767
         _ExtentY        =   688
         Caption         =   "<<"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin AIFCmp1.asxPowerButton cmdRemove 
         Height          =   390
         Left            =   4275
         TabIndex        =   11
         Top             =   2445
         Width           =   435
         _ExtentX        =   767
         _ExtentY        =   688
         Caption         =   ">"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin AIFCmp1.asxPowerButton cmdAdd 
         Height          =   390
         Left            =   4280
         TabIndex        =   12
         Top             =   1140
         Width           =   435
         _ExtentX        =   767
         _ExtentY        =   688
         Caption         =   "<"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   90
      Top             =   6030
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
            Picture         =   "frmDocumentLinking.frx":0178
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":02D2
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":042C
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":0586
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":0760
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":08BA
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":0A94
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":0BEE
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":20F0
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":22CA
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":24A4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocumentLinking.frx":267E
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   7125
      TabIndex        =   5
      Top             =   6105
      Width           =   2115
      _ExtentX        =   3731
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
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgStructure 
      Height          =   975
      Left            =   90
      TabIndex        =   13
      Top             =   120
      Width           =   9135
      _cx             =   16113
      _cy             =   1720
      Appearance      =   0
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
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
      GridColor       =   16777215
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
      Rows            =   3
      Cols            =   1
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
      ScrollTrack     =   0   'False
      ScrollBars      =   0
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
   Begin VB.Label lblDescription 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Description"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   2520
      TabIndex        =   9
      Top             =   1140
      Width           =   795
   End
   Begin VB.Label lblRefNo 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Ref No"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   90
      TabIndex        =   7
      Top             =   1140
      Width           =   510
   End
End
Attribute VB_Name = "frmDocumentLinking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Dim mlngSubSectionID As Long, mlngId As Long, mstrIDType As String, mlngSectionID As Long, mstrWhere As String

Dim mstrDescription As String, mstrRemarks As String

Const grdLinkIcon = 0
Const grdLinkDocument = 1
Const grdLinkAcTypeID = 2
Const grdLinkProcedureID = 3
Const grdLinkSubSectionID = 4
Const grdLinkDocID = 5
Const grdLinkCols = 6

Const grdUnLinkIcon = 0
Const grdUnLinkDocument = 1
Const grdUnLinkAcTypeID = 2
Const grdUnLinkProcedureID = 3
Const grdUnLinkDocID = 4
Const grdUnLinkCols = 5

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql2 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
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
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub chkShowAll_Click()
    ShowDocuments (chkShowAll = vbChecked)
End Sub

Private Sub cmdAdd_Click()
    If vsfgUnLinkedDoc.Row > 0 Then
        AddDocument vsfgUnLinkedDoc.Row
    End If
End Sub

Private Sub cmdAddAll_Click()
Dim Inc As Long, Inc1 As Long
    For Inc1 = 1 To vsfgUnLinkedDoc.Rows - 1
        For Inc = 1 To vsfgUnLinkedDoc.Rows - 1
            AddDocument Inc
            Exit For
        Next Inc
    Next Inc1
End Sub

Private Sub cmdRemove_Click()
    If vsfgLinkedDoc.Row > 0 Then
        RemoveDocument vsfgLinkedDoc.Row
    End If
End Sub

Private Sub cmdRemoveAll_Click()
Dim Inc As Long, Inc1 As Long
    For Inc1 = 1 To vsfgLinkedDoc.Rows - 1
        For Inc = 1 To vsfgLinkedDoc.Rows - 1
            RemoveDocument Inc
            Exit For
        Next Inc
    Next Inc1
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        Unload Me
    End If
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "Save"
            Save
        Case "Close"
            Unload Me
    End Select
End Sub

Public Sub ShowLinkedDocuments()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, FileExt As String, strWhere As String, strDetail As String
    strWhere = "Select DocumentID From AuditMain.dbo.DocumentSubLinks Where PeriodID = " & mPeriodID & " AND SubSectionID = " & mlngSubSectionID & ""
    strWhere = strWhere & mstrWhere
    
    sSql = "SELECT DB.DocumentID, DB.Description, DB.FileExt, DB.FileName, CMP.CompanyName AS CompanyName " & _
           "FROM DocumentBin DB LEFT OUTER JOIN AuditMain.dbo.Companies CMP ON DB.CompanyID = CMP.CompanyID " & _
           "WHERE DB.DocumentID IN (" & strWhere & ") " & _
           "ORDER BY DB.IsRead, DB.UpdateDate DESC"
    vsfgLinkedDoc.Rows = 1
    With GetRecords(sSql, AdoConnDoc)
        While Not .EOF
            vsfgLinkedDoc.Rows = vsfgLinkedDoc.Rows + 1
            Inc = vsfgLinkedDoc.Rows - 1
            vsfgLinkedDoc.TextMatrix(Inc, grdLinkDocument) = .Fields("Description") & ""
            vsfgLinkedDoc.TextMatrix(Inc, grdLinkDocID) = .Fields("DocumentID") & ""
            vsfgLinkedDoc.FontSize = 9
            vsfgLinkedDoc.Cell(flexcpAlignment, Inc, grdLinkDocument) = flexAlignLeftCenter
            SetPicture Inc, grdLinkIcon, Trim(.Fields("FileExt") & ""), vsfgLinkedDoc
            .MoveNext
        Wend
    .Close
    End With
    
    strDetail = "Select TOP 1 RefNo, Description From DocumentSubLinks Where PeriodID = " & mPeriodID & " AND SubSectionID = " & mlngSubSectionID & " "
    strDetail = strDetail & mstrWhere
    With GetRecords(strDetail)
        If Not .EOF Then
            txtRefNo = .Fields("RefNo") & ""
            txtDescription = .Fields("Description") & ""
        End If
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowDocuments(IsShowAll As Boolean)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, FileExt As String, strWhereShowAll As String, strInSelected As String
    If IsShowAll Then
        strWhereShowAll = "Select DocumentID From AuditMain.dbo.DocumentSubLinks Where 1=2"
    Else
        strWhereShowAll = "Select DocumentID From AuditMain.dbo.DocumentSubLinks"
    End If
    
    strInSelected = "0"
    For Inc = 1 To vsfgLinkedDoc.Rows - 1
        strInSelected = strInSelected & ", " & vsfgLinkedDoc.ValueMatrix(Inc, grdLinkDocID)
    Next Inc
    
    sSql = "SELECT    DB.DocumentID, DB.Description, DB.FileExt, DB.FileName, CMP.CompanyName AS CompanyName " & _
           "FROM      DocumentBin DB LEFT OUTER JOIN AuditMain.dbo.Companies CMP ON DB.CompanyID = CMP.CompanyID " & _
           "WHERE     DB.CompanyID = " & mCompanyID & " AND DB.DocumentID NOT IN (" & strWhereShowAll & ") AND DB.DocumentID NOT IN (" & strInSelected & ") " & _
           "ORDER BY  DB.Description"
    vsfgUnLinkedDoc.Rows = 1
    With GetRecords(sSql, AdoConnDoc)
        While Not .EOF
            vsfgUnLinkedDoc.Rows = vsfgUnLinkedDoc.Rows + 1
            Inc = vsfgUnLinkedDoc.Rows - 1
            vsfgUnLinkedDoc.TextMatrix(Inc, grdUnLinkDocument) = .Fields("Description") & ""
            vsfgUnLinkedDoc.TextMatrix(Inc, grdUnLinkDocID) = .Fields("DocumentID") & ""
            vsfgUnLinkedDoc.FontSize = 9
            vsfgUnLinkedDoc.Cell(flexcpAlignment, Inc, grdUnLinkDocument) = flexAlignLeftCenter
            SetPicture Inc, grdUnLinkIcon, Trim(.Fields("FileExt") & ""), vsfgUnLinkedDoc
            .MoveNext
        Wend
    .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

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

Public Sub AddDocument(Row As Long)
On Local Error GoTo Err_Exit
Dim Inc As Long
    With vsfgLinkedDoc
        .AddItem ""
        Inc = .Rows - 1
        .Cell(flexcpPicture, Inc, grdLinkIcon) = vsfgUnLinkedDoc.Cell(flexcpPicture, Row, grdUnLinkIcon)
        .TextMatrix(Inc, grdLinkDocument) = vsfgUnLinkedDoc.TextMatrix(Row, grdUnLinkDocument)
        .TextMatrix(Inc, grdLinkDocID) = vsfgUnLinkedDoc.TextMatrix(Row, grdUnLinkDocID)
        vsfgUnLinkedDoc.RemoveItem (Row)
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub RemoveDocument(Row As Long)
On Local Error GoTo Err_Exit
Dim Inc As Long
    With vsfgUnLinkedDoc
        .AddItem ""
        Inc = .Rows - 1
        .Cell(flexcpPicture, Inc, grdUnLinkIcon) = vsfgLinkedDoc.Cell(flexcpPicture, Row, grdLinkIcon)
        .TextMatrix(Inc, grdUnLinkDocument) = vsfgLinkedDoc.TextMatrix(Row, grdLinkDocument)
        .TextMatrix(Inc, grdUnLinkDocID) = vsfgLinkedDoc.TextMatrix(Row, grdLinkDocID)
        vsfgLinkedDoc.RemoveItem Row
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, IsInTran As Boolean, rsSave As New Recordset
Dim Inc As Long, lngSubSectionID As Long, lngProcedureID As Long, lngAcTypeID As Long
Dim lngSectionID As Long, lngID As Long
Dim strCompanyCode As String
Dim lngPeriodID As Long
    lngPeriodID = pActivePeriodID
    'Ref No: 016-12/07/09, Sunday 12 July 2009 -------------
    strCompanyCode = PickValue("Companies", "CompanyCode", "CompanyID = " & pActiveCompanyID)

    lngSectionID = PickValue("FilingSubSection", "SectionID", "SubSectionID = " & mlngSectionID)
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "DELETE FROM DocumentSubLinks WHERE PeriodID = " & mPeriodID & " AND SubSectionID = " & mlngSubSectionID & mstrWhere
    AdoConn.Execute sSql
    sSql = "Select * FROM DocumentSubLinks WHERE 1=2"
    Set rsSave = GetRecords(sSql)
    With rsSave
        For Inc = 1 To vsfgLinkedDoc.Rows - 1
            If vsfgLinkedDoc.TextMatrix(Inc, grdLinkDocument) <> "" Then
                .AddNew
'                If pServer = pServerLocal Then
'                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", mCompanyID * cnstDocLinkIDLocalMaxCount, (mCompanyID * cnstDocLinkIDLocalMaxCount) + cnstDocLinkIDLocalMaxCount)
'                Else
'                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", mCompanyID * cnstDocLinkIDMaxCount, (mCompanyID * cnstDocLinkIDMaxCount) + cnstDocLinkIDMaxCount)
'                End If
                'Ref No: 016-12/07/09, Sunday 12 July 2009 -------------
                If pServer = pServerLocal Then
'                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", strCompanyCode * cnstDocLinkIDLocalMaxCount, (strCompanyCode * cnstDocLinkIDLocalMaxCount) + cnstDocLinkIDLocalMaxCount)
                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", lngPeriodID * cnstDocLinkIDLocalMaxCount, (lngPeriodID * cnstDocLinkIDLocalMaxCount) + cnstDocLinkIDLocalMaxCount)
                Else
'                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", strCompanyCode * cnstDocLinkIDMaxCount, (strCompanyCode * cnstDocLinkIDMaxCount) + cnstDocLinkIDMaxCount)
                    lngID = GetRangeMaxNo("DocumentSubLinks", "DocLinkID", lngPeriodID * cnstDocLinkIDMaxCount, (lngPeriodID * cnstDocLinkIDMaxCount) + cnstDocLinkIDMaxCount)
                End If
'                .Fields("DocLinkID") = GetMaxNo("DocumentSubLinks", "DocLinkID")
                .Fields("DocLinkID") = lngID
                .Fields("RefNo") = txtRefNo.Text
                .Fields("Description") = mstrDescription                 'txtDescription.Text
                .Fields("SubSectionID") = mlngSubSectionID
                .Fields("PeriodID") = mPeriodID
                .Fields("DocumentID") = vsfgLinkedDoc.ValueMatrix(Inc, grdLinkDocID)
                .Fields("ProcedureID") = IIf(Trim(UCase(mstrIDType)) = "PROCEDURE", mlngId, Null)
                .Fields("AcTypeID") = IIf(Trim(UCase(mstrIDType)) = "ACCOUNTTYPE", mlngId, Null)
                .Fields("AcID") = IIf(Trim(UCase(mstrIDType)) = "ACCOUNTHEAD", mlngId, Null)
                .Fields("ResourceID") = IIf(Trim(UCase(mstrIDType)) = "RESOURCES", mlngId, Null)
                .Fields("LegalDocID") = IIf(Trim(UCase(mstrIDType)) = "LEGALDOCS", mlngId, Null)
                .Fields("Remarks") = mstrRemarks
                .Update
            End If
        Next Inc
       .Close
    End With
    AdoConn.CommitTrans
    Save = True
    Unload Me
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
        ShowError
    End If
    Save = False
End Function

Public Sub ShowDocumentLinks(lngLinkID As Long)
On Local Error GoTo Err_Exit
Dim strType As String, lngID As Long, sSql As String
    sSql = "Select * From DocumentSubLinks Where DocLinkID = " & lngLinkID
    With GetRecords(sSql)
        If Not .EOF Then
            If Val(.Fields("AcTypeID") & "") <> 0 Then
                lngID = Val(.Fields("AcTypeID") & "")
                strType = "ACCOUNTTYPE"
            ElseIf Val(.Fields("AcID") & "") <> 0 Then
                lngID = Val(.Fields("AcID") & "")
                strType = "ACCOUNTHEAD"
            ElseIf Val(.Fields("ProcedureID") & "") <> 0 Then
                lngID = Val(.Fields("ProcedureID") & "")
                strType = "PROCEDURE"
            End If
            ShowRelatedDocuments Val(.Fields("SubSectionID") & ""), Val(.Fields("PeriodID") & ""), strType, lngID
        End If
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowRelatedDocuments(lngSubSectionID As Long, lngPeriodID As Long, Optional IDType As String = "Nil", Optional lngID As Long = -1, Optional strDescription As String = "Nil", Optional strRemarks As String = "Nil")
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New Recordset, Inc As Long, strWhere As String
Dim strParticulars As String, strSection As String, strSubSection As String

    PeriodID = lngPeriodID
    mlngSubSectionID = lngSubSectionID
    strSubSection = "SUB SECTION : " & PickValue("FilingSubSection", "Description", "SubSectionID = " & mlngSubSectionID)
    mlngSectionID = Val(PickValue("FilingSubSection", "SectionID", "SubSectionID = " & mlngSubSectionID))
    strSection = "SECTION : " & PickValue("FilingSections", "Description", "SectionID = " & mlngSectionID)
    mlngId = lngID
    mstrIDType = IDType
    mstrRemarks = strRemarks
    
    Select Case Trim(UCase(IDType))
        Case "ACCOUNTTYPE"
            strParticulars = "Account Type : " & PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = " & mlngId & " AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0 "
            mstrDescription = txtDescription.Text
        Case "ACCOUNTHEAD"
            strParticulars = "Account Head : " & PickValue("AcHeads", "AcName", "AcID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = " & mlngId & " AND ISNULL(ProcedureID, 0) = 0 "
            mstrDescription = txtDescription.Text
        Case "PROCEDURE"
            strParticulars = "Procedure : " & PickValue("ProcedureQuestions", "Question", "QuestionID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = " & mlngId & " "
            mstrDescription = txtDescription.Text
        Case "RESOURCES"
            strParticulars = "Resource : " & PickValue("DocumentSubLinks", "Description", "ResourceID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0  AND ISNULL(ResourceID, 0) = " & mlngId & " "
            mstrDescription = txtDescription.Text
        Case "LEGALDOCS"
            strParticulars = "Particulars : " & PickValue("DocumentSubLinks", "Description", "LegalDocID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0  AND ISNULL(ResourceID, 0) = 0 AND ISNULL(LegalDocID, 0) = " & mlngId & " "
            mstrDescription = strDescription
            mstrRemarks = strRemarks
        Case Else
            strParticulars = "" '"PARTICULARS : Nil"
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0  AND ISNULL(ResourceID, 0) = 0 AND ISNULL(LegalDocID, 0) = 0"
    End Select
    With vsfgStructure
        .OutlineBar = flexOutlineBarCompleteLeaf
        .OutlineCol = 0
        
        .TextMatrix(0, 0) = strSection
        .Cell(flexcpFontSize, 0, 0) = 14
        .Cell(flexcpForeColor, 0, 0) = RGB(250, 50, 50)
        .RowHeight(0) = 360
        .IsSubtotal(0) = True
        .RowOutlineLevel(0) = 0
        .IsCollapsed(0) = flexOutlineExpanded
        
        .TextMatrix(1, 0) = strSubSection
        .Cell(flexcpFontSize, 1, 0) = 12
        .Cell(flexcpForeColor, 1, 0) = RGB(250, 100, 100)
        .RowHeight(1) = 320
        .IsSubtotal(1) = True
        .RowOutlineLevel(1) = 1
        .IsCollapsed(1) = flexOutlineExpanded
        
        .TextMatrix(2, 0) = strParticulars
        .Cell(flexcpFontSize, 2, 0) = 10
        .Cell(flexcpForeColor, 2, 0) = RGB(250, 125, 125)
        .RowHeight(2) = 280
        .IsSubtotal(2) = True
        .RowOutlineLevel(2) = 2
        .IsCollapsed(2) = flexOutlineExpanded
    End With
    '-----------------------------------------------------------------------------------------------
    ShowLinkedDocuments
    ShowDocuments (chkShowAll = vbChecked)
    Show vbModal
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgLinkedDoc_DblClick()
    cmdRemove_Click
End Sub

Private Sub vsfgUnLinkedDoc_DblClick()
    cmdAdd_Click
End Sub
