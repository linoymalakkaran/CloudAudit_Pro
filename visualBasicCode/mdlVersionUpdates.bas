Attribute VB_Name = "mdlVersionUpdates"
Option Explicit

Public Type TypeSearchTypeGroup
    SearchTypeGrpID As Long
    SearchTypeGrpName As String
    QryBody As String
    GroupFields As String
    KeyForm As String
    SearchFormName As String
    LinkMenu As String
    LinkForm As String
    LinkField As String
    LinkCaption As String
End Type

Public Type TypeSearchType
    SearchTypeId As Long
    SearchTypeName As String
    SearchTypeCode As String
    SearchTypeGrpID As Long
    OutputFields As String
    OrderFields As String
    Reserved As Boolean
    Description As String
    CreateDate As Date
    UpdateDate As Date
    CreateUserID As Long
    UpdateUserID As Long
    Filter As String
End Type

Dim mstrAddSql As String

Public Sub ReOrganiseData(Optional IsShowMessage As Boolean = True)
On Local Error Resume Next
    Screen.MousePointer = vbHourglass
    UpdateSearchTypeGroups
    UpdateSearchTypes
    UpdateObjectTypes
    UpdateAuditReportObjectTypes
    UpdateTableTypes
    UpdateReportTypes
    UpdateConsoleRootObjects
    UpdateApplicationData
    UpdateHelp
    UpdateReportTags
    UpdateFilingSection
    UpdateFilingSubSection
    fn_GetAcTypeBal
    UpdateAcTypes pActiveCompanyID
    UpdateDetachTables
    UpdateScheduleTypes
    UpdateUserAccess
    UpdateUserGroups
    UpdateAcHeads pActiveCompanyID
    '---Update Last Version----
    SetApplicationData "LastReOrganisedVersion", Val(Format(App.Major, "0000") & Format(App.Minor, "0000") & Format(App.Revision, "0000"))
    Screen.MousePointer = vbDefault
    If IsShowMessage Then pMVE.MsgBox "Re-Organizing of data completed successfully.", , "AuditMate", msgInformation, True
End Sub

Public Sub UpdateApplicationData()
    SetApplicationData "BSheetRptStmtHead", "Statement of Financial Position as at *D1*" & vbNewLine & "(In *C1*)"
    SetApplicationData "Currency", "Arab Emirates Dirhams"
    SetApplicationData "FixAssetStmtHead", "Notes to the Financial Statements" & vbNewLine & "*D1*"
    SetApplicationData "EquityStmtHead", "Statement of Changes in Shareholder's Equity" & vbNewLine & "*D1*"
    SetApplicationData "ProfitLossStmtHead", "Statement of Income *D1*"
    SetApplicationData "CashFlowStmtHead", "Statement of CashFlows" & vbNewLine & "*D1*"
    SetApplicationData "JournalEntryHead", "Statement of Journal Entries" & vbNewLine & "*D1*"
    SetApplicationData "Reviews", "Report of Reviews" & vbNewLine & "*D1*"
    SetApplicationData "AdjustmentJournal", "Statement of User Adjustment Entries" & vbNewLine & "*D1*"
    SetApplicationData "ErrorScheduleJournal", "Statement of Error Schedule Entries" & vbNewLine & "*D1*"
    SetApplicationData "MattersArising", "Report of Matters Arising" & vbNewLine & "*D1*"
    
    SetApplicationData "CheckOutPath", "D:\AuditMate\CheckOutdirectory"
    SetApplicationData "WorkDirectory", "D:\AuditMate\WorkDirectory"
    SetApplicationData "BackupPath", "D:\AuditMate\DataBase"
End Sub

Private Sub UpdateSearchTypeGroups()
On Local Error Resume Next
Dim arrSTGrp(1 To 18) As TypeSearchTypeGroup
Dim sSql As String, Inc As Long, lngTmpSearchTypeGrpID As Long
    With arrSTGrp(1)
        .SearchTypeGrpID = cnstSearchTypeGrpStatus
        .SearchTypeGrpName = "Status"
        .QryBody = "SELECT StatusName AS Name, StatusID AS XStatusID FROM Status $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(2)
        .SearchTypeGrpID = cnstSearchTypeGrpAuditType
        .SearchTypeGrpName = "Audit Type"
        .QryBody = "SELECT AuditTypeName AS Name, AuditTypeID AS XAuditTypeID FROM AuditType $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(3)
        .SearchTypeGrpID = cnstSearchTypeGrpPeriods
        .SearchTypeGrpName = "Periods"
        .QryBody = "SELECT PER.ShortName, PER.Description, Convert(Datetime,PER.StartDt-2,103) AS StartDt, Convert(DateTime,PER.EndDt-2,103) AS EndDt, AUT.AuditTypeName, PeriodID AS XPeriodID " & _
                   "FROM   Periods PER LEFT OUTER JOIN AuditType AUT ON PER.AuditTypeID = AUT.AuditTypeID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(4)
        .SearchTypeGrpID = cnstSearchTypeGrpCompany
        .SearchTypeGrpName = "Companies"
        .QryBody = "SELECT CMP.CompanyName AS Name, CMP.CompanyCode, CMP.CompanyShortName, CMP.JobCode, Status.StatusName, CMP.CompanyID AS XCompanyID " & _
                   "FROM   Companies CMP INNER JOIN Status ON CMP.StatusID = Status.StatusID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(5)
        .SearchTypeGrpID = cnstSearchTypeGrpAccountHeads
        .SearchTypeGrpName = "Account Heads"
        .QryBody = "SELECT AH.AcName AS Name, AH.AcCode, AT.AcTypeName, ST.StatusName, AH.TrialOrder, AH.AcID AS XAcID " & _
                   "FROM   AcHeads AH INNER JOIN Status ST ON AH.StatusID = ST.StatusID LEFT OUTER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(6)
        .SearchTypeGrpID = cnstSearchTypeGrpAccountTypes
        .SearchTypeGrpName = "Account Types"
        .QryBody = "SELECT AT.AcTypeName AS Name, AT.AcTypeCode, AT.AcTypeDescription, AT.ActualAcTypeID, AT.IsReserved, AT1.AcTypeName AS ParentAcTypeName, AT.AcTypeID AS XAcTypeID, AT.RefNo, ST.StatusName, " & _
                   "       AT.ParentAcTypeID AS XParentAcTypeID, AT.AccDepAcTypeID AS XAccDepAcTypeID, AT.AccCostAcTypeID AS XAccCostAcTypeID,  AT.DeductionAcTypeID AS XDeductionAcTypeID, AT.AllocationAcTypeID AS XAllocationAcTypeID " & _
                   "FROM   AcTypes AT INNER JOIN Status ST ON AT.StatusID = ST.StatusID LEFT OUTER JOIN AcTypes AT1 ON AT.ParentAcTypeID = AT1.AcTypeID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(7)
        .SearchTypeGrpID = cnstSearchTypeGrpEntries
        .SearchTypeGrpName = "Entries"
        .QryBody = "SELECT EM.RefNo, Convert(Datetime,EM.RefDt-2,103) AS RefDt, Status.StatusName, EM.EntryID AS XEntryID " & _
                   "FROM   Entries EM INNER JOIN Status ON EM.StatusID = Status.StatusID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(8)
        .SearchTypeGrpID = cnstSearchTypeGrpSubFilingSubSection
        .SearchTypeGrpName = "Sub Sections"
        .QryBody = "SELECT FSS.Description AS Name, FSS.RefNo, FS.Description AS Section, FSS.SubSectionID AS XSubSectionID " & _
                   "FROM   FilingSubSection FSS INNER JOIN FilingSections FS ON FSS.SectionID = FS.SectionID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(9)
        .SearchTypeGrpID = cnstSearchTypeGrpReports
        .SearchTypeGrpName = "Reports"
        .QryBody = "SELECT RPT.ReportID AS XReportID, RPT.ReportName AS XReportName, RPT.ReportName AS [Report], PRD.Description AS [Period], CMP.CompanyName AS [Company] FROM Companies CMP RIGHT OUTER JOIN Periods PRD ON CMP.CompanyID = PRD.CompanyID RIGHT OUTER JOIN Reports RPT ON PRD.PeriodID = RPT.PeriodID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(10)
        .SearchTypeGrpID = cnstSearchTypeGrpProcedureType
        .SearchTypeGrpName = "Procedure Types"
        .QryBody = "SELECT ProcedureTypeName AS Name, ProcedureTypeID AS XProcedureTypeID FROM ProcedureTypes $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(11)
        .SearchTypeGrpID = cnstSearchTypeGrpProcedures
        .SearchTypeGrpName = "Procedures"
        .QryBody = "SELECT ProcedureName AS Name, ProcedureID AS XProcedureID FROM Procedures $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(12)
        .SearchTypeGrpID = cnstSearchTypeGrpQuestions
        .SearchTypeGrpName = "Procedures"
        .QryBody = "SELECT  ProcedureTypes.ProcedureTypeName, ProcedureQuestions.QuestionID AS XQuestionID, ProcedureQuestions.ProcedureTypeID, " & _
                   "        ProcedureQuestions.QuestionCode, ProcedureQuestions.Question AS Question " & _
                   "FROM    ProcedureQuestions INNER JOIN ProcedureTypes ON ProcedureQuestions.ProcedureTypeID = ProcedureTypes.ProcedureTypeID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = "mnuProcedures"
        .LinkForm = "frmProcedure"
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(13)
        .SearchTypeGrpID = cnstSearchTypeGrpCurrency
        .SearchTypeGrpName = "Currency"
        .QryBody = "SELECT CurrencyName AS Name, CurrencyShortName AS ShortName, CurrencyID AS XCurrencyID FROM CurrencyMaster $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(14)
        .SearchTypeGrpID = cnstSearchTypeGrpBank
        .SearchTypeGrpName = "Bank"
        .QryBody = "SELECT BankName AS Name, BankID AS XBankID FROM BankMaster $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(15)
        .SearchTypeGrpID = cnstSearchTypeGrpNation
        .SearchTypeGrpName = "Nation"
        .QryBody = "SELECT NationName AS Name, NationID AS XNationID FROM Nations $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(16)
        .SearchTypeGrpID = cnstSearchTypeGrpUserName
        .SearchTypeGrpName = "UserName"
        .QryBody = "SELECT UserName AS Name, UserID AS XUserID FROM Users $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(17)
        .SearchTypeGrpID = cnstSearchTypeGrpUserGroupName
        .SearchTypeGrpName = "UserGroupName"
        .QryBody = "SELECT Users.UserName AS Name, Users.UserID AS XUserID " & _
                   "FROM   Users INNER JOIN UserGroupUsers ON Users.UserID = UserGroupUsers.UserID INNER JOIN " & _
                   "       UserGroups ON UserGroupUsers.UserGroupID = UserGroups.UserGroupID $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    With arrSTGrp(18)
        .SearchTypeGrpID = cnstSearchTypeGrpUserGroups
        .SearchTypeGrpName = "UserGroups"
        .QryBody = "SELECT UserGroups.UserGroupName AS Name, UserGroups.UserGroupID AS XUserID " & _
                   "FROM   UserGroups $Filter"
        .GroupFields = ""
        .KeyForm = ""
        .SearchFormName = "frmFind"
        .LinkMenu = ""
        .LinkForm = ""
        .LinkField = ""
        .LinkCaption = ""
    End With
    sSql = "SELECT * FROM SearchTypeGroups ORDER BY SearchTypeGrpID"
    With GetRecords(sSql)
        For Inc = 1 To UBound(arrSTGrp)
            If .EOF Or .BOF Then
                lngTmpSearchTypeGrpID = -1
            Else
                lngTmpSearchTypeGrpID = !SearchTypeGrpID
            End If
            If arrSTGrp(Inc).SearchTypeGrpID <> 0 Then
                If arrSTGrp(Inc).SearchTypeGrpID <> lngTmpSearchTypeGrpID Then
                    .AddNew
                End If
                !SearchTypeGrpID = IIf(arrSTGrp(Inc).SearchTypeGrpID = "-1", Null, arrSTGrp(Inc).SearchTypeGrpID)
                !SearchTypeGrpName = IIf(arrSTGrp(Inc).SearchTypeGrpName = "-1", Null, arrSTGrp(Inc).SearchTypeGrpName)
                !QryBody = IIf(arrSTGrp(Inc).QryBody = "-1", Null, arrSTGrp(Inc).QryBody)
                !GroupFields = IIf(arrSTGrp(Inc).GroupFields = "-1", Null, arrSTGrp(Inc).GroupFields)
                !KeyForm = IIf(arrSTGrp(Inc).KeyForm = "-1", Null, arrSTGrp(Inc).KeyForm)
                !SearchFormName = arrSTGrp(Inc).SearchFormName
                !LinkMenu = arrSTGrp(Inc).LinkMenu
                !LinkForm = arrSTGrp(Inc).LinkForm
                !LinkField = arrSTGrp(Inc).LinkField
                !LinkCaption = arrSTGrp(Inc).LinkCaption
                .Update
            End If
            .MoveNext
        Next Inc
        .Close
    End With
End Sub

