VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmFixedAssetSchedule 
   Caption         =   "Fixed Asset Schedule"
   ClientHeight    =   7740
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7065
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7740
   ScaleMode       =   0  'User
   ScaleWidth      =   7138.136
   WindowState     =   2  'Maximized
   Begin VB.CheckBox chkFinishGroup 
      Caption         =   "Finish Group"
      Height          =   390
      Left            =   4320
      TabIndex        =   15
      Top             =   120
      Width           =   1260
   End
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmFixedAssetSchedule.frx":0000
      Left            =   1125
      List            =   "frmFixedAssetSchedule.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   150
      Width           =   3060
   End
   Begin VB.CheckBox chkFinished 
      Caption         =   "Finished"
      Height          =   390
      Left            =   75
      TabIndex        =   11
      Top             =   7260
      Width           =   900
   End
   Begin VB.Frame Frame1 
      Caption         =   "Current year balance from trial balance"
      Height          =   915
      Left            =   120
      TabIndex        =   6
      Top             =   6195
      Width           =   6870
      Begin VB.TextBox txtAccDep 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   4605
         Locked          =   -1  'True
         TabIndex        =   8
         Top             =   345
         Width           =   2085
      End
      Begin VB.TextBox txtCost 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   915
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   345
         Width           =   2085
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Depreciation"
         Height          =   195
         Left            =   3495
         TabIndex        =   10
         Top             =   405
         Width           =   900
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Cost"
         Height          =   195
         Left            =   390
         TabIndex        =   9
         Top             =   405
         Width           =   315
      End
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgAssetTree 
      Height          =   4870
      Left            =   105
      TabIndex        =   5
      Top             =   1170
      Width           =   6885
      _cx             =   12144
      _cy             =   8590
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
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   17
      Cols            =   5
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   285
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmFixedAssetSchedule.frx":0004
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
      ExplorerBar     =   5
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
   Begin VB.TextBox txtNoteNo 
      Height          =   315
      Left            =   4020
      TabIndex        =   4
      Top             =   765
      Width           =   1275
   End
   Begin VB.TextBox txtAcType 
      Height          =   315
      Left            =   75
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   765
      Width           =   3540
   End
   Begin VB.CommandButton fndAcID 
      Height          =   315
      Left            =   3630
      Picture         =   "frmFixedAssetSchedule.frx":00AE
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   765
      Width           =   315
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2130
      TabIndex        =   12
      Top             =   7290
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
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            Object.Width           =   50
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Print"
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            Object.Tag             =   "Print"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   960
      Top             =   7215
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
            Picture         =   "frmFixedAssetSchedule.frx":0238
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":0392
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":04EC
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":0646
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":0820
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":097A
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":0B54
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":0CAE
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":21B0
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":238A
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":2564
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFixedAssetSchedule.frx":273E
            Key             =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   90
      TabIndex        =   14
      Top             =   210
      Width           =   960
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Note No"
      Height          =   195
      Left            =   4035
      TabIndex        =   3
      Top             =   540
      Width           =   600
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Account Type"
      Height          =   195
      Left            =   105
      TabIndex        =   2
      Top             =   540
      Width           =   1005
   End
End
Attribute VB_Name = "frmFixedAssetSchedule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean, lngCostAcTypeID As Long, lngDepreciationAcTypeID As Long, lngParentAcTypeID As Long
Dim mStartDt As Date, mEndDt As Date, mLaststartDt As Date, mLastEndDt As Date

Const grdSlNo = 0
Const grdParticulars = 1
Const grdValues = 2
Const grdItemID = 3
Const grdAcID = 4

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
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

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
   fndAcID.Enabled = Not blnNewValue
   txtNoteNo.Enabled = blnNewValue
   txtCost.Enabled = blnNewValue
   txtAccDep.Enabled = blnNewValue
   chkFinished.Enabled = blnNewValue
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
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
         vsfgAssetTree.SetFocus
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
Dim sSql As String
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    If mCompanyID <= 0 Then
        mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
        sSql = "SELECT  PeriodID AS IDField, ShortName + '  ' + Convert(varchar,CONVERT(DateTime, StartDt - 2, 103),103) + ' - ' + Convert(Varchar,CONVERT(DateTime, EndDt - 2, 103),103) AS NameField " & _
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " ORDER BY StartDt DESC"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
    GetDate mPeriodID
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub ClearValues()
    txtNoteNo = ""
    vsfgAssetTree.Rows = 1: vsfgAssetTree.Rows = 1
    txtCost = ""
    txtAccDep = ""
    chkFinished = vbUnchecked
