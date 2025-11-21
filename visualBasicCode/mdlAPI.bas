Attribute VB_Name = "mdlAPI"
Option Explicit

'//SHGetSpecialFolderLocation constants
'//Usage:
'//mTempPath = mBrowse.BrowShow(Me.hwnd, CSIDL_DESKTOP,BIF_BROWSEINCLUDEFILES,
'//ReturnPath, "Select File" & Chr(13) & "File
'//Name Will Be USetup.IFO",mDefaultFolder)

Public Enum Root_Folder
    CSIDL_DESKTOP = &H0                    '// 0x0000  '0
    CSIDL_PROGRAMS = &H2                   '// 0x0002  '2
    CSIDL_CONTROLS = &H3                   '// 0x0003    '3
    CSIDL_PRINTERS = &H4                  '// 0x0004    '4
    CSIDL_PERSONAL = &H5                  '// 0x0005    '5
    CSIDL_FAVORITES = &H6                  '// 0x0006    '6
    CSIDL_STARTUP = &H7                    '// 0x0007    '7
    CSIDL_RECENT = &H8                     '// 0x0008    '8
    CSIDL_SENDTO = &H9                     '// 0x0009    '9
    CSIDL_BITBUCKET = &HA                 '// 0x000a    '10
    CSIDL_STARTMENU = &HB                 '// 0x000b    '11
    CSIDL_DESKTOPDIRECTORY = &H10         '// 0x0010    '16
    CSIDL_DRIVES = &H11                    '// 0x0011    '17
    CSIDL_NETWORK = &H12                   '// 0x0012    '18
    CSIDL_NETHOOD = &H13                   '// 0x0013    '19
    CSIDL_FONTS = &H14                     '// 0x0014    '20
    CSIDL_TEMPLATES = &H15                 '// 0x0015    '21
    CSIDL_COMMON_STARTMENU = &H16          '// 0x0016    '22
    CSIDL_COMMON_PROGRAMS = &H17           '// 0X0017    '23
    CSIDL_COMMON_STARTUP = &H18            '// 0x0018    '24
    CSIDL_COMMON_DESKTOPDIRECTORY = &H19   '// 0x0019    '25
    CSIDL_APPDATA = &H1A                   '// 0x001a    '26
    CSIDL_PRINTHOOD = &H1B                 '// 0x001b    '27
End Enum

'// SHBrowseForFolder constants
Public Enum Return_From
    BIF_RETURNONLYFSDIRS = &H1 '// Browse for directory
    BIF_DONTGOBELOWDOMAIN = &H2    '// For starting the Find Computer
    BIF_STATUSTEXT = &H4
    BIF_RETURNFSANCESTORS = &H8
    BIF_EDITBOX = &H10    '16
    BIF_BROWSEFORCOMPUTER = &H1000 '4096     '// Browse for computer
    BIF_BROWSEFORPRINTER = &H2000 '8192  '// Browse for printers
    BIF_BROWSEINCLUDEFILES = &H4000 '16384   '// Browse for everything
    BIF_NEWDIALOGSTYLE = &H40 '//To create New Folder Option
End Enum

Public Enum Return_Type
    ReturnPath = 0
    ReturnName = 1
End Enum

Public Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As String) As Long
Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" _
                              (ByVal pIdl As Long, ByVal pszPath As String) As Long
Declare Function SHGetSpecialFolderLocation Lib "shell32.dll" _
                              (ByVal hwndOwner As Long, ByVal nFolder As Long, _
                              pIdl As ITEMIDLIST) As Long
Public Const NOERROR = 0
Declare Sub CoTaskMemFree Lib "ole32.dll" (ByVal pv As Long)
Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" _
                              (lpBrowseInfo As BROWSEINFO) As Long ' ITEMIDLIST

Type SHITEMID   ' mkid
    cb As Long       ' Size of the ID (including cb itself)
    abID() As Byte  ' The item ID (variable length)
End Type

Type ITEMIDLIST   ' idl
    mkid As SHITEMID
End Type

Public Const MAX_PATH = 260

Private Const WM_USER = &H400

Private Const BFFM_INITIALIZED = 1
Private Const BFFM_SELCHANGED = 2