Private Sub UpdateSearchTypes()
On Local Error Resume Next
Dim arrST(1 To 18) As TypeSearchType, mblnIsBarCode As Boolean
Dim sSql As String, Inc As Long, lngTmpSearchTypeID As Long
    With arrST(1)
        .SearchTypeId = 1
        .SearchTypeName = "Status"
        .SearchTypeCode = "1"
        .SearchTypeGrpID = cnstSearchTypeGrpStatus
        .OutputFields = "Name AS Name(6000), XStatusID AS XStatusID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(2)
        .SearchTypeId = 2
        .SearchTypeName = "Audit Type"
        .SearchTypeCode = "2"
        .SearchTypeGrpID = cnstSearchTypeGrpAuditType
        .OutputFields = "Name AS Name(6000), XAuditTypeID AS XAuditTypeID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(3)
        .SearchTypeId = 3
        .SearchTypeName = "Periods"
        .SearchTypeCode = "3"
        .SearchTypeGrpID = cnstSearchTypeGrpPeriods
        .OutputFields = "ShortName AS ShortName(2000), Description AS Description(3000), StartDt AS StartDt(1500), EndDt AS EndDt(1500), XPeriodID AS XPeriodID"
        .OrderFields = "StartDt"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(4)
        .SearchTypeId = 4
        .SearchTypeName = "Companies"
        .SearchTypeCode = "4"
        .SearchTypeGrpID = cnstSearchTypeGrpCompany
        .OutputFields = "Name AS Name(3000), CompanyCode AS CompanyCode(1000), CompanyShortName AS CompanyShortName(1500), JobCode AS JobCode(1500), StatusName AS StatusName(1500), XCompanyID AS XCompanyID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(5)
        .SearchTypeId = 5
        .SearchTypeName = "Account Heads"
        .SearchTypeCode = "5"
        .SearchTypeGrpID = cnstSearchTypeGrpAccountHeads
        .OutputFields = "Name AS Name(3000), AcCode AS Code(1000), AcTypeName AS [Account Type](2000), StatusName AS Status(1500), XAcID AS XAcID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(6)
        .SearchTypeId = 6
        .SearchTypeName = "Account Types"
        .SearchTypeCode = "6"
        .SearchTypeGrpID = cnstSearchTypeGrpAccountTypes
        .OutputFields = "Name AS Name(3000), AcTypeCode AS Code(1000), AcTypeDescription AS Description(3000), ParentAcTypeName  AS Parent(2000), IsReserved AS Reserved(2000), StatusName AS Status(1500), XAcTypeID AS XAcTypeID, XParentAcTypeID AS XParentAcTypeID, XAccDepAcTypeID AS XAccDepAcTypeID, XAccCostAcTypeID AS XAccCostAcTypeID,  XDeductionAcTypeID AS XDeductionAcTypeID, XAllocationAcTypeID AS XAllocationAcTypeID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(7)
        .SearchTypeId = 7
        .SearchTypeName = "Entries"
        .SearchTypeCode = "1"
        .SearchTypeGrpID = cnstSearchTypeGrpEntries
        .OutputFields = "RefNo AS [Ref No](3000), RefDt AS [Ref Date](2000), StatusName AS Status(1500), XEntryID AS XEntryID"
        .OrderFields = "RefDt, RefNo"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(8)
        .SearchTypeId = 8
        .SearchTypeName = "Sub Section"
        .SearchTypeCode = "8"
        .SearchTypeGrpID = cnstSearchTypeGrpSubFilingSubSection
        .OutputFields = "Name AS Name(3000), RefNo AS [Ref No](1000), Section AS [Section](1500), XSubSectionID AS XSubSectionID"
        .OrderFields = "Name, RefNo,Section"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(9)
        .SearchTypeId = 9
        .SearchTypeName = "Reports"
        .SearchTypeCode = "9"
        .SearchTypeGrpID = cnstSearchTypeGrpReports
        .OutputFields = "XReportID AS XReportID, XReportName AS XReportName, [Report] AS [Report](2000), [Period] AS [Period](2000), [Company] AS [Company](2000)"
        .OrderFields = "XReportName"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(10)
        .SearchTypeId = 10
        .SearchTypeName = "Procedure Type"
        .SearchTypeCode = "10"
        .SearchTypeGrpID = cnstSearchTypeGrpProcedureType
        .OutputFields = "Name AS Name(6000), XProcedureTypeID AS XProcedureTypeID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(11)
        .SearchTypeId = 11
        .SearchTypeName = "Procedures"
        .SearchTypeCode = "10"
        .SearchTypeGrpID = cnstSearchTypeGrpProcedures
        .OutputFields = "Name AS Name(6000), XProcedureID AS XProcedureID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(12)
        .SearchTypeId = 12
        .SearchTypeName = "Questions"
        .SearchTypeCode = "12"
        .SearchTypeGrpID = cnstSearchTypeGrpQuestions
        .OutputFields = "QuestionCode AS [QuestionCode](1500), Question AS [Question](6000), ProcedureTypeName AS [Procedure Type](3000), XQuestionID AS XQuestionID"
        .OrderFields = "QuestionCode"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(13)
        .SearchTypeId = 13
        .SearchTypeName = "Currency"
        .SearchTypeCode = "13"
        .SearchTypeGrpID = cnstSearchTypeGrpCurrency
        .OutputFields = "Name AS [Name](6000), ShortName AS [Short Name](1000), XCurrencyID AS XCurrencyID"
        .OrderFields = ""
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(14)
        .SearchTypeId = 14
        .SearchTypeName = "Bank"
        .SearchTypeCode = "14"
        .SearchTypeGrpID = cnstSearchTypeGrpBank
        .OutputFields = "Name AS [Name](6000), XBankID AS XBankID"
        .OrderFields = ""
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(15)
        .SearchTypeId = 15
        .SearchTypeName = "Nation"
        .SearchTypeCode = "15"
        .SearchTypeGrpID = cnstSearchTypeGrpNation
        .OutputFields = "Name AS [Name](6000), XNationID AS XNationID"
        .OrderFields = ""
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(16)
        .SearchTypeId = 16
        .SearchTypeName = "UserName"
        .SearchTypeCode = "16"
        .SearchTypeGrpID = cnstSearchTypeGrpUserName
        .OutputFields = "Name AS [Name](6000), XUserID AS XUserID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(17)
        .SearchTypeId = 17
        .SearchTypeName = "UserGroupName"
        .SearchTypeCode = "17"
        .SearchTypeGrpID = cnstSearchTypeGrpUserGroupName
        .OutputFields = "Name AS [Name](6000), XUserID AS XUserID"
        .OrderFields = "Name"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    With arrST(17)
        .SearchTypeId = 18
        .SearchTypeName = "UserGroups"
        .SearchTypeCode = "18"
        .SearchTypeGrpID = cnstSearchTypeGrpUserGroups
        .OutputFields = "Name AS [Name](6000), XUserID AS XUserID"
        .OrderFields = "XUserID"
        .Reserved = 1
        .Description = ""
        .CreateDate = CDate("01/01/2006")
        .UpdateDate = CDate("01/01/2006")
        .CreateUserID = 1
        .UpdateUserID = 1
        .Filter = ""
    End With
    For Inc = 1 To UBound(arrST)
        sSql = "SELECT * FROM SearchTypes WHERE SearchTypeID = " & arrST(Inc).SearchTypeId
        With GetRecords(sSql)
            If .BOF Then
                .AddNew
                !SearchTypeId = arrST(Inc).SearchTypeId
            End If
            !SearchTypeName = IIf(arrST(Inc).SearchTypeName = "-1", Null, arrST(Inc).SearchTypeName)
            !SearchTypeCode = IIf(arrST(Inc).SearchTypeCode = "-1", Null, arrST(Inc).SearchTypeCode)
            !SearchTypeGrpID = IIf(arrST(Inc).SearchTypeGrpID = "-1", Null, arrST(Inc).SearchTypeGrpID)
            !OutputFields = IIf(arrST(Inc).OutputFields = "-1", Null, arrST(Inc).OutputFields)
            !OrderFields = arrST(Inc).OrderFields
            !Reserved = arrST(Inc).Reserved
            !Description = arrST(Inc).Description
            !CreateDate = arrST(Inc).CreateDate
            !UpdateDate = arrST(Inc).UpdateDate
            !CreateUserID = arrST(Inc).CreateUserID
            !UpdateUserID = arrST(Inc).UpdateUserID
            !Filter = arrST(Inc).Filter
            .Update
            .Close
        End With
    Next Inc
End Sub

Public Function AcTypes(ByVal CompanyID, ByVal AcTypeID, ByVal AcTypeName, ByVal AcTypeCode, ByVal ParentAcTypeID, ByVal IsReserved, ByVal RefNo, _
                        ByVal AccDepAcTypeID, ByVal AccCostAcTypeID, ByVal DeductionAcTypeID, ByVal AllocationAcTypeID, ByVal TreeLevel, ByVal TrialOrder, _
                        ByVal TypeNature, ByVal EquityType, ByVal StatusID, ByVal CreateDate, ByVal UpdateDate, ByVal CreateUser, ByVal UpdateUser, _
                        ByVal IsFixedAssetParent, ByVal IsHidden, ByVal AcTypeDescription, ByVal ActualAcTypeID) As Boolean
On Local Error Resume Next
Dim sSql As String, lngPrefix As Long, tmpAcTypeID As Long
    lngPrefix = CompanyID * cnstAcTypeMaxCount
    tmpAcTypeID = lngPrefix + AcTypeID
    
        With GetRecords("Select * from AcTypes Where AcTypeID = " & tmpAcTypeID)
            If .EOF Then
                .AddNew
                !AcTypeID = tmpAcTypeID
            End If
            !CompanyID = IIf(CompanyID = -1, Null, CompanyID)
            !AcTypeName = IIf(AcTypeName = -1, Null, AcTypeName)
            !AcTypeCode = IIf(AcTypeCode = -1, Null, AcTypeCode)
            !ParentAcTypeID = IIf(ParentAcTypeID = -1, Null, lngPrefix + ParentAcTypeID)
            !IsReserved = IIf(IsReserved = -1, Null, IsReserved)
            !RefNo = IIf(RefNo = -1, Null, RefNo)
            !AccDepAcTypeID = IIf(AccDepAcTypeID = -1, Null, AccDepAcTypeID + lngPrefix)
            !AccDepAcTypeID = IIf(!AccDepAcTypeID = 0, Null, !AccDepAcTypeID)

            !AccCostAcTypeID = IIf(AccCostAcTypeID = -1, Null, AccCostAcTypeID + lngPrefix)
            !AccCostAcTypeID = IIf(!AccCostAcTypeID = 0, Null, !AccCostAcTypeID)

            !DeductionAcTypeID = IIf(DeductionAcTypeID = -1, Null, DeductionAcTypeID + lngPrefix)
            !DeductionAcTypeID = IIf(!DeductionAcTypeID = 0, Null, !DeductionAcTypeID)

            !AllocationAcTypeID = IIf(AllocationAcTypeID = -1, Null, AllocationAcTypeID + lngPrefix)
            !AllocationAcTypeID = IIf(!AllocationAcTypeID = 0, Null, !AllocationAcTypeID)

            !TreeLevel = IIf(TreeLevel = -1, Null, TreeLevel)
            !TrialOrder = IIf(TrialOrder = -1, Null, TrialOrder)
            !TypeNature = IIf(TypeNature = -1, Null, TypeNature)
            !EquityType = IIf(EquityType = -1, Null, EquityType)
            !StatusID = IIf(StatusID = -1, Null, StatusID)
            !CreateDate = IIf(CreateDate = -1, Null, CreateDate)
            !UpdateDate = IIf(UpdateDate = -1, Null, UpdateDate)
            !CreateUser = IIf(CreateUser = -1, Null, CreateUser)
            !UpdateUser = IIf(UpdateUser = -1, Null, UpdateUser)
            !IsFixedAssetParent = IIf(IsFixedAssetParent = -1, Null, IsFixedAssetParent)
            !IsHidden = IIf(IsHidden = -1, Null, IsHidden)
            !AcTypeDescription = IIf(AcTypeDescription = -1, Null, AcTypeDescription)
            !ActualAcTypeID = IIf(ActualAcTypeID = -1, -1, ActualAcTypeID)
            .Update
        End With
    End Function

Public Function UpdateSubSectionData(ByVal lngPeriodID As Long, Optional lngCopyPeriodID As Long = 0) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
Dim rsSave As New ADODB.Recordset
    If lngCopyPeriodID <> 0 Then
        sSql = "Select * from SubSectionData Where PeriodID = " & lngCopyPeriodID
    Else
        sSql = "Select * from SubSectionData Where IsTemplate = 1"
    End If
    With GetRecords(sSql)
        While Not .EOF
            sSql = "Select * from SubSectionData Where PeriodID = " & lngPeriodID & " AND SubSectionID = " & Val(.Fields("SubSectionID") & "")
            Set rsSave = GetRecords(sSql)
            If rsSave.EOF Then
                rsSave.AddNew
                rsSave.Fields("PeriodID") = lngPeriodID
                rsSave.Fields("SubSectionID") = Val(.Fields("SubSectionID") & "")
                rsSave.Fields("Data") = .Fields("Data") & ""
            End If
            rsSave.Fields("IsTemplate") = False
            rsSave.Update
            rsSave.Close
            '---Checking for sub--------------------------
            sSql = "Select * from SubSectionDataExtension Where PeriodID = " & Val(.Fields("PeriodID") & "") & " AND SubSectionID = " & Val(.Fields("SubSectionID") & "")
            With GetRecords(sSql)
                While Not .EOF
                    sSql = "Select * from SubSectionDataExtension Where PeriodID = " & lngPeriodID & " AND SubSectionID = " & Val(.Fields("SubSectionID") & "") & " AND SubSlNo = " & Val(.Fields("SubSlNo") & "")
                    Set rsSave = GetRecords(sSql)
                    If rsSave.EOF Then
                        rsSave.AddNew
                        rsSave.Fields("PeriodID") = lngPeriodID
                        rsSave.Fields("SubSectionID") = Val(.Fields("SubSectionID") & "")
                        rsSave.Fields("SubSlNo") = Val(.Fields("SubSlNo") & "")
                        rsSave.Fields("DataExtension") = .Fields("DataExtension") & ""
                    End If
                    rsSave.Update
                    rsSave.Close
                    .MoveNext
                Wend
                .Close
            End With
            .MoveNext
        Wend
        .Close
    End With
    UpdateSubSectionData = True
    Exit Function
Err_Exit:
    UpdateSubSectionData = False
End Function

