VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmConvertWizard 
   Caption         =   "Convert Data"
   ClientHeight    =   7305
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9960
   Icon            =   "frmConvertWizard.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7305
   ScaleWidth      =   9960
   Begin TabDlg.SSTab SSTabMain 
      Height          =   7740
      Left            =   0
      TabIndex        =   0
      Top             =   -360
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   13653
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      TabCaption(0)   =   "Connection"
      TabPicture(0)   =   "frmConvertWizard.frx":030A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "frame1"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "cmdBack1"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "cmdNext1"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "cmdCancel(0)"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "CD"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "Account Data"
      TabPicture(1)   =   "frmConvertWizard.frx":0326
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "frame2"
      Tab(1).Control(1)=   "cmdCancel(1)"
      Tab(1).Control(2)=   "cmdBack2"
      Tab(1).Control(3)=   "cmdNext2"
      Tab(1).ControlCount=   4
      Begin VB.CommandButton cmdNext2 
         Caption         =   "Convert"
         Height          =   360
         Left            =   -67530
         TabIndex        =   19
         Top             =   7260
         Width           =   1110
      End
      Begin VB.CommandButton cmdBack2 
         Caption         =   "Back"
         Height          =   360
         Left            =   -68625
         TabIndex        =   20
         Top             =   7260
         Width           =   1110
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "Cancel"
         Height          =   360
         Index           =   1
         Left            =   -66285
         TabIndex        =   18
         Top             =   7260
         Width           =   1110
      End
      Begin VB.Frame frame2 
         Height          =   6780
         Left            =   -74865
         TabIndex        =   17
         Top             =   405
         Width           =   9735
         Begin VSFlex8Ctl.VSFlexGrid vsfgAccountDetails 
            Height          =   6510
            Left            =   75
            TabIndex        =   21
            Top             =   195
            Width           =   9585
            _cx             =   16907
            _cy             =   11483
            Appearance      =   2
            BorderStyle     =   1
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
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
            Cols            =   13
            FixedRows       =   2
            FixedCols       =   0
            RowHeightMin    =   0
            RowHeightMax    =   0
            ColWidthMin     =   0
            ColWidthMax     =   0
            ExtendLastCol   =   -1  'True
            FormatString    =   $"frmConvertWizard.frx":0342
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
      End
      Begin MSComDlg.CommonDialog CD 
         Left            =   240
         Top             =   5265
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "Cancel"
         Height          =   360
         Index           =   0
         Left            =   8715
         TabIndex        =   4
         Top             =   7260
         Width           =   1110
      End
      Begin VB.CommandButton cmdNext1 
         Caption         =   "Next"
         Height          =   360
         Left            =   7470
         TabIndex        =   3
         Top             =   7260
         Width           =   1110
      End
      Begin VB.CommandButton cmdBack1 
         Caption         =   "Back"
         Enabled         =   0   'False
         Height          =   360
         Left            =   6375
         TabIndex        =   2
         Top             =   7260
         Width           =   1110
      End
      Begin VB.Frame frame1 
         Height          =   6705
         Left            =   135
         TabIndex        =   1
         Top             =   405
         Width           =   9735
         Begin VB.Frame frameDestination 
            Caption         =   "Destination"
            Height          =   1725
            Left            =   105
            TabIndex        =   9
            Top             =   2475
            Width           =   9510
            Begin VB.ComboBox cmbDestinationPeriod 
               Height          =   315
               Left            =   300
               Style           =   2  'Dropdown List
               TabIndex        =   13
               Top             =   1215
               Width           =   3180
            End
            Begin VB.ComboBox cmbDestinationCompany 
               Height          =   315
               ItemData        =   "frmConvertWizard.frx":0540
               Left            =   300
               List            =   "frmConvertWizard.frx":0542
               TabIndex        =   11
               Text            =   "cmbDestinationCompany"
               Top             =   480
               Width           =   5595
            End
            Begin VB.Label Label3 
               AutoSize        =   -1  'True
               Caption         =   "Period"
               Height          =   195
               Left            =   300
               TabIndex        =   12
               Top             =   990
               Width           =   450
            End
            Begin VB.Label Label2 
               AutoSize        =   -1  'True
               Caption         =   "Company"
               Height          =   195
               Left            =   285
               TabIndex        =   10
               Top             =   255
               Width           =   660
            End
         End
         Begin VB.Frame frameSource 
            Caption         =   "Source"
            Height          =   1620
            Left            =   105
            TabIndex        =   5
            Top             =   555
            Width           =   9510
            Begin VB.CommandButton cmdRefresh 
               Caption         =   "Refresh"
               Height          =   300
               Left            =   8505
               TabIndex        =   16
               Top             =   465
               Width           =   705
            End
            Begin VB.ComboBox cmbSourcePeriod 
               Height          =   315
               Left            =   315
               Style           =   2  'Dropdown List
               TabIndex        =   14
               Top             =   1065
               Width           =   3180
            End
            Begin VB.CommandButton cmdBrowseSource 
               Caption         =   "..."
               Height          =   300
               Left            =   8100
               TabIndex        =   8
               Top             =   465
               Width           =   360
            End
            Begin VB.TextBox txtSource 
               Height          =   300
               Left            =   285
               TabIndex        =   7
               Top             =   465
               Width           =   7800
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Period"
               Height          =   195
               Left            =   315
               TabIndex        =   15
               Top             =   840
               Width           =   450
            End
            Begin VB.Label Label1 
               AutoSize        =   -1  'True
               Caption         =   "Database"
               Height          =   195
               Left            =   285
               TabIndex        =   6
               Top             =   255
               Width           =   690
            End
         End
      End
   End
