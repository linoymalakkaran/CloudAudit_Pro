VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmPrivilegeSettings 
   Caption         =   "User Previleges"
   ClientHeight    =   10755
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   14580
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   10755
   ScaleWidth      =   14580
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgUsers 
      Height          =   9255
      Left            =   45
      TabIndex        =   0
      Top             =   45
      Width           =   14535
      _cx             =   25638
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
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
      Cols            =   10
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmPrivilegeSettings.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   3
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
End
Attribute VB_Name = "frmPrivilegeSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long, mDefaultPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdCompany = 0
Const grdPeriod = 1
Const grdManager = 2
Const grdAuditor = 3
Const grdAuditAssistant = 4
Const grdCompanyID = 5
Const grdPeriodID = 6
Const grdUserManagerID = 7
Const grdUserAuditorID = 8
Const grdUserAssistantID = 9
Const grdCols = 10

Private Sub Form_Activate()
Dim sSql As String
    sSql = "Select * From UserGroupUsers Where UserID = " & pUserID
        With GetRecords(sSql)
            While Not .EOF
                If .Fields("UserGroupID") & "" = "1" Or .Fields("UserGroupID") & "" = "2" Then
                    vsfgUsers.Enabled = True
                Else
                    vsfgUsers.Enabled = False
                End If
                .MoveNext
            Wend
            .Close
        End With
End Sub

Private Sub Form_Load()
    FormatGrid
    SelectPeriods
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Public Function SelectPeriods()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
Dim strCompanyName As String
Dim sSql1 As String, rsTmp As New ADODB.Recordset
'    mstrSelectedPeriods = strSelectedPeriods
'    IsCanceled = False
    '-------------------------------------
    sSql = "SELECT CMP.CompanyName, PER.ShortName, AuditType.AuditTypeName AS AuditType, CONVERT(VARCHAR, CONVERT(DATETIME, PER.StartDt - 2, 103), 103) " & _
           "+ ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, PER.EndDt - 2, 103), 103) AS Period, CMP.CompanyID, PER.PeriodID " & _
           "FROM AuditType INNER JOIN Periods PER ON AuditType.AuditTypeID = PER.AuditTypeID RIGHT OUTER JOIN Companies CMP ON PER.CompanyID = CMP.CompanyID " & _
           "Where (ISNULL(PER.StatusID, CMP.StatusID) = " & cnstStatusActive & ") ORDER BY CMP.CompanyName, PER.StartDt"
    vsfgUsers.Rows = 1
    vsfgUsers.OutlineCol = grdCompany
    vsfgUsers.OutlineBar = flexOutlineBarCompleteLeaf
    Set rsTmp = GetRecords(sSql)
        With rsTmp
            If .EOF Then
                pMVE.MsgBox "No Privileged Period Available.", msgOK, "AuditMate", msgExclamation, True
                SelectPeriods = ""
                Exit Function
            Else
                While Not .EOF
                    vsfgUsers.Rows = vsfgUsers.Rows + 1
                    Inc = vsfgUsers.Rows - 1
                    vsfgUsers.IsSubtotal(Inc) = True
                    If strCompanyName <> .Fields("CompanyName") & "" Or strCompanyName = "" Then
                        vsfgUsers.RowOutlineLevel(Inc) = 1
                    Else
                        vsfgUsers.RowOutlineLevel(Inc) = 2
                    End If
                    strCompanyName = .Fields("CompanyName") & ""
                    vsfgUsers.TextMatrix(Inc, grdCompany) = strCompanyName
                    vsfgUsers.TextMatrix(Inc, grdPeriod) = .Fields("ShortName") & ""
                    vsfgUsers.TextMatrix(Inc, grdCompanyID) = .Fields("CompanyID") & ""
                    vsfgUsers.TextMatrix(Inc, grdPeriodID) = .Fields("PeriodID") & ""
                    sSql1 = "SELECT   UserPrivileges.PeriodID, UserPrivileges.UserID, UserPrivileges.IsBlocked, UserGroupUsers.UserGroupID, UserGroups.UserGroupName, Users.UserName " & _
                            "FROM     UserPrivileges INNER JOIN UserGroupUsers ON UserPrivileges.UserID = UserGroupUsers.UserID INNER JOIN " & _
                            "         UserGroups ON UserGroupUsers.UserGroupID = UserGroups.UserGroupID INNER JOIN Users ON UserPrivileges.UserID = Users.UserID AND UserGroupUsers.UserID = Users.UserID " & _
                            "Where    UserPrivileges.PeriodID = " & rsTmp.Fields("PeriodID") & ""
                    With GetRecords(sSql1)
                        While Not .EOF
                            If .Fields("UserGroupID") & "" = 2 Then
                                vsfgUsers.TextMatrix(Inc, grdManager) = .Fields("UserName") & ""
                                vsfgUsers.TextMatrix(Inc, grdUserManagerID) = .Fields("UserID") & ""
                            ElseIf .Fields("UserGroupID") & "" = 3 Then
                                vsfgUsers.TextMatrix(Inc, grdAuditor) = .Fields("UserName") & ""
                                vsfgUsers.TextMatrix(Inc, grdUserAuditorID) = .Fields("UserID") & ""
                            ElseIf .Fields("UserGroupID") & "" = 4 Then
                                vsfgUsers.TextMatrix(Inc, grdAuditAssistant) = .Fields("UserName") & ""
                                vsfgUsers.TextMatrix(Inc, grdUserAssistantID) = .Fields("UserID")
                            Else
                                
                            End If
                            .MoveNext
                        Wend
                    End With
                    .MoveNext
                Wend
                For Inc = 1 To vsfgUsers.Rows - 1
                    vsfgUsers.IsCollapsed(Inc) = flexOutlineCollapsed
                Next Inc
                vsfgUsers.Row = 1
                vsfgUsers.MergeCells = flexMergeFree
                vsfgUsers.MergeCol(grdCompany) = True
                vsfgUsers_RowColChange
                Show
    '            While Visible
    '                DoEvents
    '            Wend
            End If
            .Close
        End With
