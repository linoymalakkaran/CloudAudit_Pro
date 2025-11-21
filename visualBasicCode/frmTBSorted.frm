VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmTBSorted 
   Caption         =   "Trial Balance"
   ClientHeight    =   8115
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   11985
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmTBSorted.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   8115
   ScaleWidth      =   11985
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgTrial 
      Height          =   7335
      Left            =   50
      TabIndex        =   0
      Top             =   0
      Width           =   11895
      _cx             =   20981
      _cy             =   12938
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9.75
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
      Rows            =   2
      Cols            =   11
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   350
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmTBSorted.frx":2EA5A
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
      ExplorerBar     =   7
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
End
Attribute VB_Name = "frmTBSorted"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mPeriodID As Long, mDefaultPeriodID As Long, mCompanyID As Long
Dim mPeriodDesc As String, mLastPeriodID As Long, mLastPeriodDesc As String

Public mstrThisPeriodDesc As String
Public mstrLastPeriodDesc As String
Public lngDecimals As Long

Const grdAcType3rd = 0
Const grdAcType4th = 1
Const grdAcName = 2
Const grdThisDebit = 3
Const grdThisCredit = 4
Const grdLastDebit = 5
Const grdLastCredit = 6
Const grdActualDr = 7
Const grdActualCr = 8
Const grdAcTypeID = 9
Const grdAcID = 10
Const grdCols = 11

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

Public Sub FormatGrid()
On Local Error Resume Next
    With vsfgTrial
        .ColWidth(grdAcType3rd) = GetProportionalValue(3500, False)
        .ColWidth(grdAcType4th) = GetProportionalValue(4000, False)
        .ColWidth(grdAcName) = GetProportionalValue(3450, False)
        .ColWidth(grdThisDebit) = GetProportionalValue(2000, False)
        .ColWidth(grdThisCredit) = GetProportionalValue(2000, False)
        .ColWidth(grdLastDebit) = GetProportionalValue(1900, False)
        .ColWidth(grdLastCredit) = GetProportionalValue(1900, False)

        .ColWidth(grdActualDr) = 0
        .ColWidth(grdActualCr) = 0
        .ColWidth(grdAcTypeID) = 0
        .ColWidth(grdAcID) = 0

'        .ColHidden(grdActualDr) = True
'        .ColHidden(grdActualCr) = True
'        .ColHidden(grdAcTypeID) = True
'        .ColHidden(grdAcID) = True

        .ExtendLastCol = False
        .ExplorerBar = flexExSortShowAndMove
        .ScrollTrack = True
'        .RowHeightMin = 350
        .Cell(flexcpFontSize, 0, grdAcType3rd, 0, grdLastCredit) = 10
        .Cell(flexcpFontBold, 0, grdAcType3rd, 0, grdLastCredit) = True

        .ColAlignment(grdAcType3rd) = flexAlignLeftCenter
        .ColAlignment(grdAcType4th) = flexAlignLeftCenter
        .ColAlignment(grdAcName) = flexAlignLeftCenter
        .ColAlignment(grdThisDebit) = flexAlignRightCenter
        .ColAlignment(grdThisCredit) = flexAlignRightCenter
        .ColAlignment(grdLastDebit) = flexAlignRightCenter
        .ColAlignment(grdLastCredit) = flexAlignRightCenter

        .Cols = grdCols
    End With
End Sub

Public Sub AdjustToScreen()
On Local Error Resume Next
    Anchor vsfgTrial, 50, 50, 19000, 10000
'    Anchor cmdRefresh, 9250, 10200, 1900, 365
    FormatGrid
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim RowInc As Long
'    For RowInc = 2 To vsfgTrial.Rows - 1
'        If vsfgTrial.TextMatrix(RowInc, grdAcType3rd) = "" Or vsfgTrial.TextMatrix(RowInc, grdAcType4th) = "" Or vsfgTrial.TextMatrix(RowInc, grdAcName) = "" Then
'            vsfgTrial.RowHeight(RowInc) = 1
'        Else
'            vsfgTrial.RowHeight(RowInc) = 350
'        End If
'    Next RowInc
End Sub

'Private Sub cmdRefresh_Click()
'    AdjustToScreen
'    CollectData
'End Sub

Private Sub Form_Resize()
    AdjustToScreen
    CollectData
End Sub

