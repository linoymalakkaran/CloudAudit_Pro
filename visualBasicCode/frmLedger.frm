VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmLedger 
   Caption         =   "Ledger Book"
   ClientHeight    =   5445
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7335
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5445
   ScaleWidth      =   7335
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmLedger.frx":0000
      Left            =   1380
      List            =   "frmLedger.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   10
      Top             =   135
      Width           =   3645
   End
   Begin VB.CommandButton fndAcID 
      Height          =   315
      Left            =   6840
      Picture         =   "frmLedger.frx":0004
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   585
      Width           =   315
   End
   Begin VB.TextBox txtAcName 
      Height          =   315
      Left            =   1365
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   585
      Width           =   5460
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgLedger 
      Height          =   3180
      Left            =   90
      TabIndex        =   1
      Top             =   960
      Width           =   7155
      _cx             =   12621
      _cy             =   5609
      Appearance      =   2
      BorderStyle     =   1
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
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   1
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
      Cols            =   9
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmLedger.frx":018E
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
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
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   165
      Top             =   4260
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   11
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":02AD
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":0407
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":0561
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":06BB
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":0895
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":09EF
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":0BC9
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":0D23
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":2225
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":23FF
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLedger.frx":25D9
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   3600
      TabIndex        =   9
      Top             =   4950
      Width           =   3690
      _ExtentX        =   6509
      _ExtentY        =   582
      ButtonWidth     =   1984
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstCtrls"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   180
      TabIndex        =   11
      Top             =   210
      Width           =   960
   End
   Begin VB.Label lblBalance 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3705
      TabIndex        =   8
      Top             =   4530
      Width           =   3525
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Balance"
      Height          =   195
      Left            =   3060
      TabIndex        =   7
      Top             =   4560
      Width           =   585
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Totals"
      Height          =   195
      Left            =   3105
      TabIndex        =   4
      Top             =   4200
      Width           =   540
   End
   Begin VB.Label lblTotCr 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   5535
      TabIndex        =   3
      Top             =   4200
      Width           =   1695
   End
   Begin VB.Label lblTotDr 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3705
      TabIndex        =   2
      Top             =   4200
      Width           =   1785
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Account Head"
      Height          =   195
      Left            =   180
      TabIndex        =   0
      Top             =   630
      Width           =   1035
   End
End
Attribute VB_Name = "frmLedger"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean

Const grdSlNo = 0
Const grdAcName = 1
Const grdRefNo = 2
Const grdDrAmt = 3
Const grdCrAmt = 4
Const grdEntryID = 5
Const grdAcID = 6
Const grdLevelNo = 7
Const grdIsOpening = 8

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & pActivePeriodID & " AND UserID = " & pUserID
        With GetRecords(sSql1)
            If Not .EOF Then
                If .Fields("IsBlocked") = True Then
                    IsReadOnly = True
                Else
                    IsReadOnly = False
                End If
            Else
                IsReadOnly = True
            End If
            .Close
        End With
    sSql = "Select DetachedBy From Companies Where CompanyID = " & pActiveCompanyID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("DetachedBy") <> "" Then
                    IsReadOnly = True
                End If
                .MoveNext
            Wend
            .Close
        End With
'    sSql3 = "Select FinalisedBy From Periods Where PeriodID = " & pActivePeriodID
'        With GetRecords(sSql3)
'            While Not .EOF
'                If .Fields("FinalisedBy") <> "" Then
'                    IsReadOnly = True
'                End If
'                .MoveNext
'            Wend
'            .Close
'        End With
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
   fndAcID.Enabled = Not blnNewValue
End Property

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property
    