Private Const BFFM_SETSTATUSTEXT = (WM_USER + 100)
Private Const BFFM_SETSELECTION = (WM_USER + 102)

Public m_CurrentDirectory As String

' SHGetSpecialFolderLocation successful rtn val
Public Type BROWSEINFO   ' bi

    ' Handle of the owner window for the dialog box.
    hOwner As Long
    
    ' Pointer to an item identifier list (an ITEMIDLIST structure) specifying the location
    ' of the "root" folder to browse from. Only the specified folder and its subfolders
    ' appear in the dialog box. This member can be NULL, and in that case, the
    ' name space root (the desktop folder) is used.
    pidlRoot As Long
    
    ' Pointer to a buffer that receives the display name of the folder selected by the
    ' user. The size of this buffer is assumed to be MAX_PATH bytes.
    pszDisplayName As String
    
    ' Pointer to a null-terminated string that is displayed above the tree view control
    ' in the dialog box. This string can be used to specify instructions to the user.
    lpszTitle As String
    
    ' Value specifying the types of folders to be listed in the dialog box as well as
    ' other options. This member can include zero or more of the following values below.
    ulFlags As Long
    
    ' Address an application-defined function that the dialog box calls when events
    ' occur. For more information, see the description of the BrowseCallbackProc
    ' function. This member can be NULL.
    lpfn As Long
    
    ' Application-defined value that the dialog box passes to the callback function
    ' (if one is specified).
    lParam As Long
    
    ' Variable that receives the image associated with the selected folder. The image
    ' is specified as an index to the system image list.
    iImage As Long

End Type

Public Function BrowseCallbackProc(ByVal hWnd As Long, ByVal uMsg As Long, ByVal lp As Long, ByVal pData As Long) As Long
On Local Error Resume Next  'Sugested by MS to prevent an error from
                        'propagating back into the calling process.
Dim lpIDList As Long
Dim ret As Long
Dim sBuffer As String
    Select Case uMsg
        Case BFFM_INITIALIZED
            Call SendMessage(hWnd, BFFM_SETSELECTION, 1, m_CurrentDirectory)
        Case BFFM_SELCHANGED
            sBuffer = Space(MAX_PATH)
            ret = SHGetPathFromIDList(lp, sBuffer)
            If ret = 1 Then
                Call SendMessage(hWnd, BFFM_SETSTATUSTEXT, 0, sBuffer)
            End If
    End Select
    BrowseCallbackProc = 0
End Function

Public Function BrowShow(ByVal hWnd As Long, Optional RootFolder As Root_Folder, Optional ReturnFrom As Return_From, Optional ReturnType As Return_Type, Optional Title As String, Optional startDirectory As String) As String
Dim BI As BROWSEINFO
Dim IDL As ITEMIDLIST
Dim nFolder As Long
Dim pIdl As Long
Dim sPath As String
    BrowShow = ""
    m_CurrentDirectory = startDirectory & vbNullChar
    With BI
        .hOwner = hWnd
        nFolder = RootFolder
        If SHGetSpecialFolderLocation(ByVal hWnd, ByVal nFolder, IDL) = NOERROR Then
          .pidlRoot = IDL.mkid.cb
        End If
        .pszDisplayName = String$(MAX_PATH, 0)
        If Trim(Title) = "" Then
            .lpszTitle = "Browse Dialog Default "
        Else
            .lpszTitle = Title
        End If
        .ulFlags = ReturnFrom
        .lpfn = GetAddressofFunction(AddressOf BrowseCallbackProc)
    End With
    pIdl = SHBrowseForFolder(BI)
    If pIdl = 0 Then Exit Function
    sPath = String$(MAX_PATH, 0)
    SHGetPathFromIDList ByVal pIdl, ByVal sPath
    CoTaskMemFree pIdl
    If ReturnType = 0 Then
        BrowShow = Left(sPath, InStr(sPath, vbNullChar) - 1)
    Else
        BrowShow = Left$(BI.pszDisplayName, InStr(BI.pszDisplayName, vbNullChar) - 1)
    End If
End Function

' This function allows you to assign a function pointer to a vaiable.
Private Function GetAddressofFunction(Add As Long) As Long
    GetAddressofFunction = Add
End Function
