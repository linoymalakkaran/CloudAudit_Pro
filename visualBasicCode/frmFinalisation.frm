VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmFinalisation 
   Caption         =   "Finalise Period"
   ClientHeight    =   5220
   ClientLeft      =   120
   ClientTop       =   345
   ClientWidth     =   8250
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Cambria"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5220
   ScaleWidth      =   8250
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   120
      Top             =   4800
   End
   Begin VB.CommandButton cmdFinish 
      Caption         =   "Finish"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   6240
      TabIndex        =   20
      Top             =   4750
      Visible         =   0   'False
      Width           =   900
   End
   Begin VB.CommandButton cmdBack 
      Caption         =   "Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   5280
      TabIndex        =   16
      Top             =   4750
      Width           =   900
   End
   Begin VB.Frame Frame2 
      Height          =   4695
      Left            =   50
      TabIndex        =   13
      Top             =   0
      Width           =   8055
      Begin VB.Frame Frame3 
         Height          =   1335
         Left            =   170
         TabIndex        =   17
         Top             =   1800
         Visible         =   0   'False
         Width           =   7710
         Begin MSComctlLib.ProgressBar pBar 
            Height          =   255
            Left            =   120
            TabIndex        =   19
            Top             =   720
            Width           =   6015
            _ExtentX        =   10610
            _ExtentY        =   450
            _Version        =   393216
            BorderStyle     =   1
            Appearance      =   0
         End
         Begin VB.Label lblFinalise 
            AutoSize        =   -1  'True
            Caption         =   "Finalizing the Period. . ."
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   210
            Left            =   120
            TabIndex        =   18
            Top             =   360
            Width           =   1770
         End
      End
      Begin VB.Frame Frame4 
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   885
         Left            =   170
         TabIndex        =   14
         Top             =   240
         Width           =   7710
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Are you sure to Finalize this Period? If Yes, click ""Finish""."
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   210
            Left            =   165
            TabIndex        =   15
            Top             =   375
            Width           =   4350
         End
      End
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "Next"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   6240
      TabIndex        =   1
      Top             =   4750
      Width           =   900
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   7215
      TabIndex        =   2
      Top             =   4750
      Width           =   900
   End
   Begin VB.Frame Frame1 
      Height          =   4695
      Left            =   50
      TabIndex        =   0
      Top             =   0
      Width           =   8055
      Begin VB.Frame frameDetails 
         Caption         =   "Details of Audit file"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2175
         Left            =   170
         TabIndex        =   8
         Top             =   2280
         Visible         =   0   'False
         Width           =   7710
         Begin VB.Label lblReviews 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00E0E0E0&
            Caption         =   "Reviews not Signed Off    :"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   240
            Left            =   120
            TabIndex        =   12
            Top             =   840
            Width           =   2295
         End
         Begin VB.Label lblNotSignedOff 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00E0E0E0&
            Caption         =   "Company Name"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   240
            Left            =   2520
            TabIndex        =   11
            Top             =   840
            Width           =   1410
         End
         Begin VB.Label lblDocuments 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00E0E0E0&
            Caption         =   "Un Linked Documents     :"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   240
            Left            =   120
            TabIndex        =   10
            Top             =   360
            Width           =   2280
         End
         Begin VB.Label lblLinkedDocuments 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00E0E0E0&
            Caption         =   "Company Name"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00400000&
            Height          =   240
            Left            =   2520
            TabIndex        =   9
            Top             =   360
            Width           =   1410
         End
      End
      Begin VB.Frame frameCompanyPeriod 
         Caption         =   "Select the Company and Period"
         BeginProperty Font 
            Name            =   "Cambria"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1965
         Left            =   170
         TabIndex        =   3
         Top             =   240
         Width           =   7710
         Begin VB.ComboBox cmbCompany 
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            ItemData        =   "frmFinalisation.frx":0000
            Left            =   180
            List            =   "frmFinalisation.frx":0002
            TabIndex        =   5
            Text            =   "cmbCompany"
            Top             =   600
            Width           =   6555
         End
         Begin VB.ComboBox cmbPeriod 
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   180
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   1335
            Width           =   4020
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Company"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Left            =   165
            TabIndex        =   7
            Top             =   375
            Width           =   735
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Period"
            BeginProperty Font 
               Name            =   "Cambria"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Left            =   180
            TabIndex        =   6
            Top             =   1110
            Width           =   510
         End
      End
   End
