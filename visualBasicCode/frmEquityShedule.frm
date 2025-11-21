VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmEquitySchedule 
   Caption         =   "Equity Schedule"
   ClientHeight    =   6930
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14475
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6930
   ScaleWidth      =   14475
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmEquityShedule.frx":0000
      Left            =   1095
      List            =   "frmEquityShedule.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   105
      Width           =   3150
   End
   Begin VB.CheckBox chkFinished 
      Caption         =   "Finished"
      Height          =   360
      Left            =   105
      TabIndex        =   1
      Top             =   6405
      Width           =   930
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgEquity 
      Height          =   5745
      Left            =   45
      TabIndex        =   0
      Top             =   525
      Width           =   15465
      _cx             =   27279
      _cy             =   10134
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
      FormatString    =   $"frmEquityShedule.frx":0004
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   2145
      Top             =   6315
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEquityShedule.frx":006B
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEquityShedule.frx":01C5
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEquityShedule.frx":039F
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEquityShedule.frx":0579
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmEquityShedule.frx":06D3
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   8625
      TabIndex        =   4
      Top             =   6390
      Width           =   4830
      _ExtentX        =   8520
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
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   60
      TabIndex        =   3
      Top             =   165
      Width           =   960
   End
End
Attribute VB_Name = "frmEquitySchedule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim TotTypeThis As Currency, TotTypeLast As Currency
Dim mStartDt As Date, mEndDt As Date, mLaststartDt As Date, mLastEndDt As Date
Dim mdblTotalAmt As Double
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Const grdSlNo = 0
Const grdParticulars = 1
Const grdItemID = 2

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

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
   chkFinished.Enabled = blnNewValue
   vsfgEquity.Enabled = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         vsfgEquity.SetFocus
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
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " Order By StartDt"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
    GetDate mPeriodID
    FillData
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Function FillData() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, Fmt() As String, lngInc As Long, ColInc As Long, RowInc As Long, TmpFmt As String
Dim lngParentID As Long, strYrPeriod As String
Dim crsAcTypes As New clsRecordSet
    vsfgEquity.Rows = 1: vsfgEquity.Rows = 20: vsfgEquity.Cols = 3: Inc = 1
    lngParentID = GetActualID(mCompanyID, cnstAcTypeShareHoldersEquity)
    '---Building header row----------------
    sSql = "SELECT * FROM AcTypes WHERE ParentAcTypeID =" & lngParentID & " ORDER BY TrialOrder, AcTypeDescription"
    crsAcTypes.BindRecords sSql, AdoConn
    With crsAcTypes
        ColInc = vsfgEquity.Cols
        vsfgEquity.RowHeight(0) = 500: vsfgEquity.RowHeight(1) = 0: vsfgEquity.RowHeightMin = 0: vsfgEquity.WordWrap = True
        While Not .EOF
            vsfgEquity.Cols = vsfgEquity.Cols + 1
            vsfgEquity.ColFormat(ColInc) = "##,###"
            vsfgEquity.TextMatrix(1, ColInc) = .Fields("AcTypeID") & ""
            vsfgEquity.TextMatrix(0, ColInc) = .Fields("AcTypeDescription") & ""
            vsfgEquity.ColWidth(ColInc) = GetProportionalValue(10200, False) / .Rows
            vsfgEquity.ColAlignment(ColInc) = flexAlignRightCenter
            If ColInc = 3 Then
                chkFinished = IIf(PickValue("Schedules", "IsFinished", "AcTypeID = " & vsfgEquity.ValueMatrix(1, ColInc) & "  AND ScheduleTypeID = " & cnstScheduleTypeEquity & " AND PeriodID = " & mPeriodID) = "True", 1, 0)
            End If
            ColInc = ColInc + 1
            .MoveNext
        Wend
        vsfgEquity.Cols = vsfgEquity.Cols + 1
        vsfgEquity.TextMatrix(0, ColInc) = "Total" & ""
        vsfgEquity.ColFormat(ColInc) = "##,###"
        vsfgEquity.ColAlignment(ColInc) = flexAlignRightCenter
        vsfgEquity.ColWidth(ColInc) = 1500

        vsfgEquity.Cell(flexcpFontBold, 0, 0, 0, vsfgEquity.Cols - 1) = True
       .Clear
    End With
    '---Filling values-----------------------
    For Inc = 1 To 9
        GetValue Inc, 1
    Next
    For Inc = 11 To 18
         GetValue Inc, 0
    Next
    '---Transfering profit-------------------
    For Inc = 3 To vsfgEquity.Cols - 2
        With AdoConn.Execute("SELECT EquityType FROM AcTypes WHERE AcTypeID = " & Val(vsfgEquity.TextMatrix(1, Inc)))
            If Not .EOF Then
                If Val(.Fields("EquityType") & "") = 1 Then
                    TotTypeThis = 0
                    TotTypeThis = GetTrialTypeValue(mPeriodID, GetActualID(mCompanyID, cnstAcTypeProfitLoss))
                    vsfgEquity.TextMatrix(11, Inc) = TotTypeThis * -1
                    If DateDiff("d", mEndDt, DateAdd("yyyy", 1, mStartDt)) = 1 Then
                        strYrPeriod = " for the year"
                    Else
                        strYrPeriod = " for the period"
                    End If
                    vsfgEquity.TextMatrix(11, 1) = "Net " & IIf(TotTypeThis < 0, "profit", "loss") & strYrPeriod
                    Exit For
                End If
            End If
            .Close
        End With
    Next
    '---Value from Trial Balance -------------
    For Inc = 3 To vsfgEquity.Cols - 2
        TotTypeThis = 0
        TotTypeThis = GetTrialTypeValue(mPeriodID, Val(vsfgEquity.TextMatrix(1, Inc)))
        vsfgEquity.TextMatrix(vsfgEquity.Rows - 1, Inc) = Format(TotTypeThis * -1, "#,##0")
    Next
    '---SlNos----------------------------------
    For Inc = 3 To 9
        vsfgEquity.TextMatrix(Inc, 0) = Inc - 2
    Next
    For Inc = 11 To 17
        vsfgEquity.TextMatrix(Inc, 0) = Inc - 10
    Next

    vsfgEquity.TextMatrix(2, grdParticulars) = "Balance at " & Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & Year(mStartDt) - 1, "MMMM DD, YYYY")
    vsfgEquity.Cell(flexcpFontBold, 2, 0, 2, vsfgEquity.Cols - 1) = True
    vsfgEquity.TextMatrix(10, grdParticulars) = "Balance at " & Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & Year(mStartDt), "MMMM DD, YYYY")
    vsfgEquity.Cell(flexcpFontBold, 10, 0, 10, vsfgEquity.Cols - 1) = True
    vsfgEquity.TextMatrix(18, grdParticulars) = "Balance at " & Format(Day(mEndDt) & "/" & Month(mEndDt) & "/" & Year(mEndDt), "MMMM DD, YYYY")
    vsfgEquity.Cell(flexcpFontBold, 18, 0, 18, vsfgEquity.Cols - 1) = True

    vsfgEquity.Cell(flexcpBackColor, 1, vsfgEquity.Cols - 1, vsfgEquity.Rows - 2, vsfgEquity.Cols - 1) = pclrRestrictionColor
    vsfgEquity.Cell(flexcpBackColor, vsfgEquity.Rows - 1, 0, vsfgEquity.Rows - 1, vsfgEquity.Cols - 2) = pclrRestrictionColor

    For RowInc = 4 To vsfgEquity.Rows - 2
        vsfgEquity.RowHeight(RowInc) = 300
    Next
    FindTotals
    FillData = True
    vsfgEquity.ColWidth(1) = 3000
