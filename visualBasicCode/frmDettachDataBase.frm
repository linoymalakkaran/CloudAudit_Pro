VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmDetachDataBase 
   Caption         =   "Detach DataBase"
   ClientHeight    =   7140
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9255
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7140
   ScaleWidth      =   9255
   WindowState     =   2  'Maximized
   Begin MSComctlLib.ImageList imgToolbarOkCancel 
      Left            =   30
      Top             =   6330
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
            Picture         =   "frmDettachDataBase.frx":0000
            Key             =   "Cancel"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDettachDataBase.frx":031A
            Key             =   "OK"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDettachDataBase.frx":0634
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDettachDataBase.frx":080E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgCompany 
      Height          =   6255
      Left            =   75
      TabIndex        =   1
      Top             =   60
      Width           =   9090
      _cx             =   16034
      _cy             =   11033
      Appearance      =   0
      BorderStyle     =   0
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
      BackColorBkg    =   -2147483643
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483633
      FocusRect       =   1
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
      Cols            =   5
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmDettachDataBase.frx":0968
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   2
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
   Begin MSComctlLib.Toolbar tbrOkCancel 
      Height          =   570
      Left            =   7800
      TabIndex        =   0
      Top             =   6480
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   1005
      ButtonWidth     =   1138
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "imgToolbarOkCancel"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&OK"
            Key             =   "Ok"
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
End
Attribute VB_Name = "frmDetachDataBase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const grdCmpJobCode As Byte = 0
Const grdCmpName As Byte = 1
Const grdCmpDetach As Byte = 2
Const grdCmpReadOnly As Byte = 3
Const grdCmpID As Byte = 4
Const grdCmpCols As Byte = 5
Dim mblnIsDetach As Boolean

Private Sub LoadCompanies()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    With vsfgCompany
        .Rows = 1
        .Cols = grdCmpCols
        .TextMatrix(0, grdCmpJobCode) = "Job Code"
        .TextMatrix(0, grdCmpName) = "Company"
        .TextMatrix(0, grdCmpDetach) = "Detach"
        .TextMatrix(0, grdCmpReadOnly) = "Read Only"
        .TextMatrix(0, grdCmpID) = "ID"
        .ColDataType(grdCmpDetach) = flexDTBoolean
        .ColDataType(grdCmpReadOnly) = flexDTBoolean
        .Cell(flexcpFontBold, 0, grdCmpJobCode, 0, grdCmpReadOnly) = True
    End With
    Inc = 0
    'add user privileges
    sSql = "SELECT CMP.CompanyID, CMP.CompanyName, CMP.JobCode FROM Companies CMP, Periods PRD WHERE CMP.CompanyID = PRD.CompanyID AND CMP.DetachedDate IS NULL GROUP BY CMP.CompanyID, CMP.CompanyName, CMP.JobCode"
    With GetRecords(sSql)
        While Not .EOF
            Inc = Inc + 1
            vsfgCompany.Rows = Inc + 1
            vsfgCompany.TextMatrix(Inc, grdCmpJobCode) = .Fields("JobCode") & ""
            vsfgCompany.TextMatrix(Inc, grdCmpName) = .Fields("CompanyName") & ""
            vsfgCompany.TextMatrix(Inc, grdCmpID) = .Fields("CompanyID") & ""
            vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexChecked
            '26/02/08
            vsfgCompany.ColHidden(grdCmpReadOnly) = True
            .MoveNext
        Wend
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub LoadDetachedCompanies()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, cnnAdoConn As New ADODB.Connection, rsTmp As New ADODB.Recordset
    With vsfgCompany
        .Rows = 1
        .Cols = grdCmpCols
        .TextMatrix(0, grdCmpJobCode) = "Job Code"
        .TextMatrix(0, grdCmpName) = "Company"
        .TextMatrix(0, grdCmpDetach) = "Attach"
        .TextMatrix(0, grdCmpReadOnly) = "ReadOnly"
        .TextMatrix(0, grdCmpID) = "ID"
        .ColDataType(grdCmpDetach) = flexDTBoolean
        .ColDataType(grdCmpReadOnly) = flexDTBoolean
        .Cell(flexcpFontBold, 0, grdCmpJobCode, 0, grdCmpReadOnly) = True
    End With
    Inc = 0
    If (OpenConn(cnnAdoConn, pServerLocal, pInitialCatelogLocal, "sa", pCnnPassword)) Then
        sSql = "SELECT CMP.CompanyID, CMP.CompanyName, CMP.JobCode FROM Companies CMP, Periods PRD WHERE CMP.CompanyID = PRD.CompanyID AND CMP.DetachedDate IS NULL GROUP BY CMP.CompanyID, CMP.CompanyName, Cmp.JobCode"
        rsTmp.Open sSql, cnnAdoConn, adOpenKeyset, adLockOptimistic
            While Not rsTmp.EOF
                Inc = Inc + 1
                vsfgCompany.Rows = Inc + 1
                vsfgCompany.TextMatrix(Inc, grdCmpJobCode) = rsTmp.Fields("JobCode") & ""
                vsfgCompany.TextMatrix(Inc, grdCmpName) = rsTmp.Fields("CompanyName") & ""
                vsfgCompany.TextMatrix(Inc, grdCmpID) = rsTmp.Fields("CompanyID") & ""
                vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexChecked
                '26/02/08
                vsfgCompany.ColHidden(grdCmpReadOnly) = True
                rsTmp.MoveNext
            Wend
        rsTmp.Close
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowAttachDetach(ByVal blnIsDetach As Boolean)
On Local Error Resume Next
    mblnIsDetach = blnIsDetach
        If blnIsDetach Then
            LoadCompanies
        Else
            LoadDetachedCompanies
        End If
