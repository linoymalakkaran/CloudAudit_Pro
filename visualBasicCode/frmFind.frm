VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{370046EB-1E49-11D8-B636-C2FB81CF1D6D}#1.0#0"; "MVE.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form frmFind 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Find"
   ClientHeight    =   3795
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   6255
   ControlBox      =   0   'False
   Icon            =   "frmFind.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   6255
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VSFlex8Ctl.VSFlexGrid vsfgSelection 
      Height          =   600
      Left            =   15
      TabIndex        =   9
      Top             =   2655
      Visible         =   0   'False
      Width           =   6210
      _cx             =   10954
      _cy             =   1058
      Appearance      =   2
      BorderStyle     =   0
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
      BackColorSel    =   12640511
      ForeColorSel    =   0
      BackColorBkg    =   -2147483643
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   3
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   4
      SelectionMode   =   0
      GridLines       =   9
      GridLinesFixed  =   2
      GridLineWidth   =   3
      Rows            =   0
      Cols            =   3
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"frmFind.frx":0442
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
   Begin VB.TextBox txtShowFirst 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H8000000F&
      BorderStyle     =   0  'None
      Height          =   240
      Left            =   3525
      MaxLength       =   5
      TabIndex        =   7
      Text            =   "10000"
      Top             =   3525
      Width           =   510
   End
   Begin VB.CheckBox chkAdvancedSearch 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      ForeColor       =   &H80000008&
      Height          =   240
      Left            =   0
      Picture         =   "frmFind.frx":0493
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Advanced Search On"
      Top             =   30
      Width           =   225
   End
   Begin VB.Timer tmrKey 
      Interval        =   300
      Left            =   5625
      Top             =   3360
   End
   Begin MVE_OCX.FlatBorder FlatBorder1 
      Left            =   5640
      Top             =   3240
      _ExtentX        =   397
      _ExtentY        =   318
   End
   Begin VB.TextBox txtSearch 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Top             =   0
      Width           =   3510
   End
   Begin MSComctlLib.Toolbar tbrCtrls 
      Height          =   1710
      Left            =   15
      TabIndex        =   3
      Top             =   3255
      Width           =   2490
      _ExtentX        =   4392
      _ExtentY        =   3016
      ButtonWidth     =   1455
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "imglstToolBar"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&New"
            Key             =   "New"
            Object.ToolTipText     =   "New"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Modify"
            Key             =   "Modify"
            Object.ToolTipText     =   "Modify"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Delete"
            Key             =   "Delete"
            Object.ToolTipText     =   "Delete"
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imglstToolBar 
      Left            =   60
      Top             =   3660
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":065D
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":0AB7
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":0F09
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":1223
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":18F5
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":2307
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":7AF9
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":7F4B
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":A6FD
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar tbrOkCancel 
      Height          =   570
      Left            =   4575
      TabIndex        =   4
      Top             =   3255
      Width           =   1500
      _ExtentX        =   2646
      _ExtentY        =   1005
      ButtonWidth     =   1402
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "imgToolbarOkCancel"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&OK"
            Key             =   "OK"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cancel"
            Key             =   "Cancel"
            ImageIndex      =   1
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList imgToolbarOkCancel 
      Left            =   645
      Top             =   3660
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":10997
            Key             =   "Cancel"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmFind.frx":10CB1
            Key             =   "OK"
         EndProperty
      EndProperty
   End
   Begin VB.ComboBox cmbSearchBy 
      Height          =   315
      Left            =   4695
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   0
      Width           =   1530
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgDetails 
      Height          =   2925
      Left            =   15
      TabIndex        =   2
      Top             =   330
      Width           =   6210
      _cx             =   10954
      _cy             =   5159
      Appearance      =   2
      BorderStyle     =   0
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
      BackColorSel    =   12640511
      ForeColorSel    =   0
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483643
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   3
      HighLight       =   2
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   4
      SelectionMode   =   0
      GridLines       =   9
      GridLinesFixed  =   2
      GridLineWidth   =   3
      Rows            =   12
      Cols            =   3
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"frmFind.frx":10FCB
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
      WallPaper       =   "frmFind.frx":1103C
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
      Begin MSAdodcLib.Adodc AdodcTmp 
         Height          =   330
         Left            =   1920
         Top             =   1080
         Visible         =   0   'False
         Width           =   1200
         _ExtentX        =   2117
         _ExtentY        =   582
         ConnectMode     =   0
         CursorLocation  =   3
         IsolationLevel  =   -1
         ConnectionTimeout=   15
         CommandTimeout  =   30
         CursorType      =   3
         LockType        =   3
         CommandType     =   8
         CursorOptions   =   0
         CacheSize       =   50
         MaxRecords      =   0
         BOFAction       =   0
         EOFAction       =   0
         ConnectStringType=   1
         Appearance      =   1
         BackColor       =   -2147483643
         ForeColor       =   -2147483640
         Orientation     =   0
         Enabled         =   -1
         Connect         =   ""
         OLEDBString     =   ""
         OLEDBFile       =   ""
         DataSourceName  =   ""
         OtherAttributes =   ""
         UserName        =   ""
         Password        =   ""
         RecordSource    =   ""
         Caption         =   "Realsoft"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         _Version        =   393216
      End
   End
   Begin VB.Label lblShowFirst 
      AutoSize        =   -1  'True
      Caption         =   "Show first            records"
      Height          =   195
      Left            =   2820
      TabIndex        =   8
      Top             =   3525
      Width           =   1755
   End
   Begin VB.Label lblSearchBy 
      AutoSize        =   -1  'True
      Caption         =   "Search By"
      Height          =   195
      Left            =   3840
      TabIndex        =   5
      Top             =   60
      Width           =   735
   End
