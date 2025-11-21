VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmCashFlow 
   Caption         =   "Cash Flow"
   ClientHeight    =   7440
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11400
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   7725.057
   ScaleMode       =   0  'User
   ScaleWidth      =   11400
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtCashEquivalent 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   315
      Left            =   2640
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   7031
      Width           =   1605
   End
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmCashFlow.frx":0000
      Left            =   1080
      List            =   "frmCashFlow.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   180
      Width           =   3645
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgCashFlow 
      Height          =   5955
      Left            =   75
      TabIndex        =   1
      Top             =   870
      Width           =   11265
      _cx             =   19870
      _cy             =   10504
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
      Rows            =   1
      Cols            =   8
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmCashFlow.frx":0004
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   2
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
      Left            =   4200
      Top             =   6840
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
            Picture         =   "frmCashFlow.frx":010E
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashFlow.frx":0268
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashFlow.frx":0442
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashFlow.frx":061C
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashFlow.frx":0776
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   6570
      TabIndex        =   4
      Top             =   6960
      Width           =   4740
      _ExtentX        =   8361
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
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Print"
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            Object.Tag             =   "Print"
            ImageKey        =   "Print"
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
   Begin MSComctlLib.Toolbar tbrCtrlsMore 
      Height          =   330
      Left            =   4920
      TabIndex        =   7
      Top             =   6960
      Width           =   1530
      _ExtentX        =   2699
      _ExtentY        =   582
      ButtonWidth     =   2805
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "imglstCtrls"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "&Auto Process"
            Key             =   "AutoProcess"
            ImageIndex      =   1
         EndProperty
      EndProperty
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Value of Cash && Cash Equivalents"
      Height          =   195
      Left            =   120
      TabIndex        =   5
      Top             =   7080
      Width           =   2400
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   45
      TabIndex        =   3
      Top             =   240
      Width           =   960
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Cash Flow Statements:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   45
      TabIndex        =   0
      Top             =   600
      Width           =   1950
   End
End
Attribute VB_Name = "frmCashFlow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdSlNo = 0
Const grdParticulars = 1
Const grdDescription = 2
Const grdThisPeriod = 3
Const grdLastPeriod = 4
Const grdIsTotal = 5
Const grdAcTypeID = 6
Const grdIsBold = 7

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mPeriodID = pActivePeriodID) Or Not (mCompanyID = pActiveCompanyID)
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
    If blnNewValue Then
        vsfgCashFlow.SetFocus
    End If
    tbrCtrlsMore.Buttons("AutoProcess").Enabled = blnNewValue
    mblnModify = blnNewValue
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
        sSql = "SELECT  PeriodID AS IDField, ShortName + '  ' + CONVERT(varchar,CONVERT(DateTime, StartDt - 2, 103),103) + ' - ' + Convert(Varchar,CONVERT(DateTime, EndDt - 2, 103),103) AS NameField " & _
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " Order By StartDt desc"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
    FillCashFlowData
    ShowCashEquivalents mPeriodID
    tbrCtrls.Buttons("Modify").Enabled = True
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
    If Button.Key <> "Close" Then
         tbrCtrls.Buttons("Modify").Enabled = True
    End If
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, rsSave As New ADODB.Recordset, Inc As Integer
    '----------------------------------------------------------------
    If vsfgCashFlow.ValueMatrix(vsfgCashFlow.Rows - 1, grdThisPeriod) <> RVal(txtCashEquivalent) Then
        pMVE.MsgBox "Cash flow not tallied with cash and cash equivalents schedule.", msgOK, "AuditMate", msgInformation
    End If
    '----------------------------------------------------------------
    AdoConn.BeginTrans
    sSql = "DELETE FROM CashFlowDetails WHERE PeriodID =" & mPeriodID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM CashFlowDetails WHERE PeriodID =" & mPeriodID
    Set rsSave = GetRecords(sSql)
        With rsSave
            For Inc = 1 To vsfgCashFlow.Rows - 1
                .AddNew
                .Fields("CashFlowID") = GetMaxNo("CashFlowDetails", "CashFlowID")
                .Fields("PeriodID") = mPeriodID
                .Fields("AcTypeID") = vsfgCashFlow.ValueMatrix(Inc, grdAcTypeID)
                .Fields("Description") = vsfgCashFlow.TextMatrix(Inc, grdDescription)
                .Fields("Amount") = vsfgCashFlow.ValueMatrix(Inc, grdThisPeriod)
                .Fields("PreviousAmount") = vsfgCashFlow.ValueMatrix(Inc, grdLastPeriod)
                .Fields("IsTotal") = vsfgCashFlow.ValueMatrix(Inc, grdIsTotal)
                .Fields("IsBold") = vsfgCashFlow.ValueMatrix(Inc, grdIsBold)
                .Update
            Next
          .Close
        End With
    Save = True
    AdoConn.CommitTrans
