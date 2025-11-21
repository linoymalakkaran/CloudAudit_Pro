VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmReportGenerator 
   Caption         =   "Generate Report"
   ClientHeight    =   8940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14850
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
   Icon            =   "frmReportGenerator.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8940
   ScaleWidth      =   14850
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog cdReport 
      Left            =   9315
      Top             =   6615
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin VB.PictureBox picLineSpacing 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1665
      Left            =   5595
      ScaleHeight     =   1635
      ScaleWidth      =   2970
      TabIndex        =   21
      Top             =   6480
      Visible         =   0   'False
      Width           =   3000
      Begin VB.Frame fraLineSpacing 
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
         Height          =   1305
         Left            =   15
         TabIndex        =   22
         Top             =   315
         Width           =   2940
         Begin VB.ComboBox cmbLineSpacing 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            ItemData        =   "frmReportGenerator.frx":000C
            Left            =   120
            List            =   "frmReportGenerator.frx":0022
            TabIndex        =   29
            Text            =   "Single"
            Top             =   330
            Width           =   1350
         End
         Begin VB.TextBox txtLineSpacing 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1545
            TabIndex        =   27
            Top             =   330
            Width           =   810
         End
         Begin VB.PictureBox picLineSpacing1 
            AutoRedraw      =   -1  'True
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Left            =   3570
            ScaleHeight     =   210
            ScaleWidth      =   465
            TabIndex        =   26
            Top             =   2295
            Visible         =   0   'False
            Width           =   525
         End
         Begin VB.CommandButton cmdLineSpacingOK 
            Caption         =   "&OK"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   780
            TabIndex        =   24
            Top             =   855
            Width           =   1005
         End
         Begin VB.CommandButton cmdLineSpacingCancel 
            Caption         =   "Cance&l"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1845
            TabIndex        =   23
            Top             =   855
            Width           =   1005
         End
         Begin RichTextLib.RichTextBox rtbLineSpacing 
            Height          =   480
            Left            =   4005
            TabIndex        =   25
            Top             =   2340
            Visible         =   0   'False
            Width           =   765
            _ExtentX        =   1349
            _ExtentY        =   847
            _Version        =   393217
            TextRTF         =   $"frmReportGenerator.frx":005E
         End
         Begin MSComCtl2.UpDown udLineSpacing 
            Height          =   315
            Left            =   2356
            TabIndex        =   28
            Top             =   330
            Width           =   240
            _ExtentX        =   423
            _ExtentY        =   556
            _Version        =   393216
            OrigLeft        =   1861
            OrigTop         =   945
            OrigRight       =   2101
            OrigBottom      =   1350
            Max             =   1000
            Enabled         =   -1  'True
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Line Spacing:"
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
            Left            =   120
            TabIndex        =   32
            Top             =   105
            Width           =   975
         End
         Begin VB.Label Label19 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "At:"
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
            Left            =   1545
            TabIndex        =   31
            Top             =   105
            Width           =   195
         End
         Begin VB.Image imgLineSpacing 
            Height          =   165
            Left            =   3030
            Stretch         =   -1  'True
            Top             =   2340
            Width           =   330
         End
         Begin VB.Label lblLineSpacingPt 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "pt"
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
            Left            =   2685
            TabIndex        =   30
            Top             =   390
            Width           =   135
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
         TabIndex        =   33
         Top             =   45
         Width           =   1050
      End
   End
   Begin VB.PictureBox picTemplate 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2490
      Left            =   0
      ScaleHeight     =   2460
      ScaleWidth      =   5475
      TabIndex        =   9
      Top             =   6465
      Visible         =   0   'False
      Width           =   5505
      Begin VB.Frame fraTemplate 
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
         Height          =   2130
         Left            =   15
         TabIndex        =   10
         Top             =   315
         Width           =   5445
         Begin VB.ComboBox cmbTemplate 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   855
            TabIndex        =   17
            Top             =   45
            Width           =   4545
         End
         Begin VB.CommandButton cmdTemplateCancel 
            Caption         =   "Cance&l"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   4395
            TabIndex        =   16
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateSave 
            Caption         =   "&Save"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   3315
            TabIndex        =   15
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateCopy 
            Caption         =   "&Copy"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   45
            TabIndex        =   14
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateDelete 
            Caption         =   "&Delete"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   2235
            TabIndex        =   13
            Top             =   1740
            Width           =   1005
         End
         Begin VB.CommandButton cmdTemplateNew 
            Caption         =   "&New"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1185
            TabIndex        =   12
            Top             =   1740
            Width           =   1005
         End
         Begin RichTextLib.RichTextBox rtbTemplate 
            Height          =   1290
            Left            =   45
            TabIndex        =   11
            Top             =   390
            Width           =   5355
            _ExtentX        =   9446
            _ExtentY        =   2275
            _Version        =   393217
            ScrollBars      =   2
            TextRTF         =   $"frmReportGenerator.frx":00E4
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Templates"
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
            Left            =   45
            TabIndex        =   18
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
         TabIndex        =   19
         Top             =   45
         Width           =   780
      End
   End
   Begin MSComctlLib.ImageList imglstDesigner 
      Left            =   12495
      Top             =   1620
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   51
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":0160
            Key             =   "Left"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":033A
            Key             =   "Right"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":0514
            Key             =   "Bold"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":06EE
            Key             =   "BringToFront"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":08C8
            Key             =   "Center"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":0AA2
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":0C7C
            Key             =   "Cut"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":0E56
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1030
            Key             =   "Font"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":120A
            Key             =   "Grammar"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":13E4
            Key             =   "Table"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":15BE
            Key             =   "Italic"
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1798
            Key             =   "Justify"
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1972
            Key             =   "Line"
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1B4C
            Key             =   "Preview"
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1D26
            Key             =   "Oval"
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1F00
            Key             =   "Paste"
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":20DA
            Key             =   "Picture"
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":22B4
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":248E
            Key             =   "Rectangle"
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2668
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2842
            Key             =   "Select"
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2A1C
            Key             =   "SendToBack"
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2BF6
            Key             =   "Spelling"
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2DD0
            Key             =   "Text"
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":2FAA
            Key             =   "Underline"
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3184
            Key             =   "Properties"
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":335E
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":34B8
            Key             =   "First"
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3692
            Key             =   "Previous"
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":386C
            Key             =   "Next"
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3A46
            Key             =   "Last"
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3C20
            Key             =   "New Page"
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3DFA
            Key             =   "Delete Page"
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":3FD4
            Key             =   "New"
            Object.Tag             =   "New"
         EndProperty
         BeginProperty ListImage36 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":41AE
            Key             =   "Options"
            Object.Tag             =   "Options"
         EndProperty
         BeginProperty ListImage37 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":6960
            Key             =   "Page Setup"
            Object.Tag             =   "Page Setup"
         EndProperty
         BeginProperty ListImage38 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":6B3A
            Key             =   "Save As"
         EndProperty
         BeginProperty ListImage39 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":6C94
            Key             =   "Delete Object"
         EndProperty
         BeginProperty ListImage40 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":C486
            Key             =   "Process Table"
            Object.Tag             =   "Process Table"
         EndProperty
         BeginProperty ListImage41 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":C8D8
            Key             =   "Fore Color"
         EndProperty
         BeginProperty ListImage42 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":CA32
            Key             =   "Back Color"
         EndProperty
         BeginProperty ListImage43 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":CB8C
            Key             =   "Find"
            Object.Tag             =   "Find"
         EndProperty
         BeginProperty ListImage44 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":CD66
            Key             =   "Increase Indent"
            Object.Tag             =   "Increase Indent"
         EndProperty
         BeginProperty ListImage45 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":CF40
            Key             =   "Decrease Indent"
            Object.Tag             =   "Decrease Indent"
         EndProperty
         BeginProperty ListImage46 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":D11A
            Key             =   "Design"
            Object.Tag             =   "Design"
         EndProperty
         BeginProperty ListImage47 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":D2F4
            Key             =   "Template"
            Object.Tag             =   "Template"
         EndProperty
         BeginProperty ListImage48 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":D4CE
            Key             =   "Line Spacing"
            Object.Tag             =   "Line Spacing"
         EndProperty
         BeginProperty ListImage49 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":D6A8
            Key             =   "Change Case"
            Object.Tag             =   "Change Case"
         EndProperty
         BeginProperty ListImage50 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":D882
            Key             =   "Tags"
            Object.Tag             =   "Tags"
         EndProperty
         BeginProperty ListImage51 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":DA5C
            Key             =   "Refresh"
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog cdlgDesigner 
      Left            =   12480
      Top             =   510
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.ImageList imglstConfigure 
      Left            =   13065
      Top             =   525
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":DBB6
            Key             =   "Down"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":E008
            Key             =   "Left"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":E45A
            Key             =   "Right"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":E8AC
            Key             =   "Up"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":ECFE
            Key             =   "Add"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":F150
            Key             =   "Remove"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrConfigure 
      Height          =   3450
      Left            =   8160
      TabIndex        =   4
      Top             =   375
      Width           =   1290
      _ExtentX        =   2275
      _ExtentY        =   6085
      ButtonWidth     =   2275
      ButtonHeight    =   1005
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstConfigure"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Add"
            Key             =   "Add"
            Object.ToolTipText     =   "Add"
            Object.Tag             =   "Add"
            ImageKey        =   "Add"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Remove"
            Key             =   "Remove"
            Object.ToolTipText     =   "Remove"
            Object.Tag             =   "Remove"
            ImageKey        =   "Remove"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Up"
            Key             =   "Up"
            Object.ToolTipText     =   "Up"
            Object.Tag             =   "Up"
            ImageKey        =   "Up"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Down"
            Key             =   "Down"
            Object.ToolTipText     =   "Down"
            Object.Tag             =   "Down"
            ImageKey        =   "Down"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Right"
            Key             =   "Right"
            Object.ToolTipText     =   "Right"
            Object.Tag             =   "Right"
            ImageKey        =   "Right"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Left"
            Key             =   "Left"
            Object.ToolTipText     =   "Left"
            Object.Tag             =   "Left"
            ImageKey        =   "Left"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTable 
      Height          =   690
      Left            =   0
      TabIndex        =   2
      Top             =   5220
      Visible         =   0   'False
      Width           =   12330
      _cx             =   21749
      _cy             =   1217
      Appearance      =   0
      BorderStyle     =   1
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
      Rows            =   20
      Cols            =   10
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"frmReportGenerator.frx":F5A2
      ScrollTrack     =   0   'False
      ScrollBars      =   3
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
   Begin RichTextLib.RichTextBox rtbText 
      Height          =   990
      Left            =   0
      TabIndex        =   1
      Top             =   4200
      Visible         =   0   'False
      Width           =   12330
      _ExtentX        =   21749
      _ExtentY        =   1746
      _Version        =   393217
      BorderStyle     =   0
      Enabled         =   -1  'True
      HideSelection   =   0   'False
      ScrollBars      =   2
      AutoVerbMenu    =   -1  'True
      TextRTF         =   $"frmReportGenerator.frx":F61C
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgConfigure 
      Height          =   3390
      Left            =   0
      TabIndex        =   0
      Top             =   405
      Width           =   8130
      _cx             =   14340
      _cy             =   5980
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
      BackColorBkg    =   -2147483643
      BackColorAlternate=   -2147483643
      GridColor       =   16775905
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
      GridLines       =   0
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   1
      Cols            =   11
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmReportGenerator.frx":F6A0
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
      OutlineBar      =   2
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
      Begin VB.Frame fraCustomTable 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
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
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   4350
         TabIndex        =   34
         Top             =   1965
         Visible         =   0   'False
         Width           =   3435
         Begin VB.CommandButton cmdRowsColsApply 
            Caption         =   "Apply"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   270
            Left            =   2685
            TabIndex        =   39
            Top             =   -30
            Width           =   690
         End
         Begin VB.TextBox txtRows 
            Appearance      =   0  'Flat
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
            Height          =   285
            Left            =   570
            MaxLength       =   2
            TabIndex        =   36
            Text            =   "00"
            Top             =   -15
            Width           =   195
         End
         Begin VB.TextBox txtCols 
            Appearance      =   0  'Flat
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
            Height          =   285
            Left            =   1275
            MaxLength       =   2
            TabIndex        =   35
            Text            =   "00"
            Top             =   -15
            Width           =   210
         End
         Begin VB.ComboBox cmbBorderType 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            ItemData        =   "frmReportGenerator.frx":F808
            Left            =   1455
            List            =   "frmReportGenerator.frx":F80A
            TabIndex        =   40
            Top             =   -60
            Width           =   1155
         End
         Begin VB.Label Label1 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Rows :"
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
            Left            =   30
            TabIndex        =   38
            Top             =   -15
            Width           =   495
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Cols :"
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
            Left            =   855
            TabIndex        =   37
            Top             =   -15
            Width           =   390
         End
      End
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgList 
      Height          =   3390
      Left            =   9465
      TabIndex        =   3
      Top             =   405
      Width           =   2865
      _cx             =   5054
      _cy             =   5980
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
      GridColor       =   16775905
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
      GridLines       =   0
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   14
      Cols            =   3
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmReportGenerator.frx":F80C
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
   Begin MSComctlLib.Toolbar tbrText 
      Height          =   330
      Left            =   0
      TabIndex        =   6
      Top             =   3855
      Width           =   12330
      _ExtentX        =   21749
      _ExtentY        =   582
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "imglstDesigner"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   26
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
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Increase Indent"
            Description     =   "Increase Indent"
            Object.ToolTipText     =   "Increase Indent"
            Object.Tag             =   "Increase Indent"
            ImageKey        =   "Increase Indent"
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Decrease Indent"
            Description     =   "Decrease Indent"
            Object.ToolTipText     =   "Decrease Indent"
            Object.Tag             =   "Decrease Indent"
            ImageKey        =   "Decrease Indent"
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "View Template"
            Object.ToolTipText     =   "View Template"
            Object.Tag             =   "View Template"
            ImageKey        =   "Template"
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Modify Template"
            Object.ToolTipText     =   "Modify Template"
            Object.Tag             =   "Modify Template"
            ImageKey        =   "Design"
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Tags"
            Description     =   "Tags"
            Object.ToolTipText     =   "Tags"
            Object.Tag             =   "Tags"
            ImageKey        =   "Tags"
            Style           =   5
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Change Case"
            Description     =   "Change Case"
            Object.ToolTipText     =   "Change Case"
            Object.Tag             =   "Change Case"
            ImageKey        =   "Change Case"
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
      Begin VB.ComboBox cmbFontSize 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "frmReportGenerator.frx":F9C0
         Left            =   4725
         List            =   "frmReportGenerator.frx":F9F4
         TabIndex        =   8
         Top             =   0
         Width           =   570
      End
      Begin VB.ComboBox cmbFontName 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2625
         TabIndex        =   7
         Top             =   0
         Width           =   2100
      End
   End
   Begin MSComctlLib.Toolbar tbrDesigner 
      Height          =   330
      Left            =   0
      TabIndex        =   20
      Top             =   0
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
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Open"
            Object.ToolTipText     =   "Open"
            Object.Tag             =   "Open"
            ImageKey        =   "Open"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Refresh"
            Object.ToolTipText     =   "Refresh"
            Object.Tag             =   "Refresh"
            ImageKey        =   "Refresh"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save"
            Object.ToolTipText     =   "Save"
            Object.Tag             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Save As"
            Object.ToolTipText     =   "Save As"
            Object.Tag             =   "Save As"
            ImageKey        =   "Save As"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
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
      EndProperty
      Begin VB.CheckBox chkFinalIssued 
         Caption         =   "Final Issued"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   4320
         TabIndex        =   42
         Top             =   0
         Width           =   1335
      End
      Begin VB.CheckBox chkDraftIssued 
         Caption         =   "Draft Issued"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2640
         TabIndex        =   41
         Top             =   0
         Width           =   1335
      End
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   12480
      TabIndex        =   43
      Top             =   8400
      Width           =   2400
      _ExtentX        =   4233
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
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   9600
      Top             =   7320
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
            Picture         =   "frmReportGenerator.frx":FA36
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":FB90
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":FD6A
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":FF44
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReportGenerator.frx":1009E
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox VSSpell1 
      Height          =   480
      Left            =   12960
      ScaleHeight     =   420
      ScaleWidth      =   1140
      TabIndex        =   44
      Top             =   1170
      Width           =   1200
   End
   Begin VB.Label lblMain 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Select one of the subentries in the list."
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   2625
      TabIndex        =   5
      Top             =   6000
      Width           =   6240
   End
