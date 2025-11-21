VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{54850C51-14EA-4470-A5E4-8C5DB32DC853}#1.0#0"; "vsprint8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{96548BD2-D0BF-46B1-B519-8F2268D49306}#1.0#0"; "vsvport8.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{05BD37E5-B82F-49E6-9A0A-97BE4815460C}#1.0#0"; "Thes8.ocx"
Object = "{CDF1175F-8D7D-431B-8B61-069CB3A80DD6}#1.0#0"; "Spell8.ocx"
Begin VB.Form frmReportDesigner 
   Caption         =   "Report Designer"
   ClientHeight    =   9030
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   13185
   ControlBox      =   0   'False
   Icon            =   "frmReportDesigner.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9030
   ScaleWidth      =   13185
   WindowState     =   2  'Maximized
   Begin VB.Frame fraOptions 
      Height          =   2040
      Left            =   3690
      TabIndex        =   32
      Top             =   3510
      Visible         =   0   'False
      Width           =   3675
      Begin VB.CheckBox chkTemplate 
         Caption         =   "Template"
         Height          =   195
         Left            =   120
         TabIndex        =   1
         Top             =   1290
         Width           =   960
      End
      Begin VB.TextBox txtReportName 
         Height          =   315
         Left            =   120
         TabIndex        =   0
         Top             =   540
         Width           =   3435
      End
      Begin VB.CommandButton cmdOptionsClose 
         Caption         =   "Close"
         Height          =   315
         Left            =   2700
         TabIndex        =   33
         Top             =   1620
         Width           =   855
      End
      Begin VB.ComboBox cmbUnits 
         Height          =   315
         ItemData        =   "frmReportDesigner.frx":000C
         Left            =   1470
         List            =   "frmReportDesigner.frx":001F
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1230
         Width           =   2085
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Report Name"
         Height          =   195
         Left            =   120
         TabIndex        =   78
         Top             =   315
         Width           =   945
      End
      Begin VB.Label Label15 
         Appearance      =   0  'Flat
         BackColor       =   &H80000002&
         Caption         =   " Options"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   240
         Left            =   15
         TabIndex        =   35
         Top             =   15
         Width           =   3660
      End
      Begin VB.Label Label14 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Measurement Units"
         Height          =   195
         Left            =   1470
         TabIndex        =   34
         Top             =   1020
         Width           =   1365
      End
   End
   Begin VB.Frame fraPageSetup 
      Height          =   3435
      Left            =   90
      TabIndex        =   21
      Top             =   1785
      Visible         =   0   'False
      Width           =   3585
      Begin VB.OptionButton optLandscape 
         Height          =   570
         Left            =   2745
         Picture         =   "frmReportDesigner.frx":0054
         Style           =   1  'Graphical
         TabIndex        =   37
         Top             =   930
         Width           =   690
      End
      Begin VB.OptionButton optPortrait 
         Height          =   570
         Left            =   690
         Picture         =   "frmReportDesigner.frx":035E
         Style           =   1  'Graphical
         TabIndex        =   36
         Top             =   930
         Value           =   -1  'True
         Width           =   690
      End
      Begin VB.CommandButton cmdPageSetupClose 
         Caption         =   "Close"
         Height          =   315
         Left            =   2580
         TabIndex        =   10
         Top             =   2970
         Width           =   855
      End
      Begin VB.Frame fraMargin 
         Caption         =   "Margin"
         Height          =   1380
         Left            =   75
         TabIndex        =   23
         Top             =   1500
         Width           =   3360
         Begin VB.TextBox txtMarginTop 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   510
            TabIndex        =   6
            Top             =   315
            Width           =   960
         End
         Begin VB.TextBox txtMarginBottom 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   2220
            TabIndex        =   7
            Top             =   315
            Width           =   960
         End
         Begin VB.TextBox txtMarginRight 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   2220
            TabIndex        =   9
            Top             =   915
            Width           =   960
         End
         Begin VB.TextBox txtMarginLeft 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   510
            TabIndex        =   8
            Top             =   915
            Width           =   960
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Bottom"
            Height          =   195
            Left            =   1650
            TabIndex        =   27
            Top             =   375
            Width           =   495
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Top"
            Height          =   195
            Left            =   165
            TabIndex        =   26
            Top             =   375
            Width           =   285
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Right"
            Height          =   195
            Left            =   1650
            TabIndex        =   25
            Top             =   975
            Width           =   375
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Left"
            Height          =   195
            Left            =   165
            TabIndex        =   24
            Top             =   975
            Width           =   270
         End
      End
      Begin VB.ComboBox cmbPaperSize 
         Height          =   315
         ItemData        =   "frmReportDesigner.frx":0668
         Left            =   75
         List            =   "frmReportDesigner.frx":066A
         TabIndex        =   5
         Top             =   525
         Width           =   3360
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Landscape"
         Height          =   195
         Left            =   1845
         TabIndex        =   39
         Top             =   1125
         Width           =   795
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Portrait"
         Height          =   195
         Left            =   75
         TabIndex        =   38
         Top             =   1125
         Width           =   495
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         BackColor       =   &H80000002&
         Caption         =   " Page Setup"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   240
         Left            =   0
         TabIndex        =   28
         Top             =   15
         Width           =   3570
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Paper Size"
         Height          =   195
         Left            =   75
         TabIndex        =   22
         Top             =   300
         Width           =   765
      End
   End
   Begin VB.PictureBox picTemplate 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      ForeColor       =   &H80000008&
      Height          =   2490
      Left            =   75
      ScaleHeight     =   2460
      ScaleWidth      =   5475
      TabIndex        =   65
      Top             =   6315
      Visible         =   0   'False
      Width           =   5505
      Begin VB.Frame fraTemplate 
         BorderStyle     =   0  'None
         Height          =   2130
         Left            =   15
         TabIndex        =   67
         Top             =   315
         Width           =   5445
         Begin RichTextLib.RichTextBox rtbTemplate 
            Height          =   1290
            Left            =   45
            TabIndex        =   69
            Top             =   390
            Width           =   5355
            _ExtentX        =   9446
            _ExtentY        =   2275
            _Version        =   393217
            Enabled         =   -1  'True
            ScrollBars      =   2
            TextRTF         =   $"frmReportDesigner.frx":066C
         End
         Begin VB.CommandButton cmdTemplateNew 
            Caption         =   "&New"
            Height          =   345
            Left            =   1185
            TabIndex        =   72
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateDelete 
            Caption         =   "&Delete"
            Height          =   345
            Left            =   2235
            TabIndex        =   73
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateCopy 
            Caption         =   "&Copy"
            Height          =   345
            Left            =   45
            TabIndex        =   70
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateSave 
            Caption         =   "&Save"
            Height          =   345
            Left            =   3315
            TabIndex        =   74
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateCancel 
            Caption         =   "Cance&l"
            Height          =   345
            Left            =   4395
            TabIndex        =   75
            Top             =   1740
            Width           =   1005
         End
         Begin VB.ComboBox cmbTemplate 
            Height          =   315
            Left            =   855
            TabIndex        =   68
            Top             =   45
            Width           =   4545
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Templates"
            Height          =   195
            Left            =   45
            TabIndex        =   71
            Top             =   105
            Width           =   735
         End
      End
      Begin VB.Label Label18 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Template"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   210
         Left            =   60
         TabIndex        =   66
         Top             =   45
         Width           =   780
      End
   End
   Begin VB.PictureBox picLineSpacing 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      ForeColor       =   &H80000008&
      Height          =   1665
      Left            =   3705
      ScaleHeight     =   1635
      ScaleWidth      =   2970
      TabIndex        =   79
      Top             =   1815
      Visible         =   0   'False
      Width           =   3000
      Begin VB.Frame fraLineSpacing 
         BorderStyle     =   0  'None
         Height          =   1305
         Left            =   15
         TabIndex        =   81
         Top             =   315
         Width           =   2940
         Begin VB.CommandButton cmdLineSpacingCancel 
            Caption         =   "Cance&l"
            Height          =   345
            Left            =   1845
            TabIndex        =   90
            Top             =   855
            Width           =   1005
         End
         Begin VB.CommandButton cmdLineSpacingOK 
            Caption         =   "&OK"
            Height          =   345
            Left            =   780
            TabIndex        =   89
            Top             =   855
            Width           =   1005
         End
         Begin RichTextLib.RichTextBox rtbLineSpacing 
            Height          =   480
            Left            =   4005
            TabIndex        =   88
            Top             =   2340
            Visible         =   0   'False
            Width           =   765
            _ExtentX        =   1349
            _ExtentY        =   847
            _Version        =   393217
            TextRTF         =   $"frmReportDesigner.frx":06EE
         End
         Begin VB.PictureBox picLineSpacing1 
            AutoRedraw      =   -1  'True
            Height          =   270
            Left            =   3570
            ScaleHeight     =   210
            ScaleWidth      =   465
            TabIndex        =   87
            Top             =   2295
            Visible         =   0   'False
            Width           =   525
         End
         Begin VB.TextBox txtLineSpacing 
            Height          =   315
            Left            =   1545
            TabIndex        =   85
            Top             =   330
            Width           =   810
         End
         Begin MSComCtl2.UpDown udLineSpacing 
            Height          =   315
            Left            =   2356
            TabIndex        =   84
            Top             =   330
            Width           =   240
            _ExtentX        =   423
            _ExtentY        =   556
            _Version        =   393216
            BuddyControl    =   "txtLineSpacing"
            BuddyDispid     =   196650
            OrigLeft        =   1861
            OrigTop         =   945
            OrigRight       =   2101
            OrigBottom      =   1350
            Max             =   1000
            SyncBuddy       =   -1  'True
            BuddyProperty   =   0
            Enabled         =   -1  'True
         End
         Begin VB.ComboBox cmbLineSpacing 
            Height          =   315
            ItemData        =   "frmReportDesigner.frx":0779
            Left            =   120
            List            =   "frmReportDesigner.frx":078F
            TabIndex        =   82
            Text            =   "Single"
            Top             =   330
            Width           =   1350
         End
         Begin VB.Label lblLineSpacingPt 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "pt"
            Height          =   195
            Left            =   2685
            TabIndex        =   91
            Top             =   390
            Width           =   135
         End
         Begin VB.Image imgLineSpacing 
            Height          =   165
            Left            =   3030
            Stretch         =   -1  'True
            Top             =   2340
            Width           =   330
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "At:"
            Height          =   195
            Left            =   1545
            TabIndex        =   86
            Top             =   105
            Width           =   195
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Line Spacing:"
            Height          =   195
            Left            =   120
            TabIndex        =   83
            Top             =   105
            Width           =   975
         End
      End
      Begin VB.Label Label20 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Line Spacing"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   210
         Left            =   60
         TabIndex        =   80
         Top             =   45
         Width           =   1050
      End
   End
   Begin VB.PictureBox picFind 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      ForeColor       =   &H80000008&
      Height          =   2490
      Left            =   5775
      ScaleHeight     =   2460
      ScaleWidth      =   5235
      TabIndex        =   52
      Top             =   6330
      Visible         =   0   'False
      Width           =   5265
      Begin VB.Frame fraReplaceWith 
         BorderStyle     =   0  'None
         Height          =   300
         Left            =   90
         TabIndex        =   64
         Top             =   1455
         Width           =   1110
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Replace wi&th"
            Height          =   195
            Left            =   60
            TabIndex        =   56
            Top             =   45
            Width           =   930
         End
      End
      Begin VB.Frame fraFindWhat 
         BorderStyle     =   0  'None
         Height          =   300
         Left            =   90
         TabIndex        =   63
         Top             =   870
         Width           =   1110
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Fi&nd what"
            Height          =   195
            Left            =   60
            TabIndex        =   54
            Top             =   45
            Width           =   690
         End
      End
      Begin VB.TextBox txtReplaceWith 
         Height          =   300
         Left            =   1230
         TabIndex        =   57
         Top             =   1455
         Width           =   3915
      End
      Begin VB.TextBox txtFindWhat 
         Height          =   300
         Left            =   1230
         TabIndex        =   55
         Top             =   870
         Width           =   3915
      End
      Begin VB.CommandButton cmdReplaceAll 
         Caption         =   "Replace &All"
         Height          =   345
         Left            =   1950
         TabIndex        =   59
         Top             =   2040
         Width           =   1005
      End
      Begin VB.CommandButton cmdReplace 
         Caption         =   "&Replace"
         Height          =   345
         Left            =   840
         TabIndex        =   58
         Top             =   2040
         Width           =   1005
      End
      Begin VB.CommandButton Cancel 
         Caption         =   "&Cancel"
         Height          =   345
         Left            =   4155
         TabIndex        =   61
         Top             =   2040
         Width           =   1005
      End
      Begin VB.CommandButton cmdFindNext 
         Caption         =   "&Find Next"
         Height          =   345
         Left            =   3045
         TabIndex        =   60
         Top             =   2040
         Width           =   1005
      End
      Begin MSComctlLib.TabStrip tbsFind 
         Height          =   2145
         Left            =   15
         TabIndex        =   53
         Top             =   315
         Width           =   5220
         _ExtentX        =   9208
         _ExtentY        =   3784
         _Version        =   393216
         BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
            NumTabs         =   2
            BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Fin&d"
               Key             =   "Find"
               Object.Tag             =   "Find"
               Object.ToolTipText     =   "Find"
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
               Caption         =   "Re&place"
               Key             =   "Replace"
               Object.Tag             =   "Replace"
               Object.ToolTipText     =   "Replace"
               ImageVarType    =   2
            EndProperty
         EndProperty
      End
      Begin VB.Label Label11 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Find and Replace"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   210
         Left            =   60
         TabIndex        =   62
         Top             =   45
         Width           =   1380
      End
   End
   Begin MSComctlLib.Toolbar tbrText 
      Height          =   330
      Left            =   3315
      TabIndex        =   47
      Top             =   195
      Width           =   9105
      _ExtentX        =   16060
      _ExtentY        =   582
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "imglstDesigner"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   20
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cut"
            Object.ToolTipText     =   "Cut"
            Object.Tag             =   "Cut"
            ImageKey        =   "Cut"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Copy"
            Object.ToolTipText     =   "Copy"
            Object.Tag             =   "Copy"
            ImageKey        =   "Copy"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Paste"
            Object.ToolTipText     =   "Paste"
            Object.Tag             =   "Paste"
            ImageKey        =   "Paste"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Left"
            Object.ToolTipText     =   "Left"
            Object.Tag             =   "Left"
            ImageKey        =   "Left"
            Style           =   2
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Center"
            Object.ToolTipText     =   "Center"
            Object.Tag             =   "Center"
            ImageKey        =   "Center"
            Style           =   2
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Right"
            Object.ToolTipText     =   "Right"
            Object.Tag             =   "Right"
            ImageKey        =   "Right"
            Style           =   2
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Justify"
            Object.ToolTipText     =   "Justify"
            Object.Tag             =   "Justify"
            ImageKey        =   "Justify"
            Style           =   2
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   2600
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Bold"
            Object.ToolTipText     =   "Bold"
            Object.Tag             =   "Bold"
            ImageKey        =   "Bold"
            Style           =   1
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Italic"
            Object.ToolTipText     =   "Italic"
            Object.Tag             =   "Italic"
            ImageKey        =   "Italic"
            Style           =   1
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Underline"
            Object.ToolTipText     =   "Underline"
            Object.Tag             =   "Underline"
            ImageKey        =   "Underline"
            Style           =   1
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Back Color"
            Object.ToolTipText     =   "Back Color"
            Object.Tag             =   "Back Color"
            ImageKey        =   "Back Color"
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Fore Color"
            Object.ToolTipText     =   "Fore Color"
            Object.Tag             =   "Fore Color"
            ImageKey        =   "Fore Color"
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Line Spacing"
            Object.ToolTipText     =   "Line Spacing"
            Object.Tag             =   "Line Spacing"
            ImageKey        =   "Line Spacing"
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   4
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "LS1.0"
                  Object.Tag             =   "1.0"
                  Text            =   "* 1.0"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "LS1.5"
                  Object.Tag             =   "1.5"
                  Text            =   "  1.5"
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "LS2.0"
                  Object.Tag             =   "2.0"
                  Text            =   "  2.0"
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Key             =   "More"
                  Object.Tag             =   "More"
                  Text            =   "More"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Spelling"
            Object.ToolTipText     =   "Spelling"
            Object.Tag             =   "Spelling"
            ImageKey        =   "Spelling"
         EndProperty
      EndProperty
      Begin VB.ComboBox cmbFontName 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   2625
         TabIndex        =   50
         Top             =   0
         Width           =   2100
      End
      Begin VB.ComboBox cmbFontSize 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "frmReportDesigner.frx":07CB
         Left            =   4725
         List            =   "frmReportDesigner.frx":07FF
         TabIndex        =   49
         Top             =   0
         Width           =   570
      End
      Begin VB.ComboBox cmbTextStyle 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "frmReportDesigner.frx":0841
         Left            =   8220
         List            =   "frmReportDesigner.frx":084B
         TabIndex        =   48
         Text            =   "Normal"
         Top             =   0
         Width           =   870
      End
   End
   Begin VB.Frame fraPage 
      Caption         =   "Page"
      Height          =   570
      Left            =   15
      TabIndex        =   15
      Top             =   525
      Width           =   4005
      Begin MSComctlLib.Toolbar tbrPage 
         Height          =   330
         Left            =   105
         TabIndex        =   3
         Top             =   195
         Width           =   3360
         _ExtentX        =   5927
         _ExtentY        =   582
         ButtonWidth     =   609
         ButtonHeight    =   582
         Style           =   1
         ImageList       =   "imglstDesigner"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   12
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "First"
               Object.ToolTipText     =   "First"
               Object.Tag             =   "First"
               ImageKey        =   "First"
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   3
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Previous"
               Object.ToolTipText     =   "Previous"
               Object.Tag             =   "Previous"
               ImageKey        =   "Previous"
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
               Object.Width           =   500
            EndProperty
            BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Next"
               Object.ToolTipText     =   "Next"
               Object.Tag             =   "Next"
               ImageKey        =   "Next"
            EndProperty
            BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Last"
               Object.ToolTipText     =   "Last"
               Object.Tag             =   "Last"
               ImageKey        =   "Last"
            EndProperty
            BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "New Page"
               Object.ToolTipText     =   "New Page"
               ImageKey        =   "New Page"
               Style           =   5
               BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
                  NumButtonMenus  =   2
                  BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Append"
                     Object.Tag             =   "Append"
                     Text            =   "Append after last page"
                  EndProperty
                  BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Insert"
                     Object.Tag             =   "Insert"
                     Text            =   "Insert before current page"
                  EndProperty
               EndProperty
            EndProperty
            BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Delete Page"
               Object.ToolTipText     =   "Delete Page"
               Object.Tag             =   "Delete Page"
               ImageKey        =   "Delete Page"
            EndProperty
         EndProperty
         Begin VB.TextBox txtPageNo 
            Alignment       =   1  'Right Justify
            Height          =   285
            Left            =   825
            TabIndex        =   4
            Text            =   "1"
            Top             =   15
            Width           =   570
         End
      End
      Begin VB.Label lblPageCount 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "of 12"
         Height          =   195
         Left            =   3480
         TabIndex        =   16
         Top             =   270
         Width           =   360
      End
   End
   Begin eAuditPro.ucShape ushpAnimation 
      Height          =   315
      Left            =   8130
      TabIndex        =   45
      Top             =   1320
      Visible         =   0   'False
      Width           =   480
      _ExtentX        =   847
      _ExtentY        =   556
   End
   Begin VB.Frame fraObjects 
      Caption         =   "Objects"
      Height          =   570
      Left            =   4020
      TabIndex        =   29
      Top             =   525
      Width           =   4920
      Begin MSComctlLib.Toolbar tbrObjects 
         Height          =   330
         Left            =   120
         TabIndex        =   30
         Top             =   180
         Width           =   4695
         _ExtentX        =   8281
         _ExtentY        =   582
         ButtonWidth     =   609
         ButtonHeight    =   582
         Style           =   1
         ImageList       =   "imglstDesigner"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   15
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Text"
               Object.ToolTipText     =   "Text"
               Object.Tag             =   "Text"
               ImageKey        =   "Text"
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Picture"
               Object.ToolTipText     =   "Picture"
               Object.Tag             =   "Picture"
               ImageKey        =   "Picture"
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Table"
               Object.ToolTipText     =   "Table"
               Object.Tag             =   "Table"
               ImageKey        =   "Table"
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Line"
               Object.ToolTipText     =   "Line"
               Object.Tag             =   "Line"
               ImageKey        =   "Line"
            EndProperty
            BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Rectangle"
               Object.ToolTipText     =   "Rectangle"
               Object.Tag             =   "Rectangle"
               ImageKey        =   "Rectangle"
            EndProperty
            BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Oval"
               Object.ToolTipText     =   "Oval"
               Object.Tag             =   "Oval"
               ImageKey        =   "Oval"
            EndProperty
            BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Properties"
               Object.ToolTipText     =   "Properties"
               Object.Tag             =   "Properties"
               ImageKey        =   "Properties"
            EndProperty
            BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Process Table"
               Object.ToolTipText     =   "Process Table"
               Object.Tag             =   "Process Table"
               ImageKey        =   "Process Table"
               Style           =   5
               BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
                  NumButtonMenus  =   2
                  BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Selected"
                     Object.Tag             =   "Selected"
                     Text            =   "Selected"
                  EndProperty
                  BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "All"
                     Object.Tag             =   "All"
                     Text            =   "All"
                  EndProperty
               EndProperty
            EndProperty
            BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Style           =   4
            EndProperty
            BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Delete Object"
               Object.ToolTipText     =   "Delete Object"
               Object.Tag             =   "Delete Object"
               ImageKey        =   "Delete Object"
            EndProperty
            BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Cut Object"
               Object.ToolTipText     =   "Cut Object"
               Object.Tag             =   "Cut Object"
               ImageKey        =   "Cut"
            EndProperty
            BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Copy Object"
               Object.ToolTipText     =   "Copy Object"
               Object.Tag             =   "Copy Object"
               ImageKey        =   "Copy"
            EndProperty
            BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Paste Object"
               Object.ToolTipText     =   "Paste Object"
               Object.Tag             =   "Paste Object"
               ImageKey        =   "Paste"
            EndProperty
         EndProperty
      End
   End
   Begin VB.PictureBox picProperties 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   5085
      Left            =   10065
      ScaleHeight     =   5055
      ScaleWidth      =   2325
      TabIndex        =   17
      Top             =   1110
      Width           =   2355
      Begin MSComctlLib.Toolbar tbrAdditional 
         Height          =   330
         Index           =   0
         Left            =   -795
         TabIndex        =   46
         Top             =   3210
         Width           =   3120
         _ExtentX        =   5503
         _ExtentY        =   582
         ButtonWidth     =   2408
         ButtonHeight    =   582
         Appearance      =   1
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "imglstDesigner"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Tags"
               Key             =   "Tags"
               Object.ToolTipText     =   "Tags"
               Object.Tag             =   "Tags"
               Style           =   5
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Change Case"
               Key             =   "Change Case"
               Object.ToolTipText     =   "Change Case"
               Object.Tag             =   "Change Case"
               Style           =   5
               BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
                  NumButtonMenus  =   3
                  BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Upper"
                     Object.Tag             =   "Upper"
                     Text            =   "UPPER"
                  EndProperty
                  BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Proper"
                     Object.Tag             =   "Proper"
                     Text            =   "Proper"
                  EndProperty
                  BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                     Key             =   "Lower"
                     Object.Tag             =   "Lower"
                     Text            =   "lower"
                  EndProperty
               EndProperty
            EndProperty
         EndProperty
      End
      Begin VB.ComboBox cmbProperties 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   0
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   240
         Width           =   2310
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgProperties 
         Height          =   2625
         Left            =   30
         TabIndex        =   19
         Top             =   555
         Width           =   2280
         _cx             =   4022
         _cy             =   4630
         Appearance      =   0
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
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
         BackColorBkg    =   -2147483643
         BackColorAlternate=   -2147483643
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483643
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
         Cols            =   3
         FixedRows       =   0
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmReportDesigner.frx":0860
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
      Begin MSComctlLib.Toolbar tbrAdditional 
         Height          =   330
         Index           =   1
         Left            =   15
         TabIndex        =   51
         Top             =   3540
         Width           =   2310
         _ExtentX        =   4075
         _ExtentY        =   582
         ButtonWidth     =   609
         ButtonHeight    =   582
         Appearance      =   1
         Style           =   1
         ImageList       =   "imglstDesigner"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   6
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Increase Indent"
               Object.ToolTipText     =   "Increase Indent"
               Object.Tag             =   "Increase Indent"
               ImageKey        =   "Increase Indent"
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Decrease Indent"
               Object.ToolTipText     =   "Decrease Indent"
               Object.Tag             =   "Decrease Indent"
               ImageKey        =   "Decrease Indent"
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "BringToFront"
               Object.ToolTipText     =   "Bring to front"
               Object.Tag             =   "Bring to front"
               ImageKey        =   "BringToFront"
            EndProperty
            BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "SendToBack"
               Object.ToolTipText     =   "Send to back"
               Object.Tag             =   "Send to back"
               ImageKey        =   "SendToBack"
            EndProperty
            BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "View Template"
               Object.ToolTipText     =   "View Template"
               Object.Tag             =   "View Template"
               ImageKey        =   "Template"
            EndProperty
            BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Modify Template"
               Object.ToolTipText     =   "Modify Template"
               Object.Tag             =   "Modify Template"
               ImageKey        =   "Design"
            EndProperty
         EndProperty
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         BackColor       =   &H80000002&
         Caption         =   " Properties"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000005&
         Height          =   240
         Left            =   0
         TabIndex        =   20
         Top             =   0
         Width           =   2310
      End
   End
   Begin MSComDlg.CommonDialog cdlgDesigner 
      Left            =   6135
      Top             =   1230
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VSPrinter8LibCtl.VSPrinter vspTmp 
      Height          =   390
      Left            =   3825
      TabIndex        =   11
      Top             =   1215
      Visible         =   0   'False
      Width           =   345
      _cx             =   609
      _cy             =   688
      Appearance      =   0
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
      ShowGuides      =   1
      LargeChangeHorz =   300
      LargeChangeVert =   300
      SmallChangeHorz =   0
      SmallChangeVert =   30
      Track           =   0   'False
      ProportionalBars=   -1  'True
      Zoom            =   100
      ZoomMode        =   0
      ZoomMax         =   100
      ZoomMin         =   100
      ZoomStep        =   0
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
      NavBar          =   0
      NavBarColor     =   -2147483633
      ExportFormat    =   0
      URL             =   ""
      Navigation      =   3
      NavBarMenuText  =   "Whole &Page|Page &Width|&Two Pages|Thumb&nail"
      AutoLinkNavigate=   -1  'True
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   9
   End
   Begin MSComctlLib.ImageList imglstDesigner 
      Left            =   5445
      Top             =   1200
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   48
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":08AF
            Key             =   "Left"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":0A89
            Key             =   "Right"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":0C63
            Key             =   "Bold"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":0E3D
            Key             =   "BringToFront"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":1017
            Key             =   "Center"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":11F1
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":13CB
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":15A5
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":177F
            Key             =   "Font"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":1959
            Key             =   "Grammar"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":1B33
            Key             =   "Table"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":1D0D
            Key             =   "Italic"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":1EE7
            Key             =   "Justify"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":20C1
            Key             =   "Line"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":229B
            Key             =   "Preview"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2475
            Key             =   "Oval"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":264F
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2829
            Key             =   "Picture"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2A03
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2BDD
            Key             =   "Rectangle"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2DB7
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":2F91
            Key             =   "Select"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":316B
            Key             =   "SendToBack"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":3345
            Key             =   "Spelling"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":351F
            Key             =   "Text"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":36F9
            Key             =   "Underline"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":38D3
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":3AAD
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":3C07
            Key             =   "First"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":3DE1
            Key             =   "Previous"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":3FBB
            Key             =   "Next"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":4195
            Key             =   "Last"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":436F
            Key             =   "New Page"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":4549
            Key             =   "Delete Page"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":4723
            Key             =   "New"
            Object.Tag             =   "New"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":48FD
            Key             =   "Options"
            Object.Tag             =   "Options"
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":70AF
            Key             =   "Page Setup"
            Object.Tag             =   "Page Setup"
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":7289
            Key             =   "Save As"
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":73E3
            Key             =   "Delete Object"
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":CBD5
            Key             =   "Process Table"
            Object.Tag             =   "Process Table"
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D027
            Key             =   "Fore Color"
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D181
            Key             =   "Back Color"
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D2DB
            Key             =   "Find"
            Object.Tag             =   "Find"
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D4B5
            Key             =   "Increase Indent"
            Object.Tag             =   "Increase Indent"
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D68F
            Key             =   "Decrease Indent"
            Object.Tag             =   "Decrease Indent"
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":D869
            Key             =   "Design"
            Object.Tag             =   "Design"
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":DA43
            Key             =   "Template"
            Object.Tag             =   "Template"
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportDesigner.frx":DC1D
            Key             =   "Line Spacing"
            Object.Tag             =   "Line Spacing"
         EndProperty
      EndProperty
   End
   Begin VSViewPort8LibCtl.VSViewPort vsvpDesigner 
      Height          =   5085
      Left            =   15
      TabIndex        =   12
      Top             =   1110
      Width           =   10080
      _cx             =   17780
      _cy             =   8969
      Appearance      =   0
      BorderStyle     =   1
      Enabled         =   -1  'True
      MousePointer    =   0
      BackColor       =   -2147483633
      AutoScroll      =   -1  'True
      VirtualWidth    =   1000
      VirtualHeight   =   1000
      LargeChangeHorz =   300
      LargeChangeVert =   300
      SmallChangeHorz =   30
      SmallChangeVert =   30
      Track           =   0   'False
      MouseScroll     =   0   'False
      ProportionalBars=   -1  'True
      FocusTrack      =   0   'False
      FocusMarginLeft =   0
      FocusMarginTop  =   0
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   9
      Begin VB.PictureBox picDesigner 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         DragIcon        =   "frmReportDesigner.frx":DDF7
         ForeColor       =   &H80000008&
         Height          =   7455
         Left            =   0
         ScaleHeight     =   7425
         ScaleWidth      =   9585
         TabIndex        =   13
         Top             =   0
         Width           =   9615
         Begin RichTextLib.RichTextBox rtbText 
            Height          =   585
            Index           =   0
            Left            =   75
            TabIndex        =   76
            Top             =   30
            Width           =   1125
            _ExtentX        =   1984
            _ExtentY        =   1032
            _Version        =   393217
            Enabled         =   -1  'True
            Appearance      =   0
            TextRTF         =   $"frmReportDesigner.frx":E101
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Times New Roman"
               Size            =   12.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin eAuditPro.ucLine ulnLine 
            Height          =   135
            Index           =   0
            Left            =   2820
            TabIndex        =   44
            Top             =   75
            Width           =   885
            _ExtentX        =   1561
            _ExtentY        =   238
            Y2              =   210
            Y1              =   75
            X2              =   3705
            X1              =   2820
         End
         Begin eAuditPro.ucShape ushpMargin 
            Height          =   450
            Left            =   4875
            TabIndex        =   43
            Top             =   60
            Width           =   420
            _ExtentX        =   741
            _ExtentY        =   794
         End
         Begin eAuditPro.ucShape ushpRectangle 
            Height          =   450
            Index           =   0
            Left            =   4230
            TabIndex        =   41
            Top             =   75
            Width           =   555
            _ExtentX        =   979
            _ExtentY        =   794
         End
         Begin eAuditPro.ucSelection uselSelection 
            DragIcon        =   "frmReportDesigner.frx":E186
            Height          =   510
            Left            =   2865
            TabIndex        =   40
            Top             =   75
            Width           =   765
            _ExtentX        =   1349
            _ExtentY        =   900
         End
         Begin VSFlex8Ctl.VSFlexGrid vsfgTable 
            Height          =   615
            Index           =   0
            Left            =   1305
            TabIndex        =   14
            Top             =   15
            Visible         =   0   'False
            Width           =   705
            _cx             =   1244
            _cy             =   1085
            Appearance      =   0
            BorderStyle     =   1
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Times New Roman"
               Size            =   12.75
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
            BackColorBkg    =   -2147483643
            BackColorAlternate=   -2147483643
            GridColor       =   -2147483633
            GridColorFixed  =   -2147483633
            TreeColor       =   -2147483632
            FloodColor      =   192
            SheetBorder     =   -2147483643
            FocusRect       =   2
            HighLight       =   2
            AllowSelection  =   -1  'True
            AllowBigSelection=   -1  'True
            AllowUserResizing=   3
            SelectionMode   =   0
            GridLines       =   1
            GridLinesFixed  =   1
            GridLineWidth   =   1
            Rows            =   5
            Cols            =   4
            FixedRows       =   0
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   0   'False
            FormatString    =   $"frmReportDesigner.frx":E490
            ScrollTrack     =   0   'False
            ScrollBars      =   0
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
            TabBehavior     =   0
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
         Begin eAuditPro.ucShape ushpOval 
            Height          =   450
            Index           =   0
            Left            =   2115
            TabIndex        =   42
            Top             =   60
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   794
            Shape           =   2
         End
         Begin VSTHES8LibCtl.VSThesaurus VSThesaurus1 
            Left            =   7020
            Top             =   165
            _ConvInfo       =   0
            BeginProperty DialogFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   178
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MainThesFile    =   ""
            AutomaticDialog =   1
            DialogTitle     =   ""
            OptionBtnCaption=   ""
            OptionBtnVisible=   0   'False
            HelpBtnVisible  =   0   'False
            DialogLeft      =   0
            DialogTop       =   0
         End
         Begin VSSPELL8LibCtl.VSSpell VSSpell1 
            Left            =   7500
            Top             =   150
            _ConvInfo       =   0
            BeginProperty DialogFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   178
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MainDictFile    =   ""
            Suggest         =   -1  'True
            CustomDictFile  =   ""
            CommonWordCache =   1
            BadWordDialog   =   1
            DialogTitle     =   ""
            OptionBtnCaption=   ""
            OptionBtnVisible=   0   'False
            DialogTop       =   0
            DialogLeft      =   0
            IgnoreWithNumbers=   0   'False
            IgnoreInUpperCase=   0   'False
            IgnoreInMixedCase=   0   'False
            AddBtnVisible   =   -1  'True
            DontCorrectText =   0   'False
            CheckSpelling   =   -1  'True
            CustomDictFile2 =   ""
            CustomDictFile3 =   ""
            CustomDictFile4 =   ""
            CustomDictFile5 =   ""
            HelpBtnVisible  =   0   'False
            WhichCustomDict =   1
            TypingErrorAction=   3
            UnderlineColor  =   4
            UnderlineStyle  =   255
         End
         Begin VB.Image imgPicture 
            Height          =   1635
            Index           =   0
            Left            =   6915
            Picture         =   "frmReportDesigner.frx":E50A
            Stretch         =   -1  'True
            Top             =   30
            Visible         =   0   'False
            Width           =   2565
         End
      End
   End
   Begin MSComctlLib.Toolbar tbrDesigner 
      Height          =   330
      Left            =   15
      TabIndex        =   31
      Top             =   195
      Width           =   12405
      _ExtentX        =   21881
      _ExtentY        =   582
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "imglstDesigner"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "New"
            Object.ToolTipText     =   "New"
            Object.Tag             =   "New"
            ImageKey        =   "New"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Open"
            Object.ToolTipText     =   "Open"
            Object.Tag             =   "Open"
            ImageKey        =   "Open"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save"
            Object.ToolTipText     =   "Save"
            Object.Tag             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save As"
            Object.ToolTipText     =   "Save As"
            Object.Tag             =   "Save As"
            ImageKey        =   "Save As"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Delete"
            Object.ToolTipText     =   "Delete"
            Object.Tag             =   "Delete"
            ImageKey        =   "Delete"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Page Setup"
            Object.ToolTipText     =   "Page Setup"
            Object.Tag             =   "Page Setup"
            ImageKey        =   "Page Setup"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Preview"
            Object.ToolTipText     =   "Preview"
            ImageKey        =   "Preview"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            Object.Tag             =   "Print"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Options"
            Object.ToolTipText     =   "Options"
            Object.Tag             =   "Options"
            ImageKey        =   "Options"
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
      EndProperty
   End
   Begin VB.Label lblHeading 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      Caption         =   " Report Designer"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   240
      Left            =   15
      TabIndex        =   77
      Top             =   -15
      Width           =   12405
   End