Public Function UpdateAcTypes(ByVal CompanyID As Long) As Boolean
    AcTypes CompanyID, 1, "Assets", "1", -1, 1, "", -1, -1, -1, -1, 1, 1, "Debit", -1, 1, "01/01/2006 12:00:00 AM", "01/01/2006 12:00:00 AM", 1, 1, -1, 0, "Assets", -1
    AcTypes CompanyID, 2, "Liabilities and Equity", "2", -1, 1, -1, -1, -1, -1, -1, 1, 2, "Credit", -1, 1, "01/01/2006 12:00:00 AM", "01/01/2006 12:00:00 AM", 1, 1, -1, 0, "Liabilities and Equity", -1
    AcTypes CompanyID, 3, "Profit and loss", "3", -1, 1, -1, -1, -1, -1, -1, 1, 3, "Credit", -1, 1, "01/01/2006 12:00:00 AM", "01/01/2006 12:00:00 AM", 1, 1, -1, 0, "Profit and loss", -1
    AcTypes CompanyID, 4, "Current assets", "4", 1, 1, "", -1, -1, -1, -1, 2, 1, "Debit", -1, 1, "11/24/2005 10:18:00 AM", "11/24/2005 10:18:00 AM", 1, 1, -1, 0, "Current assets", -1
    AcTypes CompanyID, 5, "Non - current assets", "5", 1, 1, -1, -1, -1, -1, -1, 2, 2, "Debit", -1, 1, "11/24/2005 10:18:00 AM", "11/24/2005 10:18:00 AM", 1, 1, -1, 0, "Non - current assets", -1
    AcTypes CompanyID, 6, "Current liability", "6", 2, 1, -1, -1, -1, -1, -1, 2, 1, "Credit", -1, 1, "11/24/2005 10:18:00 AM", "11/24/2005 10:18:00 AM", 1, 1, -1, 0, "Current liability", -1
    AcTypes CompanyID, 7, "Non - current liability", "7", 2, 1, -1, -1, -1, -1, -1, 2, 2, "Credit", -1, 1, "11/24/2005 10:19:00 AM", "11/24/2005 10:19:00 AM", 1, 1, -1, 0, "Non - current liability", -1
    AcTypes CompanyID, 8, "Shareholders` equity", "8", 2, 1, "", -1, -1, -1, -1, 2, 3, "Credit", -1, 1, "11/24/2005 10:19:00 AM", "11/24/2005 10:19:00 AM", 1, 1, -1, 0, "Shareholders` equity", cnstAcTypeShareHoldersEquity
    AcTypes CompanyID, 9, "Cash and cash equivalents", "9", 4, 1, "5100", -1, -1, -1, -1, 3, 1, "Debit", -1, 1, "11/24/2005 10:19:00 AM", "11/24/2005 10:19:00 AM", 1, 1, -1, 0, "Cash and cash equivalents", cnstAcTypeCashAndBankBalances
    AcTypes CompanyID, 10, "Due from related parties", "10", 4, 1, "5300", -1, -1, -1, -1, 3, 5, "Debit", -1, 1, "11/24/2005 10:24:00 AM", "11/24/2005 10:24:00 AM", 1, 1, -1, 0, "Due from related parties", cnstAcTypeDuefromRelated
    AcTypes CompanyID, 11, "Inventories", "11", 4, 1, "5550", -1, -1, -1, -1, 3, 9, "Debit", -1, 1, "11/24/2005 10:25:00 AM", "11/24/2005 10:25:00 AM", 1, 1, -1, 0, "Inventories", cnstAcTypeInventories
    AcTypes CompanyID, 12, "Property and equipment", "12", 5, 1, "5850", -1, -1, -1, -1, 3, 6, "Debit", -1, 1, "11/24/2005 10:25:00 AM", "11/24/2005 10:25:00 AM", 1, 1, 1, 0, "Property and equipment", cnstAcTypePropertyPlantEquipment
    AcTypes CompanyID, 13, "Accounts payable", "13", 6, 1, "6100", -1, -1, -1, -1, 3, 2, "Credit", -1, 1, "11/24/2005 10:26:00 AM", "11/24/2005 10:26:00 AM", 1, 1, -1, 0, "Accounts payable", cnstAcTypeTradePayables
    AcTypes CompanyID, 14, "Other payables", "14", 6, 1, "6200", -1, -1, -1, -1, 3, 3, "Credit", -1, 1, "11/24/2005 10:26:00 AM", "11/24/2005 10:26:00 AM", 1, 1, -1, 0, "Other payables", cnstAcTypeOtherPayables
    AcTypes CompanyID, 15, "Due to related parties", "15", 6, 1, "6250", -1, -1, -1, -1, 3, 4, "Credit", -1, 1, "11/24/2005 10:26:00 AM", "11/24/2005 10:26:00 AM", 1, 1, -1, 0, "Due to related parties", cnstAcTypeDuetoRelated
    AcTypes CompanyID, 16, "Bank borrowings - current portion", "16", 6, 1, "6300", -1, -1, -1, -1, 3, 5, "Credit", -1, 1, "11/24/2005 10:27:00 AM", "11/24/2005 10:27:00 AM", 1, 1, -1, 0, "Bank borrowings - current portion", cnstAcTypeBankBorrowings
    AcTypes CompanyID, 17, "Obligation under finance lease - current portion", "17", 6, 1, "6450", -1, -1, -1, 18, 3, 8, "Credit", -1, 1, "11/24/2005 10:31:00 AM", "11/24/2005 10:31:00 AM", 1, 1, -1, 0, "Obligation under finance lease - current portion", cnstAcTypeObligation
    AcTypes CompanyID, 18, "Obligation under finance lease - non current portion", "18", 7, 1, "6650", -1, -1, -1, -1, 3, 4, "Credit", -1, 1, "11/24/2005 10:31:00 AM", "11/24/2005 10:31:00 AM", 1, 1, -1, 0, "Obligation under finance lease - non current portion", -1
    AcTypes CompanyID, 19, "Provision for employees` end of service indemnity", "19", 7, 1, "6750", -1, -1, -1, -1, 3, 6, "Credit", -1, 1, "11/24/2005 10:32:00 AM", "11/24/2005 10:32:00 AM", 1, 1, -1, 0, "Provision for employees` end of service indemnity", cnstAcTypeProvisionforEmployees
    AcTypes CompanyID, 20, "Share capital", "20", 8, 1, 7100, -1, -1, -1, -1, 3, 1, "Credit", -1, 1, "11/24/2005 10:32:00 AM", "11/24/2005 10:32:00 AM", 1, 1, -1, 0, "Share capital", -1
    AcTypes CompanyID, 21, "Statutory reserve", "21", 8, 1, 7150, -1, -1, -1, -1, 3, 2, "Credit", 2, 1, "11/24/2005 10:32:00 AM", "11/24/2005 10:32:00 AM", 1, 1, -1, 0, "Statutory reserve", -1
    AcTypes CompanyID, 22, "Retained earnings", "22", 8, 1, 7200, -1, -1, -1, -1, 3, 3, "Credit", 1, 1, "11/24/2005 10:33:00 AM", "11/24/2005 10:33:00 AM", 1, 1, -1, 0, "Retained earnings", -1
    AcTypes CompanyID, 23, "Shareholders` loan account", "23", 8, 1, "7350", -1, -1, -1, -1, 3, 6, "Credit", -1, 1, "11/24/2005 10:33:00 AM", "11/24/2005 10:33:00 AM", 1, 1, -1, 0, "Shareholders` loan account", -1
    AcTypes CompanyID, 24, "Shareholders` current account", "24", 8, 1, "7400", -1, -1, -1, -1, 3, 7, "Credit", -1, 1, "11/24/2005 10:33:00 AM", "11/24/2005 10:33:00 AM", 1, 1, -1, 0, "Shareholders` current account", -1
    AcTypes CompanyID, 25, "Revenue", "25", 99, 1, "8100", -1, -1, -1, -1, 3, 1, "Credit", -1, 1, "11/24/2005 10:33:00 AM", "11/24/2005 10:33:00 AM", 1, 1, -1, 0, "Revenue", cnstAcTypeRevenue
    AcTypes CompanyID, 26, "Direct expenses", "26", 99, 1, "8150", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "11/24/2005 10:34:00 AM", "11/24/2005 10:34:00 AM", 1, 1, -1, 0, "Direct expenses", cnstAcTypeCostofSales
    AcTypes CompanyID, 27, "Other income", "27", 97, 1, "8200", -1, -1, -1, -1, 3, 1, "Credit", -1, 1, "11/24/2005 10:34:00 AM", "11/24/2005 10:34:00 AM", 1, 1, -1, 0, "Other income", cnstAcTypeOtherIncome
    AcTypes CompanyID, 28, "Selling and business promotions", "28", 97, 1, "8300", -1, -1, -1, -1, 3, 3, "Debit", -1, 1, "11/24/2005 10:34:00 AM", "11/24/2005 10:34:00 AM", 1, 1, -1, 0, "Selling and business promotions", -1
    AcTypes CompanyID, 29, "General and administrative expenses", "29", 97, 1, "8350", -1, -1, -1, -1, 3, 4, "Debit", -1, 1, "11/24/2005 10:34:00 AM", "11/24/2005 10:34:00 AM", 1, 1, -1, 0, "General and administrative expenses", -1
    AcTypes CompanyID, 30, "Depreciation and amortisation", "30", 257, 1, "8600", -1, -1, -1, -1, 4, 11, "Debit", -1, 1, "11/24/2005 10:34:00 AM", "11/24/2005 10:34:00 AM", 1, 1, -1, 0, "Depreciation and amortisation", -1
    AcTypes CompanyID, 31, "Managerial remuneration", "31", 98, 1, "8500", -1, -1, -1, -1, 3, 3, "Debit", -1, 1, "11/24/2005 10:35:00 AM", "11/24/2005 10:35:00 AM", 1, 1, -1, 0, "Managerial remuneration", -1
    AcTypes CompanyID, 32, "Finance cost", "32", 98, 1, "8450", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "11/24/2005 10:35:00 AM", "11/24/2005 10:35:00 AM", 1, 1, -1, 0, "Finance cost", cnstAcTypeFinanceCost
    AcTypes CompanyID, 33, "Cash in hand", "33", 9, 1, "", -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "11/24/2005 10:36:00 AM", "11/24/2005 10:36:00 AM", 1, 1, -1, 0, "Cash in hand", -1
    AcTypes CompanyID, 34, "Bank balance in current account", "34", 9, 1, "", -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "11/24/2005 10:36:00 AM", "11/24/2005 10:36:00 AM", 1, 1, -1, 0, "Bank balance in current account", -1
    AcTypes CompanyID, 35, "Bank balance in fixed deposit account", "35", 9, 1, "", -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "11/24/2005 10:36:00 AM", "11/24/2005 10:36:00 AM", 1, 1, -1, 0, "Bank balance in fixed deposit account", -1
'    AcTypes CompanyID, 35, "Fixed deposits", "35", 9, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "11/24/2005 10:37:00 AM", "11/24/2005 10:37:00 AM", 1, 1, -1
    '24 December 2007 ------------
    AcTypes CompanyID, 36, "Accounts receivable", "36", 4, 1, "5200", -1, -1, -1, -1, 3, 3, "Debit", -1, 1, "11/24/2005 10:50:00 AM", "11/24/2005 10:50:00 AM", 1, 1, -1, 0, "Accounts receivable", cnstAcTypeTradeReceivables
    AcTypes CompanyID, 37, "Receivables from customers", "37", 36, 1, "", -1, -1, 73, -1, 4, 1, "Debit", -1, 1, "11/24/2005 10:51:00 AM", "11/24/2005 10:51:00 AM", 1, 1, -1, 0, "Receivables from customers", -1
    AcTypes CompanyID, 38, "Prepayments", "38", 40, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "11/24/2005 10:51:00 AM", "11/24/2005 10:51:00 AM", 1, 1, -1, 0, "Prepayments", -1
    AcTypes CompanyID, 39, "Deposits", "39", 40, 1, -1, 0, 0, -1, -1, 4, 1, "Debit", -1, 1, "11/24/2005 10:51:00 AM", "11/24/2005 10:51:00 AM", 1, 1, -1, 0, "Deposits", -1
    AcTypes CompanyID, 40, "Other receivable", "40", 4, 1, "5250", -1, -1, -1, -1, 3, 4, "Debit", -1, 1, "11/24/2005 10:52:00 AM", "11/24/2005 10:52:00 AM", 1, 1, -1, 0, "Other receivable", cnstAcTypeOtherReceivables
    AcTypes CompanyID, 41, "Others", "41", 40, 1, -1, -1, -1, -1, -1, 4, 5, "Debit", -1, 1, "11/24/2005 10:52:00 AM", "11/24/2005 10:52:00 AM", 1, 1, -1, 0, "Others", -1
'    AcTypes CompanyID, 42, "Closing stock", "42", 11, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "11/24/2005 10:54:00 AM", "11/24/2005 10:54:00 AM", 1, 1, -1, 0, "Closing stock", -1
    AcTypes CompanyID, 43, "Goods in transit", "43", 11, 1, -1, -1, -1, -1, -1, 4, 7, "Debit", -1, 1, "11/24/2005 10:54:00 AM", "11/24/2005 10:54:00 AM", 1, 1, -1, 0, "Goods in transit", -1
    AcTypes CompanyID, 44, "Work in progress", "44", 11, 1, -1, -1, -1, -1, -1, 4, 8, "Debit", -1, 1, "11/24/2005 10:54:00 AM", "11/24/2005 10:54:00 AM", 1, 1, -1, 0, "Work in progress", -1
    AcTypes CompanyID, 45, "Allowance for slow moving and obsolate stock", "45", 11, 1, -1, -1, -1, -1, -1, 4, 6, "Debit", -1, 1, "11/24/2005 10:55:00 AM", "11/24/2005 10:55:00 AM", 1, 1, -1, 0, "Allowance for slow moving and obsolate stock", -1
    AcTypes CompanyID, 46, "Building", "46", 12, 1, "", 96, 95, -1, -1, 4, 3, "Debit", -1, 1, "11/24/2005 10:56:00 AM", "11/24/2005 10:56:00 AM", 1, 1, -1, 0, "Building", -1
    AcTypes CompanyID, 47, "Leasehold improvements", "47", 12, 1, "", 86, 85, -1, -1, 4, 4, "Debit", -1, 1, "11/24/2005 10:56:00 AM", "11/24/2005 10:56:00 AM", 1, 1, -1, 0, "Leasehold improvements", -1
    AcTypes CompanyID, 48, "Furniture and fixtures", "48", 12, 1, "", 88, 87, -1, -1, 4, 6, "Debit", -1, 1, "11/24/2005 10:56:00 AM", "11/24/2005 10:56:00 AM", 1, 1, -1, 0, "Furniture and fixtures", -1
    AcTypes CompanyID, 49, "Office equipment", "49", 12, 1, "", 90, 89, -1, -1, 4, 7, "Debit", -1, 1, "11/24/2005 10:57:00 AM", "11/24/2005 10:57:00 AM", 1, 1, -1, 0, "Office equipment", -1
    AcTypes CompanyID, 50, "Tools and equipments", "50", 12, 1, "", 92, 91, -1, -1, 4, 8, "Debit", -1, 1, "11/24/2005 10:57:00 AM", "11/24/2005 10:57:00 AM", 1, 1, -1, 0, "Tools and equipments", -1
    AcTypes CompanyID, 51, "Vehicles", "51", 12, 1, "", 94, 93, -1, -1, 4, 9, "Debit", -1, 1, "11/24/2005 10:57:00 AM", "11/24/2005 10:57:00 AM", 1, 1, -1, 0, "Vehicles", -1
    AcTypes CompanyID, 52, "Intangible assets", "52", 5, 1, "5800", -1, -1, -1, -1, 3, 5, "Debit", -1, 1, "11/24/2005 10:58:00 AM", "11/24/2005 10:58:00 AM", 1, 1, -1, 0, "Intangible assets", cnstAcTypeIntangibleAssets
    AcTypes CompanyID, 53, "Goodwill", "53", 52, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "11/24/2005 10:58:00 AM", "11/24/2005 10:58:00 AM", 1, 1, -1, 0, "Goodwill", -1
    AcTypes CompanyID, 54, "Expenses payable", "54", 14, 1, -1, -1, -1, -1, -1, 4, 3, "Credit", -1, 1, "11/24/2005 11:00:00 AM", "11/24/2005 11:00:00 AM", 1, 1, -1, 0, "Expenses payable", -1
    AcTypes CompanyID, 55, "Staff Provisions", "55", 14, 1, -1, -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "11/24/2005 11:00:00 AM", "11/24/2005 11:00:00 AM", 1, 1, -1, 0, "Provision for staff benefits", -1
    AcTypes CompanyID, 56, "Staff payables", "56", 14, 1, -1, -1, -1, -1, -1, 4, 1, "Credit", -1, 1, "11/24/2005 11:01:00 AM", "11/24/2005 11:01:00 AM", 1, 1, -1, 0, "Staff payable", -1
    AcTypes CompanyID, 57, "Others", "57", 14, 1, -1, -1, -1, -1, -1, 4, 6, "Credit", -1, 1, "11/24/2005 11:01:00 AM", "11/24/2005 11:01:00 AM", 1, 1, -1, 0, "Others", -1
    AcTypes CompanyID, 58, "Term loan", "58", 16, 1, -1, -1, -1, -1, -1, 4, 4, "Credit", -1, 1, "11/24/2005 11:01:00 AM", "11/24/2005 11:01:00 AM", 1, 1, -1, 0, "Term loan", -1
    AcTypes CompanyID, 59, "Trust receipts", "59", 16, 1, -1, -1, -1, -1, -1, 4, 3, "Credit", -1, 1, "11/24/2005 11:01:00 AM", "11/24/2005 11:01:00 AM", 1, 1, -1, 0, "Trust receipts", -1
    AcTypes CompanyID, 60, "Overdraft", "60", 16, 1, -1, -1, -1, -1, -1, 4, 1, "Credit", -1, 1, "11/24/2005 11:02:00 AM", "11/24/2005 11:02:00 AM", 1, 1, -1, 0, "Overdraft", -1
    AcTypes CompanyID, 61, "Bills discounted", "61", 16, 1, -1, -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "11/24/2005 11:02:00 AM", "11/24/2005 11:02:00 AM", 1, 1, -1, 0, "Bills discounted", -1
    AcTypes CompanyID, 62, "Purchases", "62", 237, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "11/24/2005 11:03:00 AM", "11/24/2005 11:03:00 AM", 1, 1, -1, 0, "Purchases", -1
    AcTypes CompanyID, 67, "Salaries and allowances", "67", 230, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "11/24/2005 11:05:00 AM", "11/24/2005 11:05:00 AM", 1, 1, -1, 0, "Salaries and allowances", -1
    AcTypes CompanyID, 68, "Rent", "68", 29, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "11/24/2005 11:05:00 AM", "11/24/2005 11:05:00 AM", 1, 1, -1, 0, "Rent", -1
    AcTypes CompanyID, 69, "Legal, license and professional", "69", 29, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "11/24/2005 11:05:00 AM", "11/24/2005 11:05:00 AM", 1, 1, -1, 0, "Legal, license and professional", -1
    AcTypes CompanyID, 70, "Bad and doubtful debts", "70", 29, 1, -1, -1, -1, -1, -1, 4, 6, "Debit", -1, 1, "11/24/2005 11:06:00 AM", "11/24/2005 11:06:00 AM", 1, 1, -1, 0, "Bad and doubtful debts", -1
    AcTypes CompanyID, 72, "Advance to suppliers", "72", 40, 1, -1, -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "11/24/2005 11:17:00 AM", "11/24/2005 11:17:00 AM", 1, 1, -1, 0, "Advance to suppliers", -1
    AcTypes CompanyID, 73, "Allowance for doubtful debts", "73", 36, 1, "", -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "11/26/2005 2:39:00 PM", "11/26/2005 2:39:00 PM", 1, 1, -1, 0, "Allowance for doubtful debts", -1
    AcTypes CompanyID, 74, "Future interest", "74", 17, 1, "", -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "12/14/2005 12:31:00 PM", "12/14/2005 12:31:00 PM", 1, 1, -1, 0, "Future interest", -1
    AcTypes CompanyID, 75, "Obligation under finance lease - current  portion", "75", 17, 1, "", -1, -1, 74, 76, 4, 1, "Credit", -1, 1, "12/17/2005 2:13:00 PM", "12/17/2005 2:13:00 PM", 1, 1, -1, 0, "Obligation under finance lease - current  portion", -1
    AcTypes CompanyID, 77, "Loans and advances", "77", 40, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/02/2006 11:17:00 AM", "07/02/2006 11:17:00 AM", 1, 1, -1, 0, "Loans and advances", -1
    AcTypes CompanyID, 81, "Other expenses", "81", 29, 1, "", -1, -1, -1, -1, 4, 10, "Debit", -1, 1, "07/02/2006 11:06:00 PM", "07/02/2006 11:06:00 PM", 1, 1, -1, 0, "Other expenses", -1
