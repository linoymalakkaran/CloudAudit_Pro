VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmAcTypes 
   Caption         =   "Account Types"
   ClientHeight    =   4740
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7245
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   4740
   ScaleWidth      =   7245
   WindowState     =   2  'Maximized
   Begin VB.CommandButton fndAcTypeID 
      Height          =   315
      Left            =   4300
      Picture         =   "frmAcTypes.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   33
      Top             =   615
      Width           =   315
   End
   Begin VB.Frame frameDetails 
      Height          =   4125
      Left            =   50
      TabIndex        =   0
      Top             =   90
      Width           =   7155
      Begin VB.TextBox txtDescription 
         Height          =   315
         Left            =   150
         TabIndex        =   34
         Top             =   1185
         Width           =   4620
      End
      Begin VB.CommandButton fndAllocationAcTypeID 
         Height          =   315
         Left            =   6645
         Picture         =   "frmAcTypes.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   14
         Top             =   3045
         Width           =   315
      End
      Begin VB.CommandButton fndCostAcTypeID 
         Height          =   315
         Left            =   3240
         Picture         =   "frmAcTypes.frx":0314
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   2445
         Width           =   315
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   3240
         Picture         =   "frmAcTypes.frx":049E
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   3660
         Width           =   315
      End
      Begin VB.CommandButton fndDeductionAcTypeID 
         Height          =   315
         Left            =   6645
         Picture         =   "frmAcTypes.frx":0628
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   2475
         Width           =   315
      End
      Begin VB.CommandButton fndDepreciationAcTypeID 
         Height          =   315
         Left            =   3240
         Picture         =   "frmAcTypes.frx":07B2
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   3045
         Width           =   315
      End
      Begin VB.CommandButton fndParentAcTypeID 
         Height          =   315
         Left            =   3240
         Picture         =   "frmAcTypes.frx":093C
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   1845
         Width           =   315
      End
      Begin VB.ComboBox cmbNature 
         Height          =   315
         ItemData        =   "frmAcTypes.frx":0AC6
         Left            =   150
         List            =   "frmAcTypes.frx":0AD3
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   3660
         Width           =   1425
      End
      Begin VB.TextBox txtAllocationTypeID 
         Height          =   315
         Left            =   3675
         Locked          =   -1  'True
         TabIndex        =   15
         Top             =   3045
         Width           =   2940
      End
      Begin VB.TextBox txtDeductionTypeID 
         Height          =   315
         Left            =   3675
         Locked          =   -1  'True
         TabIndex        =   13
         Top             =   2475
         Width           =   2955
      End
      Begin VB.TextBox txtCostTypeID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   11
         Top             =   2445
         Width           =   3075
      End
      Begin VB.TextBox txtDepreciationTypeID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   9
         Top             =   3045
         Width           =   3090
      End
      Begin VB.TextBox txtTreeLevel 
         Enabled         =   0   'False
         Height          =   315
         Left            =   5910
         TabIndex        =   7
         Top             =   1845
         Width           =   1080
      End
      Begin VB.TextBox txtRefNo 
         Height          =   315
         Left            =   4785
         TabIndex        =   6
         Top             =   1845
         Width           =   1080
      End
      Begin VB.TextBox txtTrialOrder 
         Height          =   315
         Left            =   3675
         TabIndex        =   5
         Top             =   1845
         Width           =   1080
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   1635
         Locked          =   -1  'True
         TabIndex        =   18
         Top             =   3660
         Width           =   1590
      End
      Begin VB.TextBox txtParentAcTypeID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   1845
         Width           =   3090
      End
      Begin VB.TextBox txtCode 
         Height          =   315
         Left            =   4725
         TabIndex        =   2
         Top             =   525
         Width           =   2265
      End
      Begin VB.TextBox txtAcTypeName 
         Enabled         =   0   'False
         Height          =   315
         Left            =   150
         TabIndex        =   1
         Top             =   525
         Width           =   4140
      End
      Begin VB.Label lblReserved 
         AutoSize        =   -1  'True
         Caption         =   "Reserved"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000040C0&
         Height          =   195
         Left            =   6000
         TabIndex        =   36
         Top             =   0
         Visible         =   0   'False
         Width           =   825
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Description"
         Height          =   195
         Index           =   11
         Left            =   150
         TabIndex        =   35
         Top             =   960
         Width           =   795
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Nature"
         Height          =   195
         Index           =   10
         Left            =   150
         TabIndex        =   31
         Top             =   3450
         Width           =   480
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Allocation Type"
         Height          =   195
         Index           =   9
         Left            =   3660
         TabIndex        =   30
         Top             =   2820
         Width           =   1095
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Deduction Type"
         Height          =   195
         Index           =   8
         Left            =   3660
         TabIndex        =   29
         Top             =   2250
         Width           =   1140
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Cost Type"
         Height          =   195
         Index           =   7
         Left            =   135
         TabIndex        =   28
         Top             =   2220
         Width           =   720
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Depreciation Type"
         Height          =   195
         Index           =   6
         Left            =   150
         TabIndex        =   27
         Top             =   2820
         Width           =   1305
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Tree Level"
         Height          =   195
         Index           =   5
         Left            =   5910
         TabIndex        =   26
         Top             =   1620
         Width           =   765
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Ref No"
         Height          =   195
         Index           =   4
         Left            =   4785
         TabIndex        =   25
         Top             =   1620
         Width           =   510
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Trial Order"
         Height          =   195
         Index           =   3
         Left            =   3660
         TabIndex        =   24
         Top             =   1620
         Width           =   735
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Index           =   12
         Left            =   1635
         TabIndex        =   23
         Top             =   3450
         Width           =   450
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Parent Type"
         Height          =   195
         Index           =   2
         Left            =   150
         TabIndex        =   22
         Top             =   1620
         Width           =   870
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Code"
         Height          =   195
         Index           =   1
         Left            =   4725
         TabIndex        =   21
         Top             =   300
         Width           =   375
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Name"
         Height          =   195
         Index           =   0
         Left            =   150
         TabIndex        =   20
         Top             =   300
         Width           =   420
      End
      Begin VB.Label Label7 
         Caption         =   "Derived From"
         Height          =   15
         Left            =   0
         TabIndex        =   19
         Top             =   0
         Width           =   1695
      End
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   1100
      TabIndex        =   32
      Top             =   4350
      Width           =   6045
      _ExtentX        =   10663
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
      Left            =   15
      Top             =   4275
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
            Picture         =   "frmAcTypes.frx":0AE9
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":0C43
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":0D9D
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":0EF7
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":10D1
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":122B
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":1405
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":155F
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":2A61
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":2C3B
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmAcTypes.frx":2E15
            Key             =   "Help"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmAcTypes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mlngId As Long
