Attribute VB_Name = "mdlMain"
Option Explicit

Public AdoConn As New ADODB.Connection, AdoConnDoc As New ADODB.Connection
Public AdoConnBak As New ADODB.Connection, AdoConnDocBak As New ADODB.Connection
Public AdoConnLocalMainBak As New ADODB.Connection, AdoConnLocalDocBak As New ADODB.Connection

Public pCllSystem As New Collection
Public pInitialCatelog As String, pInitialCatelogDoc As String, pInitialCatelogBak As String
Public pInitialCatelogBakMain As String, pInitialCatelogBakDoc As String
Public pInitialCatelogMainBak As String, pInitialCatelogDocBak As String
Public pInitialCatelogLocalMain As String, pInitialCatelogLocalDoc As String
Public pServer As String, pProvider As String
Public pInitialCatelogLocal As String, pServerLocal As String
Public pCnnUserName As String, pCnnPassword As String
Public pServerStatus As String
Public pConnectionSucceeded As Boolean, pLoginSucceeded As Boolean
Public pchar As String
Public Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

Dim CurMajor As Long, CurMinor As Long, CurRevision As Long

Public pMVE As New MVE_DLL.CMSRDLL

'This is the startup point of AuditMate
Public Sub Main()
    '------- 19th May 2008, Monday -------------------
    If App.PrevInstance = True Then
        pMVE.MsgBox "Application is already loaded.", msgOK, "AuditMate"
        End
    End If
    '-----------------------------------------------
    Initialize 'Initializing Variables
    MDIFormMain.Show
    OpenInitialCatalog
    MDIFormMain.SBar.Panels(1).Text = "Ready"
    'RefreshInitialData
    frmLogo.CanEnd = True
End Sub

Public Sub Initialize()
    pSQLDateFormatStyle = SQLGetDateFormatStyle(RegionalSettingsGetDateFormat)
    pServerLocal = GetLocalServerName & "\SQLEXPRESS"
'    pServer = ReadServerName(pProvider)
    pServer = "192.168.100.200"
    pchar = "11010651171001051161072097109116104076098057057064056054051054055"
    pCnnPassword = NumberEncryption(False, "eAudit", pchar)
    If Trim(UCase(pServerLocal)) <> Trim(UCase(pServer)) Then
        If pMVE.MsgBox("Do you want to connect to local server?", msgYesNo + msgDefault2, "AuditMate - Server selection", msgQuestion, True) Then
            pServer = pServerLocal
            pCnnUserName = "sa"
            pCnnPassword = NumberEncryption(False, "eAudit", pchar)
            MDIFormMain.mnuDatabaseTakeBackup.Enabled = True
            MDIFormMain.mnuDatabaseClearData.Enabled = True
            MDIFormMain.mnuDatabaseRestore.Enabled = True
            MDIFormMain.mnuFileNew.Enabled = False
            MDIFormMain.mnuBeginCompany.Enabled = False
            MDIFormMain.mnuBeginPeriod.Enabled = False
            MDIFormMain.mnuBeginUser.Enabled = False
            MDIFormMain.mnuMasters.Enabled = False
            MDIFormMain.mnuDatabaseDetach.Enabled = False
            MDIFormMain.mnuDatabaseDetachBkp.Enabled = False
        Else
            pCnnUserName = "sa"
            pCnnPassword = NumberEncryption(False, "eAudit", pchar)
            MDIFormMain.mnuDatabaseDetach.Caption = "Detach / Attach Data"
            MDIFormMain.mnuDatabaseDetachBkp.Caption = "Detach && Backup"
            frmDetachnBackup.Caption = "Detach n Backup Database"
            MDIFormMain.mnuDatabaseTakeBackup.Enabled = False
            MDIFormMain.mnuDatabaseClearData.Enabled = False
            MDIFormMain.mnuDatabaseRestore.Enabled = False
        End If
    End If
    pServerStatus = pServer
    pInitialCatelog = "AuditMain"
    pInitialCatelogDoc = "AuditDocument"
    pInitialCatelogBakMain = "AuditMainBackup1"
    pInitialCatelogBakDoc = "AuditDocumentBackup1"
    pInitialCatelogMainBak = "AuditMainBackup1"
    pInitialCatelogDocBak = "AuditDocumentBackup1"
    pInitialCatelogBak = "AuditBak"
    pInitialCatelogLocalMain = "AuditMainBackup2"
    pInitialCatelogLocalDoc = "AuditDocumentBackup2"
    pclrRestrictionColor = &H2EFFFFF
    'Temporary
    pActiveCompanyID = 1
    pActivePeriodID = 1
    pInitialCatelogLocal = "AuditMain"
End Sub