Public Function CollectData()
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, rsAcTypes As New ADODB.Recordset
Dim sSql1 As String, sSql2 As String
Dim sSqlTmpThis As String, sSqlTmpLast As String, sSqlHasJV As String, sSqlTmpActual As String
Dim crsAllAcHeads As New clsRecordSet, crsAcHeads As New clsRecordSet
Dim strActypeThird As String, strAcTypeFourth As String
Dim RowInc As Long
    vsfgTrial.Rows = 2
    mLastPeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & pActivePeriodID))
    mstrThisPeriodDesc = PickValue("Periods", "Description", "PeriodID = " & pActivePeriodID)
    mstrLastPeriodDesc = PickValue("Periods", "Description", "PeriodID = " & mLastPeriodID)

    vsfgTrial.TextMatrix(0, grdThisDebit) = mstrThisPeriodDesc & " Debit"
    vsfgTrial.TextMatrix(0, grdThisCredit) = mstrThisPeriodDesc & " Credit"
    vsfgTrial.TextMatrix(0, grdLastDebit) = mstrLastPeriodDesc & " Debit"
    vsfgTrial.TextMatrix(0, grdLastCredit) = mstrLastPeriodDesc & " Credit"

    sSql = "Select * From AcTypes Where CompanyID = " & pActiveCompanyID & " And TreeLevel = 3 And StatusID = 1 " & _
           "And    IsHidden = 0 Order By ParentAcTypeID"
    Set rsAcTypes = GetRecords(sSql)
        With rsAcTypes
            .MoveFirst
            While Not .EOF
'                vsfgTrial.Rows = vsfgTrial.Rows + 1
                Inc = vsfgTrial.Rows - 1
                vsfgTrial.TextMatrix(Inc, grdAcType3rd) = .Fields("AcTypeDescription") & ""
                strActypeThird = vsfgTrial.TextMatrix(Inc, grdAcType3rd)
                vsfgTrial.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
                sSql1 = "Select * From AcTypes Where CompanyID = " & pActiveCompanyID & " And TreeLevel = 4 And StatusID = 1 " & _
                        "And    IsHidden = 0 And ParentAcTypeID = " & vsfgTrial.TextMatrix(Inc, grdAcTypeID)
                With GetRecords(sSql1)
                    Do Until .EOF
                        vsfgTrial.TextMatrix(Inc, grdAcType3rd) = strActypeThird
                        vsfgTrial.TextMatrix(Inc, grdAcType4th) = .Fields("AcTypeDescription") & ""
                        strAcTypeFourth = vsfgTrial.TextMatrix(Inc, grdAcType4th)
                        vsfgTrial.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
                        sSqlTmpThis = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & pActivePeriodID & ")"

                        sSqlTmpLast = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE ETA.EntryID = EM.EntryID " & _
                                      "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & mLastPeriodID & ")"
                
                        sSqlHasJV = "SELECT COUNT(ETA.AcID) AS NoOfRec FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening <> 1 AND ETA.EntryID = EM.EntryID " & _
                                    "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & pActivePeriodID & ")"
                
                        sSqlTmpActual = "SELECT SUM(ETA.DAmt - ETA.CAmt) AS Amount FROM EntrySubAccounts ETA, Entries EM WHERE EM.IsOpening = 1 AND ETA.EntryID = EM.EntryID " & _
                                        "AND   (ETA.AcID = AH.AcID) And (EM.PeriodID = " & pActivePeriodID & ")"
                '        Checking Status ------------------
                        sSql2 = "SELECT   AH.*, (" & sSqlTmpThis & ") AS ThisAmount, (" & sSqlTmpLast & ") AS LastAmount, (" & sSqlTmpActual & ") AS ActualAmount, " & _
                                "CASE     WHEN (" & sSqlHasJV & ") > 0 THEN 1 ELSE 0 END AS ISOtherEntries " & _
                                "FROM     AcHeads AH WHERE CompanyID = " & pActiveCompanyID & " AND StatusID = 1 " & _
                                "ORDER BY TrialOrder"
                        crsAllAcHeads.BindRecords sSql2, AdoConn
                        crsAcHeads.BindRecordSet crsAllAcHeads, "AcTypeID|=|" & vsfgTrial.TextMatrix(Inc, grdAcTypeID)
                        With crsAcHeads
                            Do While Not .EOF
                                vsfgTrial.Rows = vsfgTrial.Rows + 1
                                Inc = vsfgTrial.Rows - 1
                                vsfgTrial.TextMatrix(Inc, grdAcType3rd) = strActypeThird
                                vsfgTrial.TextMatrix(Inc, grdAcType4th) = strAcTypeFourth
                                vsfgTrial.TextMatrix(Inc, grdAcName) = .Fields("AcName") & ""
                                vsfgTrial.TextMatrix(Inc, grdAcID) = .Fields("AcID") & ""
                                vsfgTrial.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
                                vsfgTrial.TextMatrix(Inc, grdThisDebit) = Format(IIf(Val(.Fields("ThisAmount") & "") > 0, Val(.Fields("ThisAmount") & ""), ""), "#,###")
                                vsfgTrial.TextMatrix(Inc, grdThisCredit) = Format(IIf(Val(.Fields("ThisAmount") & "") < 0, Abs(Val(.Fields("ThisAmount") & "")), ""), "#,###")
                                vsfgTrial.TextMatrix(Inc, grdLastDebit) = Format(IIf(Val(.Fields("LastAmount") & "") > 0, Val(.Fields("LastAmount") & ""), ""), "#,###")
                                vsfgTrial.TextMatrix(Inc, grdLastCredit) = Format(IIf(Val(.Fields("LastAmount") & "") < 0, Abs(Val(.Fields("LastAmount") & "")), ""), "#,###")
                                vsfgTrial.TextMatrix(Inc, grdActualDr) = IIf(Val(.Fields("ActualAmount") & "") > 0, Val(.Fields("ActualAmount") & ""), 0)
                                vsfgTrial.TextMatrix(Inc, grdActualCr) = IIf(Val(.Fields("ActualAmount") & "") < 0, Abs(Val(.Fields("ActualAmount") & "")), 0)
                                If vsfgTrial.ValueMatrix(Inc, grdThisDebit) = 0 Then vsfgTrial.TextMatrix(Inc, grdThisDebit) = ""
                                If vsfgTrial.ValueMatrix(Inc, grdThisCredit) = 0 Then vsfgTrial.TextMatrix(Inc, grdThisCredit) = ""
                                If vsfgTrial.ValueMatrix(Inc, grdLastDebit) = 0 Then vsfgTrial.TextMatrix(Inc, grdLastDebit) = ""
                                If vsfgTrial.ValueMatrix(Inc, grdLastCredit) = 0 Then vsfgTrial.TextMatrix(Inc, grdLastCredit) = ""
