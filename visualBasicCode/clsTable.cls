VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"clsGrid"
Option Explicit

Dim mcgCell As New clsGrid, mlngRows As Long, mlngCols As Long, mlngBorderType As Long
'old separators
Const cnstSeparatorCell = "¦"
Const cnstSeparatorTable = " "
'new separators
Const cnstSepPropCell = "#C#" 'property separator cell
Const cnstSepPropTable = "#T#" 'property separator table

Private Sub Class_Initialize()
    Set mcgCell = New clsGrid
End Sub

Private Sub Class_Terminate()
    On Local Error Resume Next
    mcgCell.Clear
    Set mcgCell = Nothing
End Sub

Public Sub Clear()
    mcgCell.Clear
    Set mcgCell = Nothing
End Sub

Public Sub GetValuesFromGrid(ByRef FlexGrid As VSFlex8Ctl.VSFlexGrid)
Dim RowInc As Long, ColInc As Long, Inc As Long
Dim strFirstMergeText As String, lngFirstMergeIndex As Long, lngColSpanInc As Long
    With FlexGrid
        mcgCell.Cols = rptTblCols
        mcgCell.Rows = .Rows * .Cols
        mlngBorderType = RVal(.Tag)
        mlngRows = .Rows
        mlngCols = .Cols
        For RowInc = 0 To .Rows - 1
            strFirstMergeText = ""
            lngFirstMergeIndex = -1
            lngColSpanInc = 0
            For ColInc = 0 To .Cols - 1
                Inc = .Cols * RowInc + ColInc
                mcgCell.TextMatrix(Inc, rptTblAlignment) = .Cell(flexcpAlignment, RowInc, ColInc)
                mcgCell.TextMatrix(Inc, rptTblBackColor) = .Cell(flexcpBackColor, RowInc, ColInc)
                mcgCell.TextMatrix(Inc, rptTblColWidth) = .ColWidth(ColInc)
                mcgCell.TextMatrix(Inc, rptTblFontName) = .Cell(flexcpFontName, RowInc, ColInc)
                mcgCell.TextMatrix(Inc, rptTblForeColor) = .Cell(flexcpForeColor, RowInc, ColInc)
                mcgCell.TextMatrix(Inc, rptTblIsBold) = IIf(.Cell(flexcpFontBold, RowInc, ColInc), 1, 0)
                mcgCell.TextMatrix(Inc, rptTblIsItalic) = IIf(.Cell(flexcpFontItalic, RowInc, ColInc), 1, 0)
                mcgCell.TextMatrix(Inc, rptTblRowHeight) = .RowHeight(RowInc)
                mcgCell.TextMatrix(Inc, rptTblUnderline) = IIf(.Cell(flexcpFontUnderline, RowInc, ColInc), 1, 0)
                mcgCell.TextMatrix(Inc, rptTblText) = .Cell(flexcpText, RowInc, ColInc)
                If .MergeRow(RowInc) Then
                    If strFirstMergeText = .Cell(flexcpText, RowInc, ColInc) And lngFirstMergeIndex > -1 Then
                        lngColSpanInc = lngColSpanInc + 1
                        mcgCell.TextMatrix(lngFirstMergeIndex, rptTblColSpan) = lngColSpanInc
                    Else
                        strFirstMergeText = .Cell(flexcpText, RowInc, ColInc)
                        lngFirstMergeIndex = Inc
                        lngColSpanInc = 0
                    End If
                End If
            Next ColInc
        Next RowInc
    End With
End Sub

Public Sub SetValuesToGrid(ByRef FlexGrid As VSFlex8Ctl.VSFlexGrid)
Dim RowInc As Long, ColInc As Long, Inc As Long
Dim lngColSpanStart As Long, lngColSpanCols As Long, lngColSpanText As String
    With FlexGrid
        .Tag = mlngBorderType
        .Rows = mlngRows
        .Cols = mlngCols
        For RowInc = 0 To .Rows - 1
            lngColSpanStart = -1
            lngColSpanCols = 0
            lngColSpanText = ""
            For ColInc = 0 To .Cols - 1
                Inc = .Cols * RowInc + ColInc
                .Cell(flexcpAlignment, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblAlignment)
                .Cell(flexcpBackColor, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblBackColor)
                If mcgCell.ValueMatrix(Inc, rptTblColWidth) > 0 Then
                    .ColWidth(ColInc) = mcgCell.ValueMatrix(Inc, rptTblColWidth)
                End If
                .Cell(flexcpFontName, RowInc, ColInc) = mcgCell.TextMatrix(Inc, rptTblFontName)
                .Cell(flexcpForeColor, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblForeColor)
                .Cell(flexcpFontBold, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblIsBold)
                .Cell(flexcpFontItalic, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblIsItalic)
                .RowHeight(RowInc) = mcgCell.ValueMatrix(Inc, rptTblRowHeight)
                .Cell(flexcpFontUnderline, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblUnderline)
                .Cell(flexcpText, RowInc, ColInc) = mcgCell.TextMatrix(Inc, rptTblText)
                If mcgCell.ValueMatrix(Inc, rptTblColSpan) > 1 Then
                    lngColSpanStart = ColInc
                    lngColSpanCols = mcgCell.ValueMatrix(Inc, rptTblColSpan)
                    lngColSpanText = mcgCell.TextMatrix(Inc, rptTblText)
                End If
                If ColInc > lngColSpanStart + lngColSpanCols - 1 Then
                    lngColSpanStart = -1
                    lngColSpanCols = 0
                    lngColSpanText = ""
                End If
                If lngColSpanStart >= 0 Then
                    .MergeCells = flexMergeFree
                    .Cell(flexcpText, RowInc, ColInc) = lngColSpanText
                    .MergeRow(RowInc) = True
                    .Cell(flexcpAlignment, RowInc, ColInc) = mcgCell.ValueMatrix(Inc, rptTblAlignment)
                End If
            Next ColInc
        Next RowInc
    End With
