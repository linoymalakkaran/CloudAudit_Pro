Attribute VB_Name = "mdlDatabase"
Option Explicit

Dim mlngCompanyID As Long
Dim mcnnClient As New ADODB.Connection, mblnDetach As Boolean
Dim mstrServerFrom As String, mstrServerTo As String
Dim mcnnFrom As ADODB.Connection, mcnnTo As ADODB.Connection
Dim mcnnFromDoc As New ADODB.Connection, mcnnToDoc As New ADODB.Connection
Dim mcnnToBak As New ADODB.Connection, mcnnToDocBak As New ADODB.Connection

Public Function GetRecords(sSql As String, Optional AdoConnection As ADODB.Connection = Nothing, Optional lngErrNo As Long, Optional ByVal SuppressErrMsg As Boolean = False) As Recordset
On Local Error GoTo Err_Exit
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    Set GetRecords = New ADODB.Recordset
    GetRecords.Open sSql, AdoConnection, adOpenKeyset, adLockOptimistic
Exit Function
Err_Exit:
    lngErrNo = Err.Number
    If Not SuppressErrMsg Then
        ShowError
    End If
    Set GetRecords = Nothing
End Function

Public Function IsFieldExists(TableName As String, FieldName As String, Optional AdoConnection As ADODB.Connection = Nothing) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    IsFieldExists = False
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    sSql = "Select " & FieldName & " AS Nos from " & TableName
    With AdoConnection.Execute(sSql)
        If .State = adStateOpen Then IsFieldExists = True
        .Close
    End With
Exit Function
Err_Exit:
     IsFieldExists = False
End Function

' Returns one value according to the Query
Public Function PickValue(Table As String, PickField As String, Optional Pattern As String = "", Optional AdoConnection As ADODB.Connection = Nothing) As String
On Local Error Resume Next
Dim rsTmp As New ADODB.Recordset, sSql As String
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    If Pattern <> "" Then
        Pattern = " AND " & Pattern
    End If
    sSql = "SELECT Top 1 " & PickField & " AS CodeVal from " & Table & " WHERE 1=1 " & Pattern
    rsTmp.Open sSql, AdoConnection, adOpenKeyset, adLockOptimistic
    With rsTmp
        If Not .EOF Then
            PickValue = !CodeVal & ""
        Else
            PickValue = ""
        End If
    End With
    rsTmp.Close
    Set rsTmp = Nothing
End Function

' Returning Maximum number
Public Function GetMaxNo(Table As String, Field As String, Optional Pattern As String, Optional AdoConnection As ADODB.Connection = Nothing) As Long
On Local Error GoTo Err_Exit
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    With AdoConnection.Execute("Select Max(" & Field & ")as CodeVal from " & Table & IIf(Trim(Pattern) = "", "", " Where " & Pattern))
        If .EOF Then
            GetMaxNo = 1
        Else
            GetMaxNo = IIf(IsNull(.Fields(0)), 1, .Fields(0) + 1)
        End If
    End With
Exit Function
Err_Exit:
    GetMaxNo = 1
End Function

Public Function GetRangeMaxNo(Table As String, Field As String, Optional RangeFrom As Long, Optional RangeTo As Long, Optional AdoConnection As ADODB.Connection = Nothing) As Long
On Local Error GoTo Err_Exit
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    With AdoConnection.Execute("Select ISNULL(Max(" & Field & "), " & RangeFrom & ") AS CodeVal from " & Table & " Where " & Field & " Between " & RangeFrom & " And " & RangeTo)
        If .EOF Then
            GetRangeMaxNo = 1
        Else
            GetRangeMaxNo = IIf(IsNull(.Fields(0)), 1, .Fields(0) + 1)
        End If
    End With
Exit Function
Err_Exit:
    GetRangeMaxNo = 1
End Function

' Returning lower missing number
Public Function GetMissingNo(Table As String, Field As String, Optional Pattern As String, Optional AdoConnection As ADODB.Connection = Nothing, Optional lngMinNumber As Long = 1) As Integer
On Local Error GoTo Err_Exit
Dim sSql As String
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    ' Req No: 219/07-01
    sSql = "SELECT MIN(" & Field & " + 1) AS CodeVal FROM (SELECT T1." & Field & " FROM [" & Table & "] T1 " & IIf(Trim(Pattern) = "", "", " Where " & Pattern) & " Union SELECT " & lngMinNumber - 1 & " AS " & Field & ") DD WHERE ((" & Field & " + 1) NOT IN (SELECT T2." & Field & " FROM [" & Table & "] T2 " & IIf(Trim(Pattern) = "", "", " Where " & Pattern) & "))"
    With AdoConnection.Execute(sSql)
        If .EOF Then
            GetMissingNo = 1
        Else
            GetMissingNo = IIf(IsNull(.Fields(0)), 1, .Fields(0))
        End If
        .Close
    End With
