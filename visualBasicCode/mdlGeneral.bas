Attribute VB_Name = "mdlGeneral"
Option Explicit

Public pIsInFind As Boolean
Public pbSave As Boolean
Public plnDocID As Long

Public pcrsAllCompany As New clsRecordSet, pcrsAllPeriod As New clsRecordSet
'Voucher, Report and Search Type Selection Grid Constants
Private Const grdSLCTCode As Byte = 0
Private Const grdSLCTName As Byte = 1
Private Const grdSLCTID As Byte = 2

Public Const cnstCompanyModeCreate = 1
Public Const cnstCompanyModeModify = 2

Public Const cnstProcedureModeCreate = 1
Public Const cnstProcedureModeUpdate = 2

Public pActiveCompanyID As Long, pActivePeriodID As Long

Public pclrRestrictionColor As Long

'Status Constants For All Kind of Master Entries Including Voucher Master
Public Enum StatusConstants
    cnstStatusActive = 1
    cnstStatusInactive = 2
End Enum

Public Enum ServerTypes
    ServerTypeNone = 0
    ServerTypeAccess = 1
    ServerTypeSQLServer = 2
End Enum

Public ServerType As ServerTypes

'Object Constants
Public Enum ConsoleRootObjectConstants
    cnstObjectCompany = 1001
    cnstObjectAccountTypes = 1002
    cnstObjectAccountHeads = 1003
    cnstObjectPeriod = 1004
    cnstObjectBIN = 1005

    cnstObjectTrialBalance = 3001
    cnstObjectDataSheet = 3002
    cnstObjectJournal = 3003
    cnstObjectAccountLedger = 3004
    cnstObjectGeneralSchedule = 3005
    cnstObjectSplitSchedule = 3006
    cnstObjectFixedAssetSchedule = 3007
    cnstObjectShareHoldersEquity = 3008
    cnstObjectCashEquivalents = 3009
    cnstObjectContingentLiability = 3010
    cnstObjectCashFlow = 3011
    cnstObjectNoteNoCaption = 3012

    cnstObjectCollectDocuments = 5001
    cnstObjectCollectMultipleDocuments = 5003
    cnstObjectDocumentAttachment = 5002

    cnstObjectReportRptGenerator = 6001
    cnstObjectReportTBDetail = 6002
    cnstObjectReportBalanceSheet = 6003
    cnstObjectReportProfitAndLoss = 6004
    cnstObjectReportSchedules = 6005
    cnstObjectReportFixedAsset = 6006
    cnstObjectReportEquity = 6007
    cnstObjectReportJournal = 6008
    cnstObjectReportCashFlow = 6009
    cnstObjectReportReviews = 6010
    cnstObjectReportAuditReport = 6011
    cnstObjectReportMattersArising = 6012

    cnstObjectReviews = 7001
End Enum

Public Enum DocTypeConstants
    cnstDocTypeLeadsheet = 1
    cnstDocTypeScannedDocuments = 2
    cnstDocTypeProcedures = 3
End Enum

'Audit Type constants
Public Enum AuditTypeConstants
    cnstAuditTypeAnnual = 1
    cnstAuditTypeInterim = 2
    cnstAuditTypeQuarterim = 3
End Enum

Public Enum SearchMethods
    cnstSearchMethodNone = 0
    cnstSearchMethodInvisibleExecAndRetFirstResult = 1
    cnstSearchMethodInvisibleExecIfOneAndRetFirstResult = 2
End Enum

'Form type constants
Public Enum FormTypeConstants
    cnstFormTypeSearch = 1
    cnstFormTypeReport = 2
    cnstFormTypeVoucher = 3
End Enum

'Schedule type constants
Public Enum ScheduleTypeConstants
    cnstScheduleTypeGeneral = 1
    cnstScheduleTypeSplit = 2
    cnstScheduleTypeFixedAsset = 3
    cnstScheduleTypeEquity = 4
    cnstScheduleTypeCashEquivalents = 5
    cnstScheduleTypeContingentLiability = 6
End Enum

Public Const cnstAcTypeMaxCount = 300
Public Const cnstAcHeadMaxCount = 700
Public Const cnstEntryMaxCount = 300

Public Const cnstAuditInfoMaxCount = 1200

'Ref No: 067-08/02/09 ---------
Public Const cnstReviewMaxCount = 1250
Public Const cnstFilingLeadsheetRemarksMaxCount = 2200
Public Const cnstFilingProcedureRemarksMaxCount = 3100

Public Const cnstFilingBalSheetRemarksMaxCount = 100
Public Const cnstFilingIncomeRemarksMaxCount = 200
Public Const cnstFilingLiquidityRemarksMaxCount = 300
Public Const cnstFilingProfitabilityRemarksMaxCount = 400

Public Const cnstDocIDMaxCount = 650
Public Const cnstDocIDLocalMaxCount = 850

Public Const cnstDocLinkIDMaxCount = 1000
Public Const cnstDocLinkIDLocalMaxCount = 1100

Public Const cnstLeadSheetReviewsMaxCount = 800

'Constants for Search TypeGrps
Public Enum SearchTypeGroupConstants
    cnstSearchTypeGrpStatus = 1
    cnstSearchTypeGrpAuditType = 2
    cnstSearchTypeGrpPeriods = 3
    cnstSearchTypeGrpCompany = 4
    cnstSearchTypeGrpAccountHeads = 5
    cnstSearchTypeGrpAccountTypes = 6
    cnstSearchTypeGrpEntries = 7
    cnstSearchTypeGrpSubFilingSubSection = 8
    cnstSearchTypeGrpReports = 9
    cnstSearchTypeGrpProcedureType = 10
    cnstSearchTypeGrpProcedures = 11
    cnstSearchTypeGrpQuestions = 12
    cnstSearchTypeGrpCurrency = 13
    cnstSearchTypeGrpBank = 14
    cnstSearchTypeGrpNation = 15
    cnstSearchTypeGrpUserName = 16
    cnstSearchTypeGrpUserGroupName = 17
    cnstSearchTypeGrpUserGroups = 18
End Enum

Public Const cnstAcTypeShareHoldersEquity = 8
Public Const cnstAcTypeCashAndBankBalances = 9
Public Const cnstAcTypeTradeReceivables = 36
Public Const cnstAcTypeOtherReceivables = 40
Public Const cnstAcTypeDuefromRelated = 10
Public Const cnstAcTypeInventories = 11
'Public Const cnstAcTypeInvestments = 101
Public Const cnstAcTypeProperty = 12
Public Const cnstAcTypeIntangibleAssets = 52
Public Const cnstAcTypeTradePayables = 13
Public Const cnstAcTypeOtherPayables = 14
Public Const cnstAcTypeDuetoRelated = 15
Public Const cnstAcTypeBankBorrowings = 16
Public Const cnstAcTypeObligation = 17
'Public Const cnstAcTypeOtherLongTermLiablities = 19
Public Const cnstAcTypeProvisionforEmployees = 19
Public Const cnstAcTypeRevenue = 25
Public Const cnstAcTypeCostofSales = 26
Public Const cnstAcTypeOtherIncome = 27
Public Const cnstAcTypeOperatingExpenses = 97
Public Const cnstAcTypeNonOperatingExpenses = 98
Public Const cnstAcTypeLiabilitiesAndCommitments = 258
Public Const cnstAcTypeContingentLiability = 259
Public Const cnstAcTypeCapitalCommitments = 260

Public Const cnstAcTypeOtherFinancialAssets = 105
Public Const cnstAcTypeAdvanceAgainstAquisitionofLand = 106
Public Const cnstAcTypeInvestmentPropertiesheldforSale = 107
Public Const cnstAcTypeDevelopmentProperties = 108
Public Const cnstAcTypeAvailableforsalefinancialassets = 109
Public Const cnstAcTypeInvestmentsinSubsidiariesandJointVenture = 110
Public Const cnstAcTypeInvestmentProperties = 111
Public Const cnstAcTypeAdvancefromCustomers = 112

Public Const cnstAcTypeCurrentAssets = 4
Public Const cnstAcTypeCurrentLiability = 6
Public Const cnstAcTypeFinanceCost = 32

Public Const cnstAcTypeProfitLoss = 3
Public Const cnstAcTypePropertyPlantEquipment = 12
Public Const cnstAcTypeTrading = 99
Public Const cnstAcTypeOperatingExp = 97
Public Const cnstAcTypeNonOperatingExp = 98
Public Const cnstAcTypeOtherComprehensiveExp = 113

Public Const cnstAcTypeCurrentAssets1 = 117
Public Const cnstAcTypeCurrentAssets2 = 118
Public Const cnstAcTypeCurrentAssets3 = 119

Public Const cnstAcTypeNonCurrentAssets1 = 120
Public Const cnstAcTypeNonCurrentAssets2 = 121
Public Const cnstAcTypeNonCurrentAssets3 = 122

Public Const cnstAcTypeTradingInvestments = 133
Public Const cnstAcTypeDueFromRelatedNonCurrent = 134
Public Const cnstAcTypeSecuredUnsecuredloanCurrent = 135
Public Const cnstAdvancereceivedagainstdevelopmentproperties = 136
Public Const cnstAcTypeSecuredUnsecuredloanNonCurrent = 138

