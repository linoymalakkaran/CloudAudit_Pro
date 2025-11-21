VERSION 5.00
Begin VB.UserControl ucShape 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   BackStyle       =   0  'Transparent
   ClientHeight    =   975
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1335
   LockControls    =   -1  'True
   ScaleHeight     =   975
   ScaleWidth      =   1335
   ToolboxBitmap   =   "ucShape.ctx":0000
   Begin VB.Shape shpShape 
      Height          =   555
      Left            =   120
      Top             =   210
      Width           =   885
   End
End
Attribute VB_Name = "ucShape"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Event Declarations:
Event Click() 'MappingInfo=UserControl,UserControl,-1,Click
Attribute Click.VB_Description = "Occurs when the user presses and then releases a mouse button over an object."


Private Sub UserControl_Resize()
    With shpShape
        .Left = 0
        .Top = 0
        .Width = Width
        .Height = Height
    End With
    Refresh
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=shpShape,shpShape,-1,Shape
Public Property Get Shape() As ShapeConstants
Attribute Shape.VB_Description = "Returns/sets a value indicating the appearance of a control."
    Shape = shpShape.Shape
End Property

Public Property Let Shape(ByVal New_Shape As ShapeConstants)
    shpShape.Shape() = New_Shape
    PropertyChanged "Shape"
End Property

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    shpShape.Shape = PropBag.ReadProperty("Shape", 0)
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("Shape", shpShape.Shape, 0)
End Sub

Private Sub UserControl_Click()
    RaiseEvent Click
End Sub

