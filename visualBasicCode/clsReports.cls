VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsReports"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"clsGridGroup"
Option Explicit

Dim mlngReportID As Long, mlngPeriodID As Long, mlngCompanyID As Long
Dim mstrReportName As String, mlngPaperSize As Long
Dim mdblMarginLeft As Long, mdblMarginTop As Long
Dim mdblMarginRight As Long, mdblMarginBottom As Long
Dim mlngOrientation As Long, mrptTypeReportType As ReportTypes
'Array index is the number of objects, 0th grid index has object properties
'1st grid index is the table's TextMatrix
'2nd grid index is the table's CellProperties
Dim mcggObjects() As New clsGridGroup, mlngObjMax As Long
Dim mstrmPicture() As New ADODB.Stream

Public Sub Clear()
On Local Error Resume Next
Dim ObjInc As Long, lngStrmUBound As Long
    lngStrmUBound = UBound(mstrmPicture)
    For ObjInc = 0 To lngStrmUBound
        mstrmPicture(ObjInc).Close
        Set mstrmPicture(ObjInc) = Nothing
    Next ObjInc
    ReDim mstrmPicture(0)
    mlngReportID = 0
    PeriodID = 0
    mlngObjMax = 0
    ReDim mcggObjects(0)
    mcggObjects(0).Clear
    Set mcggObjects(0) = Nothing
    mlngPaperSize = pprA4
End Sub

Public Sub StartReport(lngPaperSize As Long, dblMarginLeft As Double, dblMarginTop As Double, dblMarginRight As Double, _
                       dblMarginBottom As Double, lngOrientation As Long, Optional lngPeriodID As Long = 0, Optional strReportName As String = "", _
                       Optional lngReportID As Long = 0, Optional rptTypeReportType As ReportTypes = rptTypeTemporary)
    mstrReportName = strReportName
    mlngReportID = lngReportID
    mrptTypeReportType = rptTypeReportType
    If rptTypeReportType = rptTypeAuditReport Then
        PeriodID = lngPeriodID
    Else
        PeriodID = 0
    End If
    mlngPaperSize = IIf(lngPaperSize <= 0, pprA4, lngPaperSize)
    mdblMarginLeft = dblMarginLeft
    mdblMarginTop = dblMarginTop
    mdblMarginRight = dblMarginRight
    mdblMarginBottom = dblMarginBottom
    mlngOrientation = lngOrientation
End Sub