Public Const cnstAcTypePayabletosuppliers = 166
Public Const cnstAcTypePayableforsubcontractors = 167
Public Const cnstAcTypeAccruedpurchases = 168
Public Const cnstAcTypeBillspayable = 169
Public Const cnstAcTypeDuetocontractcustomers = 172
Public Const cnstAcTypeToshareholders = 178
Public Const cnstAcTypeToassociatesandsubsidiaries = 179
Public Const cnstAcTypeTootherrelatedparties = 180
Public Const cnstAcTypeRetensionpayablecurrent = 181
Public Const cnstAcTypeRetensionpayablenoncurrent = 182
Public Const cnstAcTypeCostofservice = 192
Public Const cnstAcTypeFinanceincome = 236
Public Const cnstAcTypeContractCost = 239

Public Const cnstAcTypeCurrentliability1 = 251
Public Const cnstAcTypeCurrentliability2 = 252
Public Const cnstAcTypeCurrentliability3 = 253

Public Const cnstAcTypeNonCurrentliability1 = 254
Public Const cnstAcTypeNonCurrentliability2 = 255
Public Const cnstAcTypeNonCurrentliability3 = 256

Public Const cnstUserGrpPartner = 1
Public Const cnstUserGrpManager = 2
Public Const cnstUserGrpAuditor = 3
Public Const cnstUserGrpAuditAssistant = 4

Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Function ShowFormInMDI(strFrmName As String, strFrmCaption As String, Optional lngCompanyID As Long = 0, Optional lngPeriodID As Long = 0) As Form
On Local Error Resume Next
Dim lngTabIndex As Long, strOwnerCompanyPeriod As String
Dim strCompanyName As String, strPeriodName As String, crsCompany As New clsRecordSet, crsPeriod As New clsRecordSet
    crsPeriod.BindRecordSet pcrsAllPeriod, "PeriodID|=|" & lngPeriodID
    If Not crsPeriod.EOF Then
        strPeriodName = crsPeriod.Fields("ShortName")
        lngCompanyID = Val(crsPeriod.Fields("CompanyID") & "")
    End If
    crsCompany.BindRecordSet pcrsAllCompany, "CompanyID|=|" & lngCompanyID
    If Not crsCompany.EOF Then
        strCompanyName = crsCompany.Fields("CompanyName")
    End If
    '--------------------------
    strOwnerCompanyPeriod = lngCompanyID & "|" & lngPeriodID
    strFrmName = strFrmName & ";" & strOwnerCompanyPeriod
    MDIFormMain.tabStrip.Tabs.Add , strFrmName, strFrmCaption
    MDIFormMain.tabStrip.Tabs(strFrmName).Caption = strFrmCaption
    MDIFormMain.tabStrip.Tabs(strFrmName).Selected = True
    MDIFormMain.tabStrip.Tabs(strFrmName).ToolTipText = strFrmCaption & " (" & strCompanyName & " - " & strPeriodName & ")"
    Set ShowFormInMDI = MDIFormMain.ShowActiveTabForm
End Function

Public Function ExtractDocument(rsDoc As ADODB.Recordset, strFieldName As String, strTempPath As String) As Boolean
On Local Error GoTo Exit_Exit
Dim strmTmp As New ADODB.Stream
    With rsDoc
        If Not .EOF Then
            If Not IsNull(.Fields(strFieldName)) Then
                strmTmp.Type = adTypeBinary
                strmTmp.Open
                strmTmp.Write .Fields(strFieldName)
                strmTmp.SaveToFile strTempPath, adSaveCreateNotExist
                strmTmp.Close
            End If
        End If
    End With
    ExtractDocument = True
Exit Function
Exit_Exit:
    ExtractDocument = False
End Function

Public Sub ShowError(Optional ByVal ErrMsg As String)
Dim TabName As String, IsClosed As Boolean
Dim i As Integer, lngErrNumber As Long
    If ErrMsg = "" Then ErrMsg = Err.Description
    lngErrNumber = Err.Number

    If InStr(1, UCase(ErrMsg), "UNIQUE KEY") > 0 Then
        TabName = ""
        IsClosed = True
        For i = 1 To Len(ErrMsg)
            If Mid(ErrMsg, i, 1) = "'" And IsClosed Then
                IsClosed = False
            ElseIf Mid(ErrMsg, i, 1) = "'" And Not IsClosed Then
                IsClosed = True
                Exit For
            Else
                If Not IsClosed Then TabName = TabName & Mid(ErrMsg, i, 1)
            End If
        Next i
        pMVE.MsgBox "This " & TabName & " Already Exists", , "AuditMate", msgCritical, True
    ElseIf InStr(1, UCase(ErrMsg), "COLUMN REFERENCE") > 0 Or InStr(1, UCase(ErrMsg), "TABLE REFERENCE") > 0 Then
        TabName = ""
        IsClosed = True
        For i = 1 To Len(ErrMsg)
            If Mid(ErrMsg, i, 1) = "_" And IsClosed Then
                IsClosed = False
            ElseIf Mid(ErrMsg, i, 1) = "_" And Not IsClosed Then
                IsClosed = True
                Exit For
            Else
                If Not IsClosed Then TabName = TabName & Mid(ErrMsg, i, 1)
            End If
        Next
        pMVE.MsgBox "Related Records existing.", , "AuditMate", msgCritical, True
    ElseIf InStr(1, UCase(ErrMsg), "UPDATE") > 0 Then
        TabName = ""
        IsClosed = True
        For i = Len(ErrMsg) To 1 Step -1
            If Mid(ErrMsg, i, 1) = "'" And IsClosed Then
                IsClosed = False
            ElseIf Mid(ErrMsg, i, 1) = "'" And Not IsClosed Then
                IsClosed = True
                Exit For
            Else
                If Not IsClosed Then TabName = Mid(ErrMsg, i, 1) & TabName
            End If
        Next
        pMVE.MsgBox "This " & TabName & " does not exists.", , "AuditMate", msgCritical, True
    ElseIf InStr(1, UCase(ErrMsg), "PRIMARY KEY") > 0 Then
        TabName = ""
        IsClosed = True
        For i = 1 To Len(ErrMsg)
            If Mid(ErrMsg, i, 1) = "_" And IsClosed Then
                IsClosed = False
            ElseIf Mid(ErrMsg, i, 1) = "'" And Not IsClosed Then
                IsClosed = True
                Exit For
            Else
                If Not IsClosed Then TabName = TabName & Mid(ErrMsg, i, 1)
            End If
        Next
        pMVE.MsgBox "This " & TabName & " Already Exists", , "AuditMate", msgCritical, True
    ElseIf InStr(1, UCase(ErrMsg), "COLUMN FOREIGN KEY") > 0 Then
        TabName = ""
        IsClosed = True
        For i = Len(ErrMsg) To 1 Step -1
            If Mid(ErrMsg, i, 1) = "'" And IsClosed Then
                IsClosed = False
            ElseIf Mid(ErrMsg, i, 1) = "'" And Not IsClosed Then
                IsClosed = True
                Exit For
            Else
                If Not IsClosed Then TabName = Mid(ErrMsg, i, 1) & TabName
            End If
        Next
        pMVE.MsgBox "This " & TabName & " Does Not Exist.", , "AuditMate", msgCritical, True
    Else
        pMVE.MsgBox lngErrNumber & " - " & ErrMsg, , "AuditMate", msgCritical, True
    
    End If
End Sub

Public Function SetComboList(Optional ByRef cmbCombo As ComboBox = Nothing, Optional ByRef strTableName As String = "", _
                             Optional ByVal lngDefault As Long = 0, Optional ByRef strOtherFieldValueOut As String, Optional Pattern As String = "", _
                             Optional ByVal blnIsAvoidDefaultLoading As Boolean = False, Optional Conn As ADODB.Connection = Nothing) As String
'Set Combo List According To The Table Name
On Local Error GoTo Err_Exit
Dim sSql As String, intIndex As Integer, strComboList As String, rsCollect As New clsRecordSet
Dim Inc As Long
    If Conn Is Nothing Then
        Set Conn = AdoConn
    End If
    strOtherFieldValueOut = ""
    If Not cmbCombo Is Nothing Then
        cmbCombo.Clear
    End If
    Select Case strTableName
    Case Else
        sSql = strTableName
    End Select
    rsCollect.BindRecords sSql, Conn
    With rsCollect
        While Not .EOF
            If strOtherFieldValueOut <> "" Then
                strOtherFieldValueOut = strOtherFieldValueOut & "|"
            End If
            For Inc = 0 To .Cols - 1
                Select Case .FieldName(Inc)
                Case "NameField", "IDField"
                Case Else
                    strOtherFieldValueOut = strOtherFieldValueOut & .Fields(Inc) & "#"
                End Select
            Next Inc
            strOtherFieldValueOut = strOtherFieldValueOut & .Fields("IDField") & "#"
            If Not cmbCombo Is Nothing Then
                intIndex = cmbCombo.ListCount
                cmbCombo.AddItem .Fields("NameField"), intIndex
                cmbCombo.ItemData(intIndex) = .Fields("IDField")
                If .Fields("IDField") = lngDefault Or cmbCombo.Text = "" And Not blnIsAvoidDefaultLoading Then
                    cmbCombo.ListIndex = intIndex
                End If
            End If
            strComboList = strComboList & "|#" & .Fields("IDField") & ";" & .Fields("NameField")
            .MoveNext
        Wend
        .Clear
    End With
    SetComboList = strComboList
Exit Function
Err_Exit:
    ShowError
End Function

