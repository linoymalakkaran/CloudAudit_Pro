VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmPeriods 
   Caption         =   "Periods"
   ClientHeight    =   8760
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7245
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8760
   ScaleWidth      =   7245
   WindowState     =   2  'Maximized
   Begin VB.Frame framePrivileges 
      Height          =   5175
      Left            =   45
      TabIndex        =   25
      Top             =   3200
      Visible         =   0   'False
      Width           =   7150
      Begin VSFlex8Ctl.VSFlexGrid vsfgUsers 
         Height          =   2370
         Left            =   120
         TabIndex        =   26
         Top             =   2595
         Width           =   6925
         _cx             =   12215
         _cy             =   4180
         Appearance      =   2
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MousePointer    =   0
         BackColor       =   -2147483643
         ForeColor       =   -2147483640
         BackColorFixed  =   -2147483633
         ForeColorFixed  =   -2147483630
         BackColorSel    =   -2147483635
         ForeColorSel    =   -2147483634
         BackColorBkg    =   -2147483636
         BackColorAlternate=   -2147483643
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   1
         HighLight       =   2
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   4
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   300
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmPeriods.frx":0000
         ScrollTrack     =   0   'False
         ScrollBars      =   2
         ScrollTips      =   0   'False
         MergeCells      =   0
         MergeCompare    =   0
         AutoResize      =   -1  'True
         AutoSizeMode    =   0
         AutoSearch      =   0
         AutoSearchDelay =   2
         MultiTotals     =   -1  'True
         SubtotalPosition=   1
         OutlineBar      =   0
         OutlineCol      =   0
         Ellipsis        =   0
         ExplorerBar     =   0
         PicturesOver    =   0   'False
         FillStyle       =   0
         RightToLeft     =   0   'False
         PictureType     =   0
         TabBehavior     =   0
         OwnerDraw       =   0
         Editable        =   2
         ShowComboButton =   1
         WordWrap        =   0   'False
         TextStyle       =   0
         TextStyleFixed  =   0
         OleDragMode     =   0
         OleDropMode     =   0
         DataMode        =   0
         VirtualData     =   -1  'True
         DataMember      =   ""
         ComboSearch     =   3
         AutoSizeMouse   =   -1  'True
         FrozenRows      =   0
         FrozenCols      =   0
         AllowUserFreezing=   0
         BackColorFrozen =   0
         ForeColorFrozen =   0
         WallPaperAlignment=   9
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
      End
      Begin VSFlex8Ctl.VSFlexGrid vsfgRoles 
         Height          =   2400
         Left            =   120
         TabIndex        =   27
         Top             =   195
         Width           =   6925
         _cx             =   12215
         _cy             =   4233
         Appearance      =   2
         BorderStyle     =   1
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MousePointer    =   0
         BackColor       =   -2147483643
         ForeColor       =   -2147483640
         BackColorFixed  =   -2147483633
         ForeColorFixed  =   -2147483630
         BackColorSel    =   -2147483635
         ForeColorSel    =   -2147483634
         BackColorBkg    =   -2147483636
         BackColorAlternate=   -2147483643
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   1
         HighLight       =   2
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   4
         FixedRows       =   1
         FixedCols       =   1
         RowHeightMin    =   330
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmPeriods.frx":0085
         ScrollTrack     =   0   'False
         ScrollBars      =   1
         ScrollTips      =   0   'False
         MergeCells      =   0
         MergeCompare    =   0
         AutoResize      =   -1  'True
         AutoSizeMode    =   0
         AutoSearch      =   0
         AutoSearchDelay =   2
         MultiTotals     =   -1  'True
         SubtotalPosition=   1
         OutlineBar      =   0
         OutlineCol      =   0
         Ellipsis        =   0
         ExplorerBar     =   0
         PicturesOver    =   0   'False
         FillStyle       =   0
         RightToLeft     =   0   'False
         PictureType     =   0
         TabBehavior     =   0
         OwnerDraw       =   0
         Editable        =   2
         ShowComboButton =   1
         WordWrap        =   -1  'True
         TextStyle       =   0
         TextStyleFixed  =   0
         OleDragMode     =   0
         OleDropMode     =   0
         DataMode        =   0
         VirtualData     =   -1  'True
         DataMember      =   ""
         ComboSearch     =   3
         AutoSizeMouse   =   -1  'True
         FrozenRows      =   0
         FrozenCols      =   0
         AllowUserFreezing=   0
         BackColorFrozen =   0
         ForeColorFrozen =   0
         WallPaperAlignment=   9
         AccessibleName  =   ""
         AccessibleDescription=   ""
         AccessibleValue =   ""
         AccessibleRole  =   24
      End
   End
   Begin AIFCmp1.asxPowerButton cmdUserPrivileges 
      Height          =   375
      Left            =   45
      TabIndex        =   24
      Top             =   2760
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
      Caption         =   "User Privilege Settings"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton fndPeriodID 
      Height          =   315
      Left            =   4350
      Picture         =   "frmPeriods.frx":0109
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   500
      Width           =   315
   End
   Begin VB.Frame frameDetails 
      Height          =   2295
      Left            =   45
      TabIndex        =   0
      Top             =   -30
      Width           =   7155
      Begin VB.CommandButton fndComparePeriodID 
         Height          =   315
         Left            =   6675
         Picture         =   "frmPeriods.frx":0293
         Style           =   1  'Graphical
         TabIndex        =   14
         Top             =   1725
         Width           =   315
      End
      Begin VB.TextBox txtComparePeriodID 
         Height          =   315
         Left            =   3600
         Locked          =   -1  'True
         TabIndex        =   15
         Top             =   1725
         Width           =   3090
      End
      Begin VB.CommandButton fndDerivedPeriodID 
         Height          =   315
         Left            =   3225
         Picture         =   "frmPeriods.frx":041D
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   1725
         Width           =   315
      End
      Begin VB.TextBox txtDerivedPeriodID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   13
         Top             =   1725
         Width           =   3090
      End
      Begin VB.TextBox txtStatusID 
         Height          =   315
         Left            =   5325
         Locked          =   -1  'True
         TabIndex        =   11
         Top             =   1125
         Width           =   1365
      End
      Begin VB.CommandButton fndStatusID 
         Height          =   315
         Left            =   6675
         Picture         =   "frmPeriods.frx":05A7
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   1125
         Width           =   315
      End
      Begin MSComCtl2.DTPicker dtpStartDt 
         Height          =   315
         Left            =   2625
         TabIndex        =   8
         Top             =   1125
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   556
         _Version        =   393216
         Format          =   106496001
         CurrentDate     =   39814
         MinDate         =   -108841
      End
      Begin VB.CommandButton fndAuditTypeID 
         Height          =   315
         Left            =   2250
         Picture         =   "frmPeriods.frx":0731
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   1125
         Width           =   315
      End
      Begin VB.TextBox txtAuditTypeID 
         Height          =   315
         Left            =   150
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   1125
         Width           =   2115
      End
      Begin VB.TextBox txtShortName 
         Height          =   315
         Left            =   4725
         TabIndex        =   5
         Top             =   525
         Width           =   2265
      End
      Begin VB.TextBox txtDescription 
         Height          =   315
         Left            =   150
         TabIndex        =   4
         Top             =   525
         Width           =   4140
      End
      Begin MSComCtl2.DTPicker dtpEndDt 
         Height          =   315
         Left            =   3975
         TabIndex        =   9
         Top             =   1125
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   556
         _Version        =   393216
         Format          =   106496001
         CurrentDate     =   40178
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Compare with"
         Height          =   195
         Index           =   6
         Left            =   3600
         TabIndex        =   22
         Top             =   1500
         Width           =   960
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Derived from"
         Height          =   195
         Index           =   5
         Left            =   150
         TabIndex        =   21
         Top             =   1500
         Width           =   900
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Index           =   12
         Left            =   5325
         TabIndex        =   20
         Top             =   900
         Width           =   450
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "End Date"
         Height          =   195
         Index           =   4
         Left            =   3975
         TabIndex        =   19
         Top             =   900
         Width           =   675
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Start Date"
         Height          =   195
         Index           =   3
         Left            =   2625
         TabIndex        =   18
         Top             =   900
         Width           =   720
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Audit Type"
         Height          =   195
         Index           =   2
         Left            =   150
         TabIndex        =   17
         Top             =   900
         Width           =   765
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Short Name"
         Height          =   195
         Index           =   1
         Left            =   4725
         TabIndex        =   16
         Top             =   300
         Width           =   840
      End
      Begin VB.Label lblCaptions 
         AutoSize        =   -1  'True
         Caption         =   "Description"
         Height          =   195
         Index           =   0
         Left            =   150
         TabIndex        =   3
         Top             =   300
         Width           =   795
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
      Top             =   2310
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
      Left            =   120
      Top             =   2160
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
            Picture         =   "frmPeriods.frx":08BB
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":0A15
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":0B6F
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":0CC9
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":0EA3
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":0FFD
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":11D7
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":1331
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":2833
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":2A0D
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmPeriods.frx":2BE7
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrlsNew 
      Height          =   330
      Left            =   3600
      TabIndex        =   28
      Top             =   8400
      Visible         =   0   'False
      Width           =   3600
      _ExtentX        =   6350
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
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmPeriods"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mlngId As Long
Dim clsPer As New clsPeriod
Dim mblnModify As Boolean, mblnNew As Boolean
Dim mblnModifyNew As Boolean, mblnNewNew As Boolean