'                                vsfgTrial.Rows = vsfgTrial.Rows + 1
'                                Inc = vsfgTrial.Rows - 1
                                .MoveNext
                            Loop
                            .Clear
                        End With
                        vsfgTrial.Rows = vsfgTrial.Rows + 1
                        Inc = vsfgTrial.Rows - 1
                        .MoveNext
                    Loop
                End With
                .MoveNext
            Wend
        End With
'        For RowInc = 2 To vsfgTrial.Rows - 1
'            If vsfgTrial.TextMatrix(RowInc, grdAcType3rd) = "" Or vsfgTrial.TextMatrix(RowInc, grdAcType4th) = "" Or vsfgTrial.TextMatrix(RowInc, grdAcName) = "" Then
'                vsfgTrial.RowHeight(RowInc) = 1
'            Else
'                vsfgTrial.RowHeight(RowInc) = 350
'            End If
'        Next RowInc
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub Form_Unload(Cancel As Integer)
    ShowFormInMDI "frmTrialBalance", "Trial Balance", pActiveCompanyID, pActivePeriodID
End Sub

Private Sub vsfgTrial_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
    With vsfgTrial
        .TextMatrix(Row, Col) = Format(.TextMatrix(Row, Col), "#,##0" & IIf(lngDecimals > 0, "." & String(lngDecimals, "0"), ""))
        If Col = grdThisCredit Then
            If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then
                If Val(.TextMatrix(Row, grdThisDebit)) > 0 Then .TextMatrix(Row, grdThisDebit) = ""
            End If
        ElseIf Col = grdThisDebit Then
            If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then
                If Val(.TextMatrix(Row, grdThisCredit)) > 0 Then .TextMatrix(Row, grdThisCredit) = ""
            End If
        End If
        If Col = grdThisCredit Or Col = grdThisDebit Then
            SaveTrial , Row
        End If
    End With
End Sub

'Private Sub vsfgTrial_AfterSort(ByVal Col As Long, Order As Integer)
'    SetDefaults
'End Sub

Private Sub vsfgTrial_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error Resume Next
    If Row > 0 Then
        Select Case Col
            Case grdAcType3rd, grdAcType4th, grdAcName, grdLastDebit, grdLastCredit
                Cancel = True
            Case grdThisDebit, grdThisCredit
                Cancel = False
            Case Else
            
        End Select
        If Col = grdThisDebit Then
            If vsfgTrial.ValueMatrix(Row, grdThisCredit) <> 0 Then
                Cancel = True
                Exit Sub
            End If
        ElseIf Col = grdThisCredit Then
            If vsfgTrial.ValueMatrix(Row, grdThisDebit) <> 0 Then
                Cancel = True
            End If
        End If
    End If
