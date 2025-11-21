VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmDetachNAttach 
   Caption         =   "Detach / Attach DataBase"
   ClientHeight    =   2880
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6210
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmDetachNAttach.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   2880
   ScaleWidth      =   6210
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   225
      Left            =   0
      TabIndex        =   5
      Top             =   2655
      Width           =   6210
      _ExtentX        =   10954
      _ExtentY        =   397
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4763
            MinWidth        =   4763
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   2
            Object.Width           =   3528
            MinWidth        =   3528
            TextSave        =   "4/4/2013"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            TextSave        =   "11:49 AM"
         EndProperty
      EndProperty
   End
   Begin VB.CheckBox chkDocTransfer 
      Caption         =   "Transfer documents"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Value           =   2  'Grayed
      Width           =   2055
   End
   Begin MSComctlLib.ProgressBar pBar 
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   2400
      Width           =   6015
      _ExtentX        =   10610
      _ExtentY        =   450
      _Version        =   393216
      BorderStyle     =   1
      Appearance      =   0
   End
   Begin VB.Frame frameDetachAttach 
      Height          =   1575
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   6015
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Company:"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   240
         Left            =   195
         TabIndex        =   10
         Top             =   960
         Width           =   900
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Job Code:"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   240
         Left            =   195
         TabIndex        =   9
         Top             =   360
         Width           =   825
      End
      Begin VB.Label lblCompanyCode 
         Caption         =   "lblCompanyCode"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   1305
         TabIndex        =   8
         Top             =   360
         Width           =   1575
      End
      Begin VB.Label lblCompany 
         AutoSize        =   -1  'True
         Caption         =   "Company not activated"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   1305
         TabIndex        =   3
         Top             =   960
         Width           =   4470
      End
   End
   Begin AIFCmp1.asxPowerButton cmdAction 
      Height          =   360
      Left            =   3840
      TabIndex        =   6
      Top             =   1800
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
      Left            =   5040
      TabIndex        =   7
      Top             =   1800
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
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   225
      Left            =   0
      TabIndex        =   2
      Top             =   2115
      Width           =   630
   End
End
Attribute VB_Name = "frmDetachNAttach"
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

Private Property Let CurrentAction(ByVal strNewValue As String)
    lblCurrentAction = strNewValue
    DoEvents
End Property

Private Sub cmdClose_Click()
    Unload Me
End Sub

'Private Sub cmdGetCompany_Click()
'Dim sSql As String, strCompanyCode As String
'    If txtCompanyCode = "" Then
'        MsgBox "Enter Company Code and try again.", vbInformation
'        Exit Sub
'    End If
'    strCompanyCode = txtCompanyCode
'    If OpenConn(AdoConn, pServer, pInitialCatelog, "sa", "") Then
'        sSql = "Select CompanyName, CompanyID From Companies Where CompanyCode = '" & strCompanyCode & "' "
'        With GetRecords(sSql, AdoConn)
'            If Not .BOF Then
'                lblCompany.Caption = .Fields("CompanyName") & ""
'                mlngCompanyID = .Fields("CompanyID") & ""
'            End If
'            .Close
'        End With
'    End If
'    GetCompanyStatus
'End Sub

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

Private Sub Form_Activate()
    GetCompanyStatus
End Sub

Private Sub Form_Load()
   pBar.Align = vbAlignBottom
   pBar.Visible = False
End Sub

Private Sub GetCompanyStatus()
On Local Error Resume Next
Dim sSql As String, ssqlCmp As String
    If OpenConn(AdoConn, pServer, pInitialCatelog, "sa", pCnnPassword) Then
        ssqlCmp = "Select CompanyName, CompanyCode From Companies Where CompanyID = '" & pActiveCompanyID & "' "
            With GetRecords(ssqlCmp, AdoConn)
                If Not .BOF Then
                    lblCompanyCode.Caption = .Fields("CompanyCode") & ""
                    lblCompany.Caption = .Fields("CompanyName") & ""
                    mlngCompanyID = pActiveCompanyID
                End If
                .Close
            End With
    End If
    If mlngCompanyID <> 0 Then
        sSql = "Select CASE WHEN ISNULL(DetachedBy,'-1')= '-1' THEN 0 ELSE 1 END AS Status From Companies Where CompanyID = " & mlngCompanyID
        With GetRecords(sSql)
            If Not .EOF Then
                If Val(.Fields("Status") & "") = 1 Then
                    cmdAction.Caption = "Attach"
                    Me.Caption = "Attach Data"
                    IsDetached = True
                Else
                    cmdAction.Caption = "Detach"
                    Me.Caption = "Detach Data"
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
On Local Error Resume Next
Dim blnSuccess As Boolean
    cmdClose.Enabled = False
    If mlngCompanyID <= 0 Then
        MsgBox "Invalid Company...", vbInformation
        cmdClose.Enabled = True
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
    If OpenConn(mcnnClient, pServerLocal, pInitialCatelogLocal, "sa", pCnnPassword) _
        And OpenConn(mcnnFromDoc, mstrServerFrom, pInitialCatelogDoc, "sa", pCnnPassword) _
        And OpenConn(mcnnToDoc, mstrServerTo, pInitialCatelogDoc, "sa", pCnnPassword) _
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
        If blnSuccess Then
            End
        End If
    Else
        MsgBox "No local server exists.", vbInformation
    End If
    cmdClose.Enabled = True
End Sub

Private Function CompanyAttachDetach() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strType As String
    CompanyAttachDetach = False
    strType = IIf(mblnDetach, "Detaching", "Attaching")
    If mblnDetach Then
        '--------------Updating Master Tables to client database
        CurrentAction = "Synchronising master data..."
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
        sSql = "UPDATE Companies SET DetachedBy = '" & mstrServerTo & "', DetachedDate = CONVERT(DateTime, CURRENT_TIMESTAMP, 103) WHERE CompanyID = " & mlngCompanyID
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
Exit Function
Err_Exit:
    MsgBox Err.Description, vbInformation
End Function

Private Function SynchroniseMasters(blnBackup As Boolean) As Boolean
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

Private Function TransferData(blnBackup As Boolean) As Boolean
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
        If chkDocTransfer.Value = vbGrayed Then
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
    CurrentAction = "Ready..."
    pBar.Visible = False
Exit Function
Err_Exit:
    MsgBox Err.Description
    TransferData = False
End Function

Private Function DeleteExistingData(blnBackup As Boolean, blnRemoveClientData As Boolean) As Boolean
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
    If chkDocTransfer.Value = vbGrayed Then
        sSql = "Delete From DocumentBin Where CompanyID = " & mlngCompanyID
        cnnDoc.Execute sSql
    End If
    DeleteExistingData = True
Exit Function
Err_Exit:
    MsgBox Err.Description
    DeleteExistingData = False
End Function

Private Property Let Percentage(ByVal strNewValue As String)
On Local Error Resume Next
    StatusBar1.Panels(1).Text = strNewValue
End Property

Private Function BackupData(blnBackup As Boolean) As Boolean
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