Exit Function
Err_Exit:
    SelectPeriods = ""
End Function

Private Sub vsfgUsers_AfterEdit(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
Dim Inc As Long, sSql As String
    If Row > 0 Then
        Select Case Col
            Case grdManager
                sSql = "Update UserPrivileges Set UserID = " & vsfgUsers.TextMatrix(Row, grdUserManagerID) & " Where PeriodID = " & vsfgUsers.TextMatrix(Row, grdPeriodID)
            Case grdAuditor
                sSql = "Update UserPrivileges Set UserID = " & vsfgUsers.TextMatrix(Row, grdUserAuditorID) & " Where PeriodID = " & vsfgUsers.TextMatrix(Row, grdPeriodID)
            Case grdAuditAssistant
                sSql = "Update UserPrivileges Set UserID = " & vsfgUsers.TextMatrix(Row, grdUserAssistantID) & " Where PeriodID = " & vsfgUsers.TextMatrix(Row, grdPeriodID)
            Case Else
        End Select
    End If
End Sub

Private Sub vsfgUsers_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
On Local Error Resume Next
    If Row > 0 Then
        Select Case Col
            Case grdCompany
                Cancel = True
            Case grdPeriod
                Cancel = True
            Case Else
                
        End Select
    End If
End Sub

Private Sub vsfgUsers_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
On Local Error Resume Next
Dim strUserIDs As String, strUsers As String
Dim sSql As String
    If Row > 0 Then
        Select Case Col
            Case grdManager
                strUserIDs = PrepareAndFind(cnstSearchTypeGrpUserName, "Where UserID IN(Select UserID From UserGroupUsers Where UserGroupID = 2) AND StatusID = " & cnstStatusActive, , , , , , , True, "XUserID")
                strUsers = FillUsers(strUserIDs)
                vsfgUsers.TextMatrix(Row, Col) = strUsers
                sSql = "Insert Into  UserPrivileges Values(" & vsfgUsers.TextMatrix(Row, grdPeriodID) & ", " & vsfgUsers.TextMatrix(Row, grdUserManagerID) & ", 0) "
                AdoConn.Execute sSql
            Case grdAuditor
                strUserIDs = PrepareAndFind(cnstSearchTypeGrpUserName, "Where UserID IN(Select UserID From UserGroupUsers Where UserGroupID = 3) AND StatusID = " & cnstStatusActive, , , , , , , True, "XUserID")
                strUsers = FillUsers(strUserIDs)
                vsfgUsers.TextMatrix(Row, Col) = strUsers
                sSql = "Insert Into  UserPrivileges Values(" & vsfgUsers.TextMatrix(Row, grdPeriodID) & ", " & vsfgUsers.TextMatrix(Row, grdUserAuditorID) & ", 0) "
                AdoConn.Execute sSql
            Case grdAuditAssistant
                strUserIDs = PrepareAndFind(cnstSearchTypeGrpUserName, "Where UserID IN(Select UserID From UserGroupUsers Where UserGroupID = 4) AND StatusID = " & cnstStatusActive, , , , , , , True, "XUserID")
                strUsers = FillUsers(strUserIDs)
                vsfgUsers.TextMatrix(Row, Col) = strUsers
                sSql = "Insert Into  UserPrivileges Values(" & vsfgUsers.TextMatrix(Row, grdPeriodID) & ", " & vsfgUsers.TextMatrix(Row, grdUserAssistantID) & ", 0) "
                AdoConn.Execute sSql
            Case Else
            
        End Select
    End If
End Sub

Private Sub vsfgUsers_RowColChange()
    SelectRow vsfgUsers
End Sub

Public Function FormatGrid()
On Local Error Resume Next
    With vsfgUsers
        .ColWidth(grdCompany) = 5000
        .ColWidth(grdPeriod) = 2500
        .ColWidth(grdManager) = 2000
        .ColWidth(grdAuditor) = 2000
        .ColWidth(grdAuditAssistant) = 2000

        .ColHidden(grdCompanyID) = True
        .ColHidden(grdPeriodID) = True
        .ColHidden(grdUserManagerID) = True
        .ColHidden(grdUserAuditorID) = True
        .ColHidden(grdUserAssistantID) = True

        .ColComboList(grdManager) = "..."
        .ColComboList(grdAuditor) = "..."
        .ColComboList(grdAuditAssistant) = "..."

        .ExtendLastCol = True

        .RowHeightMin = 330

        .Cell(flexcpFontBold, 0, grdCompany, 0, grdAuditAssistant) = True
    End With
End Function

Public Function GetUserList() As String
On Local Error GoTo Err_Exit
Dim Inc As Long, strGetList As String
    With vsfgUsers
        strGetList = "0"
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdUserManagerID) <> 0 Then
                strGetList = strGetList & ", " & .ValueMatrix(Inc, grdUserManagerID)
            End If
        Next Inc
    End With
    GetUserList = strGetList
