VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmReview 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reviews"
   ClientHeight    =   6270
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9135
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6270
   ScaleWidth      =   9135
   StartUpPosition =   2  'CenterScreen
   Begin VSFlex8Ctl.VSFlexGrid vsfgReview 
      Height          =   1710
      Left            =   0
      TabIndex        =   0
      Top             =   4125
      Width           =   9135
      _cx             =   16113
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
      Rows            =   2
      Cols            =   15
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmReview.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   3
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
      WordWrap        =   -1  'True
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
      Left            =   180
      Top             =   5820
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
            Picture         =   "frmReview.frx":01BA
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":0314
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":046E
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":05C8
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":07A2
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":08FC
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":0AD6
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":0C30
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":2132
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":230C
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":24E6
            Key             =   "Help"
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmReview.frx":26C0
            Key             =   "AutoProcess"
         EndProperty
      EndProperty
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgStructure 
      Height          =   975
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   9135
      _cx             =   16113
      _cy             =   1720
      Appearance      =   0
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
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
      GridColor       =   16777215
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   1
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   3
      Cols            =   1
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
      ScrollTrack     =   0   'False
      ScrollBars      =   0
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
      Editable        =   0
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
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   3000
      TabIndex        =   3
      Top             =   5925
      Width           =   6045
      _ExtentX        =   10663
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
   Begin VB.Frame frameData 
      Height          =   2895
      Left            =   0
      TabIndex        =   4
      Top             =   960
      Width           =   9135
      Begin VB.TextBox txtQuestion 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   6
         Top             =   360
         Width           =   8895
      End
      Begin VB.TextBox txtAnswer 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1095
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   5
         Top             =   1680
         Width           =   8895
      End
      Begin VB.Label lblCaption 
         AutoSize        =   -1  'True
         Caption         =   "Question"
         Height          =   195
         Left            =   120
         TabIndex        =   8
         Top             =   120
         Width           =   630
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Answer"
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   1440
         Width           =   525
      End
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Existing Reviews"
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   3900
      Width           =   1200
   End
End
Attribute VB_Name = "frmReview"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean
Dim lngReviewID As Long
Dim mlngSubSectionID As Long, mlngId As Long, mstrIDType As String, mlngSectionID As Long, mstrWhere As String

Const grdReviewSlNo = 0
Const grdReviewQuestion = 1
Const grdReviewAskedBy = 2
Const grdReviewAskedOn = 3
Const grdReviewReply = 4
Const grdReviewRepliedBy = 5
Const grdReviewRepliedOn = 6
Const grdReviewSubSectionID = 7
Const grdReviewPeriodID = 8
Const grdReviewAcTypeID = 9
Const grdReviewAcHeadID = 10
Const grdReviewProcedureID = 11
Const grdReviewReviewID = 12
Const grdReviewReviewUserID = 13
Const grdReviewReplyUserID = 14
Const grdReviewCols = 15

Public Property Get IsNew() As Boolean
    IsNew = mblnNew
End Property

Public Property Let IsNew(ByVal blnNewValue As Boolean)
    If blnNewValue Then
        ClearValues
        txtQuestion = ""
        txtAnswer = ""
        lngReviewID = 0
        txtQuestion.Locked = False
        txtAnswer.Locked = False
        txtQuestion.SetFocus
    Else
         ClearValues
    End If
    mblnNew = blnNewValue
End Property

Public Property Get IsModify() As Boolean
    IsModify = mblnModify
End Property

Public Property Let IsModify(ByVal blnNewValue As Boolean)
Dim lngTmpID As Long
    If blnNewValue Then
        lngTmpID = Val(PickValue("Reviews", "CreateUser", "ReviewID = " & lngReviewID))
        If lngTmpID <> pUserID Then
            txtQuestion.Locked = True
        Else
            txtQuestion.Locked = False
        End If