End
Attribute VB_Name = "frmReportGenerator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Dim mlngPeriodID As Long
Dim mblnIsEditTemplate As Boolean, mctrlSelControl As Control
Dim mstrComboListTableTypes As String
Dim mlngResizeCol As Long, mlngResizeRow As Long
Dim mcgTagValue As New clsGrid

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID & " AND UserID = " & pUserID
        With GetRecords(sSql1)
            If Not .EOF Then
                If .Fields("IsBlocked") = True Then
                    IsReadOnly = True
                Else
                    IsReadOnly = False
                End If
            Else
'                IsReadOnly = True
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

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    vsfgConfigure.Enabled = blnNewValue
    vsfgList.Enabled = blnNewValue
    tbrConfigure.Enabled = blnNewValue
    tbrText.Enabled = blnNewValue
    tbrDesigner.Enabled = blnNewValue
    chkDraftIssued.Enabled = blnNewValue
    chkFinalIssued.Enabled = blnNewValue
End Property

Private Sub chkDraftIssued_Click()
    SaveDraftIssued
End Sub

Private Sub chkFinalIssued_Click()
    SaveFinalIssued
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

Private Sub cmbLineSpacing_Change()
    Select Case cmbLineSpacing.Text
        Case "At least", "Exactly"
            lblLineSpacingPt.Visible = True
        Case Else
            lblLineSpacingPt.Visible = False
    End Select
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
    SetLineSpacing mctrlSelControl.hWnd, lsrLineSpacing, lngCustomLineSpacing
    picLineSpacing.Visible = False
