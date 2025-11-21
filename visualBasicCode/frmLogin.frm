VERSION 5.00
Object = "{370046EB-1E49-11D8-B636-C2FB81CF1D6D}#1.0#0"; "MVE.OCX"
Begin VB.Form frmLogin 
   BackColor       =   &H00800000&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   2580
   ClientLeft      =   2835
   ClientTop       =   3195
   ClientWidth     =   4590
   ControlBox      =   0   'False
   FillColor       =   &H00400000&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmLogin.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2580
   ScaleWidth      =   4590
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MVE_OCX.FlatBorder FlatBorder1 
      Left            =   90
      Top             =   630
      _ExtentX        =   397
      _ExtentY        =   318
   End
   Begin VB.TextBox txtUserName 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1290
      TabIndex        =   0
      Text            =   "admin"
      Top             =   585
      Width           =   2520
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   1395
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1455
      Width           =   1140
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   2670
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   1455
      Width           =   1140
   End
   Begin VB.TextBox txtPassword 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      IMEMode         =   3  'DISABLE
      Left            =   1290
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   975
      Width           =   2520
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "&User Name"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Index           =   0
      Left            =   390
      TabIndex        =   2
      Top             =   600
      Width           =   795
   End
   Begin VB.Image btnRightOut 
      Height          =   300
      Index           =   3
      Left            =   20
      Picture         =   "frmLogin.frx":08CA
      Top             =   2400
      Width           =   165
   End
   Begin VB.Shape Shape5 
      BorderColor     =   &H00808080&
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   2400
      Left            =   4395
      Top             =   150
      Width           =   180
   End
   Begin VB.Shape Shape4 
      BorderColor     =   &H00808080&
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   165
      Left            =   180
      Top             =   2415
      Width           =   4390
   End
   Begin VB.Shape Shape3 
      BorderColor     =   &H00808080&
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   2470
      Left            =   15
      Top             =   105
      Width           =   180
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H00808080&
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   315
      Left            =   150
      Top             =   -30
      Width           =   4260
   End
   Begin VB.Image btnToolsOut 
      Height          =   300
      Index           =   0
      Left            =   0
      Picture         =   "frmLogin.frx":0C34
      Top             =   -15
      Width           =   165
   End
   Begin VB.Image btnToolsIn 
      Height          =   300
      Index           =   0
      Left            =   15
      Picture         =   "frmLogin.frx":0F9E
      Top             =   240
      Width           =   165
   End
   Begin VB.Image btnRightIn 
      Height          =   300
      Index           =   0
      Left            =   4395
      Picture         =   "frmLogin.frx":1308
      Top             =   270
      Width           =   165
   End
   Begin VB.Image btnRightOut 
      Height          =   300
      Index           =   0
      Left            =   4410
      Picture         =   "frmLogin.frx":1672
      Top             =   -15
      Width           =   165
   End
   Begin VB.Image btnBottomUp 
      Height          =   165
      Index           =   0
      Left            =   315
      Picture         =   "frmLogin.frx":19DC
      Top             =   2415
      Width           =   300
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      BackStyle       =   0  'Transparent
      Caption         =   "Cool Tools "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   165
      TabIndex        =   8
      Top             =   -30
      Width           =   1335
   End
   Begin VB.Label Label4 
      BackColor       =   &H00808080&
      BackStyle       =   0  'Transparent
      Caption         =   " Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   3360
      TabIndex        =   7
      Top             =   -30
      Width           =   945
   End
   Begin VB.Image btnToolsOut 
      Height          =   300
      Index           =   1
      Left            =   330
      Picture         =   "frmLogin.frx":1D3B
      Top             =   420
      Width           =   165
   End
   Begin VB.Image btnToolsOut 
      Height          =   300
      Index           =   2
      Left            =   480
      Picture         =   "frmLogin.frx":20A5
      Top             =   435
      Width           =   165
   End
   Begin VB.Image btnRightOut 
      Height          =   300
      Index           =   1
      Left            =   3900
      Picture         =   "frmLogin.frx":240F
      Top             =   630
      Width           =   165
   End
   Begin VB.Image btnRightOut 
      Height          =   300
      Index           =   2
      Left            =   4080
      Picture         =   "frmLogin.frx":2779
      Top             =   615
      Width           =   165
   End
   Begin VB.Image btnRightIn 
      Height          =   300
      Index           =   1
      Left            =   3900
      Picture         =   "frmLogin.frx":2AE3
      Top             =   840
      Width           =   165
   End
   Begin VB.Image btnRightIn 
      Height          =   300
      Index           =   2
      Left            =   4095
      Picture         =   "frmLogin.frx":2E4D
      Top             =   810
      Width           =   165
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Stuff"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   60
      TabIndex        =   6
      Top             =   2460
      Width           =   525
   End
   Begin VB.Image btnBottomDown 
      Height          =   165
      Index           =   1
      Left            =   2325
      Picture         =   "frmLogin.frx":31B7
      Top             =   2145
      Width           =   300
   End
   Begin VB.Image btnBottomDown 
      Height          =   165
      Index           =   2
      Left            =   2325
      Picture         =   "frmLogin.frx":3515
      Top             =   1965
      Width           =   300
   End
   Begin VB.Image btnBottomUp 
      Height          =   165
      Index           =   1
      Left            =   2520
      Picture         =   "frmLogin.frx":3873
      Top             =   2160
      Width           =   300
   End
   Begin VB.Image btnBottomUp 
      Height          =   165
      Index           =   2
      Left            =   2550
      Picture         =   "frmLogin.frx":3BD2
      Top             =   1950
      Width           =   300
   End
   Begin VB.Label lblLabels 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "&Password"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Index           =   1
      Left            =   390
      TabIndex        =   3
      Top             =   1020
      Width           =   690
   End
   Begin VB.Image btnToolsIn 
      Height          =   300
      Index           =   1
      Left            =   345
      Picture         =   "frmLogin.frx":3F31
      Top             =   630
      Width           =   165
   End
   Begin VB.Image btnToolsIn 
      Height          =   300
      Index           =   2
      Left            =   495
      Picture         =   "frmLogin.frx":429B
      Top             =   640
      Width           =   165
   End
