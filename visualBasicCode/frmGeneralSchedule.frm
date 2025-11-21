VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmGeneralSchedule 
   Caption         =   "General Schedule"
   ClientHeight    =   5055
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7875
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5055
   ScaleWidth      =   7875
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmGeneralSchedule.frx":0000
      Left            =   1125
      List            =   "frmGeneralSchedule.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   120
      Width           =   3420
   End
   Begin VB.CheckBox chkIsDetailed 
      Caption         =   "Detailed"
      Height          =   195
      Left            =   6645
      TabIndex        =   11
      Top             =   840
      Visible         =   0   'False
      Width           =   1065
   End
   Begin VB.CheckBox chkFinished 
      Caption         =   "Finished"
      Height          =   255
      Left            =   90
      TabIndex        =   7
      Top             =   4530
      Width           =   915
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTree 
      Height          =   2865
      Left            =   60
      TabIndex        =   6
      Top             =   1140
      Width           =   7755
      _cx             =   13679
      _cy             =   5054
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
      Rows            =   50
      Cols            =   3
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmGeneralSchedule.frx":0004
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
      Editable        =   0
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
      Left            =   4620
      TabIndex        =   5
      Top             =   780
      Width           =   990
   End
   Begin VB.CheckBox chkShowUnfinished 
      Caption         =   "Show unfinished only"
      Height          =   255
      Left            =   2370
      TabIndex        =   3
      Top             =   525
      Width           =   1875
   End
   Begin VB.CommandButton fndAcTypeID 
      Height          =   315
      Left            =   4200
      Picture         =   "frmGeneralSchedule.frx":0082
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   780
      Width           =   315
   End
   Begin VB.TextBox txtAcType 
      Height          =   315
      Left            =   60
      Locked          =   -1  'True
      TabIndex        =   0
      Top             =   780
      Width           =   4140
   End
   Begin MSComctlLib.Toolbar tbrCtrlsMore 
      Height          =   330
      Left            =   1125
      TabIndex        =   8
      Top             =   4500
      Visible         =   0   'False
      Width           =   1650
      _ExtentX        =   2910
      _ExtentY        =   582
      ButtonWidth     =   2805
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstCtrls"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Auto Process"
            Key             =   "AutoProcess"
            ImageKey        =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   210
      Top             =   4005
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
            Picture         =   "frmGeneralSchedule.frx":020C
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":0366
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":04C0
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":061A
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":07F4
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":094E
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":0B28
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":0C82
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":2184
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":235E
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":2538
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmGeneralSchedule.frx":2712
            Key             =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2895
      TabIndex        =   12
      Top             =   4530
      Width           =   4935
      _ExtentX        =   8705
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
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            Object.Width           =   50
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Print"
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            Object.Tag             =   "Print"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   75
      TabIndex        =   14
      Top             =   180
      Width           =   960
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
      Left            =   6015
      TabIndex        =   10
      Top             =   4080
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
      Left            =   4185
      TabIndex        =   9
      Top             =   4080
      Width           =   1785
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Note No:"
      Height          =   195
      Left            =   4635
      TabIndex        =   4
      Top             =   540
      Width           =   645
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Account type"
      Height          =   195
      Left            =   60
      TabIndex        =   2
      Top             =   540
      Width           =   945
   End
End
Attribute VB_Name = "frmGeneralSchedule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mdblTotalAmt As Double, mdblLastTotalAmt As Double
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Const grdParticulars = 0
Const grdThisYear = 1
Const grdLastYear = 2

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
   fndAcTypeID.Enabled = Not blnNewValue
   txtNoteNo.Enabled = blnNewValue
   chkIsDetailed.Enabled = blnNewValue
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
         vsfgTree.SetFocus
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

