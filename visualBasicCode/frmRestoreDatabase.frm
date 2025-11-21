VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmRestoreDatabase 
   Caption         =   "Restore Database"
   ClientHeight    =   5175
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8130
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5175
   ScaleWidth      =   8130
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtStatistics 
      Appearance      =   0  'Flat
      Height          =   855
      Left            =   50
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   15
      Top             =   4300
      Width           =   8055
   End
   Begin VB.Frame FrameDatabase 
      Height          =   3255
      Left            =   50
      TabIndex        =   2
      Top             =   120
      Width           =   8050
      Begin VB.TextBox txtRootFolder 
         Height          =   375
         Left            =   2700
         TabIndex        =   1
         Top             =   960
         Width           =   4665
      End
      Begin VB.CommandButton cmdBrowseLocation 
         Caption         =   "..."
         Height          =   375
         Left            =   7400
         TabIndex        =   11
         Top             =   960
         Width           =   375
      End
      Begin VB.TextBox txtServer 
         Enabled         =   0   'False
         Height          =   315
         Left            =   2700
         TabIndex        =   10
         Top             =   360
         Width           =   2865
      End
      Begin VB.TextBox txtDocumentDatabase 
         Height          =   315
         Left            =   2700
         TabIndex        =   4
         Top             =   2640
         Width           =   4665
      End
      Begin VB.CommandButton cmdBrowseDocument 
         Caption         =   "..."
         Height          =   315
         Left            =   7400
         TabIndex        =   7
         Top             =   2640
         Width           =   375
      End
      Begin VB.CommandButton cmdBrowseMain 
         Caption         =   "..."
         Height          =   315
         Left            =   7400
         TabIndex        =   5
         Top             =   2040
         Width           =   375
      End
      Begin VB.TextBox txtMainDatabase 
         Height          =   315
         Left            =   2700
         TabIndex        =   3
         Top             =   2040
         Width           =   4665
      End
      Begin VB.Label lblDBLocation 
         Caption         =   " "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2700
         TabIndex        =   14
         Top             =   1560
         Width           =   4335
      End
      Begin VB.Label lblDBLocationCap 
         AutoSize        =   -1  'True
         Caption         =   "Database Location  : "
         Height          =   195
         Left            =   120
         TabIndex        =   13
         Top             =   1560
         Width           =   1530
      End
      Begin VB.Label lblRootFolderCap 
         AutoSize        =   -1  'True
         Caption         =   "AuditMate Root Folder   :"
         Height          =   195
         Left            =   120
         TabIndex        =   12
         Top             =   1050
         Width           =   1770
      End
      Begin VB.Label lblServerCap 
         AutoSize        =   -1  'True
         Caption         =   "Server"
         Height          =   195
         Left            =   135
         TabIndex        =   9
         Top             =   360
         Width           =   465
      End
      Begin VB.Label lblDocumentDatabase 
         AutoSize        =   -1  'True
         Caption         =   "Select AuditDocument Database:"
         Height          =   195
         Left            =   135
         TabIndex        =   8
         Top             =   2700
         Width           =   2370
      End
      Begin VB.Label lblMainDatabase 
         AutoSize        =   -1  'True
         Caption         =   "Select AuditMain Database:"
         Height          =   195
         Left            =   135
         TabIndex        =   6
         Top             =   2100
         Width           =   1980
      End
   End
   Begin MSComctlLib.ImageList imgToolbarOkCancel 
      Left            =   240
      Top             =   3600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRestoreDatabase.frx":0000
            Key             =   "Cancel"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRestoreDatabase.frx":031A
            Key             =   "OK"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRestoreDatabase.frx":0634
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmRestoreDatabase.frx":080E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrRestoreCancel 
      Height          =   570
      Left            =   6300
      TabIndex        =   0
      Top             =   3555
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   1005
      ButtonWidth     =   1482
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "imgToolbarOkCancel"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Restore"
            Key             =   "Restore"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cancel"
            Key             =   "Cancel"
            ImageIndex      =   1
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog cdFileBrowse 
      Left            =   960
      Top             =   3600
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
End
Attribute VB_Name = "frmRestoreDatabase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mcnnFrom As New ADODB.Connection, mcnnTo As New ADODB.Connection
Dim mcnnFromDoc As New ADODB.Connection, mcnnToDoc As New ADODB.Connection
Dim mCompanyID As Long
Const cnstSyncMastCount = 8

Public Property Let SetMessage(ByVal strMessage As String)
    txtStatistics = txtStatistics & strMessage & vbNewLine
    txtStatistics.SelStart = Len(txtStatistics) - 1
End Property

