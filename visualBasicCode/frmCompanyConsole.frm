VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmCompanyConsole 
   Caption         =   "Details of Companies"
   ClientHeight    =   9300
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   16305
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   9300
   ScaleWidth      =   16305
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgCompany 
      Height          =   9255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   15615
      _cx             =   27543
      _cy             =   16325
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9
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
      AllowBigSelection=   0   'False
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   2
      Cols            =   10
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmCompanyConsole.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   1
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
End
Attribute VB_Name = "frmCompanyConsole"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdCompanyInfo = 0
Const grdPartner = 1
Const grdManager = 2
Const grdAuditor1 = 3
Const grdAuditor2 = 4
Const grdAuditAssistant = 5
Const grdStatus = 6
Const grdCompanyID = 7
Const grdPeriodID = 8
Const grdUserID = 9
Const grdCols = 10

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = mPeriodID)
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
    sSql = "SELECT DetachedBy FROM Companies WHERE CompanyID = " & pActiveCompanyID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("DetachedBy") <> "" Then
                    IsReadOnly = True
                End If
                .MoveNext
            Wend
            .Close
        End With
End Property

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Function FormatGrid()
On Local Error Resume Next
    With vsfgCompany
        .ColWidth(grdCompanyInfo) = 5000
        .ColWidth(grdPartner) = 2000
        .ColWidth(grdManager) = 2000
        .ColWidth(grdAuditor1) = 2000
        .ColWidth(grdAuditor2) = 1800
        .ColWidth(grdAuditAssistant) = 1800
        .ColWidth(grdStatus) = 1500
        
        .ColHidden(grdCompanyID) = True
        .ColHidden(grdPeriodID) = True
        .ColHidden(grdUserID) = True
        .Cell(flexcpFontBold, 0, grdCompanyInfo, 0, grdPeriodID) = True
        
    End With

End Function

Public Function ShowData()
On Local Error Resume Next
Dim sSql As String, Inc As Long
Dim sSql1 As String, strUserIDs As Long, arrUserIDs() As String
Dim rsTmp As New ADODB.Recordset
    Inc = 0
    Screen.MousePointer = vbHourglass
    sSql = "SELECT   CMP.CompanyName, PER.ShortName, AuditType.AuditTypeName AS AuditType, CONVERT(VARCHAR, CONVERT(DATETIME, PER.StartDt - 2, 103), 103) " & _
           "         + ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, PER.EndDt - 2, 103), 103) AS Period, CMP.CompanyID, PER.PeriodID " & _
           "FROM     AuditType INNER JOIN Periods PER ON AuditType.AuditTypeID = PER.AuditTypeID RIGHT OUTER JOIN Companies CMP ON PER.CompanyID = CMP.CompanyID " & _
           "Where   (ISNULL(PER.StatusID, CMP.StatusID) = " & cnstStatusActive & ") ORDER BY CMP.CompanyName, PER.StartDt"
        With GetRecords(sSql)
            While Not .EOF
                Inc = Inc + 1
                vsfgCompany.Rows = vsfgCompany.Rows + 1
                vsfgCompany.TextMatrix(Inc, grdCompanyInfo) = .Fields("CompanyName") & "" & "-" & .Fields("ShortName") & ""
                vsfgCompany.TextMatrix(Inc, grdCompanyID) = .Fields("CompanyID") & ""
                vsfgCompany.TextMatrix(Inc, grdPeriodID) = .Fields("PeriodID") & ""
                
'                sSql1 = "SELECT   DISTINCT Users.UserName, UserPrivilegesSub.UserID, UserPrivilegesSub.PeriodID, UserGroupUsers.UserGroupID " & _
'                        "FROM     UserPrivilegesSub INNER JOIN  Users ON UserPrivilegesSub.UserID = Users.UserID INNER JOIN UserGroupUsers ON Users.UserID = UserGroupUsers.UserID " & _
'                        "Where    UserPrivilegesSub.PeriodID = " & vsfgCompany.ValueMatrix(Inc, grdPeriodID) & " ORDER BY UserGroupUsers.UserGroupID "
                sSql1 = "SELECT    Users.UserName, UserGroups.UserGroupName, UserPrivileges.PeriodID, UserGroups.UserGroupID " & _
                        "FROM      Users INNER JOIN UserGroupUsers ON Users.UserID = UserGroupUsers.UserID INNER JOIN UserGroups " & _
                        "          ON UserGroupUsers.UserGroupID = UserGroups.UserGroupID INNER JOIN UserPrivileges ON Users.UserID = UserPrivileges.UserID " & _
                        "Where     UserPrivileges.PeriodID = " & vsfgCompany.ValueMatrix(Inc, grdPeriodID) & " ORDER BY UserGroups.OrderField"
                Set rsTmp = GetRecords(sSql1)
                    With rsTmp
                        While Not .EOF
                            strUserIDs = .Fields("UserID") & ""
                            If Trim(strUserIDs) = "-1" Then strUserIDs = "0"
                            strUserIDs = Replace(strUserIDs, "|", ",")
                            arrUserIDs = Split(strUserIDs, ",")
    
                            If .Fields("UserGroupID") = "1" Then
                                vsfgCompany.TextMatrix(Inc, grdPartner) = .Fields("UserName") & ""
                            End If
                            If .Fields("UserGroupID") = "2" Then
                                vsfgCompany.TextMatrix(Inc, grdManager) = .Fields("UserName") & ""
                            End If
                            If .Fields("UserGroupID") = "3" Then
                                vsfgCompany.TextMatrix(Inc, grdAuditor1) = .Fields("UserName") & ""
                            End If
                            If .Fields("UserGroupID") = "4" Then
                                vsfgCompany.TextMatrix(Inc, grdAuditAssistant) = .Fields("UserName") & ""
                            End If
                            .MoveNext
                        Wend
                    End With
                vsfgCompany.TextMatrix(Inc, grdStatus) = "Active"
                .MoveNext
            Wend
        End With
    Screen.MousePointer = vbDefault
End Function

Private Sub Form_Load()
    FormatGrid
    ShowData
End Sub