End Sub

Private Sub cmdRowsColsApply_Click()
    vsfgTable.Rows = RVal(txtRows.Text)
    vsfgTable.Cols = RVal(txtCols.Text)
    vsfgTable.Tag = GetComboBoundValue(cmbBorderType)
    vsfgTable_AfterEdit 0, 0
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = vbCtrlMask Then
        Select Case KeyCode
            Case vbKeyS
                Dim cgRptObjs As New clsGrid
                cgRptObjs.GetValuesFromGrid vsfgConfigure
                SaveReportGenerate cgRptObjs, mlngPeriodID
                cgRptObjs.Clear
            Case vbKeyO
                If pMVE.MsgBox("Are you sure to open report again? You may loose any unsaved data.", msgYesNo, "AuditMate") Then
                    ValueCollectReportGenerate vsfgConfigure, mlngPeriodID
                End If
        End Select
    End If
End Sub

Private Sub PopulateObjectTypes()
On Local Error Resume Next
Dim Inc As Long, sSql As String
    vsfgList.Rows = 1
    Inc = 0
    sSql = "SELECT * FROM AuditReportObjectTypes ORDER BY ObjTypeID"
    With GetRecords(sSql)
        While Not .EOF
            Inc = Inc + 1
            vsfgList.Rows = Inc + 1
            vsfgList.TextMatrix(Inc, 0) = !ObjTypeName
            vsfgList.TextMatrix(Inc, 1) = !ObjTypeID
            vsfgList.TextMatrix(Inc, 2) = !ObjType
            Select Case !ObjType
                Case "Main"
                    vsfgList.Cell(flexcpFontBold, Inc, 0) = True
                Case "Sub"
                    vsfgList.Cell(flexcpFontBold, Inc, 0) = True
            End Select
            .MoveNext
        Wend
        .Close
    End With
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim sSql As String, sSql1 As String
    ButtonHandling Me
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID & " AND UserID = " & pUserID
        With GetRecords(sSql1)
            If Not .EOF Then
                If .Fields("IsBlocked") = True Then
                    tbrCtrls.Buttons("Modify").Enabled = False
                Else
                    tbrCtrls.Buttons("Modify").Enabled = True
                End If
            Else
                tbrCtrls.Buttons("Modify").Enabled = False
            End If
            .Close
        End With
    sSql = "Select DraftIssued, FinalIssued From AuditReportObjects Where PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            chkDraftIssued = IIf(.Fields("DraftIssued") & "" = True, 1, 0)
            chkFinalIssued = IIf(.Fields("FinalIssued") & "" = True, 1, 0)
        End If
    End With
    PopulateObjectTypes
    rtbText.Text = ""
    SetAlignment rtbText.hWnd, ercParaJustify
    vsfgTable.BorderStyle = flexBorderNone
    PopulateFonts cmbFontName
    rtbText.Height = 5000
    'Undo redo
    Dim lStyle As Long
    '// required to 'reveal' multiple undo
    '// set rich text box style
    lStyle = TM_RICHTEXT Or TM_MULTILEVELUNDO Or TM_MULTICODEPAGE
    SendMessageLong rtbText.hWnd, EM_SETTEXTMODE, lStyle, 0
    sSql = "SELECT TableTypeID AS IDField, 'Table - ' + TableTypeName AS NameField FROM TableTypes ORDER BY TableTypeID"
    mstrComboListTableTypes = SetComboList(, sSql)
    PopulateBorderTypes
End Sub

Private Sub PopulateBorderTypes()
    With cmbBorderType
        .Clear
        .AddItem "None"
        .ItemData(.ListCount - 1) = "0"
        .AddItem "Bottom"
        .ItemData(.ListCount - 1) = "1"
        .AddItem "Top"
        .ItemData(.ListCount - 1) = "2"
        .AddItem "Top Bottom"
        .ItemData(.ListCount - 1) = "3"
        .AddItem "Box"
        .ItemData(.ListCount - 1) = "4"
        .AddItem "Columns"
        .ItemData(.ListCount - 1) = "5"
        .AddItem "Col Top Bottom"
        .ItemData(.ListCount - 1) = "6"
        .AddItem "All"
        .ItemData(.ListCount - 1) = "7"
        .AddItem "Box Rows"
        .ItemData(.ListCount - 1) = "8"
        .AddItem "Box Columns"
        .ItemData(.ListCount - 1) = "9"
        .AddItem "Below Header"
        .ItemData(.ListCount - 1) = "10"
        .AddItem "Rows"
        .ItemData(.ListCount - 1) = "11"
    End With
End Sub

Private Function IsMainTitleAlreadyExists(ByVal lngID As Long) As Boolean
Dim Inc As Long
    IsMainTitleAlreadyExists = False
    With vsfgConfigure
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdConfigureObjTypeID) = lngID And .TextMatrix(Inc, grdConfigureType) = "Main" Then
                IsMainTitleAlreadyExists = True
                Exit For
            End If
        Next Inc
    End With
