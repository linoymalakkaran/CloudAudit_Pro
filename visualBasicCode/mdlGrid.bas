Attribute VB_Name = "mdlGrid"
Option Explicit

Public Sub SelectRow(ByRef Grid As VSFlexGrid, Optional IsBackground As Boolean = True, Optional IsForeground As Boolean = False, Optional lngHiglightBackground As Long = &H80C0FF, Optional lngHighlightText As Long = vbHighlightText, Optional ByVal IsIncludeFixedCols As Boolean = False, Optional IsMakeBold As Boolean = False)
On Local Error Resume Next
Dim lngNormalBackground As Long, lngNormalText As Long
Dim Row As Long
    Grid.Redraw = flexRDNone
    lngNormalBackground = Grid.BackColor 'vbWindowBackground
    lngNormalText = Grid.ForeColor 'vbWindowText
    '--------------------------------------------------------
    If Not IsIncludeFixedCols Then
        If Grid.Row = 0 Then
            Row = 1
        Else
            Row = Grid.Row
        End If
    Else
        Row = Grid.Row
    End If
    '--------------------------------------------------------
    With Grid
        If IsBackground Then
            '---Setting Normal Background to all Cells------------
            .Cell(flexcpBackColor, 1, 0, .Rows - 1, .Cols - 1) = lngNormalBackground
            '---Setting Highlight Background to Selected Row Cells
            .Cell(flexcpBackColor, Row, 0, Row, .Cols - 1) = lngHiglightBackground
            '---Setting bold
            If IsMakeBold Then
                .Cell(flexcpFontBold, 1, 0, .Rows - 1, .Cols - 1) = False
                .Cell(flexcpFontBold, Row, 0, Row, .Cols - 1) = True
            End If
        End If
        If IsForeground Then
            '---Setting Normal Background to all Cells------------
            .Cell(flexcpForeColor, 1, 0, .Rows - 1, .Cols - 1) = lngNormalText
            '---Setting Highlight Background to Selected Row Cells
            .Cell(flexcpForeColor, Row, 0, Row, .Cols - 1) = lngHighlightText
            '---Setting Bold
            If IsMakeBold Then
                .Cell(flexcpFontBold, 1, 0, .Rows - 1, .Cols - 1) = False
                .Cell(flexcpFontBold, Row, 0, Row, .Cols - 1) = True
            End If
        End If
    End With
    Grid.Redraw = flexRDDirect
End Sub

Public Sub CopyGridToGrid(ByRef vsfgFrom As VSFlex8Ctl.VSFlexGrid, ByRef vsfgTo As VSFlex8Ctl.VSFlexGrid)
On Local Error GoTo Err_Exit
Dim ColInc As Long, RowInc As Long
    With vsfgTo
        .Rows = vsfgFrom.Rows
        .Cols = vsfgFrom.Cols
        For RowInc = 0 To vsfgFrom.Rows - 1
            .RowHeight(RowInc) = vsfgFrom.RowHeight(RowInc)
            .RowHidden(RowInc) = vsfgFrom.RowHidden(RowInc)
            For ColInc = 0 To vsfgFrom.Cols - 1
                .ColWidth(ColInc) = vsfgFrom.ColWidth(ColInc)
                .ColHidden(ColInc) = vsfgFrom.ColHidden(ColInc)
                .ColDataType(ColInc) = vsfgFrom.ColDataType(ColInc)
                .ColEditMask(ColInc) = vsfgFrom.ColEditMask(ColInc)
                .ColFormat(ColInc) = vsfgFrom.ColFormat(ColInc)
                .Cell(flexcpAlignment, RowInc, ColInc) = vsfgFrom.Cell(flexcpAlignment, RowInc, ColInc)
                .Cell(flexcpBackColor, RowInc, ColInc) = vsfgFrom.Cell(flexcpBackColor, RowInc, ColInc)
                .Cell(flexcpChecked, RowInc, ColInc) = vsfgFrom.Cell(flexcpChecked, RowInc, ColInc)
                .Cell(flexcpCustomFormat, RowInc, ColInc) = vsfgFrom.Cell(flexcpCustomFormat, RowInc, ColInc)
                .Cell(flexcpData, RowInc, ColInc) = vsfgFrom.Cell(flexcpData, RowInc, ColInc)
                .Cell(flexcpFontBold, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontBold, RowInc, ColInc)
                .Cell(flexcpFontItalic, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontItalic, RowInc, ColInc)
                .Cell(flexcpFontName, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontName, RowInc, ColInc)
                .Cell(flexcpFontSize, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontSize, RowInc, ColInc)
                .Cell(flexcpFontStrikethru, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontStrikethru, RowInc, ColInc)
                .Cell(flexcpFontUnderline, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontUnderline, RowInc, ColInc)
                .Cell(flexcpFontWidth, RowInc, ColInc) = vsfgFrom.Cell(flexcpFontWidth, RowInc, ColInc)
                .Cell(flexcpForeColor, RowInc, ColInc) = vsfgFrom.Cell(flexcpForeColor, RowInc, ColInc)
                Set .Cell(flexcpPicture, RowInc, ColInc) = vsfgFrom.Cell(flexcpPicture, RowInc, ColInc)
                .Cell(flexcpPictureAlignment, RowInc, ColInc) = vsfgFrom.Cell(flexcpPictureAlignment, RowInc, ColInc)
                .Cell(flexcpText, RowInc, ColInc) = vsfgFrom.Cell(flexcpText, RowInc, ColInc)
                .Cell(flexcpTextStyle, RowInc, ColInc) = vsfgFrom.Cell(flexcpTextStyle, RowInc, ColInc)
            Next ColInc
        Next RowInc
    End With
Exit Sub
Err_Exit:
    ShowError
'    Resume Next
End Sub
