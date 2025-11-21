VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmCashAndCashEquivalents 
   Caption         =   "Cash and Cash Equivalents"
   ClientHeight    =   3825
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7860
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   3825
   ScaleWidth      =   7860
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtAcType 
      Height          =   315
      Left            =   45
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   765
      Width           =   4140
   End
   Begin VB.CommandButton fndAcTypeID 
      Height          =   315
      Left            =   4185
      Picture         =   "frmCashAndCashEquivalents.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   765
      Width           =   315
   End
   Begin VB.TextBox txtNoteNo 
      Height          =   315
      Left            =   4605
      TabIndex        =   3
      Top             =   765
      Width           =   990
   End
   Begin VB.CheckBox chkFinished 
      Caption         =   "Finished"
      Height          =   255
      Left            =   75
      TabIndex        =   1
      Top             =   3315
      Width           =   915
   End
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmCashAndCashEquivalents.frx":018A
      Left            =   1110
      List            =   "frmCashAndCashEquivalents.frx":018C
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   105
      Width           =   3420
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   180
      Top             =   2760
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   12
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":018E
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":02E8
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":0442
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":059C
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":0776
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":08D0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":0AAA
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":0C04
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":2106
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":22E0
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":24BA
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmCashAndCashEquivalents.frx":2694
            Key             =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2790
      TabIndex        =   6
      Top             =   3285
      Width           =   4935
      _ExtentX        =   8705
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
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
            Object.Width           =   50
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Print"
            Key             =   "Print"
            Object.ToolTipText     =   "Print"
            Object.Tag             =   "Print"
            ImageKey        =   "Print"
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgTree 
      Height          =   1710
      Left            =   45
      TabIndex        =   2
      Top             =   1125
      Width           =   7755
      _cx             =   13679
      _cy             =   3016
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
      Rows            =   5
      Cols            =   3
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmCashAndCashEquivalents.frx":29AE
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
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Account type"
      Height          =   195
      Left            =   45
      TabIndex        =   11
      Top             =   525
      Width           =   945
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Note No:"
      Height          =   195
      Left            =   4620
      TabIndex        =   10
      Top             =   525
      Width           =   645
   End
   Begin VB.Label lblTotalThis 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   270
      Left            =   4155
      TabIndex        =   9
      Top             =   2880
      Width           =   1785
   End
   Begin VB.Label lblTotalLast 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   270
      Left            =   5985
      TabIndex        =   8
      Top             =   2880
      Width           =   1800
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   60
      TabIndex        =   7
      Top             =   165
      Width           =   960
   End
End
Attribute VB_Name = "frmCashAndCashEquivalents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mdblTotalAmt As Double, mdblLastTotalAmt As Double
Dim mdblCurTotalAmount As Double, mdblLastTotalAmount As Double, mdblCurLess As Double, mdblLastLess As Double

Dim mblnModify As Boolean
Dim mblnNew As Boolean

Const grdParticulars = 0
Const grdThisYear = 1
Const grdLastYear = 2

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
   fndAcTypeID.Enabled = Not blnNewValue
   txtNoteNo.Enabled = blnNewValue
   vsfgTree.Enabled = blnNewValue
   chkFinished.Enabled = blnNewValue
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
         vsfgTree.SetFocus
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
               "FROM    Periods WHERE CompanyID =" & mCompanyID & " Order By StartDt desc"
        SetComboList cmbPeriod, sSql
    End If
    SetComboBoundValue cmbPeriod, Val(vNewValue)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "ComparePeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub fndAcTypeID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Sub ClearValues()
    txtNoteNo = ""
    chkFinished = vbUnchecked
    vsfgTree.Rows = 1: vsfgTree.Rows = 5
    mdblTotalAmt = 0
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
Dim strRslt As String, sSqlFilter As String, sSqlExtraFilter As String
Dim lngPropertyAcTypeID As Long
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpAccountTypes, "WHERE AT.AcTypeID = " & GetActualID(mCompanyID, cnstAcTypeCashAndBankBalances) & "  AND AT.CompanyID = " & mCompanyID, "XAcTypeID", , fndAcTypeID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtAcType.Tag = lngID
        End If
    Else
        If Val(PickValue("AcTypes", "TreeLevel", "AcTypeID = " & lngID)) <> 3 Then
            ShowOpen = False
            Exit Function
        End If
        strRslt = lngID
        txtAcType.Tag = lngID
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        txtAcType = PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
        ShowOpen = ShowData(lngID)
        ShowOpen = True
    End Select