End
Attribute VB_Name = "frmReportDesigner"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mlngReportID As Long, mlngPeriodID As Long, mlngCompanyID As Long
Dim mstrCrntCtrlType As String, mlngCrntArrInc As Long
Dim mctrlSelected As Control, mlngMaxArrInc As Long
Dim mlngPageCount As Long, mlngPageNoTemp As Long
Dim mlngPicIndex As Long, mblnIsStartingUp As Boolean, mblnInFormLoad As Boolean, mblnInShowOpen As Boolean
Dim mstrComboListTableTypes As String, mstrComboListBorderTypes As String
Dim mstrUnit As String, mcgPageProperties As New clsGrid, mcgProperties() As New clsGrid
Dim mlngResizeCol As Long, mlngResizeRow As Long
Dim mctrlFind As Control, mlngFindPos As Long, mblnIsEditTemplate As Boolean
Dim mcrStack(1 To 7) As New clsReports, mbtStackCrntArrIndex As Long
Dim mcgTagValue As New clsGrid
'Dim mcrtbText As New clsRichTextBox

'Page property grid constants
Const grdPgPrpPaperSize = 0
Const grdPgPrpMarginTop = 1
Const grdPgPrpMarginBottom = 2
Const grdPgPrpMarginLeft = 3
Const grdPgPrpMarginRight = 4
Const grdPgPrpOrientation = 5 '0 for Portrait and 1 for Landscape
Const cnstPgPrpCount = 6

'Object property grid constants
Const grdPropRowX1 = 0
Const grdPropRowY1 = 1
Const grdPropRowX2 = 2
Const grdPropRowY2 = 3
Const grdPropRowLeft = 4
Const grdPropRowWidth = 5
Const grdPropRowTop = 6
Const grdPropRowHeight = 7
Const grdPropRowTblType = 8
Const grdPropRowAcType = 9
Const grdPropRowCols = 10
Const grdPropRowRows = 11
Const grdPropRowBorderType = 12
Const cnstPropRowCount = 13

Const grdPropColName = 0
Const grdPropColDisplay = 1
Const grdPropColValue = 2
Const cnstPropColCount = 3

Public Property Get PeriodID() As Long
   PeriodID = mlngPeriodID
End Property

Public Property Let PeriodID(ByVal lngNewValue As Long)
    mlngPeriodID = lngNewValue
    mlngCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & lngNewValue))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mlngCompanyID
End Property

Private Sub Cancel_Click()
    picFind.Visible = False
    Set mctrlFind = Nothing
    mlngFindPos = -1
End Sub

Private Sub chkTemplate_Click()
    txtReportName_Change
End Sub

Private Sub cmbFontName_Change()
    cmbFontName_Click
End Sub

Private Sub cmbFontName_Click()
    If cmbFontName.Text <> "" Then
        ChangeSelAttributes rptTblFontName
    End If
End Sub

Private Sub cmbFontSize_Change()
    cmbFontSize_Click
End Sub

Private Sub cmbFontSize_Click()
    If RVal(cmbFontSize.Text) <> 0 Then
        ChangeSelAttributes rptTblFontSize
    End If
End Sub