Const grdPartners = 0
Const grdManagers = 1
Const grdAuditors = 2
Const grdAuditAssistants = 3

Dim mlngUserID As Long
Dim cggRoles As New clsGridGroup

Const grdRole = 0
Const grdUsers = 1
Const grdAllowModify = 2
Const grdRoleUserID = 3
Const grdRolesUserID = 4

Const grdUserSlNo = 0
Const grdUserName = 1
Const grdUserIsBlock = 2
Const grdUserID = 3
Const grdUserCols = 4

Const grdPrvAccess = 0
Const grdPrvIsAllowd = 1
Const grdPrvAccessID = 2

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql2 As String, sSql3 As String
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
    sSql2 = "Select * From UserGroupUsers Where UserID = " & pUserID
        With GetRecords(sSql2)
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

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         mlngId = 0
         
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsNewNew() As Boolean
    IsNewNew = mblnNewNew
End Property

Public Property Let IsNewNew(ByVal blnNewValue As Boolean)
    mblnNewNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    mblnModify = blnNewValue
End Property

Public Property Get IsModifyNew() As Boolean
    IsModifyNew = mblnModifyNew
End Property

Public Property Let IsModifyNew(ByVal blnNewValue As Boolean)
    mblnModifyNew = blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    dtpStartDt = ServerDateTime
    dtpEndDt = ServerDateTime
