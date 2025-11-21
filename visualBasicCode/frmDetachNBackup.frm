VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmDetachnBackup 
   Caption         =   "Detach / Attach DataBase"
   ClientHeight    =   4530
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6255
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmDetachNBackup.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   4530
   ScaleWidth      =   6255
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   3135
      Left            =   50
      TabIndex        =   5
      Top             =   1200
      Width           =   6150
      Begin VB.Frame frameDetachAttach 
         Height          =   975
         Left            =   120
         TabIndex        =   12
         Top             =   1050
         Width           =   5895
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Company"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   195
            Left            =   200
            TabIndex        =   14
            Top             =   240
            Width           =   780
         End
         Begin VB.Label lblCompany 
            AutoSize        =   -1  'True
            Caption         =   "Company not activated"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   240
            Left            =   200
            TabIndex        =   13
            Top             =   525
            Width           =   2385
         End
      End
      Begin VB.TextBox txtCompanyCode 
         Appearance      =   0  'Flat
         Height          =   375
         Left            =   1485
         TabIndex        =   8
         Top             =   480
         Width           =   1815
      End
      Begin VB.CheckBox chkDocTransfer 
         Caption         =   "Transfer documents"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   2250
         Value           =   2  'Grayed
         Width           =   2415
      End
      Begin AIFCmp1.asxPowerButton cmdGetCompany 
         Height          =   375
         Left            =   3465
         TabIndex        =   7
         Top             =   480
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   661
         Caption         =   "Get Company"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSComctlLib.ProgressBar pBar 
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   2835
         Width           =   5985
         _ExtentX        =   10557
         _ExtentY        =   450
         _Version        =   393216
         BorderStyle     =   1
         Appearance      =   0
      End
      Begin AIFCmp1.asxPowerButton cmdAction 
         Height          =   360
         Left            =   3720
         TabIndex        =   10
         Top             =   2250
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   635
         Caption         =   "Detach"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin AIFCmp1.asxPowerButton cmdClose 
         Height          =   360
         Left            =   4920
         TabIndex        =   11
         Top             =   2250
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   635
         Caption         =   "Close"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lblCurrentAction 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Ready..."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   120
         TabIndex        =   16
         Top             =   2565
         Width           =   735
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Company Code:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   120
         TabIndex        =   15
         Top             =   570
         Width           =   1335
      End
   End
   Begin VB.Frame frameBackupPath 
      Height          =   975
      Left            =   50
      TabIndex        =   1
      Top             =   120
      Width           =   6150
      Begin VB.TextBox txtBackupPath 
         Height          =   315
         Left            =   1110
         TabIndex        =   3
         Top             =   360
         Width           =   4305
      End
      Begin VB.CommandButton cmdBrowseBackupPath 
         Caption         =   "..."
         Height          =   315
         Left            =   5420
         TabIndex        =   2
         Top             =   360
         Width           =   375
      End
      Begin MSComDlg.CommonDialog cdFolderBrowse 
         Left            =   120
         Top             =   480
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         FileName        =   "cdFile"
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Backup Path"
         Height          =   195
         Left            =   120
         TabIndex        =   4
         Top             =   420
         Width           =   930
      End
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   225
      Left            =   0
      TabIndex        =   0
      Top             =   4305
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   397
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4410
            MinWidth        =   4410
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   2
            Object.Width           =   3528
            MinWidth        =   3528
            TextSave        =   "1/27/2011"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            Alignment       =   2
            Object.Width           =   2646
            MinWidth        =   2646
            TextSave        =   "12:53 PM"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmDetachnBackup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const cnstSyncMastCount = 8

Dim mblnIsDetach As Boolean, mlngCompanyID As Long
Dim IsDetached As Boolean
Dim mcnnClient As New ADODB.Connection, mblnDetach As Boolean
Dim mstrServerFrom As String, mstrServerTo As String
Dim mcnnFrom As ADODB.Connection, mcnnTo As ADODB.Connection
Dim mcnnFromDoc As New ADODB.Connection, mcnnToDoc As New ADODB.Connection
Dim mcnnToBak As New ADODB.Connection, mcnnToDocBak As New ADODB.Connection
Dim mcnnToMainBak2 As New ADODB.Connection, mcnnToDocbak2 As New ADODB.Connection