Private Sub cmdBrowseLocation_Click()
    txtRootFolder = BrowShow(Me.hWnd, CSIDL_DESKTOP, BIF_STATUSTEXT, ReturnPath, "Select a valid data path", txtRootFolder)
    If Right(Trim(txtRootFolder), 1) <> "\" And Len(txtRootFolder) <> 0 Then
        txtRootFolder = txtRootFolder & "\"
    End If
End Sub

Private Sub cmdBrowseMain_Click()
On Local Error Resume Next
    cdFileBrowse.ShowOpen
    If Dir(cdFileBrowse.FileName) <> "" Then
        txtMainDatabase.Text = cdFileBrowse.FileName
    End If
End Sub

Private Sub cmdBrowseDocument_Click()
On Local Error Resume Next
    cdFileBrowse.ShowOpen
    If Dir(cdFileBrowse.FileName) <> "" Then
        txtDocumentDatabase.Text = cdFileBrowse.FileName
    End If
End Sub

Private Sub Form_Load()
    txtServer = GetLocalServerName & "\SQLEXPRESS"
End Sub

Private Sub tbrRestoreCancel_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "Restore"
            RestoreDataBase
            MDIFormMain.CloseActiveTabForm
        Case "Cancel"
            MDIFormMain.CloseActiveTabForm
    End Select
End Sub

Private Sub txtRootFolder_Change()
    lblDBLocation.Caption = txtRootFolder.Text & "Database\"
End Sub

Public Function RestoreBackupDataBase(strFile As String, strLogicalFilename As String, strDatabaseName As String, Optional ServerName As String = "", Optional DataBaseLocation As String = "") As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    If Trim(strFile) = "" Then
        MsgBox "Invalid backup file.", vbOKOnly
        RestoreBackupDataBase = False
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
    RestoreBackupDataBase = True
Exit Function
Err_Exit:
    Screen.MousePointer = vbDefault
    pMVE.MsgBox strDatabaseName & " creation failed. " & Err.Description, msgOK, "AuditMate", msgCritical, True
    RestoreBackupDataBase = False
End Function

Public Function RestoreDataBase() As Boolean
On Local Error GoTo Err_Exit
'    If OpenConn(Adoconn, pServerLocal, pInitialCatelogLocalMain, "sa", "") _
'        And OpenConn(Adoconn, pServerLocal, pInitialCatelogLocalDoc, "sa", "") Then
        SetMessage = "Restoring Databases..."
        RestoreDataBase = RestoreBackupDataBase(Trim(txtMainDatabase), "AuditMain", "AuditMainBackup2", Trim(txtServer), Trim(lblDBLocation))
        RestoreDataBase = RestoreBackupDataBase(Trim(txtDocumentDatabase), "AuditDocument", "AuditDocumentBackup2", Trim(txtServer), Trim(lblDBLocation))
        SetMessage = "Databases restored successfully..."
'    Else
'        pMVE.MsgBox "Invalid Server!", msgOK, , msgCritical, True
'        RestoreDataBase = False
'        SetMessage = "Restoring base databases...Failure"
'        SetMessage = Err.Description
'    End If
    If OpenConn(mcnnFrom, pServerLocal, pInitialCatelogLocalMain, "sa", pCnnPassword) _
        And OpenConn(mcnnTo, pServerLocal, pInitialCatelog, "sa", pCnnPassword) _
        And OpenConn(mcnnFromDoc, pServerLocal, pInitialCatelogLocalDoc, "sa", pCnnPassword) _
        And OpenConn(mcnnToDoc, pServerLocal, pInitialCatelogDoc, "sa", pCnnPassword) Then
        SetMessage = "Updating local databases..."
        SynchroniseMasters
        TransferData mCompanyID
        DeleteExistingData True
        pMVE.MsgBox "Databases restored successfully...", msgOK, "AuditMate", msgInformation, True
    End If
Exit Function
Err_Exit:
    pMVE.MsgBox Err.Description, msgOK, "AuditMate", msgCritical, True
End Function