Private Sub ChangeSelAttributes(ByVal rtpSelChangeProperty As ReportTableProperties, Optional ByVal strKey As String = "", _
    Optional ByRef ButtonMenu As MSComctlLib.ButtonMenu = Nothing)
    On Local Error Resume Next
    Dim blnProtected As Boolean, lngSelStartOld As Long, lngSelLengthOld As Long, lngSelStartNew As Long
    Dim ctrlSelControl As Control, strSelControlType As String
    If mblnIsEditTemplate Then
        Set ctrlSelControl = rtbTemplate
        strSelControlType = "Text"
    Else
        Set ctrlSelControl = mctrlSelected
        strSelControlType = mstrCrntCtrlType
    End If
    If Not pblnIsInsideSelChangeEvent Then
        With ctrlSelControl
            Select Case strSelControlType
            Case "Text"
                blnProtected = IIf(IsNull(.SelProtected), False, .SelProtected)
                If blnProtected Then .SelProtected = False
                Select Case rtpSelChangeProperty
                Case rptTblFontSize
                    .SelFontSize = RVal(cmbFontSize.Text)
                Case rptTblFontName
                    .SelFontName = cmbFontName.Text
                Case rptTblIsBold
                    .SelBold = IIf(tbrText.Buttons("Bold").Value = tbrPressed, True, False)
                Case rptTblIsItalic
                    .SelItalic = IIf(tbrText.Buttons("Italic").Value = tbrPressed, True, False)
                Case rptTblUnderline
                    .SelUnderline = IIf(tbrText.Buttons("Underline").Value = tbrPressed, True, False)
                Case rptTblBackColor
                    SetSelBackColor .hWnd, cdlgDesigner.Color
                Case rptTblForeColor
                    .SelColor = cdlgDesigner.Color
                Case rptTblAlignment
                    If tbrText.Buttons("Left").Value Then
                        SetAlignment .hWnd, ercParaLeft
                    ElseIf tbrText.Buttons("Right").Value Then
                        SetAlignment .hWnd, ercParaRight
                    ElseIf tbrText.Buttons("Center").Value Then
                        SetAlignment .hWnd, ercParaCentre
                    ElseIf tbrText.Buttons("Justify").Value Then
                        SetAlignment .hWnd, ercParaJustify
                    End If
                Case rptTblText
                    Select Case strKey
                    Case "Cut"
                        Clipboard.SetText .SelRTF, vbCFRTF
                        .SelRTF = ""
                    Case "Copy"
                        Clipboard.SetText .SelRTF, vbCFRTF
                    Case "Paste"
                        .SelRTF = Clipboard.GetText(vbCFRTF)
                    Case "Spelling"
                        SpellCheck .hWnd 'Enabling the spell checking
                    Case "Increase Indent"
                        .SelIndent = .SelIndent + 100
                    Case "Decrease Indent"
                        .SelIndent = .SelIndent - 100
                    Case "Tags"
                        lngSelStartOld = .SelStart
                        lngSelLengthOld = .SelLength
                        .SelText = pcnstTagStart & ButtonMenu.Text & pcnstTagEnd
                        lngSelStartNew = .SelStart
                        .SelStart = lngSelStartOld
                        .SelLength = Abs(lngSelStartNew - lngSelStartOld)
                        '.SelProtected = True
                    Case "Change Case"
                        lngSelStartOld = .SelStart
                        lngSelLengthOld = .SelLength
                        Select Case ButtonMenu.Key
                        Case "Upper"
                            .SelText = StrConv(.SelText, vbUpperCase)
                        Case "Proper"
                            If Left(.SelText, 1) = pcnstTagStart Then
                                .SelText = pcnstTagStart & StrConv(Mid(.SelText, 2), vbProperCase)
                            Else
                                .SelText = StrConv(.SelText, vbProperCase)
                            End If
                        Case "Lower"
                            .SelText = StrConv(.SelText, vbLowerCase)
                        End Select
                        .SelStart = lngSelStartOld
                        .SelLength = lngSelLengthOld
                    End Select
                End Select
                If blnProtected Then .SelProtected = True
            Case "Table"
                Select Case rtpSelChangeProperty
                Case rptTblFontSize
                    .CellFontSize = RVal(cmbFontSize.Text)
                Case rptTblFontName
                    .CellFontName = cmbFontName.Text
                Case rptTblIsBold
                    .CellFontBold = IIf(tbrText.Buttons("Bold").Value = tbrPressed, True, False)
                Case rptTblIsItalic
                    .CellFontItalic = IIf(tbrText.Buttons("Italic").Value = tbrPressed, True, False)
                Case rptTblUnderline
                    .CellFontUnderline = IIf(tbrText.Buttons("Underline").Value = tbrPressed, True, False)
                Case rptTblBackColor
                    .Cell(flexcpBackColor, .Row, .Col, .RowSel, .ColSel) = cdlgDesigner.Color
                Case rptTblForeColor
                    .Cell(flexcpForeColor, .Row, .Col, .RowSel, .ColSel) = cdlgDesigner.Color
                Case rptTblAlignment
                    If tbrText.Buttons("Left").Value Then
                        .CellAlignment = flexAlignLeftTop
                    ElseIf tbrText.Buttons("Right").Value Then
                        .CellAlignment = flexAlignRightTop
                    ElseIf tbrText.Buttons("Center").Value Then
                        .CellAlignment = flexAlignCenterTop
                    ElseIf tbrText.Buttons("Justify").Value Then
                        .CellAlignment = flexAlignLeftTop
                    End If
                Case rptTblText
                    Select Case strKey
                    Case "Cut"
                        Clipboard.SetText .Text
                        .Text = ""
                    Case "Copy"
                        Clipboard.SetText .Text
                    Case "Paste"
                        .Text = Clipboard.GetText
                    Case "Spelling"
                        SpellCheck .EditWindow 'Enabling the spell checking
                    End Select
                End Select
            End Select
        End With
    End If
End Sub

Private Sub cmbLineSpacing_Change()
    Select Case cmbLineSpacing.Text
    Case "At least", "Exactly"
        lblLineSpacingPt.Visible = True
    Case Else
        lblLineSpacingPt.Visible = False
    End Select
End Sub

Private Sub cmbLineSpacing_Click()
    cmbLineSpacing_Change
End Sub

Private Sub cmbPaperSize_Change()
    cmbPaperSize_Click
End Sub

Private Sub cmbPaperSize_Click()
    On Local Error Resume Next
    Dim lngPaperSize As Long
    lngPaperSize = GetComboBoundValue(cmbPaperSize)
    vspTmp.PaperSize = lngPaperSize
    vsvpDesigner.VirtualWidth = vspTmp.PageWidth
    vsvpDesigner.VirtualHeight = vspTmp.PageHeight
    picDesigner.Width = vspTmp.PageWidth
    picDesigner.Height = vspTmp.PageHeight
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpPaperSize) = lngPaperSize
    SetMarginRectangle
End Sub

Private Sub cmbTemplate_Change()
    cmbTemplate_Click
End Sub

Private Sub cmbTemplate_Click()
    On Local Error Resume Next
    Dim sSql As String
    If cmbTemplate.ListIndex > -1 Then
        sSql = "SELECT TextRTF FROM ReportTemplates WHERE TemplateID = " & cmbTemplate.ItemData(cmbTemplate.ListIndex)
        With GetRecords(sSql)
            If Not .BOF Then
                rtbTemplate.TextRTF = !TextRTF
            End If
            .Close
        End With
    End If
End Sub

Private Sub cmbTextStyle_Click()
    On Local Error Resume Next
    SetTextStyle mctrlSelected, cmbTextStyle.Text
    GenerateTableOfContent
End Sub

Private Sub cmbUnits_Change()
    cmbUnits_Click
End Sub

Private Sub cmbUnits_Click()
    Dim arrInc As Long, RowInc As Long
    If mstrUnit <> "" Then
        txtMarginBottom.Text = ConvertToNewRealUnit(txtMarginBottom.Text)
        txtMarginLeft.Text = ConvertToNewRealUnit(txtMarginLeft.Text)
        txtMarginRight.Text = ConvertToNewRealUnit(txtMarginRight.Text)
        txtMarginTop.Text = ConvertToNewRealUnit(txtMarginTop.Text)
        With mcgPageProperties
            For RowInc = 1 To .Rows - 1
                .TextMatrix(RowInc, grdPgPrpMarginBottom) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPgPrpMarginBottom))
                .TextMatrix(RowInc, grdPgPrpMarginLeft) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPgPrpMarginLeft))
                .TextMatrix(RowInc, grdPgPrpMarginRight) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPgPrpMarginRight))
                .TextMatrix(RowInc, grdPgPrpMarginTop) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPgPrpMarginTop))
            Next RowInc
        End With
        For arrInc = 1 To mlngMaxArrInc
            With mcgProperties(arrInc)
                For RowInc = 0 To .Rows - 1
                    Select Case RowInc
                    Case grdPropRowHeight, grdPropRowLeft, grdPropRowTop, grdPropRowWidth, _
                        grdPropRowX1, grdPropRowX2, grdPropRowY1, grdPropRowY2
                        .TextMatrix(RowInc, grdPropColDisplay) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPropColDisplay))
                        .TextMatrix(RowInc, grdPropColValue) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPropColValue))
                    End Select
                Next RowInc
            End With
        Next arrInc
        With vsfgProperties
            For RowInc = 0 To .Rows - 1
                Select Case RowInc
                Case grdPropRowHeight, grdPropRowLeft, grdPropRowTop, grdPropRowWidth, _
                    grdPropRowX1, grdPropRowX2, grdPropRowY1, grdPropRowY2
                    .TextMatrix(RowInc, grdPropColDisplay) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPropColDisplay))
                    .TextMatrix(RowInc, grdPropColValue) = ConvertToNewRealUnit(.ValueMatrix(RowInc, grdPropColValue))
                End Select
            Next RowInc
        End With
    End If
    fraMargin.Caption = "Margin (" & cmbUnits.Text & ")"
    mstrUnit = cmbUnits.Text
End Sub

Private Function FindCntrlPositionCompare(ByRef ctrlControl As Control) As Long '0-Before, 1-Equal, 2-After, -1-Error
    On Local Error Resume Next
    Dim lngPos As Long
    lngPos = -1
    If mctrlFind Is Nothing Then
        lngPos = 0
    Else
        If Val(ctrlControl.Tag) < Val(mctrlFind.Tag) Then
            lngPos = 0
        ElseIf Val(ctrlControl.Tag) > Val(mctrlFind.Tag) Then
            lngPos = 2
        ElseIf Val(ctrlControl.Top) < Val(mctrlFind.Top) Then
            lngPos = 0
        ElseIf Val(ctrlControl.Top) > Val(mctrlFind.Top) Then
            lngPos = 2
        ElseIf ctrlControl.Name = mctrlFind.Name And ctrlControl.Index = mctrlFind.Index Then
            If ctrlControl.SelStart < mlngFindPos Then
                lngPos = 0
            ElseIf ctrlControl.SelStart > mlngFindPos Then
                lngPos = 2
            Else
                lngPos = 1
            End If
        Else
            lngPos = 0
        End If
    End If
    FindCntrlPositionCompare = lngPos
End Function

Private Sub cmdFindNext_Click()
    On Local Error Resume Next
    Dim lngPageNo As Long, PageInc As Long, CntrlInc As Control
    Dim lngPos As Long, blnIsSearched As Boolean, lngCheckPosition As Long
    If mctrlFind Is Nothing Then
        Set mctrlFind = mctrlSelected
        mlngFindPos = mctrlSelected.SelStart
    End If
    For PageInc = 1 To mlngPageCount + 1
        If PageInc > mlngPageCount Then 'current page should be searched twice
            lngPageNo = Val(txtPageNo.Text)
        Else
            lngPageNo = Val(txtPageNo.Text) + PageInc - 1
            If lngPageNo > mlngPageCount Then
                lngPageNo = lngPageNo - mlngPageCount
            End If
        End If
        lngPos = -1
        For Each CntrlInc In Controls
            If Val(CntrlInc.Tag) = lngPageNo And CntrlInc.Name = "rtbText" Then
                blnIsSearched = False
                lngPos = -1
                If Not mctrlSelected Is Nothing Then
                    If mctrlSelected.Name = CntrlInc.Name And mlngCrntArrInc = CntrlInc.Index Then
                        If PageInc <= mlngPageCount Then
                            lngPos = CntrlInc.Find(txtFindWhat.Text, CntrlInc.SelStart + CntrlInc.SelLength)
                        Else
                            lngPos = CntrlInc.Find(txtFindWhat.Text, 0, CntrlInc.SelStart)
                        End If
                        blnIsSearched = True
                    End If
                End If
                If Not blnIsSearched Then
                    lngPos = CntrlInc.Find(txtFindWhat.Text)
                    blnIsSearched = True
                End If
                If lngPos > -1 Then
                    lngCheckPosition = FindCntrlPositionCompare(mctrlSelected)
                    CntrlInc.SelStart = lngPos
                    CntrlInc.SelLength = Len(txtFindWhat.Text)
                    If lngCheckPosition <= 1 And FindCntrlPositionCompare(CntrlInc) >= 1 Then
                        pMVE.MsgBox "Searching Finished."
                        Set mctrlFind = Nothing
                        mlngFindPos = -1
                    Else
                        MakePageActive lngPageNo
                        SelectControl CntrlInc
                    End If
                    Exit For
                End If
            End If
        Next CntrlInc
        If lngPos > -1 And blnIsSearched Then 'searched
            Exit For
        End If
    Next PageInc
End Sub

Private Sub cmdLineSpacingCancel_Click()
    picLineSpacing.Visible = False
End Sub

Private Sub cmdLineSpacingOK_Click()
    Dim lsrLineSpacing As LineSpacingRules, lngCustomLineSpacing As Long
    Select Case cmbLineSpacing.Text
    Case "Single"
        'lsrLineSpacing = lnspSingle
        lsrLineSpacing = lnspCustom3
        lngCustomLineSpacing = 1 * 20
    Case "1.5 lines"
        'lsrLineSpacing = lnspOneAndAHalf
        lsrLineSpacing = lnspCustom3
        lngCustomLineSpacing = 1.5 * 20
    Case "Double"
        'lsrLineSpacing = lnspDouble
        lsrLineSpacing = lnspCustom3
        lngCustomLineSpacing = 2 * 20
    Case "At least"
        lsrLineSpacing = lnspCustom1
        lngCustomLineSpacing = Val(txtLineSpacing.Text) * 20
    Case "Exactly"
        lsrLineSpacing = lnspCustom2
        lngCustomLineSpacing = Val(txtLineSpacing.Text) * 20
    Case "Multiple"
        lsrLineSpacing = lnspCustom3
        lngCustomLineSpacing = Val(txtLineSpacing.Text) * 20
    End Select
    SetLineSpacing mctrlSelected.hWnd, lsrLineSpacing, lngCustomLineSpacing
    picLineSpacing.Visible = False
End Sub

Private Sub cmdPageSetupClose_Click()
    fraPageSetup.Visible = False
End Sub

Private Sub cmdOptionsClose_Click()
    fraOptions.Visible = False
End Sub

Private Function ConvertToNewRealUnit(varValue As Variant) As Double
    ConvertToNewRealUnit = ConvertToRealUnit(ConvertToBaseUnit(RVal(varValue), mstrUnit, False))
End Function

Private Function ConvertToRealUnit(ByVal dblValue As Double, Optional ByVal strUnit As String = "", Optional IsRoundOff As Boolean = True) As Double
    If strUnit = "" Then
        strUnit = cmbUnits.Text
    End If
    Select Case strUnit
    Case "Inches"
        ConvertToRealUnit = dblValue / 1440
    Case "Centimeters"
        ConvertToRealUnit = dblValue * 2.3 / 1440
    Case "Millimeters"
        ConvertToRealUnit = dblValue * 23 / 1440
    Case "Twips"
        ConvertToRealUnit = dblValue
    Case "Points"
        ConvertToRealUnit = dblValue * 62 / 1440
    Case Else 'twips
        ConvertToRealUnit = dblValue
    End Select
    If IsRoundOff Then
        ConvertToRealUnit = Round(ConvertToRealUnit, 2)
    End If
End Function

Private Function ConvertToBaseUnit(ByVal dblValue As Double, Optional ByVal strUnit As String = "", Optional IsRoundOff As Boolean = True) As Double
    If strUnit = "" Then
        strUnit = cmbUnits.Text
    End If
    Select Case strUnit
    Case "Inches"
        ConvertToBaseUnit = dblValue * 1440
    Case "Centimeters"
        ConvertToBaseUnit = dblValue * 1440 / 2.3
    Case "Millimeters"
        ConvertToBaseUnit = dblValue * 1440 / 23
    Case "Twips"
        ConvertToBaseUnit = dblValue
    Case "Points"
        ConvertToBaseUnit = dblValue * 1440 / 62
    Case Else 'twips
        ConvertToBaseUnit = dblValue
    End Select
    If IsRoundOff Then
        ConvertToBaseUnit = Round(ConvertToBaseUnit, 2)
    End If
End Function

Private Sub cmdReplace_Click()
    On Local Error Resume Next
    mctrlSelected.SelText = txtReplaceWith.Text
End Sub

Private Sub cmdTemplateCancel_Click()
    picTemplate.Visible = False
    mblnIsEditTemplate = False
End Sub

Private Sub cmdTemplateCopy_Click()
    Clipboard.SetText rtbTemplate.TextRTF, vbCFRTF
End Sub

Private Sub cmdTemplateDelete_Click()
    On Local Error Resume Next
    Dim sSql As String, lngTemplateID As Long
    lngTemplateID = GetComboBoundValue(cmbTemplate)
    sSql = "DELETE FROM ReportTemplates WHERE TemplateID = " & lngTemplateID
    AdoConn.Execute sSql
    cmdTemplateNew_Click
    PopulateTemplates cmbTemplate
End Sub

Private Sub cmdTemplateNew_Click()
    cmbTemplate.Text = ""
    rtbTemplate.Text = ""
End Sub

Private Sub cmdTemplateSave_Click()
    On Local Error Resume Next
    Dim sSql As String, lngTemplateID As Long
    sSql = "SELECT * FROM ReportTemplates WHERE TemplateName = " & FormatValue(cmbTemplate.Text)
    With GetRecords(sSql)
        If .BOF Then
            lngTemplateID = GetMaxNo("ReportTemplates", "TemplateID")
            .AddNew
            !TemplateID = lngTemplateID
        End If
        !TemplateName = cmbTemplate.Text
        !TextRTF = rtbTemplate.TextRTF
        .Update
        .Close
    End With
    PopulateTemplates cmbTemplate
End Sub

Private Sub Form_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
    Case 19 'Ctrl + S
        tbrDesigner_ButtonClick tbrDesigner.Buttons("Save")
    Case 16 'Ctrl + P
        tbrDesigner_ButtonClick tbrDesigner.Buttons("Print")
    End Select
End Sub

Private Sub Form_Load()
    On Local Error Resume Next
    Dim sSql As String, strUnit As String
    mblnInFormLoad = True
    rtbText(0).Text = ""
    rtbText(0).BorderStyle = rtfNoBorder
    vsfgTable(0).BorderStyle = flexBorderNone
    ClearValues True, False
    PopulatePaperSizes
    vspTmp.PaperSize = pprA4
    SetComboBoundValue cmbPaperSize, vspTmp.PaperSize
    strUnit = GetIniString("MeasurementUnit", "Inches", "Report Designer")
    If strUnit = "" Then
        strUnit = "Inches"
    End If
    cmbUnits.Text = strUnit
    mstrUnit = strUnit
    txtMarginLeft.Text = ConvertToRealUnit(vspTmp.MarginLeft)
    txtMarginRight.Text = ConvertToRealUnit(vspTmp.MarginRight)
    txtMarginTop.Text = ConvertToRealUnit(vspTmp.MarginTop)
    txtMarginBottom.Text = ConvertToRealUnit(vspTmp.MarginBottom)
    'initialize vsSpell control
    VSSpell1.IgnoreWithNumbers = True ' ignore words with numbers
    VSSpell1.IgnoreInUpperCase = True ' ignore words in uppercase
    VSSpell1.IgnoreInMixedCase = True ' ignore words in mixed case
    VSSpell1.Suggest = True           ' show suggestion words
    'set location of main dictionary file
    'VSSpell1.MainDictFile = MainDictFile
    PopulateFonts cmbFontName
    cmbFontName.Text = "Times New Roman"
    cmbFontSize.Text = "13"
    sSql = "SELECT TableTypeID AS IDField, TableTypeName AS NameField FROM TableTypes ORDER BY TableTypeID"
    mstrComboListTableTypes = SetComboList(, sSql)
    cmbTextStyle.Text = "Normal"
    mstrComboListBorderTypes = "#0;None|#1;Bottom|#2;Top|#3;Top Bottom|#4;Box|#5;Columns|#6;Col Top Bottom|#7;All|#8;Box Rows|#9;Box Columns|#10;Below Header|#11;Rows"
    PopulateReportTags mcgTagValue, mlngCompanyID, mlngPeriodID, tbrAdditional(0).Buttons("Tags")
    SetAlignment rtbTemplate.hWnd, ercParaJustify
    mblnInFormLoad = False
End Sub

