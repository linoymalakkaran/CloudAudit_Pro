Attribute VB_Name = "mdlPrint"
Option Explicit

Dim mStartDt As Date, mEndDt As Date, mLaststartDt As Date, mLastEndDt As Date
Dim strThisYear As String, strLastYear As String, strThisPeriod As String, strLastPeriod As String
Dim crsLeadSheetRpt As New clsReports

Public Sub PrintLeadSheets(lngAcTypeID As Long, mPeriodID As Long, Optional IsPrintSubSheets As Boolean = False, Optional lngLevels As Long, Optional IsSubSheet As Boolean = False)
On Local Error GoTo Err_Exit
Dim strTmp As String, sSql As String, sSql1 As String, sSql2 As String, strPeriodShortName As String, strFile As String, strCompanyName As String
Dim strAcTypeName As String, strAcTypeRefNo As String, Inc As Long, strPeriodDerivedShortName As String, lngComparePeriodID As Long
Dim rsTmp As New Recordset, dblTmp As Double, dblThisTotal As Double, dblLastTotal As Double, TmpY As Long, strAcTypes As String

Const cnstRowHeightMin = 500

Const grdParticulars = 0
Const grdDebit = 1
Const grdCredit = 2
Const grdRefNo = 3
Const grdCols = 4

    sSql = "SELECT  Periods.*, Companies.*, PER1.ShortName AS DerivedShortName " & _
           "FROM    Periods INNER JOIN Companies ON Periods.CompanyID = Companies.CompanyID LEFT OUTER JOIN Periods PER1 ON Periods.ComparePeriodID = PER1.PeriodID WHERE Periods.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            strPeriodShortName = .Fields("ShortName") & ""
            lngComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            strPeriodDerivedShortName = .Fields("DerivedShortName") & ""
            strFile = .Fields("JobCode") & ""
            strCompanyName = .Fields("CompanyName") & ""
        End If
        .Close
    End With
    sSql = "SELECT * FROM AcTypes WHERE AcTypeID = " & lngAcTypeID
    With GetRecords(sSql)
        If Not .EOF Then
            strAcTypeName = .Fields("AcTypeDescription") & ""
            strAcTypeRefNo = .Fields("RefNo") & ""
        End If
        .Close
    End With
    '--------------------------------------------------------------------
    With crsLeadSheetRpt
        If IsSubSheet Then
            .CreatePageBreak
        Else
            .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
        End If
        .CreateText "Year", 1000, 1500, 1000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & strPeriodShortName, 2000, 1500, 2000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "File", 1000, 2000, 1000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & strFile, 2000, 2000, 1000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "No.", 8000, 1500, 1000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateRectangle 8800, 1300, 2000, 600
        .CreateText strAcTypeRefNo, 8800, 1400, 2000, 600, , , , , , , , True, , , 18, "Century", ercParaCentre
        .CreateText "Prepared By", 8000, 2000, 1500, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & pUserName, 9500, 2000, 2000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "Date", 8000, 2500, 1500, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & Format(DateValue(ServerDateTime), "dd-MM-yyyy"), 9500, 2500, 2000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "Client", 1000, 3000, 1000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & strCompanyName, 2000, 3000, 5000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "Subject", 1000, 3500, 1000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText ": " & strAcTypeName, 2000, 3500, 4000, 600, , , , , , , , False, , , 11, "Times New Roman"
        .CreateText "Reviewed By................................", 8000, 3000, 4000, 600, , , , , , , , True, , , 11, "Times New Roman"
        .CreateText "Date.............................................", 8000, 3500, 4000, 600, , , , , , , , True, , , 11, "Times New Roman"

        .StartTable 1000, 4000, 10000, 8000, rptTTCustomTable, , , , , , , , , tbAll
        .TableCols = grdCols: .TableRows = 1: Inc = 0

        .TableCell(rptTblText, Inc, grdParticulars) = ""
        .TableCell(rptTblColWidth, , grdParticulars) = 4500
        .TableCell(rptTblAlignment, Inc, grdParticulars) = taLeftMiddle

        .TableCell(rptTblText, Inc, grdDebit) = strPeriodShortName
        .TableCell(rptTblAlignment, Inc, grdDebit) = taCenterMiddle
        .TableCell(rptTblColWidth, , grdDebit) = 2000

        .TableCell(rptTblText, Inc, grdCredit) = strPeriodDerivedShortName
        .TableCell(rptTblAlignment, Inc, grdCredit) = taCenterMiddle
        .TableCell(rptTblColWidth, , grdCredit) = 2000

        .TableCell(rptTblText, Inc, grdRefNo) = "Ref.No"
        .TableCell(rptTblAlignment, Inc, grdRefNo) = taLeftMiddle
        .TableCell(rptTblColWidth, , grdRefNo) = 1500

        .TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdRefNo) = True
        .TableCell(rptTblFontSize, Inc, grdParticulars, Inc, grdRefNo) = 14
        .TableCell(rptTblFontName, Inc, grdParticulars, Inc, grdRefNo) = "Times New Roman"
        .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdRefNo) = 400

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdRefNo) = cnstRowHeightMin

        sSql1 = "SELECT dbo.fn_GetAcTypeBal(AcTypes.AcTypeID, *PER*) AS Amount"
        sSql = "SELECT * From(SELECT AcTypeID AS TypeID, AcTypeDescription AS Particulars, RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, TrialOrder, TypeNature, 1 AS Ord " & _
               "FROM     AcTypes Where ParentAcTypeID = " & lngAcTypeID
        sSql1 = "SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = *PER*"
        sSql = sSql & " Union SELECT 0 AS TypeID, AH.AcName AS Particulars, '' AS RefNo, (" & Replace(sSql1, "*PER*", mPeriodID) & ")AS ThisPeriod, (" & Replace(sSql1, "*PER*", lngComparePeriodID) & ") AS LastPeriod, AH.TrialOrder,AT.TypeNature, 2 AS Ord " & _
               "FROM    AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE AH.AcTypeID = " & lngAcTypeID & ")TMP1 WHERE ThisPeriod <> 0 OR LastPeriod <>0 ORDER BY Ord, TrialOrder"
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("Particulars") & ""
            .TableCell(rptTblAlignment, Inc, grdParticulars) = taLeftMiddle
            dblTmp = GetSignedValue(Val(rsTmp.Fields("ThisPeriod") & ""), rsTmp.Fields("TypeNature") & "")
            dblThisTotal = dblThisTotal + dblTmp
            .TableCell(rptTblText, Inc, grdDebit) = IIf(dblTmp < 0, "(" & Format(Abs(dblTmp), "#,##0") & ")", Format(Abs(dblTmp), "#,##0"))
            .TableCell(rptTblAlignment, Inc, grdDebit) = taRightMiddle
            dblTmp = GetSignedValue(Val(rsTmp.Fields("LastPeriod") & ""), rsTmp.Fields("TypeNature") & "")
            dblLastTotal = dblLastTotal + dblTmp
            .TableCell(rptTblText, Inc, grdCredit) = IIf(dblTmp < 0, "(" & Format(Abs(dblTmp), "#,##0") & ")", Format(Abs(dblTmp), "#,##0"))
            .TableCell(rptTblAlignment, Inc, grdCredit) = taRightMiddle
            .TableCell(rptTblText, Inc, grdRefNo) = rsTmp.Fields("RefNo") & ""
            .TableCell(rptTblAlignment, Inc, grdRefNo) = taLeftMiddle

            .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdRefNo) = cnstRowHeightMin
            .TableCell(rptTblFontSize, Inc, grdParticulars, Inc, grdRefNo) = 14
            .TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdRefNo) = False
            .TableCell(rptTblFontName, Inc, grdParticulars, Inc, grdRefNo) = "Times New Roman"

            strAcTypes = strAcTypes & " " & Val(rsTmp.Fields("TypeID") & "") & ";"
            rsTmp.MoveNext
        Wend
        rsTmp.Close

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdRefNo) = cnstRowHeightMin
        .TableCell(rptTblText, Inc, grdDebit) = IIf(dblThisTotal < 0, "(" & Format(Abs(dblThisTotal), "#,##0") & ")", Format(Abs(dblThisTotal), "#,##0"))
        .TableCell(rptTblAlignment, Inc, grdDebit) = taRightMiddle
        .TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastTotal < 0, "(" & Format(Abs(dblLastTotal), "#,##0") & ")", Format(Abs(dblLastTotal), "#,##0"))
        .TableCell(rptTblAlignment, Inc, grdCredit) = taRightMiddle
        .TableCell(rptTblIsBold, Inc, grdDebit, Inc, grdCredit) = True
        .TableCell(rptTblFontSize, Inc, grdDebit, Inc, grdCredit) = 14
        .TableCell(rptTblRowHeight, 0, , .TableRows - 1) = cnstRowHeightMin
        .EndTable

        'Drawing lines around table
        .CreateLine 1000, 4000, 11000, 4000
        '.CreateLine 1000, 4400, 11000, 4400
        .CreateLine 1000, 4000, 1000, 14000
        .CreateLine 11000, 4000, 11000, 14000
        .CreateLine 5500, 4000, 5500, 14000
        .CreateLine 7500, 4000, 7500, 14000
        .CreateLine 9500, 4000, 9500, 14000
        .CreateLine 1000, 14000, 11000, 14000
        'Total Lines
        'TmpY = 4400 + ((Inc - 1) * cnstRowHeightMin)
        '.CreateLine 5500, TmpY, 9500, TmpY
        'TmpY = 4400 + ((Inc) * cnstRowHeightMin)
        '.CreateLine 5500, TmpY, 9500, TmpY
        'TmpY = 4400 + ((Inc) * cnstRowHeightMin) + 60
        '.CreateLine 5500, TmpY, 9500, TmpY

        '10 - Mar - 2008
        'Ref No:011-13/04/08
        .CreatePicture MDIFormMain.imgHamtLogo, 8000, 14550, 3000, 2000
        '---Printing sub sheets------------------------------------------------------
        If IsPrintSubSheets And lngLevels > 0 Then
            sSql = "SELECT * From AcTypes WHERE ParentAcTypeID =" & lngAcTypeID & " ORDER BY TrialOrder"
            With GetRecords(sSql)
                While Not .EOF
                    If InStr(1, strAcTypes, " " & Val(.Fields("AcTypeID") & "") & ";") <> 0 Then
                        PrintLeadSheets Val(.Fields("AcTypeID") & ""), mPeriodID, True, lngLevels - 1, True
                    End If
                    .MoveNext
                Wend
                .Close
            End With
        End If
        If Not IsSubSheet Then
            .EndReport
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function GetPrintingAddress(lngCompanyID As Long) As String
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "Select * From Companies Where CompanyID = " & lngCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            If Trim(.Fields("CompanyAdd2") & "") <> "" And Trim(.Fields("CompanyAdd3") & "") <> "" Then
                GetPrintingAddress = Trim(.Fields("CompanyAdd2") & "") & " - " & Trim(.Fields("CompanyAdd3") & "")
            Else
                GetPrintingAddress = Trim(.Fields("CompanyAdd2") & "") & Trim(.Fields("CompanyAdd3") & "")
            End If
        End If
        .Close
    End With
    GetPrintingAddress = vbNewLine & GetPrintingAddress
Exit Function
Err_Exit:

End Function

Public Function GetFixedAssetSchedulePeriod(lngPeriodID) As String
On Local Error Resume Next
Dim sSql As String, mdtStartDate As Date, mdtEndDate As Date
    sSql = "Select * From Periods Where PeriodID = " & lngPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mdtStartDate = CDate(Val(.Fields("StartDt") & ""))
            mdtEndDate = CDate(Val(.Fields("EndDt") & ""))
            If DateDiff("d", mdtEndDate, DateAdd("yyyy", 1, mdtStartDate)) = 1 Then
                GetFixedAssetSchedulePeriod = "For the year ended " & Format(Val(.Fields("EndDt") & ""), "MMMM dd,YYYY")
                strThisYear = "year"
                strLastYear = "year"
            Else
                GetFixedAssetSchedulePeriod = "For the period from " & Format(Val(.Fields("StartDt") & ""), "MMMM dd,YYYY") & " to " & Format(Val(.Fields("EndDt") & ""), "MMMM dd,YYYY")
                strThisPeriod = "period"
                strLastPeriod = "period"
                strThisYear = ""
                strLastYear = ""
            End If
        End If
        .Close
    End With
End Function

