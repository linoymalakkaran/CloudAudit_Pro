VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmRelatedReviews 
   Caption         =   "Reviews"
   ClientHeight    =   9840
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   12765
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9840
   ScaleWidth      =   12765
   WindowState     =   2  'Maximized
   Begin VB.TextBox txtReply 
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
      Height          =   990
      Left            =   45
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   8505
      Width           =   12690
   End
   Begin VB.TextBox txtReview 
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
      Height          =   990
      Left            =   45
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   7110
      Width           =   12690
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgRelatedReviews 
      Height          =   6540
      Left            =   45
      TabIndex        =   0
      Top             =   240
      Width           =   12690
      _cx             =   22384
      _cy             =   11536
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
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   1
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   1
      Cols            =   1
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   320
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   ""
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
   Begin VB.Label lblReply 
      AutoSize        =   -1  'True
      Caption         =   "Reply"
      Height          =   195
      Left            =   75
      TabIndex        =   3
      Top             =   8250
      Width           =   405
   End
   Begin VB.Label lblReview 
      AutoSize        =   -1  'True
      Caption         =   "Review"
      Height          =   195
      Left            =   75
      TabIndex        =   1
      Top             =   6870
      Width           =   540
   End
End
Attribute VB_Name = "frmRelatedReviews"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdReviewSlNo = 0
Const grdReviewSubSection = 1
Const grdReviewParticulars = 2
Const grdReviewReviews = 3
Const grdReviewReviewedBy = 4
Const grdReviewReviewedOn = 5
Const grdReviewReply = 6
Const grdReviewReplyBy = 7
Const grdReviewReplyOn = 8
Const grdReviewRevID = 9
Const grdReviewSubSectionID = 10
Const grdReviewAcTypeID = 11
Const grdReviewAcID = 12
Const grdReviewProcedureID = 13
Const grdReviewSignedOff = 14
Const grdReviewCols = 15

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

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mCompanyID = Val(PickValue("Periods", "CompanyID", "PeriodID = " & vNewValue))
    ShowReviews
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Sub ShowReviewLinks(lngLinkID As Long)
On Local Error GoTo Err_Exit
Dim strType As String, lngID As Long, sSql As String
    sSql = "Select * from Reviews Where ReviewID = " & lngLinkID
    With GetRecords(sSql)
        If Not .EOF Then
            If Val(.Fields("AcTypeID") & "") <> 0 Then
                lngID = Val(.Fields("AcTypeID") & "")
                strType = "ACCOUNTTYPE"
            ElseIf Val(.Fields("AcID") & "") <> 0 Then
                lngID = Val(.Fields("AcID") & "")
                strType = "ACCOUNTHEAD"
            ElseIf Val(.Fields("ProcedureID") & "") <> 0 Then
                lngID = Val(.Fields("ProcedureID") & "")
                strType = "PROCEDURE"
            End If
            
            ShowRelatedReviews Val(.Fields("SubSectionID") & ""), Val(.Fields("PeriodID") & ""), strType, lngID
        End If
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub ShowReviews()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strParticulars As String
    sSql = "SELECT REV.ReviewID, FSS.Description AS SubSection, (SELECT AcTypeDescription FROM AcTypes AT WHERE AT.AcTypeID = REV.AcTypeID) AS AcTypeDescription, " & _
           "(SELECT AcName FROM AcHeads AH WHERE AH.AcID = REV.AcID AND CompanyID = " & mCompanyID & ") AS AcName, (SELECT PQ.Question FROM ProcedureQuestions PQ WHERE PQ.QuestionID = REV.ProcedureID) AS ProcedureName, REV.Question, REV.Answer, REV.CreateDate, REV.UpdateDate,  " & _
           "REV.SubSectionID, REV.PeriodID, REV.ProcedureID, REV.AcTypeID, REV.AcID, REV.SignedOff, ReviewUser.UserName AS ReviewUser, ReplyUser.UserName AS ReplyUser " & _
           "FROM Reviews REV INNER JOIN FilingSubSection FSS ON REV.SubSectionID = FSS.SubSectionID INNER JOIN Users ReviewUser ON REV.CreateUser = ReviewUser.UserID LEFT OUTER JOIN " & _
           "Users ReplyUser ON REV.UpdateUser = ReplyUser.UserID Where (REV.PeriodID = " & mPeriodID & ") ORDER BY REV.ReviewID"
    vsfgRelatedReviews.Rows = 1
    With GetRecords(sSql)
        While Not .EOF
            vsfgRelatedReviews.Rows = vsfgRelatedReviews.Rows + 1
            Inc = vsfgRelatedReviews.Rows - 1
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewReviews) = .Fields("Question") & ""
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewSubSection) = .Fields("SubSection") & ""
            
            If .Fields("AcTypeDescription") & "" <> "" Then
                strParticulars = "Account Type : " & .Fields("AcTypeDescription") & ""
            ElseIf .Fields("AcName") & "" <> "" Then
                strParticulars = "Account Head : " & .Fields("AcName") & ""
            ElseIf .Fields("ProcedureName") & "" <> "" Then
                strParticulars = "Procedures : " & .Fields("ProcedureName") & ""
            End If
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewSlNo) = Inc
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewParticulars) = strParticulars
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewReviews) = .Fields("Question") & ""
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewReviewedBy) = StrConv(.Fields("ReviewUser") & "", vbProperCase)
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewReviewedOn) = DateValue(.Fields("CreateDate") & "")
            
            If Trim(.Fields("Answer") & "") <> "" Then
                vsfgRelatedReviews.TextMatrix(Inc, grdReviewReply) = .Fields("Answer") & ""
                vsfgRelatedReviews.TextMatrix(Inc, grdReviewReplyBy) = StrConv(.Fields("ReplyUser") & "", vbProperCase)
                vsfgRelatedReviews.TextMatrix(Inc, grdReviewReplyOn) = DateValue(.Fields("UpdateDate") & "")
                vsfgRelatedReviews.Cell(flexcpForeColor, Inc, grdReviewReply) = RGB(50, 50, 50)
            Else
                vsfgRelatedReviews.TextMatrix(Inc, grdReviewReply) = "Not Replied"
                vsfgRelatedReviews.Cell(flexcpForeColor, Inc, grdReviewReply) = RGB(255, 180, 0)
            End If
            
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewSignedOff) = IIf(.Fields("SignedOff") & "" = "True", 1, 0)
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewSubSectionID) = Val(.Fields("SubSectionID") & "")
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewAcTypeID) = Val(.Fields("AcTypeID") & "")
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewAcID) = Val(.Fields("AcID") & "")
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewProcedureID) = Val(.Fields("ProcedureID") & "")
            vsfgRelatedReviews.TextMatrix(Inc, grdReviewRevID) = Val(.Fields("ReviewID") & "")
            .MoveNext
        Wend
        If vsfgRelatedReviews.Rows > 1 Then
            vsfgRelatedReviews.Cell(flexcpForeColor, 1, grdReviewReviews, vsfgRelatedReviews.Rows - 1, grdReviewReviews) = RGB(100, 100, 255)
            vsfgRelatedReviews.Cell(flexcpFontBold, 1, grdReviewReviews, vsfgRelatedReviews.Rows - 1, grdReviewReviews) = True
            
            vsfgRelatedReviews.Cell(flexcpForeColor, 1, grdReviewParticulars, vsfgRelatedReviews.Rows - 1, grdReviewParticulars) = RGB(255, 100, 100)
            vsfgRelatedReviews.Cell(flexcpFontBold, 1, grdReviewParticulars, vsfgRelatedReviews.Rows - 1, grdReviewParticulars) = True
            
            vsfgRelatedReviews.Cell(flexcpFontBold, 1, grdReviewReply, vsfgRelatedReviews.Rows - 1, grdReviewReply) = True
        End If
        .Close
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Private Sub Form_Load()
    With vsfgRelatedReviews
        .Top = 60
        .Width = GetProportionalValue(15400, False)
        .Height = GetProportionalValue(7800)

        .Cols = grdReviewCols

        .ColWidth(grdReviewSlNo) = 400
        .ColWidth(grdReviewSubSection) = 1800
        .ColWidth(grdReviewParticulars) = 2000
        .ColWidth(grdReviewReviews) = 2800
        .ColWidth(grdReviewReviewedBy) = 1100
        .ColWidth(grdReviewReviewedOn) = 1100
        .ColWidth(grdReviewReply) = 2800
        .ColWidth(grdReviewReplyBy) = 1000
        .ColWidth(grdReviewReplyOn) = 1000
        .ColWidth(grdReviewSignedOff) = 1000
        

        .ColHidden(grdReviewRevID) = True
        .ColHidden(grdReviewAcTypeID) = True
        .ColHidden(grdReviewAcID) = True
        .ColHidden(grdReviewProcedureID) = True
        .ColHidden(grdReviewSubSectionID) = True
        
        .ColDataType(grdReviewSignedOff) = flexDTBoolean

        .TextMatrix(0, grdReviewSlNo) = "#"
        .TextMatrix(0, grdReviewSubSection) = "Sub Section"
        .TextMatrix(0, grdReviewParticulars) = "Particulars"
        .TextMatrix(0, grdReviewReviews) = "Reviews"
        .TextMatrix(0, grdReviewReviewedBy) = "Reviewed By"
        .TextMatrix(0, grdReviewReviewedOn) = "Reviewed On"
        .TextMatrix(0, grdReviewReply) = "Review Reply"
        .TextMatrix(0, grdReviewReplyBy) = "Replied By"
        .TextMatrix(0, grdReviewReplyOn) = "Replied On"
        .TextMatrix(0, grdReviewSignedOff) = "Signed Off"
    End With

    lblReview.Top = GetProportionalValue(8000)
    With txtReview
        .Top = GetProportionalValue(8200)
        .Height = GetProportionalValue(800)
        .Width = vsfgRelatedReviews.Width
        .Left = vsfgRelatedReviews.Left
    End With

    lblReply.Top = GetProportionalValue(9000)
    With txtReply
        .Top = GetProportionalValue(9200)
        .Height = GetProportionalValue(1000)
        .Width = vsfgRelatedReviews.Width
        .Left = vsfgRelatedReviews.Left
    End With