End Sub

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
    fndPeriodID.Enabled = Not blnNewValue
End Property

Public Property Let EnableAllNew(ByVal blnNewValue As Boolean)
    vsfgRoles.Enabled = blnNewValue
    vsfgUsers.Enabled = blnNewValue
'    vsfgPrivileges.Enabled = blnNewValue
End Property

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
    clsPer.Clear
    With clsPer
        .CompanyID = mCompanyID
        .AuditType = Val(txtAuditTypeID.Tag)
        .Description = txtDescription
        .ShortName = txtShortName
        .ComparePeriodID = Val(txtComparePeriodID.Tag)
        .DerivedPeriodID = Val(txtDerivedPeriodID.Tag)
        .StartDt = dtpStartDt
        .EndDt = dtpEndDt
        .StatusID = IIf(Val(txtStatusID.Tag) = 0, cnstStatusActive, Val(txtStatusID.Tag))
        Save = .Save(mlngId)
        If Save Then
            UpdateSubSectionData mlngId, Val(txtDerivedPeriodID.Tag)
        End If
        RefreshCompanyAndPeriod
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub cmdUserPrivileges_Click()
'    ShowFormInMDI "frmUserPrivileges", "User Privileges", , pActivePeriodID
    frameDetails.Enabled = False
    framePrivileges.Visible = True
    tbrCtrlsNew.Visible = True
    tbrCtrls.Buttons("New").Enabled = False
    tbrCtrls.Buttons("Modify").Enabled = False
    tbrCtrls.Buttons("Delete").Enabled = False
    tbrCtrls.Buttons("Save").Enabled = False
    tbrCtrls.Buttons("Close").Enabled = False
    ButtonHandlingNew Me
    LoadRoles