Exit Function
Err_Exit:
    AdoConn.RollbackTrans
    ShowError
    Save = False
End Function

'Ref No: 002 - 25/03/08
Private Sub tbrCtrlsMore_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
    Case "AutoProcess"
        AutoProcess
    End Select
End Sub

Private Sub vsfgCashFlow_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    If Row > 0 Then
        Select Case Col
            Case grdThisPeriod
                FindTotal
            Case grdLastPeriod
                FindLastTotal
            Case Else

        End Select
    End If
End Sub

Private Sub vsfgCashFlow_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
Dim Inc As Long
    If Not IsModify Then Cancel = True
    If Row > 0 Then
        If vsfgCashFlow.ValueMatrix(Row, grdIsTotal) = 1 Or vsfgCashFlow.Cell(flexcpFontBold, Row, grdDescription) = True Then
            With MDIFormMain
                Select Case Col
                    Case grdDescription, grdParticulars, grdThisPeriod, grdLastPeriod
                        Cancel = True
                        .mnuPopupDeleteRow.Visible = False
                    Case Else
                        Cancel = False
                End Select
                '26 - August - 2009 ----------
                Select Case Row
                    Case vsfgCashFlow.Rows - 1
                        Cancel = False
                    Case Else
                End Select
            End With
        End If
    End If
End Sub

Public Sub FindTotal()
On Local Error GoTo Err_Exit
Dim Inc As Long, dblTmp As Double, lngTotCount As Long
Dim dblTot1 As Double, dblTot2 As Double, dblTot3 As Double, dblTot4 As Double, dblTot5 As Double, dblTot6 As Double
Dim dblTmpTot1 As Double, dblTmpTot2 As Double, dblTmpTot3 As Double, dblTmpTot4 As Double, dblTmpTot5 As Double, dblTmpTot6 As Double
    With vsfgCashFlow
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsTotal) = 1 Then
                lngTotCount = lngTotCount + 1
                Select Case lngTotCount
                    Case 1
                        dblTot1 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTot1
                        dblTmpTot1 = dblTot1
                    Case 2
                        dblTot2 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTmpTot1 + dblTot2
                        dblTmpTot2 = dblTmpTot1 + dblTot2
                    Case 3
                        dblTot3 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTot3
                        dblTmpTot3 = dblTot3
                    Case 4
                        dblTot4 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTot4
                        dblTmpTot4 = dblTot4
                    Case 5
                        dblTot5 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTot5 + dblTmpTot4 + dblTmpTot3 + dblTmpTot2
                        dblTmpTot5 = dblTot5 + dblTmpTot4 + dblTmpTot3 + dblTmpTot2
                    Case 6
                        dblTot6 = dblTmp
                        SetTotal Inc, grdThisPeriod, dblTot6 + dblTmpTot5
                        dblTmpTot6 = dblTot6 + dblTmpTot5
                End Select
                .Cell(flexcpFontUnderline, Inc - 1, grdThisPeriod, Inc - 1, grdLastPeriod) = True
                .Cell(flexcpFontUnderline, Inc, grdThisPeriod, Inc, grdLastPeriod) = True
                .Cell(flexcpFontUnderline, Inc - 2, grdThisPeriod, Inc - 2, grdLastPeriod) = False
                dblTmp = 0
            Else
                dblTmp = dblTmp + GetActualValue(.TextMatrix(Inc, grdThisPeriod))
            End If
        Next Inc
    End With
Exit Sub
Err_Exit:
    
End Sub