Private Property Let CurrentAction(ByVal strNewValue As String)
    lblCurrentAction = strNewValue
    DoEvents
End Property

Private Sub cmdBrowseBackupPath_Click()
    txtBackupPath.Text = BrowShow(txtBackupPath.hWnd, , , , , txtBackupPath)
    If Right(Trim(txtBackupPath), 1) <> "\" And Len(txtBackupPath) <> 0 Then
        txtBackupPath = txtBackupPath & "\"
    End If
End Sub

Private Sub cmdClose_Click()
    Unload Me
End Sub

Private Sub cmdGetCompany_Click()
Dim sSql As String, strCompanyCode As String
    If txtCompanyCode = "" Then
        MsgBox "Enter Company Code and try again", vbInformation
        Exit Sub
    End If
    strCompanyCode = txtCompanyCode
    If OpenConn(AdoConn, pServer, pInitialCatelog, "sa", pCnnPassword) Then
        sSql = "Select CompanyName, CompanyID From Companies Where CompanyCode = '" & strCompanyCode & "' "
        With GetRecords(sSql, AdoConn)
            If Not .BOF Then
                lblCompany.Caption = .Fields("CompanyName") & ""
                mlngCompanyID = .Fields("CompanyID") & ""
            End If
            .Close
        End With
    End If
    GetCompanyStatus
End Sub

Private Sub InitialiseStatusbar()
Dim lngMaxSteps As Long
    lngMaxSteps = Val(PickValue("(Select Count (*) AS Num From DetachTables Where IsCompanyOrPeriodID = 1) TMP1 ", "NUM", , mcnnClient))
    lngMaxSteps = lngMaxSteps + Val(PickValue("(SELECT Count(*) AS Num FROM DocumentBin Where CompanyID = " & mlngCompanyID & ") TMP1 ", "NUM", , AdoConnDoc))
    lngMaxSteps = lngMaxSteps + cnstSyncMastCount + 20
    pBar.Min = 0
    pBar.Max = lngMaxSteps
    pBar.Value = 0
    pBar.Visible = True
    pBar.Value = 5
End Sub

Private Sub Form_Load()
   pBar.Align = vbAlignBottom
   pBar.Visible = False
End Sub

Private Sub GetCompanyStatus()
On Local Error Resume Next
Dim sSql As String
    If mlngCompanyID <> 0 Then
        sSql = "Select CASE WHEN ISNULL(DetachedBy,'-1')= '-1' THEN 0 ELSE 1 END AS Status From Companies Where CompanyID = " & mlngCompanyID
        With GetRecords(sSql)
            If Not .EOF Then
                If Val(.Fields("Status") & "") = 1 Then
                    cmdAction.Caption = "Attach"
                    IsDetached = True
                Else
                    cmdAction.Caption = "Detach"
                    IsDetached = False
                End If
            Else
                MsgBox "Company is not identified.", vbInformation
                IsDetached = False
            End If
            .Close
        End With
    End If
End Sub

Private Sub cmdAction_Click()
Dim blnSuccess As Boolean
    cmdClose.Enabled = False
    If mlngCompanyID <= 0 Then
        MsgBox "Invalid Company...", vbInformation
        Exit Sub
    End If
    If cmdAction.Caption = "Detach" Then
        mblnDetach = True
        mstrServerFrom = pServer
        mstrServerTo = pServerLocal
        Set mcnnFrom = AdoConn
        Set mcnnTo = mcnnClient
    Else
        mblnDetach = False
        mstrServerFrom = pServerLocal
        mstrServerTo = pServer
        Set mcnnFrom = mcnnClient
        Set mcnnTo = AdoConn
    End If
    If OpenConn(mcnnClient, pServerLocal, pInitialCatelogLocalMain, "sa", pCnnPassword) _
        And OpenConn(mcnnFromDoc, mstrServerFrom, pInitialCatelogDoc, "sa", pCnnPassword) _
        And OpenConn(mcnnToDoc, mstrServerTo, pInitialCatelogLocalDoc, "sa", pCnnPassword) _
        And OpenConn(mcnnToBak, mstrServerFrom, pInitialCatelogMainBak, "sa", pCnnPassword) _
        And OpenConn(mcnnToDocBak, mstrServerFrom, pInitialCatelogDocBak, "sa", pCnnPassword) Then
        Screen.MousePointer = vbHourglass
        blnSuccess = CompanyAttachDetach()
        Screen.MousePointer = vbDefault
        mcnnClient.Close
        mcnnFromDoc.Close
        mcnnToDoc.Close
        mcnnToBak.Close
        mcnnToDocBak.Close