'    LoadUserAccess
    ValueCollectNew
End Sub

Private Sub fndAuditTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpAuditType, , "Name, XAuditTypeID", txtAuditTypeID, fndAuditTypeID, , , 1
End Sub

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
    ButtonHandling Me
End Property

Private Sub fndComparePeriodID_Click()
    PrepareAndFind cnstSearchTypeGrpPeriods, "Where PER.CompanyID = " & mCompanyID & " AND PER.PeriodID <> " & mlngId, "Name, XPeriodID", txtComparePeriodID, fndComparePeriodID
End Sub

Private Sub fndDerivedPeriodID_Click()
    PrepareAndFind cnstSearchTypeGrpPeriods, "Where PER.CompanyID = " & mCompanyID & " AND PER.PeriodID <> " & mlngId, "Name, XPeriodID", txtDerivedPeriodID, fndDerivedPeriodID
End Sub

Private Sub fndPeriodID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
    Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpPeriods, "Where PER.CompanyID = " & mCompanyID, "XPeriodID", , fndPeriodID)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtDescription.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtDescription.Tag = mlngId
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
    Delete = clsPer.Delete(Val(txtDescription.Tag))
Exit Function
Err_Exit:
    Delete = False
    ShowError
End Function

Public Function ValueCollect(ByVal lngID As Long) As Boolean
On Error GoTo Err_Exit
Dim sSql As String
    clsPer.Clear
    clsPer.Collect lngID
    With clsPer
        txtDescription = .Description
        txtAuditTypeID = .AuditTypeName
        txtAuditTypeID.Tag = .AuditType
        txtShortName = .ShortName
        dtpStartDt = .StartDt
        dtpEndDt = .EndDt
        txtStatusID = .StatusName
        txtStatusID.Tag = .StatusID
        txtDerivedPeriodID = .DerivedPeriodShortName
        txtDerivedPeriodID.Tag = .DerivedPeriodID
        txtComparePeriodID = .ComparePeriodShortName
        txtComparePeriodID.Tag = .ComparePeriodID
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

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub tbrCtrlsNew_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandlingNew Me, Button.Key
    tbrCtrls.Enabled = False
End Sub

Private Sub txtAuditTypeID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndAuditTypeID_Click
    End If
End Sub

Private Sub txtComparePeriodID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndComparePeriodID_Click
    End If
End Sub

Private Sub txtDerivedPeriodID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndDerivedPeriodID_Click
    End If
End Sub

Private Sub txtStatusID_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        TabNavigation KeyCode, Shift
    ElseIf KeyCode = vbKeyReturn Then
        fndStatusID_Click
    End If
End Sub

Public Sub LoadRoles()
On Local Error GoTo Err_Exit
Dim sSql As String, lngRowHeight As Long, crsRoles As New clsRecordSet, Inc As Long
    sSql = "SELECT UserGroupID, UserGroupName From UserGroups ORDER BY OrderField"
    crsRoles.BindRecords sSql, AdoConn
    With crsRoles
        lngRowHeight = 2040 / IIf(.Rows = 0, 1, .Rows)
        vsfgRoles.Rows = 1
        While Not .EOF
            vsfgRoles.Rows = vsfgRoles.Rows + 1
            Inc = vsfgRoles.Rows - 1
            vsfgRoles.TextMatrix(Inc, grdRole) = .Fields("UserGroupName") & ""
            vsfgRoles.TextMatrix(Inc, grdRoleUserID) = Val(.Fields("UserGroupID") & "")
            vsfgRoles.RowHeight(Inc) = lngRowHeight
            cggRoles.AddItem Inc
            .MoveNext
        Wend
        .Clear
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

