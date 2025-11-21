VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{FBC672E3-F04D-11D2-AFA5-E82C878FD532}#5.8#0"; "AS-IFCE1.OCX"
Begin VB.Form frmOpenPeriod 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Open"
   ClientHeight    =   3585
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7560
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3585
   ScaleWidth      =   7560
   StartUpPosition =   1  'CenterOwner
   Begin VSFlex8Ctl.VSFlexGrid vsfgDetails 
      Height          =   3090
      Left            =   30
      TabIndex        =   0
      Top             =   30
      Width           =   7545
      _cx             =   13309
      _cy             =   5450
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
      Cols            =   7
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   300
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmOpenPeriod.frx":0000
      ScrollTrack     =   0   'False
      ScrollBars      =   2
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   2
      AutoSearchDelay =   1
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
   Begin AIFCmp1.asxPowerButton cmdOpen 
      Height          =   330
      Left            =   5295
      TabIndex        =   1
      Top             =   3210
      Width           =   1080
      _ExtentX        =   1905
      _ExtentY        =   582
      FocusStyle      =   2
      HighlightColor  =   16777215
      ShadowColor     =   16777215
      BorderStyle     =   1
      Caption         =   "&Open"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HotTracking     =   -1  'True
      HotTrackingColor=   16711680
   End
   Begin AIFCmp1.asxPowerButton cmdCancel 
      Height          =   330
      Left            =   6465
      TabIndex        =   2
      Top             =   3210
      Width           =   1080
      _ExtentX        =   1905
      _ExtentY        =   582
      FocusStyle      =   2
      HighlightColor  =   16777215
      ShadowColor     =   16777215
      BorderStyle     =   1
      Caption         =   "&Cancel"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HotTracking     =   -1  'True
      HotTrackingColor=   16711680
   End
End
Attribute VB_Name = "frmOpenPeriod"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const grdCompanyName = 0
Const grdShortName = 1
Const grdAuditType = 2
Const grdPeriod = 3
Const grdSelected = 4
Const grdCompanyID = 5
Const grdPeriodID = 6

Dim mstrReturn As String, IsCanceled As Boolean, mstrSelectedPeriods As String

Public Function SelectPeriods(Optional strSelectedPeriods As String = "") As String
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long
Dim strCompanyName As String
Dim lngUserGroupID As Long
    lngUserGroupID = Val(PickValue("UserGroupUsers", "UserGroupID", "UserID = " & pUserID))
    mstrSelectedPeriods = strSelectedPeriods
    IsCanceled = False
    If lngUserGroupID <> 3 Then
        sSql = "SELECT   CMP.CompanyName, PER.ShortName, AuditType.AuditTypeName AS AuditType, CONVERT(VARCHAR, CONVERT(DATETIME, PER.StartDt - 2, 103), 103) " & _
               "         + ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, PER.EndDt - 2, 103), 103) AS Period, CMP.CompanyID, PER.PeriodID " & _
               "FROM     AuditType INNER JOIN Periods PER ON AuditType.AuditTypeID = PER.AuditTypeID RIGHT OUTER JOIN Companies CMP ON PER.CompanyID = CMP.CompanyID " & _
               "Where   (ISNULL(PER.StatusID, CMP.StatusID) = " & cnstStatusActive & ") ORDER BY CMP.CompanyName, PER.StartDt"
    Else
        sSql = "SELECT   CMP.CompanyName, PER.ShortName, AuditType.AuditTypeName AS AuditType, CONVERT(VARCHAR, CONVERT(DATETIME, PER.StartDt - 2, 103), 103) " & _
               "         + ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, PER.EndDt - 2, 103), 103) AS Period, CMP.CompanyID, PER.PeriodID, UserPrivileges.UserID " & _
               "FROM     AuditType INNER JOIN  Periods AS PER ON AuditType.AuditTypeID = PER.AuditTypeID INNER JOIN UserPrivileges ON PER.PeriodID = UserPrivileges.PeriodID " & _
               "         RIGHT OUTER JOIN Companies AS CMP ON PER.CompanyID = CMP.CompanyID " & _
               "Where   (IsNull(PER.StatusID, CMP.StatusID) = " & cnstStatusActive & " ) And (UserPrivileges.UserID = " & pUserID & ") ORDER BY CMP.CompanyName, PER.StartDt"
    End If
    vsfgDetails.Rows = 1
    vsfgDetails.OutlineCol = grdCompanyName
    vsfgDetails.OutlineBar = flexOutlineBarCompleteLeaf
    With GetRecords(sSql)
        If .EOF Then