Public Function PrintFixedAssetSchedules(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim strTmp As String, crsFixedAsset As New clsReports, rsTmp As New Recordset, rsTmp1 As New Recordset, sSql As String, RowInc As Long, Note As String
Dim Inc As Long, TmpFmt As String, Fmt() As String, ColInc As Long
Dim curCurrentYrTot As Currency, curLastYrTot As Currency
Dim mCompanyID As Long, mDerivedPeriodID As Long, lngStartDt As Long, lngEndDt As Long, tmpAcTypeName As String
Dim lngInc As Long, lngAcTypeID As Long, Inc1 As Long, lngLastVisibleRow As Long
Dim blnIsValueExists As Boolean, strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1

    If Not crptMain Is Nothing Then
        Set crsFixedAsset = crptMain
    End If
    sSql = "SELECT  PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, " & _
           "        PER1.StartDt AS DerivedStartDt, PER1.EndDt AS DerivedEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID " & _
           "WHERE   PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            lngAcTypeID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
            mStartDt = Format(Val(.Fields("StartDt") & ""), "dd/MMM/yyyy")
            mEndDt = Format(Val(.Fields("EndDt") & ""), "dd/MMMM/yyyy")
        End If
        .Close
    End With
    'Ref No:- 002 - 01/07/2009 --------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    With crsFixedAsset
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000 * 0.5, 1440, 1240 * 0.5, 1440 * 0.5, orLandscape
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440 * 0.5, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("FixAssetStmtHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440 * 0.5, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440 * 0.5, 2800, 16000, 2800, , , , , , , orLandscape
        End If
        '--- Filling Groupname and NoteNo --------------------------------------------------------------
        .StartTable 1440 * 0.5, 2900, 10000, 10000, rptTTFixedAssetsSchedule, , , , , , , , orLandscape
        sSql = "SELECT AT.AcTypeID, AT.AcTypeDescription FROM AcTypes AT WHERE AT.ParentAcTypeID = " & lngAcTypeID & " AND AT.AcTypeID In(SELECT DISTINCT FAS.AcTypeID " & _
               "FROM FixedAssetSchedules FAS WHERE FAS.AcTypeID = AT.AcTypeID AND FAS.PeriodID = " & mPeriodID & " AND FAS.Amount <> 0) "
        Set rsTmp = GetRecords(sSql)
        If Not rsTmp.EOF Then
            Inc1 = rsTmp.RecordCount
        End If
        rsTmp.Close
        .TableCols = Inc1 + 3: .TableRows = 1: Inc = 0
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 4000
        .TableCell(rptTblColWidth, Inc, grdNoteNo) = 500
        sSql = "SELECT AcTypes.AcTypeDescription, Schedules.NoteNo FROM Schedules INNER JOIN AcTypes ON Schedules.AcTypeID = AcTypes.AcTypeID " & _
               "Where Schedules.PeriodID = " & mPeriodID & " And Schedules.AcTypeID =" & lngAcTypeID
        Set rsTmp = GetRecords(sSql)
        If Not rsTmp.BOF Then
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, 0, grdNoteNo) = UCase(rsTmp.Fields("NoteNo") & ".")
            .TableCell(rptTblText, 0, grdParticulars) = rsTmp.Fields("AcTypeDescription") & ""
            .TableCell(rptTblIsBold, 0, grdNoteNo, 0, grdParticulars) = True
            .TableCell(rptTblRowHeight, 0, grdNoteNo, 0, grdParticulars) = 400
            .TableCell(rptTblAlignment, 0, grdNoteNo, 0, grdParticulars) = taCenterTop
        End If
        .TableRows = .TableRows + 2: Inc = Inc + 2
        '--- Putting Particulars --------------------------------
        sSql = "SELECT ItemID AS ItID, Description AS ItemDesc, Format AS Fmt " & _
               "FROM FixedAssetScheduleItems ORDER BY ItemID"
        Set rsTmp1 = GetRecords(sSql)
        While Not rsTmp1.EOF
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc") & ""
            TmpFmt = rsTmp1.Fields("Fmt") & ""
            Select Case TmpFmt
                Case ""
                    .TableCell(rptTblIsBold, Inc, grdParticulars) = False
                    .TableCell(rptTblText, Inc, grdParticulars) = IIf(rsTmp1.Fields("ItemDesc") = "-", "", rsTmp1.Fields("ItemDesc"))
                Case Else
                    Fmt = Split(TmpFmt, "|")
                    For lngInc = 0 To UBound(Fmt)
                        Select Case Fmt(lngInc)
                            Case "B"
                                .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                                .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc")
                            Case "BFY"
                                .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & IIf(Month(mStartDt) = 1, Year(mStartDt), Year(mStartDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                            Case "EFY"
                                .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mEndDt) & "/" & Month(mEndDt) & "/" & IIf(Month(mEndDt) = 1, Year(mStartDt), Year(mEndDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                            Case Else
                                Select Case Left(Fmt(lngInc), 4)
                                    Case "BFY-"
                                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & IIf(Month(mStartDt) = 1, Year(mStartDt), Year(mStartDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                                    Case "EFY-"
                                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("ItemDesc") & " " & Format(DateAdd("d", Val(Mid(Fmt(lngInc), 4)), Format(Day(mStartDt) & "/" & Month(mStartDt) & "/" & IIf(Month(mStartDt) = 1, Year(mStartDt), Year(mStartDt)), "dd/MM/yyyy")), "MMMM dd, yyyy")
                                End Select
                        End Select
                    Next
            End Select
            rsTmp1.MoveNext
        Wend
        rsTmp1.Close
        '--- Putting Groups -------------------------------------------------------------------------------
        For Inc = 2 To Inc1 + 2
            .TableCell(rptTblColWidth, , Inc) = 12600 / (2 + Inc1) '11500 / (2 + Inc1)
        Next Inc
        sSql = "SELECT AT.AcTypeDescription AS AcTypeDescription, AT.AcTypeID, FAS.Amount AS Amount, FAS.ItemID FROM AcTypes AT INNER JOIN " & _
               "FixedAssetSchedules FAS ON AT.AcTypeID = FAS.AcTypeID " & _
               "Where AT.ParentAcTypeID = " & lngAcTypeID & " AND AT.CompanyID = " & mCompanyID & " And FAS.PeriodID = " & mPeriodID & " AND FAS.Amount <> 0 ORDER BY AT.AcTypeDescription"
        Set rsTmp1 = GetRecords(sSql)
        Inc = 1
        While Not rsTmp1.EOF
            If tmpAcTypeName <> rsTmp1.Fields("AcTypeDescription") & "" Then
                tmpAcTypeName = rsTmp1.Fields("AcTypeDescription") & ""
                Inc = Inc + 1
            End If
            .TableCell(rptTblText, 2, Inc) = rsTmp1.Fields("AcTypeDescription")  '& vbNewLine & "AED"
            .TableCell(rptTblUnderline, 2, Inc) = True
            .TableCell(rptTblAlignment, 2, Inc) = taLeftMiddle
            .TableCell(rptTblRowHeight, 2, Inc) = 800
            curCurrentYrTot = RVal(rsTmp1.Fields("Amount") & "")
            .TableCell(rptTblText, Val(rsTmp1.Fields("ItemID") & "") + 3, Inc) = IIf(curCurrentYrTot > 0, Format(curCurrentYrTot, "##,##0"), "(" & Format(Abs(curCurrentYrTot), "##,##0") & ")")
            If curCurrentYrTot = 0 Then .TableCell(rptTblText, rsTmp1.Fields("ItemID") + 3, Inc) = "         -"
            .TableCell(rptTblAlignment, Val(rsTmp1.Fields("ItemID") & "") + 3, Inc) = taRightMiddle
            rsTmp1.MoveNext
        Wend
        .TableCell(rptTblText, 2, .TableCols - 1) = "Total"
        .TableCell(rptTblUnderline, 2, .TableCols - 1) = True
        .TableCell(rptTblIsBold, 2, 0, 1, .TableCols - 1) = True
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblAlignment, , .TableCols - 1) = taRightMiddle
        .TableCell(rptTblRowHeight, 2, 1, 2, .TableCols - 1) = 800
        For RowInc = 4 To .TableRows - 1
            curCurrentYrTot = 0
            For Inc = 2 To .TableCols - 1
                If Left(.TableCell(rptTblText, RowInc, Inc), 1) = "(" Then
                    curLastYrTot = RVal(Mid(.TableCell(rptTblText, RowInc, Inc), 2)) * -1
                Else
                    curLastYrTot = RVal(.TableCell(rptTblText, RowInc, Inc))
                End If
                curCurrentYrTot = curCurrentYrTot + curLastYrTot
                .TableCell(rptTblIsBold, RowInc, Inc) = .TableCell(rptTblIsBold, RowInc, grdParticulars)
                .TableCell(rptTblUnderline, RowInc, Inc) = .TableCell(rptTblIsBold, RowInc, grdParticulars)
            Next Inc
            .TableCell(rptTblText, RowInc, .TableCols - 1) = IIf(curCurrentYrTot >= 0, Format(curCurrentYrTot, "##,##0"), "(" & Format(Abs(curCurrentYrTot), "##,##0") & ")")
            If curCurrentYrTot = 0 Then .TableCell(rptTblText, RowInc, .TableCols - 1) = ""
        Next RowInc
        .TableCell(rptTblIsBold, 1, 2, 1, .TableCols - 1) = True
        .TableCell(rptTblAlignment, 1, 2, 1, .TableCols - 1) = taRightMiddle
        .TableCell(rptTblUnderline, 8, 2, 8, .TableCols - 1) = True
        .TableCell(rptTblUnderline, 14, 2, 14, .TableCols - 1) = True
        .TableCell(rptTblUnderline, 17, 2, 17, .TableCols - 1) = True
        .TableCell(rptTblText, 3, 2, , .TableCols - 1) = ""
        .TableCell(rptTblText, 10, 2, , .TableCols - 1) = ""
        .TableCell(rptTblText, 16, 2, , .TableCols - 1) = ""
        If .TableRows > 17 Then
            .TableCell(rptTblUnderline, 18, 2, 18, .TableCols - 1) = True
        End If
        .TableCell(rptTblText, 3, 2, , .TableCols - 1) = strCurrency                         '"AED"
        .TableCell(rptTblIsBold, 3, 2, , .TableCols - 1) = True
        .TableCell(rptTblUnderline, 3, 2, , .TableCols - 1) = True
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblRowHeight, 3, 0, .TableRows - 1, .TableCols - 1) = 380
        .TableCell(rptTblAlignment, , 1) = taLeftMiddle
        .TableCell(rptTblAlignment, 1, 2, .TableRows - 1, .TableCols - 1) = taRightMiddle
        .TableCell(rptTblRowHeight, .TableRows - 1, 1, .TableRows - 1, .TableCols - 1) = 400
        .TableCell(rptTblUnderline, .TableRows - 1, 2, .TableRows - 1, .TableCols - 1) = True
        For Inc = 4 To .TableRows - 1
            If .TableCell(rptTblText, Inc, 1) = "" Then
                .TableCell(rptTblRowHeight, Inc, , Inc) = 200
            End If
        Next Inc
        For Inc = 5 To 9
            For ColInc = 2 To .TableCols - 1
                If .TableCell(rptTblText, Inc, ColInc) = "" Then
                    .TableCell(rptTblText, Inc, ColInc) = "           -"
                End If
            Next ColInc
        Next Inc
        For Inc = 12 To 15
            For ColInc = 2 To .TableCols - 1
                If .TableCell(rptTblText, Inc, ColInc) = "" Then
                    .TableCell(rptTblText, Inc, ColInc) = "           -"
                End If
            Next ColInc
        Next Inc
        For Inc = 18 To .TableRows - 1
            For ColInc = 2 To .TableCols - 1
                If .TableCell(rptTblText, Inc, ColInc) = "" Then
                    .TableCell(rptTblText, Inc, ColInc) = "           -"
                End If
            Next ColInc
        Next Inc
        For Inc = 5 To .TableRows - 1
            blnIsValueExists = False
            For ColInc = 2 To .TableCols - 1
                If Val(.TableCell(rptTblIsBold, Inc, ColInc)) = 1 Then
                    lngLastVisibleRow = GetLastVisibleRow(crsFixedAsset, Inc - 1, 4)
                    If lngLastVisibleRow > -1 Then
                        .TableCell(rptTblUnderline, lngLastVisibleRow, ColInc) = True
                    End If
                End If
                If Trim(.TableCell(rptTblText, Inc, ColInc)) <> "-" Then
                    blnIsValueExists = True
                End If
            Next ColInc
            If Not blnIsValueExists Then
                .TableCell(rptTblRowHeight, Inc, 0, Inc, .TableCols - 1) = 1
            End If
        Next Inc
        .EndTable
        Set rsTmp = Nothing
    End With
    If blnIsPreview Then
        If crptMain Is Nothing Then
            crsFixedAsset.EndReport
            crsFixedAsset.Clear
            Set crsFixedAsset = Nothing
        End If
    Else
        Set PrintFixedAssetSchedules = crsFixedAsset
    End If
Exit Function
Err_Exit:
    ShowError
End Function

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

Public Function PrintShareholdersEquity(ByVal mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim strTmp As String, crsEquity As New clsReports, rsTmp As New Recordset
Dim rsTmp1 As New Recordset, sSql As String, Inc As Long, RowInc As Long
Dim lngInc As Long, tmpStr As String, Inc1 As Long, lngCols As Long, dblTotalColWidth As Double, lngLineWidth As Long
Dim curCurrentYrTot As Currency, curLastYrTot As Currency, orOrientation As VSPrinter8LibCtl.OrientationSettings
Dim mCompanyID As Long, lngParentID As Long, mDerivedPeriodID As Long, ColInc As Long, lngLastVisibleRow As Long
Const grdParticulars = 0
    If Not crptMain Is Nothing Then
        Set crsEquity = crptMain
    End If
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, " & _
           "PER1.StartDt AS DerivedStartDt, PER1.EndDt AS DerivedEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID " & _
           "WHERE PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mDerivedPeriodID = Val(.Fields("DerivedPeriodID") & "")
            lngParentID = GetActualID(mCompanyID, cnstAcTypeShareHoldersEquity)
            mStartDt = Val(.Fields("StartDt") & "")
            mEndDt = Val(.Fields("EndDt") & "")
        End If
        .Close
    End With
    sSql = "SELECT COUNT(DISTINCT AT.AcTypeDescription) AS RecCount From AcTypes AT WHERE AT.AcTypeID In(SELECT DISTINCT  FAS.AcTypeID " & _
           "From FixedAssetSchedules FAS WHERE AT.ParentAcTypeID = " & lngParentID & " AND FAS.PeriodID=" & mPeriodID & " AND FAS.AMOUNT <> 0)"
    Set rsTmp = GetRecords(sSql)
    If Not rsTmp.EOF Then
        lngCols = rsTmp!RecCount + 2
    End If
    If lngCols > 5 Then
        orOrientation = orLandscape
        dblTotalColWidth = 12000
        lngLineWidth = 16000
    Else
        orOrientation = orPortrait
        dblTotalColWidth = 6500
        lngLineWidth = 11000
    End If
    With crsEquity
        .Orientation = orOrientation
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, orOrientation
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, Val(lngLineWidth), 1000, , , , , , , orOrientation, True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("EquityStmtHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, Val(dblTotalColWidth), 1000, , , , , , , orOrientation, True, , , 12, "Times New Roman"
            .CreateLine 1440, 2800, Val(lngLineWidth), 2800, , , , , , , orOrientation
        End If
        '---Putting Particulars------------------------------
        .StartTable 1440, 2900, Val(dblTotalColWidth), 10000, rptTTEquitySchedule, , , , , , , , orOrientation
        .TableRows = 2
        .TableCols = lngCols
        sSql = "SELECT DISTINCT AT.AcTypeID, AT.AcTypeDescription From AcTypes AT WHERE AT.AcTypeID In(SELECT DISTINCT  FAS.AcTypeID " & _
               "From FixedAssetSchedules FAS WHERE AT.ParentAcTypeID = " & lngParentID & " AND FAS.PeriodID=" & mPeriodID & " AND FAS.AMOUNT <> 0)"
        Set rsTmp1 = GetRecords(sSql)
        Inc = 0
        While Not rsTmp1.EOF
            Inc = Inc + 1
            .TableCell(rptTblText, 0, Inc) = rsTmp1.Fields("AcTypeID") & ""
            .TableCell(rptTblText, 1, Inc) = rsTmp1.Fields("AcTypeDescription") & ""
            .TableCell(rptTblUnderline, 1, Inc) = True
            .TableCell(rptTblAlignment, 1, Inc) = taCenterTop
            .TableCell(rptTblIsBold, 1, Inc) = True
            rsTmp1.MoveNext
        Wend
        .TableCell(rptTblRowHeight, 0) = 1
        rsTmp1.Close
        curCurrentYrTot = 0
        .TableCell(rptTblText, 1, .TableCols - 1) = "Total"
        .TableCell(rptTblUnderline, , .TableCols - 1) = True
        .TableCell(rptTblIsBold, , .TableCols - 1) = True
        .TableCell(rptTblAlignment, 1, .TableCols - 1) = taRightMiddle
        .TableCell(rptTblColWidth, , 0) = 3300
        For Inc = 1 To .TableCols - 1
            .TableCell(rptTblColWidth, , Inc) = dblTotalColWidth / (.TableCols - 1)
        Next Inc
        '---Filling values-----------------------------------------------
        For Inc = 0 To 9
            GetValue Inc + 1, 1, crsEquity, mPeriodID, mDerivedPeriodID
        Next
        For Inc = 9 To 18
            GetValue Inc + 1, 0, crsEquity, mPeriodID, mDerivedPeriodID
        Next
        For Inc = 1 To .TableCols - 2
            .TableCell(rptTblAlignment, , Inc) = taRightBottom
        Next
        '--- Find Totals ----------------------------------------------------
        For RowInc = 2 To .TableRows - 1
            curCurrentYrTot = 0
            For Inc = 1 To .TableCols - 1
                If Left(.TableCell(rptTblText, RowInc, Inc), 1) = "(" Then
                    curLastYrTot = RVal(Mid(.TableCell(rptTblText, RowInc, Inc), 2)) * -1
                Else
                    curLastYrTot = RVal(.TableCell(rptTblText, RowInc, Inc))
                End If
                curCurrentYrTot = curCurrentYrTot + curLastYrTot
                .TableCell(rptTblIsBold, RowInc, Inc) = .TableCell(rptTblIsBold, RowInc, Inc)
            Next Inc
            .TableCell(rptTblText, RowInc, .TableCols - 1) = IIf(curCurrentYrTot >= 0, Format(curCurrentYrTot, "##,##0"), "(" & Format(Abs(curCurrentYrTot), "##,##0") & ")")
            If curCurrentYrTot = 0 Then .TableCell(rptTblText, RowInc, .TableCols - 1) = ""
        Next RowInc
        For Inc = 1 To .TableCols - 2
            .TableCell(rptTblIsBold, 1, Inc) = True
            .TableCell(rptTblAlignment, 1, Inc) = taRightBottom
        Next Inc
        '--- Formatting Sections -------------------------------
        For Inc = 0 To .TableCols - 1
            .TableCell(rptTblIsBold, 2) = True
        Next Inc
        For Inc = 0 To .TableCols - 1
            .TableCell(rptTblIsBold, 10) = True
        Next Inc
        For Inc = 0 To .TableCols - 1
            .TableCell(rptTblIsBold, 18) = True
            .TableCell(rptTblUnderline, 19, 1, , .TableCols - 1) = True
        Next Inc
        '---Putting underline to last data row---------------
        For Inc = .TableRows - 2 To 1 Step -1
            If .TableCell(rptTblText, Inc, grdParticulars) <> "" Then
                Exit For
            End If
        Next Inc
        For Inc1 = 1 To .TableCols - 1
            If .TableCell(rptTblText, Inc, Inc1) = "" Then
                .TableCell(rptTblText, Inc, Inc1) = "            -"
            End If
            .TableCell(rptTblUnderline, Inc, 1, , Inc1) = True
        Next Inc1
        '---------------------------------------------------
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblAlignment, .TableRows - 1, 0) = taLeftMiddle
        .TableCell(rptTblRowHeight, 1, .TableCols - 1) = 900
        .TableCell(rptTblAlignment, , .TableCols - 1) = taRightMiddle
        .TableCell(rptTblColWidth, , .TableCols - 1) = 1500
        For Inc = 2 To .TableRows - 1
            If Trim(.TableCell(rptTblText, Inc, 1)) = "-" And Trim(.TableCell(rptTblText, Inc, .TableCols - 1)) = "-" Then
                .TableCell(rptTblRowHeight, Inc, 0, Inc, .TableCols - 1) = 1
            Else
                .TableCell(rptTblAlignment, Inc, 0) = taLeftMiddle
                .TableCell(rptTblAlignment, Inc, 1, Inc, .TableCols - 1) = taRightMiddle
                .TableCell(rptTblRowHeight, Inc, 0, Inc, .TableCols - 1) = 500
            End If
        Next Inc
        '04-03-08
        For Inc = 0 To .TableCols - 1
            For Inc1 = 2 To .TableRows - 1
                If Trim(.TableCell(rptTblText, Inc1, Inc)) <> "" And Trim(.TableCell(rptTblText, Inc1, Inc, .TableRows - 1, .TableCols - 2)) <> "" Then
                    .TableCell(rptTblAlignment, Inc, 0) = taLeftMiddle
                    .TableCell(rptTblAlignment, Inc1, 1, Inc, .TableCols - 1) = taRightMiddle
                    .TableCell(rptTblRowHeight, Inc1, 0, Inc, .TableCols - 1) = 500
                End If
            Next Inc1
        Next Inc
        For Inc = 2 To .TableRows - 1
            For ColInc = 1 To .TableCols - 1
                If .TableCell(rptTblText, Inc, ColInc) = "" Then
                    .TableCell(rptTblText, Inc, ColInc) = "            -"
                End If
            Next ColInc
        Next Inc
        Dim blnIsValueExists As Boolean
        For Inc = 2 To .TableRows - 1
            blnIsValueExists = False
            For ColInc = 1 To .TableCols - 1
                If Val(.TableCell(rptTblIsBold, Inc, ColInc)) = 1 Then
                    lngLastVisibleRow = GetLastVisibleRow(crsEquity, Inc - 1, 4)
                    If lngLastVisibleRow > -1 Then
                        .TableCell(rptTblUnderline, lngLastVisibleRow, ColInc) = True
                    End If
                End If
                If Trim(.TableCell(rptTblText, Inc, ColInc)) <> "-" Then
                    blnIsValueExists = True
                End If
            Next ColInc
            If Not blnIsValueExists Then
                .TableCell(rptTblRowHeight, Inc, 0, Inc, .TableCols - 1) = 1
            End If
        Next Inc
        '--- 03-Dec-08 ------------
        .TableCell(rptTblColWidth, , .TableCols - 1) = 1600
        .EndTable
        Set rsTmp = Nothing
     End With
     If blnIsPreview Then
         If crptMain Is Nothing Then
             crsEquity.EndReport
             crsEquity.Clear
             Set crsEquity = Nothing
         End If
     Else
         Set PrintShareholdersEquity = crsEquity
     End If
Exit Function
Err_Exit:
    ShowError
End Function

Private Function GetLastVisibleRow(crptTmp As clsReports, ByVal lngMaxRow As Long, ByVal lngMinRow As Long) As Long
Dim Inc As Long
    GetLastVisibleRow = -1
    With crptTmp
        For Inc = lngMaxRow To lngMinRow Step -1
            If Val(.TableCell(rptTblRowHeight, Inc, 0)) > 1 Then
                GetLastVisibleRow = Inc
                Exit For
            End If
        Next Inc
    End With
End Function

Public Sub GetValue(Row As Long, Section As Byte, ByRef crptTmp As clsReports, ByVal lngPeriodID As Long, ByVal lngDerivedPeriodID As Long)
On Local Error GoTo Err_Exit
Dim Inc1 As Long, sSql As String, Inc As Long, AddRow As Long, rsTmp As Recordset, lngAcTypeID As Long
    If Section = 0 Then
        AddRow = 0
        lngPeriodID = pActivePeriodID
    Else
        AddRow = 1
        lngPeriodID = lngDerivedPeriodID
    End If
    With crptTmp
        Inc1 = Row + AddRow
        If .TableRows <= Inc1 Then .TableRows = Inc1 + 1
        For Inc = 1 To .TableCols - 1
            lngAcTypeID = .TableCell(rptTblText, 0, Inc)
            sSql = "SELECT FAS.Amount, FAS.Description  FROM FixedAssetSchedules FAS " & _
                   "WHERE  FAS.AcTypeID = " & lngAcTypeID & " AND FAS.PeriodID = " & lngPeriodID & " AND FAS.ItemID =" & Row + (9 * Section)
            Set rsTmp = GetRecords(sSql)
            If Not rsTmp.EOF Then
                .TableCell(rptTblText, Inc1, 0) = rsTmp.Fields("Description") & ""
                .TableCell(rptTblText, Inc1, Inc) = IIf(RVal(rsTmp.Fields("Amount") & "") >= 0, Format(rsTmp.Fields("Amount") & "", "##,###"), "(" & Format(Abs(rsTmp.Fields("Amount") & "") & "", "##,###") & ")")
                If .TableCell(rptTblText, Inc1, Inc) = 0 Then .TableCell(rptTblText, Inc1, Inc) = ""
            End If
            rsTmp.Close
        Next
    End With
Exit Sub
Err_Exit:

End Sub

Public Function PrintGeneralSchedules(lngPeriodID As Long, lngAcTypeID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                      Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim lngCompanyID As Long
Dim crptSchedule As New clsReports, sSql As String, rsTmp As New Recordset
Dim Inc As Long, strNoteNo As String, lngComparePeriodID As Long, lngAcTypeName As String
Dim lngCompareEndDt As Long, lngEndDt As Long, dblAmount As Double, dblLastAmount As Double
Dim curCYearTot As Currency, curCTmpTot As Currency, lngThisTot As Double, IsLastRowTotal As Boolean
Dim curLYearTot As Currency, curLTmpTot As Currency, lngLastTot As Double, strAcTypes As String
Dim lngCurDt As Long, lngLastDt As Long, lngPLID As Long, lngParentAcTypeID As Long, lngImmediateParentID As Long
Dim mDeductionAcTypeID As Long, strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptSchedule = crptMain
    End If
    lngAcTypeName = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngAcTypeID)
    lngComparePeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & lngPeriodID))
    lngEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngPeriodID))
    lngCompareEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngComparePeriodID))
    lngCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & lngPeriodID))
    lngPLID = GetActualID(lngCompanyID, cnstAcTypeProfitLoss)
    lngImmediateParentID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngAcTypeID))
    lngParentAcTypeID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngImmediateParentID))
    lngCurDt = -1
    lngLastDt = -1

    strNoteNo = PickValue("Schedules", "NoteNo", "AcTypeID = " & lngAcTypeID & " AND PeriodID = " & lngPeriodID)
    'Ref No:- 002 - 01/07/2009 --------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    sSql = "Select * From Schedules"
    If Trim(strNoteNo) = "" Then
       sSql = sSql & " Where 1=2 AND AcTypeID = " & lngAcTypeID
       Exit Function
    Else
       sSql = sSql & " Where UPPER(RTrim(LTrim(NoteNo))) = '" & Trim(strNoteNo) & "' AND PeriodID = " & lngPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeGeneral
    End If
    With crptSchedule
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
        End If
        lngCurrentY = lngCurrentY + 700
       .StartTable 1440, lngCurrentY + 1000, 10000, 10000, rptTTGeneralSchedule
       .TableCols = grdCols
       .TableRows = 1: Inc = 0
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdNoteNo) = strNoteNo & "."
       .TableCell(rptTblText, Inc, grdParticulars) = lngAcTypeName
       .TableCell(rptTblIsBold, Inc, grdNoteNo, Inc, grdParticulars) = True
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdDebit) = Format(lngEndDt, "MMMM dd, yyyy")
       lngCurDt = Inc
       .TableCell(rptTblText, Inc, grdCredit) = Format(lngCompareEndDt, "MMMM dd, yyyy")
       .TableCell(rptTblRowHeight, Inc, grdDebit, Inc, grdCredit) = 300
       lngLastDt = Inc
       If lngPLID = lngParentAcTypeID Then
            .TableCell(rptTblRowHeight, lngCurDt, grdDebit, lngLastDt, grdCredit) = 550
            .TableCell(rptTblText, lngCurDt, grdDebit) = GetFixedAssetSchedulePeriod(lngPeriodID)
            .TableCell(rptTblText, lngLastDt, grdCredit) = GetFixedAssetSchedulePeriod(lngComparePeriodID)
       End If
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdDebit) = strCurrency                  '"AED"
       .TableCell(rptTblText, Inc, grdCredit) = strCurrency                 '"AED"
       .TableCell(rptTblIsBold, Inc - 1, grdDebit, Inc, grdDebit) = True
       .TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True

        With GetRecords(sSql)
            strAcTypes = "0"
            While Not .EOF
                strAcTypes = strAcTypes & ", " & Val(.Fields("AcTypeID") & "")
                .MoveNext
            Wend
            .Close
        End With
            curCYearTot = 0
        sSql = "SELECT SUM(Amount) AS Amount, SUM(PreviousAmount) AS PreviousAmount, Particulars, ORD, DeductionAcTypeID, TypeNature " & _
               "FROM (SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & lngComparePeriodID & ") AS PreviousAmount, 1 AS ORD, AT.DeductionAcTypeID, TypeNature, AT.TrialOrder " & _
               "FROM AcTypes AT Where ParentAcTypeID = " & lngAcTypeID & "  AND AT.AcTypeID NOT IN (SELECT ISNULL(AT1.DeductionAcTypeID, 0) FROM AcTypes AT1 WHERE AT1.CompanyID = " & lngCompanyID & ") " & _
               "Union " & _
               "SELECT AH.AcName AS Particulars, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
               "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & lngPeriodID & ") AS Amount, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
               "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & lngComparePeriodID & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, " & _
               "AT.TypeNature, AH.TrialOrder FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")) TMP1 " & _
               "Where (Amount <> 0 OR PreviousAmount <> 0) GROUP BY Particulars, ORD, DeductionAcTypeID, TypeNature, TrialOrder ORDER BY ORD, TrialOrder, DeductionAcTypeID DESC"
        With GetRecords(sSql)
            While Not .EOF
                crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                curCYearTot = curCYearTot + dblAmount
                curCTmpTot = dblAmount
                dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                curLYearTot = curLYearTot + dblLastAmount
                curLTmpTot = dblLastAmount
                crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = .Fields("Particulars") & ""
                crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                crptSchedule.TableCell(rptTblIsBold, Inc, grdDebit, Inc, grdDebit) = True
                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                If crptSchedule.TableCell(rptTblText, Inc, grdDebit) = 0 Then
                    crptSchedule.TableCell(rptTblText, Inc, grdDebit) = "-"
                End If
                If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
                    crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
                End If
                If Val(.Fields("DeductionAcTypeID") & "") <> 0 Then
                    mDeductionAcTypeID = Val(.Fields("DeductionAcTypeID") & "")
                    sSql = "SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & lngComparePeriodID & ") AS PreviousAmount, TypeNature " & _
                           "FROM   AcTypes Where AcTypeID = " & Val(.Fields("DeductionAcTypeID"))
                    With GetRecords(sSql)
                        While Not .EOF
                            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                            dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                            curCYearTot = curCYearTot + dblAmount
                            curCTmpTot = curCTmpTot + dblAmount
                            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                            curLYearTot = curLYearTot + dblLastAmount
                            curLTmpTot = curLTmpTot + dblLastAmount
                            crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = IIf(dblAmount > 0, "", "Less: ") & .Fields("Particulars") & ""
                            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                            crptSchedule.TableCell(rptTblIsBold, Inc, grdDebit, Inc, grdDebit) = True
                            crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))

                            If crptSchedule.TableCell(rptTblText, Inc, grdDebit) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdDebit) = "-"
                            End If
                            If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
                            End If
                            '-------17/Nov/08 Total appearing 2 times in certain cases ----