End
Attribute VB_Name = "frmFind"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public mButtonNew As Boolean, mButtonModify As Boolean, mButtonDelete As Boolean
Dim mButtonGoto As Boolean, mButtonPrint As Boolean
Dim mQuery As String, mExeQuery As String, mColWidth As String, mFilter As String, mShowTools As Boolean, mSelectionField As String
Dim mRetField As String, mRetCols As String, mRetValue As String, mSearchFields As String, mIsSelectable As Boolean
Dim mCanRefresh As Boolean, mReturned As Boolean, mSearchTypeId As Long, mSearchMethod As SearchMethods
Dim mResultCtrl As Control, mfndCtrl As Control
Dim mLinkMenu As String, mLinkForm As String, mLinkField As String, mLinkCaption As String
Dim mblnSubFormShown As Boolean, mblnIsFirstTime As Boolean
Dim mlngShowFirst As Long, arrColNames(2, 100) As String, arrFieldNames() As String
'Req No:157/07-03
Dim mlngIDCol As Long, mstrIDColCaption As String, mstrSelectedValues As String

Const mMinRows = 4
Const mMaxRows = 12
Const mMinColsWidth = 6345
Const mMaxColsWidth = 10000

Private Sub chkAdvancedSearch_Click()
    If chkAdvancedSearch = vbChecked Then
        chkAdvancedSearch.ToolTipText = "Advanced search mode: On"
        SetIniString CStr(mSearchTypeId), "On", "Find%"
    Else
        chkAdvancedSearch.ToolTipText = "Advanced search mode: Off"
        SetIniString CStr(mSearchTypeId), "Off", "Find%"
    End If
    If Visible Then RefreshGrid
End Sub

Private Sub cmbSearchBy_Click()
    If Visible Then txtSearch_Change
End Sub

Private Sub Form_Activate()
On Local Error Resume Next
    If mblnIsFirstTime Then
        mblnIsFirstTime = False
        vsfgDetails.Row = 1
        vsfgDetails.SetFocus
        vsfgDetails_RowColChange
        txtSearch.SetFocus
        txtSearch.SelStart = Len(txtSearch.Text)
        txtSearch.SelLength = 0
    End If
End Sub

Private Sub Form_Deactivate()
    'ReturnValue False
    If Not mblnSubFormShown Then
        Hide
    End If
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
        Case vbKeyReturn
        Case vbKeyEscape
            ReturnValue True
    End Select
End Sub

Private Sub Form_Load()
    mReturned = False
    mblnIsFirstTime = True
End Sub

Private Sub tbrCtrls_ButtonClick(ByVal Button As MSComctlLib.Button)
On Local Error Resume Next
Dim Inc As Long, lngID As Long, frmVchr As Form, VchrTypeID As Long
    For Inc = 0 To vsfgDetails.Cols - 1
        If UCase(Trim(vsfgDetails.TextMatrix(0, Inc))) = UCase(Trim(mLinkField)) Then
            lngID = Val(vsfgDetails.TextMatrix(vsfgDetails.Row, Inc))
            Exit For
        End If
    Next Inc
    '--------------------------
    mblnSubFormShown = True
    Select Case Trim(mLinkForm)
    Case "frmProcedure"
        ShowFormInMDI "frmProcedure", "Procedures"
    End Select
    RefreshGrid
    ZOrder vbBringToFront
