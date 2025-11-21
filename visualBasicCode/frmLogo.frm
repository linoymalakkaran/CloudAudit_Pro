VERSION 5.00
Begin VB.Form frmLogo 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   ClientHeight    =   2775
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6600
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   6600
   ShowInTaskbar   =   0   'False
   Visible         =   0   'False
   Begin VB.Timer tmrLogo 
      Interval        =   600
      Left            =   930
      Top             =   2415
   End
   Begin VB.Image ImgHamtLogo 
      Height          =   375
      Left            =   5900
      Picture         =   "frmLogo.frx":0000
      Top             =   2400
      Width           =   720
   End
   Begin VB.Label lblVersion 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   4005
      TabIndex        =   1
      Top             =   2520
      Width           =   75
   End
   Begin VB.Label lblEdition 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Professional Edition"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   240
      Left            =   45
      TabIndex        =   0
      Top             =   2475
      Visible         =   0   'False
      Width           =   2400
   End
   Begin VB.Image imgLogo 
      Height          =   2370
      Left            =   0
      Picture         =   "frmLogo.frx":65F3
      Top             =   0
      Width           =   6615
   End
End
Attribute VB_Name = "frmLogo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public CanEnd As Boolean

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If (KeyCode = vbKeyReturn) And (KeyCode = vbKeyEscape) Then
        Unload Me
    End If
End Sub

Private Sub Form_Load()
    Width = 6690
    Height = 2910
    Top = (Screen.Height / 2) - (Height / 2) - 700
    Left = (Screen.Width / 2) - (Width / 2) + 1000

    lblVersion = App.Major & "." & App.Minor & "." & App.Revision
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Unload Me
End Sub

Private Sub Form_Resize()
    ImgLogo.Width = Me.Width
    ImgLogo.Height = Me.Height
End Sub

Private Sub imgLogo_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Unload Me
End Sub

Private Sub tmrLogo_Timer()
    If pConnectionSucceeded And CanEnd Then
        Unload Me
    End If
End Sub
