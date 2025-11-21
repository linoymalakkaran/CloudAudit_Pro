VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{370046EB-1E49-11D8-B636-C2FB81CF1D6D}#1.0#0"; "MVE.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmSelect 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Select"
   ClientHeight    =   3030
   ClientLeft      =   45
   ClientTop       =   315
   ClientWidth     =   4365
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   4365
   ShowInTaskbar   =   0   'False
   Begin MVE_OCX.FlatBorder FlatBorder1 
      Left            =   210
      Top             =   2745
      _ExtentX        =   397
      _ExtentY        =   318
   End
   Begin MSComctlLib.ImageList imglstToolBar 
      Left            =   2040
      Top             =   1185
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSelect.frx":0000
            Key             =   "Cancel"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmSelect.frx":031A
            Key             =   "OK"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgDetails 
      Height          =   2430
      Left            =   15
      TabIndex        =   0
      Top             =   30
      Width           =   4320
      _cx             =   7620
      _cy             =   4286
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
      BackColorSel    =   16777215
      ForeColorSel    =   0
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483636
      FocusRect       =   1
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   9
      GridLinesFixed  =   2
      GridLineWidth   =   3
      Rows            =   50
      Cols            =   3
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"frmSelect.frx":0634
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
   Begin MSComctlLib.Toolbar tbrOkCancel 
      Height          =   600
      Left            =   2595
      TabIndex        =   1
      Top             =   2505
      Width           =   1740
      _ExtentX        =   3069
      _ExtentY        =   1058
      ButtonWidth     =   1402
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "imglstToolBar"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&OK"
            Key             =   "OK"
            ImageKey        =   "OK"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cancel"
            Key             =   "Cancel"
            ImageKey        =   "Cancel"
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "frmSelect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mlngSelectedRow As Long

Private Sub Form_Activate()
    vsfgDetails.Row = 1
    vsfgDetails_RowColChange
End Sub

Private Sub Form_Load()
    mlngSelectedRow = -1
End Sub

Private Sub tbrOkCancel_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    Case "OK"
        mlngSelectedRow = vsfgDetails.Row
    Case "Cancel"
        mlngSelectedRow = -1
    End Select
    Hide
End Sub

Private Sub vsfgDetails_DblClick()
    tbrOkCancel_ButtonClick tbrOkCancel.Buttons("OK")
End Sub

Private Sub vsfgDetails_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        vsfgDetails_DblClick
    End If
End Sub

Private Sub vsfgDetails_RowColChange()
    SelectRow vsfgDetails
End Sub

Public Property Get SelectedRow() As Long
    SelectedRow = mlngSelectedRow
End Property