End Sub

Private Sub tbrOkCancel_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case UCase(Button.Key)
        Case "OK"
            ReturnValue
        Case "CANCEL"
            ReturnValue True
    End Select
End Sub

Public Function Find(Query As String, RetField As String, SearchFields As String, ColWidth As String, Optional ResultCtrl As Object = Nothing, Optional SearchTypeName As String = "Find", _
                     Optional fndCtrl As Control = Nothing, Optional StartSearch As String, Optional SearchTypeId As Long = 0, Optional IsSelectable As Boolean = False, Optional strSelectionField As String = "", _
                     Optional ShowTools As Boolean = True, Optional LinkMenu As String = "", Optional LinkForm As String = "", Optional LinkField As String = "", Optional LinkCaption As String = "", _
                     Optional SearchMethod As SearchMethods = cnstSearchMethodNone, Optional strSelectedValues As String = "") As String   'Req No:157/07-03
'This is the calling point of the process; This will return the user selection to the calling point
On Local Error Resume Next
    mQuery = Query: mColWidth = ColWidth: mRetField = RetField: mSearchFields = SearchFields: Set mfndCtrl = fndCtrl
    mFilter = "": mRetValue = "": mSearchTypeId = SearchTypeId: mSelectionField = strSelectionField: mIsSelectable = IsSelectable: mShowTools = ShowTools
    mLinkMenu = LinkMenu: mLinkForm = LinkForm: mLinkField = LinkField: mLinkCaption = LinkCaption: mSearchMethod = SearchMethod
    arrFieldNames = Split(mSearchFields, ",")
    'Req No:157/07-03
    mstrSelectedValues = strSelectedValues
    Set mResultCtrl = ResultCtrl
    If mShowTools Then 'Toolbar privilage
        If Trim(LinkForm) <> "" Then
            Select Case Trim(LinkForm)
            Case "frmVchrGeneral"
                tbrCtrls.Visible = True
            Case Else
                If Trim(LinkMenu) = "" Then
                    tbrCtrls.Visible = False
                Else
                    tbrCtrls.Visible = MDIFormMain.Controls(LinkMenu).Enabled
                End If
            End Select
        Else
            tbrCtrls.Visible = False
        End If
    Else
        tbrCtrls.Visible = False
    End If
    If SearchTypeName = "-1" Then
        Caption = ""
    Else
        Caption = SearchTypeName
    End If
    If BindToArray(vsfgDetails, ColWidth, SearchFields, True) Then
        Call ConfigureSelectionGrid
        mCanRefresh = True
        txtSearch = StartSearch
        Select Case mSearchMethod
            Case cnstSearchMethodNone
                Show
                Visible = True
                ZOrder vbBringToFront
            Case cnstSearchMethodInvisibleExecAndRetFirstResult
                ReturnValue
            Case cnstSearchMethodInvisibleExecIfOneAndRetFirstResult
                If vsfgDetails.Rows = 3 Then
                    ReturnValue
                Else
                    Show
                    Visible = True
                    ZOrder vbBringToFront
                End If
        End Select
        
        While Visible
            DoEvents
        Wend
        If mReturned Then
            If mResultCtrl Is Nothing Then
                Find = mRetValue
            Else
                On Error Resume Next
                Dim strResults() As String, strCols() As String, Inc As Long
                If mRetValue <> "-1" Then
                    strResults = Split(mRetValue, "|")
                    strCols = Split(mRetCols, ",")
                    If TypeOf mResultCtrl Is VSFlexGrid Then
                        For Inc = 0 To UBound(strResults)
                            mResultCtrl.TextMatrix(mResultCtrl.Row, strCols(Inc)) = strResults(Inc)
                            If mResultCtrl.Col = strCols(Inc) Then
                                mResultCtrl.EditText = strResults(Inc)
                            End If
                        Next Inc
                        Find = "1"
                    Else
                        fndCtrl.Tag = strResults(2)
                        mResultCtrl.Tag = strResults(1)
                        mResultCtrl.Text = strResults(0)
                        Find = ""
                        For Inc = 3 To UBound(strResults)
                            If Find = "" Then
                                Find = strResults(Inc)
                            Else
                                Find = Find & "|" & strResults(Inc)
                            End If
                        Next Inc
                    End If
                Else
                    Find = "-1"
                End If
            End If
        Else
            Find = "-1"
        End If
    Else
        Find = "-1"
    End If
    Unload Me
