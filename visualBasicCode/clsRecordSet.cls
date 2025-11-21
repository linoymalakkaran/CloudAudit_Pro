VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsRecordSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Dim mvarRecords As Variant
Dim mlngRow As Long, mlngRows As Long
Dim msSql As String
Dim mstrFields() As String, mState As Long
Dim mblnBOF As Boolean, mblnEOF As Boolean, mFieldTypes() As Long
Dim CnnLocal As ADODB.Connection

Private Function GetDataTypeNature(ByVal DataType As DataTypeEnum) As String
    Select Case DataType
        Case adBoolean
            GetDataTypeNature = "B"
        Case adBigInt, adBinary, adCurrency, adDecimal, adDouble, adEmpty, _
            adError, adIDispatch, adInteger, adLongVarBinary, adNumeric, _
            adSingle, adSmallInt, adTinyInt, adUnsignedBigInt, adUnsignedInt, _
            adUnsignedSmallInt, adUnsignedTinyInt, adVarBinary, adVarNumeric
            GetDataTypeNature = "N"
        Case adDate, adDBDate, adDBTime, adDBTimeStamp, adFileTime
            GetDataTypeNature = "D"
        Case adBSTR, adChapter, adChar, adGUID, adIUnknown, adLongVarChar, adLongVarWChar, _
            adPropVariant, adUserDefined, adVarChar, adVariant, adVarWChar, adWChar
            GetDataTypeNature = "S"
    End Select
End Function

Public Function GetRows(Optional Filter As String, Optional ByRef RecordCount As Long) As Variant
On Local Error GoTo Err_Exit
Dim mvarRecordsTmp() As Variant, Row As Long, Col As Long, IncRow As Long, IncCol As Long
Dim arrFilters() As String, arrElements() As String, IncFilters As Long, IsFiltered As Boolean
Dim FieldID As Long
    Row = -1
    ReDim Preserve mvarRecordsTmp(Cols - 1, Rows - 1)
    arrFilters = Split(Filter, ";")
    For IncRow = 0 To Rows - 1
        If UBound(arrFilters) <> -1 Then
            IsFiltered = False
            For IncFilters = 0 To UBound(arrFilters)
                arrElements = Split(arrFilters(IncFilters), "|")
                If UBound(arrElements) < 2 Then
                    Err.Raise vbObjectError + 1, , "Error : clsRecordset - Invalid Filter"
                End If
                FieldID = GetNumericIndex(Trim(arrElements(0)))
                Select Case UCase(Trim(arrElements(1)))
                    Case "="
                        IsFiltered = (mvarRecords(FieldID, IncRow) & "" = Trim(arrElements(2)))
                    Case "<"
                        If GetDataTypeNature(FieldType(FieldID)) = "N" Then
                            IsFiltered = (Val(mvarRecords(FieldID, IncRow) & "") < Val(Trim(arrElements(2))))
                        Else
                            IsFiltered = (mvarRecords(FieldID, IncRow) & "" < Trim(arrElements(2)))
                        End If
                    Case ">"
                        If GetDataTypeNature(FieldType(FieldID)) = "N" Then
                            IsFiltered = (Val(mvarRecords(FieldID, IncRow) & "") > Val(Trim(arrElements(2))))
                        Else
                            IsFiltered = (mvarRecords(FieldID, IncRow) & "" > Trim(arrElements(2)))
                        End If
                    Case "<>"
                        IsFiltered = (mvarRecords(FieldID, IncRow) & "" <> Trim(arrElements(2)))
                    Case "<="
                        If GetDataTypeNature(FieldType(FieldID)) = "N" Then
                            IsFiltered = (Val(mvarRecords(FieldID, IncRow) & "") <= Val(Trim(arrElements(2))))
                        Else
                            IsFiltered = (mvarRecords(FieldID, IncRow) & "" <= Trim(arrElements(2)))
                        End If
                    Case ">="
                        If GetDataTypeNature(FieldType(FieldID)) = "N" Then
                            IsFiltered = (Val(mvarRecords(FieldID, IncRow) & "") >= Val(Trim(arrElements(2))))
                        Else
                            IsFiltered = (mvarRecords(FieldID, IncRow) & "" >= Trim(arrElements(2)))
                        End If
                    Case "LIKE"
                        IsFiltered = (UCase(mvarRecords(FieldID, IncRow) & "") Like UCase(Trim(arrElements(2))))
                    Case Else
                        Err.Raise vbObjectError + 1, , "Error : clsRecordset - Invalid Operator On Filter " & IncFilters + 1
                End Select
                If Not IsFiltered Then 'Failed to filter
                    Exit For
                Else
