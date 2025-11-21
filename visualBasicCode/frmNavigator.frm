VERSION 5.00
Object = "{54850C51-14EA-4470-A5E4-8C5DB32DC853}#1.0#0"; "vsprint8.ocx"
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{96548BD2-D0BF-46B1-B519-8F2268D49306}#1.0#0"; "vsvport8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmNavigator 
   BackColor       =   &H00400000&
   Caption         =   "Audit File"
   ClientHeight    =   9045
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13155
   ControlBox      =   0   'False
   FillColor       =   &H00ECFFFF&
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00ECFFFF&
   Icon            =   "frmNavigator.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9045
   ScaleWidth      =   13155
   WindowState     =   2  'Maximized
   Begin VB.Frame frameAuditReport 
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0FFFF&
      Height          =   7680
      Left            =   345
      TabIndex        =   0
      Top             =   390
      Visible         =   0   'False
      Width           =   11055
      Begin VB.CheckBox cbReview 
         BackColor       =   &H80000005&
         Caption         =   "Reviewed"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   200
         Left            =   9600
         TabIndex        =   60
         Top             =   120
         Width           =   1290
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgReporting 
         Height          =   375
         Index           =   0
         Left            =   6000
         TabIndex        =   32
         Top             =   1080
         Visible         =   0   'False
         Width           =   3015
         _cx             =   5318
         _cy             =   661
         Appearance      =   2
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
         Cols            =   5
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   330
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
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
      End
      Begin VB.Frame frameReporting 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   615
         Left            =   1440
         TabIndex        =   30
         Top             =   840
         Visible         =   0   'False
         Width           =   5415
         Begin MSComctlLib.TabStrip tbstripFinancialStatements 
            Height          =   405
            Left            =   90
            TabIndex        =   31
            Top             =   120
            Visible         =   0   'False
            Width           =   6120
            _ExtentX        =   10795
            _ExtentY        =   714
            _Version        =   393216
            BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
               NumTabs         =   4
               BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Balance Sheet"
                  Object.Tag             =   "0"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Income Statement"
                  Object.Tag             =   "1"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Liquidity"
                  Object.Tag             =   "2"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Profitability"
                  Object.Tag             =   "3"
                  ImageVarType    =   2
               EndProperty
            EndProperty
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Cambria"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin VB.Frame frameDetails 
         BackColor       =   &H00FFC0C0&
         BorderStyle     =   0  'None
         Caption         =   "Frame1"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   6495
         Left            =   135
         TabIndex        =   3
         Top             =   1545
         Width           =   8775
         Begin VB.Frame frameResources 
            Caption         =   "Resources"
            Height          =   615
            Left            =   2040
            TabIndex        =   65
            Top             =   3720
            Visible         =   0   'False
            Width           =   2085
         End
         Begin VB.Frame frameGeneralReviews 
            Caption         =   "General Reviews"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   1335
            Left            =   5280
            TabIndex        =   61
            Top             =   3840
            Visible         =   0   'False
            Width           =   2415
            Begin VB.TextBox txtGenRevReply 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   360
               MultiLine       =   -1  'True
               ScrollBars      =   2  'Vertical
               TabIndex        =   63
               Top             =   840
               Visible         =   0   'False
               Width           =   1695
            End
            Begin VB.TextBox txtGenReview 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   375
               Left            =   360
               MultiLine       =   -1  'True
               ScrollBars      =   2  'Vertical
               TabIndex        =   62
               Top             =   360
               Visible         =   0   'False
               Width           =   1695
            End
         End
         Begin MSComctlLib.TabStrip tbStripAuditReport 
            Height          =   2835
            Left            =   1320
            TabIndex        =   10
            Top             =   2640
            Width           =   7350
            _ExtentX        =   12965
            _ExtentY        =   5001
            MultiRow        =   -1  'True
            TabMinWidth     =   1323
            _Version        =   393216
            BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
               NumTabs         =   5
               BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Leadsheets"
                  Object.Tag             =   "0"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Matters Arising"
                  Object.Tag             =   "1"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Procedures"
                  Object.Tag             =   "2"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab4 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Reviews"
                  Object.Tag             =   "3"
                  ImageVarType    =   2
               EndProperty
               BeginProperty Tab5 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                  Caption         =   "Resources"
                  Object.Tag             =   "4"
                  ImageVarType    =   2
               EndProperty
            EndProperty
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Cambria"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.TextBox txtRemarks 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Index           =   0
            Left            =   50
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   33
            Top             =   0
            Width           =   1815
         End
         Begin VSViewPort8LibCtl.VSViewPort vsportAuditReport 
            Height          =   4245
            Left            =   120
            TabIndex        =   4
            Top             =   2160
            Width           =   4995
            _cx             =   8811
            _cy             =   7488
            Appearance      =   0
            BorderStyle     =   1
            Enabled         =   -1  'True
            MousePointer    =   0
            BackColor       =   -2147483633
            AutoScroll      =   -1  'True
            VirtualWidth    =   1000
            VirtualHeight   =   5000
            LargeChangeHorz =   300
            LargeChangeVert =   300
            SmallChangeHorz =   30
            SmallChangeVert =   30
            Track           =   0   'False
            MouseScroll     =   -1  'True
            ProportionalBars=   -1  'True
            FocusTrack      =   -1  'True
            FocusMarginLeft =   0
            FocusMarginTop  =   0
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   9
            Begin VB.Frame frameLegalDocs 
               Caption         =   "Frame1"
               Height          =   975
               Left            =   2160
               TabIndex        =   64
               Top             =   1440
               Visible         =   0   'False
               Width           =   1695
            End
            Begin VSFlex8Ctl.VSFlexGrid vsfgPortGridParent 
               Height          =   495
               Index           =   0
               Left            =   45
               TabIndex        =   5
               Top             =   1305
               Visible         =   0   'False
               Width           =   4290
               _cx             =   7567
               _cy             =   873
               Appearance      =   2
               BorderStyle     =   1
               Enabled         =   -1  'True
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Times New Roman"
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
               AllowBigSelection=   0   'False
               AllowUserResizing=   1
               SelectionMode   =   0
               GridLines       =   1
               GridLinesFixed  =   2
               GridLineWidth   =   1
               Rows            =   1
               Cols            =   3
               FixedRows       =   1
               FixedCols       =   0
               RowHeightMin    =   330
               RowHeightMax    =   0
               ColWidthMin     =   0
               ColWidthMax     =   0
               ExtendLastCol   =   -1  'True
               FormatString    =   $"frmNavigator.frx":1CCA
               ScrollTrack     =   0   'False
               ScrollBars      =   2
               ScrollTips      =   0   'False
               MergeCells      =   0
               MergeCompare    =   0
               AutoResize      =   -1  'True
               AutoSizeMode    =   1
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
               TabBehavior     =   1
               OwnerDraw       =   0
               Editable        =   2
               ShowComboButton =   1
               WordWrap        =   -1  'True
               TextStyle       =   0
               TextStyleFixed  =   0
               OleDragMode     =   0
               OleDropMode     =   0
               DataMode        =   0
               VirtualData     =   -1  'True
               DataMember      =   ""
               ComboSearch     =   3
               AutoSizeMouse   =   0   'False
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
            Begin VB.TextBox txtPortTextParent 
               Appearance      =   0  'Flat
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   300
               Index           =   0
               Left            =   285
               MultiLine       =   -1  'True
               ScrollBars      =   2  'Vertical
               TabIndex        =   6
               Text            =   "frmNavigator.frx":1D1C
               Top             =   255
               Visible         =   0   'False
               Width           =   2160
            End
            Begin VB.Label lblPortLabelParent 
               BackStyle       =   0  'Transparent
               Caption         =   "lblPortLabelParent"
               BeginProperty Font 
                  Name            =   "Times New Roman"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Index           =   0
               Left            =   300
               TabIndex        =   7
               Top             =   765
               Visible         =   0   'False
               Width           =   2085
               WordWrap        =   -1  'True
            End
         End
         Begin VSFlex8Ctl.VSFlexGrid vsfgAuditReport 
            Height          =   1725
            Index           =   0
            Left            =   120
            TabIndex        =   14
            Top             =   525
            Width           =   8505
            _cx             =   15002
            _cy             =   3043
            Appearance      =   0
            BorderStyle     =   0
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Times New Roman"
               Size            =   11.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MousePointer    =   0
            BackColor       =   -2147483643
            ForeColor       =   -2147483640
            BackColorFixed  =   -2147483643
            ForeColorFixed  =   -2147483630
            BackColorSel    =   -2147483635
            ForeColorSel    =   -2147483634
            BackColorBkg    =   -2147483636
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483632
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   0
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
            Cols            =   5
            FixedRows       =   1
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   $"frmNavigator.frx":1D2E
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
            OutlineBar      =   4
            OutlineCol      =   1
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
            BackColorFrozen =   12648447
            ForeColorFrozen =   0
            WallPaperAlignment=   9
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   24
         End
         Begin VSPrinter8LibCtl.VSPrinter vsprintBalanceSheet 
            Height          =   8880
            Left            =   -180
            TabIndex        =   29
            Top             =   -240
            Visible         =   0   'False
            Width           =   11880
            _cx             =   20955
            _cy             =   15663
            Appearance      =   1
            BorderStyle     =   1
            Enabled         =   -1  'True
            MousePointer    =   0
            BackColor       =   -2147483643
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   11.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BeginProperty HdrFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Courier New"
               Size            =   14.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            AutoRTF         =   -1  'True
            Preview         =   -1  'True
            DefaultDevice   =   0   'False
            PhysicalPage    =   -1  'True
            AbortWindow     =   -1  'True
            AbortWindowPos  =   0
            AbortCaption    =   "Printing..."
            AbortTextButton =   "Cancel"
            AbortTextDevice =   "on the %s on %s"
            AbortTextPage   =   "Now printing Page %d of"
            FileName        =   ""
            MarginLeft      =   1440
            MarginTop       =   1440
            MarginRight     =   1440
            MarginBottom    =   1440
            MarginHeader    =   0
            MarginFooter    =   0
            IndentLeft      =   0
            IndentRight     =   0
            IndentFirst     =   0
            IndentTab       =   720
            SpaceBefore     =   0
            SpaceAfter      =   0
            LineSpacing     =   100
            Columns         =   1
            ColumnSpacing   =   180
            ShowGuides      =   2
            LargeChangeHorz =   300
            LargeChangeVert =   300
            SmallChangeHorz =   30
            SmallChangeVert =   30
            Track           =   0   'False
            ProportionalBars=   -1  'True
            Zoom            =   50.9469696969697
            ZoomMode        =   3
            ZoomMax         =   400
            ZoomMin         =   10
            ZoomStep        =   25
            EmptyColor      =   -2147483636
            TextColor       =   0
            HdrColor        =   0
            BrushColor      =   0
            BrushStyle      =   0
            PenColor        =   0
            PenStyle        =   0
            PenWidth        =   0
            PageBorder      =   0
            Header          =   ""
            Footer          =   ""
            TableSep        =   "|;"
            TableBorder     =   7
            TablePen        =   0
            TablePenLR      =   0
            TablePenTB      =   0
            NavBar          =   3
            NavBarColor     =   -2147483633
            ExportFormat    =   0
            URL             =   ""
            Navigation      =   3
            NavBarMenuText  =   "Whole &Page|Page &Width|&Two Pages|Thumb&nail"
            AutoLinkNavigate=   0   'False
            AccessibleName  =   ""
            AccessibleDescription=   ""
            AccessibleValue =   ""
            AccessibleRole  =   9
         End
         Begin VB.Frame frameLeadsheet 
            Caption         =   "Leadsheet"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C0FFFF&
            Height          =   2805
            Left            =   1440
            TabIndex        =   13
            Top             =   2895
            Width           =   3345
         End
         Begin VB.Frame frameProcedures 
            Caption         =   "Procedures"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2220
            Left            =   4980
            TabIndex        =   11
            Top             =   2805
            Visible         =   0   'False
            Width           =   3705
            Begin MSComctlLib.TabStrip tbStripProcedures 
               Height          =   1860
               Left            =   150
               TabIndex        =   12
               Top             =   255
               Visible         =   0   'False
               Width           =   3495
               _ExtentX        =   6165
               _ExtentY        =   3281
               _Version        =   393216
               BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
                  NumTabs         =   2
                  BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                     Caption         =   "Risk Analysis"
                     Object.Tag             =   "1"
                     ImageVarType    =   2
                  EndProperty
                  BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
                     Caption         =   "Audit Procedure"
                     Object.Tag             =   "2"
                     ImageVarType    =   2
                  EndProperty
               EndProperty
            End
         End
         Begin VB.Frame frameReviews 
            Caption         =   "Reviews"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   2130
            Left            =   6510
            TabIndex        =   9
            Top             =   3645
            Visible         =   0   'False
            Width           =   2085
         End
         Begin VB.Frame frameRemarks 
            Caption         =   "Remarks"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   450
            Left            =   6585
            TabIndex        =   8
            Top             =   3105
            Visible         =   0   'False
            Width           =   1380
         End
      End
      Begin MSComctlLib.ImageList imglstSections 
         Left            =   240
         Top             =   7020
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   32
         ImageHeight     =   32
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   9
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":1DA5
               Key             =   "a1000"
               Object.Tag             =   "1000"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":2A1B
               Key             =   "a2000"
               Object.Tag             =   "2000"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":35BA
               Key             =   "a3000"
               Object.Tag             =   "3000"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":4472
               Key             =   "a4000"
               Object.Tag             =   "4000"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":57EC
               Key             =   "a5000"
               Object.Tag             =   "5000"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":66DC
               Key             =   "a6000"
               Object.Tag             =   "6000"
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":6DB4
               Key             =   "a7000"
               Object.Tag             =   "7000"
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":7D9F
               Key             =   "a8000"
               Object.Tag             =   "8000"
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":8C79
               Key             =   "a9000"
               Object.Tag             =   "9000"
            EndProperty
         EndProperty
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgSubSections 
         Height          =   1065
         Left            =   15
         TabIndex        =   2
         Top             =   -30
         Width           =   8850
         _cx             =   15610
         _cy             =   1879
         Appearance      =   2
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MousePointer    =   0
         BackColor       =   15532031
         ForeColor       =   0
         BackColorFixed  =   15532031
         ForeColorFixed  =   12648447
         BackColorSel    =   8388608
         ForeColorSel    =   -2147483634
         BackColorBkg    =   15532031
         BackColorAlternate=   16777215
         GridColor       =   0
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   12648447
         SheetBorder     =   -2147483642
         FocusRect       =   4
         HighLight       =   2
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   8
         GridLinesFixed  =   2
         GridLineWidth   =   5
         Rows            =   2
         Cols            =   0
         FixedRows       =   0
         FixedCols       =   0
         RowHeightMin    =   1000
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"frmNavigator.frx":9204
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
         PicturesOver    =   -1  'True
         FillStyle       =   0
         RightToLeft     =   0   'False
         PictureType     =   0
         TabBehavior     =   0
         OwnerDraw       =   0
         Editable        =   0
         ShowComboButton =   1
         WordWrap        =   -1  'True
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
         ForeColorFrozen =   12648447
         WallPaperAlignment=   10
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgSections 
         Height          =   8715
         Left            =   9000
         TabIndex        =   1
         Top             =   600
         Width           =   2130
         _cx             =   3757
         _cy             =   15372
         Appearance      =   3
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Cambria"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MousePointer    =   0
         BackColor       =   8388608
         ForeColor       =   12648447
         BackColorFixed  =   -2147483633
         ForeColorFixed  =   12648447
         BackColorSel    =   8388608
         ForeColorSel    =   12648447
         BackColorBkg    =   -2147483636
         BackColorAlternate=   8388608
         GridColor       =   -2147483639
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   4
         HighLight       =   2
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   4
         GridLinesFixed  =   2
         GridLineWidth   =   5
         Rows            =   11
         Cols            =   2
         FixedRows       =   0
         FixedCols       =   0
         RowHeightMin    =   800
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmNavigator.frx":9280
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
         WordWrap        =   -1  'True
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
         ForeColorFrozen =   12648447
         WallPaperAlignment=   9
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
      End
   End
   Begin MSAdodcLib.Adodc AdodcGrid 
      Height          =   495
      Left            =   1440
      Top             =   8400
      Visible         =   0   'False
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   873
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   8
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   ""
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   "sa"
      Password        =   "HamthLb99@86367"
      RecordSource    =   ""
      Caption         =   "Adodc1"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin MSComctlLib.ImageList imgLstCmpInfo 
      Left            =   240
      Top             =   8280
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   832
      ImageHeight     =   656
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":9344
            Key             =   "832 X 656"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":1BCCE
            Key             =   "SubSection"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":218EC
            Key             =   "1024 X 768"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":38858
            Key             =   "1200 X 810"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":4B2E4
            Key             =   "1280 X 800"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":650D6
            Key             =   "1024 X 900"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":7F364
            Key             =   "1366 X 768"
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox picCompanyInfo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   8055
      Left            =   960
      ScaleHeight     =   8025
      ScaleWidth      =   11025
      TabIndex        =   34
      Top             =   720
      Visible         =   0   'False
      Width           =   11055
      Begin AIFCmp1.asxPowerBanner lineCompany1 
         Height          =   30
         Left            =   120
         Top             =   1560
         Width           =   8775
         _ExtentX        =   15478
         _ExtentY        =   53
         StartColor      =   0
         EndColor        =   -2147483624
         FormatString    =   ""
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
      End
      Begin AIFCmp1.asxPowerBanner lineCompany2 
         Height          =   30
         Left            =   120
         Top             =   2400
         Width           =   8775
         _ExtentX        =   15478
         _ExtentY        =   53
         StartColor      =   0
         EndColor        =   -2147483624
         FormatString    =   ""
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
      End
      Begin VB.Label lblCmpPeriodAuditor 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Auditor"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   59
         Top             =   4800
         Visible         =   0   'False
         Width           =   1560
      End
      Begin VB.Label lblCmpPeriodAuditAssist 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Audit Assistant"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   58
         Top             =   5040
         Visible         =   0   'False
         Width           =   2310
      End
      Begin VB.Label lblCmpPeriodDataEntry 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Data Entry"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   57
         Top             =   5280
         Visible         =   0   'False
         Width           =   1845
      End
      Begin VB.Label lblCmpPeriodStatus 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Period Status"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   56
         Top             =   3120
         Visible         =   0   'False
         Width           =   2400
      End
      Begin VB.Label lblCmpPeriodStartDt 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Start Date"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   55
         Top             =   3360
         Visible         =   0   'False
         Width           =   1770
      End
      Begin VB.Label lblCmpPeriodEndDt 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period End Date"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   54
         Top             =   3600
         Visible         =   0   'False
         Width           =   1680
      End
      Begin VB.Label lblCmpPeriodDerivedFrom 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Derived From"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   53
         Top             =   3840
         Visible         =   0   'False
         Width           =   2190
      End
      Begin VB.Label lblCmpPeriodComparedWith 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Compared With"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   52
         Top             =   4080
         Visible         =   0   'False
         Width           =   2370
      End
      Begin VB.Label lblCmpPeriodPartner 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Partner"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   51
         Top             =   4320
         Visible         =   0   'False
         Width           =   1545
      End
      Begin VB.Label lblCmpPeriodManager 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Period Manager"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   50
         Top             =   4560
         Visible         =   0   'False
         Width           =   1665
      End
      Begin VB.Label lblCmpPeriodAuditType 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Audit Type"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   49
         Top             =   2880
         Visible         =   0   'False
         Width           =   2160
      End
      Begin VB.Label lblCmpPeriodDesc 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Period"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   290
         Index           =   0
         Left            =   240
         TabIndex        =   48
         Top             =   2640
         Visible         =   0   'False
         Width           =   1725
      End
      Begin VB.Line lineCompanyVert1 
         X1              =   5040
         X2              =   5040
         Y1              =   5040
         Y2              =   7320
      End
      Begin VB.Line lineCompany4 
         DrawMode        =   6  'Mask Pen Not
         X1              =   0
         X2              =   8760
         Y1              =   5880
         Y2              =   5880
      End
      Begin VB.Label lblCmpContactEmail 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Contact Email"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   47
         Top             =   2160
         Width           =   2445
      End
      Begin VB.Label lblCmpContactDesig 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Contact Desig"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   46
         Top             =   2160
         Width           =   2430
      End
      Begin VB.Label lblCmpContactMob 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Contact Mob"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   45
         Top             =   1800
         Width           =   2310
      End
      Begin VB.Label lblCmpContactName 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Contact Name"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   44
         Top             =   1800
         Width           =   2430
      End
      Begin VB.Label lblCmpStatus 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Status"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   43
         Top             =   1320
         Width           =   1650
      End
      Begin VB.Label lblCmpCurrency 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Currency"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   42
         Top             =   1320
         Width           =   1980
      End
      Begin VB.Label lblCmpPhone 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Phone"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   41
         Top             =   480
         Width           =   1680
      End
      Begin VB.Label lblCmpFax 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Fax"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   40
         Top             =   720
         Width           =   1380
      End
      Begin VB.Label lblCmpEmail 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Email"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   4920
         TabIndex        =   39
         Top             =   960
         Width           =   1620
      End
      Begin VB.Label lblCmpAddress3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Address 3"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   38
         Top             =   960
         Width           =   2055
      End
      Begin VB.Label lblCmpAddress2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Address 2"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   37
         Top             =   720
         Width           =   2055
      End
      Begin VB.Label lblCmpAddress1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Address 1"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   270
         Left            =   240
         TabIndex        =   36
         Top             =   480
         Width           =   2055
      End
      Begin VB.Label lblCompanyName 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Name"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   15
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0FFFF&
         Height          =   360
         Left            =   240
         TabIndex        =   35
         Top             =   120
         Width           =   2160
      End
      Begin VB.Line lineCompany3 
         DrawMode        =   6  'Mask Pen Not
         X1              =   0
         X2              =   8760
         Y1              =   5040
         Y2              =   5040
      End
   End
   Begin MSComDlg.CommonDialog CD 
      Left            =   120
      Top             =   7320
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.ImageList imglstIcons 
      Left            =   285
      Top             =   4605
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":99156
            Key             =   "AccountHeads"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNavigator.frx":995A8
            Key             =   "AccountTypes"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Height          =   375
      Left            =   0
      TabIndex        =   17
      Top             =   30
      Visible         =   0   'False
      Width           =   4665
      _ExtentX        =   8229
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   4
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "No. of Documents"
            TextSave        =   "No. of Documents"
            Key             =   "DocTotal"
            Object.ToolTipText     =   "Number of Documents"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "Undefined"
            TextSave        =   "Undefined"
            Key             =   "Undefined"
            Object.ToolTipText     =   "Undefined"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Text            =   "Defined Documents :"
            TextSave        =   "Defined Documents :"
            Key             =   "Defined"
            Object.ToolTipText     =   "Defined"
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin VB.Frame frameGrid 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6600
      Left            =   -90
      TabIndex        =   18
      Top             =   165
      Visible         =   0   'False
      Width           =   12120
      Begin MSComctlLib.Toolbar tbrBin 
         Height          =   330
         Left            =   9720
         TabIndex        =   26
         Top             =   960
         Width           =   5805
         _ExtentX        =   10239
         _ExtentY        =   582
         ButtonWidth     =   2170
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
               Style           =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "New"
               Key             =   "New"
               Object.ToolTipText     =   "New"
               ImageKey        =   "New"
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Mark"
               Key             =   "Read"
               Object.ToolTipText     =   "Read / UnRead"
               ImageKey        =   "Read"
               Style           =   1
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "All"
               Key             =   "All"
               Object.ToolTipText     =   "All Documents"
               ImageKey        =   "All"
            EndProperty
            BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Defined"
               Key             =   "Defined"
               Object.ToolTipText     =   "Defined Documents only"
               ImageKey        =   "DefinedDoc"
            EndProperty
            BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Undefined"
               Key             =   "Undefined"
               Object.ToolTipText     =   "Undefined Documents only"
               ImageKey        =   "UnDefined"
            EndProperty
         EndProperty
      End
      Begin VB.CommandButton fndGridGeneral 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   7305
         Picture         =   "frmNavigator.frx":999FA
         Style           =   1  'Graphical
         TabIndex        =   23
         ToolTipText     =   "Search"
         Top             =   180
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.TextBox txtGridGeneral 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   5220
         TabIndex        =   22
         Text            =   "Text1"
         Top             =   180
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.ComboBox cmbGridGeneral 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   8385
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   195
         Visible         =   0   'False
         Width           =   2000
      End
      Begin VB.CommandButton cmdGridClear 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   7815
         MouseIcon       =   "frmNavigator.frx":99B84
         TabIndex        =   20
         ToolTipText     =   "Clear"
         Top             =   195
         Visible         =   0   'False
         Width           =   330
      End
      Begin MSComctlLib.StatusBar sbrGrid 
         Height          =   375
         Left            =   2580
         TabIndex        =   19
         Top             =   6135
         Visible         =   0   'False
         Width           =   6375
         _ExtentX        =   11245
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
            NumPanels       =   3
            BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Object.Width           =   3528
               MinWidth        =   3528
               Text            =   "No. of Documents"
               TextSave        =   "No. of Documents"
               Key             =   "DocTotal"
               Object.ToolTipText     =   "Number of Documents"
            EndProperty
            BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Object.Width           =   6174
               MinWidth        =   6174
               Text            =   "CheckOut User :"
               TextSave        =   "CheckOut User :"
               Key             =   "CheckOutUser"
            EndProperty
            BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Object.Width           =   6174
               MinWidth        =   6174
               Text            =   "CheckOut Date :"
               TextSave        =   "CheckOut Date :"
               Key             =   "CheckOutDate"
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.Toolbar tbrCtrlsGridGeneral 
         Height          =   330
         Left            =   1950
         TabIndex        =   24
         Top             =   630
         Visible         =   0   'False
         Width           =   1320
         _ExtentX        =   2328
         _ExtentY        =   582
         ButtonWidth     =   1138
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Wrappable       =   0   'False
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "imglstCtrlsGridGeneral"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            EndProperty
         EndProperty
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgGeneral 
         Height          =   2625
         Left            =   135
         TabIndex        =   25
         Top             =   2190
         Width           =   11520
         _cx             =   20320
         _cy             =   4630
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
         Rows            =   2
         Cols            =   2
         FixedRows       =   1
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
         Begin MSComctlLib.ImageList imglstCtrls 
            Left            =   -30
            Top             =   315
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   16
            ImageHeight     =   16
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   20
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":99D4E
                  Key             =   "New"
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":99EA8
                  Key             =   "Open"
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A002
                  Key             =   "Modify"
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A15C
                  Key             =   "Delete"
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A336
                  Key             =   "Save"
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A490
                  Key             =   "Print"
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A66A
                  Key             =   "Notes"
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9A7C4
                  Key             =   "Status"
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9BCC6
                  Key             =   "Close"
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9BEA0
                  Key             =   "Copy"
               EndProperty
               BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9C07A
                  Key             =   "Help"
               EndProperty
               BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9C254
                  Key             =   "Notepad"
                  Object.Tag             =   "N"
               EndProperty
               BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9CC45
                  Key             =   "Read"
               EndProperty
               BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9D097
                  Key             =   "Defined"
               EndProperty
               BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9D3B1
                  Key             =   "UnDefined"
               EndProperty
               BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9D6CB
                  Key             =   "All"
               EndProperty
               BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9DB25
                  Key             =   "BookMark"
               EndProperty
               BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9E977
                  Key             =   "CheckOut"
               EndProperty
               BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9EC91
                  Key             =   "DefinedDoc"
               EndProperty
               BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "frmNavigator.frx":9EFAB
                  Key             =   "Restore"
               EndProperty
            EndProperty
         End
      End
      Begin MSComctlLib.ImageList imglstCtrlsGridGeneral 
         Left            =   150
         Top             =   1530
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   13
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A0C35
               Key             =   "New"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A0D8F
               Key             =   "Open"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A0EE9
               Key             =   "Modify"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A1043
               Key             =   "Delete"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A121D
               Key             =   "Save"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A1377
               Key             =   "Print"
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A1551
               Key             =   "Notes"
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A16AB
               Key             =   "Status"
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A2BAD
               Key             =   "Close"
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A2D87
               Key             =   "Copy"
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A2F61
               Key             =   "Help"
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A313B
               Key             =   "Read"
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frmNavigator.frx":A358D
               Key             =   "BookMark"
            EndProperty
         EndProperty
      End
      Begin VB.Label lblGridGeneral 
         AutoSize        =   -1  'True
         Caption         =   "Caption"
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
         Index           =   0
         Left            =   0
         TabIndex        =   27
         Top             =   1125
         Visible         =   0   'False
         Width           =   660
      End
   End
   Begin VB.Frame frameList 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3270
      Left            =   -15
      TabIndex        =   15
      Top             =   -30
      Visible         =   0   'False
      Width           =   11730
      Begin MSComctlLib.ListView lstViewGeneral 
         Height          =   3030
         Left            =   120
         TabIndex        =   16
         Top             =   180
         Width           =   11505
         _ExtentX        =   20294
         _ExtentY        =   5345
         View            =   3
         Sorted          =   -1  'True
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         FlatScrollBar   =   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         Icons           =   "imglstIcons"
         SmallIcons      =   "imglstIcons"
         ColHdrIcons     =   "imglstIcons"
         ForeColor       =   -2147483640
         BackColor       =   14737632
         BorderStyle     =   1
         Appearance      =   0
         NumItems        =   0
      End
   End
   Begin VB.Image imgWelcome 
      Height          =   2370
      Left            =   3700
      Picture         =   "frmNavigator.frx":A43DF
      Top             =   3000
      Width           =   6615
   End
   Begin VB.Label lblWelcome 
      AutoSize        =   -1  'True
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   15.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   360
      Left            =   2475
      TabIndex        =   28
      Top             =   2505
      Visible         =   0   'False
      Width           =   75
   End
End
Attribute VB_Name = "frmNavigator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mSenderPeriodID As Long
Dim mSubSectionID As Long
Dim mtbStripProcedures As Long
Dim mCompanyID As Long
Dim mtbStripFinance As Long
Dim IsTemplate As Boolean
Dim mblnIsReview As Boolean

Dim mObjectID As Long
Dim mlnGridRow As Long
Dim mlnGridDocID As Long
Dim mlnGridBookMark As Long
Dim mstrGridDocSearchType As String
Dim mstrGridCheckOutPath As String
Dim mstrCheckOutPath As String
Dim rsDoc As ADODB.Recordset
Dim mStream As ADODB.Stream

Const cnstSubSectionFinanceStatement = 6

Dim arrControls(2) As String, arrProperties(17) As String, IsInFillString As Boolean

Const cnstGridcmbShow = 0
Const cnstGridtxtCompanyID = 0
Const cnstGridtxtBrowse = 1
Const cnstGridtxtSearch = 1
Const cnstGridfndCompanyID = 0
Const cnstGridClear = 1
Const cnstGridfndGo = 1
Const cnstGridlblShow = 0
Const cnstGridlblCompany = 1
Const cnstGridlblSearch = 2

Const grdDocumentRowIcon = 0
Const grdDocumentRowDescription = 1
Const grdDocumentRowDocumentID = 2
Const grdDocumentRowFileName = 3
Const grdDocumentRowDocLinkID = 4
Const grdDocumentRows = 5

'Constants for Grid Formating
Const cnstGridBookMark = 0
Const cnstGridDocID = 1
Const cnstGridCode = 2
Const cnstGridDescription = 3
Const cnstGridIsCheckOut = 4
Const cnstGridIcon = 5
Const cnstGridFileName = 6
Const cnstGridFilePath = 7
Const cnstGridBrowse = 8
Const cnstGridCompany = 9
Const cnstGridCollectedDate = 10
Const cnstGridCollectedVia = 11
Const cnstGridIsRead = 13
Const cnstGridCheckOutUser = 14
Const cnstGridCheckOutDate = 15
Const cnstGridCheckInDate = 16
Const cnstGridCols = 17

Const cnstGridLeadSheet = 0
Const cnstGridProcedures = 1
Const cnstGridDocuments = 2
Const cnstGridReviews = 3
Const cnstGridRemarks = 4
Const cnstGridGeneralReviews = 5
Const cnstGridResources = 6
Const cnstGridLegalDocuments = 7

Const grdLeadSheetParticulars = 0
Const grdLeadSheetThisYear = 1
Const grdLeadSheetLastYear = 2
Const grdLeadSheetRemarks = 3
Const grdLeadSheetAttachments = 4
Const grdLeadSheetReviews = 5
Const grdLeadSheetReviewed = 6
Const grdLeadSheetAcTypeId = 7
Const grdLeadSheetAcID = 8
Const grdLeadSheetType = 9
Const grdLeadSheetReviewID = 10
Const grdLeadSheetCols = 11

Const grdProcedureSlNo = 0
Const grdProcedureQuestions = 1
Const grdProcedureAnswer = 2
Const grdProcedureFavourable = 3
Const grdProcedureID = 4
Const grdProcedureAnswers = 5
Const grdProcedureTemplate = 6
Const grdProcedureRemarks = 7
Const grdProcedureAttachments = 8
Const grdProcedureReviews = 9
Const grdProcedureIsCheckedOut = 10
Const grdProcedureType = 11
Const grdProcedureCols = 12

Const grdReviewSlNo = 0
Const grdReviews = 1
Const grdReviewedBy = 2
Const grdReviewReply = 3
Const grdReviewRepliedBy = 4
Const grdReviewRelatedAC = 5
Const grdReviewID = 6
Const grdReviewAccount = 7
Const grdReviewType = 8
Const grdReviewCols = 9

Const grdResourcesSlNo = 0
Const grdResourcesName = 1
Const grdResourcesFile = 2
Const grdResourcesID = 3
Const grdResourcesType = 4
Const grdResourceDocID = 5
Const grdResourcesCols = 6

Const grdRemarksSlNo = 0
Const grdRemarksObservations = 1
Const grdRemarksActions = 2
Const grdRemarksID = 3
Const grdRemarksType = 4
Const grdRemarksCols = 5

Const grdLegalDocSlNo = 0
Const grdLegalDocDescription = 1
Const grdLegalDocRemarks = 2
Const grdLegalDocAttachments = 3
Const grdLegalDocID = 4
Const grdLegalDocType = 5
Const grdLegalDocCols = 6

Const grdGenReviewSlNo = 0
Const grdGenReviews = 1
Const grdGenReviewedBy = 2
Const grdGenReviewReply = 3
Const grdGenReviewRepliedBy = 4
Const grdGenReviewID = 5
Const grdGenReviewType = 6
Const grdGenReviewCols = 7

Const tabLeadSheet = 0
Const tabRemarks = 1
Const tabProcedures = 2
Const tabReviews = 3
Const tabResources = 4

Const grdDocumentID = 0
Const grdDocumentName = 1
Const grdDocumentCols = 2

Const cnstgrdBalanceSheet = 0
Const cnstgrdProfitLoss = 1
Const cnstgrdLiquidity = 2
Const cnstgrdProfitability = 3

Const grdBalSheetParticulars = 0
Const grdBalSheetThisYr = 1
Const grdBalSheetLastYr = 2
Const grdBalSheetDiffPercent = 3
Const grdBalSheetDifference = 4
Const grdBalSheetRemarks = 5
Const grdBalSheetAcTypeID = 6
Const grdBalSheetCols = 7

Const grdPLParticulars = 0
Const grdPLThisYr = 1
Const grdPLLastYr = 2
Const grdPLDiffPercent = 3
Const grdPLDifference = 4
Const grdPLRemarks = 5
Const grdPLAcTypeID = 6
Const grdPLCols = 7

Const tabBalanceSheet = 0
Const tabProfitLoss = 1
Const tabLiquidity = 2
Const tabProfitability = 3

Const grdLiquidityRatio = 0
Const grdLiquidityThisYr = 1
Const grdLiquidityLastYr = 2
Const grdLiquidityRemarks = 3
Const grdLiquiditySlNo = 4
Const grdLiquidityCols = 5

Const grdProfitabilityRatio = 0
Const grdProfitabilityThisYr = 1
Const grdProfitabilityLastYr = 2
Const grdProfitabilityRemarks = 3
Const grdProfitabilitySlNo = 4
Const grdProfitabilityCols = 5

Dim mdblThisNetProfit As Double
Dim mdblLastNetProfit As Double

Dim mdblThisOperationProfit As Double
Dim mdblLastOperationProfit As Double

Const txtleadsheetRemarks = 0
Const txtProcedureRemarks = 1
Const txtBalSheetRemarks = 2
Const txtProfitLossRemarks = 3
Const txtLiquidityRemarks = 4
Const txtProfitabilityRemarks = 5

Const cnstCellSeparator As String = "¦"
Const cnstRowSeparator As String = " "

Dim mlngSectionMaxHeight As Long, mlngSectionTotalRows As Long
Dim mlngSectionActualHeight As Long

Public Sub ClearValues()
    vsfgAuditReport(cnstGridProcedures).Rows = 1: vsfgAuditReport(cnstGridProcedures).Rows = 2
End Sub

Public Sub ClearReviews()
    vsfgAuditReport(cnstGridReviews).Rows = 1: vsfgAuditReport(cnstGridReviews).Rows = 2
End Sub

Public Sub ClearResources()
    vsfgAuditReport(cnstGridResources).Rows = 1: vsfgAuditReport(cnstGridResources).Rows = 2
End Sub

Public Sub ClearRemarks()
Dim Inc As Long
    For Inc = 1 To vsfgAuditReport(cnstGridRemarks).Rows - 1
        vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksSlNo) = ""
        vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksObservations) = ""
        vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksActions) = ""
    Next Inc
End Sub

Private Sub FormatListObjects()
    frameList.Visible = True
    frameGrid.Visible = False
    frameAuditReport.Visible = False
    frameList.ZOrder vbBringToFront
    Anchor frameList, 50, , 15500, 10300
    Anchor lstViewGeneral, , , 15260, 10000
    lstViewGeneral.View = lvwReport
End Sub

