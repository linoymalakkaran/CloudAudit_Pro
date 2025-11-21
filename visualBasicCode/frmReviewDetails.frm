VERSION 5.00
Object = "{BEEECC20-4D5F-4F8B-BFDC-5D9B6FBDE09D}#1.0#0"; "vsflex8.ocx"
Begin VB.Form frmReviewDetails 
   BackColor       =   &H00E0E0E0&
   Caption         =   "Review Details"
   ClientHeight    =   10395
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   15225
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   ForeColor       =   &H00C0FFFF&
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   10395
   ScaleWidth      =   15225
   WindowState     =   2  'Maximized
   Begin VSFlex8Ctl.VSFlexGrid vsfgColHead 
      Height          =   375
      Left            =   495
      TabIndex        =   37
      Top             =   2400
      Width           =   14625
      _cx             =   25797
      _cy             =   661
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   4194304
      ForeColor       =   -2147483643
      BackColorFixed  =   64
      ForeColorFixed  =   -2147483634
      BackColorSel    =   64
      ForeColorSel    =   -2147483643
      BackColorBkg    =   -2147483636
      BackColorAlternate=   4194304
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
      Rows            =   1
      Cols            =   4
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   330
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
      ForeColorFrozen =   -2147483634
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
   Begin VB.Timer LoginTime 
      Interval        =   100
      Left            =   14040
      Top             =   120
   End
   Begin VB.CheckBox chkAuditFile 
      BackColor       =   &H00E0E0E0&
      Caption         =   "Audit File Finalised"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   12.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   405
      Left            =   12600
      TabIndex        =   34
      Top             =   9630
      Width           =   2775
   End
   Begin VB.CheckBox Check1 
      Caption         =   "SignedOff"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000001&
      Height          =   255
      Left            =   0
      TabIndex        =   33
      Top             =   13920
      Width           =   1815
   End
   Begin VB.CheckBox chkSignedOff 
      BackColor       =   &H00E0E0E0&
      Caption         =   "SignedOff"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   12.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   255
      Left            =   12600
      TabIndex        =   32
      Top             =   9120
      Width           =   2775
   End
   Begin VSFlex8Ctl.VSFlexGrid vsfgField 
      Height          =   5775
      Left            =   495
      TabIndex        =   11
      Top             =   2760
      Width           =   14625
      _cx             =   25797
      _cy             =   10186
      Appearance      =   2
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   16777215
      ForeColor       =   16448
      BackColorFixed  =   4194304
      ForeColorFixed  =   -2147483634
      BackColorSel    =   16777215
      ForeColorSel    =   -2147483630
      BackColorBkg    =   -2147483633
      BackColorAlternate=   16777215
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
      Rows            =   2
      Cols            =   6
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   330
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
      ForeColorFrozen =   16576
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
   Begin VB.Label lblData 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Data                    :   Server Detached By"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   480
      TabIndex        =   38
      Top             =   1440
      Width           =   3030
   End
   Begin VB.Image ImgRefresh 
      BorderStyle     =   1  'Fixed Single
      Height          =   900
      Left            =   14160
      Picture         =   "frmReviewDetails.frx":0000
      ToolTipText     =   "Refresh Data"
      Top             =   1440
      Width           =   900
   End
   Begin VB.Label Label7 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Review Partner                 :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   6120
      TabIndex        =   36
      Top             =   360
      Width           =   2070
   End
   Begin VB.Label lblReviewPartner 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   8520
      TabIndex        =   35
      Top             =   360
      Width           =   1275
   End
   Begin VB.Label lblFinalIssued 
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
      Left            =   9960
      TabIndex        =   31
      Top             =   9720
      Width           =   1410
   End
   Begin VB.Label Label33 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Final Issued   :"
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
      Left            =   8520
      TabIndex        =   30
      Top             =   9720
      Width           =   1290
   End
   Begin VB.Label lblDraftIssued 
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
      Left            =   9960
      TabIndex        =   29
      Top             =   9120
      Width           =   1410
   End
   Begin VB.Label Label31 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Draft Issued   :"
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
      Left            =   8520
      TabIndex        =   28
      Top             =   9120
      Width           =   1305
   End
   Begin VB.Label Label30 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Report Summary"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   360
      Left            =   8520
      TabIndex        =   27
      Top             =   8640
      Width           =   3000
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
      Left            =   6600
      TabIndex        =   26
      Top             =   9840
      Width           =   1410
   End
   Begin VB.Label lblLierewrwerwer 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Un Linked Documents"
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
      Left            =   4200
      TabIndex        =   25
      Top             =   9840
      Width           =   1995
   End
   Begin VB.Label lblDocuments 
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
      Left            =   6600
      TabIndex        =   24
      Top             =   9480
      Width           =   1410
   End
   Begin VB.Label lblD3 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Documents for the year"
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
      Left            =   4200
      TabIndex        =   23
      Top             =   9480
      Width           =   2115
   End
   Begin VB.Label lblPermanent 
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
      Left            =   6600
      TabIndex        =   22
      Top             =   9120
      Width           =   1410
   End
   Begin VB.Label asd 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Permanent documents"
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
      Left            =   4200
      TabIndex        =   21
      Top             =   9120
      Width           =   2070
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
      Left            =   2160
      TabIndex        =   20
      Top             =   9840
      Width           =   1410
   End
   Begin VB.Label Label22 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Not Signed Off"
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
      Left            =   480
      TabIndex        =   19
      Top             =   9840
      Width           =   1275
   End
   Begin VB.Label lblNotReplied 
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
      Left            =   2160
      TabIndex        =   18
      Top             =   9480
      Width           =   1410
   End
   Begin VB.Label Label20 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Not Replied"
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
      Left            =   480
      TabIndex        =   17
      Top             =   9480
      Width           =   1065
   End
   Begin VB.Label Label15 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Document Summary"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   360
      Left            =   4200
      TabIndex        =   16
      Top             =   8640
      Width           =   2760
   End
   Begin VB.Label Label14 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Reviewed"
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
      Left            =   480
      TabIndex        =   15
      Top             =   9120
      Width           =   885
   End
   Begin VB.Label lblReviewed 
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
      Left            =   2160
      TabIndex        =   14
      Top             =   9120
      Width           =   1410
   End
   Begin VB.Label Label12 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Review Summary"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   360
      Left            =   480
      TabIndex        =   13
      Top             =   8640
      Width           =   2280
   End
   Begin VB.Label Label18 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00E0E0E0&
      Caption         =   "Field Work Summary"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   360
      Left            =   600
      TabIndex        =   12
      Top             =   2040
      Width           =   14580
   End
   Begin VB.Label lblAuditorAssistant 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   8520
      TabIndex        =   10
      Top             =   1485
      Width           =   1275
   End
   Begin VB.Label lblAuditor 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   8520
      TabIndex        =   9
      Top             =   1080
      Width           =   1275
   End
   Begin VB.Label lblReviewManager 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   8520
      TabIndex        =   8
      Top             =   720
      Width           =   1275
   End
   Begin VB.Label lblPeriod 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   1920
      TabIndex        =   7
      Top             =   885
      Width           =   1605
   End
   Begin VB.Label lblCompanyName 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company Name"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   750
      Left            =   1920
      TabIndex        =   6
      Top             =   360
      Width           =   4125
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblUsers 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Logged in Users"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   10800
      TabIndex        =   5
      Top             =   1080
      Visible         =   0   'False
      Width           =   1320
   End
   Begin VB.Label Label5 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Audit Assistant                 :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   6120
      TabIndex        =   4
      Top             =   1485
      Width           =   2070
   End
   Begin VB.Label Label4 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Auditor                               :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   6120
      TabIndex        =   3
      Top             =   1080
      Width           =   2070
   End
   Begin VB.Label Label3 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Review Manager               :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   225
      Left            =   6120
      TabIndex        =   2
      Top             =   720
      Width           =   2070
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Period            :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   495
      TabIndex        =   1
      Top             =   885
      Width           =   1305
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00E0E0E0&
      Caption         =   "Company      :"
      BeginProperty Font 
         Name            =   "Cambria"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   495
      TabIndex        =   0
      Top             =   360
      Width           =   1305
   End
