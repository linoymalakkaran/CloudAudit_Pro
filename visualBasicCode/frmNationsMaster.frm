VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmNationsMaster 
   Caption         =   "Nations Master"
   ClientHeight    =   1995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6990
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   1995
   ScaleWidth      =   6990
   WindowState     =   2  'Maximized
   Begin VB.CommandButton fndNationID 
      Height          =   315
      Left            =   6240
      Picture         =   "frmNationsMaster.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   360
      Width           =   315
   End
   Begin VB.Frame frameNation 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1365
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   6765
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   2655
         Picture         =   "frmNationsMaster.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   840
         Width           =   315
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   1080
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   825
         Width           =   1590
      End
      Begin VB.TextBox txtNationName 
         Height          =   330
         Left            =   1080
         TabIndex        =   1
         Top             =   360
         Width           =   5025
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Index           =   12
         Left            =   360
         TabIndex        =   6
         Top             =   840
         Width           =   450
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Name"
         Height          =   195
         Left            =   375
         TabIndex        =   2
         Top             =   390
         Width           =   420
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   120
      Top             =   1440
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
            Picture         =   "frmNationsMaster.frx":0314
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":046E
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":05C8
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":0722
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":08FC
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":0A56
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":0C30
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":0D8A
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":228C
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":2466
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":2640
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmNationsMaster.frx":281A
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   860
      TabIndex        =   3
      Top             =   1560
      Width           =   6020
      _ExtentX        =   10610
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
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&New"
            Key             =   "New"
            ImageKey        =   "New"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Delete"
            Key             =   "Delete"
            ImageKey        =   "Delete"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmNationsMaster"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long
Dim mblnModify As Boolean, mlngId As Long
Dim mblnNew As Boolean

Public Property Get IsReadOnly() As Boolean
Dim sSql As String
    sSql = "Select * From UserGroupUsers Where UserID = " & pUserID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("UserGroupID") & "" = "1" Or .Fields("UserGroupID") & "" = "2" Then
                    IsReadOnly = False
                Else
                    IsReadOnly = True
                End If
                .MoveNext
            Wend
            .Close
        End With
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         txtNationName.SetFocus
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
    frameNation.Enabled = blnNewValue
    fndNationID.Enabled = Not blnNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
    ButtonHandling Me
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
End Sub

Private Sub fndNationID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpNation, "Where StatusID = " & cnstStatusActive, "XNationID", , fndNationID)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtNationName.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtNationName.Tag = mlngId
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(mlngId)
        ShowOpen = True
    End Select
End Function

Public Function ValueCollect(ByVal lngID As Long) As Boolean
On Error GoTo Err_Exit
Dim sSql As String, rsValues As New Recordset
    sSql = "SELECT NT.NationID AS NationID, NT.NationName AS NationName, NT.StatusID AS StatusID, ST.StatusName AS Status " & _
           "FROM   Nations NT INNER JOIN Status ST ON NT.StatusID = ST.StatusID Where NT.NationID =" & lngID
    Set rsValues = GetRecords(sSql)
    With rsValues
        txtNationName.Tag = lngID
        txtNationName.Text = .Fields("NationName") & ""
        txtStatusID.Tag = .Fields("StatusID") & ""
        txtStatusID.Text = .Fields("Status") & ""
    End With
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Private Sub fndStatusID_Click()
    PrepareAndFind cnstSearchTypeGrpStatus, , "Name, XStatusID", txtStatusID, fndStatusID, , , 1
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    ButtonShortCuts Me, KeyCode, Shift
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function Save(Optional lngID As Long = 0) As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String, rsSave As New Recordset, lngNationID As Long, blnIsNew As Boolean
    If Trim(txtNationName) = "" Then
        pMVE.MsgBox "Nation name not mentioned", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    '------------------------------------------------
    sSql = "Select * From Nations Where NationID = " & Val(txtNationName.Tag)
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            lngNationID = GetMaxNo("Nations", "NationID")
            lngID = lngNationID
            .Fields("NationID") = lngNationID
        End If
        .Fields("NationName") = txtNationName.Text
        .Fields("StatusID") = txtStatusID.Tag
        .Fields("CreateDate") = ServerDateTime
        .Fields("UpdateDate") = ServerDateTime
        .Update
        .Close
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

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Delete From Nations Where NationID = " & Val(txtNationName.Tag)
    AdoConn.Execute sSql
    AdoConn.CommitTrans
    Delete = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Delete = False
End Function
