VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form frmDocLinking 
   Caption         =   "Document Linking"
   ClientHeight    =   7260
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7260
   ScaleWidth      =   9300
   WindowState     =   2  'Maximized
   Begin VB.Frame frameMain 
      Height          =   990
      Left            =   30
      TabIndex        =   5
      Top             =   -30
      Width           =   9210
      Begin VB.CommandButton fndSubSectionID 
         Height          =   315
         Left            =   3915
         Picture         =   "frmDocLinking.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   450
         Width           =   345
      End
      Begin VB.TextBox txtSubSectionID 
         Height          =   315
         Left            =   210
         Locked          =   -1  'True
         TabIndex        =   1
         Top             =   450
         Width           =   3675
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Filing Sub Section"
         Height          =   195
         Left            =   225
         TabIndex        =   7
         Top             =   240
         Width           =   1275
      End
      Begin VB.Label lblFilingSection 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   300
         Left            =   6630
         TabIndex        =   6
         Top             =   510
         Width           =   75
      End
   End
   Begin VB.Frame frameDocuments 
      Caption         =   "Documents"
      Height          =   5715
      Left            =   30
      TabIndex        =   0
      Top             =   1005
      Width           =   9210
      Begin VSFlex8Ctl.VSFlexGrid vsfgLink 
         Height          =   3765
         Left            =   240
         TabIndex        =   13
         Top             =   1815
         Width           =   2955
         _cx             =   5212
         _cy             =   6641
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
         Rows            =   1
         Cols            =   8
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   470
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmDocLinking.frx":018A
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
      Begin VB.Frame frameDetails 
         BorderStyle     =   0  'None
         Height          =   1755
         Left            =   120
         TabIndex        =   14
         Top             =   165
         Width           =   3180
         Begin VB.TextBox txtRefNo 
            Height          =   285
            Left            =   120
            TabIndex        =   3
            Top             =   315
            Width           =   2070
         End
         Begin VB.TextBox txtDescription 
            Height          =   645
            Left            =   120
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   4
            Top             =   900
            Width           =   2955
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Ref No"
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   16
            Top             =   105
            Width           =   510
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Description"
            Height          =   195
            Index           =   1
            Left            =   120
            TabIndex        =   15
            Top             =   690
            Width           =   795
         End
      End
      Begin TabDlg.SSTab SSTabMain 
         Height          =   5385
         Left            =   3375
         TabIndex        =   2
         Top             =   225
         Width           =   5715
         _ExtentX        =   10081
         _ExtentY        =   9499
         _Version        =   393216
         TabOrientation  =   3
         Style           =   1
         TabHeight       =   706
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         TabCaption(0)   =   "Lead Sheets"
         TabPicture(0)   =   "frmDocLinking.frx":028A
         Tab(0).ControlEnabled=   -1  'True
         Tab(0).Control(0)=   "vsfgLeadSheet"
         Tab(0).Control(0).Enabled=   0   'False
         Tab(0).ControlCount=   1
         TabCaption(1)   =   "Procedures"
         TabPicture(1)   =   "frmDocLinking.frx":02A6
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "vsfgProcedures"
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "External Documents"
         TabPicture(2)   =   "frmDocLinking.frx":02C2
         Tab(2).ControlEnabled=   0   'False
         Tab(2).Control(0)=   "vsfgBin"
         Tab(2).ControlCount=   1
         Begin VSFlex8Ctl.VSFlexGrid vsfgLeadSheet 
            Height          =   5160
            Left            =   150
            TabIndex        =   8
            Top             =   75
            Width           =   4995
            _cx             =   8811
            _cy             =   9102
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
            BackColorBkg    =   -2147483637
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
            Cols            =   3
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   315
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   $"frmDocLinking.frx":02DE
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
         Begin VSFlex8Ctl.VSFlexGrid vsfgProcedures 
            Height          =   5160
            Left            =   -74850
            TabIndex        =   9
            Top             =   75
            Width           =   4995
            _cx             =   8811
            _cy             =   9102
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
            BackColorBkg    =   -2147483637
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
            Cols            =   3
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   315
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   $"frmDocLinking.frx":0343
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
         Begin VSFlex8Ctl.VSFlexGrid vsfgBin 
            Height          =   5160
            Left            =   -74850
            TabIndex        =   10
            Top             =   75
            Width           =   4995
            _cx             =   8811
            _cy             =   9102
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
            BackColorBkg    =   -2147483637
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
            Cols            =   6
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   315
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   $"frmDocLinking.frx":03BB
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
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   45
      Top             =   6705
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
            Picture         =   "frmDocLinking.frx":0478
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":05D2
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":072C
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":0886
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":0A60
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":0BBA
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":0D94
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":0EEE
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":23F0
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":25CA
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":27A4
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDocLinking.frx":297E
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   4785
      TabIndex        =   12
      Top             =   6855
      Width           =   4440
      _ExtentX        =   7832
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
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Delete"
            Key             =   "Delete"
            ImageKey        =   "Delete"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmDocLinking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim rsDoc As ADODB.Recordset