End Function

Public Function BindToArray(VSFG As VSFlexGrid, ColWidth As String, Search As String, Optional IsFirst As Boolean = False) As Boolean
'This will execute and bind the data to grid and return True in success.
On Local Error GoTo Err_Exit
Dim Arr As Variant, Inc As Long, Inc1 As Long, strWidth() As String, strSearch() As String, strDataWidth As Long, strTmpCaption As String
Dim strTmp As String, strTmpSearch As String
    'Keeping Search By In Reistry
    If Not IsFirst Then SetIniString CStr(mSearchTypeId), cmbSearchBy.Text, "Find"
    strWidth = Split(ColWidth, ",")
    strSearch = Split(Search, ",")
    mExeQuery = Replace(mQuery, " @@ ", mFilter)
    mExeQuery = Trim(mExeQuery)
    If IsFirst Then
        mlngShowFirst = Val(GetIniString(CStr(mSearchTypeId), "1000", "FindRecordCount"))
        txtShowFirst = IIf(mlngShowFirst = 0, "-", mlngShowFirst)
    End If
    If mlngShowFirst > 0 Then
        mExeQuery = "SELECT TOP " & mlngShowFirst & " " & Mid(mExeQuery, 7)
    End If
    VSFG.Clear: VSFG.Rows = 1
    Set VSFG.DataSource = Nothing
    If pServer = pServerLocal Then
        AdodcTmp.UserName = "sa"
        AdodcTmp.Password = pCnnPassword
    Else
        AdodcTmp.UserName = "sa"
        AdodcTmp.Password = pCnnPassword
    End If
    AdodcTmp.ConnectionString = AdoConn.ConnectionString
    AdodcTmp.RecordSource = mExeQuery
    AdodcTmp.Refresh
    If Not AdodcTmp.Recordset.EOF Then
        VSFG.WallPaper = Nothing
        Set VSFG.DataSource = AdodcTmp
        For Inc = 0 To VSFG.Cols - 1
            VSFG.ColWidth(Inc) = Val(strWidth(Inc))
            '---Reading GET_ function for column caption
            If InStr(1, AdodcTmp.Recordset.Fields(Inc).Name, "GET_") <> 0 Then
                If IsFirst Then
                    strTmpCaption = AdodcTmp.Recordset.Fields(Inc).Name
                    If InStr(1, strTmpCaption, "$") <> 0 Then
                        strTmp = Mid(strTmpCaption, InStr(1, strTmpCaption, "$"))
                        strTmpSearch = Trim(UCase(Replace(strTmp, "$", "")))
                        For Inc1 = 0 To AdodcTmp.Recordset.Fields.Count - 1
                            If Trim(UCase(AdodcTmp.Recordset.Fields(Inc1).Name)) = strTmpSearch Then
                                strTmpCaption = Replace(strTmpCaption, strTmp, VSFG.TextMatrix(1, Inc1))
                                Exit For
                            End If
                        Next Inc1
                    End If
                    '---After Getting Actual GET_ Command Excecuting it
                    strTmp = GetNewColumnName(strTmpCaption)
                    If strTmp <> "" Then
                        VSFG.TextMatrix(0, Inc) = GetNewColumnName(strTmpCaption)
                    Else
                        VSFG.TextMatrix(0, Inc) = AdodcTmp.Recordset.Fields(Inc).Name
                    End If
                    arrColNames(0, Inc) = AdodcTmp.Recordset.Fields(Inc).Name 'xx
                    arrColNames(1, Inc) = VSFG.TextMatrix(0, Inc)
                    '---Still Column name not find out then it is an invisible column
                    If InStr(1, VSFG.TextMatrix(0, Inc), "GET_") <> 0 Then
                        VSFG.ColWidth(Inc) = 0
                    End If
                Else
                    VSFG.TextMatrix(0, Inc) = arrColNames(1, Inc)
                    If InStr(1, VSFG.TextMatrix(0, Inc), "GET_") <> 0 Then
                        VSFG.ColWidth(Inc) = 0
                    End If
                End If
            Else 'If Not GET_
                VSFG.TextMatrix(0, Inc) = AdodcTmp.Recordset.Fields(Inc).Name
            End If
            If mIsSelectable Then
                If VSFG.TextMatrix(0, Inc) = "Selected" Then
                    VSFG.ColDataType(Inc) = flexDTBoolean
                End If
            End If
        Next
        'Filling 'Search By' Fields and fixing form diamentions at the First Time
        If IsFirst Then
            'Adjusting Height according to Row data
            If VSFG.Rows < mMaxRows Then
                VSFG.Height = (IIf(VSFG.Rows < mMinRows, mMinRows, VSFG.Rows) * 240) + 60
                If Caption = "" Then
                    Height = VSFG.Height + 930
                Else
                    Height = VSFG.Height + 1240
                End If
                tbrCtrls.Top = VSFG.Top + VSFG.Height + 30
                tbrOkCancel.Top = VSFG.Top + VSFG.Height
                lblShowFirst.Top = tbrOkCancel.Top + 250
                txtShowFirst.Top = lblShowFirst.Top + 10
            End If
            'Adjusting width according to total cols width
            strDataWidth = VSFG.Cell(flexcpLeft, 1, VSFG.Cols - 1) + VSFG.Cell(flexcpWidth, 1, VSFG.Cols - 1)
            If strDataWidth > mMinColsWidth Then
                If strDataWidth > mMaxColsWidth Then
                    strDataWidth = mMaxColsWidth
                Else
                    strDataWidth = strDataWidth + 250
                End If
                VSFG.Width = strDataWidth + 30
                Width = VSFG.Width + 100
                tbrOkCancel.Left = Width - tbrOkCancel.Width - 100
                lblShowFirst.Left = tbrOkCancel.Left - (lblShowFirst.Width + 100)
                txtShowFirst.Left = lblShowFirst.Left + 730
                cmbSearchBy.Left = Width - cmbSearchBy.Width - 60
                lblSearchBy.Left = cmbSearchBy.Left - lblSearchBy.Width - 100
                
                txtSearch.Width = strDataWidth * 0.6
            End If
            '---Positioning---------------------------
            If mfndCtrl Is Nothing Then
                SetFormPosition Me, SFPAccordingToCursor
            Else
                SetFormPosition Me, SFPAccordingToControl, mfndCtrl
            End If
            If Not (mResultCtrl Is Nothing) Then
                If TypeOf mResultCtrl Is VSFlexGrid Then
                    SetFormPosition Me, SFPAccordingToCell, mResultCtrl
                End If
            End If
            '---Getting Search By Fields--------------
            cmbSearchBy.AddItem "Any Key"
            cmbSearchBy.Text = "Any Key"
            For Inc = 0 To VSFG.Cols - 1
                If VSFG.ColWidth(Inc) > 0 Then
                    If VSFG.TextMatrix(0, Inc) <> "Selected" Then
                        cmbSearchBy.AddItem VSFG.TextMatrix(0, Inc)
                    End If
                End If
            Next
            GetLastSearchBy
        End If
    Else
        If IsFirst Then
            ReturnValue True
            pMVE.MsgBox "No Records available for searching.", , , msgInformation, True
            BindToArray = False
            Exit Function
        End If
        VSFG.Rows = 1
        VSFG.WallPaper = MDIFormMain.imgWallpaper.ListImages(1).Picture
        For Inc = 0 To VSFG.Cols - 1
            VSFG.ColWidth(Inc) = Val(strWidth(Inc))
            VSFG.TextMatrix(0, Inc) = AdodcTmp.Recordset.Fields(Inc).Name
            If Trim(arrColNames(1, Inc)) <> "" Then
                VSFG.TextMatrix(0, Inc) = arrColNames(1, Inc)
            End If
        Next
    End If
