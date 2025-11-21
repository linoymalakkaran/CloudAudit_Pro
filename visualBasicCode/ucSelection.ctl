VERSION 5.00
Begin VB.UserControl ucSelection 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BackStyle       =   0  'Transparent
   ClientHeight    =   1590
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2445
   LockControls    =   -1  'True
   ScaleHeight     =   1590
   ScaleWidth      =   2445
   ToolboxBitmap   =   "ucSelection.ctx":0000
   Begin VB.PictureBox picSelection 
      Appearance      =   0  'Flat
      BackColor       =   &H80000008&
      BorderStyle     =   0  'None
      DragIcon        =   "ucSelection.ctx":0312
      FillColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   75
      Index           =   0
      Left            =   375
      ScaleHeight     =   75
      ScaleWidth      =   75
      TabIndex        =   0
      Top             =   810
      Visible         =   0   'False
      Width           =   75
   End
   Begin VB.Image imgMove 
      Appearance      =   0  'Flat
      Height          =   480
      Left            =   30
      Picture         =   "ucSelection.ctx":061C
      Top             =   15
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Shape shpSelection 
      BorderColor     =   &H000000FF&
      Height          =   1380
      Left            =   750
      Top             =   30
      Visible         =   0   'False
      Width           =   1050
   End
End
Attribute VB_Name = "ucSelection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Event Declarations:
Event MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Event MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Public Enum SelectionResizingDirection
    srdTopLeft = 0
    srdTopCenter = 1
    srdTopRight = 2
    srdMiddleRight = 3
    srdBottomRight = 4
    srdBottomCenter = 5
    srdBottomLeft = 6
    srdMiddleLeft = 7
    srdMove = 8
End Enum
Dim msrdResizingDirection As SelectionResizingDirection
Dim mctrlSelected As Control, mstrControlType As String
Dim mblnEditing As Boolean
Const mcnstMoveCntrlHeight = 200

Public Property Get Editing() As Boolean
    Editing = mblnEditing
End Property

Public Property Let Editing(ByVal blnNewValue As Boolean)
    mblnEditing = blnNewValue
End Property

Private Sub UserControl_Initialize()
    Dim Inc As Long
    For Inc = 1 To 8
        Load picSelection(Inc)
    Next Inc
    SetAllControls
    UserControl_Resize
End Sub

Private Sub SetAllControls()
    Dim Inc As Long
    If mstrControlType = "Line" Then
        shpSelection.Visible = False
        imgMove.Visible = False
    End If
    For Inc = 1 To 8
        With picSelection(Inc)
            If mstrControlType = "Line" Then
                Select Case Inc
                Case srdTopLeft, srdBottomRight
                    .MousePointer = vbCrosshair
                Case Else
                    .Visible = False
                End Select
            Else
                Select Case Inc
                Case srdTopLeft, srdBottomRight
                    .MousePointer = vbSizeNWSE
                Case srdTopCenter, srdBottomCenter
                    .MousePointer = vbSizeNS
                Case srdTopRight, srdBottomLeft
                    .MousePointer = vbSizeNESW
                Case srdMiddleRight, srdMiddleLeft
                    .MousePointer = vbSizeWE
                Case srdMove
                    .MousePointer = vbSizeAll
                End Select
            End If
        End With
    Next Inc
End Sub

Private Sub UserControl_Resize()
    On Local Error Resume Next
    Dim Inc As Long
    With picSelection(8)
        .BackColor = vbWhite
        Set picSelection(8) = imgMove.Picture
        .Top = -75
        .Left = -80
        .Width = imgMove.Width
        .Height = imgMove.Height - 150
        .Visible = True
    End With
    shpSelection.Left = 75
    shpSelection.Top = 75 + mcnstMoveCntrlHeight
    shpSelection.Width = Width - 150
    shpSelection.Height = Height - (150 + mcnstMoveCntrlHeight)
    shpSelection.Visible = True
    For Inc = 0 To 7
        With picSelection(Inc)
            Select Case Inc
            Case srdTopLeft, srdTopCenter, srdTopRight
                .Top = shpSelection.Top - .Height
            Case srdMiddleRight, srdMiddleLeft
                .Top = shpSelection.Top + (shpSelection.Height - .Height) / 2
            Case srdBottomRight, srdBottomCenter, srdBottomLeft
                .Top = shpSelection.Top + shpSelection.Height + .Height - 70
            End Select
            Select Case Inc
            Case srdTopLeft, srdMiddleLeft, srdBottomLeft
                .Left = shpSelection.Left - .Width
            Case srdTopCenter, srdBottomCenter
                .Left = shpSelection.Left + (shpSelection.Width - .Width) / 2
            Case srdTopRight, srdMiddleRight, srdBottomRight
                .Left = shpSelection.Left + shpSelection.Width + .Width - 70
            End Select
        End With
        picSelection(Inc).Visible = True
    Next Inc
End Sub

