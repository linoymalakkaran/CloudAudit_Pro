VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmJournalEntry 
   Caption         =   "Journal Entry"
   ClientHeight    =   6630
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8310
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6630
   ScaleWidth      =   8310
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cmbPeriod 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "frmJournalEntry.frx":0000
      Left            =   1155
      List            =   "frmJournalEntry.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   16
      Top             =   135
      Width           =   3645
   End
   Begin VB.CommandButton fndRefNo 
      Height          =   315
      Left            =   1650
      Picture         =   "frmJournalEntry.frx":0004
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   990
      Width           =   315
   End
   Begin VB.TextBox txtRemark 
      Height          =   930
      Left            =   105
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   4995
      Width           =   8115
   End
   Begin VB.Frame frameDetails 
      Height          =   915
      Left            =   105
      TabIndex        =   9
      Top             =   555
      Width           =   8085
      Begin VB.TextBox txtRefNo 
         Height          =   315
         Left            =   120
         MaxLength       =   20
         TabIndex        =   0
         Top             =   420
         Width           =   1425
      End
      Begin VB.OptionButton optErrorSchedule 
         Caption         =   "Error Schedule"
         Height          =   195
         Left            =   6480
         TabIndex        =   5
         Top             =   480
         Width           =   1350
      End
      Begin VB.OptionButton optUserAdjust 
         Caption         =   "User Adjustment"
         Height          =   195
         Left            =   4920
         TabIndex        =   4
         Top             =   480
         Value           =   -1  'True
         Width           =   1545
      End
      Begin MSComCtl2.DTPicker dtpReference 
         Height          =   315
         Left            =   1965
         TabIndex        =   1
         Top             =   420
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   556
         _Version        =   393216
         Format          =   90505217
         CurrentDate     =   39336
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Ref No"
         Height          =   195
         Left            =   120
         TabIndex        =   11
         Top             =   195
         Width           =   510
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Ref Date"
         Height          =   195
         Left            =   1965
         TabIndex        =   10
         Top             =   195
         Width           =   645
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   105
      Top             =   5985
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
            Picture         =   "frmJournalEntry.frx":018E
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":02E8
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":0442
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":059C
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":0776
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":08D0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":0AAA
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":0C04
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":2106
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":22E0
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmJournalEntry.frx":24BA
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   2175
      TabIndex        =   8
      Top             =   6150
      Width           =   6000
      _ExtentX        =   10583
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
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&New"
            Key             =   "New"
            ImageKey        =   "New"
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            ImageKey        =   "Modify"
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
            Object.Width           =   50
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Delete"
            Key             =   "Delete"
            ImageKey        =   "Delete"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Save"
            Key             =   "Save"
            ImageKey        =   "Save"
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clos&e"
            Key             =   "Close"
            ImageKey        =   "Close"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgEntry 
      Height          =   2865
      Left            =   105
      TabIndex        =   2
      Top             =   1515
      Width           =   8085
      _cx             =   14261
      _cy             =   5054
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
      Cols            =   6
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmJournalEntry.frx":2694
      ScrollTrack     =   -1  'True
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
      ExplorerBar     =   5
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
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Select Period"
      Height          =   195
      Left            =   120
      TabIndex        =   17
      Top             =   195
      Width           =   960
   End
   Begin VB.Label lblTotDr 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2805
      TabIndex        =   15
      Top             =   4545
      Width           =   1305
   End
   Begin VB.Label lblTotCr 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   4140
      TabIndex        =   14
      Top             =   4545
      Width           =   1290
   End
   Begin VB.Label lblDiff 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5520
      TabIndex        =   13
      Top             =   4545
      Width           =   2655
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Totals"
      Height          =   195
      Left            =   2265
      TabIndex        =   7
      Top             =   4590
      Width           =   435
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Remarks"
      Height          =   195
      Left            =   105
      TabIndex        =   6
      Top             =   4770
      Width           =   630
   End
End
Attribute VB_Name = "frmJournalEntry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean
Dim mlngId As Long
Dim lngDecimals As Long