Exit Function
Err_Exit:
    FillData = False
    ShowError
End Function

Public Sub GetValue(Row As Long, Section As Byte)
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, lngInc As Long, AddRow As Long
Dim lngPeriodID As Long, lngAcTypeID As Long
    If Section = 0 Then
        AddRow = 0
        lngPeriodID = mPeriodID
    Else
        AddRow = 1
        lngPeriodID = mLastPeriodID
    End If
    For lngInc = 1 To vsfgEquity.Cols - 2
        lngAcTypeID = vsfgEquity.ValueMatrix(1, lngInc)
        sSql = "SELECT FAS.Amount, FAS.Description  FROM FixedAssetSchedules FAS " & _
               "WHERE FAS.AcTypeID = " & lngAcTypeID & " AND FAS.PeriodID = " & lngPeriodID & " AND FAS.ItemID =" & Row + (9 * Section)
        With AdoConn.Execute(sSql)
            If Not .EOF Then
                vsfgEquity.TextMatrix(Row + AddRow, grdParticulars) = .Fields("Description") & ""
                vsfgEquity.TextMatrix(Row + AddRow, lngInc) = .Fields("Amount") & ""
                If vsfgEquity.ValueMatrix(Row + AddRow, lngInc) = 0 Then vsfgEquity.TextMatrix(Row + AddRow, lngInc) = ""
            Else
                If Section = 0 Then vsfgEquity.TextMatrix(Row + AddRow, grdParticulars) = vsfgEquity.TextMatrix(Row - 8, grdParticulars)
                vsfgEquity.TextMatrix(Row + AddRow, lngInc) = ""
            End If
            .Close
        End With
    Next
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub FindTotals()
On Error Resume Next
Dim Inc As Long, IncCol As Long, CurTot As Currency, IsValid As Boolean, TmpRow As Long, TmpCol As Long
    TmpRow = vsfgEquity.Row: TmpCol = vsfgEquity.Col
   
    'Last Year
    'Cols
    For IncCol = 2 To 9
        CurTot = 0
        For Inc = 3 To vsfgEquity.Cols - 2
            CurTot = CurTot + RVal(vsfgEquity.TextMatrix(IncCol, Inc))
        Next
        vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1) = CurTot
        If RVal(vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1)) = 0 Then vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1) = ""
    Next
    'Rows
    For IncCol = 3 To vsfgEquity.Cols - 1
        CurTot = 0
        For Inc = 2 To 9
            CurTot = CurTot + RVal(vsfgEquity.TextMatrix(Inc, IncCol))
        Next
        If CurTot <> 0 Then vsfgEquity.TextMatrix(10, IncCol) = CurTot
        If RVal(vsfgEquity.TextMatrix(10, IncCol)) = 0 Then vsfgEquity.TextMatrix(10, IncCol) = ""
    Next
    
    'This Year
    'Cols
    For IncCol = 10 To vsfgEquity.Rows - 3
        CurTot = 0
        For Inc = 3 To vsfgEquity.Cols - 2
            CurTot = CurTot + RVal(vsfgEquity.TextMatrix(IncCol, Inc))
        Next
        vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1) = CurTot
        If RVal(vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1)) = 0 Then vsfgEquity.TextMatrix(IncCol, vsfgEquity.Cols - 1) = ""
    Next
    'Rows
    For IncCol = 3 To vsfgEquity.Cols - 1
        CurTot = 0
        For Inc = 10 To vsfgEquity.Rows - 3
            CurTot = CurTot + RVal(vsfgEquity.TextMatrix(Inc, IncCol))
        Next
        vsfgEquity.TextMatrix(vsfgEquity.Rows - 2, IncCol) = CurTot
        If RVal(vsfgEquity.TextMatrix(vsfgEquity.Rows - 2, IncCol)) = 0 Then vsfgEquity.TextMatrix(vsfgEquity.Rows - 2, IncCol) = ""
    Next
    vsfgEquity.Row = TmpRow: vsfgEquity.Col = TmpCol
