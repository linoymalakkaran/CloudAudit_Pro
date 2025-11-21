VERSION 5.00
Object = "{370046EB-1E49-11D8-B636-C2FB81CF1D6D}#1.0#0"; "MVE.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmConnection 
   ClientHeight    =   1485
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   6930
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   ScaleHeight     =   1485
   ScaleWidth      =   6930
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtDatabase 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   0
      TabIndex        =   6
      Text            =   "Database"
      Top             =   1200
      Visible         =   0   'False
      Width           =   2145
   End
   Begin MVE_OCX.FlatBorder FlatBorder1 
      Left            =   330
      Top             =   1350
      _ExtentX        =   397
      _ExtentY        =   318
   End
   Begin VB.Timer tmrConnection 
      Interval        =   10
      Left            =   6495
      Top             =   90
   End
   Begin VB.Frame fraConnect 
      Height          =   945
      Left            =   30
      TabIndex        =   1
      Top             =   -45
      Width           =   6900
      Begin MSComCtl2.Animation aniConnect 
         Height          =   660
         Left            =   1920
         TabIndex        =   7
         Top             =   120
         Width           =   2700
         _ExtentX        =   4763
         _ExtentY        =   1164
         _Version        =   393216
         AutoPlay        =   -1  'True
         Center          =   -1  'True
         FullWidth       =   180
         FullHeight      =   44
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "Cance&l"
         Height          =   315
         Left            =   5850
         TabIndex        =   4
         Top             =   465
         Width           =   960
      End
      Begin VB.CommandButton cmdConnect 
         Caption         =   "&Connect"
         Default         =   -1  'True
         Height          =   315
         Left            =   4815
         TabIndex        =   3
         Top             =   465
         Width           =   960
      End
      Begin VB.TextBox txtServer 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   120
         TabIndex        =   0
         Text            =   "Server"
         Top             =   495
         Width           =   4620
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Server"
         Height          =   195
         Left            =   120
         TabIndex        =   2
         Top             =   270
         Width           =   465
      End
   End
   Begin VB.Label lblStatus 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BackStyle       =   0  'Transparent
      Caption         =   "Connecting to"
      BeginProperty Font 
         Name            =   "Microsoft Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   480
      Left            =   0
      TabIndex        =   8
      Top             =   960
      Width           =   6885
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Database"
      Height          =   195
      Left            =   0
      TabIndex        =   5
      Top             =   975
      Visible         =   0   'False
      Width           =   690
   End
End
Attribute VB_Name = "frmConnection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public mMode As Byte

Public Enum ConnectionModes
    ConnectionModeConnecting = 1
    ConnectionModeFailed = 0
End Enum

Private Sub cmdCancel_Click()
    End
End Sub

Private Sub cmdConnect_Click()
    pServer = Trim(txtServer)
    Unload Me
    OpenInitialCatalog
    If pConnectionSucceeded Then
        SetIniString "Server", pServer
    End If
End Sub

Public Sub Form_Load()
On Local Error Resume Next
    Me.Width = 7050
    Me.Height = 1545
    Top = (Screen.Height / 2) - Height
    Left = (Screen.Width / 2) - (Width / 2)
    Select Case mMode
        Case ConnectionModeConnecting
'            aniConnect.Visible = True
'            aniConnect.Open App.Path & "\Support\AVI\Server.avi"
            lblStatus = "Connecting to " & IIf(Trim(pServer) = "", "Server", UCase(pServer))    'UCase(pInitialCatelog) & " in " & UCase(pServer)
            fraConnect.Visible = False
        Case ConnectionModeFailed
            aniConnect.Visible = False
            txtServer = UCase(pServer)
            txtDatabase = UCase(pInitialCatelog)
            lblStatus = "Connection Failed."
            fraConnect.Visible = True
    End Select
End Sub

Private Sub tmrConnection_Timer()
    If pConnectionSucceeded Then
        Unload Me
        DoEvents
    End If
End Sub