End Sub

Private Sub Form_Resize()
    WindowState = vbMaximized
End Sub

Private Sub vsfgRelatedReviews_AfterEdit(ByVal Row As Long, ByVal Col As Long)
        Select Case Col
        Case grdReviewSignedOff
            Save Row, vsfgRelatedReviews.TextMatrix(Row, grdReviewRevID)
        Case Else
        
    End Select
End Sub

Private Sub vsfgRelatedReviews_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
Dim lngUserID As Long, lngUserGroupID As Long
Dim sSql As String
    lngUserID = pUserID
    Select Case Col
        Case grdReviewSignedOff
'            sSql = "Select UserName from Users Where UserID = " & lngUserID
'            With GetRecords(sSql)
'                If Not .EOF Then
'                    If .Fields("UserName") & "" <> vsfgRelatedReviews.TextMatrix(vsfgRelatedReviews.Row, grdReviewReviewedBy) Then
'                        pMVE.MsgBox "You are not privileged to sign off this review.", msgOK, , msgInformation, True
'                        Cancel = True
'                    Else
'                        Cancel = False
'                    End If
'                End If
'            End With
        Case Else
            Cancel = True
    End Select
End Sub

Private Sub vsfgRelatedReviews_Click()
    With vsfgRelatedReviews
        txtReview = .TextMatrix(.Row, grdReviewReviews)
        If UCase(Trim(.TextMatrix(.Row, grdReviewReply))) = "NOT REPLIED" Then
            txtReply = ""
        Else
            txtReply = .TextMatrix(.Row, grdReviewReply)
        End If
    End With
