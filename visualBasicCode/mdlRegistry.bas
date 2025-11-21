Attribute VB_Name = "mdlRegistry"
Option Explicit

'Security Mask constants
Public Const READ_CONTROL = &H20000
Public Const SYNCHRONIZE = &H100000
Public Const STANDARD_RIGHTS_ALL = &H1F0000
Public Const STANDARD_RIGHTS_READ = READ_CONTROL
Public Const STANDARD_RIGHTS_WRITE = READ_CONTROL
Public Const KEY_QUERY_VALUE = &H1
Public Const KEY_SET_VALUE = &H2
Public Const KEY_CREATE_SUB_KEY = &H4
Public Const KEY_ENUMERATE_SUB_KEYS = &H8
Public Const KEY_NOTIFY = &H10
Public Const KEY_CREATE_LINK = &H20

Public Const KEY_ALL_ACCESS = ((STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or _
   KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or _
   KEY_CREATE_LINK) And (Not SYNCHRONIZE))

Public Const KEY_READ = ((STANDARD_RIGHTS_READ Or KEY_QUERY_VALUE Or _
   KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY) And (Not SYNCHRONIZE))

Public Const KEY_EXECUTE = ((KEY_READ) And (Not SYNCHRONIZE))
Public Const KEY_WRITE = ((STANDARD_RIGHTS_WRITE Or KEY_SET_VALUE _
   Or KEY_CREATE_SUB_KEY) And (Not SYNCHRONIZE))

' Possible registry data types
Public Enum InTypes
   ValNull = 0
   ValString = 1
   ValXString = 2
   ValBinary = 3
   ValDWord = 4
   ValLink = 6
   ValMultiString = 7
   ValResList = 8
End Enum

' Registry value type definitions
Public Const REG_NONE As Long = 0
Public Const REG_SZ As Long = 1
Public Const REG_EXPAND_SZ As Long = 2
Public Const REG_BINARY As Long = 3
Public Const REG_DWORD As Long = 4
Public Const REG_LINK As Long = 6
Public Const REG_MULTI_SZ As Long = 7
Public Const REG_RESOURCE_LIST As Long = 8

' Registry section definitions
Public Const HKEY_CLASSES_ROOT = &H80000000
Public Const HKEY_CURRENT_USER = &H80000001
Public Const HKEY_LOCAL_MACHINE = &H80000002
Public Const HKEY_USERS = &H80000003
Public Const HKEY_PERFORMANCE_DATA = &H80000004
Public Const HKEY_CURRENT_CONFIG = &H80000005
Public Const HKEY_DYN_DATA = &H80000006

' Codes returned by Reg API calls
Private Const ERROR_NONE = 0
Private Const ERROR_BADDB = 1
Private Const ERROR_BADKEY = 2
Private Const ERROR_CANTOPEN = 3
Private Const ERROR_CANTREAD = 4
Private Const ERROR_CANTWRITE = 5
Private Const ERROR_OUTOFMEMORY = 6
Private Const ERROR_INVALID_PARAMETER = 7
Private Const ERROR_ACCESS_DENIED = 8
Private Const ERROR_INVALID_PARAMETERS = 87
Private Const ERROR_NO_MORE_ITEMS = 259

' Registry API functions used in this module (there are more of them)
Private Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegOpenKeyEx Lib "advapi32.dll" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, phkResult As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, ByVal lpData As String, lpcbData As Long) As Long
Private Declare Function RegEnumValue Lib "advapi32.dll" Alias "RegEnumValueA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpValueName As String, lpcbValueName As Long, ByVal lpReserved As Long, lpType As Long, ByVal lpData As String, lpcbData As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegSetValueExString Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, ByVal lpValue As String, ByVal cbData As Long) As Long
Private Declare Function RegSetValueExLong Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpValue As Long, ByVal cbData As Long) As Long
Private Declare Function RegFlushKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegEnumKey Lib "advapi32.dll" Alias "RegEnumKeyA" (ByVal hKey As Long, ByVal dwIndex As Long, ByVal lpName As String, ByVal cbName As Long) As Long
Private Declare Function RegDeleteKey Lib "advapi32.dll" Alias "RegDeleteKeyA" (ByVal hKey As Long, ByVal lpSubKey As String) As Long
Private Declare Function RegDeleteValue Lib "advapi32.dll" Alias "RegDeleteValueA" (ByVal hKey As Long, ByVal lpValueName As String) As Long

Public Function ReadRegistry(ByVal Group As Long, ByVal Section As String, ByVal Key As String) As String
On Local Error Resume Next
Dim lResult As Long, lKeyValue As Long, lDataTypeValue As Long, lValueLength As Long, sValue As String, td As Double
Dim TStr1 As String, TStr2 As String, i As Long
    lResult = RegOpenKey(Group, Section, lKeyValue)
    sValue = Space$(2048)
    lValueLength = Len(sValue)
    lResult = RegQueryValueEx(lKeyValue, Key, 0&, lDataTypeValue, sValue, lValueLength)
    If (lResult = 0) And (Err.Number = 0) Then
       If lDataTypeValue = REG_DWORD Then
          td = Asc(Mid$(sValue, 1, 1)) + &H100& * Asc(Mid$(sValue, 2, 1)) + &H10000 * Asc(Mid$(sValue, 3, 1)) + &H1000000 * CDbl(Asc(Mid$(sValue, 4, 1)))
          sValue = Format$(td, "000")
       End If
       If lDataTypeValue = REG_BINARY Then
           ' Return a binary field as a hex string (2 chars per byte)
           TStr2 = ""
           For i = 1 To lValueLength
              TStr1 = Hex(Asc(Mid(sValue, i, 1)))
              If Len(TStr1) = 1 Then TStr1 = "0" & TStr1
              TStr2 = TStr2 + TStr1
           Next
           sValue = TStr2
       Else
          sValue = Left$(sValue, lValueLength - 1)
       End If
    Else
       sValue = "Not Found"
    End If
    lResult = RegCloseKey(lKeyValue)
    ReadRegistry = sValue
