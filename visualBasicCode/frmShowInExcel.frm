VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmShowInExcel 
   Caption         =   "Filename"
   ClientHeight    =   6615
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10140
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6615
   ScaleWidth      =   10140
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdPrevSheet 
      Caption         =   "Previous Sheet"
      Height          =   255
      Left            =   7080
      TabIndex        =   3
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton cmdNextSheet 
      Caption         =   "Next Sheet"
      Height          =   255
      Left            =   8400
      TabIndex        =   2
      Top             =   120
      Width           =   1215
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgExcel 
      Height          =   4935
      Left            =   240
      TabIndex        =   1
      Top             =   480
      Width           =   7455
      _cx             =   13150
      _cy             =   8705
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
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   50
      Cols            =   10
      FixedRows       =   1
      FixedCols       =   1
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
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
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   330
      Left            =   4080
      TabIndex        =   4
      Top             =   5640
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
      Left            =   2160
      Top             =   5640
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
            Picture         =   "frmShowInExcel.frx":0000
            Key             =   "Modify"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmShowInExcel.frx":015A
            Key             =   "Print"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmShowInExcel.frx":0334
            Key             =   "Close"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmShowInExcel.frx":050E
            Key             =   "Save"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmShowInExcel.frx":0668
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin VB.Label lblFileName 
      AutoSize        =   -1  'True
      Caption         =   "Caption"
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
      Left            =   90
      TabIndex        =   0
      Top             =   135
      Width           =   660
   End
End
Attribute VB_Name = "frmShowInExcel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim mlngSheet As Long
Dim mstrExt As String, mstrFileName As String
Dim mstrActualFileName As String
Dim mlngQuestionID As Long, mlngProcedureTypeID As Long, mlngSubSectionID As Long
Dim mCompanyID As Long, mPeriodID As Long
Dim mDefaultPeriodID As Long, mblnModify As Long, mblnNew As Long
Dim mstrFilePath As String

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
Dim sSql As String
    If mPeriodID = 0 Then
        mDefaultPeriodID = vNewValue
    End If
    mPeriodID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

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

Public Sub ShowFile(strExt As String, strFileName As String, strActualName As String, lngQuestionID As Long, lngProcedureTypeID As Long, lngSubSectionID As Long, Optional lngSheet As Long = -1)
On Local Error GoTo Err_Exit
    mstrExt = strExt
    mstrFileName = strFileName
    lblFileName = strFileName
    mstrActualFileName = strActualName
    mlngQuestionID = lngQuestionID
    mlngProcedureTypeID = lngProcedureTypeID
    mlngSubSectionID = lngSubSectionID
    With vsfgExcel
        Select Case UCase(strExt)
            Case ".XLS", ".XLSX"
                .FixedCols = 0: .FixedRows = 1
                If lngSheet = -1 Then
                    mlngSheet = 0
                    .LoadGrid strFileName, flexFileExcel
                Else
                    .LoadGrid strFileName, flexFileExcel, lngSheet
                End If
            Case ".JPG", ".BMP", ".TIF", ".MDI", ".GIF"
                .ExtendLastCol = True
                .Cols = 1: .Rows = 1
                .FixedCols = 0: .FixedRows = 1
                .WallPaper = LoadPicture(strFileName)
                .WallPaperAlignment = flexPicAlignCenterCenter
            Case Else
                Set .DataSource = Nothing
                .LoadGrid strFileName, flexFileData
        End Select
    End With
Exit Sub
Err_Exit:
    mlngSheet = 0
'    ShowError
End Sub

Private Sub cmdNextSheet_Click()
On Error Resume Next
    MousePointer = MousePointerConstants.vbHourglass
    mlngSheet = mlngSheet + 1
    ShowFile mstrExt, mstrFileName, mstrActualFileName, mlngQuestionID, mlngProcedureTypeID, mlngSubSectionID, mlngSheet
    MousePointer = MousePointerConstants.vbDefault
End Sub

Private Sub cmdPrevSheet_Click()
On Error Resume Next
    MousePointer = MousePointerConstants.vbHourglass
    mlngSheet = mlngSheet - 1
    ShowFile mstrExt, mstrFileName, mstrActualFileName, mlngQuestionID, mlngProcedureTypeID, mlngSubSectionID, mlngSheet
    MousePointer = MousePointerConstants.vbDefault
End Sub

Private Sub Form_Load()
    With vsfgExcel
        .Left = 60
        .Top = 400
        .Width = GetProportionalValue(15400, False)
        .Height = GetProportionalValue(8000)
        
        vsfgExcel.AllowUserResizing = flexResizeBoth
        vsfgExcel.MergeCells = flexMergeSpill
        vsfgExcel.ExtendLastCol = True
    End With
    With cmdNextSheet
        .Top = 60
        .Left = vsfgExcel.Left + vsfgExcel.Width - .Width
    End With
    With cmdPrevSheet
        .Top = cmdNextSheet.Top
        .Left = vsfgExcel.Left + vsfgExcel.Width - cmdNextSheet.Width - .Width
    End With
    With tbrCtrls
        .Top = 9000
        .Left = 9000
    End With
    ButtonHandling Me
    tbrCtrls.Buttons("Modify").Enabled = True
End Sub

Private Sub Form_Resize()
    WindowState = vbMaximized
End Sub