Exit Function
Err_Exit:
    GetUserList = "0"
End Function

Public Function GetUserNameList() As String
On Local Error GoTo Err_Exit
Dim Inc As Long, strGetList As String
'    With vsfgUsers
'        For Inc = 1 To .Rows - 1
'            If .ValueMatrix(Inc, grdUserID) <> 0 Then
'                strGetList = strGetList & .TextMatrix(Inc, grdUserName) & ", "
'            End If
'        Next Inc
'    End With
    If Len(strGetList) > 0 Then strGetList = Left(strGetList, Len(strGetList) - 2)
    GetUserNameList = strGetList
Exit Function
Err_Exit:
    GetUserNameList = ""
End Function

Public Function FillUsers(strUserIDs As String) As String
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, strUser As String
Dim arrUserIDs() As String
    If Trim(strUserIDs) = "-1" Then strUserIDs = "0"
    strUserIDs = Replace(strUserIDs, "|", ",")
    arrUserIDs = Split(strUserIDs, ",")

    sSql = "SELECT DISTINCT UM.UserName, UM.UserID FROM Users UM INNER JOIN UserGroupUsers UG ON UM.UserID = UG.UserID " & _
           "WHERE (UM.UserID IN (" & strUserIDs & "))  AND (UM.StatusID = " & cnstStatusActive & ")"
        With GetRecords(sSql)
            While Not .EOF
                If vsfgUsers.Col = grdManager Then
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdManager) = .Fields("UserName") & ""
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdUserManagerID) = Val(.Fields("UserID") & "")
                ElseIf vsfgUsers.Col = grdAuditor Then
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdAuditor) = .Fields("UserName") & ""
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdUserAuditorID) = Val(.Fields("UserID") & "")
                ElseIf vsfgUsers.Col = grdAuditAssistant Then
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdAuditAssistant) = .Fields("UserName") & ""
                    vsfgUsers.TextMatrix(vsfgUsers.Row, grdUserAssistantID) = Val(.Fields("UserID") & "")
                End If
                .MoveNext
            Wend
            strUser = strUser & vsfgUsers.TextMatrix(vsfgUsers.Row, vsfgUsers.Col) & ", "
            If Len(strUser) > 0 Then strUser = Left(strUser, Len(strUser) - 2)
            FillUsers = strUser
        End With
Exit Function
Err_Exit:
    FillUsers = ""
    ShowError
End Function

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long, sSql As String
    Save = True
Exit Function
Err_Exit:
    Save = False
    ShowError
End Function