Not_Valid:
            pMVE.MsgBox "No Privileged Period Available.", msgOK, "AuditMate", msgExclamation, True
            SelectPeriods = ""
            Exit Function
        Else
            While Not .EOF
                vsfgDetails.Rows = vsfgDetails.Rows + 1
                Inc = vsfgDetails.Rows - 1
                vsfgDetails.IsSubtotal(Inc) = True
                If strCompanyName <> .Fields("CompanyName") & "" Or strCompanyName = "" Then
                    vsfgDetails.RowOutlineLevel(Inc) = 1
                Else
                    vsfgDetails.RowOutlineLevel(Inc) = 2
                End If
                strCompanyName = .Fields("CompanyName") & ""
                vsfgDetails.TextMatrix(Inc, grdCompanyName) = strCompanyName
                vsfgDetails.TextMatrix(Inc, grdShortName) = .Fields("ShortName") & ""
                vsfgDetails.TextMatrix(Inc, grdAuditType) = .Fields("AuditType") & ""
                vsfgDetails.TextMatrix(Inc, grdPeriod) = .Fields("Period") & ""
                vsfgDetails.TextMatrix(Inc, grdSelected) = 0
                vsfgDetails.TextMatrix(Inc, grdCompanyID) = .Fields("CompanyID") & ""
                vsfgDetails.TextMatrix(Inc, grdPeriodID) = .Fields("PeriodID") & ""
                .MoveNext
            Wend
            HideSelecedItems
            If GetActiveRowCount = 0 Then
                GoTo Not_Valid
            End If
            For Inc = 1 To vsfgDetails.Rows - 1
                vsfgDetails.IsCollapsed(Inc) = flexOutlineCollapsed
            Next Inc
            vsfgDetails.Row = 1
            vsfgDetails.MergeCells = flexMergeFree
            vsfgDetails.MergeCol(grdCompanyName) = True
            vsfgDetails_RowColChange
Ret_Failed:
            Show
            While Visible
                DoEvents
            Wend
            If Not IsCanceled Then
                If ReturnValue Then
                    SelectPeriods = mstrReturn
                Else
                    GoTo Ret_Failed
                End If
            End If
        End If
        .Close
    End With
Unload Me
Exit Function
Err_Exit:
    SelectPeriods = ""
End Function

Public Sub HideSelecedItems()
On Local Error GoTo Err_Exit
Dim arrData() As String, arrObjects() As String
Dim Inc As Long, Inc1 As Long, lngCompanyID As Long, lngPeriodID As Long
    If mstrSelectedPeriods = "" Then
        Exit Sub
    End If
    arrData = Split(mstrSelectedPeriods, ";")
    For Inc = 0 To UBound(arrData)
        arrObjects = Split(arrData(Inc), "|")
        lngCompanyID = Val(arrObjects(0))
        lngPeriodID = Val(arrObjects(1))
        For Inc1 = 1 To vsfgDetails.Rows - 1
            If vsfgDetails.ValueMatrix(Inc1, grdCompanyID) = lngCompanyID And _
                vsfgDetails.ValueMatrix(Inc1, grdPeriodID) = lngPeriodID Then
                vsfgDetails.RowHidden(Inc1) = True
            End If
        Next Inc1
    Next Inc
Exit Sub
Err_Exit:

End Sub

Public Function GetActiveRowCount() As Long
Dim Inc As Long, lngCount As Long
    For Inc = 1 To vsfgDetails.Rows - 1
        If Not vsfgDetails.RowHidden(Inc) Then
            lngCount = lngCount + 1
        End If
    Next Inc
    GetActiveRowCount = lngCount
End Function

Private Sub cmdCancel_Click()
    IsCanceled = True
    Hide
End Sub

Public Function ReturnValue() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    mstrReturn = ""
    With vsfgDetails
        For Inc = 1 To .Rows - 1
            If .ValueMatrix(Inc, grdSelected) = -1 Then
                mstrReturn = mstrReturn & .ValueMatrix(Inc, grdCompanyID) & "|" & .ValueMatrix(Inc, grdPeriodID) & "; "
            End If
        Next Inc
        If mstrReturn = "" Then
            pMVE.MsgBox "Nothing Selected.", msgOK, "AuditMate", msgInformation, True
            ReturnValue = False
            Exit Function
        End If
    End With
    ReturnValue = True
Exit Function
Err_Exit:
    ShowError
    ReturnValue = False
End Function

Private Sub cmdOpen_Click()
    Hide
End Sub

Private Sub vsfgDetails_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Col <> grdSelected Then
        Cancel = True
    End If
End Sub

Private Sub vsfgDetails_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeySpace Then
        If vsfgDetails.Row <= 0 Then Exit Sub
        If vsfgDetails.Col <> grdSelected Then
            If vsfgDetails.ValueMatrix(vsfgDetails.Row, grdSelected) = -1 Then
                vsfgDetails.TextMatrix(vsfgDetails.Row, grdSelected) = 0
            Else
                vsfgDetails.TextMatrix(vsfgDetails.Row, grdSelected) = -1
            End If
        End If
    ElseIf KeyCode = vbKeyReturn Then
        Hide
    ElseIf KeyCode = vbKeyEscape Then
        IsCanceled = True
        Hide
    End If
End Sub

Private Sub vsfgDetails_RowColChange()
    SelectRow vsfgDetails
End Sub