'Ref No: 012-13/04/08
Public Sub FindLastTotal()
On Local Error GoTo Err_Exit
Dim Inc As Long, dblTmp As Double, lngTotCount As Long
Dim dblTot1 As Double, dblTot2 As Double, dblTot3 As Double, dblTot4 As Double, dblTot5 As Double, dblTot6 As Double
Dim dblTmpTot1 As Double, dblTmpTot2 As Double, dblTmpTot3 As Double, dblTmpTot4 As Double, dblTmpTot5 As Double, dblTmpTot6 As Double
    With vsfgCashFlow
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdIsTotal) = 1 Then
                lngTotCount = lngTotCount + 1
                Select Case lngTotCount
                    Case 1
                        dblTot1 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTot1
                        dblTmpTot1 = dblTot1
                    Case 2
                        dblTot2 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTmpTot1 + dblTot2
                        dblTmpTot2 = dblTmpTot1 + dblTot2
                    Case 3
                        dblTot3 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTot3
                        dblTmpTot3 = dblTot3
                    Case 4
                        dblTot4 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTot4
                        dblTmpTot4 = dblTot4
                    Case 5
                        dblTot5 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTot5 + dblTmpTot4 + dblTmpTot3 + dblTmpTot2
                        dblTmpTot5 = dblTot5 + dblTmpTot4 + dblTmpTot3 + dblTmpTot2
                    Case 6
                        dblTot6 = dblTmp
                        SetTotal Inc, grdLastPeriod, dblTot6 + dblTmpTot5
                        dblTmpTot6 = dblTot6 + dblTmpTot5
                End Select
                .Cell(flexcpFontUnderline, Inc - 1, grdThisPeriod, Inc - 1, grdLastPeriod) = True
                .Cell(flexcpFontUnderline, Inc, grdThisPeriod, Inc, grdLastPeriod) = True
                .Cell(flexcpFontUnderline, Inc - 2, grdThisPeriod, Inc - 2, grdLastPeriod) = False
                dblTmp = 0
            Else
                dblTmp = dblTmp + GetActualValue(.TextMatrix(Inc, grdLastPeriod))
            End If
        Next Inc
    End With
Exit Sub
Err_Exit:
    
End Sub

Public Sub SetTotal(Row As Long, Col As Long, dblAmount As Double)
On Local Error GoTo Err_Exit
    If dblAmount < 0 Then
        vsfgCashFlow.TextMatrix(Row, Col) = "(" & Format(Abs(dblAmount), "#,##0") & ")"
    ElseIf dblAmount > 0 Then
        vsfgCashFlow.TextMatrix(Row, Col) = Format(dblAmount, "#,##0")
    Else
        vsfgCashFlow.TextMatrix(Row, Col) = ""
    End If
Exit Sub
Err_Exit:
'    ShowError
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

Public Sub PrintDoc()
    PrintCashFlow mPeriodID
End Sub

Private Sub vsfgCashFlow_CellChanged(ByVal Row As Long, ByVal Col As Long)
    If Row > 0 And Col = grdParticulars Then
        If vsfgCashFlow.TextMatrix(Row, grdParticulars) <> "" Then
            vsfgCashFlow.TextMatrix(Row, grdDescription) = vsfgCashFlow.TextMatrix(Row, grdParticulars)
        End If
        FindTotal
    End If
    If Row > 0 And Col = grdThisPeriod Then
        vsfgCashFlow.Cell(flexcpFontBold, Row, grdThisPeriod) = True
    End If
End Sub

Private Sub vsfgCashFlow_Click()
    vsfgCashFlow.ToolTipText = vsfgCashFlow.Text
End Sub

Private Sub vsfgCashFlow_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Local Error Resume Next
Dim Inc As Long
    If Button = vbRightButton Then
        With MDIFormMain
            .mnuPopupAddRow.Visible = True
            .mnuPopupDeleteRow.Visible = True
            For Inc = 0 To .mnuPopupConsoleRoot.Count
                .mnuPopupConsoleRoot(Inc).Visible = False
            Next Inc
            PopupMenu .mnuPopup
            For Inc = 0 To .mnuPopupConsoleRoot.Count
                .mnuPopupConsoleRoot(Inc).Visible = True
            Next Inc
            .mnuPopupAddRow.Visible = False
            .mnuPopupDeleteRow.Visible = False
        End With
    End If
End Sub

Public Function AddRow()
    vsfgCashFlow.AddItem "", vsfgCashFlow.Row
End Function

Public Function DeleteRow()
    vsfgCashFlow.RemoveItem
End Function

