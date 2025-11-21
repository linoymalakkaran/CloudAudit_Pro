VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.MDIForm MDIFormMain 
   Appearance      =   0  'Flat
   BackColor       =   &H8000000C&
   Caption         =   "AuditMate"
   ClientHeight    =   8595
   ClientLeft      =   225
   ClientTop       =   855
   ClientWidth     =   15210
   Icon            =   "MDIFormMain.frx":0000
   LinkTopic       =   "MDIForm1"
   LockControls    =   -1  'True
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgExplorerBar 
      Align           =   3  'Align Left
      Height          =   7980
      Left            =   0
      TabIndex        =   1
      Top             =   375
      Width           =   3555
      _cx             =   6271
      _cy             =   14076
      Appearance      =   0
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
      HighLight       =   0
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
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
      Begin VB.TextBox txtHelp 
         BackColor       =   &H80000018&
         Height          =   2415
         Left            =   0
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   8250
         Visible         =   0   'False
         Width           =   3540
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgMain 
         Height          =   10000
         Left            =   0
         TabIndex        =   3
         Top             =   0
         Width           =   3540
         _cx             =   6244
         _cy             =   17639
         Appearance      =   0
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
         BackColor       =   15532031
         ForeColor       =   0
         BackColorFixed  =   -2147483633
         ForeColorFixed  =   -2147483630
         BackColorSel    =   16761024
         ForeColorSel    =   -2147483634
         BackColorBkg    =   15532031
         BackColorAlternate=   15532031
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
         Rows            =   1
         Cols            =   8
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"MDIFormMain.frx":1CCA
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
         BackColorFrozen =   15532031
         ForeColorFrozen =   0
         WallPaperAlignment=   9
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
         Begin VB.Timer LoginTime 
            Interval        =   100
            Left            =   2400
            Top             =   4080
         End
         Begin MSComctlLib.ImageList imgLstTabs 
            Left            =   2400
            Top             =   675
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   16
            ImageHeight     =   16
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   17
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":1DC7
                  Key             =   "frmNavigator1"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":1FA1
                  Key             =   "frmNavigator"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":3C7B
                  Key             =   "frmCompany"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":4EFD
                  Key             =   "frmPeriods"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":5057
                  Key             =   "frmUser"
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":5371
                  Key             =   "frmAcHeads"
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":57C3
                  Key             =   "frmTrialBalance"
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":591D
                  Key             =   "frmDocumentCollect"
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":5D6F
                  Key             =   "frmJournalEntry"
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":6379
                  Key             =   ""
               EndProperty
               BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":67CB
                  Key             =   "frmAcTypes"
               EndProperty
               BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":6C1D
                  Key             =   "frmLedger"
               EndProperty
               BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":7077
                  Key             =   "frmReportDesigner"
               EndProperty
               BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":7B41
                  Key             =   "frmCurrencyMaster"
               EndProperty
               BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":7D1B
                  Key             =   "frmBankMaster"
               EndProperty
               BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":816D
                  Key             =   "frmAttachedDocumentsDetails"
               EndProperty
               BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":8347
                  Key             =   "frmReportGenerator"
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.ImageList imgWallPaper 
            Left            =   2400
            Top             =   1275
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   377
            ImageHeight     =   182
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   1
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":8521
                  Key             =   ""
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.ImageList imgLstToolBar 
            Left            =   2400
            Top             =   1875
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
                  Picture         =   "MDIFormMain.frx":CC8A
                  Key             =   "Search"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":D224
                  Key             =   "Add"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":DB2C
                  Key             =   "Add1"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":DD06
                  Key             =   "Detached"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":E268
                  Key             =   "Disconnected"
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.ImageList imglstIcons 
            Left            =   2400
            Top             =   2490
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   16
            ImageHeight     =   16
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   15
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":E58A
                  Key             =   "jpg"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":EB24
                  Key             =   "doc"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":F0BE
                  Key             =   "bmp"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":F658
                  Key             =   "gif"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":FBF2
                  Key             =   "mdb"
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":1018C
                  Key             =   "mdi"
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":102E6
                  Key             =   "pdf"
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":10880
                  Key             =   "ppt"
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":10E1A
                  Key             =   "tif"
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":10F74
                  Key             =   "txt"
               EndProperty
               BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":1150E
                  Key             =   "xls"
               EndProperty
               BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":11AA8
                  Key             =   "unknown"
               EndProperty
               BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":12042
                  Key             =   "folder"
               EndProperty
               BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":147F4
                  Key             =   "xlsx"
               EndProperty
               BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "MDIFormMain.frx":14BEC
                  Key             =   "docx"
               EndProperty
            EndProperty
         End
         Begin VB.Image ImgLogo 
            Height          =   570
            Left            =   120
            Picture         =   "MDIFormMain.frx":1511F
            Top             =   7080
            Visible         =   0   'False
            Width           =   1080
         End
         Begin VB.Image imgHamtLogo 
            Height          =   1560
            Left            =   120
            Picture         =   "MDIFormMain.frx":1BA1F
            Top             =   3780
            Visible         =   0   'False
            Width           =   2205
         End
      End
      Begin VB.Label lblCaption 
         AutoSize        =   -1  'True
         BackColor       =   &H80000018&
         BackStyle       =   0  'Transparent
         Caption         =   "Help"
         Height          =   195
         Left            =   75
         TabIndex        =   5
         Top             =   8055
         Width           =   330
      End
   End
   Begin MSComctlLib.StatusBar SBar 
      Align           =   2  'Align Bottom
      Height          =   240
      Left            =   0
      TabIndex        =   0
      Top             =   8355
      Width           =   15210
      _ExtentX        =   26829
      _ExtentY        =   423
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   8819
            MinWidth        =   8819
            Key             =   "Main"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   6068
            MinWidth        =   6068
            Key             =   "Cnn"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTitleBar 
      Align           =   1  'Align Top
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   15210
      _cx             =   26829
      _cy             =   661
      Appearance      =   0
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
      HighLight       =   0
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
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
      Begin VB.CommandButton cmdClose 
         DisabledPicture =   "MDIFormMain.frx":1D48E
         DownPicture     =   "MDIFormMain.frx":1DD58
         Height          =   345
         Left            =   18760
         Picture         =   "MDIFormMain.frx":1DF22
         Style           =   1  'Graphical
         TabIndex        =   8
         ToolTipText     =   "Close"
         Top             =   0
         Width           =   390
      End
      Begin MSComctlLib.Toolbar tbrMain 
         Height          =   330
         Left            =   0
         TabIndex        =   6
         Top             =   0
         Width           =   420
         _ExtentX        =   741
         _ExtentY        =   582
         ButtonWidth     =   609
         ButtonHeight    =   582
         Style           =   1
         ImageList       =   "imgLstToolBar"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Add"
               Object.ToolTipText     =   "Open Company"
               ImageIndex      =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   3
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.TabStrip tabStrip 
         Height          =   345
         Left            =   3540
         TabIndex        =   7
         Top             =   0
         Width           =   16000
         _ExtentX        =   28231
         _ExtentY        =   609
         MultiRow        =   -1  'True
         Style           =   2
         HotTracking     =   -1  'True
         Separators      =   -1  'True
         TabMinWidth     =   1058
         ImageList       =   "imgLstTabs"
         _Version        =   393216
         BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
            NumTabs         =   1
            BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Audit File"
               Key             =   "Navigator"
               ImageVarType    =   2
            EndProperty
         EndProperty
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         OLEDropMode     =   1
      End
      Begin VB.Label lblCompany 
         Height          =   330
         Left            =   420
         TabIndex        =   9
         Top             =   0
         Width           =   3255
      End
   End
   Begin VB.Menu mnuBegin 
      Caption         =   "File"
      Begin VB.Menu mnuFileNew 
         Caption         =   "New"
         Begin VB.Menu mnuBeginCompany 
            Caption         =   "Company"
         End
         Begin VB.Menu mnuBeginPeriod 
            Caption         =   "Periods"
         End
         Begin VB.Menu mnuBeginUser 
            Caption         =   "User"
         End
      End
      Begin VB.Menu mnuBeginChangePassword 
         Caption         =   "Change Password"
      End
      Begin VB.Menu mnuBeginUserBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBeginOpen 
         Caption         =   "Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuBeginAcTypes 
         Caption         =   "Account Types"
      End
      Begin VB.Menu mnuBeginAcHeads 
         Caption         =   "Account Heads"
      End
      Begin VB.Menu mnuBeginDocumentCollectBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMasters 
         Caption         =   "Masters"
         Begin VB.Menu mnuProcedures 
            Caption         =   "&Procedures"
         End
         Begin VB.Menu mnuResources 
            Caption         =   "&Resources"
         End
         Begin VB.Menu mnuSep 
            Caption         =   "-"
         End
         Begin VB.Menu mnuCurrency 
            Caption         =   "&Currency"
         End
         Begin VB.Menu mnuBanks 
            Caption         =   "&Banks"
         End
         Begin VB.Menu mnuNations 
            Caption         =   "&Nations"
         End
      End
      Begin VB.Menu mnuBeginDocumentDefenition 
         Caption         =   "Define Documents"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuBeginDocumentLinking 
         Caption         =   "Link Documents"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuBeginConvertBar 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuBeginConvert 
         Caption         =   "Convert Data ..."
         Visible         =   0   'False
      End
      Begin VB.Menu mnuBeginReOrganizeBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBeginReOrganize 
         Caption         =   "Reorganize Data"
      End
      Begin VB.Menu mnuBeginDeleteTempFilesBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBeginDeleteTempFiles 
         Caption         =   "Delete Temporary Files"
      End
      Begin VB.Menu mnuBeginOptionsBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBeginOptions 
         Caption         =   "Options"
      End
      Begin VB.Menu mnuFileExitBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuActions 
      Caption         =   "Actions"
      Begin VB.Menu mnuBeginDocumentCollect 
         Caption         =   "Collect Documents"
      End
      Begin VB.Menu mnuActionsTBBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDataSheet 
         Caption         =   "&Trial Balance"
      End
      Begin VB.Menu mnuActionsJournalEntryBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuActionsDatasheet 
         Caption         =   "&Datasheet"
      End
      Begin VB.Menu mnuJournalBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuActionsJournalEntry 
         Caption         =   "&Journal Entry"
      End
      Begin VB.Menu mnuActionsLedgerBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLedgerBook 
         Caption         =   "&Ledger Book"
      End
      Begin VB.Menu mnuActionsGenSchedule 
         Caption         =   "-"
      End
      Begin VB.Menu mnuGeneralSchedule 
         Caption         =   "&General Schedule"
      End
      Begin VB.Menu mnuActionsFixedAsset 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFxdAstSchedule 
         Caption         =   "&Fixed Asset Schedule"
      End
      Begin VB.Menu mnuActionsSplitSchedule 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSplitSchedule 
         Caption         =   "&Split Schedule"
      End
      Begin VB.Menu mnuActionsEquitySchedule 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEquitySchedule 
         Caption         =   "&Equity Schedule"
      End
      Begin VB.Menu mnuActionsCashFlow 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCashFlow 
         Caption         =   "&Cash Flow"
      End
      Begin VB.Menu mnuProcedureUpdation 
         Caption         =   "Procedure Updation"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuActionsReports 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReport 
         Caption         =   "Report"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuReportDesigner 
         Caption         =   "Report Designer"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuReportGenerator 
         Caption         =   "Report Generator"
      End
      Begin VB.Menu mnuActionsReview 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuReview 
         Caption         =   "Reviews"
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuDatabase 
      Caption         =   "Database"
      Begin VB.Menu mnuDatabaseDetach 
         Caption         =   "Detach / Attach Data"
      End
      Begin VB.Menu mnuDatabaseDetachBkpbar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDatabaseDetachBkp 
         Caption         =   "Detach && Backup"
      End
      Begin VB.Menu mnuTakeBackupbar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDatabaseTakeBackup 
         Caption         =   "Take Backup"
      End
      Begin VB.Menu mnuDatabaseClearDataBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDatabaseClearData 
         Caption         =   "Clear Data"
      End
      Begin VB.Menu mnuBeginRestoreDatabaseBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDatabaseRestore 
         Caption         =   "Restore Database"
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "View"
      Begin VB.Menu mnuViewReviewDetails 
         Caption         =   "Review Details"
      End
      Begin VB.Menu mnuViewReview 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuViewRefresh 
         Caption         =   "Refresh"
         Shortcut        =   {F5}
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "Popup"
      Visible         =   0   'False
      Begin VB.Menu mnuPopupConsoleRoot 
         Caption         =   "Console Root(Indexed)"
         Index           =   0
      End
      Begin VB.Menu mnuPopupAddRow 
         Caption         =   "Add new row"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuPopupDeleteRow 
         Caption         =   "Delete Row"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuPopupAddNewGroup 
         Caption         =   "Add New Group"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuPopupAddNewHead 
         Caption         =   "Add New Head"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuPopupDataDeleteRow 
         Caption         =   "Delete Row"
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuPopupReportDesigner 
      Caption         =   "Popup Report Designer"
      Visible         =   0   'False
      Begin VB.Menu mnuPopupReportDesignerSub 
         Caption         =   "Insert Row"
         Index           =   0
      End
      Begin VB.Menu mnuPopupReportDesignerSub 
         Caption         =   "Delete Row"
         Index           =   1
      End
      Begin VB.Menu mnuPopupReportDesignerSub 
         Caption         =   "Insert Column"
         Index           =   2
      End
      Begin VB.Menu mnuPopupReportDesignerSub 
         Caption         =   "Delete Column"
         Index           =   3
      End
   End
   Begin VB.Menu mnuPopupProcedureDocuments 
      Caption         =   "Popup Procedure Documents"
      Visible         =   0   'False
      Begin VB.Menu mnuPopupOpenDocument 
         Caption         =   "Open Document"
      End
      Begin VB.Menu mnuPopupCheckOutDocumentBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPopupCheckOutDocument 
         Caption         =   "Check Out Document"
      End
      Begin VB.Menu mnuPopupCheckInDocument 
         Caption         =   "Check In Document"
      End
   End
   Begin VB.Menu mnuPopupExternalDocuments 
      Caption         =   "Popup External Documents"
      Visible         =   0   'False
      Begin VB.Menu mnuPopupLinkExternalDocument 
         Caption         =   "Link Document"
      End
      Begin VB.Menu mnuPopupCheckOutExternalDocumentBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPopupCheckOutExternalDocument 
         Caption         =   "Check Out Document"
      End
      Begin VB.Menu mnuPopupCheckInExternalDocument 
         Caption         =   "Check In Document"
      End
   End
   Begin VB.Menu mnuPopupLinkDocument 
      Caption         =   "Popup Link Document"
      Visible         =   0   'False
      Begin VB.Menu mnuPopupCollectDocumentSub 
         Caption         =   "Collect Document"
      End
      Begin VB.Menu mnuPopupLinkDocumentSub 
         Caption         =   "Link Document"
      End
      Begin VB.Menu mnuPopupPrintFile 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPopupPrintFileSection 
         Caption         =   "Print Section"
      End
      Begin VB.Menu mnuPopupReviewDocumentSub 
         Caption         =   "Make Reviews"
         Visible         =   0   'False
      End
   End
   Begin VB.Menu mnuDBA 
      Caption         =   "DBA"
      Begin VB.Menu mnuDBAUserSettings 
         Caption         =   "User Privilege Settings"
      End
      Begin VB.Menu mnuDBAUserBar 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDBAFinalise 
         Caption         =   "Finalisation Procedure"
      End
      Begin VB.Menu mnuDBAFinaliseSep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDBAListCompany 
         Caption         =   "List Company Details"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "Help"
      Begin VB.Menu mnuHelpTips 
         Caption         =   "Important Tips"
      End
      Begin VB.Menu mnuHelpTipsSep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHelpAbout 
         Caption         =   "About"
      End
      Begin VB.Menu mnuHelpSep 
         Caption         =   "-"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuHelpNew 
         Caption         =   "What's new?..."
         Visible         =   0   'False
      End
   End