Dim Inc As Long, mPeriodID As Long, mCompanyID As Long
Public mlngId As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean
Dim mLastPeriodID As Long, mDefaultPeriodID As Long

Const grdBinRefNo = 0
Const grdBinFileExt = 1
Const grdBinDocName = 2
Const grdBinRemarks = 3
Const grdBinDocId = 4

Const grdProcedureName = 0
Const grdProcedureTypeID = 1
Const grdProcedureID = 2

Const grdLeadSheetAcTypes = 0
Const grdLeadSheetAcTypeId = 1
Const grdLeadSheetAcTypeCode = 2

Const grdLinkSlNo = 0
Const grdLinkData = 1
Const grdLinkRefNo = 2
Const grdLinkDescription = 3
Const grdLinkDocName = 4
Const grdLinkDocID = 5
Const grdLinkProcedureID = 6
Const grdLinkAcTypeID = 7

Const pclrLeadsheet = &HC0FFC0
Const pclrProcedure = &HFFC0C0
Const pclrBinDoc = &HC0FFFF

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
   frameDetails.Enabled = blnNewValue
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
'         lngId = 0
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

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    VsfgBin.Rows = 1
    vsfgLeadSheet.Rows = 1
    vsfgLink.Rows = 1
    vsfgProcedures.Rows = 1
    lblFilingSection = ""
End Sub