Exit Function
Err_Exit:
    GetMissingNo = 1
End Function

Public Function SQLIsTableExists(ByVal strTable As String, Optional AdoConnection As ADODB.Connection = Nothing) As Boolean
On Local Error Resume Next
Dim AdoCatalog As New ADOX.Catalog, tblTmp As ADOX.Table, rsExec As New ADODB.Recordset
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    SQLIsTableExists = False
    Set AdoCatalog.ActiveConnection = AdoConnection
    Err.Clear
    Set tblTmp = AdoCatalog.Tables(strTable)
    ' rsExec.Open "select * from " & strTable & " Where 1=2", AdoConnection, adOpenKeyset, adLockOptimistic
    If Err.Number = 0 Then
        SQLIsTableExists = True
    End If
    ' rsExec.Close
    Set AdoCatalog = Nothing
End Function

Public Function SQLIsFieldExists(ByVal strTable As String, ByVal strField As String, Optional AdoConnection As ADODB.Connection = Nothing) As Boolean
On Local Error Resume Next
Dim AdoCatalog As New ADOX.Catalog, clmTmp As ADOX.Column
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    AdoCatalog.ActiveConnection = AdoConnection
    Err.Clear
    Set clmTmp = AdoCatalog.Tables(strTable).Columns(strField)
    If Err.Number = 0 Then
        SQLIsFieldExists = True
    End If
End Function

Private Sub KillOldFile(ByVal strFileName As String)
On Local Error Resume Next
    Kill strFileName
End Sub

Public Function GetLogicalName(FileType As Integer) As String
On Local Error Resume Next
Dim sSql As String
    sSql = "Select Name From dbo.sysfiles where fileid =" & FileType
    With GetRecords(sSql)
        If Not .EOF Then
            GetLogicalName = Trim(.Fields("Name") & "")
        End If
        .Close
    End With
End Function

Public Function BackupDatabase(Optional strBackupFileName As String = "") As Boolean
On Local Error GoTo Err_Exit
    ' Write a code to transfer data to backup database
    BackupDatabase = True
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    BackupDatabase = False
    ShowError
End Function

Public Sub SaveDateAndUser(rsCurrent As Recordset, Optional IsCreate As Boolean = True)
On Local Error GoTo Err_Exit
    With rsCurrent
        If IsCreate Then
            .Fields("CreateDate") = ServerDateTime
            .Fields("CreateUser") = pUserID
        End If
        .Fields("UpdateDate") = ServerDateTime
        .Fields("UpdateUser") = pUserID
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function GetMaxEntryID(lngPeriodID As Long) As Long
On Local Error GoTo Err_Exit
Dim lngEntryIDMin As Long, lngEntryIDMax As Long, lngEntryID As Long
    lngEntryIDMin = ((lngPeriodID - 1) * cnstEntryMaxCount)
    lngEntryIDMax = lngPeriodID * cnstEntryMaxCount

    lngEntryID = GetMaxNo("Entries", "EntryID", "EntryID Between " & lngEntryIDMin & " And " & lngEntryIDMax)
    If lngEntryID = 1 Then
        lngEntryID = lngEntryID + lngEntryIDMin
    End If
    GetMaxEntryID = lngEntryID
Exit Function
Err_Exit:
    ShowError
    GetMaxEntryID = -1
End Function

Public Function SaveEntry(lngPeriodID As Long, strRefNo As String, dtRefDt As Date, lngStatusID As Long, strRemarks As String, _
                          IsOpen As Boolean, Optional IsErrorSch As Boolean = False, Optional tmpEntryID As Long = -1) As Long
On Local Error GoTo Err_Exit
Dim sSql  As String, lngEntryID As Long, rsSave As New ADODB.Recordset, IsNew As Boolean
    If tmpEntryID = -1 Then
        sSql = "SELECT * FROM Entries WHERE PeriodID =" & lngPeriodID & " AND IsOpening = 1"
    Else
        sSql = "SELECT * FROM Entries WHERE EntryID =" & tmpEntryID
    End If
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            .Fields("EntryID") = GetMaxEntryID(lngPeriodID)
            IsNew = True
        End If
        .Fields("PeriodID") = lngPeriodID
        .Fields("RefNo") = strRefNo
        .Fields("RefDt") = Format(dtRefDt, "#")
        .Fields("StatusID") = lngStatusID
        .Fields("Remark") = strRemarks
        .Fields("IsOpening") = IsOpen
        .Fields("IsErrorSchedule") = IsErrorSch
        SaveDateAndUser rsSave, IsNew
        lngEntryID = Val(.Fields("EntryID") & "")
        .Update
    End With
    SaveEntry = lngEntryID