Public Function GetLocalServerName() As String
On Local Error Resume Next
Dim strComputerName As String
Dim lngLen As Long, lngX As Long
    lngLen = 16
    strComputerName = String$(lngLen, 0)
    lngX = GetComputerName(strComputerName, lngLen)
    If lngX <> 0 Then
        GetLocalServerName = Left$(strComputerName, lngLen)
    Else
        GetLocalServerName = ""
    End If
End Function

Public Sub OpenInitialCatalog()
On Local Error GoTo Err_Exit
    frmConnection.mMode = 1
    frmConnection.Form_Load
    frmConnection.Show
    DoEvents
    If OpenAllConnections Then
        DoEvents
        pConnectionSucceeded = True
        SetIniString "Server", pServer
        MDIFormMain.SBar.Panels("Cnn").Text = UCase(pInitialCatelog) & " on " & UCase(pServer)
        frmLogo.Show
        MDIFormMain.SBar.Panels("Main").Text = "Upgrading version"
        DoEvents
        UpgradeDatabase
        DoEvents
        frmLogin.Show vbModal
    Else
        Unload frmConnection
        frmConnection.mMode = 0
        frmConnection.Show vbModal
    End If
Exit Sub
Err_Exit:
    ShowError
    End
End Sub

Public Function OpenAllConnections() As Boolean
On Local Error GoTo Err_Exit
    If Not OpenConn(AdoConn, pServer, pInitialCatelog, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to main database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    If Not OpenConn(AdoConnDoc, pServer, pInitialCatelogDoc, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to document database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    If Not OpenConn(AdoConnBak, pServer, pInitialCatelogBakMain, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to main backup database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    If Not OpenConn(AdoConnDocBak, pServer, pInitialCatelogBakDoc, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to document backup database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    If Not OpenConn(AdoConnLocalMainBak, pServer, pInitialCatelogLocalMain, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to temporary main backup database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    If Not OpenConn(AdoConnLocalDocBak, pServer, pInitialCatelogLocalDoc, pCnnUserName, pCnnPassword) Then
        pMVE.MsgBox "Could not establish connection to temporary document backup database.", msgOK, "AuditMate", msgCritical
        OpenAllConnections = False
        Exit Function
    End If
    OpenAllConnections = True
Exit Function
Err_Exit:
    OpenAllConnections = False
End Function

Public Function OpenConn(AdoConnection As ADODB.Connection, strServer As String, strInitialCatelog As String, strUserName As String, strPassword As String) As Boolean
On Local Error Resume Next
    OpenConn = True
    With AdoConnection 'Opening Database
        .Close
'        .ConnectionTimeout = 10
'        .CommandTimeout = 30
        Err.Clear
        Select Case UCase(pProvider)
'            Case "NATIVE CLIENT"
'                .Open "Provider=SQLNCLI.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=" & strInitialCatelog & ";Data Source=" & strServer, strUserName, strPassword
'            Case Else
'                .Open "Provider=SQLOLEDB.1;Persist Security Info=False;Initial Catalog=" & strInitialCatelog & ";Data Source=" & strServer, strUserName, strPassword
'            If Err.Number <> 0 Then
'                Err.Clear
'                .Open "Provider=SQLOLEDB.1;Data Source=" & strServer & ";Initial Catalog=" & strInitialCatelog & ";Persist Security Info=False;Integrated Security=SSPI", strUserName, strPassword
'            End If
'            If Err.Number <> 0 Then
'                Err.Clear
'                .Open "Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=sa;Initial Catalog=" & strInitialCatelog & ";Data Source=" & strServer
'            End If
            Case "NATIVE CLIENT"
                .Open "Provider=SQLNCLI.1;Persist Security Info=False;Initial Catalog=" & strInitialCatelog & ";Data Source=" & strServer & ";User ID=sa;Password =" & strPassword
            Case Else
                .Open "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=" & strServer & ";User ID=sa;Password =" & strPassword & ";Initial Catalog=" & strInitialCatelog
            If Err.Number <> 0 Then
                Err.Clear
                .Open "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=" & strServer & ";User ID=sa;Password =" & strPassword & ";Initial Catalog=" & strInitialCatelog
            End If
            If Err.Number <> 0 Then
                Err.Clear
                .Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; Password =" & strPassword & "; Initial Catalog=" & strInitialCatelog & ";Data Source=" & strServer
            End If
        End Select
    End With
    If Err.Number <> 0 Then
        OpenConn = False
    End If
End Function

Public Sub UpgradeDatabase()
On Local Error Resume Next
Dim sSql As String, IncMajor As Long, IncMinor As Long
Dim cudUpgrade As New clsUpgradeDatabase, lngVersionDB As Long, lngVersionExe As Long
    sSql = "Select * from Version ORDER BY Major DESC, Minor DESC, Revision DESC"
        With GetRecords(sSql)
            If .EOF Then
                CurMajor = 1
                CurMinor = 0
                CurRevision = 0
            Else
                CurMajor = Val(.Fields("Major") & "")
                CurMinor = Val(.Fields("Minor") & "")
                CurRevision = Val(.Fields("Revision") & "")
            End If
            .Close
        End With
        '---Checking for Correct Version--------------
        lngVersionDB = Val(Format(CurMajor, "0000") & Format(CurMinor, "0000") & Format(CurRevision, "0000"))
        lngVersionExe = Val(Format(App.Major, "0000") & Format(App.Minor, "0000") & Format(App.Revision, "0000"))
        If lngVersionExe < lngVersionDB Then
            pMVE.MsgBox "Version of AuditMate changed!!!. Please Update", msgOK, "AuditMate", msgInformation
            TerminateApplication
            End
        End If
        '---Calling Upgrade Functions-----------------
        Screen.MousePointer = vbHourglass
        For IncMajor = CurMajor To App.Major
            For IncMinor = CurMinor To App.Minor
                CallByName cudUpgrade, "Version_" & IncMajor & "_" & IncMinor, VbMethod
            Next IncMinor
        Next IncMajor
        Set cudUpgrade = Nothing
        '---Auto Re-Organising------------------------
        If lngVersionExe > GetLastVersion Then
            ReOrganiseData False
        End If
        ExeSQL = "UPDATE Version SET Major = " & App.Major & ", Minor = " & App.Minor & ", Revision = " & App.Revision
        Screen.MousePointer = vbDefault
End Sub

Public Function GetLastVersion() As Long
On Local Error GoTo Err_Exit
    GetLastVersion = Val(GetApplicationData("LastReOrganisedVersion", "0"))
Exit Function
Err_Exit:
    GetLastVersion = 0
End Function

Public Function ReadServerName(ByRef strProvider As String) As String
On Local Error GoTo Err_Exit
Dim lngFilePointer As Long, strINIFileName As String, strOutput As String
Dim strOutputTmp As String, arrOutput() As String
    If Trim(Interaction.Command) <> "" Then
        strINIFileName = Trim(Interaction.Command)
    Else
        strINIFileName = App.Path & IIf(Right(App.Path, 1) = "\", "", "\") & "AuditMate.ini"
    End If
    If Dir(strINIFileName) <> "" Then
        lngFilePointer = FreeFile
        Open strINIFileName For Input As #lngFilePointer
        Do While Not EOF(lngFilePointer)
            Input #lngFilePointer, strOutputTmp
            strOutput = strOutput & strOutputTmp & ";"
        Loop
        Close #lngFilePointer
    Else
        strOutput = ""
    End If
    If strOutput = "" Then
        strOutput = InputBox("Please enter the servername.", "Server Name")
        If strOutput <> "" Then
            lngFilePointer = FreeFile
            Open strINIFileName For Output As #lngFilePointer
            Print #lngFilePointer, strOutput
            Close #lngFilePointer
        End If
    End If
    arrOutput = Split(strOutput, ";")
    If UBound(arrOutput) = -1 Then
        ReadServerName = ""
        strProvider = "Sql Server"
    Else
        ReadServerName = arrOutput(0)
        If UBound(arrOutput) >= 1 Then
            strProvider = arrOutput(1)
        Else
            strProvider = "Sql Server"
        End If
    End If
Exit Function
Err_Exit:
    ReadServerName = ""
    strProvider = "Sql Server"
End Function

Public Function ReadServerNameOld() As String
'On Error GoTo Err_Exit
'    ReadServerName = GetIniString("Server", "")
'Dim lngFilePointer As Long, strINIFileName As String, strOutput As String
'    If Trim(Interaction.Command) <> "" Then
'        strINIFileName = Trim(Interaction.Command)
'    Else
'        strINIFileName = App.Path & IIf(Right(App.Path, 1) = "\", "", "\") & "eAudit.ini"
'    End If
'    lngFilePointer = FreeFile
'    Open strINIFileName For Input As #lngFilePointer
'    Do While Not EOF(lngFilePointer)
'        Input #lngFilePointer, strOutput
'    Loop
'    Close #lngFilePointer
'    If Trim(strOutput) = "" Then
'        ReadServerName = "-1"
'    Else
'        ReadServerName = strOutput
'    End If
'Exit Function
'Err_Exit:
'    ReadServerName = "-1"
End Function

Public Sub TerminateApplication()
On Local Error Resume Next
    If AdoConn.State Then AdoConn.Close
    If AdoConnDoc.State Then AdoConnDoc.Close
    If AdoConnBak.State Then AdoConnBak.Close
    If AdoConnDocBak.State Then AdoConnDocBak.Close
    If AdoConnLocalMainBak.State Then AdoConnLocalMainBak.Close
    If AdoConnLocalDocBak.State Then AdoConnLocalDocBak.Close
End Sub

Public Function GetApplicationData(Key As String, Optional strDefault As String) As String
On Local Error Resume Next
Dim sSql As String
    sSql = "SELECT * FROM ApplicationData WHERE KeyField = '" & Key & "'"
    With GetRecords(sSql)
        If Not .BOF Then
            GetApplicationData = !DataField
        End If
        .Close
    End With
    If Trim(GetApplicationData) = "" Then
        GetApplicationData = strDefault
    End If
End Function

Public Function SetApplicationData(Key As String, Value As String, Optional AdoConnection As ADODB.Connection = Nothing) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New ADODB.Recordset
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    sSql = "SELECT * FROM ApplicationData WHERE KeyField = '" & Key & "'"
    Set rsTmp = GetRecords(sSql, AdoConnection)
    With rsTmp
        If Not .BOF Then
            !DataField = Value
        Else
            .AddNew
            !KeyField = Key
            !DataField = Value
        End If
        .Update
        .Close
    End With
    SetApplicationData = True
Exit Function
Err_Exit:
    SetApplicationData = False
End Function

Public Property Let ExeSQL(ByRef strNewValue As String)
On Local Error Resume Next
    AdoConn.Execute strNewValue
End Property

Public Sub Highlight()
On Local Error Resume Next
    SendKeys "{Home}+{End}"
End Sub

Public Function BuildSQLRelation(ByVal strDetailTable As String, ByVal strMasterTable As String, Optional cnnAdoConn As ADODB.Connection = Nothing) As String
On Local Error GoTo Err_Exit
Dim ctlgTmp As New ADOX.Catalog, strSQL As String
Dim indxInc As ADOX.Index, clmInc As ADOX.Column
    If cnnAdoConn Is Nothing Then
        Set ctlgTmp.ActiveConnection = AdoConn
    Else
        Set ctlgTmp.ActiveConnection = cnnAdoConn
    End If
    strSQL = ""
    For Each indxInc In ctlgTmp(strMasterTable).Indexes
        If indxInc.PrimaryKey Then
            For Each clmInc In indxInc.Columns
                strSQL = strSQL & IIf(strSQL = "", "", " AND") & " " & strDetailTable & "." & clmInc.Name & " = PTBL." & clmInc.Name
            Next clmInc
        End If
    Next indxInc
    BuildSQLRelation = strSQL
    Set ctlgTmp = Nothing
Exit Function
Err_Exit:
    Set ctlgTmp = Nothing
End Function

Public Function IsTableHasCompanyID(ByVal tblTable As ADOX.Table) As Boolean
On Local Error Resume Next
Dim strColName As String
    IsTableHasCompanyID = False
    Err.Clear
    strColName = tblTable.Columns("CompanyID").Name
    If Err.Number = 0 Then
        IsTableHasCompanyID = True
    End If
End Function

Public Function GetAllPrimaryKeyColumns(ByVal strTable As String, Optional cnnAdoClient As ADODB.Connection = Nothing) As String
On Local Error GoTo Err_Exit
Dim ctlgTmp As New ADOX.Catalog, indxInc As ADOX.Index
Dim clmInc As ADOX.Column, strPKeys As String
    strPKeys = ""
    If cnnAdoClient Is Nothing Then
        Set ctlgTmp.ActiveConnection = AdoConn
    Else
        Set ctlgTmp.ActiveConnection = cnnAdoClient
    End If
    For Each indxInc In ctlgTmp(strTable).Indexes
        If indxInc.PrimaryKey Then
            For Each clmInc In indxInc.Columns
                strPKeys = strPKeys & IIf(strPKeys = "", "", "|") & clmInc.Name
            Next clmInc
            Exit For
        End If
    Next indxInc
    Set ctlgTmp = Nothing
    GetAllPrimaryKeyColumns = strPKeys
Exit Function
Err_Exit:
    Set ctlgTmp = Nothing
    MsgBox Err.Description, vbInformation
    GetAllPrimaryKeyColumns = ""
End Function

Public Function GetPrimaryKeyColumn(ByVal strTable As String, Optional cnnConn As ADODB.Connection = Nothing) As String
On Local Error GoTo Err_Exit
Dim ctlgTmp As New ADOX.Catalog, indxInc As ADOX.Index
    If cnnConn Is Nothing Then
        Set ctlgTmp.ActiveConnection = AdoConn
    Else
        Set ctlgTmp.ActiveConnection = cnnConn
    End If
    For Each indxInc In ctlgTmp(strTable).Indexes
        If indxInc.PrimaryKey Then
            GetPrimaryKeyColumn = indxInc.Columns(0).Name
            Exit For
        End If
    Next indxInc
    Set ctlgTmp = Nothing
Exit Function
Err_Exit:
    Set ctlgTmp = Nothing
    MsgBox Err.Description, vbInformation
End Function
