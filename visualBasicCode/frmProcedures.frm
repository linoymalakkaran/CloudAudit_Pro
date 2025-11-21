VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmProcedures 
   Caption         =   "Procedures"
   ClientHeight    =   8490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10695
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   8490
   ScaleWidth      =   10695
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog CD 
      Left            =   225
      Top             =   8025
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton fndProcedureID 
      Height          =   315
      Left            =   3585
      Picture         =   "frmProcedures.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   435
      Width           =   345
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgProcDetails 
      Height          =   5130
      Left            =   75
      TabIndex        =   2
      Top             =   2835
      Width           =   10575
      _cx             =   18653
      _cy             =   9049
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
      Cols            =   1
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   315
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   -1  'True
      FormatString    =   $"frmProcedures.frx":018A
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
   Begin VB.Frame frameColumns 
      Height          =   2565
      Left            =   60
      TabIndex        =   0
      Top             =   -30
      Width           =   10590
      Begin VSFlex8Ctl.VSFlexGrid vsfgProcedure 
         Height          =   1605
         Left            =   90
         TabIndex        =   4
         Top             =   870
         Width           =   10395
         _cx             =   18336
         _cy             =   2831
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
         Cols            =   8
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   315
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   -1  'True
         FormatString    =   $"frmProcedures.frx":01C7
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
      Begin VB.Frame frameProcedureName 
         BorderStyle     =   0  'None
         Height          =   675
         Left            =   90
         TabIndex        =   6
         Top             =   120
         Width           =   10350
         Begin VB.TextBox txtProcedureID 
            Height          =   315
            Left            =   30
            TabIndex        =   9
            Top             =   345
            Width           =   3390
         End
         Begin VB.CommandButton fndProcedureTypeID 
            Height          =   315
            Left            =   6810
            Picture         =   "frmProcedures.frx":0304
            Style           =   1  'Graphical
            TabIndex        =   8
            Top             =   360
            Width           =   345
         End
         Begin VB.TextBox txtProcedureType 
            Height          =   315
            Left            =   3855
            Locked          =   -1  'True
            TabIndex        =   7
            Top             =   360
            Width           =   2940
         End
         Begin VB.Label lblDesc 
            AutoSize        =   -1  'True
            Caption         =   "Procedure Name"
            Height          =   195
            Index           =   0
            Left            =   45
            TabIndex        =   11
            Top             =   120
            Width           =   1200
         End
         Begin VB.Label lblProcedure 
            AutoSize        =   -1  'True
            Caption         =   "Procedure Type"
            Height          =   195
            Index           =   2
            Left            =   3855
            TabIndex        =   10
            Top             =   135
            Width           =   1140
         End
      End
   End
   Begin MSComctlLib.ImageList imglstCtrls 
      Left            =   990
      Top             =   8010
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
            Picture         =   "frmProcedures.frx":048E
            Key             =   "New"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":05E8
            Key             =   "Open"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":0742
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":089C
            Key             =   "Delete"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":0A76
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":0BD0
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":0DAA
            Key             =   "Notes"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":0F04
            Key             =   "Status"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":2406
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":25E0
            Key             =   "Copy"
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmProcedures.frx":27BA
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   4560
      TabIndex        =   1
      Top             =   8085
      Width           =   6075
      _ExtentX        =   10716
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
   Begin VB.Label lblProcedureDetails 
      AutoSize        =   -1  'True
      Caption         =   "Procedure Details"
      Height          =   165
      Left            =   75
      TabIndex        =   3
      Top             =   2610
      Width           =   1260
   End
End
Attribute VB_Name = "frmProcedures"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long
Dim mblnModify As Boolean
Dim mblnNew As Boolean, mlngMode As Long

Const grdColSlNo = 0
Const grdColName = 1
Const grdColDataType = 2
Const grdColWidth = 3
Const grdColAlign = 4
Const grdColBackColor = 5
Const grdColForeColor = 6
Const grdColIsLocked = 7

Public Property Get Mode() As Long
    Mode = mlngMode
End Property

Public Property Let Mode(ByVal blnNewValue As Long)
    mlngMode = blnNewValue
    Select Case mlngMode
        Case cnstProcedureModeUpdate
            vsfgProcedure.Visible = False
            frameColumns.Height = 900
            fndProcedureTypeID.Visible = False
            txtProcedureID.Enabled = False
            lblProcedureDetails.Top = 900
            vsfgProcDetails.Top = 1100
            vsfgProcDetails.Height = 6900
            tbrCtrls.Buttons("New").Visible = False
    End Select