'    AcTypes CompanyID, 83, "Retension", "83", 36, 1, "", -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "08/02/2006 11:20:00 AM", "08/02/2006 11:20:00 AM", 1, 1, -1, 0, "Retension", -1
    AcTypes CompanyID, 84, "Other advances", "84", 77, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 2:02:00 PM", "12/02/2006 2:02:00 PM", 1, 1, -1, 0, "Other advances", -1
    AcTypes CompanyID, 85, "Leasehold improvements - cost", "85", 47, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:42:00 PM", "12/02/2006 5:42:00 PM", 1, 1, -1, 0, "Leasehold improvements - cost", -1
    AcTypes CompanyID, 86, "Leasehold improvements - accumulated depreciation", "86", 47, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:43:00 PM", "12/02/2006 5:43:00 PM", 1, 1, -1, 0, "Leasehold improvements - accumulated depreciation", -1
    AcTypes CompanyID, 87, "Furniture and fixtures - cost", "87", 48, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:44:00 PM", "12/02/2006 5:44:00 PM", 1, 1, -1, 0, "Furniture and fixtures - cost", -1
    AcTypes CompanyID, 88, "Furniture and fixtures - accumulated depreciation", "88", 48, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:44:00 PM", "12/02/2006 5:44:00 PM", 1, 1, -1, 0, "Furniture and fixtures - accumulated depreciation", -1
    AcTypes CompanyID, 89, "Office equipment - cost", "89", 49, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:44:00 PM", "12/02/2006 5:44:00 PM", 1, 1, -1, 0, "Office equipment - cost", -1
    AcTypes CompanyID, 90, "Office equipment - accumulated depreciation", "90", 49, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:45:00 PM", "12/02/2006 5:45:00 PM", 1, 1, -1, 0, "Office equipment - accumulated depreciation", -1
    AcTypes CompanyID, 91, "Tools and equipments - cost", "91", 50, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:45:00 PM", "12/02/2006 5:45:00 PM", 1, 1, -1, 0, "Tools and equipments - cost", -1
    AcTypes CompanyID, 92, "Tools and equipments - accumulated depreciation", "92", 50, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:45:00 PM", "12/02/2006 5:45:00 PM", 1, 1, -1, 0, "Tools and equipments - accumulated depreciation", -1
    AcTypes CompanyID, 93, "Vehicle - cost", "93", 51, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:46:00 PM", "12/02/2006 5:46:00 PM", 1, 1, -1, 0, "Vehicle - cost", -1
    AcTypes CompanyID, 94, "Vehicle - accumulated depreciation", "94", 51, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:46:00 PM", "12/02/2006 5:46:00 PM", 1, 1, -1, 0, "Vehicle - accumulated depreciation", -1
    AcTypes CompanyID, 95, "Building - cost", "95", 46, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "12/02/2006 5:47:00 PM", "12/02/2006 5:47:00 PM", 1, 1, -1, 0, "Building - cost", -1
    AcTypes CompanyID, 96, "Building - accumulated depreciation", "96", 46, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "12/02/2006 5:47:00 PM", "12/02/2006 5:47:00 PM", 1, 1, -1, 0, "Building - accumulated depreciation", -1
    AcTypes CompanyID, 97, "Operating expenses/income", "97", 3, 1, -1, -1, -1, -1, -1, 2, 2, "Credit", -1, 1, "02/14/2006 11:11:00 AM", "02/14/2006 11:11:00 AM", 1, 1, -1, 0, "Operating expenses/income", cnstAcTypeOperatingExpenses
    AcTypes CompanyID, 98, "Non-operating expenses/income", "98", 3, 1, -1, -1, -1, -1, -1, 2, 3, "Credit", -1, 1, "02/14/2006 11:11:00 AM", "02/14/2006 11:11:00 AM", 1, 1, -1, 0, "Non-operating expenses/income", cnstAcTypeNonOperatingExpenses
    AcTypes CompanyID, 99, "Trading accounts", "99", 3, 1, -1, -1, -1, -1, -1, 2, 1, "Credit", -1, 1, "02/14/2006 11:13:00 AM", "02/14/2006 11:13:00 AM", 1, 1, -1, 0, "Trading accounts", cnstAcTypeTrading
    AcTypes CompanyID, 102, "Bank borrowings - non current portion", "102", 7, 1, "6600", -1, -1, -1, -1, 3, 3, "Credit", 0, 1, "02/23/2006 10:22:00 AM", "02/23/2006 10:22:00 AM", 1, 1, -1, 0, "Bank borrowings - non current portion", -1
    AcTypes CompanyID, 103, "Advances", "103", 14, 1, "", -1, -1, -1, -1, 4, 5, "Credit", 0, 1, "02/23/2006 10:22:00 AM", "02/23/2006 10:22:00 AM", 1, 1, -1, 0, "Advances", -1
    AcTypes CompanyID, 104, "Creditors for expense", "104", 54, 1, "", -1, -1, -1, -1, 5, 2, "Credit", 0, 1, "02/23/2006 10:22:00 AM", "02/23/2006 10:22:00 AM", 1, 1, -1, 0, "Creditors for expense", -1
    '02 March 2010, Tuesday ----------------
    AcTypes CompanyID, 105, "Other financial assets", "105", 4, 1, "5150", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Other financial assets", cnstAcTypeOtherFinancialAssets
    AcTypes CompanyID, 106, "Advance against aquisition of land", "106", 4, 1, "5350", -1, -1, -1, -1, 3, 6, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Advance against aquisition of land", cnstAcTypeAdvanceAgainstAquisitionofLand
    AcTypes CompanyID, 107, "Investment properties held for sale", "107", 4, 1, "5400", -1, -1, -1, -1, 3, 7, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Investment properties held for sale", cnstAcTypeInvestmentPropertiesheldforSale
    AcTypes CompanyID, 108, "Development properties", "108", 4, 1, "5450", -1, -1, -1, -1, 3, 8, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Development properties", cnstAcTypeDevelopmentProperties
    AcTypes CompanyID, 109, "Available for sale financial assets", "109", 5, 1, "5650", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Available for sale financial assets", cnstAcTypeAvailableforsalefinancialassets
    AcTypes CompanyID, 110, "Investments in associates and subsidiaries", "110", 5, 1, "5750", -1, -1, -1, -1, 3, 4, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Investments in associates and subsidiaries", cnstAcTypeInvestmentsinSubsidiariesandJointVenture
    AcTypes CompanyID, 111, "Investment properties", "111", 5, 1, "5700", -1, -1, -1, -1, 3, 3, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Investment properties", cnstAcTypeInvestmentProperties
    AcTypes CompanyID, 112, "Advance from customers", "112", 6, 1, "6150", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "03/02/2010 12:40:00 PM", "03/02/2010 12:40:00 PM", 1, 1, -1, 0, "Advance from customers", cnstAcTypeAdvancefromCustomers
    '03 March 2010, Wednesday ------------------
    AcTypes CompanyID, 113, "Other comprehensive income/(expense)", "113", 3, 1, -1, -1, -1, -1, -1, 2, 4, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Other comprehensive income/(expense)", cnstAcTypeOtherComprehensiveExp
    AcTypes CompanyID, 114, "Foreign currency translation reserve", "114", 113, 1, "9100", -1, -1, -1, -1, 3, 1, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Foreign currency translation reserve", -1
    AcTypes CompanyID, 115, "Net change in fair value financial assets", "114", 113, 1, "9150", -1, -1, -1, -1, 3, 2, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Net change in fair value financial assets", -1