'        If blnSuccess Then
'            End
'        End If
    Else
        MsgBox "No local server exists.", vbInformation
    End If
    cmdClose.Enabled = True
End Sub

Public Function CompanyAttachDetach() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strType As String
    CompanyAttachDetach = False
    strType = IIf(mblnDetach, "Detaching", "Attaching")
    If mblnDetach Then
        '--------------Updating Master Tables to client database
        CurrentAction = "Synchronising master data...."
        If Not SynchroniseMasters(False) Then
            MsgBox strType & " failed.", vbInformation
            Exit Function
        End If
    End If
    If TransferData(False) Then
        '--------------Updating Master Tables to backup database
        If Not SynchroniseMasters(True) Then
            MsgBox strType & " failed.", vbInformation
            CompanyAttachDetach = False
            Exit Function
        End If
        If Not TransferData(True) Then
            MsgBox strType & " failed.", vbInformation
            CompanyAttachDetach = False
            Exit Function
        End If
        '---Marking-Status------------------------------------------------------------
        sSql = "UPDATE Companies SET DetachedBy = '" & mstrServerTo & "', DetachedDate = CONVERT(DateTime,'" & Format(ServerDateTime, "dd/MMM/yyyy") & "',103) WHERE CompanyID = " & mlngCompanyID
        mcnnFrom.Execute sSql
        sSql = "UPDATE Companies SET DetachedBy = NULL, DetachedDate = NULL WHERE CompanyID = " & mlngCompanyID
        mcnnTo.Execute sSql
        If Not mblnDetach Then
            'Ref No: 007-30/03/08
            DeleteExistingData False, True
        End If
        MsgBox strType & " completed successfully.", vbInformation
        '-----------------------------------------------------------------------------
        CompanyAttachDetach = True
    End If
    TakeDataBaseBackup mlngCompanyID, mcnnClient
    DeleteExistingData False, True
Exit Function
Err_Exit:
    MsgBox Err.Description, vbInformation
End Function