End
Attribute VB_Name = "frmConvertWizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim AdoConnSource As New ADODB.Connection
Dim mSourceFyearID
Dim mDestinationCompanyID As Long, mDestinationPeriodID As Long

Const cnstTabConnection = 0
Const cnstTabAccount = 1

Const grdAcSourceSlNo = 0
Const grdAcSourceAcGrp = 1
Const grdAcSourceAcHead = 2
Const grdAcSourceAmount = 3
Const grdAcSourceAcID = 4
Const grdAcSourceGroupType = 5
Const grdAcSep = 6
Const grdAcDestAcGrp = 7
Const grdAcDestAcHead = 8
Const grdAcDestAmount = 9
Const grdAcDestIsCreate = 10
Const grdAcDestAcID = 11
Const grdAcDestAcTypeID = 12

Private Sub cmbDestinationCompany_Click()
Dim sSql As String
    '---Loading Periods---------------
    sSql = "Select '' AS NameField, 0 AS IDField From Periods UNION " & _
           "SELECT  CONVERT(VARCHAR, CONVERT(DATETIME, StartDt - 2, 103), 103) + ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, EndDt - 2, 103), 103) AS NameField, PeriodID AS IDField FROM Periods Where CompanyID = " & GetComboBoundValue(cmbDestinationCompany)
    SetComboList cmbDestinationPeriod, sSql
End Sub

Private Sub cmdBack2_Click()
    SSTabMain.Tab = cnstTabConnection
End Sub

Private Sub cmdBrowseSource_Click()
On Local Error Resume Next
    CD.Filter = "eAudit 2007 Format *.aud|*.aud"
    CD.ShowOpen
    If Dir(CD.FileName) <> "" Then
        txtSource = CD.FileName
    End If
End Sub

Private Sub cmdCancel_Click(Index As Integer)
    If pMVE.MsgBox("Are you sure to cancel this wizard?", msgYesNo, "AuditMate", msgQuestion, True) Then
        MDIFormMain.CloseActiveTabForm
    End If
End Sub

