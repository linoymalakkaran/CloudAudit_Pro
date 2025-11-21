VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmUsers 
   Caption         =   "Users"
   ClientHeight    =   2670
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   2670
   ScaleWidth      =   6630
   WindowState     =   2  'Maximized
   Begin VB.Frame frameUser 
      Height          =   2190
      Left            =   30
      TabIndex        =   0
      Top             =   -45
      Width           =   6510
      Begin VB.TextBox txtGroupID 
         Height          =   315
         Left            =   240
         Locked          =   -1  'True
         TabIndex        =   14
         Top             =   1665
         Width           =   1590
      End
      Begin VB.CommandButton fndGroupID 
         Height          =   315
         Left            =   1845
         Picture         =   "frmUsers.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   1665
         Width           =   315
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   5080
         Picture         =   "frmUsers.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   1665
         Width           =   315
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   3480
         Locked          =   -1  'True
         TabIndex        =   10
         Top             =   1665
         Width           =   1590
      End
      Begin VB.TextBox txtConfirmPwd 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         IMEMode         =   3  'DISABLE
         Left            =   3480
         PasswordChar    =   "*"
         TabIndex        =   8
         Top             =   1050
         Width           =   2760
      End
      Begin VB.TextBox txtPassword 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         IMEMode         =   3  'DISABLE
         Left            =   240
         PasswordChar    =   "*"
         TabIndex        =   6
         Top             =   1050
         Width           =   3120
      End
      Begin VB.TextBox txtUserCode 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   3480
         TabIndex        =   4
         Top             =   465
         Width           =   2760
      End
      Begin VB.TextBox txtUserName 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   255
         TabIndex        =   1
         Top             =   465
         Width           =   3120
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Category"
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
         Index           =   0
         Left            =   240
         TabIndex        =   15
         Top             =   1440
         Width           =   630
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
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
         Index           =   12
         Left            =   3480
         TabIndex        =   12
         Top             =   1440
         Width           =   450
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Confirm Password"
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
         Left            =   3480
         TabIndex        =   9
         Top             =   840
         Width           =   1260
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Password"
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
         Left            =   240
         TabIndex        =   7
         Top             =   840
         Width           =   690
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Code"
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
         Left            =   3480
         TabIndex        =   3
         Top             =   240
         Width           =   375
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "User Name"
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
         Left            =   255
         TabIndex        =   2
         Top             =   255
         Width           =   795
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   75
      Top             =   2235
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
            Picture         =   "frmUsers.frx":0314
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":046E
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":05C8
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":0722
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":08FC
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":0A56
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":0C30
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":0D8A
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":228C
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":2466
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":2640
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmUsers.frx":281A
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   4440
      TabIndex        =   5
      Top             =   2280
      Width           =   2085
      _ExtentX        =   3678
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
            Caption         =   "&Ok"
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
End
Attribute VB_Name = "frmUsers"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mblnModify As Boolean, mlngId As Long
Dim mblnNew As Boolean

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         txtUserName.SetFocus
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    mblnModify = blnNewValue
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameUser.Enabled = blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
End Sub

Private Sub fndGroupID_Click()
    PrepareAndFind cnstSearchTypeGrpUserGroups, , "Name, XUserID", txtGroupID, fndGroupID, , , 1
End Sub

Private Sub fndStatusID_Click()
    PrepareAndFind cnstSearchTypeGrpStatus, , "Name, XStatusID", txtStatusID, fndStatusID, , , 1
End Sub

Private Sub fndUserID_Click()
    ButtonHandling Me, "Open"
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    ButtonShortCuts Me, KeyCode, Shift
End Sub

Private Sub Form_Load()
    ButtonHandling Me
    frameUser.Enabled = True
    fndStatusID.Enabled = True
    tbrCtrls.Buttons("Save").Enabled = True
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
    tbrCtrls.Buttons("Save").Enabled = True
    If tbrCtrls.Buttons("Close").Value = 0 Then
        Unload Me
    End If
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String, rsSave As New Recordset, lngUserID As Long
    If Trim(txtUserName) = "" Then
        pMVE.MsgBox "User name not mentioned", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    If Trim(txtConfirmPwd) <> Trim(txtPassword) Then
        pMVE.MsgBox "Confirm password is not matching with the password entered", msgOK, "AuditMate", msgCritical, True
        txtConfirmPwd.SetFocus
        Exit Function
    End If
    '------------------------------------------------
    sSql = "Select * From Users Where 1=2"
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        .AddNew
        lngUserID = GetMaxNo("Users", "UserID")
        .Fields("UserID") = lngUserID
        .Fields("UserName") = txtUserName
        .Fields("UserCode") = txtUserCode
        .Fields("Password") = NumberEncryption(True, "eAudit", txtPassword)
        .Fields("IsAdmin") = 0
        .Fields("IsSuperUser") = 0
        .Fields("StatusID") = txtStatusID.Tag
        SaveDateAndUser rsSave, True
        .Update
        .Close
    End With
    sSql = "Select * From UserGroupUsers Where 1=2"
    With GetRecords(sSql)
        .AddNew
        .Fields("UserID") = lngUserID
        .Fields("UserGroupID") = txtGroupID.Tag
        .Update
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Save = False
End Function