'Public Sub LoadUserAccess()
'On Local Error GoTo Err_Exit
'Dim sSql As String, crsAccess As New clsRecordSet, Inc As Long
'    sSql = "SELECT UserID, IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID
'    crsAccess.BindRecords sSql, AdoConn
'    With crsAccess
''        vsfgUsers.Rows = 1
''        vsfgUsers.Cols = grdUserCols
'        While Not .EOF
''            vsfgPrivileges.Rows = vsfgPrivileges.Rows + 1
''            Inc = vsfgPrivileges.Rows - 1
''            vsfgPrivileges.TextMatrix(Inc, grdPrvAccess) = .Fields("UserAccessName") & ""
''            vsfgPrivileges.TextMatrix(Inc, grdPrvAccessID) = Val(.Fields("UserAccessID") & "")
''            vsfgPrivileges.TextMatrix(Inc, grdPrvIsAllowd) = 1
'
'            vsfgUsers.Cols = grdUserCols
'            vsfgUsers.Rows = vsfgUsers.Rows + 1
'            Inc = vsfgUsers.Rows - 1
'            vsfgUsers.TextMatrix(Inc, grdUserIsBlock) = IIf(.Fields("IsBlocked") & "" = "True", -1, 0)
'            vsfgUsers.ColDataType(grdUserIsBlock) = flexDTBoolean
''            vsfgUsers.ColHidden(vsfgUsers.Cols - 1) = True
'            .MoveNext
'        Wend
'        .Clear
'    End With
'Exit Sub
'Err_Exit:
'    ShowError
'End Sub

Public Sub ValueCollectNew()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, lngRow As Long, Inc1 As Long
'    sSql = "SELECT   UPS.UserAccessID, UPS.IsAllowed, UM.UserID, UM.UserName, UGS.UserGroupID " & _
'           "FROM     UserPrivilegesSub UPS INNER JOIN Users UM ON UPS.UserID = UM.UserID INNER JOIN " & _
'           "         UserGroupUsers UGS ON UM.UserID = UGS.UserID INNER JOIN UserGroups UG ON UGS.UserGroupID = UG.UserGroupID " & _
'           "Where    UPS.PeriodID = " & pActivePeriodID & " " & _
'           "ORDER BY UG.OrderField"
    sSql = "SELECT     UM.UserID, UM.UserName, UGS.UserGroupID, UserPrivileges.PeriodID, UserPrivileges.IsBlocked " & _
           "FROM       Users AS UM INNER JOIN UserGroupUsers AS UGS ON UM.UserID = UGS.UserID INNER JOIN " & _
           "           UserGroups AS UG ON UGS.UserGroupID = UG.UserGroupID INNER JOIN UserPrivileges ON UM.UserID = UserPrivileges.UserID " & _
           "Where      UserPrivileges.PeriodID = " & pActivePeriodID & " ORDER BY UG.OrderField"
    With GetRecords(sSql)
        While Not .EOF
            For Inc = 1 To vsfgRoles.Rows - 1
                lngRow = GetUserRow(cggRoles.cgGrid(Inc), Val(.Fields("UserID") & ""))
                If Val(.Fields("UserGroupID") & "") = vsfgRoles.ValueMatrix(Inc, grdRoleUserID) Then
                    If lngRow = 0 Then
                        cggRoles.cgGrid(Inc).Rows = cggRoles.cgGrid(Inc).Rows + 1
                        lngRow = cggRoles.cgGrid(Inc).Rows - 1
                        cggRoles.cgGrid(Inc).Cols = vsfgUsers.Cols
                    End If
                    cggRoles.cgGrid(Inc).TextMatrix(lngRow, grdUserID) = Val(.Fields("UserID") & "")
                    cggRoles.cgGrid(Inc).TextMatrix(lngRow, grdUserName) = .Fields("UserName") & ""