Public Function SynchroniseMasters(blnBackup As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim arrMastersList(1 To cnstSyncMastCount) As String, arrMastersParentList(1 To cnstSyncMastCount) As String
Dim rsTmpFrom As New clsRecordSet, rsTmpTo As New ADODB.Recordset, sSql As String, blnIsExists As Boolean
Dim arrPKeys() As String, strWhere As String, strPKeys As String, strUpdateDate As String
Dim Inc As Long, pkInc As Long, arrInc As Long
Dim cnnFrom As ADODB.Connection, cnnTo As ADODB.Connection
    SynchroniseMasters = False
    If blnBackup Then
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnToBak
    Else
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnTo
    End If
    arrMastersList(1) = "ProcedureQuestions":    arrMastersParentList(1) = "ProcedureQuestions"
    arrMastersList(2) = "ProcedureQuestionsSub": arrMastersParentList(2) = "ProcedureQuestions"
    arrMastersList(3) = "ProcedureAnswers":      arrMastersParentList(3) = "ProcedureQuestions"
    arrMastersList(4) = "BankMaster":            arrMastersParentList(4) = "BankMaster"
    arrMastersList(5) = "CurrencyMaster":        arrMastersParentList(5) = "CurrencyMaster"
    arrMastersList(6) = "Nations":               arrMastersParentList(6) = "Nations"
    arrMastersList(7) = "Users":                 arrMastersParentList(7) = "Users"
    arrMastersList(8) = "UserGroupUsers":        arrMastersParentList(8) = "Users"
    For arrInc = LBound(arrMastersList) To UBound(arrMastersList)
        CurrentAction = "Synchronising " & arrMastersList(arrInc) & " ..."
        Set rsTmpTo.ActiveConnection = mcnnClient
        strPKeys = GetAllPrimaryKeyColumns(arrMastersList(arrInc), mcnnClient)
        arrPKeys = Split(strPKeys, "|")
        strUpdateDate = PickValue("LastUpdatedDetails", "LastUpdatedDate", "TableName = '" & arrMastersList(arrInc) & "'", cnnTo)
        If strUpdateDate = "" Then
            strUpdateDate = CDate(0)
        End If
        sSql = BuildSQLRelation(arrMastersList(arrInc), arrMastersParentList(arrInc), mcnnClient)
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
        pBar.Value = pBar.Value + 1
    Next arrInc
    Set rsTmpFrom = Nothing
    Set rsTmpTo = Nothing
    SynchroniseMasters = True
Exit Function
Err_Exit:
    MsgBox Err.Description, vbInformation
    SynchroniseMasters = False
End Function

Public Function TransferData(blnBackup As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog, rsTmpClient As New ADODB.Recordset
Dim crsTmpServer As New clsRecordSet, strPKeyCol As String, Inc As Long
Dim cnnFrom As ADODB.Connection, cnnTo As ADODB.Connection
Dim cnnFromDoc As ADODB.Connection, cnnToDoc As ADODB.Connection
    TransferData = False
    If blnBackup Then
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnToBak
        Set cnnFromDoc = mcnnFromDoc
        Set cnnToDoc = mcnnToDocBak
    Else
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnTo
        Set cnnFromDoc = mcnnFromDoc
        Set cnnToDoc = mcnnToDoc
    End If
    InitialiseStatusbar
    CurrentAction = "Deleting existing data..."
    If DeleteExistingData(blnBackup, False) Then
        pBar.Value = 20
        '----Transfering data----------
        CurrentAction = "Transfering data..."
        Set adxTmp.ActiveConnection = mcnnClient
        sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder"
        With GetRecords(sSql, mcnnClient)
            While Not .EOF
                CurrentAction = "Transfering data - " & !TableName & "..."
                sSql = "SELECT " & !TableName & ".* FROM " & !TableName & ", " & !ParentTableName & " PTBL"
                strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", mcnnClient)
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
                If blnBackup Then
                    sSql = "INSERT INTO " & pInitialCatelogMainBak & ".dbo." & !TableName & " " & sSql
                    cnnFrom.Execute sSql
                Else
                    crsTmpServer.BindRecords sSql, cnnFrom
                    strPKeyCol = GetPrimaryKeyColumn(!TableName & "", mcnnClient)
                    sSql = "SELECT * FROM " & !TableName & IIf(strPKeyCol = "", "", " WHERE " & strPKeyCol & " = '0'")
                    rsTmpClient.Open sSql, cnnTo, adOpenKeyset, adLockOptimistic
                    While Not crsTmpServer.EOF
                        rsTmpClient.AddNew
                        For Inc = 0 To crsTmpServer.Cols - 1
                            rsTmpClient.Fields(Inc).Value = crsTmpServer.Fields(Inc)
                        Next Inc
                        Percentage = !TableName & ": " & Round(((crsTmpServer.Row + 1) * 100) / crsTmpServer.Rows, 2) & "%"
                        rsTmpClient.Update
                        crsTmpServer.MoveNext
                    Wend
                    rsTmpClient.Close
                    crsTmpServer.Clear
                End If
                .MoveNext
            Wend
            .Close
        End With
        Percentage = ""
        If chkDocTransfer.Value = vbChecked Then
'        If chkDocTransfer.Value = vbChecked And mblnDetach Then
            sSql = "SELECT * FROM DocumentBin Where CompanyID = " & mlngCompanyID
            If blnBackup Then
                sSql = "INSERT INTO " & pInitialCatelogDocBak & ".dbo.DocumentBin " & sSql
                cnnFromDoc.Execute sSql
            Else
                crsTmpServer.BindRecords sSql, cnnFromDoc
                While Not crsTmpServer.EOF
                    CurrentAction = "Transfering external documents - " & crsTmpServer.Fields("Description") & "...."
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
'                    pBar.Value = pBar.Value + 1
                    crsTmpServer.MoveNext
                Wend
                crsTmpServer.Clear
            End If
        End If
        TransferData = True
    End If
    CurrentAction = "Ready...."
    pBar.Visible = False
Exit Function
Err_Exit:
    MsgBox Err.Description
    TransferData = False
End Function

Public Function DeleteExistingData(blnBackup As Boolean, blnRemoveClientData As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog
Dim cnnMain As ADODB.Connection, cnnDoc As ADODB.Connection
    If blnBackup Then
        Set cnnMain = mcnnToBak
        Set cnnDoc = mcnnToDocBak
    ElseIf blnRemoveClientData And Not mblnDetach Then
        Set cnnMain = mcnnFrom
        Set cnnDoc = mcnnFromDoc
    Else
        Set cnnMain = mcnnTo
        Set cnnDoc = mcnnToDoc
    End If
    DeleteExistingData = False
    Set adxTmp.ActiveConnection = mcnnClient
    sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder DESC"
    With GetRecords(sSql, mcnnClient)
        While Not .EOF
            sSql = "DELETE " & !TableName & " FROM " & !TableName & ", " & !ParentTableName & " PTBL"
            strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", mcnnClient)
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
            cnnMain.Execute sSql
            .MoveNext
        Wend
        .Close
    End With
'    If chkDocTransfer.Value = vbChecked And mblnDetach Then
    If chkDocTransfer.Value = vbChecked Then
        sSql = "Delete From DocumentBin Where CompanyID = " & mlngCompanyID
        cnnDoc.Execute sSql
    End If
    DeleteExistingData = True
Exit Function
Err_Exit:
    MsgBox Err.Description
    DeleteExistingData = False
End Function

Public Property Let Percentage(ByVal strNewValue As String)
On Local Error Resume Next
    StatusBar1.Panels(1).Text = strNewValue
End Property

Public Function BackupData(blnBackup As Boolean) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, strWhere As String, adxTmp As New ADOX.Catalog, rsTmpClient As New ADODB.Recordset
Dim crsTmpServer As New clsRecordSet, strPKeyCol As String, Inc As Long
Dim cnnFrom As ADODB.Connection, cnnTo As ADODB.Connection
Dim cnnFromDoc As ADODB.Connection, cnnToDoc As ADODB.Connection
    BackupData = False
    If blnBackup Then
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnToBak
        Set cnnFromDoc = mcnnFromDoc
        Set cnnToDoc = mcnnToDocBak
    Else
        Set cnnFrom = mcnnFrom
        Set cnnTo = mcnnTo
        Set cnnFromDoc = mcnnFromDoc
        Set cnnToDoc = mcnnToDoc
    End If
    InitialiseStatusbar
    CurrentAction = "Deleting existing data..."
    If DeleteExistingData(blnBackup, False) Then
        pBar.Value = 20
        '----Transfering data----------
        CurrentAction = "Transfering data..."
        Set adxTmp.ActiveConnection = mcnnClient
        sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder"
        With GetRecords(sSql, mcnnClient)
            While Not .EOF
                CurrentAction = "Transfering data - " & !TableName & "..."
                sSql = "SELECT " & !TableName & ".* FROM " & !TableName & ", " & !ParentTableName & " PTBL"
                strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "", mcnnClient)
                If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                    If strWhere Then
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
                If blnBackup Then
                    sSql = "INSERT INTO " & pInitialCatelogMainBak & ".dbo." & !TableName & " " & sSql
                    cnnFrom.Execute sSql
                Else
                    crsTmpServer.BindRecords sSql, cnnFrom
                    strPKeyCol = GetPrimaryKeyColumn(!TableName & "", mcnnClient)
                    sSql = "SELECT * FROM " & !TableName & IIf(strPKeyCol = "", "", " WHERE " & strPKeyCol & " = '0'")
                    rsTmpClient.Open sSql, cnnTo, adOpenKeyset, adLockOptimistic
                    While Not crsTmpServer.EOF
                        rsTmpClient.AddNew
                        For Inc = 0 To crsTmpServer.Cols - 1
                            rsTmpClient.Fields(Inc).Value = crsTmpServer.Fields(Inc)
                        Next Inc
                        Percentage = !TableName & ": " & Round(((crsTmpServer.Row + 1) * 100) / crsTmpServer.Rows, 2) & "%"
                        rsTmpClient.Update
                        crsTmpServer.MoveNext
                    Wend
                    rsTmpClient.Close
                    crsTmpServer.Clear
                End If
                .MoveNext
            Wend
            .Close
        End With
        Percentage = ""
        If chkDocTransfer.Value = vbChecked Then
'        If chkDocTransfer.Value = vbChecked And mblnDetach Then
            sSql = "SELECT * FROM DocumentBin WHERE CompanyID = " & mlngCompanyID
            If blnBackup Then
                sSql = "INSERT INTO " & pInitialCatelogDocBak & ".dbo.DocumentBin " & sSql
                cnnFromDoc.Execute sSql
            Else
                crsTmpServer.BindRecords sSql, cnnFromDoc
                While Not crsTmpServer.EOF
                    CurrentAction = "Transfering external documents - " & crsTmpServer.Fields("Description") & "...."
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
                    pBar.Value = pBar.Value + 1
                    crsTmpServer.MoveNext
                Wend
                crsTmpServer.Clear
            End If
        End If
        BackupData = True
    End If
    CurrentAction = "Ready...."
    pBar.Visible = False
Exit Function
Err_Exit:
    MsgBox Err.Description
    BackupData = False
End Function

Public Function TakeDataBaseBackup(lngCompanyID As Long, AdoConn As Connection) As Boolean
On Local Error GoTo Err_Exit
Dim strBackupPath As String, sSql As String
Dim strBackupFileName As String, strBackupFullPath As String
Dim strCompanyJobCode As String, strServerDt As String
Dim strFolderName As String
    If OpenConn(AdoConnLocalMainBak, pServerLocal, pInitialCatelogLocalMain, "sa", pCnnPassword) _
        And OpenConn(AdoConnLocalDocBak, pServerLocal, pInitialCatelogLocalDoc, "sa", pCnnPassword) Then
        Screen.MousePointer = vbHourglass
        strBackupPath = txtBackupPath
        If Trim(strBackupPath) = "" Then
            pMVE.MsgBox "Invalid backup location. Set backup location.", msgOK, App.Title, msgInformation, True
            TakeDataBaseBackup = False
        End If
        '------------------------------------------------------------
        If Right(Trim(strBackupPath), 1) = "\" Then
            strBackupPath = Left(Trim(strBackupPath), Len(Trim(strBackupPath)) - 1)
        End If
        strServerDt = Format(ServerDateTime(AdoConn), "yyyyMMMddHHmm")
        strCompanyJobCode = PickValue("Companies", "JobCode", "CompanyID = " & lngCompanyID)
        strBackupFileName = strCompanyJobCode & "-" & strServerDt
    
        strFolderName = strBackupFileName
    
        MkDir txtBackupPath.Text & strFolderName
    
        strBackupFullPath = txtBackupPath.Text & strFolderName & "\"
    
        AdoConn.CommandTimeout = 30
        sSql = "BACKUP DATABASE " & pInitialCatelogLocalMain & " TO DISK = '" & strBackupFullPath & pInitialCatelogLocalMain & strBackupFileName & "'"
        AdoConnLocalMainBak.Execute sSql
        sSql = "BACKUP DATABASE " & pInitialCatelogLocalDoc & " TO DISK = '" & strBackupFullPath & pInitialCatelogLocalDoc & strBackupFileName & "'"
        AdoConnLocalDocBak.Execute sSql
        AdoConn.CommandTimeout = 30
        Screen.MousePointer = vbDefault
        pMVE.MsgBox "Backup has been taken successfully.", msgOK, App.Title, msgInformation, True
        TakeDataBaseBackup = True
    End If
Exit Function
Err_Exit:
    TakeDataBaseBackup = False
    Screen.MousePointer = vbDefault
    pMVE.MsgBox Err.Description, msgOK, App.Title, msgInformation, True
End Function