End
Attribute VB_Name = "frmReviewDetails"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim mCompanyID As Long, mPeriodID As Long, mLastPeriodID As Long
Dim mblnModify As Boolean, mblnNew As Boolean

Const grdColHeadFieldWork = 0
Const grdColHeadRiskAnalysis = 1
Const grdColHeadAuditProcedure = 2
Const grdColHeadReview = 3
Const grdColHeadCols = 4

Const grdFieldwork = 0
Const grdFieldRANotStarted = 1
Const grdFieldRAFinished = 2
Const grdFieldNotStarted = 3
Const grdFieldWorkinProgress = 4
Const grdFieldFinished = 5
Const grdFieldNA = 6
Const grdFieldSubSectionID = 7
Const grdFieldReviewed = 8
Const grdFieldCols = 9

Public Property Get IsReadOnly() As Boolean
Dim sSql As String, sSql1 As String, sSql3 As String
    IsReadOnly = Not (mCompanyID = pActiveCompanyID)
    IsReadOnly = Not (mPeriodID = mPeriodID)
    sSql1 = "Select IsBlocked From UserPrivileges Where PeriodID = " & mPeriodID & " AND UserID = " & pUserID
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
    mLastPeriodID = Val(PickValue("Periods", "DerivedPeriodID", "PeriodID = " & mPeriodID))
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Private Sub Form_Load()
On Local Error Resume Next
Dim Inc As Long, sSql As String, sSql1 As String, sSql2 As String
Dim lngFinished As Long, lngActualFinished As Long
Dim lngAnswer As Long, lngSectionID As Long, lngStatus As Long
Dim rsData As New ADODB.Recordset, rsDetail As New ADODB.Recordset
Dim strDetachedBy As String
'    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
'    sSql = sSql & " FROM UserGroupUsers, UserPrivilegesSub WHERE UserPrivilegesSub.UserID = UserGroupUsers.UserID AND UserGroupID = 1 AND PeriodID = " & pActivePeriodID
    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
    sSql = sSql & " FROM UserGroupUsers, UserPrivileges WHERE UserPrivileges.UserID = UserGroupUsers.UserID AND UserGroupID = 1 AND PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        lblReviewPartner.Caption = ""
        If Not .EOF Then
            .MoveFirst
            Do Until .EOF
                lblReviewPartner = lblReviewPartner.Caption & IIf(Trim(lblReviewPartner.Caption) <> "", ",", "") & .Fields("UserName")
                .MoveNext
            Loop
        End If
    End With