'    AcTypes CompanyID, 116, "Cashflow", "116", 113, 1, -1, -1, -1, -1, -1, 3, 3, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Cashflow", -1
    '27 May 2010, Thursday ------------------
    AcTypes CompanyID, 117, "Current Assets 1", "117", 4, 1, "5560", -1, -1, -1, -1, 3, 10, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, -1, 0, "Current Assets 1", cnstAcTypeCurrentAssets1
    AcTypes CompanyID, 118, "Current Assets 2", "118", 4, 1, "5570", -1, -1, -1, -1, 3, 11, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, -1, 0, "Current Assets 2", cnstAcTypeCurrentAssets2
    AcTypes CompanyID, 119, "Current Assets 3", "119", 4, 1, "5580", -1, -1, -1, -1, 3, 12, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, -1, 0, "Current Assets 3", cnstAcTypeCurrentAssets3

    AcTypes CompanyID, 120, "Non Current Assets 1", "120", 5, 1, "5860", -1, -1, -1, -1, 3, 7, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, 1, 0, "Non Current Assets 1", cnstAcTypeNonCurrentAssets1
    AcTypes CompanyID, 121, "Non Current Assets 2", "121", 5, 1, "5870", -1, -1, -1, -1, 3, 8, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, 1, 0, "Non Current Assets 2", cnstAcTypeNonCurrentAssets2
    AcTypes CompanyID, 122, "Non Current Assets 3", "122", 5, 1, "5880", -1, -1, -1, -1, 3, 9, "Debit", -1, 2, "05/27/2010 12:30:00 PM", "05/27/2010 12:30:00 PM", 1, 1, 1, 0, "Non Current Assets 3", cnstAcTypeNonCurrentAssets3
    '05 July 2010, Monday -------------------
    AcTypes CompanyID, 131, "Retension receivable - current portion", "131", 36, 1, "", -1, -1, 73, -1, 4, 2, "Debit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Retension receivable - current portion", -1
    AcTypes CompanyID, 132, "Staff loans and advances", "132", 77, 1, -1, 0, 0, -1, -1, 5, 1, "Debit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Staff loans and advances", -1
    AcTypes CompanyID, 133, "Trading investments", "133", 4, 1, "5500", -1, -1, -1, -1, 3, 8, "Debit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Trading investments", cnstAcTypeTradingInvestments
    AcTypes CompanyID, 134, "Due to related parties - non current portion", "134", 7, 1, "6550", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Due to related parties - non current portion", cnstAcTypeDueFromRelatedNonCurrent
    AcTypes CompanyID, 135, "Secured/Unsecured loan - current portion", "135", 6, 1, "6350", -1, -1, -1, -1, 3, 6, "Credit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Secured/Unsecured loan - current portion", cnstAcTypeSecuredUnsecuredloanCurrent
    AcTypes CompanyID, 136, "Advance received against development properties", "136", 6, 1, "6400", -1, -1, -1, -1, 3, 7, "Credit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Advance received against development properties", cnstAdvancereceivedagainstdevelopmentproperties
    AcTypes CompanyID, 137, "Retension receivable - non current portion", "137", 5, 1, "5600", -1, -1, 73, -1, 3, 1, "Debit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Retension receivable - non current portion", -1
    AcTypes CompanyID, 138, "Secured/Unsecured loan - non current portion", "138", 7, 1, "6700", -1, -1, -1, -1, 3, 5, "Credit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Secured/Unsecured loan - non current portion", cnstAcTypeSecuredUnsecuredloanCurrent
    AcTypes CompanyID, 139, "Fair value reserve", "139", 8, 1, "7300", -1, -1, -1, -1, 3, 5, "Credit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Fair value reserve", -1
    AcTypes CompanyID, 140, "Accumulated other comprehensive income", "140", 8, 1, "7250", -1, -1, -1, -1, 3, 4, "Credit", -1, 1, "07/05/2010 03:15:00 PM", "07/05/2010 03:15:00 PM", 1, 1, -1, 0, "Accumulated other comprehensive income", -1

    AcTypes CompanyID, 141, "Margin deposits", "141", 105, 1, "", -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Margin deposits", -1
    AcTypes CompanyID, 142, "Fixed deposits", "142", 105, 1, "", -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Fixed deposits", -1
    
    AcTypes CompanyID, 143, "Bills receivable", "143", 36, 1, "", -1, -1, 73, -1, 4, 4, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Bills receivable", -1
    AcTypes CompanyID, 144, "Due from contract customers", "144", 36, 1, "", -1, -1, 73, -1, 4, 5, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Due from contract customers", -1
    
    AcTypes CompanyID, 145, "Advance to suppliers and sub contractors", "145", 72, 1, -1, 0, 0, -1, -1, 5, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Advance to suppliers and sub contractors", -1
    AcTypes CompanyID, 146, "Debit balance in sundry creditors", "146", 72, 1, -1, 0, 0, -1, -1, 5, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Debit balance in sundry creditors", -1
    
    AcTypes CompanyID, 147, "From shareholders", "147", 10, 1, -1, 0, 0, -1, -1, 4, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "From shareholders", -1
    AcTypes CompanyID, 148, "From associates and subsidiaries", "148", 10, 1, -1, 0, 0, -1, -1, 4, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "From associates and subsidiaries", -1
    AcTypes CompanyID, 149, "From other related parties", "149", 10, 1, -1, 0, 0, -1, -1, 4, 3, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "From other related parties", -1
    
    AcTypes CompanyID, 150, "Copyrights and patents", "150", 52, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Copyrights and apparents", -1
    AcTypes CompanyID, 151, "Softwares", "151", 52, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Softwares", -1
    
    AcTypes CompanyID, 152, "Goodwill - cost", "152", 53, 1, -1, 0, 0, -1, -1, 5, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Goodwill - cost", -1
    AcTypes CompanyID, 153, "Goodwill - amortised", "153", 53, 1, -1, 0, 0, -1, -1, 5, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Goodwill - amortised", -1
    
    AcTypes CompanyID, 154, "Investments in associates", "154", 110, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Investments in associates", -1
    AcTypes CompanyID, 155, "Investments in subsidiaries", "155", 110, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Investments in subsidiaries", -1
    AcTypes CompanyID, 156, "Investments in joint ventures", "156", 110, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Investments in joint ventures", -1

    AcTypes CompanyID, 157, "Capital work in progress", "157", 12, 1, "", 160, 159, -1, -1, 4, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Capital work in progress", -1
    AcTypes CompanyID, 158, "Land", "158", 12, 1, "", 162, 161, -1, -1, 4, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Land", -1

    AcTypes CompanyID, 159, "Capital work in progress - cost", "159", 157, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Capital work in progress - cost", -1
    AcTypes CompanyID, 160, "Capital work in progress - accumulated depreciation", "160", 157, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Capital work in progress - accumulated depreciation", -1
    AcTypes CompanyID, 161, "Land - cost", "161", 158, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Land - cost", -1
    AcTypes CompanyID, 162, "Land - accumulated depreciation", "162", 158, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Land - accumulated depreciation", -1

    AcTypes CompanyID, 163, "Plant and machinery", "163", 12, 1, "", 165, 164, -1, -1, 4, 5, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Plant and machinery", -1
    AcTypes CompanyID, 164, "Plant and machinery - cost", "164", 163, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Plant and machinery - cost", -1
    AcTypes CompanyID, 165, "Plant and machinery - accumulated depreciation", "165", 163, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Plant and machinery - accumulated depreciation", -1

    AcTypes CompanyID, 166, "Payables to suppliers", "166", 13, 1, -1, -1, -1, -1, -1, 4, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Payables to suppliers", cnstAcTypePayabletosuppliers
    AcTypes CompanyID, 167, "Payables for sub contractors", "167", 13, 1, -1, -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Payables for sub contractors", cnstAcTypePayableforsubcontractors
    AcTypes CompanyID, 168, "Accrued purchases", "168", 13, 1, -1, -1, -1, -1, -1, 4, 3, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Accrued purchases", cnstAcTypeAccruedpurchases
    AcTypes CompanyID, 169, "Bills payables", "169", 13, 1, -1, -1, -1, -1, -1, 4, 5, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Bills payable", cnstAcTypeBillspayable
    AcTypes CompanyID, 170, "Letter of credit", "170", 169, 1, -1, -1, -1, -1, -1, 5, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Letter of credit", -1
    AcTypes CompanyID, 171, "Post dated cheques", "171", 169, 1, -1, -1, -1, -1, -1, 5, 2, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Post dated cheques", -1

    AcTypes CompanyID, 172, "Due to contract customers", "172", 14, 1, -1, -1, -1, -1, -1, 4, 4, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Due to contract customers", cnstAcTypeDuetocontractcustomers
    AcTypes CompanyID, 173, "Accrued expenses", "173", 54, 1, -1, -1, -1, -1, -1, 5, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Accrued expenses", -1
    AcTypes CompanyID, 175, "Advance from customers", "175", 103, 1, -1, -1, -1, -1, -1, 5, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Advance from customers", -1
    AcTypes CompanyID, 176, "Creditors balance in sundry", "176", 103, 1, -1, -1, -1, -1, -1, 5, 2, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Creditors balance in sundry", -1
    AcTypes CompanyID, 177, "Project advance", "177", 103, 1, -1, -1, -1, -1, -1, 5, 3, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Project advance", -1
    AcTypes CompanyID, 178, "To shareholders", "178", 15, 1, -1, -1, -1, -1, -1, 4, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "To shareholders", cnstAcTypeToshareholders
    AcTypes CompanyID, 179, "To associates and subsidiaries", "179", 15, 1, -1, -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "To associates and subsidiaries", cnstAcTypeToassociatesandsubsidiaries
    AcTypes CompanyID, 180, "To other related parties", "180", 15, 1, -1, -1, -1, -1, -1, 4, 3, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "To other related parties", cnstAcTypeTootherrelatedparties

    AcTypes CompanyID, 181, "Retension payable - current portion", "16", 13, 1, "6300", -1, -1, -1, -1, 4, 4, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Retension payable - current portion", cnstAcTypeRetensionpayablecurrent
    AcTypes CompanyID, 182, "Retension payable - non current portion", "182", 7, 1, "6500", -1, -1, -1, -1, 3, 1, "Credit", -1, 1, "07/06/2010 10:10:00 AM", "07/06/2010 10:10:00 AM", 1, 1, -1, 0, "Retension payable - non current portion", -1

    AcTypes CompanyID, 183, "Depreciation", "183", 30, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Depreciation", -1
    AcTypes CompanyID, 184, "Amortisation", "184", 30, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Amortisation", -1

    AcTypes CompanyID, 185, "Contract revenue", "185", 25, 1, -1, -1, -1, -1, -1, 4, 1, "Credit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Contract revenue", -1
    AcTypes CompanyID, 186, "Trading revenue", "186", 25, 1, -1, -1, -1, -1, -1, 4, 2, "Credit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Trading revenue", -1
    AcTypes CompanyID, 187, "Service revenue", "187", 25, 1, -1, -1, -1, -1, -1, 4, 3, "Credit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Service revenue", -1

    AcTypes CompanyID, 189, "Opening stock", "189", 237, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Opening stock", -1
'    AcTypes CompanyID, 190, "Direct expenses", "190", 237, 1, -1, -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Direct expenses", -1
    AcTypes CompanyID, 191, "Closing stock", "191", 237, 1, -1, -1, -1, -1, -1, 5, 4, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Closing stock", -1

    AcTypes CompanyID, 192, "Cost of service", "192", 26, 1, "8300", -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Cost of service", cnstAcTypeCostofservice
    AcTypes CompanyID, 193, "Staff cost(apportioned)", "193", 26, 1, -1, -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Staff cost(apportioned)", -1
    AcTypes CompanyID, 194, "Other direct expenses", "194", 26, 1, -1, -1, -1, -1, -1, 4, 5, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Other direct expenses", -1
    AcTypes CompanyID, 195, "Salaries and allowances", "195", 193, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Salaries and allowances", -1
    AcTypes CompanyID, 196, "Staff benefits", "196", 193, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Staff benefits", -1
    AcTypes CompanyID, 197, "Other staff cost", "197", 193, 1, "", -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Other staff cost", -1
    AcTypes CompanyID, 199, "Fair value adjustments", "199", 97, 1, "8250", -1, -1, -1, -1, 3, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Fair value adjustments", -1
    AcTypes CompanyID, 200, "Commission and discounts", "200", 28, 1, "", -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Commission and discounts", -1
    AcTypes CompanyID, 201, "Advertisement and marketing promotions", "201", 28, 1, "", -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Advertisement and marketing promotions", -1
    AcTypes CompanyID, 202, "Selling and distribution", "202", 28, 1, "", -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Selling and distribution", -1

    AcTypes CompanyID, 203, "Travelling", "203", 29, 1, -1, -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Travelling", -1
    AcTypes CompanyID, 204, "Vehicle maintenance", "204", 29, 1, -1, -1, -1, -1, -1, 4, 5, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Vehicle maintenance", -1
    AcTypes CompanyID, 205, "Communications", "205", 29, 1, -1, -1, -1, -1, -1, 4, 7, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Communications", -1
    AcTypes CompanyID, 206, "Office maintenance", "206", 29, 1, -1, -1, -1, -1, -1, 4, 8, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Office maintenance", -1
    AcTypes CompanyID, 207, "Allowance for slow and obsolete stock", "207", 29, 1, -1, -1, -1, -1, -1, 4, 9, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Allowance for slow and obsolete stock", -1
    AcTypes CompanyID, 208, "Interest on bank borrowings", "208", 32, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Interest on bank borrowings", -1
    AcTypes CompanyID, 209, "Interest on finance lease", "209", 32, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Interest on finance lease", -1
    AcTypes CompanyID, 210, "Interest to related parties", "210", 32, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Interest to related parties", -1
    AcTypes CompanyID, 211, "Other interest", "211", 32, 1, -1, -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Other interest", -1
    AcTypes CompanyID, 212, "Management fee", "212", 31, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Management fee", -1
    AcTypes CompanyID, 213, "Directors' salaries and allowances", "213", 31, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Directors' salaries and allowances", -1
    AcTypes CompanyID, 214, "Directors' expenses", "214", 31, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/07/2010 09:10:00 AM", "07/07/2010 09:10:00 AM", 1, 1, -1, 0, "Directors' expenses", -1

    AcTypes CompanyID, 215, "Stock of trading materials", "215", 11, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Stock of trading materials", -1
    AcTypes CompanyID, 216, "Stock of raw materials", "216", 11, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Stock of raw materials", -1
    AcTypes CompanyID, 217, "Stock of finished materials", "217", 11, 1, -1, -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Stock of finished materials", -1
    AcTypes CompanyID, 218, "Stock of packing materials", "218", 11, 1, -1, -1, -1, -1, -1, 4, 4, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Stock of packing materials", -1
    AcTypes CompanyID, 219, "Stock of consumables", "219", 11, 1, -1, -1, -1, -1, -1, 4, 5, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Stock of consumables", -1
    AcTypes CompanyID, 220, "Investment properties-cost", "220", 101, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Investment properties-cost", -1
    AcTypes CompanyID, 221, "Accumulated depreciation", "221", 101, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Accumulated depreciation", -1
    AcTypes CompanyID, 222, "Copyrights and patents-cost", "222", 150, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Copyrights and patents-cost", -1
    AcTypes CompanyID, 223, "Amortisation copyrights and patents", "223", 150, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Amortisation copyrights and patents", -1
    AcTypes CompanyID, 224, "Softwares-cost", "224", 151, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Softwares-cost", -1
    AcTypes CompanyID, 225, "Amortisation software", "225", 151, 1, -1, -1, -1, -1, -1, 4, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Amortisation software", -1
    AcTypes CompanyID, 226, "Staff cost(apportioned)", "226", 28, 1, "", -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff cost(apportioned)", -1
    AcTypes CompanyID, 227, "Salaries and allowances", "227", 226, 1, "", -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Salaries and allowances", -1
    AcTypes CompanyID, 228, "Staff benefits", "228", 226, 1, "", -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff benefits", -1
    AcTypes CompanyID, 229, "Staff cost", "229", 226, 1, "", -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff cost", -1
    AcTypes CompanyID, 230, "Staff cost(apportioned)", "230", 29, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff cost(apportioned)", -1
    AcTypes CompanyID, 231, "Staff benefits", "231", 230, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff benefits", -1
    AcTypes CompanyID, 232, "Staff cost", "232", 230, 1, -1, -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Staff cost", -1
    AcTypes CompanyID, 233, "Directors' cost", "233", 230, 1, -1, -1, -1, -1, -1, 5, 4, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Directors' cost", -1
    AcTypes CompanyID, 234, "Allowance for bad debts", "234", 70, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Allowance for bad debts", -1
    AcTypes CompanyID, 235, "Bad debts", "235", 70, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Bad debts", -1
    AcTypes CompanyID, 236, "Finance income", "236", 98, 1, "8400", -1, -1, -1, -1, 3, 1, "Debit", -1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1, -1, 0, "Finance income", cnstAcTypeFinanceincome

    AcTypes CompanyID, 237, "Cost of sales", "237", 26, 1, -1, -1, -1, -1, -1, 4, 1, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Cost of sales", -1
    AcTypes CompanyID, 238, "Landed cost", "238", 237, 1, -1, -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Landed cost", -1
    AcTypes CompanyID, 239, "Contract cost", "192", 26, 1, "8300", -1, -1, -1, -1, 4, 3, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Contract cost", cnstAcTypeContractCost
    AcTypes CompanyID, 240, "Sales commission", "240", 200, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Sales commission", -1
    AcTypes CompanyID, 241, "Discount", "241", 200, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Discount", -1
    AcTypes CompanyID, 242, "Advertisement", "242", 201, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Advertisement", -1
    AcTypes CompanyID, 243, "Marketing", "243", 201, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Marketing", -1
    AcTypes CompanyID, 244, "Promotion", "244", 201, 1, -1, -1, -1, -1, -1, 5, 3, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Promotion", -1
    AcTypes CompanyID, 245, "Entertainment", "245", 201, 1, -1, -1, -1, -1, -1, 5, 4, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Entertainment", -1
    AcTypes CompanyID, 246, "Selling", "246", 202, 1, -1, -1, -1, -1, -1, 5, 1, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Selling", -1
    AcTypes CompanyID, 247, "Distribution", "247", 202, 1, -1, -1, -1, -1, -1, 5, 2, "Debit", -1, 1, "07/28/2010 04:10:00 PM", "07/28/2010 04:10:00 PM", 1, 1, -1, 0, "Distribution", -1

    AcTypes CompanyID, 248, "Net value gain on cash flow hedges", "248", 113, 1, "9200", -1, -1, -1, -1, 3, 3, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Net value gain on cash flow hedges", -1
    AcTypes CompanyID, 249, "Gain on revaluation of properties", "249", 113, 1, "9250", -1, -1, -1, -1, 3, 4, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Gain on revaluation of properties", -1
    AcTypes CompanyID, 250, "Share of other comprehensive income of associates", "250", 113, 1, "9300", -1, -1, -1, -1, 3, 5, "Credit", -1, 1, "03/03/2010 09:40:00 AM", "03/03/2010 09:40:00 AM", 1, 1, -1, 0, "Share of other comprehensive income of associates", -1

    '03 August 2010, Tuesday --------------
    AcTypes CompanyID, 251, "Current liability 1", "251", 6, 1, "6460", -1, -1, -1, -1, 3, 9, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Current liability 1", cnstAcTypeCurrentliability1
    AcTypes CompanyID, 252, "Current liability 2", "252", 6, 1, "6470", -1, -1, -1, -1, 3, 10, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Current liability 2", cnstAcTypeCurrentliability2
    AcTypes CompanyID, 253, "Current liability 3", "253", 6, 1, "6480", -1, -1, -1, -1, 3, 11, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Current liability 3", cnstAcTypeCurrentliability3

    AcTypes CompanyID, 254, "Non current liability 1", "254", 7, 1, "6760", -1, -1, -1, -1, 3, 7, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Non current liability 1", cnstAcTypeNonCurrentliability1
    AcTypes CompanyID, 255, "Non current liability 2", "255", 7, 1, "6770", -1, -1, -1, -1, 3, 8, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Non current liability 2", cnstAcTypeNonCurrentliability2
    AcTypes CompanyID, 256, "Non current liability 3", "256", 7, 1, "6780", -1, -1, -1, -1, 3, 9, "Credit", -1, 2, "08/03/2010 10:56:00 AM", "08/03/2010 10:56:00 AM", 1, 1, -1, 0, "Non current liability 3", cnstAcTypeNonCurrentliability3

    AcTypes CompanyID, 257, "Depreciation and amortisation", "257", 97, 1, "8360", -1, -1, -1, -1, 3, 5, "Debit", -1, 1, "08/08/2010 10:34:00 AM", "08/08/2010 10:34:00 AM", 1, 1, -1, 0, "Depreciation and amortisation", -1
    '06 March 2008 ---------- Contingent liability Schedule
    AcTypes CompanyID, 258, "Contingent liabilities & capital commitments", "258", -1, 1, "", -1, -1, -1, -1, 2, 1, "Credit", 0, 1, "03/06/2008 10:22:00 AM", "03/06/2008 10:22:00 AM", 1, 1, -1, 1, "Contingent liabilities & capital commitments", -1
    AcTypes CompanyID, 259, "Contingent liability", "259", 258, 1, "", -1, -1, -1, -1, 3, 1, "Credit", 0, 1, "03/06/2008 10:22:00 AM", "03/06/2008 10:22:00 AM", 1, 1, -1, 1, "Contingent liability", cnstAcTypeContingentLiability
    AcTypes CompanyID, 260, "Capital commitments", "260", 258, 1, "", -1, -1, -1, -1, 3, 2, "Credit", 0, 1, "03/06/2008 10:22:00 AM", "03/06/2008 10:22:00 AM", 1, 1, -1, 1, "Capital commitments", cnstAcTypeCapitalCommitments

    UpdateAcTypes = True