'                    For Inc1 = grdUserCols To vsfgUsers.Cols - 1
'                        If Val(vsfgUsers.ColKey(Inc1)) = Val(.Fields("UserAccessID") & "") Then
'                            cggRoles.cgGrid(Inc).TextMatrix(lngRow, Inc1) = IIf(.Fields("IsBlocked") & "" = "True", -1, 0)
'                            Exit For
'                        End If
'                    Next Inc1
                End If
            Next Inc
            .MoveNext
        Wend
        .Close
    End With
    SetAllRoleUserNames
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub SetAllRoleUserNames()
On Local Error Resume Next
Dim Inc As Long, Inc1 As Long, strUsers As String
    For Inc = 1 To vsfgRoles.Rows - 1
        strUsers = ""
        With cggRoles.cgGrid(Inc)
            For Inc1 = 1 To .Rows - 1
                If Trim(.TextMatrix(Inc1, grdUserName)) <> "" Then
                    strUsers = strUsers & .TextMatrix(Inc1, grdUserName) & ", "
                End If
            Next Inc1
            If Len(strUsers) > 0 Then strUsers = Left(strUsers, Len(strUsers) - 2)
        End With
        vsfgRoles.TextMatrix(Inc, grdUserName) = strUsers
    Next Inc
End Sub

Public Function GetUserRow(cg As clsGrid, lngUserID As Long) As Long
On Local Error GoTo Err_Exit
Dim Inc As Long
    With cg
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdUserID) = lngUserID Then
                GetUserRow = Inc
                Exit Function
            End If
        Next Inc
    End With
    GetUserRow = 0
Exit Function
Err_Exit:
    GetUserRow = 0
End Function

Public Function GetUserList() As String
On Local Error GoTo Err_Exit
Dim Inc As Long, strGetList As String
    With vsfgUsers
        strGetList = "0"
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdUserID) <> 0 Then
                strGetList = strGetList & ", " & .ValueMatrix(Inc, grdUserID)
            End If
        Next Inc
    End With
    GetUserList = strGetList
Exit Function
Err_Exit:
    GetUserList = "0"
End Function

Public Function GetUserNameList() As String
On Local Error GoTo Err_Exit
Dim Inc As Long, strGetList As String
    With vsfgUsers
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdUserID) <> 0 Then
                strGetList = strGetList & .TextMatrix(Inc, grdUserName) & ", "
            End If
        Next Inc
    End With
    If Len(strGetList) > 0 Then strGetList = Left(strGetList, Len(strGetList) - 2)
    GetUserNameList = strGetList
Exit Function
Err_Exit:
    GetUserNameList = ""
End Function

Private Sub vsfgRoles_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
On Local Error GoTo Err_Exit
Dim strUserIDs As String, strUsers As String
    If Row > 0 Then
        strUserIDs = PrepareAndFind(cnstSearchTypeGrpUserName, "Where UserID Not IN (" & GetUserList & ")  AND StatusID = " & cnstStatusActive & "  AND UserID IN(Select UserID From UserGroupUsers Where UserGroupID = " & vsfgRoles.ValueMatrix(Row, grdRoleUserID) & ")", , , , , , , True, "XUserID")
        strUsers = FillUsers(strUserIDs)
        vsfgRoles.TextMatrix(Row, Col) = strUsers
        vsfgRoles_LeaveCell
        vsfgUsers_EnterCell
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgRoles_EnterCell()
On Local Error Resume Next
    If vsfgRoles.Row > 0 Then
        WriteUserAccess vsfgRoles.Row
    End If
End Sub