End Function

Public Sub WriteRegistry(ByVal Group As Long, ByVal Section As String, ByVal Key As String, ByVal ValType As InTypes, ByVal Value As Variant)
On Local Error Resume Next
Dim lResult As Long
Dim lKeyValue As Long
Dim InLen As Long
Dim lNewVal As Long
Dim sNewVal As String
    lResult = RegCreateKey(Group, Section, lKeyValue)
    If ValType = ValDWord Then
       lNewVal = CLng(Value)
       InLen = 4
       lResult = RegSetValueExLong(lKeyValue, Key, 0&, ValType, lNewVal, InLen)
    Else
       If ValType = ValString Then Value = Value + Chr(0)
       sNewVal = Value
       InLen = Len(sNewVal)
       lResult = RegSetValueExString(lKeyValue, Key, 0&, 1&, sNewVal, InLen)
    End If
    lResult = RegFlushKey(lKeyValue)
    lResult = RegCloseKey(lKeyValue)
End Sub

Private Function ReadRegistryGetSubkey(ByVal Group As Long, ByVal Section As String, Idx As Long) As String
On Local Error Resume Next
Dim lResult As Long, lKeyValue As Long, lDataTypeValue As Long, lValueLength As Long, sValue As String, td As Double
    lResult = RegOpenKey(Group, Section, lKeyValue)
    sValue = Space$(2048)
    lValueLength = Len(sValue)
    lResult = RegEnumKey(lKeyValue, Idx, sValue, lValueLength)
    If (lResult = 0) And (Err.Number = 0) Then
       sValue = Left$(sValue, InStr(sValue, Chr(0)) - 1)
    Else
       sValue = "Not Found"
    End If
    lResult = RegCloseKey(lKeyValue)
    ReadRegistryGetSubkey = sValue
End Function

Private Function ReadRegistryGetAll(ByVal Group As Long, ByVal Section As String, Idx As Long) As Variant
On Local Error Resume Next
Dim lResult As Long, lKeyValue As Long, lDataTypeValue As Long
Dim lValueLength As Long, lValueNameLength As Long
Dim sValueName As String, sValue As String
Dim td As Double
    lResult = RegOpenKey(Group, Section, lKeyValue)
    sValue = Space$(2048)
    sValueName = Space$(2048)
    lValueLength = Len(sValue)
    lValueNameLength = Len(sValueName)
    lResult = RegEnumValue(lKeyValue, Idx, sValueName, lValueNameLength, 0&, lDataTypeValue, sValue, lValueLength)
    If (lResult = 0) And (Err.Number = 0) Then
       If lDataTypeValue = REG_DWORD Then
          td = Asc(Mid$(sValue, 1, 1)) + &H100& * Asc(Mid$(sValue, 2, 1)) + &H10000 * Asc(Mid$(sValue, 3, 1)) + &H1000000 * CDbl(Asc(Mid$(sValue, 4, 1)))
          sValue = Format$(td, "000")
       End If
       sValue = Left$(sValue, lValueLength - 1)
       sValueName = Left$(sValueName, lValueNameLength)
    Else
       sValue = "Not Found"
    End If
    lResult = RegCloseKey(lKeyValue)
    ReadRegistryGetAll = Array(lDataTypeValue, sValueName, sValue)
End Function

Public Function DeleteSubkey(ByVal Group As Long, ByVal Section As String) As String
On Local Error Resume Next
Dim lResult As Long, lKeyValue As Long
    lResult = RegOpenKeyEx(Group, vbNullChar, 0&, KEY_ALL_ACCESS, lKeyValue)
    lResult = RegDeleteKey(lKeyValue, Section)
    lResult = RegCloseKey(lKeyValue)
End Function

Private Function DeleteValue(ByVal Group As Long, ByVal Section As String, ByVal Key As String) As String
On Local Error Resume Next
Dim lResult As Long, lKeyValue As Long
    lResult = RegOpenKey(Group, Section, lKeyValue)
    lResult = RegDeleteValue(lKeyValue, Key)
    lResult = RegCloseKey(lKeyValue)
End Function

Public Function SetIniString(Key As String, Value As String, Optional Section As String = "Main") As Boolean
On Local Error GoTo Err_Exit
    WriteRegistry HKEY_CURRENT_USER, "SOFTWARE\AuditMate\" & Section, Key, ValString, Value
    SetIniString = True
Exit Function
Err_Exit:
    SetIniString = False
End Function

Public Function GetIniString(Key As String, Optional Default As String, Optional Section As String = "Main") As String
On Local Error GoTo Err_Exit
    GetIniString = ReadRegistry(HKEY_CURRENT_USER, "SOFTWARE\AuditMate\" & Section, Key)
    If GetIniString = "Not Found" Then
        GetIniString = Default
    End If
Exit Function
Err_Exit:
    GetIniString = Default
End Function

Public Function DeleteIniString(Key As String, Optional Section As String = "Main") As Boolean
On Local Error GoTo Err_Exit
    DeleteValue HKEY_CURRENT_USER, "SOFTWARE\AuditMate\" & Section, Key
    DeleteIniString = True
Exit Function
Err_Exit:
    DeleteIniString = False
End Function