End Sub

Private Sub vsfgTrial_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgTrial.ToolTipText = vsfgTrial.Text
End Sub

Private Sub SetDefaults()
On Local Error GoTo Err_Exit
Dim iCounterRow As Long, Inc As Long
    With vsfgTrial
        For iCounterRow = vsfgTrial.TopRow To vsfgTrial.Rows - 1
            For Inc = 1 To vsfgTrial.Rows - 1
                If vsfgTrial.RowIsVisible(iCounterRow) Then
                    If .Row > 0 Then
                        .Cell(flexcpText, iCounterRow, grdAcType3rd, iCounterRow, grdLastCredit) = .Cell(flexcpText, Inc, grdAcType3rd, Inc, grdLastCredit)
                    End If
                Else
                    Exit For
                End If
            Next Inc
        Next iCounterRow
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function SaveTrial(Optional IsShow As Boolean = False, Optional Row As Long = -1) As Boolean
On Local Error GoTo Err_Exit
Dim lngInc As Long, sSql As String, dtRef As Date, lngEntryID As Long, lngAcSlNo As Long, lngTmpSlNo As Long
    Screen.MousePointer = vbHourglass
    dtRef = Val(PickValue("Periods", "StartDt", "PeriodID = " & pActivePeriodID))
    AdoConn.BeginTrans
    lngEntryID = SaveEntry(pActivePeriodID, "Opening...", dtRef, cnstStatusActive, "", 1)
    If lngEntryID = -1 Then
        Err.Raise vbObjectError + 1, , "Error While Saving Opening Entry."
    End If
    If Row = -1 Then
        sSql = "Delete from EntrySubAccounts Where EntryID = " & lngEntryID
    Else
        sSql = "Delete from EntrySubAccounts Where EntryID = " & lngEntryID & " AND AcID = " & vsfgTrial.ValueMatrix(Row, grdAcID)
    End If
    AdoConn.Execute sSql
    With vsfgTrial
        For lngInc = IIf(Row <> -1, Row, 0) To IIf(Row <> -1, Row, .Rows - 1)
            If .ValueMatrix(lngInc, grdAcID) <> 0 Then
                'if restricted row save actual opening value
                If .Cell(flexcpBackColor, lngInc, grdAcName) = pclrRestrictionColor Then
                    If (.ValueMatrix(lngInc, grdActualDr) + .ValueMatrix(lngInc, grdActualCr)) <> 0 Then
                        lngAcSlNo = lngAcSlNo + 1
                        If Row = -1 Then
                            lngTmpSlNo = lngAcSlNo
                        Else
                            lngTmpSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                        End If
                        If Not SaveSubEntries(lngEntryID, lngTmpSlNo, .ValueMatrix(lngInc, grdAcID), .ValueMatrix(lngInc, grdActualDr), .ValueMatrix(lngInc, grdActualCr), "", 1) Then
                            Err.Raise vbObjectError + 1, , "Error While Saving '" & .TextMatrix(lngInc, grdAcName) & "'"
                        End If
                    End If
                Else
                    If (.ValueMatrix(lngInc, grdThisDebit) + .ValueMatrix(lngInc, grdThisCredit)) <> 0 Then
                        lngAcSlNo = lngAcSlNo + 1
                        If Row = -1 Then
                            lngTmpSlNo = lngAcSlNo
                        Else
                            lngTmpSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                        End If
                        If Not SaveSubEntries(lngEntryID, lngTmpSlNo, .ValueMatrix(lngInc, grdAcID), .ValueMatrix(lngInc, grdThisDebit), .ValueMatrix(lngInc, grdThisCredit), "", 1) Then
                            Err.Raise vbObjectError + 1, , "Error While Saving '" & .TextMatrix(lngInc, grdAcName) & "'"
                        End If
                    End If
                End If
            End If
        Next
    End With
    'Ref No: 003 - 25/03/08
    '---Changing Status---------------------
    If Row <> -1 Then
        ChangeDatasheetStatus pActivePeriodID, , vsfgTrial.ValueMatrix(Row, grdAcTypeID)
    End If
    SaveTrial = True
    AdoConn.CommitTrans
    Screen.MousePointer = vbDefault
'    If Not IsShow And Row = -1 Then
'        ConvergeToControl txtConverge, 6
'    End If
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
    AdoConn.RollbackTrans
    SaveTrial = False
End Function