End Function

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    If pMVE.MsgBox("Save and Close?", msgYesNo, "AuditMate") Then
        Save
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    mcgTagValue.Clear
    Set mcgTagValue = Nothing
End Sub

Private Sub rtbText_Change()
    With vsfgConfigure
        If Trim(rtbText.Text) = "" Then
            .TextMatrix(.Row, grdConfigureData) = ""
        Else
            .TextMatrix(.Row, grdConfigureData) = rtbText.TextRTF
        End If
    End With
End Sub

Private Sub rtbText_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = vbShiftMask And KeyCode = vbKeyF7 Then
'        VSThesaurus1.CheckWord = rtbText.SelText
    End If
End Sub

Private Sub rtbText_KeyPress(KeyAscii As Integer)
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
            If rtbText.SelLength <= 0 Then
                strKey = "Center"
            End If
        Case 10 'Ctrl + J
            strKey = "Justify"
        Case 8 'Backspace
        Case Else
            With rtbText
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

Private Sub rtbText_SelChange()
    ChangeSelection rtbText, Me
End Sub

Private Sub tbrConfigure_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If chkFinalIssued.Value = 1 Then
        tbrConfigure.Enabled = False
    End If
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub tbrDesigner_ButtonClick(ByVal Button As MSComctlLib.Button)
On Local Error GoTo Err_Exit
Dim cgRptObjs As New clsGrid, strFileName As String
Dim IncRow As Long, IncCol As Long
    SetParentSlNo
    cgRptObjs.GetValuesFromGrid vsfgConfigure
    Select Case Button.Key
        Case "Save"
            Save
        Case "Save As"
            With cdReport
                .FileName = "Report1.erf"
                .Filter = "*.erf"
                .ShowSave
                strFileName = .FileName
            End With
            cgRptObjs.SaveToFile strFileName
        Case "Open"
            cgRptObjs.SetValuesToGrid vsfgConfigure
            With cdReport
                .FileName = "Report1.erf"
                .Filter = "*.erf"
                .ShowOpen
                strFileName = .FileName
            End With
            cgRptObjs.LoadFromFile strFileName
            ValueCollectReportGenerate vsfgConfigure, mlngPeriodID, cgRptObjs
        Case "Refresh"
'            If pMVE.MsgBox("Are you sure to restore last saved report? You may loose any unsaved data.", msgYesNo) Then
'                ValueCollectReportGenerate vsfgConfigure, mlngPeriodID
'            End If
'            For IncRow = 1 To vsfgConfigure.Rows - 1
'                For IncCol = 0 To vsfgConfigure.Cols - 1
'                    vsfgConfigure_AfterRowColChange 0, 0, IncRow, IncCol
'                Next IncCol
'            Next IncRow
        Case "Preview"
            PrintReportGenerate pvtPreview, mCompanyID, mlngPeriodID, mcgTagValue, , vsfgConfigure.Row, cgRptObjs
        Case "Print"
            Save
            PrintReportGenerate pvtPrint, mCompanyID, mlngPeriodID, mcgTagValue
    End Select
    cgRptObjs.Clear
    Set cgRptObjs = Nothing
Exit Sub
Err_Exit:
    If Err.Number <> 32755 Then
        ShowError
    End If
    cgRptObjs.Clear
    Set cgRptObjs = Nothing
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
        Case "Find"
        Case "Increase Indent", "Decrease Indent"
            ChangeSelAttributes rptTblText, Button.Key
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
            picTemplate.Left = Left
            picTemplate.Width = Width - 260
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
            picTemplate.Top = Height + Top - (picTemplate.Height + 270)
            picTemplate.Visible = True
    End Select
End Sub

Private Sub tbrText_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
On Local Error Resume Next
Dim lngSelStartTmp As Long, lngSelLengthTmp As Long
Dim lngSelStart As Long, lngSelLength As Long, strText As String
Dim lngCustomLineSpcing As Long, lsrLineSpacing As LineSpacingRules
    Select Case ButtonMenu.Parent.Key
        Case "Tags", "Change Case"
            ChangeSelAttributes rptTblText, ButtonMenu.Parent.Key, ButtonMenu
        Case Else
            With ActiveControl.Buttons("Line Spacing")
                .ButtonMenus("LS1.0") = "  1.0"
                .ButtonMenus("LS1.5") = "  1.5"
                .ButtonMenus("LS2.0") = "  2.0"
            End With
            Select Case ButtonMenu.Key
                Case "LS1.0"
                    'SetLineSpacing ActiveControl.hWnd, lnspSingle
                    SetLineSpacing ActiveControl.hWnd, lnspCustom3, 1 * 20
                    ButtonMenu = "* 1.0"
                Case "LS1.5"
                    'SetLineSpacing ActiveControl.hWnd, lnspOneAndAHalf
                    SetLineSpacing ActiveControl.hWnd, lnspCustom3, 1.5 * 20
                    ButtonMenu = "* 1.5"
                Case "LS2.0"
                    'SetLineSpacing ActiveControl.hWnd, lnspDouble
                    SetLineSpacing ActiveControl.hWnd, lnspCustom3, 2 * 20
                    ButtonMenu = "* 2.0"
                Case "More"
                    lsrLineSpacing = GetLineSpacing(ActiveControl.hWnd, lngCustomLineSpcing)
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
                ShowSubWindow picLineSpacing, tbrText, "Line Spacing"
            End Select
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

Private Sub SpellCheck(ByVal lnghWnd As Long)
'    Screen.MousePointer = vbHourglass
'    VSSpell1.SelStart = 0
'    VSSpell1.CheckWindow (rtbText.hWnd)
'    Screen.MousePointer = vbDefault
End Sub

Private Sub ChangeSelAttributes(ByVal rtpSelChangeProperty As ReportTableProperties, Optional ByVal strKey As String = "", _
                                Optional ByRef ButtonMenu As MSComctlLib.ButtonMenu = Nothing)
On Local Error Resume Next
Dim lngSelStartOld As Long, lngSelLengthOld As Long, lngSelStartNew As Long
Dim blnProtected As Boolean, strSelControlType As String
    strSelControlType = IIf(mctrlSelControl.Name = "rtbText", "Text", "Table")
    With mctrlSelControl
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
                    If .Visible Then
                        lngSelStartOld = .SelStart
                        lngSelLengthOld = .SelLength
                        .SelText = pcnstTagStart & ButtonMenu.Text & pcnstTagEnd
                        lngSelStartNew = .SelStart
                        .SelStart = lngSelStartOld
                        .SelLength = Abs(lngSelStartNew - lngSelStartOld)
                    Else
                        ActiveControl.Text = ActiveControl.Text & pcnstTagStart & ButtonMenu.Text & pcnstTagEnd
                    End If
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
                    .CellAlignment = flexAlignLeftCenter
                ElseIf tbrText.Buttons("Right").Value Then
                    .CellAlignment = flexAlignRightCenter
                ElseIf tbrText.Buttons("Center").Value Then
                    .CellAlignment = flexAlignCenterCenter
                ElseIf tbrText.Buttons("Justify").Value Then
                    .CellAlignment = flexAlignLeftCenter
                End If
            Case rptTblText
                Select Case strKey
                Case "Cut"
                    Clipboard.SetText .Text
                    .Text = ""
                Case "Copy"
                    'Clipboard.SetText .Text
                    Clipboard.SetText vsfgConfigure.TextMatrix(vsfgConfigure.Row, grdConfigureData)
                Case "Paste"
                    '.Text = Clipboard.GetText
                    vsfgConfigure.TextMatrix(vsfgConfigure.Row, grdConfigureData) = Clipboard.GetText
                    Dim ctTmp As New clsTable
                    ctTmp.SetGridData vsfgConfigure.TextMatrix(vsfgConfigure.Row, grdConfigureData)
                    ctTmp.SetValuesToGrid vsfgTable
                    ctTmp.Clear
                    Set ctTmp = Nothing
                Case "Spelling"
                    SpellCheck .EditWindow 'Enabling the spell checking
                End Select
            End Select
            vsfgTable_AfterEdit 0, 0
        End Select
    End With