Public Function GetPrivileges(SelectType As String, GrpID As Long, Optional CallingType As String = "", Optional CallingTypeID As Long = 0) As String
On Local Error GoTo Err_Exit
Dim sSql As String, strIds As String, frm As Form, lngTypeID As Long, rsCollect As New clsRecordSet
    Select Case SelectType
    Case "Voucher"
        If pIsSuperUser Then
            sSql = "SELECT VT.VchrTypeID AS ID FROM UserPrivileges VP INNER JOIN VchrTypes VT ON VP.VchrTypeGrpID = VT.VchrTypeGrpID " & _
                "Where (VT.VchrTypeGrpID = " & GrpID & ")"
        Else
            sSql = "SELECT VPA.VchrTypeID AS ID FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID " & _
                "Where (VPA.UserID = " & pUserID & ") And (VPA.AccessID Is Null) And (VPA.ValidationID Is Null) And (VPA.SearchTypeId Is Null) And (VT.VchrTypeGrpID = " & GrpID & ") " & _
                "Union " & _
                "SELECT VPA.VchrTypeID AS ID FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                "Where (VPA.AccessID Is Null) And (VPA.ValidationID Is Null) And (VPA.SearchTypeId Is Null) And (VT.VchrTypeGrpID = " & GrpID & ") And (VGS.UserID = " & pUserID & ") "
        End If
    Case "Search"
        Set frm = MDIFormMain.ActiveForm
        If pIsSuperUser Then
            sSql = "SELECT SearchTypeID AS ID, 0 AS IsBlocked FROM SearchTypes WHERE SearchTypeGrpID = " & GrpID
        Else
            If frm Is Nothing Or CallingType <> "" Then
                lngTypeID = CallingTypeID
                If CallingType = "Voucher" Then
                    sSql = "SELECT ID, SUM(IsBlocked) AS IsBlocked FROM (SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID " & _
                         "Where (VPA.UserID = " & pUserID & ") And (VPA.SearchTypeId Is Not Null) And (VPA.VchrTypeID = " & lngTypeID & ") " & _
                         "Union " & _
                         "SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                         "Where (VPA.SearchTypeId Is Not Null) And (VGS.UserID = " & pUserID & ") And (VPA.VchrTypeID = " & lngTypeID & ")) TmpTbl GROUP BY ID HAVING (SUM(IsBlocked) = 0)"
                ElseIf CallingType = "Report" Then
                    sSql = "SELECT ID, SUM(IsBlocked) AS IsBlocked FROM (SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN ReportTypes RT ON VPA.ReportTypeID = RT.ReportTypeID " & _
                         "Where (VPA.UserID = " & pUserID & ") And (VPA.SearchTypeId Is Not Null) And (VPA.ReportTypeID = " & lngTypeID & ") " & _
                         "Union " & _
                         "SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN ReportTypes RT ON VPA.ReportTypeID = RT.ReportTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                         "Where (VPA.SearchTypeId Is Not Null) And (VGS.UserID = " & pUserID & ") And (VPA.ReportTypeID = " & lngTypeID & ")) TmpTbl GROUP BY ID HAVING (SUM(IsBlocked) = 0)"
                End If
            Else
                If frm.Name = "frmVchrGeneral" Then
                    lngTypeID = frm.VchrTypeID
                    sSql = "SELECT ID, SUM(IsBlocked) AS IsBlocked FROM (SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID " & _
                         "Where (VPA.UserID = " & pUserID & ") And (VPA.SearchTypeId Is Not Null) And (VPA.VchrTypeID = " & lngTypeID & ") " & _
                         "Union " & _
                         "SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                         "Where (VPA.SearchTypeId Is Not Null) And (VGS.UserID = " & pUserID & ") And (VPA.VchrTypeID = " & lngTypeID & ")) TmpTbl GROUP BY ID HAVING (SUM(IsBlocked) = 0)"
                ElseIf frm.Name = "frmReportGeneral" Or frm.Name = "frmReportAnalyser" Then
                    lngTypeID = frm.ReportTypeID
                    sSql = "SELECT ID, SUM(IsBlocked) AS IsBlocked FROM (SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN ReportTypes RT ON VPA.ReportTypeID = RT.ReportTypeID " & _
                         "Where (VPA.UserID = " & pUserID & ") And (VPA.SearchTypeId Is Not Null) And (VPA.ReportTypeID = " & lngTypeID & ") " & _
                         "Union " & _
                         "SELECT VPA.SearchTypeID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN ReportTypes RT ON VPA.ReportTypeID = RT.ReportTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                         "Where (VPA.SearchTypeId Is Not Null) And (VGS.UserID = " & pUserID & ") And (VPA.ReportTypeID = " & lngTypeID & ")) TmpTbl GROUP BY ID HAVING (SUM(IsBlocked) = 0)"
                End If
            End If
        End If
    Case "Report"
        If pIsSuperUser Then
            sSql = "SELECT RT.ReportTypeID AS ID FROM UserPrivileges VP INNER JOIN ReportTypes RT ON VP.ReportTypeGrpID = RT.ReportTypeGrpID " & _
                   "Where (RT.ReportTypeGrpID = " & GrpID & ")"
        Else
            sSql = "SELECT VPA.ReportTypeID AS ID FROM UserPrivilegeAccess VPA INNER JOIN ReportTypes RT ON VPA.ReportTypeID = RT.ReportTypeID " & _
                   "Where (VPA.UserID = " & pUserID & ") And (VPA.AccessID Is Null) And (VPA.ValidationID Is Null) And (VPA.SearchTypeId Is Null) And (RT.ReportTypeGrpID = " & GrpID & ") " & _
                   "Union " & _
                   "SELECT VPS.ReportTypeID  AS ID FROM UserPrivilegeAccess VPS INNER JOIN UserGroupUsers VGS ON VPS.UserGrpID = VGS.UserGrpID INNER JOIN ReportTypes RT ON VPS.ReportTypeID = RT.ReportTypeID " & _
                   "WHERE (VPS.AccessID IS NULL) AND (VPS.ValidationID IS NULL) AND (VPS.SearchTypeID IS NULL) AND (VGS.UserID = " & pUserID & ") AND (RT.ReportTypeGrpID = " & GrpID & ")"
        End If
    Case "Validation"
        Set frm = MDIFormMain.ActiveForm
        If frm.Name = "frmVchrGeneral" Then
            lngTypeID = frm.VchrTypeID
            sSql = "SELECT ID, SUM(IsBlocked) AS IsBlocked FROM (SELECT VPA.ValidationID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID " & _
                   "Where (VPA.UserID = " & pUserID & ") And (VPA.ValidationID Is Not Null) And (VPA.VchrTypeID = " & lngTypeID & ") " & _
                "Union " & _
                "SELECT VPA.ValidationID AS ID, CONVERT(INT, VPA.IsBlocked) AS IsBlocked FROM UserPrivilegeAccess VPA INNER JOIN VchrTypes VT ON VPA.VchrTypeID = VT.VchrTypeID INNER JOIN UserGroupUsers VGS ON VPA.UserGrpID = VGS.UserGrpID " & _
                "Where (VPA.ValidationID Is Not Null) And (VGS.UserID = " & pUserID & ") And (VPA.VchrTypeID = " & lngTypeID & ")) TmpTbl GROUP BY ID HAVING (SUM(IsBlocked) = 0)"
        End If
    End Select
    If sSql <> "" Then
        rsCollect.BindRecords sSql, AdoConn
        With rsCollect
            strIds = " 0,"
            While Not .EOF
                strIds = strIds & .Fields("ID") & ","
                .MoveNext
            Wend
            .Clear
        End With
        strIds = Left(strIds, Len(strIds) - 1)
    End If
    GetPrivileges = strIds
Exit Function
Err_Exit:
    ShowError
End Function

Public Function GetComboBoundValue(ByRef cmbComboBox As ComboBox) As Long
On Local Error Resume Next
    With cmbComboBox
        GetComboBoundValue = .ItemData(.ListIndex)
    End With
End Function

Public Sub SetComboBoundValue(ByRef cmbComboBox As ComboBox, ByVal lngBoundValue As Long)
On Local Error Resume Next
Dim Inc As Long
    With cmbComboBox
        For Inc = 0 To .ListCount - 1
            If .ItemData(Inc) = lngBoundValue Then
                .ListIndex = Inc
            End If
        Next Inc
    End With
End Sub

Public Sub PutSlNo(ByRef vsfgDetails As VSFlexGrid, ByVal ColSlNo As Long, _
                   ByVal ColToCheck As Long, Optional ByVal ColSelection As Long = -1, _
                   Optional ByVal ColIsAggregateRow As Long = -1)
On Local Error Resume Next
Dim Inc As Long, lngSlNo As Long
Dim IsSlNo As Boolean, Inc1 As Long
    With vsfgDetails
        lngSlNo = 0
        For Inc = 1 To .Rows - 1
'            If .RowOutlineLevel(Inc) = 0 Then
'                .IsSubtotal(Inc) = True
'            Else
'                .IsSubtotal(Inc) = False
'            End If
            If .TextMatrix(Inc, ColToCheck) = "" Then
                IsSlNo = False
            Else
                IsSlNo = True
            End If
            If IsSlNo Then
                If ColSelection <> -1 Then
                    If .Cell(flexcpChecked, Inc, ColSelection) = flexNoCheckbox Then
                        IsSlNo = False
                        For Inc1 = .GetNodeRow(Inc, flexNTFirstChild) To .GetNodeRow(Inc, flexNTLastChild)
                            'Req No:162/07-01
                            If Inc1 > 0 And Not .ColHidden(ColSelection) Then
                                If .Cell(flexcpChecked, Inc1, ColSelection) = flexChecked Then
                                    IsSlNo = True
                                End If
                            Else
                                IsSlNo = True
                            End If
                        Next Inc1
                        If ColIsAggregateRow <> -1 Then
                            If .Cell(flexcpChecked, Inc, ColIsAggregateRow) = flexUnchecked Then
                                IsSlNo = True
                            End If
                        End If
                    Else
                        If .Cell(flexcpChecked, Inc, ColSelection) = flexUnchecked Then
                            IsSlNo = False
                        End If
                    End If
                End If
            End If
            If IsSlNo And .RowOutlineLevel(Inc) = 0 Then
                lngSlNo = lngSlNo + 1
                .TextMatrix(Inc, ColSlNo) = lngSlNo
            Else
                .TextMatrix(Inc, ColSlNo) = ""
            End If
        Next Inc
    End With