Private Sub FormatDocBin()
On Local Error Resume Next
    frameList.Visible = False
    frameGrid.Visible = True
    frameAuditReport.Visible = False
    frameGrid.ZOrder vbBringToFront
    Anchor frameGrid, 50, 0, 15500, 10300
    Anchor vsfgGeneral, , 800, 15260, 8800
    Load lblGridGeneral(cnstGridlblCompany)
    txtGridGeneral(cnstGridtxtCompanyID).Visible = True
    txtGridGeneral(cnstGridtxtCompanyID).Locked = False
    txtGridGeneral(cnstGridtxtCompanyID).Text = ""
    Load txtGridGeneral(cnstGridBrowse)
    Anchor txtGridGeneral(cnstGridtxtCompanyID), 9000, 200, 3000
    fndGridGeneral(cnstGridfndCompanyID).Visible = True
    Anchor fndGridGeneral(cnstGridfndCompanyID), 12000, 200
    cmdGridClear.Visible = True
    Anchor cmdGridClear, 12500, 200
    tbrBin.Visible = True
    Anchor tbrBin, 135, 180, 8000, 330
    sbrGrid.Visible = True
    Anchor sbrGrid, 135, 9800, 11000, 330
    vsfgGeneral.Cols = cnstGridCols
    vsfgGeneral.Rows = 1
    vsfgGeneral.Editable = flexEDNone
    vsfgGeneral.AllowBigSelection = True
    vsfgGeneral.AllowSelection = True
    vsfgGeneral.BorderStyle = flexBorderNone
    vsfgGeneral.GridLines = flexGridNone
    vsfgGeneral.SelectionMode = flexSelectionByRow

    FormatGrid

    txtGridGeneral(cnstGridtxtCompanyID).Tag = GetIniString("CompanyId")
    txtGridGeneral(cnstGridtxtCompanyID).Text = GetIniString("CompanyName")
    tbrBin.Buttons(GetIniString("DocType")).Value = tbrPressed
    cmbGridGeneral(cnstGridcmbShow).Clear
    cmbGridGeneral(cnstGridcmbShow).AddItem "Any Key"
    cmbGridGeneral(cnstGridcmbShow).AddItem "DocID"
    cmbGridGeneral(cnstGridcmbShow).AddItem "Code"
    cmbGridGeneral(cnstGridcmbShow).AddItem "Description"
    cmbGridGeneral(cnstGridcmbShow).AddItem "File Name"
    cmbGridGeneral(cnstGridcmbShow).AddItem "Company"
    cmbGridGeneral(cnstGridcmbShow).AddItem "Collected Date"
    cmbGridGeneral(cnstGridcmbShow).AddItem "Collected Via"
    cmbGridGeneral(cnstGridcmbShow).AddItem "MetaFile"
    cmbGridGeneral(cnstGridcmbShow).ListIndex = 0
    cmbGridGeneral(cnstGridcmbShow).Visible = True
    Anchor cmbGridGeneral(cnstGridcmbShow), 13000, 180, 2000, 330

    RefreshBinGrid "Active"
End Sub

Public Sub ShowDocBin()
On Local Error Resume Next
    mstrCheckOutPath = GetApplicationData("CheckOutPath")
    FormatDocBin
End Sub

Private Sub GenerateMultipleDocument()
On Local Error GoTo Err_Exit
Dim sSql As String
Dim Counter As Integer
    For Counter = 1 To 525
    sSql = "Insert into DocumentBin(DocumentID, DocumentCode, CompanyID, DocFile, FileName, FileExt, Description, Metafile, CollectedVia, CollectedDate, CreateDate, UpdateDate, CreateUser, UpdateUser, Assigned, IsRead, IsCheckOut, CheckOutPath, CheckOutFileName, CheckOutUser, CheckOutDate, CheckInDate) " & _
           "Select DocumentID +(" & Counter & " *22), DocumentCode, CompanyID, DocFile, FileName, FileExt, Description, Metafile, CollectedVia, CollectedDate, CreateDate, UpdateDate, CreateUser, UpdateUser, Assigned, IsRead, IsCheckOut, CheckOutPath, CheckOutFileName, CheckOutUser, CheckOutDate, CheckInDate From DocumentBin Where DocumentID <=20"
    AdoConnDoc.Execute sSql
    Next Counter
    Exit Sub
Err_Exit:
     ShowError
End Sub

Private Sub FormatGrid()
On Local Error GoTo Err_Exit
    vsfgGeneral.ExtendLastCol = True
    vsfgGeneral.RowHeight(vsfgGeneral.Rows - 1) = 300

    vsfgGeneral.TextMatrix(0, cnstGridBookMark) = ""
    vsfgGeneral.ColWidth(cnstGridBookMark) = 400
    vsfgGeneral.TextMatrix(0, cnstGridCode) = "Code"
    vsfgGeneral.ColWidth(cnstGridCode) = GetProportionalValue(1500, False)
    vsfgGeneral.TextMatrix(0, cnstGridDescription) = "Description"
    vsfgGeneral.ColWidth(cnstGridDescription) = GetProportionalValue(3000, False)
    vsfgGeneral.TextMatrix(0, cnstGridIcon) = ""
    vsfgGeneral.ColWidth(cnstGridIcon) = 300
    vsfgGeneral.TextMatrix(0, cnstGridFileName) = "File Name"
    vsfgGeneral.ColWidth(cnstGridFileName) = GetProportionalValue(2000, False)
    vsfgGeneral.TextMatrix(0, cnstGridFilePath) = "CheckOut Path"
    vsfgGeneral.TextMatrix(0, cnstGridBrowse) = ""
    vsfgGeneral.TextMatrix(0, cnstGridCompany) = "Company"
    vsfgGeneral.ColWidth(cnstGridCompany) = GetProportionalValue(2500, False)
    vsfgGeneral.TextMatrix(0, cnstGridCollectedDate) = "Collect Date"
    vsfgGeneral.ColWidth(cnstGridCollectedDate) = GetProportionalValue(2200, False)
    vsfgGeneral.TextMatrix(0, cnstGridCollectedVia) = "Collect Via"
    vsfgGeneral.ColWidth(cnstGridCollectedVia) = 1500
    vsfgGeneral.TextMatrix(0, cnstGridIsRead) = "IsRead"

    vsfgGeneral.ColHidden(cnstGridDocID) = True
    vsfgGeneral.ColHidden(cnstGridBookMark) = True
    vsfgGeneral.ColHidden(cnstGridFilePath) = True
    vsfgGeneral.ColHidden(cnstGridBrowse) = True
    vsfgGeneral.ColHidden(cnstGridFilePath) = True
    vsfgGeneral.ColHidden(cnstGridIsRead) = True
    vsfgGeneral.ColHidden(cnstGridCheckOutUser) = True
    vsfgGeneral.ColHidden(cnstGridCheckOutDate) = True
    vsfgGeneral.ColHidden(cnstGridCheckInDate) = True
    vsfgGeneral.ColHidden(cnstGridIsCheckOut) = True
    vsfgGeneral.ExplorerBar = flexExSort
Exit Sub
Err_Exit:
        ShowError
End Sub

Public Sub ShowAccountTypes(lngCompanyID As Long, lngPeriodID As Long, IsWithBalance As Boolean)
On Local Error Resume Next
Dim sSql As String, Inc As Long, sSqlBalance As String, strDrCr As String
    FormatListObjects
    'sSqlBalance = "SELECT SUM(ESA.DAmt) - SUM(ESA.CAmt) AS Balance " & _
                  "FROM EntrySubAccounts ESA, Entries EM WHERE ESA.EntryID = EM.EntryID " & _
                  "AND ESA.AcID IN(SELECT AH1.AcID From AcHeads AH1 Where AH1.AcTypeID = AT.AcTypeID) And EM.PeriodID = " & lngPeriodID
    sSql = "Select AT.*, AT1.AcTypeDescription AS ParentAcTypeName, dbo.fn_GetAcTypeBal(AT.AcTypeID, " & lngPeriodID & ") AS Balance from AcTypes AT1, AcTypes AT Where AT.AcTypeID = AT1.AcTypeID AND AT.CompanyId = " & lngCompanyID & " Order By AT.AcTypeDescription"
    With GetRecords(sSql)
        lstViewGeneral.ColumnHeaders.Clear
        lstViewGeneral.ListItems.Clear
        lstViewGeneral.ColumnHeaders.Add , "Main", "Account Type", GetProportionalValue(4000, False)
        lstViewGeneral.ColumnHeaders.Add , "Parent", "Parent Type", GetProportionalValue(3000, False)
        If IsWithBalance Then
            lstViewGeneral.ColumnHeaders.Add , "Balance", "Balance", GetProportionalValue(2000, False), lvwColumnRight
        End If
        While Not .EOF
            Inc = Inc + 1
            lstViewGeneral.ListItems.Add Inc, "K" & .Fields("AcTypeID"), .Fields("AcTypeDescription") & "", "AccountTypes", "AccountTypes"
            lstViewGeneral.ListItems(Inc).SubItems(1) = .Fields("ParentAcTypeName") & ""
            If IsWithBalance Then
                If Val(.Fields("Balance") & "") < 0 Then
                    strDrCr = " Cr"
                ElseIf Val(.Fields("Balance") & "") > 0 Then
                    strDrCr = " Dr"
                Else
                    strDrCr = ""
                End If
                lstViewGeneral.ListItems(Inc).SubItems(2) = IIf(Val(.Fields("Balance") & "") <> 0, Format(Abs(Val(.Fields("Balance") & "")), "#,##0.00") & strDrCr, " ")
            End If
            .MoveNext
        Wend
        .Close
    End With
End Sub

Public Sub ShowAccountHeads(lngCompanyID As Long, lngPeriodID As Long, IsWithBalance As Boolean)
On Local Error Resume Next
Dim sSql As String, Inc As Long, sSqlBalance As String, strDrCr As String
    FormatListObjects
    sSqlBalance = "SELECT SUM(ESA.DAmt) - SUM(ESA.CAmt) AS Balance " & _
                  "FROM EntrySubAccounts ESA, Entries EM WHERE ESA.EntryID = EM.EntryID " & _
                  "AND ESA.AcID = AH.AcID And EM.PeriodID = " & lngPeriodID
    sSql = "Select AH.*, AT.AcTypeDescription, (" & sSqlBalance & ") AS Balance from AcHeads AH, AcTypes AT Where AH.AcTypeID = AT.AcTypeID AND AH.CompanyId = " & lngCompanyID & " Order By AH.AcName"
    With GetRecords(sSql)
        lstViewGeneral.ColumnHeaders.Clear
        lstViewGeneral.ListItems.Clear
        lstViewGeneral.ColumnHeaders.Add , "Main", "Account Head", GetProportionalValue(4000, False)
        lstViewGeneral.ColumnHeaders.Add , "Parent", "Account Type", GetProportionalValue(3000, False)
        If IsWithBalance Then
            lstViewGeneral.ColumnHeaders.Add , "Balance", "Balance", GetProportionalValue(2000, False), lvwColumnRight
        End If
        While Not .EOF
            Inc = Inc + 1
            lstViewGeneral.ListItems.Add Inc, "K" & .Fields("AcID"), .Fields("AcName") & "", "AccountHeads", "AccountHeads"
            lstViewGeneral.ListItems(Inc).SubItems(1) = .Fields("AcTypeDescription") & ""
            If IsWithBalance Then
                If Val(.Fields("Balance") & "") < 0 Then
                    strDrCr = " Cr"
                ElseIf Val(.Fields("Balance") & "") > 0 Then
                    strDrCr = " Dr"
                Else
                    strDrCr = ""
                End If
                lstViewGeneral.ListItems(Inc).SubItems(2) = IIf(Val(.Fields("Balance") & "") <> 0, Format(Abs(Val(.Fields("Balance") & "")), "#,##0.00") & strDrCr, " ")
            End If
            .MoveNext
        Wend
        .Close
    End With
End Sub

Public Sub ShowNavigatorOnly()
    frameGrid.Visible = False
    frameList.Visible = False
    frameAuditReport.Visible = False
End Sub

Public Sub ShowAuditReport(lngPeriodID As Long)
On Local Error Resume Next
Dim sSql As String, Row As Long
Dim sSql1 As String, Inc As Long
    mSenderPeriodID = lngPeriodID
    Anchor frameReporting, 0, 1200, 13500, 15000
    Anchor tbStripAuditReport, 0, 300, 13600, 400
    Anchor tbstripFinancialStatements, 0, 800, 13700, 400
    Anchor txtRemarks(txtleadsheetRemarks), 50, 6450, 13500, 500
    Anchor txtRemarks(txtProcedureRemarks), 50, 6450, 13500, 500
    Anchor cbReview, GetProportionalValue(9700), 1200, GetProportionalValue(1300), 300
    Anchor txtGenReview, 50, 6100, 13500, 1000
    Anchor txtGenRevReply, 50, 7300, 13500, 1000

    Anchor vsportAuditReport, 0, 300, 13700, 8500
    Anchor vsprintBalanceSheet, 0, 100, 13600, 8700

    frameAuditReport.Visible = True
    frameAuditReport.ZOrder vbBringToFront
    Anchor frameAuditReport, 0, 0, 15500, 10300

    Anchor vsfgSections, 13700, 80, 1800, 10300
    Anchor vsfgSubSections, 0, 80, 13700
    Anchor frameDetails, 0, 1200, 13700, 10300

    Load vsfgAuditReport(cnstGridLeadSheet)
    vsfgAuditReport(cnstGridLeadSheet).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridLeadSheet).Visible = True
    frameLeadsheet.Caption = ""
    Set vsfgAuditReport(cnstGridLeadSheet).Container = frameLeadsheet
    Anchor frameLeadsheet, 0, 600, 13600, 7000

    Load vsfgAuditReport(cnstGridRemarks)
    vsfgAuditReport(cnstGridRemarks).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridRemarks).Visible = True
    frameRemarks.Caption = ""
    Set vsfgAuditReport(cnstGridRemarks).Container = frameRemarks
    Anchor frameRemarks, 0, 600, 13600, 7000

    Load vsfgAuditReport(cnstGridLegalDocuments)
    vsfgAuditReport(cnstGridLegalDocuments).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridLegalDocuments).Visible = True
    frameRemarks.Caption = ""
    Set vsfgAuditReport(cnstGridLegalDocuments).Container = frameRemarks
    Anchor frameRemarks, 0, 600, 13600, 7000

    Load vsfgAuditReport(cnstGridProcedures)
    vsfgAuditReport(cnstGridProcedures).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridProcedures).Visible = True
    frameProcedures.Caption = ""
    Set vsfgAuditReport(cnstGridProcedures).Container = frameProcedures
    Load txtRemarks(txtProcedureRemarks)
    Anchor frameProcedures, 0, 600, 13600, 7000
    Anchor tbStripProcedures, 0, 100, 13600, 400

    Load vsfgAuditReport(cnstGridReviews)
    vsfgAuditReport(cnstGridReviews).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridReviews).Visible = True
    frameReviews.Caption = ""
    Set vsfgAuditReport(cnstGridReviews).Container = frameReviews
    Anchor frameReviews, 0, 600, 13600, 7000

    Load vsfgAuditReport(cnstGridGeneralReviews)
    vsfgAuditReport(cnstGridGeneralReviews).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridGeneralReviews).Visible = True
    frameGeneralReviews.Caption = ""
    Set vsfgAuditReport(cnstGridGeneralReviews).Container = frameGeneralReviews
    Anchor frameGeneralReviews, 0, 600, 13600, 8400

    Load vsfgAuditReport(cnstGridResources)
    vsfgAuditReport(cnstGridResources).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridResources).Visible = True
    frameResources.Caption = ""
    Set vsfgAuditReport(cnstGridResources).Container = frameResources
    Anchor frameResources, 0, 600, 13600, 7000

    Load vsfgAuditReport(cnstGridDocuments)
    vsfgAuditReport(cnstGridDocuments).ZOrder vbBringToFront
    vsfgAuditReport(cnstGridDocuments).Visible = True
    vsfgAuditReport(cnstGridDocuments).ScrollBars = flexScrollBarNone
    Set vsfgAuditReport(cnstGridDocuments).Container = frameAuditReport

    Anchor vsfgAuditReport(cnstGridLeadSheet), 50, 100, 13600, 6300
    Set txtRemarks(txtleadsheetRemarks).Container = frameLeadsheet
    Anchor txtRemarks(txtleadsheetRemarks), 50, 6450, 13500, 500
    vsfgAuditReport(cnstGridLeadSheet).RowHeight(0) = 330
    With vsfgAuditReport(cnstGridLeadSheet)
        .Cols = grdLeadSheetCols
        .ColWidth(grdLeadSheetParticulars) = GetProportionalValue(5000, False)
        .ColWidth(grdLeadSheetThisYear) = GetProportionalValue(2000, False)
        .ColWidth(grdLeadSheetLastYear) = GetProportionalValue(2000, False)
        .ColWidth(grdLeadSheetRemarks) = GetProportionalValue(1600, False)
        .ColWidth(grdLeadSheetAttachments) = GetProportionalValue(1300, False)
        .ColWidth(grdLeadSheetReviews) = GetProportionalValue(900, False)
        .ColWidth(grdLeadSheetReviewed) = GetProportionalValue(300, False)
        .ColHidden(grdLeadSheetAcID) = True
        .ColHidden(grdLeadSheetAcTypeId) = True
        .ColHidden(grdLeadSheetType) = True
        .ColHidden(grdLeadSheetReviewID) = True

        .ColAlignment(grdLeadSheetParticulars) = flexAlignLeftCenter
        .ColAlignment(grdLeadSheetThisYear) = flexAlignRightCenter
        .ColAlignment(grdLeadSheetLastYear) = flexAlignRightCenter
        .ColAlignment(grdLeadSheetReviewed) = flexAlignCenterCenter

        .RowHeightMin = 330
        .ExtendLastCol = True
        .FixedRows = 1
        .Editable = flexEDKbdMouse
        .Rows = 1: .Rows = 2

        .ColDataType(grdLeadSheetReviewed) = flexDTBoolean

        .TextMatrix(Row, grdLeadSheetParticulars) = "Particulars"
        .TextMatrix(Row, grdLeadSheetThisYear) = "Current Year"
        .TextMatrix(Row, grdLeadSheetLastYear) = "Last Year"
        .TextMatrix(Row, grdLeadSheetRemarks) = "Remarks"
        .TextMatrix(Row, grdLeadSheetAttachments) = "Attachments"
        .TextMatrix(Row, grdLeadSheetReviews) = "Rev"
        .TextMatrix(Row, grdLeadSheetReviewed) = "Rvwd"

        .ColComboList(grdLeadSheetAttachments) = "..."
        .ColComboList(grdLeadSheetReviews) = "..."

        .TextMatrix(Row, grdLeadSheetType) = "Leadsheets"
        .Cell(flexcpFontSize, 0, 0, Row, grdLeadSheetParticulars) = 10
        .Cell(flexcpFontSize, Row, grdLeadSheetThisYear, Row, grdLeadSheetReviewed) = 8
        .Cell(flexcpFontBold, Row, grdLeadSheetParticulars, Row, grdLeadSheetReviewed) = True
        .Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridLeadSheet).Cols - 1) = vbButtonFace
    End With

    Anchor vsfgAuditReport(cnstGridProcedures), 50, 600, 13600, 5800
    Set txtRemarks(txtProcedureRemarks).Container = frameProcedures
    Anchor txtRemarks(txtProcedureRemarks), 50, 6450, 13500, 500
    txtRemarks(txtProcedureRemarks).Visible = True
    vsfgAuditReport(cnstGridProcedures).RowHeight(0) = 330
    With vsfgAuditReport(cnstGridProcedures)
        .Cols = grdProcedureCols
        .ColWidth(grdProcedureSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdProcedureQuestions) = GetProportionalValue(6500, False)
        .ColWidth(grdProcedureAnswer) = GetProportionalValue(1500, False)
        .ColWidth(grdProcedureFavourable) = GetProportionalValue(1000, False)
        .ColWidth(grdProcedureTemplate) = GetProportionalValue(1400, False)
        .ColWidth(grdProcedureRemarks) = GetProportionalValue(2000, False)
        .ColWidth(grdProcedureAttachments) = GetProportionalValue(1500, False)
        .ColWidth(grdProcedureReviews) = GetProportionalValue(300, False)
        .ColHidden(grdProcedureID) = True
        .ColHidden(grdProcedureAnswers) = True
        .ColHidden(grdProcedureRemarks) = True
        .ColHidden(grdProcedureIsCheckedOut) = True
        .ColHidden(grdProcedureType) = True

        .ColAlignment(grdProcedureSlNo) = flexAlignLeftCenter
        .ColAlignment(grdProcedureQuestions) = flexAlignLeftCenter
        .ColAlignment(grdProcedureAnswer) = flexAlignLeftCenter
        .ColAlignment(grdProcedureFavourable) = flexAlignCenterCenter
        .ColAlignment(grdProcedureTemplate) = flexAlignLeftCenter
        .RowHeightMin = 330

        .Rows = 1: .Rows = 3
        .FixedRows = 1
        .Editable = flexEDKbdMouse
        .TextMatrix(Row, grdProcedureSlNo) = "Sl No"
        .TextMatrix(Row, grdProcedureQuestions) = "Questions"
        .TextMatrix(Row, grdProcedureAnswer) = "Answer"
        .TextMatrix(Row, grdProcedureFavourable) = "Unfav"
        .TextMatrix(Row, grdProcedureTemplate) = "Templates"
        .TextMatrix(Row, grdProcedureAttachments) = "Attach"
        .TextMatrix(Row, grdProcedureReviews) = "Rev"

        .Cell(flexcpFontBold, Row, grdProcedureSlNo, Row, grdProcedureReviews) = True

        .TextMatrix(Row, grdProcedureType) = "Procedures"

        .ColDataType(grdProcedureFavourable) = flexDTBoolean
        .ColComboList(grdProcedureQuestions) = "..."
        .ColComboList(grdProcedureTemplate) = "..."
        .ColComboList(grdProcedureAttachments) = "..."
        .ColComboList(grdProcedureReviews) = "..."

        .Cell(flexcpFontBold, Row, grdProcedureSlNo, Row, grdProcedureAttachments) = True
        .Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridProcedures).Cols - 1) = vbButtonFace
    End With

    Anchor vsfgAuditReport(cnstGridReviews), 50, 100, 13600, 6800
    vsfgAuditReport(cnstGridReviews).RowHeight(0) = 330
    With vsfgAuditReport(cnstGridReviews)
        .Cols = grdReviewCols
        .ColWidth(grdReviewSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdReviews) = GetProportionalValue(4500, False)
        .ColWidth(grdReviewedBy) = GetProportionalValue(1200, False)
        .ColWidth(grdReviewReply) = GetProportionalValue(3200, False)
        .ColWidth(grdReviewRepliedBy) = GetProportionalValue(1100, False)
        .ColWidth(grdReviewRelatedAC) = GetProportionalValue(2000, False)
        .ColHidden(grdReviewID) = True
        .ColHidden(grdReviewAccount) = True
        .ColHidden(grdReviewType) = True

        .ColAlignment(grdReviewSlNo) = flexAlignLeftCenter
        .ColAlignment(grdReviews) = flexAlignLeftCenter
        .ColAlignment(grdReviewedBy) = flexAlignLeftCenter
        .ColAlignment(grdReviewReply) = flexAlignLeftCenter
        .ColAlignment(grdReviewRepliedBy) = flexAlignLeftCenter
        .ColAlignment(grdReviewRelatedAC) = flexAlignLeftCenter
        .RowHeightMin = 330

        .Rows = 1: .Rows = 2
        .FixedRows = 1
        .TextMatrix(Row, grdReviewSlNo) = "Sl No"
        .TextMatrix(Row, grdReviews) = "Reviews"
        .TextMatrix(Row, grdReviewedBy) = "Reviewed By"
        .TextMatrix(Row, grdReviewReply) = "Review Reply"
        .TextMatrix(Row, grdReviewRepliedBy) = "Replied By"
        .TextMatrix(Row, grdReviewRelatedAC) = "Related To"

        .Cell(flexcpFontBold, Row, grdReviewSlNo, Row, grdReviewRelatedAC) = True

        .TextMatrix(Row, grdReviewType) = "Reviews"

        .Cell(flexcpFontSize, 1, grdReviewSlNo, .Rows - 1, .Cols - 1) = 12
        .Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridReviews).Cols - 1) = vbButtonFace
    End With

    Anchor vsfgAuditReport(cnstGridRemarks), 50, 100, 13600, 6800
    vsfgAuditReport(cnstGridRemarks).RowHeight(0) = 500
    vsfgAuditReport(cnstGridRemarks).Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridRemarks).Cols - 1) = vbButtonFace
    With vsfgAuditReport(cnstGridRemarks)
        .Cols = grdRemarksCols
        .ColWidth(grdRemarksSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdRemarksObservations) = GetProportionalValue(6500, False)
        .ColWidth(grdRemarksActions) = GetProportionalValue(4500, False)
        .ColHidden(grdRemarksID) = True
        .ColHidden(grdRemarksType) = True

        .ColAlignment(grdRemarksSlNo) = flexAlignLeftCenter
        .ColAlignment(grdRemarksObservations) = flexAlignLeftCenter
        .ColAlignment(grdRemarksActions) = flexAlignLeftCenter
        .RowHeightMin = 500

        .FixedRows = 1
        .Editable = flexEDKbdMouse
        .WordWrap = True
        .TextMatrix(Row, grdRemarksSlNo) = "Sl No"
        .TextMatrix(Row, grdRemarksObservations) = "Observations"
        .TextMatrix(Row, grdRemarksActions) = "Actions"

        .TextMatrix(Row, grdRemarksType) = "Matters Arising"

        .Cell(flexcpFontBold, Row, grdRemarksSlNo, Row, grdRemarksActions) = True
    End With

    Anchor vsfgAuditReport(cnstGridLegalDocuments), 50, 100, 13600, 6800
    vsfgAuditReport(cnstGridLegalDocuments).RowHeight(0) = 500
    vsfgAuditReport(cnstGridLegalDocuments).Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridLegalDocuments).Cols - 1) = vbButtonFace
    With vsfgAuditReport(cnstGridLegalDocuments)
        .Cols = grdLegalDocCols
        .ColWidth(grdLegalDocSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdLegalDocDescription) = GetProportionalValue(4500, False)
        .ColWidth(grdLegalDocRemarks) = GetProportionalValue(5000, False)
        .ColWidth(grdLegalDocAttachments) = GetProportionalValue(2000, False)

        .ColHidden(grdLegalDocID) = True
        .ColHidden(grdLegalDocType) = True

        .ColAlignment(grdLegalDocSlNo) = flexAlignLeftCenter
        .ColAlignment(grdLegalDocDescription) = flexAlignLeftCenter
        .ColAlignment(grdLegalDocRemarks) = flexAlignLeftCenter
        .ColAlignment(grdLegalDocAttachments) = flexAlignLeftCenter
        .RowHeightMin = 500

        .FixedRows = 1
        .Editable = flexEDKbdMouse
        .WordWrap = True
        .TextMatrix(Row, grdLegalDocSlNo) = "Sl No"
        .TextMatrix(Row, grdLegalDocDescription) = "Particulars"
        .TextMatrix(Row, grdLegalDocRemarks) = "Remarks"
        .TextMatrix(Row, grdLegalDocAttachments) = "Attachments"

        .TextMatrix(Row, grdLegalDocType) = "Legal Documents"

        .Cell(flexcpFontBold, Row, grdLegalDocSlNo, Row, grdLegalDocAttachments) = True
    End With

    Anchor vsfgAuditReport(cnstGridGeneralReviews), 50, 100, 13500, 5800
    vsfgAuditReport(cnstGridGeneralReviews).RowHeight(0) = 500
    vsfgAuditReport(cnstGridGeneralReviews).Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridGeneralReviews).Cols - 1) = vbButtonFace
    With vsfgAuditReport(cnstGridGeneralReviews)
        .Cols = grdGenReviewCols
        .ColWidth(grdGenReviewSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdGenReviews) = GetProportionalValue(5000, False)
        .ColWidth(grdGenReviewedBy) = GetProportionalValue(1500, False)
        .ColWidth(grdGenReviewReply) = GetProportionalValue(4500, False)
        .ColWidth(grdGenReviewRepliedBy) = GetProportionalValue(1200, False)
        .ColHidden(grdGenReviewID) = True
        .ColHidden(grdGenReviewType) = True

        .ColAlignment(grdGenReviewSlNo) = flexAlignLeftCenter
        .ColAlignment(grdGenReviews) = flexAlignLeftCenter
        .ColAlignment(grdGenReviewedBy) = flexAlignLeftCenter
        .ColAlignment(grdGenReviewReply) = flexAlignLeftCenter
        .ColAlignment(grdGenReviewRepliedBy) = flexAlignLeftCenter

        .ColComboList(grdGenReviews) = "..."

        .FixedRows = 1
        .Editable = flexEDKbdMouse
'        .WordWrap = True
        .TextMatrix(Row, grdGenReviewSlNo) = "Sl No"
        .TextMatrix(Row, grdGenReviews) = "Reviews"
        .TextMatrix(Row, grdGenReviewedBy) = "Reviewed By"
        .TextMatrix(Row, grdGenReviewReply) = "Review Reply"
        .TextMatrix(Row, grdGenReviewRepliedBy) = "Replied By"

        .TextMatrix(Row, grdGenReviewType) = "General Reviews"
        .RowHeightMin = 330

        .Cell(flexcpFontBold, Row, grdGenReviewSlNo, Row, grdGenReviewRepliedBy) = True
    End With

    Anchor vsfgAuditReport(cnstGridResources), 50, 100, 13600, 6800
    vsfgAuditReport(cnstGridResources).RowHeightMin = 500
    With vsfgAuditReport(cnstGridResources)
        .Cols = grdResourcesCols
        .ColWidth(grdResourcesSlNo) = GetProportionalValue(700, False)
        .ColWidth(grdResourcesName) = GetProportionalValue(6500, False)
        .ColWidth(grdResourcesFile) = GetProportionalValue(6350, False)
        .ColHidden(grdResourcesID) = True
        .ColHidden(grdResourcesType) = True
        .ColHidden(grdResourceDocID) = True
        .ColComboList(grdResourcesFile) = "..."
        .ColAlignment(grdResourcesSlNo) = flexAlignLeftCenter
        .ColAlignment(grdResourcesName) = flexAlignLeftCenter
        .ColAlignment(grdResourcesFile) = flexAlignLeftCenter

        .Rows = 1: .Rows = 2
        .FixedRows = 1
'        .Editable = flexEDKbdMouse
        .ExtendLastCol = False
        .TextMatrix(Row, grdResourcesSlNo) = "Sl No"
        .TextMatrix(Row, grdResourcesName) = "Description"
        .TextMatrix(Row, grdResourcesFile) = "File"

        .Cell(flexcpFontBold, Row, grdResourcesSlNo, Row, grdResourcesFile) = True

        .TextMatrix(Row, grdResourcesType) = "Resources"
        .Cell(flexcpFontSize, 1, grdResourcesSlNo, .Rows - 1, .Cols - 1) = 12
        .Cell(flexcpBackColor, 0, 0, 0, vsfgAuditReport(cnstGridResources).Cols - 1) = vbButtonFace
    End With

    Anchor vsfgAuditReport(cnstGridDocuments), 50, 9000, 13500, 1100
    vsfgAuditReport(cnstGridDocuments).RowHeight(0) = 500
    vsfgAuditReport(cnstGridDocuments).Rows = 2
    vsfgAuditReport(cnstGridDocuments).Cell(flexcpBackColor, 0) = RGB(180, 180, 180)
    With vsfgAuditReport(cnstGridDocuments)
        .ColWidth(.Cols) = GetProportionalValue(13500, False)
        .ColHidden(grdDocumentID) = True
        .ExtendLastCol = False
        .FocusRect = flexFocusHeavy
        .RowHeight(0) = 500
        .RowHeight(1) = 580
        .FixedRows = 0
        .Enabled = True
        .GridLines = flexGridFlatVert
        .WordWrap = True
    End With

    Load vsfgReporting(cnstgrdBalanceSheet)
    vsfgReporting(cnstgrdBalanceSheet).ZOrder vbBringToFront
    vsfgReporting(cnstgrdBalanceSheet).Visible = True
    frameReporting.Caption = ""
    Anchor frameReporting, 0, 1200, 13600, 15000
    Set vsfgReporting(cnstgrdBalanceSheet).Container = frameReporting

    Anchor vsfgReporting(cnstgrdBalanceSheet), 50, 1200, 13600, 6000
    Set txtRemarks(txtBalSheetRemarks).Container = frameReporting
    Anchor txtRemarks(txtBalSheetRemarks), 50, 7400, 13500, 500
    txtRemarks(txtBalSheetRemarks).Visible = True
    vsfgReporting(cnstgrdBalanceSheet).RowHeight(0) = 330

    With vsfgReporting(cnstgrdBalanceSheet)
        .Cols = grdBalSheetCols
        .ColHidden(grdBalSheetAcTypeID) = True
        .ColWidth(grdBalSheetParticulars) = GetProportionalValue(3800, False)
        .ColWidth(grdBalSheetThisYr) = GetProportionalValue(2000, False)
        .ColWidth(grdBalSheetLastYr) = GetProportionalValue(2000, False)
        .ColWidth(grdBalSheetDiffPercent) = GetProportionalValue(1500, False)
        .ColWidth(grdBalSheetDifference) = GetProportionalValue(2000, False)
        .ColWidth(grdBalSheetRemarks) = GetProportionalValue(2000, False)

        .ColAlignment(grdBalSheetParticulars) = flexAlignLeftCenter
        .ColAlignment(grdBalSheetThisYr) = flexAlignRightCenter
        .ColAlignment(grdBalSheetLastYr) = flexAlignRightCenter
        .ColAlignment(grdBalSheetDiffPercent) = flexAlignRightCenter
        .ColAlignment(grdBalSheetDifference) = flexAlignRightCenter
        .ColAlignment(grdBalSheetRemarks) = flexAlignLeftCenter

        .Rows = 1: .Rows = 2
        .ExtendLastCol = False
        .Editable = flexEDKbdMouse
        .FixedRows = 1
        .TextMatrix(Row, grdBalSheetParticulars) = "BALANCE SHEET"
        .TextMatrix(Row, grdBalSheetThisYr) = "Current Year"
        .TextMatrix(Row, grdBalSheetLastYr) = "Previous Year"
        .TextMatrix(Row, grdBalSheetDiffPercent) = "Difference %"
        .TextMatrix(Row, grdBalSheetDifference) = "Difference"
        .TextMatrix(Row, grdBalSheetRemarks) = "Remarks"

        .Cell(flexcpFontBold, Row, grdBalSheetParticulars, Row, grdBalSheetRemarks) = True
    End With

    Load vsfgReporting(cnstgrdProfitLoss)
    vsfgReporting(cnstgrdProfitLoss).ZOrder vbBringToFront
    vsfgReporting(cnstgrdProfitLoss).Visible = True
    frameReporting.Caption = ""
    Set vsfgReporting(cnstgrdProfitLoss).Container = frameReporting
    Anchor frameReporting, 0, 1200, 13600, 15000

    Anchor vsfgReporting(cnstgrdProfitLoss), 50, 1200, 13600, 8000
    Set txtRemarks(txtProfitLossRemarks).Container = frameReporting
    Anchor txtRemarks(txtProfitLossRemarks), 50, 9500, 13500, 500
    txtRemarks(txtProfitLossRemarks).Visible = True

    vsfgReporting(cnstgrdProfitLoss).RowHeight(0) = 330
    With vsfgReporting(cnstgrdProfitLoss)
        .Cols = grdBalSheetCols
        .ColHidden(grdPLAcTypeID) = True
        .ColWidth(grdPLParticulars) = GetProportionalValue(3200, False)
        .ColWidth(grdPLThisYr) = GetProportionalValue(2000, False)
        .ColWidth(grdPLLastYr) = GetProportionalValue(2000, False)
        .ColWidth(grdPLDiffPercent) = GetProportionalValue(1500, False)
        .ColWidth(grdPLDifference) = GetProportionalValue(2000, False)
        .ColWidth(grdPLRemarks) = GetProportionalValue(2800, False)

        .ColAlignment(grdPLParticulars) = flexAlignLeftCenter
        .ColAlignment(grdPLThisYr) = flexAlignRightCenter
        .ColAlignment(grdPLLastYr) = flexAlignRightCenter
        .ColAlignment(grdPLDiffPercent) = flexAlignRightCenter
        .ColAlignment(grdPLDifference) = flexAlignRightCenter
        .ColAlignment(grdPLRemarks) = flexAlignLeftCenter

        .Rows = 1: .Rows = 2
        .ExtendLastCol = False
        .FixedRows = 1
        .RowHeight(Row) = 330
        .TextMatrix(Row, grdPLParticulars) = "INCOME STATEMENT"
        .TextMatrix(Row, grdPLThisYr) = "Current Year"
        .TextMatrix(Row, grdPLLastYr) = "Previous Year"
        .TextMatrix(Row, grdPLDiffPercent) = "Difference %"
        .TextMatrix(Row, grdPLDifference) = "Difference"
        .TextMatrix(Row, grdPLRemarks) = "Remarks"

        .Cell(flexcpFontBold, Row, grdPLParticulars, Row, grdPLAcTypeID) = True
    End With

    Load vsfgReporting(cnstgrdLiquidity)
    vsfgReporting(cnstgrdLiquidity).ZOrder vbBringToFront
    vsfgReporting(cnstgrdLiquidity).Visible = True
    frameReporting.Caption = ""
    Set vsfgReporting(cnstgrdLiquidity).Container = frameReporting
    Anchor frameReporting, 0, 1200, 13600, 15000

    Anchor vsfgReporting(cnstgrdLiquidity), 50, 1200, 13600, 8000
    Set txtRemarks(txtLiquidityRemarks).Container = frameReporting
    Anchor txtRemarks(txtLiquidityRemarks), 50, 9500, 13500, 500
    txtRemarks(txtLiquidityRemarks).Visible = True

    vsfgReporting(cnstgrdLiquidity).RowHeight(0) = 330
    With vsfgReporting(cnstgrdLiquidity)
        .Cols = grdLiquidityCols
        .ColHidden(grdLiquiditySlNo) = True
        .ColWidth(grdLiquidityRatio) = GetProportionalValue(3500, False)
        .ColWidth(grdLiquidityThisYr) = GetProportionalValue(3000, False)
        .ColWidth(grdLiquidityLastYr) = GetProportionalValue(3000, False)
        .ColWidth(grdLiquidityRemarks) = GetProportionalValue(4000, False)

        .ColAlignment(grdLiquidityRatio) = flexAlignLeftCenter
        .ColAlignment(grdLiquidityThisYr) = flexAlignRightCenter
        .ColAlignment(grdLiquidityLastYr) = flexAlignRightCenter
        .ColAlignment(grdLiquidityRemarks) = flexAlignLeftCenter
        .Rows = 18
        .ExtendLastCol = False
        .FixedRows = 1
        .RowHeight(Row) = 330
        .TextMatrix(Row, grdLiquidityRatio) = "LIQUIDITY RATIOS"
        .TextMatrix(Row, grdLiquidityThisYr) = "Current Year"
        .TextMatrix(Row, grdLiquidityLastYr) = "Previous Year"
        .TextMatrix(Row, grdLiquidityRemarks) = "Remarks"

        .Cell(flexcpFontBold, Row, grdLiquidityRatio, Row, grdLiquiditySlNo) = True
    End With

    Load vsfgReporting(cnstgrdProfitability)
    vsfgReporting(cnstgrdProfitability).ZOrder vbBringToFront
    vsfgReporting(cnstgrdProfitability).Visible = True
    frameReporting.Caption = ""
    Set vsfgReporting(cnstgrdProfitability).Container = frameReporting
    Anchor frameReporting, 0, 1200, 13600, 15000

    Anchor vsfgReporting(cnstgrdProfitability), 50, 1200, 13600, 8000
    Set txtRemarks(txtProfitabilityRemarks).Container = frameReporting
    Anchor txtRemarks(txtProfitabilityRemarks), 50, 9500, 13500, 500
    txtRemarks(txtProfitabilityRemarks).Visible = True

    vsfgReporting(cnstgrdProfitability).RowHeight(0) = 330
    With vsfgReporting(cnstgrdProfitability)
        .Cols = grdProfitabilityCols
        .ColHidden(grdProfitabilitySlNo) = True
        .ColWidth(grdProfitabilityRatio) = GetProportionalValue(4000, False)
        .ColWidth(grdProfitabilityThisYr) = GetProportionalValue(2000, False)
        .ColWidth(grdProfitabilityLastYr) = GetProportionalValue(2000, False)
        .ColWidth(grdProfitabilityRemarks) = GetProportionalValue(5500, False)

        .ColAlignment(grdProfitabilityRatio) = flexAlignLeftCenter
        .ColAlignment(grdProfitabilityThisYr) = flexAlignRightCenter
        .ColAlignment(grdProfitabilityLastYr) = flexAlignRightCenter
        .ColAlignment(grdProfitabilityRemarks) = flexAlignLeftCenter

        .Rows = 18
        .ExtendLastCol = False
        .FixedRows = 1
        .RowHeight(Row) = 330
        .TextMatrix(Row, grdProfitabilityRatio) = "PROFITABILTY RATIOS"
        .TextMatrix(Row, grdProfitabilityThisYr) = "Current Year"
        .TextMatrix(Row, grdProfitabilityLastYr) = "Previous Year"
        .TextMatrix(Row, grdProfitabilityRemarks) = "Remarks"
        .Cell(flexcpFontBold, Row, grdProfitabilityRatio, Row, grdProfitabilityRemarks) = True
    End With
    sSql1 = "Select Count(*) AS TotalNos From FilingSections"
    With GetRecords(sSql1)
        If Not .EOF Then
            mlngSectionTotalRows = .Fields("TotalNos") & ""
        End If
    End With
    mlngSectionMaxHeight = GetProportionalValue(9300)
    mlngSectionActualHeight = (mlngSectionMaxHeight / mlngSectionTotalRows)
    sSql = "SELECT * From FilingSections ORDER BY RefNo"
    With GetRecords(sSql)
        vsfgSections.Rows = 1
        vsfgSections.Cell(flexcpText, vsfgSections.Rows - 1, 0) = ""
        vsfgSections.RowHeight(vsfgSections.Rows - 1) = 0
        While Not .EOF
            vsfgSections.Rows = vsfgSections.Rows + 1: Inc = Inc + 1
            vsfgSections.Cell(flexcpText, Inc, 0) = .Fields("Description") & ""
            vsfgSections.TextMatrix(Inc, 1) = Val(.Fields("SectionID") & "")
            vsfgSections.RowHeight(Inc) = mlngSectionActualHeight
            .MoveNext
        Wend
        .Close
    End With
    vsfgSections.Row = Val(GetSetting(App.Title, App.Title, "LastFileSection", "1"))
    vsfgSections_Click