'                            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
'                            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(curCTmpTot < 0, "(" & Format(Abs(curCTmpTot), "#,##0") & ")", Format(curCTmpTot, "#,##0"))
'                            crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(curLTmpTot < 0, "(" & Format(Abs(curLTmpTot), "#,##0") & ")", Format(curLTmpTot, "#,##0"))
                            If crptSchedule.TableCell(rptTblText, Inc, grdDebit) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdDebit) = "-"
                            End If
                            If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
                            End If
'                            crptSchedule.TableCell(rptTblIsBold, Inc, grdDebit) = True
'                            crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc - 1, grdCredit) = True
                            .MoveNext
                        Wend
                    End With
                End If
                If crptSchedule.TableRows <= 5 Then
                    IsLastRowTotal = False
                Else
                    IsLastRowTotal = True
                End If
                .MoveNext
            Wend
        End With
        'Ref No: 024-14/06/08, 15th June 2008, Sunday --------------------
        If IsLastRowTotal Then
            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
            crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
            crptSchedule.TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdDebit) = True
            crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True
        Else
            crptSchedule.TableCell(rptTblUnderline, Inc, grdDebit, Inc, grdCredit) = True
        End If
        .TableCell(rptTblColWidth, , grdNoteNo) = 500
        .TableCell(rptTblAlignment, , grdNoteNo) = taLeftMiddle
        .TableCell(rptTblColWidth, , grdParticulars) = 5300
        .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
        .TableCell(rptTblColWidth, , grdDebit) = 2200
        .TableCell(rptTblAlignment, , grdDebit) = taRightMiddle
        .TableCell(rptTblColWidth, , grdCredit) = 2200
        .TableCell(rptTblAlignment, , grdCredit) = taRightMiddle
        If lngCompareEndDt <> 0 Then
            .TableCell(rptTblColWidth, , grdDebit) = 2200
            .TableCell(rptTblColWidth, , grdCredit) = 2200
        Else
            .TableCell(rptTblColWidth, , grdDebit) = 4000
            .TableCell(rptTblColWidth, , grdCredit) = 1
        End If
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblRowHeight, 3, 0, .TableRows - 1, .TableCols - 1) = 350
        .EndTable
        lngCurrentY = lngCurrentY + (400 * .TableRows)
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptSchedule = Nothing
            End If
        Else
            Set PrintGeneralSchedules = crptSchedule
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintSplitSchedules(lngPeriodID As Long, lngAcTypeID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                    Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim mCompanyID As Long, crptSchedule As New clsReports, sSql As String, rsTmp As New Recordset
Dim Inc As Long, strNoteNo As String, lngComparePeriodID As Long, mComparePeriodID As Long
Dim lngCompareEndDt As Long, lngEndDt As Long, dblAmount As Double, dblLastAmount As Double, dblTotalAmt As Double, dblLastTotal As Double
Dim curCYearTot As Currency, curCTmpTot As Currency, dblDerivedAmount As Long, mAcTypeName As String, dblLastDerivedAmount As Currency
Dim lngAllocationAcTypeID As Long, strAllocationType As String, curLYearTot As Currency, curLTmpYear As Currency
Dim strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1
Const grdThisYr = 2
Const grdLastYr = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptSchedule = crptMain
    End If
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, PER.ComparePeriodID AS ComparePeriodID, " & _
           "PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "Where PER.PeriodID = " & lngPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
        End If
        .Close
    End With
    mAcTypeName = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngAcTypeID)
    lngAllocationAcTypeID = Val(PickValue("AcTypes", "AllocationAcTypeID", "AcTypeID = " & lngAcTypeID))
    strAllocationType = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngAllocationAcTypeID)
    lngComparePeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & lngPeriodID))
    lngEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngPeriodID))
    lngCompareEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngComparePeriodID))
    dblLastDerivedAmount = Val(PickValue("Schedules", "DerivedAmount", "AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & lngComparePeriodID & " And ScheduleTypeID = " & cnstScheduleTypeSplit))
    strNoteNo = PickValue("Schedules", "NoteNo", "AcTypeID = " & lngAcTypeID & " AND PeriodID = " & lngPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeSplit)
    'Ref No:- 002 - 01/07/2009 ----------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    sSql = "Select * From Schedules WHERE AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & lngPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeSplit
        With GetRecords(sSql)
            If Not .EOF Then
                dblDerivedAmount = Val(.Fields("DerivedAmount") & "")
            End If
            If Trim(strNoteNo) = "" Then
               sSql = sSql & "  AND AcTypeID = " & lngAcTypeID
               Exit Function
            Else
               sSql = sSql & " AND UPPER(RTrim(LTrim(NoteNo))) = '" & Trim(strNoteNo) & "'"
            End If
        End With
        With crptSchedule
            If blnIsPreview Then
                If crptMain Is Nothing Then
                    .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
                End If
            End If
            .StartTable 1440, lngCurrentY + 1000, 10000, 10000, rptTTSplitSchedule
            .TableCols = grdCols
            .TableRows = 1: Inc = 0
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdNoteNo) = strNoteNo & "."
            .TableCell(rptTblText, Inc, grdParticulars) = mAcTypeName
            .TableCell(rptTblIsBold, Inc, grdNoteNo, Inc, grdParticulars) = True
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblRowHeight, Inc, grdThisYr, Inc, grdLastYr) = 300
            .TableCell(rptTblText, Inc, grdThisYr) = Format(lngEndDt, "MMMM dd, yyyy")
            .TableCell(rptTblText, Inc, grdLastYr) = Format(lngCompareEndDt, "MMMM dd, yyyy")

            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdThisYr) = strCurrency               '"AED"
            .TableCell(rptTblText, Inc, grdLastYr) = strCurrency               '"AED"
            .TableCell(rptTblIsBold, Inc - 1, grdThisYr, Inc, grdThisYr) = True
            .TableCell(rptTblUnderline, Inc - 1, grdThisYr, Inc, grdLastYr) = True
            With GetRecords(sSql)
                If Not .EOF Then
                    curCYearTot = 0
                    sSql = "SELECT SUM(Amount) AS Amount, SUM(PreviousAmount) AS PreviousAmount, Particulars, ORD, DeductionAcTypeID, TypeNature " & _
                           "FROM  (SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & lngComparePeriodID & ") AS PreviousAmount, 1 AS ORD, AT.DeductionAcTypeID, TypeNature, AT.TrialOrder " & _
                           "FROM   AcTypes AT Where ParentAcTypeID = " & lngAcTypeID & "  AND AT.AcTypeID NOT IN (SELECT ISNULL(AT1.DeductionAcTypeID, 0) FROM AcTypes AT1 WHERE AT1.CompanyID = " & mCompanyID & ") " & _
                           "Union " & _
                           "SELECT  AH.AcName AS Particulars, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
                           "WHERE   ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & lngPeriodID & ") AS Amount, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
                           "WHERE   ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & lngComparePeriodID & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, " & _
                           "        AT.TypeNature, AH.TrialOrder FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")) TMP1 " & _
                           "WHERE  (Amount <> 0 OR PreviousAmount <>0) GROUP BY Particulars, ORD, DeductionAcTypeID, TypeNature, TrialOrder ORDER BY ORD, TrialOrder, DeductionAcTypeID DESC"
                    With GetRecords(sSql)
                        While Not .EOF
                            dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                            curCYearTot = curCYearTot + dblAmount
                            curCTmpTot = dblAmount
                            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                            curLYearTot = curLYearTot + dblLastAmount
                            curLTmpYear = dblLastAmount
                            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                            crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = .Fields("Particulars") & ""
                            crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                            crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYr, Inc, grdThisYr) = True
                            crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                            If crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = "-"
                            End If
                            If crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = 0 Then
                                crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = "-"
                            End If
                            If Val(.Fields("DeductionAcTypeID") & "") <> 0 Then
                                sSql = "SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & lngComparePeriodID & ") AS PreviousAmount, TypeNature " & _
                                       "From AcTypes Where AcTypeID = " & Val(.Fields("DeductionAcTypeID"))
                                With GetRecords(sSql)
                                    If Not .EOF Then
                                        dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                                        curCYearTot = curCYearTot + dblAmount
                                        curCTmpTot = curCTmpTot + dblAmount
                                        
                                        dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                                        curLYearTot = curLYearTot + dblLastAmount
                                        curLTmpYear = curLTmpYear + dblLastAmount
                                        crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                        crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = IIf(dblAmount > 0, "", "Less: ") & .Fields("Particulars") & ""
                                        crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                                        crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYr, Inc, grdThisYr) = True
                                        crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                                        If crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = 0 Then
                                            crptSchedule.TableCell(rptTblText, Inc, grdThisYr) = "-"
                                        End If
                                        If crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = 0 Then
                                            crptSchedule.TableCell(rptTblText, Inc, grdLastYr) = "-"
                                        End If
                                        crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                        crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYr) = True
                                        crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdThisYr, Inc - 1, grdLastYr) = True
                                    End If
                                End With
                            End If
                            .MoveNext
                        Wend
                        .Close
                    End With
                End If
            End With
            dblTotalAmt = curCYearTot
            dblLastTotal = curLYearTot
            Inc = Inc + 1
            .TableRows = .TableRows + 1
            .TableCell(rptTblUnderline, Inc - 1, grdThisYr, Inc - 1, grdLastYr) = True
            .TableCell(rptTblUnderline, Inc, grdThisYr, Inc, grdLastYr) = True
            .TableCell(rptTblIsBold, Inc, grdThisYr) = True
            .TableCell(rptTblText, Inc, grdThisYr) = Format(curCYearTot, "#,##0")
            .TableCell(rptTblText, Inc, grdLastYr) = Format(curLYearTot, "#,##0")

            Inc = Inc + 2
            .TableRows = .TableRows + 2
            .TableCell(rptTblText, Inc, grdParticulars) = "Due within 1 year"    'mAcTypeName & " - " & "Current Portion"
            .TableCell(rptTblText, Inc, grdThisYr) = Format(dblDerivedAmount, "#,##0")
            .TableCell(rptTblIsBold, Inc, grdThisYr) = True
            .TableCell(rptTblText, Inc, grdLastYr) = Format(dblLastDerivedAmount, "#,##0")
            .TableCell(rptTblIsBold, Inc, grdLastYr) = False

            Inc = Inc + 1
            .TableRows = .TableRows + 1
            .TableCell(rptTblText, Inc, grdParticulars) = "Due within 2-5 years"   'strAllocationType
            .TableCell(rptTblText, Inc, grdThisYr) = Format(curCYearTot - dblDerivedAmount, "#,##0")
            .TableCell(rptTblIsBold, Inc, grdThisYr) = True
            .TableCell(rptTblUnderline, Inc, grdThisYr) = True
            .TableCell(rptTblText, Inc, grdLastYr) = Format(curLYearTot - dblLastDerivedAmount, "#,##0")

            If .TableCell(rptTblText, Inc, grdThisYr) = 0 Then
               .TableCell(rptTblText, Inc, grdThisYr) = "-"
            End If
            If .TableCell(rptTblText, Inc, grdLastYr) = 0 Then
               .TableCell(rptTblText, Inc, grdLastYr) = "-"
            End If

            .TableCell(rptTblIsBold, Inc, grdLastYr) = False
            .TableCell(rptTblUnderline, Inc, grdLastYr) = True
            .TableCell(rptTblColWidth, , grdNoteNo) = 500
            .TableCell(rptTblAlignment, , grdNoteNo) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdParticulars) = 5300
            .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdThisYr) = 2200
            .TableCell(rptTblAlignment, , grdThisYr) = taRightMiddle
            .TableCell(rptTblColWidth, , grdLastYr) = 2200
            .TableCell(rptTblAlignment, , grdLastYr) = taRightMiddle

            If mComparePeriodID <> 0 Then
                .TableCell(rptTblColWidth, , grdThisYr) = 2200
                .TableCell(rptTblColWidth, , grdLastYr) = 2200
            Else
                .TableCell(rptTblColWidth, , grdThisYr) = 4000
                .TableCell(rptTblColWidth, , grdLastYr) = 1
            End If

            .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
            .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
            .TableCell(rptTblRowHeight, 3, 0, .TableRows - 1, .TableCols - 1) = 400
            'Ref No - 002 16/06/2009, Tuesday --------------
            For Inc = 1 To .TableRows - 1
                If .TableCell(rptTblText, Inc, grdParticulars) = "" And .TableCell(rptTblText, Inc, grdThisYr, Inc, grdLastYr) = "" Then
                    .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdLastYr) = 100
                End If
            Next Inc
            .EndTable
            lngCurrentY = lngCurrentY + (400 * .TableRows)
            If blnIsPreview Then
                If crptMain Is Nothing Then
                    .EndReport
                    .Clear
                    Set crptSchedule = Nothing
                End If
            Else
                Set PrintSplitSchedules = crptSchedule
            End If
        End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintProfitLoss(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptPL As New clsReports, sSql As String, strTmp As String
Dim rsTmp As New Recordset, rsTmp1 As New Recordset, rsTmp2 As New Recordset
Dim mCompanyID As Long, mDerivedPeriodID As Long, mComparePeriodID As Long, mLastPeriodID As Long
Dim Inc As Long, tmpStr As String, lngAcTypeID As Long, Inc1 As Long
Dim lngStartDt As Long, lngCompareStartDt As Long, lngEndDt As Long, lngCompareEndDt As Long
Dim dblAmount As Double, dblLastAmount As Double, strTmp1 As String
Dim lngAcTypeTrading As Long, lngAcTypeOperatingExp As Long, lngAcTypeNonOperatingExp As Long, dblNextTotal As Double, dblNextTotalLast As Double
Dim dblTmpTotal As Double, dblTotalTrading As Double, dblTotalOperating As Double, dblTotalNonOperating As Double
Dim dblTmpTotalLast As Double, dblTotalLastTrading As Double, dblTotalLastOperating As Double, dblTotalLastNonOperating As Double
Dim strPeriod As String, strComparedPeriod As String
Dim blnIsValueExists As Boolean, ColInc As Long, lngLastVisibleRow As Long
Dim lngAcTypeOtherComprehensive As Long, dblTotalOtherComprehensive As Double, dblTotalLastOtherComprehensive As Double
Dim dblThisNetProfit As Double, dblThisOtherComprehensive As Double, dblLastNetProfit As Double, dblLastOtherComprehensive As Double
Dim dblThisFinalTotal As Double, dblLastFinalTotal As Double
Dim ThisTotal As String, ThisCount As Long
Dim lngComprehensiveID As Long

Const grdParticulars = 0
Const grdNoteNo = 1
Const grdThisYr = 2
Const grdLastYr = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptPL = crptMain
    End If
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, PER.ComparePeriodID AS ComparePeriodID, " & _
           "PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "Where PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            lngAcTypeID = GetActualID(mCompanyID, cnstAcTypeProfitLoss)
            lngAcTypeTrading = GetActualID(mCompanyID, cnstAcTypeTrading)
            lngAcTypeOperatingExp = GetActualID(mCompanyID, cnstAcTypeOperatingExp)
            lngAcTypeNonOperatingExp = GetActualID(mCompanyID, cnstAcTypeNonOperatingExp)
            lngAcTypeOtherComprehensive = GetActualID(mCompanyID, cnstAcTypeOtherComprehensiveExp)
            mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
            mDerivedPeriodID = Val(.Fields("DerivedPeriodID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With
    With crptPL
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("ProfitLossStmtHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orPortrait, True, , , 12, "Times New Roman"
            .CreateLine 1440, 2500, 11000, 2500, , , , , , , orPortrait
        End If
        '---Putting Particulars------------------------------
        .StartTable 1440, 2700, 10000, 10000, rptTTProfitAndLoss, , , , , , , , orPortrait
        .TableCols = grdCols
        .TableCell(rptTblColWidth, , grdParticulars) = 4600
        .TableCell(rptTblColWidth, , grdNoteNo) = 800
        .TableCell(rptTblColWidth, , grdThisYr) = 2150
        .TableCell(rptTblColWidth, , grdLastYr) = 2150
        .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
        .TableCell(rptTblAlignment, , grdNoteNo) = taCenterMiddle
        .TableCell(rptTblAlignment, , grdThisYr, , grdLastYr) = taRightMiddle
        If mComparePeriodID <> 0 Then
            .TableCell(rptTblColWidth, , grdThisYr) = 2150
            .TableCell(rptTblColWidth, , grdLastYr) = 2150
        Else
            .TableCell(rptTblColWidth, , grdThisYr) = 4600
            .TableCell(rptTblColWidth, , grdLastYr) = 1
        End If
        .TableRows = 1: Inc = 0
        .TableCell(rptTblUnderline, Inc, grdNoteNo, , grdLastYr) = True
'        .TableCell(rptTblText, Inc, grdNoteNo) = "Note"
        '------20/12/07
        .TableCell(rptTblIsBold, Inc, grdNoteNo) = False
        .TableCell(rptTblIsItalic, Inc, grdNoteNo) = False
        '------
        strPeriod = GetFixedAssetSchedulePeriod(mPeriodID)
        strComparedPeriod = GetFixedAssetSchedulePeriod(mComparePeriodID)
        .TableCell(rptTblText, Inc, grdNoteNo) = "Note     "
        .TableCell(rptTblIsBold, Inc, grdNoteNo) = True
        .TableCell(rptTblAlignment, Inc, grdNoteNo) = taCenterMiddle
        .TableCell(rptTblText, Inc, grdThisYr) = strPeriod 'Format(lngEndDt, "MMMM dd, yyyy")
        .TableCell(rptTblIsBold, Inc, grdThisYr) = True
        .TableCell(rptTblText, Inc, grdLastYr) = strComparedPeriod 'Format(lngCompareEndDt, "MMMM dd, yyyy")
        .TableCell(rptTblRowHeight, Inc, grdNoteNo, Inc, grdLastYr) = 600
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT AT.AcTypeID, AT.AcTypeDescription, AT.TrialOrder From AcTypes AT WHERE AT.TreeLevel = 2 AND AT.ParentAcTypeID =" & lngAcTypeID & " ORDER BY AT.TrialOrder"
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            sSql = "SELECT AT.AcTypeID, AT.AcTypeDescription, AT.ParentAcTypeID, SSB.NoteNo, AT.TypeNature, (SELECT CAmt - DAmt from SchedulesSubBalanceSheet Where AcTypeID = SSB.AcTypeID AND PeriodID = " & mPeriodID & ") AS ThisYear , " & _
                   "(SELECT CAmt - DAmt from SchedulesSubBalanceSheet Where AcTypeID = SSB.AcTypeID AND PeriodID = " & mComparePeriodID & ") AS LastYear From AcTypes AT, SchedulesSubBalanceSheet SSB " & _
                   "WHERE AT.AcTypeID = SSB.AcTypeID AND AT.ParentAcTypeID = " & Val(rsTmp.Fields("AcTypeID") & "") & " AND SSB.PeriodID = " & mPeriodID & " ORDER BY AT.TrialOrder"
            Set rsTmp1 = GetRecords(sSql)
            If Not rsTmp1.EOF Then
                While Not rsTmp1.EOF
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                    '------ 28 June 2011 ------
                    If rsTmp1.Fields("ParentAcTypeID") & "" = lngAcTypeOtherComprehensive Then
                       ' .TableRows = .TableRows + 1: Inc = Inc + 1
                        strTmp = "Other comprehensive income/(expense) for the " & IIf(strThisYear <> "" And strLastPeriod <> "", "year / period", IIf(strThisYear <> "", "year", "period"))
                        .TableCell(rptTblText, Inc, grdParticulars) = strTmp
                        .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                        .TableRows = .TableRows + 1: Inc = Inc + 1
                    End If
                    .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("AcTypeDescription") & ""
                    .TableCell(rptTblText, Inc, grdNoteNo) = rsTmp1.Fields("NoteNo") & ""
                    dblAmount = GetSignedValue(Val(rsTmp1.Fields("ThisYear") & ""), rsTmp1.Fields("TypeNature") & "")
                    dblLastAmount = GetSignedValue(Val(rsTmp1.Fields("LastYear") & ""), rsTmp1.Fields("TypeNature") & "")
                    .TableCell(rptTblText, Inc, grdThisYr) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                    .TableCell(rptTblText, Inc, grdLastYr) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                    dblTmpTotal = dblTmpTotal + dblAmount
                    dblTmpTotalLast = dblTmpTotalLast + dblLastAmount
                    rsTmp1.MoveNext
'                    ThisTotal = dblTmpTotal
'                    ThisCount = Len(ThisTotal)
                    If .TableCell(rptTblText, Inc, grdThisYr) = 0 Then
                        .TableCell(rptTblText, Inc, grdThisYr) = "-"
                    End If
                    If .TableCell(rptTblText, Inc, grdLastYr) = 0 Then
                        .TableCell(rptTblText, Inc, grdLastYr) = "-"
                    End If
                Wend
                Select Case Val(rsTmp.Fields("AcTypeID") & "")
                    Case lngAcTypeTrading
                        dblTotalTrading = dblTmpTotal
                        dblNextTotal = dblTotalTrading
                        dblTmpTotal = 0

                        dblTotalLastTrading = dblTmpTotalLast
                        dblNextTotalLast = dblTotalLastTrading
                        dblTmpTotalLast = 0
                        strTmp = "Gross " & IIf(dblNextTotal > 0, "profit", "loss")
                    Case lngAcTypeOperatingExp
                        dblTotalOperating = dblTmpTotal
                        dblNextTotal = dblTotalOperating + dblNextTotal
                        dblTmpTotal = 0

                        dblTotalLastOperating = dblTmpTotalLast
                        dblNextTotalLast = dblTotalLastOperating + dblNextTotalLast
                        dblTmpTotalLast = 0
                        strTmp = IIf(dblNextTotal > 0, "Profit", "Loss") & " from operations"
                    Case lngAcTypeNonOperatingExp
                        dblTotalNonOperating = dblTmpTotal
                        dblNextTotal = dblTotalNonOperating + dblNextTotal
                        dblTmpTotal = 0

                        dblTotalLastNonOperating = dblTmpTotalLast
                        dblNextTotalLast = dblTotalLastNonOperating + dblNextTotalLast
                        dblTmpTotalLast = 0
                        strTmp = "Net " & IIf(dblNextTotal > 0, "profit", "loss") & "  for the " & IIf(strThisYear <> "" And strLastPeriod <> "", "year / period", IIf(strThisYear <> "", "year", "period"))
                        dblThisNetProfit = dblNextTotal
                        dblLastNetProfit = dblNextTotalLast
                    Case lngAcTypeOtherComprehensive
                        dblNextTotal = 0
                        dblNextTotalLast = 0
'                        If lngAcTypeOtherComprehensive > 1 Then
'                            .TableRows = .TableRows + 1: Inc = Inc + 1
'                            strTmp = "Other comprehensive income/(expense) for the " & IIf(strThisYear <> "" And strLastPeriod <> "", "year / period", IIf(strThisYear <> "", "year", "period"))
'                            .TableCell(rptTblText, Inc, grdParticulars) = strTmp
'                        End If
                        dblTotalOtherComprehensive = dblTmpTotal
                        dblNextTotal = dblTotalOtherComprehensive + dblNextTotal
                        dblTmpTotal = 0

                        dblTotalLastOtherComprehensive = dblTmpTotalLast
                        dblNextTotalLast = dblTotalLastOtherComprehensive + dblNextTotalLast
                        dblTmpTotalLast = 0
                        strTmp = "Other comprehensive income/(expense) included directly in equity"
                        dblThisOtherComprehensive = dblNextTotal
                        dblLastOtherComprehensive = dblNextTotalLast
                End Select

                dblThisFinalTotal = dblThisNetProfit + dblThisOtherComprehensive
                dblLastFinalTotal = dblLastNetProfit + dblLastOtherComprehensive

                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblText, Inc, grdParticulars) = strTmp
                .TableCell(rptTblText, Inc, grdThisYr) = IIf(dblNextTotal < 0, "(" & Format(Abs(dblNextTotal), "#,##0") & ")", Format(dblNextTotal, "#,##0"))
                .TableCell(rptTblText, Inc, grdLastYr) = IIf(dblNextTotalLast < 0, "(" & Format(Abs(dblNextTotalLast), "#,##0") & ")", Format(dblNextTotalLast, "#,##0"))
                .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                .TableCell(rptTblUnderline, Inc - 1, grdThisYr, Inc - 1, grdLastYr) = True
            End If
            rsTmp.MoveNext
        Wend
        If dblThisOtherComprehensive <> 0 Then
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdParticulars) = "Total comprehensive income during the year"
            .TableCell(rptTblText, Inc, grdThisYr) = IIf(dblThisFinalTotal < 0, "(" & Format(Abs(dblThisFinalTotal), "#,##0") & ")", Format(dblThisFinalTotal, "#,##0"))
            .TableCell(rptTblText, Inc, grdLastYr) = IIf(dblLastFinalTotal < 0, "(" & Format(Abs(dblLastFinalTotal), "#,##0") & ")", Format(dblLastFinalTotal, "#,##0"))
            .TableCell(rptTblIsBold, Inc, grdParticulars) = True
            .TableCell(rptTblIsItalic, Inc, grdParticulars, Inc, grdLastYr) = True
            .TableCell(rptTblUnderline, Inc - 1, grdThisYr, Inc - 1, grdLastYr) = True
        End If
        rsTmp.Close
        .TableCell(rptTblFontName, , grdParticulars, , grdLastYr) = "Times New Roman"
        .TableCell(rptTblAlignment, , grdThisYr, , grdLastYr) = taRightMiddle
        .TableCell(rptTblRowHeight, 1, grdParticulars, .TableRows - 1, grdLastYr) = 600
'        .TableCell(rptTblBackColor, .TableRows - 1, grdParticulars, .TableRows - 1, grdLastYr) = RGB(200, 200, 200)
        .TableCell(rptTblUnderline, .TableRows - 2, grdThisYr, .TableRows - 1, grdLastYr) = True
        .TableCell(rptTblAlignment, .TableRows - 1, grdParticulars) = taLeftMiddle
        .TableCell(rptTblAlignment, .TableRows - 1, grdThisYr, .TableRows - 1, grdLastYr) = taRightMiddle
        .TableCell(rptTblIsBold, 0, grdThisYr, .TableRows - 1, grdThisYr) = True
        'Ref No: 001 - 25/03/08
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) <> "" And .TableCell(rptTblText, Inc, grdThisYr, Inc, grdLastYr) <> "" Then
                .TableCell(rptTblAlignment, Inc, grdParticulars) = taLeftMiddle
                .TableCell(rptTblAlignment, Inc, grdNoteNo) = taCenterMiddle
                .TableCell(rptTblAlignment, Inc, grdThisYr, Inc, grdLastYr) = taRightMiddle
                .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdLastYr) = 600
            End If
        Next Inc
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdThisYr) = "-" And .TableCell(rptTblText, Inc, grdLastYr) = "-" Then
                .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdLastYr) = 1
            End If
        Next Inc
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        'Ref No:
        If .TableCell(rptTblRowHeight, .TableRows - 2, grdThisYr, .TableRows - 2, grdLastYr) > 1 Then
            .TableCell(rptTblUnderline, .TableRows - 2, grdThisYr, .TableRows - 2, grdLastYr) = True
        Else
            .TableCell(rptTblUnderline, .TableRows - 3, grdThisYr, .TableRows - 3, grdLastYr) = True
        End If
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdThisYr) = 0 Then
                .TableCell(rptTblText, Inc, grdThisYr) = "-"
            End If
        Next Inc
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdLastYr) = 0 Then
                .TableCell(rptTblText, Inc, grdLastYr) = "-"
            End If
        Next Inc
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptPL = Nothing
            End If
        Else
            Set PrintProfitLoss = crptPL
        End If
    End With
