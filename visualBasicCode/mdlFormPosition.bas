Attribute VB_Name = "mdlFormPosition"
Option Explicit

Public Enum SetFormPositionAccordingToConstants
    SFPAccordingToCursor = 1
    SFPAccordingToControl = 2
    SFPAccordingToCell = 3
End Enum
Public Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Public Type PointAPI
    X As Long
    Y As Long
End Type
Public Declare Function GetCursorPos Lib "user32" (lpPoint As PointAPI) As Long
Public Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long

Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

Public Function FormWithinForm(Parent As Object, Child As Object)
On Local Error Resume Next
    SetParent Child.hWnd, Parent.hWnd
    FormWithinForm = (Err.Number = 0 And Err.LastDllError = 0)
End Function

Public Sub SetFormPosition(ByRef frmForm As Form, ByVal SFPAccordingTo As SetFormPositionAccordingToConstants, _
                           Optional ByVal cntrlConrol As Object = Nothing, Optional ByVal strCntrlKey As String = "")
On Local Error Resume Next
Dim rectPos As RECT, papiPos As PointAPI
Dim dblLeft As Double, dblTop As Double
Dim dblRight As Double, dblBottom As Double
Dim dblScrnWidth As Double, dblScrnHeight As Double
    dblLeft = 0
    dblTop = 0
    dblRight = 0
    dblBottom = 0
    Select Case SFPAccordingTo
    Case SFPAccordingToCursor
        If GetCursorPos(papiPos) <> 0 Then
            'If GetCursorPos succeed
            dblLeft = papiPos.X
            dblTop = papiPos.Y
            dblRight = dblLeft
            dblBottom = dblTop
        End If
    Case SFPAccordingToControl, SFPAccordingToCell
        If Not cntrlConrol Is Nothing Then
            If GetWindowRect(cntrlConrol.hWnd, rectPos) <> 0 Then
                'If GetWindowRect succeed
                dblLeft = rectPos.Left
                dblTop = rectPos.Top
                dblRight = rectPos.Right
                dblBottom = rectPos.Bottom
                Select Case TypeName(cntrlConrol)
                Case "Toolbar"
                    If strCntrlKey <> "" Then
                        With cntrlConrol.Buttons(strCntrlKey)
                            dblLeft = dblLeft + .Left / Screen.TwipsPerPixelX
                            dblTop = dblTop + .Top / Screen.TwipsPerPixelX
                            dblRight = dblLeft + .Width / Screen.TwipsPerPixelX
                            dblBottom = dblBottom + .Height / Screen.TwipsPerPixelX
                        End With
                    End If
                Case Else
                    If SFPAccordingTo = SFPAccordingToCell Then
                        dblLeft = dblLeft + cntrlConrol.CellLeft / Screen.TwipsPerPixelX
                        dblTop = dblTop + cntrlConrol.CellTop / Screen.TwipsPerPixelX
                        dblRight = dblLeft + cntrlConrol.CellWidth / Screen.TwipsPerPixelX
                        dblBottom = dblTop + cntrlConrol.CellHeight / Screen.TwipsPerPixelX
                    End If
                End Select
            End If
        End If
    End Select
    With Screen
        dblLeft = dblLeft * .TwipsPerPixelX
        dblTop = dblTop * .TwipsPerPixelY
        dblRight = dblRight * .TwipsPerPixelX
        dblBottom = dblBottom * .TwipsPerPixelY
        dblScrnWidth = .Width
        dblScrnHeight = .Height
    End With
    With frmForm
        If dblLeft + 100 + .Width > dblScrnWidth Then
            If dblRight - .Width < 0 Then
                .Left = dblLeft - (dblLeft + 100 + .Width - dblScrnWidth)
            Else
                .Left = dblRight - .Width
            End If
        Else
            .Left = dblLeft
        End If
        If dblBottom + 500 + .Height > dblScrnHeight Then
            If dblTop - .Height < 0 Then
                .Top = dblTop - (dblTop + 500 + .Height - dblScrnHeight)
            Else
                .Top = dblTop - .Height
            End If
        Else
            .Top = dblBottom
        End If
    End With
End Sub

Public Function GetResolution() As String
On Local Error GoTo Err_Exit
    GetResolution = CStr(GetResolutionX()) & " X " & CStr(GetResolutionY())
Exit Function
Err_Exit:
    GetResolution = "-1"
End Function

Public Function GetResolutionX() As Long
On Local Error GoTo Err_Exit
    GetResolutionX = Screen.Width / Screen.TwipsPerPixelX
Exit Function
Err_Exit:
    GetResolutionX = -1
End Function

Public Function GetResolutionY() As Long
On Local Error GoTo Err_Exit
    GetResolutionY = Screen.Height / Screen.TwipsPerPixelY
Exit Function
Err_Exit:
    GetResolutionY = -1
End Function

Public Sub Align(ByRef frmForm As Form, Optional ByVal lngAdjustTop As Long = 0, Optional ByVal lngAdjustLeft As Long = 0)
    With frmForm
        .Left = (MDIFormMain.Width - .Width) / 2 - lngAdjustLeft
        .Top = (MDIFormMain.Height - .Height) / 2 - lngAdjustTop
    End With
End Sub
