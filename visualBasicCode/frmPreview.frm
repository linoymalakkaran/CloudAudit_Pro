VERSION 5.00
Object = "{54850C51-14EA-4470-A5E4-8C5DB32DC853}#1.0#0"; "vsprint8.ocx"
Begin VB.Form frmPreview 
   Caption         =   "Preview"
   ClientHeight    =   8850
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12510
   Icon            =   "frmPreview.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   8850
   ScaleWidth      =   12510
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VSPrinter8LibCtl.VSPrinter vpPreview 
      Height          =   8880
      Left            =   -15
      TabIndex        =   0
      Top             =   0
      Width           =   11880
      _cx             =   20955
      _cy             =   15663
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   -1  'True
      MousePointer    =   0
      BackColor       =   -2147483643
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty HdrFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      AutoRTF         =   -1  'True
      Preview         =   -1  'True
      DefaultDevice   =   0   'False
      PhysicalPage    =   -1  'True
      AbortWindow     =   -1  'True
      AbortWindowPos  =   0
      AbortCaption    =   "Printing..."
      AbortTextButton =   "Cancel"
      AbortTextDevice =   "on the %s on %s"
      AbortTextPage   =   "Now printing Page %d of"
      FileName        =   ""
      MarginLeft      =   1440
      MarginTop       =   1440
      MarginRight     =   1440
      MarginBottom    =   1440
      MarginHeader    =   0
      MarginFooter    =   0
      IndentLeft      =   0
      IndentRight     =   0
      IndentFirst     =   0
      IndentTab       =   720
      SpaceBefore     =   0
      SpaceAfter      =   0
      LineSpacing     =   100
      Columns         =   1
      ColumnSpacing   =   180
      ShowGuides      =   2
      LargeChangeHorz =   300
      LargeChangeVert =   300
      SmallChangeHorz =   30
      SmallChangeVert =   30
      Track           =   0   'False
      ProportionalBars=   -1  'True
      Zoom            =   50.9469696969697
      ZoomMode        =   3
      ZoomMax         =   400
      ZoomMin         =   10
      ZoomStep        =   25
      EmptyColor      =   -2147483636
      TextColor       =   0
      HdrColor        =   0
      BrushColor      =   0
      BrushStyle      =   0
      PenColor        =   0
      PenStyle        =   0
      PenWidth        =   0
      PageBorder      =   0
      Header          =   ""
      Footer          =   ""
      TableSep        =   "|;"
      TableBorder     =   7
      TablePen        =   0
      TablePenLR      =   0
      TablePenTB      =   0
      NavBar          =   3
      NavBarColor     =   -2147483633
      ExportFormat    =   5
      URL             =   ""
      Navigation      =   3
      NavBarMenuText  =   "Whole &Page|Page &Width|&Two Pages|Thumb&nail"
      AutoLinkNavigate=   0   'False
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   9
   End
End
Attribute VB_Name = "frmPreview"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Resize()
On Local Error Resume Next
    vpPreview.Width = Width - 100
    vpPreview.Height = Height - 600
End Sub

'Private Sub vpPreview_DblClick()
'    PrintJournalEntries pActivePeriodID, True
'End Sub

Public Function PrintJournalEntries(mPeriodID As Long, Optional ByVal blnIsPreview As Boolean = True)
On Local Error GoTo Err_Exit
Dim crptJournal As New clsReports, sSql As String, rsTmp As New Recordset, strTmp As String
Dim Inc As Long, mCompanyID As Long, mComparePeriodID As Long, ColInc As Long
Dim lngStartDt As Long, lngEndDt As Long, lngCompareStartDt As Long, lngCompareEndDt As Long
Dim dblTotalDebit As Double, dblTotalCredit As Double, strRemarks As String

Const grdDate = 0
Const grdSlNo = 1
Const grdParticulars = 2
Const grdJVType = 3
Const grdDebit = 4
Const grdCredit = 5
Const grdCols = 6