'    vsfg.AddItem "", 1
'    vsfg.RowHeight(1) = 0
'    For Inc = 0 To vsfg.Cols - 1
'        vsfg.TextMatrix(1, Inc) = strSearch(Inc)
'    Next
    'Req No:157/07-03
    Dim lngRow As Long
    If mIsSelectable And mlngIDCol > -1 Then
        For Inc = 1 To vsfgDetails.Rows - 1
            lngRow = vsfgSelection.FindRow(vsfgDetails.TextMatrix(Inc, mlngIDCol), , mlngIDCol)
            If lngRow > -1 Then
                If vsfgSelection.Cell(flexcpChecked, lngRow, 0) = flexChecked Then
                    vsfgDetails.Cell(flexcpChecked, Inc, 0) = flexChecked
                End If
            End If
        Next Inc
    End If
    mCanRefresh = False
    BindToArray = True
Exit Function
Err_Exit:
    ShowError
    BindToArray = False
End Function

Private Sub ConfigureSelectionGrid()
'Req No:157/07-03
Dim ColInc As Long, crsTmp As New clsRecordSet, RowInc As Long, lngRow As Long
    If mIsSelectable Then
        Call GetIDCol
        With vsfgSelection
            .Cols = vsfgDetails.Cols
            .Width = vsfgDetails.Width
            For ColInc = 0 To vsfgDetails.Cols - 1
                .ColAlignment(ColInc) = vsfgDetails.ColAlignment(ColInc)
                .ColDataType(ColInc) = vsfgDetails.ColDataType(ColInc)
                .ColFormat(ColInc) = vsfgDetails.ColFormat(ColInc)
                .ColHidden(ColInc) = vsfgDetails.ColHidden(ColInc)
                .ColWidth(ColInc) = vsfgDetails.ColWidth(ColInc)
            Next ColInc
            If mlngIDCol > -1 Then
                If mstrSelectedValues = "" Then 'Req No:209/07-02
                    mstrSelectedValues = "0"
                End If
                mExeQuery = Replace(mQuery, " @@ ", " WHERE " & mstrIDColCaption & " IN (" & mstrSelectedValues & ")")
                crsTmp.BindRecords mExeQuery, AdoConn
                If Not crsTmp.BOF Then
                    .Rows = crsTmp.Rows
                End If
                For RowInc = 0 To crsTmp.Rows - 1
                    For ColInc = 0 To crsTmp.Cols - 1
                        .TextMatrix(RowInc, ColInc) = crsTmp.TextMatrix(RowInc, ColInc)
                        Select Case ColInc
                        Case 0
                            .Cell(flexcpChecked, RowInc, 0) = flexChecked
                        Case mlngIDCol
                            lngRow = vsfgDetails.FindRow(.TextMatrix(RowInc, ColInc), , ColInc)
                            If lngRow > -1 Then
                                vsfgDetails.Cell(flexcpChecked, lngRow, 0) = flexChecked
                            End If
                        End Select
                    Next ColInc
                Next RowInc
                crsTmp.Clear
            End If
            'If .Rows > 0 Then
                '.Visible = True
            'End If
        End With
    End If