End Sub

Public Sub ShowSubSections(lngSectionID As Long)
On Local Error Resume Next
Dim sSql As String, rsData As New ADODB.Recordset
Dim sSql1 As String, rsDetail As New ADODB.Recordset
Dim lngStatus As Long
Dim Inc As Long, lngRecordCount As Long
    lngRecordCount = 0
    sSql = "SELECT * From FilingSubSection WHERE (SectionID = " & lngSectionID & ")" & " ORDER BY TrialOrder"
    Set rsData = GetRecords(sSql)
    With rsData
        vsfgSubSections.Rows = 2
        vsfgSubSections.Cols = 0
        vsfgSubSections.RowHeightMin = 1125
        vsfgSubSections.RowHidden(1) = True
'        vsfgSubSections.ExtendLastCol = True
        While Not .EOF
            If lngSectionID >= 5 And lngSectionID <> 11 Then
                lngStatus = PickValue("AcTypes", "StatusID", "ActualAcTypeID = " & rsData.Fields("AcTypeID") & "" & " AND CompanyID = " & pActiveCompanyID)
                If lngStatus = 1 Then
                    sSql1 = "Select AT.AcTypeDescription From AcTypes AT Where AT.ActualAcTypeID = " & rsData.Fields("AcTypeID") & " AND AT.CompanyID = " & pActiveCompanyID & " ORDER BY AT.TrialOrder"
                    Set rsDetail = GetRecords(sSql1)
                        If Not rsDetail.EOF Then
                            vsfgSubSections.Cols = vsfgSubSections.Cols + 1
                            vsfgSubSections.Cell(flexcpText, 0, vsfgSubSections.Cols - 1) = rsDetail.Fields("AcTypeDescription") & ""
                            vsfgSubSections.TextMatrix(1, vsfgSubSections.Cols - 1) = Val(rsData.Fields("SubSectionID") & "")
                            lngRecordCount = lngRecordCount + 1
                            vsfgSubSections.ColWidth(vsfgSubSections.Cols - 1) = (vsfgSubSections.Width - 80) / .RecordCount
                            vsfgSubSections.ColAlignment(vsfgSubSections.Cols - 1) = flexAlignCenterTop
        '                    vsfgSubSections.CellPicture = imgLstCmpInfo.ListImages(7)
        '                    vsfgSubSections.Cell(flexcpBackColor, 0, vsfgSubSections.Cols - 1) = &HC0FFFF                     'GetColor(0)
        '                    vsfgSubSections.Picture = imgLstCmpInfo.ListImages(7)
        '                    vsfgSubSections.CellBackColor = &HC0FFFF
                        End If
                Else
'                    vsfgSubSections.Cell(flexcpText, 0, vsfgSubSections.Cols - 1) = ""
'                    vsfgSubSections.TextMatrix(1, vsfgSubSections.Cols - 1) = -1
'                    vsfgSubSections.ColWidth(vsfgSubSections.Cols - 1) = 0
                End If
            Else
                vsfgSubSections.Cols = vsfgSubSections.Cols + 1
                lngRecordCount = lngRecordCount + 1
                vsfgSubSections.Cell(flexcpText, 0, vsfgSubSections.Cols - 1) = rsData.Fields("Description") & ""
                vsfgSubSections.TextMatrix(1, vsfgSubSections.Cols - 1) = Val(rsData.Fields("SubSectionID") & "")
                vsfgSubSections.ColWidth(vsfgSubSections.Cols - 1) = (vsfgSubSections.Width - 80) / .RecordCount
                vsfgSubSections.ColAlignment(vsfgSubSections.Cols - 1) = flexAlignCenterTop
            End If
        .MoveNext
        Wend
    .Close
    End With
    lngRecordCount = vsfgSubSections.Cols
    For Inc = 0 To vsfgSubSections.Cols
        If vsfgSubSections.TextMatrix(0, Inc) <> "" Then
            vsfgSubSections.ColWidth(Inc) = (vsfgSubSections.Width) / lngRecordCount
        End If
    Next Inc
End Sub

Public Function GetColor(lngCol As Long)
    Select Case lngCol Mod 8
        Case 0
            GetColor = RGB(252, 255, 214)
        Case 1
            GetColor = RGB(229, 251, 205)
        Case 2
            GetColor = RGB(229, 209, 205)
        Case 3
            GetColor = RGB(223, 248, 255)
        Case 4
            GetColor = RGB(255, 247, 255)
        Case 5
            GetColor = RGB(252, 255, 236)
        Case 6
            GetColor = RGB(238, 243, 205)
        Case 7
            GetColor = RGB(246, 247, 255)
    End Select
End Function

Public Property Get ObjectID() As Long
    ObjectID = mObjectID
End Property

Public Property Let ObjectID(ByVal vNewValue As Long)
    mObjectID = vNewValue
End Property

Private Sub cbReview_Click()
    SaveSubSectionReview
End Sub

Private Sub cmdGridClear_Click()
    txtGridGeneral(cnstGridtxtCompanyID).Text = ""
    txtGridGeneral(cnstGridtxtCompanyID).Tag = ""
    txtGridGeneral(cnstGridtxtCompanyID).SetFocus
End Sub

Private Sub fndGridGeneral_Click(Index As Integer)
On Local Error GoTo Err_Exit
Dim strFilter As String
    strFilter = GetFilter
    RefreshBinGrid "Find", strFilter, txtGridGeneral(cnstGridtxtCompanyID).Text, (cmbGridGeneral(cnstGridcmbShow).Text = "Any Key")
Err_Exit:
End Sub

Public Function GetFilter() As String
On Local Error GoTo Err_Exit
Dim strFilter As String
    strFilter = "DocumentID"
    Select Case cmbGridGeneral(cnstGridcmbShow).Text
        Case "DocID"
             strFilter = "DocumentID"
        Case "Code"
             strFilter = "DocumentCode"
        Case "File Name"
             strFilter = "FileName"
        Case "Company"
            strFilter = "CompanyName"
        Case "Collected Date"
            strFilter = "CollectedDate"
        Case "Collected Via"
             strFilter = "CollectedVia"
        Case "Collected Date"
            strFilter = "CollectedDate"
        Case "Description", "MetaFile"
            strFilter = cmbGridGeneral(cnstGridcmbShow).Text
      End Select
      GetFilter = strFilter
Exit Function
Err_Exit:
End Function

Private Sub RefreshBinGrid(ByVal strKey As String, Optional strFieldName As String = "x", Optional strFieldValue As String = "", Optional bAnyKey As Boolean = False)
On Local Error GoTo Err_Exit
Dim strCompanyName As String, lngCompanyID As Long
Dim sSql As String, sSqlTmp As String, sSqlDefAndUndefFirst As String
Dim sSqlDefAndUndefSecond As String, sSqlSearchKey As String
Dim sSqlOrderTmp As String, sSqlActive As String
Dim FileExt As String
    lngCompanyID = Val(txtGridGeneral(cnstGridtxtCompanyID).Tag)
    Set rsDoc = New ADODB.Recordset
    rsDoc.CursorLocation = adUseClient
    sSqlTmp = "SELECT DocumentID From AuditMain.dbo.DocumentSubLinks"
    sSql = "SELECT  '' AS BookMark, DocumentBin.DocumentID AS DocID, DocumentBin.DocumentCode AS Code, DocumentBin.Description, " & _
           "        IsCheckOut AS CheckOut, DocumentBin.FileExt, DocumentBin.FileName, CheckOutPath,'' AS Brows, AuditMain.dbo.Companies.CompanyName AS CompanyName , " & _
           "        DocumentBin.CollectedDate, DocumentBin.CollectedVia, DocumentBin.MetaFile, IsRead, CheckOutUser, CheckOutDate, CheckInDate " & _
           "FROM    DocumentBin  LEFT OUTER JOIN AuditMain.dbo.Companies ON DocumentBin.CompanyID = AuditMain.dbo.Companies.CompanyID WHERE DocumentBin.IsResource Is Null"
    sSqlOrderTmp = " ORDER BY IsRead, DocumentBin.UpdateDate DESC"
    sSqlDefAndUndefFirst = "SELECT '' as BookMark, DocumentBin.DocumentID AS DocID, DocumentCode AS Code, Description,IsCheckOut AS CheckOut, FileExt, FileName, CheckOutPath,  " & _
                           "       '' as Brows, AuditMain.dbo.Companies.CompanyName AS CompanyName, CollectedDate, CollectedVia, MetaFile, IsRead, CheckOutUser, CheckOutDate, CheckInDate " & _
                           "From   DocumentBin LEFT OUTER JOIN AuditMain.dbo.Companies ON DocumentBin.CompanyID = AuditMain.dbo.Companies.CompanyID Where DocumentID "
    sSqlDefAndUndefSecond = "IN (" & sSqlTmp & ") AND $SearchKey$  AND DocumentBin.IsResource Is NULL ORDER BY DocumentBin.UpdateDate DESC"
    sSqlSearchKey = " DocumentID IN (Select DocumentID From DocumentBin INNER JOIN AuditMain.dbo.Companies CMP ON CMP.CompanyID = DocumentBin.CompanyID Where DocumentID like '%" & strFieldValue & "%' AND DocumentBin.IsResource Is Null " & _
                    " or DocumentCode like '%" & strFieldValue & "%'" & _
                    " or Description like '%" & strFieldValue & "%'" & _
                    " or FileName like '%" & strFieldValue & "%'" & _
                    " or CheckOutPath like '%" & strFieldValue & "%'" & _
                    " or CONVERT(varchar, CollectedDate, 103) like '%" & strFieldValue & "%'" & _
                    " or CollectedVia like '%" & strFieldValue & "%'" & _
                    " or CompanyName like '%" & strFieldValue & "%'" & _
                    " or MetaFile like '%" & strFieldValue & "%') "
    sSqlActive = "SELECT  '' AS BookMark, DocumentBin.DocumentID AS DocID, DocumentBin.DocumentCode AS Code, DocumentBin.Description, " & _
                 "        DocumentBin.IsCheckOut AS CheckOut, DocumentBin.FileExt, DocumentBin.FileName, DocumentBin.CheckOutPath, '' AS Brows, " & _
                 "        AuditMain.dbo.Companies.CompanyName AS CompanyName, DocumentBin.CollectedDate, DocumentBin.CollectedVia, DocumentBin.Metafile, " & _
                 "        DocumentBin.IsRead, DocumentBin.CheckOutUser, DocumentBin.CheckOutDate, DocumentBin.CheckInDate " & _
                 "FROM    DocumentBin LEFT OUTER JOIN AuditMain.dbo.Companies ON DocumentBin.CompanyID = AuditMain.dbo.Companies.CompanyID " & _
                 "Where   DocumentBin.CompanyID = " & pActiveCompanyID & " AND DocumentBin.IsResource Is Null "
    Select Case strKey
        Case "Active"
            sSql = sSqlActive & sSqlOrderTmp
            sSql = Replace(sSql, "$SearchKey$", sSqlSearchKey)
        Case "All"
             sSql = sSql & sSqlOrderTmp
             sSql = Replace(sSql, "$SearchKey$", sSqlSearchKey)
        Case "Defined"
            sSql = sSqlDefAndUndefFirst & sSqlDefAndUndefSecond
            sSql = Replace(sSql, "$SearchKey$", sSqlSearchKey)
        Case "Undefined"
            sSql = sSqlDefAndUndefFirst & " NOT " & sSqlDefAndUndefSecond
            sSql = Replace(sSql, "$SearchKey$", sSqlSearchKey)
        Case "Find"
'            If bAnyKey = True Then
'                sSql = sSql & " Where " & sSqlSearchKey & sSqlOrderTmp
'            Else
'                If strFieldName = "CollectedDate" Then
'                   sSql = sSql & " Where CONVERT(varchar, CollectedDate) like '%" & strFieldValue & "%'" & sSqlOrderTmp
'                Else
'                  sSql = sSql & " Where " & strFieldName & " like '%" & strFieldValue & "%'" & sSqlOrderTmp
'                End If
'            End If
    End Select
    Set vsfgGeneral.DataSource = Nothing
    AdodcGrid.ConnectionString = AdoConnDoc.ConnectionString
    AdodcGrid.RecordSource = sSql
    DoEvents
    Set vsfgGeneral.DataSource = AdodcGrid
    AdodcGrid.Refresh
    SetIconAndDefaults
    RefreshPanel strKey
    sbrGrid.Panels.Item("DocTotal").MinWidth = 3000
    sbrGrid.Panels.Item("DocTotal").Text = "Total No. of Documents : " & Val(vsfgGeneral.Rows - 1)
    FormatGrid
    Exit Sub
Err_Exit:
'    ShowError
End Sub

Private Sub RefreshPanel(ByVal strKey As String)
On Local Error GoTo Err_Exit
Dim DocCount As Long
Dim rsDocCount As New ADODB.Recordset
Dim sSql As String
    sbrGrid.Panels.Item("CheckOutUser").Visible = False
    sbrGrid.Panels.Item("CheckOutDate").Visible = False
    sbrGrid.Panels.Item("DocTotal").MinWidth = 3000
    sbrGrid.Panels.Item("DocTotal").Text = "Total No. of Documents :" & Val(vsfgGeneral.Rows - 1)
    If strKey = "All" Then
    sSql = "SELECT  count(*) as DocCount From DocumentBin Where DocumentID  IN (SELECT DocumentID From AuditMain.dbo.DocumentSubLinks)"
    Set rsDocCount = GetRecords(sSql, AdoConnDoc)
    With rsDocCount
        If Not .EOF Then
            sbrGrid.Panels.Item("CheckOutUser").MinWidth = 3500
            sbrGrid.Panels.Item("CheckOutUser").Visible = True
            sbrGrid.Panels.Item("CheckOutUser").Text = "Undefined Documents : " & Val(vsfgGeneral.Rows - 1) - Val(.Fields("DocCount"))
            sbrGrid.Panels.Item("CheckOutDate").MinWidth = 3800
            sbrGrid.Panels.Item("CheckOutDate").Visible = True
            sbrGrid.Panels.Item("CheckOutDate").Text = "Defined Documents : " & .Fields("DocCount")
        End If
    .Close
    End With
End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub SetExtPic(Row As Long, strExt As String, Optional Col As Long = -1)
On Local Error Resume Next
    If Col = -1 Then
      Col = cnstGridIcon
    End If
    strExt = LCase(strExt)
    Err.Clear
    vsfgGeneral.Cell(flexcpPicture, Row, Col) = Nothing
    vsfgGeneral.Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
    If Err.Number <> 0 Then
        vsfgGeneral.Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
    End If
End Sub

Private Sub SetPortObjects()
    arrControls(0) = "<TEXT>"
    arrControls(1) = "<LABEL>"
    arrControls(2) = "<GRID>"
    '------------------------
    arrProperties(0) = "<BOLD>"
    arrProperties(1) = "<ITALIC>"
    arrProperties(2) = "<UNDERLINE>"
    arrProperties(3) = "<FONTNAME>"
    arrProperties(4) = "<FONTSIZE>"
    arrProperties(5) = "<LEFT>"
    arrProperties(6) = "<TOP>"
    arrProperties(7) = "<WIDTH>"
    arrProperties(8) = "<HEIGHT>"
    arrProperties(9) = "<ROWS>"
    arrProperties(10) = "<COLS>"
    arrProperties(11) = "<GRIDDATA>"
    arrProperties(12) = "<CELL>"
    arrProperties(13) = "<COLWIDTH>"
    arrProperties(14) = "<COLALIGN>"
    arrProperties(15) = "<COLCOMBOLIST>"
    arrProperties(16) = "<VALUE>"
    arrProperties(17) = "<FIXEDROWS>"
End Sub

Private Sub Form_Load()
    SetPortObjects
End Sub

Private Sub Form_Resize()
    WindowState = vbMaximized
End Sub

Private Sub tbrBin_ButtonClick(ByVal Button As MSComctlLib.Button)
On Local Error Resume Next
    Select Case Button.Key
        Case "New"
            ShowDocument
        Case "Read"
            UpdateFieldDocIsRead vsfgGeneral.Row
        Case "All", "Defined", "Undefined"
            mstrGridDocSearchType = Button.Key
            RefreshBinGrid mstrGridDocSearchType, , txtGridGeneral(cnstGridtxtCompanyID).Text
    End Select
End Sub

Private Function UpdateFieldDocIsRead(Row As Long, Optional IsCheckOut As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "Select IsRead From DocumentBin Where  DocumentId  = " & vsfgGeneral.ValueMatrix(Row, cnstGridDocID)
    With GetRecords(sSql, AdoConnDoc)
        If Not .EOF Then
            If vsfgGeneral.ValueMatrix(Row, cnstGridIsRead) = False Or IsCheckOut = True Then
                .Fields("IsRead") = True
                 vsfgGeneral.TextMatrix(Row, cnstGridIsRead) = -1
            Else
               .Fields("IsRead") = False
                vsfgGeneral.TextMatrix(Row, cnstGridIsRead) = 0
            End If
        End If
        .Update
        .Close
    End With
    UpdateFieldDocIsRead = True
Exit Function
Err_Exit:
    UpdateFieldDocIsRead = False
End Function

Private Sub UpdateFieldDocIsCheckOut(ByVal Row As Integer)
On Local Error GoTo Err_Exit
Dim sSql As String, rsUpdateDoc As New Recordset, sFileName As String
    sSql = "Select IsCheckOut,CheckOutPath,FileName,CheckOutFileName,CheckOutUser,CheckOutDate,CheckInDate From DocumentBin Where  DocumentId  = " & Val(vsfgGeneral.TextMatrix(Row, cnstGridDocID))
    Set rsUpdateDoc = GetRecords(sSql, AdoConnDoc)
    With rsUpdateDoc
        If Not .EOF Then
            If Val(vsfgGeneral.TextMatrix(Row, cnstGridIsCheckOut)) = False Then
                .Fields("IsCheckOut") = True
                .Fields("CheckOutPath") = vsfgGeneral.TextMatrix(Row, cnstGridFilePath) ' mstrGridCheckOutPath
                .Fields("CheckOutFileName") = GetApplicationData("DocumentInc") & .Fields("FileName")
                'Add CheckOut User,Date...
                .Fields("CheckOutUser") = pUserID
                vsfgGeneral.TextMatrix(Row, cnstGridCheckOutUser) = pUserID
                .Fields("CheckOutDate") = ServerDateTime
                vsfgGeneral.TextMatrix(Row, cnstGridIsCheckOut) = -1
                tbrBin.Buttons.Item("CheckOut").Enabled = False
                tbrBin.Buttons.Item("CheckIn").Enabled = True
                tbrBin.Buttons.Item("Restore").Enabled = True
            Else
                .Fields("IsCheckOut") = False
                sFileName = .Fields("CheckOutPath") & "\"
                sFileName = sFileName & .Fields("CheckOutFileName")
                If Dir(sFileName) <> "" Then
                    Kill sFileName
                End If
                .Fields("CheckOutPath") = ""
                .Fields("CheckOutFileName") = ""
                .Fields("CheckInDate") = ServerDateTime
                vsfgGeneral.TextMatrix(Row, cnstGridIsCheckOut) = 0
                tbrBin.Buttons.Item("CheckOut").Enabled = True
                tbrBin.Buttons.Item("CheckIn").Enabled = False
                tbrBin.Buttons.Item("Restore").Enabled = False
            End If
        End If
    .Update
    .Close
    End With
Exit Sub
Err_Exit:
     ShowError
End Sub

Private Sub tbStripAuditReport_Click()
On Local Error Resume Next
    Select Case Val(tbStripAuditReport.SelectedItem.Tag)
        Case tabLeadSheet
            frameLeadsheet.ZOrder vbBringToFront
        Case tabRemarks
            frameRemarks.Visible = True
            frameRemarks.ZOrder vbBringToFront
        Case tabProcedures
            tbStripProcedures.Visible = True
            frameProcedures.Container = tbStripProcedures
            frameProcedures.Visible = True
            frameProcedures.ZOrder vbBringToFront
            tbStripProcedures_Click
        Case tabReviews
            frameReviews.Visible = True
            frameReviews.ZOrder vbBringToFront
        Case tabResources
            frameResources.Visible = True
            frameResources.ZOrder vbBringToFront
    End Select
End Sub

Private Sub tbstripFinancialStatements_Click()
On Local Error Resume Next
    Select Case Val(tbstripFinancialStatements.SelectedItem.Tag)
        Case tabBalanceSheet
            frameReporting.Visible = True
            vsfgReporting(cnstgrdBalanceSheet).ZOrder vbBringToFront
            PrintBalanceSheetRpt (mSenderPeriodID)
        Case tabProfitLoss
            frameReporting.Visible = True
            vsfgReporting(cnstgrdProfitLoss).ZOrder vbBringToFront
            PrintProfitLossRpt (mSenderPeriodID)
        Case tabLiquidity
            frameReporting.Visible = True
            vsfgReporting(cnstgrdLiquidity).ZOrder vbBringToFront
            ShowLiquidityRatios (mSenderPeriodID)
        Case tabProfitability
            frameReporting.Visible = True
            vsfgReporting(cnstgrdProfitability).ZOrder vbBringToFront
            ShowProfitabilityRatios (mSenderPeriodID)
    End Select
End Sub

Private Sub tbStripProcedures_Click()
On Local Error Resume Next
    mtbStripProcedures = tbStripProcedures.SelectedItem.Tag
'    If vsfgAuditReport(cnstGridProcedures).Rows = 1 Or vsfgAuditReport(cnstGridProcedures).Rows = 2 Then
'        FillPrimarySubSectionProcedures vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
'    Else
        FillSubSectionProcedures vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
'    End If
    With vsfgAuditReport(cnstGridProcedures)
        If mtbStripProcedures = 1 Then  'IC Questionnaire
            .ColWidth(grdProcedureSlNo) = GetProportionalValue(700, False)
            .ColWidth(grdProcedureQuestions) = GetProportionalValue(6200, False)
            .ColWidth(grdProcedureAnswer) = GetProportionalValue(1200, False)
            .ColWidth(grdProcedureFavourable) = GetProportionalValue(1000, False)
            .ColWidth(grdProcedureTemplate) = GetProportionalValue(1400, False)
            .ColWidth(grdProcedureRemarks) = GetProportionalValue(1600, False)
            .ColWidth(grdProcedureAttachments) = GetProportionalValue(1500, False)
            .ColWidth(grdProcedureReviews) = GetProportionalValue(300, False)
            
            .TextMatrix(0, grdProcedureSlNo) = "Sl No"
            .TextMatrix(0, grdProcedureQuestions) = "Questions"
            .TextMatrix(0, grdProcedureAnswer) = "Answer"
            .TextMatrix(0, grdProcedureFavourable) = "UnFav"
            .TextMatrix(0, grdProcedureTemplate) = "Templates"
            .TextMatrix(0, grdProcedureRemarks) = "Remarks"
            .TextMatrix(0, grdProcedureAttachments) = "Attach"
            .TextMatrix(0, grdProcedureReviews) = "Rev"

            .ColHidden(grdProcedureRemarks) = False
            .ColHidden(grdProcedureFavourable) = False
            .ColHidden(grdProcedureTemplate) = True

            FillSubSectionProcedures vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
            txtRemarks(txtProcedureRemarks).Text = ""
        Else                            'Audit Program
            .ColWidth(grdProcedureSlNo) = GetProportionalValue(700, False)
            .ColWidth(grdProcedureQuestions) = GetProportionalValue(5500, False)
            .ColWidth(grdProcedureAnswer) = GetProportionalValue(1200, False)
            .ColWidth(grdProcedureFavourable) = GetProportionalValue(1000, False)
            .ColWidth(grdProcedureTemplate) = GetProportionalValue(1400, False)
            .ColWidth(grdProcedureRemarks) = GetProportionalValue(2000, False)
            .ColWidth(grdProcedureAttachments) = GetProportionalValue(1500, False)
            .ColWidth(grdProcedureReviews) = GetProportionalValue(300, False)

            .TextMatrix(0, grdProcedureSlNo) = "Sl No"
            .TextMatrix(0, grdProcedureQuestions) = "Substantive Test"
            .TextMatrix(0, grdProcedureAnswer) = "Status"
            .TextMatrix(0, grdProcedureFavourable) = "UnFav"
            .TextMatrix(0, grdProcedureTemplate) = "Templates"
            .TextMatrix(0, grdProcedureRemarks) = "Remarks"
            .TextMatrix(0, grdProcedureAttachments) = "Attach"
            .TextMatrix(0, grdProcedureReviews) = "Rev"
            
            .ColHidden(grdProcedureTemplate) = False
            .ColHidden(grdProcedureRemarks) = False
            .ColHidden(grdProcedureFavourable) = True
            
            FillSubSectionProcedures vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
            txtRemarks(txtProcedureRemarks).Text = ""
        End If
    End With
End Sub

Private Sub txtPortTextParent_Change(Index As Integer)
    SaveStringData
End Sub

Private Sub txtPortTextParent_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    txtPortTextParent(Index).ToolTipText = txtPortTextParent(Index).Text
End Sub

Private Sub txtRemarks_Change(Index As Integer)
    Select Case Index
        Case txtleadsheetRemarks
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(vsfgAuditReport(cnstGridLeadSheet).Row, grdLeadSheetRemarks) = txtRemarks(txtleadsheetRemarks).Text
            vsfgAuditReport_AfterEdit cnstGridLeadSheet, vsfgAuditReport(cnstGridLeadSheet).Row, grdLeadSheetRemarks
        Case txtProcedureRemarks
            vsfgAuditReport(cnstGridProcedures).TextMatrix(vsfgAuditReport(cnstGridProcedures).Row, grdProcedureRemarks) = txtRemarks(txtProcedureRemarks).Text
            vsfgAuditReport_AfterEdit cnstGridProcedures, vsfgAuditReport(cnstGridProcedures).Row, grdProcedureRemarks
    End Select
End Sub

Private Sub vsfgAuditReport_AfterEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long)
Dim lngFavourable As String, lngForeColor As Long, lngAnswerID As Long
    Select Case Index
        Case cnstGridLeadSheet
            If Row > 0 Then
                Select Case Col
                    Case grdLeadSheetRemarks
                        SaveLeadSheetRemarks
                    Case grdLeadSheetReviewed
                        SaveLeadSheetReviews Row, vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
                End Select
            End If
        Case cnstGridProcedures
            If Row > 0 Then
                Select Case Col
                    Case grdProcedureAnswer
                        lngForeColor = Val(PickValue("ProcedureAnswers", "ForeColor", "Description = '" & vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureAnswer) & "' AND QuestionID =" & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)))
                        lngFavourable = Val(PickValue("ProcedureAnswers", "IsFavourable", "Description = '" & vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureAnswer) & "' AND QuestionID =" & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)))
                        If lngForeColor > 0 Then
                            vsfgAuditReport(Index).Cell(flexcpBackColor, Row, grdProcedureAnswer) = IIf(Val(lngForeColor & "") = 0, vbBlack, Val(lngForeColor & ""))
                        Else
                            vsfgAuditReport(Index).Cell(flexcpBackColor, Row, grdProcedureAnswer) = vbWhite
                        End If
                        vsfgAuditReport(Index).TextMatrix(Row, grdProcedureFavourable) = IIf(lngFavourable & "" = "True", -1, 0)
                    Case grdProcedureFavourable

                    Case grdProcedureRemarks
                        SaveProcedureRemarks
                End Select
            End If
            SaveSubSectionProcedures
        Case cnstGridRemarks
            If Row > 0 Then
                PutSlNo vsfgAuditReport(cnstGridRemarks), grdRemarksSlNo, grdRemarksObservations
                SaveRemarks
            End If
        Case cnstGridGeneralReviews
            If Row > 0 Then
                PutSlNo vsfgAuditReport(cnstGridGeneralReviews), grdGenReviewSlNo, grdGenReviews
'                SaveGeneralReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            End If
            If Col = grdGenReviews And Row = vsfgAuditReport(cnstGridGeneralReviews).Rows - 1 Then
                vsfgAuditReport(cnstGridGeneralReviews).Rows = vsfgAuditReport(cnstGridGeneralReviews).Rows + 1
            End If
        Case cnstGridResources
        
        Case cnstGridLegalDocuments
            PutSlNo vsfgAuditReport(cnstGridLegalDocuments), grdLegalDocSlNo, grdLegalDocDescription
    End Select
End Sub

Private Sub vsfgAuditReport_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
Dim lngProcedureID As Long
    Select Case Index
        Case cnstGridLeadSheet
            If Row > 0 Then
                Select Case Col
                    Case grdLeadSheetParticulars
                        Cancel = True
                    Case grdLeadSheetThisYear
                        Cancel = True
                    Case grdLeadSheetLastYear
                        Cancel = True
                    Case Else
                        Cancel = False
                End Select
            End If
        Case cnstGridProcedures
            If Row > 0 Then
                Select Case Col
                    Case grdProcedureAnswer
                        vsfgAuditReport(Index).ColComboList(Col) = vsfgAuditReport(Index).TextMatrix(Row, grdProcedureAnswers)
                    Case grdProcedureID
                        lngProcedureID = PickValue("ProcedureQuestions", "QuestionID", "Question = " & vsfgAuditReport(Index).TextMatrix(Row, grdProcedureQuestions))
                        vsfgAuditReport(Index).TextMatrix(Row, grdProcedureID) = lngProcedureID
                    Case grdProcedureFavourable
                        Cancel = True
                End Select
            End If
        Case cnstGridResources
            If Row > 0 Then
                            
            End If
        Case cnstGridGeneralReviews
            If Row > 0 Then
                Select Case Col
                    Case grdGenReviews
                        Cancel = False
                    Case Else
                        Cancel = True
                End Select
            End If
    End Select
End Sub

Private Sub vsfgAuditReport_CellButtonClick(Index As Integer, ByVal Row As Long, ByVal Col As Long)
Dim sSql As String, rsTmp As ADODB.Recordset, strFilePath As String, strExt As String, strFileName As String
Dim strWorkDirectory As String, strCheckOutPath As String, strTmpFileName As String, lngAcTypeID As Long, lngAcHeadID As Long
Dim sSqlFilter As String, strQuestionID As String, arrQIds() As String, Inc As Long, IncCount As Long, lngRow As Long
Dim lngResourceID As Long, lngLegalDocID As Long
    Select Case Index
        Case cnstGridProcedures
            If Row > 0 And Col = grdProcedureQuestions Then
                sSqlFilter = "0"
                With vsfgAuditReport(Index)
                    For Inc = 1 To .Rows - 1
                        If .ValueMatrix(Inc, grdProcedureID) <> 0 Then
                            sSqlFilter = sSqlFilter & ", " & .ValueMatrix(Inc, grdProcedureID)
                        End If
                    Next Inc
                End With
                sSqlFilter = "Where ProcedureQuestions.QuestionID In (Select QuestionID From ProcedureQuestionsSub WHERE SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & ") AND ProcedureQuestions.QuestionID Not In (" & sSqlFilter & " ) AND (Select Count(*) From ProcedureAnswers Where QuestionID = ProcedureQuestions.QuestionID) > 0 AND ProcedureQuestions.ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag)
                strQuestionID = PrepareAndFind(cnstSearchTypeGrpQuestions, sSqlFilter, , , , , , , True, "XQuestionID")
                If strQuestionID <> "" Then
                    arrQIds = Split(strQuestionID, "|")
                    For Inc = 0 To UBound(arrQIds)
                        If Val(arrQIds(Inc)) > 0 Then
                            IncCount = IncCount + 1
                            lngRow = Row
                            If IncCount > 1 Then
                                vsfgAuditReport(Index).AddItem "", Row + (IncCount - 1)
                                lngRow = Row + (IncCount - 1)
                            Else
                                DeleteSubSectionProcedures mSenderPeriodID, vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), _
                                    Val(tbStripProcedures.SelectedItem.Tag), vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)
                            End If
                            FillProcedures lngRow, Val(arrQIds(Inc))
                            PutSlNo vsfgAuditReport(Index), grdProcedureSlNo, grdProcedureQuestions
                        End If
                    Next Inc
                End If
                SaveSubSectionProcedures
            End If
            If Row > 0 And Col = grdProcedureTemplate Then
                If vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureTemplate) <> "" Then
                    strFileName = vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureTemplate)
                    strExt = GetExtension(strFileName, True) 'Mid(strFilename, InStr(1, strFilename, "."))
                    strWorkDirectory = GetApplicationData("WorkDirectory")
                    strCheckOutPath = GetApplicationData("CheckOutPath")
                    If Right(Trim(strWorkDirectory), 1) <> "\" Then
                        strWorkDirectory = strWorkDirectory & "\"
                    End If
                    If Right(Trim(strCheckOutPath), 1) <> "\" Then
                        strCheckOutPath = strCheckOutPath & "\"
                    End If
                    strTmpFileName = GetTickCount
                    strFilePath = strWorkDirectory & strTmpFileName & strExt
                    sSql = "SELECT TemplateFile, IsCheckedOut FROM SubSectionProcedures WHERE ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                           "AND    SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                           "AND    QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)
                    Set rsTmp = GetRecords(sSql)
                    If ExtractDocument(rsTmp, "TemplateFile", strFilePath) Then
                        Select Case Trim(UCase(strExt))
                        Case ".XLS", ".XLSX", ".JPG", ".BMP", ".GIF"
                            ShowFile strExt, strFilePath, vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureTemplate), vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID), Val(tbStripProcedures.SelectedItem.Tag), vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
                        Case Else
                            Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
                        End Select
                    End If
                End If
            End If
            If Row > 0 And Col = grdProcedureAttachments And vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdProcedureID) <> 0 Then
                ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "PROCEDURE", vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdProcedureID)
                DisplayProcedureAttachmentsAndReviews
            End If
            If Row > 0 And Col = grdProcedureReviews Then
                ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "PROCEDURE", vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdProcedureID)
                DisplayProcedureAttachmentsAndReviews
            End If
        Case cnstGridLeadSheet
            If Row > 0 And (Col = grdLeadSheetAttachments Or Col = grdLeadSheetReviews) Then
                lngAcTypeID = vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdLeadSheetAcTypeId)
                If lngAcTypeID = 0 Then
                    lngAcHeadID = vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdLeadSheetAcID)
                End If
                If Col = grdLeadSheetReviews Then
                    If lngAcTypeID <> 0 Then
                        ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "ACCOUNTTYPE", lngAcTypeID
                        DisplayLeadSheetAttachmentsAndReviews
                    ElseIf lngAcHeadID <> 0 Then
                        ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "ACCOUNTHEAD", lngAcHeadID
                        DisplayLeadSheetAttachmentsAndReviews
                    End If
                Else
                    If lngAcTypeID <> 0 Then
                        ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "ACCOUNTTYPE", lngAcTypeID
                        DisplayLeadSheetAttachmentsAndReviews
                    ElseIf lngAcHeadID <> 0 Then
                        ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "ACCOUNTHEAD", lngAcHeadID
                        DisplayLeadSheetAttachmentsAndReviews
                    End If
                End If
                FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            End If
        Case cnstGridDocuments
        
        Case cnstGridResources
            If Col = grdResourcesFile Then
                ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "RESOURCES", lngResourceID
            
            End If
        Case cnstGridRemarks
            If Row > 0 And Col = grdRemarksActions Then
                ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            Else
                PutSlNo vsfgAuditReport(cnstGridRemarks), grdRemarksSlNo, grdRemarksObservations
            End If
        Case cnstGridGeneralReviews
            If Col = grdGenReviews Then
                ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            End If
        Case cnstGridLegalDocuments
            If Row > 0 And Col = grdLegalDocAttachments Then
                lngLegalDocID = vsfgAuditReport(Index).ValueMatrix(vsfgAuditReport(Index).Row, grdLegalDocSlNo)
                ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, "LEGALDOCS", lngLegalDocID, vsfgAuditReport(cnstGridLegalDocuments).TextMatrix(vsfgAuditReport(cnstGridLegalDocuments).Row, grdLegalDocDescription), vsfgAuditReport(cnstGridLegalDocuments).TextMatrix(vsfgAuditReport(cnstGridLegalDocuments).Row, grdLegalDocRemarks)
            End If
    End Select