End
Attribute VB_Name = "frmFinalisation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long

Private Sub cmbCompany_Click()
Dim sSql As String
    sSql = "SELECT   '' AS NameField, 0 AS IDField FROM Periods UNION " & _
           "SELECT   CONVERT(VARCHAR, CONVERT(DATETIME, StartDt - 2, 103), 103) + ' - ' + CONVERT(VARCHAR, CONVERT(DATETIME, EndDt - 2, 103), 103) AS NameField, " & _
           "         PeriodID AS IDField FROM Periods WHERE CompanyID = " & GetComboBoundValue(cmbCompany)
    SetComboList cmbPeriod, sSql
End Sub

Private Sub cmbPeriod_Click()
Dim sSql As String
    frameDetails.Visible = True
    mCompanyID = GetComboBoundValue(cmbCompany)
    mPeriodID = GetComboBoundValue(cmbPeriod)

    sSql = "SELECT Unlinked = Count(*) FROM DocumentBin LEFT OUTER JOIN AuditMain.dbo.Companies ON DocumentBin.CompanyID = "
    sSql = sSql & " AuditMain.dbo.Companies.CompanyID WHERE DocumentID  NOT IN "
    sSql = sSql & " (SELECT DocumentID FROM AuditMain.dbo.DocumentSubLinks) AND DocumentBin.CompanyID = " & mCompanyID
    With GetRecords(sSql, AdoConnDoc)
        If Not .EOF Then
            lblLinkedDocuments = .Fields("Unlinked") & ""
        End If
    End With
    sSql = "Select NotSignedOff = SUM((Case When Isnull(Signedoff,0) = 0 Then 1 Else 0 End)) From Reviews Where PeriodID = " & mPeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            lblNotSignedOff = .Fields("NotSignedOff") & ""
        End If
    End With
End Sub

Private Sub cmdBack_Click()
    Frame1.Visible = True
    Frame2.Visible = False
    cmdBack.Visible = False
    cmdFinish.Visible = False
    cmdNext.Visible = True
End Sub

Private Sub cmdCancel_Click()
    If cmdCancel.Caption = "Close" Then
        MDIFormMain.CloseActiveTabForm
    Else
        If pMVE.MsgBox("Are you sure to cancel this wizard?", msgYesNo, "AuditMate", msgQuestion, True) Then
            MDIFormMain.CloseActiveTabForm
        End If
    End If
End Sub

Private Sub cmdFinish_Click()
Dim Inc As Long, sSql As String
    Frame3.Visible = True
    lblFinalise.Caption = "Finalizing the Period..."
    pBar.Min = 0
    pBar.Value = 0
    pBar.Visible = True
    pBar.Value = 5
    For Inc = 1 To 5
        pBar.Value = pBar.Value + 1
        pBar.Refresh
    Next Inc
    sSql = "UPDATE Periods SET FinalisedBy = '" & pUserName & "', FinalisedDate = CONVERT(DateTime, CURRENT_TIMESTAMP, 103) WHERE PeriodID = " & mPeriodID
    AdoConn.Execute sSql
    lblFinalise.Caption = "Period Finalized succesfully..."
    pBar.Value = 99
    cmdBack.Enabled = False
    cmdCancel.Caption = "Close"
End Sub

Private Sub cmdNext_Click()
    If lblLinkedDocuments <> "0" Then
        pMVE.MsgBox "Can't proceed to finalize. Unlinked documents are there in BIN.", msgOK, "AuditMate", msgInformation, True
        cmdNext.Enabled = False
        Exit Sub
    End If
    If lblNotSignedOff <> "" Then
        pMVE.MsgBox "Can't proceed to finalise. Review SignOff is still pending.", msgOK, "AuditMate", msgInformation, True
        cmdNext.Enabled = False
        Exit Sub
    End If
    Frame2.Visible = True
    cmdNext.Visible = False
    cmdFinish.Visible = True
    cmdBack.Visible = True
    Frame3.Visible = False
End Sub

Private Sub Form_Load()
On Local Error Resume Next
Dim sSql As String
    Frame2.Visible = False
    cmdBack.Visible = False
    mCompanyID = 0
    mPeriodID = 0
    Align Me
    sSql = "SELECT   '' AS NameField, 0 AS IDField FROM Companies UNION " & _
           "SELECT   CompanyName AS NameField, CompanyID AS IDField FROM Companies ORDER BY NameField"
    SetComboList cmbCompany, sSql
End Sub