End Sub

Private Function GetReportTableTypeID(ByVal rgObjTypeID As ReportGeneratorObjectTypes) As ReportTableTypes
    Select Case rgObjTypeID
        Case RGObjTableOfContents
            GetReportTableTypeID = rptTTTableOfContents
        Case RGObjBalanceSheet
            GetReportTableTypeID = rptTTBalanceSheet
        Case RGObjStatementOfIncome
            GetReportTableTypeID = rptTTProfitAndLoss
        Case RGObjShareholdersEquity
            GetReportTableTypeID = rptTTEquitySchedule
        Case RGObjCashFlows
            GetReportTableTypeID = rptTTCashFlow
        Case Else
            GetReportTableTypeID = 0
    End Select
End Function

Private Function GetReportTableTypeName(ByVal rptTable As ReportTableTypes) As String
    Select Case rptTable
        Case rptTTTableOfContents
            GetReportTableTypeName = "Table of Contents"
        Case rptTTBalanceSheet
            GetReportTableTypeName = "Balance Sheet"
        Case rptTTProfitAndLoss
            GetReportTableTypeName = "Profit and Loss"
        Case rptTTEquitySchedule
            GetReportTableTypeName = "Equity Schedule"
        Case rptTTCashFlow
            GetReportTableTypeName = "Cash Flow"
    End Select
End Function

Private Sub AddItem(ByVal strTitle As String, ByVal rgObjTypeID As ReportGeneratorObjectTypes, _
                    ByVal strRowType As String, ByVal lngLevel As Long, Optional ByVal rttTableTypeID As ReportTableTypes = 0)
Dim Inc As Long, lnglstRow As Long
    lnglstRow = vsfgList.Row
    If strRowType = "Main" And vsfgList.TextMatrix(lnglstRow, grdConfigureType) = "Main" _
        And IsMainTitleAlreadyExists(vsfgList.ValueMatrix(lnglstRow, grdConfigureObjTypeID)) Then
        pMVE.MsgBox "Title '" & vsfgList.TextMatrix(lnglstRow, grdConfigureTitle) & "' already added.", , "AuditMate"
    Else
        With vsfgConfigure
            If .Row = .Rows - 1 Then
                .Rows = .Rows + 1
                .Row = .Rows - 1
            Else
                .AddItem "", .Row
            End If
            Inc = .Row
            .TextMatrix(Inc, grdConfigureTitle) = strTitle
            .TextMatrix(Inc, grdConfigureObjTypeID) = rgObjTypeID
            .TextMatrix(Inc, grdConfigureType) = strRowType
            .TextMatrix(Inc, grdConfigureTableID) = rttTableTypeID
            SetLevel vsfgConfigure, Inc, lngLevel
            .IsSubtotal(Inc) = True
            Select Case strRowType
            Case "Main"
                .Cell(flexcpFontBold, Inc, 0, Inc, .Cols - 1) = True
                .TextMatrix(Inc, grdConfigureDescription) = vsfgList.TextMatrix(lnglstRow, grdConfigureTitle)
                'Header
                Select Case rgObjTypeID
                    Case RGObjCommonPageHeader, RGObjTableOfContents, RGObjBalanceSheet, RGObjStatementOfIncome, _
                        RGObjShareholdersEquity, RGObjCashFlows, RGObjNotesToTheFinancialStatements
                        AddItem "Header", RGObjHeader, "Object", lngLevel + 1
                End Select
                'Table
                Select Case rgObjTypeID
                    Case RGObjTableOfContents, RGObjBalanceSheet, RGObjStatementOfIncome, _
                        RGObjShareholdersEquity, RGObjCashFlows, RGObjNotesToTheFinancialStatements
                        AddItem "Table", RGObjTable, "Object", lngLevel + 1, GetReportTableTypeID(rgObjTypeID)
                End Select
                'Text
                Select Case rgObjTypeID
                    Case RGObjFrontPage, RGObjIndependentAuditorsReport, RGObjBalanceSheet, RGObjStatementOfIncome, _
                        RGObjShareholdersEquity, RGObjCashFlows, RGObjNotesToTheFinancialStatements
                        AddItem "Text", RGObjText, "Object", lngLevel + 1
                End Select
                RefreshTables rptTTTableOfContents, 0, ""
            Case "Sub"
                .Cell(flexcpFontBold, Inc, 0, Inc, .Cols - 1) = True
                .TextMatrix(Inc, grdConfigureDescription) = vsfgList.TextMatrix(lnglstRow, grdConfigureTitle)
            Case "Object"
                If rgObjTypeID = RGObjTable Then
                    .TextMatrix(Inc, grdConfigureTitle) = .TextMatrix(Inc, grdConfigureTitle) & " - " & _
                        GetReportTableTypeName(rttTableTypeID)
                    RefreshTables rptTTTableOfContents, 0, ""
                End If
            End Select
        End With
    End If
End Sub

Private Sub tbrConfigure_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Inc As Long, ColInc As Long
    Select Case Button.Key
        Case "Add"
            With vsfgList
                AddItem .TextMatrix(.Row, grdConfigureTitle), .ValueMatrix(.Row, grdConfigureObjTypeID), .TextMatrix(.Row, grdConfigureType), 0
            End With
        Case "Remove"
            If vsfgConfigure.Row > 0 Then
                vsfgConfigure.RemoveItem vsfgConfigure.Row
            End If
        Case "Up"
            With vsfgConfigure
                Inc = .Row
                If Inc > 1 Then
                    .AddItem "", Inc - 1
                    .Row = Inc - 1
                    For ColInc = 0 To .Cols - 1
                        .TextMatrix(.Row, ColInc) = .TextMatrix(Inc + 1, ColInc)
                        .Cell(flexcpFontBold, .Row, ColInc) = .Cell(flexcpFontBold, Inc + 1, ColInc)
                        .Cell(flexcpFontItalic, .Row, ColInc) = .Cell(flexcpFontItalic, Inc + 1, ColInc)
                    Next ColInc
                    SetLevel vsfgConfigure, .Row
                    .RemoveItem Inc + 1
                    vsfgConfigure_AfterRowColChange 0, 0, .Row, .Col
                End If
            End With
        Case "Down"
            With vsfgConfigure
                Inc = .Row
                If Inc < .Rows - 1 Then
                    If Inc = .Rows - 2 Then
                        .Rows = .Rows + 1
                    Else
                        .AddItem "", Inc + 2
                    End If
                    .Row = Inc + 2
                    For ColInc = 0 To .Cols - 1
                        .TextMatrix(.Row, ColInc) = .TextMatrix(Inc, ColInc)
                        .Cell(flexcpFontBold, .Row, ColInc) = .Cell(flexcpFontBold, Inc, ColInc)
                        .Cell(flexcpFontItalic, .Row, ColInc) = .Cell(flexcpFontItalic, Inc, ColInc)
                    Next ColInc
                    SetLevel vsfgConfigure, .Row
                    .RemoveItem Inc
                    If .Row < .Rows - 1 Then
                        .Row = .Row - 1
                    End If
                End If
            End With
        Case "Left"
            SetLevel vsfgConfigure, vsfgConfigure.Row, -1
        Case "Right"
            SetLevel vsfgConfigure, vsfgConfigure.Row, 1
    End Select
