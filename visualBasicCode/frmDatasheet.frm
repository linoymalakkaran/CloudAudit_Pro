VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmDatasheet 
   Caption         =   "Datasheet"
   ClientHeight    =   9870
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   14565
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9870
   ScaleWidth      =   14565
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgDatasheet 
      Height          =   9015
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14535
      _cx             =   25638
      _cy             =   15901
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9.75
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
      Rows            =   4
      Cols            =   8
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
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
      FrozenRows      =   2
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
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   10365
      TabIndex        =   1
      Top             =   9345
      Width           =   3600
      _ExtentX        =   6350
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
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   7920
      Top             =   9240
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDatasheet.frx":0000
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDatasheet.frx":015A
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDatasheet.frx":0334
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDatasheet.frx":050E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmDatasheet.frx":0668
            Key             =   "Help"
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmDatasheet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdParticulars = 0
Const grdAccounts = 1
Const grdThisTrialBalance = 2
Const grdThisTotal = 3
Const grdLastTrialBalance = 4
Const grdLastTotal = 5
Const grdAcTypeID = 6
Const grdAcID = 7
Const grdIsBold = 8
Const grdTreeLevel = 9
Const grdIsTotal = 10
Const grdCols = 11

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = pActivePeriodID)
    tbrCtrls.Buttons("Save").Enabled = Not IsReadOnly
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

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
    mblnModify = blnNewValue
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    If mCompanyID <= 0 Then
        mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
    End If
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    vsfgDatasheet.Enabled = True
    vsfgDatasheet.Editable = flexEDKbdMouse
End Property

Private Sub Form_Activate()
    LoadDataSheet
End Sub

Private Sub Form_Load()
    ButtonHandling Me
    tbrCtrls.Buttons("Modify").Enabled = True
    FormatGrid
'    LoadDataSheet
End Sub

Public Function FormatGrid()
On Local Error Resume Next
    vsfgDatasheet.TextMatrix(0, grdParticulars) = ""
    vsfgDatasheet.TextMatrix(0, grdAccounts) = "Description"
    vsfgDatasheet.TextMatrix(0, grdThisTrialBalance) = "CurrentYr TB"
    vsfgDatasheet.TextMatrix(0, grdThisTotal) = "CurrentYr Amount"
    vsfgDatasheet.TextMatrix(0, grdLastTrialBalance) = "LastYr TB"
    vsfgDatasheet.TextMatrix(0, grdLastTotal) = "LastYr Amount"

    vsfgDatasheet.Cols = grdCols
    vsfgDatasheet.ColHidden(grdAcTypeID) = True
    vsfgDatasheet.ColHidden(grdAcID) = True
    vsfgDatasheet.ColHidden(grdIsBold) = True
    vsfgDatasheet.ColHidden(grdTreeLevel) = True
    vsfgDatasheet.ColHidden(grdIsTotal) = True

    vsfgDatasheet.Cell(flexcpFontBold, 0, grdParticulars, 0, grdThisTotal) = True
    vsfgDatasheet.Cell(flexcpFontSize, 0, grdParticulars, 0, grdThisTotal) = "10"

    vsfgDatasheet.ColWidth(grdParticulars) = GetProportionalValue(500, False)
    vsfgDatasheet.ColWidth(grdAccounts) = GetProportionalValue(6000, False)
    vsfgDatasheet.ColWidth(grdThisTrialBalance) = GetProportionalValue(2000, False)
    vsfgDatasheet.ColWidth(grdThisTotal) = GetProportionalValue(2000, False)
    vsfgDatasheet.ColWidth(grdLastTrialBalance) = GetProportionalValue(2000, False)
    vsfgDatasheet.ColWidth(grdLastTotal) = GetProportionalValue(1800, False)

    vsfgDatasheet.ColAlignment(grdAccounts) = flexAlignLeftCenter
    vsfgDatasheet.ColAlignment(grdThisTrialBalance) = flexAlignRightCenter
    vsfgDatasheet.ColAlignment(grdThisTotal) = flexAlignRightCenter
    vsfgDatasheet.ColAlignment(grdLastTrialBalance) = flexAlignRightCenter
    vsfgDatasheet.ColAlignment(grdLastTotal) = flexAlignRightCenter

    vsfgDatasheet.ColComboList(grdParticulars) = "..."

    vsfgDatasheet.OutlineBar = flexOutlineBarCompleteLeaf
    vsfgDatasheet.OutlineCol = 0
    vsfgDatasheet.IsSubtotal(1) = True
    vsfgDatasheet.RowOutlineLevel(1) = 0
    vsfgDatasheet.IsCollapsed(1) = flexOutlineExpanded
    vsfgDatasheet.Editable = flexEDKbdMouse