'                    MsgBox "Filter True"
                End If
            Next IncFilters
        Else
            IsFiltered = True 'If No filter then Release this row
        End If
        'Returning Filtered row
        If IsFiltered Then
            Row = Row + 1
            For Col = 0 To Cols - 1
                mvarRecordsTmp(Col, Row) = mvarRecords(Col, IncRow)
            Next Col
        End If
    Next IncRow
    'Returning Resultset
    If Row >= 0 Then
        ReDim Preserve mvarRecordsTmp(Cols - 1, Row)
        RecordCount = Row
    Else
        ReDim Preserve mvarRecordsTmp(Cols - 1, 0)
        RecordCount = -1
    End If
    GetRows = mvarRecordsTmp
Exit Function
Err_Exit:
    Err.Raise Err.Number, "Error : clsRecordset - " & Err.Description
End Function

Public Sub BindRecordSet(ByVal SourceRecordset As clsRecordSet, Optional Filter As String)
On Local Error GoTo Err_Exit
Dim lngFld As Long, mRecordCount As Long
    msSql = ""
    mlngRows = -1
    With SourceRecordset
        If Not .EOF Then
            'Applying filter and geting records
            mvarRecords = .GetRows(Filter, mRecordCount)
            If mRecordCount <> -1 Then
                mlngRows = UBound(mvarRecords, 2) + 1
            Else
                mlngRows = -1
            End If
        End If
        mState = 1 'State Opened
        ReDim mstrFields(.Cols - 1)
        ReDim mFieldTypes(.Cols - 1)
        For lngFld = 0 To .Cols - 1
            mstrFields(lngFld) = .FieldName(lngFld)
            mFieldTypes(lngFld) = .FieldType(lngFld)
        Next lngFld
    End With
    If mlngRows > 0 Then
        mblnBOF = False
        mblnEOF = False
    Else
        mblnBOF = True
        mblnEOF = True
    End If
    mlngRow = 0
Exit Sub
Err_Exit:
    mblnEOF = True: mblnEOF = True
    Err.Raise Err.Number, "Error : clsRecordset - " & Err.Description
End Sub

Public Sub BindRecords(ByRef sSql As String, ByRef cnnConnection As ADODB.Connection)
On Local Error GoTo Err_Exit
Dim lngFld As Long, rsTmp As New ADODB.Recordset, strMsg As String
    msSql = sSql
    mlngRows = -1
    Set CnnLocal = cnnConnection
    rsTmp.Open msSql, cnnConnection, adOpenKeyset, adLockOptimistic
    With rsTmp
        If Not .EOF Then
            mvarRecords = .GetRows()
            mlngRows = UBound(mvarRecords, 2) + 1
        End If
        mState = 1 'State Opened
        ReDim mstrFields(.Fields.Count - 1)
        ReDim mFieldTypes(.Fields.Count - 1)
        For lngFld = 0 To .Fields.Count - 1
            mstrFields(lngFld) = .Fields(lngFld).Name
            mFieldTypes(lngFld) = .Fields(lngFld).Type
        Next lngFld
        .Close
    End With
    If mlngRows > 0 Then
        mblnBOF = False
        mblnEOF = False
    Else
        mblnBOF = True
        mblnEOF = True
    End If
    mlngRow = 0
Exit Sub
Err_Exit:
    mblnEOF = True: mblnEOF = True
    strMsg = Err.Description
    Err.Raise vbObjectError + 1, , "Error : clsRecordset - " & strMsg
End Sub

Public Property Get Rows() As Long
    Rows = mlngRows
End Property

Public Property Let Row(ByVal lngNewValue As Long)
    mlngRow = lngNewValue
    If mlngRow > mlngRows - 1 Then
        mlngRow = mlngRows - 1
        mblnEOF = True
    Else
        mblnEOF = False
    End If