Public Sub EndReport(Optional ByRef vpPreview As VSPrinter8LibCtl.VSPrinter = Nothing)
On Local Error GoTo Err_Exit
Dim sSql As String, ObjInc As Long, rsObjects As New ADODB.Recordset
Dim rsObjectsSub As New ADODB.Recordset, lngSubSlNo As Long
Dim RowInc As Long, ColInc As Long
    If mrptTypeReportType = rptTypeTemporary Then
        If vpPreview Is Nothing Then
            With frmPreview
                LoadReports 0, .vpPreview, Me
                .Show , MDIFormMain
                .ZOrder vbBringToFront
            End With
        Else
            LoadReports 0, vpPreview, Me
        End If
        Clear
    Else
        If mlngReportID <= 0 Then
            mlngReportID = GetMaxNo("Reports", "ReportID")
        End If
        lngSubSlNo = 0
        AdoConn.BeginTrans
        ExeSQL = "DELETE FROM ReportsObjectsSub WHERE ReportID = " & mlngReportID
        ExeSQL = "DELETE FROM ReportsObjects WHERE ReportID = " & mlngReportID
        sSql = "SELECT * FROM ReportsObjects WHERE ReportID = " & mlngReportID
        rsObjects.Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
        sSql = "SELECT * FROM ReportsObjectsSub WHERE ReportID = " & mlngReportID
        rsObjectsSub.Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
        sSql = "SELECT * FROM Reports WHERE ReportID = " & mlngReportID
        With GetRecords(sSql)
            If .BOF Then
                .AddNew
                !ReportID = mlngReportID
            End If
            !ReportName = IIf(mstrReportName = "", mlngReportID, mstrReportName)
            !PeriodID = IIf(mlngPeriodID <= 0, Null, mlngPeriodID)
            !ReportTypeID = mrptTypeReportType
            !PaperSize = mlngPaperSize
            !MarginLeft = mdblMarginLeft
            !MarginTop = mdblMarginTop
            !MarginRight = mdblMarginRight
            !MarginBottom = mdblMarginBottom
            !Orientation = mlngOrientation
            .Update
            .Close
        End With
        For ObjInc = 1 To mlngObjMax
            With mcggObjects(ObjInc)
                rsObjects.AddNew
                rsObjects!ReportID = mlngReportID
                rsObjects!ObjSlNo = ObjInc
                rsObjects!ObjectTypeID = .ValueMatrix(0, 0, rptObjTypeID)
                rsObjects!ObjectName = .TextMatrix(0, 0, rptObjName)
                rsObjects!TextRTF = .TextMatrix(0, 0, rptObjTextRtf)
                rsObjects!PaperSize = IIf(.ValueMatrix(0, 0, rptObjPaperSize) < 0, mlngPaperSize, .ValueMatrix(0, 0, rptObjPaperSize))
                rsObjects!MarginBottom = IIf(.ValueMatrix(0, 0, rptObjMarginBottom) < 0, mdblMarginBottom, .ValueMatrix(0, 0, rptObjMarginBottom))
                rsObjects!MarginLeft = IIf(.ValueMatrix(0, 0, rptObjMarginLeft) < 0, mdblMarginLeft, .ValueMatrix(0, 0, rptObjMarginLeft))
                rsObjects!MarginRight = IIf(.ValueMatrix(0, 0, rptObjMarginRight) < 0, mdblMarginRight, .ValueMatrix(0, 0, rptObjMarginRight))
                rsObjects!MarginTop = IIf(.ValueMatrix(0, 0, rptObjMarginTop) < 0, mdblMarginTop, .ValueMatrix(0, 0, rptObjMarginTop))
                rsObjects!Orientation = IIf(.ValueMatrix(0, 0, rptObjOrientation) < 0, mlngOrientation, .ValueMatrix(0, 0, rptObjOrientation))
                If .ValueMatrix(0, 0, rptObjTypeID) = objtpPicture Then
                    rsObjects!Picture = mstrmPicture(ObjInc).Read
                End If
                rsObjects!ObjLeft = .ValueMatrix(0, 0, rptObjLeft)
                rsObjects!ObjTop = .ValueMatrix(0, 0, rptObjTop)
                rsObjects!ObjWidth = .ValueMatrix(0, 0, rptObjWidth)
                rsObjects!ObjHeight = .ValueMatrix(0, 0, rptObjHeight)
                rsObjects!BorderTypeID = .ValueMatrix(0, 0, rptObjBorderTypeID)
                rsObjects!NoOfRows = .ValueMatrix(0, 0, rptObjNoOfRows)
                rsObjects!NoOfCols = .ValueMatrix(0, 0, rptObjNoOfCols)
                If .ValueMatrix(0, 0, rptObjTableTypeID) <= 0 Then
                    rsObjects!TableTypeID = Null
                Else
                    rsObjects!TableTypeID = .ValueMatrix(0, 0, rptObjTableTypeID)
                End If
                If .ValueMatrix(0, 0, rptObjAcTypeID) <= 0 Then
                    rsObjects!AcTypeID = Null
                Else
                    rsObjects!AcTypeID = .ValueMatrix(0, 0, rptObjAcTypeID)
                End If
                rsObjects.Update
                If .ValueMatrix(0, 0, rptObjTypeID) = objtpTable Then
                    For RowInc = 0 To .Rows(1) - 1
                        For ColInc = 0 To .Cols(1) - 1
                            lngSubSlNo = lngSubSlNo + 1
                            rsObjectsSub.AddNew
                            rsObjectsSub!ReportID = mlngReportID
                            rsObjectsSub!SubSlNo = lngSubSlNo
                            rsObjectsSub!ObjSlNo = ObjInc
                            rsObjectsSub!TextRTF = .TextMatrix(1, RowInc, ColInc)
                            rsObjectsSub!Row = RowInc
                            rsObjectsSub!Col = ColInc
                            rsObjectsSub!BackColor = .ValueMatrix(RowInc + 2, rptTblBackColor, ColInc)
                            rsObjectsSub!ForeColor = .ValueMatrix(RowInc + 2, rptTblForeColor, ColInc)
                            rsObjectsSub!ColWidth = .ValueMatrix(RowInc + 2, rptTblColWidth, ColInc)
                            If .ValueMatrix(RowInc + 2, rptTblUnderline, ColInc) > -1 Then
                                rsObjectsSub!Underline = .ValueMatrix(RowInc + 2, rptTblUnderline, ColInc)
                            Else
                                rsObjectsSub!Underline = 0
                            End If
                            If .ValueMatrix(RowInc + 2, rptTblIsBold, ColInc) > -1 Then
                                rsObjectsSub!IsBold = .ValueMatrix(RowInc + 2, rptTblIsBold, ColInc)
                            Else
                                rsObjectsSub!IsBold = 0
                            End If
                            rsObjectsSub!FontSize = .ValueMatrix(RowInc + 2, rptTblFontSize, ColInc)
                            If .ValueMatrix(RowInc + 2, rptTblIsItalic, ColInc) > -1 Then
                                rsObjectsSub!IsItalic = .ValueMatrix(RowInc + 2, rptTblIsItalic, ColInc)
                            Else
                                rsObjectsSub!IsItalic = 0
                            End If
                            rsObjectsSub!Alignment = .ValueMatrix(RowInc + 2, rptTblAlignment, ColInc)
                            rsObjectsSub!FontName = .TextMatrix(RowInc + 2, rptTblFontName, ColInc)
                            rsObjectsSub!RowHeight = .ValueMatrix(RowInc + 2, rptTblRowHeight, ColInc)
                            rsObjectsSub.Update
                        Next ColInc
                    Next RowInc
                End If
            End With
        Next ObjInc
        rsObjects.Close
        Set rsObjects = Nothing
        rsObjectsSub.Close
        Set rsObjectsSub = Nothing
        AdoConn.CommitTrans
    End If