Private Sub PopulatePaperSizes()
    With cmbPaperSize
        .AddItem "Letter, 8½ x 11 in."
        .ItemData(.NewIndex) = pprLetter
        .AddItem "Letter Small, 8½ x 11 in."
        .ItemData(.NewIndex) = pprLetterSmall
        .AddItem "Tabloid, 11 x 17 in."
        .ItemData(.NewIndex) = pprTabloid
        .AddItem "Ledger, 17 x 11 in."
        .ItemData(.NewIndex) = pprLedger
        .AddItem "Legal, 8 ½ x 14 in."
        .ItemData(.NewIndex) = pprLegal
        .AddItem "Statement, 5 1/2 x 8 1/2 in."
        .ItemData(.NewIndex) = pprStatement
        .AddItem "Executive, 7 1/2 x 10 1/2 in."
        .ItemData(.NewIndex) = pprExecutive
        .AddItem "A3, 297 x 420 mm"
        .ItemData(.NewIndex) = pprA3
        .AddItem "A4, 210 x 297 mm"
        .ItemData(.NewIndex) = pprA4
        .AddItem "A4 Small, 210 x 297 mm"
        .ItemData(.NewIndex) = pprA4Small
        .AddItem "A5, 148 x 210 mm"
        .ItemData(.NewIndex) = pprA5
        .AddItem "B4, 250 x 354 mm"
        .ItemData(.NewIndex) = pprB4
        .AddItem "B5, 182 x 257 mm"
        .ItemData(.NewIndex) = pprB5
        .AddItem "Folio, 8 ½ x 13 in."
        .ItemData(.NewIndex) = pprFolio
        .AddItem "Quarto, 215 x 275 mm"
        .ItemData(.NewIndex) = pprQuarto
        .AddItem "10 x 14 in."
        .ItemData(.NewIndex) = ppr10x14
        .AddItem "11 x 17 in."
        .ItemData(.NewIndex) = ppr11x17
        .AddItem "Note, 8 ½ x 11 in."
        .ItemData(.NewIndex) = pprNote
        .AddItem "Envelope #9, 3 7/8 x 8 7/8 in."
        .ItemData(.NewIndex) = pprEnv9
        .AddItem "Envelope #10, 4 1/8 x 9 ½ in."
        .ItemData(.NewIndex) = pprEnv10
        .AddItem "Envelope #11, 4 ½ x 10 3/8 in."
        .ItemData(.NewIndex) = pprEnv11
        .AddItem "Envelope #12, 4 ½ x 11 in."
        .ItemData(.NewIndex) = pprEnv12
        .AddItem "Envelope #14, 5 x 11 ½ in."
        .ItemData(.NewIndex) = pprEnv14
        .AddItem "C size sheet"
        .ItemData(.NewIndex) = pprCSheet
        .AddItem "D size sheet"
        .ItemData(.NewIndex) = pprDSheet
        .AddItem "E size sheet"
        .ItemData(.NewIndex) = pprESheet
        .AddItem "Envelope DL, 110 x 220 mm"
        .ItemData(.NewIndex) = pprEnvDL
        .AddItem "Envelope C5, 162 x 229 mm"
        .ItemData(.NewIndex) = pprEnvC5
        .AddItem "Envelope C3, 324 x 458 mm"
        .ItemData(.NewIndex) = pprEnvC3
        .AddItem "Envelope C4, 229 x 324 mm"
        .ItemData(.NewIndex) = pprEnvC4
        .AddItem "Envelope C6, 114 x 162 mm"
        .ItemData(.NewIndex) = pprEnvC6
        .AddItem "Envelope C65, 114 x 229 mm"
        .ItemData(.NewIndex) = pprEnvC65
        .AddItem "Envelope B4, 250 x 353 mm"
        .ItemData(.NewIndex) = pprEnvB4
        .AddItem "Envelope B5, 176 x 250 mm"
        .ItemData(.NewIndex) = pprEnvB5
        .AddItem "Envelope B6, 176 x 125 mm"
        .ItemData(.NewIndex) = pprEnvB6
        .AddItem "Envelope, 110 x 230 mm"
        .ItemData(.NewIndex) = pprEnvItaly
        .AddItem "Envelope Monarch, 3 7/8 x 7 ½ in."
        .ItemData(.NewIndex) = pprEnvMonarch
        .AddItem "Envelope, 3 5/8 x 6 ½ in."
        .ItemData(.NewIndex) = pprEnvPersonal
        .AddItem "U.S. Standard Fanfold, 14 7/8 x 11 in."
        .ItemData(.NewIndex) = pprFanfoldUS
        .AddItem "German Standard Fanfold, 8 ½ x 12 in."
        .ItemData(.NewIndex) = pprFanfoldStdGerman
        .AddItem "German Legal Fanfold, 8 1/2 x 13 in."
        .ItemData(.NewIndex) = pprFanfoldLglGerman
        .AddItem "Custom-size"
        .ItemData(.NewIndex) = pprUser
    End With
End Sub

Private Sub Form_Resize()
    On Local Error Resume Next
    vsvpDesigner.Height = Height - (vsvpDesigner.Top + 400)
    picProperties.Height = Height - (vsvpDesigner.Top + 400)
End Sub

Private Sub Form_Unload(Cancel As Integer)
'    Set mcrtbText = Nothing
    mcgTagValue.Clear
    Set mcgTagValue = Nothing
End Sub

Private Sub imgPicture_Click(Index As Integer)
    mlngCrntArrInc = Index
    mstrCrntCtrlType = "Picture"
    ShowSelection
End Sub

Private Sub imgPicture_DblClick(Index As Integer)
    On Local Error Resume Next
    cdlgDesigner.ShowOpen
    If cdlgDesigner.FileName <> "" Then
        imgPicture(Index).Picture = LoadPicture(cdlgDesigner.FileName)
    End If
End Sub

Private Sub imgPicture_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub imgPicture_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    picDesigner.MousePointer = vbDefault
End Sub

Private Sub optLandscape_Click()
    optPortrait_Click
End Sub

Private Sub optPortrait_Click()
    Dim lngOrientation As Long
    lngOrientation = IIf(optPortrait.Value, orPortrait, orLandscape)
    vspTmp.Orientation = lngOrientation
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpOrientation) = lngOrientation
    vsvpDesigner.VirtualWidth = vspTmp.PageWidth
    vsvpDesigner.VirtualHeight = vspTmp.PageHeight
    picDesigner.Width = vspTmp.PageWidth
    picDesigner.Height = vspTmp.PageHeight
    SetMarginRectangle
End Sub

Private Sub SetControlPositionAfterDrop(Source As Control)
    On Local Error Resume Next
    Dim lpPoint As PointAPI, rctRect As RECT
    GetCursorPos lpPoint
    GetWindowRect Source.hWnd, rctRect
    lpPoint.X = lpPoint.X * Screen.TwipsPerPixelX
    lpPoint.Y = lpPoint.Y * Screen.TwipsPerPixelY
    rctRect.Left = rctRect.Left * Screen.TwipsPerPixelX
    rctRect.Right = rctRect.Right * Screen.TwipsPerPixelX
    rctRect.Top = rctRect.Top * Screen.TwipsPerPixelY
    rctRect.Bottom = rctRect.Bottom * Screen.TwipsPerPixelY
    Source.Left = Source.Left + (lpPoint.X - rctRect.Left)
    Source.Top = Source.Top + (lpPoint.Y - rctRect.Top)
End Sub

Private Sub picDesigner_DragDrop(Source As Control, X As Single, Y As Single)
    On Local Error Resume Next
    If Source.Name = "picFind" Then
        SetControlPositionAfterDrop Source
    Else
        uselSelection.SelectionResize
        ShowSelection
        picDesigner.MousePointer = vbDefault
    End If
End Sub

Private Sub picDesigner_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    FindControlFromMouseSelection X, Y
End Sub

Private Sub picDesigner_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Local Error Resume Next
    Dim lngX As Long, lngY As Long
    If Button = vbLeftButton And Screen.MousePointer <> vbDefault Then
        lngX = X
        lngY = Y
        If mstrCrntCtrlType = "Line" Then
            mctrlSelected.X2 = lngX
            mctrlSelected.Y2 = lngY
        Else
            If lngX < mctrlSelected.Left Then
                mctrlSelected.Width = mctrlSelected.Left - lngX
                mctrlSelected.Left = lngX
            Else
                mctrlSelected.Width = lngX - mctrlSelected.Left
            End If
            If lngY < mctrlSelected.Top Then
                mctrlSelected.Height = mctrlSelected.Top - lngY
                mctrlSelected.Top = lngY
            Else
                mctrlSelected.Height = lngY - mctrlSelected.Top
            End If
        End If
        mctrlSelected.Visible = True
        ShowSelection
    End If
    picDesigner.MousePointer = vbDefault
End Sub

Private Sub picFind_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub picProperties_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub rtbTemplate_GotFocus()
    mblnIsEditTemplate = True
End Sub

Private Sub rtbTemplate_SelChange()
    ChangeSelection rtbTemplate, Me
End Sub

Private Sub rtbText_Change(Index As Integer)
    txtFindWhat_Change
    ReportChanged
End Sub

Private Sub rtbText_Click(Index As Integer)
    uselSelection.Editing = True
    tbrText.Visible = True
    If mlngCrntArrInc <> Index Or mstrCrntCtrlType <> "Text" Then
        mlngCrntArrInc = Index
        mstrCrntCtrlType = "Text"
        ShowSelection
        rtbText(Index).SetFocus
    End If
End Sub

Private Sub SelectMaxIndexControl()
    On Local Error Resume Next
    Dim ctrlInc As Control, lngCrntArrInc As Long, strCrntCtrlType
    lngCrntArrInc = 0
    For Each ctrlInc In Controls
        Select Case ctrlInc.Name
        Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
            If ctrlInc.Visible And ctrlInc.Index > lngCrntArrInc Then
                lngCrntArrInc = ctrlInc.Index
                Select Case ctrlInc.Name
                Case "rtbText"
                    strCrntCtrlType = "Text"
                Case "imgPicture"
                    strCrntCtrlType = "Picture"
                Case "vsfgTable"
                    strCrntCtrlType = "Table"
                Case "ulnLine"
                    strCrntCtrlType = "Line"
                Case "ushpRectangle"
                    strCrntCtrlType = "Rectangle"
                Case "ushpOval"
                    strCrntCtrlType = "Oval"
                End Select
            End If
        End Select
    Next ctrlInc
    If lngCrntArrInc > 0 Then
        mlngCrntArrInc = lngCrntArrInc
        mstrCrntCtrlType = strCrntCtrlType
    Else
        mlngCrntArrInc = 0
        mstrCrntCtrlType = ""
    End If
    ShowSelection
End Sub
    
Private Sub rtbText_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub rtbText_GotFocus(Index As Integer)
    mblnIsEditTemplate = False
End Sub

Private Sub rtbText_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If Shift = vbShiftMask And KeyCode = vbKeyF7 Then
        VSThesaurus1.CheckWord = rtbText(Index).SelText
    End If
End Sub

Private Sub rtbText_KeyPress(Index As Integer, KeyAscii As Integer)
    Dim strKey As String
    Select Case KeyAscii
    Case 2 'Ctrl + B
        strKey = "Bold"
    Case 9 'Ctrl + I
        strKey = "Italic"
    Case 21 'Ctrl + U
        strKey = "Underline"
    Case 12 'Ctrl + L
        strKey = "Left"
    Case 18 'Ctrl + R
        strKey = "Right"
    Case 3 'Ctrl + C
        If rtbText(Index).SelLength <= 0 Then
            strKey = "Center"
        End If
    Case 10 'Ctrl + J
        strKey = "Justify"
    Case 8 'Backspace
    Case Else
        With rtbText(Index)
            If .SelLength = 0 And .SelProtected And Mid(.Text, .SelStart + 1, 1) = pcnstTagStart Then
                'for permiting entries before the protected area
                .SelText = Chr(KeyAscii)
                .SelProtected = False
            End If
        End With
    End Select
    If strKey <> "" Then
        With tbrText.Buttons(strKey)
            Select Case .Style
            Case tbrCheck
                If .Value = tbrPressed Then
                    .Value = tbrUnpressed
                Else
                    .Value = tbrPressed
                End If
            Case tbrButtonGroup
                .Value = tbrPressed
            End Select
        End With
        tbrText_ButtonClick tbrText.Buttons(strKey)
    End If
End Sub

Private Sub rtbText_LostFocus(Index As Integer)
    On Local Error Resume Next
    If mctrlSelected.Name = "rtbText" And mctrlSelected.Index = Index Then
        rtbText(Index).HideSelection = False
    Else
        rtbText(Index).HideSelection = True
    End If
End Sub

Private Sub rtbText_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    picDesigner.MousePointer = vbDefault
End Sub

Private Sub rtbText_SelChange(Index As Integer)
    ChangeSelection rtbText(Index), Me
End Sub

Private Sub SetPageProperties(ByVal strCommand As String, Optional ByVal lngPageNo As Long = 0)
    On Local Error Resume Next
    Dim IncPage As Long, ctrlInc As Control, lngActivePageNo As Long, ColInc As Long
    Select Case strCommand
    Case "Clear"
        mlngPageCount = 1
        mcgPageProperties.Rows = mlngPageCount + 1
        lngActivePageNo = mlngPageCount
    Case "Delete"
        For IncPage = lngPageNo To mlngPageCount - 1
            For ColInc = 0 To mcgPageProperties.Cols - 1
                mcgPageProperties.TextMatrix(IncPage, ColInc) = mcgPageProperties.TextMatrix(IncPage + 1, ColInc)
            Next ColInc
        Next IncPage
        If mlngPageCount > 1 Then
            For Each ctrlInc In Controls
                Select Case ctrlInc.Name
                Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
                    Select Case Val(ctrlInc.Tag)
                    Case lngPageNo
                        Unload ctrlInc
                    Case Is > lngPageNo
                        ctrlInc.Tag = Val(ctrlInc.Tag) - 1
                    End Select
                End Select
            Next ctrlInc
            mlngPageCount = mlngPageCount - 1
            If mlngPageCount + 1 = lngPageNo Then
                txtPageNo.Text = mlngPageCount
                lngPageNo = mlngPageCount
            End If
        End If
        mcgPageProperties.Rows = mlngPageCount + 1
        lngActivePageNo = lngPageNo
    Case "Insert"
        mlngPageCount = mlngPageCount + 1
        mcgPageProperties.Rows = mlngPageCount + 1
        For IncPage = mlngPageCount To lngPageNo Step -1
            For ColInc = 0 To mcgPageProperties.Cols - 1
                If IncPage = lngPageNo Then
                    mcgPageProperties.TextMatrix(IncPage, ColInc) = ""
                Else
                    mcgPageProperties.TextMatrix(IncPage, ColInc) = mcgPageProperties.TextMatrix(IncPage - 1, ColInc)
                End If
            Next ColInc
        Next IncPage
        For Each ctrlInc In Controls
            Select Case ctrlInc.Name
            Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
                If Val(ctrlInc.Tag) >= lngPageNo Then
                    ctrlInc.Tag = Val(ctrlInc.Tag) + 1
                End If
            End Select
        Next ctrlInc
        lngActivePageNo = lngPageNo
    Case "Append"
        mlngPageCount = mlngPageCount + 1
        mcgPageProperties.Rows = mlngPageCount + 1
        lngActivePageNo = mlngPageCount
    End Select
    With mcgPageProperties
        .Cols = cnstPgPrpCount
        .Rows = mlngPageCount + 1
        For IncPage = 1 To mlngPageCount
            If .ValueMatrix(IncPage, grdPgPrpPaperSize) <= 0 Then
                If IncPage = 1 Then
                    .TextMatrix(IncPage, grdPgPrpPaperSize) = GetComboBoundValue(cmbPaperSize)
                    .TextMatrix(IncPage, grdPgPrpMarginBottom) = txtMarginBottom.Text
                    .TextMatrix(IncPage, grdPgPrpMarginLeft) = txtMarginLeft.Text
                    .TextMatrix(IncPage, grdPgPrpMarginRight) = txtMarginRight.Text
                    .TextMatrix(IncPage, grdPgPrpMarginTop) = txtMarginTop.Text
                    .TextMatrix(IncPage, grdPgPrpOrientation) = IIf(optPortrait.Value, 0, 1)
                Else
                    For ColInc = 0 To .Cols - 1
                        .TextMatrix(IncPage, ColInc) = .TextMatrix(IncPage - 1, ColInc)
                    Next ColInc
                End If
            End If
        Next IncPage
    End With
    MakePageActive lngActivePageNo
    lblPageCount.Caption = "of " & mlngPageCount
    GenerateTableOfContent
End Sub

Private Sub ClearValues(ByVal blnIsStartUp As Boolean, ByVal blnIsFromValueCollect As Boolean)
    Dim blnIsContinue As Boolean
    If blnIsFromValueCollect Or blnIsStartUp Then
        blnIsContinue = True
    Else
        blnIsContinue = pMVE.MsgBox("Are you sure to create a new report? You may lose your unsaved data.", msgYesNo)
    End If
    If blnIsContinue Then
        If Not blnIsFromValueCollect Then
            mlngReportID = 0
            txtReportName.Text = ""
            txtReportName.Tag = ""
        End If
        UnloadAllComponents
        PopulateProperties
        SetPageProperties "Clear"
        txtPageNo.Text = "1"
        mlngCrntArrInc = 0
        mlngMaxArrInc = 0
        mstrCrntCtrlType = ""
        Set mctrlSelected = Nothing
        ShowSelection
    End If
End Sub

Private Sub DeleteReport()
    On Local Error GoTo Err_Exit
    Dim sSql As String
    If pMVE.MsgBox("Are you sure to delete the report '" & txtReportName.Text & "'?", msgYesNo) Then
        AdoConn.BeginTrans
        sSql = "DELETE FROM ReportsObjectsSub WHERE ReportID = " & mlngReportID
        AdoConn.Execute sSql
        sSql = "DELETE FROM ReportsObjects WHERE ReportID = " & mlngReportID
        AdoConn.Execute sSql
        sSql = "DELETE FROM Reports WHERE ReportID = " & mlngReportID
        AdoConn.Execute sSql
        AdoConn.CommitTrans
        ClearValues True, False
    End If
Exit Sub
Err_Exit:
    ShowError
    AdoConn.RollbackTrans
End Sub

Private Sub tbrAdditional_ButtonClick(Index As Integer, ByVal Button As MSComctlLib.Button)
    On Local Error Resume Next
    Select Case Button.Key
    Case "Find"
        txtFindWhat.Text = mctrlSelected.SelText
        tbsFind_Click
        picFind.Visible = True
        picFind.Left = vsvpDesigner.Left + (vsvpDesigner.Width / 2) - 1000
        picFind.Top = vsvpDesigner.Top + (vsvpDesigner.Height / 2) - 1000
        txtFindWhat.SetFocus
        Set mctrlFind = Nothing
        mlngFindPos = -1
    Case "Increase Indent", "Decrease Indent"
        ChangeSelAttributes rptTblText, Button.Key
    Case "BringToFront"
        mctrlSelected.ZOrder vbBringToFront
        uselSelection.ZOrder vbBringToFront
    Case "SendToBack"
        mctrlSelected.ZOrder vbSendToBack
    Case "View Template", "Modify Template"
        PopulateTemplates cmbTemplate
        If Button.Key = "Modify Template" Then
            cmdTemplateSave.Visible = True
            cmdTemplateDelete.Visible = True
            cmdTemplateNew.Visible = True
            rtbTemplate.Locked = False
        Else
            cmdTemplateSave.Visible = False
            cmdTemplateDelete.Visible = False
            cmdTemplateNew.Visible = False
            rtbTemplate.Locked = True
        End If
        picTemplate.Left = vsvpDesigner.Left
        picTemplate.Width = vsvpDesigner.Width - 260
        fraTemplate.Width = picTemplate.Width - 60
        rtbTemplate.Width = fraTemplate.Width - 110
        picTemplate.Height = 3500
        fraTemplate.Height = picTemplate.Height - 360
        rtbTemplate.Height = fraTemplate.Height - (500 + cmdTemplateCopy.Height)
        cmdTemplateCancel.Left = rtbTemplate.Left + rtbTemplate.Width - cmdTemplateCancel.Width
        cmdTemplateSave.Left = cmdTemplateCancel.Left - (cmdTemplateSave.Width + 100)
        cmdTemplateDelete.Left = cmdTemplateSave.Left - (cmdTemplateDelete.Width + 100)
        cmdTemplateNew.Left = cmdTemplateDelete.Left - (cmdTemplateNew.Width + 100)
        cmdTemplateCopy.Top = rtbTemplate.Top + rtbTemplate.Height + cmdTemplateCopy.Height - 300
        cmdTemplateSave.Top = cmdTemplateCopy.Top
        cmdTemplateDelete.Top = cmdTemplateCopy.Top
        cmdTemplateNew.Top = cmdTemplateCopy.Top
        cmdTemplateCancel.Top = cmdTemplateCopy.Top
        picTemplate.Top = vsvpDesigner.Height + vsvpDesigner.Top - (picTemplate.Height + 270)
        picTemplate.Visible = True
    End Select
End Sub

Private Sub tbrDesigner_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim strNewReportName As String
    On Local Error Resume Next
    Select Case Button.Key
    Case "Page Setup"
        ShowSubWindow fraPageSetup, tbrDesigner, Button.Key
        'fraPageSetup.ZOrder vbBringToFront
        'fraPageSetup.Visible = True
    Case "Options"
        ShowSubWindow fraOptions, tbrDesigner, Button.Key
        'fraOptions.ZOrder vbBringToFront
        'fraOptions.Visible = True
    Case "Preview"
        Preview
    Case "Save"
        Save mlngReportID, txtReportName.Text
    Case "Save As"
        strNewReportName = InputBox("Please enter a report name.", "Report Name")
        Save 0, strNewReportName
        If strNewReportName <> "" Then
            ShowOpen mlngReportID
        End If
    Case "Open"
        ShowOpen
    Case "New"
        ClearValues False, False
    Case "Delete"
        DeleteReport
    Case "Print"
        tbrDesigner_ButtonClick tbrDesigner.Buttons("Save")
        Screen.MousePointer = vbHourglass
        LoadReports mlngReportID, frmPreview.vpPreview
        frmPreview.Show
        frmPreview.ZOrder vbBringToFront
        Screen.MousePointer = vbDefault
    End Select
End Sub