End Sub

Private Sub tbrOkCancel_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Inc As Long, sSql As String
    Select Case Button.Key
        Case "Cancel"
            MDIFormMain.CloseActiveTabForm
        Case "Ok"
            If mblnIsDetach Then
                CompanyAttachDetach "Detach"
            Else
                CompanyAttachDetach "Attach"
            End If
    End Select
End Sub

Private Sub DetachCompany(ByVal lngCompanyID As Long, ByRef cnnAdoConn As ADODB.Connection, ByVal strCommand As String)
On Local Error GoTo Err_Exit
Dim sSql As String, adxTmp As New ADOX.Catalog, strWhere As String, strPKeyCol As String
Dim rsTmpServer As New ADODB.Recordset, rsTmpClient As New ADODB.Recordset, Inc As Long
    Set adxTmp.ActiveConnection = AdoConn
    sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder DESC"
    With GetRecords(sSql)
        While Not .EOF
            sSql = "DELETE " & !TableName & " FROM " & !TableName & ", " & !ParentTableName & " PTBL"
            strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "")
            If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                If strWhere = "" Then
                    sSql = sSql & " WHERE PTBL.CompanyID = " & lngCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PTBL.CompanyID = " & lngCompanyID
                End If
            Else
                sSql = sSql & ", Periods PRD "
                If strWhere = "" Then
                    sSql = sSql & " WHERE PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & lngCompanyID
                Else
                    sSql = sSql & " WHERE " & strWhere & " AND PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & lngCompanyID
                End If
            End If
            cnnAdoConn.Execute sSql
            .MoveNext
        Wend
        .Close
    End With
    If strCommand <> "DELETE ONLY" Then
        sSql = "SELECT DT.TableName, ISNULL(DTP.TableName, DT.TableName) AS ParentTableName FROM DetachTables DT LEFT OUTER JOIN DetachTables DTP ON DT.ParentTableID = DTP.TableID WHERE DT.IsCompanyOrPeriodID = 1 ORDER BY DT.TableOrder"
        With GetRecords(sSql)
            While Not .EOF
                sSql = "SELECT " & !TableName & ".* FROM " & !TableName & ", " & !ParentTableName & " PTBL"
                strWhere = BuildSQLRelation(!TableName & "", !ParentTableName & "")
                If IsTableHasCompanyID(adxTmp.Tables(!ParentTableName & "")) Then
                    If strWhere = "" Then
                        sSql = sSql & " WHERE PTBL.CompanyID = " & lngCompanyID
                    Else
                        sSql = sSql & " WHERE " & strWhere & " AND PTBL.CompanyID = " & lngCompanyID
                    End If
                Else
                    sSql = sSql & ", Periods PRD "
                    If strWhere = "" Then
                        sSql = sSql & " WHERE PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & lngCompanyID
                    Else
                        sSql = sSql & " WHERE " & strWhere & " AND PRD.PeriodID = PTBL.PeriodID AND PRD.CompanyID = " & lngCompanyID
                    End If
                End If
                rsTmpServer.Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
                strPKeyCol = GetPrimaryKeyColumn(!TableName & "")
                sSql = "SELECT * FROM " & !TableName & IIf(strPKeyCol = "", "", " WHERE " & strPKeyCol & " = '0'")
                rsTmpClient.Open sSql, cnnAdoConn, adOpenKeyset, adLockOptimistic
                While Not rsTmpServer.EOF
                    rsTmpClient.AddNew
                    For Inc = 0 To rsTmpServer.Fields.Count - 1
                        rsTmpClient.Fields(Inc).Value = rsTmpServer.Fields(Inc).Value
                    Next Inc
                    rsTmpClient.Update
                    rsTmpServer.MoveNext
                Wend
                rsTmpClient.Close
                rsTmpServer.Close
                .MoveNext
            Wend
            .Close
        End With
    End If
    Set adxTmp = Nothing
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Function GetPrimaryKeyColumn(ByVal strTable As String) As String
On Local Error GoTo Err_Exit
Dim ctlgTmp As New ADOX.Catalog, indxInc As ADOX.Index
    Set ctlgTmp.ActiveConnection = AdoConn
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
    ShowError
End Function