End Function

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function LoadDataSheet()
On Local Error Resume Next
Dim sSql As String, lngLiabilityID As Long, lngCommitmentsID As Long, Inc As Long, strFormula As String
Dim rsData As New ADODB.Recordset
Dim strCompanyName As String, lngLevel As Long
Dim ColInc As Long
    strCompanyName = PickValue("Companies", "CompanyName", "CompanyID = " & mCompanyID)
    vsfgDatasheet.TextMatrix(1, grdAccounts) = strCompanyName
    vsfgDatasheet.TextMatrix(2, grdAccounts) = "Particulars"
    vsfgDatasheet.TextMatrix(1, grdTreeLevel) = 1
    vsfgDatasheet.TextMatrix(2, grdTreeLevel) = 1
    vsfgDatasheet.MergeCells = flexMergeFree
    vsfgDatasheet.Cell(flexcpFontSize, 1, grdAccounts) = 14
    vsfgDatasheet.Cell(flexcpFontName, 1, , 2, grdAccounts) = "Cambria"
    vsfgDatasheet.Cell(flexcpAlignment, 1, grdAccounts) = flexAlignCenterCenter
    vsfgDatasheet.Cell(flexcpFontBold, 1, grdAccounts, 2, grdThisTrialBalance) = True
    vsfgDatasheet.MergeCells = flexMergeFree
    vsfgDatasheet.MergeRow(1) = True
    vsfgDatasheet.Cell(flexcpBackColor, 1, 0, 2, vsfgDatasheet.Cols - 1) = RGB(200, 200, 255)
    vsfgDatasheet.RowHeight(1) = 600

    lngLiabilityID = GetActualID(mCompanyID, cnstAcTypeContingentLiability)
    lngCommitmentsID = GetActualID(mCompanyID, cnstAcTypeCapitalCommitments)
    lngLevel = 1
    Inc = 4
    vsfgDatasheet.Rows = vsfgDatasheet.Rows + 1
    sSql = "Select * From AuditInformation Where PeriodID = " & mPeriodID
    Set rsData = GetRecords(sSql)
    With rsData
        If .EOF Then
            sSql = "Select * From AuditInformation Where PeriodID = 1005"
            With GetRecords(sSql)
                Inc = 2
                .MoveFirst
                Do While Not .EOF
                    Inc = Inc + 1
                    vsfgDatasheet.Rows = vsfgDatasheet.Rows + 1
                    vsfgDatasheet.OutlineCol = 1
                    vsfgDatasheet.OutlineBar = flexOutlineBarCompleteLeaf
                    vsfgDatasheet.IsSubtotal(Inc) = True
                    vsfgDatasheet.RowOutlineLevel(Inc) = 1
                    vsfgDatasheet.TextMatrix(Inc, grdAccounts) = .Fields("Particulars") & ""
                    vsfgDatasheet.TextMatrix(Inc, grdAcTypeID) = Val(.Fields("AcTypeID")) & ""
                    vsfgDatasheet.TextMatrix(Inc, grdAcID) = .Fields("AcID") & ""
                    vsfgDatasheet.TextMatrix(Inc, grdThisTrialBalance) = IIf(.Fields("ThisYrTB") & "" < 0, "(" & Format(Abs(.Fields("ThisYrTB")), "#,##0") & ")", Format(.Fields("ThisYrTB"), "#,##0"))
                    vsfgDatasheet.TextMatrix(Inc, grdThisTotal) = IIf(.Fields("ThisYrAmt") & "" < 0, "(" & Format(Abs(.Fields("ThisYrAmt")), "#,##0") & ")", Format(.Fields("ThisYrAmt"), "#,##0"))
                    vsfgDatasheet.TextMatrix(Inc, grdLastTrialBalance) = IIf(.Fields("LastYrTB") & "" < 0, "(" & Format(Abs(.Fields("LastYrTB")), "#,##0") & ")", Format(.Fields("LastYrTB"), "#,##0"))
                    vsfgDatasheet.TextMatrix(Inc, grdLastTotal) = IIf(.Fields("LastYrAmt") & "" < 0, "(" & Format(Abs(.Fields("LastYrAmt")), "#,##0") & ")", Format(.Fields("LastYrAmt"), "#,##0"))
                    vsfgDatasheet.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
                    vsfgDatasheet.TextMatrix(Inc, grdTreeLevel) = .Fields("Treelevel") & ""
                    vsfgDatasheet.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
                    If .Fields("Treelevel") & "" = 1 Then
                        vsfgDatasheet.RowOutlineLevel(Inc) = 1
                    ElseIf .Fields("Treelevel") & "" = 2 Then
                        vsfgDatasheet.RowOutlineLevel(Inc) = 2
                    Else
                        vsfgDatasheet.RowOutlineLevel(Inc) = 3
                    End If
                    If .Fields("IsBold") & "" = "True" Then
                        vsfgDatasheet.Cell(flexcpFontBold, Inc, grdAccounts) = True
                    End If
                    If .Fields("Treelevel") = 1 Or .Fields("Treelevel") = 2 Then
                        vsfgDatasheet.Cell(flexcpFontBold, Inc, grdAccounts) = True
                    End If
                    vsfgDatasheet.Cell(flexcpFontBold, Inc, grdThisTrialBalance, Inc, grdThisTotal) = True
                    .MoveNext
                Loop
            End With
        Else
            Inc = 2
            .MoveFirst
            Do While Not .EOF
                Inc = Inc + 1
                vsfgDatasheet.Rows = vsfgDatasheet.Rows + 1
                vsfgDatasheet.OutlineCol = 1
                vsfgDatasheet.OutlineBar = flexOutlineBarCompleteLeaf
                vsfgDatasheet.IsSubtotal(Inc) = True
                vsfgDatasheet.RowOutlineLevel(Inc) = 1
                vsfgDatasheet.TextMatrix(Inc, grdAccounts) = .Fields("Particulars") & ""
                vsfgDatasheet.TextMatrix(Inc, grdAcTypeID) = Val(.Fields("AcTypeID")) & ""
                vsfgDatasheet.TextMatrix(Inc, grdAcID) = .Fields("AcID") & ""
                vsfgDatasheet.TextMatrix(Inc, grdThisTrialBalance) = IIf(.Fields("ThisYrTB") & "" < 0, "(" & Format(Abs(.Fields("ThisYrTB")), "#,##0") & ")", Format(.Fields("ThisYrTB"), "#,##0"))
                vsfgDatasheet.TextMatrix(Inc, grdThisTotal) = IIf(.Fields("ThisYrAmt") & "" < 0, "(" & Format(Abs(.Fields("ThisYrAmt")), "#,##0") & ")", Format(.Fields("ThisYrAmt"), "#,##0"))
                vsfgDatasheet.TextMatrix(Inc, grdLastTrialBalance) = IIf(.Fields("LastYrTB") & "" < 0, "(" & Format(Abs(.Fields("LastYrTB")), "#,##0") & ")", Format(.Fields("LastYrTB"), "#,##0"))
                vsfgDatasheet.TextMatrix(Inc, grdLastTotal) = IIf(.Fields("LastYrAmt") & "" < 0, "(" & Format(Abs(.Fields("LastYrAmt")), "#,##0") & ")", Format(.Fields("LastYrAmt"), "#,##0"))
                vsfgDatasheet.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
                vsfgDatasheet.TextMatrix(Inc, grdTreeLevel) = .Fields("Treelevel") & ""
                vsfgDatasheet.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
                If .Fields("Treelevel") & "" = 1 Then
                    vsfgDatasheet.RowOutlineLevel(Inc) = 1
                ElseIf .Fields("Treelevel") & "" = 2 Then
                    vsfgDatasheet.RowOutlineLevel(Inc) = 2
                Else
                    vsfgDatasheet.RowOutlineLevel(Inc) = 3
                End If
                If .Fields("IsBold") & "" = "True" Then
                    vsfgDatasheet.Cell(flexcpFontBold, Inc, grdAccounts) = True
                End If
                If .Fields("Treelevel") = 1 Or .Fields("Treelevel") = 2 Then
                    vsfgDatasheet.Cell(flexcpFontBold, Inc, grdAccounts) = True
                End If
                vsfgDatasheet.Cell(flexcpFontBold, Inc, grdThisTrialBalance) = True
                .MoveNext
            Loop
        End If
    End With
    FindTotal
    For Inc = 2 To vsfgDatasheet.Rows - 1
        For ColInc = 2 To vsfgDatasheet.Cols - 1
            If vsfgDatasheet.ValueMatrix(Inc, ColInc) = 0 Then
                vsfgDatasheet.TextMatrix(Inc, ColInc) = ""
            End If
        Next ColInc
    Next Inc