Private Sub cmdNext1_Click()
Dim IsPass As Boolean
    IsPass = True
    mSourceFyearID = 0
    mDestinationCompanyID = 0
    mDestinationPeriodID = 0
    
    If AdoConnSource.State <> adStateOpen Then
        IsPass = False
    Else
        mSourceFyearID = GetComboBoundValue(cmbSourcePeriod)
        mDestinationCompanyID = GetComboBoundValue(cmbDestinationCompany)
        mDestinationPeriodID = GetComboBoundValue(cmbDestinationPeriod)
        If mSourceFyearID = 0 Or _
            mDestinationCompanyID = 0 Or _
                mDestinationPeriodID = 0 Then
            IsPass = False
        End If
    End If
    
    If Not IsPass Then
        pMVE.MsgBox "Could not continue. Some connection parameters are missing.", msgOK, , msgCritical, True
    Else
        FillAccountsData
        SSTabMain.Tab = cnstTabAccount
    End If
End Sub

Private Sub FillAccountsData()
On Local Error GoTo Err_Exit
Dim sSql As String, Inc As Long, dblAmount As Double, strTmp As String
    Screen.MousePointer = vbHourglass
    sSql = "SELECT AG.AcGrpName, AM.AcName, AcBal.Amount, AcBal.DrCr, AcBal.AcCode, AG.GrpType " & _
           "FROM AcGroups AS AG INNER JOIN (AcMastertFYearBalance AS AcBal INNER JOIN AcMaster AS AM ON AcBal.AcCode = AM.AcCode) ON AG.AcGrpCode = AM.AcGrpCode " & _
           "Where AcBal.FYear = " & mSourceFyearID & " ORDER BY AG.TreeLevel;"
    vsfgAccountDetails.Rows = 2
    Inc = 2
    With GetRecords(sSql, AdoConnSource)
        While Not .EOF
            vsfgAccountDetails.Rows = vsfgAccountDetails.Rows + 1
            
            '---Source Section-------------------------------------------------
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceSlNo) = Inc - 1
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceAcGrp) = .Fields("AcGrpName") & ""
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceAcHead) = .Fields("AcName") & ""
            dblAmount = RVal(.Fields("Amount") & "")
            If .Fields("DrCr") & "" = "C" Then
                dblAmount = dblAmount * -1
                vsfgAccountDetails.Cell(flexcpForeColor, Inc, grdAcSourceAmount) = vbRed
            End If
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceAmount) = dblAmount
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceAcID) = Val(.Fields("AcCode") & "")
            vsfgAccountDetails.TextMatrix(Inc, grdAcSourceGroupType) = IIf(Trim(.Fields("GrpType") & "") = "C", "Credit", "Debit")
            
            '---Destination Section--------------------------------------------
            strTmp = Trim(.Fields("AcGrpName") & "")
'            sSql = "SELECT AT.AcTypeName, AH.AcName, ESA.DAmt, ESA.CAmt, AH.AcID " & _
                   "FROM Entries EM INNER JOIN EntrySubAccounts ESA ON EM.EntryID = ESA.EntryID RIGHT OUTER JOIN " & _
                   "AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID ON ESA.AcID = AH.AcID " & _
                   "Where (EM.IsOpening = 1) AND (UPPER(RTRIM(LTRIM(AH.AcName))) = " & FormatValue(UCase(Trim(.Fields("AcName") & ""))) & ") And (AH.CompanyID = " & mDestinationCompanyID & ") And (EM.PeriodID = " & mDestinationPeriodID & ")"
            sSql = "SELECT AT.AcTypeName, AH.AcName, AH.AcID FROM AcHeads AH LEFT OUTER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID " & _
                   "WHERE (UPPER(RTRIM(LTRIM(AH.AcName))) = " & FormatValue(UCase(Trim(.Fields("AcName") & ""))) & ") AND (AH.CompanyID = " & mDestinationCompanyID & ")"
            With GetRecords(sSql)
                If Not .EOF Then
                    vsfgAccountDetails.TextMatrix(Inc, grdAcDestAcGrp) = .Fields("AcTypeName") & ""
                    vsfgAccountDetails.TextMatrix(Inc, grdAcDestAcHead) = .Fields("AcName") & ""
                    vsfgAccountDetails.TextMatrix(Inc, grdAcDestAcID) = Val(.Fields("AcID") & "")
                Else
                    '---Create True---------------------------
                    vsfgAccountDetails.TextMatrix(Inc, grdAcDestIsCreate) = -1

                    sSql = "SELECT AcTypeName, AcTypeID From AcTypes WHERE UPPER(RTRIM(LTRIM(AcTypeName))) = " & FormatValue(UCase(strTmp)) & " And (CompanyID = " & mDestinationCompanyID & ")"
                    With GetRecords(sSql)
                        If Not .EOF Then
                            vsfgAccountDetails.TextMatrix(Inc, grdAcDestAcGrp) = .Fields("AcTypeName") & ""
                            vsfgAccountDetails.TextMatrix(Inc, grdAcDestAcTypeID) = Val(.Fields("AcTypeID") & "")
                        End If
                        .Close
                    End With
                End If
                .Close
            End With
            vsfgAccountDetails.TopRow = Inc
            Inc = Inc + 1
            .MoveNext
        Wend
        .Close
    End With
    vsfgAccountDetails.Cell(flexcpBackColor, 0, grdAcSep, vsfgAccountDetails.Rows - 1, grdAcSep) = RGB(200, 200, 200)
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    Screen.MousePointer = vbDefault
    ShowError