Exit Function
Err_Exit:
'    ShowError
End Function

Public Function PrintCashFlow(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptCash As New clsReports, sSql As String, rsTmp As New Recordset
Dim Inc As Long, mCompanyID As Long, mComparePeriodID As Long, strTmp As String
Dim lngStartDt As Long, lngCompareStartDt As Long, lngEndDt As Long, lngCompareEndDt As Long
Dim strAmount As String, strPreviousamount As String

Const grdParticulars = 0
Const grdThisYr = 1
Const grdLastYr = 2
Const grdIsTotal = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptCash = crptMain
    End If
    sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.ComparePeriodID AS ComparePeriodID, " & _
           "PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "WHERE PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With
    With crptCash
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("CashFlowStmtHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 2800, 11500, 2800, , , , , , , orPortrait
        End If
        .StartTable 1440, 2850, 10000, 10000, rptTTCashFlow, , , , , , , , orPortrait
        .TableCols = grdCols
        .TableRows = 1: Inc = 0
'        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdThisYr) = GetFixedAssetSchedulePeriod(mPeriodID)
        .TableCell(rptTblUnderline, Inc, grdThisYr) = True
        .TableCell(rptTblIsBold, , grdThisYr) = True
        .TableCell(rptTblText, Inc, grdLastYr) = GetFixedAssetSchedulePeriod(mComparePeriodID)
        .TableCell(rptTblUnderline, Inc, grdLastYr) = True
        .TableCell(rptTblRowHeight, Inc, grdThisYr, Inc, grdLastYr) = 800
        sSql = "SELECT CFD.Description AS Particulars, CFD.Amount AS Amount, CFD.PreviousAmount AS PreviousAmount, CFD.IsBold, CFD.IsTotal AS IsTotal " & _
               "FROM   CashFlowDetails CFD WHERE  CFD.PeriodID =" & mPeriodID
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("Particulars") & ""
            strTmp = IIf(Val(rsTmp.Fields("Amount") & "") = 0, "-", Format(Abs(Val(rsTmp.Fields("Amount") & "")), "#,##,0"))
            .TableCell(rptTblText, Inc, grdThisYr) = IIf(rsTmp.Fields("Amount") < 0, "(" & strTmp & ")", strTmp)
            .TableCell(rptTblIsBold, Inc, grdThisYr) = True
            strTmp = IIf(Val(rsTmp.Fields("PreviousAmount") & "") = 0, "-", Format(Abs(Val(rsTmp.Fields("PreviousAmount") & "")), "#,##,0"))
            .TableCell(rptTblText, Inc, grdLastYr) = IIf(rsTmp.Fields("PreviousAmount") < 0, "(" & strTmp & ")", strTmp)
            .TableCell(rptTblText, Inc, grdIsTotal) = rsTmp.Fields("IsTotal") & ""
            If rsTmp.Fields("IsBold") = True Then
                .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                .TableCell(rptTblUnderline, Inc, grdThisYr, , grdLastYr) = True
                .TableCell(rptTblUnderline, Inc - 1, grdThisYr, , grdLastYr) = True
            End If
            If rsTmp.Fields("IsTotal") = True Then
                .TableCell(rptTblUnderline, Inc - 1, grdThisYr, , grdLastYr) = True
            End If
            rsTmp.MoveNext
        Wend
        rsTmp.Close
        .TableCell(rptTblColWidth, , grdParticulars) = 6000
        .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
        .TableCell(rptTblFontName, , grdParticulars) = "Times New Roman"
        .TableCell(rptTblColWidth, , grdThisYr) = 2600
        .TableCell(rptTblAlignment, , grdThisYr) = taRightMiddle
        .TableCell(rptTblFontName, , grdThisYr) = "Times New Roman"
        .TableCell(rptTblColWidth, , grdLastYr) = 2000
        .TableCell(rptTblAlignment, , grdLastYr) = taRightMiddle
        .TableCell(rptTblFontName, , grdLastYr) = "Times New Roman"
        .TableCell(rptTblColWidth, , grdIsTotal) = 1
        If mComparePeriodID <> 0 Then
            .TableCell(rptTblColWidth, , grdThisYr) = 2100
            .TableCell(rptTblColWidth, , grdLastYr) = 2000
            .TableCell(rptTblColWidth, , grdIsTotal) = 1
        Else
            .TableCell(rptTblColWidth, , grdThisYr) = 4000
            .TableCell(rptTblColWidth, , grdLastYr) = 1
            .TableCell(rptTblColWidth, , grdIsTotal) = 1
        End If
        .TableCell(rptTblUnderline, Inc, grdThisYr) = True
        If .TableRows > 2 Then
            .TableCell(rptTblRowHeight, 2, grdParticulars, .TableRows - 1, .TableCols - 1) = 330
        End If
        'Ref No: 001 - 17/06/2009, Wednesday ----------
'        If .TableCell(rptTblText, .TableRows - 3, grdThisYr, .TableRows - 3, grdLastYr) <> "" Then
'            .TableCell(rptTblUnderline, .TableRows - 3, grdThisYr, .TableRows - 3, grdLastYr) = False
'        End If
        If .TableRows > 10 Then
            .TableCell(rptTblUnderline, .TableRows - 3, grdThisYr, .TableRows - 3, grdLastYr) = False
        End If
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) <> "" And .TableCell(rptTblText, Inc, grdThisYr) = "" Then
                .TableCell(rptTblText, Inc, grdThisYr) = "-"
            End If
        Next Inc
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) <> "" And .TableCell(rptTblText, Inc, grdLastYr) = "" Then
                .TableCell(rptTblText, Inc, grdLastYr) = "-"
            End If
        Next Inc
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdThisYr) = "-" And .TableCell(rptTblText, Inc, grdLastYr) = "-" Then
                .TableCell(rptTblText, Inc, grdThisYr, Inc, grdLastYr) = ""
                .TableCell(rptTblUnderline, Inc, grdThisYr, Inc, grdLastYr) = False
            End If
        Next Inc
        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "" And .TableCell(rptTblText, Inc, grdThisYr, Inc, grdLastYr) = "" Then
                .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdLastYr) = 75
            End If
        Next Inc
        For Inc = 6 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from operating activities" Then
                strAmount = .TableCell(rptTblText, Inc, grdThisYr)
                strPreviousamount = .TableCell(rptTblText, Inc, grdLastYr)
                If strAmount = "-" Or strAmount = "" Then
                    strAmount = 0
                End If
                If strPreviousamount = "-" Or strPreviousamount = "" Then
                    strPreviousamount = 0
                End If
                If strAmount < 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in operating activities"
                ElseIf strAmount < 0 And strPreviousamount > 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash (used in)/generated from operating activities"
                ElseIf strAmount > 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from/(used in) operating activities"
                ElseIf strAmount < 0 And strPreviousamount = 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in operating activities"
                Else
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from operating activities"
                End If
            End If
        Next Inc
        For Inc = 10 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in investing activities" Then
                strAmount = .TableCell(rptTblText, Inc, grdThisYr)
                strPreviousamount = .TableCell(rptTblText, Inc, grdLastYr)
                If strAmount = "-" Or strAmount = "" Then
                    strAmount = 0
                End If
                If strPreviousamount = "-" Or strPreviousamount = "" Then
                    strPreviousamount = 0
                End If
                If strAmount < 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in investing activities"
                ElseIf strAmount < 0 And strPreviousamount > 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash (used in)/generated from investing activities"
                ElseIf strAmount > 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from/(used in) investing activities"
                ElseIf strAmount < 0 And strPreviousamount = 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from investing activities"
                Else
                
                End If
            End If
        Next Inc
        For Inc = 13 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in financing activities" Then
                strAmount = .TableCell(rptTblText, Inc, grdThisYr)
                strPreviousamount = .TableCell(rptTblText, Inc, grdLastYr)
                If strAmount = "-" Or strAmount = "" Then
                    strAmount = 0
                End If
                If strPreviousamount = "-" Or strPreviousamount = "" Then
                    strPreviousamount = 0
                End If
                If strAmount < 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash used in financing activities"
                ElseIf strAmount > 0 And strPreviousamount > 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from financing activities"
                ElseIf strAmount < 0 And strPreviousamount > 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash (used in)/generated from financing activities"
                ElseIf strAmount > 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from/(used in) financing activities"
                Else
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net cash generated from financing activities"
                End If
            End If
        Next Inc
        For Inc = 14 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "Net increase in cash and cash equivalents" Then
                strAmount = .TableCell(rptTblText, Inc, grdThisYr)
                strPreviousamount = .TableCell(rptTblText, Inc, grdLastYr)
                If strAmount = "-" Or strAmount = "" Then
                    strAmount = 0
                End If
                If strPreviousamount = "-" Or strPreviousamount = "" Then
                    strPreviousamount = 0
                End If
                If strAmount < 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net decrease in cash and cash equivalents"
                ElseIf strAmount < 0 And strPreviousamount > 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net (decrease)/increase in cash and cash equivalents"
                ElseIf strAmount > 0 And strPreviousamount < 0 Then
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net increase/(decrease) in cash and cash equivalents"
                Else
                    .TableCell(rptTblText, Inc, grdParticulars) = "Net increase in cash and cash equivalents"
                End If
            End If
        Next Inc
        If .TableCell(rptTblText, .TableRows - 2, grdParticulars) <> "" And .TableCell(rptTblText, .TableRows - 2, grdLastYr) = "" Then
            .TableCell(rptTblText, .TableRows - 2, grdThisYr) = 0
        End If
        .TableCell(rptTblFontName, , , .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, , , .TableRows - 1, .TableCols - 1) = 11
        For Inc = 8 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) <> "" And .TableCell(rptTblText, Inc, grdIsTotal) = "True" Then
                If .TableCell(rptTblText, Inc, grdThisYr, Inc, grdLastYr) = "" Then
                    .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdIsTotal) = 1
                    .TableCell(rptTblRowHeight, Inc - 1, grdParticulars, Inc - 1, grdIsTotal) = 1
                End If
            End If
        Next Inc
        .TableCell(rptTblUnderline, .TableRows - 2, grdThisYr, .TableRows - 2, grdLastYr) = True
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptCash = Nothing
            End If
        Else
            Set PrintCashFlow = crptCash
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintCashEquivalentSchedule(lngPeriodID As Long, lngAcTypeID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                            Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim lngCompanyID As Long, dblCurTotalAmount As Double, dblLastTotalAmount As Double
Dim crptSchedule As New clsReports, sSql As String, rsTmp As New Recordset
Dim Inc As Long, lngComparePeriodID As Long, lngCompareEndDt As Long, lngEndDt As Long
Dim dblAmount As Double, dblLastAmount As Double, dblCurLess As Double, dblLastLess As Double
Dim curCYearTot As Currency, curLYearTot As Currency
Dim strNoteNo As String, strParticulars As String, RowInc As Long
Dim IsLastRowTotal As Boolean, strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptSchedule = crptMain
    End If

    lngComparePeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & lngPeriodID))
    lngEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngPeriodID))
    lngCompareEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngComparePeriodID))
    lngCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & lngPeriodID))
    lngAcTypeID = PickValue("Schedules", "AcTypeID", "PeriodID = " & lngPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeCashEquivalents)
    dblCurLess = Val(PickValue("Schedules", "DerivedAmount", "PeriodID = " & lngPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID))
    dblLastLess = Val(PickValue("Schedules", "DerivedAmount", "PeriodID = " & lngComparePeriodID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID))
    strNoteNo = PickValue("Schedules", "NoteNo", "AcTypeID = " & lngAcTypeID & " AND PeriodID = " & lngPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeCashEquivalents)
    'Ref No:- 002 - 01/07/2009 --------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    With crptSchedule
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
        End If
       .StartTable 1440, lngCurrentY + 1000, 10000, 10000, rptTTCashEquivalents
       .TableCols = grdCols
       .TableRows = 1: Inc = 0
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdNoteNo) = strNoteNo & "."
       .TableCell(rptTblText, Inc, grdParticulars) = "Cash and cash equivalents"
       .TableCell(rptTblIsBold, Inc, grdNoteNo, Inc, grdParticulars) = True
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdDebit) = Format(lngEndDt, "MMMM DD, YYYY")
       .TableCell(rptTblText, Inc, grdCredit) = Format(lngCompareEndDt, "MMMM DD, YYYY")
       .TableRows = .TableRows + 1: Inc = Inc + 1
       .TableCell(rptTblText, Inc, grdDebit) = strCurrency                     '"AED"
       .TableCell(rptTblText, Inc, grdCredit) = strCurrency                    '"AED"
       .TableCell(rptTblIsBold, Inc - 1, grdDebit, Inc, grdDebit) = True
       .TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True
       curCYearTot = 0
       sSql = "SELECT  AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & lngComparePeriodID & ") AS PreviousAmount, " & _
              "TypeNature From AcTypes Where AcTypeID = " & lngAcTypeID
       With GetRecords(sSql)
        If Not .EOF Then
            dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
        End If
        crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
        crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = "Cash and bank balances"
        crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
        crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
        If crptSchedule.TableCell(rptTblText, Inc, grdDebit) = 0 Then
            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = "-"
        End If
        strParticulars = PickValue("Schedules", "Remarks", "PeriodID = " & lngPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID)
