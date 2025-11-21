VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmOptions 
   Caption         =   "Options"
   ClientHeight    =   3390
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6885
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   3390
   ScaleWidth      =   6885
   WindowState     =   2  'Maximized
   Begin VB.Frame frameDetails 
      Height          =   2565
      Left            =   30
      TabIndex        =   0
      Top             =   -15
      Width           =   6795
      Begin VB.CommandButton cmdBrowseBackupPath 
         Caption         =   "..."
         Height          =   315
         Left            =   6100
         TabIndex        =   11
         Top             =   1920
         Width           =   375
      End
      Begin VB.TextBox txtBackupPath 
         Height          =   315
         Left            =   1695
         TabIndex        =   10
         Top             =   1920
         Width           =   4425
      End
      Begin VB.TextBox txtServer 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1695
         TabIndex        =   9
         Top             =   390
         Width           =   3000
      End
      Begin VB.TextBox txtWorkingDirectory 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1695
         TabIndex        =   8
         Top             =   885
         Width           =   4425
      End
      Begin VB.TextBox txtCheckOutPath 
         Enabled         =   0   'False
         Height          =   315
         Left            =   1695
         TabIndex        =   7
         Top             =   1395
         Width           =   4440
      End
      Begin VB.CommandButton cmdBrowseWorkingDirectory 
         Caption         =   "..."
         Enabled         =   0   'False
         Height          =   330
         Left            =   6100
         TabIndex        =   6
         Top             =   885
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.CommandButton cmdBrowseCheckOutPath 
         Caption         =   "..."
         Enabled         =   0   'False
         Height          =   330
         Left            =   6100
         TabIndex        =   5
         Top             =   1395
         Visible         =   0   'False
         Width           =   375
      End
      Begin MSComDlg.CommonDialog cdFolderBrowse 
         Left            =   240
         Top             =   2220
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         FileName        =   "cdFile"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Backup Path"
         Height          =   195
         Left            =   240
         TabIndex        =   12
         Top             =   1980
         Width           =   930
      End
      Begin VB.Label lblCheckOutPath 
         AutoSize        =   -1  'True
         Caption         =   "CheckOut Path"
         Height          =   195
         Index           =   1
         Left            =   225
         TabIndex        =   4
         Top             =   1455
         Width           =   1095
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Server"
         Height          =   195
         Index           =   0
         Left            =   225
         TabIndex        =   3
         Top             =   450
         Width           =   465
      End
      Begin VB.Label lblWorkingDirectory 
         AutoSize        =   -1  'True
         Caption         =   "Working Directory"
         Height          =   195
         Left            =   225
         TabIndex        =   2
         Top             =   945
         Width           =   1275
      End
   End
   Begin MSComctlLib.ImageList imgToolbarOkCancel 
      Left            =   120
      Top             =   2805
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOptions.frx":0000
            Key             =   "Cancel"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOptions.frx":031A
            Key             =   "OK"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOptions.frx":0634
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmOptions.frx":080E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrOkCancel 
      Height          =   570
      Left            =   5340
      TabIndex        =   1
      Top             =   2700
      Width           =   1425
      _ExtentX        =   2514
      _ExtentY        =   1005
      ButtonWidth     =   1138
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "imgToolbarOkCancel"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Ok"
            Key             =   "Ok"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cancel"
            Key             =   "Cancel"
            ImageIndex      =   1
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmOptions"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdBrowseBackupPath_Click()
    txtBackupPath.Text = BrowShow(txtBackupPath.hWnd, , , , , txtBackupPath)
End Sub

Private Sub cmdBrowseCheckOutPath_Click()
On Local Error Resume Next
    Dim strPath As String
    strPath = BrowShow(txtWorkingDirectory.hWnd, CSIDL_DRIVES)
    If Trim(strPath) <> "" Then
        txtCheckOutPath.Text = strPath
    End If
End Sub

Private Sub cmdBrowseWorkingDirectory_Click()
On Local Error Resume Next
    Dim strPath As String
    strPath = BrowShow(txtWorkingDirectory.hWnd, CSIDL_DRIVES)
    If Trim(strPath) <> "" Then
        txtWorkingDirectory.Text = strPath
    End If
 End Sub
 
Private Sub Form_Load()
    GetAllOptions
End Sub

Public Sub GetAllOptions()
On Local Error Resume Next
    txtServer = GetIniString("Server", pServer)
'    txtWorkingDirectory.Text = GetSetting("AuditMateSetup", "AuditMateSetup", "WorkDirectory")
'    txtCheckOutPath.Text = GetSetting("AuditMateSetup", "AuditMateSetup", "CheckOutPath")
    txtWorkingDirectory.Text = GetApplicationData("WorkDirectory")
    txtCheckOutPath.Text = GetApplicationData("CheckOutPath")
    txtBackupPath = GetApplicationData("BackupPath")
End Sub

Public Sub SetAllOptions()
On Local Error Resume Next
    SetIniString "Server", Trim(txtServer)
'    SetIniString "WorkDirectory", txtWorkingDirectory.Text
'    SetIniString "CheckOutPath", txtCheckOutPath.Text
    SetApplicationData "WorkDirectory", txtWorkingDirectory
    SetApplicationData "CheckOutPath", txtCheckOutPath
    SetApplicationData "BackupPath", txtBackupPath
End Sub

Private Sub tbrOkCancel_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "Ok"
            SetAllOptions
            MDIFormMain.CloseActiveTabForm
        Case "Cancel"
            MDIFormMain.CloseActiveTabForm
    End Select
End Sub
