VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.OCX"
Begin VB.Form frmTrialBalance 
   BackColor       =   &H80000004&
   Caption         =   "Trial Balance"
   ClientHeight    =   10470
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   15225
   ControlBox      =   0   'False
   FillStyle       =   0  'Solid
   ForeColor       =   &H00000000&
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   10470
   ScaleWidth      =   15225
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtSearch 
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5640
      TabIndex        =   23
      Top             =   80
      Width           =   2190
   End
   Begin VB.CommandButton cmdSearch 
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   7825
      Picture         =   "frmTrialBalance.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   22
      Top             =   80
      Width           =   315
   End
   Begin VB.ComboBox cmbPeriod 
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      ItemData        =   "frmTrialBalance.frx":018A
      Left            =   11700
      List            =   "frmTrialBalance.frx":018C
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Top             =   80
      Width           =   3420
   End
   Begin VB.CommandButton cmdShowTB 
      Caption         =   "Show TB Sorted"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   10200
      TabIndex        =   20
      Top             =   80
      Width           =   1400
   End
   Begin VB.CommandButton cmdUnHide 
      Caption         =   "Show Inactive Items"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   8280
      TabIndex        =   19
      Top             =   80
      Width           =   1755
   End
   Begin VB.CommandButton cmdLock 
      Appearance      =   0  'Flat
      Height          =   450
      Left            =   5100
      Picture         =   "frmTrialBalance.frx":018E
      Style           =   1  'Graphical
      TabIndex        =   18
      ToolTipText     =   "Lock"
      Top             =   0
      Width           =   450
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   450
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   5085
      _ExtentX        =   8969
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "imglstToolbar"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   12
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Properties"
            Object.ToolTipText     =   "Properties"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Refresh"
            Object.ToolTipText     =   "Refresh"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save"
            Object.ToolTipText     =   "Save"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ExporttoExcel"
            Object.ToolTipText     =   "Export to Excel"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CollapseAll"
            Object.ToolTipText     =   "CollapseAll"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CollapseSub"
            Object.ToolTipText     =   "Collapse Sub Level"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ExpandSub"
            Object.ToolTipText     =   "Expand Sub Level"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "ExpandAll"
            Object.ToolTipText     =   "Expand All"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   350
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Report"
            Object.ToolTipText     =   "Reports"
            ImageIndex      =   12
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   7
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptTBDetailed"
                  Text            =   "TB-Detailed"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptBalanceSheet"
                  Text            =   "Balance Sheet"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptProfitLoss"
                  Text            =   "Profit & Loss"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptSchedules"
                  Text            =   "Schedules"
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptLeadSheet"
                  Text            =   "Leadsheet"
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptAdjustment"
                  Text            =   "User Adjustment Entries"
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "RptErrorSchedule"
                  Text            =   "Error Schedule Entries"
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.ComboBox cmbPeriod1 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "frmTrialBalance.frx":0826
         Left            =   8000
         List            =   "frmTrialBalance.frx":0828
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   0
         Width           =   3555
      End
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTotal 
      Height          =   270
      Left            =   90
      TabIndex        =   6
      Top             =   9900
      Width           =   6570
      _cx             =   11589
      _cy             =   476
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
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
      Cols            =   10
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   400
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
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
   Begin MSComctlLib.ImageList ImgTree 
      Left            =   720
      Top             =   8880
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":082A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":0984
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":0ADE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":0CB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":0E92
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imglstToolbar 
      Left            =   13485
      Top             =   495
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   20
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":0FEC
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":17B3
            Key             =   "Refresh"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":2426
            Key             =   "Search"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":2C04
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":3199
            Key             =   "Export2"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":40AC
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":4966
            Key             =   "Srch"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":51C4
            Key             =   "Export"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":5DC0
            Key             =   "Search2"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":6680
            Key             =   "Export1"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":6C1A
            Key             =   "Refresh1"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":6D74
            Key             =   "Reports"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":7341
            Key             =   "Report1"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":8003
            Key             =   "CollapseAll"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":81DD
            Key             =   "ExpandAll"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":83B7
            Key             =   "Search1"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":AB69
            Key             =   "CollapseSub"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":AC4B
            Key             =   "ExpandSub"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":AE25
            Key             =   "Print1"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmTrialBalance.frx":BCFF
            Key             =   "Report2"
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtConverge 
      Height          =   360
      Left            =   90
      TabIndex        =   12
      Text            =   "Converge Me"
      Top             =   45
      Width           =   330
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTree 
      Height          =   9420
      Left            =   0
      TabIndex        =   0
      Top             =   450
      Width           =   15180
      _cx             =   26776
      _cy             =   16616
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9.75
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
      GridColor       =   14737632
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   4
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   8
      GridLinesFixed  =   0
      GridLineWidth   =   1
      Rows            =   50
      Cols            =   15
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmTrialBalance.frx":C8B3
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
      FrozenRows      =   2
      FrozenCols      =   0
      AllowUserFreezing=   2
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   4
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
      Begin Crystal.CrystalReport Report 
         Left            =   3720
         Top             =   6840
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileType   =   19
         PrintFileLinesPerPage=   60
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgAddNew 
         Height          =   1950
         Left            =   5130
         TabIndex        =   7
         Top             =   1665
         Visible         =   0   'False
         Width           =   4770
         _cx             =   8414
         _cy             =   3440
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
         BackColorBkg    =   -2147483633
         BackColorAlternate=   -2147483643
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   0
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   0
         Cols            =   0
         FixedRows       =   0
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   ""
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
         Begin VB.TextBox txtAddNewName 
            Height          =   315
            Left            =   135
            TabIndex        =   9
            Top             =   585
            Width           =   4440
         End
         Begin MSComctlLib.Toolbar tbrAddNew 
            Height          =   330
            Left            =   2415
            TabIndex        =   11
            Top             =   1380
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
         Begin MSComctlLib.ImageList imglstCtrls 
            Left            =   90
            Top             =   1245
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
                  Picture         =   "frmTrialBalance.frx":C9F4
                  Key             =   "New"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":CB4E
                  Key             =   "Open"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":CCA8
                  Key             =   "Modify"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":CE02
                  Key             =   "Delete"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":CFDC
                  Key             =   "Save"
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":D136
                  Key             =   "Print"
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":D310
                  Key             =   "Notes"
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":D46A
                  Key             =   "Status"
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":E96C
                  Key             =   "Close"
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":EB46
                  Key             =   "Copy"
               EndProperty
               BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":ED20
                  Key             =   "Help"
               EndProperty
            EndProperty
         End
         Begin AIFCmp1.asxPowerBanner lblHeaderAddNew 
            Height          =   285
            Left            =   0
            Top             =   0
            Width           =   4740
            _ExtentX        =   8361
            _ExtentY        =   503
            EndColor        =   14737632
            FormatString    =   "Account Heads"
            Orientation     =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            TextColor       =   16777215
         End
         Begin VB.Label lblGroupAddNew 
            AutoSize        =   -1  'True
            Caption         =   "Group Name"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   195
            Left            =   150
            TabIndex        =   10
            Top             =   1050
            Width           =   1065
         End
         Begin VB.Label lblCaptionAddNew 
            AutoSize        =   -1  'True
            Caption         =   "Account Name"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H0000C0C0&
            Height          =   195
            Left            =   150
            TabIndex        =   8
            Top             =   360
            Width           =   1260
         End
      End
      Begin MSComctlLib.ImageList imgWallpaper 
         Left            =   240
         Top             =   7680
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   130
         ImageHeight     =   130
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmTrialBalance.frx":EEFA
               Key             =   "Lock"
            EndProperty
         EndProperty
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgPassword 
         Height          =   1590
         Left            =   5160
         TabIndex        =   13
         Top             =   4680
         Visible         =   0   'False
         Width           =   3210
         _cx             =   5662
         _cy             =   2805
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
         BackColorBkg    =   -2147483633
         BackColorAlternate=   -2147483643
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   0
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   0
         Cols            =   0
         FixedRows       =   0
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   ""
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
         Begin VB.TextBox txtPassword 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            IMEMode         =   3  'DISABLE
            Left            =   135
            PasswordChar    =   "*"
            TabIndex        =   14
            Top             =   585
            Width           =   2880
         End
         Begin MSComctlLib.Toolbar tbrPassword 
            Height          =   330
            Left            =   2175
            TabIndex        =   15
            Top             =   1020
            Width           =   795
            _ExtentX        =   1402
            _ExtentY        =   582
            ButtonWidth     =   1376
            ButtonHeight    =   582
            AllowCustomize  =   0   'False
            Wrappable       =   0   'False
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "&Ok"
                  Key             =   "Ok"
                  ImageIndex      =   3
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.ImageList ImageList 
            Left            =   90
            Top             =   1005
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
                  Picture         =   "frmTrialBalance.frx":FACB
                  Key             =   "New"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":FC25
                  Key             =   "Open"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":FD7F
                  Key             =   "Ok"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":103B7
                  Key             =   "Modify"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":10511
                  Key             =   "Delete"
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":106EB
                  Key             =   "Save"
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":10845
                  Key             =   "Print"
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":10A1F
                  Key             =   "Notes"
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":10B79
                  Key             =   "Status"
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":1207B
                  Key             =   "Close"
               EndProperty
               BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":12255
                  Key             =   "Copy"
               EndProperty
               BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmTrialBalance.frx":1242F
                  Key             =   "Help"
               EndProperty
            EndProperty
         End
         Begin AIFCmp1.asxPowerBanner lblEnterPassword 
            Height          =   285
            Left            =   0
            Top             =   0
            Width           =   4740
            _ExtentX        =   8361
            _ExtentY        =   503
            EndColor        =   14737632
            FormatString    =   "Enter Password"
            Orientation     =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            TextColor       =   16777215
         End
      End
      Begin VB.Shape shpConverge 
         BorderColor     =   &H00000000&
         BorderStyle     =   3  'Dot
         BorderWidth     =   2
         DrawMode        =   1  'Blackness
         Height          =   1710
         Left            =   120
         Top             =   3135
         Visible         =   0   'False
         Width           =   4110
      End
      Begin VB.Shape shpSelection 
         BorderColor     =   &H8000000D&
         Height          =   1680
         Left            =   30
         Top             =   600
         Visible         =   0   'False
         Width           =   4110
      End
   End
   Begin MSComDlg.CommonDialog cdFolderBrowse 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      FileName        =   "cdFile"
   End
   Begin VB.Label lblLastCr 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   12225
      TabIndex        =   5
      Top             =   10095
      Width           =   390
   End
   Begin VB.Label lblLastDr 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   10905
      TabIndex        =   4
      Top             =   10095
      Width           =   390
   End
   Begin VB.Label lblThisCr 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   9465
      TabIndex        =   3
      Top             =   10095
      Width           =   390
   End
   Begin VB.Label lblThisDr 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   8385
      TabIndex        =   2
      Top             =   10095
      Width           =   390
   End
   Begin VB.Label lblBalance 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   6825
      TabIndex        =   1
      Top             =   10095
      Width           =   390
   End
