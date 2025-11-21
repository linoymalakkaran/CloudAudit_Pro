VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGridGroup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Option Explicit

Dim mcgGrid() As New clsGrid

Public Sub RemoveItem(Optional ByVal GridIndex As Long = -1, Optional ByVal NoOfItems As Long, Optional IsRaiseErrorIfOutOfBounds As Boolean = True)
Dim lngUBound As Long, Inc As Long
    lngUBound = UBound(mcgGrid)
    'find whether index out of bounds
    If GridIndex + NoOfItems - 1 > lngUBound Or GridIndex < -1 Or NoOfItems < 0 Then
        If IsRaiseErrorIfOutOfBounds Then
            Err.Raise vbObjectError + 10, , "Subscript out of range"
        End If
    Else
        If GridIndex < 0 Then
            GridIndex = (lngUBound - NoOfItems) + 1
        End If
        'transfer values from removed rows
        For Inc = GridIndex To lngUBound - NoOfItems
            mcgGrid(Inc).GetValuesFromGridClass mcgGrid(Inc + NoOfItems)
        Next Inc
        ReDim Preserve mcgGrid(lngUBound - NoOfItems)
    End If
End Sub

Public Sub AddItem(Optional ByRef GridIndex As Long = -1, Optional ByVal NoOfItems As Long = 1)
Dim lngUBound As Long, Inc As Long
    lngUBound = UBound(mcgGrid) + NoOfItems
    If GridIndex + NoOfItems - 1 > lngUBound Or GridIndex < -1 Or NoOfItems < 0 Then
        Err.Raise vbObjectError + 10, , "Subscript out of range"
    Else
        ReDim Preserve mcgGrid(lngUBound)
        If GridIndex < 0 Then
            GridIndex = (lngUBound - NoOfItems) + 1
        End If
        If GridIndex < (lngUBound - NoOfItems) + 1 Then
            'transfer values from inserted rows
            For Inc = lngUBound - NoOfItems To GridIndex Step -1
                mcgGrid(Inc + NoOfItems).GetValuesFromGridClass mcgGrid(Inc)
            Next Inc
            For Inc = GridIndex To GridIndex + NoOfItems - 1
                'clear newly inserted items
                mcgGrid(Inc).Clear
            Next Inc
        End If
    End If
End Sub

Public Property Get cgGrid(ByVal GridIndex As Long) As clsGrid
    Set cgGrid = mcgGrid(GridIndex)
End Property

Public Property Get GridCount() As Long
    GridCount = UBound(mcgGrid) + 1
End Property

Public Property Let GridCount(ByVal lngNewValue As Long)
    ReDim Preserve mcgGrid(lngNewValue - 1)
End Property

Public Property Get TextArray(ByVal GridIndex As Long, ByVal Index As Long) As String
    TextArray = mcgGrid(GridIndex).TextArray(Index)
End Property

Public Property Let TextArray(ByVal GridIndex As Long, ByVal Index As Long, _
    ByVal strNewValue As String)
    mcgGrid(GridIndex).TextArray(Index) = strNewValue
End Property

Public Property Get TextMatrix(ByVal GridIndex As Long, ByVal Row As Long, ByVal Col As Long) As String
    TextMatrix = mcgGrid(GridIndex).TextMatrix(Row, Col)
End Property

Public Property Let TextMatrix(ByVal GridIndex As Long, ByVal Row As Long, ByVal Col As Long, _
    ByVal strNewValue As String)
    mcgGrid(GridIndex).TextMatrix(Row, Col) = strNewValue
End Property

Public Property Get ValueMatrix(ByVal GridIndex As Long, ByVal Row As Long, ByVal Col As Long) As Double
    ValueMatrix = mcgGrid(GridIndex).ValueMatrix(Row, Col)
End Property

Public Property Get Cols(ByVal GridIndex As Long) As Long
    Cols = mcgGrid(GridIndex).Cols
End Property

Public Property Let Cols(ByVal GridIndex As Long, ByVal lngNewValue As Long)
    mcgGrid(GridIndex).Cols = lngNewValue
End Property

Public Property Get Grid(ByVal Index As Long) As clsGrid
    Set Grid = mcgGrid(Index)
End Property

Public Property Let Grid(ByVal Index As Long, cgNewValue As clsGrid)
    Set mcgGrid(Index) = cgNewValue
End Property

Public Property Get Rows(ByVal GridIndex As Long) As Long
    Rows = mcgGrid(GridIndex).Rows
End Property

Public Property Let Rows(ByVal GridIndex As Long, ByVal lngNewValue As Long)
    mcgGrid(GridIndex).Rows = lngNewValue
End Property

Private Sub Class_Initialize()
    Clear
End Sub

Public Sub GetValuesFromGridGrpClass(ByRef clsGridGrpClass As clsGridGroup)
Dim GridIndex As Long
    GridCount = clsGridGrpClass.GridCount
    For GridIndex = 0 To GridCount - 1
        mcgGrid(GridIndex).GetValuesFromGridClass clsGridGrpClass.cgGrid(GridIndex)
    Next GridIndex
End Sub

Public Sub GetValuesFromGridClass(ByVal GridIndex As Long, ByRef clsGridClass As clsGrid)
    mcgGrid(GridIndex).GetValuesFromGridClass clsGridClass
End Sub

Public Sub GetValuesFromGrid(ByVal GridIndex As Long, ByRef FlexGrid As Object)
    mcgGrid(GridIndex).GetValuesFromGrid FlexGrid
End Sub

Public Sub SetValuesToGrid(ByVal GridIndex As Long, ByRef FlexGrid As Object, _
                           Optional IgnoreFirstRow As Boolean = False)
    mcgGrid(GridIndex).SetValuesToGrid FlexGrid, IgnoreFirstRow
End Sub

Private Sub Class_Terminate()
    Clear
End Sub

Public Sub ClearGrid(ByVal GridIndex As Long)
    mcgGrid(GridIndex).Clear
End Sub

Public Sub Clear()
    ReDim mcgGrid(0)
    mcgGrid(0).Clear
End Sub