End
Attribute VB_Name = "MDIFormMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const grdParticulars = 0
Const grdStatus = 1
Const grdIsActive = 2
Const grdCompanyID = 3
Const grdIsCompany = 4
Const grdPeriodID = 5
Const grdIsPeriod = 6
Const grdElementID = 7
Const grdCols = 8

Const cnstSelectedChar = "ü"

Dim IsInitialized As Boolean
Dim mcrsConsoleRootObjectsAll As New clsRecordSet

Public Sub RemoveCompanyPeriodObjects(Optional lngMainPeriodID As Long = -1, Optional lngMainCompanyID As Long = -1)
On Local Error Resume Next
Dim lngCompanyID As Long, lngPeriodID As Long, Inc As Long, arrData() As String, arrIDs() As String
Dim strFormName As String
    With TabStrip
        For Inc = 1 To .Tabs.Count
            If .Tabs.Count = 1 Then Exit For
            TabStrip.Tabs(Inc).Selected = True
            arrData = Split(TabStrip.SelectedItem.Key, ";")
            strFormName = arrData(0)
            arrIDs = Split(arrData(1), "|")
            lngCompanyID = Val(arrIDs(0))
            lngPeriodID = Val(arrIDs(1))
            If lngPeriodID = lngMainPeriodID Then
                CloseActiveTabForm
                Inc = Inc - 1
            ElseIf lngCompanyID = lngMainCompanyID Then
                CloseActiveTabForm
                Inc = Inc - 1
            End If
        Next
    End With
    ShowNavigatorObjects 0, 0, 0
End Sub