End Function

Public Function ReOrganizeCompanyDefaultData(ByVal CompanyID As Long, Optional ByVal IsShowMsg As Boolean = False) As Boolean
    UpdateAcTypes (CompanyID)
    If IsShowMsg Then
        MsgBox ("Data reorganized successfully.")
    End If
End Function

Private Sub ReportTags(TagID, TagName, TagSQL, CreateDate, UpdateDate, CreateUser, UpdateUser)
Dim sSql As String
    sSql = "SELECT * FROM ReportTags WHERE TagID = " & TagID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !TagID = TagID
            !CreateDate = CreateDate
            !CreateUser = CreateUser
        End If
        !TagName = TagName
        !TagSQL = TagSQL
        !UpdateDate = UpdateDate
        !UpdateUser = UpdateUser
        .Update
    End With
End Sub

Private Sub UpdateReportTags()
Dim dtServerDateTime As Date
    dtServerDateTime = ServerDateTime
    ReportTags 1, "Company Name", "SELECT CompanyName FROM Companies WHERE CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 2, "Company Address1", "SELECT CompanyAdd1 FROM Companies WHERE CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 3, "Company Address2", "SELECT CompanyAdd2 FROM Companies WHERE CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 4, "Company Address3", "SELECT CompanyAdd3 FROM Companies WHERE CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 5, "Fy End Date", "SELECT DATENAME(month, CONVERT(datetime, EndDt-2, 103)) + ' ' + DATENAME(day, CONVERT(datetime, EndDt-2, 103)) + ', ' + DATENAME(year, CONVERT(datetime, EndDt-2, 103)) FROM Periods WHERE PeriodID = $PeriodID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 6, "Period", "SELECT CASE WHEN (EndDt-StartDt) + 1 >= 365 THEN 'For the year ended ' + DATENAME(month, CONVERT(datetime, EndDt-2, 103)) + ' ' + DATENAME(day, CONVERT(datetime, EndDt-2, 103)) + ', ' + DATENAME(year, CONVERT(datetime, EndDt-2, 103)) ELSE 'For the period from ' + DATENAME(month, CONVERT(datetime, StartDt-2, 103)) + ' ' + DATENAME(day, CONVERT(datetime, StartDt-2, 103)) + ', ' + DATENAME(year, CONVERT(datetime, StartDt-2, 103)) + ' to ' + DATENAME(month, CONVERT(datetime, EndDt-2, 103)) + ' ' + DATENAME(day, CONVERT(datetime, EndDt-2, 103)) + ', ' + DATENAME(year, CONVERT(datetime, EndDt-2, 103)) END FROM Periods WHERE PeriodID = $PeriodID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 7, "Currency", "SELECT CM.CurrencyName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 8, "Currency Short Name", "SELECT CM.CurrencyShortName FROM Companies CMP, CurrencyMaster CM WHERE CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = $CompanyID$", dtServerDateTime, dtServerDateTime, pUserID, pUserID
    ReportTags 9, "Section Title", "SELECT '$SectionTitle$'", dtServerDateTime, dtServerDateTime, pUserID, pUserID
End Sub

Private Sub ObjectTypes(ObjectTypeID, ObjectTypeName)
Dim sSql As String
    sSql = "SELECT * FROM ObjectTypes WHERE ObjectTypeID = " & ObjectTypeID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !ObjectTypeID = ObjectTypeID
        End If
        !ObjectTypeName = ObjectTypeName
        .Update
    End With
End Sub

Private Sub AuditReportObjectTypes(ObjTypeID, ObjTypeName, ObjType)
Dim sSql As String
    sSql = "SELECT * FROM AuditReportObjectTypes WHERE ObjTypeID = " & ObjTypeID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !ObjTypeID = ObjTypeID
        End If
        !ObjTypeName = ObjTypeName
        !ObjType = ObjType
        .Update
    End With
End Sub

Private Sub UpdateObjectTypes()
    ObjectTypes 1, "Text"
    ObjectTypes 2, "Table"
    ObjectTypes 3, "Diagram"
    ObjectTypes 4, "Picture"
    ObjectTypes 5, "Page Break"
    ObjectTypes 6, "Line"
    ObjectTypes 7, "Rectangle"
    ObjectTypes 8, "Oval"
End Sub

Private Sub UpdateAuditReportObjectTypes()
    AuditReportObjectTypes 1, "Common Page Header", "Main"
    AuditReportObjectTypes 2, "Front Page", "Main"
    AuditReportObjectTypes 3, "Table of Contents", "Main"
    AuditReportObjectTypes 4, "Independent Auditor's Report", "Main"
    AuditReportObjectTypes 5, "Balance Sheet", "Main"
    AuditReportObjectTypes 6, "Statement of Income", "Main"
    AuditReportObjectTypes 7, "Shareholder's Equity", "Main"
    AuditReportObjectTypes 8, "Cash Flows", "Main"
    AuditReportObjectTypes 9, "Notes to the Financial Statements", "Main"
    AuditReportObjectTypes 10, "Sub Heading", "Sub"
    AuditReportObjectTypes 11, "Header", "Object"
    AuditReportObjectTypes 12, "Text", "Object"
    AuditReportObjectTypes 13, "Table", "Object"
End Sub

Private Sub ReportTypes(ReportTypeID, ReportTypeName)
Dim sSql As String
    sSql = "SELECT * FROM ReportTypes WHERE ReportTypeID = " & ReportTypeID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !ReportTypeID = ReportTypeID
        End If
        !ReportTypeName = ReportTypeName
        .Update
    End With
End Sub

Private Sub UpdateReportTypes()
    ReportTypes 1, "Balance Sheet"
    ReportTypes 2, "Template"
    ReportTypes 3, "Temporary"
End Sub

Private Sub TableTypes(TableTypeID, TableTypeName, ScheduleTypeID)
Dim sSql As String
    sSql = "SELECT * FROM TableTypes WHERE TableTypeID = " & TableTypeID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !TableTypeID = TableTypeID
        End If
        !TableTypeName = TableTypeName
        !ScheduleTypeID = IIf(ScheduleTypeID = -1, Null, ScheduleTypeID)
        .Update
    End With
End Sub

Private Sub UpdateTableTypes()
    TableTypes 1, "Custom Table", -1 'rptTTCustomTable
    TableTypes 2, "Table of Contents", -1 'rptTTTableOfContents
    TableTypes 3, "General Schedule", cnstScheduleTypeGeneral 'rptTTGeneralSchedule
    TableTypes 4, "Split Schedule", cnstScheduleTypeSplit 'rptTTSplitSchedule
    TableTypes 5, "Fixed Assets Schedule", cnstScheduleTypeFixedAsset 'rptTTFixedAssetsSchedule
    TableTypes 6, "Equity Schedule", cnstScheduleTypeEquity 'rptTTEquitySchedule
    TableTypes 7, "Balance Sheet", -1 'rptTTBalanceSheet
    TableTypes 8, "Cash Flow", -1 'rptTTCashFlow
    TableTypes 9, "Profit and Loss", -1 'rptTTProfitAndLoss
    TableTypes 10, "Cash and Cash Equivalents", cnstScheduleTypeCashEquivalents 'rptTTCashEquivalents
    TableTypes 11, "Contingent Liability Schedule", cnstScheduleTypeContingentLiability 'rptTTLiabilitySchedule
    TableTypes 12, "Schedules", -1 'rptTTSchedules
End Sub

Public Sub UpdateConsoleRootObjects()
On Local Error Resume Next
    '---Root Categories-------------------
    ConsoleRootObjects 1001, "Company", -1, -1, 0, 1, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 1002, "Account Types", -1, 1001, 1, 0, -1, -1, 1, 0, 0, -1, -1
    ConsoleRootObjects 1003, "Account Heads", -1, 1001, 2, 0, -1, -1, 1, 0, 0, -1, -1
    ConsoleRootObjects 1004, "Periods", -1, 1001, 3, 1, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 1005, "BIN", -1, -1, 4, 0, -1, -1, 1, 1, 0, -1, -1
    '---Main Categories-------------------
    ConsoleRootObjects 2001, "Activities", -1, 1004, 1, 0, -1, -1, 1, 0, 0, -1, -1
    'ConsoleRootObjects 2002, "Audit Procedures", -1, 1004, 2, 0, -1, -1, 1, 0, 0, -1, -1
    ConsoleRootObjects 2003, "Document Management", -1, 1004, 3, 0, -1, -1, 1, 0, 0, -1, -1
    ConsoleRootObjects 2004, "Reports", -1, 1004, 4, 0, -1, -1, 1, 0, 0, -1, -1
    ConsoleRootObjects 2005, "Reviews", -1, 1004, 4, 0, -1, -1, 1, 0, 0, -1, -1
    '---Sub Categories--------------------
    'Activities
    ConsoleRootObjects 3001, "Trial Balance", -1, 2001, 1, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3002, "Data Sheet", -1, 2001, 2, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3003, "Journal Entry", -1, 2001, 3, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3004, "Account Ledger", -1, 2001, 4, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3005, "General Schedule", -1, 2001, 5, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3006, "Split Schedule", -1, 2001, 6, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3007, "Fixed Asset Schedule", -1, 2001, 7, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3008, "Shareholders Equity", -1, 2001, 8, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3009, "Cash & Cash Equivalents Schedule", -1, 2001, 9, 0, -1, -1, 0, 0, 0, -1, -1
'    ConsoleRootObjects 3010, "Contingent Liability Schedule", -1, 2001, 10, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3011, "Cash Flow", -1, 2001, 11, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 3012, "Note No. & Caption", -1, 2001, 12, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6001, "Report Generator", -1, 2001, 13, 0, -1, -1, 0, 0, 0, -1, -1

    'Audit Procedures
    'ConsoleRootObjects 4001, "Procedure Creation", -1, 2002, 1, 0, -1, -1, 0, 0, 0, -1, -1
    'ConsoleRootObjects 4002, "Procedure Updation", -1, 2002, 2, 0, -1, -1, 0, 0, 0, -1, -1

    'Document Management
    ConsoleRootObjects 5001, "Collect Documents", -1, 2003, 1, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 5002, "Documents Summary", -1, 2003, 3, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 5003, "Collect Multiple Documents", -1, 2003, 2, 0, -1, -1, 0, 0, 0, -1, -1

    'Reports
    'Ref No : 021-10/06/08, 11th June 2008, Wednesday --------------------------------
'    ConsoleRootObjects 6001, "Report Generator", -1, 2004, 1, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6002, "TB - Detailed", -1, 2004, 1, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6003, "Balance Sheet", -1, 2004, 2, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6004, "Profit & Loss", -1, 2004, 3, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6005, "Schedules", -1, 2004, 4, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6006, "Fixed Asset Schedule", -1, 2004, 5, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6007, "Shareholder's Equity", -1, 2004, 6, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6008, "Journal Entry", -1, 2004, 7, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6009, "Cash Flow", -1, 2004, 8, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6012, "Matters Arising", -1, 2004, 9, 0, -1, -1, 0, 0, 0, -1, -1
    'Ref No: 028-26/06/08, 28th June 2008, Saturday-----------------------------------
    ConsoleRootObjects 6010, "Reviews", -1, 2004, 10, 0, -1, -1, 0, 0, 0, -1, -1
    ConsoleRootObjects 6011, "Audit Report", -1, 2004, 11, 0, -1, -1, 1, 1, 0, -1, -1

    'Reviews
    ConsoleRootObjects 7001, "Review Summary", -1, 2005, 7, 0, -1, -1, 0, 0, 0, -1, -1

    '---Object Privileges-----------------------------------------------------------------------------------------
    'Company
    ObjectPrivileges 1001, cnstObjectCompany, "Activate", "Activate Company", "Activate", -1, 1, 0, 0
    ObjectPrivileges 1002, cnstObjectCompany, "Open", "Properties", "Open", -1, 2, 1, 0
    ObjectPrivileges 1003, cnstObjectCompany, "Modify", "Modify Company", "Modify", -1, 0, 0, 1
    ObjectPrivileges 1004, cnstObjectCompany, "Close", "Close Company", "Close", -1, 0, 0, 0