End Property

Public Property Let EnableAll(ByVal blnNewValue As Boolean)
    frameProcedureName.Enabled = blnNewValue
    fndProcedureID.Enabled = Not blnNewValue
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
         vsfgProcedure.SetFocus
    Else
        ClearValues
    End If
    mblnModify = blnNewValue
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
    txtProcedureID = ""
    txtProcedureType = ""
    vsfgProcedure.Rows = 1: vsfgProcedure.Rows = 50
    vsfgProcDetails.Rows = 0: vsfgProcDetails.Rows = 2
    vsfgProcDetails.FixedRows = 1
    vsfgProcDetails.Cols = 1
End Sub

Private Sub fndProcedureID_Click()
    ButtonHandling Me, "Open"
End Sub

Public Function ShowOpen(Optional ByVal lngID As Long = 0) As Boolean
    Dim strRslt As String
    If lngID = 0 Then
        strRslt = PrepareAndFind(cnstSearchTypeGrpProcedures, "WHERE PeriodID = " & mPeriodID, "XProcedureID", , fndProcedureID, , , 1)
        If strRslt <> "-1" Then
            lngID = Val(strRslt)
            txtProcedureID.Tag = lngID
        End If
    Else
        strRslt = lngID
        txtProcedureID.Tag = lngID
    End If
    Select Case strRslt
    Case "-1", ""
        ShowOpen = False
    Case Else
        ShowOpen = ValueCollect(lngID)
        ShowOpen = True
    End Select
End Function

