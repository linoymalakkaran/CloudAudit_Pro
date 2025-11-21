VERSION 5.00
Begin VB.UserControl ucLine 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BackStyle       =   0  'Transparent
   ClientHeight    =   2190
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5040
   LockControls    =   -1  'True
   ScaleHeight     =   2190
   ScaleWidth      =   5040
   Begin VB.Line lnLine 
      X1              =   30
      X2              =   3180
      Y1              =   45
      Y2              =   225
   End
End
Attribute VB_Name = "ucLine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Event Declarations:
Event Click() 'MappingInfo=UserControl,UserControl,-1,Click
Attribute Click.VB_Description = "Occurs when the user presses and then releases a mouse button over an object."

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,Y2
Public Property Get Y2() As Single
Attribute Y2.VB_Description = "Returns/sets the Y coordinate of the ending point of a Line control."
    Y2 = Extender.Top + lnLine.Y2
End Property

Public Property Let Y2(ByVal New_Y2 As Single)
    lnLine.Y2 = Abs(Extender.Top - New_Y2)
    Height = lnLine.Y2
    PropertyChanged "Y2"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,Y1
Public Property Get Y1() As Single
Attribute Y1.VB_Description = "Returns/sets the Y coordinate of the starting point of a Line control."
    Y1 = Extender.Top
End Property

Public Property Let Y1(ByVal New_Y1 As Single)
    lnLine.Y1 = 0
    Extender.Top = New_Y1
    PropertyChanged "Y1"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,X2
Public Property Get X2() As Single
Attribute X2.VB_Description = "Returns/sets the X coordinate of the ending point of a Line control."
    X2 = Extender.Left + lnLine.X2
End Property

Public Property Let X2(ByVal New_X2 As Single)
    lnLine.X2 = Abs(Extender.Left - New_X2)
    Width = lnLine.X2
    PropertyChanged "X2"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,X1
Public Property Get X1() As Single
Attribute X1.VB_Description = "Returns/sets the X coordinate of the starting point of a Line control."
    X1 = Extender.Left
End Property

Public Property Let X1(ByVal New_X1 As Single)
    lnLine.X1 = 0
    Extender.Left = New_X1
    PropertyChanged "X1"
End Property

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    Height = Abs(PropBag.ReadProperty("Y2", 885) - Extender.Top)
    Extender.Top = PropBag.ReadProperty("Y1", 705)
    Width = Abs(PropBag.ReadProperty("X2", 3615) - Extender.Left)
    Extender.Left = PropBag.ReadProperty("X1", 465)
    lnLine.DrawMode = PropBag.ReadProperty("DrawMode", 13)
    lnLine.BorderStyle = PropBag.ReadProperty("BorderStyle", 1)
End Sub

Private Sub UserControl_Resize()
    Static blnIsNotFirstTime As Boolean
    If Width < 50 Then
        Width = 50
    End If
    If Height < 50 Then
        Height = 50
    End If
    If Not blnIsNotFirstTime Then
        lnLine.X1 = IIf(Width <= 50, Width / 2, 0)
        lnLine.Y1 = IIf(Height <= 50, Height / 2, 0)
        lnLine.X2 = IIf(Width <= 50, Width / 2, Width)
        lnLine.Y2 = IIf(Height <= 50, Height / 2, Height)
        blnIsNotFirstTime = True
    End If
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("Y2", Extender.Top + Height, 885)
    Call PropBag.WriteProperty("Y1", Extender.Top, 705)
    Call PropBag.WriteProperty("X2", Extender.Left + Width, 3615)
    Call PropBag.WriteProperty("X1", Extender.Left, 465)
    Call PropBag.WriteProperty("DrawMode", lnLine.DrawMode, 13)
    Call PropBag.WriteProperty("BorderStyle", lnLine.BorderStyle, 1)
End Sub

Private Sub UserControl_Click()
    RaiseEvent Click
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,DrawMode
Public Property Get DrawMode() As DrawModeConstants
Attribute DrawMode.VB_Description = "Sets the appearance of output from graphics methods or of a Shape or Line control."
    DrawMode = lnLine.DrawMode
End Property

Public Property Let DrawMode(ByVal New_DrawMode As DrawModeConstants)
    lnLine.DrawMode() = New_DrawMode
    PropertyChanged "DrawMode"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lnLine,lnLine,-1,BorderStyle
Public Property Get BorderStyle() As BorderStyleConstants
Attribute BorderStyle.VB_Description = "Returns/sets the border style for an object."
    BorderStyle = lnLine.BorderStyle
End Property

Public Property Let BorderStyle(ByVal New_BorderStyle As BorderStyleConstants)
    lnLine.BorderStyle() = New_BorderStyle
    PropertyChanged "BorderStyle"
End Property