End Sub

Public Function GetDate(lngPeriodID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
sSql = "SELECT CONVERT(DateTime, PER.StartDt - 2, 103) AS StartDate, CONVERT(DateTime, PER.EndDt - 2, 103) AS EndDate, " & _
       "CONVERT(DateTime, PER1.StartDt - 2, 103) AS LastStartDate, CONVERT(DateTime, PER1.EndDt - 2, 103) AS LastEndDate " & _
       "FROM   Periods PER LEFT OUTER JOIN Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID WHERE PER.PeriodID =" & lngPeriodID
    With GetRecords(sSql)
        While Not .EOF
            If IsNull(.Fields("StartDate")) Then
                mStartDt = Format(DateValue(ServerDateTime), "dd/MMM/yyyy")
            Else
                mStartDt = Format(.Fields("StartDate") - 1, "dd/MMM/yyyy")
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
                mLastEndDt = Format(DateValue(ServerDateTime), "dd/MMMM/yyyy")
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

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub Form_Activate()
    If mPeriodID = pActivePeriodID Then tbrCtrls.Buttons("Modify").Enabled = True
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub Form_Resize()
    AdjustToScreen
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub vsfgEquity_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Row < 11 Then Cancel = True
    If Row = vsfgEquity.Rows - 2 Then Cancel = True
    If Row = vsfgEquity.Rows - 1 Then Cancel = True
    If Col = vsfgEquity.Cols - 1 Then Cancel = True
    If Col = 0 Then Cancel = True
End Sub

Private Sub vsfgEquity_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    If Col > 2 Then
        vsfgEquity.TextMatrix(Row, Col) = RVal(vsfgEquity.TextMatrix(Row, Col))
        If RVal(vsfgEquity.TextMatrix(Row, Col)) = 0 Then
            vsfgEquity.TextMatrix(Row, Col) = ""
        End If
    End If
    FindTotals
End Sub

Public Sub AdjustToScreen()
On Local Error Resume Next
    Anchor vsfgEquity, , , 15465
    Anchor tbrCtrls, 10230
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, ColInc As Long, lngParentID As Long, lngAcTypeID As Long
Dim IsInTran As Boolean, rsUpdate As New ADODB.Recordset
    For ColInc = 3 To vsfgEquity.Cols - 2
        lngAcTypeID = vsfgEquity.ValueMatrix(1, ColInc)
        With GetRecords("SELECT EquityType FROM AcTypes WHERE AcTypeID= " & vsfgEquity.ValueMatrix(1, ColInc))
            If Not .EOF Then
                If Val(.Fields("EquityType") & "") = 0 Then
                    If vsfgEquity.ValueMatrix(vsfgEquity.Rows - 2, ColInc) <> vsfgEquity.ValueMatrix(vsfgEquity.Rows - 1, ColInc) Then
                        pMVE.MsgBox "Amount Not Matching.(" & vsfgEquity.TextMatrix(0, ColInc) & ")", msgOK, "AuditMate", msgInformation, True
                        Exit Function
                    End If
                End If
            End If
            .Close
        End With
    Next
    '-------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    '---Updating master-------------------------
    lngParentID = GetActualID(mCompanyID, cnstAcTypeShareHoldersEquity)
    sSql = "DELETE FROM Schedules WHERE (AcTypeID IN (SELECT AcTypeID FROM AcTypes WHERE ParentAcTypeID = " & lngParentID & ") OR AcTypeID = " & lngParentID & ") AND PeriodID =" & mPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM Schedules WHERE 1 = 2"
    Set rsUpdate = GetRecords(sSql)
    With rsUpdate
        For ColInc = 3 To vsfgEquity.Cols - 2
            lngAcTypeID = vsfgEquity.ValueMatrix(1, ColInc)
            .AddNew
            .Fields("AcTypeID") = lngAcTypeID
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeEquity
            .Fields("NoteNo") = ""
            .Fields("IsFinished") = chkFinished
            .Fields("DerivedAmount") = vsfgEquity.ValueMatrix(vsfgEquity.Rows - 2, ColInc)
            .Fields("IsDetailed") = False
            SaveDateAndUser rsUpdate, True
            .Update
        Next
        .Close
    End With
    '--Updating Sub------------------------------------
    sSql = "SELECT * FROM FixedAssetSchedules WHERE 1 = 2"
    Set rsUpdate = GetRecords(sSql)
    With rsUpdate
        For ColInc = 3 To vsfgEquity.Cols - 2
            lngAcTypeID = vsfgEquity.ValueMatrix(1, ColInc)
            sSql = "DELETE FROM FixedAssetSchedules WHERE FixedAssetSchedules.AcTypeID = " & lngAcTypeID & " AND FixedAssetSchedules.PeriodID =" & mPeriodID
            AdoConn.Execute sSql
            For Inc = 10 To vsfgEquity.Rows - 2
                If Trim(vsfgEquity.TextMatrix(Inc, 1)) <> "" Then
                    .AddNew
                    .Fields("AcTypeID") = lngAcTypeID
                    .Fields("PeriodID") = mPeriodID
                    .Fields("ItemID") = Inc
                    .Fields("IsFinished") = chkFinished
                    .Fields("Amount") = Val(vsfgEquity.TextMatrix(Inc, ColInc))
                    .Fields("Description") = Trim(vsfgEquity.TextMatrix(Inc, 1))
                    .Update
                End If
            Next
        Next
        .Close
    End With
    '------Save to Balance Sheet-------------------------
    sSql = "DELETE FROM SchedulesSubBalanceSheet WHERE AcTypeID IN (SELECT AcTypeID FROM AcTypes WHERE ParentAcTypeID = " & lngParentID & ") AND PeriodID =" & mPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM SchedulesSubBalanceSheet WHERE 1 = 2"
    Set rsUpdate = GetRecords(sSql)
    With rsUpdate
        For ColInc = 3 To vsfgEquity.Cols - 2
            mdblTotalAmt = vsfgEquity.ValueMatrix(vsfgEquity.Rows - 2, ColInc)
            .AddNew
            !AcTypeID = vsfgEquity.ValueMatrix(1, ColInc)
            !PeriodID = mPeriodID
            !NoteNo = ""
            !DAmt = IIf(RVal(mdblTotalAmt) > 0, mdblTotalAmt, 0)
            !CAmt = IIf(RVal(mdblTotalAmt) < 0, mdblTotalAmt, 0)
            .Update
        Next
        .Close
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    Save = False
    ShowError
End Function

Private Sub vsfgEquity_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgEquity.ToolTipText = vsfgEquity.Text
End Sub

Public Sub PrintDoc()
    PrintShareholdersEquity mPeriodID
End Sub