End Sub

Private Sub vsfgAuditReport_Click(Index As Integer)
On Local Error Resume Next
Dim lngID As Long, strType As String
    With vsfgAuditReport(Index)
        Select Case Index
            Case cnstGridLeadSheet
                If .Row > 0 Then
                    If .ValueMatrix(.Row, grdLeadSheetAcID) <> 0 Then
                        lngID = .ValueMatrix(.Row, grdLeadSheetAcID)
                        strType = "ACCOUNTHEAD"
                    End If
                    If .ValueMatrix(.Row, grdLeadSheetAcTypeId) <> 0 And lngID = 0 Then
                        lngID = .ValueMatrix(.Row, grdLeadSheetAcTypeId)
                        strType = "ACCOUNTTYPE"
                    End If
                    If lngID <> 0 Then
                        FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, strType, lngID
                    End If
                    txtRemarks(txtleadsheetRemarks).Text = .TextMatrix(.Row, grdLeadSheetRemarks)
                End If
            Case cnstGridProcedures
                If .Row > 0 Then
                   If .ValueMatrix(.Row, grdProcedureID) <> 0 Then
                       lngID = .ValueMatrix(.Row, grdProcedureID)
                       strType = "PROCEDURE"
                   End If
                   If lngID <> 0 Then
                       FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, strType, lngID
                   End If
                   txtRemarks(txtProcedureRemarks).Text = .TextMatrix(.Row, grdProcedureRemarks)
                End If
            Case cnstGridGeneralReviews
                If .Row > 0 Then
                    txtGenReview = .TextMatrix(.Row, grdGenReviews)
                    txtGenRevReply = .TextMatrix(.Row, grdGenReviewReply)
                End If
        End Select
    End With
End Sub

Private Sub vsfgAuditReport_DblClick(Index As Integer)
On Local Error Resume Next
Dim sSql As String, strFileName As String, strExt As String, strTmpFileName As String, IsCheckOut As Boolean
Dim strWorkDirectory As String, strCheckOutPath As String, strFilePath As String, Inc As Long
    With vsfgAuditReport(Index)
        Select Case Index
        Case cnstGridDocuments
            OpenExternalDocument
'                ShowDocumentLinks .ValueMatrix(grdDocumentRowDocLinkID, .Col)
        Case cnstGridResources
            LoadAndOpenResourceFile vsfgAuditReport(cnstGridResources).Row, vsfgAuditReport(cnstGridResources).Col
        End Select
    End With
End Sub

Public Sub OpenExternalDocument()
On Local Error Resume Next
    With vsfgAuditReport(cnstGridDocuments)
        OpenDocumentFile .TextMatrix(grdDocumentRowFileName, .Col), .ValueMatrix(grdDocumentRowDocumentID, .Col)
    End With
End Sub

Private Sub vsfgAuditReport_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    Select Case Index
        Case cnstGridLeadSheet
            KeyShortCuts Index, KeyCode, Shift
        Case cnstGridProcedures
            KeyShortCuts Index, KeyCode, Shift
'            If KeyCode = vbKeyDelete Then
'                If vsfgAuditReport(cnstGridProcedures).Row > 0 Then
'                    If DeleteSubSectionProcedures(mSenderPeriodID, vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), _
'                                                Val(tbStripProcedures.SelectedItem.Tag), vsfgAuditReport(cnstGridProcedures).ValueMatrix(vsfgAuditReport(cnstGridProcedures).Row, grdProcedureID), True) Then
'                        vsfgAuditReport(cnstGridProcedures).RemoveItem (vsfgAuditReport(cnstGridProcedures).Row)
'                    End If
'                    PutSlNo vsfgAuditReport(cnstGridProcedures), grdProcedureSlNo, grdProcedureID
'                End If
'            End If
        Case cnstGridGeneralReviews
            KeyShortCuts Index, KeyCode, Shift
'            If KeyCode = vbKeyDelete Then
'                If vsfgAuditReport(cnstGridGeneralReviews).Row > 0 Then
'                    If DeleteSectionReviews(vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), vsfgAuditReport(cnstGridGeneralReviews).ValueMatrix(vsfgAuditReport(cnstGridGeneralReviews).Row, grdGenReviewID), True) Then
'                        vsfgAuditReport(cnstGridGeneralReviews).RemoveItem (vsfgAuditReport(cnstGridGeneralReviews).Row)
'                    End If
'                    PutSlNo vsfgAuditReport(cnstGridGeneralReviews), grdGenReviewSlNo, grdGenReviews
'                End If
'            End If
    End Select
End Sub

Public Function DeleteSubSectionProcedures(lngPeriodID As Long, lngSubSectionID As Long, lngProcedureTypeID As Long, lngQuestionID As Long, Optional IsMsg As Boolean = False) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, IsDelete As Boolean
    If IsMsg Then
        IsDelete = pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True)
    Else
        IsDelete = True
    End If
    If IsDelete Then
        AdoConn.BeginTrans
        sSql = "Delete from SubSectionProcedures Where PeriodID = " & lngPeriodID & " AND SubSectionID = " & lngSubSectionID & _
               " AND ProcedureTypeID = " & lngProcedureTypeID & " AND QuestionID = " & lngQuestionID
        AdoConn.Execute sSql
        AdoConn.CommitTrans
        DeleteSubSectionProcedures = True
        Exit Function
    End If
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
End Function

Private Sub vsfgAuditReport_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
Dim sSql As String, rsTmp As New Recordset
    Select Case Index
        Case cnstGridProcedures
            If vsfgAuditReport(Index).Rows > 0 And vsfgAuditReport(Index).Col = grdProcedureTemplate Then
                sSql = "Select  TemplateFile, IsCheckedOut From SubSectionProcedures Where ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                       "AND     SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                       "AND     QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(vsfgAuditReport(cnstGridProcedures).Row, grdProcedureID)
                Set rsTmp = GetRecords(sSql)
                If vsfgAuditReport(Index).TextMatrix(vsfgAuditReport(Index).Row, grdProcedureTemplate) <> "" Then
                    If rsTmp.Fields("IsCheckedOut") & "" = True Then
                        MDIFormMain.mnuPopupCheckInDocument.Enabled = True
                        MDIFormMain.mnuPopupCheckOutDocument.Enabled = False
                    Else
                        MDIFormMain.mnuPopupCheckInDocument.Enabled = False
                        MDIFormMain.mnuPopupCheckOutDocument.Enabled = True
                    End If
                    If Button = vbRightButton Then
                        PopupMenu MDIFormMain.mnuPopupProcedureDocuments
                    End If
                End If
            End If
        Case cnstGridDocuments
            If vsfgAuditReport(Index).Row >= 0 Then
                If vsfgAuditReport(Index).TextMatrix(1, vsfgAuditReport(Index).Col) <> "" Then
                    If Button = vbRightButton Then
                        PopupMenu MDIFormMain.mnuPopupExternalDocuments
                    End If
                End If
            End If
    End Select
End Sub

Public Sub OpenTemplateDocuments()
On Local Error GoTo Err_Exit
Dim Row As Long, strFilePath As String, sSql As String
Dim strFileName As String, strExt As String, strWorkDirectory As String, strTmpFileName As String
    With vsfgAuditReport(cnstGridProcedures)
        Row = .Row
        If .TextMatrix(Row, grdProcedureTemplate) <> "" Then
            strFileName = .TextMatrix(Row, grdProcedureTemplate)
            strExt = GetExtension(strFileName, True) 'Mid(strFilename, InStr(1, strFilename, "."))
            strWorkDirectory = GetApplicationData("WorkDirectory")
            If Right(Trim(strWorkDirectory), 1) <> "\" Then
                strWorkDirectory = strWorkDirectory & "\"
            End If
            strTmpFileName = GetTickCount
            strFilePath = strWorkDirectory & strTmpFileName & strExt

            sSql = "Select    TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                   "AND       SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                   "AND       QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)

            If ExtractDocument(GetRecords(sSql), "TemplateFile", strFilePath) Then
                Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
            End If
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub CheckOutTemplateDocuments()
On Local Error GoTo Err_Exit
Dim Row As Long, strFilePath As String, sSql As String
Dim strFileName As String, strExt As String, strCheckOutPath As String, strTmpFileName As String
    With vsfgAuditReport(cnstGridProcedures)
        Row = .Row
        If .TextMatrix(Row, grdProcedureTemplate) <> "" Then
            strFileName = vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureTemplate)
            strExt = GetExtension(strFileName, True) 'Mid(strFilename, InStr(1, strFilename, "."))
            strCheckOutPath = GetApplicationData("CheckOutPath")
            If Right(Trim(strCheckOutPath), 1) <> "\" Then
                strCheckOutPath = strCheckOutPath & "\"
            End If
            strTmpFileName = GetTickCount
            strFilePath = strCheckOutPath & strTmpFileName & " - " & GetCompanyAndPeriodName(mSenderPeriodID) & vsfgAuditReport(cnstGridProcedures).TextMatrix(Row, grdProcedureTemplate)

            sSql = "Select TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                   "AND    SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                   "AND    QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)

            If ExtractDocument(GetRecords(sSql), "TemplateFile", strFilePath) Then
                sSql = "Update SubSectionProcedures Set IsCheckedOut = 1 Where ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                       "AND    SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                       "AND    QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)
                AdoConn.Execute sSql
                vsfgAuditReport(cnstGridProcedures).Cell(flexcpBackColor, Row, grdProcedureTemplate) = RGB(150, 150, 150)
                If pMVE.MsgBox("Template checked out to '" & strFilePath & ". Do you want to open?", msgYesNo, "AuditMate", msgQuestion, True) Then
                    Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
                End If
            End If
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub CheckOutExternalDocuments()
On Local Error GoTo Err_Exit
Dim Col As Long, strFilePath As String, sSql As String
Dim strFileName As String, strExt As String, strCheckOutPath As String, strTmpFileName As String
    With vsfgAuditReport(cnstGridDocuments)
        Col = .Col
        If .TextMatrix(3, Col) <> "" Then
            strFileName = .TextMatrix(3, Col)
            strExt = GetExtension(strFileName, True) 'Mid(strFilename, InStr(1, strFilename, "."))
            strCheckOutPath = GetApplicationData("CheckOutPath")
            If Right(Trim(strCheckOutPath), 1) <> "\" Then
                strCheckOutPath = strCheckOutPath & "\"
            End If
            strTmpFileName = GetTickCount
            strFilePath = strCheckOutPath & strTmpFileName & " - " & GetCompanyAndPeriodName(mSenderPeriodID) & .TextMatrix(3, Col)

            sSql = "SELECT DocFile From DocumentBin Where DocumentID = " & .ValueMatrix(2, Col)
            If ExtractDocument(GetRecords(sSql, AdoConnDoc), "DocFile", strFilePath) Then
                sSql = "Update DocumentBin Set IsCheckOut = 1 Where DocumentID = " & .ValueMatrix(2, Col)
                AdoConnDoc.Execute sSql

                .Cell(flexcpBackColor, 0, Col, 1, Col) = RGB(150, 150, 150)
                If pMVE.MsgBox("Document checked out to '" & strFilePath & ". Do you want to open?", msgYesNo, "AuditMate", msgQuestion, True) Then
                    Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
                End If
            End If
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub CheckInTemplateDocuments()
On Local Error GoTo Err_Exit
Dim Row As Long, strFilePath As String, sSql As String
Dim mStream As ADODB.Stream, strCheckOutPath As String
Dim strFileName As String, strExt As String, strTmpFileName As String
    With vsfgAuditReport(cnstGridProcedures)
        Row = .Row
        If .TextMatrix(Row, grdProcedureTemplate) <> "" Then
            strCheckOutPath = GetApplicationData("CheckOutPath")
            CD.InitDir = strCheckOutPath
            CD.ShowOpen
            strFilePath = CD.FileName
            If Dir(strFilePath) <> "" And Trim(strFilePath) <> "" Then
                sSql = "Select TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                        "AND   SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                        "AND   QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)
                With GetRecords(sSql)
                    If Not .EOF Then
                        Set mStream = New ADODB.Stream
                        mStream.Type = adTypeBinary
                        mStream.Open
                        mStream.LoadFromFile strFilePath
                        .Fields("TemplateFile").Value = mStream.Read
                        .Update
                        sSql = "UPDATE SubSectionProcedures SET IsCheckedOut = 0 WHERE ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
                               "AND    SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & " And PeriodID = " & mSenderPeriodID & _
                               "AND    QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Row, grdProcedureID)
                        AdoConn.Execute sSql
                        vsfgAuditReport(cnstGridProcedures).Cell(flexcpBackColor, Row, grdProcedureTemplate) = RGB(255, 255, 255)
'                        pMVE.MsgBox "Document checked in from '" & strFilePath & ".", msgOK, , msgInformation, True
                        KillFile strFilePath
                    End If
                End With
            End If
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub CheckInExternalDocuments()
On Local Error GoTo Err_Exit
Dim Col As Long, strFilePath As String, sSql As String
Dim mStream As ADODB.Stream
Dim strFileName As String, strExt As String, strCheckOutPath As String, strTmpFileName As String
    With vsfgAuditReport(cnstGridDocuments)
        Col = .Col
        If .TextMatrix(3, Col) <> "" Then
            CD.ShowOpen
            strFilePath = CD.FileName
            If Dir(strFilePath) <> "" And Trim(strFilePath) <> "" Then
                sSql = "Select DocFile, FileExt, FileName From DocumentBin Where DocumentID = " & .ValueMatrix(2, Col)
                With GetRecords(sSql, AdoConnDoc)
                    If Not .EOF Then
                        Set mStream = New ADODB.Stream
                        mStream.Type = adTypeBinary
                        mStream.Open
                        mStream.LoadFromFile strFilePath
                        .Fields("DocFile").Value = mStream.Read
                        .Fields("FileName") = Dir(strFilePath)
                        .Fields("FileExt") = GetExtension(.Fields("FileName"))
                        .Update
                        sSql = "Update DocumentBin Set IsCheckOut = 0 Where DocumentID = " & vsfgAuditReport(cnstGridDocuments).ValueMatrix(2, Col)
                        AdoConnDoc.Execute sSql
'                        If Val(.Fields("IsCheckOut") & "") = 0 Then
'                            MDIFormMain.mnuPopupCheckInExternalDocument.Enabled = False
'                        End If
                        vsfgAuditReport(cnstGridDocuments).Cell(flexcpBackColor, 0, Col, 1, Col) = RGB(255, 255, 255)
                        pMVE.MsgBox "Document checked in from '" & strFilePath & ".", msgOK, "AuditMate", msgInformation, True
                        KillFile strFilePath
                    End If
                End With
            End If
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub KillFile(strFileName As String)
On Local Error Resume Next
    Kill strFileName
End Sub

Public Function GetCompanyAndPeriodName(lngPeriodID As Long) As String
On Local Error GoTo Err_Exit
Dim sSql As String
    GetCompanyAndPeriodName = ""
    sSql = "SELECT CMP.JobCode, PER.Description FROM Periods PER INNER JOIN " & _
           "Companies CMP ON PER.CompanyID = CMP.CompanyID Where (PER.PeriodID = " & lngPeriodID & ")"
    With GetRecords(sSql)
        If Not .EOF Then
            GetCompanyAndPeriodName = .Fields("JobCode") & " - " & .Fields("Description") & " "
        End If
        .Close
    End With
Exit Function
Err_Exit:
    GetCompanyAndPeriodName = ""
End Function

Private Sub vsfgAuditReport_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If vsfgAuditReport(cnstGridResources).Col = grdResourcesFile Then
        vsfgAuditReport(cnstGridResources).MousePointer = flexHand
    Else
        vsfgAuditReport(cnstGridResources).MousePointer = flexArrow
    End If
    vsfgAuditReport(cnstGridResources).ToolTipText = vsfgAuditReport(cnstGridResources).Text
    vsfgAuditReport(Index).ToolTipText = vsfgAuditReport(Index).Text
End Sub

Private Sub vsfgAuditReport_RowColChange(Index As Integer)
    vsfgAuditReport_Click Index
End Sub

Private Sub vsfgGeneral_AfterScroll(ByVal OldTopRow As Long, ByVal OldLeftCol As Long, ByVal NewTopRow As Long, ByVal NewLeftCol As Long)
    SetIconAndDefaults
End Sub

Private Sub vsfgGeneral_AfterSort(ByVal Col As Long, Order As Integer)
    SetIconAndDefaults
End Sub

Private Sub SetIconAndDefaults()
On Local Error GoTo Err_Exit
Dim iCounterRow As Long
    mstrCheckOutPath = GetApplicationData("CheckOutPath")
    With vsfgGeneral
        For iCounterRow = vsfgGeneral.TopRow To vsfgGeneral.Rows - 1
            If vsfgGeneral.RowIsVisible(iCounterRow) Then
                 SetExtPic iCounterRow, .TextMatrix(iCounterRow, cnstGridIcon) & ""
                 SetExtPic iCounterRow, "folder", cnstGridBrowse
                .Cell(flexcpFontUnderline, 1, cnstGridFileName, iCounterRow, cnstGridFileName) = True
                .Cell(flexcpForeColor, 1, cnstGridFileName, iCounterRow, cnstGridFileName) = &HFF0000
                If .Row > 0 Then
                    If .TextMatrix(iCounterRow, cnstGridFilePath) = "" Then
                        .TextMatrix(iCounterRow, cnstGridFilePath) = mstrCheckOutPath
                    End If
                    If Val(.TextMatrix(iCounterRow, cnstGridIsRead)) = True Then
                        .Cell(flexcpFontBold, iCounterRow, 0, iCounterRow, cnstGridCols - 1) = False
                    Else
                        .Cell(flexcpFontBold, iCounterRow, 0, iCounterRow, cnstGridCols - 1) = True
                    End If
                End If
            Else
                Exit For
            End If
        Next iCounterRow
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgGeneral_Click()
On Local Error Resume Next
    If vsfgGeneral.Col = cnstGridBrowse Then
        With vsfgGeneral
           txtGridGeneral(cnstGridBrowse).Text = BrowShow(txtGridGeneral(cnstGridBrowse).hWnd, , , , , .TextMatrix(.Row, cnstGridFilePath))
            If txtGridGeneral(cnstGridBrowse).Text <> "" Then
                 mstrCheckOutPath = txtGridGeneral(cnstGridBrowse).Text
                .TextMatrix(.Row, cnstGridFilePath) = txtGridGeneral(cnstGridBrowse).Text
            End If
        End With
    End If
        txtGridGeneral(cnstGridtxtCompanyID).Text = vsfgGeneral.TextMatrix(vsfgGeneral.Row, vsfgGeneral.Col)
        txtGridGeneral(cnstGridtxtCompanyID).Tag = vsfgGeneral.TextMatrix(0, vsfgGeneral.Col)
        mlnGridDocID = Val(vsfgGeneral.TextMatrix(vsfgGeneral.Row, cnstGridDocID))
        mstrGridCheckOutPath = vsfgGeneral.TextMatrix(vsfgGeneral.Row, cnstGridFilePath)
End Sub

Private Sub vsfgGeneral_DblClick()
    LoadAndOpenFile vsfgGeneral.Row, vsfgGeneral.Col
End Sub

Private Sub LoadAndOpenFile(ByVal Row As Integer, ByVal Col As Integer, Optional IsCheckOut As Boolean = False)
On Local Error Resume Next
Dim sSql As String, strFileName As String, strTmpFileName As String
Dim strExt As String, strWorkDirectory As String, strCheckOutPath As String
Dim strFilePath As String
    Select Case Col
        Case cnstGridFileName, cnstGridIcon
            strFileName = vsfgGeneral.TextMatrix(Row, cnstGridFileName)
            strExt = GetExtension(strFileName, True)
            strWorkDirectory = GetApplicationData("WorkDirectory")
            strCheckOutPath = GetApplicationData("CheckOutPath")
            If Right(Trim(strWorkDirectory), 1) <> "\" Then
                strWorkDirectory = strWorkDirectory & "\"
            End If
            If Right(Trim(strCheckOutPath), 1) <> "\" Then
                strCheckOutPath = strCheckOutPath & "\"
            End If
            If strFileName <> "" Then
                ClearTempFiles strWorkDirectory
            Else
                strFileName = App.Path
            End If
            strTmpFileName = GetTickCount
            sSql = "SELECT DocFile FROM DocumentBin WHERE  DocumentID = " & vsfgGeneral.ValueMatrix(Row, cnstGridDocID)
            If IsCheckOut = True Then
                strFilePath = strCheckOutPath & strTmpFileName & strFileName
            Else
                strFilePath = strWorkDirectory & strTmpFileName & strExt
            End If
            'Extracting the file
            If ExtractDocument(GetRecords(sSql, AdoConnDoc), "DocFile", strFilePath) Then
                Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
                'Marking as read
                UpdateFieldDocIsRead Val(Row), IsCheckOut
            End If
         Case Else
            ShowDocument vsfgGeneral.ValueMatrix(vsfgGeneral.Row, cnstGridDocID)
    End Select
End Sub

Private Function RetrieveAndSaveFile(Row As Long) As Boolean
Dim txtFilename As String, rsSave As Recordset
    Set rsSave = GetRecords("Select * From  DocumentBin Where DocumentID = " & vsfgGeneral.TextMatrix(Row, cnstGridDocID), AdoConnDoc)
    With rsSave
        If Not .EOF Then
            txtFilename = .Fields("CheckOutPath").Value & "\"
            txtFilename = txtFilename & .Fields("CheckOutFileName").Value & ""
            Set mStream = New ADODB.Stream
            mStream.Type = adTypeBinary
            mStream.Open
            If Dir(txtFilename) <> "" Then
                mStream.LoadFromFile txtFilename
                .Fields("Docfile").Value = mStream.Read
                SaveDateAndUser rsSave, False 'IsNew
                Kill (txtFilename)
                .Update
                RetrieveAndSaveFile = True
                pMVE.MsgBox "Document Uploaded Successfully.", msgOK, "AuditMate", msgInformation, True
            Else
                ShowError "File doesn't exist !!!...."
                RetrieveAndSaveFile = False
            End If
         .Close
        End If
    End With
End Function

Private Sub vsfgGeneral_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If vsfgGeneral.Col = cnstGridFileName Then
        vsfgGeneral.MousePointer = flexHand
    Else
        vsfgGeneral.MousePointer = flexArrow
    End If
    vsfgGeneral.ToolTipText = vsfgGeneral.Text
End Sub

Private Sub vsfgGeneral_SelChange()
  sbrGrid.Panels.Item("CheckOutDate").Visible = False
  sbrGrid.Panels.Item("CheckOutUser").Visible = False
    If Val(vsfgGeneral.TextMatrix(vsfgGeneral.Row, cnstGridIsCheckOut)) <> 0 Then
      sbrGrid.Panels.Item("CheckOutUser").MinWidth = 3500
      sbrGrid.Panels.Item("CheckOutUser").Text = "CheckOut User : " & GetCheckOutUser(Val(vsfgGeneral.TextMatrix(vsfgGeneral.Row, cnstGridCheckOutUser))) & ""
      sbrGrid.Panels.Item("CheckOutUser").Visible = True
      sbrGrid.Panels.Item("CheckOutDate").MinWidth = 3700
      sbrGrid.Panels.Item("CheckOutDate").Text = "CheckOut Date : " & vsfgGeneral.TextMatrix(vsfgGeneral.Row, cnstGridCheckOutDate) '14/10/2007 12.01"
      sbrGrid.Panels.Item("CheckOutDate").Visible = True
   End If
End Sub

Private Sub vsfgPortGridParent_AfterEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long)
Dim Inc As Long, IsNewRow As Boolean
    SaveStringData
    With vsfgPortGridParent(Index)
        '---For adding new row--------
        If .Row = .Rows - 1 Then
            For Inc = 0 To .Cols - 1
                If .Cell(flexcpBackColor, .Row, Inc) = pclrRestrictionColor Then
                    IsNewRow = False
                    Exit For
                End If
                If Trim(.TextMatrix(.Row, Inc)) <> "" Then
                    IsNewRow = True
                End If
            Next Inc
            If IsNewRow Then
                .Rows = .Rows + 1
            End If
        End If
        '---For auto resize--------
        .AutoSizeMode = flexAutoSizeRowHeight
        .AutoSize Col
    End With
    
End Sub

Public Sub SaveStringData()
On Local Error GoTo Err_Exit
Dim lngSubSectionID As Long, mPeriodID As Long
Dim IsTran As Boolean, sSql As String, lngSlNo As Long
Dim strData As String, strData1 As String, strData2 As String
    If IsInFillString Then Exit Sub
    '--------------------------------
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    mPeriodID = mSenderPeriodID
    If lngSubSectionID <= 0 Or mPeriodID <= 0 Then
        Exit Sub
    End If
    '--------------------------------
    strData = ReadStringData
    strData1 = Left(strData, 7500)
    If Len(strData) > 7500 Then
        strData = Right(strData, Len(strData) - 7500)
    Else
        strData = ""
    End If
    AdoConn.BeginTrans
    IsTran = True
    sSql = "Delete from SubSectionDataExtension Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mPeriodID
    AdoConn.Execute sSql
    If Len(strData1) <> 0 Then
        sSql = "Select * from SubSectionData Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mPeriodID
        With GetRecords(sSql)
            If .EOF Then
                .AddNew
            End If
            .Fields("PeriodID") = mPeriodID
            .Fields("SubSectionID") = lngSubSectionID
            .Fields("Data") = strData1
            .Fields("IsTemplate") = IsTemplate
            .Update
            .Close
        End With
    End If
    While Not (Len(strData) = 0)
        If Len(strData) > 7500 Then
            strData = Right(strData, Len(strData) - 7500)
            strData2 = Left(strData, 7500)
        Else
            strData2 = strData
            strData = ""
        End If
        lngSlNo = lngSlNo + 1
        sSql = "Select * from SubSectionDataExtension Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mPeriodID
        With GetRecords(sSql)
            If .EOF Then
                .AddNew
            End If
            .Fields("PeriodID") = mPeriodID
            .Fields("SubSectionID") = lngSubSectionID
            .Fields("SubSlNo") = lngSlNo
            .Fields("DataExtension") = strData2
            .Update
            .Close
        End With
    Wend
    AdoConn.CommitTrans
Exit Sub
Err_Exit:
    If IsTran Then
        AdoConn.RollbackTrans
    End If
End Sub

Private Sub vsfgPortGridParent_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If vsfgPortGridParent(Index).Cell(flexcpBackColor, Row, Col) = pclrRestrictionColor Then
        Cancel = True
    End If
End Sub

Private Sub vsfgPortGridParent_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgPortGridParent(Index).ToolTipText = vsfgPortGridParent(Index).Text
End Sub

Private Sub vsfgReporting_AfterEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long)
    Select Case Index
        Case cnstgrdBalanceSheet
            If Row > 0 Then
                Select Case Col
                    Case grdBalSheetRemarks
                        SaveBalSheetRemarks
                End Select
            End If
        Case cnstgrdProfitLoss
            If Row > 0 Then
                Select Case Col
                    Case grdPLRemarks
                        SaveIncomeRemarks
                End Select
            End If
        Case cnstgrdLiquidity
            If Row > 0 Then
                Select Case Col
                    Case grdLiquidityRemarks
                        SaveLiquidityRemarks
                End Select
            End If
        Case cnstgrdProfitability
            If Row > 0 Then
                Select Case Col
                    Case grdProfitabilityRemarks
                        SaveProfitabilityRemarks
                End Select
            End If
    End Select
End Sub

Private Sub vsfgReporting_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Select Case Index
        Case cnstgrdBalanceSheet
            If Row > 0 Then
                Select Case Col
                    Case grdBalSheetParticulars
                        Cancel = True
                    Case grdBalSheetThisYr
                        Cancel = True
                    Case grdBalSheetLastYr
                        Cancel = True
                    Case grdBalSheetDiffPercent
                        Cancel = True
                    Case grdBalSheetDifference
                        Cancel = True
                End Select
            End If
        Case cnstgrdProfitLoss
            If Row > 0 Then
                Select Case Col
                    Case grdPLParticulars
                        Cancel = True
                    Case grdPLThisYr
                        Cancel = True
                    Case grdPLLastYr
                        Cancel = True
                    Case grdPLDiffPercent
                        Cancel = True
                    Case grdPLDifference
                        Cancel = True
                End Select
            End If
        Case cnstgrdLiquidity
            If Row > 0 Then
                Select Case Col
                    Case grdLiquidityRatio
                        Cancel = True
                    Case grdLiquidityThisYr
                        Cancel = True
                    Case grdLiquidityLastYr
                        Cancel = True
                End Select
            End If
        Case cnstgrdProfitability
            If Row > 0 Then
                Select Case Col
                    Case grdProfitabilityRatio
                        Cancel = True
                    Case grdProfitabilityThisYr
                        Cancel = True
                    Case grdProfitabilityLastYr
                        Cancel = True
                End Select
            End If
    End Select
End Sub

Private Sub vsfgReporting_Click(Index As Integer)
    vsfgReporting(Index).ToolTipText = vsfgReporting(Index).Text
End Sub

Private Sub vsfgSections_Click()
On Local Error Resume Next
Dim Inc As Long
    For Inc = 1 To vsfgSections.Rows - 1
        vsfgSections.Cell(flexcpBackColor, Inc, 0) = &H800000
        If vsfgSections.Cell(flexcpBackColor, Inc, 0) = &H800000 Then
            vsfgSections.Cell(flexcpForeColor, Inc, 0) = &HECFFFF                   '&HC0FFFF
        Else
            vsfgSections.Cell(flexcpForeColor, Inc, 0) = &H80000012
        End If
    Next Inc
    ShowSubSections vsfgSections.ValueMatrix(vsfgSections.Row, 1)
    SaveSetting App.Title, App.Title, "LastFileSection", vsfgSections.Row
    vsfgSubSections.Col = 0
    vsfgSubSections.Row = 0
    vsfgSubSections_Click
    '--- Ref No: 027-23/06/08 ---
    frameLeadsheet.ZOrder vbBringToFront
    '--- Ref No: 047-09/11/08
    If PickValue("FilingSections", "Description", "SectionID = " & vsfgSections.TextMatrix(vsfgSections.Row, 1)) & "" = "Planning" Then
        vsfgAuditReport(cnstGridDocuments).Visible = True
        FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
    End If
End Sub

Private Sub vsfgSections_RowColChange()
On Local Error Resume Next
Dim Inc As Long
    If vsfgSections.Row < 1 Then Exit Sub
    For Inc = 0 To vsfgSections.Rows - 1
        vsfgSections.TextMatrix(Inc, 0) = Replace(vsfgSections.TextMatrix(Inc, 0), ">   ", "")
    Next Inc
    vsfgSections.TextMatrix(vsfgSections.Row, 0) = ">   " & vsfgSections.TextMatrix(vsfgSections.Row, 0)
End Sub

Private Sub vsfgSubSections_Click()
On Local Error Resume Next
Dim Inc As Long, lngReportID As Long
Dim lngRow As Long
    lngRow = vsfgSubSections.Row
    frameDetails.BackColor = vsfgSubSections.BackColor
    vsfgSubSections.Cell(flexcpBackColor, vsfgSubSections.Row, vsfgSubSections.Col) = &H800000
    vsfgSubSections.Cell(flexcpForeColor, vsfgSubSections.Row, vsfgSubSections.Col) = &HECFFFF           '&HC0FFFF
    vsfgSubSections.Cell(flexcpFontBold, vsfgSubSections.Row, vsfgSubSections.Col) = True
    For Inc = 0 To vsfgSubSections.Cols - 1
        If Inc <> vsfgSubSections.Col Then
            vsfgSubSections.Cell(flexcpBackColor, 0, Inc) = &HECFFFF               '&HC0FFFF
            vsfgSubSections.Cell(flexcpFontBold, 0, Inc) = False
            vsfgSubSections.Cell(flexcpForeColor, 0, Inc) = &H0&
        End If
    Next
    For Inc = 1 To vsfgSections.Rows - 1
        vsfgSections.Cell(flexcpBackColor, Inc, 0) = &H800000
    Next Inc
    vsfgSections.CellBackColor = &HECFFFF                          '&HC0FFFF
    If vsfgSections.CellBackColor = &H800000 Then
        vsfgSections.CellForeColor = &HECFFFF                      '&HC0FFFF
    Else
        vsfgSections.CellForeColor = &H80000012
    End If
    If vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) = cnstSubSectionFinanceStatement Then
        vsprintBalanceSheet.Visible = True
    Else
        vsprintBalanceSheet.Visible = False
    End If
    If vsfgSubSections.Col >= 0 Then
        SaveSetting App.Title, App.Title, "LastFileSubSection", vsfgSections.ValueMatrix(vsfgSections.Row, 1)
        If PickValue("FilingSections", "IsStringData", "SectionID = " & vsfgSections.ValueMatrix(vsfgSections.Row, 1)) & "" = "True" Then
            FillStringData vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            vsportAuditReport.Visible = True
            vsprintBalanceSheet.Visible = False
            tbStripAuditReport.Visible = False
            frameLeadsheet.Visible = False
            frameProcedures.Visible = False
            frameRemarks.Visible = False
            frameReviews.Visible = False
            frameResources.Visible = False
            frameReporting.Visible = False
            tbstripFinancialStatements.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = False
            frameGeneralReviews.Visible = False
            If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Financial statements" Then
                vsportAuditReport.Visible = False
                vsprintBalanceSheet.Visible = True
                tbStripAuditReport.Visible = False
                frameLeadsheet.Visible = False
                frameProcedures.Visible = False
                frameRemarks.Visible = False
                frameReviews.Visible = False
                frameResources.Visible = False
                frameGeneralReviews.Visible = False
                vsfgAuditReport(cnstGridDocuments).Visible = False
                '-------new code start-------------
                DoEvents
                vsprintBalanceSheet.ZOrder vbBringToFront
                PrintReportGenerate pvtPreview, pActiveCompanyID, pActivePeriodID, , , , , vsprintBalanceSheet
                '-------new code end---------------
            End If
        Else
            If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Audit resources & timeTable" Then
                vsportAuditReport.Visible = False
                vsprintBalanceSheet.Visible = False
                tbStripAuditReport.Visible = False
                frameLeadsheet.Visible = False
                frameProcedures.Visible = False
                frameRemarks.Visible = False
                frameReviews.Visible = False
                frameResources.Visible = False
                frameGeneralReviews.Visible = False
                frameReporting.Visible = False
                tbstripFinancialStatements.Visible = False
                vsfgAuditReport(cnstGridDocuments).Visible = False
                Exit Sub
            End If
            If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Client meetings" Or _
               PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Client communications and correspondence" Then
                vsportAuditReport.Visible = False
                frameLeadsheet.Visible = False
                tbStripAuditReport.Visible = False
                frameProcedures.Visible = False
                frameRemarks.Visible = True
                frameReviews.Visible = False
                frameResources.Visible = False
                frameReporting.Visible = False
                frameGeneralReviews.Visible = False
                tbstripFinancialStatements.Visible = False
                vsfgAuditReport(cnstGridLegalDocuments).Visible = False
                vsfgAuditReport(cnstGridDocuments).Visible = True
                vsfgAuditReport(cnstGridRemarks).Visible = True
                With vsfgAuditReport(cnstGridRemarks)
                    .TextMatrix(0, grdRemarksSlNo) = "Sl No"
                    .TextMatrix(0, grdRemarksObservations) = "Description"
                    .TextMatrix(0, grdRemarksActions) = "Attachments"
                    
                    .ColWidth(grdRemarksObservations) = GetProportionalValue(8000, False)
                    .ColWidth(grdRemarksActions) = GetProportionalValue(3000, False)
                    .ColComboList(grdRemarksActions) = "..."
                End With
                DisplayClientMeetingsReviews vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
                DisplayClientMeetingsAttachments vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
                FillDocuments vsfgSubSections.TextMatrix(1, vsfgSubSections.Col), mSenderPeriodID
                Exit Sub
            End If
            If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Legal and Other Documents" Then
                vsportAuditReport.Visible = False
                frameLeadsheet.Visible = False
                tbStripAuditReport.Visible = False
                frameProcedures.Visible = False