End Sub

Public Sub GetLastSearchBy()
On Local Error GoTo Err_Exit
Dim strAdvSearch As String
    cmbSearchBy.Text = GetIniString(CStr(mSearchTypeId), "Any Key", "Find")
    strAdvSearch = GetIniString(CStr(mSearchTypeId), "Off", "Find%")
    chkAdvancedSearch = IIf(strAdvSearch = "On", vbChecked, vbUnchecked)
    chkAdvancedSearch_Click
Err_Exit:
End Sub

Public Sub RefreshGrid()
On Local Error Resume Next
Dim Inc As Long, IncSub As Long, Col As Long, strSearch As String, strTmp() As String, strAdvSearch As String
Dim mOprator As String
    strSearch = txtSearch
    strAdvSearch = IIf(chkAdvancedSearch = vbChecked, "%", "")
    strSearch = IIf(chkAdvancedSearch = vbChecked, Replace(strSearch, " ", "%"), strSearch)
    strTmp = Split(strSearch, "|")
    mFilter = " Where"
    With vsfgDetails
        If UCase(cmbSearchBy) = UCase("Any Key") Then 'Any Key
            For IncSub = 0 To UBound(strTmp) 'Each Sub search items
                strSearch = Replace(strTmp(IncSub), "'", "' + CHAR(39)+ '")
                If strSearch <> "" Then
                    mFilter = mFilter & "And ("
                    For Inc = 0 To .Cols - 1
                        If UCase(Left(Trim(arrFieldNames(Inc)), 1)) <> "X" Then
                            mFilter = mFilter & "Or " & Trim(arrFieldNames(Inc)) & " Like '" & strAdvSearch & strSearch & "%' "
                        End If
                    Next Inc
                    mFilter = mFilter & ")"
                End If
            Next IncSub
        Else
            For Inc = 0 To .Cols - 1
                If UCase(Trim(.TextMatrix(0, Inc))) = UCase(cmbSearchBy) Then
                    Col = Inc
                    Exit For
                End If
            Next Inc
            If UCase(Left(Trim(arrFieldNames(Col)), 1)) <> "X" Then
                mFilter = mFilter & "Or " & Trim(arrFieldNames(Col)) & " Like '" & strAdvSearch & strSearch & "%' "
            End If
        End If
        If Trim(txtSearch) = "" Then
            mFilter = ""
        End If
    End With
    mFilter = Replace(mFilter, "WhereOr", "Where")
    mFilter = Replace(mFilter, "WhereAnd", "Where")
    mFilter = Replace(mFilter, "(Or", "(")
    BindToArray vsfgDetails, mColWidth, mSearchFields
    If vsfgDetails.Rows >= 1 Then
        vsfgDetails.Row = 1
        SelectRow vsfgDetails
    End If