Dim clsAc As New clsAcType
Dim mblnModify As Boolean
Dim mblnNew As Boolean, mIsReserved As Boolean

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
    cmbNature = " "
    lblReserved.Visible = False
End Sub

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         mlngId = 0
         txtAcTypeName.SetFocus
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
    fndAcTypeID.Enabled = Not blnNewValue
End Property

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
    clsAc.Clear
    With clsAc
        .CompanyID = mCompanyID
        .AcTypeName = Trim(txtAcTypeName)
        .AcTypeCode = Trim(txtCode)
        .ParentAcTypeID = Val(txtParentAcTypeID.Tag)
        .TrialOrder = Val(txtTrialOrder)
        .RefNo = Trim(txtRefNo)
        .TreeLevel = Val(txtTreeLevel)
        .AccDepAcTypeID = Val(txtDepreciationTypeID.Tag)
        .AccCostAcTypeID = Val(txtCostTypeID.Tag)
        .DeductionAcTypeID = Val(txtDeductionTypeID.Tag)
        .AllocationAcTypeID = Val(txtAllocationTypeID.Tag)
        .TypeNature = cmbNature
        .StatusID = IIf(Val(txtStatusID.Tag) = 0, cnstStatusActive, Val(txtStatusID.Tag))
        .IsHidden = 0
        .AcTypeDescription = Trim(txtDescription)
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
         txtDescription.SetFocus
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
    ButtonHandling Me