Const grdSlNo = 0
Const grdAcName = 1
Const grdDrAmt = 2
Const grdCrAmt = 3
Const grdNarration = 4
Const grdAcID = 5

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
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
    ButtonHandling Me
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameDetails.Enabled = blnNewValue
    vsfgEntry.Enabled = blnNewValue
    txtRemark.Enabled = blnNewValue
    fndRefNo.Enabled = Not blnNewValue
End Property

Public Sub ClearValues()
    ClearAllTextBoxes Me
    vsfgEntry.Rows = 1: vsfgEntry.Rows = 50
    dtpReference = ServerDateTime
    optUserAdjust = True
    lblTotDr = "0.00"
    lblTotCr = "0.00"
    lblDiff = "0"
End Sub

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
         ClearValues
         mlngId = 0
         txtRefNo.SetFocus
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
         txtRefNo.SetFocus
         Highlight
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

Private Sub cmbPeriod_Click()
    If PeriodID <> 0 Then PeriodID = GetComboBoundValue(cmbPeriod)
End Sub

Private Sub dtpReference_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
    If KeyCode = vbKeyReturn Then
        vsfgEntry.Row = 1
        vsfgEntry.Col = grdAcName
        vsfgEntry.SetFocus
    End If
End Sub

Private Sub fndRefNo_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
    Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpEntries, "Where EM.IsOpening = 0 And EM.PeriodID = " & mPeriodID, "XEntryID", , fndRefNo)
        If strRslt <> "-1" Then
            mlngId = Val(strRslt)
            txtRefNo.Tag = mlngId
        End If
    Else
        strRslt = lngID
        mlngId = lngID
        txtRefNo.Tag = mlngId
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(mlngId)
        ShowOpen = True
    End Select
End Function

Public Function ValueCollect(ByVal lngID As Long) As Boolean
On Error GoTo Err_Exit
Dim sSql As String, Inc As Integer
    ClearValues
    sSql = "SELECT * FROM Entries WHERE EntryID = " & lngID
    With GetRecords(sSql)
        If .EOF Then
            pMVE.MsgBox "Not a Valid Record!", msgOK, "AuditMate", msgExclamation, True
            ValueCollect = False
            Exit Function
        Else
            optErrorSchedule = IIf(.Fields("IsErrorSchedule") & "" = "True", True, False)
            optUserAdjust = IIf(.Fields("IsErrorSchedule") & "" = "True", False, True)
            txtRefNo = .Fields("RefNo") & ""
            txtRefNo.Tag = Val(.Fields("EntryID") & "")
            dtpReference = .Fields("RefDt") - 2
            txtRemark = .Fields("Remark") & ""
        End If
        sSql = "SELECT *, AcHeads.AcName AS Account FROM EntrySubAccounts ESA INNER JOIN " & _
               "AcHeads ON ESA.AcID = AcHeads.AcID WHERE (ESA.EntryID = " & lngID & ")"
        With GetRecords(sSql)
            While Not .EOF
                Inc = Inc + 1
                vsfgEntry.TextMatrix(Inc, grdSlNo) = ""
                vsfgEntry.TextMatrix(Inc, grdAcName) = .Fields("Account")
                vsfgEntry.TextMatrix(Inc, grdAcID) = .Fields("AcID")
                vsfgEntry.TextMatrix(Inc, grdDrAmt) = IIf(Val(.Fields("DAmt") & "") = 0, "", Val(.Fields("DAmt") & ""))
                vsfgEntry.TextMatrix(Inc, grdCrAmt) = IIf(Val(.Fields("CAmt") & "") = 0, "", Val(.Fields("CAmt") & ""))
                vsfgEntry.TextMatrix(Inc, grdNarration) = .Fields("Narration") & ""
                .MoveNext
            Wend
            .Close
        End With
        .Close
    End With
    PutSlNo vsfgEntry, grdSlNo, grdAcID
    FindTotal
    ValueCollect = True
Exit Function
Err_Exit:
    ValueCollect = False
    ShowError
End Function