Public Sub ReadUserAccess(lngRow As Long)
On Local Error GoTo Err_Exit
    vsfgRoles.TextMatrix(lngRow, grdUsers) = GetUserNameList
    cggRoles.cgGrid(lngRow).GetValuesFromGrid vsfgUsers
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub WriteUserAccess(lngRow As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    With cggRoles.cgGrid(lngRow)
        vsfgUsers.Rows = 1
        If .Rows > 1 Then
            .SetValuesToGrid vsfgUsers, True
        End If
    End With
    For Inc = 1 To vsfgUsers.Rows - 1
        sSql = "SELECT UserID, IsBlocked From UserPrivileges Where UserID = " & vsfgUsers.TextMatrix(Inc, grdUserID) & " And PeriodID = " & pActivePeriodID
            With GetRecords(sSql)
                If Not .EOF Then
                    vsfgUsers.TextMatrix(Inc, grdUserIsBlock) = IIf(.Fields("IsBlocked") & "" = "True", -1, 0)
                End If
            End With
    Next Inc
    vsfgUsers_EnterCell
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgRoles_GotFocus()
    vsfgRoles_EnterCell
End Sub

Private Sub vsfgRoles_LeaveCell()
On Local Error Resume Next
    If vsfgRoles.Row > 0 Then
        ReadUserAccess vsfgRoles.Row
    End If
End Sub

Private Sub vsfgRoles_RowColChange()
    SelectRow vsfgRoles, , , RGB(230, 230, 255)
End Sub

Private Sub vsfgUsers_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error GoTo Err_Exit
    If Row > 1 Then
        Select Case Col
            Case grdUserSlNo, grdUserName
                Cancel = True
            Case grdUserIsBlock
                Cancel = False
        End Select
    End If
Exit Sub
Err_Exit:
    
End Sub

'Public Sub ReadUserPrivileges(lngRow As Long)
''On Local Error Resume Next
'Dim Inc As Long
'    With vsfgPrivileges
'        For Inc = 1 To .Rows - 1
'            vsfgUsers.TextMatrix(lngRow, (grdUserCols + Inc) - 1) = .ValueMatrix(Inc, grdPrvIsAllowd)
'        Next Inc
'    End With
'End Sub
'
'Public Sub WriteUserPrivileges(lngRow As Long)
''On Local Error Resume Next
'Dim Inc As Long
'    With vsfgUsers
'        frameAccess.Caption = .TextMatrix(lngRow, grdUserName)
'        mlngUserID = .TextMatrix(lngRow, grdUserID)
'        For Inc = grdUserCols To .Cols - 1
'            vsfgPrivileges.TextMatrix((Inc - grdUserCols) + 1, grdPrvIsAllowd) = 1 '.ValueMatrix(lngRow, Inc)
'        Next Inc
'    End With
'End Sub

Public Function FillUsers(strUserIDs As String) As String
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strUser As String
Dim arrUserIDs() As String
    If Trim(strUserIDs) = "-1" Then strUserIDs = "0"
    strUserIDs = Replace(strUserIDs, "|", ",")
    arrUserIDs = Split(strUserIDs, ",")

    sSql = "SELECT DISTINCT UM.UserName, UM.UserID FROM Users UM INNER JOIN UserGroupUsers UG ON UM.UserID = UG.UserID " & _
           "WHERE (UM.UserID IN (" & strUserIDs & "))  AND (UM.StatusID = " & cnstStatusActive & ")"
        With GetRecords(sSql)
            While Not .EOF
                vsfgUsers.Rows = vsfgUsers.Rows + 1
                Inc = vsfgUsers.Rows - 1
                
                vsfgUsers.TextMatrix(Inc, grdUsers) = .Fields("UserName") & ""
                vsfgUsers.TextMatrix(Inc, grdUserID) = Val(.Fields("UserID") & "")

'                FillUserPrivileges Inc
                .MoveNext
            Wend
            PutSlNo vsfgUsers, grdUserSlNo, grdUserID
            
            For Inc = 1 To vsfgUsers.Rows - 1
                strUser = strUser & vsfgUsers.TextMatrix(Inc, grdUsers) & ", "
            Next
            
            If Len(strUser) > 0 Then strUser = Left(strUser, Len(strUser) - 2)
            FillUsers = strUser
        End With
Exit Function
Err_Exit:
    FillUsers = ""
    ShowError
End Function
'
'Public Sub FillUserPrivileges(lngRow As Long)
'On Local Error Resume Next
'Dim sSql As String, Inc As Long
'    sSql = "SELECT UAD.UserAccessID, UAD.IsAllowed FROM UserGroupUsers UGU INNER JOIN UserAccessDefaults UAD ON UGU.UserGroupID = UAD.UserGroupID " & _
'           "Where UGU.UserID = " & vsfgUsers.ValueMatrix(lngRow, grdUserID)
'    With GetRecords(sSql)
'        While Not .EOF
'            For Inc = grdUserCols To vsfgUsers.Cols - 1
'                If Val(vsfgUsers.ColKey(Inc)) = Val(.Fields("UserAccessID") & "") Then
'                    vsfgUsers.TextMatrix(lngRow, Inc) = IIf(.Fields("IsAllowed") & "" = "True", -1, 0)
'                End If
'            Next Inc
'            .MoveNext
'        Wend
'        .Close
'    End With
'
'    sSql = "SELECT UserAccessID, IsAllowed From UserPrivilegesSub Where UserID = " & vsfgUsers.ValueMatrix(lngRow, grdUserID) & " And PeriodID = " & pActivePeriodID
'    With GetRecords(sSql)
'        While Not .EOF
'            For Inc = grdUserCols To vsfgUsers.Cols - 1
'                If Val(vsfgUsers.ColKey(Inc)) = Val(.Fields("UserAccessID") & "") Then
'                    vsfgUsers.TextMatrix(lngRow, Inc) = IIf(.Fields("IsAllowed") & "" = "True", -1, 0)
'                End If
'            Next Inc
'            .MoveNext
'        Wend
'        .Close
'    End With
'End Sub

Private Sub vsfgUsers_EnterCell()
On Local Error Resume Next
    If vsfgUsers.Row <= 0 Then vsfgUsers.Row = 1
    If vsfgUsers.Row > 0 Then
        PutSlNo vsfgUsers, grdUserSlNo, grdUserName
'        WriteUserPrivileges vsfgUsers.Row
    End If
End Sub

Private Sub vsfgUsers_GotFocus()
    vsfgUsers_EnterCell
End Sub

Private Sub vsfgUsers_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error GoTo Err_Exit
    If KeyCode = vbKeyDelete Then
        If vsfgUsers.Row > 0 And vsfgRoles.Row > 0 Then
            vsfgUsers.RemoveItem vsfgUsers.Row
            PutSlNo vsfgUsers, grdUserSlNo, grdUserName
            ReadUserAccess vsfgRoles.Row
        End If
    End If
Exit Sub
Err_Exit:
   ShowError
End Sub

'Private Sub vsfgUsers_LeaveCell()
'On Local Error Resume Next
'    If vsfgUsers.Row > 0 Then
'        ReadUserPrivileges vsfgUsers.Row
'    End If
'End Sub

Private Sub vsfgUsers_RowColChange()
    SelectRow vsfgUsers, , , RGB(220, 220, 255)
End Sub

Public Function SaveNew() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, Inc1 As Long, Inc2 As Long
Dim rsTmp As New ADODB.Recordset, rsTmp1 As New ADODB.Recordset
    AdoConn.BeginTrans
'    sSql = "Delete From UserPrivileges Where PeriodID = " & pActivePeriodID
'    AdoConn.Execute sSql
'    sSql = "Select * From UserPrivileges Where 1=2"
'    Set rsTmp1 = GetRecords(sSql)
'    For Inc = 1 To vsfgRoles.Rows - 1
'        If vsfgRoles.ValueMatrix(Inc, grdRoleUserID) <> 0 Then
'            rsTmp1.AddNew
'            rsTmp1.Fields("PeriodID") = pActivePeriodID
'            rsTmp1.Fields("UserID") = vsfgRoles.ValueMatrix(Inc, grdRoleUserID)
'            rsTmp1.Fields("IsBlocked") = vsfgRoles.ValueMatrix(Inc, grdAllowModify)
'            rsTmp1.Update
'        End If
'    Next Inc
    sSql = "Delete From UserPrivileges Where PeriodID = " & pActivePeriodID
    AdoConn.Execute sSql
    sSql = "Select * From UserPrivileges Where 1=2"
    Set rsTmp = GetRecords(sSql)
    For Inc = 1 To vsfgRoles.Rows - 1
        With cggRoles.cgGrid(Inc)
            For Inc1 = 1 To .Rows - 1
                If .ValueMatrix(Inc1, grdUserID) <> 0 Then
                    rsTmp.AddNew
                    rsTmp.Fields("UserID") = .ValueMatrix(Inc1, grdUserID)
                    rsTmp.Fields("PeriodID") = pActivePeriodID
                    rsTmp.Fields("IsBlocked") = vsfgUsers.ValueMatrix(Inc1, grdUserIsBlock)
                    rsTmp.Update
                End If
            Next Inc1
        End With
    Next Inc
    AdoConn.CommitTrans
    SaveNew = True
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
    SaveNew = False
End Function