End Sub

Private Sub RefreshTables(ByVal rptTableType As ReportTableTypes, ByVal lngAcTypeID As Long, ByVal strNoteNo As String)
On Local Error Resume Next
Dim crptTmp As clsReports, ctblTmp As New clsTable, cgTmp As New clsGrid, Inc As Long
    Screen.MousePointer = vbHourglass
    With vsfgConfigure
        Select Case rptTableType
            Case rptTTCustomTable, rptTTSchedules
            Case rptTTTableOfContents
                cgTmp.GetValuesFromGrid vsfgConfigure
                PrintReportGenerate pvtTesting, mCompanyID, mlngPeriodID, mcgTagValue, ctblTmp, , cgTmp
            Case rptTTBalanceSheet
                Set crptTmp = PrintBalanceSheet(mlngPeriodID, False)
            Case rptTTCashFlow
                Set crptTmp = PrintCashFlow(mlngPeriodID, False)
            Case rptTTProfitAndLoss
                Set crptTmp = PrintProfitLoss(mlngPeriodID, False)
            Case rptTTGeneralSchedule
                Set crptTmp = PrintGeneralSchedules(mlngPeriodID, lngAcTypeID, False)
            Case rptTTSplitSchedule
                Set crptTmp = PrintSplitSchedules(mlngPeriodID, lngAcTypeID, False)
            Case rptTTEquitySchedule
                Set crptTmp = PrintShareholdersEquity(mlngPeriodID, False)
            Case rptTTFixedAssetsSchedule
                Set crptTmp = PrintFixedAssetSchedules(mlngPeriodID, False)
            Case rptTTLiabilitySchedule
                Set crptTmp = PrintLiabilitySchedules(mlngPeriodID, lngAcTypeID, False)
            Case rptTTCashEquivalents
                Set crptTmp = PrintCashEquivalentSchedule(mlngPeriodID, lngAcTypeID, False)
        End Select
        Select Case rptTableType
            Case rptTTTableOfContents, rptTTCustomTable, rptTTSchedules
            Case Else
                LoadTableDataFromReportClass ctblTmp, crptTmp, crptTmp.ObjectCount
        End Select
        For Inc = 1 To .Rows - 1
            If rptTableType <> rptTTCustomTable And .ValueMatrix(Inc, grdConfigureObjTypeID) = RGObjTable _
                And .ValueMatrix(Inc, grdConfigureTableID) = rptTableType _
                And .ValueMatrix(Inc, grdConfigureAcTypeID) = lngAcTypeID _
                And (.TextMatrix(Inc, grdConfigureDescription) = strNoteNo Or strNoteNo = "") Then
                If rptTableType = rptTTSchedules Then
                    Set crptTmp = PrintSchedules(.TextMatrix(Inc, grdConfigureDescription), mlngPeriodID, False)
                    LoadTableDataFromReportClass ctblTmp, crptTmp, crptTmp.ObjectCount
                End If
                vsfgConfigure.TextMatrix(Inc, grdConfigureData) = ctblTmp.GetGridData
            End If
        Next Inc
    End With
    ctblTmp.Clear
    Set ctblTmp = Nothing
    crptTmp.Clear
    Set crptTmp = Nothing
    cgTmp.Clear
    Set cgTmp = Nothing
    Screen.MousePointer = vbDefault
End Sub

Private Sub LoadTableDataFromReportClass(ctblTmp As clsTable, ByRef crptTmp As clsReports, ByVal ObjInc As Long)
On Local Error GoTo Err_Exit
Dim RowInc As Long, ColInc As Long
    If Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfCols)) >= 0 Then
        ctblTmp.Cell(rptTblCols) = Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfCols))
    End If
    If Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfRows)) >= 0 Then
        ctblTmp.Cell(rptTblRows) = Val(crptTmp.ObjectProperty(ObjInc, rptObjNoOfRows))
    End If
    With crptTmp
        For RowInc = 0 To .ObjectTableRows(ObjInc) - 1
            For ColInc = 0 To .ObjectTableCols(ObjInc) - 1
                ctblTmp.Cell(rptTblText, RowInc, ColInc) = .ObjectTableCell(ObjInc, rptTblText, RowInc, ColInc)
                If Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc)) > -1 Then
                    ctblTmp.Cell(rptTblBackColor, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblBackColor, RowInc, ColInc))
                Else
                    ctblTmp.Cell(rptTblBackColor, RowInc, ColInc) = 0
                End If
                If Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc)) > -1 Then
                    ctblTmp.Cell(rptTblForeColor, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblForeColor, RowInc, ColInc))
                Else
                    ctblTmp.Cell(rptTblForeColor, RowInc, ColInc) = 0
                End If
                If Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc)) > 0 Then
                    ctblTmp.Cell(rptTblColWidth, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblColWidth, RowInc, ColInc))
                End If
                ctblTmp.Cell(rptTblUnderline, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblUnderline, RowInc, ColInc))
                ctblTmp.Cell(rptTblIsBold, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblIsBold, RowInc, ColInc))
                If Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc)) > 0 Then
                    ctblTmp.Cell(rptTblFontSize, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblFontSize, RowInc, ColInc))
                End If
                ctblTmp.Cell(rptTblIsItalic, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblIsItalic, RowInc, ColInc))
                If Val(.ObjectTableCell(ObjInc, rptTblAlignment, RowInc, ColInc)) > -1 Then
                    ctblTmp.Cell(rptTblAlignment, RowInc, ColInc) = GetFlexGridAlignment(Val(.ObjectTableCell(ObjInc, rptTblAlignment, RowInc, ColInc)))
                End If
                If .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc) <> "" Then
                    ctblTmp.Cell(rptTblFontName, RowInc, ColInc) = .ObjectTableCell(ObjInc, rptTblFontName, RowInc, ColInc)
                End If
                If Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc)) > 0 Then
                    ctblTmp.Cell(rptTblRowHeight, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblRowHeight, RowInc, ColInc))
                End If
                ctblTmp.Cell(rptTblColSpan, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblColSpan, RowInc, ColInc))
                ctblTmp.Cell(rptTblRowSpan, RowInc, ColInc) = Val(.ObjectTableCell(ObjInc, rptTblRowSpan, RowInc, ColInc))
            Next ColInc
        Next RowInc
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgConfigure_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    With vsfgConfigure
        If .ValueMatrix(Row, grdConfigureObjTypeID) = RGObjTable Then
            Select Case Col
                Case grdConfigureTitle
                    .TextMatrix(Row, grdConfigureTableID) = .ComboData(.ComboIndex)
                Case grdConfigureDescription
                    .TextMatrix(Row, grdConfigureAcTypeID) = .ComboData(.ComboIndex)
                    .TextMatrix(Row, grdConfigureAcTypeName) = .TextMatrix(Row, grdConfigureDescription)
            End Select
        End If
    End With
End Sub