Private Function BuildSQLRelation(ByVal strDetailTable As String, ByVal strMasterTable As String) As String
On Local Error GoTo Err_Exit
Dim ctlgTmp As New ADOX.Catalog, strSQL As String
Dim indxInc As ADOX.Index, clmInc As ADOX.Column
    Set ctlgTmp.ActiveConnection = AdoConn
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

Private Function IsTableHasCompanyID(ByVal tblTable As ADOX.Table) As Boolean
On Local Error Resume Next
Dim strColName As String
    IsTableHasCompanyID = False
    Err.Clear
    strColName = tblTable.Columns("CompanyID").Name
    If Err.Number = 0 Then
        IsTableHasCompanyID = True
    End If
End Function

Private Sub vsfgCompany_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Select Case Col
        Case grdCmpDetach, grdCmpReadOnly
        Case Else
            Cancel = True
    End Select
End Sub

Public Sub CompanyAttachDetach(DataBaseAction As String)
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
    Select Case DataBaseAction
        Case "Attach"
            If UCase(pServer) = UCase(pServerLocal) Then
                pMVE.MsgBox "You can't run attach on your local server.", msgOK, "AuditMate", msgCritical, True
                MDIFormMain.CloseActiveTabForm
            Else
                Dim mAdoConn As New ADODB.Connection
                If OpenConn(mAdoConn, pServerLocal, pInitialCatelogLocal, "sa", pCnnPassword) Then
                    Screen.MousePointer = vbHourglass
                    For Inc = 1 To vsfgCompany.Rows - 1
                        If vsfgCompany.Cell(flexcpChecked, Inc, grdCmpDetach) = flexChecked Then            'And vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexUnchecked
                            DetachCompany vsfgCompany.ValueMatrix(Inc, grdCmpID), mAdoConn, ""
                        End If
                    Next Inc
                    For Inc = 0 To vsfgCompany.Rows - 1
                        If vsfgCompany.Cell(flexcpChecked, Inc, grdCmpDetach) = flexChecked Then            'And vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexUnchecked Then
                            sSql = "UPDATE Companies SET DetachedBy = '" & pServer & "', DetachedDate = '" & ServerDateTime & "' WHERE CompanyID = " & vsfgCompany.ValueMatrix(Inc, grdCmpID)
                            mAdoConn.Execute sSql
                            sSql = "UPDATE Companies SET DetachedBy = NULL , DetachedDate = NULL WHERE CompanyID = " & vsfgCompany.ValueMatrix(Inc, grdCmpID)
                            AdoConn.Execute sSql
                        End If
                    Next Inc
                    mAdoConn.Close
                    pMVE.MsgBox "Attaching completed successfully.", msgOK, "AuditMate", msgInformation, True
                    Screen.MousePointer = vbDefault
                    MDIFormMain.CloseActiveTabForm
                Else
                    pMVE.MsgBox "No server exists.", msgOK, "AuditMate", msgCritical, True
                End If
            End If
        Case "Detach"
            If UCase(pServerLocal) = UCase(pServer) Then
                pMVE.MsgBox "You can't run detach on your server machine.", msgOK, "AuditMate", msgCritical, True
                MDIFormMain.CloseActiveTabForm
            Else
                If OpenConn(mAdoConn, pServerLocal, pInitialCatelogLocal, "sa", pCnnPassword) Then
                    Screen.MousePointer = vbHourglass
                    For Inc = 1 To vsfgCompany.Rows - 1
                        If vsfgCompany.Cell(flexcpChecked, Inc, grdCmpDetach) = flexChecked Then
                            DetachCompany vsfgCompany.ValueMatrix(Inc, grdCmpID), mAdoConn, ""
                        End If
                    Next Inc
                    For Inc = 0 To vsfgCompany.Rows - 1
                        If vsfgCompany.Cell(flexcpChecked, Inc, grdCmpDetach) = flexChecked Then            'And vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexUnchecked
                            sSql = "UPDATE Companies SET DetachedBy = '" & pServerLocal & "' , DetachedDate = '" & ServerDateTime & "' WHERE CompanyID = " & vsfgCompany.ValueMatrix(Inc, grdCmpID)
                            AdoConn.Execute sSql
                        '26/02/08
'                        ElseIf vsfgCompany.Cell(flexcpChecked, Inc, grdCmpDetach) = flexChecked Then        'And vsfgCompany.Cell(flexcpChecked, Inc, grdCmpReadOnly) = flexchecked Then
'                            sSql = "UPDATE Companies SET DetachedBy = '" & pServer & "', DetachedDate = '" & ServerDateTime & "' WHERE CompanyID = " & vsfgCompany.ValueMatrix(Inc, grdCmpID)
'                            mAdoConn.Execute sSql
                        End If
                    Next Inc
                    mAdoConn.Close
                    pMVE.MsgBox "Detaching completed successfully.", msgOK, "AuditMate", msgInformation, True
                    Screen.MousePointer = vbDefault
                    MDIFormMain.CloseActiveTabForm
                Else
                    pMVE.MsgBox "No local server exists.", msgOK, "AuditMate", msgCritical, True
                End If
            End If
    End Select
Exit Sub
Err_Exit:
    ShowError
End Sub