End Sub

Private Sub cmdNext2_Click()
On Local Error GoTo Err_Exit
Dim Inc As Long, lngAcTypeID As Long, lngAcID As Long, lngEntryID As Long
Dim lngAcSlNo As Long, dblDAmt As Double, dblCAmt As Double, Inc1 As Long
Dim sSql As String
    Screen.MousePointer = vbHourglass
    '---Checking for Reload Template------------
    sSql = "Select Count(*)AS Num from AcTypes Where CompanyID = " & mDestinationCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            If Val(.Fields("Num") & "") = 0 Then
                MDIFormMain.SBar.Panels(1).Text = "Loading Templates..."
                ReOrganizeCompanyDefaultData mDestinationCompanyID
                FillAccountsData
                MDIFormMain.SBar.Panels(1).Text = "Ready"
            End If
        End If
        .Close
    End With
    '---Validate Account Data Convertion-------
    MDIFormMain.SBar.Panels(1).Text = "Converting Data..."
    If ValidateAccountDataConversion Then
        With vsfgAccountDetails
            lngEntryID = SaveEntry(mDestinationPeriodID, "Opening", ServerDateTime, cnstStatusActive, "", True)
            For Inc = 2 To .Rows - 1
                lngAcID = 0
                If .ValueMatrix(Inc, grdAcDestIsCreate) = -1 Then
                    '---Account Type Creation--------------------
                    lngAcTypeID = .ValueMatrix(Inc, grdAcDestAcTypeID)
                    If lngAcTypeID = 0 And .ValueMatrix(Inc, grdAcDestAcID) = 0 Then
                        lngAcTypeID = CreateAccountType(Inc, mDestinationCompanyID)
                        For Inc1 = Inc + 1 To .Rows - 1
                            If UCase(Trim(.TextMatrix(Inc1, grdAcSourceAcGrp))) = UCase(Trim(.TextMatrix(Inc, grdAcSourceAcGrp))) _
                                And UCase(Trim(.TextMatrix(Inc1, grdAcSourceAcGrp))) <> "" Then
                                
                                If .ValueMatrix(Inc1, grdAcDestAcTypeID) = 0 Then
                                    .TextMatrix(Inc1, grdAcDestAcTypeID) = lngAcTypeID
                                End If
                            End If
                        Next Inc1
                    End If
                    '---Account Head Creation--------------------
                    lngAcID = .ValueMatrix(Inc, grdAcDestAcID)
                    If lngAcID = 0 Then
                        lngAcID = CreateAccountHead(Inc, mDestinationCompanyID, lngAcTypeID)
                    End If
                End If
                If lngAcID = 0 Then
                    lngAcID = .ValueMatrix(Inc, grdAcDestAcID)
                End If
                lngAcSlNo = GetMaxNo("EntrySubAccounts", "AcSlNo", "EntryID = " & lngEntryID)
                dblDAmt = vsfgAccountDetails.ValueMatrix(Inc, grdAcSourceAmount)
                dblDAmt = IIf(dblDAmt > 0, dblDAmt, 0)
                dblCAmt = vsfgAccountDetails.ValueMatrix(Inc, grdAcSourceAmount)
                dblCAmt = IIf(dblCAmt < 0, dblCAmt, 0)
                SaveSubEntries lngEntryID, lngAcSlNo, lngAcID, dblDAmt, dblCAmt, ""
                vsfgAccountDetails.Cell(flexcpBackColor, Inc, 0, Inc, vsfgAccountDetails.Cols - 1) = RGB(220, 220, 250)
                vsfgAccountDetails.TopRow = Inc
                DoEvents
            Next Inc
        End With
    End If
    MDIFormMain.SBar.Panels(1).Text = "Ready"
    pMVE.MsgBox "Data converted successfully.", msgOK
    SSTabMain.Tab = cnstTabConnection
    Sleep 1000
    MDIFormMain.CloseActiveTabForm
    Screen.MousePointer = vbDefault