End Function

Public Function ShowData(lngAcTypeID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, dblLastAmount As Double, dblAmount As Double, dblCYearTot As Double, dblCTmpTot As Double
    sSql = "Select * from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeCashEquivalents
    With GetRecords(sSql)
        If Not .EOF Then
            txtNoteNo = .Fields("NoteNo") & ""
            chkFinished = IIf(.Fields("IsFinished"), vbChecked, vbUnchecked)
        End If
        .Close
    End With
    sSql = "SELECT  AcTypeDescription AS Particulars, dbo.fn_GetAcTypeBal(AcTypeID, " & mPeriodID & ") AS Amount, dbo.fn_GetAcTypeBal(AcTypeID, " & mLastPeriodID & ") AS PreviousAmount, " & _
           "TypeNature From AcTypes Where AcTypeID = " & lngAcTypeID
    With GetRecords(sSql)
        If Not .EOF Then
            dblAmount = GetSignedValue(Val(.Fields("Amount") & ""), .Fields("TypeNature") & "")
            dblLastAmount = GetSignedValue(Val(.Fields("PreviousAmount") & ""), .Fields("TypeNature") & "")
        End If
        'Ref No: 048-09/11/08-----------------
        vsfgTree.TextMatrix(1, grdParticulars) = "Cash & bank balances"
'        vsfgTree.TextMatrix(2, grdParticulars) = "Less : "
        vsfgTree.TextMatrix(1, grdThisYear) = IIf(dblAmount < 0, "(" & Format(Abs(dblAmount), "#,##0") & ")", Format(dblAmount, "#,##0"))
        vsfgTree.TextMatrix(1, grdLastYear) = IIf(dblLastAmount < 0, "(" & Format(Abs(dblLastAmount), "#,##0") & ")", Format(dblLastAmount, "#,##0"))
        If vsfgTree.ValueMatrix(1, grdThisYear) = 0 Then
            vsfgTree.TextMatrix(1, grdThisYear) = "-"
        End If
        If vsfgTree.ValueMatrix(1, grdLastYear) = 0 Then
            vsfgTree.TextMatrix(1, grdLastYear) = "-"
        End If
        vsfgTree.Cell(flexcpFontBold, 1, grdParticulars, vsfgTree.Rows - 1, grdThisYear) = True
        mdblTotalAmt = dblAmount
        mdblLastTotalAmt = dblLastAmount
        mdblCurTotalAmount = dblAmount - mdblCurLess
        mdblLastTotalAmount = dblLastAmount - mdblLastLess
        lblTotalThis = IIf(mdblCurTotalAmount < 0, "(" & Format(Abs(mdblCurTotalAmount), "#,##0") & ")", Format(mdblCurTotalAmount, "#,##0"))
        lblTotalLast = IIf(mdblLastTotalAmount < 0, "(" & Format(Abs(mdblLastTotalAmount), "#,##0") & ")", Format(mdblLastTotalAmount, "#,##0"))
        .Close

        vsfgTree.TextMatrix(2, grdThisYear) = PickValue("Schedules", "DerivedAmount", "PeriodID = " & mPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID)
        vsfgTree.TextMatrix(2, grdLastYear) = PickValue("Schedules", "DerivedAmount", "PeriodID = " & mLastPeriodID & " And ScheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID)
        vsfgTree.TextMatrix(2, grdParticulars) = PickValue("Schedules", "Remarks", "PeriodID = " & mPeriodID & " And scheduleTypeID = " & cnstScheduleTypeCashEquivalents & " And AcTypeID = " & lngAcTypeID)

         vsfgTree_AfterEdit 2, grdThisYear
    End With
    ShowData = True
Exit Function
Err_Exit:
    ShowData = False
    ShowError
End Function

Private Sub vsfgTree_AfterEdit(ByVal Row As Long, ByVal Col As Long)
'Ref No: 065-27/01/09 --------------
Dim Inc As Long
    Inc = 0
    Select Case Col
        Case grdParticulars
        
        Case grdThisYear
            For Inc = 2 To vsfgTree.Rows - 1
                mdblCurLess = mdblCurLess + vsfgTree.ValueMatrix(Inc, grdThisYear)
                mdblLastLess = mdblLastLess + vsfgTree.ValueMatrix(Inc, grdLastYear)
                mdblCurTotalAmount = mdblTotalAmt - mdblCurLess
                mdblLastTotalAmount = mdblLastTotalAmt - mdblLastLess
                lblTotalThis = IIf(mdblCurTotalAmount < 0, "(" & Format(Abs(mdblCurTotalAmount), "#,##0") & ")", Format(mdblCurTotalAmount, "#,##0"))
                lblTotalLast = IIf(mdblLastTotalAmount < 0, "(" & Format(Abs(mdblLastTotalAmount), "#,##0") & ")", Format(mdblLastTotalAmount, "#,##0"))
            Next Inc
    End Select
'    mdblCurLess = vsfgTree.ValueMatrix(2, grdThisYear)
'    mdblLastLess = vsfgTree.ValueMatrix(2, grdLastYear)
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim IsTran As Boolean, sSql As String, lngAcTypeID As Long
Dim rsSave As New ADODB.Recordset
    lngAcTypeID = Val(txtAcType.Tag)
    If lngAcTypeID = 0 Then
        pMVE.MsgBox "Nothing To Save!", msgOK, "AuditMate", msgInformation
        Save = False
        Exit Function
    End If
    'Ref No: 014-16/04/08
'    If chkFinished = vbChecked And Trim(txtNoteNo) = "" Then
'        pMVE.MsgBox "Note No: Not Specified.", msgOK, , msgInformation
'        Save = False
'        Exit Function
'    End If
    AdoConn.BeginTrans
    IsTran = True
    sSql = "Delete from Schedules Where AcTypeID = " & lngAcTypeID & " AND PeriodID  = " & mPeriodID & " AND ScheduleTypeID = " & cnstScheduleTypeCashEquivalents
    AdoConn.Execute sSql
        sSql = "Select * From Schedules Where 1 = 2"
        Set rsSave = GetRecords(sSql)
        With rsSave
            .AddNew
            .Fields("AcTypeID") = lngAcTypeID
            .Fields("PeriodID") = mPeriodID
            .Fields("ScheduleTypeID") = cnstScheduleTypeCashEquivalents
            .Fields("NoteNo") = IIf(Trim(txtNoteNo) = "", Null, txtNoteNo)
            .Fields("IsFinished") = chkFinished
            .Fields("IsDetailed") = 0
            .Fields("DerivedAmount") = vsfgTree.ValueMatrix(2, grdThisYear)
            .Fields("Remarks") = vsfgTree.TextMatrix(2, grdParticulars)
            SaveDateAndUser rsSave, True
            .Update
        End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsTran Then
        AdoConn.RollbackTrans
    End If
    Save = False
    ShowError
End Function

Public Sub PrintDoc()
    PrintCashEquivalentSchedule mPeriodID, txtAcType.Tag
End Sub

'Ref No: 004 - 25/03/08
Private Sub vsfgTree_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Row > 0 Then
        Select Case Col
'            Case grdParticulars
'                Cancel = True
            Case grdLastYear
                Cancel = True
            Case Else
                Cancel = False
        End Select
    End If
End Sub