Private Sub Preview(Optional IsExport As Boolean = True)
    On Local Error GoTo Err_Exit
    Dim ctrlInc As Control, PageInc As Long, RowInc As Long, ColInc As Long
    Dim dblTmpHeight As Double, dblTmpWidth As Double, cllTagValue As New Collection
    Dim bmInc As MSComctlLib.ButtonMenu, strTextRTF As String, sSql As String
    Dim dblMarginLeftTmp As Double
    Screen.MousePointer = vbHourglass
    For Each bmInc In tbrAdditional(0).Buttons("Tags").ButtonMenus
        sSql = bmInc.Tag
        sSql = Replace(sSql, "$CompanyID$", mlngCompanyID)
        sSql = Replace(sSql, "$PeriodID$", mlngPeriodID)
        WriteToCollection cllTagValue, GetSingleValueFromSQL(sSql), bmInc.Key
    Next bmInc
    With frmPreview.vpPreview
        If IsExport Then
            .PaperSize = pprA4
            .ExportFormat = vpxRTFExtended
            .ExportFile = App.Path & "\eAuditProReports.DOC"
        End If
        frmPreview.vpPreview.NavBar = vpnbTop
        For PageInc = 1 To mlngPageCount
            .PaperSize = mcgPageProperties.ValueMatrix(PageInc, grdPgPrpPaperSize)
            .Orientation = mcgPageProperties.ValueMatrix(PageInc, grdPgPrpOrientation)
            .MarginBottom = ConvertToBaseUnit(mcgPageProperties.ValueMatrix(PageInc, grdPgPrpMarginBottom))
            .MarginLeft = ConvertToBaseUnit(mcgPageProperties.ValueMatrix(PageInc, grdPgPrpMarginLeft))
            .MarginRight = ConvertToBaseUnit(mcgPageProperties.ValueMatrix(PageInc, grdPgPrpMarginRight))
            .MarginTop = ConvertToBaseUnit(mcgPageProperties.ValueMatrix(PageInc, grdPgPrpMarginTop))
            .BrushStyle = bsTransparent
            If PageInc <= 1 Then
                .StartDoc
            Else
                If .PageCount > 3 Then
                    If .MarginBottom < 650 Then
                        .MarginBottom = 650
                    End If
                    .MarginFooter = 600
                    .HdrFontName = "Times New Roman"
                    .HdrFontSize = 13
                    .Footer = "|-" & .PageCount - 2 & "-"
                End If
                .NewPage
            End If
            For Each ctrlInc In Controls
                Select Case ctrlInc.Name
                Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
                    If Val(ctrlInc.Tag) = PageInc Then
                        Select Case ctrlInc.Name
                        Case "rtbText"
                            strTextRTF = ctrlInc.TextRTF
                            For Each bmInc In tbrAdditional(0).Buttons("Tags").ButtonMenus
                                strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(bmInc.Key, vbUpperCase) & pcnstTagEnd, StrConv(cllTagValue(bmInc.Key), vbUpperCase))
                                strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(bmInc.Key, vbProperCase) & pcnstTagEnd, cllTagValue(bmInc.Key))
                                strTextRTF = Replace(strTextRTF, pcnstTagStart & StrConv(bmInc.Key, vbLowerCase) & pcnstTagEnd, StrConv(cllTagValue(bmInc.Key), vbLowerCase))
                            Next bmInc
                            .TextBox strTextRTF, ctrlInc.Left, ctrlInc.Top, ctrlInc.Width, ctrlInc.Height
                        Case "imgPicture"
                            .DrawPicture ctrlInc, ctrlInc.Left, ctrlInc.Top, ctrlInc.Width, ctrlInc.Height
                        Case "vsfgTable"
                            .TextRTF = ""
                            .CurrentY = ctrlInc.Top
                            .CurrentX = ctrlInc.Left
                            dblMarginLeftTmp = .MarginLeft
                            'If .MarginLeft > ctrlInc.Left Then
                            .MarginLeft = ctrlInc.Left
                            'End If
                            .StartTable
                            .TableBorder = mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowBorderType, grdPropColValue)
                            .TableCell(tcRows) = 0
                            .TableCell(tcCols) = 0
                            dblTmpHeight = 0
                            For RowInc = 0 To ctrlInc.Rows - 1
                                dblTmpHeight = dblTmpHeight + ctrlInc.RowHeight(RowInc)
                                If dblTmpHeight - 2000 <= ctrlInc.Height Then
                                    .TableCell(tcRows) = RowInc + 1
                                    dblTmpWidth = 0
                                    For ColInc = 0 To ctrlInc.Cols - 1
                                        'dblTmpWidth = dblTmpWidth + (ctrlInc.ColWidth(ColInc) * pcnstColWidthRatioFromGridToPrint)
                                        dblTmpWidth = dblTmpWidth + (ctrlInc.ColWidth(ColInc))
                                        If dblTmpWidth - 2000 <= ctrlInc.Width Then
                                            If ColInc + 1 > .TableCell(tcCols) Then
                                                .TableCell(tcCols) = ColInc + 1
                                            End If
                                            .TableCell(tcAlign, RowInc + 1, ColInc + 1) = GetPrintAlignment(ctrlInc.Cell(flexcpAlignment, RowInc, ColInc))
                                            .TableCell(tcBackColor, RowInc + 1, ColInc + 1) = Val(ctrlInc.Cell(flexcpBackColor, RowInc, ColInc))
                                            .TableCell(tcForeColor, RowInc + 1, ColInc + 1) = Val(ctrlInc.Cell(flexcpForeColor, RowInc, ColInc))
                                            '.TableCell(tcRowHeight, RowInc + 1, ColInc + 1) = ctrlInc.RowHeight(RowInc) * pcnstRowHeightRatioFromGridToPrint
                                            .TableCell(tcRowHeight, RowInc + 1, ColInc + 1) = ctrlInc.RowHeight(RowInc)
                                            '.TableCell(tcColWidth, RowInc + 1, ColInc + 1) = ctrlInc.ColWidth(ColInc) * pcnstColWidthRatioFromGridToPrint
                                            .TableCell(tcColWidth, RowInc + 1, ColInc + 1) = ctrlInc.ColWidth(ColInc)
                                            .TableCell(tcFontName, RowInc + 1, ColInc + 1) = ctrlInc.Cell(flexcpFontName, RowInc, ColInc)
                                            .TableCell(tcFontSize, RowInc + 1, ColInc + 1) = Val(ctrlInc.Cell(flexcpFontSize, RowInc, ColInc))
                                            .TableCell(tcFontBold, RowInc + 1, ColInc + 1) = ctrlInc.Cell(flexcpFontBold, RowInc, ColInc)
                                            .TableCell(tcFontItalic, RowInc + 1, ColInc + 1) = ctrlInc.Cell(flexcpFontItalic, RowInc, ColInc)
                                            .TableCell(tcFontUnderline, RowInc + 1, ColInc + 1) = ctrlInc.Cell(flexcpFontUnderline, RowInc, ColInc)
                                            .TableCell(tcText, RowInc + 1, ColInc + 1) = ctrlInc.Cell(flexcpText, RowInc, ColInc)
                                        End If
                                    Next ColInc
                                End If
                            Next RowInc
                            .EndTable
                            .MarginLeft = dblMarginLeftTmp
                        Case "ulnLine"
                            .DrawLine ctrlInc.X1, ctrlInc.Y1, ctrlInc.X2, ctrlInc.Y2
                        Case "ushpRectangle"
                            .DrawRectangle ctrlInc.Left, ctrlInc.Top, ctrlInc.Left + ctrlInc.Width, ctrlInc.Top + ctrlInc.Height
                        Case "ushpOval"
                            .DrawEllipse ctrlInc.Left, ctrlInc.Top, ctrlInc.Left + ctrlInc.Width, ctrlInc.Top + ctrlInc.Height
                        End Select
                    End If
                End Select
            Next ctrlInc
        Next PageInc
        If .PageCount > 3 Then
            .MarginFooter = 600
            .HdrFontName = "Times New Roman"
            .HdrFontSize = 13
            .Footer = "|-" & .PageCount - 2 & "-"
        End If
        .EndDoc
    End With
    frmPreview.vpPreview.PreviewPage = RVal(txtPageNo.Text)
    frmPreview.Show
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
End Sub

Private Sub ConfigurePropertyGridClass(ByVal lngArrInc As Long)
    With mcgProperties(lngArrInc)
        .Cols = cnstPropColCount
        .Rows = cnstPropRowCount
        .TextMatrix(grdPropRowX1, grdPropColName) = "X1"
        .TextMatrix(grdPropRowY1, grdPropColName) = "Y1"
        .TextMatrix(grdPropRowX2, grdPropColName) = "X2"
        .TextMatrix(grdPropRowY2, grdPropColName) = "Y2"
        .TextMatrix(grdPropRowLeft, grdPropColName) = "Left"
        .TextMatrix(grdPropRowWidth, grdPropColName) = "Width"
        .TextMatrix(grdPropRowTop, grdPropColName) = "Top"
        .TextMatrix(grdPropRowHeight, grdPropColName) = "Height"
        .TextMatrix(grdPropRowTblType, grdPropColName) = "Type"
        .TextMatrix(grdPropRowAcType, grdPropColName) = "Ac Type"
        .TextMatrix(grdPropRowCols, grdPropColName) = "Cols"
        .TextMatrix(grdPropRowRows, grdPropColName) = "Rows"
        .TextMatrix(grdPropRowBorderType, grdPropColName) = "Border"
        .TextMatrix(grdPropRowTblType, grdPropColDisplay) = "Custom Table"
        .TextMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable
        .TextMatrix(grdPropRowBorderType, grdPropColDisplay) = "None"
        .TextMatrix(grdPropRowBorderType, grdPropColValue) = tbNone
    End With
End Sub

Private Sub SetControlPropertiesInPropertyGrid(ByRef ctrlControl As Control)
    Dim Inc As Long
    mcgProperties(mlngCrntArrInc).SetValuesToGrid vsfgProperties
    With vsfgProperties
        If mstrCrntCtrlType = "Line" Then
            .TextMatrix(grdPropRowX1, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.X1)
            .TextMatrix(grdPropRowY1, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Y1)
            .TextMatrix(grdPropRowX2, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.X2)
            .TextMatrix(grdPropRowY2, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Y2)
        Else
            .TextMatrix(grdPropRowLeft, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Left)
            .TextMatrix(grdPropRowHeight, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Height)
            .TextMatrix(grdPropRowTop, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Top)
            .TextMatrix(grdPropRowWidth, grdPropColDisplay) = ConvertToRealUnit(ctrlControl.Width)
        End If
        If mstrCrntCtrlType = "Table" Then
            .TextMatrix(grdPropRowRows, grdPropColDisplay) = ctrlControl.Rows
            .TextMatrix(grdPropRowCols, grdPropColDisplay) = ctrlControl.Cols
        End If
        For Inc = 0 To .Rows - 1
            .RowHidden(Inc) = True
            Select Case Inc
            Case grdPropRowX1, grdPropRowX2, grdPropRowY1, grdPropRowY2
                If mstrCrntCtrlType = "Line" Then
                    .RowHidden(Inc) = False
                End If
            Case grdPropRowLeft, grdPropRowWidth, grdPropRowTop, grdPropRowHeight
                If mstrCrntCtrlType <> "Line" Then
                    .RowHidden(Inc) = False
                End If
            End Select
            Select Case Inc
            Case grdPropRowTblType, grdPropRowAcType, grdPropRowCols, grdPropRowRows, grdPropRowBorderType
                If mstrCrntCtrlType = "Table" Then
                    .RowHidden(Inc) = False
                End If
            End Select
            
            Select Case Inc
            Case grdPropRowTblType, grdPropRowAcType, grdPropRowBorderType
            Case Else
                .TextMatrix(Inc, grdPropColValue) = .TextMatrix(Inc, grdPropColDisplay)
            End Select
        Next Inc
    End With
    mcgProperties(mlngCrntArrInc).GetValuesFromGrid vsfgProperties
End Sub

Private Sub ShowProperties(ByRef ctrlControl As Control)
    On Local Error Resume Next
    mblnIsStartingUp = True
    SetControlPropertiesInPropertyGrid ctrlControl
    PopulateProperties
    cmbProperties.Text = mstrCrntCtrlType & "(" & mlngCrntArrInc & ")"
    mblnIsStartingUp = False
End Sub

Private Sub PopulateProperties()
    Dim ctrlTmp As Control
    With cmbProperties
        .Clear
        For Each ctrlTmp In Controls
            Select Case ctrlTmp.Name
            Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
                If ctrlTmp.Visible Then
                    Select Case ctrlTmp.Name
                    Case "rtbText"
                        .AddItem "Text(" & ctrlTmp.Index & ")"
                    Case "imgPicture"
                        .AddItem "Picture(" & ctrlTmp.Index & ")"
                    Case "vsfgTable"
                        .AddItem "Table(" & ctrlTmp.Index & ")"
                    Case "ulnLine"
                        .AddItem "Line(" & ctrlTmp.Index & ")"
                    Case "ushpRectangle"
                        .AddItem "Rectangle(" & ctrlTmp.Index & ")"
                    Case "ushpOval"
                        .AddItem "Oval(" & ctrlTmp.Index & ")"
                    End Select
                End If
            End Select
        Next ctrlTmp
    End With
End Sub

Public Sub ShowSelection(Optional ByVal IsShowProperties As Boolean = True)
    On Local Error Resume Next
    mblnIsEditTemplate = False
    uselSelection.Visible = False
    If mstrCrntCtrlType <> "" Then
'        Set mcrtbText = Nothing
        Select Case mstrCrntCtrlType
        Case "Text"
            Set mctrlSelected = rtbText(mlngCrntArrInc)
            mctrlSelected.HideSelection = False
            'mcrtbText.WatchControl rtbText(mlngCrntArrInc)
        Case "Picture"
            Set mctrlSelected = imgPicture(mlngCrntArrInc)
        Case "Table"
            Set mctrlSelected = vsfgTable(mlngCrntArrInc)
        Case "Line"
            Set mctrlSelected = ulnLine(mlngCrntArrInc)
        Case "Rectangle"
            Set mctrlSelected = ushpRectangle(mlngCrntArrInc)
        Case "Oval"
            Set mctrlSelected = ushpOval(mlngCrntArrInc)
        End Select
        uselSelection.ShowSelection mctrlSelected, mstrCrntCtrlType
        If IsShowProperties Then
            ShowProperties mctrlSelected
        End If
        tbrText.Visible = False
        tbrObjects.Buttons("Process Table").ButtonMenus("Selected").Enabled = False
        If mstrCrntCtrlType = "Text" Or vsfgProperties.ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
            If uselSelection.Editing Then
                tbrText.Visible = True
            End If
            If mstrCrntCtrlType = "Table" Then
                tbrText.Buttons("Justify").Enabled = False
                cmbTextStyle.Visible = False
            Else
                tbrText.Buttons("Justify").Enabled = True
                cmbTextStyle.Visible = True
            End If
        ElseIf mstrCrntCtrlType = "Table" And vsfgProperties.ValueMatrix(grdPropRowTblType, grdPropColValue) <> rptTTCustomTable Then
            tbrObjects.Buttons("Process Table").ButtonMenus("Selected").Enabled = True
        End If
    End If
End Sub

Private Sub DeleteObjects()
    If pMVE.MsgBox("Are you sure to delete the object '" & mstrCrntCtrlType & "(" & mlngCrntArrInc & ")'?", msgYesNo) Then
        Unload mctrlSelected
        SelectMaxIndexControl
    End If
End Sub

Private Sub tbrObjects_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Local Error Resume Next
    Dim dblLastCntrlTop As Double, ctrlControl As Control
    Static ctrlForEdit As Control, strForEditType As String, lngForEditArrInc As Long
    Select Case Button.Key
    Case "Properties"
        ShowProperties mctrlSelected
    Case "Delete Object"
        DeleteObjects
    Case "Process Table"
        If Button.ButtonMenus("Selected").Enabled Then
            tbrObjects_ButtonMenuClick Button.ButtonMenus("Selected")
        End If
    Case "Cut Object", "Copy Object"
        Set ctrlForEdit = mctrlSelected
        strForEditType = mstrCrntCtrlType
        lngForEditArrInc = mlngCrntArrInc
        If Button.Key = "Cut Object" Then
            ctrlForEdit.Tag = ""
            ctrlForEdit.Visible = False
            mstrCrntCtrlType = ""
            Set mctrlSelected = Nothing
            ShowSelection True
        End If
    Case "Paste Object"
        Dim ctrlNew As Control
        If ctrlForEdit.Tag = "" Then
            Set ctrlNew = ctrlForEdit
        Else
            If LoadObject(strForEditType, ctrlNew) Then
                mstrCrntCtrlType = strForEditType
                mlngCrntArrInc = mlngMaxArrInc
                With ctrlNew
                    .Left = ctrlForEdit.Left
                    .Top = ctrlForEdit.Top
                    .Width = ctrlForEdit.Width
                    .Height = ctrlForEdit.Height
                    Select Case strForEditType
                    Case "Text"
                        .TextRTF = ctrlForEdit.TextRTF
                    Case "Picture"
                        Set .Picture = ctrlForEdit.Picture
                    Case "Table"
                        CopyGridToGrid ctrlForEdit, ctrlNew
                    End Select
                    mcgProperties(mlngCrntArrInc).GetValuesFromGridClass mcgProperties(lngForEditArrInc)
                End With
            End If
        End If
        If Not ctrlNew Is Nothing Then
            Set mctrlSelected = ctrlNew
            mstrCrntCtrlType = strForEditType
            mlngCrntArrInc = lngForEditArrInc
            With ctrlNew
                .Tag = txtPageNo.Text
                .Visible = True
                .ZOrder vbBringToFront
            End With
            ShowSelection 'show borders of the selected control
            uselSelection.ZOrder vbBringToFront
        End If
    Case Else 'load object
        If LoadObject(Button.Key, ctrlControl) Then
            dblLastCntrlTop = vspTmp.MarginTop
            If Not mctrlSelected Is Nothing Then
                If RVal(txtPageNo.Text) = RVal(mctrlSelected.Tag) Then
                    If mctrlSelected.Name = "ulnLine" Then
                        dblLastCntrlTop = mctrlSelected.Y2
                    Else
                        dblLastCntrlTop = mctrlSelected.Top + mctrlSelected.Height
                    End If
                End If
            End If
            If dblLastCntrlTop > vspTmp.PageHeight - vspTmp.MarginBottom Then
                dblLastCntrlTop = vspTmp.MarginTop
            End If
            mstrCrntCtrlType = Button.Key
            mlngCrntArrInc = mlngMaxArrInc
            With ctrlControl
                .Tag = txtPageNo.Text
                If Button.Key = "Line" Then
                    .X1 = vspTmp.MarginLeft
                    .Y1 = dblLastCntrlTop '0
                    If .Y2 > vspTmp.PageHeight - vspTmp.MarginBottom Then
                        .Y2 = (vspTmp.PageHeight - vspTmp.MarginBottom)
                    Else
                        .Y2 = .Y1 + .Y2
                    End If
                Else
                    .Left = vspTmp.MarginLeft
                    .Top = dblLastCntrlTop 'vspTmp.MarginTop
                    .Width = vspTmp.PageWidth - (vspTmp.MarginRight + vspTmp.MarginLeft)
                    If .Top + .Height > vspTmp.PageHeight - vspTmp.MarginBottom Then
                        .Height = (vspTmp.PageHeight - vspTmp.MarginBottom) - .Top
                    End If
                End If
                If Button.Key = "Text" Then
                    .FontName = cmbFontName.Text 'set all font name
                    .FontSize = RVal(cmbFontSize.Text) 'set all font size
                End If
                .Visible = True
            End With
            ShowSelection 'show borders of the selected control
        End If
    End Select
End Sub

Private Sub tbrObjects_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
    On Local Error Resume Next
    Dim TableInc As Long, TableMin As Long, TableMax As Long, crptTmp As clsReports
    Select Case ButtonMenu.Key
    Case "Selected"
        TableMin = mlngCrntArrInc
        TableMax = mlngCrntArrInc
    Case "All"
        TableMin = 1
        TableMax = mlngMaxArrInc 'assuming all objects are table objects
    End Select
    For TableInc = TableMin To TableMax 'assuming all objects are table objects
        'do processing on different table types this will affect only on table objects
        With mcgProperties(TableInc)
            Select Case .ValueMatrix(grdPropRowTblType, grdPropColValue)
            Case rptTTBalanceSheet, rptTTEquitySchedule, rptTTFixedAssetsSchedule, _
                rptTTGeneralSchedule, rptTTSplitSchedule, rptTTCashFlow, rptTTProfitAndLoss, _
                rptTTCashEquivalents, rptTTLiabilitySchedule
                Select Case .ValueMatrix(grdPropRowTblType, grdPropColValue)
                Case rptTTBalanceSheet
                    Set crptTmp = PrintBalanceSheet(mlngPeriodID, False)
                Case rptTTCashFlow
                    Set crptTmp = PrintCashFlow(mlngPeriodID, False)
                Case rptTTProfitAndLoss
                    Set crptTmp = PrintProfitLoss(mlngPeriodID, False)
                Case rptTTEquitySchedule
                    Set crptTmp = PrintShareholdersEquity(mlngPeriodID, False)
                Case rptTTFixedAssetsSchedule
                    Set crptTmp = PrintFixedAssetSchedules(mlngPeriodID, False)
                Case rptTTGeneralSchedule
                    Set crptTmp = PrintGeneralSchedules(mlngPeriodID, .ValueMatrix(grdPropRowAcType, grdPropColValue), False)
                Case rptTTSplitSchedule
                    Set crptTmp = PrintSplitSchedules(mlngPeriodID, .ValueMatrix(grdPropRowAcType, grdPropColValue), False)
                Case rptTTCashEquivalents
                    Set crptTmp = PrintCashEquivalentSchedule(mlngPeriodID, False)
                Case rptTTLiabilitySchedule
                    Set crptTmp = PrintLiabilitySchedules(mlngPeriodID, .ValueMatrix(grdPropRowAcType, grdPropColValue), False)
                End Select
                LoadObjectProperties vsfgTable(TableInc), crptTmp, crptTmp.ObjectCount, True
                LoadObjectData vsfgTable(TableInc), crptTmp, crptTmp.ObjectCount
                crptTmp.Clear
                Set crptTmp = Nothing
            Case rptTTTableOfContents
                GenerateTableOfContent
            Case rptTTCustomTable
            End Select
        End With
    Next TableInc