Public Sub ShowSelection(cntrlControl As Control, strControlType As String)
    On Local Error Resume Next
    Dim Inc As Long
    Set mctrlSelected = cntrlControl
    mstrControlType = strControlType
    Select Case strControlType
    Case "Line", "Rectangle", "Oval"
        cntrlControl.ZOrder vbBringToFront
    End Select
    Select Case strControlType
    Case "Line"
        With cntrlControl
            If .X1 < .X2 Then
                Extender.Left = .X1 - 70
                Width = (.X2 - Extender.Left) + 40
            Else
                Extender.Left = .X2 - 70
                Width = (.X1 - Extender.Left) + 40
            End If
            If .Y1 < .Y2 Then
                Extender.Top = .Y1 - (70 + mcnstMoveCntrlHeight)
                Height = (.Y2 - Extender.Top) + mcnstMoveCntrlHeight - 150
            Else
                Extender.Top = .Y2 - (70 + mcnstMoveCntrlHeight)
                Height = (.Y1 - Extender.Top) + 150 + mcnstMoveCntrlHeight - 150
            End If
        End With
        SetAllControls
    Case Else
        Extender.Left = cntrlControl.Left - 75
        Extender.Top = cntrlControl.Top - (75 + mcnstMoveCntrlHeight)
        Width = cntrlControl.Width + 150
        Height = cntrlControl.Height + 150 + mcnstMoveCntrlHeight
    End Select
    Extender.Visible = True
End Sub

Private Sub picSelection_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseDown(Index, Button, Shift, X, Y)
    msrdResizingDirection = Index
End Sub

Private Sub picSelection_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent MouseUp(Index, Button, Shift, X, Y)
End Sub

Public Sub SelectionResize()
    On Local Error Resume Next
    Dim lpPoint As PointAPI, rctRect As RECT
    mblnEditing = False
    GetCursorPos lpPoint
    GetWindowRect hWnd, rctRect
    lpPoint.X = lpPoint.X * Screen.TwipsPerPixelX
    lpPoint.Y = lpPoint.Y * Screen.TwipsPerPixelY
    rctRect.Left = rctRect.Left * Screen.TwipsPerPixelX + 60
    rctRect.Right = rctRect.Right * Screen.TwipsPerPixelX - 75
    rctRect.Top = rctRect.Top * Screen.TwipsPerPixelY + 320
    rctRect.Bottom = rctRect.Bottom * Screen.TwipsPerPixelY - 90
    Select Case msrdResizingDirection
    Case srdTopCenter, srdTopLeft, srdTopRight
        If mstrControlType = "Line" Then
            mctrlSelected.Y1 = mctrlSelected.Y1 + (lpPoint.Y - rctRect.Top)
            mctrlSelected.Y2 = mctrlSelected.Y2 - (lpPoint.Y - rctRect.Top)
        Else
            mctrlSelected.Top = mctrlSelected.Top + (lpPoint.Y - rctRect.Top)
            mctrlSelected.Height = mctrlSelected.Height - (lpPoint.Y - rctRect.Top)
        End If
    Case srdBottomCenter, srdBottomLeft, srdBottomRight
        If mstrControlType = "Line" Then
            mctrlSelected.Y2 = mctrlSelected.Y2 + (lpPoint.Y - rctRect.Bottom)
        Else
            mctrlSelected.Height = mctrlSelected.Height + (lpPoint.Y - rctRect.Bottom)
        End If
    Case srdMove
        If mstrControlType = "Line" Then
            mctrlSelected.X1 = mctrlSelected.X1 + (lpPoint.X - rctRect.Left)
            mctrlSelected.X2 = mctrlSelected.X2 + (lpPoint.X - rctRect.Left)
            mctrlSelected.Y1 = mctrlSelected.Y1 + (lpPoint.Y - rctRect.Top)
            mctrlSelected.Y2 = mctrlSelected.Y2 + (lpPoint.Y - rctRect.Top)
        Else
            mctrlSelected.Left = mctrlSelected.Left + (lpPoint.X - rctRect.Left) - 90
            mctrlSelected.Width = mctrlSelected.Width
            mctrlSelected.Top = mctrlSelected.Top + (lpPoint.Y - rctRect.Top) + 170
            mctrlSelected.Height = mctrlSelected.Height
        End If
    End Select
    Select Case msrdResizingDirection
    Case srdTopLeft, srdMiddleLeft, srdBottomLeft
        If mstrControlType = "Line" Then
            mctrlSelected.X1 = mctrlSelected.X1 + (lpPoint.X - rctRect.Left)
            mctrlSelected.X2 = mctrlSelected.X2 - (lpPoint.X - rctRect.Left)
        Else
            mctrlSelected.Left = mctrlSelected.Left + (lpPoint.X - rctRect.Left)
            mctrlSelected.Width = mctrlSelected.Width - (lpPoint.X - rctRect.Left)
        End If
    Case srdTopRight, srdMiddleRight, srdBottomRight
        If mstrControlType = "Line" Then
            mctrlSelected.X2 = mctrlSelected.X2 + (lpPoint.X - rctRect.Right)
        Else
            mctrlSelected.Width = mctrlSelected.Width + (lpPoint.X - rctRect.Right)
        End If
    End Select
    ShowSelection mctrlSelected, mstrControlType
End Sub