Private Sub Form_Load()
    ClearValues
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function Save() As Boolean
On Error GoTo Err_Exit
Dim IsInTran As Boolean, rsSave As ADODB.Recordset
Dim Inc As Long, lngEntryID As Long, sSql As String
    If Val(lblTotDr) <> Val(lblTotCr) Then
        pMVE.MsgBox "Amount Not Tallied.", msgOK, "AuditMate", msgCritical, True
        Save = False
        Exit Function
    End If
    '--------------------------------------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    lngEntryID = SaveEntry(mPeriodID, txtRefNo, DateValue(dtpReference), cnstStatusActive, Trim(txtRemark), False, optErrorSchedule, Val(txtRefNo.Tag))
    If lngEntryID = -1 Then
        Err.Raise vbObjectError + 1, , "Error While Saving Entry."
    End If
    sSql = "DELETE FROM EntrySubAccounts WHERE EntryID = " & lngEntryID
    AdoConn.Execute sSql
    With vsfgEntry
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdAcID) <> 0 Then
               If Not SaveSubEntries(lngEntryID, Inc, .ValueMatrix(Inc, grdAcID), .ValueMatrix(Inc, grdDrAmt), .ValueMatrix(Inc, grdCrAmt), .TextMatrix(Inc, grdNarration)) Then
                  Err.Raise vbObjectError + 1, , "Error While Saving '" & .TextMatrix(Inc, grdAcName) & "'."
               End If
            End If
            If vsfgEntry.ValueMatrix(Inc, grdAcID) <> 0 Then
                ChangeDatasheetStatus mPeriodID, vsfgEntry.ValueMatrix(Inc, grdAcID)
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

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are You Sure To Delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "DELETE FROM EntrySubAccounts  WHERE EntryID = " & Val(txtRefNo.Tag)
    AdoConn.Execute sSql
    sSql = "DELETE FROM Entries WHERE EntryID = " & Val(txtRefNo.Tag)
    AdoConn.Execute sSql
    AdoConn.CommitTrans
    Delete = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Delete = False
End Function

Private Sub vsfgEntry_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    With vsfgEntry
        .TextMatrix(Row, Col) = Format(.TextMatrix(Row, Col), "#0")
    End With
    FindTotal
End Sub

Private Sub vsfgEntry_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Col = grdDrAmt Then
        If vsfgEntry.ValueMatrix(Row, grdCrAmt) <> 0 Then
            Cancel = True
        End If
    ElseIf Col = grdCrAmt Then
        If vsfgEntry.ValueMatrix(Row, grdDrAmt) <> 0 Then
            Cancel = True
        End If
    End If
    If Col <> grdAcName Then
        If vsfgEntry.ValueMatrix(Row, grdAcID) = 0 Then
            Cancel = True
        End If
    End If
    If Col = grdSlNo Then
        Cancel = True
    End If
End Sub

Private Sub vsfgEntry_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
Dim Inc As Integer
    Inc = vsfgEntry.Rows - 1
        PrepareAndFind cnstSearchTypeGrpAccountHeads, "Where AH.StatusID = " & cnstStatusActive & " AND AH.CompanyID = " & mCompanyID, "Name(" & grdAcName & "), XAcID(" & grdAcID & ")", vsfgEntry, , , , 1
        PutSlNo vsfgEntry, grdSlNo, grdAcID
End Sub

Public Sub FindTotal()
On Local Error Resume Next
Dim Inc As Long, dblDr As Double, dblCr As Double, dblDiff As Double
    With vsfgEntry
        For Inc = 1 To .Rows - 1
            dblDr = dblDr + .ValueMatrix(Inc, grdDrAmt)
            dblCr = dblCr + .ValueMatrix(Inc, grdCrAmt)
        Next Inc
    End With
    lblTotDr = Format(dblDr, "#,##0")
    lblTotCr = Format(dblCr, "#,##0")
    lblDiff = Format(Abs(dblDr - dblCr), "#,##0")
    If dblDr - dblCr < 0 Then
        lblDiff.ForeColor = vbRed
        lblDiff = lblDiff & " Cr"
    ElseIf dblDr - dblCr > 0 Then
        lblDiff.ForeColor = vbGreen
        lblDiff = lblDiff & " Dr"
    End If
End Sub

Public Sub ShowSpecifiedJournal(lngEntryID As Long)
On Local Error Resume Next
    ButtonHandling Me, "Open", lngEntryID
End Sub