Exit Function
Err_Exit:
    SaveEntry = -1
End Function

Public Function SaveSubEntries(lngEntryID As Long, lngAcSlNo As Long, lngAcHeadID As Long, dblDrAmt As Double, dblCrAmt As Double, strNarration As String, Optional IsOpen As Long = 0) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    If IsOpen = 1 Then
        sSql = "SELECT * FROM EntrySubAccounts WHERE EntryID = " & lngEntryID & " AND AcSlno = " & lngAcSlNo
    Else
        sSql = "SELECT * FROM EntrySubAccounts WHERE EntryID = " & lngEntryID & " AND AcID = " & lngAcHeadID
    End If
    With GetRecords(sSql)
        If .EOF Then
            .AddNew
            .Fields("EntryID") = lngEntryID
            If Val(.Fields("AcSlNo") & "") = 0 Then
                .Fields("AcSlNo") = lngAcSlNo
            End If
        End If
        .Fields("AcID") = lngAcHeadID
        .Fields("DAmt") = Abs(dblDrAmt)
        .Fields("CAmt") = Abs(dblCrAmt)
        .Fields("Narration") = strNarration
        .Update
    End With
    SaveSubEntries = True
Exit Function
Err_Exit:
    SaveSubEntries = False
End Function

Public Sub ChangeDatasheetStatus(ByVal lngPeriodID As Long, Optional ByVal lngAcID As Long = 0, Optional ByVal lngAcTypeID As Long = 0)
On Local Error GoTo Err_Exit
Dim sSql As String
    If lngAcTypeID = 0 Then
        lngAcTypeID = PickValue("AcHeads", "AcTypeID", "AcID = " & lngAcID)
    End If
    lngAcTypeID = Get3rdLevelParent(lngAcTypeID)
    '----------------------------------------------------------------------------
    sSql = "UPDATE Schedules SET IsFinished = 0 WHERE AcTypeID = " & lngAcTypeID
    AdoConn.Execute sSql
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function Get3rdLevelParent(lngAcTypeID As Long)
On Local Error Resume Next
Dim sSql As String
    sSql = "SELECT TreeLevel, ParentAcTypeID FROM AcTypes WHERE AcTypeID = " & lngAcTypeID
    With GetRecords(sSql)
        If Not .EOF Then
            If Val(.Fields("TreeLevel") & "") = 3 Then
                Get3rdLevelParent = lngAcTypeID
            ElseIf Val(.Fields("ParentAcTypeID") & "") <> 0 Then
                Get3rdLevelParent = Get3rdLevelParent(Val(.Fields("ParentAcTypeID") & ""))
            Else
                Get3rdLevelParent = 0
            End If
        Else
            Get3rdLevelParent = 0
        End If
    End With
End Function

Public Function TakeDataBaseBackup(lngCompanyID As Long, AdoConn As Connection) As Boolean
On Local Error GoTo Err_Exit
Dim strBackupPath As String, sSql As String
Dim strBackupFileName As String, strBackupFullPath As String
Dim strCompanyJobCode As String, strServerDt As String
    If lngCompanyID = 0 Then
        pMVE.MsgBox "Select Company and try again.", msgOK, App.Title, msgInformation, True
        TakeDataBaseBackup = False
        Exit Function
    End If
    Screen.MousePointer = vbHourglass
    strBackupPath = PickValue("ApplicationData", "DataField", "KeyField = 'BackupPath'", AdoConn)
    If Trim(strBackupPath) = "" Then
        pMVE.MsgBox "Invalid backup path. Set backup path on Begin -> Options.", msgOK, App.Title, msgInformation, True
        TakeDataBaseBackup = False
    End If
    '------------------------------------------------------------
    If Right(Trim(strBackupPath), 1) = "\" Then
        strBackupPath = Left(Trim(strBackupPath), Len(Trim(strBackupPath)) - 1)
    End If
    strServerDt = Format(ServerDateTime(AdoConn), "yyyyMMMddHHmm")
    strCompanyJobCode = PickValue("Companies", "CompanyCode", "CompanyID = " & lngCompanyID)
    strBackupFileName = strCompanyJobCode & "-" & strServerDt

    strBackupFullPath = strBackupPath & "\"

    AdoConn.CommandTimeout = 30
    sSql = "BACKUP DATABASE " & pInitialCatelogDoc & " TO DISK = '" & strBackupFullPath & pInitialCatelogDoc & strBackupFileName & "'"
    AdoConnDoc.Execute sSql
    sSql = "BACKUP DATABASE " & pInitialCatelog & " TO DISK = '" & strBackupFullPath & pInitialCatelog & strBackupFileName & "'"
    AdoConn.Execute sSql
    AdoConn.CommandTimeout = 30
    Screen.MousePointer = vbDefault
    pMVE.MsgBox "Backup has been taken successfully.", msgOK, App.Title, msgInformation, True
    TakeDataBaseBackup = True