Public Function SynchroniseMasters() As Boolean
On Local Error GoTo Err_Exit
Dim arrMastersList(1 To cnstSyncMastCount) As String, arrMastersParentList(1 To cnstSyncMastCount) As String
Dim rsTmpFrom As New clsRecordSet, rsTmpTo As New ADODB.Recordset, sSql As String, blnIsExists As Boolean
Dim arrPKeys() As String, strWhere As String, strPKeys As String, strUpdateDate As String
Dim Inc As Long, pkInc As Long, arrInc As Long
Dim cnnFrom As ADODB.Connection, cnnTo As ADODB.Connection
    SynchroniseMasters = False
    Set cnnFrom = mcnnFrom
    Set cnnTo = mcnnTo
    arrMastersList(1) = "ProcedureQuestions":    arrMastersParentList(1) = "ProcedureQuestions"
    arrMastersList(2) = "ProcedureQuestionsSub": arrMastersParentList(2) = "ProcedureQuestions"
    arrMastersList(3) = "ProcedureAnswers":      arrMastersParentList(3) = "ProcedureQuestions"
    arrMastersList(4) = "BankMaster":            arrMastersParentList(4) = "BankMaster"
    arrMastersList(5) = "CurrencyMaster":        arrMastersParentList(5) = "CurrencyMaster"
    arrMastersList(6) = "Nations":               arrMastersParentList(6) = "Nations"
    arrMastersList(7) = "Users":                 arrMastersParentList(7) = "Users"
    arrMastersList(8) = "UserGroupUsers":        arrMastersParentList(8) = "Users"
    For arrInc = LBound(arrMastersList) To UBound(arrMastersList)
        SetMessage = "Synchronising " & arrMastersList(arrInc) & " ..."
        Set rsTmpTo.ActiveConnection = mcnnTo
        strPKeys = GetAllPrimaryKeyColumns(arrMastersList(arrInc), mcnnTo)
        arrPKeys = Split(strPKeys, "|")
        strUpdateDate = PickValue("LastUpdatedDetails", "LastUpdatedDate", "TableName = '" & arrMastersList(arrInc) & "'", cnnTo)
        If strUpdateDate = "" Then
            strUpdateDate = CDate(0)
        End If
        sSql = BuildSQLRelation(arrMastersList(arrInc), arrMastersParentList(arrInc), mcnnTo)
        sSql = "SELECT " & arrMastersList(arrInc) & ".* FROM " & arrMastersList(arrInc) & ", " & arrMastersParentList(arrInc) & " PTBL WHERE " & sSql & " AND PTBL.UpdateDate > CONVERT(datetime, '" & strUpdateDate & "', " & pSQLDateFormatStyle & ") ORDER BY " & arrMastersList(arrInc) & "." & arrPKeys(0)
        rsTmpFrom.BindRecords sSql, cnnFrom
        While Not rsTmpFrom.EOF
            strWhere = ""
            For pkInc = LBound(arrPKeys) To UBound(arrPKeys)
                strWhere = strWhere & IIf(strWhere = "", " WHERE ", " AND ") & arrPKeys(pkInc) & " = '" & rsTmpFrom.Fields(arrPKeys(pkInc)) & "'"
            Next pkInc
            sSql = "SELECT * FROM " & arrMastersList(arrInc) & strWhere
            rsTmpTo.Open sSql, cnnTo, adOpenKeyset, adLockOptimistic
            If rsTmpTo.BOF Then
                rsTmpTo.AddNew
                For pkInc = LBound(arrPKeys) To UBound(arrPKeys)
                    rsTmpTo.Fields(arrPKeys(pkInc)) = rsTmpFrom.Fields(arrPKeys(pkInc))
                Next pkInc
            End If
            For Inc = 0 To rsTmpFrom.Cols - 1
                blnIsExists = False
                For pkInc = LBound(arrPKeys) To UBound(arrPKeys)
                    If UCase(arrPKeys(pkInc)) = UCase(rsTmpFrom.FieldName(Inc)) Then
                        blnIsExists = True
                        Exit For
                    End If
                Next pkInc
                If Not blnIsExists Then
                    rsTmpTo.Fields(rsTmpFrom.FieldName(Inc)) = rsTmpFrom.Fields(Inc)
                End If
            Next Inc
            rsTmpTo.Update
            rsTmpTo.Close
            rsTmpFrom.MoveNext
        Wend
        sSql = "SELECT * FROM LastUpdatedDetails WHERE TableName = '" & arrMastersList(arrInc) & "'"
        With rsTmpTo
            .Open sSql, cnnTo, adOpenKeyset, adLockOptimistic
            If .BOF Then
                .AddNew
                !TableName = arrMastersList(arrInc)
            End If
            !LastUpdatedDate = ServerDateTime
            .Update
            .Close
        End With
        rsTmpFrom.Clear
    Next arrInc
    Set rsTmpFrom = Nothing
    Set rsTmpTo = Nothing
    SynchroniseMasters = True
    mCompanyID = Val(PickValue("Companies", "CompanyID", , mcnnFrom))
Exit Function
Err_Exit:
    MsgBox Err.Description, vbInformation
    SynchroniseMasters = False
End Function