Exit Sub
Err_Exit:
    ShowError
    AdoConn.RollbackTrans
End Sub

Private Function CreateNewReportObject() As clsGridGroup
    mlngObjMax = mlngObjMax + 1
    ReDim Preserve mcggObjects(mlngObjMax)
    ReDim Preserve mstrmPicture(mlngObjMax)
    mcggObjects(mlngObjMax).Rows(0) = 1
    mcggObjects(mlngObjMax).Cols(0) = rptObjGridColCount
    Set CreateNewReportObject = mcggObjects(mlngObjMax)
End Function

Public Sub CreateText(strTextRTF As String, lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long, _
                      Optional strName As String = "", Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, _
                      Optional dblMarginLeft As Double = -1, Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, _
                      Optional dblMarginBottom As Double = -1, Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1, _
                      Optional blnBold As Boolean = False, Optional blnItalic As Boolean = False, Optional blnUnderLine As Boolean = False, _
                      Optional sglFontSize As Single = 0, Optional strFontName As String = "", Optional epaAlign As ERECParagraphAlignmentConstants = ercParaJustify)
    'Dim strAlign As String
    'If Left(strTextRTF, 6) <> "{\rtf1" Then
    '    Select Case epaAlign
    '    Case ercParaCentre
    '        strAlign = "\qc"
    '    Case ercParaJustify
    '        strAlign = "\qj"
    '    Case ercParaLeft
    '        strAlign = ""
    '    Case ercParaRight
    '        strAlign = "\qr"
    '    Case Else
    '        strAlign = "\qj"
    '    End Select
    '    strTextRTF = "{\rtf1\ansi\ansicpg1252\deff0{\fonttbl{\f0\fnil\fcharset0 " & IIf(strFontName = "", "MS Sans Serif", strFontName) & ";}}" & vbCrLf & "\viewkind4\uc1\pard" & strAlign & "\lang1033" & IIf(blnUnderLine, "\ul", "") & IIf(blnBold, "\b", "") & IIf(blnItalic, "\i", "") & "\f0\fs" & IIf(sglFontSize <= 0, 17, sglFontSize * 2) & " " & Replace(strTextRTF, vbCrLf, vbCrLf & "\par ") & vbCrLf & "\par }" & vbCrLf
    'End If
    strTextRTF = CreateRTF(strTextRTF, strFontName, sglFontSize, blnBold, blnItalic, blnUnderLine, epaAlign)
    With CreateNewReportObject
        .TextMatrix(0, 0, rptObjTypeID) = objtpText
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjTextRtf) = strTextRTF
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngLeft
        .TextMatrix(0, 0, rptObjTop) = lngTop
        .TextMatrix(0, 0, rptObjWidth) = lngWidth
        .TextMatrix(0, 0, rptObjHeight) = lngHeight
    End With
End Sub

Public Sub CreateLine(lngX1 As Long, lngY1 As Long, lngX2 As Long, lngY2 As Long, Optional strName As String = "", _
                      Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, Optional dblMarginLeft As Double = -1, _
                      Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, Optional dblMarginBottom As Double = -1, _
                      Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1)
    With CreateNewReportObject
        .TextMatrix(0, 0, rptObjTypeID) = objtpLine
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngX1
        .TextMatrix(0, 0, rptObjTop) = lngY1
        .TextMatrix(0, 0, rptObjWidth) = lngX2
        .TextMatrix(0, 0, rptObjHeight) = lngY2
    End With
End Sub

Public Sub CreateRectangle(lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long, Optional strName As String = "", _
                           Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, Optional dblMarginLeft As Double = -1, _
                           Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, Optional dblMarginBottom As Double = -1, _
                           Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1)
    With CreateNewReportObject
        .TextMatrix(0, 0, rptObjTypeID) = objtpRectangle
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngLeft
        .TextMatrix(0, 0, rptObjTop) = lngTop
        .TextMatrix(0, 0, rptObjWidth) = lngWidth
        .TextMatrix(0, 0, rptObjHeight) = lngHeight
    End With