'    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
'    sSql = sSql & " FROM UserGroupUsers, UserPrivilegesSub WHERE UserPrivilegesSub.UserID = UserGroupUsers.UserID AND UserGroupID = 2 AND PeriodID = " & pActivePeriodID
    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
    sSql = sSql & " FROM UserGroupUsers, UserPrivileges WHERE UserPrivileges.UserID = UserGroupUsers.UserID AND UserGroupID = 2 AND PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        lblReviewManager.Caption = ""
        If Not .EOF Then
            .MoveFirst
            Do Until .EOF
                lblReviewManager = lblReviewManager.Caption & IIf(Trim(lblReviewManager.Caption) <> "", ",", "") & .Fields("UserName")
                .MoveNext
            Loop
        End If
    End With

    sSql = "SELECT CompanyName FROM Companies WHERE CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        lblCompanyName.Caption = ""
        .MoveFirst
        Do Until .EOF
            lblCompanyName = .Fields("CompanyName") & ""
            .MoveNext
        Loop
    End With

    sSql = "SELECT Description FROM Periods WHERE PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        lblPeriod.Caption = ""
        .MoveFirst
        Do Until .EOF
            lblPeriod = .Fields("Description") & ""
            .MoveNext
        Loop
    End With

'    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
'    sSql = sSql & " FROM UserGroupUsers, UserPrivilegesSub WHERE UserPrivilegesSub.Userid = UserGroupUsers.UserID AND UserGroupID = 3 AND PeriodID = " & pActivePeriodID
    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
    sSql = sSql & " FROM UserGroupUsers, UserPrivileges WHERE UserPrivileges.Userid = UserGroupUsers.UserID AND UserGroupID = 3 AND PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        lblAuditor.Caption = ""
        If Not .EOF Then
            .MoveFirst
            Do Until .EOF
                lblAuditor = lblAuditor.Caption & IIf(Trim(lblAuditor.Caption) <> "", ", ", "") & .Fields("UserName") & ""
                .MoveNext
            Loop
        End If
    End With