End
Attribute VB_Name = "frmTrialBalance"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const grdAcName = 0
Const grdNature = 1
Const grdRefNo = 2
Const grdStatus = 3
Const grdSchedule = 4
Const grdThisDebit = 5
Const grdThisCredit = 6
Const grdLastDebit = 7
Const grdLastCredit = 8
Const grdFormula = 9
Const grdAcTypeID = 10
Const grdAcID = 11
Const grdIsOtherEntries = 12
Const grdActualDr = 13
Const grdActualCr = 14
Const grdCols = 15

Const cnstBtnsAcType = 0
Const cnstBtnsAcHeads = 1
Const cnstBtnsSchedules = 2
Const cnstBtnsFinanceLease = 3
Const cnstBtnsFixedAssets = 4
Const cnstBtnsEquity = 5
Const cnstBtnsCashFlow = 6
Const cnstBtnsLeadSheet = 7
Const cnstBtnsReport = 8
Const cnstBtnsFeedBack = 9
Const cnstBtnsCancel = 10
Const cnstBtnsEditCancel = 11
Const cnstBtnsRefresh = 12
Const cnstBtnsPrint = 13
Const cnstBtnsSave = 14

Public mstrThisPeriodDesc As String
Public mstrLastPeriodDesc As String

Public lngTreelevel As Long, lngTreeLevelMax As Long, lngDecimals As Long
Dim mPeriodID As Long, mDefaultPeriodID As Long, mPeriodDesc As String, mLastPeriodID As Long, mLastPeriodDesc As String, mCompanyID As Long
Dim cgTmpTreeGrid As New clsGrid, CurRow As Long, CurTopRow As Long, IsLocked As Boolean
Dim sSql As String
Dim crsCollectData As New clsRecordSet
Dim crsAllAcTypes As New clsRecordSet
Dim crsAllAcHeads As New clsRecordSet

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
    tbrCtrls.Buttons("Save").Enabled = Not IsReadOnly
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
'    sSql3 = "Select FinalisedBy From Periods Where PeriodID = " & mPeriodID
'        With GetRecords(sSql3)
'            While Not .EOF
'                If .Fields("FinalisedBy") <> "" Then
'                    IsReadOnly = True
'                    vsfgTree.Enabled = False
'                End If
'                .MoveNext
'            Wend
'            .Close
'        End With
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    vsfgTree.Enabled = blnNewValue
    tbrCtrls.Enabled = Not blnNewValue
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
Dim sSql As String
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    If mCompanyID <= 0 Then
        mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
        sSql = "SELECT  PeriodID AS IDField, ShortName + '  ' + Convert(varchar,CONVERT(DateTime, StartDt - 2, 103),103) + ' - ' + Convert(Varchar,CONVERT(DateTime, EndDt - 2, 103),103) AS NameField " & _
               "FROM Periods WHERE CompanyID =" & mCompanyID & " Order By StartDt"
        SetComboList cmbPeriod, sSql
    End If
    '----------------------------------
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & mPeriodID))
    mstrThisPeriodDesc = PickValue("Periods", "Description", "PeriodID = " & mPeriodID)
    mstrLastPeriodDesc = PickValue("Periods", "Description", "PeriodID = " & mLastPeriodID)
    RefreshTrial
    ExpandCollapse True, False
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub InitControls()
    'Initialize Tree Control
    With vsfgTree
        .Rows = 0
        .Left = 50
        ' Appearance
        .BackColorBkg = .BackColor
        .SheetBorder = .BackColor
        .Redraw = flexRDBuffered
        .OutlineCol = 0
        .OutlineBar = flexOutlineBarCompleteLeaf
        .Ellipsis = flexEllipsisEnd

        'Behavior
        .AllowSelection = False
        .Highlight = flexHighlightWithFocus
        .ScrollTrack = True
        .AutoSearch = flexSearchNone
        .Editable = flexEDKbdMouse
    End With
End Sub

Public Sub FormatGrid()
    With vsfgTree
         .ColWidth(grdAcName) = GetProportionalValue(5300, False)
         .ColWidth(grdNature) = GetProportionalValue(500, False)
         .ColWidth(grdRefNo) = GetProportionalValue(750, False)
         .ColWidth(grdStatus) = GetProportionalValue(500, False)
         .ColWidth(grdSchedule) = GetProportionalValue(600, False)
         .ColWidth(grdThisDebit) = GetProportionalValue(2100, False)
         .ColWidth(grdThisCredit) = GetProportionalValue(2100, False)
         .ColWidth(grdLastDebit) = GetProportionalValue(1750, False)
         .ColWidth(grdLastCredit) = GetProportionalValue(1750, False)

         .ColWidth(grdAcID) = 0
         .ColWidth(grdIsOtherEntries) = 0
         .ColWidth(grdActualDr) = 0
         .ColWidth(grdActualCr) = 0
         .ColWidth(grdAcTypeID) = 0
         .ColWidth(grdFormula) = 0
        
         .ColComboList(grdSchedule) = "..."
         .ColComboList(grdNature) = "..."

         .ColAlignment(grdAcName) = flexAlignLeftCenter
         .ColAlignment(grdRefNo) = flexAlignRightCenter
         .ColAlignment(grdStatus) = flexAlignCenterCenter
         .ColAlignment(grdSchedule) = flexAlignLeftCenter
         .ColAlignment(grdThisDebit) = flexAlignRightCenter
         .ColAlignment(grdThisCredit) = flexAlignRightCenter
         .RowHeightMin = 330

         '---Positioning Bottom Total Labels---
         .Col = grdRefNo
         lblBalance.Left = .CellLeft + .CellWidth - lblBalance.Width
         .Col = grdThisDebit
         lblThisDr.Left = .CellLeft + .CellWidth - lblThisDr.Width
         .Col = grdThisCredit
         lblThisCr.Left = .CellLeft + .CellWidth - lblThisCr.Width
         .Col = grdLastDebit
         lblLastDr.Left = .CellLeft + .CellWidth - lblLastDr.Width
         .Col = grdLastCredit
         lblLastCr.Left = .CellLeft + .CellWidth - lblLastCr.Width

         vsfgTotal.Cols = .Cols
         vsfgTotal.ColWidth(grdAcName) = .ColWidth(grdAcName)
         vsfgTotal.ColWidth(grdNature) = .ColWidth(grdNature)
         vsfgTotal.ColWidth(grdRefNo) = .ColWidth(grdRefNo)
         vsfgTotal.ColWidth(grdStatus) = .ColWidth(grdStatus)
         vsfgTotal.ColWidth(grdSchedule) = .ColWidth(grdSchedule)
         vsfgTotal.ColWidth(grdThisDebit) = .ColWidth(grdThisDebit)
         vsfgTotal.ColWidth(grdThisCredit) = .ColWidth(grdThisCredit)
         vsfgTotal.ColWidth(grdLastDebit) = .ColWidth(grdLastDebit)
         vsfgTotal.ColWidth(grdLastCredit) = .ColWidth(grdLastCredit)
         vsfgTotal.ColWidth(grdAcID) = .ColWidth(grdAcID)
         vsfgTotal.ColWidth(grdIsOtherEntries) = .ColWidth(grdIsOtherEntries)
         vsfgTotal.ColWidth(grdActualDr) = .ColWidth(grdActualDr)
         vsfgTotal.ColWidth(grdActualCr) = .ColWidth(grdActualCr)
         vsfgTotal.ColWidth(grdAcTypeID) = .ColWidth(grdAcTypeID)
         vsfgTotal.ColWidth(grdFormula) = .ColWidth(grdFormula)
         vsfgTotal.Cell(flexcpBackColor, 0, grdLastDebit, 0, grdLastCredit) = RGB(250, 250, 250)
    End With
End Sub

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Public Sub PrintDatasheet()
On Local Error Resume Next
Dim crTmp As New clsReports
Dim RowInc As Long, ColInc As Long, RowInc1 As Long
    Screen.MousePointer = vbHourglass
    With crTmp
        .StartReport pprA4, 1440 * 0.5, 1440 * 0.5, 1440 * 0.5, 1440 * 0.5, 0, , , , rptTypeTemporary
        .StartTable 1440 * 0.5, 1440 * 0.5, 12000, 10000, rptTTBalanceSheet
        .TableCols = vsfgTree.Cols
        RowInc1 = -1
        For RowInc = 0 To vsfgTree.Rows - 1
            If Not vsfgTree.RowHidden(RowInc) Then
                RowInc1 = RowInc1 + 1
                .TableRows = RowInc1 + 1
                For ColInc = 0 To vsfgTree.Cols - 1
                    If Not vsfgTree.ColHidden(ColInc) And vsfgTree.ColWidth(ColInc) > 10 Then
                        If ColInc = grdAcName And vsfgTree.RowOutlineLevel(RowInc) > 0 Then
                            .TableCell(rptTblText, RowInc1, ColInc) = String((vsfgTree.RowOutlineLevel(RowInc) - 1) * 3, " ") & vsfgTree.TextMatrix(RowInc, ColInc)
                        Else
                            .TableCell(rptTblText, RowInc1, ColInc) = vsfgTree.TextMatrix(RowInc, ColInc)
                        End If
                        .TableCell(rptTblAlignment, RowInc1, ColInc) = GetPrintAlignment(vsfgTree.Cell(flexcpAlignment, RowInc, ColInc))
                        .TableCell(rptTblBackColor, RowInc1, ColInc) = vsfgTree.Cell(flexcpBackColor, RowInc, ColInc)
                        .TableCell(rptTblColWidth, RowInc1, ColInc) = GetPrintColWidth(ColInc)
                        .TableCell(rptTblRowHeight, RowInc1, ColInc) = vsfgTree.RowHeight(RowInc) + 150
                        .TableCell(rptTblFontName, RowInc1, ColInc) = "Times New Roman"
                        .TableCell(rptTblFontSize, RowInc1, ColInc) = vsfgTree.Cell(flexcpFontSize, RowInc, ColInc) + 1
                        .TableCell(rptTblForeColor, RowInc1, ColInc) = vsfgTree.Cell(flexcpForeColor, RowInc, ColInc)
                        .TableCell(rptTblIsBold, RowInc1, ColInc) = IIf(vsfgTree.Cell(flexcpFontBold, RowInc, ColInc), 1, 0)
                        .TableCell(rptTblIsItalic, RowInc1, ColInc) = IIf(vsfgTree.Cell(flexcpFontItalic, RowInc, ColInc), 1, 0)
                        .TableCell(rptTblUnderline, RowInc1, ColInc) = IIf(vsfgTree.Cell(flexcpFontUnderline, RowInc, ColInc), 1, 0)
                    End If
                Next ColInc
            End If
        Next RowInc
        .EndTable
        .EndReport
        Screen.MousePointer = vbDefault
    End With
End Sub

Public Function GetPrintColWidth(Col As Long) As Long
On Local Error GoTo Err_Exit
    Select Case Col
        Case grdAcName
            GetPrintColWidth = 5000