'    ObjectPrivileges 1005, cnstObjectCompany, "DetachAttach", "Detach/Attach Company", "DetachAttach", -1, 0, 0, 0

    'Account Type
    ObjectPrivileges 1301, cnstObjectAccountTypes, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1302, cnstObjectAccountTypes, "New", "New Account Type", "New", -1, 2, 0, 0

    'Account Heads
    ObjectPrivileges 1401, cnstObjectAccountHeads, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1402, cnstObjectAccountHeads, "New", "New Account Head", "New", -1, 2, 0, 0

    'BIN
    ObjectPrivileges 1501, cnstObjectBIN, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1502, cnstObjectBIN, "New", "Create New Document", "New", -1, 2, 0, 0

    'Period
    ObjectPrivileges 1101, cnstObjectPeriod, "Activate", "Activate Period", "Activate", -1, 1, 0, 0
    ObjectPrivileges 1102, cnstObjectPeriod, "Open", "Properties", "Open", -1, 2, 1, 0
    ObjectPrivileges 1103, cnstObjectPeriod, "New", "New Period", "New", -1, 3, 0, 0
    ObjectPrivileges 1104, cnstObjectPeriod, "Modify", "Modify Period", "Modify", -1, 4, 0, 0
    ObjectPrivileges 1105, cnstObjectPeriod, "Close", "Close Period", "Close", -1, 0, 0, 0

    'Trial Balance
    ObjectPrivileges 1202, cnstObjectTrialBalance, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1204, cnstObjectTrialBalance, "Modify", "Modify TrialBalance", "Modify", -1, 3, 0, 1

    'Data Sheet
    ObjectPrivileges 1205, cnstObjectDataSheet, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1206, cnstObjectDataSheet, "Modify", "Modify DataSheet", "Modify", -1, 3, 0, 1

    'Journal Entry
    ObjectPrivileges 1601, cnstObjectJournal, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1602, cnstObjectJournal, "New", "New Journal", "New", -1, 1, 0, 0
    ObjectPrivileges 1603, cnstObjectJournal, "Modify", "Modify Journal", "Modify", -1, 1, 0, 0

    'Ledger
    ObjectPrivileges 1701, cnstObjectAccountLedger, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1702, cnstObjectAccountLedger, "Modify", "Modify Journal", "Modify", -1, 1, 0, 1

    'General Schedule
    ObjectPrivileges 1801, cnstObjectGeneralSchedule, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1802, cnstObjectGeneralSchedule, "Modify", "Modify General Schedule", "Modify", -1, 1, 0, 1

    'Split Schedule
    ObjectPrivileges 1901, cnstObjectSplitSchedule, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 1902, cnstObjectSplitSchedule, "Modify", "Modify Split Schedule", "Modify", -1, 1, 0, 1

    'Fixed Asset Schedule
    ObjectPrivileges 2301, cnstObjectFixedAssetSchedule, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2302, cnstObjectFixedAssetSchedule, "Modify", "Modify Fixed Asset Schedule", "Modify", -1, 1, 0, 1

    'Equity Schedule
    ObjectPrivileges 2101, cnstObjectShareHoldersEquity, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2102, cnstObjectShareHoldersEquity, "Modify", "Modify Shareholders Equity", "Modify", -1, 1, 0, 1

    'Cash Flow
    ObjectPrivileges 2201, cnstObjectCashFlow, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2202, cnstObjectCashFlow, "Modify", "Modify Cash Flow", "Modify", -1, 1, 0, 1

    'Cash & Cash Equivalents Schedule
    ObjectPrivileges 2001, cnstObjectCashEquivalents, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2002, cnstObjectCashEquivalents, "Modify", "Modify Cash Equivalents Schedule", "Modify", -1, 1, 0, 1

    'Contingent Liability Schedule
    ObjectPrivileges 2701, cnstObjectContingentLiability, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2702, cnstObjectContingentLiability, "Modify", "Modify Liability Schedule", "Modify", -1, 1, 0, 1

    'Note No. & Caption
    ObjectPrivileges 2801, cnstObjectNoteNoCaption, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2802, cnstObjectNoteNoCaption, "Modify", "Modify Note No. & Caption", "Modify", -1, 1, 0, 1

    'Document Management
    ObjectPrivileges 2401, cnstObjectCollectDocuments, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2402, cnstObjectDocumentAttachment, "Open", "Open", "Open", -1, 1, 1, 0
    ObjectPrivileges 2403, cnstObjectCollectMultipleDocuments, "Open", "Open", "Open", -1, 1, 1, 0

    'Reports
    ObjectPrivileges 2501, cnstObjectReportRptGenerator, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2502, cnstObjectReportBalanceSheet, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2503, cnstObjectReportProfitAndLoss, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2504, cnstObjectReportSchedules, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2505, cnstObjectReportCashFlow, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2506, cnstObjectReportAuditReport, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2507, cnstObjectReportFixedAsset, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2508, cnstObjectReportEquity, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2509, cnstObjectReportJournal, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2510, cnstObjectReportReviews, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2511, cnstObjectReportTBDetail, "Open", "Open Report", "Open", -1, 1, 1, 0
    ObjectPrivileges 2512, cnstObjectReportMattersArising, "Open", "Open Report", "Open", -1, 1, 1, 0
    'Reviews
    ObjectPrivileges 2601, cnstObjectReviews, "Open", "Open", "Open", -1, 1, 1, 0

    'DELETE UNNECESSORY OBJECT DECLARATIONS
    DeleteConsoleRootObjects 4001
    DeleteConsoleRootObjects 4002
    DeleteConsoleRootObjects 2002
'    DeleteConsoleRootObjects 6001
    DeleteConsoleRootObjects 3010
    
    DeleteObjectPrivileges 2701
    DeleteObjectPrivileges 2702
    
    DeleteObjectPrivileges 1005
End Sub

Private Sub DeleteConsoleRootObjects(ObjectID As Long)
Dim sSql As String
    sSql = "DELETE FROM ObjectPrivileges WHERE ObjectID = " & ObjectID
    ExeSQL = sSql
    sSql = "DELETE FROM ConsoleRootObjects WHERE ObjectID = " & ObjectID
    ExeSQL = sSql
End Sub

Private Sub DeleteObjectPrivileges(PrvlID As Long)
Dim sSql As String
    sSql = "DELETE FROM ObjectPrivileges WHERE PrvlID = " & PrvlID
    ExeSQL = sSql
End Sub

Private Sub ConsoleRootObjects(ObjectID, ObjectName, DisplayName, ParentObjectID, DisplayOrder, IsVirtual, FontName, FontSize, IsBold, IsItalic, IsUnderlined, ForeColor, BackColor)
Dim sSql As String
    sSql = "SELECT * FROM ConsoleRootObjects WHERE ObjectID = " & ObjectID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !ObjectID = ObjectID
        End If
        !ObjectName = ObjectName
        !DisplayName = IIf(DisplayName = -1, Null, DisplayName)
        !ParentObjectID = IIf(ParentObjectID = -1, Null, ParentObjectID)
        !DisplayOrder = IIf(DisplayOrder = -1, Null, DisplayOrder)
        !IsVirtual = IsVirtual
        !FontName = IIf(FontName = -1, Null, FontName)
        !FontSize = IIf(FontSize = -1, Null, FontSize)
        !IsBold = IsBold
        !IsItalic = IsItalic
        !IsUnderlined = IsUnderlined
        !ForeColor = IIf(ForeColor = -1, Null, ForeColor)
        !BackColor = IIf(BackColor = -1, Null, BackColor)
        .Update
    End With
End Sub

Private Sub ObjectPrivileges(PrvlID, ObjectID, PrvlName, DisplayName, Command, ParentPrvlID, DisplayOrder, IsObjectPrvl, IsHidden)
Dim sSql As String
    sSql = "SELECT * FROM ObjectPrivileges WHERE PrvlID = " & PrvlID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !PrvlID = PrvlID
        End If
        !ObjectID = ObjectID
        !PrvlName = PrvlName
        !DisplayName = IIf(DisplayName = -1, Null, DisplayName)
        !Command = Command
        !ParentPrvlID = IIf(ParentPrvlID = -1, Null, ParentPrvlID)
        !DisplayOrder = IIf(DisplayOrder = -1, Null, DisplayOrder)
        !IsObjectPrvl = IsObjectPrvl
        !IsHidden = IsHidden
        .Update
    End With
End Sub

Public Sub UpdateHelp()
On Local Error Resume Next
Dim strHelp As String
    Help 1, "Form", "frmNavigator", "Navigator"
    Help 2, "Form", "frmPeriods", "You can manipulate periods under an active company. Period short name and audit types are mandatory elements."
    Help 3, "Form", "frmAcHeads", "This screen will help you to handle account heads under a particular account type. Trial order is the display order of the particular account head in the data sheet."
    strHelp = "DATA SHEET" & vbNewLine & _
              "F6 -> Create New Account Head" & vbNewLine & _
              "F7 -> Create New Account Type" & vbNewLine & _
              "F4 -> Open with properties" & vbNewLine & _
              "Ctrl + S -> Save" & vbNewLine & _
              "Ctrl + 8 -> Print Balance Sheet" & vbNewLine & _
              "Ctrl + L -> Lock Datasheet"
    Help 4, "Form", "frmTrialBalance", strHelp
End Sub

Private Sub Help(HelpID, HelpTypeID, HelpName, Description)
Dim sSql As String
    sSql = "SELECT * FROM Help WHERE HelpID = " & HelpID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !HelpID = HelpID
        End If
        !HelpTypeID = HelpTypeID
        !HelpName = HelpName
        !Description = Description
        .Update
    End With
End Sub

Private Sub fn_GetAcTypeBal()
On Local Error Resume Next
    AddSQL = "$CLEAR$"
    AddSQL = " FUNCTION dbo.fn_GetAcTypeBal(@AcTypeID int, @PeriodID int) RETURNS float AS"
    AddSQL = "begin"
    AddSQL = "DECLARE @CurAcTypes Cursor, @RetVal float, @RetValTmp float, @TmpAcTypeID int"
    AddSQL = "set @RetVal=0"
    AddSQL = "set @RetValTmp=0"
    AddSQL = "SELECT @RetValTmp = ISNULL(SUM(ESA.DAmt), 0) - ISNULL(SUM(ESA.CAmt),0) FROM EntrySubAccounts ESA, Entries EM, AcHeads AH1 WHERE ESA.EntryID = EM.EntryID AND ESA.AcID = AH1.AcID AND AH1.AcTypeID = @AcTypeID And EM.PeriodID = @PeriodID"
    AddSQL = "SET @RetVal = ISNULL(@RetVal, 0) + ISNULL(@RetValTmp, 0)"
    AddSQL = "SET @CurAcTypes = Cursor for Select AcTypeID From AcTypes Where ParentAcTypeID = @AcTypeID"
    AddSQL = "OPEN @CurAcTypes"
    AddSQL = "FETCH NEXT FROM @CurAcTypes INTO @TmpAcTypeID"
    AddSQL = "WHILE @@Fetch_Status <> -1"
    AddSQL = "begin"
    AddSQL = "  SET @RetVal = ISNULL(@RetVal, 0) + ISNULL(dbo.fn_GetAcTypeBal(@TmpAcTypeID, @PeriodID), 0)"
    AddSQL = "  FETCH NEXT FROM @CurAcTypes INTO @TmpAcTypeID"
    AddSQL = "End"
    AddSQL = "RETURN ISNULL(@RetVal, 0)"
    AddSQL = "END"
    ExeSQL = "CREATE " & AddSQL
    ExeSQL = "ALTER " & AddSQL
    AddSQL = "$CLEAR$"
End Sub

Public Property Get AddSQL() As String
    AddSQL = mstrAddSql
End Property

Public Property Let AddSQL(ByRef strNewValue As String)
    If strNewValue = "$CLEAR$" Then
        mstrAddSql = ""
    Else
        mstrAddSql = mstrAddSql & strNewValue & vbCrLf
    End If
End Property

Public Function FormatValue(ByVal varValue As Variant) As String
    Select Case TypeName(varValue)
        Case "Long", "Integer"
            FormatValue = IIf(varValue = -1, "NULL", varValue)
        Case "Boolean"
            FormatValue = IIf(varValue, 1, 0)
        Case "String"
            If varValue = "-1" Then
                FormatValue = "NULL"
            Else
                FormatValue = "'" & Replace(varValue, "'", "' + CHAR(39) + '") & "'"
            End If
    End Select
End Function

Public Function FilingSubSection(SubSectionID, SectionID, RefNo, Description, AcTypeID, TrialOrder)
Dim sSql As String
    sSql = "SELECT * FROM FilingSubSection WHERE SubSectionID = " & SubSectionID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !SubSectionID = SubSectionID
        End If
        !SectionID = SectionID
        !RefNo = RefNo
        !Description = Description
        !AcTypeID = IIf(AcTypeID = -1, Null, AcTypeID)
        !TrialOrder = IIf(TrialOrder = -1, Null, TrialOrder)
        .Update
    End With
End Function

Public Function UpdateFilingSubSection()
    FilingSubSection 1, 1, 1100, "Client service plan", -1, -1
'    Ref No:005/07 ----------------
    FilingSubSection 2, 1, 1200, "Establish terms of engagement", -1, -1
    FilingSubSection 3, 1, 1300, "Understanding the client's business", -1, -1
    FilingSubSection 4, 1, 1400, "Overview of the accounting process", -1, -1
    FilingSubSection 5, 1, 1500, "Determine planning materiality", -1, -1
    FilingSubSection 6, 2, 2100, "Financial statements", -1, -1
    FilingSubSection 7, 2, 2200, "Financial statement - Analysis", -1, -1
    FilingSubSection 8, 2, 2300, "Audit summary", -1, -1
    FilingSubSection 9, 2, 2400, "Going - Concern Considerations Program", -1, -1
    FilingSubSection 10, 2, 2500, "Other reporting", -1, -1
    FilingSubSection 11, 3, 3100, "Audit resources & timeTable", -1, -1
    FilingSubSection 12, 3, 3200, "Client meetings", -1, -1
    FilingSubSection 13, 3, 3300, "Client communications and correspondence", -1, -1
    FilingSubSection 14, 4, 4100, "Revenue Cycle", -1, -1
    FilingSubSection 15, 4, 4200, "Expenditure Cycle", -1, -1
    FilingSubSection 16, 4, 4300, "Inventory Cycle", -1, -1
    FilingSubSection 17, 4, 4400, "Payroll Cycle", -1, -1
    FilingSubSection 18, 4, 4500, "Fixed Assets Cycle", -1, -1
    FilingSubSection 19, 5, 5100, "Cash & cash equivalents", cnstAcTypeCashAndBankBalances, 1
    FilingSubSection 20, 5, 5200, "Accounts receivables", cnstAcTypeTradeReceivables, 3
    FilingSubSection 21, 5, 5250, "Other receivables", cnstAcTypeOtherReceivables, 4
    FilingSubSection 22, 5, 5300, "Due from related parties", cnstAcTypeDuefromRelated, 5
    FilingSubSection 23, 5, 5500, "Inventories", cnstAcTypeInventories, 10
    FilingSubSection 24, 6, 5650, "Investments in subsidiaries and joint venture", cnstAcTypeInvestmentsinSubsidiariesandJointVenture, 14
    FilingSubSection 25, 6, 5850, "Property & equipments", cnstAcTypeProperty, 18
    FilingSubSection 26, 6, 5900, "Intangible assets", cnstAcTypeIntangibleAssets, 17
    FilingSubSection 27, 7, 6100, "Accounts payables", cnstAcTypeTradePayables, 22
    FilingSubSection 28, 7, 6200, "Other payables", cnstAcTypeOtherPayables, 24
    FilingSubSection 29, 7, 6250, "Due to related parties", cnstAcTypeDuetoRelated, 25
    FilingSubSection 30, 7, 6300, "Bank borrowings", cnstAcTypeBankBorrowings, 26
    FilingSubSection 31, 7, 6350, "Obligation under finance lease", cnstAcTypeObligation, 29