End Sub

Public Function GetNewColumnName(ByVal strColName As String) As String
Dim IncValues As Long, IsExitLoop As Boolean
Dim arrFields() As String, arrIndex As Long, sSql As String
    GetNewColumnName = strColName
    If strColName Like "GET_*" Then
        'get field name from another table
        strColName = Replace(strColName, "__", "_") 'If _Tmp Table Comes
        arrFields = Split(strColName, "_")
        For IncValues = 4 To 5
            IsExitLoop = False
            If UBound(arrFields) >= IncValues Then
                sSql = "SELECT " & arrFields(3) & " AS FieldName FROM [" & IIf(Left(arrFields(1), 3) = "tmp", "_", "") & arrFields(1) & "] WHERE " & arrFields(2) & " = '" & arrFields(IncValues) & "'"
                With GetRecords(sSql)
                    If Not .BOF Then
                        GetNewColumnName = .Fields("FieldName").Value & ""
                        IsExitLoop = True
                    End If
                    .Close
                End With
            Else
                IsExitLoop = True
            End If
            If IsExitLoop Then
                Exit For
            End If
        Next IncValues
    End If
End Function

Public Function RVal(ByVal vrntValue As Variant) As Double
On Local Error Resume Next
    vrntValue = Replace(vrntValue, "%", "")
    RVal = Val(Replace(vrntValue, ",", ""))
End Function

Public Function PrepareAndFind(SearchTypeGroup As SearchTypeGroupConstants, Optional Filter As String = "", Optional RetFields As String = "", Optional ResultCtrl As Control = Nothing, _
                               Optional fndCtrl As Control = Nothing, Optional Caption As String = "Default", Optional StartSearch As String, Optional Tabs As Byte = 0, Optional IsSelectable As Boolean = False, _
                               Optional strSelectionField As String = "", Optional ShowTools As Boolean = True, Optional SearchMethod As SearchMethods = cnstSearchMethodNone, _
                               Optional CallingType As String = "", Optional CallingTypeID As Long = 0, Optional strSelectedValues As String = "") As String
On Local Error Resume Next
Dim sSql As String, SearchType As String, Inc As Long
Dim SearchQuery As String, strOutputFields As String, strColWidth As String, strOrderFields As String
Dim strGroupFields As String, strSearchFields As String, strTypeName As String, lngSearchTypeId As Long
Dim LinkMenu As String, LinkForm As String, LinkField As String, LinkCaption As String
Dim frmSearch As New frmFind, cbnTmp As New clsCallByName
        If pIsInFind Then
'            Exit Function
        End If
        SearchType = SelectTypeID(cnstFormTypeSearch, SearchTypeGroup, "", "", , , CallingType, CallingTypeID)
        If SearchType = "-1" Then
            PrepareAndFind = "-1"
            Exit Function
        End If
        '------------------------------------------------
        sSql = "Select * From SearchTypeGroups Where SearchTypeGrpID = " & SearchTypeGroup
        With GetRecords(sSql)
            SearchQuery = .Fields("QryBody") & ""
            SearchQuery = "(" & SearchQuery & ") DERIVEDTBL "
            strGroupFields = .Fields("GroupFields") & ""
            LinkMenu = .Fields("LinkMenu") & ""
            LinkForm = .Fields("LinkForm") & ""
            LinkField = .Fields("LinkField") & ""
            LinkCaption = .Fields("LinkCaption") & ""
            .Close
        End With
        sSql = "Select * From SearchTypes Where SearchTypeID = " & Val(SearchType)
        With GetRecords(sSql)
            If IsSelectable Then
                'strOutputFields = " $SelectedValues$ AS Selected(800), "
                strOutputFields = " 0 AS Selected(800), "
            End If
            If Not .BOF Then
                strOutputFields = strOutputFields & .Fields("OutputFields") & ""
                strOrderFields = .Fields("OrderFields") & ""
                strTypeName = .Fields("SearchTypeName") & ""
                lngSearchTypeId = .Fields("SearchTypeID") & ""
                If .Fields("Filter") & "" <> "" Then
                    If Filter = "" Then
                        Filter = " WHERE " & .Fields("Filter") & ""
                    Else
                        Filter = Filter & " AND " & .Fields("Filter") & ""
                    End If
                    Filter = Replace(Filter, "$DefaultBranch$", pCllSystem("BranchID"))
                End If
            End If
            .Close
        End With
        '---Split Fields and ColWidths-------------------
        SplitFieldAndWidth strOutputFields, strSearchFields, strColWidth, "", "", "", ""
        SearchQuery = Replace(SearchQuery, "$Filter", Filter)
        '---Slot for User searching----------------------
        SearchQuery = SearchQuery & " @@ "
        '---Building Query-------------------------------
        SearchQuery = "SELECT " & strOutputFields & " FROM " & SearchQuery & strGroupFields & NullIf(strOrderFields, " Order By " & strOrderFields, False)
    If Caption <> "Default" Then
        strTypeName = Caption
    End If
    '---Calling Searching Form---------------------------
    pIsInFind = True
    PrepareAndFind = frmSearch.Find(SearchQuery, RetFields, strSearchFields, strColWidth, ResultCtrl, strTypeName, fndCtrl, StartSearch, lngSearchTypeId, IsSelectable, strSelectionField, ShowTools, LinkMenu, LinkForm, LinkField, LinkCaption, SearchMethod, strSelectedValues)
    If Not (fndCtrl Is Nothing) Then fndCtrl.SetFocus
    pIsInFind = False
    If PrepareAndFind <> "-1" Then
        If Not (ResultCtrl Is Nothing) Then
            If TypeOf ResultCtrl Is VSFlexGrid Then
                For Inc = 1 To Tabs
                    SendKeys "{Right}"
                Next
                ResultCtrl.SetFocus
            Else
                For Inc = 1 To Tabs
                    SendKeys "{TAB}"
                Next
            End If
        Else
            For Inc = 1 To Tabs
                SendKeys "{TAB}"
            Next
        End If
    Else
        ResultCtrl.SetFocus
    End If
End Function

Public Function SelectTypeID(ByVal FormType As FormTypeConstants, ByVal intGrpID As Integer, _
                             ByRef ostrCode As String, ByRef ostrName As String, Optional ByVal intTypeID As Integer = 0, _
                             Optional ByVal IsDefault As Boolean = False, Optional CallingType As String = "", Optional CallingTypeID As Long = 0) As Integer
On Local Error GoTo Err_Exit
Dim sSql As String, vsfgDetails As VSFlex8Ctl.VSFlexGrid, strCaption As String
Dim Inc As Long, lngRow As Long, strType As String, strPrevIDs As String, rsCollect As New clsRecordSet
Dim IsBranchChecking As Boolean
    IsBranchChecking = Not IIf(GetFromCollection(pCllSystem, "", "IsHandleBranchesInSameLocation") = "True", True, False)
    Select Case FormType
        Case cnstFormTypeReport
            strType = "Report"
            strPrevIDs = GetPrivileges(strType, Val(intGrpID), CallingType, CallingTypeID)
            sSql = "SELECT RT.ReportTypeID AS IDField, RT.ReportTypeName AS NameField, RT.ReportTypeCode AS CodeField, RTGRP.ReportTypeGrpName AS GrpNameField FROM ReportTypes RT, ReportTypeGroups RTGRP WHERE RT.ReportTypeGrpID = RTGRP.ReportTypeGrpID" & IIf(intTypeID <= 0, "", " AND RT.ReportTypeID = " & intTypeID) & IIf(intGrpID <= 0, "", " AND RT.ReportTypeID IN (" & strPrevIDs & ") AND RT.ReportTypeGrpID = " & intGrpID) & " ORDER BY RT.IsDefault DESC, RT.ReportTypeID, RT.ReportTypeName"
        Case cnstFormTypeSearch
            strType = "Search"
            'strPrevIDs = GetPrivileges(strType, Val(intGrpID), CallingType, CallingTypeID) & IIf(strPrevIDs = "", "", " AND ST.SearchTypeID In (" & strPrevIDs & ")")
            sSql = "SELECT ST.SearchTypeID AS IDField, ST.SearchTypeName AS NameField, ST.SearchTypeCode AS CodeField, STGRP.SearchTypeGrpName AS GrpNameField FROM SearchTypes ST, SearchTypeGroups STGRP WHERE ST.SearchTypeGrpID = STGRP.SearchTypeGrpID" & IIf(intTypeID <= 0, "", " AND ST.SearchTypeID = " & intTypeID) & IIf(intGrpID <= 0, "", " AND ST.SearchTypeGrpID = " & intGrpID) & IIf(strPrevIDs = "", "", " AND ST.SearchTypeID In (" & strPrevIDs & ")")
    End Select
    With frmSelect
        .Hide
        Set vsfgDetails = .vsfgDetails
    End With
    Inc = 0
    vsfgDetails.Rows = 1
    rsCollect.BindRecords sSql, AdoConn
    With rsCollect
        Do While Not .EOF
            Inc = Inc + 1
            vsfgDetails.Rows = Inc + 1
            vsfgDetails.TextMatrix(Inc, grdSLCTCode) = .Fields("CodeField")
            vsfgDetails.TextMatrix(Inc, grdSLCTID) = .Fields("IDField")
            vsfgDetails.TextMatrix(Inc, grdSLCTName) = .Fields("NameField")
            strCaption = .Fields("GrpNameField")
            If IsDefault Then
                Exit Do
            Else
                .MoveNext
            End If
        Loop
        .Clear
    End With
    With vsfgDetails
        Select Case .Rows
            Case 1
                lngRow = -1
                If pIsSuperUser Then
                    If pMVE.MsgBox("No valid " & strType & " type exists. Do you want to create new " & strType & " type now?", msgYesNo, "AuditMate", msgQuestion, True) Then
    '                    Select Case strType
    '                    Case "Voucher"
    '                        ShowForm "frmVchrTypes", "Voucher Types"
    '                    Case "Report"
    '                        ShowForm "frmReportDesigner", "Report Designer"
    '                    Case "Search"
    '                    End Select
                    End If
                Else
                    pMVE.MsgBox "You don't have enough privilege.", , "AuditMate", msgInformation
                End If
            Case 2
                lngRow = 1
            Case Else
                With frmSelect
                    .Caption = strCaption
                    Align frmSelect, 200
                    .Show
                    .Visible = True
                    .ZOrder vbBringToFront
                    While .Visible
                        DoEvents
                    Wend
                    lngRow = .SelectedRow
                End With
        End Select
        If lngRow = -1 Then
            SelectTypeID = -1
            ostrCode = ""
            ostrName = ""
        Else
            SelectTypeID = Val(.TextMatrix(lngRow, grdSLCTID))
            ostrCode = .TextMatrix(lngRow, grdSLCTCode)
            ostrName = .TextMatrix(lngRow, grdSLCTName)
        End If
    End With
    Unload frmSelect