'        Case grdNature
'            GetPrintColWidth = 300
        Case grdRefNo
            GetPrintColWidth = 675
'        Case grdStatus
'            GetPrintColWidth = 290
        Case grdSchedule
            GetPrintColWidth = 600
        Case grdThisDebit
            GetPrintColWidth = 1300
        Case grdThisCredit
            GetPrintColWidth = 1300
        Case grdLastDebit
            GetPrintColWidth = 1100
        Case grdLastCredit
            GetPrintColWidth = 1100
        Case grdAcID
            GetPrintColWidth = 0
        Case grdIsOtherEntries
            GetPrintColWidth = 0
        Case grdActualDr
            GetPrintColWidth = 0
        Case grdActualCr
            GetPrintColWidth = 0
        Case grdAcTypeID
            GetPrintColWidth = 0
        Case grdFormula
            GetPrintColWidth = 0
    End Select
Exit Function
Err_Exit:
    GetPrintColWidth = 0
End Function

Private Sub ExpandCollapse(IsAll As Boolean, IsCollapse As Boolean)
On Local Error Resume Next
Dim Inc As Long
    With vsfgTree
        If IsCollapse Then
            If IsAll Then
                lngTreelevel = 1
            Else
                If lngTreelevel > 1 Then
                    lngTreelevel = lngTreelevel - 1
                End If
            End If
        Else
            If IsAll Then
                lngTreelevel = lngTreeLevelMax
            Else
                If lngTreelevel <= lngTreeLevelMax Then
                    lngTreelevel = lngTreelevel + 1
                End If
            End If
        End If
        .Outline lngTreelevel
    End With
End Sub

Private Sub cmdExcel_Click()
    Report.Reset
    Report.Connect = "DSN=bichu-pc;uid=sa;pwd=;dsq=AuditMain"
    Report.ReportFileName = "F:\TRIALBALANCE.RPT"
    Report.StoredProcParam(0) = mCompanyID
    Report.StoredProcParam(1) = mPeriodID
    Report.StoredProcParam(2) = mLastPeriodID
    Report.PrintFileName = "C:\VISMAILS\TrialBalance.XLS"
    Report.PrintFileType = crptExcel50
    Report.Destination = crptToFile
    Report.Action = 1
    pMVE.MsgBox "Exporting of data to Excel is completed", msgOK, "AuditMate", msgInformation, True
End Sub

Private Sub cmdLock_Click()
    LockUnlockGrid
End Sub

Private Sub cmdPrint_Click()
    PrintDatasheet
End Sub

Private Sub cmdProperties_Click()
    ShowProperties
End Sub

Private Sub cmdRefresh_Click()
    RefreshTrial
End Sub

Private Sub cmdSave_Click()
    SaveTrial
End Sub

Private Sub cmdSearch_Click()
Dim strAccount As String, Inc As Long
Dim Data As String
    strAccount = txtSearch.Text
    vsfgTree.AutoSearch = flexSearchFromTop
    vsfgTree.SelectionMode = flexSelectionFree
    For Inc = 2 To vsfgTree.Rows - 1
        If vsfgTree.TextMatrix(Inc, grdAcName) = strAccount Then
            vsfgTree.Cell(flexcpBackColor, Inc, grdAcName) = &HFFFF&
        Else
            vsfgTree.BackColor = &H80000005
        End If
    Next
End Sub

Private Sub cmdShowTB_Click()
    frmTBSorted.Show
End Sub

Private Sub cmdUnHide_Click()
    If cmdUnHide.Caption = "Show Inactive Items" Then
        RefreshTrialAll
        cmdUnHide.Caption = "Hide Inactive Items"
    Else
        RefreshTrial
        cmdUnHide.Caption = "Show Inactive Items"
    End If
End Sub

Private Sub Form_Activate()
Dim sSql As String, sSql3 As String
    RefreshTrial
    sSql = "Select IsLocked From LockedObjects Where PeriodID = " & mPeriodID & " And ObjectID = " & 3001
    With GetRecords(sSql)
        If Not .EOF Then
            If .Fields("IsLocked") = True Then
                Set vsfgTree.WallPaper = imgWallpaper.ListImages("Lock").Picture
                vsfgTree.Editable = flexEDNone
                cmdLock.Value = True
            Else
                Set vsfgTree.WallPaper = Nothing
                vsfgTree.Editable = flexEDKbdMouse
                cmdLock.Value = False
            End If
        End If
    End With
    sSql = "Select DetachedBy From Companies Where CompanyID = " & pActiveCompanyID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("DetachedBy") <> "" Then
                    vsfgTree.Editable = flexEDNone
                    vsfgTree.Enabled = False
                End If
                .MoveNext
            Wend
            .Close
        End With
'    sSql3 = "Select FinalisedBy From Periods Where PeriodID = " & mPeriodID
'        With GetRecords(sSql3)
'            While Not .EOF
'                If .Fields("FinalisedBy") <> "" Then
'                    Set vsfgTree.WallPaper = imgWallpaper.ListImages("Lock").Picture
'                    vsfgTree.Editable = flexEDNone
'                    vsfgTree.Enabled = False
'                    tbrCtrls.Enabled = False
'                    cmdLock.Enabled = False
'                    txtSearch.Enabled = False
'                    cmdUnHide.Enabled = False
'                    cmdShowTB.Enabled = False
'                End If
'                .MoveNext
'            Wend
'            .Close
'        End With
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    KeyShortCuts KeyCode, Shift
End Sub

Private Sub Form_Load()
On Local Error GoTo Err_Exit
    vsfgTree.Left = Screen.Width - 495
    InitControls
    FormatGrid
Exit Sub
Err_Exit:
    pMVE.MsgBox "Error While Loading " & Err.Description, msgOK, "AuditMate", msgInformation, True
End Sub

Public Sub CollectData()
On Local Error GoTo Err_Exit
Dim Row  As Long, sSqlTmpThis As String, sSqlTmpLast As String, sSqlHasJV As String, sSqlTmpActual As String, sSql As String
Dim dblTotDr As Double, dblTotCr As Double
Dim strCompanyName As String
Dim sSql1 As String
    strCompanyName = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID)
    With vsfgTree
        .Rows = 0: .Rows = 2
        Row = 0
        .TextMatrix(Row, grdAcName) = strCompanyName
        .TextMatrix(Row, grdThisDebit) = mstrThisPeriodDesc
        .TextMatrix(Row, grdThisCredit) = mstrThisPeriodDesc
        .TextMatrix(Row, grdLastDebit) = mstrLastPeriodDesc
        .TextMatrix(Row, grdLastCredit) = mstrLastPeriodDesc

        .MergeCells = flexMergeFree
        .MergeRow(Row) = True
        .Cell(flexcpFontSize, Row, grdAcName) = 14
        .Cell(flexcpFontName, Row, grdAcName) = "Book Antiqua"
        .Cell(flexcpAlignment, Row, grdAcName) = flexAlignCenterCenter
        .Cell(flexcpFontBold, Row, grdAcName, Row, grdLastCredit) = True
        .MergeCells = flexMergeFree
        .MergeRow(Row) = True
        .Cell(flexcpAlignment, Row, grdSchedule, Row, grdLastCredit) = flexAlignCenterCenter

        Row = Row + 1
        .RowHeight(Row) = 400
        .TextMatrix(Row, grdAcName) = "Trial Balance"
        .TextMatrix(Row, grdRefNo) = "Ref."
        .TextMatrix(Row, grdStatus) = ""
        .TextMatrix(Row, grdSchedule) = "Note"
        .TextMatrix(Row, grdThisDebit) = "Debit"
        .TextMatrix(Row, grdThisCredit) = "Credit"
        .TextMatrix(Row, grdLastDebit) = "Debit"
        .TextMatrix(Row, grdLastCredit) = "Credit"
        .Cell(flexcpFontSize, Row, grdAcName) = 12
        .Cell(flexcpFontSize, Row, grdStatus, Row, grdLastCredit) = 10
        .Cell(flexcpFontBold, Row, grdAcName, Row, grdLastCredit) = True
        .Cell(flexcpAlignment, Row, grdSchedule, Row, grdLastCredit) = flexAlignCenterCenter
        '---All Account Groups--------------------------
        sSql = "SELECT   AT.*, (SELECT TOP 1 IsNull(SCH.IsFinished,0) FROM Schedules SCH WHERE SCH.AcTypeID = AT.AcTypeID AND SCH.PeriodID = " & mPeriodID & ") AS Finished, " & _
               "(SELECT  TOP 1 IsNull(SCH.NoteNo,0) FROM Schedules SCH WHERE SCH.AcTypeID = AT.AcTypeID AND SCH.PeriodID = " & mPeriodID & ") AS NoteNo " & _
               "FROM     AcTypes AT WHERE AT.CompanyID = " & mCompanyID & " AND AT.IsHidden = 0  AND AT.StatusID = 1 " & _
               "ORDER BY AT.TrialOrder, AT.AcTypeDescription"
        crsAllAcTypes.BindRecords sSql, AdoConn
        '---All Account Heads---------------------------
        sSqlTmpThis = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"

        sSqlTmpLast = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mLastPeriodID & ")"

        sSqlHasJV = "SELECT COUNT(ETA.AcID) AS NoOfRec FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening <> 1 AND ETA.EntryID = EM.EntryID " & _
                    "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"

        sSqlTmpActual = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening = 1 AND ETA.EntryID = EM.EntryID " & _
                        "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"
'        Checking Status ------------------
        sSql = "SELECT   AH.*, (" & sSqlTmpThis & ") AS ThisAmount, (" & sSqlTmpLast & ") AS LastAmount, (" & sSqlTmpActual & ") AS ActualAmount, CASE WHEN (" & sSqlHasJV & ") > 0 THEN 1 ELSE 0 END AS ISOtherEntries " & _
               "FROM     AcHeads AH WHERE CompanyID = " & mCompanyID & " AND StatusID = 1 " & _
               "ORDER BY TrialOrder, AcName"
        crsAllAcHeads.BindRecords sSql, AdoConn
        'Filling data (Recursive)-------------
        ShowGrpsAndAccts -1, dblTotDr, dblTotCr, "", 1
        .Outline 1: .Row = 1
        .AddItem "Grand Total"
        .Cell(flexcpFontBold, .Rows - 1, grdAcName, .Rows - 1, grdThisCredit) = True
        .IsSubtotal(.Rows - 1) = True
        FindTotal
        FindGrandTotal
        .Cell(flexcpAlignment, 1, 0, 0, grdStatus) = flexAlignLeftCenter
        .Cell(flexcpAlignment, 1, grdThisDebit, .Rows - 1, grdLastCredit) = flexAlignRightCenter
        .Cell(flexcpBackColor, 1, grdLastDebit, .Rows - 1, grdLastCredit) = RGB(250, 250, 250)
        .Cell(flexcpBackColor, 1, 0, 0, .Cols - 1) = RGB(230, 230, 255)
        .FrozenRows = 2
    End With