End Sub

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub fndAcID_Click()
    ButtonHandling Me, "Open"
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountTypes, "WHERE AT.ParentAcTypeID IN(Select AT1.AcTypeID From AcTypes AT1 Where AT1.IsFixedAssetParent = 1 AND AT.CompanyID = " & mCompanyID & ") ", "XAcTypeID", , fndAcID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtAcType.Tag = lngID
        End If
    Else
        strRslt = lngID
        txtAcType.Tag = lngID
    End If
    Select Case strRslt
        Case "-1", ""
            ShowOpen = False
        Case Else
            txtAcType = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
            lngCostAcTypeID = Val(PickValue("AcTypes", "AccCostAcTypeID", "AcTypeID = " & lngID))
            lngDepreciationAcTypeID = Val(PickValue("AcTypes", "AccDepAcTypeID", "AcTypeID = " & lngID))
            lngParentAcTypeID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngID))
            If lngCostAcTypeID = 0 Then
                ShowOpen = False
                pMVE.MsgBox "Cost Type Not Mentioned.", msgOK, "AuditMate", msgCritical, True
                Exit Function
            End If
            If lngDepreciationAcTypeID = 0 Then
                ShowOpen = False
                pMVE.MsgBox "Depreciation Type Not Mentioned.", msgOK, "AuditMate", msgCritical, True
                Exit Function
            End If
            ShowOpen = FillSchedule(lngID)
            ShowOpen = True
    End Select
End Function

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsTran As Boolean, sSql As String, lngAcTypeID As Long, Inc As Integer, dblBalSheetAmount As Double
Dim rsSave As New Recordset
    lngAcTypeID = Val(txtAcType.Tag)
    If vsfgAssetTree.ValueMatrix(6, grdValues) <> RVal(txtCost) Then
        pMVE.MsgBox "Cost Amount Not Matching with Trial Balance.", msgOK, "AuditMate", msgCritical, True
        Exit Function
    End If
    If vsfgAssetTree.ValueMatrix(12, grdValues) <> RVal(txtAccDep) Then
        pMVE.MsgBox "Depreciation Amount Not Matching with Trial Balance.", msgOK, "AuditMate", msgCritical, True
        Exit Function
    End If
    '-----------------------------------------------------------------------------------
    AdoConn.BeginTrans
    IsTran = True
    sSql = "Delete from FixedAssetSchedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID
    AdoConn.Execute sSql
    If IsValidDoc Then
        sSql = "Select * From FixedAssetSchedules Where 1 = 2"
        With GetRecords(sSql)
            For Inc = 1 To vsfgAssetTree.Rows - 1
                If Trim(vsfgAssetTree.TextMatrix(Inc, 1)) <> "" Then
                .AddNew
                .Fields("AcTypeID") = lngAcTypeID
                .Fields("PeriodID") = mPeriodID
                .Fields("ItemID") = vsfgAssetTree.TextMatrix(Inc, grdItemID)
                .Fields("IsFinished") = chkFinished                         'IIf(chkFinished = vbChecked, True, False)
                .Fields("Amount") = vsfgAssetTree.ValueMatrix(Inc, grdValues)
                .Update
                End If
            Next
        End With
    End If
    sSql = "Delete From Schedules Where AcTypeID = " & lngAcTypeID & " And PeriodID  = " & mPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeFixedAsset
    AdoConn.Execute sSql
        sSql = "Select * From Schedules Where 1 = 2"
        Set rsSave = GetRecords(sSql)
        With rsSave
            .AddNew
            .Fields("AcTypeID") = lngAcTypeID
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeFixedAsset
            .Fields("NoteNo") = IIf(Trim(txtNoteNo) = "", Null, txtNoteNo)
            .Fields("IsFinished") = chkFinished                               'IIf(chkFinished = vbChecked, True, False)
            .Fields("IsDetailed") = 0
            .Fields("DerivedAmount") = vsfgAssetTree.ValueMatrix(14, grdValues)
            SaveDateAndUser rsSave, True
            .Update
        End With
    sSql = "Delete From Schedules Where AcTypeID = " & GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment) & " And PeriodID  = " & mPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeGeneral
    AdoConn.Execute sSql
        sSql = "Select * From Schedules Where 1 = 2"
        Set rsSave = GetRecords(sSql)
        With rsSave
            .AddNew
            .Fields("AcTypeID") = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeGeneral
            .Fields("NoteNo") = IIf(Trim(txtNoteNo) = "", Null, txtNoteNo)
            .Fields("IsFinished") = chkFinishGroup                          'IIf(chkFinishGroup = vbChecked, True, False)
            .Fields("IsDetailed") = 0
            .Fields("DerivedAmount") = vsfgAssetTree.ValueMatrix(14, grdValues)
            SaveDateAndUser rsSave, True
            .Update
        End With
    AdoConn.CommitTrans
    '---Balance sheet entry----------------------------------