Exit Function
Err_Exit:
    ShowError
End Function

Public Sub SplitFieldAndWidth(ByRef strOutputFields As String, ByRef strSearchFields As String, ByRef strColWidth As String, _
                              ByRef strShades As String, ByRef strTotal As String, ByRef strBalance As String, ByRef strFormat As String, _
                              Optional ByRef strAlign As String = "", Optional ByRef strForeColor As String = "", Optional ByRef strFontName As String = "", _
                              Optional ByRef strFontSize As String = "", Optional ByRef strFontBold As String = "", Optional ByRef strFontItalic As String = "", _
                              Optional ByRef strFontUnderline As String = "", Optional ByRef strLeft As String = "", Optional ByRef strTop As String = "", _
                              Optional ByRef strHeight As String = "")
On Local Error Resume Next
Dim Inc As Integer, strData() As String, tmpField As String, TmpWidth As String
Dim tmpStr As String, tmpSearch As String, strTmp As String
Dim lngPosStart As Long, lngPosLegth As Long, strAggFn As String
    strData = Split(strOutputFields, ",")
    
    'Getting Fields
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "<") <> 0 Then
            tmpStr = Right(tmpStr, Len(tmpStr) - InStr(1, tmpStr, "<"))
        End If
        If InStr(1, tmpStr, "(") = 0 Then
            tmpField = tmpField & tmpStr & ","
        Else
            If InStr(1, tmpStr, "@") <> 0 Then
                strAggFn = Left(tmpStr, InStr(1, tmpStr, "@") - 1)
                strAggFn = strAggFn & "(" & Mid(tmpStr, InStr(1, tmpStr, "@") + 1, InStr(1, UCase(tmpStr), "AS") - InStr(1, tmpStr, "@") - 1)
                strAggFn = strAggFn & ")"
                strAggFn = strAggFn & " " & Mid(tmpStr, InStr(1, UCase(tmpStr), "AS"))
                tmpStr = Left(strAggFn, InStr(1, strAggFn, "AS") + 1)
                strAggFn = Mid(strAggFn, InStr(1, strAggFn, "AS") + 2)
                tmpStr = tmpStr & Left(strAggFn, InStr(1, strAggFn, "(") - 1)
                tmpField = tmpField & tmpStr & ","
                tmpStr = "  "
            Else
                tmpField = tmpField & Left(tmpStr, InStr(1, tmpStr, "(") - 1) & ","
            End If
        End If
        
        If InStr(1, UCase(tmpStr), " AS ") = 0 Then
            If Trim(tmpStr) <> "" Then tmpSearch = tmpSearch & tmpStr & ","
        Else
            tmpSearch = tmpSearch & Left(tmpStr, InStr(1, UCase(tmpStr), " AS ") - 1) & ","
        End If
    Next Inc
    tmpField = Left(tmpField, Len(tmpField) - 1)
    strOutputFields = tmpField
    tmpSearch = Left(tmpSearch, Len(tmpSearch) - 1)
    strSearchFields = tmpSearch
    
    'Getting Col Widths
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(") = 0 Then
            TmpWidth = TmpWidth & "0,"
        Else
            lngPosStart = InStr(1, tmpStr, "(") + 1
            lngPosLegth = InStr(1, tmpStr, ")") - lngPosStart
            TmpWidth = TmpWidth & RVal(Mid(tmpStr, lngPosStart, lngPosLegth)) & ","
        End If
    Next Inc
    TmpWidth = Left(TmpWidth, Len(TmpWidth) - 1)
    strColWidth = TmpWidth
    
    'Getting Column Shades
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Sh") = 0 Then
            strTmp = strTmp & "0,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Sh") + 3
            lngPosLegth = InStr(1, tmpStr, "Sh)") - lngPosStart
            strTmp = strTmp & RVal(Mid(tmpStr, lngPosStart, lngPosLegth)) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strShades = strTmp
    
    'Getting Column Total
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(T") = 0 Then
            strTmp = strTmp & "0,"
        Else
            lngPosStart = InStr(1, tmpStr, "(T") + 2
            lngPosLegth = InStr(1, tmpStr, "T)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strTotal = strTmp
    
    'Getting Column Balance
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(B") = 0 Then
            strTmp = strTmp & "0,"
        Else
            lngPosStart = InStr(1, tmpStr, "(B") + 2
            lngPosLegth = InStr(1, tmpStr, "B)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strBalance = strTmp
    
    'Getting Column Format
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(F") = 0 Then
            strTmp = strTmp & "0,"
        Else
            lngPosStart = InStr(1, tmpStr, "(F") + 2
            lngPosLegth = InStr(1, tmpStr, "F)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFormat = strTmp
    
    'Getting Column Alignment
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Al") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Al") + 3
            lngPosLegth = InStr(1, tmpStr, "Al)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strAlign = strTmp
    
    'Getting Column Forecolor
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Cf") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Cf") + 3
            lngPosLegth = InStr(1, tmpStr, "Cf)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strForeColor = strTmp
    
    'Getting Column FontName
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Nn") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Nn") + 3
            lngPosLegth = InStr(1, tmpStr, "Nn)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFontName = strTmp
    
    'Getting Column FontSize
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Ns") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Ns") + 3
            lngPosLegth = InStr(1, tmpStr, "Ns)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFontSize = strTmp
    
    'Getting Column FontBold
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Nb") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Nb") + 3
            lngPosLegth = InStr(1, tmpStr, "Nb)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFontBold = strTmp
    
    'Getting Column FontItalic
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Ni") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Ni") + 3
            lngPosLegth = InStr(1, tmpStr, "Ni)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFontItalic = strTmp
    
    'Getting Column FontUnderline
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Nu") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Nu") + 3
            lngPosLegth = InStr(1, tmpStr, "Nu)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strFontUnderline = strTmp
    
    'Getting Column Left
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Lf") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Lf") + 3
            lngPosLegth = InStr(1, tmpStr, "Lf)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strLeft = strTmp
    
    'Getting Column Top
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(Up") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Up") + 3
            lngPosLegth = InStr(1, tmpStr, "Up)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strTop = strTmp
    
    'Getting Column Height
    strTmp = ""
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
         If InStr(1, tmpStr, "(Ht") = 0 Then
            strTmp = strTmp & "-1,"
        Else
            lngPosStart = InStr(1, tmpStr, "(Ht") + 3
            lngPosLegth = InStr(1, tmpStr, "Ht)") - lngPosStart
            strTmp = strTmp & Mid(tmpStr, lngPosStart, lngPosLegth) & ","
        End If
    Next Inc
    strTmp = Left(strTmp, Len(strTmp) - 1)
    strHeight = strTmp
End Sub

Public Function NullIf(Expression As String, IfFalse As String, Optional Validation As Boolean = True)
    If Validation Then
        NullIf = IIf(Trim(Expression) = "", IfFalse, Expression)
    Else
        NullIf = IIf(Trim(Expression) = "", Expression, IfFalse)
    End If
End Function

Public Sub WriteToCollection(ByRef Cll As Collection, ByVal Var As Variant, ByVal Key As String, Optional obj As Object = Nothing)
On Local Error Resume Next
    Cll.Remove Key
    If Not obj Is Nothing Then
        Cll.Add obj, Key
    Else
        Cll.Add Var, Key
    End If
End Sub

Public Function GetFromCollection(ByRef Cll As Collection, Optional Var As Variant = "", Optional Key As String = "", Optional obj As Object = Nothing) As String
On Local Error GoTo Err_Exit
    If Not obj Is Nothing Then
        If TypeOf obj Is clsGrid Then
            Set obj = Cll(Key)
        Else
            If UCase(Right(Key, 2)) = "ID" Then
                If TypeName(obj) = "Field" Then
                    If Val(Cll(Key)) = 0 Then
                        obj = Null
                    Else
                        obj = Cll(Key)
                    End If
                Else
                    obj.Tag = Cll(Key)
                End If
            Else
                obj = Cll(Key)
            End If
        End If
    Else
        If Var = "" Then
            GetFromCollection = Cll(Key)
            Var = Cll(Key)
        Else
            Var = Cll(Key)
        End If
    End If
Exit Function
Err_Exit:
    If Not obj Is Nothing Then
        If TypeOf obj Is clsGrid Then
            Set obj = Nothing
        Else
            If UCase(Right(Key, 2)) = "ID" Then
                If TypeName(obj) = "Field" Then
                    obj = ""
                Else
                    obj.Tag = ""
                End If
            Else
                obj = ""
            End If
        End If
    Else
        If Var = "" Then
            GetFromCollection = ""
        Else
            Var = ""
        End If
    End If
End Function

Public Sub ClearCollection(Cll As Collection, Optional Key As String)
On Local Error GoTo Err_Exit
Dim cllTmp As New Collection
    If Key <> "" Then
        Set Cll.Item(Key) = Nothing
    Else
        Set Cll = Nothing
        Set Cll = cllTmp
    End If
Exit Sub
Err_Exit:
    
End Sub

Public Sub ClearAllTextBoxes(ByRef frmForm As Form, Optional ByVal strExceptions As String = "")
Dim cntrlTmp As Control
    For Each cntrlTmp In frmForm
        If TypeName(cntrlTmp) = "TextBox" Then
            If Not strExceptions Like "*|" & cntrlTmp.Name & "|*" Then
                cntrlTmp.Tag = ""
                cntrlTmp.Text = ""
            End If
        End If
    Next cntrlTmp
End Sub

Public Sub TabNavigation(KeyCode As Integer, Shift As Integer, Optional Tabs As Integer = 1, Optional VchrForm As Form = Nothing)
On Local Error Resume Next
Dim Inc As Integer
    Select Case KeyCode
    Case vbKeyReturn
        If VchrForm Is Nothing Then
            If Shift = 0 Then
                For Inc = 1 To Tabs
                    SendKeys "{TAB}"
                Next Inc
            Else
                For Inc = 1 To Tabs
                    SendKeys "{TAB}+"
                Next Inc
            End If
        End If
    Case vbKeyDelete
        With MDIFormMain.ActiveForm
            If TypeName(.ActiveControl) = "TextBox" Then
                With .ActiveControl
                    If .Locked = True Then
                        .Text = ""
                        .Tag = ""
                    End If
                End With
            End If
        End With
    End Select
End Sub

Public Sub ButtonHandling(ByRef frmForm As Form, Optional ByVal strButtonKey As String = "", _
                          Optional ByVal varParameterShowOpen As Variant = 0, Optional ByVal IsClearAfterSaving As Variant = True)
'Handles Tool Bar Button Clicks
On Local Error Resume Next
Dim IsStartPosition As Boolean, IsFormClosed As Boolean, IsClear As Boolean, strTmp As String
    IsStartPosition = False
    IsFormClosed = False
    IsClear = True
    With frmForm
        'If Read Only Form Then Change Button Events
        If ButtonsReadOnlyHandling(frmForm) Then
            Select Case strButtonKey
                Case "Close"
                    MDIFormMain.CloseActiveTabForm
                Case "Open"
                 .ShowOpen varParameterShowOpen
            End Select
            Exit Sub
        End If
        'If Not Read Only
        .SetFocus
        .tbrCtrls.Enabled = False
        Select Case strButtonKey
        Case "New"
            If .IsNew Then
                IsStartPosition = True
                .EnableAll = False
                .IsNew = False
                .tbrCtrls.Buttons("New").Caption = "&New"
                .tbrCtrls.Buttons("Print").Enabled = False
            Else
                .EnableAll = True
                .IsNew = True
                .tbrCtrls.Buttons("New").Caption = "Cance&l"
            End If
        Case "Modify"
            .tbrCtrls.Buttons("New").Caption = "&New"
            If .IsModify Then
                IsStartPosition = True
                .EnableAll = False
                .IsModify = False
                .tbrCtrls.Buttons("Modify").Caption = "&Modify"
            Else
                .EnableAll = True
                .IsModify = True
                .tbrCtrls.Buttons("Modify").Caption = "Cance&l"
                .tbrCtrls.Buttons("New").Enabled = False
            End If
        Case "Close"
            If .IsNew Or .IsModify Then
                If pMVE.MsgBox("Are you sure to exit? You may lose unsaved data.", msgYesNo, "AuditMate", msgQuestion, True) Then
                    .IsNew = False
                    .IsModify = False
                    IsFormClosed = True
                End If
            Else
                IsFormClosed = True
            End If
        Case "Open"
            If .ShowOpen(varParameterShowOpen) Then
                .tbrCtrls.Buttons("Print").Enabled = True
                .tbrCtrls.Buttons("New").Enabled = True
                .tbrCtrls.Buttons("Modify").Enabled = True
                .tbrCtrls.Buttons("Delete").Enabled = True
                .tbrCtrls.Buttons("Status").Enabled = True
            End If
        Case "Copy"
            .Copy
        Case "Notes"
            .Notes .tbrCtrls, "Notes"
        Case "Preview"
            .Preview
        Case "Print"
            .PrintDoc
        Case "Help"
            .Help
        Case "Custom"
            .Custom
        Case "Delete"
            If .Delete Then
                IsStartPosition = True
            End If
        Case "Save"
            'If CheckValidation(frmForm, 1) Then
                If .Save Then
                    .IsNew = False
                    .IsModify = False
                    .EnableAll = False
                    .tbrCtrls.Buttons("Modify").Caption = "&Modify"
                    .tbrCtrls.Buttons("New").Caption = "&New"
                    .tbrCtrls.Buttons("Modify").Enabled = False
                    IsStartPosition = True
                    IsClear = IsClearAfterSaving
                End If
            'End If
        Case "TabsNavigationLeft"
            .TabsNavigation "Left"
        Case "TabsNavigationRight"
            .TabsNavigation "Right"
        Case ""
            IsStartPosition = True
        End Select
        .tbrCtrls.Enabled = True
        If Not .IsNew Then
            .tbrCtrls.Buttons("New").Caption = "&New"
        End If
        If Not .IsModify Then
            .tbrCtrls.Buttons("Modify").Caption = "&Modify"
        End If
        If IsFormClosed Then
            If .MDIChild = True Then
                MDIFormMain.CloseActiveTabForm
                Unload frmForm
            Else
                Unload frmForm
            End If
        Else
            .tbrCtrls.Buttons("Notes").Enabled = True
            .tbrCtrls.Buttons("Status").Enabled = True
            If .IsNew Or .IsModify Then
                .tbrCtrls.Buttons("Save").Enabled = True
                .tbrCtrls.Buttons("Print").Enabled = True
                .tbrCtrls.Buttons("Delete").Enabled = False
                .tbrCtrls.Buttons("Open").Enabled = False
                .tbrCtrls.Buttons("Copy").Enabled = True
                If .IsNew Then
                    .tbrCtrls.Buttons("Modify").Enabled = False
                Else
                    .tbrCtrls.Buttons("New").Enabled = False
                End If
            Else
                .tbrCtrls.Buttons("Copy").Enabled = False
                .tbrCtrls.Buttons("Save").Enabled = False
                .tbrCtrls.Buttons("Open").Enabled = True
            End If
            If IsStartPosition Then
                If IsClear Then
                    .ClearValues
                End If
                .EnableAll = False
                .tbrCtrls.Buttons("Delete").Enabled = False
                .tbrCtrls.Buttons("Print").Enabled = False
                .tbrCtrls.Buttons("Modify").Enabled = False
                .tbrCtrls.Buttons("New").Enabled = True
                .tbrCtrls.Buttons("Status").Enabled = False
            End If
            'User Access
            If .Name = "frmVchrGeneral" Then
                If .tbrCtrls.Buttons("New").Enabled Then
                    .tbrCtrls.Buttons("New").Enabled = .pCllUserAccess("IsAdd")
                End If
                If .tbrCtrls.Buttons("Modify").Enabled Then
                    .tbrCtrls.Buttons("Modify").Enabled = .pCllUserAccess("IsModify")
                    If DateValue(.dtpVchrDt) < DateValue(ServerDateTime) Then
                        .tbrCtrls.Buttons("Modify").Enabled = .pCllUserAccess("IsModifyPredatedEntry")
                    End If
                End If
                If .tbrCtrls.Buttons("Delete").Enabled Then
                    .tbrCtrls.Buttons("Delete").Enabled = .pCllUserAccess("IsDelete")
                    If DateValue(.dtpVchrDt) < DateValue(ServerDateTime) Then
                        .tbrCtrls.Buttons("Delete").Enabled = .pCllUserAccess("IsDeletePredatedEntry")
                    End If
                End If
                If .tbrNavigator.Buttons("Adjust").Enabled Then
                    .tbrNavigator.Buttons("Adjust").Enabled = .pCllUserAccess("IsAdjust")
                End If
                If .tbrCtrls.Buttons("Print").Enabled Then
                    .tbrCtrls.Buttons("Print").Enabled = .pCllUserAccess("IsPrint")
                End If
                If .tbrCtrls.Buttons("Print").ButtonMenus.Count > 0 And .tbrCtrls.Buttons("Print").Enabled Then
                    .tbrNavigator.Buttons("Options").ButtonMenus("Print").Enabled = True
                Else
                    .tbrNavigator.Buttons("Options").ButtonMenus("Print").Enabled = False
                    .tbrCtrls.Buttons("Print").Enabled = False
                End If
            ElseIf .Name = "frmTimeSheet" Then
                If .IsModify Then
                    .tbrNavigator.Buttons("Reallocate").Enabled = True
                Else
                    .tbrNavigator.Buttons("Reallocate").Enabled = False
                End If
            End If
        End If
        Err.Clear
    End With
End Sub

Public Function ButtonsReadOnlyHandling(ByRef frm As Form) As Boolean
On Local Error Resume Next
    ButtonsReadOnlyHandling = False
    With frm
        If .IsReadOnly Then
            If Err.Number = 0 Then
                .tbrCtrls.Buttons("New").Enabled = False
                .tbrCtrls.Buttons("Modify").Enabled = False
                .tbrCtrls.Buttons("Delete").Enabled = False
                .tbrCtrls.Buttons("Save").Enabled = True
                .EnableAll = False
                ButtonsReadOnlyHandling = True
            End If
        Else
            If Err.Number = 0 Then
                .tbrCtrls.Buttons("New").Enabled = (Not .IsNew And Not .IsModify)
            End If
        End If
    End With
End Function

Public Sub ButtonShortCuts(ByRef frmForm As Form, KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
Dim strKey As String, blnIsValidKey As Boolean
Static lngLastTime As Long
    strKey = ""
    blnIsValidKey = False
    Select Case KeyCode
    Case vbKeyControl, vbKeyShift, vbKeyMenu
        blnIsValidKey = False
    Case Else
        blnIsValidKey = True
    End Select
    If blnIsValidKey And GetTickCount() - lngLastTime > 400 Then
        lngLastTime = GetTickCount()
        With frmForm
            If vbCtrlMask = Shift Then
                Select Case KeyCode
                Case vbKeyN
                    If Not frmForm.IsNew Then
                        strKey = "New"
                    End If
                Case vbKeyO
                    strKey = "Open"
                Case vbKeyM
                    If Not frmForm.IsModify Then
                        strKey = "Modify"
                    End If
                Case vbKeyD
                    strKey = "Delete"
                Case vbKeyS
                    strKey = "Save"
                Case vbKeyF
                    strKey = "Find"
                Case vbKeyP
                    strKey = "Print"
                Case vbKeyL
                    If frmForm.IsNew Then
                        strKey = "New"
                    ElseIf frmForm.IsModify Then
                        strKey = "Modify"
                    End If
                Case vbKeyE
                    strKey = "Close"
                Case vbKeyLeft
                    strKey = "TabsNavigationLeft"
                Case vbKeyRight
                    strKey = "TabsNavigationRight"
                End Select
            End If
            If KeyCode = vbKeyF1 Then
                strKey = "Help"
            ElseIf KeyCode = vbKeyF3 Then
                strKey = "Find"
            End If
            If strKey <> "" Then
                If .tbrCtrls.Buttons(strKey).Enabled Then
                    ButtonHandling frmForm, strKey
                End If
            End If
        End With
    End If
End Sub

Public Sub ShowDatasheet(PeriodID As Long)
On Local Error GoTo Err_Exit
    ShowFormInMDI "frmTrialBalance", "Trial Balance", , PeriodID
Exit Sub
Err_Exit:

End Sub

Public Sub Anchor(Ctrl As Control, Optional lngLeft As Long = -1, Optional lngTop As Long = -1, Optional lngWidth As Long = -1, Optional lngHeight As Long = -1)
On Local Error Resume Next
    If lngLeft <> -1 Then
        Ctrl.Left = GetProportionalValue(lngLeft, False)
    End If
    If lngTop <> -1 Then
        Ctrl.Top = GetProportionalValue(lngTop)
    End If
    If lngWidth <> -1 Then
        Ctrl.Width = GetProportionalValue(lngWidth, False)
    End If
    If lngHeight <> -1 Then
        Ctrl.Height = GetProportionalValue(lngHeight)
    End If
End Sub

Public Function GetProportionalValue(lngFixedValue As Long, Optional IsHeight As Boolean = True, Optional lngFixedHeight As Long = 11700, Optional lngFixedWidth As Long = 19320) As Long
On Local Error GoTo Err_Exit
Dim lngCurHeight As Long, lngCurWidth As Long, lngTmp As Long, dblPer As Double
    lngCurHeight = MDIFormMain.Height: lngCurWidth = MDIFormMain.Width
    If IsHeight Then
        lngTmp = lngCurHeight - lngFixedHeight
        dblPer = (lngTmp * 100) / lngFixedHeight
        
        GetProportionalValue = lngFixedValue + ((lngFixedValue * dblPer) / 100)
    Else
        lngTmp = lngCurWidth - lngFixedWidth
        dblPer = (lngTmp * 100) / lngFixedWidth
        dblPer = dblPer * 1.02
        
        GetProportionalValue = lngFixedValue + ((lngFixedValue * dblPer) / 100)
    End If
Exit Function
Err_Exit:
    GetProportionalValue = lngFixedValue
End Function

Public Function GetActiveFormObject(strFrmName As String) As Form
On Local Error Resume Next
Dim frm As Form
    For Each frm In Forms
        If Trim(UCase(frm.Name)) = Trim(UCase(strFrmName)) Then
            Set GetActiveFormObject = frm
        End If
    Next
End Function

Public Sub ShowLedger(lngPeriodID As Long, Optional lngAcID As Long = -1)
On Local Error Resume Next
    ShowFormInMDI "frmLedger", "Ledger Entry", , lngPeriodID
    If lngAcID > 0 Then
        GetActiveFormObject("frmLedger").ShowSpecifiedLedger lngAcID
    End If
End Sub

Public Sub ShowJournal(lngPeriodID As Long, Optional lngEntryID As Long = -1)
On Local Error Resume Next
    ShowFormInMDI "frmJournalEntry", "Journal Entry", , lngPeriodID
    If lngEntryID > 0 Then
        GetActiveFormObject("frmJournalEntry").ShowSpecifiedJournal lngEntryID
    End If
End Sub

Public Sub ShowFile(strExt As String, strFileName As String, strDesc As String, lngQuestionID As Long, lngProcedureTypeID As Long, lngSubSectionID As Long)
On Local Error Resume Next
    ShowFormInMDI "frmShowInExcel", "Preview - " & strDesc
    If Trim(strFileName) <> "" And Trim(strExt) <> "" Then
       GetActiveFormObject("frmShowInExcel").ShowFile strExt, strFileName, strDesc, lngQuestionID, lngProcedureTypeID, lngSubSectionID
    End If
End Sub

Public Sub ShowDocument(Optional lngDocID As Long = -1)
On Local Error Resume Next
Dim frm As New frmDocumentCollect
    If lngDocID < 1 Then frm.Show
    frm.ShowSpecifiedDocument lngDocID
    frm.Show vbModal
End Sub

Public Sub ShowGeneralShedule(Optional lngPeriodID As Long = -1, Optional AcTypeID As Long = -1)
On Local Error Resume Next
    If lngPeriodID = -1 And pActivePeriodID = 0 Then Exit Sub
    If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & AcTypeID)) <> 3 Then Exit Sub
    If AcTypeID <> -1 Then
        ShowFormInMDI "frmGeneralSchedule", "General Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
        ButtonHandling GetActiveFormObject("frmGeneralSchedule"), "Open", AcTypeID
    End If
End Sub

Public Function GetSignedValue(dblValue As Double, strNature As String) As Double
On Local Error GoTo Err_Exit
Dim dblAmount As Double
    If strNature = "Debit" Then
        dblAmount = dblValue
    ElseIf strNature = "Credit" And dblValue < 0 Then
        dblAmount = Abs(dblValue)
    ElseIf strNature = "Credit" And dblValue > 0 Then
        dblAmount = Abs(dblValue) * -1
    End If
    GetSignedValue = dblAmount
Exit Function
Err_Exit:
    GetSignedValue = dblValue
End Function

Public Function GetTrialTypeValue(mPeriodID As Long, lngAcTypeID As Long) As Double
On Local Error GoTo Err_Exit
Dim sSql As String
    'sSql = "SELECT SUM(ESA.DAmt - ESA.CAmt) AS Amount FROM Entries ENT INNER JOIN " & _
            "       EntrySubAccounts ESA ON ENT.EntryID = ESA.EntryID INNER JOIN AcHeads ON ESA.AcID = AcHeads.AcID " & _
            "Where (AcHeads.AcTypeID = " & lngAcTypeID & ") And (ENT.PeriodID = " & mPeriodID & ")"
    sSql = "SELECT dbo.fn_GetAcTypeBal(" & lngAcTypeID & ", " & mPeriodID & ") AS Amount"
    With GetRecords(sSql)
        If .EOF Then
            GetTrialTypeValue = 0
        Else
            GetTrialTypeValue = Val(.Fields("Amount") & "")
        End If
        .Close
    End With
Exit Function
Err_Exit:
    GetTrialTypeValue = 0
End Function

Public Function GetActualID(mCompanyID As Long, lngID As Long, Optional IsAccounts As Boolean = False) As Double
On Local Error GoTo Err_Exit
Dim lngType As Long
    lngType = IIf(IsAccounts, cnstAcHeadMaxCount, cnstAcTypeMaxCount)
    GetActualID = (mCompanyID * lngType) + lngID
Exit Function
Err_Exit:
    GetActualID = 0
End Function

Public Sub RefreshAll()
    RefreshCompanyAndPeriod
End Sub

Public Sub RefreshCompanyAndPeriod()
On Local Error GoTo Err_Exit
Dim sSql As String
    sSql = "Select * from Companies"
    pcrsAllCompany.BindRecords sSql, AdoConn
    sSql = "Select * from Periods"
    pcrsAllPeriod.BindRecords sSql, AdoConn
Exit Sub
Err_Exit:
    ShowError "Error While Refreshing Company or Period Data. " & Err.Description
End Sub

Public Sub ShowSplitSchedule(Optional lngPeriodID As Long = -1, Optional AcTypeID As Long = -1)
On Local Error Resume Next
    If lngPeriodID = -1 And pActivePeriodID = 0 Then Exit Sub
    If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & AcTypeID)) <> 3 Then Exit Sub
    If Val(PickValue("AcTypes", "AllocationAcTypeID", "AcTypeID = " & AcTypeID)) > 0 Then
'    If AcTypeID <> -1 Then
        ShowFormInMDI "frmSplitSchedule", "Split Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
        ButtonHandling GetActiveFormObject("frmSplitSchedule"), "Open", AcTypeID
    Else
        ShowFormInMDI "frmSplitSchedule", "Split Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
    End If
End Sub

Public Sub ShowFixedAssetSchedule(Optional lngPeriodID As Long = -1, Optional AcTypeID As Long = -1)
On Local Error Resume Next
    If lngPeriodID = -1 And pActivePeriodID = 0 Then Exit Sub
    If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & AcTypeID)) <> 3 Then Exit Sub
    If Val(PickValue("AcTypes", "AccCostAcTypeID", "AcTypeID = " & AcTypeID)) > 0 Then
'    If AcTypeID <> -1 Then
        ShowFormInMDI "frmFixedAssetSchedule", "Fixed Asset Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
        ButtonHandling GetActiveFormObject("frmFixedAssetSchedule"), "Open", AcTypeID
    Else
        ShowFormInMDI "frmFixedAssetSchedule", "Fixed Asset Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
    End If
End Sub

Public Sub ShowEquitySchedule(Optional lngPeriodID As Long = -1, Optional AcTypeID As Long = -1)
On Local Error Resume Next
    If lngPeriodID = -1 And pActivePeriodID = 0 Then Exit Sub
    If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & AcTypeID)) <> 3 Then Exit Sub
    If AcTypeID <> -1 Then
        ShowFormInMDI "frmEquitySchedule", "Shareholder's Equity Schedule", , IIf(lngPeriodID = -1, pActivePeriodID, lngPeriodID)
        ButtonHandling GetActiveFormObject("frmEquitySchedule"), "Open", AcTypeID
    End If