End Function

Private Sub vsfgDatasheet_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
    If Row > 0 Then
        Select Case Col
            Case grdThisTotal
                FindTotal
            Case grdLastTotal
                FindLastTotal
        End Select
    End If
End Sub

Private Sub vsfgDatasheet_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error Resume Next
Dim Inc As Long
    If Not IsModify Then Cancel = True
    If Row > 0 Then
        If vsfgDatasheet.ValueMatrix(Row, grdIsTotal) = 1 Or vsfgDatasheet.Cell(flexcpFontBold, Row, grdAccounts) = True Then
            With MDIFormMain
                Select Case Col
                    Case grdAccounts, grdParticulars, grdThisTotal, grdThisTrialBalance, grdLastTrialBalance, grdLastTotal
                        Cancel = True
                        .mnuPopupDeleteRow.Visible = False
                        .mnuPopupAddNewGroup.Visible = False
                        .mnuPopupAddNewHead.Visible = False
                        .mnuPopupDataDeleteRow.Visible = False
                    Case grdThisTrialBalance
                        Cancel = True
                    Case Else
                        
                End Select
            End With
        End If
    End If
End Sub

Private Sub vsfgDatasheet_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.TreeLevel = 3 AND AT.CompanyID = " & mCompanyID, "Name(" & grdAccounts & "), XAcTypeID(" & grdAcTypeID & ")", vsfgDatasheet, , , , 1
    FindTrialBalanceTotal