Public Function ShowActiveTabForm() As Form
On Local Error Resume Next
Dim strFormName As String, strFormCaption As String, IsAlreadyActive As Boolean
Dim lngIndex As Long, frmForm As Form, arrData() As String, arrIDs() As String
Dim lngCompanyID As Long, lngPeriodID As Long
    arrData = Split(TabStrip.SelectedItem.Key, ";")
    strFormName = arrData(0)
    arrIDs = Split(arrData(1), "|")
    lngCompanyID = Val(arrIDs(0))
    lngPeriodID = Val(arrIDs(1))
    '----------------------------------------------------------------------------
    MakeInVisible strFormName
    strFormCaption = TabStrip.SelectedItem.Caption
    IsAlreadyActive = IsCalledFormActive(strFormName, strFormCaption, lngCompanyID, lngPeriodID, frmForm)
    If Not IsAlreadyActive Then
        lngIndex = Forms.Count
        Forms.Add strFormName
        Set frmForm = Forms(lngIndex)
        frmForm.Caption = " " & strFormCaption & " "
        frmForm.ZOrder vbBringToFront
        frmForm.Show
        TabStrip.SelectedItem.Image = strFormName
        frmForm.CompanyID = lngCompanyID
        frmForm.PeriodID = lngPeriodID
    End If
    Set ShowActiveTabForm = frmForm
'    Help = strFormName
End Function

'Public Property Let Help(strFormName As String)
'    txtHelp = PickValue("Help", "Description", "HelpName = '" & strFormName & "'")
'End Property

Public Sub MakeInVisible(strFormName As String)
On Local Error Resume Next
Dim Inc As Long, frmForm As Form
    For Inc = 0 To Forms.Count - 1
        If UCase(Trim(Forms(Inc).Name)) <> UCase(Trim(strFormName)) And UCase(Trim(Forms(Inc).Name)) <> "MDIFORMMAIN" Then
            Set frmForm = Forms(Inc)
            frmForm.Visible = False
        End If
    Next Inc
End Sub

Public Function IsCalledFormActive(ByVal strFrm As String, ByVal strCaption As String, lngCompanyID As Long, lngPeriodID As Long, frmForm As Form) As Boolean
'Return whether the called form is active.
On Local Error Resume Next
Dim Inc As Long, lngFrmCompanyID As Long, lngFrmPeriodID As Long
    IsCalledFormActive = False
    For Inc = 0 To Forms.Count - 1
        lngFrmCompanyID = 0: lngFrmPeriodID = 0
        If lngCompanyID <> 0 Then lngFrmCompanyID = Forms(Inc).CompanyID
        If lngPeriodID <> 0 Then lngFrmPeriodID = Forms(Inc).PeriodID
        If UCase(Trim(Forms(Inc).Name)) = UCase(Trim(strFrm)) And UCase(Trim(Forms(Inc).Caption)) = UCase(Trim(strCaption)) And _
            lngFrmCompanyID = lngCompanyID And lngFrmPeriodID = lngPeriodID Then

            Forms(Inc).ZOrder vbBringToFront
            Set frmForm = Forms(Inc)
            frmForm.WindowState = vbMaximized
            frmForm.Show
            frmForm.Visible = True
            IsCalledFormActive = True
            Exit Function
        End If
    Next Inc
    Err.Clear
End Function

Private Sub cmdClose_Click()
    CloseActiveTabForm
End Sub

Public Function CloseActiveTabForm() As Boolean
On Local Error Resume Next
Dim Inc As Long, strFrmName As String, frmForm As Form
Dim lngNextIndex As Long, arrData() As String, arrIDs() As String, strFrmKey As String
Dim lngCompanyID As Long, lngPeriodID As Long, lngFrmCompanyID As Long, lngFrmPeriodID As Long
    strFrmKey = TabStrip.SelectedItem.Key
    arrData = Split(TabStrip.SelectedItem.Key, ";")
    strFrmName = arrData(0)
    arrIDs = Split(arrData(1), "|")
    lngCompanyID = Val(arrIDs(0))
    lngPeriodID = Val(arrIDs(1))
    '---------------------------
    lngNextIndex = TabStrip.SelectedItem.Index - 1
    If strFrmName <> "frmNavigator" Then          'Never Close Navigator
        For Inc = 0 To Forms.Count - 1
            lngFrmCompanyID = 0: lngFrmPeriodID = 0
            If lngCompanyID <> 0 Then lngFrmCompanyID = Forms(Inc).CompanyID
            If lngPeriodID <> 0 Then
                lngFrmPeriodID = Forms(Inc).DefaultPeriodID
                If lngFrmPeriodID = 0 Then lngFrmPeriodID = Forms(Inc).PeriodID
            End If
            If UCase(Trim(Forms(Inc).Name)) = UCase(Trim(strFrmName)) And _
                lngFrmCompanyID = lngCompanyID And lngFrmPeriodID = lngPeriodID Then

                Forms(Inc).ZOrder vbBringToFront
                Set frmForm = Forms(Inc)
                Unload frmForm
                TabStrip.Tabs.Remove strFrmKey
                CloseActiveTabForm = True
                MDIFormMain.TabStrip.Tabs(lngNextIndex).Selected = True
                ShowActiveTabForm
                Exit Function
            End If
        Next Inc
    End If
End Function

'Private Sub LoginTime_Timer()
'On Local Error Resume Next
'Dim strSQL As String
'    strSQL = " Delete From Userlog Where UserID = " & pUserID
'    AdoConn.Execute strSQL
'    strSQL = "Insert into Userlog (UserID, CompanyID, PeriodID) Values"
'    strSQL = strSQL & " (" & pUserID & "," & pActiveCompanyID & "," & pActivePeriodID & ")"
'    AdoConn.Execute strSQL
'End Sub

Private Sub MDIForm_Activate()
    If Not IsInitialized And pLoginSucceeded Then
        LoadConsoleRoot GetIniString("ConsoleRoot")
        ActivateCompanyOrPeriod Val(GetIniString("ActiveCompany", 0)), Val(GetIniString("ActivePeriod", 0))
        IsInitialized = True
    End If
End Sub

Private Sub MDIForm_Load()
On Local Error Resume Next
    TabStrip.Tabs(1).Key = "frmNavigator"
    TabStrip.Tabs("frmNavigator").Caption = " Audit File "
    ShowActiveTabForm
End Sub

Private Sub MDIForm_Resize()
    AdjustToScreen
End Sub

Private Sub mnuAcTypes_Click()
    ShowFormInMDI "frmAcTypes", "Account Types"
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    If Not pMVE.MsgBox("Are you sure to exit the application?.", msgYesNo, "AuditMate", msgQuestion, True) Then
        Cancel = 1
    Else
        End
    End If
End Sub

Private Sub mnuActionsDatasheet_Click()
    ShowFormInMDI "frmDatasheet", "Datasheet", , pActivePeriodID
End Sub

Private Sub mnuActionsJournalEntry_Click()
    ShowJournal pActivePeriodID
End Sub

Private Sub mnuBanks_Click()
    ShowFormInMDI "frmBankMaster", "Bank Master", pActiveCompanyID
End Sub

Private Sub mnuBeginAcHeads_Click()
    ShowFormInMDI "frmAcHeads", "Account Heads", pActiveCompanyID
End Sub

Private Sub mnuBeginAcTypes_Click()
    ShowFormInMDI "frmAcTypes", "Account Types", pActiveCompanyID
End Sub

Private Sub mnuBeginChangePassword_Click()
    ShowFormInMDI "frmChangePassword", "Change Password"
End Sub

Private Sub mnuBeginCompany_Click()
    ShowFormInMDI "frmCompany", "Company"
    GetActiveFormObject("frmCompany").CompanyMode = cnstCompanyModeCreate
End Sub

Private Sub mnuBeginConvert_Click()
    ShowFormInMDI "frmConvertWizard", "Convert Data"
End Sub

Private Sub mnuBeginDeleteTempFiles_Click()
    DeleteTemporaryFiles
End Sub

Private Sub mnuBeginDocumentCollect_Click()
'    ShowFormInMDI "frmDocumentCollect", "Collect Documents(BIN)"
    frmDocumentCollect.Show
End Sub

Private Sub mnuBeginDocumentDefenition_Click()
    ShowFormInMDI "frmDocumentDefinition", "Define Documents", 0, pActivePeriodID
End Sub

Private Sub mnuBeginDocumentLinking_Click()
    ShowFormInMDI "frmDocLinking", "Link Documents", , pActivePeriodID
End Sub

Private Sub mnuBeginOpen_Click()
    ConsoleRoot = frmOpenPeriod.SelectPeriods(ConsoleRoot)
End Sub

Private Sub mnuBeginOptions_Click()
    ShowFormInMDI "frmOptions", "Options"
End Sub

Private Sub mnuBeginPeriod_Click()
    If pActiveCompanyID <> 0 Then
        ShowFormInMDI "frmPeriods", "Periods", pActiveCompanyID
    Else
        pMVE.MsgBox "No active company found!!!", msgOK, "AuditMate", msgExclamation, True
    End If
