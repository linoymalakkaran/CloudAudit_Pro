VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmLiabilitySchedule 
   Caption         =   "Contingent Liability Schedule"
   ClientHeight    =   3750
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7860
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   3750
   ScaleWidth      =   7860
   WindowState     =   2  'Maximized
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2985
      TabIndex        =   8
      Top             =   3360
      Width           =   4815
      _ExtentX        =   8493
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
   Begin VB.CommandButton fndScheduleID 
      Height          =   315
      Left            =   4440
      Picture         =   "frmLiabilitySchedule.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   840
      Width           =   315
   End
   Begin VB.CheckBox chkFinished 
      Caption         =   "Finished"
      Height          =   255
      Left            =   150
      TabIndex        =   6
      Top             =   3390
      Width           =   915
   End
   Begin VB.TextBox txtNoteNo 
      Height          =   315
      Left            =   5040
      TabIndex        =   3
      Top             =   840
      Width           =   990
   End
   Begin VB.TextBox txtScheduleName 
      Height          =   315
      Left            =   50
      TabIndex        =   2
      Top             =   840
      Width           =   4380
   End
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmLiabilitySchedule.frx":018A
      Left            =   1100
      List            =   "frmLiabilitySchedule.frx":018C
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   120
      Width           =   3420
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgLiability 
      Height          =   1710
      Left            =   45
      TabIndex        =   7
      Top             =   1250
      Width           =   7755
      _cx             =   13679
      _cy             =   3016
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
      Rows            =   5
      Cols            =   4
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmLiabilitySchedule.frx":018E
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   255
      Top             =   2835
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
            Picture         =   "frmLiabilitySchedule.frx":022E
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":0388
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":04E2
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":063C
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":0816
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":0970
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":0B4A
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":0CA4
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":21A6
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":2380
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":255A
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLiabilitySchedule.frx":2734
            Key             =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblTotalLast 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   270
      Left            =   5985
      TabIndex        =   10
      Top             =   2955
      Width           =   1800
   End
   Begin VB.Label lblTotalThis 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   270
      Left            =   4155
      TabIndex        =   9
      Top             =   2955
      Width           =   1785
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Note No:"
      Height          =   195
      Left            =   5055
      TabIndex        =   5
      Top             =   600
      Width           =   645
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Schedule Name"
      Height          =   195
      Left            =   45
      TabIndex        =   4
      Top             =   600
      Width           =   1140
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   50
      TabIndex        =   1
      Top             =   180
      Width           =   960
   End
End
Attribute VB_Name = "frmLiabilitySchedule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean
Dim mdblTotalAmt As Double, mdblLastTotalAmt As Double

Const grdParticulars = 0
Const grdThisYear = 1
Const grdLastYear = 2
Const grdAcID = 3

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

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         txtScheduleName.SetFocus
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
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " Order By StartDt desc"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    fndScheduleID.Enabled = Not blnNewValue
    txtScheduleName.Enabled = blnNewValue
    txtNoteNo.Enabled = blnNewValue
    vsfgLiability.Enabled = blnNewValue
    chkFinished.Enabled = blnNewValue
End Property

Public Sub ClearValues()
    txtNoteNo = ""
    chkFinished = vbUnchecked
    vsfgLiability.Rows = 1: vsfgLiability.Rows = 5
    mdblTotalAmt = 0
End Sub

Private Sub fndScheduleID_Click()
    ButtonHandling Me, "Open"
End Sub