Exit Sub
Err_Exit:
    vsfgTree.Redraw = flexRDDirect
    ShowError
End Sub

Public Sub ShowGrpsAndAccts(ByVal ParentTypeID As Long, dblTotDr As Double, dblTotCr As Double, strTotFormula As String, lngLevel As Long)
On Local Error GoTo Err_Exit
Dim crsAcTypes As New clsRecordSet, crsAcHeads As New clsRecordSet
Dim dblAggrDrTot As Double, dblAggrCrTot As Double, lngTypeRow As Long, strFormula As String
Dim lngInc As Integer, Inc As Long, strTypeNature As String
    If ParentTypeID = -1 Then
        crsAcTypes.BindRecordSet crsAllAcTypes, "ParentAcTypeID|=|" & ""
    Else
        crsAcTypes.BindRecordSet crsAllAcTypes, "ParentAcTypeID|=|" & ParentTypeID
    End If
    With crsAcTypes
        If Not .EOF Then
            Do While Not .EOF
                'Adding Account Type
    '            vsfgTree.AddItem .Fields("AcTypeName") & ""
                vsfgTree.AddItem .Fields("AcTypeDescription") & ""
                Inc = vsfgTree.Rows - 1
                If .Fields("TypeNature") & "" = "Debit" Then
                    strTypeNature = "D"
                ElseIf .Fields("TypeNature") & "" = "Credit" Then
                    strTypeNature = "C"
                Else
                    strTypeNature = ""
                End If
    '            vsfgTree.TextMatrix(Inc, grdNature) = strTypeNature
                vsfgTree.TextMatrix(Inc, grdAcTypeID) = Val(.Fields("AcTypeID") & "")
                If .Fields("StatusID") & "" = 1 Then
                    vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &H80000008
                Else
                    vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &HFF&
                End If
                If .Fields("StatusID") & "" = 1 And .Fields("IsReserved") = "True" Then
                    vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &H80000008
                ElseIf .Fields("StatusID") & "" = 1 And .Fields("IsReserved") = "False" Then
                    vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &HFF0000
                Else
                    
                End If
                'Finished Tag-----------
                If IIf(.Fields("Finished") & "" = "True", 1, 0) = 0 And Val(.Fields("TreeLevel") & "") = 3 Then
                    vsfgTree.Cell(flexcpChecked, vsfgTree.Rows - 1, grdStatus) = flexUnchecked
                ElseIf Val(.Fields("TreeLevel") & "") = 3 Then
                    vsfgTree.Cell(flexcpChecked, vsfgTree.Rows - 1, grdStatus) = flexChecked
                End If
                'Putting Picture---------
                If Val(.Fields("TreeLevel") & "") <= 5 And Val(.Fields("Treelevel") & "") <> 0 Then
                    vsfgTree.Cell(flexcpPicture, Inc, 0) = ImgTree.ListImages(Val(.Fields("TreeLevel") & "")).Picture
                End If
                vsfgTree.IsSubtotal(Inc) = True
                vsfgTree.RowOutlineLevel(Inc) = lngLevel
    
                vsfgTree.Cell(flexcpAlignment, Inc, grdStatus) = flexAlignCenterCenter
                vsfgTree.TextMatrix(Inc, grdRefNo) = .Fields("RefNo") & ""
                vsfgTree.TextMatrix(Inc, grdSchedule) = .Fields("NoteNo") & ""
                If lngLevel > lngTreeLevelMax Then
                    lngTreeLevelMax = lngLevel
                End If
                lngTreelevel = lngTreeLevelMax
                lngTypeRow = Inc
                dblAggrDrTot = 0: dblAggrCrTot = 0
                strFormula = ""
                crsAcHeads.BindRecordSet crsAllAcHeads, "AcTypeID|=|" & crsAcTypes.Fields("AcTypeID")
                With crsAcHeads
                    Do While Not .EOF
                        vsfgTree.AddItem .Fields("AcName") & ""
                        Inc = vsfgTree.Rows - 1
                        vsfgTree.TextMatrix(Inc, grdRefNo) = .Fields("AcCode") & ""
                        vsfgTree.TextMatrix(Inc, grdAcID) = Val(.Fields("AcID") & "")
                        vsfgTree.TextMatrix(Inc, grdAcTypeID) = vsfgTree.ValueMatrix(lngTypeRow, grdAcTypeID)
                        vsfgTree.TextMatrix(Inc, grdThisDebit) = Format(IIf(Val(.Fields("ThisAmount") & "") > 0, Val(.Fields("ThisAmount") & ""), ""), "#,###")
                        vsfgTree.TextMatrix(Inc, grdThisCredit) = Format(IIf(Val(.Fields("ThisAmount") & "") < 0, Abs(Val(.Fields("ThisAmount") & "")), ""), "#,###")
                        vsfgTree.TextMatrix(Inc, grdLastDebit) = Format(IIf(Val(.Fields("LastAmount") & "") > 0, Val(.Fields("LastAmount") & ""), ""), "#,###")
                        vsfgTree.TextMatrix(Inc, grdLastCredit) = Format(IIf(Val(.Fields("LastAmount") & "") < 0, Abs(Val(.Fields("LastAmount") & "")), ""), "#,###")
                        vsfgTree.TextMatrix(Inc, grdActualDr) = IIf(Val(.Fields("ActualAmount") & "") > 0, Val(.Fields("ActualAmount") & ""), 0)
                        vsfgTree.TextMatrix(Inc, grdActualCr) = IIf(Val(.Fields("ActualAmount") & "") < 0, Abs(Val(.Fields("ActualAmount") & "")), 0)
                        If vsfgTree.ValueMatrix(Inc, grdThisDebit) = 0 Then vsfgTree.TextMatrix(Inc, grdThisDebit) = ""
                        If vsfgTree.ValueMatrix(Inc, grdThisCredit) = 0 Then vsfgTree.TextMatrix(Inc, grdThisCredit) = ""
                        If vsfgTree.ValueMatrix(Inc, grdLastDebit) = 0 Then vsfgTree.TextMatrix(Inc, grdLastDebit) = ""
                        If vsfgTree.ValueMatrix(Inc, grdLastCredit) = 0 Then vsfgTree.TextMatrix(Inc, grdLastCredit) = ""
                        vsfgTree.TextMatrix(Inc, grdIsOtherEntries) = Val(.Fields("IsOtherEntries") & "")
                        If .Fields("StatusID") & "" = 1 Then
                            vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &H80000008
                        Else
                            vsfgTree.Cell(flexcpForeColor, Inc, grdAcName, Inc, vsfgTree.Cols - 1) = &HFF&
                        End If
                        If Val(.Fields("IsOtherEntries") & "") = 1 Then
                            vsfgTree.Cell(flexcpBackColor, Inc, grdAcName, Inc, grdLastCredit) = pclrRestrictionColor
                            vsfgTree.TextMatrix(Inc, grdNature) = "JV"
                        End If
                        vsfgTree.IsSubtotal(Inc) = True
                        vsfgTree.RowOutlineLevel(Inc) = lngLevel + 1
                        dblAggrDrTot = dblAggrDrTot + vsfgTree.ValueMatrix(Inc, grdThisDebit)
                        dblAggrCrTot = dblAggrCrTot + vsfgTree.ValueMatrix(Inc, grdThisCredit)
                        vsfgTree.Cell(flexcpFontBold, Inc, grdRefNo, Inc, grdLastCredit) = False
                        strFormula = strFormula & Inc & ","
                        .MoveNext
                    Loop
                  .Clear
                End With
                ShowGrpsAndAccts Val(.Fields("AcTypeID") & ""), dblAggrDrTot, dblAggrCrTot, strFormula, (lngLevel + 1)
                vsfgTree.TextMatrix(lngTypeRow, grdThisDebit) = dblAggrDrTot
                vsfgTree.TextMatrix(lngTypeRow, grdThisCredit) = dblAggrCrTot
                If vsfgTree.ValueMatrix(lngTypeRow, grdThisDebit) = 0 Then vsfgTree.TextMatrix(lngTypeRow, grdThisDebit) = ""
                If vsfgTree.ValueMatrix(lngTypeRow, grdThisCredit) = 0 Then vsfgTree.TextMatrix(lngTypeRow, grdThisCredit) = ""
                vsfgTree.TextMatrix(lngTypeRow, grdFormula) = strFormula
                dblTotDr = dblTotDr + dblAggrDrTot
                dblTotCr = dblTotCr + dblAggrCrTot
                vsfgTree.Cell(flexcpFontBold, lngTypeRow, grdAcName, lngTypeRow, grdLastCredit) = True
                strTotFormula = strTotFormula & strFormula
                .MoveNext
            Loop
        End If
        .Clear
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function SaveTrial(Optional IsShow As Boolean = False, Optional Row As Long = -1) As Boolean
On Local Error GoTo Err_Exit
Dim lngInc As Long, sSql As String, dtRef As Date, lngEntryID As Long, lngAcSlNo As Long, lngTmpSlNo As Long
    Screen.MousePointer = vbHourglass
    dtRef = Val(PickValue("Periods", "StartDt", "PeriodID = " & mPeriodID))
    AdoConn.BeginTrans
    lngEntryID = SaveEntry(mPeriodID, "Opening...", dtRef, cnstStatusActive, "", 1)
    If lngEntryID = -1 Then
        Err.Raise vbObjectError + 1, , "Error While Saving Opening Entry."
    End If
    If Row = -1 Then
        sSql = "Delete from EntrySubAccounts Where EntryID = " & lngEntryID
    Else
        sSql = "Delete from EntrySubAccounts Where EntryID = " & lngEntryID & " AND AcID = " & vsfgTree.ValueMatrix(Row, grdAcID)
    End If
    AdoConn.Execute sSql
    With vsfgTree
        For lngInc = IIf(Row <> -1, Row, 0) To IIf(Row <> -1, Row, .Rows - 1)
            If .ValueMatrix(lngInc, grdAcID) <> 0 Then
                'if restricted row save actual opening value
                If .Cell(flexcpBackColor, lngInc, grdAcName) = pclrRestrictionColor Then
                    If (.ValueMatrix(lngInc, grdActualDr) + .ValueMatrix(lngInc, grdActualCr)) <> 0 Then
                        lngAcSlNo = lngAcSlNo + 1
                        If Row = -1 Then
                            lngTmpSlNo = lngAcSlNo
                        Else
                            lngTmpSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                        End If
                        If Not SaveSubEntries(lngEntryID, lngTmpSlNo, .ValueMatrix(lngInc, grdAcID), .ValueMatrix(lngInc, grdActualDr), .ValueMatrix(lngInc, grdActualCr), "", 1) Then
                            Err.Raise vbObjectError + 1, , "Error While Saving '" & .TextMatrix(lngInc, grdAcName) & "'"
                        End If
                    End If
                Else
                    If (.ValueMatrix(lngInc, grdThisDebit) + .ValueMatrix(lngInc, grdThisCredit)) <> 0 Then
                        lngAcSlNo = lngAcSlNo + 1
                        If Row = -1 Then
                            lngTmpSlNo = lngAcSlNo
                        Else
                            lngTmpSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                        End If
                        If Not SaveSubEntries(lngEntryID, lngTmpSlNo, .ValueMatrix(lngInc, grdAcID), .ValueMatrix(lngInc, grdThisDebit), .ValueMatrix(lngInc, grdThisCredit), "", 1) Then
                            Err.Raise vbObjectError + 1, , "Error While Saving '" & .TextMatrix(lngInc, grdAcName) & "'"
                        End If
                    End If
                End If
            End If
        Next
    End With
    'Ref No: 003 - 25/03/08
    '---Changing Status---------------------
    If Row <> -1 Then
        ChangeDatasheetStatus mPeriodID, , vsfgTree.ValueMatrix(Row, grdAcTypeID)
        vsfgTree.Cell(flexcpBackColor, Row, grdAcName, Row, grdCols - 1) = &HFFC0C0
    End If
    SaveTrial = True
    AdoConn.CommitTrans
    Screen.MousePointer = vbDefault
    If IsShow Then pMVE.MsgBox "Trial Balance Updated Successfully", msgOK, "AuditMate", msgInformation, True
    If Not IsShow And Row = -1 Then
        ConvergeToControl txtConverge, 6
    End If
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
    AdoConn.RollbackTrans
    SaveTrial = False
