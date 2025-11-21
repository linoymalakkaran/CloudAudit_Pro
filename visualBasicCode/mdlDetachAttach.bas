Attribute VB_Name = "mdlDetachAttach"
Option Explicit

Public Type TypeDetachTables
    TableID As Integer
    TableName As String
    ParentTableName As String
    TableOrder As Integer
    IsCompanyOrPeriodID As Boolean
    IsDetailsUpdated As Boolean
End Type

Public Sub UpdateDetachTables()
On Local Error GoTo Err_Exit
Dim arrSLTbl() As TypeDetachTables, intParentTableID As Integer
Dim ctlgTmp As New ADOX.Catalog, tblInc As ADOX.Table, intTableInc As Integer
Dim sSql As String, arrInc As Long, arrInc1 As Long, intTableOrder As Integer
    Set ctlgTmp.ActiveConnection = AdoConn
    ReDim arrSLTbl(0)
    intTableInc = 0
    intTableOrder = 0
    sSql = "SELECT * FROM DetachTables ORDER BY TableID"
    With GetRecords(sSql)
        While Not .EOF
            intTableInc = Val(!TableID & "")
            ReDim Preserve arrSLTbl(intTableInc)
            arrSLTbl(intTableInc).TableID = intTableInc
            arrSLTbl(intTableInc).TableName = !TableName & ""
            arrSLTbl(intTableInc).ParentTableName = ""
            arrSLTbl(intTableInc).TableOrder = 0
            arrSLTbl(intTableInc).IsCompanyOrPeriodID = False
            arrSLTbl(intTableInc).IsDetailsUpdated = False
            .MoveNext
        Wend
        .Close
    End With
    For Each tblInc In ctlgTmp.Tables
        GetAllRelatedTables arrSLTbl, tblInc, intTableInc, intTableOrder, ""
    Next tblInc
    For arrInc = 1 To UBound(arrSLTbl)
        sSql = "SELECT * FROM DetachTables WHERE TableID = " & arrSLTbl(arrInc).TableID
        With GetRecords(sSql)
            If .BOF Then
                .AddNew
                !TableID = arrSLTbl(arrInc).TableID
            End If
            !TableName = arrSLTbl(arrInc).TableName
            intParentTableID = GetTableID(arrSLTbl, arrSLTbl(arrInc).ParentTableName)
            If intParentTableID > arrSLTbl(arrInc).TableID Or intParentTableID = -1 Then
                !ParentTableID = Null
            Else
                !ParentTableID = intParentTableID
            End If
            !TableOrder = arrSLTbl(arrInc).TableOrder
            !IsCompanyOrPeriodID = arrSLTbl(arrInc).IsCompanyOrPeriodID
            .Update
            .Close
        End With
    Next arrInc
    For arrInc = 1 To UBound(arrSLTbl)
        intParentTableID = GetTableID(arrSLTbl, arrSLTbl(arrInc).ParentTableName)
        If intParentTableID > arrSLTbl(arrInc).TableID Then
            sSql = "UPDATE DetachTables SET ParentTableID = " & intParentTableID & " WHERE TableID = " & arrSLTbl(arrInc).TableID
            AdoConn.Execute sSql
        End If
    Next arrInc
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Function GetAllRelatedTables(ByRef arrSLTbl() As TypeDetachTables, ByVal tblTable As ADOX.Table, _
                                     ByRef intTableInc As Integer, ByRef intTableOrder As Integer, ByVal strParentTbls As String) As Integer
On Local Error GoTo Err_Exit
Dim keyInc As ADOX.Key, blnUpdatable As Boolean, intTableID As Integer
Dim blnIsCompanyOrPeriodID As Boolean, strParentTableName As String, blnIsNew As Boolean
Dim blnIsDetailsUpdated1 As Boolean, blnIsDetailsUpdated2 As Boolean
Dim lngArrIndex1 As Long, lngArrIndex2 As Long, intTableIDTmp As Integer
    intTableID = -1
    blnIsDetailsUpdated1 = False
    blnIsDetailsUpdated2 = False
    With tblTable
        If Not .Name Like "sys*" And Not .Name Like "_tmp*" And .Name <> "dtproperties" _
            And Not .Name Like "Detach*" Then
            intTableIDTmp = GetTableID(arrSLTbl, .Name, lngArrIndex1)
            blnIsDetailsUpdated1 = False
            If lngArrIndex1 > -1 Then
                blnIsDetailsUpdated1 = arrSLTbl(lngArrIndex1).IsDetailsUpdated
            End If
            If lngArrIndex1 = -1 Or Not blnIsDetailsUpdated1 Then
                blnUpdatable = True
                For Each keyInc In .Keys
                    If keyInc.Type = adKeyForeign And keyInc.RelatedTable <> .Name _
                        And Not strParentTbls Like "*|" & keyInc.RelatedTable & "|*" Then
                        GetTableID arrSLTbl, keyInc.RelatedTable, lngArrIndex2
                        blnIsDetailsUpdated2 = False
                        If lngArrIndex2 > -1 Then
                            blnIsDetailsUpdated2 = arrSLTbl(lngArrIndex2).IsDetailsUpdated
                        End If
                        If lngArrIndex2 = -1 Or Not blnIsDetailsUpdated2 Then
                            intTableID = GetAllRelatedTables(arrSLTbl, .ParentCatalog.Tables(keyInc.RelatedTable), _
                                intTableInc, intTableOrder, strParentTbls & "|" & .Name & "|")
                            If intTableID = -1 Then
                                blnUpdatable = False
                                Exit For
                            End If
                        End If
                    End If
                Next keyInc
                If blnUpdatable Then
                    intTableOrder = intTableOrder + 1
                    strParentTableName = GetParentTableName(tblTable)
                    If strParentTableName = "-1" Then
                        blnIsCompanyOrPeriodID = IsTableHasCompanyOrPeriodID(tblTable)
                    Else
                        blnIsCompanyOrPeriodID = True
                    End If
                    If intTableIDTmp <= -1 Or lngArrIndex1 <= -1 Then
                        intTableInc = intTableInc + 1
                        intTableID = intTableInc
                        blnIsNew = True
                    Else
                        intTableID = intTableIDTmp
                        blnIsNew = False
                    End If
                    DetachTables arrSLTbl, intTableID, .Name, strParentTableName, intTableOrder, blnIsCompanyOrPeriodID, blnIsNew
                End If
            End If
        End If
    End With
    GetAllRelatedTables = intTableID