End Sub

Private Sub mnuBeginReOrganize_Click()
    ReOrganiseData True
End Sub

Private Sub mnuBeginUser_Click()
    ShowFormInMDI "frmUsers", "Users"
End Sub

Private Sub mnuCashFlow_Click()
    ShowFormInMDI "frmCashFlow", "Cash Flow", , pActivePeriodID
End Sub

Private Sub mnuCurrency_Click()
    ShowFormInMDI "frmCurrencyMaster", "Currency Master", pActiveCompanyID
End Sub

Private Sub mnuDatabaseAttach_Click()
    frmDetachNAttach.cmdAction.Caption = "Attach"
    frmDetachNAttach.Show vbModal
End Sub

Private Sub mnuDatabaseClearData_Click()
    If pActiveCompanyID = 0 Then
        pMVE.MsgBox "Select company first.", msgOK, "AuditMate", msgInformation, True
        Exit Sub
    Else
        If pMVE.MsgBox("Are you sure to delete all the existing data of the currently active company from the local database?", msgYesNo, "AuditMate", msgQuestion, True) Then
            TakeDataBaseBackup pActiveCompanyID, AdoConn
            DeleteExistingData
            pMVE.MsgBox "Data removed successfully.", msgOK, "AuditMate", msgInformation, True
        Else
            Exit Sub
        End If
    End If
End Sub

Private Sub mnuDatabaseDetach_Click()
    frmDetachNAttach.Show vbModal
End Sub

Private Sub mnuDatabaseDetachBkp_Click()
    frmDetachnBackup.Show vbModal
End Sub

Private Sub mnuDatabaseRestore_Click()
    ShowFormInMDI "frmRestoreDatabase", "Restore Database"
End Sub

Private Sub mnuDatabaseTakeBackup_Click()
    ShowFormInMDI "frmBackupData", "Backup Data"
End Sub

Private Sub mnuDataSheet_Click()
    ShowFormInMDI "frmTrialBalance", "Trial Balance", pActiveCompanyID, pActivePeriodID
End Sub

Private Sub mnuDBAFinalise_Click()
    ShowFormInMDI "frmFinalisation", "Finalise Period"
End Sub

Private Sub mnuDBAListCompany_Click()
    ShowFormInMDI "frmCompanyConsole", "Companies and Details", pActiveCompanyID
End Sub

Private Sub mnuDBAUserSettings_Click()
    ShowFormInMDI "frmPrivilegeSettings", "User Privilege Settings"
End Sub

Private Sub mnuEquitySchedule_Click()
    ShowFormInMDI "frmEquitySchedule", "Equity Schedule", , pActivePeriodID
End Sub

Private Sub mnuFileExit_Click()
    If pMVE.MsgBox("Are you sure to exit the application?.", msgYesNo, "AuditMate", msgQuestion, True) Then
        TerminateApplication
        End
    End If
End Sub

Private Sub mnuFxdAstSchedule_Click()
    ShowFormInMDI "frmFixedAssetSchedule", "Fixed Asset Schedule", , pActivePeriodID
End Sub

Private Sub mnuGeneralSchedule_Click()
    ShowFormInMDI "frmGeneralSchedule", "General Schedule", , pActivePeriodID
End Sub

Private Sub mnuHelpAbout_Click()
    frmLogo.CanEnd = False
    frmLogo.Show vbModal
End Sub

Private Sub mnuHelpNew_Click()
    ShowFormInMDI "frmVersionDetails", "Version Details"
End Sub

Private Sub mnuHelpTips_Click()
    ShowFormInMDI "frmTips", "Important Tips"
End Sub

Private Sub mnuLedgerBook_Click()
    ShowLedger pActivePeriodID
End Sub

Private Sub mnuNations_Click()
    ShowFormInMDI "frmNationsMaster", "Nations Master", pActiveCompanyID
End Sub

Private Sub mnuPopupAddNewGroup_Click()
    ActiveForm.AddNewGroup
End Sub

Private Sub mnuPopupAddNewHead_Click()
    ActiveForm.AddNewHead
End Sub

Private Sub mnuPopupAddRow_Click()
On Local Error Resume Next
    ActiveForm.AddRow
End Sub

Private Sub mnuPopupCheckInDocument_Click()
    GetActiveFormObject("frmNavigator").CheckInTemplateDocuments
End Sub

Private Sub mnuPopupCheckInExternalDocument_Click()
    GetActiveFormObject("frmNavigator").CheckInExternalDocuments
End Sub

Private Sub mnuPopupCheckOutDocument_Click()
    GetActiveFormObject("frmNavigator").CheckOutTemplateDocuments
End Sub

Private Sub mnuPopupCheckOutExternalDocument_Click()
    GetActiveFormObject("frmNavigator").CheckOutExternalDocuments
End Sub

Private Sub mnuPopupCollectDocumentSub_Click()
    frmDocumentCollect.Show
End Sub

Private Sub mnuPopupConsoleRoot_Click(Index As Integer)
    PropertyMenuActions Index
End Sub

Private Sub mnuPopupDataDeleteRow_Click()
    ActiveForm.DataDeleteRow
End Sub

Private Sub mnuPopupDeleteRow_Click()
On Local Error Resume Next
    ActiveForm.DeleteRow
End Sub

Private Sub mnuPopupLinkDocumentSub_Click()
    GetActiveFormObject("frmNavigator").LinkDocuments
End Sub

Private Sub mnuPopupOpenExternalDocument_Click()
    GetActiveFormObject("frmNavigator").OpenExternalDocument
End Sub

Private Sub mnuPopupLinkExternalDocument_Click()
    GetActiveFormObject("frmNavigator").LinkDocuments
End Sub

Private Sub mnuPopupPrintFileSection_Click()
    GetActiveFormObject("frmNavigator").PrintAuditFile
End Sub

Private Sub mnuPopupReportDesignerSub_Click(Index As Integer)
On Local Error Resume Next
    With ActiveForm.ActiveControl
        Select Case Index
            Case 0
                .AddItem "", .Row
            Case 1
                If pMVE.MsgBox("Are you sure to delete the row?", msgYesNo, "AuditMate") Then
                    .RemoveItem .Row
                End If
            Case 2
                ' insert column
                .Cols = .Cols + 1               ' add column
                .ColPosition(.Cols - 1) = .Col  ' move into place
            Case 3
                If pMVE.MsgBox("Are you sure to delete the column?", msgYesNo, "AuditMate") Then
                    ' delete column
                    .ColPosition(.Col) = .Cols - 1  ' move to right
                    .Cols = .Cols - 1               ' delete column
                End If
        End Select
    End With
End Sub

Private Sub mnuPopupReviewDocumentSub_Click()
    GetActiveFormObject("frmNavigator").LinkReviews
End Sub

Private Sub mnuProcedures_Click()
    ShowFormInMDI "frmProcedure", "Procedure Creation", , pActivePeriodID
'    GetActiveFormObject("frmProcedures").Mode = cnstProcedureModeCreate
End Sub

Private Sub mnuProcedureUpdation_Click()
    ShowFormInMDI "frmProcedures", "Procedure Updation", , pActivePeriodID
    GetActiveFormObject("frmProcedures").Mode = cnstProcedureModeUpdate
End Sub

Private Sub mnuReport_Click()
    frmPreview.Show
End Sub

Private Sub mnuReportDesigner_Click()
    ShowFormInMDI "frmReportDesigner", "Report Designer", , pActivePeriodID
    GetActiveFormObject ("frmReportDesigner")
End Sub

Private Sub mnuReportEdit_Click()
On Local Error Resume Next
    ShowFormInMDI("frmReportGenerator", "Report Generator", , pActivePeriodID).UpdateItems
End Sub

Private Sub mnuReportGenerator_Click()
    ShowFormInMDI "frmReportGenerator", "Report Generator", , pActivePeriodID
End Sub

Private Sub mnuResources_Click()
    ShowFormInMDI "frmResources", "Resource Loading", , pActivePeriodID
End Sub

Private Sub mnuReview_Click()
    ShowFormInMDI "frmReview", "Reviews", , pActivePeriodID
End Sub

Private Sub mnuSplitSchedule_Click()
    ShowFormInMDI "frmSplitSchedule", "Split Schedule", , pActivePeriodID
End Sub

Private Sub mnuViewRefresh_Click()
    RefreshAll
'    PrintAllSchedules pActivePeriodID
End Sub

Private Sub mnuViewReviewDetails_Click()
    ShowFormInMDI "frmReviewDetails", "Dashboard", , pActivePeriodID
End Sub

Private Sub tabStrip_Click()
    ShowActiveTabForm
End Sub