Public Function DisplayDocuments(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
    Dim sSql As String, strDescription As String
    vsfgLink.Rows = 1: Inc = 0
    sSql = "SELECT FD.RefNo, FD.Description, FD.DocSlNo, DOC.DocumentName, PRC.ProcedureName, AT.AcTypeName, FD.PeriodID, FD.DocumentID, FD.ProcedureID, FD.AcTypeID FROM FilingDocuments FD LEFT OUTER JOIN " & _
           "Documents DOC ON FD.DocumentID = DOC.DocumentID LEFT OUTER JOIN Procedures PRC ON FD.ProcedureID = PRC.ProcedureID LEFT OUTER JOIN " & _
           "AcTypes AT ON FD.AcTypeID = AT.AcTypeID WHERE FD.SubSectionID = " & lngSubSectionID & " AND FD.PeriodID = " & mPeriodID & " ORDER BY FD.DocSlNo"
    With GetRecords(sSql, AdoConn)
        While .EOF <> True
            vsfgLink.Rows = vsfgLink.Rows + 1
            Inc = Inc + 1
            strDescription = ""
            If Trim(.Fields("DocumentName") & "") = "" Then
                strDescription = Trim(.Fields("DocumentName") & "")
            ElseIf Trim(.Fields("ProcedureName") & "") = "" Then
                strDescription = Trim(.Fields("ProcedureName") & "")
            ElseIf Trim(.Fields("AcTypeName") & "") = "" Then
                strDescription = Trim(.Fields("AcTypeName") & "")
            End If
            If Len(strDescription) > 20 Then
                strDescription = Left(strDescription, 17) & "..."
            End If
            vsfgLink.TextMatrix(Inc, grdLinkSlNo) = Inc
            vsfgLink.TextMatrix(Inc, grdLinkData) = .Fields("RefNo") & "" & vbNewLine & strDescription
            vsfgLink.TextMatrix(Inc, grdLinkDocName) = strDescription
            vsfgLink.TextMatrix(Inc, grdLinkRefNo) = .Fields("RefNo") & ""
            vsfgLink.TextMatrix(Inc, grdLinkDescription) = .Fields("Description") & ""
            vsfgLink.TextMatrix(Inc, grdLinkDocID) = .Fields("DocumentID") & ""
            vsfgLink.TextMatrix(Inc, grdLinkProcedureID) = .Fields("ProcedureID") & ""
            vsfgLink.TextMatrix(Inc, grdLinkAcTypeID) = .Fields("AcTypeID") & ""
            .MoveNext
        Wend
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function DisplayBin(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
    Dim sSql As String
    VsfgBin.Rows = 1
    sSql = "Select *, 1 AS IsShow From Documents Where PeriodID = " & mPeriodID & " AND DocumentID Not In (Select DocumentID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") "
    sSql = sSql & " Union Select *, 0 AS IsShow From Documents Where PeriodID = " & mPeriodID & " AND DocumentID In (Select DocumentID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") ORDER BY RefNo "
    Inc = 1
    With GetRecords(sSql, AdoConn)
        While .EOF <> True
            VsfgBin.Rows = VsfgBin.Rows + 1
            VsfgBin.TextMatrix(Inc, grdBinRefNo) = .Fields("RefNo") & " "
            SetExtPic Inc, Trim(.Fields("FileExt") & "")
            VsfgBin.TextMatrix(Inc, grdBinDocName) = .Fields("DocumentName") & " "
            VsfgBin.TextMatrix(Inc, grdBinRemarks) = .Fields("Remarks") & " "
            VsfgBin.TextMatrix(Inc, grdBinDocId) = .Fields("DocumentID") & " "
            If .Fields("IsShow") = 0 Then
                VsfgBin.RowHidden(Inc) = True
            End If
            Inc = Inc + 1
            .MoveNext
        Wend
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function DisplayProcedures(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
    Dim sSql As String
    vsfgProcedures.Rows = 1
    sSql = "Select *, 1 AS IsShow From Procedures Where ProcedureID Not In (Select ProcedureID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") "
    sSql = sSql & " Union Select *, 0 AS IsShow From Procedures Where ProcedureID In (Select ProcedureID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") Order By ProcedureName"
    Inc = 1
    With GetRecords(sSql, AdoConn)
        While .EOF <> True
            vsfgProcedures.Rows = vsfgProcedures.Rows + 1
            vsfgProcedures.TextMatrix(Inc, grdProcedureName) = .Fields("ProcedureName") & ""
            vsfgProcedures.TextMatrix(Inc, grdProcedureTypeID) = .Fields("ProcedureTypeID") & ""
            vsfgProcedures.TextMatrix(Inc, grdProcedureID) = .Fields("ProcedureID") & ""
            
            If .Fields("IsShow") = 0 Then
                 vsfgProcedures.RowHidden(Inc) = True
            End If
            Inc = Inc + 1
            .MoveNext
        Wend
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function DisplayLeadSheet(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
    Dim sSql As String
    vsfgLeadSheet.Rows = 1
    sSql = "Select *, 1 AS IsShow  From Actypes  Where CompanyID = " & mCompanyID & " AND AcTypeID Not In (Select AcTypeID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") "
    sSql = sSql & " Union Select *, 0 AS IsShow  From Actypes  Where CompanyID = " & mCompanyID & " AND AcTypeID In (Select AcTypeID From FilingDocuments Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & ") Order By AcTypeName "
    Inc = 1
    With GetRecords(sSql, AdoConn)
        While .EOF <> True
            vsfgLeadSheet.Rows = vsfgLeadSheet.Rows + 1
            vsfgLeadSheet.TextMatrix(Inc, grdLeadSheetAcTypes) = .Fields("ActypeName") & ""
            vsfgLeadSheet.TextMatrix(Inc, grdLeadSheetAcTypeId) = .Fields("AcTypeID") & ""
            vsfgLeadSheet.TextMatrix(Inc, grdLeadSheetAcTypeCode) = .Fields("AcTypeCode") & ""
            If .Fields("IsShow") = 0 Then
                vsfgLeadSheet.RowHidden(Inc) = True
            End If
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
    VsfgBin.Cell(flexcpPicture, Row, grdBinFileExt) = Nothing
    VsfgBin.Cell(flexcpPicture, Row, grdBinFileExt) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
    If Err.Number <> 0 Then
        VsfgBin.Cell(flexcpPicture, Row, grdBinFileExt) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
    End If
End Sub