Exit Function
Err_Exit:
    TakeDataBaseBackup = False
    Screen.MousePointer = vbDefault
    pMVE.MsgBox Err.Description, msgOK, App.Title, msgInformation, True
End Function

Public Function RestoreSqlDataBase(strFile As String, strLogicalFilename As String, strDatabaseName As String, Optional ServerName As String = "", Optional DataBaseLocation As String = "") As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    If Trim(strFile) = "" Then
        MsgBox "Invalid backup file.", vbOKOnly
        RestoreSqlDataBase = False
        Exit Function
    End If
    DoEvents
    Screen.MousePointer = vbHourglass
    sSql = "RESTORE DATABASE " & strDatabaseName & _
           " FROM DISK = '" & strFile & "' WITH DBO_ONLY , " & _
           "Move '" & strLogicalFilename & "_Data' " & _
           "TO '" & DataBaseLocation & strDatabaseName & "_data.mdf', " & _
           "MOVE '" & strLogicalFilename & "_Log' " & _
           "TO '" & DataBaseLocation & strDatabaseName & "_log.ldf', REPLACE"

    'Removing existing connections & processes
    With GetRecords("exec sp_who", AdoConn)
        While Not .EOF
            If UCase(!DBName & "") = UCase(strDatabaseName) Then
                AdoConn.Execute "KILL " & !Spid
            End If
            .MoveNext
        Wend
        .Close
    End With
    'Excecuting
    With AdoConn
        .CommandTimeout = 0
        .Execute sSql
        .CommandTimeout = 30
    End With
    Screen.MousePointer = vbDefault
    RestoreSqlDataBase = True
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    pMVE.MsgBox strDatabaseName & " creation failed. " & Err.Description, msgOK, "AuditMate", msgCritical, True
    RestoreSqlDataBase = False
End Function

Public Function DeleteExistingData() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog
Dim cnnMain As ADODB.Connection, cnnDoc As ADODB.Connection
'    If blnBackup Then
'        Set cnnMain = mcnnToBak
'        Set cnnDoc = mcnnToDocBak
'    ElseIf blnRemoveClientData Then
'        Set cnnMain = mcnnFrom
'        Set cnnDoc = mcnnFromDoc
'    Else
'        Set cnnMain = mcnnTo
'        Set cnnDoc = mcnnToDoc
'    End If
'    cnnMain = pInitialCatelog
'    cnnDoc = pInitialCatelogDoc
    DeleteExistingData = True
    Screen.MousePointer = vbHourglass
    Set adxTmp.ActiveConnection = AdoConn
    sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder DESC"
    With GetRecords(sSql, AdoConn)
        While Not .EOF
            sSql = "DELETE " & !TableName & " FROM " & !TableName & ", " & !ParentTableName & " PTBL"
            strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", AdoConn)
            If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                If strWhere = "" Then
                    sSql = sSql & " WHERE PTBL.CompanyID = " & pActiveCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PTBL.CompanyID = " & pActiveCompanyID
                End If
            Else
                sSql = sSql & ", Periods PRD "
                If strWhere = "" Then
                    sSql = sSql & " WHERE PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & pActiveCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & pActiveCompanyID
                End If
            End If
            AdoConn.Execute sSql
            .MoveNext
        Wend
        .Close
    End With
'    If chkDocTransfer.Value = vbChecked Then
    sSql = "Delete From DocumentBin Where CompanyID = " & pActiveCompanyID
    AdoConnDoc.Execute sSql
'    End If
    DeleteExistingData = True
    Screen.MousePointer = vbDefault
Exit Function
Err_Exit:
    pMVE.MsgBox Err.Description, msgOK, "AuditMate", msgCritical, True
    DeleteExistingData = False
    Screen.MousePointer = vbDefault
End Function