End Sub

Public Sub ReturnValue(Optional Cancel As Boolean = False)
'This is the return point of the local process
On Local Error GoTo Err_Exit
Dim Col As Long, Inc As Long, strTmp() As String, arrInc As Long
    mRetValue = ""
    If Cancel Then
        mRetValue = "-1"
    Else
        If mIsSelectable Then
            With vsfgSelection
                'Req No:157/07-03
                'Multiple row value selection return
                'strTmp = Split(mSelectionField, ",")
                'For Inc = 0 To .Cols - 1
                '    If UCase(Trim(.TextMatrix(0, Inc))) = UCase(Trim(strTmp(0))) Then
                '        Col = Inc
                '        Exit For
                '    End If
                'Next Inc
                Col = mlngIDCol
                For Inc = 0 To .Rows - 1
                    If .TextMatrix(Inc, 0) = "-1" Then
                        mRetValue = mRetValue & .TextMatrix(Inc, Col) & "|"
                    End If
                Next Inc
                'Req No:113/07-01
                'mRetValue = mRetValue & .TextMatrix(.Row, Col) & "|"
                If mRetValue = "" Then
                    pMVE.MsgBox "Invalid selection"
                End If
            End With
        Else
            With vsfgDetails
                'Multiple col value selection return
                SplitRetCol mRetField, mRetCols
                strTmp = Split(mRetField, ",")
                For arrInc = 0 To UBound(strTmp)
                    For Inc = 0 To .Cols - 1
                        If UCase(Trim(.TextMatrix(0, Inc))) = UCase(Trim(strTmp(arrInc))) Then
                            Col = Inc
                            Exit For
                        End If
                    Next Inc
                    mRetValue = mRetValue & .TextMatrix(.Row, Col) & "|"  '.TextMatrix(IIf(.Row = 1, 2, .Row), Col) & "|"
                Next arrInc
            End With
        End If
        mRetValue = Left(mRetValue, Len(mRetValue) - 1)
    End If
    mReturned = True
    Hide
Exit Sub
Err_Exit:
    mRetValue = "-1"
    mReturned = True
    Hide
End Sub