End Property

Public Property Get Row() As Long
    Row = mlngRow
End Property

Public Property Get Cols() As Long
    Cols = UBound(mstrFields, 1) + 1
End Property

Public Property Get Source() As String
    Source = msSql
End Property

Public Property Get DataMatrix(ByVal Row As Long, ByVal Col As Long) As Variant
    DataMatrix = mvarRecords(Col, Row)
End Property

Public Property Get TextMatrix(ByVal Row As Long, ByVal Col As Long) As String
    TextMatrix = mvarRecords(Col, Row) & ""
End Property

Public Sub MoveFirst()
    mlngRow = 0
    If mlngRows > 0 Then
        mblnBOF = False
        mblnEOF = False
    Else
        mblnBOF = True
        mblnEOF = True
    End If
End Sub

Public Sub MoveLast()
    mlngRow = mlngRows - 1
    If mlngRows > 0 Then
        mblnBOF = False
        mblnEOF = False
    Else
        mblnBOF = True
        mblnEOF = True
    End If
End Sub

Public Sub MoveNext()
    mlngRow = mlngRow + 1
    If mlngRow > mlngRows - 1 Then
        mlngRow = mlngRows - 1
        mblnEOF = True
    End If
End Sub

Public Sub MovePrevious()
    mlngRow = mlngRow - 1
    If mlngRow < 0 Then
        mlngRow = 0
        mblnBOF = True
    End If
End Sub

Private Function GetNumericIndex(Index) As Long
Dim lngInc As Long
    lngInc = -1
    If IsNumeric(Index) Then
        lngInc = Index
    Else
        For lngInc = 0 To UBound(mstrFields)
            If UCase(mstrFields(lngInc)) = UCase(Index) Then
                Exit For
            End If
        Next lngInc
    End If
    GetNumericIndex = lngInc
    If lngInc < 0 Then
        Err.Raise vbObjectError + 11, , "Item '" & Index & "' not found corresponding to the name or ordinal position."
    End If
End Function

Public Property Get Fields(Index) As Variant
Dim lngIndex As Long
    lngIndex = GetNumericIndex(Index)
    If lngIndex > -1 Then
        Fields = mvarRecords(lngIndex, mlngRow)
    End If
End Property

Public Property Get FieldsNoNull(Index, ValueIfNull) As Variant
Dim lngIndex As Long
    lngIndex = GetNumericIndex(Index)
    If lngIndex > -1 Then
        FieldsNoNull = IIf(IsNull(mvarRecords(lngIndex, mlngRow)), ValueIfNull, mvarRecords(lngIndex, mlngRow))
    End If
End Property

Public Property Get FieldType(Index) As Long
Dim lngIndex As Long
    lngIndex = GetNumericIndex(Index)
    If lngIndex > -1 Then
        FieldType = mFieldTypes(lngIndex)
    End If
End Property

Public Property Get FieldName(Index) As String
Dim lngIndex As Long
    lngIndex = GetNumericIndex(Index)
    If lngIndex > -1 Then
        FieldName = mstrFields(lngIndex)
    End If
End Property

Public Property Get BOF() As Boolean
    BOF = mblnBOF
End Property

Public Property Get EOF() As Boolean
    EOF = mblnEOF
End Property

Public Sub Clear()
ReDim mvarRecords(0), mstrFields(0), mFieldTypes(0)
    mState = 0 'State Closed
    mlngRows = 0
    mblnBOF = True
    mblnEOF = True
End Sub

Public Property Get State() As Long
    State = mState
End Property

Public Sub Refresh()
    Clear
    BindRecords msSql, CnnLocal
End Sub

Private Sub Class_Initialize()
    mState = 0
    mblnBOF = True
    mblnEOF = True
End Sub

Private Sub Class_Terminate()
    Clear
End Sub

Public Function Search(FieldIndex As Variant, SearchValue As Variant) As Boolean
Dim Inc As Long, lngCol As Long
    lngCol = GetNumericIndex(FieldIndex)
    Search = False
    For Inc = 0 To mlngRows - 1
        If TextMatrix(Inc, lngCol) = CStr(SearchValue) Then
            Row = Inc
            Search = True
            Exit For
        End If
    Next Inc
End Function