'    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
'    sSql = sSql & " FROM UserGroupUsers, UserPrivilegesSub WHERE UserPrivilegesSub.UserID = UserGroupUsers.UserID AND UserGroupID = 4 AND PeriodID = " & pActivePeriodID
    sSql = "SELECT DISTINCT UserName = (SELECT UserName FROM Users WHERE Users.UserID = UserGroupUsers.UserID) "
    sSql = sSql & " FROM UserGroupUsers, UserPrivileges WHERE UserPrivileges.UserID = UserGroupUsers.UserID AND UserGroupID = 4 AND PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        lblAuditorAssistant.Caption = ""
        If Not .EOF Then
            .MoveFirst
            Do Until .EOF
                lblAuditorAssistant = lblAuditorAssistant.Caption & IIf(Trim(lblAuditorAssistant.Caption) <> "", ", ", "") & .Fields("UserName") & ""
                .MoveNext
            Loop
        End If
    End With
    vsfgColHead.Cols = grdColHeadCols
    vsfgColHead.ExtendLastCol = True
    vsfgColHead.Rows = 1
    vsfgColHead.ColWidth(grdColHeadFieldWork) = 5000
    vsfgColHead.ColWidth(grdColHeadRiskAnalysis) = 2400
    vsfgColHead.ColWidth(grdColHeadAuditProcedure) = 5600
    vsfgColHead.ColWidth(grdColHeadReview) = 1200
    
    vsfgColHead.TextMatrix(0, grdColHeadFieldWork) = "Particulars"
    vsfgColHead.TextMatrix(0, grdColHeadRiskAnalysis) = "Risk Analysis"
    vsfgColHead.TextMatrix(0, grdColHeadAuditProcedure) = "Audit Procedure"
    vsfgColHead.TextMatrix(0, grdColHeadReview) = "Reviews"
    
    vsfgColHead.ColAlignment(grdColHeadFieldWork) = flexAlignCenterCenter
    vsfgColHead.ColAlignment(grdColHeadRiskAnalysis) = flexAlignCenterCenter
    vsfgColHead.ColAlignment(grdColHeadAuditProcedure) = flexAlignCenterCenter
    vsfgColHead.ColAlignment(grdColHeadReview) = flexAlignCenterCenter

    Inc = 1
    vsfgField.Cols = grdFieldCols
    vsfgField.ExtendLastCol = False
    vsfgField.Rows = 2
    vsfgField.ColWidth(grdFieldwork) = 5000
    vsfgField.ColWidth(grdFieldRANotStarted) = 1200
    vsfgField.ColWidth(grdFieldRAFinished) = 1200
    vsfgField.ColWidth(grdFieldNotStarted) = 1500
    vsfgField.ColWidth(grdFieldWorkinProgress) = 2000
    vsfgField.ColWidth(grdFieldFinished) = 1200
    vsfgField.ColWidth(grdFieldNA) = 900
    vsfgField.ColWidth(grdFieldReviewed) = 1350

    vsfgField.TextMatrix(0, grdFieldwork) = "Filing Sections"
    vsfgField.TextMatrix(0, grdFieldRANotStarted) = "Not Started"
    vsfgField.TextMatrix(0, grdFieldRAFinished) = "Finished"
    vsfgField.TextMatrix(0, grdFieldNotStarted) = "Not Started"
    vsfgField.TextMatrix(0, grdFieldWorkinProgress) = "Work In Progress"
    vsfgField.TextMatrix(0, grdFieldFinished) = "Finished"
    vsfgField.TextMatrix(0, grdFieldNA) = "N/A"
    vsfgField.TextMatrix(0, grdFieldReviewed) = "Status"

    vsfgField.ColHidden(grdFieldSubSectionID) = True
    vsfgField.ColDataType(grdFieldReviewed) = flexDTBoolean

    vsfgField.ColAlignment(grdFieldRANotStarted) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldRAFinished) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldFinished) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldNotStarted) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldWorkinProgress) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldNA) = flexAlignCenterCenter
    vsfgField.ColAlignment(grdFieldReviewed) = flexAlignCenterCenter

    Inc = 2

    vsfgField.OutlineBar = flexOutlineBarCompleteLeaf
    vsfgField.OutlineCol = 0
    vsfgField.IsSubtotal(1) = True
    vsfgField.RowOutlineLevel(1) = 0
    vsfgField.IsCollapsed(1) = flexOutlineExpanded
    sSql = "Select * From FilingSections Where SectionID < 11"
    With GetRecords(sSql)
        While Not .EOF
            lngSectionID = .Fields("SectionID") & ""
            vsfgField.Rows = vsfgField.Rows + 1
            vsfgField.OutlineBar = flexOutlineBarCompleteLeaf
            vsfgField.OutlineCol = 0
            vsfgField.IsSubtotal(Inc) = True
            vsfgField.RowOutlineLevel(Inc) = 1
            vsfgField.RowHeight(Inc) = 330
            vsfgField.IsCollapsed(Inc) = flexOutlineExpanded
            vsfgField.TextMatrix(Inc, grdFieldwork) = .Fields("Description") & ""
            sSql1 = "Select * From FilingSubSection Where SectionID = " & lngSectionID & " Order By TrialOrder"
            Set rsData = GetRecords(sSql1)
            With rsData
                .MoveFirst
                While Not .EOF
                    Inc = Inc + 1
                    vsfgField.Rows = vsfgField.Rows + 1
                    If lngSectionID >= 5 And lngSectionID <> 11 Then
                        lngStatus = PickValue("AcTypes", "StatusID", "ActualAcTypeID = " & rsData.Fields("AcTypeID") & "" & " AND CompanyID = " & pActiveCompanyID)
                        If lngStatus = 1 Then
                            sSql1 = "Select AT.AcTypeDescription From AcTypes AT Where AT.ActualAcTypeID = " & rsData.Fields("AcTypeID") & " AND AT.CompanyID = " & pActiveCompanyID
                            Set rsDetail = GetRecords(sSql1)
                                If Not rsDetail.EOF Then
                                    vsfgField.TextMatrix(Inc, grdFieldwork) = rsDetail.Fields("AcTypeDescription") & ""
                                End If
                                vsfgField.TextMatrix(Inc, grdFieldSubSectionID) = Val(rsData.Fields("SubSectionID")) & ""
                        Else
                            vsfgField.TextMatrix(Inc, grdFieldwork) = rsData.Fields("Description") & ""
                            vsfgField.Cell(flexcpForeColor, Inc, grdFieldwork, Inc, grdFieldReviewed) = &H808080
                        End If
                    Else
                        vsfgField.TextMatrix(Inc, grdFieldwork) = rsData.Fields("Description") & ""
                        vsfgField.TextMatrix(Inc, grdFieldSubSectionID) = Val(rsData.Fields("SubsectionID")) & ""
                    End If
                If Trim(vsfgField.TextMatrix(Inc, grdFieldSubSectionID)) <> "" Then
                    sSql = "Select * From ReviewSubSections Where PeriodID = " & pActivePeriodID & " And SubSectionID = " & vsfgField.TextMatrix(Inc, grdFieldSubSectionID)
                    With GetRecords(sSql)
                        Do Until .EOF
                            If .Fields("chkReview") = True Then
                                vsfgField.TextMatrix(Inc, grdFieldReviewed) = 1
                            Else
                                vsfgField.TextMatrix(Inc, grdFieldReviewed) = 0
                            End If
                            .MoveNext
                        Loop
                    End With
                End If
                If Trim(vsfgField.TextMatrix(Inc, grdFieldSubSectionID)) <> "" Then
                    sSql = "Select  Yes = Isnull(SUM(Case When Isnull(AnswerID, 0) = 1  Then 1 Else 0 End),''), No = Isnull(SUM(Case When Isnull(AnswerID, 0) = 2  Then 1 Else 0 End),''), " & _
                           "NA = Isnull(SUM(Case When Isnull(AnswerID, 0) = 3  Then 1 Else 0 End),''),  NotStarted = Isnull(SUM(Case When Isnull(AnswerID, 0) = '' Then 1 Else 0 End),'') " & _
                           "From SubSectionProcedures  Where  SubSectionID = " & vsfgField.TextMatrix(Inc, grdFieldSubSectionID) & "  And ProcedureTypeID = 1 And PeriodID = " & pActivePeriodID
                    With GetRecords(sSql)
                        lngAnswer = .Fields("Yes") + .Fields("No") + .Fields("NA")
                        Do Until .EOF
                            vsfgField.TextMatrix(Inc, grdFieldRANotStarted) = IIf(.Fields("NotStarted") & "" = 0, "", .Fields("NotStarted"))
                            vsfgField.TextMatrix(Inc, grdFieldRAFinished) = IIf(lngAnswer = 0, "", lngAnswer)
                            .MoveNext
                        Loop
                    End With
                End If
                If Trim(vsfgField.TextMatrix(Inc, grdFieldSubSectionID)) <> "" And (Val(vsfgField.TextMatrix(Inc, grdFieldFinished)) + Val(vsfgField.TextMatrix(Inc, grdFieldNotStarted)) + Val(vsfgField.TextMatrix(Inc, grdFieldWorkinProgress))) = 0 Then
                    sSql = "Select Finished = Isnull(SUM(Case When Isnull(AnswerID, 0) = 1 Then 1 Else 0 End),''),"
                    sSql = sSql & " NotApplicable = Isnull(sum(Case When Isnull(AnswerID, 0) = 4 Then 1 else 0 end), ''), "
                    sSql = sSql & " NotStarted = Isnull(SUM(Case When Isnull(AnswerID, 0) = 2 Then 1 Else 0 End),''), "
                    sSql = sSql & " WorkInProgress = Isnull(SUM(Case When Isnull(AnswerID, 0) = 3 Then 1 Else 0 End),'') "
                    sSql = sSql & " From SubSectionProcedures Where SubSectionID = " & vsfgField.TextMatrix(Inc, grdFieldSubSectionID) & "  And ProcedureTypeID = 2 And PeriodID = " & pActivePeriodID
                    With GetRecords(sSql)
                        Do Until .EOF
                            vsfgField.TextMatrix(Inc, grdFieldNotStarted) = IIf(.Fields("NotStarted") & "" = 0, "", .Fields("NotStarted"))
                            vsfgField.TextMatrix(Inc, grdFieldWorkinProgress) = IIf(.Fields("Workinprogress") & "" = 0, "", .Fields("WorkInProgress"))
                            vsfgField.TextMatrix(Inc, grdFieldFinished) = IIf(.Fields("Finished") & "" = 0, "", .Fields("Finished"))
                            vsfgField.TextMatrix(Inc, grdFieldNA) = IIf(.Fields("NotApplicable") & "" = 0, "", .Fields("NotApplicable"))
                            .MoveNext
                        Loop
                    End With
                End If
                .MoveNext