Public Function TransferData(mlngCompanyID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog, rsTmpClient As New ADODB.Recordset
Dim crsTmpServer As New clsRecordSet, strPKeyCol As String, Inc As Long
Dim cnnFrom As ADODB.Connection, cnnTo As ADODB.Connection
Dim cnnFromDoc As ADODB.Connection, cnnToDoc As ADODB.Connection
    TransferData = False
    Set cnnFrom = mcnnFrom
    Set cnnTo = mcnnTo
    Set cnnFromDoc = mcnnFromDoc
    Set cnnToDoc = mcnnToDoc
    If DeleteExistingData(False) Then
        '----Transfering data----------
        SetMessage = "Updating main data..."
        Set adxTmp.ActiveConnection = mcnnTo
        sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder"
            With GetRecords(sSql, mcnnTo)
                While Not .EOF
                    SetMessage = "Transfering data - " & !TableName & "..."
                    sSql = "SELECT " & !TableName & ".* FROM " & !TableName & ", " & !ParentTableName & " PTBL"
                    strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", mcnnTo)
                    If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                        If strWhere = "" Then
                            sSql = sSql & " WHERE PTBL.CompanyID = " & mlngCompanyID
                        Else
                            sSql = sSql & " WHERE " & strWhere & " AND PTBL.CompanyID = " & mlngCompanyID
                        End If
                    Else
                        sSql = sSql & ", Periods PRD "
                        If strWhere = "" Then
                            sSql = sSql & " WHERE PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & mlngCompanyID
                        Else
                            sSql = sSql & " WHERE " & strWhere & " AND PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & mlngCompanyID
                        End If
                    End If
                    crsTmpServer.BindRecords sSql, cnnFrom
                    strPKeyCol = GetPrimaryKeyColumn(!TableName & "", mcnnTo)
                    sSql = "SELECT * FROM " & !TableName & IIf(strPKeyCol = "", "", " WHERE " & strPKeyCol & " = '0'")
                    rsTmpClient.Open sSql, cnnTo, adOpenKeyset, adLockOptimistic
                    While Not crsTmpServer.EOF
                        rsTmpClient.AddNew
                        For Inc = 0 To crsTmpServer.Cols - 1
                            rsTmpClient.Fields(Inc).Value = crsTmpServer.Fields(Inc)
                        Next Inc
'                        Percentage = !TableName & ": " & Round(((crsTmpServer.Row + 1) * 100) / crsTmpServer.Rows, 2) & "%"
                        rsTmpClient.Update
                        crsTmpServer.MoveNext
                    Wend
                    rsTmpClient.Close
                    crsTmpServer.Clear
                    .MoveNext
                Wend
                .Close
            End With
            SetMessage = "Main data updated successfully..."
            sSql = "SELECT * FROM DocumentBin Where CompanyID = " & mlngCompanyID
            crsTmpServer.BindRecords sSql, cnnFromDoc
            While Not crsTmpServer.EOF
                SetMessage = "Updating document data..."
                sSql = "SELECT * FROM DocumentBin WHERE DocumentID = " & crsTmpServer.Fields("DocumentID")
                rsTmpClient.Open sSql, cnnToDoc, adOpenKeyset, adLockOptimistic
                If rsTmpClient.BOF Then
                    rsTmpClient.AddNew
                End If
                For Inc = 0 To crsTmpServer.Cols - 1
                    rsTmpClient.Fields(Inc).Value = crsTmpServer.Fields(Inc)
                Next Inc
                rsTmpClient.Update
                rsTmpClient.Close
                crsTmpServer.MoveNext
            Wend
            crsTmpServer.Clear
            SetMessage = "Document data updated successfully..."
        TransferData = True
    End If
    SetMessage = "Ready...."
'    pBar.Visible = False
Exit Function
Err_Exit:
    MsgBox Err.Description
    TransferData = False
End Function

Public Function DeleteExistingData(blnRemoveClientData As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog
Dim cnnMain As ADODB.Connection, cnnDoc As ADODB.Connection
    If blnRemoveClientData Then
        Set cnnMain = mcnnFrom
        Set cnnDoc = mcnnFromDoc
    Else
        Set cnnMain = mcnnTo
        Set cnnDoc = mcnnToDoc
    End If
    DeleteExistingData = False
    Set adxTmp.ActiveConnection = mcnnTo
    sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder DESC"
    With GetRecords(sSql, mcnnTo)
        While Not .EOF
            sSql = "DELETE " & !TableName & " FROM " & !TableName & ", " & !ParentTableName & " PTBL"
            strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", mcnnTo)
            If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                If strWhere = "" Then
                    sSql = sSql & " WHERE PTBL.CompanyID = " & mCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PTBL.CompanyID = " & mCompanyID
                End If
            Else
                sSql = sSql & ", Periods PRD "
                If strWhere = "" Then
                    sSql = sSql & " WHERE PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & mCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & mCompanyID
                End If
            End If
            cnnMain.Execute sSql
            .MoveNext
        Wend
        .Close
    End With
    sSql = "Delete From DocumentBin Where CompanyID = " & mCompanyID
    cnnDoc.Execute sSql
    DeleteExistingData = True
Exit Function
Err_Exit:
    MsgBox Err.Description
    DeleteExistingData = False
End Function