Private Sub vsfgCashFlow_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
Dim Inc As Integer
    Inc = vsfgCashFlow.Rows - 1
    PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.TreeLevel = 3 AND AT.CompanyID = " & mCompanyID, "Name(" & grdParticulars & "), XAcTypeID(" & grdAcTypeID & ")", vsfgCashFlow, , , , 1
    FindTrialBalanceTotal
    FindTotal
    vsfgCashFlow.Cell(flexcpFontBold, vsfgCashFlow.Row, grdThisPeriod) = True
    PutSlNo vsfgCashFlow, grdSlNo, grdDescription
End Sub

Public Function FindTrialBalanceTotal(Optional lngRow As Long = -1)
On Local Error Resume Next
Dim lngAcTypeLast As Double, lngAcTypeThis As Double, lngAcTypeTotal As Double
Dim lngAcTypeID As Long, strNature As String
    'Ref No: 005 - 27/03/08
    lngAcTypeID = vsfgCashFlow.ValueMatrix(IIf(lngRow = -1, vsfgCashFlow.Row, lngRow), grdAcTypeID)
    strNature = PickValue("AcTypes", "TypeNature", "AcTypeID = " & lngAcTypeID)

    lngAcTypeLast = GetSignedValue(GetTrialTypeValue(mLastPeriodID, lngAcTypeID), strNature)
    lngAcTypeThis = GetSignedValue(GetTrialTypeValue(mPeriodID, lngAcTypeID), strNature)

    lngAcTypeTotal = lngAcTypeLast - lngAcTypeThis
    If lngAcTypeTotal < 0 Then 'Increase
        If strNature = "Credit" Then
            lngAcTypeTotal = lngAcTypeTotal * -1
        End If
    Else
        If strNature = "Credit" Then
            lngAcTypeTotal = lngAcTypeTotal * -1
        End If
    End If

    SetTotal IIf(lngRow = -1, vsfgCashFlow.Row, lngRow), grdThisPeriod, lngAcTypeTotal
End Function

Public Function ShowCashEquivalents(lngPeriodID As Long)
On Local Error GoTo Err_Exit
Dim lngAcTypeID As Long, sSql As String, dblThisCash As Double, dblDerivedAmt As Double, dblTotalAmt As Double
    lngAcTypeID = GetActualID(mCompanyID, cnstAcTypeCashAndBankBalances)
    sSql = "SELECT  dbo.fn_GetAcTypeBal(AcTypeID, " & mPeriodID & ") AS Amount From AcTypes Where AcTypeID = " & lngAcTypeID
    With GetRecords(sSql)
        If Not .EOF Then
            dblThisCash = Val(.Fields("Amount") & "")
        End If
    End With
    sSql = "Select DerivedAmount From Schedules Where AcTypeID = " & lngAcTypeID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And PeriodID = " & mPeriodID
        With GetRecords(sSql)
            If Not .EOF Then
                dblDerivedAmt = Val(.Fields("DerivedAmount") & "")
            End If
        End With
    dblTotalAmt = dblThisCash - dblDerivedAmt
    txtCashEquivalent = Format(Abs(dblTotalAmt), "#,##0")
Exit Function
Err_Exit:
    ShowError
End Function

Public Sub FillCashFlowData()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, rsTmp As Recordset, dblThisTotAmt As Double, dblLastTotAmt As Double, lngAcType As Long, sSql2 As String, rsTmp2 As New Recordset
Dim lngInc As Long, ProfitLossThisTotal As Long, lngAcTypeID As Long, DepreciationThisTotal As Double, sSql1 As String, rsTmp1 As New Recordset, dblTotThisAmt As Double
Dim ProfitLossLastTotal As Long, DepreciationLastTotal As Double, sSqlPrevious As String, rsTmp3 As New Recordset

    DepreciationThisTotal = 0
    DepreciationLastTotal = 0

    lngAcTypeID = GetActualID(mCompanyID, cnstAcTypePropertyPlantEquipment)
    ProfitLossThisTotal = GetTrialTypeValue(mPeriodID, GetActualID(mCompanyID, cnstAcTypeProfitLoss))
    ProfitLossLastTotal = GetTrialTypeValue(mLastPeriodID, GetActualID(mCompanyID, cnstAcTypeProfitLoss))
    sSql1 = "SELECT SUM(FAS.Amount) AS TotalDepreciation FROM AcTypes AT INNER JOIN FixedAssetSchedules FAS ON AT.AcTypeID = FAS.AcTypeID " & _
            "WHERE  AT.ParentAcTypeID = " & lngAcTypeID & " And FAS.ItemID = 10 AND FAS.PeriodID = " & mPeriodID
    Set rsTmp1 = GetRecords(sSql1)
    If Not rsTmp1.EOF Then
        DepreciationThisTotal = Val(rsTmp1.Fields("TotalDepreciation") & "")
    End If
    'Ref No: 005 - 27/03/08 ---- Change in ItemID
    sSql1 = "SELECT SUM(FAS.Amount) AS TotalDepreciation FROM AcTypes AT INNER JOIN FixedAssetSchedules FAS ON AT.AcTypeID = FAS.AcTypeID " & _
            "WHERE  AT.ParentAcTypeID = " & lngAcTypeID & " And FAS.ItemID = 10 AND FAS.PeriodID = " & mLastPeriodID
    Set rsTmp1 = GetRecords(sSql1)
    If Not rsTmp1.EOF Then
        DepreciationLastTotal = Val(rsTmp1.Fields("TotalDepreciation") & "")
    End If