Public Sub AdjustToScreen()
On Local Error Resume Next
    vsfgExplorerBar.Width = GetProportionalValue(3555, False)
    vsfgMain.Width = GetProportionalValue(3540, False)
    txtHelp.Width = GetProportionalValue(3540, False)
    TabStrip.Left = GetProportionalValue(3540, False)
    tbrMain.Width = GetProportionalValue(3540, False)

    vsfgMain.Height = GetProportionalValue(11000)
    lblCaption.Top = GetProportionalValue(8055)
    txtHelp.Top = GetProportionalValue(8250)
    txtHelp.Height = GetProportionalValue(2415)
    ImgLogo.Top = GetProportionalValue(9530)
    cmdClose.Left = GetProportionalValue(18760, False)
    FormatConsoleRootGrid
End Sub

'---Functions for Handling Console Root-----------
Private Sub LoadConsoleRoot(strObjectIds As String)
On Local Error GoTo Err_Exit
Dim arrData() As String, arrObjects() As String
Dim Inc As Long, Inc1 As Long, crsObjects As New clsRecordSet
Dim lngCompanyID As Long, lngPeriodID As Long, strTmp As String, lngTmp As Long, lngRow As Long
    mcrsConsoleRootObjectsAll.BindRecords "Select * from ConsoleRootObjects Order BY ParentObjectID, DisplayOrder", AdoConn
    '--------------------------------------------
    vsfgMain.OutlineBar = flexOutlineBarSymbolsLeaf
    vsfgMain.OutlineCol = grdParticulars
    vsfgMain.MergeCells = flexMergeFree
    vsfgMain.MergeCellsFixed = flexMergeFree
    vsfgMain.TextMatrix(0, grdStatus) = "Console Root"
    vsfgMain.MergeRow(0) = True
    '--------------------------------------------
    If strObjectIds = "" Then
        Exit Sub
    End If
    If Right(strObjectIds, 2) = "; " Then
        strObjectIds = Left(strObjectIds, Len(strObjectIds) - 2)
    End If
    arrData = Split(strObjectIds, ";")
    For Inc = 0 To UBound(arrData)
        arrObjects = Split(arrData(Inc), "|")
        lngCompanyID = Val(arrObjects(0))
        lngPeriodID = Val(arrObjects(1))
        LoadCompanyInConsoleRoot lngCompanyID
        LoadPeriodInConsoleRoot lngPeriodID, lngCompanyID
    Next Inc
    '---Loading Extra Objects---------------
    crsObjects.BindRecordSet mcrsConsoleRootObjectsAll, "ParentObjectID|=|;ObjectID|<>|" & cnstObjectCompany
    With vsfgMain
        While Not crsObjects.EOF
            For Inc = 1 To .Rows - 1
                If .ValueMatrix(Inc, grdElementID) = Val(crsObjects.Fields("ObjectID") & "") Then
                    .RemoveItem Inc
                    Exit For
                End If
            Next Inc
            lngRow = .Rows
            strTmp = IIf(crsObjects.Fields("DisplayName") & "" = "", crsObjects.Fields("ObjectName") & "", crsObjects.Fields("DisplayName") & "")
            vsfgMain.AddItem strTmp, lngRow
            .TextMatrix(lngRow, grdCompanyID) = 0
            .TextMatrix(lngRow, grdPeriodID) = 0
            .TextMatrix(lngRow, grdElementID) = Val(crsObjects.Fields("ObjectID") & "")
            .IsSubtotal(lngRow) = True
            .RowOutlineLevel(lngRow) = 1
            .IsCollapsed(lngRow) = flexOutlineCollapsed
            strTmp = crsObjects.Fields("FontName") & ""
            If strTmp <> "" Then
                .Cell(flexcpFontName, lngRow, grdParticulars) = strTmp
            End If
            lngTmp = Val(crsObjects.Fields("FontSize") & "")
            If lngTmp <> 0 Then
                .Cell(flexcpFontSize, lngRow, grdParticulars) = lngTmp
            End If
            .Cell(flexcpFontBold, lngRow, grdParticulars) = crsObjects.Fields("IsBold")
            .Cell(flexcpFontItalic, lngRow, grdParticulars) = crsObjects.Fields("IsItalic")
            .Cell(flexcpFontUnderline, lngRow, grdParticulars) = crsObjects.Fields("IsUnderlined")
            lngTmp = Val(crsObjects.Fields("ForeColor") & "")
            If lngTmp <> 0 Then
                .Cell(flexcpForeColor, lngRow, grdParticulars) = lngTmp
            End If
            lngTmp = Val(crsObjects.Fields("BackColor") & "")
            If lngTmp <> 0 Then
                .Cell(flexcpBackColor, lngRow, grdParticulars) = lngTmp
            End If
            crsObjects.MoveNext
        Wend
    End With
    crsObjects.Clear
    '---------------------------------------
    ActivateCompanyOrPeriod
    RecordConsoleRoot
Exit Sub
Err_Exit:
End Sub

Public Sub RecordConsoleRoot()
Dim Inc As Long
    SetIniString "ConsoleRoot", ConsoleRoot
    With vsfgMain
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsActive) = 1 And .ValueMatrix(Inc, grdIsCompany) = 1 Then
                SetIniString "ActiveCompany", .ValueMatrix(Inc, grdCompanyID)
                Exit For
            End If
        Next Inc
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsActive) And .ValueMatrix(Inc, grdIsPeriod) = 1 Then
                SetIniString "ActivePeriod", .ValueMatrix(Inc, grdPeriodID)
                Exit For
            End If
        Next Inc
    End With
End Sub

Private Sub LoadCompanyInConsoleRoot(lngCompanyID As Long)
On Local Error GoTo Err_Exit
Dim crsCompany As New clsRecordSet, IsCompanyExists As Boolean, Inc As Long
Dim strCompany As String, strDetachedBy As String
Dim sSql As String, strCurCompany As String
'    strCurCompany = PickValue("Companies", "CompanyName", "CompanyID = " & lngCompanyID)
    With vsfgMain
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdCompanyID) = lngCompanyID Then
                IsCompanyExists = True
                Exit For
            End If
        Next Inc
    End With
    '---If company not exists then-----------------------------
    If Not IsCompanyExists Then
        With vsfgMain
            crsCompany.BindRecordSet pcrsAllCompany, "CompanyID|=|" & lngCompanyID
            If Not crsCompany.EOF Then
                .Rows = .Rows + 1
                Inc = .Rows - 1
                .TextMatrix(Inc, grdParticulars) = crsCompany.Fields("CompanyName") & ""
                .TextMatrix(Inc, grdCompanyID) = lngCompanyID
                .TextMatrix(Inc, grdIsCompany) = 1
                .TextMatrix(Inc, grdElementID) = cnstObjectCompany
                .IsSubtotal(Inc) = True
                .RowOutlineLevel(Inc) = 0
                .Cell(flexcpFontName, Inc, grdParticulars) = "Cambria"
                .Cell(flexcpFontSize, Inc, grdParticulars) = 10
                .Cell(flexcpFontBold, Inc, grdParticulars) = True
                .RowHeight(Inc) = 350
                LoadObjects True, lngCompanyID, 0, cnstObjectCompany, 1
            End If
        End With
    Else
        crsCompany.BindRecordSet pcrsAllCompany, "CompanyID|=|" & lngCompanyID
        If Not crsCompany.EOF Then
            vsfgMain.TextMatrix(Inc, grdParticulars) = crsCompany.Fields("CompanyName") & ""
        End If
        crsCompany.Clear
    End If
    '--- Marking Detached Status------------------------------------------------------
    '--- Ref No: 064-20/01/09 ------------------
    sSql = "Select DetachedBy From Companies Where CompanyID = " & lngCompanyID
    With GetRecords(sSql, AdoConn)
        While Not .EOF
            strCompany = vsfgMain.TextMatrix(Inc, grdParticulars)
            strDetachedBy = .Fields("DetachedBy") & ""
            If .Fields("DetachedBy") & "" = "" Then
                vsfgMain.Cell(flexcpForeColor, Inc, grdParticulars) = &H800000              'RGB(100, 140, 255)
                vsfgMain.Cell(flexcpPictureAlignment, Inc, grdParticulars) = flexPicAlignLeftCenter
                vsfgMain.Cell(flexcpPicture, Inc, grdParticulars) = Nothing
                Exit Sub
            Else
                vsfgMain.Cell(flexcpForeColor, Inc, grdParticulars) = RGB(255, 0, 0)
                vsfgMain.Cell(flexcpPictureAlignment, Inc, grdParticulars) = flexPicAlignLeftCenter
                vsfgMain.Cell(flexcpPicture, Inc, grdParticulars) = imgLstToolBar.ListImages("Detached").Picture
            End If
            .MoveNext
        Wend
        vsfgMain.TextMatrix(Inc, grdParticulars) = strCompany & "  " & strDetachedBy
        .Close
    End With
    '-----------------------------------------------------------------------------
'    lblCompany.Caption = strCurCompany
Exit Sub
Err_Exit:
End Sub