'        If strParticulars <> "" Then
'            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
'            crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = strParticulars
'            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblCurLess < 0, "(" & Format(Abs(dblCurLess), "#,##0") & ")", Format(dblCurLess, "#,##0"))
'            crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastLess < 0, "(" & Format(Abs(dblLastLess), "#,##0") & ")", Format(dblLastLess, "#,##0"))
'            If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
'                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
'            End If
'        End If
        'Ref No 001 - 16/06/2009, Tuesday --------
        If strParticulars <> "" Then
            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
            crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = strParticulars
            crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblCurLess <> 0, "(" & Format(Abs(dblCurLess), "#,##0") & ")", Format(dblCurLess, "#,##0"))
            crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastLess <> 0, "(" & Format(Abs(dblLastLess), "#,##0") & ")", Format(dblLastLess, "#,##0"))
            If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
            End If
        End If
        If crptSchedule.TableRows <= 5 Then
            IsLastRowTotal = False
        Else
            IsLastRowTotal = True
        End If
        End With
         curCYearTot = dblAmount - dblCurLess
         curLYearTot = dblLastAmount - dblLastLess
         If IsLastRowTotal Then
             crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
             crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
             crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
             crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True
         Else
             crptSchedule.TableCell(rptTblUnderline, Inc, grdDebit, Inc, grdCredit) = True
         End If
        .TableCell(rptTblColWidth, , grdNoteNo) = 500
        .TableCell(rptTblAlignment, , grdNoteNo) = taLeftMiddle
        .TableCell(rptTblColWidth, , grdParticulars) = 5300
        .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
        'Ref No: 001 - 05/Jul/2009, Sunday ----------
        .TableCell(rptTblColWidth, , grdDebit) = 2200
        .TableCell(rptTblAlignment, , grdDebit) = taRightMiddle
        .TableCell(rptTblColWidth, , grdCredit) = 2200
        .TableCell(rptTblAlignment, , grdCredit) = taRightMiddle
        If lngComparePeriodID <> 0 Then
             .TableCell(rptTblColWidth, , grdDebit) = 2200
             .TableCell(rptTblColWidth, , grdCredit) = 2200
        Else
           .TableCell(rptTblColWidth, , grdDebit) = 4000
           .TableCell(rptTblColWidth, , grdCredit) = 1
        End If
        For RowInc = 5 To .TableRows - 1
             If .TableCell(rptTblText, RowInc, grdParticulars) = "" And .TableCell(rptTblText, RowInc, grdDebit) = "0" Then
                  .TableCell(rptTblRowHeight, RowInc, 0, RowInc, .TableCols - 1) = 1
             End If
        Next RowInc
        .TableCell(rptTblIsBold, 0, grdDebit, .TableRows - 1, grdDebit) = True
        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblRowHeight, 3, 0, .TableRows - 1, .TableCols - 1) = 400
        .EndTable
        lngCurrentY = lngCurrentY + (400 * .TableRows)
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptSchedule = Nothing
            End If
        Else
            Set PrintCashEquivalentSchedule = crptSchedule
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintLiabilitySchedules(lngPeriodID As Long, lngAcTypeID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                        Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim lngCompanyID As Long
Dim crptSchedule As New clsReports, sSql As String, rsTmp As New Recordset, sSqlThisYear As String, sSqlLastYear As String
Dim Inc As Long, strNoteNo As String, lngComparePeriodID As Long, lngAcTypeName As String
Dim lngCompareEndDt As Long, lngEndDt As Long, dblAmount As Double, dblLastAmount As Double
Dim curCYearTot As Currency, curCTmpTot As Currency, lngThisTot As Double, IsLastRowTotal As Boolean
Dim curLYearTot As Currency, curLTmpTot As Currency, lngLastTot As Double, strAcTypes As String
Dim lngPLID As Long, lngParentAcTypeID As Long, lngImmediateParentID As Long
Dim strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptSchedule = crptMain
    End If

    lngAcTypeName = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngAcTypeID)
    lngComparePeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & lngPeriodID))
    lngEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngPeriodID))
    lngCompareEndDt = Val(PickValue("Periods", "EndDt", "PeriodID = " & lngComparePeriodID))
    lngCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & lngPeriodID))
    lngPLID = GetActualID(lngCompanyID, cnstAcTypeProfitLoss)
    lngImmediateParentID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngAcTypeID))
    lngParentAcTypeID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngImmediateParentID))

    strNoteNo = PickValue("Schedules", "NoteNo", "AcTypeID = " & lngAcTypeID & " AND PeriodID = " & lngPeriodID)
    'Ref No:- 002 - 01/07/2009 --------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    With crptSchedule
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
        End If
        lngCurrentY = lngCurrentY + 700
        .StartTable 1440, lngCurrentY + 1000, 10000, 10000, rptTTGeneralSchedule
        .TableCols = grdCols
        .TableRows = 1: Inc = 0
        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdNoteNo) = strNoteNo & "."
        .TableCell(rptTblText, Inc, grdParticulars) = lngAcTypeName
        .TableCell(rptTblIsBold, Inc, grdNoteNo, Inc, grdParticulars) = True
        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdDebit) = Format(lngEndDt, "MMMM dd, yyyy")
        .TableCell(rptTblText, Inc, grdCredit) = Format(lngCompareEndDt, "MMMM dd, yyyy")
        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdDebit) = strCurrency                     '"AED"
        .TableCell(rptTblText, Inc, grdCredit) = strCurrency                    '"AED"
        .TableCell(rptTblIsBold, Inc - 1, grdDebit, Inc, grdDebit) = True
        .TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True

        curCYearTot = 0

        sSqlThisYear = "SELECT Amount From LiabilitySchedules Where (AcTypeID = " & lngAcTypeID & ") And (AcID = AH.AcID) And (PeriodID = " & lngPeriodID & ")"
        sSqlLastYear = "SELECT Amount From LiabilitySchedules Where (AcTypeID = " & lngAcTypeID & ") And (AcID = AH.AcID) And (PeriodID = " & lngComparePeriodID & ")"

        sSql = "SELECT AH.AcID, AH.AcName AS Particulars, (" & sSqlThisYear & ") AS Amount, (" & sSqlLastYear & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, AT.TypeNature, AH.TrialOrder " & _
               "FROM   AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")"
            With GetRecords(sSql)
                While Not .EOF
                    crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                    dblAmount = Val(.Fields("Amount") & "")
                    curCYearTot = curCYearTot + dblAmount
                    curCTmpTot = dblAmount
                    dblLastAmount = Val(.Fields("PreviousAmount") & "")
                    curLYearTot = curLYearTot + dblLastAmount
                    curLTmpTot = dblLastAmount
                    crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = .Fields("Particulars") & ""
                    crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
                    crptSchedule.TableCell(rptTblIsBold, Inc, grdDebit, Inc, grdDebit) = True
                    crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                    If crptSchedule.TableCell(rptTblText, Inc, grdDebit) = 0 Then
                        crptSchedule.TableCell(rptTblText, Inc, grdDebit) = "-"
                    End If
                    If crptSchedule.TableCell(rptTblText, Inc, grdCredit) = 0 Then
                        crptSchedule.TableCell(rptTblText, Inc, grdCredit) = "-"
                    End If
                    If crptSchedule.TableRows <= 5 Then
                        IsLastRowTotal = False
                    Else
                        IsLastRowTotal = True
                    End If
                    .MoveNext
                Wend
            End With
            If IsLastRowTotal Then
                crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                crptSchedule.TableCell(rptTblText, Inc, grdDebit) = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
                crptSchedule.TableCell(rptTblText, Inc, grdCredit) = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
                crptSchedule.TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdDebit) = True
                crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdDebit, Inc, grdCredit) = True
            Else
                crptSchedule.TableCell(rptTblUnderline, Inc, grdDebit, Inc, grdCredit) = True
            End If
            .TableCell(rptTblColWidth, , grdNoteNo) = 500
            .TableCell(rptTblAlignment, , grdNoteNo) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdParticulars) = 5300
            .TableCell(rptTblAlignment, , grdParticulars) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdDebit) = 2200
            .TableCell(rptTblAlignment, , grdDebit) = taRightMiddle
            .TableCell(rptTblColWidth, , grdCredit) = 2200
            .TableCell(rptTblAlignment, , grdCredit) = taRightMiddle
            If lngCompareEndDt <> 0 Then
                 .TableCell(rptTblColWidth, , grdDebit) = 2200
                 .TableCell(rptTblColWidth, , grdCredit) = 2200
            Else
                .TableCell(rptTblColWidth, , grdDebit) = 4000
                .TableCell(rptTblColWidth, , grdCredit) = 1
            End If
            .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
            .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
            .TableCell(rptTblRowHeight, 2, 0, .TableRows - 1, .TableCols - 1) = 350
            .EndTable
        lngCurrentY = lngCurrentY + (400 * .TableRows)
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptSchedule = Nothing
            End If
        Else
            Set PrintLiabilitySchedules = crptSchedule
        End If
    End With
Exit Function
Err_Exit:
'    ShowError
End Function

Public Function PrintSchedules(strNoteNo As String, lngPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                               Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim mCompanyID As Long, mComparePeriodID As Long, mstrCaption As String
Dim crptSchedule As New clsReports, sSql As String, rsTmp As New ADODB.Recordset
Dim Inc As Long, lngStartDt As Long, lngEndDt As Long, lngCompareStartDt As Long, lngCompareEndDt As Long
Dim dblThisAmount As Double, dblLastAmount As Double, dblThisTotalAmt As Double, dblLastTotalAmt As Double
Dim curCYearTot As Currency, curCTmpTot As Currency, curLYearTot As Currency, curLTmpTot As Currency
Dim dblThisDerivedAmount As Double, dblLastDerivedAmount As Double
Dim lngAcTypeID As Long, lngAllocationAcTypeID As Long, strAllocationAcType As String
Dim lngScheduleTypeID As Long, rptReportTableType As ReportTableTypes
Dim IsLastRowTotal As Boolean, lngTotalAcTypes As Long, strAcTypeName As String
Dim lngCurDt As Long, lngLastDt As Long, lngPLID As Long, lngParentAcTypeID As Long, lngImmediateParentID As Long
Dim lngPropertyID As Long, strCurrency As String

Const grdNoteNo = 0
Const grdParticulars = 1
Const grdThisYear = 2
Const grdLastYear = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crptSchedule = crptMain
    End If
    sSql = "SELECT PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.ComparePeriodID AS ComparePeriodID, " & _
           "       PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt " & _
           "FROM   Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "WHERE  PER.PeriodID = " & lngPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With
    mstrCaption = PickValue("Notes", "Description", "NoteNo = " & strNoteNo & " And PeriodID = " & lngPeriodID)
    lngPropertyID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
    'Ref No:- 002 - 01/07/09 --------
    sSql = "SELECT CM.CurrencyShortName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    With crptSchedule
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
        End If
        sSql = "Select ScheduleTypeID From Schedules Where NoteNo = " & Val(strNoteNo) & " And AcTypeID <> " & lngPropertyID & " And PeriodID = " & lngPeriodID
        With GetRecords(sSql)
            If Not .EOF Then
                lngScheduleTypeID = Val(.Fields("ScheduleTypeID") & "")
            End If
        End With
        Select Case lngScheduleTypeID
        Case 1
            rptReportTableType = rptTTGeneralSchedule
        Case 2
            rptReportTableType = rptTTSplitSchedule
        Case 3
            rptReportTableType = rptTTFixedAssetsSchedule
        Case 4
            rptReportTableType = rptTTEquitySchedule
        Case 5
            rptReportTableType = rptTTCashEquivalents
        Case 6
            rptReportTableType = rptTTLiabilitySchedule
        End Select
        If rptReportTableType = rptTTFixedAssetsSchedule Then
            If blnIsPreview And crptMain Is Nothing Then
                crptMain.StartReport pprA4, 1440, 1440, 1440, 1440, 1, lngPeriodID
                crptMain.CreatePageBreak , , , , , , orLandscape
            End If
            Set crptSchedule = PrintFixedAssetSchedules(lngPeriodID, blnIsPreview, crptMain)
            crptMain.CreatePageBreak , , , , , , orPortrait
            If blnIsPreview And crptMain Is Nothing Then
                crptMain.CreatePageBreak , , , , , , orPortrait
            End If
        ElseIf rptReportTableType = rptTTEquitySchedule Then
            If blnIsPreview And crptMain Is Nothing Then
                crptMain.StartReport pprA4, 1440, 1440, 1440, 1440, 1, lngPeriodID
            End If
            Set crptSchedule = PrintShareholdersEquity(lngPeriodID, blnIsPreview, crptMain)
            If blnIsPreview And crptMain Is Nothing Then
                crptMain.CreatePageBreak , , , , , , orPortrait
            End If
        Else
            .StartReport pprA4, 1440, 1000, 1440 * 0.5, 1440 * 0.5, 0
            lngCurrentY = lngCurrentY + 700
            .StartTable 1440, lngCurrentY + 1000, 10000, 10000, rptReportTableType, , , , , , , , orPortrait
            .TableCols = grdCols
            .TableRows = 1: Inc = 0
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdNoteNo) = strNoteNo & "."
            .TableCell(rptTblText, Inc, grdParticulars) = mstrCaption
            .TableCell(rptTblIsBold, Inc, grdNoteNo, Inc, grdParticulars) = True
            .TableCell(rptTblAlignment, Inc, grdNoteNo, Inc, grdParticulars) = taLeftMiddle
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdThisYear) = Format(lngEndDt, "MMMM dd, yyyy")
            .TableCell(rptTblText, Inc, grdLastYear) = Format(lngCompareEndDt, "MMMM dd, yyyy")
            .TableCell(rptTblRowHeight, Inc, grdThisYear, Inc, grdLastYear) = 700
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblText, Inc, grdThisYear) = strCurrency                 '"AED"
            .TableCell(rptTblText, Inc, grdLastYear) = strCurrency                 '"AED"
            .TableCell(rptTblIsBold, Inc - 1, grdThisYear, Inc, grdThisYear) = True
            .TableCell(rptTblUnderline, Inc - 1, grdThisYear, Inc, grdLastYear) = True
            sSql = "SELECT Count(*) As TotalNos From Schedules Where NoteNo = " & strNoteNo & " And PeriodID = " & lngPeriodID
                With GetRecords(sSql)
                    If Not .EOF Then
                        lngTotalAcTypes = .Fields("TotalNos") & ""
                    End If
                End With
            If lngTotalAcTypes >= 1 Then
                If rptReportTableType <> rptTTSplitSchedule Then
                    sSql = "Select AcTypeID From Schedules Where NoteNo = " & strNoteNo & " And ScheduleTypeID IN(" & cnstScheduleTypeGeneral & " , " & cnstScheduleTypeContingentLiability & ", " & cnstScheduleTypeCashEquivalents & ") And PeriodID = " & lngPeriodID
                Else
                    sSql = "Select TOP 1 AcTypeID From Schedules Where NoteNo = " & strNoteNo & " And ScheduleTypeID = " & cnstScheduleTypeSplit & " And PeriodID = " & lngPeriodID
                End If
                    Set rsTmp = GetRecords(sSql)
                    With rsTmp
                        While Not .EOF
                            curCYearTot = 0
                            lngAcTypeID = .Fields("AcTypeID") & ""
                            lngPLID = GetActualID(mCompanyID, cnstAcTypeProfitLoss)
                            lngImmediateParentID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngAcTypeID))
                            lngParentAcTypeID = Val(PickValue("AcTypes", "ParentAcTypeID", "AcTypeID = " & lngImmediateParentID))
                            If lngPLID = lngParentAcTypeID Then
                                 crptSchedule.TableCell(rptTblRowHeight, 2, grdThisYear, 2, grdLastYear) = 1100
                                 crptSchedule.TableCell(rptTblText, 2, grdThisYear) = GetFixedAssetSchedulePeriod(lngPeriodID)
                                 crptSchedule.TableCell(rptTblText, 2, grdLastYear) = GetFixedAssetSchedulePeriod(mComparePeriodID)
                            End If
                            strAcTypeName = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngAcTypeID & " And CompanyID = " & mCompanyID)
                            If mstrCaption <> strAcTypeName Then
                                crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = strAcTypeName
                                crptSchedule.TableCell(rptTblIsBold, Inc, grdParticulars) = True
                                crptSchedule.TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                                crptSchedule.TableCell(rptTblUnderline, Inc, grdParticulars) = True
                            End If
                        sSql = "SELECT SUM(Amount) AS Amount, SUM(PreviousAmount) AS PreviousAmount, Particulars, ORD, DeductionAcTypeID, TypeNature " & _
                               "FROM (SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & mComparePeriodID & ") AS PreviousAmount, 1 AS ORD, AT.DeductionAcTypeID, TypeNature, AT.TrialOrder " & _
                               "FROM AcTypes AT Where ParentAcTypeID = " & lngAcTypeID & "  AND AT.AcTypeID NOT IN (SELECT ISNULL(AT1.DeductionAcTypeID, 0) FROM AcTypes AT1 WHERE AT1.CompanyID = " & mCompanyID & ") " & _
                               "Union " & _
                               "SELECT AH.AcName AS Particulars, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
                               "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & lngPeriodID & ") AS Amount, (SELECT SUM(ESA.DAmt - ESA.CAmt) FROM EntrySubAccounts ESA, Entries ET " & _
                               "WHERE ET.EntryID = ESA.EntryID AND ESA.AcID = AH.AcID AND ET.PeriodID = " & mComparePeriodID & ") AS PreviousAmount, 2 AS ORD, AT.DeductionAcTypeID, " & _
                               "AT.TypeNature, AH.TrialOrder FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID WHERE (AH.AcTypeID = " & lngAcTypeID & ")) TMP1 " & _
                               "WHERE (Amount <> 0 OR PreviousAmount <> 0) GROUP BY Particulars, ORD, DeductionAcTypeID, TypeNature, TrialOrder ORDER BY ORD, TrialOrder, DeductionAcTypeID DESC"
                        With GetRecords(sSql)
                            While Not .EOF
                                dblThisAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                                curCYearTot = curCYearTot + dblThisAmount
                                curCTmpTot = dblThisAmount
                                dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                                curLYearTot = curLYearTot + dblLastAmount
                                curLTmpTot = dblLastAmount
                                crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = .Fields("Particulars") & ""
                                crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = IIf(dblThisAmount < 0, "(" & Format(Abs(dblThisAmount), "#,##0") & ")", Format(dblThisAmount, "#,##0"))
                                crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYear, Inc, grdThisYear) = True
                                crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                                If crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = 0 Then
                                    crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = "-"
                                End If
                                If crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = 0 Then
                                    crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = "-"
                                End If
                                If Val(.Fields("DeductionAcTypeID") & "") <> 0 Then
                                    sSql = "SELECT AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & lngPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & mComparePeriodID & ") AS PreviousAmount, TypeNature " & _
                                           "From AcTypes Where AcTypeID = " & Val(.Fields("DeductionAcTypeID"))
                                    With GetRecords(sSql)
                                        While Not .EOF
                                            crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                            dblThisAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
                                            curCYearTot = curCYearTot + dblThisAmount
                                            curCTmpTot = curCTmpTot + dblThisAmount
                                            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
                                            curLYearTot = curLYearTot + dblLastAmount
                                            curLTmpTot = curLTmpTot + dblLastAmount
                                            crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = IIf(dblThisAmount > 0, "", "Less - ") & .Fields("Particulars") & ""
                                            crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = IIf(dblThisAmount < 0, "(" & Format(Abs(dblThisAmount), "#,##0") & ")", Format(dblThisAmount, "#,##0"))
                                            crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYear, Inc, grdThisYear) = True
                                            crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
                                            If crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = 0 Then
                                                crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = "-"
                                            End If
                                            If crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = 0 Then
                                                crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = "-"
                                            End If
                                            If rptReportTableType = rptTTSplitSchedule Then
                                                dblThisDerivedAmount = Val(PickValue("Schedules", "DerivedAmount", "AcTypeID = " & lngAcTypeID & " And PeriodID = " & lngPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeSplit))
                                                dblLastDerivedAmount = Val(PickValue("Schedules", "DerivedAmount", "AcTypeID = " & lngAcTypeID & " And PeriodID = " & mComparePeriodID & " And ScheduleTypeID = " & cnstScheduleTypeSplit))
                                                dblThisTotalAmt = curCYearTot
                                                dblLastTotalAmt = curLYearTot
                                                Inc = Inc + 1
                                                crptSchedule.TableRows = crptSchedule.TableRows + 1
                                                crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdThisYear, Inc - 1, grdLastYear) = True
                                                crptSchedule.TableCell(rptTblUnderline, Inc, grdThisYear, Inc, grdLastYear) = True
                                                crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYear) = True
                                                crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = Format(curCYearTot, "#,##0")
                                                crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = Format(curLYearTot, "#,##0")

                                                Inc = Inc + 2
                                                crptSchedule.TableRows = crptSchedule.TableRows + 2
                                                crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = "Due within 1 year"           '" & "Current Portion"
                                                crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = Format(dblThisDerivedAmount, "#,##0")
                                                crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYear) = True
                                                crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = Format(dblLastDerivedAmount, "#,##0")
                                                crptSchedule.TableCell(rptTblIsBold, Inc, grdLastYear) = False

                                                Inc = Inc + 1
                                                crptSchedule.TableRows = crptSchedule.TableRows + 1
                                                crptSchedule.TableCell(rptTblText, Inc, grdParticulars) = "Due within 2-5 years"        'strAllocationType
                                                crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = Format(curCYearTot - dblThisDerivedAmount, "#,##0")
                                                crptSchedule.TableCell(rptTblIsBold, Inc, grdThisYear) = True
                                                crptSchedule.TableCell(rptTblUnderline, Inc, grdThisYear, Inc, grdLastYear) = True
                                                crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = Format(curLYearTot - dblLastDerivedAmount, "#,##0")
                                            End If
                                            .MoveNext
                                        Wend
                                    End With
                                End If
                                If crptSchedule.TableRows <= 5 Then
                                    IsLastRowTotal = False
                                Else
                                    IsLastRowTotal = True
                                End If
                                .MoveNext
                            Wend
                            If rptReportTableType <> rptTTSplitSchedule Then
                                If IsLastRowTotal Then
                                    crptSchedule.TableRows = crptSchedule.TableRows + 1: Inc = Inc + 1
                                    crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = IIf(curCYearTot < 0, "(" & Format(Abs(curCYearTot), "#,##0") & ")", Format(curCYearTot, "#,##0"))
                                    crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = IIf(curLYearTot < 0, "(" & Format(Abs(curLYearTot), "#,##0") & ")", Format(curLYearTot, "#,##0"))
                                    crptSchedule.TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdThisYear) = True
                                    crptSchedule.TableCell(rptTblUnderline, Inc - 1, grdThisYear, Inc, grdLastYear) = True
                                Else
                                    crptSchedule.TableCell(rptTblUnderline, Inc, grdThisYear, Inc, grdLastYear) = True
                                End If
                            End If
                        End With
                        .MoveNext
                    Wend
                    .Close
                End With
                If crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = 0 Then
                    crptSchedule.TableCell(rptTblText, Inc, grdThisYear) = "-"
                End If
                If crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = 0 Then
                    crptSchedule.TableCell(rptTblText, Inc, grdLastYear) = "-"
                End If
            End If
            .TableCell(rptTblColWidth, , grdNoteNo) = 500
            .TableCell(rptTblAlignment, 1, grdNoteNo, .TableRows - 1, grdNoteNo) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdParticulars) = 5300
            .TableCell(rptTblAlignment, 1, grdParticulars, .TableRows - 1, grdParticulars) = taLeftMiddle
            .TableCell(rptTblColWidth, , grdThisYear) = 2200
            .TableCell(rptTblAlignment, , grdThisYear) = taRightMiddle
            .TableCell(rptTblColWidth, , grdLastYear) = 2200
            .TableCell(rptTblAlignment, , grdLastYear) = taRightMiddle
            If lngCompareEndDt <> 0 Then
                .TableCell(rptTblColWidth, , grdThisYear) = 2200
                .TableCell(rptTblColWidth, , grdLastYear) = 2200
            Else
                .TableCell(rptTblColWidth, , grdThisYear) = 4000
                .TableCell(rptTblColWidth, , grdLastYear) = 1
            End If
            .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
            .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
            .TableCell(rptTblRowHeight, 3, 0, .TableRows - 1, .TableCols - 1) = 400
            .EndTable
            lngCurrentY = lngCurrentY + (400 * .TableRows)
        End If
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptSchedule = Nothing
            End If
        Else
            Set PrintSchedules = crptSchedule
        End If
    End With