End Sub

Public Sub ShowRelatedDocuments(lngSubSectionID As Long, lngPeriodID As Long, Optional IDType As String = "Nil", Optional lngID As Long = -1, Optional strDescription As String = "Nil", Optional strRemarks As String = "Nil")
On Local Error GoTo Err_Exit
    frmDocumentLinking.Show
    frmDocumentLinking.Hide
    GetActiveFormObject("frmDocumentLinking").ShowRelatedDocuments lngSubSectionID, lngPeriodID, IDType, lngID, strDescription, strRemarks
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowRelatedReviews(lngSubSectionID As Long, lngPeriodID As Long, Optional IDType As String = "Nil", Optional lngID As Long = -1)
On Local Error GoTo Err_Exit
    frmReview.Show
    frmReview.Hide
    GetActiveFormObject("frmReview").ShowRelatedReviews lngSubSectionID, lngPeriodID, IDType, lngID
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowDocumentLinks(lngLinkID As Long)
On Local Error GoTo Err_Exit
    frmDocumentLinking.Show
    frmDocumentLinking.Hide
    GetActiveFormObject("frmDocumentLinking").ShowDocumentLinks lngLinkID
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowReviewLinks(lngLinkID As Long)
On Local Error GoTo Err_Exit
    frmReview.Show
    frmReview.Hide
    GetActiveFormObject("frmReview").ShowReviewLinks lngLinkID
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ClearTempFiles(strWorkDirectory As String)
On Local Error Resume Next
Dim strFileName As String
    strFileName = Dir(strWorkDirectory, vbHidden)
    Do While strFileName <> ""
        Kill strWorkDirectory & strFileName
        strFileName = Dir
    Loop