Private Sub CloseCompanyFromConsoleRoot(lngCompanyID As Long)
On Local Error Resume Next
Dim Inc As Long
    With vsfgMain
        For Inc = .Rows - 1 To 1 Step -1
            If .ValueMatrix(Inc, grdCompanyID) = lngCompanyID Then
                .RemoveItem (Inc)
            End If
        Next Inc
    End With
    RemoveCompanyPeriodObjects , lngCompanyID
    ActivateCompanyOrPeriod
    RecordConsoleRoot
End Sub

Private Sub ClosePeriodFromConsoleRoot(lngPeriodID As Long)
On Local Error Resume Next
Dim Inc As Long
    With vsfgMain
        For Inc = .Rows - 1 To 1 Step -1
            If .ValueMatrix(Inc, grdPeriodID) = lngPeriodID Then
                .RemoveItem (Inc)
            End If
        Next Inc
    End With
    RemoveCompanyPeriodObjects lngPeriodID
    ActivateCompanyOrPeriod
    RecordConsoleRoot
End Sub

Private Sub LoadPeriodInConsoleRoot(lngPeriodID As Long, Optional lngLoadUnderCompanyID As Long)
On Local Error GoTo Err_Exit
Dim crsPeriods As New clsRecordSet, Inc As Long, IncRow As Long
    With vsfgMain
        For Inc = .Rows - 1 To 1 Step -1
            If .ValueMatrix(Inc, grdPeriodID) = lngPeriodID And lngPeriodID <> 0 Then
                .RemoveItem Inc
            End If
        Next Inc
        For Inc = .Rows - 1 To 1 Step -1
            If .ValueMatrix(Inc, grdCompanyID) = lngLoadUnderCompanyID Then
                IncRow = Inc + 1
                Exit For
            End If
        Next Inc
    End With

    If IncRow <> 0 Then
        With vsfgMain
            crsPeriods.BindRecordSet pcrsAllPeriod, "PeriodID|=|" & lngPeriodID
            If Not crsPeriods.EOF Then
                .AddItem crsPeriods.Fields("ShortName") & "", IncRow
                .TextMatrix(IncRow, grdCompanyID) = lngLoadUnderCompanyID
                .TextMatrix(IncRow, grdPeriodID) = lngPeriodID
                .TextMatrix(IncRow, grdIsPeriod) = 1
                .TextMatrix(IncRow, grdElementID) = cnstObjectPeriod
                .IsSubtotal(IncRow) = True
                .RowOutlineLevel(IncRow) = 1
                .Cell(flexcpForeColor, IncRow, grdParticulars) = RGB(240, 180, 100)
                .Cell(flexcpFontSize, IncRow, grdParticulars) = 9
                .Cell(flexcpFontBold, IncRow, grdParticulars) = True
                LoadObjects False, lngLoadUnderCompanyID, lngPeriodID, cnstObjectPeriod
            End If
        End With
    End If
Exit Sub
Err_Exit:
End Sub

Public Sub LoadObjects(IsCompany As Boolean, lngCompanyID As Long, Optional lngPeriodID As Long = 0, Optional lngParentObjectID As Long = -1, Optional lngLevel As Long = 2)
On Local Error GoTo Err_Exit
Dim lngRow As Long, Inc As Long, sSql As String, crsObjects As New clsRecordSet, strTmp As String, lngTmp As Long
    With vsfgMain
        '---Reading Section Data---------------------
        crsObjects.BindRecordSet mcrsConsoleRootObjectsAll, "ParentObjectID|=|" & IIf(lngParentObjectID = -1, "", lngParentObjectID)
        While Not crsObjects.EOF
            If Val(crsObjects.Fields("ObjectID") & "") <> cnstObjectPeriod Then
                '---Finding Next Row----------
                For Inc = .Rows - 1 To 1 Step -1
                    If IsCompany Then
                        If .ValueMatrix(Inc, grdCompanyID) = lngCompanyID Then
                            lngRow = Inc + 1
                            Exit For
                        End If
                    Else
                        If .ValueMatrix(Inc, grdPeriodID) = lngPeriodID Then
                            lngRow = Inc + 1
                            Exit For
                        End If
                    End If
                Next Inc
                strTmp = IIf(crsObjects.Fields("DisplayName") & "" = "", crsObjects.Fields("ObjectName") & "", crsObjects.Fields("DisplayName") & "")
                vsfgMain.AddItem strTmp, lngRow
                vsfgMain.TextMatrix(lngRow, grdStatus) = strTmp
                .TextMatrix(lngRow, grdCompanyID) = lngCompanyID
                .TextMatrix(lngRow, grdPeriodID) = lngPeriodID
                .TextMatrix(lngRow, grdElementID) = Val(crsObjects.Fields("ObjectID") & "")
                .IsSubtotal(lngRow) = True
                .RowOutlineLevel(lngRow) = lngLevel
                strTmp = crsObjects.Fields("FontName") & ""
                If strTmp <> "" Then
                    .Cell(flexcpFontName, lngRow, grdParticulars) = strTmp
                End If
                lngTmp = Val(crsObjects.Fields("FontSize") & "")
                If lngTmp <> 0 Then
                    .Cell(flexcpFontSize, lngRow, grdParticulars) = lngTmp
                End If
                .Cell(flexcpFontBold, lngRow, grdParticulars) = crsObjects.Fields("IsBold")
                .Cell(flexcpFontItalic, lngRow, grdParticulars) = crsObjects.Fields("IsItalic")
                .Cell(flexcpFontUnderline, lngRow, grdParticulars) = crsObjects.Fields("IsUnderlined")
                lngTmp = Val(crsObjects.Fields("ForeColor") & "")
                If lngTmp <> 0 Then
                    .Cell(flexcpForeColor, lngRow, grdParticulars) = lngTmp
                End If
                lngTmp = Val(crsObjects.Fields("BackColor") & "")
                If lngTmp <> 0 Then
                    .Cell(flexcpBackColor, lngRow, grdParticulars) = lngTmp
                End If
                vsfgMain.MergeRow(lngRow) = True
                lngRow = lngRow + 1
                '---Calling next level---------------------
                LoadObjects IsCompany, lngCompanyID, lngPeriodID, Val(crsObjects.Fields("ObjectID") & ""), lngLevel + 1
            End If
            crsObjects.MoveNext
        Wend
        crsObjects.Clear
    End With
Exit Sub
Err_Exit:

End Sub

Public Function ActivateCompanyOrPeriod(Optional lngCompanyID As Long = 0, Optional lngPeriodID As Long = 0) As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    With vsfgMain
        'Remove the currently active company
        pActiveCompanyID = 0
        pActivePeriodID = 0
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsActive) = 1 Then
                .TextMatrix(Inc, grdIsActive) = 0
                .TextMatrix(Inc, grdStatus) = ""
            End If
        Next Inc
        If lngPeriodID = 0 And lngCompanyID = 0 Then
            If GetCompanyCount = 1 Then
                For Inc = 1 To .Rows - 1
                    If .ValueMatrix(Inc, grdCompanyID) <> 0 Then
                        SetActiveRow .ValueMatrix(Inc, grdCompanyID), False
                        Exit For
                    End If
                Next Inc
                If GetPeriodCount(.ValueMatrix(Inc, grdCompanyID)) = 1 Then
                    For Inc = Inc To .Rows - 1
                        If .ValueMatrix(Inc, grdPeriodID) <> 0 Then
                            SetActiveRow .ValueMatrix(Inc, grdPeriodID), True
                            Exit For
                        End If
                    Next Inc
                End If
            End If
        End If
        'Activating Period Or Company
        If lngPeriodID <> 0 Then
            SetActiveRow lngPeriodID, True
        ElseIf lngCompanyID <> 0 Then
            SetActiveRow lngCompanyID, False
        End If
'        frmNavigator.ShowCompanyInfo = lngCompanyID
    End With
    RecordConsoleRoot
    MakeActiveFormsReadOnly
Exit Function
Err_Exit:
    ActivateCompanyOrPeriod = False
End Function

Public Sub FormatConsoleRootGrid()
On Local Error Resume Next
    With vsfgMain
        .ColWidth(grdParticulars) = GetProportionalValue(2800, False)
    End With
End Sub

Public Function GetCompanyCount() As Long
On Local Error Resume Next
Dim Inc As Long, lngCount As Long
    For Inc = 1 To vsfgMain.Rows - 1
        If vsfgMain.ValueMatrix(Inc, grdIsCompany) = 1 Then
            lngCount = lngCount + 1
        End If
    Next Inc
    GetCompanyCount = lngCount
End Function

Public Function GetPeriodCount(lngCompanyID As Long) As Long
On Local Error Resume Next
Dim Inc As Long, lngCount As Long
    For Inc = 1 To vsfgMain.Rows - 1
        If vsfgMain.ValueMatrix(Inc, grdCompanyID) = lngCompanyID And vsfgMain.ValueMatrix(Inc, grdIsPeriod) = 1 Then
            lngCount = lngCount + 1
        End If
    Next Inc
    GetPeriodCount = lngCount