End Sub

Private Sub tbrPage_ButtonClick(ByVal Button As MSComctlLib.Button)
On Local Error Resume Next
    Dim lngCurrentPageTem As Long
    Select Case Button.Key
    Case "First"
        MakePageActive (1)
    Case "Previous"
        If txtPageNo.Text - 1 > 0 Then
            MakePageActive (txtPageNo.Text - 1)
        End If
    Case "Next"
        If txtPageNo.Text + 1 <= mlngPageCount Then
            MakePageActive (txtPageNo.Text + 1)
        End If
    Case "Last"
        MakePageActive (mlngPageCount)
    Case "New Page"
        SetPageProperties "Append", RVal(txtPageNo.Text)
    Case "Delete Page"
        SetPageProperties "Delete", RVal(txtPageNo.Text)
    End Select
    mlngCrntArrInc = 0
    mstrCrntCtrlType = ""
    Set mctrlSelected = Nothing
    PopulateProperties
    ShowSelection
End Sub

Private Sub tbrPage_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
    SetPageProperties ButtonMenu.Key, RVal(txtPageNo.Text)
End Sub

Private Sub tbrAdditional_ButtonMenuClick(Index As Integer, ByVal ButtonMenu As MSComctlLib.ButtonMenu)
    ChangeSelAttributes rptTblText, ButtonMenu.Parent.Key, ButtonMenu
End Sub

Private Sub tbrText_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Local Error Resume Next
    Select Case Button.Key
    Case "Bold"
        ChangeSelAttributes rptTblIsBold
    Case "Italic"
        ChangeSelAttributes rptTblIsItalic
    Case "Underline"
        ChangeSelAttributes rptTblUnderline
    Case "Back Color"
        cdlgDesigner.ShowColor
        ChangeSelAttributes rptTblBackColor
    Case "Fore Color"
        cdlgDesigner.ShowColor
        ChangeSelAttributes rptTblForeColor
    Case "Left", "Right", "Center", "Justify"
        ChangeSelAttributes rptTblAlignment
    Case "Cut", "Copy", "Paste", "Spelling"
        ChangeSelAttributes rptTblText, Button.Key
    End Select
End Sub

Private Sub SetMarginRectangle()
    On Local Error Resume Next
    With ushpMargin
        .Left = vspTmp.MarginLeft - 10
        .Top = vspTmp.MarginTop - 10
        .Width = (picDesigner.Width + 20 - vspTmp.MarginRight) - .Left
        .Height = (picDesigner.Height + 20 - vspTmp.MarginBottom) - .Top
    End With
End Sub

Private Sub tbrText_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
    On Local Error Resume Next
    Dim lngSelStartTmp As Long, lngSelLengthTmp As Long
    Dim lngSelStart As Long, lngSelLength As Long, strText As String
    Dim lngCustomLineSpcing As Long, lsrLineSpacing As LineSpacingRules
    With tbrText.Buttons("Line Spacing")
        .ButtonMenus("LS1.0") = "  1.0"
        .ButtonMenus("LS1.5") = "  1.5"
        .ButtonMenus("LS2.0") = "  2.0"
    End With
    Select Case ButtonMenu.Key
    Case "LS1.0"
        'SetLineSpacing mctrlSelected.hWnd, lnspSingle
        SetLineSpacing mctrlSelected.hWnd, lnspCustom3, 1 * 20
        ButtonMenu = "* 1.0"
    Case "LS1.5"
        'SetLineSpacing mctrlSelected.hWnd, lnspOneAndAHalf
        SetLineSpacing mctrlSelected.hWnd, lnspCustom3, 1.5 * 20
        ButtonMenu = "* 1.5"
    Case "LS2.0"
        'SetLineSpacing mctrlSelected.hWnd, lnspDouble
        SetLineSpacing mctrlSelected.hWnd, lnspCustom3, 2 * 20
        ButtonMenu = "* 2.0"
    Case "More"
        lsrLineSpacing = GetLineSpacing(mctrlSelected.hWnd, lngCustomLineSpcing)
        txtLineSpacing.Text = ""
        Select Case lsrLineSpacing
        Case lnspSingle
            cmbLineSpacing.Text = "Single"
        Case lnspOneAndAHalf
            cmbLineSpacing.Text = "1.5 lines"
        Case lnspDouble
            cmbLineSpacing.Text = "Double"
        Case lnspCustom1
            cmbLineSpacing.Text = "At least"
            txtLineSpacing.Text = lngCustomLineSpcing / 20#
        Case lnspCustom2
            cmbLineSpacing.Text = "Exactly"
            txtLineSpacing.Text = lngCustomLineSpcing / 20#
        Case lnspCustom3
            cmbLineSpacing.Text = "Multiple"
            txtLineSpacing.Text = lngCustomLineSpcing / 20#
        End Select
        'With picLineSpacing
        '    .Left = tbrText.Left + tbrText.Buttons("Line Spacing").Left + tbrText.Buttons("Line Spacing").Width - .Width
        '    .Top = tbrText.Top + tbrText.Height
        '    .Visible = True
        'End With
        ShowSubWindow picLineSpacing, tbrText, "Line Spacing"
        'With mctrlSelected
        '    lngSelStartTmp = .SelStart
        '    lngSelLengthTmp = .SelLength
        '    lngSelStart = GetLineStart(mctrlSelected)
        '    lngSelLength = GetLineLength(mctrlSelected)
        '    .SelStart = lngSelStart
        '    .SelLength = lngSelLength
        '    strText = .SelText
        '    rtbLineSpacing.Width = 8000
        '    rtbLineSpacing.Height = 8000
        '    picLineSpacing1.Width = 8000
        '    picLineSpacing1.Height = 800
        '    With rtbLineSpacing
        '        SetAlignment .hWnd, ercParaJustify
        '        .SelLength = 0
        '        .TextRTF = CreateRTF(RepeatString("Previous Paragraph ", 1, 9), , , , , , , RGB(200, 0, 0))
        '        .SelStart = Len(.Text)
        '        .SelRTF = CreateRTF(vbCrLf & strText & vbCrLf, , , , , , , vbBlack)
        '        .SelStart = Len(CreateRTF(RepeatString("Following Paragraph ", 1, 9)))
        '        .SelRTF = CreateRTF(RepeatString("Following Paragraph ", 1, 9), , , , , , , RGB(200, 0, 0))
        '        .SelStart = 0
        '        .SelLength = Len(.Text)
        '        picLineSpacing1.Cls
        '        .SelPrint picLineSpacing1.hDC
        '    End With
        '    Set imgLineSpacing = picLineSpacing1.Image
        '    .SelStart = lngSelStartTmp
        '    .SelLength = lngSelLengthTmp
        'End With
    End Select
End Sub

Private Sub ShowSubWindow(ByRef ctrlWindow As Control, ByRef tbrParentToolBar As MSComctlLib.Toolbar, ByVal strButtonKey As String)
    Dim sngLeft As Single
    With tbrParentToolBar
        sngLeft = .Left + .Buttons(strButtonKey).Left
        If sngLeft + .Buttons(strButtonKey).Width - ctrlWindow.Width < 0 Then
            ctrlWindow.Left = sngLeft
        Else
            ctrlWindow.Left = sngLeft + .Buttons(strButtonKey).Width - ctrlWindow.Width
        End If
        ctrlWindow.Top = .Top + .Height
        ctrlWindow.Visible = True
        ctrlWindow.ZOrder vbBringToFront
    End With
End Sub

Private Sub tbsFind_Click()
    If tbsFind.Tabs("Find").Selected Then
        cmdReplace.Visible = False
        cmdReplaceAll.Visible = False
        fraReplaceWith.Visible = False
        txtReplaceWith.Visible = False
    Else
        cmdReplace.Visible = True
        cmdReplaceAll.Visible = True
        fraReplaceWith.Visible = True
        txtReplaceWith.Visible = True
    End If
End Sub

Private Sub tbsFind_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub txtFindWhat_Change()
    Set mctrlFind = Nothing
    mlngFindPos = -1
End Sub

Private Sub txtMarginLeft_Change()
    vspTmp.MarginLeft = ConvertToBaseUnit(RVal(txtMarginLeft.Text))
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpMarginLeft) = txtMarginLeft.Text
    SetMarginRectangle
    vsvpDesigner.VirtualLeft = vspTmp.MarginLeft
End Sub

Private Sub txtMarginRight_Change()
    vspTmp.MarginRight = ConvertToBaseUnit(RVal(txtMarginRight.Text))
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpMarginRight) = txtMarginRight.Text
    SetMarginRectangle
End Sub

Private Sub txtMarginTop_Change()
    vspTmp.MarginTop = ConvertToBaseUnit(RVal(txtMarginTop.Text))
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpMarginTop) = txtMarginTop.Text
    SetMarginRectangle
    vsvpDesigner.VirtualTop = vspTmp.MarginTop
End Sub

Private Sub txtMarginBottom_Change()
    vspTmp.MarginBottom = ConvertToBaseUnit(RVal(txtMarginBottom.Text))
    mcgPageProperties.TextMatrix(RVal(txtPageNo.Text), grdPgPrpMarginBottom) = txtMarginBottom.Text
    SetMarginRectangle
End Sub

Private Sub txtPageNo_Change()
    tbrText.Visible = False
End Sub

Private Sub txtPageNo_GotFocus()
    mlngPageNoTemp = txtPageNo.Text
End Sub

Private Sub txtPageNo_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtPageNo_LostFocus()
    If RVal(txtPageNo.Text) <= 0 Or RVal(txtPageNo.Text) > mlngPageCount Then
        pMVE.MsgBox "Invalid Page No.", msgOK
        txtPageNo.Text = mlngPageNoTemp
    Else
        MakePageActive Val(txtPageNo.Text)
    End If
End Sub

Private Sub MakePageActive(lngPageNo As Long)
    Dim ctrlInc As Control
    For Each ctrlInc In Controls
        Select Case ctrlInc.Name
        Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
            If Val(ctrlInc.Tag) = lngPageNo Then
                ctrlInc.Visible = True
            Else
                ctrlInc.Visible = False
            End If
        End Select
    Next ctrlInc
    txtPageNo.Text = lngPageNo
    With mcgPageProperties
        txtMarginBottom.Text = .TextMatrix(lngPageNo, grdPgPrpMarginBottom)
        txtMarginLeft.Text = .TextMatrix(lngPageNo, grdPgPrpMarginLeft)
        txtMarginRight.Text = .TextMatrix(lngPageNo, grdPgPrpMarginRight)
        txtMarginTop.Text = .TextMatrix(lngPageNo, grdPgPrpMarginTop)
        SetComboBoundValue cmbPaperSize, .ValueMatrix(lngPageNo, grdPgPrpPaperSize)
        If .ValueMatrix(lngPageNo, grdPgPrpOrientation) = 0 Then
            optPortrait.Value = True
        Else
            optLandscape.Value = True
        End If
    End With
End Sub

Private Sub txtReportName_Change()
    lblHeading.Caption = " " & IIf(chkTemplate.Value = vbChecked, "Template-", "") & txtReportName.Text
End Sub

Private Sub ulnLine_Click(Index As Integer)
    mlngCrntArrInc = Index
    mstrCrntCtrlType = "Line"
    ShowSelection
End Sub

Private Sub ulnLine_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub uselSelection_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub uselSelection_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    uselSelection.Drag vbBeginDrag
End Sub

Private Sub ushpMargin_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub ushpOval_Click(Index As Integer)
    mlngCrntArrInc = Index
    mstrCrntCtrlType = "Oval"
    ShowSelection
End Sub

Private Sub ushpOval_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub ushpRectangle_Click(Index As Integer)
    mlngCrntArrInc = Index
    mstrCrntCtrlType = "Rectangle"
    ShowSelection
End Sub

Private Sub ushpRectangle_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub vsfgProperties_CellChanged(ByVal Row As Long, ByVal Col As Long)
    On Local Error Resume Next
    With vsfgProperties
        If Row = grdPropRowTblType And Col = grdPropColValue Then
            Select Case .ValueMatrix(grdPropRowTblType, grdPropColValue)
            Case rptTTCustomTable, rptTTTableOfContents, rptTTBalanceSheet, _
                rptTTFixedAssetsSchedule, rptTTCashFlow, rptTTProfitAndLoss, rptTTCashEquivalents
                .TextMatrix(grdPropRowAcType, grdPropColDisplay) = ""
                .TextMatrix(grdPropRowAcType, grdPropColValue) = ""
                .Cell(flexcpBackColor, grdPropRowAcType, 0, grdPropRowAcType, .Cols - 1) = pclrRestrictionColor
                Select Case .ValueMatrix(grdPropRowTblType, grdPropColValue)
                Case rptTTCustomTable, rptTTTableOfContents
                    .Cell(flexcpBackColor, grdPropRowBorderType, 0, grdPropRowBorderType, .Cols - 1) = .BackColor
                Case Else
                    .Cell(flexcpBackColor, grdPropRowBorderType, 0, grdPropRowBorderType, .Cols - 1) = pclrRestrictionColor
                End Select
            Case Else
                .Cell(flexcpBackColor, grdPropRowAcType, 0, grdPropRowAcType, .Cols - 1) = .BackColor
                .Cell(flexcpBackColor, grdPropRowBorderType, 0, grdPropRowBorderType, .Cols - 1) = pclrRestrictionColor
            End Select
            If .ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
                .Cell(flexcpBackColor, grdPropRowCols, 0, grdPropRowCols, .Cols - 1) = .BackColor
                .Cell(flexcpBackColor, grdPropRowRows, 0, grdPropRowRows, .Cols - 1) = .BackColor
                mctrlSelected.Highlight = flexHighlightWithFocus
            Else
                .Cell(flexcpBackColor, grdPropRowCols, 0, grdPropRowCols, .Cols - 1) = pclrRestrictionColor
                .Cell(flexcpBackColor, grdPropRowRows, 0, grdPropRowRows, .Cols - 1) = pclrRestrictionColor
                mctrlSelected.Highlight = flexHighlightNever
            End If
        End If
    End With
End Sub