'        lngTmpID = Val(PickValue("Reviews", "UpdateUser", "ReviewID = " & lngReviewID))
'        If lngTmpID <> pUserID Then
'            txtAnswer.Locked = True
'        Else
'            txtAnswer.Locked = False
'        End If
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
End Property

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

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameData.Enabled = blnNewValue
End Property

Public Property Get DefaultPeriodID() As Long
    DefaultPeriodID = mDefaultPeriodID
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & mPeriodID))
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub ClearValues()
    txtQuestion = ""
    txtAnswer = ""
    lngReviewID = 0
    ShowLinkedReviews
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        Unload Me
    End If
End Sub

Private Sub Form_Load()
    ButtonHandling Me
    With vsfgReview
        .Cols = grdReviewCols

        .ColWidth(grdReviewSlNo) = 400
        .TextMatrix(0, grdReviewSlNo) = "SlNo"

        .ColWidth(grdReviewQuestion) = 2000
        .TextMatrix(0, grdReviewQuestion) = "Question"

        .ColWidth(grdReviewAskedBy) = 1000
        .TextMatrix(0, grdReviewAskedBy) = "Asked By"

        .ColWidth(grdReviewAskedOn) = 1000
        .TextMatrix(0, grdReviewAskedOn) = "Asked on"

        .ColWidth(grdReviewReply) = 2000
        .TextMatrix(0, grdReviewReply) = "Reply"

        .ColWidth(grdReviewRepliedBy) = 1000
        .TextMatrix(0, grdReviewRepliedBy) = "Replied By"

        .ColWidth(grdReviewRepliedOn) = 1000
        .TextMatrix(0, grdReviewRepliedOn) = "Replied on"

        .ColHidden(grdReviewSubSectionID) = True
        .ColHidden(grdReviewPeriodID) = True
        .ColHidden(grdReviewAcTypeID) = True
        .ColHidden(grdReviewAcHeadID) = True
        .ColHidden(grdReviewProcedureID) = True
        .ColHidden(grdReviewReviewID) = True
        .ColHidden(grdReviewReplyUserID) = True
        .ColHidden(grdReviewReviewUserID) = True
    End With
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, IsInTran As Boolean, rsSave As New Recordset, IsNewRec As Boolean
Dim Inc As Long, lngSubSectionID As Long, lngProcedureID As Long, lngAcTypeID As Long
    If Trim(txtQuestion.Text) = "" Then
        pMVE.MsgBox "Question not mentioned", msgOK, "AuditMate", msgInformation, True
        txtQuestion.SetFocus
        Save = False
        Exit Function
    End If
    '---------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Select * From Reviews Where ReviewID = " & lngReviewID 'PeriodID = " & mPeriodID & " AND SubSectionID = " & mlngSubSectionID & mstrWhere
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            '.Fields("ReviewID") = GetMaxNo("Reviews", "ReviewID")
            'Ref No: 067-08/02/09 -------------
            .Fields("ReviewID") = GetRangeMaxNo("Reviews", "ReviewID", mCompanyID * cnstReviewMaxCount, (mCompanyID * cnstReviewMaxCount) + cnstReviewMaxCount)
            IsNewRec = True
        End If
        .Fields("Question") = txtQuestion
        .Fields("Answer") = txtAnswer
        .Fields("SubSectionID") = mlngSubSectionID
        .Fields("PeriodID") = mPeriodID
        .Fields("ProcedureID") = IIf(Trim(UCase(mstrIDType)) = "PROCEDURE", mlngId, Null)
        .Fields("AcTypeID") = IIf(Trim(UCase(mstrIDType)) = "ACCOUNTTYPE", mlngId, Null)
        .Fields("AcID") = IIf(Trim(UCase(mstrIDType)) = "ACCOUNTHEAD", mlngId, Null)
        If IsNewRec Then
            .Fields("CreateUser") = pUserID
            .Fields("CreateDate") = ServerDateTime
        End If
        'If Val(.Fields("UpdateUser") & "") = 0 Or Val(.Fields("UpdateUser") & "") = pUserID Then
            .Fields("UpdateUser") = pUserID
            .Fields("UpdateDate") = ServerDateTime
        'End If
        .Update
        .Close
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
        ShowError
    End If
    Save = False