End Function

Private Sub SetActiveRow(lngID As Long, IsPeriod As Boolean)
Dim Inc As Long
    With vsfgMain
        If IsPeriod Then
            For Inc = 1 To .Rows - 1
                If .ValueMatrix(Inc, grdPeriodID) = lngID Then
                    .TextMatrix(Inc, grdStatus) = cnstSelectedChar
                    .TextMatrix(Inc, grdIsActive) = 1
                    .Cell(flexcpFontName, Inc, grdStatus) = "Wingdings"
                    .Cell(flexcpFontSize, Inc, grdStatus) = 8
                    .Cell(flexcpFontBold, Inc, grdStatus) = True
                    .Cell(flexcpForeColor, Inc, grdStatus) = RGB(200, 50, 0)
                    pActivePeriodID = .ValueMatrix(Inc, grdPeriodID)
                    SetActiveRow .ValueMatrix(Inc, grdCompanyID), False
                    Exit For
                End If
            Next Inc
        Else
            For Inc = 1 To .Rows - 1
                If .ValueMatrix(Inc, grdCompanyID) = lngID Then
                    .TextMatrix(Inc, grdStatus) = cnstSelectedChar
                    .TextMatrix(Inc, grdIsActive) = 1
                    .Cell(flexcpFontName, Inc, grdStatus) = "Wingdings"
                    .Cell(flexcpFontSize, Inc, grdStatus) = 8
                    .Cell(flexcpFontBold, Inc, grdStatus) = True
                    .Cell(flexcpForeColor, Inc, grdStatus) = RGB(240, 0, 0)
                    pActiveCompanyID = .ValueMatrix(Inc, grdCompanyID)
                    Exit For
                End If
            Next Inc
        End If
    End With
End Sub

Private Sub tbrMain_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "Add"
            ConsoleRoot = frmOpenPeriod.SelectPeriods(ConsoleRoot)
        Case "Search"
            'Temporary Purpose
'            PrintGeneralSchedules 3, 1209
    End Select
End Sub

Private Sub SelectObject()
    With vsfgMain
        If .Row > 0 Then
            ShowNavigatorObjects .ValueMatrix(.Row, grdElementID), .ValueMatrix(.Row, grdCompanyID), .ValueMatrix(.Row, grdPeriodID)
        End If
    End With
End Sub

Public Sub ShowNavigatorObjects(lngObjectID As Long, lngCompanyID As Long, lngPeriodID As Long)
On Local Error Resume Next
Dim frm As frmNavigator
    Set frm = GetActiveFormObject("frmNavigator")
    frm.ObjectID = lngObjectID
    Select Case lngObjectID
        Case cnstObjectPeriod
            frm.ShowAuditReport lngPeriodID
            ShowFormInMDI "frmReviewDetails", "Dashboard", , pActivePeriodID
        Case cnstObjectAccountTypes
'            frm.ShowAccountTypes lngCompanyID, lngPeriodID, False
        Case cnstObjectAccountHeads
'            frm.ShowAccountHeads lngCompanyID, lngPeriodID, False
        Case cnstObjectTrialBalance
'            frm.ShowAccountTypes lngCompanyID, lngPeriodID, True
        Case cnstObjectBIN
            frm.ShowDocBin
        Case cnstObjectAccountLedger
            frm.ShowAccountHeads lngCompanyID, lngPeriodID, True
        Case cnstObjectCompany
            frm.ShowCompanyInfo = lngCompanyID
        Case Else
            frm.ShowNavigatorOnly
    End Select
End Sub

Private Sub vsfgMain_Click()
Dim strCompanyName As String
    strCompanyName = PickValue("Companies", "CompanyName", "CompanyID = " & pActiveCompanyID)
    MDIFormMain.Caption = App.Title & " : User - " + pUserName & "  Logged into : " + pstrDomain & " - " + strCompanyName
End Sub

Private Sub vsfgMain_DblClick()
Dim lngDefPrvlID As Integer
    If vsfgMain.Row > 0 Then
        lngDefPrvlID = Val(PickValue("ObjectPrivileges", "PrvlID", "ObjectID = " & vsfgMain.ValueMatrix(vsfgMain.Row, grdElementID) & " AND IsObjectPrvl = 1"))
        If lngDefPrvlID <> 0 Then
            PropertyMenuActions lngDefPrvlID
        End If
    End If
End Sub

Private Sub vsfgMain_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgMain.ToolTipText = vsfgMain.Text
End Sub

Private Sub vsfgMain_RowColChange()
Dim lngColor As Long
    lngColor = RGB(240, 240, 240)
    SelectRow vsfgMain, , , lngColor
    SelectObject
End Sub

Public Property Get ConsoleRoot() As String
Dim strConsoleRoot As String, strTmp As String, Inc As Long
    With vsfgMain
        For Inc = 1 To .Rows - 1
            strTmp = .ValueMatrix(Inc, grdCompanyID) & "|" & .ValueMatrix(Inc, grdPeriodID) & "; "
            If InStr(1, strConsoleRoot, strTmp) = 0 Then
                strConsoleRoot = strConsoleRoot & strTmp
            End If
        Next Inc
    End With
    ConsoleRoot = strConsoleRoot
End Property

Public Property Let ConsoleRoot(ByVal vNewValue As String)
    LoadConsoleRoot vNewValue
End Property

Private Sub vsfgMain_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
        vsfgMain.Col = vsfgMain.MouseCol
        vsfgMain.Row = vsfgMain.MouseRow
        PopupObjectPrivileges X, Y
    End If
End Sub

Public Sub PopupObjectPrivileges(X As Single, Y As Single)
On Local Error Resume Next
Dim sSql As String, lngRow As Long, lngObjectID As Long, strCaption As String, Ctrl As Control
Dim IsMenuExists As Boolean, mnuDefaultMenu As Menu
    If vsfgMain.Row > 0 Then
        lngRow = vsfgMain.Row
    Else
        Exit Sub
    End If
    '---Clear All Menus---------
    mnuPopupConsoleRoot(0).Visible = True
    For Each Ctrl In MDIFormMain
        If TypeOf Ctrl Is Menu Then
            If Ctrl.Name Like "mnuPopupConsoleRoot*" Then
                If Ctrl.Index <> 0 Then Unload Ctrl
            End If
        End If
    Next
    '---------------------------
    lngObjectID = vsfgMain.ValueMatrix(lngRow, grdElementID)
    sSql = "SELECT  * From ObjectPrivileges Where ObjectID = " & lngObjectID & " And IsHidden = 0"
    With GetRecords(sSql)
        While Not .EOF
            Load mnuPopupConsoleRoot(.Fields("PrvlID"))
            strCaption = IIf(.Fields("DisplayName") & "" = "", .Fields("PrvlName") & "", .Fields("DisplayName") & "")
            mnuPopupConsoleRoot(.Fields("PrvlID")).Caption = strCaption
            mnuPopupConsoleRoot(.Fields("PrvlID")).Tag = .Fields("Command") & ""
            mnuPopupConsoleRoot(.Fields("PrvlID")).Visible = True
            mnuPopupConsoleRoot(.Fields("PrvlID")).Enabled = True
            If .Fields("IsObjectPrvl") Then
                Set mnuDefaultMenu = mnuPopupConsoleRoot(.Fields("PrvlID"))
            End If
            IsMenuExists = True
            .MoveNext
        Wend
        .Close
    End With
    mnuPopupConsoleRoot(0).Caption = "Refresh"
    IsMenuExists = True
    
    If IsMenuExists Then
        If Not mnuDefaultMenu Is Nothing Then
            PopupMenu mnuPopup, , X, Y + 330, mnuDefaultMenu
        Else
            PopupMenu mnuPopup, , X, Y + 330
        End If
    End If
End Sub