Private Sub fndAcTypeID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Sub AutoProcess()
On Local Error GoTo Err_Exit
Dim sSql As String, crsAcTypes As New clsRecordSet, sSqlFilter As String
Dim lngPropertyPlantID As Long
    lngPropertyPlantID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
    sSqlFilter = " And AcTypeID NOT IN( " & lngPropertyPlantID & ")"
    sSql = "Select AcTypeID FROM AcTypes  Where TreeLevel = 3 " & sSqlFilter & " And CompanyID = " & mCompanyID & " And IsHidden = 0"
    crsAcTypes.BindRecords sSql, AdoConn
    With crsAcTypes
        While Not .EOF
            ShowOpen .Fields("AcTypeID")
            ButtonHandling Me, "Modify"
            ButtonHandling Me, "Save"
            DoEvents
            .MoveNext
        Wend
        .Clear
    End With
    pMVE.MsgBox "Automatic updation completed.", msgOK, "AuditMate", msgInformation, True
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String, sSqlFilter As String, sSqlExtraFilter As String
Dim lngPropertyAcTypeID As Long
    If chkShowUnfinished = vbChecked Then
        sSqlFilter = " AND AT.AcTypeID NOT IN(Select AcTypeID from Schedules Where PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeGeneral & ")"
    End If
    lngPropertyAcTypeID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
    sSqlExtraFilter = " AND AT.AcTypeID NOT IN(" & lngPropertyAcTypeID & ")"
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountTypes, "WHERE AT.TreeLevel = 3 AND ISNULL(AT.AllocationAcTypeID,0) = 0 " & sSqlFilter & sSqlExtraFilter & " AND AT.CompanyID = " & mCompanyID, "XAcTypeID", , fndAcTypeID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtAcType.Tag = lngID
        End If
    Else
        If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & lngID)) <> 3 Then
            ShowOpen = False
            Exit Function
        End If
        strRslt = lngID
        txtAcType.Tag = lngID
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        txtAcType = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
        ShowOpen = ShowData(lngID)
        ShowOpen = True
    End Select
End Function

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Public Sub ClearValues()
    txtNoteNo = ""
    chkFinished = vbUnchecked: chkIsDetailed = vbUnchecked
    vsfgTree.Rows = 1: vsfgTree.Rows = 9
    mdblTotalAmt = 0
End Sub

