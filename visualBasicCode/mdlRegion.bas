Attribute VB_Name = "mdlRegion"
Option Explicit

Public numXtras As Integer
Public PATHSTR As String

Private Const PI    As Double = 3.14159265358979
Private Const RADS  As Double = PI / 180    '<Degrees> * RADS = radians

Private Type PointAPI   'API Point structure
    X   As Long
    Y   As Long
End Type

Private Declare Function ExtCreateRegion Lib "gdi32" (lpXform As Any, ByVal nCount As Long, lpRgnData As Any) As Long

Private Sub RotatePoints(uAxisPt As PointAPI, uRotatePts() As PointAPI, fDegrees As Single)

'Rotates an array of PointAPI points around a center point by fDegrees

Dim lIdx As Long
Dim fDX As Single
Dim fDY As Single
Dim fRadians As Single

    fRadians = fDegrees * RADS

    For lIdx = 0 To UBound(uRotatePts)
        fDX = uRotatePts(lIdx).X - uAxisPt.X
        fDY = uRotatePts(lIdx).Y - uAxisPt.Y
        uRotatePts(lIdx).X = uAxisPt.X + ((fDX * Cos(fRadians)) + (fDY * Sin(fRadians)))
        uRotatePts(lIdx).Y = uAxisPt.Y + -((fDX * Sin(fRadians)) - (fDY * Cos(fRadians)))
    Next lIdx
    
End Sub

Public Sub AppExit()
Dim f As Form
    For Each f In Forms
        Unload f
    Next f
    End
End Sub

Public Function LoadRegionData() As Long
On Local Error Resume Next
    LoadRegionData = ExtCreateRegion(ByVal 0&, 560, 32)
End Function

Public Function LoadRegionDataFromFile(ByVal sFileName As String) As Long
On Local Error GoTo ErrorHandler
Dim iFile As Long, B() As Byte, dwCount As Long
    If Dir(sFileName) = "" Then MsgBox sFileName & " not found!": Exit Function

   iFile = FreeFile
   Open sFileName For Binary Access Read Lock Write As #iFile
   ReDim B(0 To LOF(iFile) - 1) As Byte
   Get #iFile, , B
   Close #iFile
   
   dwCount = UBound(B) - LBound(B) + 1
   LoadRegionDataFromFile = ExtCreateRegion(ByVal 0&, dwCount, B(0))
    LoadRegionDataFromFile = ExtCreateRegion(ByVal 0&, 560, 32)
   Exit Function

ErrorHandler:
Dim lErr As Long, sErr As String
   lErr = Err.Number: sErr = Err.Description
   If iFile > 0 Then
      Close #iFile
   End If
   Err.Raise lErr, App.EXEName, sErr
   Exit Function
End Function