'                vsfgField.IsCollapsed(Inc) = flexOutlineExpanded
                Wend
            End With
            Inc = Inc + 1
        .MoveNext
        Wend
    End With
    For Inc = 24 To vsfgField.Rows - 1
        If vsfgField.TextMatrix(Inc, grdFieldSubSectionID) <> "" Then
            If vsfgField.TextMatrix(Inc, grdFieldRAFinished) = "" Then
                vsfgField.TextMatrix(Inc, grdFieldRANotStarted) = 1
            End If
        End If
    Next
    For Inc = 24 To vsfgField.Rows - 1
        If vsfgField.TextMatrix(Inc, grdFieldSubSectionID) <> "" Then
            If vsfgField.TextMatrix(Inc, grdFieldFinished) = "" And vsfgField.TextMatrix(Inc, grdFieldWorkinProgress) = "" And vsfgField.TextMatrix(Inc, grdFieldNA) = "" Then
                vsfgField.TextMatrix(Inc, grdFieldNotStarted) = 1
            End If
        End If
    Next
    sSql = "Select Reviewed = Count(*), NotReplied = SUM((Case When RTRIM(Answer) <> '' Then 0 Else 1 End)), "
    sSql = sSql & " NotSignedOff = SUM((Case When Isnull(Signedoff,0) = 0 Then 1 Else 0 End)) From Reviews Where PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            lblReviewed = ":  " & .Fields("Reviewed") & ""
            lblNotReplied = ":  " & .Fields("NotReplied") & ""
            lblNotSignedOff = ":  " & .Fields("NotSignedOff") & ""
        End If
    End With

    sSql = "Select PermanentDoc = SUM((Case When DocumentType = 1 Then 1 Else 0 End)),"
    sSql = sSql & " TemporaryDoc = SUM((Case When DocumentType = 0 Then 1 Else 0 End)) From DocumentBin Where CompanyID = " & pActiveCompanyID
    With GetRecords(sSql, AdoConnDoc)
        If Not .EOF Then
            lblPermanent = ":  " & .Fields("PermanentDoc") & ""
            lblDocuments = ":  " & .Fields("TemporaryDoc") & ""
        End If
    End With

    sSql = "Select Unlinked = Count(*) From DocumentBin LEFT OUTER JOIN AuditMain.dbo.Companies ON DocumentBin.CompanyID = "
    sSql = sSql & " AuditMain.dbo.Companies.CompanyID Where DocumentID  NOT IN "
    sSql = sSql & " (Select DocumentID From AuditMain.dbo.DocumentSubLinks) And DocumentBin.CompanyID = " & pActiveCompanyID
    With GetRecords(sSql, AdoConnDoc)
        If Not .EOF Then
            lblLinkedDocuments = ":  " & .Fields("Unlinked") & ""
        End If
    End With

    lblDraftIssued.Caption = ""
    lblFinalIssued.Caption = ""

    sSql = "Select Signedoff, AuditFile From Periods Where PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            If .Fields("Signedoff") = True Then
                chkSignedOff.Value = 1
            Else
                chkSignedOff.Value = 0
            End If
            If .Fields("AuditFile") = True Then
                chkAuditFile.Value = 1
            Else
                chkAuditFile.Value = 0
            End If
        End If
    End With

    sSql = "Select DraftIssuedDate, FinalIssuedDate From AuditReportObjects Where PeriodID = " & pActivePeriodID
    With GetRecords(sSql)
        If Not .EOF Then
            lblDraftIssued = .Fields("DraftIssuedDate") & ""
            lblFinalIssued = .Fields("FinalIssuedDate") & ""
        End If
    End With

    sSql = "Select Detachedby = (Case When RTrim(Isnull(Detachedby,'')) = '' Then 'SERVER' Else Replace(Isnull(Detachedby,''),'-LAP','') End) "
    sSql = sSql & "  From Companies Where CompanyID = " & pActiveCompanyID
    With GetRecords(sSql)
        If Not .EOF Then
            If .Fields("Detachedby") <> "SERVER" Then
                strDetachedBy = "Detached by " & .Fields("Detachedby") & ""
            Else
                strDetachedBy = "SERVER"
            End If
            lblData = "Data                    :   " & strDetachedBy
        End If
    End With
    For Inc = 1 To 24
        vsfgField.Cell(flexcpBackColor, Inc, grdFieldwork, Inc, grdFieldReviewed) = &H80000005
    Next
    For Inc = 25 To vsfgField.Rows - 1
        vsfgField.Cell(flexcpBackColor, Inc, grdFieldwork, Inc, grdFieldReviewed) = &HC0FFFF
    Next
    For Inc = 2 To vsfgField.Rows - 1
        If vsfgField.Cell(flexcpBackColor, Inc, grdFieldwork, Inc, grdFieldReviewed) = &H80000005 Then
            vsfgField.IsCollapsed(Inc) = flexOutlineCollapsed
        Else
            vsfgField.IsCollapsed(Inc) = flexOutlineExpanded
        End If
    Next
