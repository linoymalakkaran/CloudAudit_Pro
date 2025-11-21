VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmCompany 
   Caption         =   "Company"
   ClientHeight    =   7125
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7245
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7125
   ScaleWidth      =   7245
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame1 
      Height          =   6540
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   7140
      Begin VB.TextBox txtCurrencyID 
         Height          =   315
         Left            =   3795
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   1080
         Width           =   2880
      End
      Begin VB.CommandButton fndCurrencyID 
         Height          =   315
         Left            =   6675
         Picture         =   "FrmCompany.frx":0000
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   1080
         Width           =   315
      End
      Begin VB.TextBox txtCompanyName 
         Height          =   315
         Left            =   150
         MaxLength       =   100
         TabIndex        =   0
         Top             =   420
         Width           =   5040
      End
      Begin VB.TextBox txtCompanyCode 
         Height          =   315
         Left            =   5250
         MaxLength       =   20
         TabIndex        =   1
         Top             =   420
         Width           =   1740
      End
      Begin VB.Frame frameAddress 
         Caption         =   "Address"
         Height          =   1410
         Left            =   150
         TabIndex        =   26
         Top             =   1500
         Width           =   6855
         Begin VB.TextBox txtAddress1 
            Height          =   315
            Left            =   150
            MaxLength       =   100
            TabIndex        =   6
            Top             =   225
            Width           =   6570
         End
         Begin VB.TextBox txtAddress2 
            Height          =   315
            Left            =   150
            MaxLength       =   100
            TabIndex        =   7
            Top             =   600
            Width           =   6570
         End
         Begin VB.TextBox txtAddress3 
            Height          =   315
            Left            =   150
            MaxLength       =   100
            TabIndex        =   8
            Top             =   975
            Width           =   6570
         End
      End
      Begin VB.TextBox txtShortName 
         Height          =   315
         Left            =   150
         MaxLength       =   20
         TabIndex        =   2
         Top             =   1080
         Width           =   1740
      End
      Begin VB.TextBox txtPhone 
         Height          =   315
         Left            =   150
         MaxLength       =   50
         TabIndex        =   9
         Top             =   3210
         Width           =   2640
      End
      Begin VB.TextBox txtFax 
         Height          =   315
         Left            =   2850
         MaxLength       =   20
         TabIndex        =   10
         Top             =   3210
         Width           =   2340
      End
      Begin VB.TextBox txtURL 
         Height          =   315
         Left            =   2805
         MaxLength       =   40
         TabIndex        =   14
         Top             =   3870
         Width           =   4215
      End
      Begin VB.TextBox txtJobCode 
         Height          =   315
         Left            =   1965
         MaxLength       =   20
         TabIndex        =   3
         Top             =   1080
         Width           =   1740
      End
      Begin VB.TextBox txtEmail 
         Height          =   315
         Left            =   150
         MaxLength       =   40
         TabIndex        =   13
         Top             =   3870
         Width           =   2595
      End
      Begin VB.Frame frameContact 
         Caption         =   "Contact"
         Height          =   2115
         Left            =   150
         TabIndex        =   21
         Top             =   4245
         Width           =   6840
         Begin VB.TextBox txtContactName 
            Height          =   315
            Left            =   150
            MaxLength       =   30
            TabIndex        =   15
            Top             =   450
            Width           =   6540
         End
         Begin VB.TextBox txtContactDesignation 
            Height          =   315
            Left            =   150
            MaxLength       =   50
            TabIndex        =   16
            Top             =   1050
            Width           =   4290
         End
         Begin VB.TextBox txtContactEmail 
            Height          =   315
            Left            =   150
            MaxLength       =   40
            TabIndex        =   18
            Top             =   1650
            Width           =   6540
         End
         Begin VB.TextBox txtContactPhone 
            Height          =   315
            Left            =   4500
            MaxLength       =   50
            TabIndex        =   17
            Top             =   1050
            Width           =   2190
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Name"
            Height          =   195
            Index           =   8
            Left            =   150
            TabIndex        =   25
            Top             =   225
            Width           =   420
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Designation"
            Height          =   195
            Index           =   9
            Left            =   150
            TabIndex        =   24
            Top             =   825
            Width           =   840
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Email"
            Height          =   195
            Index           =   10
            Left            =   150
            TabIndex        =   23
            Top             =   1425
            Width           =   375
         End
         Begin VB.Label lblCaptions 
            AutoSize        =   -1  'True
            Caption         =   "Phone"
            Height          =   195
            Index           =   11
            Left            =   4500
            TabIndex        =   22
            Top             =   825
            Width           =   465
         End
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   5250
         Locked          =   -1  'True
         TabIndex        =   11
         Top             =   3210
         Width           =   1440
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   6675
         Picture         =   "FrmCompany.frx":018A
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   3210
         Width           =   315
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Currency"
         Height          =   195
         Index           =   13
         Left            =   3795
         TabIndex        =   36
         Top             =   870
         Width           =   630
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Company Name"
         Height          =   195
         Index           =   0
         Left            =   150
         TabIndex        =   35
         Top             =   195
         Width           =   1125
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Code"
         Height          =   195
         Index           =   2
         Left            =   5250
         TabIndex        =   34
         Top             =   195
         Width           =   375
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Short Name"
         Height          =   195
         Index           =   1
         Left            =   150
         TabIndex        =   33
         Top             =   870
         Width           =   840
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Phone"
         Height          =   195
         Index           =   3
         Left            =   150
         TabIndex        =   32
         Top             =   3000
         Width           =   465
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Fax"
         Height          =   195
         Index           =   4
         Left            =   2850
         TabIndex        =   31
         Top             =   3000
         Width           =   255
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "URL"
         Height          =   195
         Index           =   5
         Left            =   2805
         TabIndex        =   30
         Top             =   3645
         Width           =   330
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Job Code"
         Height          =   195
         Index           =   6
         Left            =   1965
         TabIndex        =   29
         Top             =   870
         Width           =   675
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Email"
         Height          =   195
         Index           =   7
         Left            =   150
         TabIndex        =   28
         Top             =   3645
         Width           =   375
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Index           =   12
         Left            =   5250
         TabIndex        =   27
         Top             =   3000
         Width           =   450
      End
   End
   Begin VB.CheckBox chkReload 
      Caption         =   "Load Templates"
      Height          =   195
      Left            =   480
      TabIndex        =   19
      Top             =   6800
      Width           =   1695
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   120
      Top             =   6480
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
            Picture         =   "FrmCompany.frx":0314
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":046E
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":05C8
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":0722
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":08FC
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":0A56
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":0C30
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":0D8A
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":228C
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":2466
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FrmCompany.frx":2640
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2400
      TabIndex        =   37
      Top             =   6720
      Width           =   4845
      _ExtentX        =   8546
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
         NumButtons      =   7
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
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmCompany"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long
Dim clsCmp As New clsCompany
Dim mlngCompanyMode As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Public Property Get IsReadOnly() As Boolean
Dim sSql As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
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
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         mCompanyID = 0
         txtCompanyName.SetFocus
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         txtCompanyName.SetFocus
         Highlight
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
End Sub

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    Frame1.Enabled = blnNewValue
End Property