Private Sub fndSubSectionID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
    Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpSubFilingSubSection, , "XSubSectionID", , fndSubSectionID, , , 1)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtSubSectionID.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtSubSectionID.Tag = mlngId
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(mlngId)
        ShowOpen = True
    End Select
End Function

Public Function ValueCollect(ByVal lngID As Long) As Boolean
On Error GoTo Err_Exit
Dim sSql As String
    sSql = "SELECT FSS.*, FilingSections.Description AS Section FROM FilingSubSection FSS LEFT OUTER JOIN " & _
           "FilingSections ON FSS.SectionID = FilingSections.SectionID Where FSS.SubSectionID = " & lngID
    With GetRecords(sSql)
        If Not .EOF Then
            txtSubSectionID.Tag = Val(.Fields("SubSectionID") & "")
            txtSubSectionID = .Fields("Description") & ""
            lblFilingSection = .Fields("Section") & ""
        End If
        .Close
    End With
    DisplayBin lngID
    DisplayLeadSheet lngID
    DisplayProcedures lngID
    DisplayDocuments lngID
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Private Sub Form_Load()
    ClearValues
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub UpdateDetails()
    If vsfgLink.Row <= 0 Then Exit Sub
    vsfgLink.TextMatrix(vsfgLink.Row, grdLinkDescription) = txtDescription
    vsfgLink.TextMatrix(vsfgLink.Row, grdLinkRefNo) = txtRefNo
End Sub

Private Sub txtDescription_Change()
    UpdateDetails
End Sub

Private Sub txtRefNo_Change()
    UpdateDetails
End Sub

Private Sub VsfgBin_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub VsfgBin_DblClick()
    AddDocument "DocmentFiles", VsfgBin.Row
End Sub

Private Sub VsfgBin_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    VsfgBin.ToolTipText = VsfgBin.Text
End Sub

Private Sub VsfgBin_RowColChange()
    SelectRow VsfgBin
End Sub

Private Sub vsfgLeadSheet_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub vsfgLeadSheet_DblClick()
    AddDocument "Leadsheet", vsfgLeadSheet.Row
End Sub

Private Sub vsfgLeadSheet_RowColChange()
    SelectRow vsfgLeadSheet
End Sub

Private Sub vsfgLink_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub vsfgLink_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        RemoveDocument vsfgLink.Row
    End If
End Sub


Private Sub vsfgLink_RowColChange()
    If vsfgLink.Row <= 0 Then Exit Sub
    txtDescription = vsfgLink.TextMatrix(vsfgLink.Row, grdLinkDescription)
    txtRefNo = vsfgLink.TextMatrix(vsfgLink.Row, grdLinkRefNo)
End Sub

Private Sub vsfgProcedures_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub vsfgProcedures_DblClick()
    AddDocument "Procedure", vsfgProcedures.Row
End Sub

Public Function AddDocument(strDocType As String, Row As Long) As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    If Not IsModify Then Exit Function
    With vsfgLink
        .Rows = .Rows + 1
        Inc = .Rows - 1
        txtDescription = ""
        txtRefNo = ""
        Select Case strDocType
            Case "Leadsheet"
                .TextMatrix(Inc, grdLinkData) = vsfgLeadSheet.TextMatrix(Row, grdLeadSheetAcTypes)
                .TextMatrix(Inc, grdLinkDocName) = vsfgLeadSheet.TextMatrix(Row, grdLeadSheetAcTypes)
                .TextMatrix(Inc, grdLinkAcTypeID) = vsfgLeadSheet.TextMatrix(Row, grdLeadSheetAcTypeId)
                .Cell(flexcpBackColor, Inc, grdLinkSlNo, Inc, grdLinkData) = pclrLeadsheet
                vsfgLeadSheet.RowHidden(Row) = True
            Case "Procedure"
                .TextMatrix(Inc, grdLinkData) = vsfgProcedures.TextMatrix(Row, grdProcedureName)
                .TextMatrix(Inc, grdLinkDocName) = vsfgProcedures.TextMatrix(Row, grdProcedureName)
                .TextMatrix(Inc, grdLinkProcedureID) = vsfgProcedures.TextMatrix(Row, grdProcedureID)
                .Cell(flexcpBackColor, Inc, grdLinkSlNo, Inc, grdLinkData) = pclrProcedure
                vsfgProcedures.RowHidden(Row) = True
            Case "DocmentFiles"
                .TextMatrix(Inc, grdLinkData) = VsfgBin.TextMatrix(Row, grdBinDocName)
                .TextMatrix(Inc, grdLinkDocName) = VsfgBin.TextMatrix(Row, grdBinDocName)
                .TextMatrix(Inc, grdLinkDocID) = VsfgBin.TextMatrix(Row, grdBinDocId)
                .Cell(flexcpBackColor, Inc, grdLinkSlNo, Inc, grdLinkData) = pclrBinDoc
                VsfgBin.RowHidden(Row) = True
        End Select
    End With
    PutSlNo vsfgLink, grdLinkSlNo, grdLinkData