End
Attribute VB_Name = "frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'For dragging the form
Private Const WM_NCLBUTTONDOWN = &HA1
Private Const HTCAPTION = 2
Private Const SW_SHOWMAXIMIZED = 3

Private bLeftOut As Boolean
Private bRightOut As Boolean
Private bBottomOut As Boolean

Private iRelLeftTrayOffset As Integer
Private iRelRightTrayOffset As Integer
Private iRelBottomTrayOffset As Integer

Private Declare Sub ReleaseCapture Lib "user32" ()
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Long, ByVal hrgn As Long, ByVal bRedraw As Boolean) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Private Sub cmdCancel_Click()
On Local Error Resume Next
    Unload Me
End Sub

Private Sub cmdOK_Click()
Dim pUserGroupID As Long
    If Login(txtUserName, txtPassword) Then
        Unload Me
        MDIFormMain.Show
    Else
        txtPassword.SetFocus
        Highlight
    End If
    pUserGroupID = Val(PickValue("UserGroupUsers", "UserGroupID", "UserID = " & pUserID))
    If pUserGroupID = 3 Or pUserGroupID = 4 Then
        MDIFormMain.mnuDBA.Enabled = False
    Else
        MDIFormMain.mnuDBA.Enabled = True
    End If
End Sub

Private Sub Form_Activate()
Dim strPassword As String
    txtUserName.SetFocus
    Highlight
    txtUserName_Change
    DoEvents
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        cmdCancel_Click
    End If
End Sub

Private Sub Form_Load()
    DrowMe
    cmdOK.Enabled = False
End Sub

Public Sub DrowMe()
On Local Error Resume Next
Dim hrgn As Long
Dim grad As New clsGradient
    
    PATHSTR = App.Path & IIf(Mid(App.Path, Len(App.Path), 1) = "\", "", "\")
    'hrgn = LoadRegionDataFromFile(PATHSTR & "main.pts")
    hrgn = LoadRegionData()
    SetWindowRgn hWnd, hrgn, True
    DeleteObject hrgn
    ' initialize our tray state flags
    bLeftOut = False
    bRightOut = False
    bBottomOut = False
    ZOrder
    ' initialize the offset postions for the trays
    iRelLeftTrayOffset = Left
    iRelRightTrayOffset = Left
    ' makes a funky gradient on the form
    grad.MetalCylander RGB(10, 10, 255), _
                       RGB(100, 100, 200), _
                       RGB(80, 80, 80), _
                       RGB(50, 50, 255), _
                       Width \ 4, _
                      (Width \ 5) + (Width \ 4), _
                       Width, Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Not pLoginSucceeded Then
        AdoConn.Close
        End
    End If
End Sub

Private Sub btnClose_Click()
    End
End Sub

Private Sub lblClose_Click()
    End
End Sub

Private Sub txtUserName_Change()
    If txtUserName.Text <> "" Then
        cmdOK.Enabled = True
    Else
        cmdOK.Enabled = False
    End If
End Sub