Public Property Get CompanyMode() As Long
    CompanyMode = mlngCompanyMode
End Property

Public Property Let CompanyMode(ByVal vNewValue As Long)
    mlngCompanyMode = vNewValue
    Select Case mlngCompanyMode
    Case cnstCompanyModeCreate
        ClearValues
        tbrCtrls.Buttons("Modify").Enabled = False
    Case cnstCompanyModeModify
        ClearValues
        CollectValues
        tbrCtrls.Buttons("New").Enabled = False
    End Select
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Sub CollectValues()
On Error Resume Next
    clsCmp.Collect mCompanyID
    With clsCmp
        txtCompanyName = .CompanyName
        txtCompanyCode = .CompanyCode
        txtShortName = .CompanyShortName
        txtJobCode = .JobCode
        txtAddress1 = .CompanyAdd1
        txtAddress2 = .CompanyAdd2
        txtAddress3 = .CompanyAdd3
        txtPhone = .CompanyPhone
        txtFax = .CompanyFax
        txtEmail = .CompanyEmail
        txtStatusID.Tag = .StatusID
        txtStatusID = .StatusName
        txtContactName = .ContactPerson
        txtContactDesignation = .ContPerDesignation
        txtContactEmail = .ContPerEmail
        txtContactPhone = .ContPerPhone
        txtCurrencyID = .CurrencyName
        txtCurrencyID.Tag = .CurrencyID
    End With
End Sub

Private Sub fndCurrencyID_Click()
    PrepareAndFind cnstSearchTypeGrpCurrency, , "Name, XCurrencyID", txtCurrencyID, fndStatusID, , , 1
End Sub

Private Sub fndStatusID_Click()
    PrepareAndFind cnstSearchTypeGrpStatus, , "Name, XStatusID", txtStatusID, fndStatusID, , , 1
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strCompanyCode As String
    '08/02/2010, Monday -----------
    strCompanyCode = txtCompanyCode
    If mblnNew Then
        sSql = "Select * From Companies Where CompanyCode = " & "'" & strCompanyCode & "'"
        With GetRecords(sSql)
            If Not .EOF Then
                pMVE.MsgBox "Company code already exists.", msgOK, "AuditMate", msgInformation, True
                Exit Function
            End If
        End With
    End If
    clsCmp.Clear
    With clsCmp
        .CompanyName = txtCompanyName
        .CompanyCode = txtCompanyCode
        .CompanyShortName = txtShortName
        .JobCode = txtJobCode
        .CompanyAdd1 = txtAddress1
        .CompanyAdd2 = txtAddress2
        .CompanyAdd3 = txtAddress3
        .CompanyPhone = txtPhone
        .CompanyFax = txtFax
        .CompanyEmail = txtEmail
        .StatusID = IIf(Val(txtStatusID.Tag) = 0, cnstStatusActive, Val(txtStatusID.Tag))
        .ContactPerson = txtContactName
        .ContPerDesignation = txtContactDesignation
        .ContPerEmail = txtContactEmail
        .ContPerPhone = txtContactPhone
        .CurrencyID = Val(txtCurrencyID.Tag)
        Save = .Save(mCompanyID)
        RefreshCompanyAndPeriod
        If chkReload Then
            ReOrganizeCompanyDefaultData mCompanyID
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub Form_Load()
    ButtonHandling Me
    tbrCtrls.Buttons("Modify").Enabled = True
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub txtStatusID_KeyDown(KeyCode As Integer, Shift As Integer)
    TabNavigation KeyCode, Shift
End Sub