End Function

Public Sub ConvergeToControl(Ctrl As Control, Steps As Long)
On Local Error Resume Next
Dim Inc As Long
Dim lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long
Dim lngLeftMin As Long, lngTopMin As Long, lngWidthMin As Long, lngHeightMin As Long
Dim lngLeftMax As Long, lngTopMax As Long, lngWidthMax As Long, lngHeightMax As Long

    lngLeftMin = Ctrl.Left
    lngTopMin = Ctrl.Top
    lngWidthMin = Ctrl.Width
    lngHeightMin = Ctrl.Height

    lngLeftMax = Left
    lngTopMax = Top
    lngWidthMax = Width
    lngHeightMax = Height

    shpConverge.Visible = True
    For Inc = Steps To 1 Step -1
        lngLeft = ((lngLeftMax - lngLeftMin) / Steps) * Inc * -1
        lngTop = ((lngTopMax - lngTopMin) / Steps) * Inc * -1
        lngWidth = ((lngWidthMax - lngWidthMin) / Steps) * Inc
        lngHeight = ((lngHeightMax - lngHeightMin) / Steps) * Inc

        Sleep 50
        shpConverge.Left = lngLeft
        shpConverge.Top = lngTop
        shpConverge.Width = lngWidth
        shpConverge.Height = lngHeight
    Next Inc
    shpConverge.Visible = False
End Sub

Private Sub Form_Resize()
    AdjustToScreen
End Sub

Public Sub AdjustToScreen()
On Local Error Resume Next
    Anchor vsfgTree, 0, 450, 15520, 9600
    Anchor vsfgTotal, 0, 10000, 15520, 400
    Anchor txtSearch, 5690, 80, 2190, 315
    Anchor cmdSearch, 7885, 80, 315, 315
    Anchor cmdUnHide, 8400, 80, 1755, 315
    Anchor cmdShowTB, 10300, 80, 1400, 315
    Anchor cmbPeriod, 11950, 80, 3500, 315

    Anchor lblBalance, 6000, 10000
    Anchor lblLastCr, 11500, 100
    Anchor lblLastDr, 10440, 10000
    Anchor lblThisCr, 9120, 10000
    Anchor lblThisDr, 7920, 10000

    FormatGrid
End Sub

Private Sub tbrAddNew_ButtonClick(ByVal Button As MSComctlLib.Button)
    ToolbarAddNewActions Button.Key
End Sub

Private Sub ToolbarAddNewActions(Key As String)
Dim IsSaved As Boolean, obj As Object
    Select Case Key
        Case "Save"
            If vsfgAddNew.Tag = "Account Head" Then
                Set obj = New clsAcHead
                obj.CompanyID = CompanyID
                obj.AcHeadName = txtAddNewName
                obj.AcTypeID = Val(txtAddNewName.Tag)
                obj.TrialOrder = 0
                obj.StatusID = cnstStatusActive
                IsSaved = obj.Save(0)
            Else
                Set obj = New clsAcType
                obj.CompanyID = CompanyID
                obj.AcTypeName = txtAddNewName
                obj.AcTypeDescription = txtAddNewName
                obj.ParentAcTypeID = Val(txtAddNewName.Tag)
                obj.TrialOrder = 0
                obj.IsReserved = 0
                obj.TreeLevel = Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & Val(txtAddNewName.Tag))) + 1
                obj.TypeNature = PickValue("AcTypes", "TypeNature", "AcTypeID = " & Val(txtAddNewName.Tag))
                obj.StatusID = cnstStatusActive
                IsSaved = obj.Save(0)
            End If
            If IsSaved Then
                vsfgAddNew.Visible = False
                RefreshTrial
            End If
        Case "Close"
            vsfgAddNew.Visible = False
    End Select
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ToolBarActions Button.Key
End Sub

Public Sub ToolBarActions(Key As String)
On Local Error Resume Next
Dim Inc As Long, strExcelFile As String, strFilePath As String
Dim crApp As CRAXDRT.Application
Dim oRpt As CRAXDRT.Report

    Select Case Key
        Case "Properties"
            ShowProperties
        Case "CollapseAll"
            ExpandCollapse True, True
        Case "ExpandAll"
            ExpandCollapse True, False
        Case "CollapseSub"
            ExpandCollapse False, True
        Case "ExpandSub"
            ExpandCollapse False, False
        Case "Search"
            If tbrCtrls.Buttons("Search").Value = tbrPressed Then
                vsfgTree.AutoSearch = flexSearchFromTop
            Else
                vsfgTree.AutoSearch = flexSearchNone
            End If
        Case "Save"
            SaveTrial
        Case "Print"
            PrintDatasheet
        Case "Refresh"
            RefreshTrial
        Case "ExporttoExcel"
'            strExcelFile = BrowShow(tbrCtrls.hWnd, , , , , strExcelFile)
'            If Right(Trim(strExcelFile), 1) <> "\" Then
'                strExcelFile = strExcelFile & "\"
'            End If
            Report.Reset
            Report.Connect = "DSN= " & pServer & ";uid=sa;pwd= " & pCnnPassword & ";dsq=AuditMain"
            Report.ReportFileName = "D:\Installs\TRIALBALANCE.RPT"
            Report.StoredProcParam(0) = mCompanyID
            Report.StoredProcParam(1) = mPeriodID
            Report.StoredProcParam(2) = mLastPeriodID
            Report.PrintFileName = "D:\AuditMate\TrialBalance.XLS"
            Report.PrintFileType = crptExcel50
            Report.Destination = crptToFile
            Report.Action = 1
            If pMVE.MsgBox("Data exported to " & "D:\TrialBalance.xls" & ". Do you want to open?", msgYesNo, , msgQuestion, True) Then
                Shell "Explorer.exe " & "D:\AuditMate\TrialBalance.XLS", vbMaximizedFocus
            End If
'            Set crApp = New CRAXDRT.Application
'            Set oRpt = crApp.OpenReport(App.Path & "\TRIALBALANCE.rpt", 1)
'            oRpt.GroupNameFields(0) = mCompanyID
'            oRpt.GroupNameFields(1) = mPeriodID
'            oRpt.GroupNameFields(2) = mLastPeriodID
'            oRpt.ExportOptions.DestinationType = crEDTDiskFile
'            oRpt.ExportOptions.DiskFileName = App.Path & "\Report1.xls"
'            oRpt.ExportOptions.FormatType = crEFTExcel50Tabular
'            oRpt.Export
        Case "General"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.RowOutlineLevel(Inc) = 3 Then
                    If vsfgTree.ValueMatrix(Inc, grdAcTypeID) <> GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment) Then
                        ShowGeneralShedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                    End If
                    Exit Sub
                End If
            Next Inc
        Case "Split"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.RowOutlineLevel(Inc) = 3 Then
                    ShowSplitSchedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                    Exit Sub
                End If
            Next Inc
        Case "Asset"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.RowOutlineLevel(Inc) = 3 Then
                    ShowFixedAssetSchedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                    Exit Sub
                End If
            Next Inc
        Case "Equity"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.RowOutlineLevel(Inc) = 3 Then
                    ShowEquitySchedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                    Exit Sub
                End If
            Next Inc
        'Ref No : 020-10/06/08, 10th June 2008, Tuesday ---------
        Case "Lock"
            LockUnlockGrid
    End Select
End Sub

Public Sub LockUnlockGrid()
On Local Error Resume Next
Dim sSql As String, IsNewRec As Boolean
    IsLocked = Not IsLocked
    If IsLocked Then
        vsfgTree.WallPaper = imgWallpaper.ListImages("Lock").Picture
        vsfgTree.Editable = flexEDNone
    Else
        vsfgPassword.Visible = True
        txtPassword.SetFocus
    End If
    AdoConn.BeginTrans
    sSql = "Select * From LockedObjects Where PeriodID = " & mPeriodID & " And ObjectID = " & 3001
    With GetRecords(sSql)
        If .EOF Then
            .AddNew
            .Fields("LockID") = GetMaxNo("LockedObjects", "LockID")
            IsNewRec = True
        End If
        .Fields("PeriodID") = mPeriodID
        .Fields("ObjectID") = 3001
        .Fields("IsLocked") = IsLocked
        If IsNewRec Then
            .Fields("CreateUser") = pUserID
            .Fields("CreateDate") = ServerDateTime
        End If
        .Fields("UpdateUser") = pUserID
        .Fields("UpdateDate") = ServerDateTime
        .Update
        .Close
    End With
    AdoConn.CommitTrans
    vsfgTree.Refresh
End Sub

Private Sub ShowProperties()
On Local Error Resume Next
    With vsfgTree
        If .Row < 0 Then Exit Sub
        If .ValueMatrix(.Row, grdAcID) <> 0 Then
            ShowFormInMDI "frmAcHeads", "Account Heads", mCompanyID
            ButtonHandling GetActiveFormObject("frmAcHeads"), "Open", .ValueMatrix(.Row, grdAcID)
        ElseIf .ValueMatrix(.Row, grdAcTypeID) <> 0 Then
            ShowFormInMDI "frmAcTypes", "Account Types", mCompanyID
            ButtonHandling GetActiveFormObject("frmAcTypes"), "Open", .ValueMatrix(.Row, grdAcTypeID)
        Else
            ShowFormInMDI "frmPeriods", "Periods", mCompanyID
            ButtonHandling GetActiveFormObject("frmPeriods"), "Open", GetComboBoundValue(cmbPeriod)
        End If
    End With
End Sub