'    If Trim(txtNoteNo) <> "" And chkFinished = vbChecked Then
    sSql = "Select * From SchedulesSubBalanceSheet Where AcTypeID = " & lngParentAcTypeID & " AND PeriodID  = " & mPeriodID
        With GetRecords(sSql)
            If .EOF Then
                .AddNew
                .Fields("AcTypeID") = lngParentAcTypeID
                .Fields("PeriodID") = mPeriodID
            End If
                .Fields("NoteNo") = Trim(txtNoteNo)
                dblBalSheetAmount = GetBalSheetAmount()
                .Fields("DAmt") = IIf(RVal(dblBalSheetAmount) > 0, dblBalSheetAmount, 0)
                .Fields("CAmt") = IIf(RVal(dblBalSheetAmount) < 0, dblBalSheetAmount, 0)
                .Update
                .Close
        End With
'    End If
    Save = True
Exit Function
Err_Exit:
    Save = False
    If IsTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
End Function

Public Function IsValidDoc() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    With vsfgAssetTree
        For Inc = 0 To .Rows - 1
            If .ValueMatrix(Inc, grdValues) <> 0 Then
                IsValidDoc = True
                Exit Function
            End If
        Next Inc
    End With
Exit Function
Err_Exit:
    IsValidDoc = False
End Function