End Sub

Public Sub DeleteTemporaryFiles()
On Local Error Resume Next
Dim strWorkDirectory As String
    strWorkDirectory = GetApplicationData("WorkDirectory")
    '----28-Oct-2008----
    If strWorkDirectory = "" Then
        Exit Sub
    End If
    If strWorkDirectory <> "" Then
        If Right(Trim(strWorkDirectory), 1) <> "\" Then
            strWorkDirectory = strWorkDirectory & "\"
        End If
    End If
    ClearTempFiles strWorkDirectory
End Sub

Public Function GetExtension(strFileName As String, Optional IsWithDot As Boolean = False) As String
On Local Error GoTo Err_Exit
Dim strTmp As String
    strTmp = StrReverse(strFileName)
    If InStr(1, strTmp, ".") <> 0 Then
        strTmp = Mid(strTmp, 1, InStr(1, strTmp, ".") - 1)
        strTmp = Left(StrReverse(strTmp), 10)
        If IsWithDot Then
            strTmp = "." & strTmp
        End If
    Else
        strTmp = ""
    End If
    GetExtension = strTmp
Exit Function
Err_Exit:
    GetExtension = ""
End Function

Public Sub ButtonHandlingNew(ByRef frmForm As Form, Optional ByVal strButtonKey As String = "")
On Local Error Resume Next
Dim IsStartPosition As Boolean, IsFormClosed As Boolean, IsClear As Boolean, strTmp As String
    IsStartPosition = False
    IsFormClosed = False
    With frmForm
        If ButtonsReadOnlyHandling(frmForm) Then
            Select Case strButtonKey
                Case "Close"
                    MDIFormMain.CloseActiveTabForm
            End Select
            Exit Sub
        End If
        'If Not Read Only
        .SetFocus
        .tbrCtrlsNew.Enabled = False
        Select Case strButtonKey
        Case "New"
            If .IsNewNew Then
                IsStartPosition = True
                .EnableAllNew = False
                .IsNewNew = False
                .tbrCtrlsNew.Buttons("New").Caption = "&New"
                .tbrCtrlsNew.Buttons("Print").Enabled = False
            Else
                .EnableAllNew = True
                .IsNewNew = True
                .tbrCtrlsNew.Buttons("New").Caption = "Cance&l"
            End If
        Case "Modify"
            .tbrCtrlsNew.Buttons("New").Caption = "&New"
            If .IsModifyNew Then
                IsStartPosition = True
                .EnableAllNew = False
                .IsModifyNew = False
                .tbrCtrlsNew.Buttons("Modify").Caption = "&Modify"
            Else
                .EnableAllNew = True
                .IsModifyNew = True
                .tbrCtrlsNew.Buttons("Modify").Caption = "Cance&l"
                .tbrCtrlsNew.Buttons("New").Enabled = False
            End If
        Case "Close"
            If .IsNewNew Or .IsModifyNew Then
                If pMVE.MsgBox("Are you sure to exit? You may lose unsaved data.", msgYesNo, "AuditMate", msgQuestion, True) Then
                    .IsNewNew = False
                    .IsModifyNew = False
                    IsFormClosed = True
                End If
            Else
                IsFormClosed = True
            End If
        Case "Save"
            If .SaveNew Then
                .IsNewNew = False
                .IsModifyNew = False
                .EnableAllNew = False
                .tbrCtrlsNew.Buttons("Modify").Caption = "&Modify"
                .tbrCtrlsNew.Buttons("New").Caption = "&New"
                .tbrCtrlsNew.Buttons("Modify").Enabled = False
                IsStartPosition = True
            End If
        Case ""
            IsStartPosition = True
        End Select
        .tbrCtrlsNew.Enabled = True
        If Not .IsNewNew Then
            .tbrCtrlsNew.Buttons("New").Caption = "&New"
        End If
        If Not .IsModifyNew Then
            .tbrCtrlsNew.Buttons("Modify").Caption = "&Modify"
        End If
        If IsFormClosed Then
            If .MDIChild = True Then
                MDIFormMain.CloseActiveTabForm
                Unload frmForm
            Else
                Unload frmForm
            End If
        Else
            If .IsNewNew Or .IsModifyNew Then
                .tbrCtrlsNew.Buttons("Save").Enabled = True
                If .IsNewNew Then
                    .tbrCtrlsNew.Buttons("Modify").Enabled = False
                Else
                    .tbrCtrlsNew.Buttons("New").Enabled = False
                End If
            Else
                .tbrCtrlsNew.Buttons("Save").Enabled = False
            End If
            If IsStartPosition Then
                If IsClear Then
                    .ClearValues
                End If
                .EnableAllNew = False
                .tbrCtrls.Buttons("Modify").Enabled = False
                .tbrCtrls.Buttons("New").Enabled = True
            End If
        End If
        Err.Clear
    End With
End Sub
