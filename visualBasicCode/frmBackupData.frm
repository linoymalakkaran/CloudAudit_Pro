VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmBackupData 
   Caption         =   "Database Backup"
   ClientHeight    =   1770
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   6600
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
   MDIChild        =   -1  'True
   ScaleHeight     =   1770
   ScaleWidth      =   6600
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdClose 
      Caption         =   "Close"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5280
      TabIndex        =   5
      Top             =   1320
      Width           =   1215
   End
   Begin VB.CommandButton cmdBackup 
      Caption         =   "Take Backup"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3840
      TabIndex        =   4
      Top             =   1320
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   50
      TabIndex        =   0
      Top             =   0
      Width           =   6495
      Begin VB.TextBox txtBackupPath 
         Height          =   315
         Left            =   1230
         TabIndex        =   2
         Top             =   360
         Width           =   4665
      End
      Begin VB.CommandButton cmdBrowseBackupPath 
         Caption         =   "..."
         Height          =   315
         Left            =   5915
         TabIndex        =   1
         Top             =   360
         Width           =   375
      End
      Begin MSComDlg.CommonDialog cdFolderBrowse 
         Left            =   840
         Top             =   600
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         FileName        =   "cdFile"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Backup Path"
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
         Left            =   120
         TabIndex        =   3
         Top             =   420
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmBackupData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdBackup_Click()
    TakeDataBaseBackup pActiveCompanyID, AdoConn
    MDIFormMain.CloseActiveTabForm
End Sub

Private Sub cmdBrowseBackupPath_Click()
    txtBackupPath.Text = BrowShow(txtBackupPath.hWnd, , , , , txtBackupPath)
End Sub

Public Function TakeDataBaseBackup(lngCompanyID As Long, AdoConn As Connection) As Boolean
On Local Error GoTo Err_Exit
Dim strBackupPath As String, sSql As String
Dim strBackupFileName As String, strBackupFullPath As String
Dim strCompanyJobCode As String, strServerDt As String
    If lngCompanyID = 0 Then
        pMVE.MsgBox "Select Company and try again.", msgOK, App.Title, msgInformation, True
        TakeDataBaseBackup = False
        Exit Function
    End If
    Screen.MousePointer = vbHourglass
    strBackupPath = txtBackupPath.Text
    If Trim(strBackupPath) = "" Then
        pMVE.MsgBox "Invalid backup path. Set backup path.", msgOK, App.Title, msgInformation, True
        TakeDataBaseBackup = False
        Exit Function
    End If
    '------------------------------------------------------------
    If Right(Trim(strBackupPath), 1) = "\" Then
        strBackupPath = Left(Trim(strBackupPath), Len(Trim(strBackupPath)) - 1)
    End If
    strServerDt = Format(ServerDateTime(AdoConn), "yyyyMMMddHHmm")
    strCompanyJobCode = PickValue("Companies", "CompanyCode", "CompanyID = " & lngCompanyID)
    strBackupFileName = strCompanyJobCode & "-" & strServerDt

    strBackupFullPath = strBackupPath & "\"

    AdoConn.CommandTimeout = 30
    sSql = "BACKUP DATABASE " & pInitialCatelogDoc & " TO DISK = '" & strBackupFullPath & pInitialCatelogDoc & strBackupFileName & "'"
    AdoConnDoc.Execute sSql
    sSql = "BACKUP DATABASE " & pInitialCatelog & " TO DISK = '" & strBackupFullPath & pInitialCatelog & strBackupFileName & "'"
    AdoConn.Execute sSql
    AdoConn.CommandTimeout = 30
    Screen.MousePointer = vbDefault
    pMVE.MsgBox "Backup has been taken successfully.", msgOK, App.Title, msgInformation, True
    TakeDataBaseBackup = True
Exit Function
Err_Exit:
    TakeDataBaseBackup = False
    Screen.MousePointer = vbDefault
    pMVE.MsgBox Err.Description, msgOK, App.Title, msgInformation, True
End Function

Private Sub cmdClose_Click()
    MDIFormMain.CloseActiveTabForm
End Sub

Private Sub Form_Load()
Dim strBackupPath As String
    strBackupPath = PickValue("ApplicationData", "DataField", "KeyField = 'BackupPath'", AdoConn)
    txtBackupPath.Text = strBackupPath
End Sub