Public Function FillSchedule(lngAcTypeID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Integer, TmpFmt As String, RowInc As Long, lngInc As Long, Fmt() As String
Dim dblLastCost As Double, dblLastDepr As Double
    vsfgAssetTree.Rows = 1: vsfgAssetTree.Rows = 2: Inc = 1
    txtNoteNo = "": chkFinished = 0
    lngAcTypeID = Val(txtAcType.Tag)
    sSql = "Select * from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeFixedAsset
    With GetRecords(sSql)
        If Not .EOF Then
            txtNoteNo = .Fields("NoteNo") & ""
            chkFinished = IIf(.Fields("IsFinished"), vbChecked, vbUnchecked)
            chkFinishGroup = IIf(.Fields("IsFinished"), vbChecked, vbUnchecked)
        End If
        .Close
    End With
    sSql = "SELECT ItemID AS ItID, Description AS ItemDesc, Format AS Fmt " & _
           "FROM FixedAssetScheduleItems ORDER BY ItemID"
    With GetRecords(sSql)
        While Not .EOF
            vsfgAssetTree.TextMatrix(Inc, grdSlNo) = Inc
            TmpFmt = .Fields("Fmt") & ""
            Select Case TmpFmt
                Case ""
                    vsfgAssetTree.TextMatrix(Inc, grdParticulars) = IIf(.Fields("ItemDesc") = "-", "", .Fields("ItemDesc"))
                Case Else
                    Fmt = Split(TmpFmt, "|")
                    For lngInc = 0 To UBound(Fmt)
                        Select Case Fmt(lngInc)
                            Case "B"
                                vsfgAssetTree.Row = Inc
                                For RowInc = 0 To vsfgAssetTree.Cols - 1
                                    vsfgAssetTree.Col = RowInc
                                    vsfgAssetTree.CellFontBold = True
                                Next
                                vsfgAssetTree.TextMatrix(Inc, grdParticulars) = .Fields("ItemDesc")
                            Case "BFY"
                                vsfgAssetTree.TextMatrix(Inc, grdParticulars) = .Fields("ItemDesc") & " " & Format(mStartDt, "MMMM dd, yyyy")
                            Case "EFY"
                                vsfgAssetTree.TextMatrix(Inc, grdParticulars) = .Fields("ItemDesc") & " " & Format(mEndDt, "MMMM dd, yyyy")
                            Case Else
                                DoEvents
                                Select Case Left(Fmt(lngInc), 3)
                                    Case "BFY"
                                        vsfgAssetTree.TextMatrix(Inc, grdParticulars) = .Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & IIf(Month(mStartDt) = 1, Year(mStartDt), Year(mStartDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                                    Case "EFY"
                                        vsfgAssetTree.TextMatrix(Inc, grdParticulars) = .Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mEndDt) & "/" & Month(mEndDt) & "/" & Month(mStartDt) & "/" & IIf(Month(mEndDt) = 1, Year(mEndDt), Year(mEndDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                                End Select
                        End Select
                    Next
            End Select
            vsfgAssetTree.TextMatrix(Inc, grdItemID) = .Fields("ItID")
            vsfgAssetTree.TextMatrix(Inc, grdValues) = Format(GetValue(.Fields("ItID"), lngAcTypeID), "#,###")
            If RVal(vsfgAssetTree.TextMatrix(Inc, grdValues)) = 0 Then vsfgAssetTree.TextMatrix(Inc, 2) = ""
                .MoveNext
            If Not .EOF Then
                Inc = Inc + 1
                vsfgAssetTree.Rows = vsfgAssetTree.Rows + 1
            End If
        Wend
        .Close
    End With
    '---Loading values from trial balance----------------------------
    txtCost = Format(Abs(GetTrialTypeValue(mPeriodID, lngCostAcTypeID)), "#,##0")
    txtAccDep = Format(Abs(GetTrialTypeValue(mPeriodID, lngDepreciationAcTypeID)), "#,##0")
    dblLastCost = Format(Abs(GetTrialTypeValue(mLastPeriodID, lngCostAcTypeID)), "#,##0")
    dblLastDepr = Format(Abs(GetTrialTypeValue(mLastPeriodID, lngDepreciationAcTypeID)), "#,##0")
    '----------------------------------------------------------------

    vsfgAssetTree.TextMatrix(6, grdValues) = txtCost
    vsfgAssetTree.TextMatrix(12, grdValues) = txtAccDep
    vsfgAssetTree.TextMatrix(2, grdValues) = dblLastCost
    vsfgAssetTree.TextMatrix(9, grdValues) = dblLastDepr
    FindTotals
    FillSchedule = True
Exit Function
Err_Exit:
    FillSchedule = False
    ShowError
End Function

Public Function GetValue(ItID As String, lngAcTypeID As Long) As String
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "SELECT FAS.Amount Amt FROM FixedAssetSchedules FAS WHERE FAS.AcTypeID = " & lngAcTypeID & " AND FAS.ItemID = " & ItID & " AND FAS.PeriodID = " & mPeriodID
    With AdoConn.Execute(sSql)
        If Not .EOF Then
            If Not IsNull(.Fields("Amt")) Then
                GetValue = CStr(.Fields("Amt"))
            Else
                GetValue = ""
            End If
        Else
            GetValue = ""
        End If
    End With
Exit Function
Err_Exit:
    GetValue = ""
End Function

Public Sub FindTotals()
On Local Error Resume Next
Dim Inc As Long, CurTot As Currency, IsValid As Boolean, TmpRow As Long, TmpCol As Long
    With vsfgAssetTree
        TmpRow = .Row: TmpCol = .Col
        For Inc = 0 To .Rows - 1
            If IsValid Then
                CurTot = CurTot + .ValueMatrix(Inc, grdValues)
            End If
            If IsValid And .Cell(flexcpFontBold, Inc, 1) Then
                CurTot = CurTot - .ValueMatrix(Inc, grdValues)
                .TextMatrix(Inc, 2) = Format(CurTot, "#,###")
                IsValid = False
            End If
            If Not IsValid And .Cell(flexcpFontBold, Inc, 1) Then
                CurTot = 0
                IsValid = True
            End If
        Next
        .TextMatrix(.Rows - 2, grdValues) = Format(.ValueMatrix(6, grdValues) - .ValueMatrix(12, grdValues), "#,###")
        .TextMatrix(.Rows - 1, grdValues) = Format(.ValueMatrix(2, grdValues) - .ValueMatrix(9, grdValues), "#,###")
        .TextMatrix(1, grdValues) = ""
        .TextMatrix(8, grdValues) = ""
        .TextMatrix(14, grdValues) = ""
        .Row = TmpRow: .Col = TmpCol
    End With
End Sub

Public Function GetDate(lngPeriodID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "SELECT CONVERT(DateTime, PER.StartDt - 2, 103) AS StartDate, CONVERT(DateTime, PER.EndDt - 2, 103) AS EndDate, " & _
           "CONVERT(DateTime, PER1.StartDt - 2, 103) AS LastStartDate, CONVERT(DateTime, PER1.EndDt - 2, 103) AS LastEndDate " & _
           "FROM   Periods PER LEFT OUTER JOIN Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID Where PER.PeriodID =" & lngPeriodID
        With GetRecords(sSql)
            While Not .EOF
                If IsNull(.Fields("StartDate")) Then
                    mStartDt = Format(DateValue(ServerDateTime), "dd/MMM/yyyy")
                Else
                    mStartDt = Format(.Fields("StartDate"), "dd/MMM/yyyy")
                End If
                If IsNull(.Fields("EndDate")) Then
                    mEndDt = Format(DateValue(ServerDateTime), "dd/MMM/yyyy")
                Else
                    mEndDt = Format(.Fields("EndDate"), "dd/MMM/yyyy")
                End If
                If IsNull(.Fields("LastStartDate")) Then
                    mLaststartDt = Format(DateValue(ServerDateTime), "dd/MMM/yyyy")
                Else
                    mLaststartDt = Format(.Fields("LastStartDate"), "dd/MMM/yyyy")
                End If
                If IsNull(.Fields("LastEndDate")) Then
                    mLastEndDt = Format(DateValue(ServerDateTime), "dd/MMM/yyyy")
                Else
                    mLastEndDt = Format(.Fields("LastEndDate"), "dd/MMM/yyyy")
                End If
                .MoveNext
            Wend
            .Close
        End With
    GetDate = True
Exit Function
Err_Exit:
    GetDate = False
'    ShowError
End Function

Public Function GetBalSheetAmount() As Double
On Local Error GoTo Err_Exit
Dim sSql As String, TotalAmt As Double
    sSql = "SELECT Sum(FAS.Amount)AS Total FROM FixedAssetSchedules FAS INNER JOIN dbo.AcTypes AT ON AT.AcTypeID = FAS.AcTypeID " & _
           "WHERE FAS.PeriodID=" & mPeriodID & " AND FAS.ItemID= 15 AND AT.ParentAcTypeID = " & lngParentAcTypeID
    With AdoConn.Execute(sSql)
        If Not .EOF Then
            TotalAmt = Val(.Fields("Total") & "")
        Else
            TotalAmt = 0
        End If
        .Close
    End With
    GetBalSheetAmount = TotalAmt
Exit Function
Err_Exit:
    GetBalSheetAmount = 0
End Function

Private Sub vsfgAssetTree_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    FindTotals
End Sub

Private Sub vsfgAssetTree_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Not mblnModify Then
        Cancel = True
    End If
    '001/08
    If Row = 2 Then
        Cancel = True
    End If
    If Row = 1 Or Row = 7 Or Row = 13 Then
        Cancel = True
    End If
    If Col = 1 Then Cancel = True
    If Trim(vsfgAssetTree.TextMatrix(Row, 1)) = "" Then
        Cancel = True
    End If
End Sub

Public Sub PrintDoc()
    PrintFixedAssetSchedules mPeriodID
End Sub