Private Sub ToolBarSubActions(Key As String)
On Local Error Resume Next
Dim Inc As Long, crptPrint As New clsReports, sSql As String, lngCurrentY As Long
Dim lngPropertyID As Long
    Screen.MousePointer = vbHourglass
    lngCurrentY = -1
    lngPropertyID = GetActualID(pActiveCompanyID, cnstAcTypePropertyPlantEquipment)
    If Left(Key, 1) = "_" Then Key = Right(Key, Len(Key) - 1)
    Select Case Key
        Case "RptTBDetailed"
            crptPrint.CreatePageBreak , , , , , , orPortrait
            crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 0, mPeriodID
            PrintTBReport mPeriodID, True, crptPrint
            crptPrint.EndReport
            crptPrint.Clear
            Set crptPrint = Nothing
        Case "RptBalanceSheet"
            crptPrint.CreatePageBreak , , , , , , orPortrait
            crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 0, mPeriodID
            PrintBalanceSheet mPeriodID, True, crptPrint
            crptPrint.CreatePageBreak
            PrintProfitLoss mPeriodID, True, crptPrint
            crptPrint.CreatePageBreak , , , , , , orLandscape
            PrintShareholdersEquity mPeriodID, True, crptPrint
            crptPrint.CreatePageBreak , , , , , , orLandscape
            PrintFixedAssetSchedules mPeriodID, True, crptPrint
            sSql = "SELECT NoteNo, AcTypeID, ScheduleTypeID FROM Schedules WHERE IsFinished = 1 AND ScheduleTypeID IN " & _
                   "       (" & cnstScheduleTypeGeneral & ", " & cnstScheduleTypeCashEquivalents & ", " & cnstScheduleTypeContingentLiability & ", " & cnstScheduleTypeSplit & ") " & _
                   "AND    AcTypeID <> " & lngPropertyID & " " & _
                   "AND    PeriodID = " & mPeriodID & " ORDER BY CONVERT(int, NoteNo)"
            With GetRecords(sSql)
                While Not .EOF
                    If .Fields("NoteNo") & "" <> "" Then
                        If lngCurrentY > 10000 Or lngCurrentY = -1 Then
                            crptPrint.CreatePageBreak , , , , , , orPortrait
                            lngCurrentY = 0
                        End If
                        Select Case !ScheduleTypeID
                        Case cnstScheduleTypeGeneral
                            PrintGeneralSchedules mPeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                        Case cnstScheduleTypeSplit
                            PrintSplitSchedules mPeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                        End Select
                    End If
                    .MoveNext
                Wend
                .Close
            End With
            crptPrint.CreatePageBreak , , , , , , orPortrait
            PrintCashFlow mPeriodID, True, crptPrint
            crptPrint.EndReport
            crptPrint.Clear
            Set crptPrint = Nothing
        Case "RptLeadSheet"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.ValueMatrix(Inc, grdAcTypeID) <> 0 Then
                    PrintLeadSheets vsfgTree.ValueMatrix(Inc, grdAcTypeID), mPeriodID
                    Exit Sub
                End If
            Next Inc
    End Select
    Screen.MousePointer = vbDefault
End Sub

Private Sub tbrPassword_ButtonClick(ByVal Button As MSComctlLib.Button)
    ToolbarEnterPassword Button.Key
End Sub

Public Sub ToolbarEnterPassword(Key As String)
On Local Error Resume Next
Dim sSql As String, rsTmp As New ADODB.Recordset, strCmpCode As String
Dim IsNewRec As Boolean
    sSql = "Select CompanyCode From Companies Where CompanyID = " & pActiveCompanyID
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            If Not .EOF Then
                strCmpCode = .Fields("CompanyCode") & ""
            End If
            .Close
        End With
    Select Case Key
        Case "Ok"
            If strCmpCode = txtPassword Then
                txtPassword.Text = ""
                vsfgPassword.Visible = False
                IsLocked = False
                Set vsfgTree.WallPaper = Nothing
                vsfgTree.Editable = flexEDKbdMouse
                cmdLock.Value = False
                AdoConn.BeginTrans
                sSql = "Select * From LockedObjects Where PeriodID = " & mPeriodID & " And ObjectID = " & 3001
                With GetRecords(sSql)
                    If .EOF Then
                        .AddNew
                        .Fields("LockID") = GetMaxNo("LockedObjects", "LockID")
                        IsNewRec = True
                    End If
                    .Fields("PeriodID") = mPeriodID
                    .Fields("ObjectID") = 3001
                    .Fields("IsLocked") = IsLocked
                    If IsNewRec Then
                        .Fields("CreateUser") = pUserID
                        .Fields("CreateDate") = ServerDateTime
                    End If
                    .Fields("UpdateUser") = pUserID
                    .Fields("UpdateDate") = ServerDateTime
                    .Update
                    .Close
                End With
                AdoConn.CommitTrans
            Else
                pMVE.MsgBox "Password you entered is incorrect. Please try again.", msgOK, "AuditMate", msgInformation, True
                txtPassword.Text = ""
                txtPassword.SetFocus
            End If
        Case Else

    End Select
End Sub

Private Sub txtAddNewName_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        ToolbarAddNewActions "Close"
    ElseIf KeyCode = vbKeyReturn Then
        ToolbarAddNewActions "Save"
    End If
End Sub

Private Sub vsfgTree_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error GoTo Err_Exit
    With vsfgTree
        .TextMatrix(Row, Col) = Format(.TextMatrix(Row, Col), "#,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
        If Col = grdThisCredit Then
            If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then
                If Val(.TextMatrix(Row, grdThisDebit)) > 0 Then .TextMatrix(Row, grdThisDebit) = ""
            End If
        ElseIf Col = grdThisDebit Then
            If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then
                If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then .TextMatrix(Row, grdThisCredit) = ""
            End If
        End If
        If Col = grdThisCredit Or Col = grdThisDebit Then
            SaveTrial , Row
        End If
    End With
    FindTotal
    FindGrandTotal
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub KeyShortCuts(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
Dim strKey As String, blnIsValidKey As Boolean
Static lngLastTime As Long
    strKey = ""
    blnIsValidKey = False
    Select Case KeyCode
    Case vbKeyControl, vbKeyShift, vbKeyMenu
        blnIsValidKey = False
    Case Else
        blnIsValidKey = True
    End Select
    lngLastTime = GetTickCount()
    If vbCtrlMask = Shift Then
        Select Case KeyCode
        Case vbKeyS
            strKey = "Save"
        Case vbKey1
            strKey = "General"
        Case vbKey8
            strKey = "_RptBalanceSheet"
        Case vbKey9
            strKey = "_RptLeadSheet"
        Case vbKeyL
            strKey = "Lock"
        Case Else
            strKey = ""
        End Select
    Else
        Select Case KeyCode
        Case vbKeyF5
            strKey = "Refresh"
        Case vbKeyF4
            strKey = "Properties"
        Case vbKeyF6
            AddNewItem "Account Head"
        Case vbKeyF7
            AddNewItem "Account Type"
        End Select
    End If
    If strKey <> "" Then
        If Left(strKey, 1) = "_" Then
            ToolBarSubActions strKey
        Else
            If tbrCtrls.Buttons(strKey).Enabled Then
                ToolBarActions strKey
            End If
        End If
    End If
End Sub

Public Sub AddNewItem(Key As String)
On Local Error Resume Next
Dim lngTreelevel As Long
    lngTreelevel = Val(PickValue("AcTypes", "Treelevel", "AcTypeID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID)))
    If lngTreelevel < 3 Then
        pMVE.MsgBox "Creation of Account Types at this level is not permitted", msgOK, "AuditMate", msgInformation, True
        Exit Sub
    End If
    If vsfgAddNew.Visible Then Exit Sub
    If vsfgTree.Row < 1 Then Exit Sub
    If vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID) = 0 Then Exit Sub

    vsfgAddNew.Tag = Key
    txtAddNewName.Tag = vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID)
    If Key = "Account Head" Then
        lblHeaderAddNew.FormatString = "Account Heads"
        lblCaptionAddNew = "Account Name"
        lblCaptionAddNew.ForeColor = &H800080
        lblGroupAddNew = "Create under '" & PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID)) & "'"
        txtAddNewName.Text = ""
        vsfgAddNew.Visible = True
        txtAddNewName.SetFocus
        Anchor vsfgAddNew, 4000, 1500
    Else
        lblHeaderAddNew.FormatString = "Account Types"
        lblCaptionAddNew = "Account Type Name"
        lblCaptionAddNew.ForeColor = &H8080&
        lblGroupAddNew = "Create under '" & PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID)) & "'"
        txtAddNewName.Text = ""
        vsfgAddNew.Visible = True
        txtAddNewName.SetFocus
        Anchor vsfgAddNew, 1500, 1500
    End If
End Sub

Private Sub vsfgTree_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset
    sSql = "Select IsLocked From LockedObjects Where PeriodID = " & mPeriodID & " And ObjectID = " & 3001
    With GetRecords(sSql)
        If Not .EOF Then
            If .Fields("IsLocked") = True Then
                Cancel = True
            End If
        End If
    End With