End Function

Public Sub ShowRelatedReviews(lngSubSectionID As Long, lngPeriodID As Long, Optional IDType As String = "Nil", Optional lngID As Long = -1)
On Local Error GoTo Err_Exit
Dim sSql As String, rsTmp As New Recordset, Inc As Long, strWhere As String
Dim strParticulars As String, strSection As String, strSubSection As String
    PeriodID = lngPeriodID
    mlngSubSectionID = lngSubSectionID
    strSubSection = "SUB SECTION : " & PickValue("FilingSubSection", "Description", "SubSectionID = " & mlngSubSectionID)
    mlngSectionID = Val(PickValue("FilingSubSection", "SectionID", "SubSectionID = " & mlngSubSectionID))
    strSection = "SECTION : " & PickValue("FilingSections", "Description", "SectionID = " & mlngSectionID)
    mlngId = lngID
    mstrIDType = IDType

    Select Case Trim(UCase(IDType))
        Case "ACCOUNTTYPE"
            strParticulars = "Account Type : " & PickValue("AcTypes", "AcTypeDescription", "AcTypeID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = " & mlngId & " AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0 "
        Case "ACCOUNTHEAD"
            strParticulars = "Account Head : " & PickValue("AcHeads", "AcName", "AcID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = " & mlngId & " AND ISNULL(ProcedureID, 0) = 0 "
        Case "PROCEDURE"
            strParticulars = "Procedure : " & PickValue("ProcedureQuestions", "Question", "QuestionID = " & lngID)
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = " & mlngId & " "
        Case Else
            strParticulars = "" ' "PARTICULARS : Nil"
            mstrWhere = " AND ISNULL(AcTypeID, 0) = 0 AND ISNULL(AcID, 0) = 0 AND ISNULL(ProcedureID, 0) = 0 "
    End Select

    With vsfgStructure
        .OutlineBar = flexOutlineBarCompleteLeaf
        .OutlineCol = 0

        .TextMatrix(0, 0) = strSection
        .Cell(flexcpFontSize, 0, 0) = 14
        .Cell(flexcpForeColor, 0, 0) = RGB(50, 50, 250)
        .RowHeight(0) = 360
        .IsSubtotal(0) = True
        .RowOutlineLevel(0) = 0
        .IsCollapsed(0) = flexOutlineExpanded

        .TextMatrix(1, 0) = strSubSection
        .Cell(flexcpFontSize, 1, 0) = 12
        .Cell(flexcpForeColor, 1, 0) = RGB(100, 100, 250)
        .RowHeight(1) = 320
        .IsSubtotal(1) = True
        .RowOutlineLevel(1) = 1
        .IsCollapsed(1) = flexOutlineExpanded

        .TextMatrix(2, 0) = strParticulars
        .Cell(flexcpFontSize, 2, 0) = 10
        .Cell(flexcpForeColor, 2, 0) = RGB(125, 125, 250)
        .RowHeight(2) = 280
        .IsSubtotal(2) = True
        .RowOutlineLevel(2) = 2
        .IsCollapsed(2) = flexOutlineExpanded
    End With
    '----------------------------------------------------------------------
    ShowLinkedReviews
    Show vbModal
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgReview_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error GoTo Err_Exit
    With vsfgReview
        vsfgReview.AutoSizeMode = flexAutoSizeRowHeight
        vsfgReview.AutoSize Col
    End With
Exit Sub
Err_Exit:
    
End Sub

Public Sub ShowLinkedReviews()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, FileExt As String, strWhere As String, strDetail As String
    sSql = "SELECT  RW.Question, RW.Answer, ReviewUser.UserName AS ReviewUser, ReplyUser.UserName AS ReplyUser, RW.CreateDate AS ReviewDate, RW.UpdateDate AS ReplyDate, RW.ReviewID, RW.AcTypeID, RW.AcID, RW.ProcedureID, RW.PeriodID, RW.SubSectionID, " & _
           "        ReviewUser.UserID AS ReviewUserID, ReplyUser.UserID AS ReplyUserID FROM Reviews RW INNER JOIN Users ReviewUser ON RW.CreateUser = ReviewUser.UserID LEFT OUTER JOIN Users ReplyUser ON RW.UpdateUser = ReplyUser.UserID " & _
           "Where   RW.PeriodID = " & mPeriodID & " AND RW.SubSectionID = " & mlngSubSectionID & " "
    sSql = sSql & mstrWhere

    vsfgReview.Rows = 1
    With GetRecords(sSql)
        While Not .EOF
            vsfgReview.Rows = vsfgReview.Rows + 1
            Inc = vsfgReview.Rows - 1
            vsfgReview.TextMatrix(Inc, grdReviewSlNo) = Inc
            vsfgReview.TextMatrix(Inc, grdReviewQuestion) = .Fields("Question") & ""
            vsfgReview.TextMatrix(Inc, grdReviewAskedBy) = StrConv(.Fields("ReviewUser") & "", vbProperCase)
            vsfgReview.TextMatrix(Inc, grdReviewAskedOn) = .Fields("ReviewDate") & ""

            If Trim(.Fields("Answer") & "") <> "" Then
                vsfgReview.TextMatrix(Inc, grdReviewReply) = .Fields("Answer") & ""
                vsfgReview.TextMatrix(Inc, grdReviewRepliedBy) = StrConv(.Fields("ReplyUser") & "", vbProperCase)
                vsfgReview.TextMatrix(Inc, grdReviewRepliedOn) = .Fields("ReplyDate") & ""
            Else
                vsfgReview.TextMatrix(Inc, grdReviewReply) = "Not Replied"
            End If

            vsfgReview.TextMatrix(Inc, grdReviewSubSectionID) = Val(.Fields("SubSectionID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewPeriodID) = Val(.Fields("PeriodID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewAcTypeID) = Val(.Fields("AcTypeID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewAcHeadID) = Val(.Fields("AcID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewProcedureID) = Val(.Fields("ProcedureID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewReviewID) = Val(.Fields("ReviewID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewReviewUserID) = Val(.Fields("ReviewUserID") & "")
            vsfgReview.TextMatrix(Inc, grdReviewReplyUserID) = Val(.Fields("ReplyUserID") & "")
            .MoveNext
        Wend
        .Close
    End With
    If vsfgReview.Rows > 1 Then vsfgReview.Row = 1
    ValueCollect
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub vsfgReview_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Cancel = True
End Sub

Private Sub vsfgReview_RowColChange()
    SelectRow vsfgReview, , , RGB(220, 220, 255)
    ValueCollect
End Sub

Public Sub ValueCollect()
On Local Error GoTo Err_Exit
Dim sSql As String, lngGroupID As Long
    lngGroupID = Val(PickValue("UserGroupUsers", "UserGroupID", "UserID = " & pUserID))
    If IsNew Or IsModify Then Exit Sub
    With vsfgReview
        If .Row > 0 Then
            txtQuestion = .TextMatrix(.Row, grdReviewQuestion)
            If UCase(Trim(.TextMatrix(.Row, grdReviewReply))) = "NOT REPLIED" Then
                txtAnswer = ""
            Else
                txtAnswer = .TextMatrix(.Row, grdReviewReply)
            End If

            lngReviewID = .ValueMatrix(.Row, grdReviewReviewID)

            tbrCtrls.Buttons("Modify").Enabled = True
            tbrCtrls.Buttons("Delete").Enabled = True
        Else
            txtQuestion = ""
            txtAnswer = ""
        End If
    End With
    If lngGroupID > 2 Then
        tbrCtrls.Buttons("Delete").Enabled = False
    End If
    tbrCtrls.Buttons("Close").Enabled = True
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function Delete() As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Delete from Reviews Where ReviewID = " & lngReviewID
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