End Sub

Private Sub vsfgDatasheet_CellChanged(ByVal Row As Long, ByVal Col As Long)
    FindTotal
End Sub

Private Sub vsfgDatasheet_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
Dim Inc As Long, Col As Long
    Col = vsfgDatasheet.Col
    Select Case Col
        Case grdAccounts
            If vsfgDatasheet.ValueMatrix(vsfgDatasheet.Row, grdIsTotal) <> 1 And vsfgDatasheet.ValueMatrix(vsfgDatasheet.Row, grdIsBold) <> 1 Then
                If Button = vbRightButton Then
                    With MDIFormMain
                        .mnuPopupAddNewGroup.Visible = True
                        .mnuPopupAddNewHead.Visible = True
                        .mnuPopupDataDeleteRow.Visible = True
                        For Inc = 0 To .mnuPopupConsoleRoot.Count
                            .mnuPopupConsoleRoot(Inc).Visible = False
                        Next Inc
                        PopupMenu .mnuPopup
    '                    For Inc = 0 To .mnuPopupConsoleRoot.Count
    '                                .mnuPopupConsoleRoot(Inc).Visible = True
    '                    Next Inc
                        .mnuPopupDeleteRow.Visible = False
                        .mnuPopupAddNewGroup.Visible = False
                        .mnuPopupAddNewHead.Visible = False
                        .mnuPopupDataDeleteRow.Visible = False
                    End With
                End If
            End If
        Case Else
            
    End Select
End Sub

Public Function AddNewGroup()
    vsfgDatasheet.AddItem "", vsfgDatasheet.Row + 1
    vsfgDatasheet.RowOutlineLevel(vsfgDatasheet.Row + 1) = 2
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row, grdAcTypeID) = vsfgDatasheet.TextMatrix(vsfgDatasheet.Row - 1, grdAcTypeID)
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row + 1, grdTreeLevel) = 2
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row, grdIsBold) = True
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row, grdIsTotal) = True
End Function

Public Function AddNewHead()
    vsfgDatasheet.AddItem "", vsfgDatasheet.Row + 1
    vsfgDatasheet.RowOutlineLevel(vsfgDatasheet.Row + 1) = 3
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row + 1, grdTreeLevel) = 3
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row, grdIsBold) = False
    vsfgDatasheet.TextMatrix(vsfgDatasheet.Row, grdIsTotal) = False
End Function

Public Function DataDeleteRow()
    vsfgDatasheet.RemoveItem