'                frameRemarks.Visible = False
                frameReviews.Visible = False
                frameReporting.Visible = False
                frameGeneralReviews.Visible = False
                tbstripFinancialStatements.Visible = False
                frameRemarks.Visible = True
                vsfgAuditReport(cnstGridRemarks).Visible = False
                vsfgAuditReport(cnstGridLegalDocuments).Visible = True
                With vsfgAuditReport(cnstGridLegalDocuments)
                    .TextMatrix(0, grdLegalDocSlNo) = "Sl No"
                    .TextMatrix(0, grdLegalDocDescription) = "Particulars"
                    .TextMatrix(0, grdLegalDocRemarks) = "Remarks"
                    .TextMatrix(0, grdLegalDocAttachments) = "Attachments"

                    .ColWidth(grdLegalDocDescription) = GetProportionalValue(5000, False)
                    .ColWidth(grdLegalDocRemarks) = GetProportionalValue(6000, False)
                    .ColWidth(grdLegalDocAttachments) = GetProportionalValue(1500, False)

                    .ColComboList(grdLegalDocAttachments) = "..."
                End With
                FillLegalDocDetails vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
                vsfgAuditReport(cnstGridDocuments).Visible = True
                FillDocuments vsfgSubSections.TextMatrix(1, vsfgSubSections.Col), mSenderPeriodID
                Exit Sub
            End If
            vsportAuditReport.Visible = False
            frameLeadsheet.Visible = True
            tbStripAuditReport.Visible = True
            frameProcedures.Visible = True
            frameRemarks.Visible = True
            frameReviews.Visible = True
            frameResources.Visible = True
            frameGeneralReviews.Visible = False
            frameReporting.Visible = False
            tbstripFinancialStatements.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = True
            vsfgAuditReport(cnstGridRemarks).Visible = True
            vsfgAuditReport(cnstGridRemarks).ZOrder vbBringToFront
            With vsfgAuditReport(cnstGridRemarks)
                .TextMatrix(0, grdRemarksSlNo) = "Sl No"
                .TextMatrix(0, grdRemarksObservations) = "Observations"
                .TextMatrix(0, grdRemarksActions) = "Actions"

                .ColWidth(grdRemarksObservations) = GetProportionalValue(8000, False)
                .ColWidth(grdRemarksActions) = GetProportionalValue(3000, False)
                .ColComboList(grdRemarksActions) = ""
            End With
            FillSubSectionDetails vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillSubSectionReview vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillSubSectionProcedures vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillRemarks vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillResources vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
        End If
    End If
        If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Financial statement - Analysis" Then
            frameReporting.Visible = True
            tbstripFinancialStatements.Visible = True
            tbstripFinancialStatements.SelectedItem.Tag = 0
            vsportAuditReport.Visible = False
            vsprintBalanceSheet.Visible = False
            tbStripAuditReport.Visible = False
            frameLeadsheet.Visible = False
            frameProcedures.Visible = False
            frameRemarks.Visible = False
            frameReviews.Visible = False
            frameResources.Visible = False
            frameGeneralReviews.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = False
            PrintBalanceSheetRpt (mSenderPeriodID)
        End If
        If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "General Review Points" Then
            vsportAuditReport.Visible = False
            frameLeadsheet.Visible = False
            tbStripAuditReport.Visible = False
            frameProcedures.Visible = False
            frameRemarks.Visible = False
            frameReviews.Visible = False
            frameResources.Visible = False
            frameReporting.Visible = False
            tbstripFinancialStatements.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = False
            frameGeneralReviews.Visible = True
            txtGenReview.Visible = True
            txtGenRevReply.Visible = True
            FillGeneralReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
        End If
        If PickValue("FilingSubSection", "Description", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Contingent Liability" Then
            vsportAuditReport.Visible = False
            frameLeadsheet.Visible = True
            tbStripAuditReport.Visible = True
            frameProcedures.Visible = True
            frameRemarks.Visible = True
            frameReviews.Visible = True
            frameResources.Visible = True
            frameGeneralReviews.Visible = False
            frameReporting.Visible = False
            tbstripFinancialStatements.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = True
            FillSubSectionDetails vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillSubSectionReview vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillSubSectionProcedures vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillRemarks vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
        ElseIf PickValue("FilingSubSection", "Decsription", "SubSectionID = " & vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)) & "" = "Capital Commitments" Then
            vsportAuditReport.Visible = False
            frameLeadsheet.Visible = True
            tbStripAuditReport.Visible = True
            frameProcedures.Visible = True
            frameRemarks.Visible = True
            frameReviews.Visible = True
            frameResources.Visible = True
            frameGeneralReviews.Visible = False
            frameReporting.Visible = False
            tbstripFinancialStatements.Visible = False
            vsfgAuditReport(cnstGridDocuments).Visible = True
            FillSubSectionDetails vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillSubSectionReview vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillSubSectionProcedures vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
            FillReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
            FillRemarks vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
        End If
        txtRemarks(txtleadsheetRemarks).Text = ""
End Sub

Public Function ReadStringData() As String
On Local Error Resume Next
Dim Ctrl As Control
    For Each Ctrl In Controls
        If UCase(Ctrl.Container.Name) = "VSPORTAUDITREPORT" Then
            Err.Clear
            If Ctrl.Index <> 0 Then
                If Err.Number = 0 Then
                    ReadStringData = ReadStringData & GetPropertyString(Ctrl)
                End If
            End If
        End If
    Next
End Function

Public Function GetPropertyString(Ctrl As Control) As String
On Local Error Resume Next
Dim strPropString As String, strPropStringTmp As String, strTypeString As String
Dim IncProp As Long, lngInsPos As Long, strTmp As String
    If TypeOf Ctrl Is TextBox Then
        strPropString = "<TEXT><TEXT>"
        strTypeString = "<TEXT>"
    ElseIf TypeOf Ctrl Is Label Then
        strPropString = "<LABEL><LABEL>"
        strTypeString = "<LABEL>"
    ElseIf TypeOf Ctrl Is VSFlexGrid Then
        strPropString = "<GRID><GRID>"
        strTypeString = "<GRID>"
    Else
        GetPropertyString = ""
        Exit Function
    End If
    '------------------------------------------------------------
    lngInsPos = Len(strTypeString)
    For IncProp = 0 To UBound(arrProperties)
        Err.Clear
        Select Case arrProperties(IncProp)
        Case "<BOLD>"
            strTmp = Ctrl.FontBold
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<ITALIC>"
            strTmp = Ctrl.FontItalic
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<LEFT>"
            strTmp = Ctrl.Left
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<TOP>"
            strTmp = Ctrl.Top + vsportAuditReport.VirtualTop
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<WIDTH>"
            strTmp = Ctrl.Width
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<HEIGHT>"
            strTmp = Ctrl.Height
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<ROWS>"
            strTmp = Ctrl.Rows
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<COLS>"
            strTmp = Ctrl.Cols
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<FIXEDROWS>"
            If strTypeString = "<GRID>" Then
                strTmp = Ctrl.FixedRows
                If Err.Number = 0 Then
                    strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
                End If
            End If
        Case "<COLCOMBOLIST>", "<COLALIGN>", "<COLWIDTH>", "<CELL>"
            If strTypeString = "<GRID>" Then
                strPropStringTmp = strPropStringTmp & GetFunctionString(Ctrl, arrProperties(IncProp))
            End If
        Case "<GRIDDATA>"
            strTmp = ReadDataFromGrid(Ctrl)
            If Err.Number = 0 Then
                strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
            End If
        Case "<VALUE>"
            If strTypeString <> "<GRID>" Then
                strTmp = Ctrl
                If Err.Number = 0 Then
                    strPropStringTmp = strPropStringTmp & arrProperties(IncProp) & strTmp & arrProperties(IncProp)
                End If
            End If
        End Select
    Next IncProp
    '------------------------------------------------------------
    strPropString = Left(strPropString, lngInsPos) & strPropStringTmp & Right(strPropString, Len(strPropString) - lngInsPos)
    GetPropertyString = strPropString
End Function

Public Sub FillStringData(lngSubSectionID As Long, mPeriodID As Long)
On Local Error Resume Next
Dim Inc As Long, Inc1 As Long, IncProp As Long, sSql As String
Dim strData As String, strTmp As String, strTmpProp As String
Dim lngLastPos As Long, lngEndPos As Long
Dim strProperties As String, lngLastPosProp As Long, lngEndPosProp As Long
Dim strValue As String, strParams As String, lngCurCtrlIndex As Long
Dim Ctrl As Control, lngTabIndex As Long
    FillSubSectionReview vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
    lngTabIndex = 0
    IsInFillString = True
    vsportAuditReport.VirtualHeight = 5000
    '---Unloading all controls---------
    For Inc = 1 To txtPortTextParent.Count - 1
        Unload txtPortTextParent(Inc)
    Next Inc
    For Inc = 1 To lblPortLabelParent.Count - 1
        Unload lblPortLabelParent(Inc)
    Next Inc
    For Inc = 1 To vsfgPortGridParent.Count - 1
        Unload vsfgPortGridParent(Inc)
    Next Inc
    '----------------------------------
    sSql = "SELECT Data, IsTemplate FROM SubSectionData Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID
    With GetRecords(sSql)
        If Not .EOF Then
            IsTemplate = .Fields("IsTemplate") & ""
            strData = .Fields("Data") & ""
        End If
        .Close
    End With
    sSql = "SELECT DataExtension FROM SubSectionDataExtension Where PeriodID = " & mPeriodID & " And SubSectionID = " & lngSubSectionID & " ORDER BY SubSlNo"
    With GetRecords(sSql)
        While Not .EOF
            strData = strData & .Fields("DataExtension") & ""
            .MoveNext
        Wend
        .Close
    End With
    If Trim(strData) <> "" Then
        '---For all control types-----------
        For Inc = 0 To UBound(arrControls)
            strTmp = strData
            lngLastPos = 1
            lngEndPos = 1
            Do While True
                If InStr(lngLastPos, strTmp, arrControls(Inc)) <> 0 Then
                    lngLastPos = InStr(lngLastPos, strTmp, arrControls(Inc)) + Len(arrControls(Inc))
                    If InStr(lngLastPos, strTmp, arrControls(Inc)) <> 0 Then
                        lngEndPos = InStr(lngLastPos, strTmp, arrControls(Inc))
                        strProperties = Mid(strTmp, lngLastPos, lngEndPos - lngLastPos)
                        lngLastPos = lngEndPos + Len(arrControls(Inc))
                        Select Case arrControls(Inc)
                            Case "<TEXT>"
                                lngCurCtrlIndex = txtPortTextParent.Count
                                Load txtPortTextParent(lngCurCtrlIndex)
                                txtPortTextParent(lngCurCtrlIndex).TabIndex = lngTabIndex
                                Set Ctrl = txtPortTextParent(lngCurCtrlIndex)
                                lngTabIndex = lngTabIndex + 1
                            Case "<LABEL>"
                                lngCurCtrlIndex = lblPortLabelParent.Count
                                Load lblPortLabelParent(lngCurCtrlIndex)
                                Set Ctrl = lblPortLabelParent(lngCurCtrlIndex)
                            Case "<GRID>"
                                lngCurCtrlIndex = vsfgPortGridParent.Count
                                Load vsfgPortGridParent(lngCurCtrlIndex)
                                vsfgPortGridParent(lngCurCtrlIndex).TabIndex = lngTabIndex
                                Set Ctrl = vsfgPortGridParent(lngCurCtrlIndex)
                                lngTabIndex = lngTabIndex + 1
                                vsfgPortGridParent(lngCurCtrlIndex).Rows = 2
                            Case Else
                                Exit Do
                        End Select
                        Ctrl.Visible = True
                        If Trim(strProperties) <> "" Then
                            '---For all property types-----------
                            For IncProp = 0 To UBound(arrProperties)
                                strTmpProp = strProperties
                                lngLastPosProp = 1
                                lngEndPosProp = 1
                                Do While True
                                    If InStr(lngLastPosProp, strTmpProp, arrProperties(IncProp)) <> 0 Then
                                        lngLastPosProp = InStr(lngLastPosProp, strTmpProp, arrProperties(IncProp)) + Len(arrProperties(IncProp))
                                        If InStr(lngLastPosProp, strTmpProp, arrProperties(IncProp)) <> 0 Then
                                            lngEndPosProp = InStr(lngLastPosProp, strTmpProp, arrProperties(IncProp))
                                            strValue = Mid(strTmpProp, lngLastPosProp, lngEndPosProp - lngLastPosProp)
                                            Select Case arrProperties(IncProp)
                                                Case "<BOLD>"
                                                    If UCase(strValue) = "TRUE" Then
                                                        Ctrl.FontBold = True
                                                    Else
                                                        Ctrl.FontBold = False
                                                    End If
                                                Case "<ITALIC>"
                                                    If UCase(strValue) = "TRUE" Then
                                                        Ctrl.FontItalic = True
                                                    Else
                                                        Ctrl.FontItalic = False
                                                    End If
                                                Case "<LEFT>"
                                                    If Val(strValue) <> 0 Then
                                                        Ctrl.Left = Val(strValue)
                                                    End If
                                                Case "<TOP>"
                                                    If Val(strValue) <> 0 Then
                                                        Ctrl.Top = Val(strValue) - vsportAuditReport.VirtualTop
                                                    End If
                                                Case "<WIDTH>"
                                                    If Val(strValue) <> 0 Then
                                                        Ctrl.Width = Val(strValue)
                                                    End If
                                                Case "<HEIGHT>"
                                                    If Val(strValue) <> 0 Then
                                                        Ctrl.Height = Val(strValue)
                                                    End If
                                                Case "<ROWS>"
                                                    Ctrl.Rows = Val(strValue)
                                                Case "<COLS>"
                                                    Ctrl.Cols = Val(strValue)
                                                Case "<FIXEDROWS>"
                                                    Ctrl.FixedRows = Val(strValue)
                                                Case "<CELL>"
                                                    ExecuteFunction Ctrl, strValue, arrProperties(IncProp)
                                                Case "<COLWIDTH>"
                                                    ExecuteFunction Ctrl, strValue, arrProperties(IncProp)
                                                Case "<COLALIGN>"
                                                    ExecuteFunction Ctrl, strValue, arrProperties(IncProp)
                                                Case "<COLCOMBOLIST>"
                                                    ExecuteFunction Ctrl, strValue, arrProperties(IncProp)
                                                Case "<GRIDDATA>"
                                                    WriteDataToGrid Ctrl, strValue
                                                Case "<VALUE>"
                                                    Ctrl = strValue
                                                Case Else
                                                    Exit Do
                                            End Select
                                            lngLastPosProp = lngLastPosProp + Len(arrProperties(IncProp)) + (lngEndPosProp - lngLastPosProp)
                                        Else
                                            Exit Do
                                        End If
                                    Else
                                        Exit Do
                                    End If
                                Loop
                            Next IncProp
                        End If
                        If vsportAuditReport.VirtualHeight < (Ctrl.Top + Ctrl.Height) Then
                            vsportAuditReport.VirtualHeight = Ctrl.Top + Ctrl.Height + 500
                        End If
                    Else
                        Exit Do
                    End If
                Else
                    Exit Do
                End If
            Loop
        Next Inc
    End If
    IsInFillString = False
End Sub

Public Function GetFunctionString(Ctrl As Object, strPropName As String) As String
On Local Error Resume Next
Dim Inc As Long, strResult As String
Dim IncRow As Long, IncCol As Long
    Select Case UCase(strPropName)
        Case "<CELL>"
            '---Back Color-----------------
            For IncRow = 0 To Ctrl.Rows - 1
                For IncCol = 0 To Ctrl.Cols - 1
                    strResult = strResult & UCase(strPropName) & flexcpBackColor & ";" & IncRow & ";" & IncCol & cnstCellSeparator & Ctrl.Cell(flexcpBackColor, IncRow, IncCol) & UCase(strPropName)
                Next IncCol
            Next IncRow
            '---Font Bold------------------
            For IncRow = 0 To Ctrl.Rows - 1
                For IncCol = 0 To Ctrl.Cols - 1
                    strResult = strResult & UCase(strPropName) & FontBold & ";" & IncRow & ";" & IncCol & cnstCellSeparator & Ctrl.Cell(FontBold, IncRow, IncCol) & UCase(strPropName)
                Next IncCol
            Next IncRow
        Case "<COLWIDTH>"
            For Inc = 0 To Ctrl.Cols - 1
                strResult = strResult & UCase(strPropName) & Inc & cnstCellSeparator & Ctrl.ColWidth(Inc) & UCase(strPropName)
            Next Inc
        Case "<COLALIGN>"
            For Inc = 0 To Ctrl.Cols - 1
                strResult = strResult & UCase(strPropName) & Inc & cnstCellSeparator & Ctrl.ColAlignment(Inc) & UCase(strPropName)
            Next Inc
        Case "<COLCOMBOLIST>"
            For Inc = 0 To Ctrl.Cols - 1
                If Ctrl.ColKey(Inc) <> "" Then
                    strResult = strResult & UCase(strPropName) & Inc & cnstCellSeparator & Ctrl.ColKey(Inc) & UCase(strPropName)
                Else
                    strResult = strResult & UCase(strPropName) & Inc & cnstCellSeparator & Ctrl.ColComboList(Inc) & UCase(strPropName)
                End If
            Next Inc
    End Select
    GetFunctionString = strResult
End Function

Public Sub ExecuteFunction(Ctrl As Object, strData As String, strPropName As String)
On Local Error Resume Next
Dim arrData() As String, arrParams() As String, strCompare As String, sSql As String
Dim IncParam As Long
    arrData = Split(strData, cnstCellSeparator)
    arrParams = Split(arrData(0), ";")
    strCompare = arrData(1)
    Select Case UCase(strPropName)
    Case "<CELL>"
    
        Select Case UBound(arrParams)
        Case 0
            Ctrl.Cell(Val(arrParams(0))) = strCompare
        Case 1
            Ctrl.Cell(Val(arrParams(0)), arrParams(1)) = strCompare
        Case 2
            Ctrl.Cell(Val(arrParams(0)), arrParams(1), arrParams(2)) = strCompare
        Case 3
            Ctrl.Cell(Val(arrParams(0)), arrParams(1), arrParams(2), arrParams(3)) = strCompare
        Case 4
            Ctrl.Cell(Val(arrParams(0)), arrParams(1), arrParams(2), arrParams(3), arrParams(4)) = strCompare
        End Select
    Case "<COLWIDTH>"
        Ctrl.ColWidth(Val(arrParams(0))) = Val(strCompare)
    Case "<COLALIGN>"
        Ctrl.ColAlignment(Val(arrParams(0))) = Val(strCompare)
        Ctrl.FixedAlignment(Val(arrParams(0))) = Val(strCompare)
    Case "<COLCOMBOLIST>"
        Select Case Trim(UCase(strCompare))
        Case "$LISTOFBANK"
            Ctrl.ColKey(Val(arrParams(0))) = Trim(UCase(strCompare))
            sSql = "SELECT BankName FROM BankMaster WHERE StatusID = " & cnstStatusActive & " ORDER BY BankName"
            With GetRecords(sSql)
                strCompare = " "
                While Not .EOF
                    strCompare = strCompare & "|" & .Fields("BankName") & ""
                    .MoveNext
                Wend
                .Close
            End With
        Case "$LISTOFNATION"
            Ctrl.ColKey(Val(arrParams(0))) = Trim(UCase(strCompare))
            sSql = "SELECT NationName FROM Nations WHERE StatusID = " & cnstStatusActive & " ORDER BY NationName"
            With GetRecords(sSql)
                strCompare = " "
                While Not .EOF
                    strCompare = strCompare & "|" & .Fields("NationName") & ""
                    .MoveNext
                Wend
                .Close
            End With
        Case Else
            Ctrl.ColKey(Val(arrParams(0))) = ""
        End Select
        Ctrl.ColComboList(Val(arrParams(0))) = strCompare
    End Select
End Sub

Public Sub WriteDataToGrid(ctrlGrid As Object, strData As String)
On Local Error Resume Next
Dim Inc1 As Long
Dim lngRow As Long, lngCol As Long, arrRowCells() As String, arrCell() As String
    arrRowCells = Split(strData, cnstRowSeparator)
    For lngRow = LBound(arrRowCells) To UBound(arrRowCells)
        arrCell = Split(arrRowCells(lngRow), cnstCellSeparator)
        For lngCol = LBound(arrCell) To UBound(arrCell)
            ctrlGrid.TextMatrix(lngRow, lngCol) = arrCell(lngCol)
        Next lngCol
    Next lngRow
End Sub

Public Function ReadDataFromGrid(ctrlGrid As Control) As String
On Local Error Resume Next
Dim lngRow As Long, lngCol As Long
Dim strResult As String
    If TypeOf ctrlGrid Is VSFlexGrid Then
        With ctrlGrid
            For lngRow = 0 To .Rows - 1
                For lngCol = 0 To .Cols - 1
                    strResult = strResult & .TextMatrix(lngRow, lngCol)
                    If lngCol <> .Cols - 1 Then
                        strResult = strResult & cnstCellSeparator
                    End If
                Next lngCol
                strResult = strResult & cnstRowSeparator
            Next lngRow
        End With
    End If
    ReadDataFromGrid = strResult
End Function

Public Sub FillSubSectionDetails(lngSubSectionID As Long, mPeriodID As Long)
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, sSql1 As String
Dim lngAcTypeID As Long, lngActualID As Long, lngComparePeriodID As Long, mCompanyID As Long
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, PER.ComparePeriodID AS ComparePeriodID, " & _
           "       PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt " & _
           "FROM   Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "Where  PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID"))
            lngComparePeriodID = Val(.Fields("ComparePeriodID"))
        End If
    End With
    '---LeadSheet----------------------------------------
    lngAcTypeID = Val(PickValue("FilingSubSection", "AcTypeID", "SubSectionID = " & lngSubSectionID))
    lngActualID = GetActualID(mCompanyID, lngAcTypeID)
    
    vsfgAuditReport(cnstGridLeadSheet).Rows = vsfgAuditReport(cnstGridLeadSheet).Rows + 1: Inc = Inc + 1
    vsfgAuditReport(cnstGridLeadSheet).OutlineBar = flexOutlineBarCompleteLeaf
    vsfgAuditReport(cnstGridLeadSheet).OutlineCol = grdLeadSheetParticulars
    vsfgAuditReport(cnstGridLeadSheet).Rows = 1
    DoEvents
    vsfgAuditReport(cnstGridLeadSheet).Rows = 1
    ShowLeadSheet lngActualID, mPeriodID, lngComparePeriodID
Exit Sub
Err_Exit:
'    ShowError
End Sub

Public Sub ShowLeadSheet(ByVal ParentTypeID As Long, mPeriodID As Long, lngComparePeriodID As Long, Optional ByVal lngLevel As Long = 0)
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, sSql1 As String, dblTotThisPeriod As Double, dblTotLastPeriod As Double
Dim curYearTot As Currency, curTmpTotThis As Currency, lastYearTot As Currency, lastTmpTotThis As Currency
Dim lngOperatingExp As Long, lngOtherIncome As Long
Dim lngContingentLiability As Long
    mCompanyID = PickValue("Periods", "CompanyID", "PeriodID = " & mSenderPeriodID)
    lngOperatingExp = GetActualID(mCompanyID, cnstAcTypeOperatingExpenses)
    lngOtherIncome = GetActualID(mCompanyID, cnstAcTypeOtherIncome)

    lngContingentLiability = GetActualID(mCompanyID, cnstAcTypeContingentLiability)

    If lngLevel = 0 Then
        vsfgAuditReport(cnstGridLeadSheet).Redraw = flexRDNone
        Screen.MousePointer = vbHourglass
    End If

    sSql1 = "SELECT dbo.fn_GetAcTypeBal(AcTypes.AcTypeID, *PER*) AS Amount"
    'Ref No: 010 - 07/04/08
    If ParentTypeID = lngOperatingExp Then
        sSql = "SELECT * FROM(SELECT AcTypeID AS TypeID, AcTypeDescription AS Particulars, RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, TrialOrder, 1 AS Ord, TypeNature " & _
               "FROM AcTypes WHERE ParentAcTypeID = " & ParentTypeID & " And AcTypeID <> " & lngOtherIncome
    Else
        sSql = "SELECT * FROM(SELECT AcTypeID AS TypeID, AcTypeDescription AS Particulars, RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, TrialOrder, 1 AS Ord, TypeNature " & _
               "FROM AcTypes WHERE ParentAcTypeID = " & ParentTypeID
    End If

    If ParentTypeID = lngContingentLiability Then
        sSql = "SELECT * FROM(SELECT AcTypeID AS TypeID, AcTypeDescription AS Particulars, RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, TrialOrder, 1 AS Ord, TypeNature " & _
               "FROM AcTypes WHERE ParentAcTypeID = " & lngContingentLiability
    End If

    sSql1 = "SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = *PER*"
    sSql = sSql & " Union SELECT AH.AcID AS TypeID, AH.AcName AS Particulars, '' AS RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, AH.TrialOrder, 2 AS Ord, AT.TypeNature " & _
           "FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE AH.AcTypeID = " & ParentTypeID & ")TMP1 WHERE ThisPeriod <> 0 OR LastPeriod <> 0 ORDER BY Ord, TrialOrder, TypeNature"
    With GetRecords(sSql)
        While Not .EOF
            vsfgAuditReport(cnstGridLeadSheet).Rows = vsfgAuditReport(cnstGridLeadSheet).Rows + 1
            Inc = vsfgAuditReport(cnstGridLeadSheet).Rows - 1
            dblTotThisPeriod = GetSignedValue(Val(.Fields("ThisPeriod") & ""), .Fields("TypeNature") & "")
            curYearTot = curYearTot + dblTotThisPeriod
            curTmpTotThis = curTmpTotThis + dblTotThisPeriod
            dblTotLastPeriod = GetSignedValue(Val(.Fields("LastPeriod") & ""), .Fields("TypeNature") & "")
            lastYearTot = lastYearTot + dblTotLastPeriod
            lastTmpTotThis = lastTmpTotThis + dblTotLastPeriod
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetParticulars) = .Fields("Particulars") & ""
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetThisYear) = IIf(dblTotThisPeriod < 0, "(" & Format(Abs(dblTotThisPeriod), "#,###") & ")", Format(Abs(dblTotThisPeriod), "#,###"))
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetLastYear) = IIf(dblTotLastPeriod < 0, "(" & Format(Abs(dblTotLastPeriod), "#,###") & ")", Format(Abs(dblTotLastPeriod), "#,###"))
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAttachments) = ""
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetType) = "Leadsheets"
            vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetReviewed) = 0
            If Val(.Fields("Ord") & "") = 1 Then
                vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcTypeId) = .Fields("TypeID") & ""
            Else
                vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcID) = .Fields("TypeID") & ""
            End If
            vsfgAuditReport(cnstGridLeadSheet).RowOutlineLevel(Inc) = lngLevel
            vsfgAuditReport(cnstGridLeadSheet).IsSubtotal(Inc) = True
            If Val(.Fields("Ord") & "") = 1 Then
                ShowLeadSheet Val(.Fields("TypeID") & ""), mPeriodID, lngComparePeriodID, lngLevel + 1
            End If
            FillLeadSheetRemarks Inc, vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
            .MoveNext
        Wend
    End With
    If lngLevel = 0 Then
        With vsfgAuditReport(cnstGridLeadSheet)
            .Rows = .Rows + 1
            Inc = .Rows - 1
            .RowOutlineLevel(Inc) = lngLevel
            .TextMatrix(Inc, grdLeadSheetParticulars) = "Grand Total"
            .IsSubtotal(Inc) = True
            .TextMatrix(Inc, grdLeadSheetThisYear) = IIf(curTmpTotThis > 0, Format(Abs(curTmpTotThis), "#,###"), "(" & Format(Abs(curTmpTotThis), "#,###") & ")")
            .TextMatrix(Inc, grdLeadSheetLastYear) = IIf(lastTmpTotThis > 0, Format(Abs(lastTmpTotThis), "#,###"), "(" & Format(Abs(lastTmpTotThis), "#,###") & ")")
            .Cell(flexcpFontSize, Inc, grdLeadSheetParticulars, , grdLeadSheetLastYear) = 10.5
            .Cell(flexcpBackColor, Inc, grdLeadSheetParticulars, , grdLeadSheetReviewed) = RGB(200, 200, 200)
            .Cell(flexcpFontBold, Inc, grdLeadSheetParticulars, , grdLeadSheetReviewed) = True

            DisplayLeadSheetAttachmentsAndReviews
            FillLeadSheetReviews
            '-------------------------------------------------------
            vsfgAuditReport(cnstGridLeadSheet).Redraw = flexRDDirect
            Screen.MousePointer = vbDefault
        End With
    End If
    vsfgAuditReport(cnstGridLeadSheet).Outline 1
Exit Sub
Err_Exit:
    ShowError
    vsfgAuditReport(cnstGridLeadSheet).Redraw = flexRDDirect
End Sub

Public Sub DisplayLeadSheetAttachmentsAndReviews()
On Local Error Resume Next
Dim sSql As String, Inc As Long
    '---Show Attachments in lead sheet-----------------------------------
    sSql = "SELECT   Count(*) AS Nos, ISNULL(AcTypeID, 0) AS AcTypeID, ISNULL(AcID, 0) AS AcID " & _
           "FROM     DocumentSubLinks DSL WHERE (PeriodID = " & mSenderPeriodID & ") AND (SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & ") AND (ISNULL(AcTypeID, 0) <> 0 OR ISNULL(AcID, 0) <> 0)" & _
           "GROUP BY ISNULL(AcTypeID, 0), ISNULL(AcID, 0)"
    If vsfgAuditReport(cnstGridLeadSheet).Rows > 0 Then
        vsfgAuditReport(cnstGridLeadSheet).Cell(flexcpText, 1, grdLeadSheetAttachments, vsfgAuditReport(cnstGridLeadSheet).Rows - 1, grdLeadSheetAttachments) = ""
    End If
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgAuditReport(cnstGridLeadSheet).Rows - 1
                If (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcTypeId) = Val(.Fields("AcTypeID") & "") And Val(.Fields("AcTypeID") & "") <> 0) Or _
                    (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcID) = Val(.Fields("AcID") & "") And Val(.Fields("AcID") & "") <> 0) Then
                    vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAttachments) = "Attach: " & Val(.Fields("Nos") & "")                      '.Fields("RefNo") & ""
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
    '---Show Reviews-----------------------------------------------------
    sSql = "SELECT   Count(*) AS Nos, ISNULL(AcTypeID, 0) AS AcTypeID, ISNULL(AcID, 0) AS AcID " & _
           "FROM     Reviews RW WHERE (PeriodID = " & mSenderPeriodID & ") AND (SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & ") AND (ISNULL(AcTypeID, 0) <> 0 OR ISNULL(AcID, 0) <> 0) " & _
           "GROUP BY ISNULL(AcTypeID, 0), ISNULL(AcID, 0)"
    If vsfgAuditReport(cnstGridLeadSheet).Rows > 0 Then
        vsfgAuditReport(cnstGridLeadSheet).Cell(flexcpText, 1, grdLeadSheetReviews, vsfgAuditReport(cnstGridLeadSheet).Rows - 1, grdLeadSheetReviews) = ""
        vsfgAuditReport(cnstGridLeadSheet).Cell(flexcpForeColor, 1, grdLeadSheetReviews, vsfgAuditReport(cnstGridLeadSheet).Rows - 1, grdLeadSheetReviews) = RGB(255, 150, 100)
    End If
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgAuditReport(cnstGridLeadSheet).Rows - 1
                If (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcTypeId) = Val(.Fields("AcTypeID") & "") And Val(.Fields("AcTypeID") & "") <> 0) Or _
                    (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcID) = Val(.Fields("AcID") & "") And Val(.Fields("AcID") & "") <> 0) Then
                    vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetReviews) = "Rev: " & Val(.Fields("Nos") & "")
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
End Sub

Public Sub DisplayProcedureAttachmentsAndReviews()
On Local Error Resume Next
Dim sSql As String, Inc As Long
    sSql = "SELECT    Count(*) As Nos, ISNULL(ProcedureID, 0) AS ProcedureID " & _
           "FROM      DocumentSubLinks DSL WHERE (PeriodID = " & mSenderPeriodID & ") AND (SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & ") " & _
           "AND       ISNULL(ProcedureID, 0) <> 0 " & _
           "GROUP BY  ISNULL(ProcedureID, 0)"
    If vsfgAuditReport(cnstGridProcedures).Rows > 0 Then
        vsfgAuditReport(cnstGridProcedures).Cell(flexcpText, 1, grdProcedureAttachments, vsfgAuditReport(cnstGridProcedures).Rows - 1, grdProcedureAttachments) = ""
    End If
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgAuditReport(cnstGridProcedures).Rows - 1
                If vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID) = Val(.Fields("ProcedureID") & "") And Val(.Fields("ProcedureID") & "") <> 0 Then
                    vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureAttachments) = "Attach: " & Val(.Fields("Nos") & "")              '.Fields("RefNo") & ""
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
    '---Show Reviews -----------------------------------------------------
    sSql = "SELECT   Count(*) AS Nos, ISNULL(ProcedureID, 0) AS ProcedureID " & _
           "FROM     Reviews RW WHERE (PeriodID = " & mSenderPeriodID & ") AND (SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col) & ") AND ISNULL(ProcedureID, 0) <> 0 " & _
           "GROUP BY ISNULL(ProcedureID, 0)"
    If vsfgAuditReport(cnstGridProcedures).Rows > 0 Then
        vsfgAuditReport(cnstGridProcedures).Cell(flexcpText, 1, grdProcedureReviews, vsfgAuditReport(cnstGridProcedures).Rows - 1, grdProcedureReviews) = ""
        vsfgAuditReport(cnstGridProcedures).Cell(flexcpForeColor, 1, grdProcedureReviews, vsfgAuditReport(cnstGridProcedures).Rows - 1, grdProcedureReviews) = RGB(255, 150, 100)
    End If
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgAuditReport(cnstGridProcedures).Rows - 1
                If vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID) = Val(.Fields("ProcedureID") & "") And Val(.Fields("ProcedureID") & "") <> 0 Then
                    vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureReviews) = "Rev: " & Val(.Fields("Nos") & "")
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
End Sub

Public Sub FillProcedures(lngRow As Long, lngQuestionID As Long)
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, rsTmp As New ADODB.Recordset, strAnswer As String
    sSql = "SELECT  PA.*, PQ.FileName, PQ.Question AS Question FROM ProcedureAnswers PA INNER JOIN  ProcedureQuestions PQ ON PA.QuestionID = PQ.QuestionID " & _
           "WHERE   PQ.QuestionID = " & lngQuestionID
    With GetRecords(sSql)
        While Not .EOF
            vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureID) = .Fields("QuestionID") & ""
            vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureQuestions) = .Fields("Question") & ""
            vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureTemplate) = .Fields("FileName") & ""
            strAnswer = strAnswer & .Fields("Description") & "|"
            vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureAnswers) = strAnswer
            vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureType) = "Procedures"
            FillProcedureRemarks lngRow, vsfgSubSections.TextMatrix(1, vsfgSubSections.Col)
            .MoveNext
        Wend
      .Close
    End With
    If lngRow = vsfgAuditReport(cnstGridProcedures).Rows - 1 Then
        vsfgAuditReport(cnstGridProcedures).Rows = vsfgAuditReport(cnstGridProcedures).Rows + 1
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function SaveSubSectionProcedures() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, lngSubSectionID As Long
Dim TmpStream As ADODB.Stream, strOldFile As String, strFilePath As String
Dim rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    AdoConn.BeginTrans
    For Inc = 1 To vsfgAuditReport(cnstGridProcedures).Rows - 1
        If vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureSlNo) <> 0 Then
        sSql = "SELECT * FROM SubSectionProcedures WHERE ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & _
               "AND    SubSectionID = " & lngSubSectionID & " And PeriodID = " & mSenderPeriodID & _
               "AND    QuestionID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID)
            With GetRecords(sSql)
                If .EOF Then
                    .AddNew
                    .Fields("PeriodID") = mSenderPeriodID
                    .Fields("SubSectionID") = lngSubSectionID
                    .Fields("ProcedureTypeID") = Val(tbStripProcedures.SelectedItem.Tag)
                    .Fields("QuestionID") = vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID)
                End If
                .Fields("ProcedureSlNo") = vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureSlNo)
                .Fields("AnswerID") = Val(PickValue("ProcedureAnswers", "AnswerID", "Description = '" & vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureAnswer) & "' AND QuestionID =" & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID)))
                If Val(.Fields("AnswerID") & "") = 0 Then .Fields("AnswerID") = Null
                
                .Fields("FileName") = PickValue("ProcedureQuestions", "FileName", "QuestionID =" & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID))
                '---If work file is empty then copy from template---------------
                Set rsTmp = GetRecords("Select TemplateFile From ProcedureQuestions Where QuestionID =" & vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureID))
                If IsEmpty(.Fields("TemplateFile").Value) Then
                    If Not rsTmp.EOF Then
                        .Fields("TemplateFile").Value = rsTmp.Fields("TemplateFile")
                    End If
                End If
                If rsTmp.State = adStateOpen Then rsTmp.Close
                
                .Fields("FileName") = vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureTemplate)
                .Fields("IsCheckedOut") = vsfgAuditReport(cnstGridProcedures).ValueMatrix(Inc, grdProcedureTemplate)
                .Update
                .Close
            End With
        End If
    Next Inc
    AdoConn.CommitTrans
    SaveSubSectionProcedures = True
    PutSlNo vsfgAuditReport(cnstGridProcedures), grdProcedureSlNo, grdProcedureID
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
'    ShowError
    SaveSubSectionProcedures = False
End Function