Public Function ValueCollect(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, Row As Long, Col As Long
    sSql = "SELECT PRC.*, PRT.ProcedureTypeName FROM Procedures PRC, ProcedureTypes PRT WHERE PRC.ProcedureTypeID = PRT.ProcedureTypeID " & _
           "AND ProcedureID = " & lngID
    With GetRecords(sSql)
        If Not .EOF Then
            txtProcedureID.Tag = lngID
            txtProcedureID = .Fields("ProcedureName") & ""
            txtProcedureType.Tag = Val(.Fields("ProcedureTypeID") & "")
            txtProcedureType = .Fields("ProcedureTypeName") & ""
        End If
        .Close
    End With
    'Getting Columns
    sSql = "SELECT *  FROM ProcedureSubColumns WHERE ProcedureId= " & lngID & " ORDER BY ColID"
    With GetRecords(sSql)
        vsfgProcedure.Rows = 1: Inc = 0
        While Not .EOF
            vsfgProcedure.Rows = vsfgProcedure.Rows + 1: Inc = Inc + 1
            vsfgProcedure.TextMatrix(Inc, grdColSlNo) = Val(.Fields("ColID") & "")
            vsfgProcedure.TextMatrix(Inc, grdColName) = .Fields("Description") & ""
            vsfgProcedure.TextMatrix(Inc, grdColDataType) = Trim(.Fields("DataType") & "")
            vsfgProcedure.TextMatrix(Inc, grdColWidth) = IIf(Val(.Fields("ColWidth") & "") = 0, "", Val(.Fields("ColWidth") & ""))
            vsfgProcedure.TextMatrix(Inc, grdColForeColor) = IIf(Val(.Fields("ColForecolor") & "") = 0, "", Val(.Fields("ColForecolor") & ""))
            vsfgProcedure.Cell(flexcpBackColor, Inc, grdColForeColor) = IIf(Val(.Fields("ColForecolor") & "") = 0, vbBlack, Val(.Fields("ColForecolor") & ""))
            vsfgProcedure.TextMatrix(Inc, grdColBackColor) = IIf(Val(.Fields("ColBackcolor") & "") = 0, "", Val(.Fields("ColBackcolor") & ""))
            vsfgProcedure.Cell(flexcpBackColor, Inc, grdColBackColor) = IIf(Val(.Fields("ColBackcolor") & "") = 0, vbWhite, Val(.Fields("ColBackcolor") & ""))
            vsfgProcedure.TextMatrix(Inc, grdColAlign) = IIf(Val(.Fields("ColAlign") & "") = 0, 1, Val(.Fields("ColAlign") & ""))
            vsfgProcedure.TextMatrix(Inc, grdColIsLocked) = IIf(.Fields("ColIsLocked") & "" = "True", -1, 0)
            .MoveNext
        Wend
      .Close
    End With
    If vsfgProcedure.Rows < 50 Then vsfgProcedure.Rows = 50
    BuildDataGrid
    'Getting Column Data
    sSql = "SELECT *  FROM ProcedureSubDefaults WHERE ProcedureId= " & lngID & " ORDER BY RowID"
    With GetRecords(sSql)
        vsfgProcDetails.Rows = 1
        While Not .EOF
            Row = Val(.Fields("RowID") & "")
            Col = Val(.Fields("ColID") & "") - 1
            If vsfgProcDetails.Rows <= Row Then
                vsfgProcDetails.Rows = Row + 1
            End If
            If vsfgProcDetails.Cols <= Col Then
                vsfgProcDetails.Cols = Col + 1
            End If
            vsfgProcDetails.TextMatrix(Row, Col) = .Fields("DefaultValue") & ""
            .MoveNext
        Wend
        .Close
    End With
    If vsfgProcDetails.Rows = 1 Then vsfgProcDetails.Rows = vsfgProcDetails.Rows + 1
    BuildDataGrid
    ValueCollect = False
Exit Function
Err_Exit:
    ShowError
    ValueCollect = False
End Function

Private Sub fndProcedureTypeID_Click()
    PrepareAndFind cnstSearchTypeGrpProcedureType, , "Name, XProcedureTypeID", txtProcedureType, fndProcedureTypeID, , , 1
End Sub

Private Sub Form_Load()
    ButtonHandling Me
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub vsfgProcDetails_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    If Row = vsfgProcDetails.Rows - 1 Then vsfgProcDetails.Rows = vsfgProcDetails.Rows + 1
    BuildDataGrid
End Sub

Private Sub vsfgProcDetails_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Not mblnModify And Not mblnNew Then
        Cancel = True
    End If
End Sub

Private Sub vsfgProcDetails_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyDelete Then
        If vsfgProcDetails.Row > 1 Then
            vsfgProcDetails.RemoveItem vsfgProcDetails.Row
        End If
    End If
End Sub

Private Sub vsfgProcedure_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    PutSlNo vsfgProcedure, grdColSlNo, grdColName
    BuildDataGrid
End Sub

Public Function BuildDataGrid() As Boolean
On Error Resume Next
Dim Inc As Long, lngInc As Long, lngColWidth As Long, lngGridCol As Long
    vsfgProcDetails.Cell(flexcpText, 0, 0, 0, vsfgProcDetails.Cols - 1) = ""
    For Inc = 1 To vsfgProcedure.Rows - 1
        If vsfgProcedure.ValueMatrix(Inc, grdColSlNo) <> 0 Then
            If vsfgProcDetails.Cols <= vsfgProcedure.ValueMatrix(Inc, grdColSlNo) Then
                vsfgProcDetails.Cols = vsfgProcDetails.Cols + 1
            End If
            lngGridCol = vsfgProcedure.ValueMatrix(Inc, grdColSlNo) - 1
            vsfgProcDetails.TextMatrix(0, lngGridCol) = vsfgProcedure.TextMatrix(Inc, grdColName)
            lngColWidth = vsfgProcedure.ValueMatrix(Inc, grdColWidth)
            If lngColWidth = 0 Then lngColWidth = 1200
            vsfgProcDetails.ColWidth(lngGridCol) = lngColWidth
            vsfgProcDetails.ColDataType(lngGridCol) = GetColDataType(vsfgProcedure.TextMatrix(Inc, grdColDataType))
            vsfgProcDetails.Cell(flexcpBackColor, 1, lngGridCol, vsfgProcDetails.Rows - 1, lngGridCol) = vsfgProcedure.Cell(flexcpText, Inc, grdColBackColor)
            vsfgProcDetails.Cell(flexcpForeColor, 1, lngGridCol, vsfgProcDetails.Rows - 1, lngGridCol) = vsfgProcedure.Cell(flexcpText, Inc, grdColForeColor)
            vsfgProcDetails.ColAlignment(lngGridCol) = vsfgProcedure.ValueMatrix(Inc, grdColAlign)
        End If
    Next Inc
BuildDataGrid = True
Exit Function
Err_Exit:
    'ShowError
    BuildDataGrid = False
End Function

Public Function GetColDataType(strDataType As String)
    Select Case Trim(strDataType)
        Case "S"
            GetColDataType = flexDTString
        Case "N"
            GetColDataType = flexDTDecimal
        Case "D"
            GetColDataType = flexDTDate
        Case "B"
            GetColDataType = flexDTBoolean
        Case Else
            GetColDataType = flexDTString
    End Select
End Function

Public Function Save() As Boolean
On Error GoTo Err_Exit
Dim sSql As String, Inc As Long, Inc1 As Long, rsSave As Recordset, ColInc As Long
Dim lngID As Long, IsInTran As Boolean
    If Trim(txtProcedureID) = "" Then
        pMVE.MsgBox "Procedure Name is Not Mentioned.", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    If Val(txtProcedureType.Tag) = 0 Then
        pMVE.MsgBox "Procedure Type is Not Mentioned.", msgOK, "AuditMate", msgInformation, True
        Save = False
        Exit Function
    End If
    '---------------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    lngID = Val(txtProcedureID.Tag)
    sSql = "SELECT * FROM Procedures WHERE ProcedureID = " & lngID
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            lngID = GetMaxNo("Procedures", "ProcedureID")
            .Fields("ProcedureID") = lngID
        End If
        .Fields("PeriodID") = mPeriodID
        .Fields("ProcedureName") = txtProcedureID
        .Fields("ProcedureTypeID") = Val(txtProcedureType.Tag)
        .Fields("IsTemplate") = 0
        SaveDateAndUser rsSave, mblnNew
        .Update
      .Close
    End With
    sSql = "DELETE FROM ProcedureSubColumns WHERE ProcedureID = " & lngID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM ProcedureSubColumns WHERE ProcedureID = " & lngID
    With GetRecords(sSql)
        For Inc = 1 To vsfgProcedure.Rows - 1
            If vsfgProcedure.ValueMatrix(Inc, grdColSlNo) <> 0 Then
                .AddNew
                .Fields("ProcedureID") = lngID
                .Fields("ColID") = vsfgProcedure.ValueMatrix(Inc, grdColSlNo)
                .Fields("Description") = vsfgProcedure.TextMatrix(Inc, grdColName)
                .Fields("DataType") = Trim(vsfgProcedure.TextMatrix(Inc, grdColDataType))
                .Fields("ColWidth") = vsfgProcedure.ValueMatrix(Inc, grdColWidth)
                .Fields("ColForecolor") = vsfgProcedure.ValueMatrix(Inc, grdColForeColor)
                .Fields("ColBackcolor") = vsfgProcedure.ValueMatrix(Inc, grdColBackColor)
                .Fields("ColAlign") = vsfgProcedure.ValueMatrix(Inc, grdColAlign)
                .Fields("ColIsLocked") = vsfgProcedure.ValueMatrix(Inc, grdColIsLocked)
                .Fields("IsTotal") = 0
                .Update
            End If
        Next
      .Close
    End With
    sSql = "DELETE FROM ProcedureSubDefaults WHERE ProcedureID = " & lngID
    AdoConn.Execute sSql
    sSql = "SELECT * FROM ProcedureSubDefaults WHERE ProcedureID = " & lngID
    With GetRecords(sSql)
        For Inc = 1 To vsfgProcDetails.Rows - 1
            For Inc1 = 0 To vsfgProcDetails.Cols - 1
                .AddNew
                .Fields("ProcedureID") = lngID
                .Fields("ColID") = Inc1 + 1
                .Fields("RowID") = Inc
                .Fields("DefaultValue") = vsfgProcDetails.TextMatrix(Inc, Inc1)
                .Fields("IsDesign") = (Mode = cnstProcedureModeCreate)
                .Update
            Next Inc1
        Next
      .Close
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

Private Sub vsfgProcedure_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If Not mblnModify And Not mblnNew Then
        Cancel = True
    End If
End Sub

Private Sub vsfgProcedure_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
    Select Case Col
        Case grdColBackColor, grdColForeColor
            CD.ShowColor
            vsfgProcedure.Cell(flexcpBackColor, Row, Col) = CD.Color
            vsfgProcedure.Cell(flexcpText, Row, Col) = CD.Color
    End Select
    vsfgProcedure_AfterEdit Row, Col
End Sub