End Function

Public Function FindTrialBalanceTotal(Optional lngRow As Long = -1)
On Local Error Resume Next
Dim lngAcTypeLast As Double, lngAcTypeThis As Double
Dim lngAcTypeID As Long, strNature As String
    lngAcTypeID = vsfgDatasheet.ValueMatrix(IIf(lngRow = -1, vsfgDatasheet.Row, lngRow), grdAcTypeID)
    strNature = PickValue("AcTypes", "TypeNature", "AcTypeID = " & lngAcTypeID)
    lngAcTypeThis = GetSignedValue(GetTrialTypeValue(mPeriodID, lngAcTypeID), strNature)
    If lngAcTypeThis < 0 Then
        If strNature = "Credit" Then
            lngAcTypeThis = lngAcTypeThis * -1
        End If
    Else
        If strNature = "Credit" Then
            lngAcTypeThis = lngAcTypeThis * -1
        End If
    End If
    SetTotal IIf(lngRow = -1, vsfgDatasheet.Row, lngRow), grdThisTrialBalance, lngAcTypeThis
End Function

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsSave As New ADODB.Recordset
Dim Inc As Long
    AdoConn.BeginTrans
    sSql = "Delete From AuditInformation Where PeriodID = " & mPeriodID
    AdoConn.Execute sSql
    sSql = "Select * From AuditInformation Where PeriodID  = " & mPeriodID
    Set rsSave = GetRecords(sSql)
        With rsSave
            For Inc = 3 To vsfgDatasheet.Rows - 1
                .AddNew
                .Fields("InfoID") = GetRangeMaxNo("AuditInformation", "InfoID", mCompanyID * cnstAuditInfoMaxCount, (mCompanyID * cnstAuditInfoMaxCount) + cnstAuditInfoMaxCount)
                .Fields("PeriodID") = mPeriodID
                If vsfgDatasheet.ValueMatrix(Inc, grdAcTypeID) <> 0 Then
                    .Fields("AcTypeID") = vsfgDatasheet.TextMatrix(Inc, grdAcTypeID)
                    .Fields("AcID") = Null
                ElseIf vsfgDatasheet.ValueMatrix(Inc, grdAcID) <> 0 Then
                    .Fields("AcTypeID") = vsfgDatasheet.TextMatrix(Inc, grdAcTypeID)
                    .Fields("AcID") = vsfgDatasheet.TextMatrix(Inc, grdAcID)
                End If
                .Fields("Particulars") = vsfgDatasheet.TextMatrix(Inc, grdAccounts)
                .Fields("ThisYrTB") = vsfgDatasheet.ValueMatrix(Inc, grdThisTrialBalance)
                .Fields("ThisYrAmt") = vsfgDatasheet.ValueMatrix(Inc, grdThisTotal)
                .Fields("LastYrTB") = vsfgDatasheet.ValueMatrix(Inc, grdLastTrialBalance)
                .Fields("LastYrAmt") = vsfgDatasheet.ValueMatrix(Inc, grdLastTotal)
                .Fields("IsBold") = vsfgDatasheet.ValueMatrix(Inc, grdIsBold)
                .Fields("Treelevel") = vsfgDatasheet.ValueMatrix(Inc, grdTreeLevel)
                .Fields("IsTotal") = vsfgDatasheet.ValueMatrix(Inc, grdIsTotal)
                .Update
            Next
            .Close
        End With
    Save = True
    AdoConn.CommitTrans
Exit Function
Err_Exit:
    ShowError
    Save = False
End Function

Public Sub SetTotal(Row As Long, Col As Long, dblAmount As Double)
On Local Error GoTo Err_Exit
    If dblAmount < 0 Then
        vsfgDatasheet.TextMatrix(Row, Col) = "(" & Format(Abs(dblAmount), "#,##0") & ")"
    ElseIf dblAmount > 0 Then
        vsfgDatasheet.TextMatrix(Row, Col) = Format(dblAmount, "#,##0")
    Else
        vsfgDatasheet.TextMatrix(Row, Col) = ""
    End If
Exit Sub
Err_Exit:
'    ShowError
End Sub