Private Sub vsfgConfigure_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
On Local Error Resume Next
    With vsfgConfigure
        fraCustomTable.Visible = False
        rtbText.Visible = False
        vsfgTable.Visible = False
        lblMain.Visible = False
        Select Case .TextMatrix(NewRow, grdConfigureType)
            Case "Main"
                lblMain.Visible = True
            Case "Object", "Sub"
                Select Case .TextMatrix(NewRow, grdConfigureObjTypeID)
                Case RGObjHeader, RGObjText, RGObjSubHeading
                    rtbText.TextRTF = .TextMatrix(NewRow, grdConfigureData)
                    rtbText.Visible = True
                    rtbText.Height = 5500
                    Set mctrlSelControl = rtbText
                    'Update Items rtbText
                Case RGObjTable
                    vsfgTable.Visible = True
                    vsfgTable.Top = rtbText.Top
                    vsfgTable.Height = 5500
                    Set mctrlSelControl = vsfgTable
                    RefreshTables .ValueMatrix(NewRow, grdConfigureTableID), .ValueMatrix(NewRow, grdConfigureAcTypeID), .TextMatrix(NewRow, grdConfigureDescription)
                    If .TextMatrix(NewRow, grdConfigureData) <> "" Then
                        Dim ctTable As New clsTable
                        ctTable.SetGridData .TextMatrix(NewRow, grdConfigureData)
                        ctTable.SetValuesToGrid vsfgTable
                        ctTable.Clear
                        Set ctTable = Nothing
                        SetOrientation NewRow
                        SetSubHeading NewRow
                    Else
                        If .ValueMatrix(NewRow, grdConfigureTableID) = rptTTCustomTable Then
                            vsfgTable.Rows = 5
                            vsfgTable.Cols = 4
                        End If
                    End If
                    txtRows.Text = vsfgTable.Rows
                    txtCols.Text = vsfgTable.Cols
                    SetComboBoundValue cmbBorderType, RVal(vsfgTable.Tag)
            End Select
        End Select
    End With
End Sub

Private Sub SetParentSlNo()
On Local Error Resume Next
Dim Inc As Long, arrLevel() As Long
    With vsfgConfigure
        For Inc = 1 To .Rows - 1
            ReDim Preserve arrLevel(.RowOutlineLevel(Inc))
            arrLevel(.RowOutlineLevel(Inc)) = Inc
            If .RowOutlineLevel(Inc) = 0 Then
                .TextMatrix(Inc, grdConfigureParentSlNo) = ""
            Else
                .TextMatrix(Inc, grdConfigureParentSlNo) = arrLevel(.RowOutlineLevel(Inc) - 1)
            End If
            If .ValueMatrix(Inc, grdConfigureObjTypeID) = RGObjTable Then
                If .ValueMatrix(Inc, grdConfigureParentSlNo) <> 0 Then
                    .TextMatrix(.ValueMatrix(Inc, grdConfigureParentSlNo), grdConfigureOrientation) _
                        = .ValueMatrix(Inc, grdConfigureOrientation)
                End If
            Else
                .TextMatrix(Inc, grdConfigureOrientation) = orPortrait
            End If
        Next Inc
    End With
End Sub

Private Sub SetOrientation(ByVal lngRow As Long)
Dim ocOrientation As VSPrinter8LibCtl.OrientationSettings, dblWidth As Double, Inc As Long
    dblWidth = 0
    For Inc = 0 To vsfgTable.Cols - 1
        dblWidth = vsfgTable.ColWidth(Inc) + dblWidth
    Next Inc
    If dblWidth > 11000 Then
        ocOrientation = orLandscape
    Else
        ocOrientation = orPortrait
    End If
    vsfgConfigure.TextMatrix(lngRow, grdConfigureOrientation) = ocOrientation
    SetParentSlNo
End Sub

Private Sub SetSubHeading(ByVal lngRow As Long)
Dim Inc As Long, strSubHeading As String
    With vsfgConfigure
        Select Case .ValueMatrix(lngRow, grdConfigureTableID)
            Case rptTTCashEquivalents, rptTTEquitySchedule, rptTTFixedAssetsSchedule, _
                 rptTTGeneralSchedule, rptTTLiabilitySchedule, rptTTSplitSchedule, rptTTSchedules
                If vsfgTable.Rows >= 1 Then
                    If .ValueMatrix(lngRow, grdConfigureTableID) = rptTTFixedAssetsSchedule _
                        Or vsfgTable.TextMatrix(0, 0) <> "" Then
                        strSubHeading = vsfgTable.TextMatrix(0, 0) & "    " & vsfgTable.TextMatrix(0, 1)
                    Else
                        strSubHeading = vsfgTable.TextMatrix(1, 0) & "    " & vsfgTable.TextMatrix(1, 1)
                    End If
                End If
        End Select
        For Inc = lngRow To 1 Step -1
            If .TextMatrix(Inc, grdConfigureType) = "Sub" Then
                If strSubHeading <> "" Then
                    .TextMatrix(Inc, grdConfigureDescription) = strSubHeading
                End If
                Exit For
            End If
        Next Inc
    End With
End Sub

Private Sub vsfgConfigure_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error Resume Next
Dim Inc As Long, strComboList As String, sSql As String
    If chkFinalIssued.Value = 1 Then
        vsfgConfigure.Editable = flexEDNone
        rtbText.Enabled = False
        vsfgTable.Editable = flexEDNone
    End If
    With vsfgConfigure
        Select Case vsfgConfigure.TextMatrix(Row, grdConfigureType)
        Case "Main", "Sub"
            If Col = grdConfigureDescription Then
                .ComboList = ""
            Else
                Cancel = True
            End If
        Case Else
            If .TextMatrix(Row, grdConfigureObjTypeID) = RGObjTable Then
                Select Case Col
                    Case grdConfigureTitle
                        .ComboList = mstrComboListTableTypes
                    Case grdConfigureDescription
                        Select Case .ValueMatrix(Row, grdConfigureTableID)
                            Case rptTTCustomTable
                                fraCustomTable.Left = .CellLeft
                                fraCustomTable.Top = .CellTop
                                fraCustomTable.Width = .CellWidth
                                fraCustomTable.Visible = True
                                Cancel = True
                            Case rptTTTableOfContents, rptTTBalanceSheet, rptTTFixedAssetsSchedule, _
                                rptTTCashFlow, rptTTProfitAndLoss, rptTTCashEquivalents, rptTTEquitySchedule
                                Cancel = True
                            Case rptTTSchedules
                                .ComboList = ""
                            Case Else
                                sSql = "SELECT AcTypeID AS IDField, AcTypeDescription AS NameField FROM AcTypes WHERE CompanyID = " & mCompanyID & " ORDER BY AcTypeDescription"
                                strComboList = SetComboList(, sSql)
                                .ComboList = strComboList
                        End Select
                    Case Else
                        Cancel = True
                End Select
                Select Case Col
                    Case grdConfigureTitle, grdConfigureDescription
                        For Inc = 0 To .ComboCount - 1
                            If .ComboData(Inc) = .TextMatrix(Row, Col) Then
                                .ComboIndex = Inc
                                Exit For
                            End If
                        Next Inc
                End Select
            Else
                Cancel = True
            End If
        End Select
    End With
End Sub

Private Sub vsfgConfigure_BeforeScroll(ByVal OldTopRow As Long, ByVal OldLeftCol As Long, ByVal NewTopRow As Long, ByVal NewLeftCol As Long, Cancel As Boolean)
    fraCustomTable.Visible = False
End Sub

Private Sub vsfgConfigure_Click()
'Dim sSql As String
'    sSql = "Select DraftIssued, FinalIssued From AuditReportObjects Where PeriodID = " & pActivePeriodID
'    With GetRecords(sSql)
'        If Not .EOF Then
'            chkDraftIssued = IIf(.Fields("DraftIssued") & "" = True, 1, 0)
'            chkFinalIssued = IIf(.Fields("FinalIssued") & "" = True, 1, 0)
'        End If
'    End With
End Sub

Private Sub vsfgList_DblClick()
    If chkFinalIssued.Value = 1 Then
        vsfgList.Editable = flexEDNone
        Exit Sub
    End If
    tbrConfigure_ButtonClick tbrConfigure.Buttons("Add")
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

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal lngNewValue As Long)
    mCompanyID = lngNewValue
End Property

Public Property Get PeriodID() As Long
    PeriodID = mlngPeriodID
End Property

