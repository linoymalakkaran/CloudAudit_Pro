VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmAcHeads 
   Caption         =   "Account Heads"
   ClientHeight    =   2160
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7245
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   2160
   ScaleWidth      =   7245
   WindowState     =   2  'Maximized
   Begin VB.CommandButton fndAcID 
      Height          =   315
      Left            =   4350
      Picture         =   "frmAcHeads.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   500
      Width           =   315
   End
   Begin VB.Frame frameDetails 
      Height          =   1695
      Left            =   45
      TabIndex        =   0
      Top             =   -30
      Width           =   7155
      Begin VB.TextBox txtTrialOrder 
         Height          =   315
         Left            =   3900
         TabIndex        =   14
         Top             =   1125
         Width           =   1140
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   5100
         Locked          =   -1  'True
         TabIndex        =   9
         Top             =   1125
         Width           =   1590
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   6675
         Picture         =   "frmAcHeads.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   1125
         Width           =   315
      End
      Begin VB.CommandButton fndAccountTypeID 
         Height          =   315
         Left            =   3525
         Picture         =   "frmAcHeads.frx":0314
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   1125
         Width           =   315
      End
      Begin VB.TextBox txtAccountTypeID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   1125
         Width           =   3390
      End
      Begin VB.TextBox txtAcCode 
         Height          =   315
         Left            =   4725
         TabIndex        =   5
         Top             =   525
         Width           =   2265
      End
      Begin VB.TextBox txtAcName 
         Height          =   315
         Left            =   150
         TabIndex        =   4
         Top             =   525
         Width           =   4140
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Trial Order"
         Height          =   195
         Index           =   3
         Left            =   3900
         TabIndex        =   15
         Top             =   900
         Width           =   735
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Index           =   12
         Left            =   5100
         TabIndex        =   12
         Top             =   900
         Width           =   450
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Account Type"
         Height          =   195
         Index           =   2
         Left            =   150
         TabIndex        =   11
         Top             =   900
         Width           =   1005
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Ref No"
         Height          =   195
         Index           =   1
         Left            =   4725
         TabIndex        =   10
         Top             =   300
         Width           =   510
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Name"
         Height          =   195
         Index           =   0
         Left            =   150
         TabIndex        =   3
         Top             =   300
         Width           =   420
      End
      Begin VB.Label Label7 
         Caption         =   "Derived From"
         Height          =   15
         Left            =   0
         TabIndex        =   1
         Top             =   0
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   1185
      TabIndex        =   2
      Top             =   1770
      Width           =   6030
      _ExtentX        =   10636
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   45
      Top             =   1575
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":049E
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":05F8
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":0752
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":08AC
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":0A86
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":0BE0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":0DBA
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":0F14
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":2416
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":25F0
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcHeads.frx":27CA
            Key             =   "Help"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmAcHeads"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mCompanyID As Long, mlngId As Long
Dim clsAc As New clsAcHead
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID & " AND UserID = " & pUserID
        With GetRecords(sSql1)
            If Not .EOF Then
                If .Fields("IsBlocked") = True Then
                    IsReadOnly = True
                Else
                    IsReadOnly = False
                End If
            Else
                IsReadOnly = True
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

Public Sub ClearValues()
    ClearAllTextBoxes Me
End Sub

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         mlngId = 0
         txtAcName.SetFocus
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
    fndAcID.Enabled = Not blnNewValue
End Property

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
    clsAc.Clear
    With clsAc
        .CompanyID = mCompanyID
        .AcHeadName = Trim(txtAcName)
        .AcHeadCode = Trim(txtAcCode)
        .AcTypeID = Val(txtAccountTypeID.Tag)
        .TrialOrder = Val(txtTrialOrder)
        .StatusID = IIf(Val(txtStatusID.Tag) = 0, cnstStatusActive, Val(txtStatusID.Tag))
        Save = .Save(mlngId)
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         txtAcName.SetFocus
         Highlight
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
    ClearValues
    ButtonHandling Me
End Property

Private Sub fndAcID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
    Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountHeads, "WHERE AH.CompanyID = " & mCompanyID, "XAcID", , fndAcID, , , 1)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtAcName.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtAcName.Tag = mlngId
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(mlngId)
        ShowOpen = True
    End Select
End Function

Public Function Delete() As Boolean
On Error GoTo Err_Exit
    Delete = clsAc.Delete(Val(txtAcName.Tag))
Exit Function
Err_Exit:
    Delete = False
    ShowError
End Function

Public Function ValueCollect(ByVal lngID As Long) As Boolean
On Error GoTo Err_Exit
Dim sSql As String
    clsAc.Clear
    clsAc.Collect lngID
    With clsAc
        txtAcName = .AcHeadName
        txtAcCode = .AcHeadCode
        txtAccountTypeID.Tag = .AcTypeID
        txtAccountTypeID = .AcTypeName
        txtTrialOrder = .TrialOrder
        txtStatusID.Tag = .StatusID
        txtStatusID = .StatusName
    End With
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Private Sub fndAccountTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID, "Name, XAcTypeID", txtAccountTypeID, fndAccountTypeID, , , 1
End Sub

Private Sub fndStatusID_Click()
    PrepareAndFind cnstSearchTypeGrpStatus, , "Name, XStatusID", txtStatusID, fndStatusID, , , 1
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    ButtonShortCuts Me, KeyCode, Shift
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub txtStatusID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndStatusID_Click
    End If
End Sub