Public Function ShowData(lngAcTypeID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim rsDeduction As ADODB.Recordset, sSql As String, sSql1 As String, Inc As Integer, dblLastAmount As Double
Dim dblAmount As Double, curCYearTot As Currency, curCTmpTot As Currency, curLYearTot As Currency, curLTmpYear As Currency, lastYear As Currency, AcType As String
    ClearValues
    sSql = "Select * from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeGeneral
    With GetRecords(sSql)
        If Not .EOF Then
            txtNoteNo = .Fields("NoteNo") & ""
            chkFinished = IIf(.Fields("IsFinished"), vbChecked, vbUnchecked)
            chkIsDetailed = IIf(.Fields("IsDetailed"), vbChecked, vbUnchecked)
        End If
        .Close
    End With
    'Ref No: 002/07
    sSql = "SELECT SUM(Amount) AS Amount, SUM(PreviousAmount) AS PreviousAmount, Particulars, ORD, DeductionAcTypeID, TypeNature " & _
           "FROM (SELECT AcTypeName AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & mPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & mLastPeriodID & ") AS PreviousAmount, 1 AS ORD, AT.DeductionAcTypeID, TypeNature, AT.TrialOrder " & _
           "FROM AcTypes AT Where ParentAcTypeID = " & lngAcTypeID & "  AND AT.AcTypeID NOT IN (SELECT ISNULL(AT1.DeductionAcTypeID, 0) FROM AcTypes AT1 WHERE AT1.CompanyID = " & mCompanyID & ") " & _
           "Union " & _
           "SELECT AH.AcName AS Particulars, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
           "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & mPeriodID & ") AS Amount, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
           "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & mLastPeriodID & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, " & _
           "AT.TypeNature, AH.TrialOrder FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")) TMP1 " & _
           "Where (Amount <> 0 OR PreviousAmount <>0) GROUP BY Particulars, ORD, DeductionAcTypeID, TypeNature, TrialOrder ORDER BY ORD, TrialOrder, DeductionAcTypeID DESC"
    vsfgTree.OutlineBar = flexOutlineBarCompleteLeaf
    With GetRecords(sSql)
        While Not .EOF
            Inc = Inc + 1
            vsfgTree.Rows = vsfgTree.Rows + 1
            dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
            curCYearTot = curCYearTot + dblAmount
            curCTmpTot = dblAmount
            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
            curLYearTot = curLYearTot + dblLastAmount
            curLTmpYear = dblLastAmount
            vsfgTree.TextMatrix(Inc, grdParticulars) = .Fields("Particulars") & ""
            vsfgTree.TextMatrix(Inc, grdThisYear) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
            vsfgTree.TextMatrix(Inc, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
            If vsfgTree.ValueMatrix(Inc, grdThisYear) = 0 Then
                vsfgTree.TextMatrix(Inc, grdThisYear) = "-"
            End If
            If vsfgTree.ValueMatrix(Inc, grdLastYear) = 0 Then
                vsfgTree.TextMatrix(Inc, grdLastYear) = "-"
            End If
            If Val(.Fields("Ord") & "") = 2 Then
                vsfgTree.Cell(flexcpFontItalic, Inc, grdParticulars, Inc, grdLastYear) = True
            End If
            '---Less Deduction-------------------------------
            vsfgTree.Cell(flexcpFontBold, Inc, grdParticulars, Inc, grdThisYear) = True
            If Val(.Fields("DeductionAcTypeID") & "") <> 0 Then
                'sSql = "SELECT AT.AcTypeDescription AS Particulars, SUM(ESA.DAmt) - SUM(ESA.CAmt) AS Amount, AT.TypeNature FROM Entries ET INNER JOIN " & _
                       "EntrySubAccounts ESA ON ET.EntryID = ESA.EntryID INNER JOIN AcHeads AH ON ESA.AcID = AH.AcID INNER JOIN " & _
                       "AcTypes AT ON AH.AcTypeID = AT.AcTypeID Where ET.PeriodID = " & mPeriodID & " And AT.AcTypeID = " & Val(.Fields("DeductionAcTypeID") & "") & " GROUP BY AT.AcTypeDescription, AT.TypeNature "
                sSql = "SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & mPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & mLastPeriodID & ") AS PreviousAmount, TypeNature " & _
                       "From AcTypes Where AcTypeID = " & Val(.Fields("DeductionAcTypeID"))
                With GetRecords(sSql)
                    While Not .EOF
                        Inc = Inc + 1
                        vsfgTree.Rows = vsfgTree.Rows + 1
                        dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                        curCYearTot = curCYearTot + dblAmount
                        curCTmpTot = curCTmpTot + dblAmount
                        dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                        curLYearTot = curLYearTot + dblLastAmount
                        curLTmpYear = curLTmpYear + dblLastAmount
                        vsfgTree.TextMatrix(Inc, grdParticulars) = IIf(dblAmount > 0, "", "Less:  ") & .Fields("Particulars") & ""
                        vsfgTree.TextMatrix(Inc, grdThisYear) = IIf(dblAmount > 0, Format(Abs(dblAmount), "#,##0"), "(" & Format(Abs(dblAmount), "#,##0") & ")")
                        vsfgTree.TextMatrix(Inc, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                        vsfgTree.Cell(flexcpFontBold, Inc, grdParticulars, Inc, grdThisYear) = True
                        vsfgTree.Cell(flexcpFontUnderline, Inc, grdThisYear, Inc, grdLastYear) = True

                        Inc = Inc + 1
                        vsfgTree.Rows = vsfgTree.Rows + 1
                        vsfgTree.TextMatrix(Inc, grdThisYear) = IIf(curCTmpTot < 0, "(" & Format(Abs(curCTmpTot), "#,##0") & ")", Format(curCTmpTot, "#,##0"))
                        vsfgTree.TextMatrix(Inc, grdLastYear) = IIf(curLTmpYear < 0, "(" & Format(Abs(curLTmpYear), "#,##0") & ")", Format(curLTmpYear, "#,##0"))
                        vsfgTree.Cell(flexcpFontBold, Inc, grdParticulars, Inc, grdThisYear) = True
                        .MoveNext
                    Wend
                End With
            End If
            .MoveNext
        Wend
        If vsfgTree.ValueMatrix(Inc, grdThisYear) = 0 Then
            vsfgTree.TextMatrix(Inc, grdThisYear) = "-"
        End If
        If vsfgTree.ValueMatrix(Inc, grdLastYear) = 0 Then
            vsfgTree.TextMatrix(Inc, grdLastYear) = "-"
        End If
        mdblTotalAmt = curCYearTot
        mdblLastTotalAmt = curLYearTot
        lblTotalThis = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
        lblTotalLast = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
        If vsfgTree.Rows < 9 Then vsfgTree.Rows = 9
        .Close
    End With
    vsfgTree.TextMatrix(0, grdThisYear) = "Current Period"
    vsfgTree.TextMatrix(0, grdLastYear) = "Previous Period"
    ShowData = True
Exit Function
Err_Exit:
    ShowData = False
    ShowError
End Function

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsTran As Boolean, sSql As String, lngAcTypeID As Long
Dim rsSave As New ADODB.Recordset
    lngAcTypeID = Val(txtAcType.Tag)
    If lngAcTypeID = 0 Then
        pMVE.MsgBox "Nothing To Save!", msgOK, "AuditMate", msgInformation
        Save = False
        Exit Function
    End If

'    Ref No:002/07
'    If chkFinished = vbChecked And Trim(txtNoteNo) = "" Then
'        pMVE.MsgBox "Note No: Not Specified.", msgOK, , msgInformation
'        Save = False
'        Exit Function
'    End If

    AdoConn.BeginTrans
    IsTran = True
    sSql = "Delete from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeGeneral
    AdoConn.Execute sSql
        sSql = "Select * From Schedules Where 1 = 2"
        Set rsSave = GetRecords(sSql)
        With rsSave
            .AddNew
            .Fields("AcTypeID") = lngAcTypeID
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeGeneral
            .Fields("NoteNo") = IIf(Trim(txtNoteNo) = "", Null, txtNoteNo)
            .Fields("IsFinished") = chkFinished
            .Fields("IsDetailed") = chkIsDetailed
            .Fields("DerivedAmount") = RVal(lblTotalThis)
            SaveDateAndUser rsSave, True
            .Update
        End With
    'Balance Sheet
    sSql = "Delete from SchedulesSubBalanceSheet Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID
    AdoConn.Execute sSql
        'If Trim(txtNoteNo) <> "" And chkFinished = vbChecked Then
            sSql = "Select * From SchedulesSubBalanceSheet Where 1 = 2"
            Set rsSave = GetRecords(sSql)
            With rsSave
                .AddNew
                .Fields("AcTypeID") = lngAcTypeID
                .Fields("PeriodID") = mPeriodID
                .Fields("NoteNo") = Trim(txtNoteNo)
                .Fields("DAmt") = IIf(RVal(mdblTotalAmt) > 0, mdblTotalAmt, 0)
                .Fields("CAmt") = IIf(RVal(mdblTotalAmt) < 0, mdblTotalAmt, 0)
                .Update
            End With
        'End If
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    Save = False
    If IsTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
End Function

Private Sub tbrCtrlsMore_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "AutoProcess"
            AutoProcess
    End Select
End Sub

Public Sub PrintDoc()
    PrintGeneralSchedules mPeriodID, txtAcType.Tag
End Sub