Exit Function
Err_Exit:
    ShowError
End Function

Private Function GetParentTableName(ByVal tblTable As ADOX.Table, Optional ByVal lngLevel As Long = 0) As String
On Local Error GoTo Err_Exit
Dim strParentTableName As String, strImmediateParent As String, strPKey As String
Dim keyFInc As ADOX.Key, indxInc As ADOX.Index, clmInc As ADOX.Column
Dim lngKeyPos As Long, lngKeyPosOld As Long
    strParentTableName = ""
    If IsTableHasCompanyOrPeriodID(tblTable) Then
        strParentTableName = tblTable.Name
    End If
    If strParentTableName = "" Then
        strImmediateParent = ""
        For Each indxInc In tblTable.Indexes
            strPKey = ""
            If indxInc.PrimaryKey Then
                For Each clmInc In indxInc.Columns
                    strPKey = strPKey & "|" & clmInc.Name & "|"
                Next clmInc
            End If
            If strPKey <> "" Then
                Exit For
            End If
        Next indxInc
        If strPKey <> "" Then
            lngKeyPos = 0
            lngKeyPosOld = 0
            For Each keyFInc In tblTable.Keys
                If keyFInc.Type = adKeyForeign Then
                    For Each clmInc In keyFInc.Columns
                        lngKeyPos = InStr(1, strPKey, "|" & clmInc.Name & "|")
                        If lngKeyPos > 0 And (lngKeyPos < lngKeyPosOld Or lngKeyPosOld = 0) Then
                            strImmediateParent = keyFInc.RelatedTable
                            If lngKeyPos = 1 Then
                                Exit For
                            End If
                        End If
                        lngKeyPosOld = lngKeyPos
                    Next clmInc
                    If strImmediateParent <> "" And lngKeyPos = 1 Then
                        Exit For
                    End If
                End If
            Next keyFInc
        End If
        If strImmediateParent <> "" Then
            strParentTableName = GetParentTableName(tblTable.ParentCatalog.Tables(strImmediateParent), lngLevel + 1)
        End If
        If strParentTableName = "" Then
            strParentTableName = -1
        End If
    End If
    If lngLevel = 0 And strParentTableName = tblTable.Name Then
        strParentTableName = -1
    End If
    GetParentTableName = strParentTableName
Exit Function
Err_Exit:
    ShowError
End Function

Private Function IsTableHasCompanyOrPeriodID(ByVal tblTable As ADOX.Table) As Boolean
On Local Error Resume Next
Dim strColName As String
    IsTableHasCompanyOrPeriodID = False
    Err.Clear
    strColName = tblTable.Columns("CompanyID").Name
    If Err.Number = 0 Then
        IsTableHasCompanyOrPeriodID = True
    Else
        Err.Clear
        strColName = tblTable.Columns("PeriodID").Name
        If Err.Number = 0 Then
            IsTableHasCompanyOrPeriodID = True
        End If
    End If
End Function

Private Function GetTableID(ByRef arrDetachTables() As TypeDetachTables, ByVal strTableName As String, _
                            Optional ByRef lngArrIndex As Long = -1, Optional ByRef blnIsDetailsUpdated As Boolean) As Integer
On Local Error Resume Next
Dim arrInc As Long, intTableID As Integer
    intTableID = -1
    lngArrIndex = -1
    blnIsDetailsUpdated = False
    For arrInc = 1 To UBound(arrDetachTables)
        With arrDetachTables(arrInc)
            If UCase(.TableName) = UCase(strTableName) Then
                intTableID = .TableID
                lngArrIndex = arrInc
                blnIsDetailsUpdated = .IsDetailsUpdated
                Exit For
            End If
        End With
    Next arrInc
    GetTableID = intTableID
End Function

Private Sub DetachTables(ByRef arrDetachTables() As TypeDetachTables, TableID As Integer, TableName As String, _
                         ParentTableName As String, TableOrder As Integer, IsCompanyOrPeriodID As Boolean, blnIsNew As Boolean)
    'Keep sorted in TableID wise
    If blnIsNew Then
        ReDim Preserve arrDetachTables(TableID)
    End If
    With arrDetachTables(TableID)
        .TableID = TableID
        .TableName = TableName
        .ParentTableName = ParentTableName
        .TableOrder = TableOrder
        .IsCompanyOrPeriodID = IsCompanyOrPeriodID
        .IsDetailsUpdated = True
    End With
End Sub