End Sub

Private Sub chkAuditFile_Click()
    SaveAuditfile
End Sub

Private Sub chkSignedOff_Click()
    If pMVE.MsgBox("Do you want to Sign Off this period Audit File?.", msgYesNo, "AuditMate", msgInformation, True) Then
        Savesignedoff
    Else
        Exit Sub
    End If
End Sub

Public Function Savesignedoff() As Boolean
On Local Error Resume Next
Dim sSql As String
    If chkSignedOff.Value = 1 Then
        sSql = "UPDATE Periods SET Signedoff = 1  WHERE PeriodID = " & pActivePeriodID
    Else
        sSql = "UPDATE Periods SET Signedoff = 0  WHERE PeriodID = " & pActivePeriodID
    End If
    AdoConn.Execute sSql
    Savesignedoff = True
End Function

Public Function SaveAuditfile() As Boolean
On Local Error Resume Next
Dim sSql As String
    If chkAuditFile.Value = 1 Then
        sSql = "UPDATE Periods SET AuditFile = 1  WHERE PeriodID = " & pActivePeriodID
    Else
        sSql = "UPDATE Periods SET AuditFile = 0  WHERE PeriodID = " & pActivePeriodID
    End If
    AdoConn.Execute sSql
    SaveAuditfile = True
End Function