'------- 18 May 2010 --------
Public Sub FillPrimarySubSectionProcedures(lngSubSectionID As Long)
On Local Error Resume Next
Dim sSql As String, Inc As Long, strExt As String, strFileName As String
Dim sSqlInitialData As String
    ClearValues
    '--------04/01/08----------------------------------------
    sSql = "SELECT SSP.QuestionID, SSP.IsCheckedOut, SSP.ProcedureSlNo AS ProcedureSlNo, PQ.Question AS Question, PQ.ProcedureTypeID AS ProcedureTypeID, PA.Description AS Answer, PA.ForeColor AS Color, PA.IsFavourable AS Favourable, SSP.FileName AS FileName " & _
           "FROM SubSectionProcedures SSP INNER JOIN ProcedureQuestions PQ ON SSP.QuestionID = PQ.QuestionID LEFT OUTER JOIN ProcedureAnswers PA ON SSP.QuestionID = PA.QuestionID AND SSP.AnswerID = PA.AnswerID " & _
           "Where SSP.SubSectionID = " & lngSubSectionID & " AND SSP.ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & " ORDER BY SSP.ProcedureSlNo"
    vsfgAuditReport(cnstGridProcedures).Rows = 2
    With GetRecords(sSql)
        If Not .EOF Then
            While Not .EOF
                Inc = vsfgAuditReport(cnstGridProcedures).Rows - 1
                FillProcedures Inc, Val(.Fields("QuestionID") & "")
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureSlNo) = .Fields("ProcedureSlNo") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureQuestions) = .Fields("Question") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureAnswer) = .Fields("Answer") & ""
                vsfgAuditReport(cnstGridProcedures).Cell(flexcpBackColor, Inc, grdProcedureAnswer) = IIf(Val(.Fields("Color") & "") = 0, vbBlack, Val(.Fields("Color") & ""))
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureFavourable) = IIf(.Fields("Favourable") & "" = "True", -1, 0)
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureTemplate) = .Fields("FileName") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureIsCheckedOut) = Val(.Fields("IsCheckedOut") & "")
                If vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureTemplate) <> "" Then
                    strFileName = .Fields("FileName")
                    strExt = GetExtension(strFileName)
                    SetPicture 1, Inc, grdProcedureTemplate, strExt
                End If
                .MoveNext
            Wend
'        Else
'            vsfgAuditReport(cnstGridProcedures).Rows = 1: vsfgAuditReport(cnstGridProcedures).Rows = 2
        End If
        .Close
        vsfgAuditReport(cnstGridProcedures).TextMatrix(1, grdProcedureType) = "Procedures"
    End With
Exit Sub
'Err_Exit:
End Sub

Public Sub FillSubSectionProcedures(lngSubSectionID As Long)
On Local Error Resume Next
Dim sSql As String, Inc As Long, strExt As String, strFileName As String
Dim sSqlInitialData As String
    ClearValues
    '--------04/01/08----------------------------------------
    sSql = "SELECT SSP.QuestionID, SSP.IsCheckedOut, SSP.ProcedureSlNo AS ProcedureSlNo, PQ.Question AS Question, PQ.ProcedureTypeID AS ProcedureTypeID, PA.Description AS Answer, PA.ForeColor AS Color, PA.IsFavourable AS Favourable, SSP.FileName AS FileName " & _
           "FROM SubSectionProcedures SSP INNER JOIN ProcedureQuestions PQ ON SSP.QuestionID = PQ.QuestionID LEFT OUTER JOIN ProcedureAnswers PA ON SSP.QuestionID = PA.QuestionID AND SSP.AnswerID = PA.AnswerID " & _
           "Where SSP.SubSectionID = " & lngSubSectionID & " AND SSP.ProcedureTypeID = " & Val(tbStripProcedures.SelectedItem.Tag) & " AND SSP.PeriodID = " & mSenderPeriodID & " ORDER BY SSP.ProcedureSlNo"
    vsfgAuditReport(cnstGridProcedures).Rows = 2
    With GetRecords(sSql)
        If Not .EOF Then
            While Not .EOF
                Inc = vsfgAuditReport(cnstGridProcedures).Rows - 1
                FillProcedures Inc, Val(.Fields("QuestionID") & "")
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureSlNo) = .Fields("ProcedureSlNo") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureQuestions) = .Fields("Question") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureAnswer) = .Fields("Answer") & ""
                vsfgAuditReport(cnstGridProcedures).Cell(flexcpBackColor, Inc, grdProcedureAnswer) = IIf(Val(.Fields("Color") & "") = 0, vbBlack, Val(.Fields("Color") & ""))
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureFavourable) = IIf(.Fields("Favourable") & "" = "True", -1, 0)
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureTemplate) = .Fields("FileName") & ""
                vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureIsCheckedOut) = Val(.Fields("IsCheckedOut") & "")
                If .Fields("IsCheckedOut") Then vsfgAuditReport(cnstGridProcedures).Cell(flexcpBackColor, Inc, grdProcedureTemplate) = RGB(150, 150, 150)
                If vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureTemplate) <> "" Then
                    strFileName = .Fields("FileName")
                    strExt = GetExtension(strFileName)
                    SetPicture 1, Inc, grdProcedureTemplate, strExt
                End If
                .MoveNext
            Wend
            DisplayProcedureAttachmentsAndReviews
        Else
            vsfgAuditReport(cnstGridProcedures).Rows = 1: vsfgAuditReport(cnstGridProcedures).Rows = 2
        End If
        .Close
        vsfgAuditReport(cnstGridProcedures).TextMatrix(1, grdProcedureType) = "Procedures"
    End With
'Err_Exit:
End Sub

Public Sub SetPicture(Index As Integer, Row As Long, Col As Long, strExt As String)
On Local Error Resume Next
    strExt = LCase(strExt)
    Err.Clear
    With vsfgAuditReport(Index)
        Select Case Index
            Case cnstGridProcedures
                .Cell(flexcpPicture, Row, Col) = Nothing
                .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
                If Err.Number <> 0 Then
                    .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
                End If
            Case cnstGridDocuments
                .Cell(flexcpPicture, Row, Col) = Nothing
                .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
                .Cell(flexcpPictureAlignment, Row, Col) = flexPicAlignCenterCenter
                If Err.Number <> 0 Then
                    .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
                End If
            Case cnstGridResources
                .Cell(flexcpPicture, Row, Col) = Nothing
                .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
                If Err.Number <> 0 Then
                    .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
                End If
            Case cnstGridLegalDocuments
                .Cell(flexcpPicture, Row, Col) = Nothing
                .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages(strExt).Picture
                If Err.Number <> 0 Then
                    .Cell(flexcpPicture, Row, Col) = MDIFormMain.imglstIcons.ListImages("unknown").Picture
                End If
        End Select
    End With
End Sub

Public Sub FillDocuments(lngSubSectionID As Long, lngPeriodID As Long, Optional IDType As String = "Nil", Optional lngID As Long = -1)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, FileExt As String
Dim strWhere As String, mstrWhere As String, lngColWidth As Long
    Select Case Trim(UCase(IDType))
        Case "ACCOUNTTYPE"
            mstrWhere = " AND ISNULL(DSL.AcTypeID, 0) = " & lngID & " AND ISNULL(DSL.AcID, 0) = 0 AND ISNULL(DSL.ProcedureID, 0) = 0 "
        Case "ACCOUNTHEAD"
            mstrWhere = " AND ISNULL(DSL.AcTypeID, 0) = 0 AND ISNULL(DSL.AcID, 0) = " & lngID & " AND ISNULL(DSL.ProcedureID, 0) = 0 "
        Case "PROCEDURE"
            mstrWhere = " AND ISNULL(DSL.AcTypeID, 0) = 0 AND ISNULL(DSL.AcID, 0) = 0 AND ISNULL(DSL.ProcedureID, 0) = " & lngID & " "
        Case "RESOURCES"
            mstrWhere = " AND ISNULL(DSL.AcTypeID, 0) = 0 AND ISNULL(DSL.AcID, 0) = 0 AND ISNULL(DSL.ProcedureID, 0) = 0 AND ISNULL(DSL.ResourceID, 0) = " & lngID & " "
        Case Else
            mstrWhere = ""
    End Select

    sSql = "SELECT DISTINCT DSL.DocLinkID, DB.DocumentID, DB.IsCheckOut, DB.Description, DB.FileExt, DB.FileName, CMP.CompanyName AS CompanyName, DSL.RefNo " & _
           "FROM DocumentBin DB LEFT OUTER JOIN AuditMain.dbo.Companies CMP ON DB.CompanyID = CMP.CompanyID " & _
           "INNER JOIN AuditMain.dbo.DocumentSubLinks DSL ON DB.DocumentID = DSL.DocumentID " & _
           "WHERE  DSL.PeriodID = " & lngPeriodID & " AND IsResource Is NULL AND DSL.SubSectionID = " & lngSubSectionID & mstrWhere

    vsfgAuditReport(cnstGridDocuments).Cols = 0
    vsfgAuditReport(cnstGridDocuments).Rows = grdDocumentRows
    vsfgAuditReport(cnstGridDocuments).RowHidden(grdDocumentRowDocumentID) = True
    vsfgAuditReport(cnstGridDocuments).RowHidden(grdDocumentRowFileName) = True
    vsfgAuditReport(cnstGridDocuments).RowHidden(grdDocumentRowDocLinkID) = True

    With GetRecords(sSql, AdoConnDoc)
        While Not .EOF
            vsfgAuditReport(cnstGridDocuments).Cols = vsfgAuditReport(cnstGridDocuments).Cols + 1
            Inc = vsfgAuditReport(cnstGridDocuments).Cols - 1

            SetPicture 2, grdDocumentRowIcon, Inc, Trim(.Fields("FileExt") & "")
            vsfgAuditReport(cnstGridDocuments).TextMatrix(grdDocumentRowDescription, Inc) = .Fields("RefNo") & " - " & .Fields("Description") & ""
            vsfgAuditReport(cnstGridDocuments).TextMatrix(grdDocumentRowDocumentID, Inc) = Val(.Fields("DocumentID") & "")
            vsfgAuditReport(cnstGridDocuments).TextMatrix(grdDocumentRowFileName, Inc) = .Fields("FileName") & ""
            vsfgAuditReport(cnstGridDocuments).TextMatrix(grdDocumentRowDocLinkID, Inc) = Val(.Fields("DocLinkID") & "")

            vsfgAuditReport(cnstGridDocuments).Cell(flexcpAlignment, grdDocumentRowDescription, Inc) = flexAlignCenterCenter
            vsfgAuditReport(cnstGridDocuments).ColWidth(Inc) = 1500
            If .Fields("IsCheckOut") Then
                vsfgAuditReport(cnstGridDocuments).Cell(flexcpBackColor, grdDocumentRowIcon, Inc, grdDocumentRowDescription, Inc) = RGB(150, 150, 150)
            End If
            .MoveNext
        Wend
        With vsfgAuditReport(cnstGridDocuments)
            .ExtendLastCol = True
            .ZOrder vbBringToFront
            .RowHeight(grdDocumentRowDescription) = GetProportionalValue(660)
            lngColWidth = .Width - 15
            If .Cols > 0 Then
                lngColWidth = lngColWidth / .Cols
            End If
            For Inc = 0 To .Cols - 1
                vsfgAuditReport(cnstGridDocuments).ColWidth(Inc) = lngColWidth
            Next Inc
        End With
    .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Function GetCheckOutUser(ByVal lnUserID As Long) As String
On Local Error GoTo Err_Exit
Dim rsGetUserName As New Recordset
Dim sSql As String
    sSql = "Select UserName From Users Where UserID  = " & lnUserID
    Set rsGetUserName = GetRecords(sSql, AdoConn)
    With rsGetUserName
        If Not .EOF Then
            GetCheckOutUser = (.Fields("UserName"))
        End If
       .Close
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Sub KeyShortCuts(Index As Integer, KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
Dim blnIsValidKey As Boolean, lngID As Long, strType As String
Static lngLastTime As Long
    If GetTickCount() - lngLastTime > 400 Then
        With vsfgAuditReport(Index)
            lngLastTime = GetTickCount()
            Select Case KeyCode
                Case vbKeyF12
                    Select Case Index
                        Case cnstGridLeadSheet
                            If .Row > 0 Then
                                lngID = .ValueMatrix(.Row, grdLeadSheetAcTypeId)
                                strType = "ACCOUNTTYPE"
                                If lngID = 0 Then
                                    lngID = .ValueMatrix(.Row, grdLeadSheetAcID)
                                    strType = "ACCOUNTHEAD"
                                End If
                                If lngID <> 0 Then
                                    ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, strType, lngID
                                End If
                            End If
                        Case cnstGridProcedures
                            If .Row > 0 Then
                                lngID = .ValueMatrix(.Row, grdProcedureID)
                                strType = "PROCEDURE"
                                If lngID <> 0 Then
                                    ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID, strType, lngID
                                End If
                            End If
                    End Select
            End Select
        End With
    End If
End Sub

Public Sub FillReviews(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset, Inc As Long, strParticulars As String
    ClearReviews
    sSql = "SELECT REV.ReviewID, FSS.Description AS SubSection, (SELECT AcTypeDescription FROM AcTypes AT WHERE AT.AcTypeID = REV.AcTypeID) AS AcTypeDescription, " & _
           "      (SELECT AcName FROM AcHeads AH WHERE AH.AcID = REV.AcID AND CompanyID = " & mCompanyID & ") AS AcName, (SELECT PQ.Question FROM ProcedureQuestions PQ WHERE PQ.QuestionID = REV.ProcedureID) AS ProcedureName, REV.Question, REV.Answer, REV.CreateDate, REV.UpdateDate,  " & _
           "       REV.SubSectionID, REV.PeriodID, REV.ProcedureID, REV.AcTypeID, REV.AcID, ReviewUser.UserName AS ReviewUser, ReplyUser.UserName AS ReplyUser " & _
           "FROM   Reviews REV INNER JOIN FilingSubSection FSS ON REV.SubSectionID = FSS.SubSectionID INNER JOIN Users ReviewUser ON REV.CreateUser = ReviewUser.UserID LEFT OUTER JOIN " & _
           "       Users ReplyUser ON REV.UpdateUser = ReplyUser.UserID Where REV.SubSectionID = " & lngSubSectionID & " AND REV.PeriodID = " & mSenderPeriodID & " ORDER BY REV.ReviewID"
    Set rsTmp = GetRecords(sSql)
    With vsfgAuditReport(cnstGridReviews)
        While Not rsTmp.EOF
            .Rows = .Rows + 1: Inc = Inc + 1
            If rsTmp.Fields("AcTypeDescription") & "" <> "" Then
                strParticulars = rsTmp.Fields("AcTypeDescription") & ""
            ElseIf rsTmp.Fields("AcName") & "" <> "" Then
                strParticulars = rsTmp.Fields("AcName") & ""
            ElseIf rsTmp.Fields("ProcedureName") & "" <> "" Then
                strParticulars = rsTmp.Fields("ProcedureName") & ""
            End If
            .TextMatrix(Inc, grdReviewSlNo) = Inc
            .TextMatrix(Inc, grdReviews) = rsTmp.Fields("Question") & ""
            .TextMatrix(Inc, grdReviewedBy) = StrConv(rsTmp.Fields("ReviewUser") & "", vbProperCase)
            .TextMatrix(Inc, grdReviewReply) = rsTmp.Fields("Answer") & ""
            If rsTmp.Fields("Answer") & "" = "" Then
                .TextMatrix(Inc, grdReviewRepliedBy) = ""
            Else
                .TextMatrix(Inc, grdReviewRepliedBy) = StrConv(rsTmp.Fields("ReplyUser") & "", vbProperCase)
            End If
            .TextMatrix(Inc, grdReviewRelatedAC) = strParticulars
            .TextMatrix(Inc, grdReviewID) = rsTmp.Fields("ReviewID") & ""
            .TextMatrix(Inc, grdReviewAccount) = rsTmp.Fields("AcTypeID") & ""
            .TextMatrix(Inc, grdReviewType) = "Reviews"
            rsTmp.MoveNext
        Wend
        rsTmp.Close
        PutSlNo vsfgAuditReport(cnstGridReviews), grdReviewSlNo, grdReviews
        vsfgAuditReport(cnstGridReviews).TextMatrix(1, grdReviewType) = "Reviews"
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function SaveRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset, lngSubSectionID As Long, Inc As Long
    AdoConn.BeginTrans
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    sSql = "Delete From Remarks Where SubSectionID = " & lngSubSectionID & " And PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "Select * From Remarks Where 1=2"
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            For Inc = 1 To vsfgAuditReport(cnstGridRemarks).Rows - 1
                If vsfgAuditReport(cnstGridRemarks).ValueMatrix(Inc, grdRemarksSlNo) <> 0 Then
                    .AddNew
                    .Fields("RemarkID") = vsfgAuditReport(cnstGridRemarks).ValueMatrix(Inc, grdRemarksSlNo)
                    .Fields("SubSectionID") = lngSubSectionID
                    .Fields("PeriodID") = mSenderPeriodID
                    .Fields("Observations") = vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksObservations)
                    .Fields("Actions") = vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksActions)
                    SaveDateAndUser rsTmp
                    .Update
                End If
            Next Inc
        End With
    AdoConn.CommitTrans
    SaveRemarks = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
    SaveRemarks = False
End Function

Public Sub FillRemarks(lngSubSectionID As Long)
On Local Error Resume Next
Dim sSql As String, rsTmp As New ADODB.Recordset, Inc As Long
    ClearRemarks
    sSql = "Select * From Remarks Where SubSectionID = " & lngSubSectionID & " And PeriodID = " & mSenderPeriodID
    Set rsTmp = GetRecords(sSql)
    With vsfgAuditReport(cnstGridRemarks)
        While Not rsTmp.EOF
            .Rows = .Rows + 1: Inc = Inc + 1
            .TextMatrix(Inc, grdRemarksSlNo) = Inc
            .TextMatrix(Inc, grdRemarksObservations) = rsTmp.Fields("Observations") & ""
            .TextMatrix(Inc, grdRemarksActions) = rsTmp.Fields("Actions") & ""
            .TextMatrix(Inc, grdRemarksType) = "Matters Arising"
            rsTmp.MoveNext
        Wend
        rsTmp.Close
        .AutoSizeMode = flexAutoSizeRowHeight
        .AutoSize grdRemarksObservations
    End With
End Sub

Public Function PrintBalanceSheetRpt(mPeriodID As Long)
On Local Error GoTo Err_Exit
Dim strTmp As Double, strTmp1 As Double, sSql As String, lngAcTypePL As Long, mDerivedPeriodID As Long, mComparePeriodID As Long
Dim mCompanyID As Long, lngDerivedStartDt As Long, lngStartDt As Long, lngDerivedEndDt As Long, lngEndDt As Long, Inc As Long
Dim rsTmp As New Recordset, rsTmp1 As New Recordset, rsTmp2 As New Recordset, lngLevelCount As Long, dblLevelTotalThis As Double, dblLevelTotalLast As Double
Dim dblTmpSubTotalCur As Double, dblTmpSubTotalLast As Double, dblTmpMainTotalCur As Double, dblTmpMainTotalLast As Double
Dim TotDifference As Double, TotDiffPercent As Double, lngSubSectionID As Long