Public Property Let PeriodID(ByVal lngNewValue As Long)
    mlngPeriodID = lngNewValue
    PopulateReportTags mcgTagValue, mCompanyID, mlngPeriodID, tbrText.Buttons("Tags")
    ValueCollectReportGenerate vsfgConfigure, mlngPeriodID
End Property

Public Sub UpdateItems()
'    Dim bCanUndo As Boolean
'    '// Undo/Redo options:
'    bCanUndo = CanUndo(rtbText)
'    MDIFormMain.mnuReportEditUndo.Enabled = bCanUndo
'    '// Set Undo Text
'    If (bCanUndo) Then
'        MDIFormMain.mnuReportEditUndo.Caption = "&Undo " & TranslateUndoType(UndoType(rtbText))
'    Else
'        MDIFormMain.mnuReportEditUndo.Caption = "&Undo"
'    End If
'    '// Set Redo Text
'    bCanUndo = CanRedo(rtbText)
'    If (bCanUndo) Then
'        MDIFormMain.mnuReportEditRedo.Caption = "&Redo " & TranslateUndoType(RedoType(rtbText))
'    Else
'        MDIFormMain.mnuReportEditRedo.Caption = "&Redo"
'    End If
'    MDIFormMain.mnuReportEditRedo.Enabled = bCanUndo
'    'tbrText.Buttons("Redo").Enabled = bCanUndo
'    '// Cut/Copy/Paste/Clear options
'    MDIFormMain.mnuReportEditCut.Enabled = CanCopy(rtbText)
'    MDIFormMain.mnuReportEditCopy.Enabled = CanCopy(rtbText)
'    MDIFormMain.mnuReportEditPaste.Enabled = CanPaste(rtbText)
'    MDIFormMain.mnuReportEditClear.Enabled = CanCopy(rtbText)
End Sub


Private Sub vsfgTable_AfterEdit(ByVal Row As Long, ByVal Col As Long)
Dim ctTable As New clsTable
    With vsfgConfigure
        ctTable.GetValuesFromGrid vsfgTable
        .TextMatrix(.Row, grdConfigureData) = ctTable.GetGridData
    End With
    ctTable.Clear
    Set ctTable = Nothing
End Sub

Private Sub vsfgTable_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    With vsfgConfigure
        If .ValueMatrix(.Row, grdConfigureTableID) <> rptTTCustomTable Then
            Cancel = True
        End If
    End With
End Sub

Private Sub vsfgTable_KeyPress(KeyAscii As Integer)
On Local Error Resume Next
Dim strKey As String
    If vsfgConfigure.ValueMatrix(vsfgConfigure.Row, grdConfigureTableID) = rptTTCustomTable Then
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
        vsfgTable_AfterEdit 0, 0
    End If
End Sub

Private Sub vsfgTable_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
Dim lngHeight As Long, lngLeft As Long, lngTop As Long, lngWidth As Long, ColInc As Long
    With vsfgTable
        If .ColIsVisible(.MouseCol) And .RowIsVisible(.MouseRow) And vsfgConfigure.ValueMatrix(vsfgConfigure.Row, grdConfigureTableID) = rptTTCustomTable Then
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
End Sub

Private Sub vsfgTable_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
Dim lngLeft As Long, lngWidth As Long
Dim lngTop As Long, lngHeight As Long
    With vsfgTable
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
                If Button = vbRightButton And vsfgConfigure.ValueMatrix(vsfgConfigure.Row, grdConfigureTableID) = rptTTCustomTable Then
                    PopupMenu MDIFormMain.mnuPopupReportDesigner
                End If
        End Select
        vsfgTable_AfterEdit 0, 0
    End With
End Sub

Private Sub vsfgTable_SelChange()
On Local Error Resume Next
    With tbrText
        'Selecting Bold , Italic  and Underline Tool Bar Buttons
        .Buttons("Bold").Value = IIf(vsfgTable.CellFontBold, tbrPressed, tbrUnpressed)
        .Buttons("Italic").Value = IIf(vsfgTable.CellFontItalic, tbrPressed, tbrUnpressed)
        .Buttons("Underline").Value = IIf(vsfgTable.CellFontUnderline, tbrPressed, tbrUnpressed)
        'Selecting Left, Right, Center and Justify Tool bar Buttons
        Select Case vsfgTable.CellAlignment
            Case flexAlignLeftBottom, flexAlignLeftCenter, flexAlignLeftTop
                .Buttons("Left").Value = tbrPressed
            Case flexAlignRightBottom, flexAlignRightCenter, flexAlignRightTop
                .Buttons("Right").Value = tbrPressed
            Case flexAlignCenterBottom, flexAlignCenterCenter, flexAlignCenterTop
                .Buttons("Center").Value = tbrPressed
            Case flexAlignGeneral
                'If IsNumeric(vsfgTable.Text) Then
                '    .Buttons("Right").Value = tbrPressed
                'Else
                '    .Buttons("Left").Value = tbrPressed
                'End If
                .Buttons("Left").Value = tbrPressed
                .Buttons("Left").Value = tbrUnpressed
        End Select
        If Not IsNull(vsfgTable.CellFontName) Then
            cmbFontName.Text = vsfgTable.CellFontName
        End If
        If Not IsNull(vsfgTable.CellFontSize) Then
            cmbFontSize.Text = Round(vsfgTable.CellFontSize, 0)
        End If
    End With
End Sub

Private Sub Save()
Dim cgRptObjs As New clsGrid
    cgRptObjs.GetValuesFromGrid vsfgConfigure
    SaveReportGenerate cgRptObjs, mlngPeriodID
    SaveDraftIssued
    SaveFinalIssued
    cgRptObjs.Clear
    Set cgRptObjs = Nothing
End Sub

Public Function SaveDraftIssued() As Boolean
On Local Error Resume Next
Dim sSql As String
    Screen.MousePointer = vbHourglass
    If chkDraftIssued.Value = 1 Then
        sSql = "Update AuditReportObjects Set DraftIssued = 1 Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
        sSql = "Update AuditReportObjects Set DraftIssuedDate = CURRENT_TIMESTAMP Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
        sSql = "Update AuditReportObjects Set DraftIssuedUser = " & pUserID & " Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
    Else
        sSql = "Update AuditReportObjects Set DraftIssued = 0 Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
'        sSql = "Update AuditReportObjects Set DraftIssuedDate = CURRENT_TIMESTAMP Where PeriodID = " & pActivePeriodID
'        AdoConn.Execute sSql
'        sSql = "Update AuditReportObjects Set DraftIssuedUser = " & pUserID & " Where PeriodID = " & pActivePeriodID
'        AdoConn.Execute sSql
    End If
    SaveDraftIssued = True
    Screen.MousePointer = vbDefault
End Function

Public Function SaveFinalIssued() As Boolean
On Local Error Resume Next
Dim sSql As String
    Screen.MousePointer = vbHourglass
    If chkFinalIssued.Value = 1 Then
        sSql = "Update AuditReportObjects Set FinalIssued = 1 Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
        sSql = "Update AuditReportObjects Set FinalIssuedDate = CURRENT_TIMESTAMP Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
        sSql = "Update AuditReportObjects Set FinalIssuedUser = " & pUserID & " Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
    Else
        sSql = "Update AuditReportObjects Set FinalIssued = 0 Where PeriodID = " & pActivePeriodID
        AdoConn.Execute sSql
'        sSql = "Update AuditReportObjects Set FinalIssuedDate = CURRENT_TIMESTAMP Where PeriodID = " & pActivePeriodID
'        AdoConn.Execute sSql
'        sSql = "Update AuditReportObjects Set FinalIssuedUser = " & pUserID & " Where PeriodID = " & pActivePeriodID
'        AdoConn.Execute sSql
    End If
    SaveFinalIssued = True
    Screen.MousePointer = vbDefault
End Function