Exit Function
Err_Exit:
'    ShowError
End Function

Public Function PrintReviewReport(lngPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                  Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset
Dim crptReview As New clsReports, Inc As Long, strTmp As String, strParticulars As String, lngSlNo As Long

Const grdRevSlNo = 0
Const grdReviewRelated = 1
Const grdReview = 2
Const grdReviewedBy = 3
Const grdReviewReply = 4
Const grdReviewRepliedBy = 5
Const grdReviewSignedBy = 6
Const grdRevCols = 7

    If Not crptMain Is Nothing Then
        Set crptReview = crptMain
    End If
    With crptReview
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
'            ---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & pActiveCompanyID) & GetPrintingAddress(pActiveCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("Reviews")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(lngPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 3000, 10950, 3000, , , , , , , orPortrait
        End If
        .StartTable 1440, 3000, 11000, 11000, rptTTCustomTable, , , , , , , , orPortrait, tbAll
        .TableCols = grdRevCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdRevSlNo) = "Sl No"
        .TableCell(rptTblText, Inc, grdReviewRelated) = "Related To"
        .TableCell(rptTblText, Inc, grdReview) = "Reviews"
        .TableCell(rptTblText, Inc, grdReviewedBy) = "Reviewed By"
        .TableCell(rptTblText, Inc, grdReviewReply) = "Review Reply"
        .TableCell(rptTblText, Inc, grdReviewRepliedBy) = "Replied By"
        .TableCell(rptTblText, Inc, grdReviewSignedBy) = "SignedOff"
        
        .TableCell(rptTblColWidth, Inc, grdRevSlNo) = 500
        .TableCell(rptTblColWidth, Inc, grdReviewRelated) = 1800
        .TableCell(rptTblColWidth, Inc, grdReview) = 2400
        .TableCell(rptTblColWidth, Inc, grdReviewedBy) = 1100
        .TableCell(rptTblColWidth, Inc, grdReviewReply) = 2500
        .TableCell(rptTblColWidth, Inc, grdReviewRepliedBy) = 900
        .TableCell(rptTblColWidth, Inc, grdReviewSignedBy) = 900
        
        .TableCell(rptTblIsBold, Inc, grdRevSlNo, , grdReviewSignedBy) = True
        .TableCell(rptTblRowHeight, Inc, grdRevSlNo, Inc, grdReviewSignedBy) = 600
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT  REV.ReviewID, FSS.Description AS SubSection, (SELECT AcTypeDescription FROM AcTypes AT WHERE AT.AcTypeID = REV.AcTypeID) AS AcTypeDescription, " & _
               "        (SELECT AcName FROM AcHeads AH WHERE AH.AcID = REV.AcID) AS AcName, (SELECT PQ.Question FROM ProcedureQuestions PQ WHERE PQ.QuestionID = REV.ProcedureID) AS ProcedureName, REV.Question, REV.Answer, REV.CreateDate, REV.UpdateDate,  " & _
               "        REV.SubSectionID, REV.PeriodID, REV.ProcedureID, REV.AcTypeID, REV.AcID, REV.SignedBy, ReviewUser.UserName AS ReviewUser, ReplyUser.UserName AS ReplyUser " & _
               "FROM    Reviews REV INNER JOIN FilingSubSection FSS ON REV.SubSectionID = FSS.SubSectionID INNER JOIN Users ReviewUser ON REV.CreateUser = ReviewUser.UserID LEFT OUTER JOIN " & _
               "        Users ReplyUser ON REV.UpdateUser = ReplyUser.UserID Where (REV.PeriodID = " & lngPeriodID & ") ORDER BY REV.ReviewID"
        Set rsTmp = GetRecords(sSql)
            lngSlNo = 0
            While Not rsTmp.EOF
                If rsTmp.Fields("AcTypeDescription") & "" <> "" Then
                    strParticulars = "Account Type : " & rsTmp.Fields("AcTypeDescription") & ""
                ElseIf rsTmp.Fields("AcName") & "" <> "" Then
                    strParticulars = "Account Head : " & rsTmp.Fields("AcName") & ""
                ElseIf rsTmp.Fields("ProcedureName") & "" <> "" Then
                    strParticulars = "Procedures : " & rsTmp.Fields("ProcedureName") & ""
                End If
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblRowHeight, Inc, grdRevSlNo, Inc, grdReviewRepliedBy) = 1700
                lngSlNo = lngSlNo + 1
                .TableCell(rptTblText, Inc, grdRevSlNo) = lngSlNo
                .TableCell(rptTblText, Inc, grdReviewRelated) = strParticulars
                .TableCell(rptTblText, Inc, grdReview) = rsTmp.Fields("Question") & ""
                .TableCell(rptTblText, Inc, grdReviewedBy) = StrConv(rsTmp.Fields("ReviewUser") & "", vbProperCase)
                .TableCell(rptTblText, Inc, grdReviewReply) = rsTmp.Fields("Answer") & ""
                .TableCell(rptTblText, Inc, grdReviewRepliedBy) = StrConv(rsTmp.Fields("ReplyUser") & "", vbProperCase)
                .TableCell(rptTblText, Inc, grdReviewSignedBy) = StrConv(rsTmp.Fields("SignedBy") & "", vbProperCase)
                .TableRows = .TableRows + 1: Inc = Inc + 1
                rsTmp.MoveNext
            Wend
            rsTmp.Close
            .TableCell(rptTblFontName, 0, grdRevSlNo, .TableRows - 1, grdReviewSignedBy) = "Times New Roman"
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptReview = Nothing
            End If
        Else
            Set PrintReviewReport = crptReview
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintJournal(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptJournal As New clsReports, sSql As String, rsTmp As New Recordset, strTmp As String
Dim Inc As Long, mCompanyID As Long, ColInc As Long
Dim dblTotalDebit As Double, dblTotalCredit As Double
Dim lngEntryID As Long
Dim rsRemark As New ADODB.Recordset, rsEntry As New ADODB.Recordset

Const grdRefNo = 0
Const grdParticulars = 1
Const grdJVType = 2
Const grdDebit = 3
Const grdCredit = 4
Const grdEntryID = 5
Const grdCols = 6

If crptMain Is Nothing Then
    Set crptJournal = crptMain
End If
    mCompanyID = pActiveCompanyID
    With crptJournal
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1440, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("JournalEntryHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 3000, 10950, 3000, , , , , , , orPortrait
            .CreateLine 1440, 3700, 11170, 3700, , , , , , , orPortrait
        End If
        .StartTable 1440, 3000, 11000, 11000, rptTTCustomTable, , , , , , , , orPortrait, tbBoxColumns
        .TableCols = grdCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdRefNo) = "No."
        .TableCell(rptTblText, Inc, grdParticulars) = "Particulars"
        .TableCell(rptTblText, Inc, grdJVType) = "Type"
        .TableCell(rptTblText, Inc, grdDebit) = "Debit"
        .TableCell(rptTblText, Inc, grdCredit) = "Credit"

        .TableCell(rptTblColWidth, Inc, grdRefNo) = 1000
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 5000
        .TableCell(rptTblColWidth, Inc, grdJVType) = 700
        .TableCell(rptTblColWidth, Inc, grdDebit) = 1500
        .TableCell(rptTblColWidth, Inc, grdCredit) = 1500
        .TableCell(rptTblColWidth, Inc, grdEntryID) = 0
        .TableCell(rptTblIsBold, Inc, grdRefNo, , grdCredit) = True
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT   EntryID, RefNo, Remark From Entries Where PeriodID = " & mPeriodID & " And IsOpening = 0"
        Set rsEntry = GetRecords(sSql)
            While Not rsEntry.EOF
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblText, Inc, grdRefNo) = rsEntry.Fields("RefNo") & ""
                sSql = "SELECT   AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, Entries.IsErrorSchedule AS Reason, " & _
                       "         EntrySubAccounts.EntryID AS EntryID, EntrySubAccounts.Narration AS Narration " & _
                       "FROM     Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID " & _
                       "WHERE    Entries.IsOpening = 0 AND Entries.PeriodID = " & mPeriodID & " " & _
                       "AND      EntrySubAccounts.EntryID = " & rsEntry.Fields("EntryID") & "" & _
                       "ORDER BY EntryID"
                    Set rsTmp = GetRecords(sSql)
                    Do Until rsTmp.EOF
'                        .TableRows = .TableRows + 1: Inc = Inc + 1
                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("AccountName") & ""
                        .TableCell(rptTblText, Inc, grdDebit) = IIf(rsTmp.Fields("Debit") < 0, "(" & Format(Abs(rsTmp.Fields("Debit")), "#,###.00") & ")", Format(rsTmp.Fields("Debit"), "#,###.00"))
'                        dblTotalDebit = dblTotalDebit + Val(rsTmp.Fields("Debit") & "")
                        .TableCell(rptTblText, Inc, grdCredit) = IIf(rsTmp.Fields("Credit") < 0, "(" & Format(Abs(rsTmp.Fields("Credit")), "#,###.00") & ")", Format(rsTmp.Fields("Credit"), "#,###.00"))
'                        dblTotalCredit = dblTotalCredit + Val(rsTmp.Fields("Credit") & "")
                        If rsTmp.Fields("Reason") = "False" Then
                            .TableCell(rptTblText, Inc, grdJVType) = "U A"
                        Else
                            .TableCell(rptTblText, Inc, grdJVType) = "E S"
                        End If
                        .TableCell(rptTblAlignment, Inc, grdJVType) = taJustMiddle
                        .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                        If rsTmp.Fields("Narration") & "" <> "" Then
                            .TableRows = .TableRows + 1: Inc = Inc + 1
                            .TableCell(rptTblText, Inc, grdParticulars) = "(" & rsTmp.Fields("Narration") & "" & ")"
'                            .TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                        End If
                        .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, .TableCols - 1) = 400
                        rsTmp.MoveNext
                        If .TableCell(rptTblText, Inc, grdRefNo, Inc, grdCredit) = "" Then
                            .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, grdCredit) = 1
                        End If
                        .TableRows = .TableRows + 1: Inc = Inc + 1
                    Loop
                    rsTmp.Close
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                    .TableCell(rptTblText, Inc, grdParticulars) = rsEntry.Fields("Remark") & ""
                    .TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                    .TableCell(rptTblRowHeight, Inc, grdEntryID, Inc, grdCredit) = 500
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                rsEntry.MoveNext
            Wend
            rsEntry.Close