End Sub

Public Sub CreateOval(lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long, Optional strName As String = "", _
                      Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, Optional dblMarginLeft As Double = -1, _
                      Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, Optional dblMarginBottom As Double = -1, _
                      Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1)
    With CreateNewReportObject
        .TextMatrix(0, 0, rptObjTypeID) = objtpOval
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngLeft
        .TextMatrix(0, 0, rptObjTop) = lngTop
        .TextMatrix(0, 0, rptObjWidth) = lngWidth
        .TextMatrix(0, 0, rptObjHeight) = lngHeight
    End With
End Sub

Public Sub CreatePageBreak(Optional strName As String = "", _
                           Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, Optional dblMarginLeft As Double = -1, _
                           Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, Optional dblMarginBottom As Double = -1, _
                           Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1)
    With CreateNewReportObject
        .TextMatrix(0, 0, rptObjTypeID) = objtpPageBreak
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
    End With
End Sub

Public Sub CreatePicture(imgPicture As Image, lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long, _
                         Optional strName As String = "", Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, _
                         Optional dblMarginLeft As Double = -1, Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, _
                         Optional dblMarginBottom As Double = -1, Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1)
Dim strPicFileName As String
    With CreateNewReportObject()
        Set mstrmPicture(mlngObjMax) = New ADODB.Stream
        mstrmPicture(mlngObjMax).Type = adTypeBinary
        mstrmPicture(mlngObjMax).Open
        strPicFileName = App.Path & IIf(Right(App.Path, 1) = "\", "", "\") & "tmp.pic"
        SavePicture imgPicture.Picture, strPicFileName
        mstrmPicture(mlngObjMax).LoadFromFile strPicFileName
        .TextMatrix(0, 0, rptObjTypeID) = objtpPicture
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngLeft
        .TextMatrix(0, 0, rptObjTop) = lngTop
        .TextMatrix(0, 0, rptObjWidth) = lngWidth
        .TextMatrix(0, 0, rptObjHeight) = lngHeight
    End With
End Sub

Public Sub StartTable(lngLeft As Long, lngTop As Long, lngWidth As Long, lngHeight As Long, rptTTTableType As ReportTableTypes, _
                      Optional lngAcTypeID As Long = 0, Optional strName As String = "", Optional pssPaperSize As VSPrinter8LibCtl.PaperSizeSettings = -1, _
                      Optional dblMarginLeft As Double = -1, Optional dblMarginTop As Double = -1, Optional dblMarginRight As Double = -1, _
                      Optional dblMarginBottom As Double = -1, Optional orsOrientation As VSPrinter8LibCtl.OrientationSettings = -1, _
                      Optional tbsBorderTypeID As TableBorderSettings = tbNone, Optional strTableType As String = "", Optional strAcType As String = "")
    With CreateNewReportObject()
        .TextMatrix(0, 0, rptObjTypeID) = objtpTable
        .TextMatrix(0, 0, rptObjName) = strName
        .TextMatrix(0, 0, rptObjPaperSize) = pssPaperSize
        .TextMatrix(0, 0, rptObjMarginBottom) = dblMarginBottom
        .TextMatrix(0, 0, rptObjMarginLeft) = dblMarginLeft
        .TextMatrix(0, 0, rptObjMarginRight) = dblMarginRight
        .TextMatrix(0, 0, rptObjMarginTop) = dblMarginTop
        .TextMatrix(0, 0, rptObjOrientation) = orsOrientation
        .TextMatrix(0, 0, rptObjLeft) = lngLeft
        .TextMatrix(0, 0, rptObjTop) = lngTop
        .TextMatrix(0, 0, rptObjWidth) = lngWidth
        .TextMatrix(0, 0, rptObjHeight) = lngHeight
        .TextMatrix(0, 0, rptObjTableTypeID) = rptTTTableType
        .TextMatrix(0, 0, rptObjAcTypeID) = lngAcTypeID
        .TextMatrix(0, 0, rptObjTableTypeName) = strTableType
        .TextMatrix(0, 0, rptObjAcTypeName) = strAcType
        .TextMatrix(0, 0, rptObjBorderTypeID) = tbsBorderTypeID
        InitializeTableObject
        ConfigureTableProperties
    End With
End Sub

Private Sub InitializeTableObject()
    With mcggObjects(mlngObjMax)
        .AddItem 1
        .ClearGrid (1)
        .Rows(1) = 1
        .Cols(1) = 1
    End With
End Sub

Public Sub EndTable()
On Local Error GoTo Err_Exit
Dim RowInc As Long, ColInc As Long, strText As String, strPrefix As String
Dim arrColWidth() As Single, cgPrintWidth As New clsGrid, sngColWidth As Single
Dim rptTTTableType As ReportTableTypes
    frmPreview.vpPreview.StartDoc
    With mcggObjects(mlngObjMax)
        .TextMatrix(0, 0, rptObjNoOfCols) = .Cols(1)
        .TextMatrix(0, 0, rptObjNoOfRows) = .Rows(1)
        rptTTTableType = .ValueMatrix(0, 0, rptObjTableTypeID)
        ReDim arrColWidth(.Cols(1))
        cgPrintWidth.Cols = .Cols(1)
        cgPrintWidth.Rows = .Rows(1)
    End With
    If rptTTTableType <> rptTTCustomTable Then
        For ColInc = 0 To TableCols - 1
            For RowInc = 0 To TableRows - 1
                strText = Trim(TableCell(rptTblText, RowInc, ColInc))
                If IsNumeric(strText) Then
                    cgPrintWidth.TextMatrix(RowInc, ColInc) = TableCellTextPrintWidth("", RowInc, ColInc)
                    If arrColWidth(ColInc) < cgPrintWidth.ValueMatrix(RowInc, ColInc) Then
                        arrColWidth(ColInc) = cgPrintWidth.ValueMatrix(RowInc, ColInc)
                    End If
                End If
            Next RowInc
            For RowInc = 0 To TableRows - 1
                strText = Trim(TableCell(rptTblText, RowInc, ColInc))
                If (IsNumeric(strText) Or Trim(strText) = "-") And TableCell(rptTblUnderline, RowInc, ColInc) = "1" Then
                    sngColWidth = cgPrintWidth.ValueMatrix(RowInc, ColInc)
                    strPrefix = ""
                    While arrColWidth(ColInc) > sngColWidth
                        strPrefix = strPrefix & " "
                        sngColWidth = TableCellTextPrintWidth(strPrefix, RowInc, ColInc)
                    Wend
                    TableCell(rptTblText, RowInc, ColInc) = strPrefix & strText
                End If
            Next RowInc
        Next ColInc
    End If
    frmPreview.vpPreview.EndDoc
    Unload frmPreview
Exit Sub
Err_Exit:
    ShowError
    Unload frmPreview
End Sub

Private Function TableCellTextPrintWidth(ByVal strPrefix As String, Row As Long, Col As Long) As Single
On Local Error Resume Next
Dim sngTextWidth As Single
    With frmPreview.vpPreview
        If RVal(TableCell(rptTblAlignment, Row, Col)) > -1 Then
            .TextAlign = TableCell(rptTblAlignment, Row, Col)
        End If
        If TableCell(rptTblFontName, Row, Col) <> "" Then
            .FontName = TableCell(rptTblFontName, Row, Col)
        End If
        If RVal(TableCell(rptTblFontSize, Row, Col)) > 0 Then
            .FontSize = RVal(TableCell(rptTblFontSize, Row, Col))
        End If
        If TableCell(rptTblIsBold, Row, Col) <> "" Then
            .FontBold = (TableCell(rptTblIsBold, Row, Col) = "1")
        End If
        If TableCell(rptTblIsItalic, Row, Col) <> "" Then
            .FontItalic = (TableCell(rptTblIsItalic, Row, Col) = "1")
        End If
        If TableCell(rptTblUnderline, Row, Col) <> "" Then
            .FontUnderline = (TableCell(rptTblUnderline, Row, Col) = "1")
        End If
        .CalcText = strPrefix & Replace(Replace(Trim(TableCell(rptTblText, Row, Col)), vbCr, ""), vbLf, "")
        sngTextWidth = .TextWid
    End With
    TableCellTextPrintWidth = sngTextWidth
End Function

Public Property Get TableCols() As Long
    TableCols = mcggObjects(mlngObjMax).Cols(1)
End Property

Public Property Let TableCols(ByVal lngNewValue As Long)
    mcggObjects(mlngObjMax).Cols(1) = lngNewValue
    ConfigureTableProperties
End Property

Public Property Get TableRows() As Long
    TableRows = mcggObjects(mlngObjMax).Rows(1)
End Property

Public Property Let TableRows(ByVal lngNewValue As Long)
On Local Error Resume Next
    mcggObjects(mlngObjMax).Rows(1) = lngNewValue
    ConfigureTableProperties
End Property

Public Function TableAddRow(Optional ByVal lngRowsToAdd As Long = 1) As Long
    With mcggObjects(mlngObjMax)
        .Rows(1) = .Rows(1) + lngRowsToAdd
        TableAddRow = .Rows(1) - 1
    End With
    ConfigureTableProperties
End Function

Private Sub ConfigureTableProperties()
On Local Error Resume Next
Dim RowInc As Long, ColInc As Long, lngNoOfItems As Long
Dim lngNewRows As Long, lngNewCols As Long
    lngNewRows = 0
    With mcggObjects(mlngObjMax)
        Select Case .Rows(1)
        Case Is > .GridCount - 2
            lngNoOfItems = .Rows(1) - (.GridCount - 2)
            .AddItem , lngNoOfItems
            lngNewRows = lngNoOfItems
        Case Is = .GridCount - 2
            'No action needed because it is equal
        Case Is < .GridCount - 2
            lngNoOfItems = (.GridCount - 2) - .Rows(1)
            .RemoveItem , lngNoOfItems
        End Select
        For RowInc = 0 To .Rows(1) - 1
            lngNewCols = .Cols(1) - .Cols(RowInc + 2)
            .Cols(RowInc + 2) = .Cols(1)
            .Rows(RowInc + 2) = cnstRptTblPropertyCount
            For ColInc = 0 To .Cols(1) - 1
                If RowInc >= .Rows(1) - lngNewRows Or ColInc >= .Cols(1) - lngNewCols Or (.Cols(1) = 1 And .Rows(1) = 1) Then
                    .TextMatrix(RowInc + 2, rptTblBackColor, ColInc) = -1
                    .TextMatrix(RowInc + 2, rptTblColWidth, ColInc) = -1
                    .TextMatrix(RowInc + 2, rptTblForeColor, ColInc) = -1
                    .TextMatrix(RowInc + 2, rptTblRowHeight, ColInc) = -1
                End If
            Next ColInc
        Next RowInc
        .TextMatrix(0, 0, rptObjNoOfCols) = .Cols(1)
        .TextMatrix(0, 0, rptObjNoOfRows) = .Rows(1)
    End With
End Sub

Public Property Get TableCell(rptTblTableProperty As ReportTableProperties, Optional Row1 As Long, Optional Col1 As Long, Optional Row2 As Long, Optional Col2 As Long) As Variant
    With mcggObjects(mlngObjMax)
        If rptTblTableProperty = rptTblText Then
            TableCell = .TextMatrix(1, Row1, Col1)
        Else
            TableCell = .TextMatrix(Row1 + 2, rptTblTableProperty, Col1)
        End If
    End With
End Property

Public Property Let TableCell(rptTblTableProperty As ReportTableProperties, Optional Row1 As Long = -1, Optional Col1 As Long = -1, Optional Row2 As Long, Optional Col2 As Long, varNewValue As Variant)
Dim RowMax As Long, ColMax As Long, RowInc As Long, ColInc As Long
Dim RowMin As Long, ColMin As Long
    With mcggObjects(mlngObjMax)
        If Row1 = -1 Then
            RowMin = 0
            RowMax = .Rows(1) - 1
        Else
            RowMin = Row1
            RowMax = IIf(Row1 > Row2, Row1, Row2)
        End If
        If Col1 = -1 Then
            ColMin = 0
            ColMax = .Cols(1) - 1
        Else
            ColMin = Col1
            ColMax = IIf(Col1 > Col2, Col1, Col2)
        End If
        For RowInc = RowMin To RowMax
            For ColInc = ColMin To ColMax
                If rptTblTableProperty = rptTblText Then
                    .TextMatrix(1, RowInc, ColInc) = varNewValue
                Else
                    Select Case rptTblTableProperty
                    Case rptTblUnderline, rptTblIsItalic, rptTblIsBold
                        Select Case varNewValue
                        Case "True"
                            .TextMatrix(RowInc + 2, rptTblTableProperty, ColInc) = 1
                        Case "False"
                            .TextMatrix(RowInc + 2, rptTblTableProperty, ColInc) = 0
                        Case Else
                            .TextMatrix(RowInc + 2, rptTblTableProperty, ColInc) = varNewValue
                        End Select
                    Case Else
                        .TextMatrix(RowInc + 2, rptTblTableProperty, ColInc) = varNewValue
                    End Select
                End If
            Next ColInc
        Next RowInc
    End With
End Property

Private Sub Class_Initialize()
    Clear
End Sub

Private Sub Class_Terminate()
    Clear
End Sub

Public Sub ValueCollect(ByVal lngReportID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, crObjects As New ADODB.Recordset, RowInc As Long, ColInc As Long
Dim crTmp As New clsRecordSet, crObjectsSub As New clsRecordSet
    Clear
    mlngReportID = lngReportID
    sSql = "SELECT RO.*, TT.TableTypeName, AcT.AcTypeDescription FROM ReportsObjects RO LEFT OUTER JOIN TableTypes TT ON TT.TableTypeID = RO.TableTypeID LEFT OUTER JOIN AcTypes AcT ON AcT.AcTypeID = RO.AcTypeID WHERE RO.ReportID = " & lngReportID & " ORDER BY RO.ObjSlNo"
    crObjects.Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
    sSql = "SELECT * FROM ReportsObjectsSub WHERE ReportID = " & lngReportID & " ORDER BY SubSlNo"
    crObjectsSub.BindRecords sSql, AdoConn
    sSql = "SELECT * FROM Reports WHERE ReportID = " & lngReportID
    With GetRecords(sSql)
        If Not .BOF Then
            mstrReportName = !ReportName
            PeriodID = Val(!PeriodID & "")
            mrptTypeReportType = !ReportTypeID
            mlngPaperSize = !PaperSize
            mdblMarginLeft = !MarginLeft
            mdblMarginTop = !MarginTop
            mdblMarginRight = !MarginRight
            mdblMarginBottom = !MarginBottom
            mlngOrientation = !Orientation
        End If
        .Close
    End With
    While Not crObjects.EOF
        With CreateNewReportObject()
            .TextMatrix(0, 0, rptObjTypeID) = crObjects.Fields("ObjectTypeID")
            .TextMatrix(0, 0, rptObjName) = crObjects.Fields("ObjectName")
            .TextMatrix(0, 0, rptObjTextRtf) = crObjects.Fields("TextRTF")
            .TextMatrix(0, 0, rptObjPaperSize) = IIf(IsNull(crObjects.Fields("PaperSize")), -1, crObjects.Fields("PaperSize"))
            .TextMatrix(0, 0, rptObjMarginBottom) = IIf(IsNull(crObjects.Fields("MarginBottom")), -1, crObjects.Fields("MarginBottom"))
            .TextMatrix(0, 0, rptObjMarginLeft) = IIf(IsNull(crObjects.Fields("MarginLeft")), -1, crObjects.Fields("MarginLeft"))
            .TextMatrix(0, 0, rptObjMarginRight) = IIf(IsNull(crObjects.Fields("MarginRight")), -1, crObjects.Fields("MarginRight"))
            .TextMatrix(0, 0, rptObjMarginTop) = IIf(IsNull(crObjects.Fields("MarginTop")), -1, crObjects.Fields("MarginTop"))
            .TextMatrix(0, 0, rptObjOrientation) = IIf(IsNull(crObjects.Fields("Orientation")), -1, crObjects.Fields("Orientation"))
            .TextMatrix(0, 0, rptObjLeft) = crObjects.Fields("ObjLeft")
            .TextMatrix(0, 0, rptObjTop) = crObjects.Fields("ObjTop")
            .TextMatrix(0, 0, rptObjWidth) = crObjects.Fields("ObjWidth")
            .TextMatrix(0, 0, rptObjHeight) = crObjects.Fields("ObjHeight")
            .TextMatrix(0, 0, rptObjBorderTypeID) = crObjects.Fields("BorderTypeID")
            .TextMatrix(0, 0, rptObjNoOfRows) = crObjects.Fields("NoOfRows")
            .TextMatrix(0, 0, rptObjNoOfCols) = crObjects.Fields("NoOfCols")
            .TextMatrix(0, 0, rptObjTableTypeID) = IIf(IsNull(crObjects.Fields("TableTypeID")), -1, crObjects.Fields("TableTypeID"))
            .TextMatrix(0, 0, rptObjAcTypeID) = IIf(IsNull(crObjects.Fields("AcTypeID")), -1, crObjects.Fields("AcTypeID"))
            .TextMatrix(0, 0, rptObjTableTypeName) = IIf(IsNull(crObjects.Fields("TableTypeName")), "", crObjects.Fields("TableTypeName"))
            .TextMatrix(0, 0, rptObjAcTypeName) = IIf(IsNull(crObjects.Fields("AcTypeDescription")), "", crObjects.Fields("AcTypeDescription"))
            Select Case crObjects.Fields("ObjectTypeID")
                Case objtpPicture
                    If Not IsNull(crObjects.Fields("Picture")) Then
                        mstrmPicture(mlngObjMax).Type = adTypeBinary
                        mstrmPicture(mlngObjMax).Open
                        mstrmPicture(mlngObjMax).Write crObjects.Fields("Picture")
                    End If
                Case objtpTable
                    InitializeTableObject
                    TableCols = crObjects.Fields("NoOfCols")
                    TableRows = crObjects.Fields("NoOfRows")
                    ConfigureTableProperties
                    crTmp.BindRecordSet crObjectsSub, "ObjSlNo|=|" & crObjects.Fields("ObjSlNo")
                    While Not crTmp.EOF
                        RowInc = crTmp.Fields("Row")
                        ColInc = crTmp.Fields("Col")
                        TableCell(rptTblText, RowInc, ColInc) = crTmp.Fields("TextRTF")
                        TableCell(rptTblBackColor, RowInc, ColInc) = crTmp.Fields("BackColor") & ""
                        TableCell(rptTblForeColor, RowInc, ColInc) = crTmp.Fields("ForeColor") & ""
                        TableCell(rptTblColWidth, RowInc, ColInc) = crTmp.Fields("ColWidth") & ""
                        TableCell(rptTblUnderline, RowInc, ColInc) = IIf(IsNull(crTmp.Fields("Underline")), -1, crTmp.Fields("Underline"))
                        TableCell(rptTblIsBold, RowInc, ColInc) = IIf(IsNull(crTmp.Fields("IsBold")), -1, crTmp.Fields("IsBold"))
                        TableCell(rptTblFontSize, RowInc, ColInc) = crTmp.Fields("FontSize") & ""
                        TableCell(rptTblIsItalic, RowInc, ColInc) = IIf(IsNull(crTmp.Fields("IsItalic")), -1, crTmp.Fields("IsItalic"))
                        TableCell(rptTblAlignment, RowInc, ColInc) = crTmp.Fields("Alignment") & ""
                        TableCell(rptTblFontName, RowInc, ColInc) = crTmp.Fields("FontName") & ""
                        TableCell(rptTblRowHeight, RowInc, ColInc) = crTmp.Fields("RowHeight") & ""
                        crTmp.MoveNext
                    Wend
                    crTmp.Clear
            End Select
        End With
        crObjects.MoveNext
    Wend
    crObjects.Close
    Set crObjects = Nothing
    crTmp.Clear
    Set crTmp = Nothing
    crObjectsSub.Clear
    Set crObjectsSub = Nothing
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Property Get ReportName() As String
    ReportName = mstrReportName
End Property

Public Property Let ReportName(ByVal strNewValue As String)
    mstrReportName = strNewValue
End Property

Public Property Get PeriodID() As Long
    PeriodID = mlngPeriodID
End Property

Public Property Let PeriodID(ByVal lngNewValue As Long)
    mlngPeriodID = lngNewValue
    mlngCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & lngNewValue))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mlngCompanyID