Private Sub Form_Unload(Cancel As Integer)
    KillFile mstrFileName
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
    ButtonHandling Me, Button.Key
End Sub

Private Sub tbrCtrls_Click()
    If tbrCtrls.Buttons("Modify").Value = tbrPressed Then
        OpenTemplateDocuments
    End If
End Sub

Private Sub vsfgExcel_AfterEdit(ByVal Row As Long, ByVal Col As Long)
Dim Inc As Long
Dim mStream As New ADODB.Stream, sSql As String
    For Inc = 1 To vsfgExcel.Rows - 1
        With vsfgExcel
            .SaveGrid mstrFileName, flexFileExcel, mlngSheet
        End With
    Next
    If Dir(mstrFileName) <> "" And Trim(mstrFileName) <> "" Then
        sSql = "Select TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & mlngProcedureTypeID & _
                "AND   SubSectionID = " & mlngSubSectionID & " And PeriodID = " & pActivePeriodID & _
                "AND   QuestionID = " & mlngQuestionID
        With GetRecords(sSql)
            If Not .EOF Then
                Set mStream = New ADODB.Stream
                mStream.Type = adTypeBinary
                mStream.Open
                mStream.LoadFromFile mstrFileName
                .Fields("TemplateFile").Value = mStream.Read
'                .Update
                KillFile mstrFileName
            End If
        End With
    End If
End Sub

Private Sub vsfgExcel_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgExcel.ToolTipText = vsfgExcel.Text
End Sub

Public Sub KillFile(strFileName As String)
On Local Error Resume Next
    Kill strFileName
End Sub

Public Sub OpenTemplateDocuments()
On Local Error GoTo Err_Exit
Dim strFilePath As String, sSql As String
Dim strFileName As String, strExt As String, strCheckOutPath As String, strTmpFileName As String
    strFileName = mstrActualFileName
    strExt = GetExtension(strFileName, True) 'Mid(strFilename, InStr(1, strFilename, "."))
    strCheckOutPath = GetApplicationData("CheckOutPath")
    If Right(Trim(strCheckOutPath), 1) <> "\" Then
        strCheckOutPath = strCheckOutPath & "\"
    End If
    strTmpFileName = GetTickCount
    strFilePath = strCheckOutPath & strTmpFileName & " - " & GetCompanyAndPeriodName(pActivePeriodID) & mstrActualFileName
'    strFilePath = strCheckOutPath & strFileName
    mstrFilePath = strFilePath
    sSql = "Select TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & mlngProcedureTypeID & _
           "AND    SubSectionID = " & mlngSubSectionID & " And PeriodID = " & pActivePeriodID & _
           "AND    QuestionID = " & mlngQuestionID

    If ExtractDocument(GetRecords(sSql), "TemplateFile", strFilePath) Then
        sSql = "Update SubSectionProcedures Set IsCheckedOut = 1 Where ProcedureTypeID = " & mlngProcedureTypeID & _
               "AND    SubSectionID = " & mlngSubSectionID & " And PeriodID = " & pActivePeriodID & _
               "AND    QuestionID = " & mlngQuestionID
        AdoConn.Execute sSql
        If pMVE.MsgBox("Template file is ready for editing.", msgOK, "AuditMate", msgInformation, True) Then
            Shell "Explorer.exe " & strFilePath, vbMaximizedFocus
        End If
    End If
Exit Sub
Err_Exit:
    ShowError
End Sub

Public Function Save() As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, mStream As New ADODB.Stream
    If Dir(mstrFilePath) <> "" And Trim(mstrFilePath) <> "" Then
        sSql = "Select TemplateFile From SubSectionProcedures Where ProcedureTypeID = " & mlngProcedureTypeID & _
                "AND   SubSectionID = " & mlngSubSectionID & " And PeriodID = " & pActivePeriodID & _
                "AND   QuestionID = " & mlngQuestionID
        With GetRecords(sSql)
            If Not .EOF Then
                Set mStream = New ADODB.Stream
                mStream.Type = adTypeBinary
                mStream.Open
                mStream.LoadFromFile mstrFilePath
                .Fields("TemplateFile").Value = mStream.Read
                .Update
                sSql = "UPDATE SubSectionProcedures SET IsCheckedOut = 0 WHERE ProcedureTypeID = " & mlngProcedureTypeID & _
                       "AND    SubSectionID = " & mlngSubSectionID & " And PeriodID = " & pActivePeriodID & _
                       "AND    QuestionID = " & mlngQuestionID
                AdoConn.Execute sSql
                KillFile mstrFilePath
            End If
        End With
    End If
    Save = True
    
Exit Function
Err_Exit:
    ShowError
    Save = False
End Function

Public Function GetCompanyAndPeriodName(lngPeriodID As Long) As String
On Local Error GoTo Err_Exit
Dim sSql As String
    GetCompanyAndPeriodName = ""
    sSql = "SELECT CMP.JobCode, PER.Description FROM Periods PER INNER JOIN " & _
           "Companies CMP ON PER.CompanyID = CMP.CompanyID Where (PER.PeriodID = " & lngPeriodID & ")"
    With GetRecords(sSql)
        If Not .EOF Then
            GetCompanyAndPeriodName = .Fields("JobCode") & " - " & .Fields("Description") & " "
        End If
        .Close
    End With
Exit Function
Err_Exit:
    GetCompanyAndPeriodName = ""
End Function