'    If Me.IsReadOnly = True Then
'        Cancel = True
'    End If
    If vsfgPassword.Visible = True Then
        Cancel = True
    End If
    If Col = grdThisDebit Then
        If vsfgTree.ValueMatrix(Row, grdThisCredit) <> 0 Then
            Cancel = True
            Exit Sub
        End If
    ElseIf Col = grdThisCredit Then
        If vsfgTree.ValueMatrix(Row, grdThisDebit) <> 0 Then
            Cancel = True
        End If
    End If
    If Row <= 1 Then
        Cancel = True
        Exit Sub
    End If
    If Col <= grdRefNo Then
        Cancel = True
        Exit Sub
    End If
    If vsfgTree.ValueMatrix(Row, grdAcID) = 0 Then
        Cancel = True
    End If
    If vsfgTree.Cell(flexcpBackColor, Row, Col) = pclrRestrictionColor Then
        Cancel = True
    End If
    If Col = grdLastCredit Or Col = grdLastDebit Then
        Cancel = True
    End If
    If Col = grdSchedule Then
        vsfgTree.Cell(flexcpBackColor, Row, Col) = pclrRestrictionColor
        Cancel = False
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub FindGrandTotal()
On Local Error GoTo Err_Exit
Dim Inc As Integer, curLastDrTot As Currency, curLastCrTot As Currency, curDrTot As Currency, curCrTot As Currency
    With vsfgTree
    curCrTot = 0
    curDrTot = 0
        For Inc = 1 To .Rows - 2
            If Trim(.TextMatrix(Inc, grdFormula)) = "" Then
                curLastDrTot = curLastDrTot + RVal(.TextMatrix(Inc, grdLastDebit))
                curLastCrTot = curLastCrTot + RVal(.TextMatrix(Inc, grdLastCredit))
                curDrTot = curDrTot + RVal(.TextMatrix(Inc, grdThisDebit))
                curCrTot = curCrTot + RVal(.TextMatrix(Inc, grdThisCredit))
            End If
        Next
        .Cell(flexcpText, .Rows - 1, grdLastDebit) = IIf(curLastDrTot <= 0, "", Format(curLastDrTot, "#,##0.00"))
        .Cell(flexcpText, .Rows - 1, grdLastCredit) = IIf(curLastCrTot <= 0, "", Format(curLastCrTot, "#,##0.00"))
        .Cell(flexcpText, .Rows - 1, grdThisDebit) = IIf(curDrTot <= 0, "", Format(curDrTot, "#,##0.00"))
        .Cell(flexcpText, .Rows - 1, grdThisCredit) = IIf(curCrTot <= 0, "", Format(curCrTot, "#,##0.00"))
        lblThisDr = Format(curDrTot, "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
        lblThisCr = Format(curCrTot, "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
        lblLastDr = Format(curLastDrTot, "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
        lblLastCr = Format(curLastCrTot, "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
    End With
    lblBalance = RVal(lblThisDr) - RVal(lblThisCr)
    If RVal(lblBalance) > 0 Then
        lblBalance = "Difference " & Format(lblBalance, "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), "") & " Dr")
        lblBalance.ForeColor = &H8000&
    ElseIf RVal(lblBalance) < 0 Then
        lblBalance = "Difference " & Format(Abs(lblBalance), "##,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), "") & " Cr")
        lblBalance.ForeColor = &H80&
    Else
        lblBalance = "" ' "Tallied"
        lblBalance.ForeColor = &H800080
    End If

    With vsfgTotal
        .MergeCells = flexMergeFree
        .MergeRow(0) = True
        .Cell(flexcpAlignment, 0, 0, 0, .Cols - 1) = flexAlignRightCenter
        
        .TextMatrix(0, grdThisDebit) = " " & lblThisDr
        .TextMatrix(0, grdThisCredit) = lblThisCr
        .TextMatrix(0, grdLastDebit) = " " & lblLastDr
        .TextMatrix(0, grdLastCredit) = lblLastCr
        .TextMatrix(0, grdRefNo) = lblBalance
        .TextMatrix(0, grdRefNo - 1) = lblBalance
        .TextMatrix(0, grdRefNo - 2) = lblBalance
        .Cell(flexcpForeColor, 0, grdRefNo, 0, grdRefNo - 2) = lblBalance.ForeColor
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub FindTotal()
On Local Error GoTo Err_Exit
Dim Inc As Integer
    With vsfgTree
        For Inc = 1 To .Rows - 1
            If Trim(.TextMatrix(Inc, grdFormula)) <> "" Then
                FindSum .TextMatrix(Inc, grdFormula), Inc
            End If
        Next
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Function FindSum(ByVal strCols As String, ByVal Row As Long) As Currency
On Local Error GoTo Err_Exit
Dim tmpstrCol As Stream, Inc As Integer, ColVal As Integer, ArrCols() As String
    ArrCols = Split(strCols, ",")
    With vsfgTree
        .TextMatrix(Row, grdLastDebit) = 0
        .TextMatrix(Row, grdLastCredit) = 0
        .TextMatrix(Row, grdThisDebit) = 0
        .TextMatrix(Row, grdThisCredit) = 0
        For Inc = 0 To UBound(ArrCols) - 1
            ColVal = RVal(ArrCols(Inc))
            .TextMatrix(Row, grdLastDebit) = .ValueMatrix(Row, grdLastDebit) + .ValueMatrix(ColVal, grdLastDebit)
            .TextMatrix(Row, grdLastDebit) = IIf(.ValueMatrix(Row, grdLastDebit) = 0, "", Format(.ValueMatrix(Row, grdLastDebit), "#,##0"))
            .TextMatrix(Row, grdLastCredit) = .ValueMatrix(Row, grdLastCredit) + .ValueMatrix(ColVal, grdLastCredit)
            .TextMatrix(Row, grdLastCredit) = IIf(.ValueMatrix(Row, grdLastCredit) = 0, "", Format(.ValueMatrix(Row, grdLastCredit), "#,##0"))
            .TextMatrix(Row, grdThisDebit) = .ValueMatrix(Row, grdThisDebit) + .ValueMatrix(ColVal, grdThisDebit)
            .TextMatrix(Row, grdThisDebit) = IIf(.ValueMatrix(Row, grdThisDebit) = 0, "", Format(.ValueMatrix(Row, grdThisDebit), "#,##0"))
            .TextMatrix(Row, grdThisCredit) = .ValueMatrix(Row, grdThisCredit) + .ValueMatrix(ColVal, grdThisCredit)
            .TextMatrix(Row, grdThisCredit) = IIf(.ValueMatrix(Row, grdThisCredit) = 0, "", Format(.ValueMatrix(Row, grdThisCredit), "#,##0"))
        Next
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub vsfgTree_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
Dim Inc As Long, lngAllocationTypeID As Long
    lngAllocationTypeID = Val(PickValue("AcTypes", "AllocationAcTypeID", "AcTypeID = " & vsfgTree.TextMatrix(Row, grdAcTypeID)))
    If Row > 1 And Col = grdSchedule Then
        For Inc = vsfgTree.Row To 1 Step -1
            If vsfgTree.RowOutlineLevel(Inc) = 3 Then
                If lngAllocationTypeID <> 0 Then
                    ShowSplitSchedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                    Exit Sub
                Else
                    If vsfgTree.ValueMatrix(Inc, grdAcTypeID) <> GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment) Then
                        ShowGeneralShedule mPeriodID, vsfgTree.ValueMatrix(Inc, grdAcTypeID)
                        Exit Sub
                    End If
                End If
            End If
        Next Inc
    End If
    If Row > 1 And Col = grdNature Then
        For Inc = vsfgTree.Row To 1 Step -1
            If vsfgTree.RowOutlineLevel(Inc) >= 4 Then
                If vsfgTree.Cell(flexcpBackColor, Row, grdAcName) = pclrRestrictionColor Then
                    ShowLedger mPeriodID, vsfgTree.ValueMatrix(Row, grdAcID)
                End If
            End If
        Next Inc
    End If
End Sub

Private Sub vsfgTree_Click()
    vsfgTree.ToolTipText = vsfgTree.Text
End Sub

Public Sub RecordGridFormat()
On Local Error GoTo Err_Exit
Dim Inc As Long, Inc1 As Long
    cgTmpTreeGrid.Clear
    cgTmpTreeGrid.Cols = vsfgTree.Cols + 1
    cgTmpTreeGrid.Rows = vsfgTree.Rows
    For Inc = 1 To vsfgTree.Rows - 1
        For Inc1 = 0 To vsfgTree.Cols - 1
            cgTmpTreeGrid.TextMatrix(Inc, Inc1) = vsfgTree.TextMatrix(Inc, Inc1)
        Next Inc1
    Next Inc
    For Inc = 1 To vsfgTree.Rows - 1
        cgTmpTreeGrid.TextMatrix(Inc, cgTmpTreeGrid.Cols - 1) = vsfgTree.IsCollapsed(Inc)
    Next Inc
    CurTopRow = vsfgTree.TopRow
    CurRow = vsfgTree.Row
Exit Sub
Err_Exit:
'    Resume
End Sub

Public Sub ApplyGridFormat()
On Local Error Resume Next
Dim Inc As Long, Inc1 As Long, inct As Long
    With cgTmpTreeGrid
        For Inc = 1 To .Rows - 1
            For Inc1 = Inc To vsfgTree.Rows - 1
                If .ValueMatrix(Inc, grdAcID) = vsfgTree.ValueMatrix(Inc1, grdAcID) And _
                    .ValueMatrix(Inc, grdAcTypeID) = vsfgTree.ValueMatrix(Inc1, grdAcTypeID) Then
                    vsfgTree.IsCollapsed(Inc1) = .ValueMatrix(Inc, .Cols - 1)
                End If
                inct = inct + 1
            Next Inc1
        Next Inc
    End With
    vsfgTree.TopRow = CurTopRow
    vsfgTree.Row = CurRow
    vsfgTree.SetFocus
End Sub

Public Sub RefreshTrial()
On Local Error GoTo Err_Exit
    If Not Visible Then Exit Sub
    vsfgTree.Redraw = flexRDNone
    Screen.MousePointer = vbHourglass
    RecordGridFormat
    CollectData
    ExpandCollapse True, False
    Screen.MousePointer = vbDefault
    ApplyGridFormat
    vsfgTree.Redraw = flexRDDirect
Exit Sub
Err_Exit:
    Screen.MousePointer = vbDefault
End Sub

Private Sub vsfgTree_DblClick()
On Local Error Resume Next
Dim sSql As String, rsTmp As New ADODB.Recordset, lngCount As Long
    With vsfgTree
        If .Row <= 0 Then Exit Sub
            If .Cell(flexcpBackColor, .Row, grdAcName) = pclrRestrictionColor Then
                ShowLedger mPeriodID, .ValueMatrix(.Row, grdAcID)
            End If
            If .WallPaper = imgWallpaper.ListImages("Lock").Picture Then
                .Editable = flexEDNone
            End If
    End With
    sSql = "Select Count(*) As Nos From AuditReportObjects Where PeriodID = " & mPeriodID
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            If Not .EOF Then
                lngCount = .Fields("Nos") & ""
            End If
            .Close
        End With
    If IsLocked Then Exit Sub
    If lngCount > 0 Then
        pMVE.MsgBox "Audit Report is already created for this period", msgOK, "AuditMate", msgInformation, True
    End If
    vsfgTree.EditCell
End Sub

Private Sub vsfgTree_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        If vsfgTree.Cell(flexcpBackColor, vsfgTree.Row, grdAcName) = pclrRestrictionColor Then
            vsfgTree_DblClick
        End If
    End If
End Sub

Public Sub SelectRowBorder(ByRef vsfgReport As VSFlexGrid, _
                           ByRef shpSelection As Shape, ByVal IsFormVisible As Boolean)
On Local Error Resume Next
Dim ColInc As Long
    With vsfgReport
        If .Row >= 0 Then
            shpSelection.Width = .Cell(flexcpLeft, .Row, .Cols - 1) + _
                .Cell(flexcpWidth, .Row, .Cols - 1) - .Cell(flexcpLeft, .Row, 0)
            shpSelection.Left = .Cell(flexcpLeft, .Row, 0)
            shpSelection.Top = .Cell(flexcpTop, .Row)
            shpSelection.Height = .Cell(flexcpHeight, .Row)
            If IsFormVisible Then
                shpSelection.Visible = True
            Else
                shpSelection.Visible = False
            End If
        End If
    End With
End Sub

Private Sub vsfgTree_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
    vsfgTree.DragRow vsfgTree.Row
End Sub

Private Sub vsfgTree_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgTree.ToolTipText = vsfgTree.Text
End Sub

Private Sub vsfgTree_RowColChange()
    SelectRowBorder vsfgTree, shpSelection, Visible
End Sub

Private Sub vsfgTree_AfterMoveRow(ByVal Row As Long, Position As Long)
On Local Error GoTo Err_Exit
Dim IsUpdated As Boolean, IsValid As Boolean, Inc As Long, sSql As String, lngTmpType As Long
Dim sSql1 As String
    If vsfgTree.ValueMatrix(vsfgTree.Row, grdAcID) > 0 Then
        If vsfgTree.Row > 0 Then
            If vsfgTree.ValueMatrix(vsfgTree.Row - 1, grdAcTypeID) > 0 Then
                If vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID) <> vsfgTree.ValueMatrix(vsfgTree.Row - 1, grdAcTypeID) Then
                    IsValid = True
                End If
            End If
        End If
    End If
    If IsValid Then
        sSql1 = "Select * from FilingAccountRemarks Where AcID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcID)
        With GetRecords(sSql1)
            If Not .EOF Then
                pMVE.MsgBox "Remarks exists for this Account Head in Filing Section.", msgOK, "AuditMate", msgInformation, True
            End If
        End With
        sSql1 = "Select * from DocumentSubLinks Where AcID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcID)
        With GetRecords(sSql1)
            If Not .EOF Then
                pMVE.MsgBox "Document attachments exists for this Account Head in Filing Section.", msgOK, "AuditMate", msgInformation, True
            End If
        End With
        If pMVE.MsgBox("Are You Sure To Change The Group of This Account Head?", msgYesNo, "AuditMate", msgQuestion, True) Then
            vsfgTree.TextMatrix(vsfgTree.Row, grdAcTypeID) = vsfgTree.ValueMatrix(vsfgTree.Row - 1, grdAcTypeID)
            sSql = "Update AcHeads Set AcTypeID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcTypeID) & " Where AcID = " & vsfgTree.ValueMatrix(vsfgTree.Row, grdAcID)
            AdoConn.Execute sSql
        End If
    Else
        pMVE.MsgBox "Invalid grouping movement.", msgOK, "AuditMate", msgInformation, True
    End If
    RefreshTrial
Exit Sub
Err_Exit:
    pMVE.MsgBox "Invalid grouping movement.", msgOK, "AuditMate", msgInformation, True
End Sub

Private Sub tbrCtrls_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
    ToolBarSubMenuActions ButtonMenu.Key
End Sub

Public Sub ToolBarSubMenuActions(Key As String)
On Local Error Resume Next
Dim Inc As Long
    Select Case Key
        Case "RptTBDetailed"
            PrintTBReport mPeriodID
        Case "RptCashFlow"
            PrintCashFlow mPeriodID
        Case "RptBalanceSheet"
            PrintBalanceSheet mPeriodID
        Case "RptProfitLoss"
            PrintProfitLoss mPeriodID
        Case "RptSchedules"
            PrintSchedules mPeriodID
        Case "RptLeadSheet"
            For Inc = vsfgTree.Row To 1 Step -1
                If vsfgTree.ValueMatrix(Inc, grdAcTypeID) <> 0 Then
                    PrintLeadSheets vsfgTree.ValueMatrix(Inc, grdAcTypeID), mPeriodID
                    Exit Sub
                End If
            Next Inc
        Case "RptAdjustment"
            PrintAdjustmentJournal pActivePeriodID
        Case "RptErrorSchedule"
            PrintErrorScheduleJournal pActivePeriodID
    End Select
End Sub

Public Sub PrintSchedules(lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, strNoteNo As String
Dim crptPrint As New clsReports, lngCurrentY As Long
Dim lngPropertyID As Long
    lngPropertyID = GetActualID(pActiveCompanyID, cnstAcTypePropertyPlantEquipment)
    Screen.MousePointer = vbHourglass
    crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 0, PeriodID
    sSql = "SELECT NoteNo, AcTypeID, ScheduleTypeID FROM Schedules WHERE IsFinished = 1 AND ScheduleTypeID IN " & _
           "       (" & cnstScheduleTypeGeneral & ", " & cnstScheduleTypeCashEquivalents & ", " & cnstScheduleTypeContingentLiability & ", " & cnstScheduleTypeSplit & ") " & _
           "AND    AcTypeID <> " & lngPropertyID & " " & _
           "AND    PeriodID = " & PeriodID & " ORDER BY CONVERT(int, NoteNo)"
    With GetRecords(sSql)
        While Not .EOF
            If .Fields("NoteNo") & "" <> "" Then
                If lngCurrentY > 10000 Or lngCurrentY = -1 Then
                    crptPrint.CreatePageBreak , , , , , , orPortrait
                    lngCurrentY = 0
                End If
                Select Case !ScheduleTypeID
                    Case cnstScheduleTypeGeneral
                        PrintGeneralSchedules PeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                    Case cnstScheduleTypeCashEquivalents
                        PrintCashEquivalentSchedule PeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                    Case cnstScheduleTypeContingentLiability
                        PrintLiabilitySchedules PeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                    Case cnstScheduleTypeSplit
                        PrintSplitSchedules PeriodID, .Fields("AcTypeID"), True, crptPrint, lngCurrentY
                End Select
            End If
            .MoveNext
        Wend
        .Close
    End With
    crptPrint.CreatePageBreak , , , , , , orPortrait
    crptPrint.EndReport
    crptPrint.Clear
    Set crptPrint = Nothing
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub CollectAllData()
On Local Error GoTo Err_Exit
Dim Row  As Long, sSqlTmpThis As String, sSqlTmpLast As String, sSqlHasJV As String, sSqlTmpActual As String, sSql As String
Dim dblTotDr As Double, dblTotCr As Double
Dim strCompanyName As String
    strCompanyName = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID)
    With vsfgTree
        .Rows = 0: .Rows = 2
        Row = 0
        .TextMatrix(Row, grdAcName) = strCompanyName
        .TextMatrix(Row, grdThisDebit) = mstrThisPeriodDesc
        .TextMatrix(Row, grdThisCredit) = mstrThisPeriodDesc
        .TextMatrix(Row, grdLastDebit) = mstrLastPeriodDesc
        .TextMatrix(Row, grdLastCredit) = mstrLastPeriodDesc

        .MergeCells = flexMergeFree
        .MergeRow(Row) = True
        .Cell(flexcpFontSize, Row, grdAcName) = 14
        .Cell(flexcpFontName, Row, grdAcName) = "Book Antiqua"
        .Cell(flexcpAlignment, Row, grdAcName) = flexAlignCenterCenter
        .Cell(flexcpFontBold, Row, grdAcName, Row, grdLastCredit) = True
        .MergeCells = flexMergeFree
        .MergeRow(Row) = True
        .Cell(flexcpAlignment, Row, grdThisDebit, Row, grdLastCredit) = flexAlignCenterCenter

        Row = Row + 1
        .RowHeight(Row) = 400
        .TextMatrix(Row, grdAcName) = "Trial Balance"
        .TextMatrix(Row, grdRefNo) = "Ref."
        .TextMatrix(Row, grdStatus) = ""
        .TextMatrix(Row, grdSchedule) = "Note"
        .TextMatrix(Row, grdThisDebit) = "Debit"
        .TextMatrix(Row, grdThisCredit) = "Credit"
        .TextMatrix(Row, grdLastDebit) = "Debit"
        .TextMatrix(Row, grdLastCredit) = "Credit"
        .Cell(flexcpFontSize, Row, grdAcName) = 12
        .Cell(flexcpFontSize, Row, grdStatus, Row, grdLastCredit) = 10
        .Cell(flexcpFontBold, Row, grdAcName, Row, grdLastCredit) = True
        '---All Account Groups--------------------------
        '---Checking Status -------
        sSql = "SELECT   AT.*, (SELECT TOP 1 IsNull(SCH.IsFinished,0) FROM Schedules SCH WHERE SCH.AcTypeID = AT.AcTypeID AND SCH.PeriodID = " & mPeriodID & ") AS Finished, " & _
               "(SELECT  TOP 1 IsNull(SCH.NoteNo,0) FROM Schedules SCH WHERE SCH.AcTypeID = AT.AcTypeID AND SCH.PeriodID = " & mPeriodID & ") AS NoteNo " & _
               "FROM     AcTypes AT WHERE AT.CompanyID = " & mCompanyID & " AND AT.IsHidden = 0  AND AT.StatusID = 1 OR AT.StatusID = 2 " & _
               "ORDER BY AT.TrialOrder, AT.AcTypeDescription"
        crsAllAcTypes.BindRecords sSql, AdoConn
        '---All Account Heads---------------------------
        sSqlTmpThis = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"

        sSqlTmpLast = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mLastPeriodID & ")"

        sSqlHasJV = "SELECT COUNT(ETA.AcID) AS NoOfRec FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening <> 1 AND ETA.EntryID = EM.EntryID " & _
                    "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"

        sSqlTmpActual = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening = 1 AND ETA.EntryID = EM.EntryID " & _
                        "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mPeriodID & ")"
        'Checking Status ------------
        sSql = "SELECT   AH.*, (" & sSqlTmpThis & ") AS ThisAmount, (" & sSqlTmpLast & ") AS LastAmount, (" & sSqlTmpActual & ") AS ActualAmount, CASE WHEN (" & sSqlHasJV & ") > 0 THEN 1 ELSE 0 END AS ISOtherEntries " & _
               "FROM     AcHeads AH WHERE CompanyID = " & mCompanyID & " AND StatusID = 1 OR StatusID = 2 " & _
               "ORDER BY TrialOrder, AcName"
        crsAllAcHeads.BindRecords sSql, AdoConn
        'Filling data (Recursive)-------------
        ShowGrpsAndAccts -1, dblTotDr, dblTotCr, "", 1
        .Outline 1: .Row = 1
        .AddItem "Grand Total"
        .Cell(flexcpFontBold, .Rows - 1, grdAcName, .Rows - 1, grdThisCredit) = True
        .IsSubtotal(.Rows - 1) = True
        FindTotal
        FindGrandTotal
        .Cell(flexcpAlignment, 1, 0, 0, grdStatus) = flexAlignLeftCenter
        .Cell(flexcpAlignment, 1, grdThisDebit, .Rows - 1, grdLastCredit) = flexAlignRightCenter
        .Cell(flexcpBackColor, 1, grdLastDebit, .Rows - 1, grdLastCredit) = RGB(250, 250, 250)
        .Cell(flexcpBackColor, 1, 0, 0, .Cols - 1) = RGB(230, 230, 255)
        .FrozenRows = 2
    End With
Exit Sub
Err_Exit:
    vsfgTree.Redraw = flexRDDirect
    ShowError
End Sub

Public Sub RefreshTrialAll()
On Local Error GoTo Err_Exit
    If Not Visible Then Exit Sub
    vsfgTree.Redraw = flexRDNone
    Screen.MousePointer = vbHourglass
    RecordGridFormat
    CollectAllData
    ExpandCollapse True, False
    Screen.MousePointer = vbDefault
    ApplyGridFormat
    vsfgTree.Redraw = flexRDDirect
Exit Sub
Err_Exit:
    Screen.MousePointer = vbDefault
End Sub