End Property

Public Property Get ReportTypeID() As ReportTypes
    ReportTypeID = mrptTypeReportType
End Property

Public Property Let ReportTypeID(ByVal rptNewValue As ReportTypes)
    mrptTypeReportType = rptNewValue
End Property

Public Property Get ReportID() As Long
    ReportID = mlngReportID
End Property

Public Property Let ReportID(ByVal lngNewValue As Long)
    mlngReportID = lngNewValue
End Property

Public Property Get PaperSize() As PaperSizeSettings
    PaperSize = mlngPaperSize
End Property

Public Property Let PaperSize(ByVal pprsNewValue As PaperSizeSettings)
    mlngPaperSize = pprsNewValue
End Property

Public Property Get MarginLeft() As Double
    MarginLeft = mdblMarginLeft
End Property

Public Property Let MarginLeft(ByVal dblNewValue As Double)
    mdblMarginLeft = dblNewValue
End Property

Public Property Get MarginTop() As Double
    MarginTop = mdblMarginTop
End Property

Public Property Let MarginTop(ByVal dblNewValue As Double)
    mdblMarginTop = dblNewValue
End Property

Public Property Get MarginRight() As Double
    MarginRight = mdblMarginRight
End Property

Public Property Let MarginRight(ByVal dblNewValue As Double)
    mdblMarginRight = dblNewValue