End Sub

Private Sub vsfgRelatedReviews_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgRelatedReviews.ToolTipText = vsfgRelatedReviews.Text
End Sub

Private Sub vsfgRelatedReviews_RowColChange()
    SelectRow vsfgRelatedReviews, , , RGB(220, 220, 250)
    vsfgRelatedReviews_Click
End Sub

Private Sub vsfgRelatedReviews_DblClick()
On Local Error GoTo Err_Exit
Dim strIDType As String, lngID As Long
    With vsfgRelatedReviews
        If .Row > 0 Then
            ShowReviewLinks vsfgRelatedReviews.ValueMatrix(.Row, grdReviewRevID)
            ShowReviews
        End If
    End With
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Sub Save(Inc As Long, lngID As Long)
On Local Error GoTo Err_Exit
Dim sSql As String, lngSignedOff As Long
    lngSignedOff = vsfgRelatedReviews.ValueMatrix(Inc, grdReviewSignedOff) & ""
    sSql = "UPDATE Reviews SET SignedOff = " & lngSignedOff & " Where ReviewID = " & lngID
    AdoConn.Execute sSql
    sSql = "UPDATE Reviews SET SignedBy = " & "'" & pUserName & "'" & " Where ReviewID = " & lngID
    AdoConn.Execute sSql
Exit Sub
Err_Exit:
    ShowError
End Sub