Private Sub vsfgProperties_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub vsfgTable_BeforeEdit(Index As Integer, ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    On Local Error Resume Next
    If mcgProperties(Index).ValueMatrix(grdPropRowTblType, grdPropColValue) <> rptTTCustomTable Then
        Cancel = True
    End If
End Sub

Private Sub vsfgTable_Click(Index As Integer)
    mlngCrntArrInc = Index
    mstrCrntCtrlType = "Table"
    uselSelection.Editing = True
    ShowSelection
    vsfgTable_SelChange Index
End Sub

Public Sub FindControlFromControlName(ByVal strCntrlName As String)
    mstrCrntCtrlType = Mid(strCntrlName, 1, InStr(1, strCntrlName, "(") - 1)
    mlngCrntArrInc = RVal(Mid(strCntrlName, InStr(1, strCntrlName, "(") + 1))
    ShowSelection False
    SetControlPropertiesInPropertyGrid mctrlSelected
End Sub

Public Sub SelectControl(ctrlControl As Control)
    Dim strCntrlName As String
    Select Case ctrlControl.Name
    Case "rtbText"
        strCntrlName = "Text"
    Case "imgPicture"
        strCntrlName = "Picture"
    Case "vsfgTable"
        strCntrlName = "Table"
    Case "ulnLine"
        strCntrlName = "Line"
    Case "ushpRectangle"
        strCntrlName = "Rectangle"
    Case "ushpOval"
        strCntrlName = "Oval"
    End Select
    strCntrlName = strCntrlName & "(" & ctrlControl.Index & ")"
    FindControlFromControlName strCntrlName
End Sub

Private Sub FindControlFromMouseSelection(X As Single, Y As Single, Optional strSearchInType As String = "Line")
    On Local Error Resume Next
    Dim Inc As Long, dblM As Double, dblB As Double, IsExists As Boolean, objTmp As Object
    Dim dblLeft As Double, dblWidth As Double, dblTop As Double, dblHeight As Double
    Select Case strSearchInType
    Case "Line"
        For Inc = ulnLine.LBound To ulnLine.UBound
            With ulnLine(Inc)
                If .Visible Then
                    Err.Clear
                    dblM = (.Y1 - .Y2) / (.X1 - .X2)
                    If Err.Number = 0 Then
                        dblB = .Y1 - (.X1 * dblM)
                        If Abs(Y - (dblM * X + dblB)) < 50 Then
                            mlngCrntArrInc = Inc
                            mstrCrntCtrlType = strSearchInType
                            ShowSelection
                            IsExists = True
                            Exit For
                        End If
                    End If
                End If
            End With
        Next Inc
        If Not IsExists Then
            FindControlFromMouseSelection X, Y, "Rectangle"
        End If
    Case "Rectangle"
        Set objTmp = ushpRectangle
    Case "Oval"
        Set objTmp = ushpOval
    End Select
    If Not objTmp Is Nothing Then
        For Inc = objTmp.LBound To objTmp.UBound
            With objTmp(Inc)
                If .Visible Then
                    Err.Clear
                    dblLeft = .Left: dblWidth = .Width: dblTop = .Top: dblHeight = .Height
                    If (X >= dblLeft And X <= dblLeft + dblWidth And (Abs(Y - dblTop) < 50 _
                        Or Abs(Y - (dblTop + dblHeight)) < 50)) Or (Y >= dblTop And Y <= dblTop + dblHeight _
                        And (Abs(X - dblLeft) < 50 Or Abs(X - (dblLeft + dblWidth)) < 50)) Then
                        If Err.Number = 0 Then
                            mlngCrntArrInc = Inc
                            mstrCrntCtrlType = strSearchInType
                            ShowSelection
                            IsExists = True
                            Exit For
                        End If
                    End If
                End If
            End With
        Next Inc
        If Not IsExists And strSearchInType = "Rectangle" Then
            FindControlFromMouseSelection X, Y, "Oval"
        End If
    End If
End Sub

Private Sub vsfgTable_DragDrop(Index As Integer, Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub vsfgTable_GotFocus(Index As Integer)
    mblnIsEditTemplate = False
End Sub

Private Sub vsfgTable_KeyPress(Index As Integer, KeyAscii As Integer)
    Dim strKey As String
    If vsfgProperties.ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
        Select Case KeyAscii
        Case 2 'Ctrl + B
            strKey = "Bold"
        Case 9 'Ctrl + I
            strKey = "Italic"
        Case 21 'Ctrl + U
            strKey = "Underline"
        Case 12 'Ctrl + L
            strKey = "Left"
        Case 18 'Ctrl + R
            strKey = "Right"
        Case 3 'Ctrl + C
            strKey = "Center"
        Case 10 'Ctrl + J
            strKey = "Justify"
        Case 8 'Backspace
        Case Else
        End Select
        If strKey <> "" Then
            With tbrText.Buttons(strKey)
                Select Case .Style
                Case tbrCheck
                    If .Value = tbrPressed Then
                        .Value = tbrUnpressed
                    Else
                        .Value = tbrPressed
                    End If
                Case tbrButtonGroup
                    .Value = tbrPressed
                End Select
            End With
            tbrText_ButtonClick tbrText.Buttons(strKey)
        End If
    End If
End Sub

Private Sub vsfgTable_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Local Error Resume Next
    Dim lngHeight As Long, lngLeft As Long, lngTop As Long, lngWidth As Long, ColInc As Long
    If Index = mlngCrntArrInc Then
        With vsfgTable(Index)
            If .ColIsVisible(.MouseCol) And .RowIsVisible(.MouseRow) And vsfgProperties.ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
                lngHeight = .RowHeight(.MouseRow)
                lngWidth = .ColWidth(.MouseCol)
                lngTop = .RowPos(.MouseRow)
                lngLeft = .ColPos(.MouseCol)
                If X >= lngLeft + lngWidth - 20 And X <= lngLeft + lngWidth + 20 _
                    And Y > lngTop - 50 And Y < lngTop + lngHeight And Button <> vbLeftButton Then
                    mlngResizeCol = .MouseCol
                    .MousePointer = flexSizeEW
                ElseIf Y >= lngTop + lngHeight - 20 And Y <= lngTop + lngHeight + 20 _
                    And X > lngLeft - 50 And X < lngLeft + lngWidth And Button <> vbLeftButton Then
                    mlngResizeRow = .MouseRow
                    .MousePointer = flexSizeNS
                Else
                    If Button <> vbLeftButton Then
                        .MousePointer = flexDefault
                    End If
                End If
            Else
                .MousePointer = flexDefault
            End If
        End With
    End If
End Sub

Private Sub vsfgTable_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    picDesigner.MousePointer = vbDefault
    On Local Error Resume Next
    Dim lngLeft As Long, lngWidth As Long
    Dim lngTop As Long, lngHeight As Long
    If Index = mlngCrntArrInc Then
        With vsfgTable(Index)
            Select Case .MousePointer
            Case flexSizeEW
                lngWidth = .ColWidth(mlngResizeCol) - 15
                lngLeft = .ColPos(mlngResizeCol)
                If lngLeft >= (X + 70) Then
                    .ColWidth(mlngResizeCol) = 0
                Else
                    .ColWidth(mlngResizeCol) = (X + 70) - lngLeft
                End If
                .MousePointer = flexDefault
            Case flexSizeNS
                lngHeight = .RowHeight(mlngResizeRow) - 15
                lngTop = .RowPos(mlngResizeRow)
                If lngTop >= (Y + 70) Then
                    .RowHeight(mlngResizeRow) = 0
                Else
                    .RowHeight(mlngResizeRow) = (Y + 70) - lngTop
                End If
                .MousePointer = flexDefault
            Case Else
                If Button = vbRightButton And vsfgProperties.ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
                    PopupMenu MDIFormMain.mnuPopupReportDesigner
                End If
            End Select
        End With
    End If
End Sub

Private Sub vsfgTable_SelChange(Index As Integer)
    On Local Error Resume Next
    With tbrText
        'Selecting Bold , Italic  and Undierline Tool Bar Buttons
        .Buttons("Bold").Value = IIf(vsfgTable(Index).CellFontBold, tbrPressed, tbrUnpressed)
        .Buttons("Italic").Value = IIf(vsfgTable(Index).CellFontItalic, tbrPressed, tbrUnpressed)
        .Buttons("Underline").Value = IIf(vsfgTable(Index).CellFontUnderline, tbrPressed, tbrUnpressed)
        'Seleting Left, Right, Center and Justify Tool bar Buttons
        Select Case vsfgTable(Index).CellAlignment
        Case flexAlignLeftBottom, flexAlignLeftCenter, flexAlignLeftTop
            .Buttons("Left").Value = tbrPressed
        Case flexAlignRightBottom, flexAlignRightCenter, flexAlignRightTop
            .Buttons("Right").Value = tbrPressed
        Case flexAlignCenterBottom, flexAlignCenterCenter, flexAlignCenterTop
            .Buttons("Center").Value = tbrPressed
        End Select
        If Not IsNull(vsfgTable(Index).CellFontName) Then
            cmbFontName.Text = vsfgTable(Index).CellFontName
        End If
        If Not IsNull(vsfgTable(Index).CellFontSize) Then
            cmbFontSize.Text = Round(vsfgTable(Index).CellFontSize, 0)
        End If
    End With
End Sub

Private Sub VSSpell1_Checking(Cancel As Integer)
    On Local Error Resume Next
    'provide user feedback while checking long text
    Static iPct%, iPctPrev%
    iPct = Int(100 * VSSpell1.SelStart / Len(VSSpell1.Text))
    If iPct <> iPctPrev Then
        iPctPrev = iPct
    End If
End Sub

Private Sub VSSpell1_Complete(Cancelled As Integer)
    If Cancelled Then
        MsgBox "Spelling Check Cancelled." & vbCrLf & vbCrLf & "Words per minute: " & VSSpell1.WordsPerMinute
    Else
        MsgBox "Spelling Check Completed." & vbCrLf & vbCrLf & "Words per minute: " & VSSpell1.WordsPerMinute
    End If
End Sub
 
Private Sub SpellCheck(ByVal lnghWnd As Long)
    Screen.MousePointer = vbHourglass
    VSSpell1.SelStart = 0
    VSSpell1.CheckWindow (mctrlSelected.hWnd)
    Screen.MousePointer = vbDefault
End Sub

Private Sub VSThesaurus1_Changed()
    On Local Error Resume Next
    mctrlSelected.SelText = VSThesaurus1.ChangedWord
End Sub

Public Function ShowOpen(Optional ByVal lngReportID As Long = 0) As Boolean
    Dim strRslt As String
    If lngReportID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpReports, "WHERE ISNULL(RPT.PeriodID, " & mlngPeriodID & ") = " & mlngPeriodID, "XReportID", , tbrDesigner)
        If strRslt <> "-1" Then
            mlngReportID = Val(strRslt)
            txtReportName.Tag = mlngReportID
        End If
    Else
        strRslt = lngReportID
        mlngReportID = lngReportID
        txtReportName.Tag = mlngReportID
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        mblnInShowOpen = True
        ShowOpen = ValueCollect(mlngReportID)
        ShowOpen = True
        mblnInShowOpen = False
    End Select
End Function

Private Sub ShowReport(ByRef crptTmp As clsReports)
    Dim lngPageCount As Long, ObjInc As Long
    Dim RowInc As Long, ColInc As Long, ctrlControl As Control
    Dim strPicFileName As String
    lngPageCount = 1
    SetComboBoundValue cmbPaperSize, IIf(crptTmp.PaperSize <= 0, pprA4, crptTmp.PaperSize)
    txtMarginLeft.Text = ConvertToRealUnit(crptTmp.MarginLeft)
    txtMarginTop.Text = ConvertToRealUnit(crptTmp.MarginTop)
    txtMarginRight.Text = ConvertToRealUnit(crptTmp.MarginRight)
    txtMarginBottom.Text = ConvertToRealUnit(crptTmp.MarginBottom)
    If crptTmp.Orientation = 0 Then
        optPortrait.Value = True
    Else
        optLandscape.Value = True
    End If
    mcgPageProperties.TextMatrix(1, grdPgPrpOrientation) = crptTmp.Orientation
    For ObjInc = 1 To crptTmp.ObjectCount
        Select Case Val(crptTmp.ObjectProperty(ObjInc, rptObjTypeID))
        Case objtpPageBreak
            lngPageCount = lngPageCount + 1
            With mcgPageProperties
                .Cols = cnstPgPrpCount
                .Rows = lngPageCount + 1
                .TextMatrix(lngPageCount, grdPgPrpPaperSize) = Val(crptTmp.ObjectProperty(ObjInc, rptObjPaperSize))
                .TextMatrix(lngPageCount, grdPgPrpMarginBottom) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom)))
                .TextMatrix(lngPageCount, grdPgPrpMarginLeft) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft)))
                .TextMatrix(lngPageCount, grdPgPrpMarginRight) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginRight)))
                .TextMatrix(lngPageCount, grdPgPrpMarginTop) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginTop)))
                .TextMatrix(lngPageCount, grdPgPrpOrientation) = Val(crptTmp.ObjectProperty(ObjInc, rptObjOrientation))
            End With
        End Select
        If LoadObject(GetReportObjectName(Val(crptTmp.ObjectProperty(ObjInc, rptObjTypeID))), ctrlControl) Then
            LoadObjectProperties ctrlControl, crptTmp, ObjInc, False
            With mcgPageProperties
                .Cols = cnstPgPrpCount
                .Rows = lngPageCount + 1
                .TextMatrix(lngPageCount, grdPgPrpPaperSize) = Val(crptTmp.ObjectProperty(ObjInc, rptObjPaperSize))
                .TextMatrix(lngPageCount, grdPgPrpMarginBottom) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom)))
                .TextMatrix(lngPageCount, grdPgPrpMarginLeft) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft)))
                .TextMatrix(lngPageCount, grdPgPrpMarginRight) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginRight)))
                .TextMatrix(lngPageCount, grdPgPrpMarginTop) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginTop)))
                .TextMatrix(lngPageCount, grdPgPrpOrientation) = Val(crptTmp.ObjectProperty(ObjInc, rptObjOrientation))
            End With
            ctrlControl.Tag = lngPageCount
            LoadObjectData ctrlControl, crptTmp, ObjInc
            If lngPageCount = 1 Then
                ctrlControl.Visible = True
            Else
                ctrlControl.Visible = False
            End If
        End If
    Next ObjInc
    mlngPageCount = lngPageCount
    lblPageCount.Caption = "of " & mlngPageCount
End Sub

Private Function ValueCollect(ByVal lngReportID As Long) As Boolean
    On Local Error GoTo Err_Exit
    Dim crptTmp As New clsReports
    Screen.MousePointer = vbHourglass
    ClearValues False, True
    crptTmp.ValueCollect lngReportID
    txtReportName = crptTmp.ReportName
    chkTemplate.Value = IIf(crptTmp.ReportTypeID = rptTypeTemplate, vbChecked, vbUnchecked)
    '-----------------
    ShowReport crptTmp
    '-----------------
'    SetComboBoundValue cmbPaperSize, IIf(crptTmp.PaperSize <= 0, pprA4, crptTmp.PaperSize)
'    txtMarginLeft.Text = ConvertToRealUnit(crptTmp.MarginLeft)
'    txtMarginTop.Text = ConvertToRealUnit(crptTmp.MarginTop)
'    txtMarginRight.Text = ConvertToRealUnit(crptTmp.MarginRight)
'    txtMarginBottom.Text = ConvertToRealUnit(crptTmp.MarginBottom)
'    If crptTmp.Orientation = 0 Then
'        optPortrait.Value = True
'    Else
'        optLandscape.Value = True
'    End If
'    mcgPageProperties.TextMatrix(1, grdPgPrpOrientation) = crptTmp.Orientation
'    For ObjInc = 1 To crptTmp.ObjectCount
'        Select Case Val(crptTmp.ObjectProperty(ObjInc, rptObjTypeID))
'        Case objtpPageBreak
'            lngPageCount = lngPageCount + 1
'            With mcgPageProperties
'                .Cols = cnstPgPrpCount
'                .Rows = lngPageCount + 1
'                .TextMatrix(lngPageCount, grdPgPrpPaperSize) = Val(crptTmp.ObjectProperty(ObjInc, rptObjPaperSize))
'                .TextMatrix(lngPageCount, grdPgPrpMarginBottom) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginLeft) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginRight) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginRight)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginTop) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginTop)))
'                .TextMatrix(lngPageCount, grdPgPrpOrientation) = Val(crptTmp.ObjectProperty(ObjInc, rptObjOrientation))
'            End With
'        End Select
'        If LoadObject(GetReportObjectName(Val(crptTmp.ObjectProperty(ObjInc, rptObjTypeID))), ctrlControl) Then
'            LoadObjectProperties ctrlControl, crptTmp, ObjInc, False
'            With mcgPageProperties
'                .Cols = cnstPgPrpCount
'                .Rows = lngPageCount + 1
'                .TextMatrix(lngPageCount, grdPgPrpPaperSize) = Val(crptTmp.ObjectProperty(ObjInc, rptObjPaperSize))
'                .TextMatrix(lngPageCount, grdPgPrpMarginBottom) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginBottom)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginLeft) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginLeft)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginRight) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginRight)))
'                .TextMatrix(lngPageCount, grdPgPrpMarginTop) = ConvertToRealUnit(Val(crptTmp.ObjectProperty(ObjInc, rptObjMarginTop)))
'                .TextMatrix(lngPageCount, grdPgPrpOrientation) = Val(crptTmp.ObjectProperty(ObjInc, rptObjOrientation))
'            End With
'            ctrlControl.Tag = lngPageCount
'            LoadObjectData ctrlControl, crptTmp, ObjInc
'            If lngPageCount = 1 Then
'                ctrlControl.Visible = True
'            Else
'                ctrlControl.Visible = False
'            End If
'        End If
'    Next ObjInc
'    mlngPageCount = lngPageCount
'    lblPageCount.Caption = "of " & mlngPageCount
    crptTmp.Clear
    Set crptTmp = Nothing
    tbrObjects_ButtonMenuClick tbrObjects.Buttons("Process Table").ButtonMenus("All")
    ValueCollect = True
    Screen.MousePointer = vbDefault
Exit Function
Err_Exit:
    ShowError
    crptTmp.Clear
    Set crptTmp = Nothing
    ValueCollect = False
    Screen.MousePointer = vbDefault
End Function

Private Function LoadObject(ByVal strCtrlType As String, ByRef ctrlControl As Control) As Boolean
    Dim objTmp As Object
    Select Case strCtrlType
    Case "Page Break"
    Case "Diagram"
    Case "Text"
        Set objTmp = rtbText
    Case "Picture"
        Set objTmp = imgPicture
    Case "Table"
        Set objTmp = vsfgTable
    Case "Line"
        Set objTmp = ulnLine
    Case "Rectangle"
        Set objTmp = ushpRectangle
    Case "Oval"
        Set objTmp = ushpOval
    End Select
    If objTmp Is Nothing Then
        LoadObject = False
    Else
        mlngMaxArrInc = mlngMaxArrInc + 1
        Load objTmp(mlngMaxArrInc)
        Set ctrlControl = objTmp(mlngMaxArrInc)
        Select Case strCtrlType
        Case "Text"
            ctrlControl.Text = ""
            SetAlignment ctrlControl.hWnd, ercParaJustify
        Case "Table"
            With ctrlControl
                .Cell(flexcpAlignment, 0, 0, .Rows - 1, .Cols - 1) = flexAlignLeftTop
            End With
        End Select
        ReDim Preserve mcgProperties(mlngMaxArrInc)
        ConfigurePropertyGridClass mlngMaxArrInc
        LoadObject = True
    End If
End Function

Private Sub LoadObjectProperties(ctrlControl As Control, ByRef crptProperies As clsReports, _
    ByVal ObjIndex As Long, ByVal blnIsFromProcessing As Boolean)
    Dim Inc As Long, lngBorderTypeID As Long
    Dim arrBorderTypesFields() As String, arrBorderTypes() As String
    With mcgProperties(ctrlControl.Index)
        If Not blnIsFromProcessing Then
            If ctrlControl.Name = "ulnLine" Then
                .TextMatrix(grdPropRowX1, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjX1)))
                .TextMatrix(grdPropRowY1, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjY1)))
                .TextMatrix(grdPropRowX2, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjX2)))
                .TextMatrix(grdPropRowY2, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjY2)))
            Else
                .TextMatrix(grdPropRowLeft, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjLeft)))
                .TextMatrix(grdPropRowTop, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjTop)))
                .TextMatrix(grdPropRowWidth, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjWidth)))
                .TextMatrix(grdPropRowHeight, grdPropColDisplay) = ConvertToRealUnit(Val(crptProperies.ObjectProperty(ObjIndex, rptObjHeight)))
            End If
            .TextMatrix(grdPropRowTblType, grdPropColDisplay) = crptProperies.ObjectProperty(ObjIndex, rptObjTableTypeName)
            .TextMatrix(grdPropRowTblType, grdPropColValue) = crptProperies.ObjectProperty(ObjIndex, rptObjTableTypeID)
            .TextMatrix(grdPropRowAcType, grdPropColDisplay) = crptProperies.ObjectProperty(ObjIndex, rptObjAcTypeName)
            .TextMatrix(grdPropRowAcType, grdPropColValue) = crptProperies.ObjectProperty(ObjIndex, rptObjAcTypeID)
        End If
        lngBorderTypeID = Val(crptProperies.ObjectProperty(ObjIndex, rptObjBorderTypeID))
        arrBorderTypes = Split(mstrComboListBorderTypes, "|")
        If lngBorderTypeID <= UBound(arrBorderTypes) Then
            arrBorderTypesFields = Split(arrBorderTypes(lngBorderTypeID), ";")
            If UBound(arrBorderTypesFields) >= 1 Then
                .TextMatrix(grdPropRowBorderType, grdPropColDisplay) = arrBorderTypesFields(1)
            End If
        End If
        .TextMatrix(grdPropRowBorderType, grdPropColValue) = lngBorderTypeID
        .TextMatrix(grdPropRowRows, grdPropColDisplay) = crptProperies.ObjectProperty(ObjIndex, rptObjNoOfRows)
        .TextMatrix(grdPropRowCols, grdPropColDisplay) = crptProperies.ObjectProperty(ObjIndex, rptObjNoOfCols)
        For Inc = 0 To .Rows - 1
            Select Case Inc
            Case grdPropRowTblType, grdPropRowAcType, grdPropRowBorderType
            Case Else
                .TextMatrix(Inc, grdPropColValue) = .TextMatrix(Inc, grdPropColDisplay)
            End Select
        Next Inc
        If Not blnIsFromProcessing Then
            If ctrlControl.Name = "ulnLine" Then
                ctrlControl.X1 = ConvertToBaseUnit(.ValueMatrix(grdPropRowX1, grdPropColValue))
                ctrlControl.Y1 = ConvertToBaseUnit(.ValueMatrix(grdPropRowY1, grdPropColValue))
                ctrlControl.X2 = ConvertToBaseUnit(.ValueMatrix(grdPropRowX2, grdPropColValue))
                ctrlControl.Y2 = ConvertToBaseUnit(.ValueMatrix(grdPropRowY1, grdPropColValue))
            Else
                ctrlControl.Left = ConvertToBaseUnit(.ValueMatrix(grdPropRowLeft, grdPropColValue))
                ctrlControl.Top = ConvertToBaseUnit(.ValueMatrix(grdPropRowTop, grdPropColValue))
                ctrlControl.Width = ConvertToBaseUnit(.ValueMatrix(grdPropRowWidth, grdPropColValue))
                ctrlControl.Height = ConvertToBaseUnit(.ValueMatrix(grdPropRowHeight, grdPropColValue))
            End If
        End If
        If ctrlControl.Name = "vsfgTable" Then
            ctrlControl.Rows = .ValueMatrix(grdPropRowRows, grdPropColValue)
            ctrlControl.Cols = .ValueMatrix(grdPropRowCols, grdPropColValue)
        End If
    End With
End Sub