Public Sub PropertyMenuActions(PrvlID As Integer)
On Local Error GoTo Err_Exit
Dim lngObjectID As Long, strCommand As String, lngRow As Long
Dim sSql As String
    If PrvlID = 0 Then
        LoadConsoleRoot ConsoleRoot
        Exit Sub
    End If
    lngObjectID = Val(PickValue("ObjectPrivileges", "ObjectID", "PrvlID = " & PrvlID))
    strCommand = PickValue("ObjectPrivileges", "Command", "PrvlID = " & PrvlID)  'mnuPopupConsoleRoot(PrvlID).Tag
    If vsfgMain.Row > 0 Then lngRow = vsfgMain.Row
    '-------------------------------------------
    With vsfgMain
        Select Case lngObjectID
            Case cnstObjectCompany
                Select Case Trim(UCase(strCommand))
                    Case "ACTIVATE"
                        ActivateCompanyOrPeriod .ValueMatrix(lngRow, grdCompanyID)
                    Case "OPEN"
                        ShowFormInMDI "frmCompany", "Company", .ValueMatrix(lngRow, grdCompanyID)
                        GetActiveFormObject("frmCompany").CompanyMode = cnstCompanyModeModify
                    Case "CLOSE"
                        CloseCompanyFromConsoleRoot .ValueMatrix(lngRow, grdCompanyID)
                End Select
            Case cnstObjectPeriod
                Select Case Trim(UCase(strCommand))
                    Case "ACTIVATE"
                        ActivateCompanyOrPeriod .ValueMatrix(lngRow, grdCompanyID), .ValueMatrix(lngRow, grdPeriodID)
                    Case "OPEN"
                        ShowFormInMDI "frmPeriods", "Periods", .ValueMatrix(lngRow, grdCompanyID)
                        GetActiveFormObject("frmPeriods").ShowOpen .ValueMatrix(lngRow, grdPeriodID)
                    Case "NEW"
                        ShowFormInMDI "frmPeriods", "Periods", .ValueMatrix(lngRow, grdCompanyID)
                        ButtonHandling GetActiveFormObject("frmPeriods"), "New"
                    Case "MODIFY"
                        ShowFormInMDI "frmPeriods", "Periods", .ValueMatrix(lngRow, grdCompanyID)
                        GetActiveFormObject("frmPeriods").ShowOpen .ValueMatrix(lngRow, grdPeriodID)
                        ButtonHandling GetActiveFormObject("frmPeriods"), "Modify"
                    Case "CLOSE"
                        ClosePeriodFromConsoleRoot .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectAccountTypes
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmAcTypes", "Account Types", .ValueMatrix(lngRow, grdCompanyID)
                    Case "NEW"
                        ShowFormInMDI "frmAcTypes", "Account Types", .ValueMatrix(lngRow, grdCompanyID)
                        ButtonHandling GetActiveFormObject("frmAcTypes"), "New"
                End Select
            Case cnstObjectAccountHeads
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmAcHeads", "Account Heads", .ValueMatrix(lngRow, grdCompanyID)
                    Case "NEW"
                        ShowFormInMDI "frmAcHeads", "Account Types", .ValueMatrix(lngRow, grdCompanyID)
                        ButtonHandling GetActiveFormObject("frmAcHeads"), "New"
                End Select
            Case cnstObjectBIN
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        frmDocumentCollect.Show
                End Select
            Case cnstObjectTrialBalance
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmTrialBalance", "Trial Balance", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectDataSheet
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmDatasheet", "Data Sheet", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectJournal
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowJournal .ValueMatrix(lngRow, grdPeriodID)
                    Case "NEW"
                        ShowJournal .ValueMatrix(lngRow, grdPeriodID)
                        ButtonHandling GetActiveFormObject("frmJournalEntry"), "New"
                End Select
            Case cnstObjectAccountLedger
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowLedger .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectGeneralSchedule
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmGeneralSchedule", "General Schedule", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectSplitSchedule
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmSplitSchedule", "Split Schedule", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectFixedAssetSchedule
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmFixedAssetSchedule", "Fixed Asset Schedule", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectShareHoldersEquity
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmEquitySchedule", "Equity Schedule", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectCashEquivalents
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmCashAndCashEquivalents", "Cash && Cash Equivalents", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
'            Case cnstObjectContingentLiability
'                Select Case Trim(UCase(strCommand))
'                    Case "OPEN"
'                        ShowFormInMDI "frmLiabilitySchedule", "Contingent Liability Schedule", , .ValueMatrix(lngRow, grdPeriodID)
'                End Select
            Case cnstObjectCashFlow
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmCashFlow", "Cash Flow", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectNoteNoCaption
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmNoteNoAndCaption", "Note No. && Caption", , .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectCollectDocuments
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmDocumentCollect", "Collect Documents(BIN)", .ValueMatrix(lngRow, grdCompanyID)
                End Select
            Case cnstObjectCollectMultipleDocuments
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmCollectMultipleDocs", "Collect Multiple Documents(BIN)", .ValueMatrix(lngRow, grdCompanyID)
                End Select
            Case cnstObjectDocumentAttachment
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmAttachedDocumentsDetails", "Attached Documents", .ValueMatrix(lngRow, grdCompanyID), .ValueMatrix(lngRow, grdPeriodID)
                End Select
            'Ref No : 021-10/06/08, 11th June 2008, Wednesday ---------------
            Case cnstObjectReportRptGenerator
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                       ShowFormInMDI "frmReportGenerator", "Report Generator", , pActivePeriodID
                       GetActiveFormObject ("frmReportGenerator")
                End Select
            Case cnstObjectReportTBDetail
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportTBDetail, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportBalanceSheet
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportBalanceSheet, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportProfitAndLoss
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportProfitAndLoss, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportSchedules
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportSchedules, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportFixedAsset
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportFixedAsset, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportEquity
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportEquity, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportJournal
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportJournal, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportCashFlow
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportCashFlow, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportMattersArising
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportMattersArising, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportReviews
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReports cnstObjectReportReviews, .ValueMatrix(lngRow, grdPeriodID)
                End Select
            Case cnstObjectReportAuditReport
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        PrintReportGenerate pvtPreview, pActiveCompanyID, pActivePeriodID
                End Select
            Case cnstObjectReviews
                Select Case Trim(UCase(strCommand))
                    Case "OPEN"
                        ShowFormInMDI "frmRelatedReviews", "Related Reviews", .ValueMatrix(lngRow, grdCompanyID), .ValueMatrix(lngRow, grdPeriodID)
                End Select
        End Select
    End With
Exit Sub
Err_Exit:

End Sub

Public Sub MakeActiveFormsReadOnly()
On Local Error Resume Next
Dim frm As Form
    For Each frm In Forms
        If frm.Name <> "MDIFormMain" Then
            ButtonsReadOnlyHandling frm
        End If
    Next
End Sub

Private Sub PrintReports(ObjectID As Long, PeriodID As Long)
Dim crptPrint As New clsReports, lngCurrentY As Long, lngReportID As Long
Dim Inc As Long, sSql As String, lngPropertyID As Long
Dim VP As VSPrinter8LibCtl.VSPrinter
On Local Error GoTo Err_Exit
    Screen.MousePointer = vbHourglass
'    lngCurrentY = -1
    lngPropertyID = GetActualID(pActiveCompanyID, cnstAcTypePropertyPlantEquipment)
    Select Case ObjectID
        Case cnstObjectReportTBDetail
            PrintTBReport PeriodID, True
        Case cnstObjectReportBalanceSheet
            PrintBalanceSheet PeriodID, True
        Case cnstObjectReportProfitAndLoss
            PrintProfitLoss PeriodID, True
        Case cnstObjectReportSchedules
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
        Case cnstObjectReportFixedAsset
            crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 1, pActivePeriodID
            PrintFixedAssetSchedules pActivePeriodID, True, crptPrint
            crptPrint.EndReport
            crptPrint.Clear
            Set crptPrint = Nothing
        Case cnstObjectReportEquity
            crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 1, pActivePeriodID
            PrintShareholdersEquity pActivePeriodID, True, crptPrint
            crptPrint.EndReport
            crptPrint.Clear
            Set crptPrint = Nothing
        Case cnstObjectReportJournal
            PrintJournal PeriodID, True
        Case cnstObjectReportCashFlow
            PrintCashFlow PeriodID, True
        Case cnstObjectReportAuditReport
            lngReportID = Val(PickValue("Reports", "ReportID", "PeriodID = " & PeriodID))
            LoadReports lngReportID, frmPreview.vpPreview
            frmPreview.Show
            frmPreview.ZOrder vbBringToFront
        Case cnstObjectReportReviews
            PrintReviewReport PeriodID, True
        Case cnstObjectReportMattersArising
            PrintMattersArsingReport PeriodID, True
    End Select
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub PrintAllSchedules(lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, strNoteNo As String
Dim crptPrint As New clsReports, lngCurrentY As Long
    Screen.MousePointer = vbHourglass
    sSql = "SELECT    DISTINCT CONVERT(int, NoteNo) AS NoteNo From Schedules Where PeriodID = " & lngPeriodID & " And NoteNo <> 0 " & _
           "ORDER BY  CONVERT(int, NoteNo)"
        With GetRecords(sSql)
            crptPrint.StartReport pprA4, 1440, 1440, 1440, 1440, 0, lngPeriodID
            While Not .EOF
                strNoteNo = .Fields("NoteNo") & ""
                If lngCurrentY > 10000 Or lngCurrentY = -1 Then
                    crptPrint.CreatePageBreak , , , , , , orPortrait
                    lngCurrentY = 0
                End If
                PrintSchedules strNoteNo, lngPeriodID, True, crptPrint, lngCurrentY
            .MoveNext
            Wend
            .Close
            crptPrint.EndReport
            crptPrint.Clear
            Set crptPrint = Nothing
        End With
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    ShowError
End Sub