'    sSql = "SELECT   CFD.Description Particulars, AT.AcTypeDescription, SUM(CASE CFD.PeriodID WHEN " & mPeriodID & " THEN CFD.Amount ELSE 0 END) AS Amount, " & _
'           "         SUM(CASE CFD.PeriodID WHEN " & mLastPeriodID & " THEN CFD.Amount ELSE 0 END) AS PreviousAmount, CFD.IsBold AS IsBold, CFD.IsTotal AS IsTotal, CFD.AcTypeID AS AcTypeID " & _
'           "FROM     (SELECT  * From CashFlowDetails WHERE PeriodID IN (" & mLastPeriodID & ", " & mPeriodID & ")) CFD LEFT OUTER JOIN AcTypes AT ON CFD.AcTypeID = AT.AcTypeID " & _
'           "GROUP BY CFD.Description, AT.AcTypeDescription, CFD.IsBold, CFD.IsTotal, CFD.AcTypeID " & _
'           "ORDER BY MAX(CFD.CashFlowID)"
    sSql = "SELECT  AT.AcTypeDescription, CFD.Description AS Particulars, CFD.Amount AS Amount, CFD.PreviousAmount AS PreviousAmount, CFD.IsBold, CFD.IsTotal, CFD.AcTypeID AS AcTypeID " & _
           "FROM    CashFlowDetails CFD LEFT OUTER JOIN AcTypes AT ON CFD.AcTypeID = AT.AcTypeID WHERE  CFD.PeriodID =" & mPeriodID
    Set rsTmp = GetRecords(sSql)
        If Not rsTmp.EOF Then
            With rsTmp
                While Not .EOF
                    vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
                    vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
                    vsfgCashFlow.TextMatrix(Inc, grdParticulars) = .Fields("AcTypeDescription") & ""
                    vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Particulars") & ""
                    vsfgCashFlow.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
                    vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
                    vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
                    vsfgCashFlow.TextMatrix(Inc, grdThisPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
                    vsfgCashFlow.TextMatrix(Inc, grdLastPeriod) = IIf(.Fields("PreviousAmount") & "" < 0, "(" & Format(Abs(.Fields("PreviousAmount")), "#,##0") & ")", Format(Abs(.Fields("PreviousAmount")), "#,##0"))
                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
                    If .Fields("IsBold") = True Then
                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
                    Else
                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
                    End If
                    .MoveNext
                Wend
                .Close
            End With
        Else
            sSql = "SELECT CFD.*, CFD.Description AS Particulars, CFD.Amount AS Amount, AT.AcTypeDescription " & _
                   "FROM   CashFlowDetails CFD LEFT OUTER JOIN AcTypes AT ON CFD.AcTypeID = AT.AcTypeID " & _
                   "WHERE  CFD.PeriodID = " & mLastPeriodID
            Set rsTmp2 = GetRecords(sSql)
                If Not rsTmp2.EOF Then
                    With rsTmp2
                        While Not .EOF
                            vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
                            vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
                            vsfgCashFlow.TextMatrix(Inc, grdParticulars) = .Fields("AcTypeDescription") & ""
                            vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Particulars") & ""
                            vsfgCashFlow.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
                            vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
                            vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
'                            vsfgCashFlow.TextMatrix(Inc, grdThisPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
                            vsfgCashFlow.TextMatrix(Inc, grdLastPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
                            vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
                            If .Fields("IsBold") = True Then
                                vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
                            Else
                                vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
                            End If
                            .MoveNext
                        Wend
                        .Close
                        vsfgCashFlow.TextMatrix(2, grdDescription) = "Net " & IIf(ProfitLossThisTotal < 0, "profit", "loss") & " for the year"
                    End With
                Else
                    sSql = "SELECT *, CFI.Description as Particulars, 0 AS Amount FROM CashFlowItems CFI"
                    Set rsTmp2 = GetRecords(sSql)
                    With rsTmp2
                        While Not .EOF
                            vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
                            vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
                            vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
                            vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
                            vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
                            vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
                            If .Fields("IsBold") = True Then
                                vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
                            Else
                                vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
                            End If
                            .MoveNext
                        Wend
                        .Close
                        vsfgCashFlow.TextMatrix(2, grdDescription) = "Net " & IIf(ProfitLossThisTotal < 0, "profit", "loss") & " for the year"
                    End With
                End If
        End If
'            sSql = "SELECT *, CFI.Description as Particulars, 0 AS Amount FROM CashFlowItems CFI"
'            Set rsTmp2 = GetRecords(sSql)
'            With rsTmp2
'                While Not .EOF
'                    vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
'                    vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
'                    vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
'                    vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
'                    vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
'                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
'                    If .Fields("IsBold") = True Then
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
'                    Else
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
'                    End If
'                    .MoveNext
'                Wend
'                .Close
'            End With
'        End If
'    If mLastPeriodID <> 0 Then
'        sSql = "SELECT CFD.*, CFD.Description AS Particulars, CFD.Amount AS Amount, AT.AcTypeDescription " & _
'               "FROM   CashFlowDetails CFD LEFT OUTER JOIN AcTypes AT ON CFD.AcTypeID = AT.AcTypeID " & _
'               "WHERE  CFD.PeriodID = " & mLastPeriodID
'        Set rsTmp2 = GetRecords(sSql)
'        With rsTmp2
'            While Not .EOF
'                vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
'                vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
'                vsfgCashFlow.TextMatrix(Inc, grdParticulars) = .Fields("AcTypeDescription") & ""
'                vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Particulars") & ""
'                vsfgCashFlow.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
'                vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
'                vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
'                vsfgCashFlow.TextMatrix(Inc, grdThisPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
'                vsfgCashFlow.TextMatrix(Inc, grdLastPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
'                vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
'                If .Fields("IsBold") = True Then
'                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
'                Else
'                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
'                End If
'                .MoveNext
'            Wend
'            .Close
'        End With
'    End If
'    If mLastPeriodID = 0 Then
'        sSql = "SELECT CFD.*, CFD.Description AS Particulars, CFD.Amount AS Amount, CFD.PreviousAmount AS PreviousAmount, AT.AcTypeDescription " & _
'               "FROM   CashFlowDetails CFD LEFT OUTER JOIN AcTypes AT ON CFD.AcTypeID = AT.AcTypeID " & _
'               "WHERE  CFD.PeriodID =" & mPeriodID
'        Set rsTmp = GetRecords(sSql)
'        If Not rsTmp.EOF Then
'            With rsTmp
'                While Not .EOF
'                    vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
'                    vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
'                    vsfgCashFlow.TextMatrix(Inc, grdParticulars) = .Fields("AcTypeDescription") & ""
'                    vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Particulars") & ""
'                    vsfgCashFlow.TextMatrix(Inc, grdAcTypeID) = .Fields("AcTypeID") & ""
'                    vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
'                    vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
'                    vsfgCashFlow.TextMatrix(Inc, grdThisPeriod) = IIf(.Fields("Amount") & "" < 0, "(" & Format(Abs(.Fields("Amount")), "#,##0") & ")", Format(Abs(.Fields("Amount")), "#,##0"))
'                    vsfgCashFlow.TextMatrix(Inc, grdLastPeriod) = IIf(.Fields("PreviousAmount") & "" < 0, "(" & Format(Abs(.Fields("PreviousAmount")), "#,##0") & ")", Format(Abs(.Fields("PreviousAmount")), "#,##0"))
'                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
'                    If .Fields("IsBold") = True Then
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
'                    Else
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
'                    End If
'                    .MoveNext
'                Wend
'                .Close
'            End With
'        Else
'            sSql = "SELECT *, CFI.Description as Particulars, 0 AS Amount FROM CashFlowItems CFI"
'            Set rsTmp2 = GetRecords(sSql)
'            With rsTmp2
'                While Not .EOF
'                    vsfgCashFlow.Rows = vsfgCashFlow.Rows + 1: Inc = Inc + 1
'                    vsfgCashFlow.TextMatrix(Inc, grdSlNo) = Inc
'                    vsfgCashFlow.TextMatrix(Inc, grdDescription) = .Fields("Description") & ""
'                    vsfgCashFlow.TextMatrix(Inc, grdIsTotal) = IIf(.Fields("IsTotal") & "" = "True", 1, 0)
'                    vsfgCashFlow.TextMatrix(Inc, grdIsBold) = IIf(.Fields("IsBold") & "" = "True", 1, 0)
'                    vsfgCashFlow.Cell(flexcpFontBold, Inc, grdThisPeriod) = True
'                    If .Fields("IsBold") = True Then
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = True
'                    Else
'                        vsfgCashFlow.Cell(flexcpFontBold, Inc, grdDescription) = False
'                    End If
'                    .MoveNext
'                Wend
'                .Close
'            End With
'        End If
'    End If
'    vsfgCashFlow.TextMatrix(2, grdDescription) = "Net " & IIf(ProfitLossThisTotal < 0, "profit", "loss") & " for the year"
    vsfgCashFlow.TextMatrix(2, grdThisPeriod) = IIf((ProfitLossThisTotal * -1 < 0), "(" & Format(Abs(ProfitLossThisTotal * -1), "#,##0") & ")", Format(ProfitLossThisTotal * -1, "#,##0"))
    vsfgCashFlow.TextMatrix(2, grdLastPeriod) = IIf((ProfitLossLastTotal * -1 < 0), "(" & Format(Abs(ProfitLossLastTotal * -1), "#,##0") & ")", Format(ProfitLossLastTotal * -1, "#,##0"))
    vsfgCashFlow.TextMatrix(4, grdDescription) = "Depreciation"
    If vsfgCashFlow.ValueMatrix(4, grdThisPeriod) = 0 Then
        vsfgCashFlow.TextMatrix(4, grdThisPeriod) = IIf(Val(DepreciationThisTotal) < 0, "(" & Format(Abs(DepreciationThisTotal), "#,##0") & ")", Format(Val(DepreciationThisTotal), "#,##0"))
    End If
'    vsfgCashFlow.TextMatrix(4, grdLastPeriod) = IIf(Val(DepreciationLastTotal) < 0, "(" & Format(Abs(DepreciationLastTotal), "#,##0") & ")", Format(Val(DepreciationLastTotal), "#,##0"))
    PutSlNo vsfgCashFlow, grdSlNo, grdDescription
    FindTotal
    vsfgCashFlow.TextMatrix(0, grdThisPeriod) = "Current Period"
    vsfgCashFlow.Cell(flexcpFontBold, 0, grdSlNo, 0, grdLastPeriod) = True
    vsfgCashFlow.Cell(flexcpFontUnderline, vsfgCashFlow.Rows - 3, grdThisPeriod, vsfgCashFlow.Rows - 3, grdLastPeriod) = False
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub AutoProcess()
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String, lngAcType As Double
    With vsfgCashFlow
        For Inc = 0 To .Rows - 1
            If .ValueMatrix(Inc, grdAcTypeID) <> 0 Then
                FindTrialBalanceTotal Inc
            End If
        Next Inc
    End With
    FindTotal
    pMVE.MsgBox "Cash flow is updated with trial balance values.", msgOK, "AuditMate", msgInformation, True
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function Get1stLevelParent(lngAcTypeID As Long)
On Local Error Resume Next
Dim sSql As String
    sSql = "Select TreeLevel, ParentAcTypeID from AcTypes Where AcTypeID = " & lngAcTypeID
    With GetRecords(sSql)
        If Not .EOF Then
            If Val(.Fields("TreeLevel") & "") = 3 Then
                Get1stLevelParent = lngAcTypeID
            ElseIf Val(.Fields("ParentAcTypeID") & "") <> 0 Then
                Get1stLevelParent = Get1stLevelParent(Val(.Fields("ParentAcTypeID") & ""))
            Else
                Get1stLevelParent = 0
            End If
        Else
            Get1stLevelParent = 0
        End If
    End With
End Function