Exit Function
Err_Exit:
    ShowError
End Function

Public Function RemoveDocument(Row As Long) As Boolean
On Local Error GoTo Err_Exit
Dim lngColID As Long, lngColID1 As Long, VSFG As VSFlexGrid, Inc As Long
    If Not IsModify Then Exit Function
    If Row <= 0 Then Exit Function
    With vsfgLink
        If .ValueMatrix(Row, grdLinkAcTypeID) <> 0 Then
            Set VSFG = vsfgLeadSheet
            lngColID = grdLeadSheetAcTypeId
            lngColID1 = grdLinkAcTypeID
        ElseIf .ValueMatrix(Row, grdLinkProcedureID) <> 0 Then
            Set VSFG = vsfgProcedures
            lngColID = grdProcedureID
            lngColID1 = grdLinkProcedureID
        ElseIf .ValueMatrix(Row, grdLinkDocID) <> 0 Then
            Set VSFG = VsfgBin
            lngColID = grdBinDocId
            lngColID1 = grdLinkDocID
        End If
    End With
    For Inc = 1 To VSFG.Rows - 1
        If VSFG.ValueMatrix(Inc, lngColID) = vsfgLink.ValueMatrix(Row, lngColID1) Then
            VSFG.RowHidden(Inc) = False
            Exit For
        End If
    Next Inc
    vsfgLink.RemoveItem Row
    RemoveDocument = True
Exit Function
Err_Exit:
    RemoveDocument = False
End Function

Private Sub vsfgProcedures_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgProcedures.ToolTipText = vsfgProcedures.Text
End Sub

Private Sub vsfgProcedures_RowColChange()
    SelectRow vsfgProcedures
End Sub

Public Function Save() As Boolean
On Error GoTo Err_Exit
Dim IsInTran As Boolean, rsSave As ADODB.Recordset
    '--------------------------------------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    AdoConn.Execute "Delete from FilingDocuments Where SubSectionID = " & Val(txtSubSectionID.Tag)
    Set rsSave = GetRecords("Select * From  FilingDocuments", AdoConn)
    With rsSave
        For Inc = 0 To vsfgLink.Rows - 1
            If Trim(vsfgLink.TextMatrix(Inc, grdLinkRefNo)) = "" Then
                pMVE.MsgBox "Reference No: Not Mentioned for '" & vsfgLink.TextMatrix(Inc, grdLinkData) & "'.", msgOK, , msgCritical, True
                Save = False
                Exit Function
            End If
            .AddNew
            .Fields("SubSectionID") = txtSubSectionID.Tag
            .Fields("PeriodID") = mPeriodID
            .Fields("DocSlNo") = Inc
            .Fields("RefNo") = vsfgLink.TextMatrix(Inc, grdLinkRefNo)
            .Fields("Description") = vsfgLink.TextMatrix(Inc, grdLinkDescription)
            .Fields("DocumentID") = IIf(vsfgLink.ValueMatrix(Inc, grdLinkDocID) = 0, Null, vsfgLink.ValueMatrix(Inc, grdLinkDocID))
            .Fields("ProcedureID") = IIf(vsfgLink.ValueMatrix(Inc, grdLinkProcedureID) = 0, Null, vsfgLink.ValueMatrix(Inc, grdLinkProcedureID))
            .Fields("AcTypeID") = IIf(vsfgLink.ValueMatrix(Inc, grdLinkAcTypeID) = 0, Null, vsfgLink.ValueMatrix(Inc, grdLinkAcTypeID))
            .Update
        Next
       .Close
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
End Function