End Property

Public Property Get MarginBottom() As Double
    MarginBottom = mdblMarginBottom
End Property

Public Property Let MarginBottom(ByVal dblNewValue As Double)
    mdblMarginBottom = dblNewValue
End Property

Public Property Get Orientation() As OrientationSettings
    Orientation = mlngOrientation
End Property

Public Property Let Orientation(ByVal orNewValue As OrientationSettings)
    mlngOrientation = orNewValue
End Property

Public Property Get ObjectCount() As Long
    ObjectCount = mlngObjMax
End Property

Public Property Get ObjectProperty(Index As Long, rptObjProperty As ReportObjectProperties) As Variant
    Select Case rptObjProperty
        Case rptObjPicture
            Set ObjectProperty = mstrmPicture(Index)
        Case Else
            ObjectProperty = mcggObjects(Index).TextMatrix(0, 0, rptObjProperty)
    End Select
End Property

Public Property Get ObjectTableCell(Index As Long, rptTblTableProperty As ReportTableProperties, Row, Col) As Variant
    With mcggObjects(Index)
        If rptTblTableProperty = rptTblText Then
            ObjectTableCell = .TextMatrix(1, Row, Col)
        Else
            ObjectTableCell = .TextMatrix(Row + 2, rptTblTableProperty, Col)
        End If
    End With
End Property

Public Property Get ObjectTableCols(Index As Long) As Long
    ObjectTableCols = mcggObjects(Index).Cols(1)
End Property

Public Property Get ObjectTableRows(Index As Long) As Long
    ObjectTableRows = mcggObjects(Index).Rows(1)
End Property