'If crptMain Is Nothing Then
'    Set crptJournal = crptMain
'End If
sSql = "SELECT PER.PeriodID AS PeriodID, PER.CompanyID AS CompanyID, PER.StartDt AS StartDt, PER.EndDt AS EndDt, PER.ComparePeriodID AS ComparePeriodID, " & _
       "PER1.StartDt AS CompareStartDt, PER1.EndDt AS CompareEndDt FROM Periods PER LEFT OUTER JOIN Periods PER1 ON PER.ComparePeriodID = PER1.PeriodID " & _
       "WHERE PER.PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            mCompanyID = Val(.Fields("CompanyID") & "")
            mComparePeriodID = Val(.Fields("ComparePeriodID") & "")
            lngStartDt = Val(.Fields("StartDt") & "")
            lngEndDt = Val(.Fields("EndDt") & "")
            lngCompareStartDt = Val(.Fields("CompareStartDt") & "")
            lngCompareEndDt = Val(.Fields("CompareEndDt") & "")
        End If
        .Close
    End With

    With vpPreview
        If blnIsPreview Then
            .StartDoc
            '---Finding header data----------------
            .PaperSize = pprA4
            .Orientation = orPortrait
            strTmp = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID) & GetPrintingAddress(mCompanyID)
            .TextBox strTmp, 1440, 1500, 11000, 1000
            strTmp = GetApplicationData("JournalEntryHead")
            strTmp = Replace(strTmp, "*D1*", GetFixedAssetSchedulePeriod(mPeriodID))
            .TextBox strTmp, 1440, 2200, 11000, 1000
            .DrawLine 1440, 2800, 11000, 2800
        End If
        .StartTable
        .Columns = grdCols
        .TableCell(tcRows) = 1: Inc = 1
        .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1
        .TableCell(tcText, Inc, grdSlNo) = "No."
        .TableCell(tcText, Inc, grdParticulars) = "Particulars"
        .TableCell(tcText, Inc, grdJVType) = "Type"
        .TableCell(tcText, Inc, grdDebit) = "Debit"
        .TableCell(tcText, Inc, grdCredit) = "Credit"

        .TableCell(tcColWidth, Inc, grdSlNo) = 500
        .TableCell(tcColWidth, Inc, grdParticulars) = 5000
        .TableCell(tcColWidth, Inc, grdJVType) = 1000
        .TableCell(tcColWidth, Inc, grdDebit) = 1500
        .TableCell(tcColWidth, Inc, grdCredit) = 1500
        
        .TableCell(tcFontBold, Inc, grdSlNo, Inc, grdCredit) = True
        .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1

        sSql = "SELECT  AcHeads.AcName AS AccountName, EntrySubAccounts.DAmt AS Debit, EntrySubAccounts.CAmt AS Credit, Entries.IsErrorSchedule AS Reason, " & _
               "        EntrySubAccounts.EntryID AS SlNo, EntrySubAccounts.Narration AS Narration,  Entries.UpdateDate AS Date, Entries.Remark AS Remarks " & _
               "FROM    Entries INNER JOIN EntrySubAccounts ON Entries.EntryID = EntrySubAccounts.EntryID INNER JOIN AcHeads ON EntrySubAccounts.AcID = AcHeads.AcID " & _
               "WHERE   Entries.IsOpening = 0 AND Entries.PeriodID = " & mPeriodID
        Set rsTmp = GetRecords(sSql)
        While Not rsTmp.EOF
            .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1
            .TableCell(tcText, Inc, grdSlNo) = rsTmp.Fields("SlNo") & ""
            .TableCell(tcText, Inc, grdParticulars) = rsTmp.Fields("AccountName") & ""
            .TableCell(tcText, Inc, grdDebit) = IIf(rsTmp.Fields("Debit") < 0, "(" & Format(Abs(rsTmp.Fields("Debit")), "#,###.00") & ")", Format(rsTmp.Fields("Debit"), "#,###.00"))
            dblTotalDebit = dblTotalDebit + Val(rsTmp.Fields("Debit") & "")
            .TableCell(tcText, Inc, grdCredit) = IIf(rsTmp.Fields("Credit") < 0, "(" & Format(Abs(rsTmp.Fields("Credit")), "#,###.00") & ")", Format(rsTmp.Fields("Credit"), "#,###.00"))
            dblTotalCredit = dblTotalCredit + Val(rsTmp.Fields("Credit") & "")

            strRemarks = rsTmp.Fields("Remarks") & ""
            If rsTmp.Fields("Reason") = "False" Then
                .TableCell(tcText, Inc, grdJVType) = "U A"
            Else
                .TableCell(tcText, Inc, grdJVType) = "E S"
            End If
            .TableCell(tcAlign, Inc, grdJVType) = taJustMiddle
            .TableCell(tcAlign, Inc, grdSlNo) = taRightMiddle
            .TableCell(tcFontBold, Inc, grdParticulars) = True
            .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1
            .TableCell(tcText, Inc, grdParticulars) = rsTmp.Fields("Narration") & ""
            .TableCell(tcFontItalic, Inc, grdParticulars) = True
            .TableCell(tcRowHeight, Inc, grdSlNo, Inc, grdCredit) = 700
            .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1
            .TableCell(tcText, Inc, grdParticulars) = rsTmp.Fields("Remarks") & ""
            rsTmp.MoveNext
        Wend
        .TableCell(tcRows) = .TableCell(tcRows) + 1: Inc = Inc + 1
        .TableCell(tcText, Inc, grdParticulars) = "Total Amount"
        .TableCell(tcText, Inc, grdDebit) = IIf(dblTotalDebit < 0, "(" & Format(Abs(dblTotalDebit), "#,###.00") & ")", Format(dblTotalDebit, "#,###.00"))
        .TableCell(tcText, Inc, grdCredit) = IIf(dblTotalCredit < 0, "(" & Format(Abs(dblTotalCredit), "#,###.00") & ")", Format(dblTotalCredit, "#,###.00"))
        .TableCell(tcFontBold, Inc, grdParticulars, Inc, grdCredit) = True
        .TableCell(tcFontBold, Inc - 1, grdDebit, Inc - 1, grdCredit) = True
        .TableCell(tcFontBold, 2, grdDebit, .TableCell(tcRows) - 1, grdCredit) = True
        .TableCell(tcAlign, 2, grdJVType) = taCenterMiddle
        .TableCell(tcAlign, 0, grdDebit, .TableCell(tcRows) - 1, grdCredit) = taRightMiddle
        .TableCell(tcFontName, 0, grdDate, .TableCell(tcRows) - 1, grdCredit) = "Times New Roman"
        .EndTable
    .EndDoc
'        If blnIsPreview Then
'            If crptMain Is Nothing Then
'                .EndReport
'                .Clear
'                Set crptJournal = Nothing
'            End If
'        Else
'            Set PrintJournal = crptJournal
'        End If
    End With
Exit Function
Err_Exit:
    ShowError
End Function

Private Sub vpPreview_NewPage()
    OnPreviewNewPage vpPreview
End Sub