Public Sub FindTotal()
On Local Error GoTo Err_Exit
Dim Inc As Long, dblTmp As Double, lngTotCount As Long
Dim dblTot1 As Double, dblTot2 As Double, dblTot3 As Double, dblTot4 As Double, dblTot5 As Double, dblTot6 As Double
Dim dblTmpTot1 As Double, dblTmpTot2 As Double, dblTmpTot3 As Double, dblTmpTot4 As Double, dblTmpTot5 As Double, dblTmpTot6 As Double
Dim dblTotTmp As Double
    With vsfgDatasheet
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsTotal) = 1 Then
                lngTotCount = lngTotCount + 1
                Select Case lngTotCount
                    Case 1
                        dblTot1 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot1
                        dblTmpTot1 = dblTot1
                    Case 2
                        dblTot2 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot2
                        dblTmpTot2 = dblTmpTot1 + dblTot2
                    Case 3
                        dblTot3 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot3
                        dblTmpTot3 = dblTot3
                    Case 4
                        dblTot4 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot4
                        dblTmpTot4 = dblTot4
                    Case 5
                        dblTot5 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot5
                        dblTmpTot5 = dblTot5 + dblTmpTot4 + dblTmpTot3 + dblTmpTot2
                    Case 6
                        dblTot6 = dblTmp
                        SetTotal Inc, grdThisTotal, dblTot6
                        dblTmpTot6 = dblTot6 + dblTmpTot5
                    Case Else
                        dblTotTmp = dblTmp
                        SetTotal Inc, grdThisTotal, dblTotTmp
                        dblTmpTot6 = dblTot6 + dblTmpTot5
                End Select
                .Cell(flexcpFontUnderline, Inc - 1, grdThisTotal, Inc - 1, grdLastTotal) = True
                .Cell(flexcpFontUnderline, Inc, grdThisTotal, Inc, grdLastTotal) = True
                .Cell(flexcpFontBold, Inc, grdThisTotal, Inc, grdLastTotal) = True

                dblTmp = 0
            Else
                dblTmp = dblTmp + GetActualValue(.TextMatrix(Inc, grdThisTotal))
            End If
        Next Inc
    End With
Exit Sub
Err_Exit:
    
End Sub

Public Function GetActualValue(strValue As String) As Double
On Local Error Resume Next
Dim IsMinus As Boolean
    If InStr(1, strValue, "(") <> 0 Then
        IsMinus = True
    End If
    If InStr(1, strValue, "-") <> 0 Then
        IsMinus = True
    End If
    strValue = Trim(Replace(Replace(Replace(strValue, ",", ""), "(", ""), ")", ""))
    GetActualValue = Abs(RVal(strValue))
    If IsMinus Then
        GetActualValue = GetActualValue * -1
    End If
End Function

Public Sub FindLastTotal()
On Local Error GoTo Err_Exit
Dim Inc As Long, dblTmp As Double, lngTotCount As Long
Dim dblTot1 As Double, dblTot2 As Double, dblTot3 As Double, dblTot4 As Double, dblTot5 As Double, dblTot6 As Double
Dim dblTmpTot1 As Double, dblTmpTot2 As Double, dblTmpTot3 As Double, dblTmpTot4 As Double, dblTmpTot5 As Double, dblTmpTot6 As Double
Dim dblTotTmp As Double
    With vsfgDatasheet
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsTotal) = 1 Then
                lngTotCount = lngTotCount + 1
                Select Case lngTotCount
                    Case 1
                        dblTot1 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot1
                    Case 2
                        dblTot2 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot2
                    Case 3
                        dblTot3 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot3
                    Case 4
                        dblTot4 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot4
                    Case 5
                        dblTot5 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot5
                    Case 6
                        dblTot6 = dblTmp
                        SetTotal Inc, grdLastTotal, dblTot6
                    Case Else
                        dblTotTmp = dblTmp
                        SetTotal Inc, grdLastTotal, dblTotTmp
                End Select
                .Cell(flexcpFontUnderline, Inc - 1, grdThisTotal, Inc - 1, grdLastTotal) = True
                .Cell(flexcpFontUnderline, Inc, grdThisTotal, Inc, grdLastTotal) = True
                .Cell(flexcpFontBold, Inc, grdThisTotal, Inc, grdLastTotal) = True
                dblTmp = 0
            Else
                dblTmp = dblTmp + GetActualValue(.TextMatrix(Inc, grdLastTotal))
            End If
        Next Inc
    End With
Exit Sub
Err_Exit:
    
End Sub