Private Sub Form_Resize()
    WindowState = vbMaximized
End Sub

Private Sub ImgRefresh_Click()
    Form_Load
'    LoginTime_Timer
End Sub

'Private Sub LoginTime_Timer()
'On Local Error Resume Next
'Dim strSQL As String, strlogin As String
'    strSQL = " Delete From Userlog Where UserID = " & pUserID
'    AdoConn.Execute strSQL
'    strSQL = "Insert into Userlog (UserID, CompanyID, PeriodID) Values"
'    strSQL = strSQL & " (" & pUserID & "," & pActiveCompanyID & "," & pActivePeriodID & ")"
'    AdoConn.Execute strSQL
'    strlogin = "Logged in Users : "
'    strSQL = "SELECT DISTINCT UserName FROM Userlog, Users WHERE Userlog.UserID = Users.UserID AND DATEPART(hh, RecordedTime) = DATEPART(hh, GETDATE()) "
'    strSQL = strSQL & " AND DATEPART(yyyy,RecordedTime) = DATEPART(yyyy,GETDATE()) AND DATEPART(mm,RecordedTime) = DATEPART(mm,GETDATE()) AND DATEPART(dd,RecordedTime) = DATEPART(dd,GETDATE()) "
'    strSQL = strSQL & " AND DATEPART(mi, RecordedTime) = DATEPART(mi, GETDATE())  AND CompanyID = " & pActiveCompanyID & " AND PeriodID = " & pActivePeriodID
'    With GetRecords(strSQL)
'        If Not .EOF Then
'            .MoveFirst
'            Do Until .EOF
'                strlogin = strlogin & .Fields("UserName") & ", "
'                .MoveNext
'            Loop
'        End If
'    End With
'    lblUsers = strlogin
'End Sub