Public Sub SplitRetCol(ByRef mRetFieldRef As String, ByRef mRetColsRef As String)
Dim tmpStr As String, strData() As String, Inc As Long
Dim tmpField As String, tmpCols As String
    strData = Split(mRetFieldRef, ",")
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(") = 0 Then
            tmpField = tmpField & tmpStr & ","
        Else
            tmpField = tmpField & Left(tmpStr, InStr(1, tmpStr, "(") - 1) & ","
        End If
    Next
    
    For Inc = 0 To UBound(strData)
        tmpStr = strData(Inc)
        If InStr(1, tmpStr, "(") = 0 Then
            tmpCols = tmpCols & "0,"
        Else
            tmpCols = tmpCols & RVal(Mid(tmpStr, InStr(1, tmpStr, "(") + 1)) & ","
        End If
    Next

    tmpField = Left(tmpField, Len(tmpField) - 1)
    mRetFieldRef = tmpField
    tmpCols = Left(tmpCols, Len(tmpCols) - 1)
    mRetColsRef = tmpCols
End Sub

Private Sub tmrKey_Timer()
    mCanRefresh = True
End Sub

Private Sub txtSearch_Change()
    RefreshGrid
End Sub

Private Sub txtSearch_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error Resume Next
    If KeyCode = vbKeyDown Then
        vsfgDetails.Row = 2 'IIf(vsfgDetails.Rows > 3, 3, 2)
        vsfgDetails.SetFocus
    ElseIf KeyCode = vbKeyReturn Then
        vsfgDetails.Row = 1
        vsfgDetails.Col = 0
        vsfgDetails.SetFocus
        ReturnValue
    End If
End Sub

Private Sub txtShowFirst_Change()
    If Visible Then
        SetIniString CStr(mSearchTypeId), Val(txtShowFirst), "FindRecordCount"
        mlngShowFirst = Val(txtShowFirst)
        RefreshGrid
    End If
End Sub

Private Sub GetIDCol()
On Local Error Resume Next
    Dim strTmp() As String, ColInc As Long
    mlngIDCol = -1
    mstrIDColCaption = ""
    If mIsSelectable Then
        strTmp = Split(mSelectionField, ",")
        For ColInc = 0 To vsfgDetails.Cols - 1
            If UCase(Trim(vsfgDetails.TextMatrix(0, ColInc))) = UCase(Trim(strTmp(0))) Then
                mlngIDCol = ColInc
                mstrIDColCaption = UCase(Trim(strTmp(0)))
                Exit For
            End If
        Next ColInc
    End If
End Sub

Private Sub vsfgDetails_AfterEdit(ByVal Row As Long, ByVal Col As Long)
    'Req No:157/07-03
On Local Error Resume Next
Dim RowInc As Long, ColInc As Long
    If Col = 0 And mIsSelectable Then
        With vsfgSelection
            .Visible = False
            If vsfgDetails.Cell(flexcpChecked, Row, Col) = flexChecked Then
                .Rows = .Rows + 1
                RowInc = .Rows - 1
                For ColInc = 0 To .Cols - 1
                    .TextMatrix(RowInc, ColInc) = vsfgDetails.TextMatrix(Row, ColInc)
                Next ColInc
            Else
                If mlngIDCol > -1 Then
                    For RowInc = .Rows - 1 To 0 Step -1
                        If .TextMatrix(RowInc, mlngIDCol) = vsfgDetails.TextMatrix(Row, mlngIDCol) Then
                            If .Rows = 1 Then
                                .Rows = 0
                            Else
                                .RemoveItem RowInc
                            End If
                        End If
                    Next RowInc
                End If
            End If
            'If .Rows > 0 Then
                '.Visible = True
            'End If
        End With
    End If
End Sub

Private Sub vsfgDetails_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    If vsfgDetails.ColDataType(Col) <> flexDTBoolean Then
        Cancel = True
    End If
End Sub

Private Sub vsfgDetails_DblClick()
    ReturnValue
End Sub

Private Sub vsfgDetails_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        ReturnValue
    ElseIf KeyCode = vbKeyUp Then
        On Error Resume Next
        If vsfgDetails.Row = 1 Then
            txtSearch.SetFocus
            Highlight
        End If
    ElseIf KeyCode = vbKeySpace Then
        If mIsSelectable Then
            If vsfgDetails.ColDataType(0) = flexDTBoolean Then
                If vsfgDetails.TextMatrix(vsfgDetails.Row, 0) = "-1" Then
                    vsfgDetails.TextMatrix(vsfgDetails.Row, 0) = "0"
                Else
                    vsfgDetails.TextMatrix(vsfgDetails.Row, 0) = "-1"
                End If
                SendKeys "{DOWN}"
            End If
        End If
    End If
End Sub

Private Sub vsfgDetails_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim Inc As Long, strSelect As String
    If mIsSelectable Then
        With vsfgDetails
            If .ColDataType(0) = flexDTBoolean Then
                If .Row <> .RowSel Or .Col <> .ColSel Then
                    For Inc = .Row To .RowSel
                        'Req No:113/07-01
                        If Inc = .Row Then
                            If .TextMatrix(Inc, 0) = "-1" Then
                                strSelect = "0"
                            Else
                                strSelect = "-1"
                            End If
                        End If
                        .TextMatrix(Inc, 0) = strSelect
                        'Req No:157/07-03
                        vsfgDetails_AfterEdit Inc, 0
                        'Req No:113/07-01
                        'If .TextMatrix(Inc, 0) = "-1" Then
                        '    .TextMatrix(Inc, 0) = "0"
                        'Else
                        '    .TextMatrix(Inc, 0) = "-1"
                        'End If
                    Next
                End If
            End If
        End With
    End If
End Sub

Private Sub vsfgDetails_RowColChange()
    vsfgDetails.ToolTipText = vsfgDetails.Text
    'Coding for cell movement; because of HSScroll bar removal
    If (vsfgDetails.CellLeft + vsfgDetails.CellWidth) > (Width + 100) Then
        vsfgDetails.LeftCol = vsfgDetails.Col
    ElseIf vsfgDetails.CellLeft <= 0 And vsfgDetails.Col >= 0 Then
        vsfgDetails.LeftCol = vsfgDetails.Col
    End If
    SelectRow vsfgDetails
End Sub
