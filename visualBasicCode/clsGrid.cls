VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Option Explicit

Dim mstrGridData() As String, mstrName As String
Dim mlngCols As Long, mlngRows As Long
Dim mlngIndexRow As Long, mlngIndexCol As Long
Const cnstSeparatorCell = "±"
Const cnstSeparatorData = "«"

Public Sub SaveToFile(ByVal strFilename As String)
Dim intFP As Integer
    If strFilename <> "" Then
        intFP = FreeFile
        Open strFilename For Output As #intFP
        Print #intFP, StringData
        Close #intFP
    End If
End Sub

Public Sub LoadFromFile(ByVal strFilename As String)
Dim intFP As Integer, strTmp1 As String, strTmp As String
    If strFilename <> "" Then
        intFP = FreeFile
        Open strFilename For Binary Access Read As #intFP
        Do While Not EOF(intFP) 'Loop until end of file.
           strTmp1 = Input(1, #intFP)
           strTmp = strTmp & strTmp1
        Loop
        Close #intFP
        StringData = strTmp
    End If
End Sub

Public Property Get StringData() As String
Dim strTmp As String
    strTmp = mlngRows & cnstSeparatorData & mlngCols & cnstSeparatorData
    strTmp = strTmp & JoinData(cnstSeparatorCell)
    StringData = strTmp
End Property

Public Property Let StringData(ByVal strNewValue As String)
Dim arrTmp() As String
    arrTmp = Split(strNewValue, cnstSeparatorData)
    If UBound(arrTmp) >= 2 Then
        SplitData arrTmp(2), cnstSeparatorCell, Val(arrTmp(0)), Val(arrTmp(1))
    End If
End Property

Public Property Get IndexRow() As Long
    IndexRow = mlngIndexRow
End Property

Public Property Let IndexRow(ByVal lngNewValue As Long)
    mlngIndexRow = lngNewValue
End Property

Public Property Get IndexCol() As Long
    IndexCol = mlngIndexCol
End Property

Public Property Let IndexCol(ByVal lngNewValue As Long)
    mlngIndexCol = lngNewValue
End Property

Public Property Get TextArrayIndex(ByVal Row As Long, ByVal Col As Long) As Long
    TextArrayIndex = mlngCols * Row + Col
End Property

Public Property Get TextArrayUBound() As Long
    TextArrayUBound = UBound(mstrGridData)
End Property

Public Property Get TextArray(ByVal Index As Long) As String
    If Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    TextArray = mstrGridData(Index)
End Property

Public Property Let TextArray(ByVal Index As Long, ByVal strNewValue As String)
    If Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    mstrGridData(Index) = strNewValue
End Property

Public Property Get TrimMatrix(ByVal Row As Long, ByVal Col As Long) As String
Dim Index As Long
    Index = mlngCols * Row + Col
    If Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    TrimMatrix = Trim(mstrGridData(Index))
End Property

Public Property Get TextMatrix(ByVal Row As Long, ByVal Col As Long) As String
Dim Index As Long
    Index = mlngCols * Row + Col
    If Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    TextMatrix = mstrGridData(Index)
End Property

Public Property Let TextMatrix(ByVal Row As Long, ByVal Col As Long, ByVal strNewValue As String)
Dim Index As Long
    Index = mlngCols * Row + Col
    If Row >= mlngRows Or Row < 0 Or Col >= mlngCols Or Col < 0 Or Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    mstrGridData(Index) = strNewValue
End Property

Public Property Get ValueMatrix(ByVal Row As Long, ByVal Col As Long) As Double
Dim Index As Long
    Index = mlngCols * Row + Col
    If Row >= mlngRows Or Row < 0 Or Col >= mlngCols Or Col < 0 Or Index > UBound(mstrGridData) Or Index < LBound(mstrGridData) Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    End If
    ValueMatrix = FVal(mstrGridData(Index))
End Property

Private Function FindRowFromKey(ByVal strRowKey As String) As Long
Dim Inc As Long, lngRow As Long
    FindRowFromKey = -1
    If mlngIndexCol > -1 And mlngIndexCol < mlngCols Then
        For Inc = 0 To mlngRows - 1
            If TextMatrix(Inc, mlngIndexCol) = strRowKey Then
                FindRowFromKey = Inc
                Exit For
            End If
        Next Inc
    Else
        Err.Raise vbObjectError + 10, , "Indexing Column not set or invalid Indexing Column."
    End If
End Function

Private Function FindColFromKey(ByVal strColKey As String) As Long
Dim Inc As Long, lngCol As Long
    FindColFromKey = -1
    If mlngIndexRow > -1 And mlngIndexRow < mlngRows Then
        For Inc = 0 To mlngCols - 1
            If TextMatrix(mlngIndexRow, Inc) = strColKey Then
                FindColFromKey = Inc
                Exit For
            End If
        Next Inc
    Else
        Err.Raise vbObjectError + 10, , "Indexing Row not set or invalid Indexing Row."
    End If
End Function

Public Property Get TextMatrixOnColIndex(ByVal strRowKey As String, ByVal Col As Long) As String
    TextMatrixOnColIndex = TextMatrix(FindRowFromKey(strRowKey), Col)
End Property

Public Property Let TextMatrixOnColIndex(ByVal strRowKey As String, ByVal Col As Long, ByVal strNewValue As String)
    TextMatrix(FindRowFromKey(strRowKey), Col) = strNewValue
End Property

Public Property Get TextMatrixOnRowIndex(ByVal Row As Long, ByVal strColKey As String) As String
    TextMatrixOnRowIndex = TextMatrix(Row, FindColFromKey(strColKey))
End Property

Public Property Let TextMatrixOnRowIndex(ByVal Row As Long, ByVal strColKey As String, ByVal strNewValue As String)
    TextMatrix(Row, FindColFromKey(strColKey)) = strNewValue
End Property

Public Property Get Cols() As Long
    Cols = mlngCols
End Property

Public Property Let Cols(ByVal lngNewValue As Long)
Dim lngIndex As Long, lngOldCols As Long, lngOldIndex As Long
Dim RowInc As Long, ColInc As Long, lngNewIndex As Long
    'set old values
    lngOldCols = mlngCols
    'set new values
    mlngCols = lngNewValue
    lngIndex = (mlngRows * mlngCols) - 1
    If lngIndex < 0 Then
        lngIndex = 0
    End If
    If lngOldCols > mlngCols Then
        'cols reduced
        For RowInc = 0 To mlngRows - 1
            For ColInc = 0 To mlngCols - 1
                lngNewIndex = mlngCols * RowInc + ColInc
                lngOldIndex = lngOldCols * RowInc + ColInc
                mstrGridData(lngNewIndex) = mstrGridData(lngOldIndex)
            Next ColInc
        Next RowInc
    End If
    ReDim Preserve mstrGridData(lngIndex)
    If lngOldCols < mlngCols Then
        'cols added
        For RowInc = mlngRows - 1 To 0 Step -1
            For ColInc = mlngCols - 1 To 0 Step -1
                lngNewIndex = mlngCols * RowInc + ColInc
                lngOldIndex = lngOldCols * RowInc + ColInc
                If ColInc >= lngOldCols Then
                    mstrGridData(lngNewIndex) = ""
                Else
                    mstrGridData(lngNewIndex) = mstrGridData(lngOldIndex)
                End If
            Next ColInc
        Next RowInc
    End If
End Property

Public Property Get Rows() As Long
    Rows = mlngRows
End Property

Public Property Let Rows(ByVal vNewValue As Long)
Dim lngIndex As Long
    mlngRows = vNewValue
    lngIndex = mlngRows * mlngCols - 1
    If lngIndex < 0 Then
        lngIndex = 0
    End If
    ReDim Preserve mstrGridData(lngIndex)
End Property

Private Sub Class_Initialize()
    Clear
    mlngIndexRow = -1
    mlngIndexCol = -1
End Sub

Public Sub GetValuesFromGridClass(ByRef clsGridClass As clsGrid)
Dim Inc As Long
    mlngRows = clsGridClass.Rows
    Cols = clsGridClass.Cols
    For Inc = 0 To UBound(mstrGridData)
        mstrGridData(Inc) = clsGridClass.TextArray(Inc)
    Next Inc
End Sub

Public Sub Clear()
    mlngRows = 1
    Cols = 1
    mstrGridData(0) = ""
End Sub

Public Sub GetValuesFromGrid(ByRef FlexGrid As Object)
On Local Error GoTo Err_Exit
Dim Inc As Long
    mstrName = FlexGrid.Name
    mlngRows = FlexGrid.Rows
    Cols = FlexGrid.Cols
    For Inc = 0 To UBound(mstrGridData)
        mstrGridData(Inc) = FlexGrid.TextArray(Inc)
    Next Inc
Exit Sub
Err_Exit:
    MsgBox Err.Description, , "clsGrid"
End Sub

Public Sub SetValuesToGrid(ByRef FlexGrid As Object, Optional IgnoreFirstRow As Boolean = False, Optional IsMakeGridVisible As Boolean = True)
Dim Inc As Long, Start As Long
Dim strTmp As String
    'name is refering only for initialising the object
    strTmp = FlexGrid.Name
    If IsMakeGridVisible Then
        FlexGrid.Visible = False
    End If
    FlexGrid.Rows = mlngRows
    FlexGrid.Cols = mlngCols
    Start = IIf(IgnoreFirstRow, 1, 0)
    Start = Start * Cols
    For Inc = Start To UBound(mstrGridData)
        FlexGrid.TextArray(Inc) = mstrGridData(Inc)
    Next Inc
    If IsMakeGridVisible Then
        FlexGrid.Visible = True
    End If
End Sub

Private Function FVal(ByVal vrntValue As Variant) As Double
On Local Error Resume Next
    vrntValue = Replace(vrntValue, "%", "")
    FVal = Val(Replace(vrntValue, ",", ""))
End Function

Public Property Get Name() As String
    Name = mstrName
End Property

Public Property Let Name(ByVal strNewValue As String)
    mstrName = strNewValue
End Property

Private Sub Class_Terminate()
    Clear
End Sub

Public Function JoinData(ByVal strDelimiter As String) As String
    JoinData = Join(mstrGridData, strDelimiter)
End Function

Public Sub SplitData(ByRef strData As String, ByVal strDelimiter As String, ByVal Rows As Long, ByVal Cols As Long)
    mstrGridData = Split(strData, strDelimiter)
    mlngCols = Cols
    mlngRows = Rows
End Sub

Public Sub CopyToClipBoard()
On Local Error Resume Next
Dim strData As String
Dim Inc As Long, IncCols As Long
    For Inc = 1 To Rows - 1
        For IncCols = 0 To Cols - 1
            strData = strData & TextMatrix(Inc, IncCols)
            If IncCols <> Cols - 1 Then
                strData = strData & vbTab
            End If
        Next IncCols
        If Inc <> Rows - 1 Then
            strData = strData & vbNewLine
        End If
    Next Inc
    Clipboard.SetText strData, ClipBoardConstants.vbCFText
End Sub