'        .TableRows = .TableRows + 1: Inc = Inc + 1
'        .TableCell(rptTblText, Inc, grdParticulars) = "Total Amount"
'        .TableCell(rptTblText, Inc, grdDebit) = IIf(dblTotalDebit < 0, "(" & Format(Abs(dblTotalDebit), "#,###.00") & ")", Format(dblTotalDebit, "#,###.00"))
'        .TableCell(rptTblText, Inc, grdCredit) = IIf(dblTotalCredit < 0, "(" & Format(Abs(dblTotalCredit), "#,###.00") & ")", Format(dblTotalCredit, "#,###.00"))
'        .TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdCredit) = True
'        .TableCell(rptTblIsBold, Inc - 1, grdDebit, Inc - 1, grdCredit) = True
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdDebit) = ".00" Then
                .TableCell(rptTblText, Inc, grdDebit) = "  "
            End If
        Next Inc
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdCredit) = ".00" Then
                .TableCell(rptTblText, Inc, grdCredit) = "  "
            End If
        Next Inc
        .TableCell(rptTblIsBold, 2, grdDebit, .TableRows - 1, grdCredit) = True
        .TableCell(rptTblAlignment, 2, grdJVType) = taCenterMiddle
        .TableCell(rptTblAlignment, 0, grdDebit, .TableRows - 1, grdCredit) = taRightMiddle
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblFontName, 0, grdRefNo, .TableRows - 1, grdCredit) = "Times New Roman"
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptJournal = Nothing
            End If
        Else
            Set PrintJournal = crptJournal
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintTBReport(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptTBDetail As New clsReports, sSql As String, rsTmp As New Recordset, strTmp As String
Dim Inc As Long, mCompanyID As Long, mComparePeriodID As Long, ColInc As Long
Dim lngStartDt As Long, lngEndDt As Long, lngCompareStartDt As Long, lngCompareEndDt As Long
Dim lngEntryID As Long, lngAcID As Long, rsTmp1 As New ADODB.Recordset, rsTmp2 As New ADODB.Recordset
Dim dblThisDebit As Double, dblThisCredit As Double
Dim dblTmpThisDebit As Double, dblTmpThisCredit As Double
Dim dblThisDr As Double, dblThisCr As Double
Dim dblThisDr1 As Double, dblThisCr1 As Double
Dim dblThisDr2 As Double, dblThisCr2 As Double
Dim dblThisDr3 As Double, dblThisCr3 As Double
Dim dblCurOpenBalDebit As Double, dblCurOpenBalCredit As Double
Dim dblAdjEntryDebit As Double, dblAdjEntryCredit As Double
Dim dblErrSchDebit As Double, dblErrSchCredit As Double
Dim dblCurCloseBalDebit As Double, dblCurCloseBalCredit As Double

Const grdParticulars = 0
Const grdCurOpeningDr = 1
Const grdCurOpeningCr = 2
Const grdAdjEntryDr = 3
Const grdAdjEntryCr = 4
Const grdErrScheduleDr = 5
Const grdErrScheduleCr = 6
Const grdCurYearClosingDr = 7
Const grdCurYearClosingCr = 8
Const grdEntryID = 9
Const grdAcID = 10
Const grdCols = 11

If crptMain Is Nothing Then
    Set crptTBDetail = crptMain
End If
sSql = "SELECT  PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.ComparePeriodID AS ComparePeriodID, " & _
       "        PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
       "WHERE   PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With
    With crptTBDetail
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1440, 500, 1440 * 0.5, 1440 * 0.5, orLandscape
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440 * 0.5, 500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = "Detailed Trial Balance Report"
            .CreateText strTmp, 1440 * 0.5, 1100, 11000, 2000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440 * 0.5, 1400, 11000, 1400, , , , , , , orLandscape
        End If
        Screen.MousePointer = vbHourglass
        .StartTable 1440 * 0.5, 1400, 11000, 11000, rptTTCustomTable, , , , , , , , orLandscape, tbAll
        
        .TableCols = grdCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdParticulars) = "Particulars"
        .TableCell(rptTblText, Inc, grdCurOpeningDr) = "Current Year Opening Balance"
        .TableCell(rptTblText, Inc, grdAdjEntryDr) = "Audit Adjustment Entries"
        .TableCell(rptTblText, Inc, grdErrScheduleDr) = "Error Schedule"
        .TableCell(rptTblText, Inc, grdCurYearClosingDr) = "Current Year Closing Balance"
        
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 3500
        .TableCell(rptTblColWidth, Inc, grdCurOpeningDr) = 3000
        .TableCell(rptTblColWidth, Inc, grdCurOpeningCr) = 0
        .TableCell(rptTblColWidth, Inc, grdAdjEntryDr) = 3000
        .TableCell(rptTblColWidth, Inc, grdAdjEntryCr) = 0
        .TableCell(rptTblColWidth, Inc, grdErrScheduleDr) = 3000
        .TableCell(rptTblColWidth, Inc, grdErrScheduleCr) = 0
        .TableCell(rptTblColWidth, Inc, grdCurYearClosingDr) = 3000
        .TableCell(rptTblColWidth, Inc, grdCurYearClosingCr) = 0
        .TableCell(rptTblColWidth, Inc, grdEntryID) = 0
        .TableCell(rptTblColWidth, Inc, grdAcID) = 0
        
        .TableCell(rptTblAlignment, Inc, grdParticulars, Inc, grdEntryID) = taCenterMiddle
        .TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdEntryID) = True
        .TableCell(rptTblRowHeight, 0, grdParticulars, 0, grdEntryID) = 0
        .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdEntryID) = 600
        .EndTable
        
        .StartTable 1440 * 0.5, 2000, 11000, 11000, rptTTCustomTable, , , , , , , , orLandscape, tbAll
        .TableCols = grdCols
        .TableRows = 1: Inc = 0
        
        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdCurOpeningDr) = "Debit"
        .TableCell(rptTblText, Inc, grdCurOpeningCr) = "Credit"
        .TableCell(rptTblText, Inc, grdAdjEntryDr) = "Debit"
        .TableCell(rptTblText, Inc, grdAdjEntryCr) = "Credit"
        .TableCell(rptTblText, Inc, grdErrScheduleDr) = "Debit"
        .TableCell(rptTblText, Inc, grdErrScheduleCr) = "Credit"
        .TableCell(rptTblText, Inc, grdCurYearClosingDr) = "Debit"
        .TableCell(rptTblText, Inc, grdCurYearClosingCr) = "Credit"
        
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 3500
        .TableCell(rptTblColWidth, Inc, grdCurOpeningDr) = 1500
        .TableCell(rptTblColWidth, Inc, grdCurOpeningCr) = 1500
        .TableCell(rptTblColWidth, Inc, grdAdjEntryDr) = 1500
        .TableCell(rptTblColWidth, Inc, grdAdjEntryCr) = 1500
        .TableCell(rptTblColWidth, Inc, grdErrScheduleDr) = 1500
        .TableCell(rptTblColWidth, Inc, grdErrScheduleCr) = 1500
        .TableCell(rptTblColWidth, Inc, grdCurYearClosingDr) = 1500
        .TableCell(rptTblColWidth, Inc, grdCurYearClosingCr) = 1500
        .TableCell(rptTblColWidth, Inc, grdEntryID) = 0
        .TableCell(rptTblColWidth, Inc, grdAcID) = 0
        
        .TableCell(rptTblIsBold, Inc, grdParticulars, , grdAcID) = True
        dblCurOpenBalDebit = 0
        dblCurOpenBalCredit = 0
        dblAdjEntryDebit = 0
        dblAdjEntryCredit = 0
        dblErrSchDebit = 0
        dblErrSchCredit = 0
        dblCurCloseBalDebit = 0
        dblCurCloseBalCredit = 0
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT    Entries.EntryID, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, AcHeads.AcName AS AccountName, AcHeads.AcID, AcTypes.TypeNature " & _
               "FROM      EntrySubAccounts INNER JOIN  Entries ON EntrySubAccounts.EntryID = Entries.EntryID INNER JOIN " & _
               "          AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID INNER JOIN  AcTypes ON AcHeads.AcTypeID = AcTypes.AcTypeID " & _
               "Where     Entries.PeriodID = " & mPeriodID & " And Entries.IsOpening = 1 AND AcHeads.CompanyID = " & mCompanyID
        Set rsTmp = GetRecords(sSql)
        If Not rsTmp.EOF Then
            rsTmp.MoveFirst
                Do Until rsTmp.EOF
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                    .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("AccountName") & ""
                    .TableCell(rptTblText, Inc, grdCurOpeningDr) = IIf(rsTmp.Fields("Debit") & "" < 0, "(" & Format(Abs(rsTmp.Fields("Debit")), "#,##0") & ")", Format(Abs(rsTmp.Fields("Debit")), "#,##0"))
                    .TableCell(rptTblText, Inc, grdCurOpeningCr) = IIf(rsTmp.Fields("Credit") & "" < 0, "(" & Format(Abs(rsTmp.Fields("Credit")), "#,##0") & ")", Format(Abs(rsTmp.Fields("Credit")), "#,##0"))
                    .TableCell(rptTblText, Inc, grdEntryID) = rsTmp.Fields("EntryID") & ""
                    .TableCell(rptTblText, Inc, grdAcID) = rsTmp.Fields("AcID") & ""
                    lngEntryID = rsTmp.Fields("EntryID")
                    lngAcID = rsTmp.Fields("AcID") & ""
                    dblTmpThisDebit = rsTmp.Fields("Debit") & ""
                    dblTmpThisCredit = rsTmp.Fields("Credit") & ""
                    dblThisDebit = dblTmpThisDebit + dblThisDebit
                    dblThisCredit = dblTmpThisCredit + dblThisCredit
                    dblCurOpenBalDebit = dblCurOpenBalDebit + dblThisDebit
                    dblCurOpenBalCredit = dblCurOpenBalCredit + dblThisCredit
                    dblTmpThisDebit = 0
                    dblTmpThisCredit = 0
                    If .TableCell(rptTblText, Inc, grdCurOpeningDr) = 0 Then
                        .TableCell(rptTblText, Inc, grdCurOpeningDr) = ""
                    End If
                    If .TableCell(rptTblText, Inc, grdCurOpeningCr) = 0 Then
                        .TableCell(rptTblText, Inc, grdCurOpeningCr) = ""
                    End If
                    sSql = "SELECT    AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, AcTypes.TypeNature " & _
                           "FROM      Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN " & _
                           "          AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID INNER JOIN AcTypes ON AcHeads.AcTypeID = AcTypes.AcTypeID " & _
                           "Where     Entries.IsErrorSchedule = 1 And Entries.IsOpening = 0 And AcHeads.AcID = " & lngAcID & " And Entries.PeriodID = " & mPeriodID
                    Set rsTmp1 = GetRecords(sSql)
                    If Not rsTmp1.EOF Then
                        rsTmp1.MoveFirst
                        If rsTmp1.Fields("Debit") & "" <> 0 Then
                            .TableCell(rptTblText, Inc, grdAdjEntryDr) = IIf(rsTmp1.Fields("Debit") & "" < 0, "(" & Format(Abs(rsTmp1.Fields("Debit")), "#,##0") & ")", Format(Abs(rsTmp1.Fields("Debit")), "#,##0"))
                        Else
                            .TableCell(rptTblText, Inc, grdAdjEntryDr) = 0
                        End If
                        If rsTmp1.Fields("Credit") & "" <> 0 Then
                            .TableCell(rptTblText, Inc, grdAdjEntryCr) = IIf(rsTmp1.Fields("Credit") & "" < 0, "(" & Format(Abs(rsTmp1.Fields("Credit")), "#,##0") & ")", Format(Abs(rsTmp1.Fields("Credit")), "#,##0"))
                        Else
                            .TableCell(rptTblText, Inc, grdAdjEntryCr) = 0
                        End If
                        If .TableCell(rptTblText, Inc, grdAdjEntryDr) = 0 Then
                            .TableCell(rptTblText, Inc, grdAdjEntryDr) = ""
                        End If
                        If .TableCell(rptTblText, Inc, grdAdjEntryCr) = 0 Then
                            .TableCell(rptTblText, Inc, grdAdjEntryCr) = ""
                        End If
                        dblTmpThisDebit = rsTmp1.Fields("Debit") & ""
                        dblTmpThisCredit = rsTmp1.Fields("Credit") & ""
                        dblThisDebit = dblTmpThisDebit + dblThisDebit
                        dblThisCredit = dblTmpThisCredit + dblThisCredit
                        If dblThisDebit <> 0 Then
                            dblThisDebit = dblThisDebit - dblThisCredit
                            dblThisCredit = 0
                        End If
                        If dblThisCredit <> 0 Then
                            dblThisCredit = dblThisCredit + dblThisDebit
                            dblThisDebit = 0
                        End If
                        dblAdjEntryDebit = dblAdjEntryDebit + dblThisDebit
                        dblAdjEntryCredit = dblAdjEntryCredit + dblThisCredit
                        dblTmpThisDebit = 0
                        dblTmpThisCredit = 0
                        rsTmp1.MoveNext
                    End If
                    sSql = "SELECT    AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, AcTypes.TypeNature " & _
                           "FROM      Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN " & _
                           "          AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID INNER JOIN AcTypes ON AcHeads.AcTypeID = AcTypes.AcTypeID " & _
                           "Where     Entries.IsErrorSchedule = 0 And Entries.IsOpening = 0 And AcHeads.AcID = " & lngAcID & " And Entries.PeriodID = " & mPeriodID
                    Set rsTmp2 = GetRecords(sSql)
                    If Not rsTmp2.EOF Then
                        rsTmp2.MoveFirst
                        If rsTmp2.Fields("Debit") & "" <> 0 Then
                            .TableCell(rptTblText, Inc, grdErrScheduleDr) = IIf(rsTmp2.Fields("Debit") & "" < 0, "(" & Format(Abs(rsTmp2.Fields("Debit")), "#,##0") & ")", Format(Abs(rsTmp2.Fields("Debit")), "#,##0"))
                        Else
                            .TableCell(rptTblText, Inc, grdErrScheduleDr) = 0
                        End If
                        If rsTmp2.Fields("Credit") & "" <> 0 Then
                            .TableCell(rptTblText, Inc, grdErrScheduleCr) = IIf(rsTmp2.Fields("Credit") & "" < 0, "(" & Format(Abs(rsTmp2.Fields("Credit")), "#,##0") & ")", Format(Abs(rsTmp2.Fields("Credit")), "#,##0"))
                        Else
                            .TableCell(rptTblText, Inc, grdErrScheduleCr) = 0
                        End If
                        If .TableCell(rptTblText, Inc, grdErrScheduleDr) = 0 Then
                            .TableCell(rptTblText, Inc, grdErrScheduleDr) = ""
                        End If
                        If .TableCell(rptTblText, Inc, grdErrScheduleCr) = 0 Then
                            .TableCell(rptTblText, Inc, grdErrScheduleCr) = ""
                        End If
                        dblTmpThisDebit = rsTmp2.Fields("Debit") & ""
                        dblTmpThisCredit = rsTmp2.Fields("Credit") & ""
                        dblThisDebit = dblThisDebit + dblTmpThisDebit
                        dblThisCredit = dblThisCredit + dblTmpThisCredit
                        If dblThisDebit <> 0 Then
                            dblThisDebit = dblThisDebit - dblThisCredit
                            dblThisCredit = 0
                        End If
                        If dblThisCredit <> 0 Then
                            dblThisCredit = dblThisCredit + dblThisDebit
                            dblThisDebit = 0
                        End If
                        dblErrSchDebit = dblErrSchDebit + dblThisDebit
                        dblErrSchCredit = dblErrSchCredit + dblThisCredit
                        dblTmpThisDebit = 0
                        dblTmpThisCredit = 0
                        rsTmp2.MoveNext
                    End If
                    .TableCell(rptTblText, Inc, grdCurYearClosingDr) = IIf(dblThisDebit < 0, "(" & Format(Abs(dblThisDebit), "#,##0") & ")", Format(Abs(dblThisDebit), "#,##0"))
                    .TableCell(rptTblText, Inc, grdCurYearClosingCr) = IIf(dblThisCredit < 0, "(" & Format(Abs(dblThisCredit), "#,##0") & ")", Format(Abs(dblThisCredit), "#,##0"))
                    .TableCell(rptTblIsBold, Inc, grdCurYearClosingDr, Inc, grdCurYearClosingCr) = True
                    If .TableCell(rptTblText, Inc, grdCurYearClosingDr) = 0 Then
                        .TableCell(rptTblText, Inc, grdCurYearClosingDr) = ""
                    End If
                    If .TableCell(rptTblText, Inc, grdCurYearClosingCr) = 0 Then
                        .TableCell(rptTblText, Inc, grdCurYearClosingCr) = ""
                    End If
                    dblCurCloseBalDebit = dblCurCloseBalDebit + dblThisDebit
                    dblCurCloseBalCredit = dblCurCloseBalCredit + dblThisCredit
                    dblTmpThisDebit = 0
                    dblTmpThisCredit = 0
                    dblThisDebit = 0
                    dblThisCredit = 0
            rsTmp.MoveNext
            Loop
        End If
        .TableCell(rptTblText, Inc, grdParticulars) = "Grand Total"
        .TableCell(rptTblText, Inc, grdCurOpeningDr) = IIf(dblCurOpenBalDebit < 0, "(" & Format(Abs(dblCurOpenBalDebit), "#,##0") & ")", Format(Abs(dblCurOpenBalDebit), "#,##0"))
        .TableCell(rptTblText, Inc, grdCurOpeningCr) = IIf(dblCurOpenBalCredit < 0, "(" & Format(Abs(dblCurOpenBalCredit), "#,##0") & ")", Format(Abs(dblCurOpenBalCredit), "#,##0"))
        .TableCell(rptTblText, Inc, grdAdjEntryDr) = IIf(dblAdjEntryDebit < 0, "(" & Format(Abs(dblAdjEntryDebit), "#,##0") & ")", Format(Abs(dblAdjEntryDebit), "#,##0"))
        .TableCell(rptTblText, Inc, grdAdjEntryCr) = IIf(dblAdjEntryCredit < 0, "(" & Format(Abs(dblAdjEntryCredit), "#,##0") & ")", Format(Abs(dblAdjEntryCredit), "#,##0"))
        .TableCell(rptTblText, Inc, grdErrScheduleDr) = IIf(dblErrSchDebit < 0, "(" & Format(Abs(dblErrSchDebit), "#,##0") & ")", Format(Abs(dblErrSchDebit), "#,##0"))
        .TableCell(rptTblText, Inc, grdErrScheduleCr) = IIf(dblErrSchCredit < 0, "(" & Format(Abs(dblErrSchCredit), "#,##0") & ")", Format(Abs(dblErrSchCredit), "#,##0"))
        .TableCell(rptTblText, Inc, grdCurYearClosingDr) = IIf(dblCurCloseBalDebit < 0, "(" & Format(Abs(dblCurCloseBalDebit), "#,##0") & ")", Format(Abs(dblCurCloseBalDebit), "#,##0"))
        .TableCell(rptTblText, Inc, grdCurYearClosingCr) = IIf(dblCurCloseBalCredit < 0, "(" & Format(Abs(dblCurCloseBalCredit), "#,##0") & ")", Format(Abs(dblCurCloseBalCredit), "#,##0"))
        .TableCell(rptTblRowHeight, 0, grdParticulars, 0, grdAcID) = 0
        .TableCell(rptTblIsBold, Inc, grdParticulars, Inc, grdCurYearClosingCr) = True
        For Inc = 3 To .TableRows - 1
            .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdCurYearClosingCr) = 350
            .TableCell(rptTblAlignment, Inc, grdParticulars) = taLeftMiddle
            .TableCell(rptTblAlignment, Inc, grdCurOpeningDr, Inc, grdCurYearClosingCr) = taRightMiddle
        Next
'        For Inc = 3 To .TableRows - 1
'            If .TableCell(rptTblText, Inc, grdCurOpeningDr, Inc, grdCurYearClosingCr) = 0 Then
'                .TableCell(rptTblText, Inc, grdCurOpeningDr, Inc, grdCurYearClosingCr) = "-"
'            End If
'        Next
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptTBDetail = Nothing
            End If
        Else
            Set PrintTBReport = crptTBDetail
        End If
    End With
    Screen.MousePointer = vbDefault
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
End Function

Public Function PrintAdjustmentJournal(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptJournal As New clsReports, sSql As String, rsTmp As New Recordset, strTmp As String
Dim Inc As Long, mCompanyID As Long, ColInc As Long
Dim dblTotalDebit As Double, dblTotalCredit As Double
Dim lngEntryID As Long
Dim rsRemark As New ADODB.Recordset, rsEntry As New ADODB.Recordset

Const grdRefNo = 0
Const grdParticulars = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdEntryID = 4
Const grdCols = 5

If crptMain Is Nothing Then
    Set crptJournal = crptMain
End If
    mCompanyID = pActiveCompanyID
    With crptJournal
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1440, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("AdjustmentJournal")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 3000, 10450, 3000, , , , , , , orPortrait
            .CreateLine 1440, 3700, 10450, 3700, , , , , , , orPortrait
        End If
        .StartTable 1440, 3000, 11000, 11000, rptTTCustomTable, , , , , , , , orPortrait, tbBoxColumns
        .TableCols = grdCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdRefNo) = "No."
        .TableCell(rptTblText, Inc, grdParticulars) = "Particulars"
        .TableCell(rptTblText, Inc, grdDebit) = "Debit"
        .TableCell(rptTblText, Inc, grdCredit) = "Credit"

        .TableCell(rptTblColWidth, Inc, grdRefNo) = 1000
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 5000
        .TableCell(rptTblColWidth, Inc, grdDebit) = 1500
        .TableCell(rptTblColWidth, Inc, grdCredit) = 1500
        .TableCell(rptTblColWidth, Inc, grdEntryID) = 0
        .TableCell(rptTblIsBold, Inc, grdRefNo, , grdCredit) = True
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT   EntryID, RefNo, Remark From Entries Where PeriodID = " & mPeriodID & " And IsOpening = 0 AND IsErrorSchedule = 0"
        Set rsEntry = GetRecords(sSql)
            While Not rsEntry.EOF
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblText, Inc, grdRefNo) = rsEntry.Fields("RefNo") & ""
                sSql = "SELECT   AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, Entries.IsErrorSchedule AS Reason, " & _
                       "         EntrySubAccounts.EntryID AS EntryID, EntrySubAccounts.Narration AS Narration " & _
                       "FROM     Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID " & _
                       "WHERE    Entries.IsOpening = 0 AND Entries.PeriodID = " & mPeriodID & " " & _
                       "AND      EntrySubAccounts.EntryID = " & rsEntry.Fields("EntryID") & "" & _
                       "ORDER BY EntryID"
                    Set rsTmp = GetRecords(sSql)
                    Do Until rsTmp.EOF
'                        .TableRows = .TableRows + 1: Inc = Inc + 1
                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("AccountName") & ""
                        .TableCell(rptTblText, Inc, grdDebit) = IIf(rsTmp.Fields("Debit") < 0, "(" & Format(Abs(rsTmp.Fields("Debit")), "#,###.00") & ")", Format(rsTmp.Fields("Debit"), "#,###.00"))
'                        dblTotalDebit = dblTotalDebit + Val(rsTmp.Fields("Debit") & "")
                        .TableCell(rptTblText, Inc, grdCredit) = IIf(rsTmp.Fields("Credit") < 0, "(" & Format(Abs(rsTmp.Fields("Credit")), "#,###.00") & ")", Format(rsTmp.Fields("Credit"), "#,###.00"))
'                        dblTotalCredit = dblTotalCredit + Val(rsTmp.Fields("Credit") & "")
                        .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                        If rsTmp.Fields("Narration") & "" <> "" Then
                            .TableRows = .TableRows + 1: Inc = Inc + 1
                            .TableCell(rptTblText, Inc, grdParticulars) = "(" & rsTmp.Fields("Narration") & "" & ")"
'                            .TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                        End If
                        .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, .TableCols - 1) = 400
                        rsTmp.MoveNext
                        If .TableCell(rptTblText, Inc, grdRefNo, Inc, grdCredit) = "" Then
                            .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, grdCredit) = 1
                        End If
                        .TableRows = .TableRows + 1: Inc = Inc + 1
                    Loop
                    rsTmp.Close
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                    .TableCell(rptTblText, Inc, grdParticulars) = rsEntry.Fields("Remark") & ""
                    .TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                    .TableCell(rptTblRowHeight, Inc, grdEntryID, Inc, grdCredit) = 500
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                rsEntry.MoveNext
            Wend
            rsEntry.Close
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdDebit) = ".00" Then
                .TableCell(rptTblText, Inc, grdDebit) = "  "
            End If
        Next Inc
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdCredit) = ".00" Then
                .TableCell(rptTblText, Inc, grdCredit) = "  "
            End If
        Next Inc
        .TableCell(rptTblIsBold, 2, grdDebit, .TableRows - 1, grdCredit) = True
        .TableCell(rptTblAlignment, 0, grdDebit, .TableRows - 1, grdCredit) = taRightMiddle
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblFontName, 0, grdRefNo, .TableRows - 1, grdCredit) = "Times New Roman"
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptJournal = Nothing
            End If
        Else
            Set PrintAdjustmentJournal = crptJournal
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintErrorScheduleJournal(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crptJournal As New clsReports, sSql As String, rsTmp As New Recordset, strTmp As String
Dim Inc As Long, mCompanyID As Long, ColInc As Long
Dim dblTotalDebit As Double, dblTotalCredit As Double
Dim lngEntryID As Long
Dim rsRemark As New ADODB.Recordset, rsEntry As New ADODB.Recordset

Const grdRefNo = 0
Const grdParticulars = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdEntryID = 4
Const grdCols = 5

If crptMain Is Nothing Then
    Set crptJournal = crptMain
End If
    mCompanyID = pActiveCompanyID
    With crptJournal
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1440, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
            '---Finding header data----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("ErrorScheduleJournal")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 3000, 10450, 3000, , , , , , , orPortrait
            .CreateLine 1440, 3700, 10450, 3700, , , , , , , orPortrait
        End If
        .StartTable 1440, 3000, 11000, 11000, rptTTCustomTable, , , , , , , , orPortrait, tbBoxColumns
        .TableCols = grdCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdRefNo) = "No."
        .TableCell(rptTblText, Inc, grdParticulars) = "Particulars"
        .TableCell(rptTblText, Inc, grdDebit) = "Debit"
        .TableCell(rptTblText, Inc, grdCredit) = "Credit"

        .TableCell(rptTblColWidth, Inc, grdRefNo) = 1000
        .TableCell(rptTblColWidth, Inc, grdParticulars) = 5000
        .TableCell(rptTblColWidth, Inc, grdDebit) = 1500
        .TableCell(rptTblColWidth, Inc, grdCredit) = 1500
        .TableCell(rptTblColWidth, Inc, grdEntryID) = 0
        .TableCell(rptTblIsBold, Inc, grdRefNo, , grdCredit) = True
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT   EntryID, RefNo, Remark From Entries Where PeriodID = " & mPeriodID & " And IsOpening = 0 AND IsErrorSchedule = 1"
        Set rsEntry = GetRecords(sSql)
            While Not rsEntry.EOF
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblText, Inc, grdRefNo) = rsEntry.Fields("RefNo") & ""
                sSql = "SELECT   AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, Entries.IsErrorSchedule AS Reason, " & _
                       "         EntrySubAccounts.EntryID AS EntryID, EntrySubAccounts.Narration AS Narration " & _
                       "FROM     Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID " & _
                       "WHERE    Entries.IsOpening = 0 AND Entries.PeriodID = " & mPeriodID & " " & _
                       "AND      EntrySubAccounts.EntryID = " & rsEntry.Fields("EntryID") & "" & _
                       "ORDER BY EntryID"
                    Set rsTmp = GetRecords(sSql)
                    Do Until rsTmp.EOF
'                        .TableRows = .TableRows + 1: Inc = Inc + 1
                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("AccountName") & ""
                        .TableCell(rptTblText, Inc, grdDebit) = IIf(rsTmp.Fields("Debit") < 0, "(" & Format(Abs(rsTmp.Fields("Debit")), "#,###.00") & ")", Format(rsTmp.Fields("Debit"), "#,###.00"))
'                        dblTotalDebit = dblTotalDebit + Val(rsTmp.Fields("Debit") & "")
                        .TableCell(rptTblText, Inc, grdCredit) = IIf(rsTmp.Fields("Credit") < 0, "(" & Format(Abs(rsTmp.Fields("Credit")), "#,###.00") & ")", Format(rsTmp.Fields("Credit"), "#,###.00"))
'                        dblTotalCredit = dblTotalCredit + Val(rsTmp.Fields("Credit") & "")
                        .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                        If rsTmp.Fields("Narration") & "" <> "" Then
                            .TableRows = .TableRows + 1: Inc = Inc + 1
                            .TableCell(rptTblText, Inc, grdParticulars) = "(" & rsTmp.Fields("Narration") & "" & ")"
                        End If
                        .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, .TableCols - 1) = 400
                        rsTmp.MoveNext
                        If .TableCell(rptTblText, Inc, grdRefNo, Inc, grdCredit) = "" Then
                            .TableCell(rptTblRowHeight, Inc, grdRefNo, Inc, grdCredit) = 1
                        End If
                        .TableRows = .TableRows + 1: Inc = Inc + 1
                    Loop
                    rsTmp.Close
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                    .TableCell(rptTblText, Inc, grdParticulars) = rsEntry.Fields("Remark") & ""
                    .TableCell(rptTblIsItalic, Inc, grdParticulars) = True
                    .TableCell(rptTblRowHeight, Inc, grdEntryID, Inc, grdCredit) = 500
                    .TableRows = .TableRows + 1: Inc = Inc + 1
                rsEntry.MoveNext
            Wend
            rsEntry.Close
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdDebit) = ".00" Then
                .TableCell(rptTblText, Inc, grdDebit) = "  "
            End If
        Next Inc
        For Inc = 3 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdCredit) = ".00" Then
                .TableCell(rptTblText, Inc, grdCredit) = "  "
            End If
        Next Inc
        .TableCell(rptTblIsBold, 2, grdDebit, .TableRows - 1, grdCredit) = True
        .TableCell(rptTblAlignment, 0, grdDebit, .TableRows - 1, grdCredit) = taRightMiddle
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .TableCell(rptTblFontName, 0, grdRefNo, .TableRows - 1, grdCredit) = "Times New Roman"
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptJournal = Nothing
            End If
        Else
            Set PrintErrorScheduleJournal = crptJournal
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintMattersArsingReport(lngPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, _
                                         Optional ByRef crptMain As clsReports = Nothing, Optional ByRef lngCurrentY As Long = 0) As clsReports
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset
Dim crptMatters As New clsReports, Inc As Long, strTmp As String, strParticulars As String, lngSlNo As Long

Const grdRevSlNo = 0
Const grdReviewRelated = 1
Const grdReview = 2
Const grdReviewReply = 3
Const grdRevCols = 4

    If Not crptMain Is Nothing Then
        Set crptMatters = crptMain
    End If
    With crptMatters
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, orPortrait
            End If