End Sub

Public Function GetGridData() As String
    'GetGridData = mlngRows & cnstSeparatorTable & mlngCols & cnstSeparatorTable & mcgCell.JoinData(cnstSeparatorCell) & _
        cnstSeparatorTable & mlngBorderType
    GetGridData = mlngRows & cnstSepPropTable & mlngCols & cnstSepPropTable & mcgCell.JoinData(cnstSepPropCell) & _
        cnstSepPropTable & mlngBorderType & cnstSepPropTable & rptTblCols
End Function

Public Sub SetGridData(ByVal strData As String)
Dim arrTables() As String, arrCells() As String, lngCurrenctCols As Long, blnIsOldData As Boolean
    If InStr(1, strData, cnstSeparatorTable) <> 0 Or InStr(1, strData, cnstSeparatorCell) <> 0 Then
        arrTables = Split(strData, cnstSeparatorTable)
        blnIsOldData = True
    Else
        arrTables = Split(strData, cnstSepPropTable)
        blnIsOldData = False
    End If
    If UBound(arrTables) >= 2 Then
        mlngRows = Val(arrTables(0))
        mlngCols = Val(arrTables(1))
        If UBound(arrTables) >= 3 Then
            mlngBorderType = RVal(arrTables(3))
        End If
        lngCurrenctCols = 0
        If UBound(arrTables) >= 4 Then
            lngCurrenctCols = RVal(arrTables(4))
        End If
        If lngCurrenctCols = 0 Then
            lngCurrenctCols = rptTblCols - 2
        End If
        If blnIsOldData Then
            mcgCell.SplitData arrTables(2), cnstSeparatorCell, Val(arrTables(0)) * Val(arrTables(1)), lngCurrenctCols
        Else
            mcgCell.SplitData arrTables(2), cnstSepPropCell, Val(arrTables(0)) * Val(arrTables(1)), lngCurrenctCols
        End If
        mcgCell.Cols = rptTblCols
    End If
End Sub

Public Property Get Cell(rptTblProperty As ReportTableProperties, Optional Row As Long, Optional Col As Long) As Variant
Dim Inc As Long
    Inc = mlngCols * Row + Col
    Select Case rptTblProperty
        Case rptTblCols
            Cell = mlngCols
        Case rptTblRows
            Cell = mlngRows
        Case rptTblBackColor, rptTblForeColor, rptTblColWidth, rptTblAlignment, rptTblFontSize, rptTblRowHeight
            Cell = mcgCell.ValueMatrix(Inc, rptTblProperty)
        Case rptTblUnderline, rptTblIsBold, rptTblIsItalic
            Cell = IIf(mcgCell.ValueMatrix(Inc, rptTblProperty) = 0, False, True)
        Case Else
            Cell = mcgCell.TextMatrix(Inc, rptTblProperty)
    End Select
End Property

Public Property Let Cell(rptTblProperty As ReportTableProperties, Optional Row As Long, Optional Col As Long, ByVal varNewValue As Variant)
Dim Inc As Long, Inc1 As Long
    Inc = mlngCols * Row + Col
    Select Case rptTblProperty
        Case rptTblCols
            mlngCols = Val(varNewValue)
            mcgCell.Cols = rptTblCols
            mcgCell.Rows = mlngRows * mlngCols
            For Inc1 = 0 To mcgCell.Rows - 1
                If mcgCell.ValueMatrix(Inc1, rptTblColWidth) = 0 Then
                    mcgCell.TextMatrix(Inc1, rptTblColWidth) = 1000
                End If
            Next Inc1
        Case rptTblRows
            mlngRows = Val(varNewValue)
            mcgCell.Cols = rptTblCols
            mcgCell.Rows = mlngRows * mlngCols
            For Inc1 = 0 To mcgCell.Rows - 1
                If mcgCell.ValueMatrix(Inc1, rptTblRowHeight) = 0 Then
                    mcgCell.TextMatrix(Inc1, rptTblRowHeight) = 315
                End If
            Next Inc1
        Case rptTblUnderline, rptTblIsBold, rptTblIsItalic
            mcgCell.TextMatrix(Inc, rptTblProperty) = IIf(varNewValue, 1, 0)
        Case Else
            mcgCell.TextMatrix(Inc, rptTblProperty) = varNewValue
    End Select
End Property

Public Property Get BorderType() As Long
    BorderType = mlngBorderType
End Property