Const grdParticulars = 0
Const grdThisYr = 1
Const grdLastYr = 2
Const grdDiffPercent = 3
Const grdDifference = 4
Const grdRemarks = 5
Const grdAcTypeID = 6
Const grdCols = 7

    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    sSql = "SELECT  PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, PER.ComparePeriodID AS ComparePeriodID, " & _
           "        PER1.StartDt AS DerivedStartDt, PER1.EndDt AS DerivedEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID " & _
           "Where   PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mDerivedPeriodID = Val(.Fields("DerivedPeriodID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngAcTypePL = GetActualID(mCompanyID, cnstAcTypeProfitLoss)
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            If Val(.Fields("DerivedStartDt") & "") = 0 Then
                lngDerivedStartDt = Format(DateAdd("yyyy", -1, CDate(lngStartDt)), "#")
            Else
                lngDerivedStartDt = Val(.Fields("DerivedStartDt") & "")
            End If
            If Val(.Fields("DerivedEndDt") & "") = 0 Then
                lngDerivedEndDt = Format(DateAdd("yyyy", -1, CDate(lngEndDt)), "#")
            Else
                lngDerivedEndDt = Val(.Fields("DerivedEndDt") & "")
            End If
        End If
        .Close
    End With
    With vsfgReporting(cnstgrdBalanceSheet)
        .Rows = 1
        '--- Filling Table Data -------------------
        sSql = "SELECT AcTypeID, AcTypeDescription, TrialOrder From AcTypes Where CompanyID = " & mCompanyID & " AND TreeLevel = 1 AND AcTypeID <> " & lngAcTypePL & " AND IsHidden = 0 ORDER BY TrialOrder"
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            .Rows = .Rows + 1: Inc = Inc + 1
            .TextMatrix(Inc, grdBalSheetParticulars) = UCase(rsTmp.Fields("AcTypeDescription") & "")
            .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = True
            dblTmpMainTotalCur = 0: dblTmpMainTotalLast = 0
            dblLevelTotalThis = 0: dblLevelTotalLast = 0

            sSql = "SELECT AcTypeID, AcTypeDescription, TrialOrder From AcTypes Where ParentAcTypeID = " & Val(rsTmp.Fields("AcTypeID") & "") & " ORDER BY TrialOrder"
            Set rsTmp1 = GetRecords(sSql)
            While Not rsTmp1.EOF
                .Rows = .Rows + 1: Inc = Inc + 1
                .TextMatrix(Inc, grdBalSheetParticulars) = StrConv(rsTmp1.Fields("AcTypeDescription") & "", vbProperCase)
                .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = True
                dblTmpSubTotalCur = 0: dblTmpSubTotalLast = 0

                sSql = "SELECT  AT.AcTypeID, AT.AcTypeDescription, AT.TypeNature, (SELECT SSB.NoteNo FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mPeriodID & ") AS NoteNo, (SELECT CASE WHEN SSB.CAmt < 0 THEN SSB.CAmt - SSB.DAmt ELSE SSB.DAmt - SSB.CAmt END FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mPeriodID & ") AS CurrentYr, (SELECT  CASE WHEN SSB.CAmt < 0 THEN SSB.CAmt - SSB.DAmt ELSE SSB.DAmt - SSB.CAmt END FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mComparePeriodID & ") AS LastYr From AcTypes AT WHERE AT.ParentAcTypeID = " & Val(rsTmp1.Fields("AcTypeID") & "") & " ORDER BY AT.TrialOrder"
                Set rsTmp2 = GetRecords(sSql)
                While Not rsTmp2.EOF
                    If Val(rsTmp2.Fields("CurrentYr") & "") <> 0 Or Val(rsTmp2.Fields("LastYr") & "") <> 0 Then
                        .Rows = .Rows + 1: Inc = Inc + 1
                        .TextMatrix(Inc, grdBalSheetParticulars) = rsTmp2.Fields("AcTypeDescription") & ""
                        .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = False
                        strTmp = GetSignedValue(Val(rsTmp2.Fields("CurrentYr") & ""), rsTmp2.Fields("TypeNature") & "")
                        'strTmp = IIf(Val(rsTmp2.Fields("CurrentYr") & "") = 0, 0, Format(Abs(Val(rsTmp2.Fields("CurrentYr") & "")), "#,##0"))
                        '.TextMatrix(Inc, grdBalSheetThisYr) = IIf(Val(rsTmp2.Fields("CurrentYr") & "") < 0, "(" & Format(Abs(strTmp), "#,##0") & ")", Format(Abs(strTmp), "#,##0"))
                        .TextMatrix(Inc, grdBalSheetThisYr) = IIf(strTmp < 0, "(" & Format(Abs(strTmp), "#,##0") & ")", Format(Abs(strTmp), "#,##0"))
                        .Cell(flexcpFontBold, Inc, grdBalSheetThisYr) = True

                        'strTmp1 = IIf(Val(rsTmp2.Fields("LastYr") & "") = 0, 0, Format(Abs(Val(rsTmp2.Fields("LastYr") & "")), "#,##0")) & ""
                        strTmp1 = GetSignedValue(Val(rsTmp2.Fields("LastYr") & ""), rsTmp2.Fields("TypeNature") & "")
                        '.TextMatrix(Inc, grdBalSheetLastYr) = IIf(Val(rsTmp2.Fields("LastYr") & "") < 0, "(" & Format(Abs(strTmp1), "#,##0") & ")", Format(Abs(strTmp1), "#,##0"))
                        .TextMatrix(Inc, grdBalSheetLastYr) = IIf(strTmp1 < 0, "(" & Format(Abs(strTmp1), "#,##0") & ")", Format(Abs(strTmp1), "#,##0"))
                        .Cell(flexcpFontBold, Inc, grdBalSheetLastYr) = False
                        TotDifference = strTmp - strTmp1
                        .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##0") & ")", Format(Abs(TotDifference), "#,##0"))
                        If strTmp1 = 0 Then
                            TotDiffPercent = 0
                        Else
                            TotDiffPercent = (TotDifference / strTmp1) * 100
                        End If
                        .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%" & "  "
                        .TextMatrix(Inc, grdAcTypeID) = rsTmp2.Fields("AcTypeID") & ""
                        FillBalSheetRemarks Inc, lngSubSectionID
                        dblTmpSubTotalCur = dblTmpSubTotalCur + Val(rsTmp2.Fields("CurrentYr") & "")
                        dblTmpSubTotalLast = dblTmpSubTotalLast + Val(rsTmp2.Fields("LastYr") & "")
                        dblTmpMainTotalCur = dblTmpMainTotalCur + Val(rsTmp2.Fields("CurrentYr") & "")
                        dblTmpMainTotalLast = dblTmpMainTotalLast + Val(rsTmp2.Fields("LastYr") & "")
                    End If
                    rsTmp2.MoveNext
                Wend
                rsTmp2.Close
                '--- Total Sub Level ----
                .Rows = .Rows + 1: Inc = Inc + 1
                .TextMatrix(Inc, grdBalSheetParticulars) = "Total " & StrConv(rsTmp1.Fields("AcTypeDescription") & "", vbProperCase)
                .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = True

                strTmp = IIf(dblTmpSubTotalCur = 0, 0, Format(Abs(dblTmpSubTotalCur), "#,##,0"))
                .TextMatrix(Inc, grdBalSheetThisYr) = IIf(dblTmpSubTotalCur < 0, "(" & Format(Abs(strTmp), "#,##0") & ")", Format(Abs(strTmp), "#,##0"))
                .Cell(flexcpFontBold, Inc, grdBalSheetThisYr) = True
                .Cell(flexcpFontUnderline, Inc, grdBalSheetThisYr) = True
                .Cell(flexcpFontUnderline, Inc - 1, grdBalSheetThisYr) = True

                dblLevelTotalThis = dblLevelTotalThis + dblTmpSubTotalCur

                strTmp1 = IIf(dblTmpSubTotalLast = 0, 0, Format(Abs(dblTmpSubTotalLast), "#,##,0"))
                .TextMatrix(Inc, grdBalSheetLastYr) = IIf(dblTmpSubTotalLast < 0, "(" & Format(Abs(strTmp1), "#,##,0") & ")", Format(Abs(strTmp1), "#,##,0"))
                .Cell(flexcpFontBold, Inc, grdBalSheetLastYr) = False
                .Cell(flexcpFontUnderline, Inc, grdBalSheetLastYr) = True
                .Cell(flexcpFontUnderline, Inc - 1, grdBalSheetLastYr) = True

                TotDifference = strTmp - strTmp1
                .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##,0") & ")", Format(Abs(TotDifference), "#,##,0"))
                If strTmp1 = 0 Then
                    TotDiffPercent = 0
                Else
                    TotDiffPercent = (TotDifference / strTmp1) * 100
                End If
                .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%"

                dblLevelTotalLast = dblLevelTotalLast + dblTmpSubTotalLast
                lngLevelCount = lngLevelCount + 1

                If lngLevelCount = 4 Then
                    .Rows = .Rows + 2: Inc = Inc + 2
                    .TextMatrix(Inc, grdBalSheetParticulars) = "Total Liabilities"
                    .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = True

                    strTmp = IIf(dblLevelTotalThis = 0, 0, Format(Abs(dblLevelTotalThis), "#,##,0"))
                    .TextMatrix(Inc, grdBalSheetThisYr) = IIf(dblLevelTotalThis < 0, "(" & Format(Abs(strTmp), "#,##,0") & ")", Format(Abs(strTmp), "#,##,0"))
                    .Cell(flexcpFontBold, Inc, grdBalSheetThisYr) = True
                    .Cell(flexcpFontUnderline, Inc, grdBalSheetThisYr) = True
                    .Cell(flexcpFontUnderline, Inc - 1, grdBalSheetThisYr) = True

                    strTmp1 = IIf(dblLevelTotalLast = 0, 0, Format(Abs(dblLevelTotalLast), "#,##,0"))
                    .TextMatrix(Inc, grdBalSheetLastYr) = IIf(dblLevelTotalLast < 0, "(" & Format(Abs(strTmp1), "#,##,0") & ")", Format(Abs(strTmp1), "#,##,0"))
                    .Cell(flexcpFontBold, Inc, grdBalSheetLastYr) = False
                    .Cell(flexcpFontUnderline, Inc, grdBalSheetLastYr) = True
                    .Cell(flexcpFontUnderline, Inc - 1, grdBalSheetLastYr) = True

                    TotDifference = strTmp - strTmp1
                    .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##,0") & ")", Format(Abs(TotDifference), "#,##,0"))
                    If strTmp1 = 0 Then
                        TotDiffPercent = 0
                    Else
                        TotDiffPercent = (TotDifference / strTmp1) * 100
                    End If
                    .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%"
                End If
                .Rows = .Rows + 1: Inc = Inc + 1
                rsTmp1.MoveNext
            Wend
            rsTmp1.Close
            '--- Total Main Level ----
            .Rows = .Rows + 1: Inc = Inc + 1
            .TextMatrix(Inc, grdBalSheetParticulars) = "Total " & LCase(rsTmp.Fields("AcTypeDescription") & "")
            .Cell(flexcpFontBold, Inc, grdBalSheetParticulars) = True

            strTmp = IIf(dblTmpMainTotalCur = 0, 0, Format(Abs(dblTmpMainTotalCur), "#,##,0"))
            .TextMatrix(Inc, grdBalSheetThisYr) = IIf(dblTmpMainTotalCur < 0, "(" & Format(Abs(strTmp), "#,##,0") & ")", Format(Abs(strTmp), "#,##,0"))
            .Cell(flexcpFontBold, Inc, grdBalSheetThisYr) = True

            strTmp1 = IIf(dblTmpMainTotalLast = 0, 0, Format(Abs(dblTmpMainTotalLast), "#,##,0"))
            .TextMatrix(Inc, grdBalSheetLastYr) = IIf(dblTmpMainTotalLast < 0, "(" & Format(Abs(strTmp1), "#,##,0") & ")", Format(Abs(strTmp1), "#,##,0"))
            .Cell(flexcpFontBold, Inc, grdBalSheetLastYr) = False

            TotDifference = strTmp - strTmp1
            .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##,0") & ")", Format(Abs(TotDifference), "#,##,0"))
            If strTmp1 = 0 Then
                TotDiffPercent = 0
            Else
                TotDiffPercent = (TotDifference / strTmp1) * 100
            End If
            .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%"
            rsTmp.MoveNext
        Wend
        rsTmp.Close
        .Cell(flexcpFontName, 0, 0, .Rows - 1, .Cols - 1) = "Times New Roman"
        .Cell(flexcpAlignment, 1, grdThisYr, .Rows - 1, grdDifference) = taRightMiddle
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintProfitLossRpt(mPeriodID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, strTmp As String
Dim rsTmp As New Recordset, rsTmp1 As New Recordset, rsTmp2 As New Recordset
Dim mCompanyID As Long, mDerivedPeriodID As Long, mComparePeriodID As Long, mLastPeriodID As Long
Dim Inc As Long, tmpStr As String, lngAcTypeID As Long
Dim lngStartDt As Long, lngCompareStartDt As Long, lngEndDt As Long, lngCompareEndDt As Long
Dim dblAmount As Double, dblLastAmount As Double
Dim lngAcTypeTrading As Long, lngAcTypeOperatingExp As Long, lngAcTypeNonOperatingExp As Long, dblNextTotal As Double, dblNextTotalLast As Double
Dim dblTmpTotal As Double, dblTotalTrading As Double, dblTotalOperating As Double, dblTotalNonOperating As Double
Dim dblTmpTotalLast As Double, dblTotalLastTrading As Double, dblTotalLastOperating As Double, dblTotalLastNonOperating As Double
Dim TotDifference As Double, TotDiffPercent As Double, lngSubSectionID As Long

Const grdParticulars = 0
Const grdThisYr = 1
Const grdLastYr = 2
Const grdDiffPercent = 3
Const grdDifference = 4
Const grdRemarks = 5
Const grdAcTypeID = 6
Const grdCols = 7

    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, PER.ComparePeriodID AS ComparePeriodID, " & _
           "       PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt " & _
           "FROM   Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "Where  PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            lngAcTypeID = GetActualID(mCompanyID, cnstAcTypeProfitLoss)
            lngAcTypeTrading = GetActualID(mCompanyID, cnstAcTypeTrading)
            lngAcTypeOperatingExp = GetActualID(mCompanyID, cnstAcTypeOperatingExp)
            lngAcTypeNonOperatingExp = GetActualID(mCompanyID, cnstAcTypeNonOperatingExp)
            mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
            mDerivedPeriodID = Val(.Fields("DerivedPeriodID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With
    With vsfgReporting(cnstgrdProfitLoss)
        .Rows = 1
        sSql = "SELECT AT.AcTypeID, AT.AcTypeDescription, AT.TrialOrder From AcTypes AT WHERE AT.TreeLevel = 2 AND AT.ParentAcTypeID =" & lngAcTypeID & " ORDER BY AT.TrialOrder"
        Set rsTmp = GetRecords(sSql)
            While Not rsTmp.EOF
                sSql = "SELECT AT.AcTypeID, AT.AcTypeDescription, SSB.NoteNo, AT.TypeNature, (Select CAmt - DAmt from SchedulesSubBalanceSheet Where AcTypeID = SSB.AcTypeID AND PeriodID = " & mPeriodID & ") AS ThisYear , (Select  CAmt - DAmt from SchedulesSubBalanceSheet Where AcTypeID = SSB.AcTypeID AND PeriodID = " & mComparePeriodID & ") AS LastYear From AcTypes AT, SchedulesSubBalanceSheet SSB WHERE AT.AcTypeID = SSB.AcTypeID AND AT.ParentAcTypeID = " & Val(rsTmp.Fields("AcTypeID") & "") & " AND SSB.PeriodID = " & mPeriodID & " ORDER BY AT.TrialOrder"
                Set rsTmp1 = GetRecords(sSql)
                If Not rsTmp1.EOF Then
                    While Not rsTmp1.EOF
                        .Rows = .Rows + 1: Inc = Inc + 1
                        .TextMatrix(Inc, grdPLParticulars) = rsTmp1.Fields("AcTypeDescription") & ""
                        .Cell(flexcpFontBold, Inc, grdPLParticulars) = False
                        dblAmount = GetSignedValue(Val(rsTmp1.Fields("ThisYear") & ""), rsTmp1.Fields("TypeNature") & "")
                        dblLastAmount = GetSignedValue(Val(rsTmp1.Fields("LastYear") & ""), rsTmp1.Fields("TypeNature") & "")
                        .TextMatrix(Inc, grdThisYr) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0")) & ""
                        .TextMatrix(Inc, grdLastYr) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0")) & ""
                        .Cell(flexcpFontBold, Inc, grdLastYr) = False
                        dblTmpTotal = dblTmpTotal + dblAmount
                        dblTmpTotalLast = dblTmpTotalLast + dblLastAmount
                        TotDifference = dblAmount - dblLastAmount
                        .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##0") & ")", Format(TotDifference, "#,##0")) & ""
                        .Cell(flexcpFontBold, Inc, grdDifference) = False
                        If dblLastAmount = 0 Then
                            TotDiffPercent = 0
                        Else
                            TotDiffPercent = (TotDifference / dblLastAmount) * 100
                        End If
                        .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%"
                        .TextMatrix(Inc, grdAcTypeID) = rsTmp1.Fields("AcTypeID") & ""
                        FillIncomeRemarks Inc, lngSubSectionID
                        .Cell(flexcpFontBold, Inc, grdDiffPercent) = False
                        rsTmp1.MoveNext
                    Wend
                    Select Case Val(rsTmp.Fields("AcTypeID") & "")
                        Case lngAcTypeTrading
                            dblTotalTrading = dblTmpTotal
                            dblNextTotal = dblTotalTrading
                            dblTmpTotal = 0

                            dblTotalLastTrading = dblTmpTotalLast
                            dblNextTotalLast = dblTotalLastTrading
                            dblTmpTotalLast = 0
                            strTmp = "Gross " & IIf(dblNextTotal > 0, "Profit", "Loss")
                        Case lngAcTypeOperatingExp
                            dblTotalOperating = dblTmpTotal
                            dblNextTotal = dblTotalOperating + dblNextTotal
                            mdblThisOperationProfit = dblNextTotal
                            dblTmpTotal = 0

                            dblTotalLastOperating = dblTmpTotalLast
                            dblNextTotalLast = dblTotalLastOperating + dblNextTotalLast
                            mdblLastOperationProfit = dblNextTotalLast
                            dblTmpTotalLast = 0
                            strTmp = IIf(dblNextTotal > 0, "Profit", "Loss") & " from operations"
                        Case lngAcTypeNonOperatingExp
                            dblTotalNonOperating = dblTmpTotal
                            dblNextTotal = dblTotalNonOperating + dblNextTotal
                            dblTmpTotal = 0

                            dblTotalLastNonOperating = dblTmpTotalLast
                            dblNextTotalLast = dblTotalLastNonOperating + dblNextTotalLast
                            dblTmpTotalLast = 0
                            strTmp = "Net " & IIf(dblNextTotal > 0, "Profit", "Loss") & " for the year"
                    End Select
                    .Rows = .Rows + 1: Inc = Inc + 1
                    .TextMatrix(Inc, grdPLParticulars) = strTmp & ""
                    .TextMatrix(Inc, grdThisYr) = IIf(dblNextTotal < 0, "(" & Format(Abs(dblNextTotal), "#,##0") & ")", Format(dblNextTotal, "#,##0")) & ""
                    .TextMatrix(Inc, grdLastYr) = IIf(dblNextTotalLast < 0, "(" & Format(Abs(dblNextTotalLast), "#,##0") & ")", Format(dblNextTotalLast, "#,##0")) & ""
                    If .TextMatrix(Inc, grdPLParticulars) = "Gross Profit" Or .TextMatrix(Inc, grdPLParticulars) = "Gross Loss" Then
                        mdblThisNetProfit = .TextMatrix(Inc, grdThisYr)
                        mdblLastNetProfit = .TextMatrix(Inc, grdLastYr)
                    End If
                    .Cell(flexcpFontBold, Inc, grdLastYr) = False
                    TotDifference = dblNextTotal - dblNextTotalLast
                    .TextMatrix(Inc, grdDifference) = IIf(TotDifference < 0, "(" & Format(Abs(TotDifference), "#,##0") & ")", Format(TotDifference, "#,##0")) & ""
                    .Cell(flexcpFontBold, Inc, grdDifference) = False
                    If dblNextTotalLast = 0 Then
                        TotDiffPercent = 0
                    Else
                        TotDiffPercent = (TotDifference / dblNextTotalLast) * 100
                    End If
                    .TextMatrix(Inc, grdDiffPercent) = Format(TotDiffPercent, "###.0") & "%"
                    .Cell(flexcpFontBold, Inc, grdDiffPercent) = False
                    .Cell(flexcpFontUnderline, Inc - 1, grdThisYr, Inc - 1, grdLastYr) = True
                End If
                rsTmp.MoveNext
            Wend
            rsTmp.Close
        .Cell(flexcpFontName, 0, 0, .Rows - 1, .Cols - 1) = "Times New Roman"
        .Cell(flexcpAlignment, 1, grdThisYr, .Rows - 1, grdDifference) = taRightMiddle
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function ShowLiquidityRatios(mPeriodID As Long)
On Local Error GoTo Err_Exit
Dim lngLastPeriodID As Long, Inc As Long, lngThisRevenue As Long, lngLastRevenue As Long, lngThisTradeReceivable As Long, lngLastTradeReceivable As Long
Dim lngThisCurLiability As Long, lngLastCurLiability As Long, lngThisTotCurAssets As Long, lngLastTotCurAssets As Long
Dim lngThisInventory As Long, lngLastInventory As Long, lngThisQuickAsset As Long, lngLastQuickAsset As Long
Dim lngThisCash As Long, lngLastCash As Long, lngThisCostofSales As Long, lngLastCostofSales As Long
Dim lngThisFinanceCost As Long, lngLastFinanceCost As Long, lngThisProfitLoss As Long, lngLastProfitLoss As Long
Dim lngSubSectionID As Long
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)

    lngLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
    lngThisRevenue = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeRevenue))
    lngLastRevenue = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeRevenue))
    lngThisTradeReceivable = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeTradeReceivables))
    lngLastTradeReceivable = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeTradeReceivables))
    lngThisCurLiability = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentLiability))
    lngLastCurLiability = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentLiability))
    lngThisTotCurAssets = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentAssets))
    lngLastTotCurAssets = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentAssets))
    lngThisInventory = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeInventories))
    lngLastInventory = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeInventories))
    lngThisQuickAsset = lngThisTotCurAssets - lngThisInventory
    lngLastQuickAsset = lngLastTotCurAssets - lngLastInventory
    lngThisCash = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCashAndBankBalances))
    lngLastCash = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCashAndBankBalances))
    lngThisCostofSales = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCostofSales))
    lngLastCostofSales = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCostofSales))
    lngThisFinanceCost = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeFinanceCost))
    lngLastFinanceCost = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeFinanceCost))
    lngThisProfitLoss = GetTrialTypeValue(mPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeProfitLoss))
    lngLastProfitLoss = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeProfitLoss))

    With vsfgReporting(cnstgrdLiquidity)
        .Rows = 17
        .TextMatrix(1, grdLiquidityRatio) = "What is short - term debt paying ability?"
        .Cell(flexcpFontBold, 1, grdLiquidityRatio) = True
        .TextMatrix(1, grdLiquidityThisYr) = ""
        .TextMatrix(3, grdLiquidityRatio) = "Current Ratio"
        .TextMatrix(3, grdLiquiditySlNo) = "1"
        .Cell(flexcpFontBold, 3, grdLiquidityRatio) = False
        If lngThisCurLiability = 0 Then
            .TextMatrix(3, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(3, grdLiquidityThisYr) = Format((lngThisTotCurAssets / lngThisCurLiability * -1), "##0.0")
        End If
        If lngLastCurLiability = 0 Then
            .TextMatrix(3, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(3, grdLiquidityLastYr) = Format((lngLastTotCurAssets / lngLastCurLiability * -1), "##0.0")
        End If
        FillLiquidityRemarks 3, lngSubSectionID
        .TextMatrix(4, grdLiquidityRatio) = "Quick Ratio"
        .TextMatrix(4, grdLiquiditySlNo) = "2"
        .Cell(flexcpFontBold, 4, grdLiquidityRatio) = False
        If lngThisCurLiability = 0 Then
            .TextMatrix(4, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(4, grdLiquidityThisYr) = Format((lngThisQuickAsset / lngThisCurLiability * -1), "##0.0")
        End If
        If lngLastCurLiability = 0 Then
            .TextMatrix(4, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(4, grdLiquidityLastYr) = Format((lngLastQuickAsset / lngLastCurLiability * -1), "##0.0")
        End If
        FillLiquidityRemarks 4, lngSubSectionID
        .TextMatrix(5, grdLiquidityRatio) = "Cash Ratio"
        .TextMatrix(5, grdLiquiditySlNo) = "3"
        .Cell(flexcpFontBold, 5, grdLiquidityRatio) = False
        If lngThisCurLiability = 0 Then
            .TextMatrix(5, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(5, grdLiquidityThisYr) = Format((lngThisCash / lngThisCurLiability * -1), "##0.0")
        End If
        If lngLastCurLiability = 0 Then
            .TextMatrix(5, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(5, grdLiquidityLastYr) = Format((lngLastCash / lngLastCurLiability * -1), "##0.0")
        End If
        FillLiquidityRemarks 5, lngSubSectionID
        .TextMatrix(7, grdLiquidityRatio) = "How liquid are current assets?"
        .Cell(flexcpFontBold, 7, grdLiquidityRatio) = True
        .TextMatrix(9, grdLiquidityRatio) = "Days in Receivables"
        .TextMatrix(9, grdLiquiditySlNo) = "4"
        .Cell(flexcpFontBold, 9, grdLiquidityRatio) = False
        If lngThisRevenue = 0 Then
            .TextMatrix(9, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(9, grdLiquidityThisYr) = Format((lngThisTradeReceivable / lngThisRevenue * -1) * 365, "##0.0")
        End If
        If lngLastRevenue = 0 Then
            .TextMatrix(9, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(9, grdLiquidityLastYr) = Format((lngLastTradeReceivable / lngLastRevenue * -1) * 365, "##0.0")
        End If
        FillLiquidityRemarks 9, lngSubSectionID
        .TextMatrix(10, grdLiquidityRatio) = "Accounts Receivables Turnover"
        .TextMatrix(10, grdLiquiditySlNo) = "5"
        .Cell(flexcpFontBold, 10, grdLiquidityRatio) = False
        If (lngThisTradeReceivable + lngLastTradeReceivable = 0) Then
            .TextMatrix(10, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(10, grdLiquidityThisYr) = Format(lngThisRevenue * -1 / ((lngThisTradeReceivable + lngLastTradeReceivable) / 2), "##0.0")
        End If
        If lngLastTradeReceivable = 0 Then
            .TextMatrix(10, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(10, grdLiquidityLastYr) = Format((lngLastRevenue * -1 / lngLastTradeReceivable), "##0.0")
        End If
        FillLiquidityRemarks 10, lngSubSectionID
        .TextMatrix(11, grdLiquidityRatio) = "Inventory Turnover"
        .TextMatrix(11, grdLiquiditySlNo) = "6"
        .Cell(flexcpFontBold, 11, grdLiquidityRatio) = False
        If (lngThisInventory + lngLastInventory = 0) Then
            .TextMatrix(11, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(11, grdLiquidityThisYr) = Format(-lngThisCostofSales / ((lngThisInventory + lngLastInventory) / 2), "##0.0")
        End If
        If lngLastInventory = 0 Then
            .TextMatrix(11, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(11, grdLiquidityLastYr) = Format((-lngLastCostofSales / lngLastInventory), "##0.0")
        End If
        FillLiquidityRemarks 11, lngSubSectionID
        .TextMatrix(12, grdLiquidityRatio) = "Working Capital Turnover"
        .TextMatrix(12, grdLiquiditySlNo) = "7"
        .Cell(flexcpFontBold, 12, grdLiquidityRatio) = False
        If lngThisTotCurAssets + lngThisCurLiability = 0 Then
            .TextMatrix(12, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(12, grdLiquidityThisYr) = Format((lngThisRevenue * -1 / (lngThisTotCurAssets + lngThisCurLiability)), "##0.0")
        End If
        If (lngLastTotCurAssets + lngLastCurLiability = 0) Then
            .TextMatrix(12, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(12, grdLiquidityLastYr) = Format((lngLastRevenue * -1 / (lngLastTotCurAssets + lngLastCurLiability)), "##0.0")
        End If
        FillLiquidityRemarks 12, lngSubSectionID
        .TextMatrix(14, grdLiquidityRatio) = "Can future charges be met?"
        .Cell(flexcpFontBold, 14, grdLiquidityRatio) = True
        .TextMatrix(16, grdLiquidityRatio) = "Interest Coverage"
        .TextMatrix(16, grdLiquiditySlNo) = "8"
        .Cell(flexcpFontBold, 16, grdLiquidityRatio) = False
        If lngThisFinanceCost = 0 Then
            .TextMatrix(16, grdLiquidityThisYr) = "N/A"
        Else
            .TextMatrix(16, grdLiquidityThisYr) = Format(((-lngThisProfitLoss - lngThisFinanceCost) / lngThisFinanceCost), "##0.0")
        End If
        If lngLastFinanceCost = 0 Then
            .TextMatrix(16, grdLiquidityLastYr) = "N/A"
        Else
            .TextMatrix(16, grdLiquidityLastYr) = Format(((-lngLastProfitLoss - lngLastFinanceCost) / lngLastFinanceCost), "##0.0")
        End If
        FillLiquidityRemarks 16, lngSubSectionID
'        .TextMatrix(17, grdLiquidityRatio) = "Interest to Long - Term Debt"
'        .Cell(flexcpFontBold, 17, grdLiquidityRatio) = False
        .Cell(flexcpAlignment, 1, grdLiquidityThisYr, .Rows - 1, grdLiquidityLastYr) = taRightMiddle
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Sub LinkDocuments()
On Local Error GoTo Err_Exit
    If vsfgSubSections.Col >= 0 Then
        ShowRelatedDocuments vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
        DisplayLeadSheetAttachmentsAndReviews
        DisplayProcedureAttachmentsAndReviews
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub LinkReviews()
On Local Error GoTo Err_Exit
    If vsfgSubSections.Col >= 0 Then
        ShowRelatedReviews vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col), mSenderPeriodID
        DisplayLeadSheetAttachmentsAndReviews
        DisplayProcedureAttachmentsAndReviews
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgSubSections_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If vsfgSubSections.Col >= 0 Then
        If Button = vbRightButton Then
            PopupMenu MDIFormMain.mnuPopupLinkDocument
        End If
    End If
End Sub

Public Function SaveLeadSheetRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New Recordset, lngSubSectionID As Long, Inc As Long
Dim lngRemarkID As Long, lngLeadsheetRemarkID  As Long, lngActualID As Long
Dim lngAcTypeID As Long, lngAcID As Long
    AdoConn.BeginTrans
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    If vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(vsfgAuditReport(cnstGridLeadSheet).Row, grdLeadSheetAcTypeId) <> 0 Then
        lngAcTypeID = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(vsfgAuditReport(cnstGridLeadSheet).Row, grdLeadSheetAcTypeId)
        lngAcID = 0
    Else
        lngAcTypeID = 0
        lngAcID = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(vsfgAuditReport(cnstGridLeadSheet).Row, grdLeadSheetAcID)
    End If
    sSql = "Delete From FilingAccountRemarks Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & pActivePeriodID & " AND AcTypeID = " & lngAcTypeID & " AND AcID = " & lngAcID & " AND ProcedureID IS NULL"
    AdoConn.Execute sSql
    sSql = "Select * From FilingAccountRemarks Where 1=2"
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            For Inc = 1 To vsfgAuditReport(cnstGridLeadSheet).Rows - 1
                If vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetRemarks) <> "" Then
                    .AddNew
                    '.Fields("RemarkID") = GetMaxNo("FilingAccountRemarks", "RemarkID")
                    lngRemarkID = GetRangeMaxNo("FilingAccountRemarks", "RemarkID", mCompanyID * cnstFilingLeadsheetRemarksMaxCount, (mCompanyID * cnstFilingLeadsheetRemarksMaxCount) + cnstFilingLeadsheetRemarksMaxCount)
                    .Fields("RemarkID") = lngRemarkID
                    .Fields("PeriodID") = pActivePeriodID
                    .Fields("SubSectionID") = lngSubSectionID
                    If vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcTypeId) <> 0 Then
                        .Fields("AcTypeID") = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcTypeId)
                        .Fields("AcID") = Null
                    ElseIf vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcID) <> 0 Then
                        .Fields("AcTypeID") = Null
                        .Fields("AcID") = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcID)
                    Else
                        Exit Function
                    End If
                    .Fields("Description") = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetRemarks)
                    SaveDateAndUser rsTmp
                    .Update
                End If
            Next Inc
        End With
    AdoConn.CommitTrans
    SaveLeadSheetRemarks = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
'    ShowError
    SaveLeadSheetRemarks = False
End Function

Public Function FillLeadSheetRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgAuditReport(cnstGridLeadSheet).Rows > 0 Then
        If vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(lngRow, grdLeadSheetAcTypeId) <> 0 Then
            sSql = "Select * From FilingAccountRemarks Where SubSectionID = " & lngSubSectionID & " And AcTypeID = " & vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(lngRow, grdLeadSheetAcTypeId) & " AND PeriodID = " & mSenderPeriodID
        Else
            sSql = "Select * From FilingAccountRemarks Where SubSectionID = " & lngSubSectionID & " And AcID = " & vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(lngRow, grdLeadSheetAcID) & " AND PeriodID = " & mSenderPeriodID
        End If
        With GetRecords(sSql)
            While Not .EOF
                vsfgAuditReport(cnstGridLeadSheet).TextMatrix(lngRow, grdLeadSheetRemarks) = .Fields("Description") & ""
            .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
'    ShowError
End Function

Public Function ShowProfitabilityRatios(lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim lngLastPeriodID As Long, Inc As Long, lngThisRevenue As Long, lngLastRevenue As Long, lngThisTradeReceivable As Long, lngLastTradeReceivable As Long
Dim lngThisCurLiability As Long, lngLastCurLiability As Long, lngThisTotCurAssets As Long, lngLastTotCurAssets As Long
Dim lngThisInventory As Long, lngLastInventory As Long, lngThisQuickAsset As Long, lngLastQuickAsset As Long
Dim lngThisCash As Long, lngLastCash As Long, lngThisCostofSales As Long, lngLastCostofSales As Long
Dim lngThisFinanceCost As Long, lngLastFinanceCost As Long, lngThisProfitLoss As Long, lngLastProfitLoss As Long
Dim lngThisOperatingIncome As Long, lngLastOperatingIncome As Long
Dim lngThisEquity As Long, lngLastEquity As Long
Dim lngSubSectionID As Long
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)

    lngLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & lngPeriodID))
    lngThisRevenue = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeRevenue))
    lngLastRevenue = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeRevenue))
    lngThisTradeReceivable = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeTradeReceivables))
    lngLastTradeReceivable = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeTradeReceivables))
    lngThisCurLiability = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentLiability))
    lngLastCurLiability = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentLiability))
    lngThisTotCurAssets = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentAssets))
    lngLastTotCurAssets = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCurrentAssets))
    lngThisInventory = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeInventories))
    lngLastInventory = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeInventories))
    lngThisQuickAsset = lngThisTotCurAssets - lngThisInventory
    lngLastQuickAsset = lngLastTotCurAssets - lngLastInventory
    lngThisCash = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCashAndBankBalances))
    lngLastCash = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCashAndBankBalances))
    lngThisCostofSales = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCostofSales))
    lngLastCostofSales = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeCostofSales))
    lngThisFinanceCost = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeFinanceCost))
    lngLastFinanceCost = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeFinanceCost))
    lngThisProfitLoss = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeProfitLoss))
    lngLastProfitLoss = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeProfitLoss))
    lngThisOperatingIncome = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeOperatingExpenses))
    lngLastOperatingIncome = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeOperatingExpenses))
    lngThisEquity = GetTrialTypeValue(lngPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeShareHoldersEquity))
    lngLastEquity = GetTrialTypeValue(lngLastPeriodID, GetActualID(pActiveCompanyID, cnstAcTypeShareHoldersEquity))

    With vsfgReporting(cnstgrdProfitability)
        .Rows = 12
        .TextMatrix(1, grdProfitabilityRatio) = "How profitable?"
        .Cell(flexcpFontBold, 1, grdProfitabilityRatio) = True
        .TextMatrix(1, grdProfitabilityThisYr) = ""
        .TextMatrix(3, grdProfitabilityRatio) = "Gross Profit Margin"
        .TextMatrix(3, grdProfitabilitySlNo) = "1"
        .Cell(flexcpFontBold, 3, grdProfitabilityRatio) = False
        If lngThisRevenue = 0 Then
            .TextMatrix(3, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(3, grdProfitabilityThisYr) = Format((mdblThisNetProfit / lngThisRevenue * -1) * 100, "##0.0") & "%"
        End If
        If lngLastRevenue = 0 Then
            .TextMatrix(3, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(3, grdProfitabilityLastYr) = Format((mdblLastNetProfit / lngLastRevenue * -1) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 3, lngSubSectionID
        .TextMatrix(4, grdProfitabilityRatio) = "Operating Profit Margin"
        .TextMatrix(4, grdProfitabilitySlNo) = "2"
        .Cell(flexcpFontBold, 4, grdProfitabilityRatio) = False
        If lngThisRevenue = 0 Then
            .TextMatrix(4, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(4, grdProfitabilityThisYr) = Format((mdblThisOperationProfit / lngThisRevenue * -1) * 100, "##0.0") & "%"
        End If
        If lngLastRevenue = 0 Then
            .TextMatrix(4, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(4, grdProfitabilityLastYr) = Format((mdblLastOperationProfit / lngLastRevenue * -1) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 4, lngSubSectionID
        .TextMatrix(5, grdProfitabilityRatio) = "Net Profit Margin"
        .TextMatrix(5, grdProfitabilitySlNo) = "3"
        .Cell(flexcpFontBold, 5, grdProfitabilityRatio) = False
        If lngThisRevenue = 0 Then
            .TextMatrix(5, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(5, grdProfitabilityThisYr) = Format((lngThisProfitLoss / lngThisRevenue) * 100, "##0.0") & "%"
        End If
        If lngLastRevenue = 0 Then
            .TextMatrix(5, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(5, grdProfitabilityLastYr) = Format((lngLastProfitLoss / lngLastRevenue) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 5, lngSubSectionID
        .TextMatrix(7, grdProfitabilityRatio) = "How efficiently are resources used?"
        .Cell(flexcpFontBold, 7, grdProfitabilityRatio) = True
        .TextMatrix(9, grdProfitabilityRatio) = "Total Assets Turnover"
        .TextMatrix(9, grdProfitabilitySlNo) = "4"
        .Cell(flexcpFontBold, 9, grdProfitabilityRatio) = False
        If (lngThisTotCurAssets + lngLastTotCurAssets) = 0 Then
            .TextMatrix(9, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(9, grdProfitabilityThisYr) = Format((lngThisRevenue * -1 / (lngThisTotCurAssets + lngThisTotCurAssets) / 2) * 100, "##0.0") & "%"
        End If
        If lngLastTotCurAssets = 0 Then
            .TextMatrix(9, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(9, grdProfitabilityLastYr) = Format((lngLastRevenue * -1 / lngLastTotCurAssets) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 9, lngSubSectionID
        .TextMatrix(10, grdProfitabilityRatio) = "Return on Total Assets"
        .TextMatrix(10, grdProfitabilitySlNo) = "5"
        .Cell(flexcpFontBold, 10, grdProfitabilityRatio) = False
        If lngThisTotCurAssets = 0 Then
            .TextMatrix(10, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(10, grdProfitabilityThisYr) = Format(mdblThisOperationProfit / (lngThisTotCurAssets) * 100, "##0.0") & "%"
        End If
        If lngLastTotCurAssets = 0 Then
            .TextMatrix(10, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(10, grdProfitabilityLastYr) = Format((mdblLastOperationProfit / lngLastTotCurAssets) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 10, lngSubSectionID
        .TextMatrix(11, grdProfitabilityRatio) = "Return on Equity"
        .TextMatrix(11, grdProfitabilitySlNo) = "6"
        .Cell(flexcpFontBold, 11, grdProfitabilityRatio) = False
        If lngThisEquity = 0 Then
            .TextMatrix(11, grdProfitabilityThisYr) = "N/A"
        Else
            .TextMatrix(11, grdProfitabilityThisYr) = Format((lngThisProfitLoss / lngThisEquity) * 100, "##0.0") & "%"
        End If
        If lngLastEquity = 0 Then
            .TextMatrix(11, grdProfitabilityLastYr) = "N/A"
        Else
            .TextMatrix(11, grdProfitabilityLastYr) = Format((lngLastProfitLoss / lngLastEquity) * 100, "##0.0") & "%"
        End If
        FillProfitabilityRemarks 11, lngSubSectionID
        .Cell(flexcpAlignment, 1, grdProfitabilityThisYr, .Rows - 1, grdProfitabilityLastYr) = taRightMiddle
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Property Let ShowCompanyInfo(ByVal lngCompanyID As Long)
On Local Error Resume Next
Dim sSql As String, Inc As Long, lngCol As Long
Dim strUserGrp(6) As String
     If lngCompanyID <> 0 Then
        '---Positioning Controls--------------------------
        With picCompanyInfo
            .Left = 0
            .Top = 0
            .Height = Me.Height
            .Width = Me.Width
        End With
        With lineCompany1
            .Left = 80
            .Top = 1600
            .Width = picCompanyInfo.Width - GetProportionalValue(3000, False)
            .EndColor = RGB(232, 232, 196)
'            .X1 = 80
'            .Y1 = 1600
'            .X2 = picCompanyInfo.Width
'            .Y2 = 1600
        End With
        With lineCompany2
            .Left = 80
            .Top = 2000
            .Width = picCompanyInfo.Width - GetProportionalValue(3000, False)
            .EndColor = RGB(232, 232, 196)
'            .X1 = 80
'            .Y1 = 2000
'            .X2 = picCompanyInfo.Width
'            .Y2 = 2000
        End With
        With lineCompany3
            .X1 = 0
            .Y1 = 2700
            .X2 = picCompanyInfo.Width
            .Y2 = 2700
            .Visible = False
        End With
        With lineCompany4
            .X1 = 0
            .Y1 = 6200
            .X2 = picCompanyInfo.Width
            .Y2 = 6200
            .Visible = False
        End With
        With lineCompanyVert1
            .X1 = GetProportionalValue(7000, False)
            .Y1 = lineCompany3.Y1
            .X2 = .X1
            .Y2 = picCompanyInfo.Height
            .Visible = False
        End With
        '---------------------------------------
        With lblCompanyName
            .Left = 500
            .Top = 260
        End With
        '------
        With lblCmpAddress1
            .Left = 500
            .Top = 700
        End With
        With lblCmpAddress2
            .Left = 500
            .Top = 1000
        End With
        With lblCmpAddress3
            .Left = 500
            .Top = 1300
        End With
        '------
        With lblCmpPhone
            .Left = GetProportionalValue(7000, False)
            .Top = 700
        End With
        With lblCmpFax
            .Left = GetProportionalValue(7000, False)
            .Top = 1000
        End With
        With lblCmpEmail
            .Left = GetProportionalValue(7000, False)
            .Top = 1300
        End With
        '-----
        With lblCmpCurrency
            .Left = 500
            .Top = 1700
        End With
        With lblCmpStatus
            .Left = GetProportionalValue(7000, False)
            .Top = 1700
        End With
        '-----
        With lblCmpContactName
            .Left = 500
            .Top = 2100
        End With
        With lblCmpContactMob
            .Left = GetProportionalValue(7000, False)
            .Top = 2100
        End With
        With lblCmpContactDesig
            .Left = 500
            .Top = 2400
        End With
        With lblCmpContactEmail
            .Left = GetProportionalValue(7000, False)
            .Top = 2400
        End With
        '---Loading Data----------------------------------
        sSql = "SELECT CUR.CurrencyName, ST.StatusName, CMP.* " & _
               "FROM Companies CMP LEFT OUTER JOIN Status ST ON CMP.StatusID = ST.StatusID LEFT OUTER JOIN " & _
               "CurrencyMaster CUR ON CMP.CurrencyID = CUR.CurrencyID Where CMP.CompanyID = " & lngCompanyID
        With GetRecords(sSql)
            lblCompanyName = .Fields("CompanyName") & " [" & .Fields("JobCode") & "]"
            lblCmpAddress1 = GetFormatedStr(.Fields("CompanyAdd1") & "")
            lblCmpAddress2 = GetFormatedStr(.Fields("CompanyAdd2") & "")
            lblCmpAddress3 = GetFormatedStr(.Fields("CompanyAdd3") & "")
            
            lblCmpPhone = IIf(.Fields(Trim("CompanyPhone") & "") = "", "", "Phone. " & .Fields("CompanyPhone") & "")
            lblCmpFax = IIf(.Fields(Trim("CompanyFax") & "") = "", "", "Fax. " & .Fields("CompanyFax") & "")
            lblCmpEmail = IIf(.Fields(Trim("CompanyEmail") & "") = "", "", "Email. " & .Fields("CompanyEmail") & "")
            
            lblCmpCurrency = IIf(.Fields(Trim("CurrencyName") & "") = "", "", "Currency. " & .Fields("CurrencyName") & "")
            lblCmpStatus = IIf(.Fields(Trim("StatusName") & "") = "", "", "Current Status. " & .Fields("StatusName") & "")
            
            lblCmpContactName = "Contact Person. " & .Fields("ContactPerson") & ""
            lblCmpContactMob = "Contact No. " & .Fields("ContPerPhone") & ""
            lblCmpContactDesig = "Contact Designation. " & .Fields("ContPerDesignation") & ""
            lblCmpContactEmail = "Contact Email. " & .Fields("ContPerEmail") & ""
            
            '---Removing Unnecessory controls-------------
            RemovePeriodControls
            '---------------------------------------------
            sSql = "SELECT PER.*, DER_PER.Description AS Derived, COMP_PER.Description AS Compared, AUT.AuditTypeName AS AuditType, ST.StatusName AS Status " & _
                   "FROM Periods PER LEFT OUTER JOIN Status ST ON PER.StatusID = ST.StatusID LEFT OUTER JOIN Periods COMP_PER ON PER.ComparePeriodID = COMP_PER.PeriodID LEFT OUTER JOIN " & _
                   "Periods DER_PER ON PER.DerivedPeriodID = DER_PER.PeriodID LEFT OUTER JOIN AuditType AUT ON PER.AuditTypeID = AUT.AuditTypeID " & _
                   "Where (PER.CompanyID = " & lngCompanyID & ") Order By PER.StartDt DESC"
            With GetRecords(sSql)
                lngCol = 0
                While Not .EOF
                    '---Load Objects-------------------
                    LoadPeriodControls Inc
                    '---Position Controls--------------
                    ArrangePeriodControls Inc, (Inc / 3) - (Inc Mod 1), Inc Mod 2
                    '---Filling Data-------------------
                    lblCmpPeriodDesc(Inc) = "Period Description. " & .Fields("Description") & ""
                    lblCmpPeriodAuditType(Inc) = "Audit Type. " & .Fields("AuditType") & ""
                    lblCmpPeriodStatus(Inc) = "Current Status. " & .Fields("Status") & ""
                    lblCmpPeriodStartDt(Inc) = "Start Date. " & Format(.Fields("StartDt") & "", "dd/MMM/yyyy")
                    lblCmpPeriodEndDt(Inc) = "End Date. " & Format(.Fields("EndDt") & "", "dd/MMM/yyyy")
                    lblCmpPeriodDerivedFrom(Inc) = "Derived from. " & .Fields("Derived") & ""
                    lblCmpPeriodComparedWith(Inc) = "Compared with. " & .Fields("Compared") & ""
                    
                    GetPeriodUserGroups strUserGrp, Val(.Fields("PeriodID") & "")
                    
                    lblCmpPeriodPartner(Inc) = strUserGrp(1)
                    lblCmpPeriodManager(Inc) = strUserGrp(2)
                    lblCmpPeriodAuditor(Inc) = strUserGrp(3)
                    lblCmpPeriodAuditAssist(Inc) = strUserGrp(4)
                    lblCmpPeriodDataEntry(Inc) = strUserGrp(5)
                    Inc = Inc + 1
                    .MoveNext
                Wend
                .Close
            End With
            .Close
        End With
        '-------------------------------------------------
        picCompanyInfo.BackColor = RGB(245, 240, 250)
        Set picCompanyInfo.Picture = GetBackPicture
        picCompanyInfo.ZOrder vbBringToFront
        picCompanyInfo.Visible = True
     Else
        picCompanyInfo.Visible = False
     End If
End Property

Public Function GetBackPicture() As IPictureDisp
On Local Error Resume Next
'    Select Case GetResolution
'    Case "1024 X 768"
'    Case "1280 X 800"
'    Case "1280 X 960"
'    Case "1280 X 1024"
'    End Select
    Set GetBackPicture = imgLstCmpInfo.ListImages(GetResolution).Picture
End Function

Public Function GetFormatedStr(strSource As String) As String
On Local Error Resume Next
    GetFormatedStr = Replace(Replace(Replace(Replace(strSource, vbNewLine, " "), vbTab, " "), vbCr, " "), vbLf, " ")
End Function

Private Sub GetPeriodUserGroups(strUserGrp() As String, lngPeriodID As Long)
On Local Error Resume Next
Dim sSql As String, Inc As Long, strUserGroupTmp As String, strRet As String
'    sSql = "SELECT  DISTINCT UPS.UserID, UPS.PeriodID, UserGroups.UserGroupName, Users.UserName, UserGroups.OrderField " & _
'           "FROM    UserPrivilegesSub UPS INNER JOIN UserGroupUsers UGS ON UPS.UserID = UGS.UserID INNER JOIN " & _
'           "        UserGroups ON UGS.UserGroupID = UserGroups.UserGroupID INNER JOIN Users ON UPS.UserID = Users.UserID " & _
'           "Where   UPS.PeriodID = " & lngPeriodID & " ORDER BY UserGroups.OrderField"
    sSql = "SELECT    Users.UserName, UserGroups.UserGroupName, UserPrivileges.PeriodID " & _
           "FROM      Users INNER JOIN UserGroupUsers ON Users.UserID = UserGroupUsers.UserID INNER JOIN UserGroups " & _
           "          ON UserGroupUsers.UserGroupID = UserGroups.UserGroupID INNER JOIN UserPrivileges ON Users.UserID = UserPrivileges.UserID " & _
           "Where     UserPrivileges.PeriodID = " & lngPeriodID & " ORDER BY UserGroups.OrderField"
    With GetRecords(sSql)
        While Not .EOF
            If strUserGroupTmp <> .Fields("UserGroupName") & "" Then
                If Len(strRet) <> "" Then
                    strRet = Left(strRet, Len(strRet) - 2)
                End If
                strUserGrp(Inc) = strRet
                strUserGroupTmp = .Fields("UserGroupName") & ""
                strRet = .Fields("UserGroupName") & ". " & .Fields("UserName") & ", "
                Inc = Inc + 1
            Else
                strRet = strRet & .Fields("UserName") & ", "
            End If
            .MoveNext
        Wend
        .Close
        
        If strRet <> "" Then
            If Len(strRet) <> "" Then
                strRet = Left(strRet, Len(strRet) - 2)
            End If
            strUserGrp(Inc) = strRet
        End If
    End With
End Sub

Private Sub ArrangePeriodControls(Inc As Long, Row As Long, Col As Long)
On Local Error Resume Next
Dim lngTop As Long, lngLeft As Long
Const cnstLineSpacing = 290
Const cnstStartTop = 2600
    lngTop = (Row * 3500) + cnstStartTop
    If Col = 0 Then
        lngLeft = 500
    Else
        lngLeft = GetProportionalValue(7200, False)
    End If
    '------------------------------------------------------------
    With lblCmpPeriodDesc(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodAuditType(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodStatus(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodStartDt(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodEndDt(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodDerivedFrom(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodComparedWith(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodPartner(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodManager(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodAuditor(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
    With lblCmpPeriodAuditAssist(Inc)
        .Left = lngLeft
        lngTop = lngTop + cnstLineSpacing
        .Top = lngTop
    End With
'    With lblCmpPeriodDataEntry(Inc)
'        .Left = lngLeft
'        lngTop = lngTop + cnstLineSpacing
'        .Top = lngTop
'    End With
End Sub

Private Sub LoadPeriodControls(Inc As Long)
On Local Error Resume Next
    Load lblCmpPeriodDesc(Inc)
    lblCmpPeriodDesc(Inc).Visible = True
    
    Load lblCmpPeriodAuditType(Inc)
    lblCmpPeriodAuditType(Inc).Visible = True
    
    Load lblCmpPeriodStatus(Inc)
    lblCmpPeriodStatus(Inc).Visible = True
    
    Load lblCmpPeriodStartDt(Inc)
    lblCmpPeriodStartDt(Inc).Visible = True
    
    Load lblCmpPeriodEndDt(Inc)
    lblCmpPeriodEndDt(Inc).Visible = True
    
    Load lblCmpPeriodDerivedFrom(Inc)
    lblCmpPeriodDerivedFrom(Inc).Visible = True
    
    Load lblCmpPeriodComparedWith(Inc)
    lblCmpPeriodComparedWith(Inc).Visible = True
    
    Load lblCmpPeriodPartner(Inc)
    lblCmpPeriodPartner(Inc).Visible = True
    
    Load lblCmpPeriodManager(Inc)
    lblCmpPeriodManager(Inc).Visible = True
    
    Load lblCmpPeriodAuditor(Inc)
    lblCmpPeriodAuditor(Inc).Visible = True
    
    Load lblCmpPeriodAuditAssist(Inc)
    lblCmpPeriodAuditAssist(Inc).Visible = True
    
'    Load lblCmpPeriodDataEntry(Inc)
'    lblCmpPeriodDataEntry(Inc).Visible = True
End Sub

Private Sub RemovePeriodControls()
On Local Error Resume Next
Dim Inc As Long
    For Inc = 10 To 0 Step -1
        lblCmpPeriodDesc(Inc).Visible = False
        Unload lblCmpPeriodDesc(Inc)

        lblCmpPeriodAuditType(Inc).Visible = False
        Unload lblCmpPeriodAuditType(Inc)

        lblCmpPeriodStatus(Inc).Visible = False
        Load lblCmpPeriodStatus(Inc)

        lblCmpPeriodStartDt(Inc).Visible = False
        Unload lblCmpPeriodStartDt(Inc)

        lblCmpPeriodEndDt(Inc).Visible = False
        Unload lblCmpPeriodEndDt(Inc)

        lblCmpPeriodDerivedFrom(Inc).Visible = False
        Unload lblCmpPeriodDerivedFrom(Inc)

        lblCmpPeriodComparedWith(Inc).Visible = False
        Unload lblCmpPeriodComparedWith(Inc)

        lblCmpPeriodPartner(Inc).Visible = False
        Unload lblCmpPeriodPartner(Inc)

        lblCmpPeriodManager(Inc).Visible = False
        Unload lblCmpPeriodManager(Inc)

        lblCmpPeriodAuditor(Inc).Visible = False
        Unload lblCmpPeriodAuditor(Inc)

        lblCmpPeriodAuditAssist(Inc).Visible = False
        Unload lblCmpPeriodAuditAssist(Inc)

'        lblCmpPeriodDataEntry(Inc).Visible = False
'        Unload lblCmpPeriodDataEntry(Inc)
    Next
End Sub

'Ref No: 009 - 06/04/08
Public Function SaveSubSectionReview() As Boolean
On Local Error GoTo Err_Exit
Dim lngSubSectionID As Long, sSql As String, rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    If mblnIsReview Then
        Exit Function
    End If
    AdoConn.BeginTrans
    sSql = "Delete From ReviewSubSections Where SubSectionID = " & lngSubSectionID & " And PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "Select * From ReviewSubSections Where 1 = 2"
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            .AddNew
            .Fields("SubSectionID") = lngSubSectionID
            .Fields("PeriodID") = mSenderPeriodID
            .Fields("ChkReview") = cbReview
            SaveDateAndUser rsTmp
            .Update
            .Close
        End With
    AdoConn.CommitTrans
    SaveSubSectionReview = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
    SaveSubSectionReview = False
End Function

Public Sub FillSubSectionReview(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "Select * From ReviewSubSections Where SubSectionID = " & lngSubSectionID & " And PeriodID = " & mSenderPeriodID
        mblnIsReview = True
        With GetRecords(sSql)
            If Not .EOF Then
                cbReview = IIf(.Fields("ChkReview") & "" = "True", 1, 0)
                If .Fields("UpdateUser") <> pUserID Then
                    cbReview = 0
                End If
            Else
                cbReview = 0
            End If
        End With
        mblnIsReview = False
Exit Sub
Err_Exit:
'    ShowError
    mblnIsReview = False
End Sub

Public Sub PrintAuditFile()
On Local Error Resume Next
Dim lngSectionID As Long, lngSubSectionID As Long, Inc As Long, Inc1 As Long
Dim sSql As String, strTmp As String, rsTmp As New ADODB.Recordset
Dim strCompanyName As String, strJobCode As String, strPeriodDesc As String
Dim strSection As String, strSubSection As String, strReviewedBy As String
Dim ctrlTmp As Control, arrCtrl() As Control, arrInc As Long, blnDataExists As Boolean
Dim RowInc As Long, ColInc As Long, dblWidth As Double, lngOldRows As Long, lngLastCol As Long
Dim strGridType As String, lngInc As Long, strLastGridType As String
    Screen.MousePointer = vbHourglass
    ReDim arrCtrl(0)
    arrInc = 0
    Unload frmPreview
    lngSubSectionID = Val(vsfgSubSections.TextMatrix(1, vsfgSubSections.Col))
    sSql = "SELECT  USR.UserName AS ReviewedBy " & _
           "FROM    ReviewSubSections RSS INNER JOIN Users USR ON RSS.CreateUser = USR.UserID " & _
           "        INNER JOIN FilingSubSection FSS ON RSS.SubSectionID = FSS.SubSectionID " & _
           "WHERE   RSS.PeriodID = " & mSenderPeriodID & " And FSS.SubSectionID = " & lngSubSectionID & " " & _
           "AND     RSS.ChkReview = 1"
    With GetRecords(sSql)
        If Not .EOF Then
            strReviewedBy = StrConv(.Fields("ReviewedBy") & "", vbProperCase)
        End If
        .Close
    End With
    sSql = "SELECT  CMP.CompanyName AS CompanyName, CMP.JobCode AS JobNo, PRD.Description AS PeriodName " & _
           "FROM    Companies CMP INNER JOIN Periods PRD ON CMP.CompanyID = PRD.CompanyID " & _
           "WHERE   CMP.CompanyID = " & pActiveCompanyID & " And PRD.PeriodID  = " & mSenderPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            strCompanyName = .Fields("CompanyName") & ""
            strJobCode = .Fields("JobNo") & ""
            strPeriodDesc = .Fields("PeriodName") & ""
        End If
        .Close
    End With
    strSection = Replace(vsfgSections.TextMatrix(vsfgSections.Row, 0), ">", "")
    strSubSection = vsfgSubSections.TextMatrix(0, vsfgSubSections.Col)
    With frmPreview.vpPreview
        .PaperSize = pprA4
        .Orientation = orPortrait
        .MarginLeft = 1440
        .MarginTop = 3600
        .MarginRight = 800
        .MarginBottom = 1000
        .BrushStyle = bsTransparent
        .StartDoc
        .CurrentY = 3200
        .CurrentX = 1440
        .TextAlign = taJustTop
        For Each ctrlTmp In Controls
            If ctrlTmp.Visible Then
                Select Case TypeName(ctrlTmp)
                Case "TextBox", "Label", "VSFlexGrid"
                    If ctrlTmp.Name <> "vsfgSections" And ctrlTmp.Name <> "vsfgSubSections" _
                        And ctrlTmp.Container.Name <> "picCompanyInfo" Then
                        arrInc = arrInc + 1
                        ReDim Preserve arrCtrl(arrInc)
                        Set arrCtrl(arrInc) = ctrlTmp
                    End If
                End Select
            End If
        Next ctrlTmp
        For Inc = 1 To UBound(arrCtrl)
            For Inc1 = Inc + 1 To UBound(arrCtrl)
                If arrCtrl(Inc).Top > arrCtrl(Inc1).Top Then
                    Set ctrlTmp = arrCtrl(Inc)
                    Set arrCtrl(Inc) = arrCtrl(Inc1)
                    Set arrCtrl(Inc1) = ctrlTmp
                End If
            Next Inc1
        Next Inc
        For Inc = 1 To UBound(arrCtrl)
            frmPreview.vpPreview = ""
            Select Case TypeName(arrCtrl(Inc))
            Case "Label"
                .TextAlign = taLeftTop
                frmPreview.vpPreview = arrCtrl(Inc).Caption
            Case "TextBox"
                frmPreview.vpPreview = arrCtrl(Inc).Text
            Case "VSFlexGrid"
                lngInc = Val(vsfgSubSections.TextMatrix(1, vsfgSubSections.Col))
                strGridType = ""
                strLastGridType = ""
                For lngInc = 19 To 40
                    If lngInc = lngSubSectionID Then
                        If arrCtrl(Inc).TextMatrix(1, arrCtrl(Inc).Cols - 1) = "Leadsheets" Then
                            strGridType = "Leadsheets"
                            strLastGridType = "Leadsheets"
                            Exit For
                        ElseIf arrCtrl(Inc).TextMatrix(1, arrCtrl(Inc).Cols - 1) = "Matters Arising" Then
                            strGridType = "Matters Arising"
                            Exit For
                        ElseIf arrCtrl(Inc).TextMatrix(1, arrCtrl(Inc).Cols - 1) = "Procedures" Then
                            strGridType = "Procedures"
                            Exit For
                        ElseIf arrCtrl(Inc).TextMatrix(1, arrCtrl(Inc).Cols - 1) = "Reviews" Then
                            strGridType = "Reviews"
                            Exit For
                        Else
                            strGridType = " Related Documents"
                            Exit For
                        End If
                    End If
                Next lngInc
                If strGridType <> strLastGridType Then
                    .NewPage
                End If
                .StartTable
                    .TableCell(tcCols) = 1
                    .TableCell(tcRows) = 2
                    .TableCell(tcColWidth, , 1) = 5000
                    .TableCell(tcFontBold, 1, 1) = True
                    .TableCell(tcFontUnderline, 1, 1) = True
                    .TableCell(tcText, 1, 1) = strGridType
                    .TableBorder = tbNone
                .EndTable
                .StartTable
                .TableBorder = tbAll
                .TableCell(tcCols) = arrCtrl(Inc).Cols
                For RowInc = 0 To arrCtrl(Inc).Rows - 1
                    lngOldRows = .TableCell(tcRows)
                    .TableCell(tcRows) = RowInc + 1
                    blnDataExists = False
                    lngLastCol = 0
                    dblWidth = 0
                    For ColInc = 0 To arrCtrl(Inc).Cols - 1
                        .TableCell(tcText, RowInc + 1, ColInc + 1) = arrCtrl(Inc).Cell(flexcpTextDisplay, RowInc, ColInc)
                        .TableCell(tcAlign, RowInc + 1, ColInc + 1) = GetPrintAlignment(arrCtrl(Inc).ColAlignment(ColInc))
                        .TableCell(tcFontBold, RowInc + 1, ColInc + 1) = arrCtrl(Inc).Cell(flexcpFontBold, RowInc, ColInc)
                        If arrCtrl(Inc).FixedRows > RowInc Then
                            .TableCell(tcBackColor, RowInc + 1, ColInc + 1) = &H8000000F
                        Else
                            If arrCtrl(Inc).Cell(flexcpBackColor, RowInc, ColInc) <> 0 Then
                                .TableCell(tcBackColor, RowInc + 1, ColInc + 1) = &H8000000F
                            End If
                        End If
                        If arrCtrl(Inc).ColHidden(ColInc) Or arrCtrl(Inc).TextMatrix(0, ColInc) = "Rev" Or arrCtrl(Inc).TextMatrix(0, ColInc) = "Attachments" _
                            Or arrCtrl(Inc).TextMatrix(0, ColInc) = "Attach" Or arrCtrl(Inc).TextMatrix(0, ColInc) = "Templates" Then
                            .TableCell(tcColWidth, , ColInc + 1) = 0
                        Else
                            lngLastCol = ColInc
                            .TableCell(tcColWidth, , ColInc + 1) = (9800# / arrCtrl(Inc).Width) * arrCtrl(Inc).ColWidth(ColInc)
                            dblWidth = dblWidth + .TableCell(tcColWidth, , ColInc + 1)
                        End If
                        If Trim(arrCtrl(Inc).TextMatrix(RowInc, ColInc)) <> "" Then
                            blnDataExists = True
                        End If
                    Next ColInc
                    dblWidth = 9800 - dblWidth
                    If dblWidth > 0 Then
                        .TableCell(tcColWidth, , lngLastCol + 1) = .TableCell(tcColWidth, , lngLastCol + 1) + dblWidth
                    End If
                    If Not blnDataExists Then
                        .TableCell(tcRows) = lngOldRows
                    End If
                Next RowInc
                If .TableCell(tcRows) = 1 And arrCtrl(Inc).Rows > 1 Then
                    .TableCell(tcRows) = 2
                End If
                .EndTable
            End Select
            strLastGridType = strGridType
            strGridType = ""
        Next Inc
        .EndDoc
        'Ref No : 019-29/05/08, 29th May 2008, Thursday -------
        For Inc = 1 To .PageCount
            .StartOverlay Inc, True
                .CurrentX = .MarginLeft
                .CurrentY = .MarginTop - 300
                .PenWidth = 20
                .DrawRectangle 1440, 1000, 11000, 2000
                .TextAlign = taCenterTop
                .FontBold = True
                .FontSize = 14
                .TextBox strCompanyName, 1440, 1300, 9000, 1000
                .FontSize = 12
                .TextAlign = taLeftTop
                .DrawRectangle 1440, 2100, 8000, 3000
                .FontBold = False
                .TextBox "Section : ", 1600, 2200, 1600, 2000
                .TextBox Trim(strSection), 3000, 2200, 4000, 2000
                .TextBox "Sub Section : ", 1600, 2600, 1600, 2000
                .TextBox strSubSection, 3000, 2600, 8000, 2000
                .DrawRectangle 8200, 2100, 11000, 3000
                .TextBox "Job No : ", 8400, 2200, 2000, 1000
                .TextBox strJobCode, 9300, 2200, 1000, 1000
                .TextBox "Year : ", 8400, 2600, 2000, 1000
                .TextBox strPeriodDesc, 9300, 2600, 3500, 1000
                If Inc = .PageCount Then
                    strTmp = "Prepared by :  " & pUserName & "                                                                    Reviewed by :  " & strReviewedBy
                Else
                    strTmp = ""
                End If
                .CurrentX = .MarginLeft
                .CurrentY = .PageHeight - (.MarginBottom + 500)
                .TextAlign = taLeftTop
                .TextAlign = taLeftTop
                frmPreview.vpPreview = strTmp
                .TextAlign = taCenterTop
                frmPreview.vpPreview = Inc & "  of  " & .PageCount
            .EndOverlay
        Next Inc
    End With
    Screen.MousePointer = vbDefault
    frmPreview.Show vbModal
End Sub

Public Sub DisplayClientMeetingsAttachments(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    sSql = "SELECT  Count(*) AS Nos " & _
           "FROM    DocumentSubLinks DSL WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgAuditReport(cnstGridRemarks).Rows - 1
                If vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksObservations) <> "" Then
                    vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksActions) = "Attach : " & Val(.Fields("Nos") & "")
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub DisplayClientMeetingsReviews(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    ClearRemarks
    sSql = "Select * From Remarks Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
        With GetRecords(sSql)
            While Not .EOF
                vsfgAuditReport(cnstGridRemarks).Rows = vsfgAuditReport(cnstGridRemarks).Rows + 1: Inc = Inc + 1
                vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksSlNo) = Inc
                vsfgAuditReport(cnstGridRemarks).TextMatrix(Inc, grdRemarksObservations) = .Fields("Observations") & ""
                .MoveNext
            Wend
            .Close
        End With
        vsfgAuditReport(cnstGridRemarks).AutoSizeMode = flexAutoSizeRowHeight
        vsfgAuditReport(cnstGridRemarks).AutoSize grdRemarksObservations
Exit Sub
Err_Exit:
    ShowError
End Sub

'Public Function SaveGeneralReviews(lngSubSectionID As Long) As Boolean
'On Local Error GoTo Err_Exit
'Dim sSql As String, Inc As Long, IsInTran As Boolean
'Dim IsNewRec As Boolean
'    AdoConn.BeginTrans
'    IsInTran = True
'    sSql = "Delete From Reviews Where SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
'    AdoConn.Execute sSql
'    sSql = "Select * From Reviews Where 1=2"                 'SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
'        For Inc = 1 To vsfgAuditReport(cnstGridGeneralReviews).Rows - 1
'            If vsfgAuditReport(cnstGridGeneralReviews).TextMatrix(Inc, grdGenReviewSlNo) <> "" Then
'                With GetRecords(sSql)
'                    If .EOF Then
'                        .AddNew
'                        .Fields("ReviewID") = GetMaxNo("Reviews", "ReviewID")
'                        .Fields("CreateUser") = pUserID
'                        .Fields("CreateDate") = ServerDateTime
'                        IsNewRec = True
'                    End If
'                    .Fields("PeriodID") = mSenderPeriodID
'                    .Fields("SubSectionID") = lngSubSectionID
'                    .Fields("Question") = vsfgAuditReport(cnstGridGeneralReviews).TextMatrix(Inc, grdGenReviews)
''                    If IsNewRec Then
''                        .Fields("CreateUser") = pUserID
''                        .Fields("CreateDate") = ServerDateTime
''                    End If
'                    If Trim(vsfgAuditReport(cnstGridGeneralReviews).TextMatrix(Inc, grdGenReviewReply)) <> "" Then
'                        .Fields("Answer") = vsfgAuditReport(cnstGridGeneralReviews).TextMatrix(Inc, grdGenReviewReply)
'                        .Fields("UpdateUser") = pUserID
'                        .Fields("UpdateDate") = ServerDateTime
'                    End If
'                    .Update
'                    .Close
'                End With
'            End If
'        Next Inc
'    AdoConn.CommitTrans
'    SaveGeneralReviews = True
'Exit Function
'Err_Exit:
'    If IsInTran Then
'        AdoConn.RollbackTrans
'        ShowError
'    End If
'    SaveGeneralReviews = False
'End Function
    
Public Sub FillGeneralReviews(lngSubSectionID As Long)
On Local Error Resume Next
Dim sSql As String, rsTmp As New ADODB.Recordset, Inc As Long
    sSql = "SELECT  RW.Question, RW.Answer, ReviewUser.UserName AS ReviewUser, ReplyUser.UserName AS ReplyUser, RW.CreateDate AS ReviewDate, RW.UpdateDate AS ReplyDate, " & _
           "        RW.ReviewID, RW.PeriodID, RW.SubSectionID, ReviewUser.UserID AS ReviewUserID, ReplyUser.UserID AS ReplyUserID " & _
           "FROM    Reviews RW INNER JOIN Users ReviewUser ON RW.CreateUser = ReviewUser.UserID LEFT OUTER JOIN Users ReplyUser ON RW.UpdateUser = ReplyUser.UserID " & _
           "Where   RW.PeriodID = " & mSenderPeriodID & " AND RW.SubSectionID = " & lngSubSectionID
    Set rsTmp = GetRecords(sSql)
    vsfgAuditReport(cnstGridGeneralReviews).Rows = 2
    With vsfgAuditReport(cnstGridGeneralReviews)
        If Not rsTmp.EOF Then
            While Not rsTmp.EOF
                .Rows = .Rows + 1: Inc = Inc + 1
                .TextMatrix(Inc, grdGenReviewSlNo) = Inc
                .TextMatrix(Inc, grdGenReviews) = rsTmp.Fields("Question") & ""
                .TextMatrix(Inc, grdGenReviewedBy) = StrConv(rsTmp.Fields("ReviewUser") & "", vbProperCase)
                If rsTmp.Fields("Answer") & "" <> "" Then
                    .TextMatrix(Inc, grdGenReviewReply) = rsTmp.Fields("Answer") & ""
                    .TextMatrix(Inc, grdGenReviewRepliedBy) = StrConv(rsTmp.Fields("ReplyUser") & "", vbProperCase)
                Else
                    .TextMatrix(Inc, grdGenReviewReply) = ""
                    .TextMatrix(Inc, grdGenReviewRepliedBy) = ""
                End If
                .TextMatrix(Inc, grdGenReviewID) = Val(rsTmp.Fields("ReviewID") & "")
            rsTmp.MoveNext
            Wend
        Else
            vsfgAuditReport(cnstGridReviews).Rows = 1: vsfgAuditReport(cnstGridReviews).Rows = 2
        End If
        rsTmp.Close
        .AutoSizeMode = flexAutoSizeRowHeight
        .AutoSize grdGenReviews
    End With
End Sub

Public Function DeleteSectionReviews(lngSubSectionID As Long, lngReviewID As Long, Optional IsMsg As Boolean = False) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, IsDelete As Boolean
    If IsMsg Then
        IsDelete = pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgInformation, True)
    Else
        IsDelete = True
    End If
    If IsDelete Then
        AdoConn.BeginTrans
        sSql = "Delete From Reviews Where PeriodID = " & mSenderPeriodID & " AND SubSectionID = " & lngSubSectionID & " AND ReviewID = " & lngReviewID
        AdoConn.Execute sSql
        AdoConn.CommitTrans
        DeleteSectionReviews = True
        Exit Function
    End If
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    DeleteSectionReviews = False
End Function

'--- Ref No: 063-18/01/09 ------------------
Public Function SaveProcedureRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset, lngSubSectionID As Long, Inc As Long
Dim lngRemarkID As Long, lngProcedureRemarkID  As Long, lngActualID As Long
    AdoConn.BeginTrans
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    'sSql = "Delete From FilingAccountRemarks Where SubSectionID = " & lngSubSectionID & " And ProcedureID = " & vsfgAuditReport(cnstGridProcedures).TextMatrix(vsfgAuditReport(cnstGridProcedures).Row, grdProcedureID) & " And PeriodID = " & mSenderPeriodID
    sSql = "DELETE FROM FilingAccountRemarks WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & pActivePeriodID & " AND AcTypeID IS NULL AND AcID IS NULL AND ProcedureID = " & vsfgAuditReport(cnstGridProcedures).TextMatrix(vsfgAuditReport(cnstGridProcedures).Row, grdProcedureID)
    AdoConn.Execute sSql
    sSql = "SELECT * FROM FilingAccountRemarks WHERE 1=2"
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            For Inc = 1 To vsfgAuditReport(cnstGridProcedures).Rows - 1
                If vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureRemarks) <> "" Then
                    .AddNew
                    '.Fields("RemarkID") = GetMaxNo("FilingAccountRemarks", "RemarkID")
                    lngRemarkID = GetRangeMaxNo("FilingAccountRemarks", "RemarkID", mCompanyID * cnstFilingProcedureRemarksMaxCount, (mCompanyID * cnstFilingProcedureRemarksMaxCount) + cnstFilingProcedureRemarksMaxCount)
                    .Fields("RemarkID") = lngRemarkID
                    .Fields("PeriodID") = pActivePeriodID
                    .Fields("SubSectionID") = lngSubSectionID
                    .Fields("AcTypeID") = Null
                    .Fields("AcID") = Null
                    .Fields("Description") = vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureRemarks)
                    .Fields("ProcedureID") = vsfgAuditReport(cnstGridProcedures).TextMatrix(Inc, grdProcedureID)
                    SaveDateAndUser rsTmp
                    .Update
                End If
            Next Inc
        End With
    AdoConn.CommitTrans
    SaveProcedureRemarks = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
'    ShowError
    SaveProcedureRemarks = False
End Function

Public Function FillProcedureRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgAuditReport(cnstGridProcedures).Rows > 0 Then
        sSql = "SELECT * FROM FilingAccountRemarks WHERE SubSectionID = " & lngSubSectionID & " AND ProcedureID = " & vsfgAuditReport(cnstGridProcedures).ValueMatrix(lngRow, grdProcedureID) & " AND PeriodID = " & mSenderPeriodID
        With GetRecords(sSql)
            While Not .EOF
                vsfgAuditReport(cnstGridProcedures).TextMatrix(lngRow, grdProcedureRemarks) = .Fields("Description") & ""
            .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
'     ShowError
End Function

Public Function SaveBalSheetRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, lngSubSectionID As Long, lngRemarkID As Long
Dim sSql As String, rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    AdoConn.BeginTrans
    sSql = "DELETE FROM FilingBalSheetRemarks WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM FilingBalSheetRemarks WHERE 1 = 2"
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgReporting(cnstgrdBalanceSheet).Rows - 1
            If vsfgReporting(cnstgrdBalanceSheet).TextMatrix(Inc, grdBalSheetRemarks) <> "" Then
                .AddNew
                lngRemarkID = GetRangeMaxNo("FilingBalSheetRemarks", "RemarkID", mCompanyID * cnstFilingBalSheetRemarksMaxCount, (mCompanyID * cnstFilingBalSheetRemarksMaxCount) + cnstFilingBalSheetRemarksMaxCount)
                .Fields("RemarkID") = lngRemarkID
                .Fields("PeriodID") = mSenderPeriodID
                .Fields("SubSectionID") = lngSubSectionID
                .Fields("AcTypeID") = vsfgReporting(cnstgrdBalanceSheet).TextMatrix(Inc, grdBalSheetAcTypeID)
                .Fields("Description") = vsfgReporting(cnstgrdBalanceSheet).TextMatrix(Inc, grdBalSheetRemarks)
                SaveDateAndUser rsTmp
                .Update
            End If
        Next Inc
    End With
    AdoConn.CommitTrans
    SaveBalSheetRemarks = True
Exit Function
Err_Exit:
    SaveBalSheetRemarks = False
    AdoConn.RollbackTrans
    ShowError
End Function

Public Function FillBalSheetRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgReporting(cnstgrdBalanceSheet).Rows > 0 Then
        If vsfgReporting(cnstgrdBalanceSheet).ValueMatrix(lngRow, grdBalSheetAcTypeID) <> 0 Then
            sSql = "SELECT * FROM FilingBalSheetRemarks WHERE SubSectionID = " & lngSubSectionID & " AND AcTypeID = " & vsfgReporting(cnstgrdBalanceSheet).ValueMatrix(lngRow, grdBalSheetAcTypeID) & " AND PeriodID = " & mSenderPeriodID
        End If
        With GetRecords(sSql)
            While Not .EOF
                vsfgReporting(cnstgrdBalanceSheet).TextMatrix(lngRow, grdBalSheetRemarks) = .Fields("Description") & ""
            .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
    ShowError
End Function

Public Function SaveIncomeRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, lngSubSectionID As Long, lngRemarkID As Long
Dim sSql As String, rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    AdoConn.BeginTrans
    sSql = "DELETE FROM FilingIncomeRemarks WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM FilingIncomeRemarks WHERE 1 = 2"
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgReporting(cnstgrdProfitLoss).Rows - 1
            If vsfgReporting(cnstgrdProfitLoss).TextMatrix(Inc, grdPLRemarks) <> "" Then
                .AddNew
                lngRemarkID = GetRangeMaxNo("FilingIncomeRemarks", "RemarkID", mCompanyID * cnstFilingIncomeRemarksMaxCount, (mCompanyID * cnstFilingIncomeRemarksMaxCount) + cnstFilingIncomeRemarksMaxCount)
                .Fields("RemarkID") = lngRemarkID
                .Fields("PeriodID") = mSenderPeriodID
                .Fields("SubSectionID") = lngSubSectionID
                .Fields("AcTypeID") = vsfgReporting(cnstgrdProfitLoss).TextMatrix(Inc, grdPLAcTypeID)
                .Fields("Description") = vsfgReporting(cnstgrdProfitLoss).TextMatrix(Inc, grdPLRemarks)
                SaveDateAndUser rsTmp
                .Update
            End If
        Next Inc
    End With
    AdoConn.CommitTrans
    SaveIncomeRemarks = True
Exit Function
Err_Exit:
    SaveIncomeRemarks = False
    AdoConn.RollbackTrans
    ShowError
End Function

Public Function FillIncomeRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgReporting(cnstgrdProfitLoss).Rows > 0 Then
        If vsfgReporting(cnstgrdProfitLoss).ValueMatrix(lngRow, grdPLAcTypeID) <> 0 Then
            sSql = "SELECT * FROM FilingIncomeRemarks WHERE SubSectionID = " & lngSubSectionID & " AND AcTypeID = " & vsfgReporting(cnstgrdProfitLoss).ValueMatrix(lngRow, grdPLAcTypeID) & " AND PeriodID = " & mSenderPeriodID
        End If
        With GetRecords(sSql)
            While Not .EOF
                vsfgReporting(cnstgrdProfitLoss).TextMatrix(lngRow, grdPLRemarks) = .Fields("Description") & ""
                .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
    ShowError
End Function

Public Function SaveLiquidityRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, lngSubSectionID As Long, lngRemarkID As Long
Dim sSql As String, rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    AdoConn.BeginTrans
    sSql = "DELETE FROM FilingLiquidityRemarks WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM FilingLiquidityRemarks WHERE 1 = 2"
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgReporting(cnstgrdLiquidity).Rows - 1
            If vsfgReporting(cnstgrdLiquidity).TextMatrix(Inc, grdLiquidityRemarks) <> "" Then
                .AddNew
                lngRemarkID = GetRangeMaxNo("FilingLiquidityRemarks", "RemarkID", mCompanyID * cnstFilingLiquidityRemarksMaxCount, (mCompanyID * cnstFilingLiquidityRemarksMaxCount) + cnstFilingLiquidityRemarksMaxCount)
                .Fields("RemarkID") = lngRemarkID
                .Fields("PeriodID") = mSenderPeriodID
                .Fields("SubSectionID") = lngSubSectionID
                .Fields("LiquidityID") = vsfgReporting(cnstgrdLiquidity).TextMatrix(Inc, grdLiquiditySlNo)
                .Fields("Description") = vsfgReporting(cnstgrdLiquidity).TextMatrix(Inc, grdLiquidityRemarks)
                SaveDateAndUser rsTmp
                .Update
            End If
        Next Inc
    End With
    AdoConn.CommitTrans
    SaveLiquidityRemarks = True
Exit Function
Err_Exit:
    SaveLiquidityRemarks = False
    AdoConn.RollbackTrans
    ShowError
End Function

Public Function FillLiquidityRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgReporting(cnstgrdLiquidity).Rows > 0 Then
        If vsfgReporting(cnstgrdLiquidity).ValueMatrix(lngRow, grdLiquiditySlNo) <> 0 Then
            sSql = "SELECT * FROM FilingLiquidityRemarks WHERE SubSectionID = " & lngSubSectionID & " AND LiquidityID = " & vsfgReporting(cnstgrdLiquidity).ValueMatrix(lngRow, grdLiquiditySlNo) & " AND PeriodID = " & mSenderPeriodID
        End If
        With GetRecords(sSql)
            While Not .EOF
                vsfgReporting(cnstgrdLiquidity).TextMatrix(lngRow, grdLiquidityRemarks) = .Fields("Description") & ""
            .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
    ShowError
End Function

Public Function SaveProfitabilityRemarks() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, lngSubSectionID As Long, lngRemarkID As Long
Dim sSql As String, rsTmp As New ADODB.Recordset
    lngSubSectionID = vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
    AdoConn.BeginTrans
    sSql = "DELETE FROM FilingProfitabilityRemarks WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM FilingProfitabilityRemarks WHERE 1 = 2"
    Set rsTmp = GetRecords(sSql)
    With rsTmp
        For Inc = 1 To vsfgReporting(cnstgrdProfitability).Rows - 1
            If vsfgReporting(cnstgrdProfitability).TextMatrix(Inc, grdProfitabilityRemarks) <> "" Then
                .AddNew
                lngRemarkID = GetRangeMaxNo("FilingProfitabilityRemarks", "RemarkID", mCompanyID * cnstFilingProfitabilityRemarksMaxCount, (mCompanyID * cnstFilingProfitabilityRemarksMaxCount) + cnstFilingProfitabilityRemarksMaxCount)
                .Fields("RemarkID") = lngRemarkID
                .Fields("PeriodID") = mSenderPeriodID
                .Fields("SubSectionID") = lngSubSectionID
                .Fields("ProfitabilityID") = vsfgReporting(cnstgrdProfitability).TextMatrix(Inc, grdProfitabilitySlNo)
                .Fields("Description") = vsfgReporting(cnstgrdProfitability).TextMatrix(Inc, grdProfitabilityRemarks)
                SaveDateAndUser rsTmp
                .Update
            End If
        Next Inc
    End With
    AdoConn.CommitTrans
    SaveProfitabilityRemarks = True
Exit Function
Err_Exit:
    SaveProfitabilityRemarks = False
    AdoConn.RollbackTrans
    ShowError
End Function

Public Function FillProfitabilityRemarks(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    If vsfgReporting(cnstgrdProfitability).Rows > 0 Then
        If vsfgReporting(cnstgrdProfitability).ValueMatrix(lngRow, grdProfitabilitySlNo) <> 0 Then
            sSql = "SELECT * FROM FilingProfitabilityRemarks WHERE SubSectionID = " & lngSubSectionID & " AND ProfitabilityID = " & vsfgReporting(cnstgrdProfitability).ValueMatrix(lngRow, grdProfitabilitySlNo) & " AND PeriodID = " & mSenderPeriodID
        End If
        With GetRecords(sSql)
            While Not .EOF
                vsfgReporting(cnstgrdProfitability).TextMatrix(lngRow, grdProfitabilityRemarks) = .Fields("Description") & ""
            .MoveNext
            Wend
        End With
    End If
Exit Function
Err_Exit:
    ShowError
End Function

Public Function SaveLeadSheetReviews(lngRow As Long, lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, rsSave As New ADODB.Recordset
Dim lngID As Long, lngCompanyID As Long
    lngCompanyID = mCompanyID
    AdoConn.BeginTrans
    sSql = "Delete From ReviewLeadSheet WHERE SubSectionID = " & lngSubSectionID & " AND PeriodID = " & mSenderPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * From ReviewLeadSheet WHERE 1=2"
    Set rsSave = GetRecords(sSql)
    With rsSave
        For Inc = 1 To vsfgAuditReport(cnstGridLeadSheet).Rows - 1
            If vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetReviewed) = -1 Then
                .AddNew
                lngID = GetRangeMaxNo("ReviewLeadSheet", "ReviewID", mCompanyID * cnstLeadSheetReviewsMaxCount, (mCompanyID * cnstLeadSheetReviewsMaxCount) + cnstLeadSheetReviewsMaxCount)
                .Fields("ReviewID") = lngID
                .Fields("SubSectionID") = lngSubSectionID
                .Fields("PeriodID") = mSenderPeriodID
                If vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcTypeId) <> 0 Then
                    .Fields("AcTypeID") = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcTypeId)
                    .Fields("AcID") = Null
                ElseIf vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcID) <> 0 Then
                    .Fields("AcTypeID") = Null
                    .Fields("AcID") = vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetAcID)
                Else
                    .Fields("AcTypeID") = Null
                    .Fields("AcID") = Null
                End If
                .Fields("Reviewed") = vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetReviewed)
                SaveDateAndUser rsSave
                .Update
            End If
        Next
    End With
    AdoConn.CommitTrans
Exit Function
Err_Exit:
    ShowError
    AdoConn.RollbackTrans
End Function

Public Function FillLeadSheetReviews()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    sSql = "SELECT *, ISNULL(AcTypeID, 0) AS AcTypeID, ISNULL(AcID, 0) AS AcID From ReviewLeadSheet " & _
           "WHERE  PeriodID = " & mSenderPeriodID & " AND SubSectionID = " & vsfgSubSections.ValueMatrix(1, vsfgSubSections.Col)
        With GetRecords(sSql)
            While Not .EOF
                For Inc = 1 To vsfgAuditReport(cnstGridLeadSheet).Rows - 1
                    If (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcTypeId) = Val(.Fields("AcTypeID") & "") And Val(.Fields("AcTypeID") & "") <> 0) Or _
                        (vsfgAuditReport(cnstGridLeadSheet).ValueMatrix(Inc, grdLeadSheetAcID) = Val(.Fields("AcID") & "") And Val(.Fields("AcID") & "") <> 0) Then
                        vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetReviewed) = IIf(.Fields("Reviewed") & "" = "True", -1, 0)
                        vsfgAuditReport(cnstGridLeadSheet).TextMatrix(Inc, grdLeadSheetReviewID) = .Fields("ReviewID") & ""
                    End If
                Next Inc
            .MoveNext
            Wend
        End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function FillResources(lngSubSectionID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset, Inc As Long
Dim strFileName As String, strExt As String, iCounterRow As Long
Dim lngPeriodID As Long
    lngPeriodID = 1005
    ClearResources
    sSql = "SELECT   DISTINCT DSL.DocLinkID, DB.DocumentID, DB.IsCheckOut, DB.Description, DB.FileExt, DB.FileName, CMP.CompanyName AS CompanyName, DSL.RefNo " & _
           "FROM     DocumentBin DB LEFT OUTER JOIN AuditMain.dbo.Companies CMP ON DB.CompanyID = CMP.CompanyID " & _
           "         INNER    JOIN AuditMain.dbo.DocumentSubLinks DSL ON DB.DocumentID = DSL.DocumentID " & _
           "WHERE    DSL.PeriodID = " & lngPeriodID & " AND DSL.SubSectionID = " & lngSubSectionID & " AND IsResource = 1"
    Set rsTmp = GetRecords(sSql, AdoConnDoc)
        With vsfgAuditReport(cnstGridResources)
            While Not rsTmp.EOF
                .Rows = .Rows + 1: Inc = Inc + 1
                .TextMatrix(Inc, grdResourcesSlNo) = Inc
                .TextMatrix(Inc, grdResourcesName) = rsTmp.Fields("Description") & ""
                .TextMatrix(Inc, grdResourcesFile) = rsTmp.Fields("FileName") & ""
                .TextMatrix(Inc, grdResourceDocID) = rsTmp.Fields("DocumentID") & ""
                If vsfgAuditReport(cnstGridResources).TextMatrix(Inc, grdResourcesFile) <> "" Then
                    strFileName = rsTmp.Fields("FileName")
                    strExt = GetExtension(strFileName)
                    SetPicture 6, Inc, grdResourcesFile, strExt
                End If
                rsTmp.MoveNext
            Wend
            For iCounterRow = vsfgAuditReport(cnstGridResources).TopRow To vsfgAuditReport(cnstGridResources).Rows - 1
                .Cell(flexcpFontUnderline, 1, grdResourcesFile, iCounterRow, grdResourcesFile) = True
                .Cell(flexcpForeColor, 1, grdResourcesFile, iCounterRow, grdResourcesFile) = &HFF0000
            Next iCounterRow
        End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub LoadAndOpenResourceFile(ByVal Row As Integer, ByVal Col As Integer, Optional IsCheckOut As Boolean = False)
On Local Error Resume Next
Dim sSql As String, strFileName As String, strTmpFileName As String
Dim strExt As String, strWorkDirectory As String, strCheckOutPath As String
Dim strFilePath As String
    Select Case Col
        Case grdResourcesFile
            strFileName = vsfgAuditReport(cnstGridResources).TextMatrix(Row, grdResourcesFile)
            strExt = GetExtension(strFileName, True)
            strWorkDirectory = GetApplicationData("WorkDirectory")
            If Right(Trim(strWorkDirectory), 1) <> "\" Then
                strWorkDirectory = strWorkDirectory & "\"
            End If
            If strFileName <> "" Then
                ClearTempFiles strWorkDirectory
            Else
                strFileName = App.Path
            End If
            strTmpFileName = GetTickCount
            sSql = "SELECT DocFile FROM DocumentBin  WHERE  DocumentID = " & vsfgAuditReport(cnstGridResources).ValueMatrix(Row, grdResourceDocID)
                strFilePath = strWorkDirectory & strTmpFileName & strExt
            'Extracting the file
            If ExtractDocument(GetRecords(sSql, AdoConnDoc), "DocFile", strFilePath) Then
                Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
            End If
         Case Else
            ShowDocument vsfgAuditReport(cnstGridResources).ValueMatrix(vsfgAuditReport(cnstGridResources).Row, grdResourceDocID)
    End Select
End Sub

Public Sub FillLegalDocDetails(lngSubSectionID As Long)
On Local Error Resume Next
Dim Inc As Long, sSql As String, rsTmp As New ADODB.Recordset
Dim strFileName As String, strExt As String, iCounterRow As Long
        sSql = "SELECT   DISTINCT DSL.DocLinkID, DB.DocumentID, DB.IsCheckOut, DSL.Description, DSL.Remarks, DSL.LegalDocID, DB.FileExt, DB.FileName, CMP.CompanyName AS CompanyName, DSL.RefNo " & _
               "FROM     DocumentBin DB LEFT OUTER JOIN AuditMain.dbo.Companies CMP ON DB.CompanyID = CMP.CompanyID " & _
               "         INNER    JOIN AuditMain.dbo.DocumentSubLinks DSL ON DB.DocumentID = DSL.DocumentID " & _
               "WHERE    DSL.PeriodID = " & mSenderPeriodID & " AND DSL.SubSectionID = " & lngSubSectionID & " ORDER BY DSL.LegalDocID"
    Set rsTmp = GetRecords(sSql, AdoConnDoc)
        With vsfgAuditReport(cnstGridLegalDocuments)
            While Not rsTmp.EOF
                .Rows = .Rows + 1: Inc = Inc + 1
                .TextMatrix(Inc, grdLegalDocSlNo) = Inc
                .TextMatrix(Inc, grdLegalDocDescription) = rsTmp.Fields("Description") & ""
                .TextMatrix(Inc, grdLegalDocRemarks) = rsTmp.Fields("Remarks") & ""
                .TextMatrix(Inc, grdLegalDocAttachments) = rsTmp.Fields("FileName") & ""
                .TextMatrix(Inc, grdLegalDocID) = rsTmp.Fields("DocumentID") & ""
                If vsfgAuditReport(cnstGridLegalDocuments).TextMatrix(Inc, grdLegalDocAttachments) <> "" Then
                    strFileName = rsTmp.Fields("FileName")
                    strExt = GetExtension(strFileName)
                    SetPicture 7, Inc, grdLegalDocAttachments, strExt
                End If
                rsTmp.MoveNext
            Wend
            For iCounterRow = vsfgAuditReport(cnstGridLegalDocuments).TopRow To vsfgAuditReport(cnstGridLegalDocuments).Rows - 1
                .Cell(flexcpFontUnderline, 1, grdLegalDocAttachments, iCounterRow, grdLegalDocAttachments) = True
                .Cell(flexcpForeColor, 1, grdLegalDocAttachments, iCounterRow, grdLegalDocAttachments) = &HFF0000
            Next iCounterRow
        End With
End Sub