Exit Sub
Err_Exit:
    MDIFormMain.SBar.Panels(1).Text = "Ready"
    Screen.MousePointer = vbDefault
End Sub

Public Function CreateAccountHead(Row As Long, lngCompanyID As Long, lngAcTypeID As Long)
On Local Error GoTo Err_Exit
Dim clsAc As New clsAcHead, lngTmpID As Long
    clsAc.Clear
    With clsAc
        .CompanyID = lngCompanyID
        .AcHeadName = Trim(vsfgAccountDetails.TextMatrix(Row, grdAcSourceAcHead))
        .AcHeadCode = ""
        .AcTypeID = lngAcTypeID
        .TrialOrder = 0
        .StatusID = cnstStatusActive
        .Save lngTmpID
    End With
    CreateAccountHead = lngTmpID
Exit Function
Err_Exit:
    
End Function

Public Function CreateAccountType(Row As Long, lngCompanyID As Long)
On Local Error GoTo Err_Exit
Dim clsAc As New clsAcType, lngTmpID As Long
    clsAc.Clear
    With clsAc
        .CompanyID = lngCompanyID
        .AcTypeName = Trim(vsfgAccountDetails.TextMatrix(Row, grdAcSourceAcGrp))
        .AcTypeCode = ""
        .ParentAcTypeID = -1
        .TrialOrder = 1
        .RefNo = ""
        .TreeLevel = 5
        .AccDepAcTypeID = -1
        .AccCostAcTypeID = -1
        .DeductionAcTypeID = -1
        .AllocationAcTypeID = -1
        .TypeNature = vsfgAccountDetails.TextMatrix(Row, grdAcSourceGroupType) '"Debit"
        .StatusID = cnstStatusActive
        .Save lngTmpID
    End With
    CreateAccountType = lngTmpID
Exit Function
Err_Exit:
    
End Function

Public Function ValidateAccountDataConversion() As Boolean
On Local Error GoTo Err_Exit
Dim Inc As Long
    With vsfgAccountDetails
        For Inc = 2 To .Rows - 1
            If .ValueMatrix(Inc, grdAcSourceAcID) <> 0 And _
                .ValueMatrix(Inc, grdAcDestAcID) = 0 And .ValueMatrix(Inc, grdAcDestIsCreate) = 0 Then
                Exit Function
            End If
            If .ValueMatrix(Inc, grdAcSourceAcID) <> 0 And _
                .ValueMatrix(Inc, grdAcDestAcID) = 0 And _
                    .ValueMatrix(Inc, grdAcDestIsCreate) = 1 And _
                        .ValueMatrix(Inc, grdAcDestAcTypeID) <> 0 Then
                        Exit Function
                Exit Function
            End If
        Next Inc
        '-----------------------------------------------------
        ValidateAccountDataConversion = True
    End With
Exit Function
Err_Exit:
    
End Function

Private Sub cmdRefresh_Click()
On Local Error GoTo Err_Exit
Dim sSql As String
    If AdoConnSource.State = adStateOpen Then
        AdoConnSource.Close
    End If
    AdoConnSource.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & txtSource & ";Persist Security Info=False"
    
    If AdoConnSource.State = adStateOpen Then
        sSql = "SELECT FYear AS IDField, FYearDesc AS NameField FROM FYear;"
        SetComboList cmbSourcePeriod, sSql, , , , , AdoConnSource
    End If