Private Sub Form_Load()
    ButtonHandling Me
    tbrCtrls.Buttons("Modify").Enabled = True
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub vsfgLiability_AfterEdit(ByVal Row As Long, ByVal Col As Long)
Dim Inc As Long
    If Row > 0 Then
        Select Case Col
            Case grdThisYear
                mdblTotalAmt = 0
                mdblLastTotalAmt = 0
                For Inc = 0 To vsfgLiability.Rows - 1
                    mdblTotalAmt = mdblTotalAmt + vsfgLiability.ValueMatrix(Inc, grdThisYear)
                    mdblLastTotalAmt = mdblLastTotalAmt + vsfgLiability.ValueMatrix(Inc, grdLastYear)
                Next Inc
                lblTotalThis = IIf(mdblTotalAmt < 0, "(" & Format(Abs(mdblTotalAmt), "#,##0") & ")", Format(mdblTotalAmt, "#,##0"))
                lblTotalLast = IIf(mdblLastTotalAmt < 0, "(" & Format(Abs(mdblLastTotalAmt), "#,##0") & ")", Format(mdblLastTotalAmt, "#,##0"))
            Case grdLastYear
                
        End Select
    End If
End Sub

Private Sub vsfgLiability_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Row > 0 Then
        Select Case Col
            Case grdLastYear
                Cancel = True
            Case Else
                Cancel = False
        End Select
    End If
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
On Local Error GoTo Err_Exit
Dim strRslt As String, sSqlFilter As String, lngPropertyAcTypeID As Long
    lngPropertyAcTypeID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
    sSqlFilter = " AND AT.AcTypeID NOT IN(" & lngPropertyAcTypeID & ")"
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountTypes, "WHERE AT.TreeLevel = 3 AND AT.IsHidden = 1 " & sSqlFilter & " AND AT.CompanyID = " & mCompanyID, "XAcTypeID", , fndScheduleID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtScheduleName.Tag = lngID
        End If
    Else
        If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & lngID)) <> 3 Then
            ShowOpen = False
            Exit Function
        End If
        strRslt = lngID
        txtScheduleName.Tag = lngID
    End If
    Select Case strRslt
        Case "-1", ""
            ShowOpen = False
        Case Else
            txtScheduleName = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
            ShowOpen = ShowData(lngID)
            ShowOpen = True
    End Select
Exit Function
Err_Exit:
    ShowError
End Function

Public Function ShowData(lngAcTypeID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim rsDeduction As ADODB.Recordset, sSql As String, sSql1 As String, Inc As Integer, dblLastAmount As Double
Dim dblAmount As Double, curCYearTot As Currency, curCTmpTot As Currency, curLYearTot As Currency, curLTmpYear As Currency, lastYear As Currency, AcType As String
Dim sSqlThisYear As String, sSqlLastYear As String
    ClearValues
    sSql = "Select * from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeContingentLiability
    With GetRecords(sSql)
        If Not .EOF Then
            txtNoteNo = .Fields("NoteNo") & ""
            chkFinished = IIf(.Fields("IsFinished"), vbChecked, vbUnchecked)
        End If
        .Close
    End With

    sSqlThisYear = "SELECT Amount From LiabilitySchedules Where (AcTypeID = " & lngAcTypeID & ") And (AcID = AH.AcID) And (PeriodID = " & mPeriodID & ")"
    sSqlLastYear = "SELECT Amount From LiabilitySchedules Where (AcTypeID = " & lngAcTypeID & ") And (AcID = AH.AcID) And (PeriodID = " & mLastPeriodID & ")"

    sSql = "SELECT AH.AcID, AH.AcName AS Particulars, (" & sSqlThisYear & ") AS Amount, (" & sSqlLastYear & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, " & _
           "AT.TypeNature, AH.TrialOrder FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")"

        vsfgLiability.OutlineBar = flexOutlineBarCompleteLeaf
        With GetRecords(sSql)
            While Not .EOF
                vsfgLiability.Rows = vsfgLiability.Rows + 1: Inc = Inc + 1