End Property

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID, "XAcTypeID", , fndAcTypeID, , , 1)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtAcTypeName.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtAcTypeName.Tag = mlngId
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
    Delete = clsAc.Delete(Val(txtAcTypeName.Tag))
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
        mCompanyID = .CompanyID
        txtAcTypeName = .AcTypeName
        txtDescription = .AcTypeDescription
        txtCode = .AcTypeCode
        txtParentAcTypeID.Tag = .ParentAcTypeID
        txtParentAcTypeID = .ParentAcTypeName
        txtDepreciationTypeID.Tag = .AccDepAcTypeID
        txtDepreciationTypeID = .AccDepAcTypeName
        txtCostTypeID.Tag = .AccCostAcTypeID
        txtCostTypeID = .AccCostAcTypeName
        txtDeductionTypeID.Tag = .DeductionAcTypeID
        txtDeductionTypeID = .DeductionAcTypeName
        txtAllocationTypeID.Tag = .AllocationAcTypeID
        txtAllocationTypeID = .AllocationAcTypeName
        txtTrialOrder = .TrialOrder
        txtRefNo = .RefNo
        txtTreeLevel = .TreeLevel
        Select Case Trim(.TypeNature)
            Case "Debit", "Credit"
                cmbNature = Trim(.TypeNature)
            Case Else
                cmbNature = " "
        End Select
        txtStatusID.Tag = .StatusID
        txtStatusID = .StatusName
        IsReserved = .IsReserved
    End With
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Private Sub fndAccountTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID, "Name, XAcTypeID", txtAcTypeName, fndAcTypeID, , , 1
End Sub

Private Sub fndAcTypeID_Click()
    ButtonHandling Me, "Open"
    IsReserved = lblReserved.Visible
End Sub

Private Sub fndAllocationAcTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID & " AND AT.AcTypeID <> " & Val(txtAcTypeName.Tag), "Name, XAcTypeID", txtAllocationTypeID, fndAllocationAcTypeID, , , 1
End Sub

Private Sub fndCostAcTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID & " AND AT.AcTypeID <> " & Val(txtAcTypeName.Tag), "Name, XAcTypeID", txtCostTypeID, fndCostAcTypeID, , , 1
End Sub

Private Sub fndDeductionAcTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID & " AND AT.AcTypeID <> " & Val(txtAcTypeName.Tag), "Name, XAcTypeID", txtDeductionTypeID, fndDeductionAcTypeID, , , 1
End Sub

Private Sub fndDepreciationAcTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID & " AND AT.AcTypeID <> " & Val(txtAcTypeName.Tag), "Name, XAcTypeID", txtDepreciationTypeID, fndDepreciationAcTypeID, , , 1
End Sub

Private Sub fndParentAcTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mCompanyID & " AND AT.AcTypeID <> " & Val(txtAcTypeName.Tag), "Name, XAcTypeID", txtParentAcTypeID, fndParentAcTypeID, , , 1
End Sub

Private Sub fndStatusID_Click()
    PrepareAndFind cnstSearchTypeGrpStatus, , "Name, XStatusID", txtStatusID, fndStatusID, , , 1
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    ButtonShortCuts Me, KeyCode, Shift
End Sub

Private Sub Form_Load()
    ClearValues
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub txtAllocationTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtCostTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtDeductionTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtDepreciationTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtParentAcTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub

Private Sub txtStatusID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndStatusID_Click
    End If
End Sub

Public Property Get IsReserved() As Boolean
    IsReserved = mIsReserved
End Property

Public Property Let IsReserved(ByVal vNewValue As Boolean)
    mIsReserved = vNewValue
    lblReserved.Visible = vNewValue
    If IsReserved Then
        txtParentAcTypeID.Enabled = False
        fndParentAcTypeID.Enabled = False
        txtCode.Enabled = False
        txtTrialOrder.Enabled = True
        txtRefNo.Enabled = True
        txtTreeLevel.Enabled = False
    End If
End Property