'            --- Finding header data ----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & pActiveCompanyID) & GetPrintingAddress(pActiveCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("MattersArising")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(lngPeriodID))
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , orLandscape, True, , , 12, "Times New Roman"
            .CreateLine 1440, 3000, 10950, 3000, , , , , , , orPortrait
        End If
        .StartTable 1440, 3000, 11000, 11000, rptTTCustomTable, , , , , , , , orPortrait, tbAll
        .TableCols = grdRevCols
        .TableRows = 1: Inc = 0

        .TableRows = .TableRows + 1: Inc = Inc + 1
        .TableCell(rptTblText, Inc, grdRevSlNo) = "Sl No"
        .TableCell(rptTblText, Inc, grdReviewRelated) = "Sub Section"
        .TableCell(rptTblText, Inc, grdReview) = "Observations"
        .TableCell(rptTblText, Inc, grdReviewReply) = "Actions"

        .TableCell(rptTblColWidth, Inc, grdRevSlNo) = 500
        .TableCell(rptTblColWidth, Inc, grdReviewRelated) = 1800
        .TableCell(rptTblColWidth, Inc, grdReview) = 4500
        .TableCell(rptTblColWidth, Inc, grdReviewReply) = 3500

        .TableCell(rptTblIsBold, Inc, grdRevSlNo, , grdReviewReply) = True
        .TableCell(rptTblRowHeight, Inc, grdRevSlNo, Inc, grdReviewReply) = 600
        .TableRows = .TableRows + 1: Inc = Inc + 1
        sSql = "SELECT  FSS.Description AS SubSection, REM.Observations, REM.Actions, REM.PeriodID, FSS.SubSectionID " & _
               "FROM    FilingSubSection AS FSS INNER JOIN Remarks AS REM ON FSS.SubSectionID = REM.SubSectionID " & _
               "WHERE   REM.PeriodID = " & lngPeriodID & " ORDER BY FSS.SubSectionID"
        Set rsTmp = GetRecords(sSql)
            lngSlNo = 0
            While Not rsTmp.EOF
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblRowHeight, Inc, grdRevSlNo, Inc, grdReviewReply) = 2000
                lngSlNo = lngSlNo + 1
                .TableCell(rptTblText, Inc, grdRevSlNo) = lngSlNo
                .TableCell(rptTblText, Inc, grdReviewRelated) = rsTmp.Fields("SubSection") & ""
                .TableCell(rptTblText, Inc, grdReview) = rsTmp.Fields("Observations") & ""
                .TableCell(rptTblText, Inc, grdReviewReply) = rsTmp.Fields("Actions") & ""
                .TableRows = .TableRows + 1: Inc = Inc + 1
                rsTmp.MoveNext
            Wend
            rsTmp.Close
            .TableCell(rptTblFontName, 0, grdRevSlNo, .TableRows - 1, grdReviewReply) = "Times New Roman"
            .TableCell(rptTblAlignment, 0, grdRevSlNo, .TableRows - 1, grdReviewReply) = taJustTop
        .EndTable
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .EndReport
                .Clear
                Set crptMatters = Nothing
            End If
        Else
            Set PrintMattersArsingReport = crptMatters
        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Public Function PrintBalanceSheet(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True, Optional ByRef crptMain As clsReports = Nothing, Optional ByRef vpPreview As VSPrinter8LibCtl.VSPrinter = Nothing) As clsReports
On Local Error GoTo Err_Exit
Dim crsBalanceRpt As New clsReports, strTmp As String, sSql As String, lngAcTypePL As Long, mDerivedPeriodID As Long, mComparePeriodID As Long
Dim mCompanyID As Long, lngComparedStartDt As Long, lngStartDt As Long, lngComparedEndDt As Long, lngEndDt As Long, Inc As Long
Dim rsTmp As New Recordset, rsTmp1 As New Recordset, rsTmp2 As New Recordset, lngLevelCount As Long, dblLevelTotalThis As Double, dblLevelTotalLast As Double
Dim dblTmpSubTotalCur As Double, dblTmpSubTotalLast As Double, dblTmpMainTotalCur As Double, dblTmpMainTotalLast As Double, dblAmount As Double, dblLastAmount As Double
Dim strDebit As String, strCredit As String
Dim strCurrency As String

Const grdParticulars = 0
Const grdNoteNo = 1
Const grdDebit = 2
Const grdCredit = 3
Const grdCols = 4

    If Not crptMain Is Nothing Then
        Set crsBalanceRpt = crptMain
    End If
    sSql = "SELECT  PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.DerivedPeriodID AS DerivedPeriodID, " & _
           "        PER.ComparePeriodID AS ComparePeriodID, PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt " & _
           "FROM    Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
           "WHERE   PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mDerivedPeriodID = Val(.Fields("DerivedPeriodID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngAcTypePL = GetActualID(mCompanyID, cnstAcTypeProfitLoss)
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            If Val(.Fields("CompareStartDt") & "") = 0 Then
                lngComparedStartDt = Format(DateAdd("yyyy", -1, CDate(lngStartDt)), "#")
            Else
                lngComparedStartDt = Val(.Fields("CompareStartDt") & "")
            End If
            If Val(.Fields("CompareEndDt") & "") = 0 Then
                lngComparedEndDt = Format(DateAdd("yyyy", -1, CDate(lngEndDt)), "#")
            Else
                lngComparedEndDt = Val(.Fields("CompareEndDt") & "")
            End If
        End If
        .Close
    End With
    'Ref No: - 002 - 01/07/2009 -------
    sSql = "SELECT CM.CurrencyName AS CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            strCurrency = .Fields("CurrencyName") & ""
        End If
    End With
    With crsBalanceRpt
        If blnIsPreview Then
            If crptMain Is Nothing Then
                .StartReport pprA4, 1000, 1000, 1440 * 0.5, 1440 * 0.5, 0
            End If
            '--- Finding header data ----------------
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .CreateText strTmp, 1440, 1500, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            strTmp = GetApplicationData("BSheetRptStmtHead")
            strTmp = Replace(strTmp, "*D1*", Format(lngEndDt, "MMMM dd, yyyy"))
'            strTmp = Replace(strTmp, "*C1*", GetApplicationData("Currency", "Arab Emirates Dirhams"))
            strTmp = Replace(strTmp, "*C1*", strCurrency)
            .CreateText strTmp, 1440, 2200, 11000, 1000, , , , , , , , True, , , 12, "Times New Roman"
            .CreateLine 1440, 2800, 11200, 2800
        End If
        '--- Filling Table Data ---------------------
        .StartTable 1440, 2900, 10000, 10000, rptTTBalanceSheet
        .TableCols = grdCols: .TableRows = 1: Inc = 0

        .TableCell(rptTblRowHeight, Inc) = 350
        .TableCell(rptTblText, Inc, grdNoteNo) = "Note"
        '------ 20/12/07 ---
        .TableCell(rptTblIsBold, Inc, grdNoteNo) = False
        .TableCell(rptTblIsItalic, Inc, grdNoteNo) = False
        '------
        .TableCell(rptTblUnderline, Inc, grdNoteNo) = True
        strTmp = Format(lngEndDt, "MMMM dd, yyyy")
        .TableCell(rptTblText, Inc, grdDebit) = strTmp
        strTmp = Format(lngComparedEndDt, "MMMM dd, yyyy")
        .TableCell(rptTblText, Inc, grdCredit) = strTmp
        '------ 20/12/07 ---
        .TableCell(rptTblIsItalic, Inc, grdDebit) = False
        .TableCell(rptTblIsBold, Inc, grdDebit) = True
        '------
        .TableCell(rptTblUnderline, Inc, grdDebit) = True

        .TableCell(rptTblIsItalic, Inc, grdCredit) = False
        .TableCell(rptTblUnderline, Inc, grdCredit) = True
        .TableCell(rptTblIsBold, Inc, grdCredit) = False
        If Format(lngEndDt, "MMMM dd") = Format(lngComparedEndDt, "MMMM dd") Then
            .TableCell(rptTblRowHeight, Inc, grdNoteNo, , grdCredit) = 550
        Else
            .TableCell(rptTblRowHeight, Inc, grdNoteNo, , grdCredit) = 600
        End If
        sSql = "SELECT AcTypeID, AcTypeDescription, TrialOrder From AcTypes Where CompanyID = " & mCompanyID & " AND TreeLevel = 1 AND AcTypeID <> " & lngAcTypePL & " AND IsHidden = 0 ORDER BY TrialOrder"
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblRowHeight, Inc, grdParticulars, .TableRows - 1, grdCredit) = 270
            .TableCell(rptTblText, Inc, grdParticulars) = rsTmp.Fields("AcTypeDescription") & ""     'StrConv(rsTmp.Fields("AcTypeDescription") & "", vbProperCase)
            .TableCell(rptTblIsBold, Inc, grdParticulars) = True
            dblTmpMainTotalCur = 0: dblTmpMainTotalLast = 0
            dblLevelTotalThis = 0: dblLevelTotalLast = 0
            .TableRows = .TableRows + 1: Inc = Inc + 1
            sSql = "SELECT AcTypeID, AcTypeDescription, TrialOrder From AcTypes Where ParentAcTypeID = " & Val(rsTmp.Fields("AcTypeID") & "") & "  AND CompanyID = " & mCompanyID & " ORDER BY TrialOrder"
            Set rsTmp1 = GetRecords(sSql)
            While Not rsTmp1.EOF
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblText, Inc, grdParticulars) = rsTmp1.Fields("AcTypeDescription") & ""     'StrConv(rsTmp1.Fields("AcTypeDescription") & "", vbProperCase)
                .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                dblTmpSubTotalCur = 0: dblTmpSubTotalLast = 0
                sSql = "SELECT  AT.AcTypeID, AT.AcTypeDescription, AT.TypeNature, (SELECT SSB.NoteNo FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mPeriodID & ") AS NoteNo, (SELECT CASE WHEN SSB.CAmt < 0 THEN SSB.CAmt - SSB.DAmt ELSE SSB.DAmt - SSB.CAmt END FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mPeriodID & ") AS CurrentYr, (SELECT  CASE WHEN SSB.CAmt < 0 THEN SSB.CAmt - SSB.DAmt ELSE SSB.DAmt - SSB.CAmt END FROM SchedulesSubBalanceSheet SSB Where SSB.AcTypeID = AT.AcTypeID And " & _
                       "        SSB.PeriodID = " & mComparePeriodID & ") AS LastYr " & _
                       "From    AcTypes AT WHERE AT.ParentAcTypeID = " & Val(rsTmp1.Fields("AcTypeID") & "") & " ORDER BY AT.TrialOrder"
                Set rsTmp2 = GetRecords(sSql)
                While Not rsTmp2.EOF
                    If Val(rsTmp2.Fields("CurrentYr") & "") <> 0 Or Val(rsTmp2.Fields("LastYr") & "") <> 0 Then
                        .TableRows = .TableRows + 1: Inc = Inc + 1
                        .TableCell(rptTblRowHeight, Inc, grdParticulars, .TableRows - 1, grdCredit) = 270
                        .TableCell(rptTblText, Inc, grdParticulars) = rsTmp2.Fields("AcTypeDescription") & ""
                        .TableCell(rptTblIsBold, Inc, grdParticulars) = False
                        If rsTmp2.Fields("AcTypeDescription") = "Share capital" Then
                            .TableCell(rptTblText, Inc, grdNoteNo) = "1"
                            .TableCell(rptTblIsBold, Inc, grdNoteNo) = False
                        Else
                            .TableCell(rptTblText, Inc, grdNoteNo) = rsTmp2.Fields("NoteNo") & ""
                            .TableCell(rptTblIsBold, Inc, grdNoteNo) = False
                        End If
                        'Ref No: 001-30/06/09, Tuesday --------
                        If rsTmp2.Fields("AcTypeDescription") = "Obligation under finance lease" Then
                            .TableCell(rptTblText, Inc, grdParticulars) = "Obligation under finance lease - current portion"
                        End If
                        
                        strTmp = IIf(Val(rsTmp2.Fields("CurrentYr") & "") = 0, "-", Format(Abs(Val(rsTmp2.Fields("CurrentYr") & "")), "#,##,0"))
                        .TableCell(rptTblText, Inc, grdDebit) = IIf(Val(rsTmp2.Fields("CurrentYr") & "") < 0, "(" & strTmp & ")", strTmp)
                        .TableCell(rptTblIsBold, Inc, grdDebit) = True

                        strTmp = IIf(Val(rsTmp2.Fields("LastYr") & "") = 0, "-", Format(Abs(Val(rsTmp2.Fields("LastYr") & "")), "#,##,0"))
                        .TableCell(rptTblText, Inc, grdCredit) = IIf(Val(rsTmp2.Fields("LastYr") & "") < 0, "(" & strTmp & ")", strTmp)
                        .TableCell(rptTblIsBold, Inc, grdCredit) = False
 
                        dblTmpSubTotalCur = dblTmpSubTotalCur + Val(rsTmp2.Fields("CurrentYr") & "")
                        dblTmpSubTotalLast = dblTmpSubTotalLast + Val(rsTmp2.Fields("LastYr") & "")
                        dblTmpMainTotalCur = dblTmpMainTotalCur + Val(rsTmp2.Fields("CurrentYr") & "")
                        dblTmpMainTotalLast = dblTmpMainTotalLast + Val(rsTmp2.Fields("LastYr") & "")
                    End If
                    rsTmp2.MoveNext
                Wend
                rsTmp2.Close
                '---Total Sub Level----
                .TableRows = .TableRows + 1: Inc = Inc + 1
                .TableCell(rptTblRowHeight, Inc, grdParticulars, .TableRows - 1, grdCredit) = 270
                .TableCell(rptTblText, Inc, grdParticulars) = "Total " & StrConv(rsTmp1.Fields("AcTypeDescription") & "", vbLowerCase)
                .TableCell(rptTblIsBold, Inc, grdParticulars) = True
                
                strTmp = IIf(dblTmpSubTotalCur = 0, "-", Format(Abs(dblTmpSubTotalCur), "#,##,0"))
                .TableCell(rptTblText, Inc, grdDebit) = IIf(dblTmpSubTotalCur < 0, "(" & strTmp & ")", strTmp)
                .TableCell(rptTblIsBold, Inc, grdDebit) = True
                .TableCell(rptTblUnderline, Inc, grdDebit) = True
                .TableCell(rptTblUnderline, Inc - 1, grdDebit) = True
                dblLevelTotalThis = dblLevelTotalThis + dblTmpSubTotalCur

                strTmp = IIf(dblTmpSubTotalLast = 0, "-", Format(Abs(dblTmpSubTotalLast), "#,##,0"))
                .TableCell(rptTblText, Inc, grdCredit) = IIf(dblTmpSubTotalLast < 0, "(" & strTmp & ")", strTmp)
                .TableCell(rptTblIsBold, Inc, grdCredit) = False
                .TableCell(rptTblUnderline, Inc, grdCredit) = True
                .TableCell(rptTblUnderline, Inc - 1, grdCredit) = True
                dblLevelTotalLast = dblLevelTotalLast + dblTmpSubTotalLast
                lngLevelCount = lngLevelCount + 1
                .TableRows = .TableRows + 2: Inc = Inc + 2
                
                If lngLevelCount = 4 Then
                    .TableRows = .TableRows + 2: Inc = Inc + 2
                    .TableCell(rptTblRowHeight, Inc, grdParticulars, .TableRows - 1, grdCredit) = 270
                    .TableCell(rptTblText, Inc, grdParticulars) = "Total liabilities"
                    .TableCell(rptTblIsBold, Inc, grdParticulars) = True

                    strTmp = IIf(dblLevelTotalThis = 0, "-", Format(Abs(dblLevelTotalThis), "#,##,0"))
                    .TableCell(rptTblText, Inc, grdDebit) = IIf(dblLevelTotalThis < 0, "(" & strTmp & ")", strTmp)
                    .TableCell(rptTblIsBold, Inc, grdDebit) = True
                    .TableCell(rptTblUnderline, Inc, grdDebit) = True
                    .TableCell(rptTblUnderline, Inc - 1, grdDebit) = True

                    strTmp = IIf(dblLevelTotalLast = 0, "-", Format(Abs(dblLevelTotalLast), "#,##,0"))
                    .TableCell(rptTblText, Inc, grdCredit) = IIf(dblLevelTotalLast < 0, "(" & strTmp & ")", strTmp)
                    .TableCell(rptTblIsBold, Inc, grdCredit) = False
                    .TableCell(rptTblUnderline, Inc, grdCredit) = True
                    .TableCell(rptTblUnderline, Inc - 1, grdCredit) = True
                End If
                rsTmp1.MoveNext
            Wend
            rsTmp1.Close
            '---Total Main Level-------------
            .TableRows = .TableRows + 1: Inc = Inc + 1
            .TableCell(rptTblRowHeight, Inc, grdParticulars, .TableRows - 1, grdCredit) = 270
            .TableCell(rptTblText, Inc, grdParticulars) = "Total " & LCase(rsTmp.Fields("AcTypeDescription") & "")
            .TableCell(rptTblIsBold, Inc, grdParticulars) = True
            .TableCell(rptTblUnderline, Inc, grdDebit, Inc, grdCredit) = True
            
            strTmp = IIf(dblTmpMainTotalCur = 0, "-", Format(Abs(dblTmpMainTotalCur), "#,##,0"))
            .TableCell(rptTblText, Inc, grdDebit) = IIf(dblTmpMainTotalCur < 0, "(" & strTmp & ")", strTmp)
            .TableCell(rptTblIsBold, Inc, grdDebit) = True

            strTmp = IIf(dblTmpMainTotalLast = 0, "-", Format(Abs(dblTmpMainTotalLast), "#,##,0"))
            .TableCell(rptTblText, Inc, grdCredit) = IIf(dblTmpMainTotalLast < 0, "(" & strTmp & ")", strTmp)
            .TableCell(rptTblIsBold, Inc, grdCredit) = False
            .TableRows = .TableRows + 5: Inc = Inc + 5
            rsTmp.MoveNext
        Wend
        rsTmp.Close
        For Inc = 10 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings" Then
                strDebit = .TableCell(rptTblText, Inc, grdDebit)
                strCredit = .TableCell(rptTblText, Inc, grdCredit)
                If strDebit <> "-" And strCredit <> "-" Then
                    If strDebit > 0 And strCredit > 0 Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings"
                    End If
                    If strDebit > 0 And strCredit < 0 Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings/(accumulated deficit)"
                    End If
                    If strDebit < 0 And strCredit > 0 Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "(Accumulated deficit)/retained earnings"
                    End If
                    If strDebit < 0 And strCredit < 0 Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "Accumulated deficit"
                    End If
                    If strDebit > 0 And strCredit = 0 Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings"
                    End If
                    If strDebit > 0 And strCredit = "" Then
                        .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings"
                    End If
                Else
                    .TableCell(rptTblText, Inc, grdParticulars) = "Retained earnings"
                End If
            End If
        Next Inc

        For Inc = 1 To .TableRows - 1
            If .TableCell(rptTblText, Inc, grdParticulars) = "" And .TableCell(rptTblText, Inc, grdDebit, Inc, grdCredit) = "" Then
                .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdCredit) = 60
            End If
        Next Inc
        For Inc = 5 To .TableRows - 1
            If .TableCell(rptTblIsBold, Inc, grdParticulars) = True And .TableCell(rptTblUnderline, Inc, grdDebit, Inc, grdCredit) = True Then
                If .TableCell(rptTblText, Inc, grdParticulars) <> "" And .TableCell(rptTblText, Inc, grdDebit, Inc, grdCredit) = "-" Then
                    If .TableCell(rptTblIsBold, Inc - 1, grdParticulars) = True And .TableCell(rptTblText, Inc - 1, grdDebit, Inc - 1, grdCredit) = "" Then
                        .TableCell(rptTblRowHeight, Inc, grdParticulars, Inc, grdCredit) = 60
                        .TableCell(rptTblRowHeight, Inc - 1, grdParticulars, Inc - 1, grdCredit) = 60
                    End If
                End If
            End If
        Next Inc
        .TableCell(rptTblColWidth, , grdParticulars) = 5400
        .TableCell(rptTblColWidth, , grdNoteNo) = 700
        If mComparePeriodID <> 0 Then
            .TableCell(rptTblColWidth, , grdDebit) = 2000
            .TableCell(rptTblColWidth, , grdCredit) = 1800
        Else
            .TableCell(rptTblColWidth, , grdDebit) = 4000
            .TableCell(rptTblColWidth, , grdCredit) = 1
        End If
        .TableCell(rptTblAlignment, 0, grdParticulars, .TableRows - 1, grdParticulars) = taLeftMiddle
        .TableCell(rptTblAlignment, 0, grdNoteNo, .TableRows - 1, grdNoteNo) = taCenterMiddle
        .TableCell(rptTblAlignment, 0, grdDebit, .TableRows - 1, grdDebit) = taRightMiddle
        .TableCell(rptTblAlignment, 0, grdCredit, .TableRows - 1, grdCredit) = taRightMiddle

        .TableCell(rptTblFontName, 0, 0, .TableRows - 1, .TableCols - 1) = "Times New Roman"
        .TableCell(rptTblFontSize, 0, 0, .TableRows - 1, .TableCols - 1) = 11
        .EndTable
    End With
    If blnIsPreview Then
        If crptMain Is Nothing Then
            crsBalanceRpt.EndReport vpPreview
            crsBalanceRpt.Clear
            Set crsBalanceRpt = Nothing
        End If
    Else
        Set PrintBalanceSheet = crsBalanceRpt
    End If
Exit Function
Err_Exit:
    ShowError
End Function