Private Sub LoadObjectData(ctrlControl As Control, ByRef crptTmp As clsReports, ByVal ObjInc As Long)
    Dim RowInc As Long, ColInc As Long, strPicFileName As String
    Select Case Val(crptTmp.ObjectProperty(ObjInc, rptObjTypeID))
    Case objtpTable
        If Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfCols)) >= 0 Then
            ctrlControl.Cols = Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfCols))
        End If
        If Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfRows)) >= 0 Then
            ctrlControl.Rows = Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfRows))
        End If
        With crptTmp
            For RowInc = 0 To .ObjectTableRows(ObjInc) - 1
                For ColInc = 0 To .ObjectTableCols(ObjInc) - 1
                    ctrlControl.TextMatrix(RowInc, ColInc) = .ObjectTableCell(ObjInc, rptTblText, RowInc, ColInc)
                    If Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc)) > -1 Then
                        ctrlControl.Cell(flexcpBackColor, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc))
                    Else
                        ctrlControl.Cell(flexcpBackColor, RowInc, ColInc) = 0
                    End If
                    If Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc)) > -1 Then
                        ctrlControl.Cell(flexcpForeColor, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc))
                    Else
                        ctrlControl.Cell(flexcpForeColor, RowInc, ColInc) = 0
                    End If
                    If Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc)) > 0 Then
                        'ctrlControl.ColWidth(ColInc) = Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc)) / pcnstColWidthRatioFromGridToPrint
                        ctrlControl.ColWidth(ColInc) = Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc))
                    Else
                        'ctrlControl.ColWidth(ColInc) = 720
                    End If
                    ctrlControl.Cell(flexcpFontUnderline, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblUnderline, RowInc, ColInc))
                    ctrlControl.Cell(flexcpFontBold, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblIsBold, RowInc, ColInc))
                    If Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc)) > 0 Then
                        ctrlControl.Cell(flexcpFontSize, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc))
                    End If
                    ctrlControl.Cell(flexcpFontItalic, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblIsItalic, RowInc, ColInc))
                    If Val(.ObjectTableCell(ObjInc, rptTblAlignment, RowInc, ColInc)) > -1 Then
                        ctrlControl.Cell(flexcpAlignment, RowInc, ColInc) = GetFlexGridAlignment(Val(.ObjectTableCell(ObjInc, rptTblAlignment, RowInc, ColInc)))
                    End If
                    If .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc) <> "" Then
                        ctrlControl.Cell(flexcpFontName, RowInc, ColInc) = .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc)
                    End If
                    If Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc)) > 0 Then
                        'ctrlControl.RowHeight(RowInc) = Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc)) / pcnstRowHeightRatioFromGridToPrint
                        ctrlControl.RowHeight(RowInc) = Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc))
                    Else
                        'ctrlControl.RowHeight(RowInc) = 290
                        ctrlControl.AutoSizeMode = flexAutoSizeRowHeight
                        ctrlControl.AutoSize 0, ctrlControl.Cols - 1
                        'ctrlControl.RowHeight(RowInc) = 500
                    End If
                Next ColInc
            Next RowInc
        End With
    Case objtpPicture
        strPicFileName = App.Path & IIf(Right(App.Path, 1) = "\", "", "\") & "tmp.pic"
        crptTmp.ObjectProperty(ObjInc, rptObjPicture).SaveToFile strPicFileName, adSaveCreateOverWrite
        Set ctrlControl.Picture = LoadPicture(strPicFileName)
    Case objtpText
        ctrlControl.TextRTF = crptTmp.ObjectProperty(ObjInc, rptObjTextRtf)
    End Select
End Sub

Private Sub UnloadAllComponents()
    On Local Error Resume Next
    Dim cntrInc As Control
    For Each cntrInc In Controls
        Select Case cntrInc.Name
        Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
            If cntrInc.Index > 0 Then
                Unload cntrInc
            End If
        End Select
    Next cntrInc
    mlngCrntArrInc = 0
    mstrCrntCtrlType = ""
    Set mctrlSelected = Nothing
    mlngMaxArrInc = 0
End Sub

Private Sub SaveReportInClass(ByRef crTmp As clsReports, ByVal lngReportID As Long, ByVal strReportName As String)
    Dim ctrlInc As Control
    Dim PageInc As Long, RowInc As Long, ColInc As Long
    Dim lngPaperSize As Long, dblMarginLeft As Double, dblMarginRight As Double
    Dim dblMarginTop As Double, dblMarginBottom As Double, lngOrientation As Long
    Dim lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long
    Dim lngX1 As Long, lngX2 As Long, lngY1 As Long, lngY2 As Long
    Dim lngRow As Long, lngCol As Long
    With crTmp
        With mcgPageProperties
            lngPaperSize = .ValueMatrix(1, grdPgPrpPaperSize)
            dblMarginLeft = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginLeft))
            dblMarginRight = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginRight))
            dblMarginTop = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginTop))
            dblMarginBottom = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginBottom))
            lngOrientation = .ValueMatrix(1, grdPgPrpOrientation)
        End With
        .StartReport lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation, _
            mlngPeriodID, strReportName, lngReportID, IIf(chkTemplate.Value = vbChecked, rptTypeTemplate, rptTypeAuditReport)
        For PageInc = 1 To mlngPageCount
            With mcgPageProperties
                lngPaperSize = .ValueMatrix(PageInc, grdPgPrpPaperSize)
                dblMarginLeft = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginLeft))
                dblMarginRight = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginRight))
                dblMarginTop = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginTop))
                dblMarginBottom = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginBottom))
                lngOrientation = .ValueMatrix(PageInc, grdPgPrpOrientation)
            End With
            For Each ctrlInc In Controls
                Select Case ctrlInc.Name
                Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
                    If Val(ctrlInc.Tag) = PageInc Then
                        With ctrlInc
                            If .Name = "ulnLine" Then
                                lngX1 = .X1
                                lngX2 = .X2
                                lngY1 = .Y1
                                lngY2 = .Y2
                            Else
                                lngLeft = .Left
                                lngTop = .Top
                                lngWidth = .Width
                                lngHeight = .Height
                            End If
                        End With
                        Select Case ctrlInc.Name
                        Case "rtbText"
                            .CreateText ctrlInc.TextRTF, lngLeft, lngTop, lngWidth, lngHeight, "Text", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
                        Case "imgPicture"
                            .CreatePicture ctrlInc, lngLeft, lngTop, lngWidth, lngHeight, "Picture", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
                        Case "vsfgTable"
                            .StartTable ctrlInc.Left, lngTop, lngWidth, lngHeight, mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowTblType, grdPropColValue), mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowAcType, grdPropColValue), "Table", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation, mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowBorderType, grdPropColValue), mcgProperties(ctrlInc.Index).TextMatrix(grdPropRowTblType, grdPropColDisplay), mcgProperties(ctrlInc.Index).TextMatrix(grdPropRowAcType, grdPropColDisplay)
                            .TableRows = ctrlInc.Rows
                            .TableCols = ctrlInc.Cols
                            For RowInc = 0 To ctrlInc.Rows - 1
                                For ColInc = 0 To ctrlInc.Cols - 1
                                    .TableCell(rptTblText, RowInc, ColInc) = ctrlInc.TextMatrix(RowInc, ColInc)
                                    .TableCell(rptTblBackColor, RowInc, ColInc) = ctrlInc.Cell(flexcpBackColor, RowInc, ColInc)
                                    .TableCell(rptTblForeColor, RowInc, ColInc) = ctrlInc.Cell(flexcpForeColor, RowInc, ColInc)
                                    '.TableCell(rptTblColWidth, RowInc, ColInc) = ctrlInc.ColWidth(ColInc) * pcnstColWidthRatioFromGridToPrint
                                    .TableCell(rptTblColWidth, RowInc, ColInc) = ctrlInc.ColWidth(ColInc)
                                    .TableCell(rptTblUnderline, RowInc, ColInc) = ctrlInc.Cell(flexcpFontUnderline, RowInc, ColInc)
                                    .TableCell(rptTblIsBold, RowInc, ColInc) = ctrlInc.Cell(flexcpFontBold, RowInc, ColInc)
                                    .TableCell(rptTblFontSize, RowInc, ColInc) = ctrlInc.Cell(flexcpFontSize, RowInc, ColInc)
                                    .TableCell(rptTblIsItalic, RowInc, ColInc) = ctrlInc.Cell(flexcpFontItalic, RowInc, ColInc)
                                    .TableCell(rptTblAlignment, RowInc, ColInc) = GetPrintAlignment(ctrlInc.Cell(flexcpAlignment, RowInc, ColInc))
                                    .TableCell(rptTblFontName, RowInc, ColInc) = ctrlInc.Cell(flexcpFontName, RowInc, ColInc)
                                    '.TableCell(rptTblRowHeight, RowInc, ColInc) = ctrlInc.RowHeight(RowInc) * pcnstRowHeightRatioFromGridToPrint
                                    .TableCell(rptTblRowHeight, RowInc, ColInc) = ctrlInc.RowHeight(RowInc)
                                Next ColInc
                            Next RowInc
                            .EndTable
                        Case "ulnLine"
                            .CreateLine lngX1, lngY1, lngX2, lngY2, "Line", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
                        Case "ushpRectangle"
                            .CreateRectangle lngLeft, lngTop, lngWidth, lngHeight, "Rectangle", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
                        Case "ushpOval"
                            .CreateOval lngLeft, lngTop, lngWidth, lngHeight, "Rectangle", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
                        End Select
                    End If
                End Select
            Next ctrlInc
            If PageInc < mlngPageCount Then
                .CreatePageBreak "PageBreak"
            End If
        Next PageInc
    End With
End Sub

Private Sub Save(ByVal lngReportID As Long, ByVal strReportName As String)
    On Local Error GoTo Err_Exit
    Dim clsReports As New clsReports
    If strReportName = "" Then
        pMVE.MsgBox "Report Name can't be blank !", , , msgCritical, True
        tbrDesigner_ButtonClick tbrDesigner.Buttons("Options")
        txtReportName.SetFocus
    Else
        Screen.MousePointer = vbHourglass
'        With clsReports
'            With mcgPageProperties
'                lngPaperSize = .ValueMatrix(1, grdPgPrpPaperSize)
'                dblMarginLeft = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginLeft))
'                dblMarginRight = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginRight))
'                dblMarginTop = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginTop))
'                dblMarginBottom = ConvertToBaseUnit(.ValueMatrix(1, grdPgPrpMarginBottom))
'                lngOrientation = .ValueMatrix(1, grdPgPrpOrientation)
'            End With
'            .StartReport lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation, _
'                mlngPeriodID, strReportName, lngReportID, IIf(chkTemplate.Value = vbChecked, rptTypeTemplate, rptTypeAuditReport)
'            For PageInc = 1 To mlngPageCount
'                With mcgPageProperties
'                    lngPaperSize = .ValueMatrix(PageInc, grdPgPrpPaperSize)
'                    dblMarginLeft = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginLeft))
'                    dblMarginRight = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginRight))
'                    dblMarginTop = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginTop))
'                    dblMarginBottom = ConvertToBaseUnit(.ValueMatrix(PageInc, grdPgPrpMarginBottom))
'                    lngOrientation = .ValueMatrix(PageInc, grdPgPrpOrientation)
'                End With
'                For Each ctrlInc In Controls
'                    Select Case ctrlInc.Name
'                    Case "rtbText", "imgPicture", "vsfgTable", "ulnLine", "ushpRectangle", "ushpOval"
'                        If Val(ctrlInc.Tag) = PageInc Then
'                            With ctrlInc
'                                If .Name = "ulnLine" Then
'                                    lngX1 = .X1
'                                    lngX2 = .X2
'                                    lngY1 = .Y1
'                                    lngY2 = .Y2
'                                Else
'                                    lngLeft = .Left
'                                    lngTop = .Top
'                                    lngWidth = .Width
'                                    lngHeight = .Height
'                                End If
'                            End With
'                            Select Case ctrlInc.Name
'                            Case "rtbText"
'                                .CreateText ctrlInc.TextRTF, lngLeft, lngTop, lngWidth, lngHeight, "Text", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
'                            Case "imgPicture"
'                                .CreatePicture ctrlInc, lngLeft, lngTop, lngWidth, lngHeight, "Picture", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
'                            Case "vsfgTable"
'                                .StartTable ctrlInc.Left, lngTop, lngWidth, lngHeight, mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowTblType, grdPropColValue), mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowAcType, grdPropColValue), "Table", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation, mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowBorderType, grdPropColValue), mcgProperties(ctrlInc.Index).TextMatrix(grdPropRowTblType, grdPropColDisplay), mcgProperties(ctrlInc.Index).TextMatrix(grdPropRowAcType, grdPropColDisplay)
'                                .TableRows = ctrlInc.Rows
'                                .TableCols = ctrlInc.Cols
'                                For RowInc = 0 To ctrlInc.Rows - 1
'                                    For ColInc = 0 To ctrlInc.Cols - 1
'                                        .TableCell(rptTblText, RowInc, ColInc) = ctrlInc.TextMatrix(RowInc, ColInc)
'                                        .TableCell(rptTblBackColor, RowInc, ColInc) = ctrlInc.Cell(flexcpBackColor, RowInc, ColInc)
'                                        .TableCell(rptTblForeColor, RowInc, ColInc) = ctrlInc.Cell(flexcpForeColor, RowInc, ColInc)
'                                        .TableCell(rptTblColWidth, RowInc, ColInc) = ctrlInc.ColWidth(ColInc) * pcnstColWidthRatioFromGridToPrint
'                                        .TableCell(rptTblUnderline, RowInc, ColInc) = ctrlInc.Cell(flexcpFontUnderline, RowInc, ColInc)
'                                        .TableCell(rptTblIsBold, RowInc, ColInc) = ctrlInc.Cell(flexcpFontBold, RowInc, ColInc)
'                                        .TableCell(rptTblFontSize, RowInc, ColInc) = ctrlInc.Cell(flexcpFontSize, RowInc, ColInc)
'                                        .TableCell(rptTblIsItalic, RowInc, ColInc) = ctrlInc.Cell(flexcpFontItalic, RowInc, ColInc)
'                                        .TableCell(rptTblAlignment, RowInc, ColInc) = GetPrintAlignment(ctrlInc.Cell(flexcpAlignment, RowInc, ColInc))
'                                        .TableCell(rptTblFontName, RowInc, ColInc) = ctrlInc.Cell(flexcpFontName, RowInc, ColInc)
'                                        .TableCell(rptTblRowHeight, RowInc, ColInc) = ctrlInc.RowHeight(RowInc) * pcnstRowHeightRatioFromGridToPrint
'                                    Next ColInc
'                                Next RowInc
'                                .EndTable
'                            Case "ulnLine"
'                                .CreateLine lngX1, lngY1, lngX2, lngY2, "Line", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
'                            Case "ushpRectangle"
'                                .CreateRectangle lngLeft, lngTop, lngWidth, lngHeight, "Rectangle", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
'                            Case "ushpOval"
'                                .CreateOval lngLeft, lngTop, lngWidth, lngHeight, "Rectangle", lngPaperSize, dblMarginLeft, dblMarginTop, dblMarginRight, dblMarginBottom, lngOrientation
'                            End Select
'                        End If
'                    End Select
'                Next ctrlInc
'                If PageInc < mlngPageCount Then
'                    .CreatePageBreak "PageBreak"
'                End If
'            Next PageInc
'            .EndReport
'            mlngReportID = .ReportID
'        End With
        '-----------
        SaveReportInClass clsReports, lngReportID, strReportName
        clsReports.EndReport
        mlngReportID = clsReports.ReportID
        '-----------
        ShowAnimation
        Screen.MousePointer = vbDefault
    End If
    clsReports.Clear
    Set clsReports = Nothing
Exit Sub
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
End Sub

Private Sub vsfgProperties_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    On Local Error Resume Next
    With vsfgProperties
        Select Case Row
        Case grdPropRowLeft
            mctrlSelected.Left = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowWidth
            mctrlSelected.Width = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowTop
            mctrlSelected.Top = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowHeight
            mctrlSelected.Height = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowX1
            mctrlSelected.X1 = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowY1
            mctrlSelected.Y1 = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowX2
            mctrlSelected.X2 = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowY2
            mctrlSelected.Y2 = ConvertToBaseUnit(.ValueMatrix(Row, Col))
        Case grdPropRowTblType
            .TextMatrix(Row, grdPropColValue) = .ComboData(.ComboIndex)
            If .ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTCustomTable Then
                tbrText.Visible = True
            End If
        Case grdPropRowAcType
            .TextMatrix(Row, grdPropColValue) = .ComboData(.ComboIndex)
        Case grdPropRowBorderType
            .TextMatrix(Row, grdPropColValue) = .ComboData(.ComboIndex)
        Case grdPropRowRows
            mctrlSelected.Rows = .ValueMatrix(Row, Col)
        Case grdPropRowCols
            mctrlSelected.Cols = .ValueMatrix(Row, Col)
        End Select
    End With
    mcgProperties(mlngCrntArrInc).GetValuesFromGrid vsfgProperties
    ShowSelection False
End Sub

Private Sub vsfgProperties_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Dim Inc As Long, strComboList As String, sSql As String
    With vsfgProperties
        .ComboList = ""
        If Col = grdPropColName Then
            Cancel = True
        ElseIf .Cell(flexcpBackColor, Row, Col) = pclrRestrictionColor Then
            Cancel = True
        Else
            Select Case Row
            Case grdPropRowTblType
                .ComboList = mstrComboListTableTypes
            Case grdPropRowBorderType
                .ComboList = mstrComboListBorderTypes
            Case grdPropRowAcType
                sSql = "SELECT AcTypeID AS IDField, AcTypeName AS NameField FROM AcTypes WHERE CompanyID = " & mlngCompanyID & " ORDER BY AcTypeName"
                strComboList = SetComboList(, sSql)
                .ComboList = strComboList
            End Select
            Select Case Row
            Case grdPropRowTblType, grdPropRowAcType, grdPropRowBorderType
                For Inc = 0 To .ComboCount - 1
                    If .ComboData(Inc) = .TextMatrix(Row, grdPropColValue) Then
                        .ComboIndex = Inc
                        Exit For
                    End If
                Next Inc
            End Select
        End If
    End With
End Sub

Private Sub cmbProperties_Click()
    On Local Error Resume Next
    If Not mblnIsStartingUp Then
        FindControlFromControlName cmbProperties.Text
    End If
End Sub

Private Sub GenerateTableOfContent()
    On Local Error Resume Next
    Dim PageInc As Long, mcgTOC As New clsGrid, RowInc As Long, ctrlInc As Control
    Dim lngLineStart As Long, lngHeadingCharPos As Long, strHeadingLine As String
    With mcgTOC
        .Rows = 1
        .Cols = 2
        RowInc = 0
        .TextMatrix(RowInc, 1) = "Page"
        For PageInc = 1 To mlngPageCount
            For Each ctrlInc In Controls
                If ctrlInc.Name = "rtbText" Then
                    If RVal(ctrlInc.Tag) = PageInc Then
                        lngLineStart = 1
                        lngHeadingCharPos = InStr(lngLineStart, ctrlInc.Text, Chr(pcnstHeadingChar))
                        While lngHeadingCharPos <> 0
                            strHeadingLine = Mid(ctrlInc.Text, lngLineStart, lngHeadingCharPos - lngLineStart)
                            strHeadingLine = StrReverse(strHeadingLine)
                            lngLineStart = InStr(1, strHeadingLine, vbCr)
                            lngLineStart = lngHeadingCharPos - (lngLineStart - 2)
                            If lngLineStart = 0 Or lngLineStart > lngHeadingCharPos Then
                                lngLineStart = 1
                            End If
                            strHeadingLine = Mid(ctrlInc.Text, lngLineStart, lngHeadingCharPos - lngLineStart)
                            RowInc = RowInc + 1
                            .Rows = RowInc + 1
                            If InStr(1, UCase(strHeadingLine), "BALANCE SHEET") > 0 Then
                                .TextMatrix(RowInc, 0) = "Balance Sheet"
                            ElseIf InStr(1, UCase(strHeadingLine), "STATEMENT OF INCOME") > 0 Then
                                .TextMatrix(RowInc, 0) = "Statement of Income"
                            Else
                                .TextMatrix(RowInc, 0) = strHeadingLine
                            End If
                            .TextMatrix(RowInc, 1) = PageInc - 2 & "-" & mlngPageCount - 2
                            If RowInc > 1 Then
                                If .ValueMatrix(RowInc - 1, 1) + 1 < .ValueMatrix(RowInc, 1) Then
                                    .TextMatrix(RowInc - 1, 1) = .ValueMatrix(RowInc - 1, 1) & "-" & .ValueMatrix(RowInc, 1) - 1
                                Else
                                    .TextMatrix(RowInc - 1, 1) = .ValueMatrix(RowInc - 1, 1)
                                End If
                            End If
                            lngHeadingCharPos = InStr(lngHeadingCharPos + 1, ctrlInc.Text, Chr(pcnstHeadingChar))
                        Wend
                    End If
                End If
            Next ctrlInc
        Next PageInc
        For Each ctrlInc In Controls
            If ctrlInc.Name = "vsfgTable" Then
                If ctrlInc.Index > 0 Then
                    If mcgProperties(ctrlInc.Index).ValueMatrix(grdPropRowTblType, grdPropColValue) = rptTTTableOfContents Then
                        .SetValuesToGrid ctrlInc, , False
                        ctrlInc.Cell(flexcpAlignment, 0, 0, .Rows - 1, 0) = flexAlignLeftCenter
                        ctrlInc.ColWidth(0) = 8000
                        ctrlInc.ColWidth(1) = 1500
                        ctrlInc.Cell(flexcpFontBold, 0, 0, .Rows - 1, .Cols - 1) = True
                        ctrlInc.Cell(flexcpAlignment, 0, 1, .Rows - 1, 1) = flexAlignCenterCenter
                        ctrlInc.Cell(flexcpFontSize, 0, 0, .Rows - 1, .Cols - 1) = 13
                        For RowInc = 0 To .Rows - 1
                            ctrlInc.RowHeight(RowInc) = 600
                        Next RowInc
                    End If
                End If
            End If
        Next ctrlInc
    End With
End Sub

Private Sub ShowAnimation()
    Dim Inc As Long
    ushpAnimation.Visible = True
    ushpAnimation.Top = vsvpDesigner.Height - (vsvpDesigner.Top + 8000)
    ushpAnimation.Left = vsvpDesigner.Width - (vsvpDesigner.Left + 10000)
    For Inc = 10000 To 8000 Step -1
        ushpAnimation.Width = Inc
        ushpAnimation.Height = Inc
        ushpAnimation.Left = ushpAnimation.Left + 1
        ushpAnimation.Top = ushpAnimation.Top + 1
        DoEvents
    Next Inc
    ushpAnimation.Visible = False
End Sub

Private Sub vsvpDesigner_DragDrop(Source As Control, X As Single, Y As Single)
    picDesigner_DragDrop Source, X, Y
End Sub

Private Sub ReportChanged()
'    If Not mblnInShowOpen And Not mblnInFormLoad Then
'        Select Case mbtStackCrntArrIndex
'        Case 0, 7
'            mbtStackCrntArrIndex = 1
'        Case Else
'            mbtStackCrntArrIndex = mbtStackCrntArrIndex + 1
'        End Select
'        mcrStack(mbtStackCrntArrIndex).Clear
'        SaveReportInClass mcrStack(mbtStackCrntArrIndex), 0, ""
'    End If
End Sub

Private Sub ReportChangeUndo()
'    Select Case mbtStackCrntArrIndex
'    Case 0
'    Case Else
'        ShowReport mcrStack(mbtStackCrntArrIndex)
'        mbtStackCrntArrIndex = mbtStackCrntArrIndex - 1
'    End Select
End Sub