Exit Sub
Err_Exit:
    pMVE.MsgBox Err.Description, msgOK, , msgCritical, False
End Sub

Private Sub Form_Load()
Dim sSql As String
    Height = 6270
    Width = 10080
    Align Me
    '---Loading Companies---------------
    sSql = "Select '' AS NameField, 0 AS IDField From Companies UNION " & _
           "SELECT CompanyName AS NameField, CompanyID AS IDField From Companies ORDER BY NameField"
    SetComboList cmbDestinationCompany, sSql
    '----------------------------------------------
    With vsfgAccountDetails
        .MergeCells = flexMergeFree
        .MergeRow(0) = True
        .Cell(flexcpAlignment, 0, 0, 0, .Cols - 1) = flexAlignCenterCenter
    End With
    SSTabMain.Tab = cnstTabConnection
End Sub

Private Sub txtSource_Change()
    If AdoConnSource.State = adStateOpen Then
        AdoConnSource.Close
    End If
    cmbSourcePeriod.Clear
End Sub

Private Sub vsfgAccountDetails_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
    Select Case Col
        Case grdAcDestAcGrp
        Case grdAcDestAcHead
        Case grdAcDestIsCreate
            If vsfgAccountDetails.ValueMatrix(Row, grdAcDestAcID) <> 0 Then
                Cancel = True
            End If
        Case Else
            Cancel = True
    End Select
End Sub

Private Sub vsfgAccountDetails_CellButtonClick(ByVal Row As Long, ByVal Col As Long)
On Local Error GoTo Err_Exit
    Select Case Col
    Case grdAcDestAcGrp
        If vsfgAccountDetails.ValueMatrix(Row, grdAcDestAcID) = 0 Then
            PrepareAndFind cnstSearchTypeGrpAccountTypes, "WHERE AT.CompanyID = " & mDestinationCompanyID, "Name(" & grdAcDestAcGrp & "), XAcTypeID(" & grdAcDestAcTypeID & ")", vsfgAccountDetails, , , , 1
        End If
    Case grdAcDestAcHead
        PrepareAndFind cnstSearchTypeGrpAccountHeads, "WHERE AH.CompanyID = " & mDestinationCompanyID, "Name(" & grdAcDestAcHead & "), Account Type(" & grdAcDestAcTypeID & "), XAcID(" & grdAcDestAcID & ")", vsfgAccountDetails, , , , 1
        If vsfgAccountDetails.ValueMatrix(Row, grdAcDestAcTypeID) = 0 Then
            vsfgAccountDetails.TextMatrix(Row, grdAcDestAcGrp) = vsfgAccountDetails.TextMatrix(Row, grdAcDestAcTypeID) 'PickValue("AcTypes", "AcTypeName", "AcTypeID = " & vsfgAccountDetails.ValueMatrix(Row, grdAcDestAcTypeID))
        End If
        vsfgAccountDetails.TextMatrix(Row, grdAcDestAcTypeID) = ""
        vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestIsCreate) = 0
    End Select
Exit Sub
Err_Exit:
    
End Sub

Private Sub vsfgAccountDetails_KeyDown(KeyCode As Integer, Shift As Integer)
On Local Error GoTo Err_Exit
    If KeyCode = vbKeyDelete Then
        Select Case vsfgAccountDetails.Col
        Case grdAcDestAcGrp
            If vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestAcTypeID) <> 0 Then
                vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestAcGrp) = ""
                vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestAcTypeID) = 0
            End If
        Case grdAcDestAcHead
            vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestAcHead) = ""
            vsfgAccountDetails.TextMatrix(vsfgAccountDetails.Row, grdAcDestAcID) = 0
        End Select
    End If
Exit Sub
Err_Exit:
    
End Sub

Private Sub vsfgAccountDetails_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    vsfgAccountDetails.ToolTipText = vsfgAccountDetails.Text
End Sub
