VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmCurrencyMaster 
   Caption         =   "Currency Master"
   ClientHeight    =   1875
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6195
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
   ScaleHeight     =   1875
   ScaleWidth      =   6195
   WindowState     =   2  'Maximized
   Begin VB.CommandButton fndCurrencyID 
      Height          =   315
      Left            =   5520
      Picture         =   "frmCurrencyMaster.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   310
      Width           =   315
   End
   Begin VB.Frame frameCurrency 
      Height          =   1350
      Left            =   120
      TabIndex        =   0
      Top             =   -45
      Width           =   5910
      Begin VB.TextBox txtStatusID 
         Height          =   330
         Left            =   3800
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   855
         Width           =   1575
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   5380
         Picture         =   "frmCurrencyMaster.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   870
         Width           =   315
      End
      Begin VB.TextBox txtCurShortName 
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
         Left            =   1290
         TabIndex        =   3
         Top             =   855
         Width           =   1770
      End
      Begin VB.TextBox txtCurrencyName 
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
         Left            =   1290
         TabIndex        =   1
         Top             =   345
         Width           =   4080
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Short Name"
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
         Left            =   360
         TabIndex        =   9
         Top             =   855
         Width           =   840
      End
      Begin VB.Label lblStatus 
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
         Left            =   3240
         TabIndex        =   8
         Top             =   855
         Width           =   450
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Name"
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
         Left            =   375
         TabIndex        =   2
         Top             =   375
         Width           =   420
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   75
      Top             =   1275
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
            Picture         =   "frmCurrencyMaster.frx":0314
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":046E
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":05C8
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":0722
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":08FC
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":0A56
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":0C30
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":0D8A
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":228C
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":2466
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":2640
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCurrencyMaster.frx":281A
            Key             =   "Notepad"
            Object.Tag             =   "N"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   0
      TabIndex        =   4
      Top             =   1440
      Width           =   6075
      _ExtentX        =   10716
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
Attribute VB_Name = "frmCurrencyMaster"
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
         txtCurrencyName.SetFocus
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

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
    ButtonHandling Me
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameCurrency.Enabled = blnNewValue
    fndCurrencyID.Enabled = Not blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
End Sub

Private Sub fndCurrencyID_Click()
    ButtonHandling Me, "Open"
End Sub

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
Dim sSql As String, rsSave As New ADODB.Recordset
Dim IsInTran As Boolean, blnIsNew As Boolean, lngCurID As Long
    If Trim(txtCurrencyName) = "" Then
        pMVE.MsgBox "Currency name not mentioned.", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    '------------------------------------------------
    sSql = "Select * From CurrencyMaster Where CurrencyID = " & Val(txtCurrencyName.Tag)
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            lngCurID = GetMaxNo("CurrencyMaster", "CurrencyID")
            lngID = lngCurID
            .Fields("CurrencyID") = lngCurID
        End If
        .Fields("CurrencyName") = txtCurrencyName
        .Fields("CurrencyShortName") = txtCurShortName
        .Fields("StatusID") = txtStatusID.Tag
        SaveDateAndUser rsSave
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

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpCurrency, "Where StatusID = " & cnstStatusActive, "XCurrencyID", , fndCurrencyID)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtCurrencyName.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtCurrencyName.Tag = mlngId
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
On Local Error GoTo Err_Exit
Dim sSql As String, rsValues As New Recordset
    sSql = "SELECT   CM.CurrencyID AS CurrencyID, CM.CurrencyName AS CurrencyName, CM.CurrencyShortName AS CurrencyShortName, " & _
           "         CM.StatusID AS StatusID, ST.StatusName AS Status " & _
           "FROM     CurrencyMaster CM INNER JOIN Status ST ON CM.StatusID = ST.StatusID " & _
           "WHERE    CM.CurrencyID = " & lngID
    Set rsValues = GetRecords(sSql)
    With rsValues
        txtCurrencyName.Tag = lngID
        txtCurrencyName.Text = .Fields("CurrencyName") & ""
        txtCurShortName.Text = .Fields("CurrencyShortName") & ""
        txtStatusID.Tag = .Fields("StatusID") & ""
        txtStatusID.Text = .Fields("Status") & ""
    End With
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are You Sure To Delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Delete From CurrencyMaster Where CurrencyID = " & Val(txtCurrencyName.Tag)
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