'    FilingSubSection 32, 7, 6400, "Other long term liabilities", cnstAcTypeOtherLongTermLiablities, 21
    FilingSubSection 33, 8, 7100, "Equity", cnstAcTypeShareHoldersEquity, 37
    FilingSubSection 34, 9, 8100, "Revenue", cnstAcTypeRevenue, 38
    FilingSubSection 35, 9, 8200, "Cost of sales", cnstAcTypeCostofSales, 39
    FilingSubSection 36, 9, 8300, "Other income", cnstAcTypeOtherIncome, 40
    FilingSubSection 37, 9, 8400, "Operating expenses", cnstAcTypeOperatingExpenses, 41
    FilingSubSection 38, 9, 8500, "Non operating expenses", cnstAcTypeNonOperatingExpenses, 42
    FilingSubSection 39, 10, 9100, "Contingent liability", cnstAcTypeContingentLiability, 43
    FilingSubSection 40, 10, 9200, "Capital commitments", cnstAcTypeCapitalCommitments, 44
    ' Ref No: 028-26/06/08, 26th June 2008, Thursday -----------
    FilingSubSection 50, 11, 9500, "General Review Points", -1, 45
    ' 29 March 2010, Monday --------------
    FilingSubSection 51, 5, 5150, "Other financial assets", cnstAcTypeOtherFinancialAssets, 2
    FilingSubSection 52, 5, 5350, "Advance against aquisition of land", cnstAcTypeAdvanceAgainstAquisitionofLand, 6
    FilingSubSection 53, 5, 5400, "Investment properties held for sale", cnstAcTypeInvestmentPropertiesheldforSale, 7
    FilingSubSection 54, 5, 5450, "Development properties", cnstAcTypeDevelopmentProperties, 8
    FilingSubSection 55, 6, 5600, "Available for sale financial assets", cnstAcTypeAvailableforsalefinancialassets, 14
    FilingSubSection 56, 6, 5800, "Investment properties", cnstAcTypeInvestmentProperties, 15
    FilingSubSection 57, 7, 6150, "Advance from customers", cnstAcTypeAdvancefromCustomers, 23
    ' 27 May 2010, Thursday -------------
    FilingSubSection 58, 5, 5560, "Current Assets 1", cnstAcTypeCurrentAssets1, 11
    FilingSubSection 59, 5, 5570, "Current Assets 2", cnstAcTypeCurrentAssets2, 12
    FilingSubSection 60, 5, 5580, "Current Assets 3", cnstAcTypeCurrentAssets3, 13

    FilingSubSection 61, 6, 5910, "Non Current Assets 1", cnstAcTypeNonCurrentAssets1, 19
    FilingSubSection 62, 6, 5920, "Non Current Assets 2", cnstAcTypeNonCurrentAssets2, 20
    FilingSubSection 63, 6, 5930, "Non Current Assets 3", cnstAcTypeNonCurrentAssets3, 21
    FilingSubSection 64, 7, 6800, "Provision for employees` end of service indemnity", cnstAcTypeProvisionforEmployees, 33
    FilingSubSection 65, 3, 3000, "Legal and Other Documents", -1, -1
    
    FilingSubSection 66, 5, 5500, "Trading investments", cnstAcTypeTradingInvestments, 9
    ' FilingSubSection 67, 6, 5650, "Investments in associates & subsidiaries", cnstAcTypeInvestmentsinSubsidiariesandJointVenture, 16
    FilingSubSection 68, 7, 6350, "Secured/Unsecured loan", cnstAcTypeSecuredUnsecuredloanCurrent, 27
    FilingSubSection 69, 7, 6400, "Advance received against development", cnstAdvancereceivedagainstdevelopmentproperties, 28
    FilingSubSection 70, 7, 6460, "Current liability 1", cnstAcTypeCurrentliability1, 30
    FilingSubSection 71, 7, 6470, "Current liability 2", cnstAcTypeCurrentliability2, 31
    FilingSubSection 72, 7, 6480, "Current liability 3", cnstAcTypeCurrentliability3, 32
    
    FilingSubSection 73, 7, 6760, "Non current liability 1", cnstAcTypeNonCurrentliability1, 34
    FilingSubSection 74, 7, 6770, "Non current liability 2", cnstAcTypeNonCurrentliability2, 35
    FilingSubSection 75, 7, 6780, "Non current liability 3", cnstAcTypeNonCurrentliability3, 36
    
End Function

Public Function FilingSection(SectionID, RefNo, Description, IsStringData)
Dim sSql As String
    sSql = "SELECT * FROM FilingSections WHERE SectionID = " & SectionID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !SectionID = SectionID
        End If
        !RefNo = RefNo
        !Description = Description
        !IsStringData = IsStringData
        .Update
    End With
End Function

Public Function UpdateFilingSection()
    FilingSection 1, 1000, "Planning", 1
    FilingSection 2, 2000, "Reporting", 1
    FilingSection 3, 3000, "Audit Management", 0
    FilingSection 4, 4000, "Controls", 1
    FilingSection 5, 5000, "Current Assets", 0
    FilingSection 6, 5100, "Non Current Assets", 0
    FilingSection 7, 6000, "Liabilities", 0
    FilingSection 8, 7000, "Equity", 0
    FilingSection 9, 8000, "Income & Expenditure", 0
    FilingSection 10, 9000, "Others", 0
    ' Ref No: 028-26/06/08, 26th June 2008, Thursday -----------
    FilingSection 11, 9500, "General Reviews", 0
End Function

Public Function UserAccess(UserAccessID, UserAccessName, UserAccessDescription, OrderField)
Dim sSql As String
    sSql = "SELECT * FROM UserAccess WHERE UserAccessID = " & UserAccessID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !UserAccessID = UserAccessID
        End If
        !UserAccessName = UserAccessName
        !UserAccessDescription = UserAccessDescription
        !OrderField = OrderField
        .Update
    End With
End Function

Public Function UpdateUserAccess()
    UserAccess 1, "Data Entry", "Trial Balance", 1
    UserAccess 2, "Journal Entries", "JV", 2
    UserAccess 3, "Audit Filing", "Filing Section", 3
    UserAccess 4, "Scheduling", "Schedule Processing", 4
    UserAccess 5, "Audit Reporting", "Report Designing", 5
    UserAccess 6, "Review Queries", "Reviews", 6
    UserAccess 7, "Detach DataBase", "Detaching DataBase", 7
End Function

Public Function UserGroups(UserGroupID, UserGroupName, OrderField)
Dim sSql As String
    sSql = "SELECT * FROM UserGroups WHERE UserGroupID = " & UserGroupID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !UserGroupID = UserGroupID
        End If
        !UserGroupName = UserGroupName
        !OrderField = OrderField
        .Update
    End With
End Function

Public Function UpdateUserGroups()
    UserGroups 1, "Partner", 1
    UserGroups 2, "Manager", 2
    UserGroups 3, "Auditor", 3
    UserGroups 4, "Audit Support Staff", 4
End Function

Public Function ScheduleTypes(ScheduleTypeID, ScheduleTypeName)
Dim sSql As String
    sSql = "SELECT * FROM ScheduleTypes WHERE ScheduleTypeID = " & ScheduleTypeID
    With GetRecords(sSql)
        If .BOF Then
            .AddNew
            !ScheduleTypeID = ScheduleTypeID
        End If
        !ScheduleTypeName = ScheduleTypeName
        .Update
    End With
End Function

Public Sub UpdateScheduleTypes()
    ScheduleTypes 1, "General Schedule"
    ScheduleTypes 2, "Split Schedule"
    ScheduleTypes 3, "Fixed Asset Schedule"
    ScheduleTypes 4, "Equity Schedule"
    ScheduleTypes 5, "Cash and Cash Equivalents"
End Sub

Public Function AcHeads(ByVal CompanyID, ByVal AcID, ByVal AcName, ByVal AcCode, ByVal AcTypeID, ByVal TrialOrder, _
                        ByVal StatusID, ByVal CreateDate, ByVal UpdateDate, ByVal CreateUser, ByVal UpdateUser)
On Local Error Resume Next
Dim sSql As String, lngPrefix As Long, tmpAcHeadID As Long
Dim lngAcTypeID As Long
    lngAcTypeID = CompanyID * cnstAcTypeMaxCount
    lngPrefix = CompanyID * cnstAcHeadMaxCount
    tmpAcHeadID = lngPrefix + AcID
        With GetRecords("Select * From AcHeads Where AcID = " & tmpAcHeadID)
            If .EOF Then
                .AddNew
                !AcID = tmpAcHeadID
            End If
            !CompanyID = IIf(CompanyID = -1, Null, CompanyID)
            !AcName = IIf(AcName = -1, Null, AcName)
            !AcCode = IIf(AcCode = -1, Null, AcCode)
            !AcTypeID = IIf(AcTypeID = -1, Null, lngAcTypeID + AcTypeID)
            !TrialOrder = IIf(TrialOrder = -1, Null, TrialOrder)
            !StatusID = IIf(StatusID = -1, Null, StatusID)
            !CreateDate = IIf(CreateDate = -1, Null, CreateDate)
            !UpdateDate = IIf(UpdateDate = -1, Null, UpdateDate)
            !CreateUser = IIf(CreateUser = -1, Null, CreateUser)
            !UpdateUser = IIf(UpdateUser = -1, Null, UpdateUser)
            .Update
        End With
End Function

Public Function UpdateAcHeads(ByVal CompanyID As Long) As Boolean
    AcHeads CompanyID, 1, "Labour guarantee", "1", 141, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 2, "Sundry debtors as per list", "2", 37, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 3, "Retention receivables", "3", 131, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 4, "Allowance for bad debts", "4", 73, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 5, "PDC received", "5", 143, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 6, "Unbilled receivable", "6", 144, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 7, "Goods in transit", "7", 43, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 8, "Work in progress", "8", 44, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 9, "Retention receivables-non current portion", "9", 137, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 12, "Buildings", "12", 220, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 13, "Land", "13", 220, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 14, "Buildings", "14", 221, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 15, "Land", "15", 221, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 16, "Goodwill", "16", 152, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 17, "Amortisation-goodwill", "17", 153, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 18, "Copyrights", "18", 222, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 19, "Patents", "19", 222, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 20, "Amortisation-copyrights", "20", 223, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 21, "Amortisation-patents", "21", 223, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 22, "Software", "22", 224, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 23, "Amortisation-software", "23", 225, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 24, "Sundry creditors as per list", "24", 166, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 25, "Sub-contractors as per list", "25", 167, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 26, "Accrued purchases", "26", 168, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 27, "PDC payable", "27", 171, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 28, "Salary payables", "28", 56, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 29, "Leave salary", "29", 55, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 30, "Air ticket", "30", 55, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 31, "Bonus", "31", 55, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 32, "Advance from customers", "32", 175, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 34, "Credit balance in sundry debtors", "34", 175, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 35, "Excess invoiced", "35", 172, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 36, "Opening balance", "36", 19, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 37, "Charge for the year", "37", 19, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 38, "Payments during the year", "38", 19, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 39, "Excess provision written back", "39", 19, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 40, "Basic salary", "40", 195, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 41, "Allowances", "41", 195, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 42, "Leave salary", "42", 196, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 43, "Air ticket", "43", 196, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 44, "Bonus", "44", 196, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 45, "Insurance", "45", 196, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 46, "Housing/rent", "46", 197, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 47, "Medical expenses", "47", 197, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 48, "Visa cost", "48", 197, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 49, "Welfare", "49", 197, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 50, "Utilities", "50", 197, 5, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 51, "Depreciation", "51", 194, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 52, "Sales commission", "52", 200, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 53, "Discount", "53", 200, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 54, "Advertisement", "54", 201, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 55, "Marketing", "55", 201, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 56, "Promotion", "56", 201, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 57, "Entertainment", "57", 201, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 58, "Selling", "58", 202, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 59, "Distribution", "59", 202, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 60, "Basic salary", "60", 227, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 61, "Allowances", "61", 227, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 62, "Leave salary", "62", 228, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 63, "Air ticket", "63", 228, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 64, "Bonus", "64", 228, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 65, "Insurance", "65", 228, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 66, "Housing/rent", "66", 229, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 67, "Medical expenses", "67", 229, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 68, "Visa cost", "68", 229, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 69, "Welfare", "69", 229, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 70, "Utilities", "70", 229, 5, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 71, "Basic salary", "71", 67, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 72, "Allowances", "72", 67, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 73, "Leave salary", "73", 231, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 74, "Air ticket", "74", 231, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 75, "Bonus", "75", 231, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 76, "Insurance", "76", 231, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 77, "Housing/rent", "77", 232, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 78, "Medical expenses", "78", 232, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 79, "Visa cost", "79", 232, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 80, "Welfare", "80", 232, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 81, "Utilities", "81", 232, 5, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 82, "Directors' salaries and allowances", "82", 233, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 83, "Directors' expenses", "83", 233, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 84, "Office rent", "84", 68, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 85, "Audit fee", "85", 69, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 86, "Accounting charges", "86", 69, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 87, "Licensing fee", "87", 69, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 88, "Sponsorship fee", "88", 69, 4, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 89, "Allowance", "89", 234, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 90, "Bad debts", "90", 235, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 91, "Telephone charges", "91", 205, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 92, "Internet charges", "92", 205, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 93, "Postage and courier", "93", 205, 3, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 94, "Allowance for slow moving stock", "94", 207, 1, 1, "28/07/2010 04:25:00 PM", "28/07/2010 04:25:00 PM", 1, 1
'    AcHeads CompanyID, 95, "Depreciation", "95", 30, 1, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
'    AcHeads CompanyID, 96, "Amortisation", "96", 30, 2, 1, "26/07/2010 01:25:00 PM", "26/07/2010 01:25:00 PM", 1, 1
    AcHeads CompanyID, 97, "Interest on fixed deposits", "97", 236, 1, 1, "28/07/2010 04:25:00 PM", "28/07/2010 04:25:00 PM", 1, 1
    AcHeads CompanyID, 98, "Management fee", "98", 212, 1, 1, "28/07/2010 04:25:00 PM", "28/07/2010 04:25:00 PM", 1, 1
    AcHeads CompanyID, 99, "Retension payable-current portion", "99", 181, 1, 1, "28/07/2010 04:25:00 PM", "28/07/2010 04:25:00 PM", 1, 1
    
    UpdateAcHeads = True
End Function