Public Property Let IsModify(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         vsfgLedger.SetFocus
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
Dim sSql As String
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    If mCompanyID <= 0 Then
        mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
        sSql = "SELECT  PeriodID AS IDField, ShortName + '  ' + Convert(varchar,CONVERT(DateTime, StartDt - 2, 103),103) + ' - ' + Convert(Varchar,CONVERT(DateTime, EndDt - 2, 103),103) AS NameField " & _
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " ORDER BY StartDt DESC"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub fndAcID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountHeads, "WHERE AH.CompanyID = " & mCompanyID, " XAcID", , fndAcID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtAcName.Tag = lngID
        End If
    Else
        strRslt = lngID
        txtAcName.Tag = lngID
    End If
    Select Case strRslt
        Case "-1", ""
            ShowOpen = False
        Case Else
            txtAcName = PickValue("AcHeads", "AcName", "AcID = " & lngID)
            ShowOpen = FillLedger(lngID)
            ShowOpen = True
    End Select
End Function

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Sub FindTotal()
On Local Error Resume Next
Dim Inc As Long, dblDr As Double, dblCr As Double
    With vsfgLedger
        For Inc = 1 To .Rows - 1
            dblDr = dblDr + .ValueMatrix(Inc, grdDrAmt)
            dblCr = dblCr + .ValueMatrix(Inc, grdCrAmt)
        Next Inc
    End With
    lblTotDr = Format(dblDr, "#,##0.00")
    lblTotCr = Format(dblCr, "#,##0.00")
    lblBalance = Format(Abs(dblDr - dblCr), "#,##0.00") & IIf(dblDr - dblCr <> 0, IIf(dblDr - dblCr > 0, " Dr", " Cr"), "")
End Sub

Public Sub ShowSpecifiedLedger(lngAcID As Long)
On Local Error Resume Next
    ButtonHandling Me, "Open", lngAcID
End Sub

Private Sub vsfgLedger_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    FindTotal
End Sub

Private Sub vsfgLedger_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Col <> grdDrAmt And Col <> grdCrAmt Then
        Cancel = True
        Exit Sub
    End If
    If vsfgLedger.ValueMatrix(Row, grdIsOpening) <> 1 Then
        Cancel = True
        Exit Sub
    End If
    If Col = grdDrAmt Then
        If vsfgLedger.ValueMatrix(Row, grdCrAmt) <> 0 Then
            Cancel = True
            Exit Sub
        End If
    ElseIf Col = grdCrAmt Then
        If vsfgLedger.ValueMatrix(Row, grdDrAmt) <> 0 Then
            Cancel = True
            Exit Sub
        End If
    End If
    If Not IsModify Then
        Cancel = True
    End If
End Sub

Public Sub ClearValues()
    'Ref No: 013-15/04/08
    vsfgLedger.Rows = 1: vsfgLedger.Rows = 40
    lblTotDr = "0.00": lblTotCr = "0.00"
    lblBalance = "0.00"
End Sub

Public Function FillLedger(lngAcID As Long) As Boolean
Dim sSql As String, Inc As Integer
On Local Error GoTo Err_Exit
    ClearValues
    sSql = "SELECT 'Opening' AS Account, 0 AS AcID, '' AS RefNo, ESA.EntryID AS EntryID, ESA.DAmt AS DAmt, ESA.CAmt AS CAmt, 1 AS IsOpen, 1 AS Ord, 0 AS LEVEL " & _
           "FROM AcHeads AH INNER JOIN EntrySubAccounts ESA ON AH.AcID = ESA.AcID INNER JOIN Entries ET ON ESA.EntryID = ET.EntryID WHERE ET.PeriodID = " & mPeriodID & " AND (ESA.AcID = " & lngAcID & ") AND (ET.IsOpening = 1) " & _
           "Union " & _
           "SELECT 'Opening' AS Account, 0 AS AcID, '' AS RefNo, 0 AS EntryID, 0 AS DAmt, 0 AS CAmt, 1 AS IsOpen, 1 AS Ord, 0 AS LEVEL " & _
           "FROM AcHeads AH WHERE (SELECT Count(*) FROM Entries ET INNER JOIN EntrySubAccounts ESA ON ET.EntryID = ESA.EntryID WHERE ET.PeriodID = " & mPeriodID & " AND ESA.AcID = " & lngAcID & " AND ET.IsOpening = 1) = 0 " & _
           "Union " & _
           "SELECT (SELECT CASE COUNT(AH1.AcID) WHEN 1 THEN MIN(AH1.AcName) ELSE 'Multiple Entry' END FROM AcHeads AH1, EntrySubAccounts ESA1 WHERE ESA1.AcID = AH1.AcID AND ESA1.EntryID = ESA.EntryID AND ESA1.ACID <> ESA.ACID) AS Account, ESA.AcID AS AcID, ET.RefNo AS RefNo, " & _
           "ESA.EntryID AS EntryID, ESA.DAmt AS DAmt, ESA.CAmt AS CAmt, 0 AS IsOpen, 2 AS Ord, 0 AS LEVEL FROM AcHeads AH INNER JOIN EntrySubAccounts ESA ON AH.AcID = ESA.AcID INNER JOIN Entries ET ON ESA.EntryID = ET.EntryID WHERE ET.PeriodID = " & mPeriodID & " AND (ESA.AcID = " & lngAcID & ") AND (ET.IsOpening = 0) " & _
           "Union " & _
           "SELECT AH.AcName + '(' + CONVERT(varchar, ESA.DAmt + ESA.CAmt) + ')' AS Account, ESA.AcID AS AcID, '' AS RefNo, ESA.EntryID AS EntryID, -1 AS DAmt, -1 AS CAmt, 0 AS IsOpen, 3 AS Ord, 1 AS LEVEL FROM AcHeads AH INNER JOIN " & _
           "EntrySubAccounts ESA ON AH.AcID = ESA.AcID INNER JOIN Entries ET ON ESA.EntryID = ET.EntryID WHERE ET.PeriodID = " & mPeriodID & " AND (ESA.AcID <> " & lngAcID & ") AND (ET.IsOpening = 0) AND ESA.EntryID IN (SELECT EntryID FROM EntrySubAccounts ESA1 WHERE ESA1.AcID = " & lngAcID & ") AND (SELECT COUNT(ESA2.AcID) " & _
           "FROM EntrySubAccounts ESA2 WHERE ESA2.EntryID = ESA.EntryID) > 2 ORDER BY IsOpen DESC, EntryID, Ord"
    vsfgLedger.OutlineBar = flexOutlineBarCompleteLeaf
    With GetRecords(sSql)
        While Not .EOF
            Inc = Inc + 1
            vsfgLedger.TextMatrix(Inc, grdSlNo) = Inc
            vsfgLedger.TextMatrix(Inc, grdAcName) = .Fields("Account") & ""
            vsfgLedger.TextMatrix(Inc, grdRefNo) = .Fields("RefNo") & ""
            vsfgLedger.TextMatrix(Inc, grdDrAmt) = IIf(Val(.Fields("DAmt") & "") < 1, "", Format(Val(.Fields("DAmt") & ""), "#,##0.00"))
            vsfgLedger.TextMatrix(Inc, grdCrAmt) = IIf(Val(.Fields("CAmt") & "") < 1, "", Format(Val(.Fields("CAmt") & ""), "#,##0.00"))
            vsfgLedger.TextMatrix(Inc, grdEntryID) = Val(.Fields("EntryID") & "")
            vsfgLedger.TextMatrix(Inc, grdAcID) = Val(.Fields("AcID") & "")
            vsfgLedger.TextMatrix(Inc, grdLevelNo) = Val(.Fields("Level") & "")
            vsfgLedger.TextMatrix(Inc, grdIsOpening) = Val(.Fields("IsOpen") & "")
            If Not .Fields("IsOpen") = 1 Then
                vsfgLedger.Cell(flexcpBackColor, Inc, grdSlNo, Inc, grdCrAmt) = pclrRestrictionColor
            End If
            .MoveNext
        Wend
       .Close
    End With
    For Inc = 1 To vsfgLedger.Rows - 1
        vsfgLedger.IsSubtotal(Inc) = True
        vsfgLedger.RowOutlineLevel(Inc) = vsfgLedger.ValueMatrix(Inc, grdLevelNo)
    Next Inc
    For Inc = 1 To vsfgLedger.Rows - 1
        vsfgLedger.IsCollapsed(Inc) = flexOutlineCollapsed
    Next Inc
    PutSlNo vsfgLedger, grdSlNo, grdAcName
    FindTotal
    FillLedger = True
Exit Function
Err_Exit:
    FillLedger = False
    ShowError
End Function

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String, dtRef As Date
Dim lngAcID As Long, lngEntryID As Long, Inc As Integer, lngAcSlNo As Long
    dtRef = Val(PickValue("Periods", "StartDt", "PeriodID = " & mPeriodID))
    lngAcID = Val(txtAcName.Tag)
    AdoConn.BeginTrans
    With vsfgLedger
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsOpening) Then
                lngEntryID = SaveEntry(mPeriodID, "Opening...", dtRef, cnstStatusActive, "", 1)
                If lngEntryID = -1 Then
                    Err.Raise vbObjectError + 1, , "Error while updating Opening."
                End If
                'Fetching Current AcSlNo--------19th May 2008, Monday
                lngAcSlNo = Val(PickValue("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID & " AND AcID = " & lngAcID))
                If lngAcSlNo = 0 Then
                    'Fetching New AcSlNo if new Account
                    lngAcSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                End If
                sSql = "DELETE FROM EntrySubAccounts WHERE EntryID = " & lngEntryID & " AND AcID = " & lngAcID
                AdoConn.Execute sSql
                If Not SaveSubEntries(lngEntryID, lngAcSlNo, lngAcID, .ValueMatrix(Inc, grdDrAmt), .ValueMatrix(Inc, grdCrAmt), "", 1) Then
                    Err.Raise vbObjectError + 1, , "Error while updating Opening."
                End If
            End If
        Next Inc
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Save = False
End Function

Private Sub vsfgLedger_DblClick()
On Local Error Resume Next
    With vsfgLedger
        If .Row < 1 Then Exit Sub
        If .ValueMatrix(.Row, grdIsOpening) = 1 Then Exit Sub
        If .ValueMatrix(.Row, grdEntryID) <> 0 Then
            ShowJournal mPeriodID, .ValueMatrix(.Row, grdEntryID)
        End If
    End With
End Sub

Private Sub vsfgLedger_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        If vsfgLedger.Cell(flexcpBackColor, vsfgLedger.Row, grdAcName) = pclrRestrictionColor Then
            vsfgLedger_DblClick
        End If
    End If
End Sub