'                vsfgLiability.OutlineCol = 0
'                vsfgLiability.IsSubtotal(Inc) = True
'                vsfgLiability.RowOutlineLevel(Inc) = 1
'                vsfgLiability.IsCollapsed(Inc) = flexOutlineExpanded
                dblAmount = Val(.Fields("Amount") & "")
                curCYearTot = curCYearTot + dblAmount
                curCTmpTot = dblAmount
                dblLastAmount = Val(.Fields("PreviousAmount") & "")
                curLYearTot = curLYearTot + dblLastAmount
                curLTmpYear = dblLastAmount
                vsfgLiability.TextMatrix(Inc, grdParticulars) = .Fields("Particulars") & ""
                vsfgLiability.TextMatrix(Inc, grdAcID) = .Fields("AcID") & ""
                vsfgLiability.TextMatrix(Inc, grdThisYear) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                vsfgLiability.TextMatrix(Inc, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                If vsfgLiability.ValueMatrix(Inc, grdThisYear) = 0 Then
                    vsfgLiability.TextMatrix(Inc, grdThisYear) = "-"
                End If
                If vsfgLiability.ValueMatrix(Inc, grdLastYear) = 0 Then
                    vsfgLiability.TextMatrix(Inc, grdLastYear) = "-"
                End If
                vsfgLiability.Cell(flexcpFontBold, Inc, grdParticulars, Inc, grdThisYear) = True
                .MoveNext
            Wend
            If vsfgLiability.ValueMatrix(Inc, grdThisYear) = 0 Then
                vsfgLiability.TextMatrix(Inc, grdThisYear) = "-"
            End If
            If vsfgLiability.ValueMatrix(Inc, grdLastYear) = 0 Then
                vsfgLiability.TextMatrix(Inc, grdLastYear) = "-"
            End If
            mdblTotalAmt = curCYearTot
            mdblLastTotalAmt = curLYearTot
            lblTotalThis = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
            lblTotalLast = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
            If vsfgLiability.Rows >= 5 Then vsfgLiability.Rows = 5
            .Close
        End With
    ShowData = True
Exit Function
Err_Exit:
    ShowData = False
    ShowError
End Function

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsTran As Boolean, sSql As String, lngAcTypeID As Long
Dim rsSave As New ADODB.Recordset, Inc As Long
    lngAcTypeID = Val(txtScheduleName.Tag)
    If lngAcTypeID = 0 Then
        pMVE.MsgBox "Nothing To Save!", msgOK, "AuditMate", msgInformation
        Save = False
        Exit Function
    End If
    If chkFinished = vbChecked And Trim(txtNoteNo) = "" Then
        pMVE.MsgBox "Note No: not specified.", msgOK, "AuditMate", msgInformation
        Save = False
        Exit Function
    End If
    AdoConn.BeginTrans
    IsTran = True
    sSql = "Delete from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeContingentLiability
    AdoConn.Execute sSql
        sSql = "Select * From Schedules Where 1 = 2"
        Set rsSave = GetRecords(sSql)
        With rsSave
            .AddNew
            .Fields("AcTypeID") = lngAcTypeID
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeContingentLiability
            .Fields("NoteNo") = IIf(Trim(txtNoteNo) = "", Null, txtNoteNo)
            .Fields("IsFinished") = chkFinished
            .Fields("IsDetailed") = 0
            .Fields("DerivedAmount") = RVal(lblTotalThis)
            SaveDateAndUser rsSave, True
            .Update
        End With
    sSql = "Delete From LiabilitySchedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID = " & mPeriodID
    AdoConn.Execute sSql
        sSql = "Select * From LiabilitySchedules Where 1=2"
        Set rsSave = GetRecords(sSql)
        Inc = 0
        With rsSave
            For Inc = 1 To vsfgLiability.Rows - 1
                If vsfgLiability.TextMatrix(Inc, grdParticulars) <> "" Then
                    .AddNew
                    .Fields("AcID") = vsfgLiability.TextMatrix(Inc, grdAcID)
                    .Fields("AcTypeID") = lngAcTypeID
                    .Fields("PeriodID") = mPeriodID
                    .Fields("Amount") = vsfgLiability.TextMatrix(Inc, grdThisYear)
                    .Update
                End If
            Next Inc
        End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsTran Then
        AdoConn.RollbackTrans
    End If
    Save = False
    ShowError
End Function

Public Sub PrintDoc()
    PrintLiabilitySchedules mPeriodID, txtScheduleName.Tag
End Sub
