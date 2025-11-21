Attribute VB_Name = "mdlDate"
Option Explicit
' Created on 30/03/2006
' Purpose : This module is using for declaring methods and constants for handling date
' contents: Date methods and constants
' ------------------------------------------------------------------------------------
Public Enum SQLDateFormatStyles
    SQLDateFormatStyleUSA = 101
    SQLDateFormatStyleANSI = 102
    SQLDateFormatStyleBritishFrench = 103
    SQLDateFormatStyleGerman = 104
    SQLDateFormatStyleItalian = 105
    SQLDateFormatStyle_dd_MMM_yyyy = 106
    SQLDateFormatStyle_MMM_dd_yyyy = 107
    SQLDateFormatStyleTime = 108
    SQLDateFormatStyleLongDateTime = 109
    SQLDateFormatStyleUSANew = 110
    SQLDateFormatStyleJAPAN = 111
    SQLDateFormatStyleISO = 112
    SQLDateFormatStyleEurope = 113
    SQLDateFormatStyleTimeMilliSeconds = 114
    SQLDateFormatStyleODBC = 120
    SQLDateFormatStyleODBCMilliSeconds = 121
End Enum
Public pSQLDateFormatStyle As SQLDateFormatStyles

Dim blnMDSettingsChanged As Boolean
Public Declare Function GetUserDefaultLCID Lib "kernel32" () As Long
Public Declare Function GetSystemDefaultLCID Lib "kernel32" () As Long
Public Declare Function GetThreadLocale Lib "kernel32" () As Long

Public Declare Function GetLocaleInfo Lib "kernel32" _
   Alias "GetLocaleInfoA" _
  (ByVal Locale As Long, _
   ByVal LCType As Long, _
   ByVal lpLCData As String, _
   ByVal cchData As Long) As Long

Public Declare Function SetLocaleInfo Lib "kernel32" _
    Alias "SetLocaleInfoA" _
   (ByVal Locale As Long, _
    ByVal LCType As Long, _
    ByVal lpLCData As String) As Long

Public Const HWND_BROADCAST As Long = &HFFFF&
Public Const WM_SETTINGCHANGE As Long = &H1A

Public Declare Function PostMessage Lib "user32" _
   Alias "PostMessageA" _
  (ByVal hWnd As Long, _
   ByVal wMsg As Long, _
   ByVal wParam As Long, _
   lParam As Any) As Long
Public Const LOCALE_SDECIMAL As Long = &HE        ' decimal separator
Public Const LOCALE_STHOUSAND = &HF  ' thousand separator
Public Const LOCALE_SSHORTDATE = &H1F ' short date
Public Const LOCALE_SCURRENCY = &H14 ' currency symbol
Public Const LOCALE_SMONDECIMALSEP = &H16 ' 'decimal separator for currency
Public Const LOCALE_SMONTHOUSANDSEP = &H17 ' thousand separator for currency

Public old_LOCALE_SDECIMAL As String
Public old_LOCALE_STHOUSAND As String
Public old_LOCALE_SSHORTDATE As String
Public old_LOCALE_SMONTHOUSANDSEP As String
Public old_LOCALE_SMONDECIMALSEP As String
Public old_LOCALE_SCURRENCY As String

Dim LCID As Long, iRet As Long, lpLCDataVar As String, Symbol As String
Dim iRet2 As Long, pos As Integer

Public Function SQLDateFormatString() As String
    Select Case pSQLDateFormatStyle
    Case SQLDateFormatStyleUSA
        SQLDateFormatString = "MM/dd/yyyy"
    Case SQLDateFormatStyleANSI
        SQLDateFormatString = "yyyy.MM.dd"
    Case SQLDateFormatStyleBritishFrench
        SQLDateFormatString = "dd/MM/yyyy"
    Case SQLDateFormatStyleGerman
        SQLDateFormatString = "dd.MM.yyyy"
    Case SQLDateFormatStyleItalian
        SQLDateFormatString = "dd-MM-yyyy"
    Case SQLDateFormatStyle_dd_MMM_yyyy
        SQLDateFormatString = "dd MMM yyyy"
    Case SQLDateFormatStyle_MMM_dd_yyyy
        SQLDateFormatString = "MMM dd, yy"
    Case SQLDateFormatStyleTime
        SQLDateFormatString = "hh:mm:ss"
    Case SQLDateFormatStyleLongDateTime
        SQLDateFormatString = "MMM dd yyyy hh:mi:ss:mmmAM"
    Case SQLDateFormatStyleUSANew
        SQLDateFormatString = "MM-dd-yyyy"
    Case SQLDateFormatStyleJAPAN
        SQLDateFormatString = "yyyy/MM/dd"
    Case SQLDateFormatStyleISO
        SQLDateFormatString = "yyyyMMdd"
    Case SQLDateFormatStyleEurope
        SQLDateFormatString = "dd MMM yyyy hh:mm:ss:mmm"
    Case SQLDateFormatStyleTimeMilliSeconds
        SQLDateFormatString = "hh:mi:ss:mmm"
    Case SQLDateFormatStyleODBC
        SQLDateFormatString = "yyyy-MM-dd hh:mi:ss"
    Case SQLDateFormatStyleODBCMilliSeconds
        SQLDateFormatString = "yyyy-MM-dd hh:mi:ss.mmm"
    Case Else
        SQLDateFormatString = "dd/MM/yyyy"
    End Select
End Function

Public Function SQLGetDateFormatStyle(ByVal strDateFormatString As String) As SQLDateFormatStyles
    'Req No:141/07-02
    Select Case strDateFormatString
    Case "MM/dd/yyyy", "M/d/yyyy", "MM/dd/yy", "M/d/yy"
        SQLGetDateFormatStyle = SQLDateFormatStyleUSA
    Case "yyyy.MM.dd", "yy.MM.dd"
        SQLGetDateFormatStyle = SQLDateFormatStyleANSI
    Case "dd/MM/yyyy", "dd/MM/yy"
        SQLGetDateFormatStyle = SQLDateFormatStyleBritishFrench
    Case "dd.MM.yyyy", "dd.MM.yy"
        SQLGetDateFormatStyle = SQLDateFormatStyleGerman
    Case "dd-MM-yyyy", "dd-MM-yy"
        SQLGetDateFormatStyle = SQLDateFormatStyleItalian
    Case "dd MMM yyyy", "dd MMM yy"
        SQLGetDateFormatStyle = SQLDateFormatStyle_dd_MMM_yyyy
    Case "MMM dd, yy", "MMM dd, yyyy"
        SQLGetDateFormatStyle = SQLDateFormatStyle_MMM_dd_yyyy
    Case "hh:mm:ss"
        SQLGetDateFormatStyle = SQLDateFormatStyleTime
    Case "MMM dd yyyy hh:mi:ss:mmmAM", "MMM dd yy hh:mi:ss:mmmAM"
        SQLGetDateFormatStyle = SQLDateFormatStyleLongDateTime
    Case "MM-dd-yyyy", "MM-dd-yy"
        SQLGetDateFormatStyle = SQLDateFormatStyleUSANew
    Case "yyyy/MM/dd", "yy/MM/dd"
        SQLGetDateFormatStyle = SQLDateFormatStyleJAPAN
    Case "yyyyMMdd", "yyMMdd"
        SQLGetDateFormatStyle = SQLDateFormatStyleISO
    Case "dd MMM yyyy hh:mm:ss:mmm", "dd MMM yy hh:mm:ss:mmm"
        SQLGetDateFormatStyle = SQLDateFormatStyleEurope
    Case "hh:mi:ss:mmm"
        SQLGetDateFormatStyle = SQLDateFormatStyleTimeMilliSeconds
    Case "yyyy-MM-dd hh:mi:ss", "yy-MM-dd hh:mi:ss"
        SQLGetDateFormatStyle = SQLDateFormatStyleODBC
    Case "yyyy-MM-dd hh:mi:ss.mmm", "yy-MM-dd hh:mi:ss.mmm"
        SQLGetDateFormatStyle = SQLDateFormatStyleODBCMilliSeconds
    Case Else
        SQLGetDateFormatStyle = SQLDateFormatStyleBritishFrench
        'Req No:141/07-02
        pMVE.MsgBox "AuditMate is not supporting your date format '" & strDateFormatString & "'.", , "AuditMate"
    End Select
End Function

Public Sub setMDSettings()
    blnMDSettingsChanged = False
    ' read currency symbol
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SCURRENCY, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SCURRENCY, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    If Symbol <> " " Then
        'change currency symbol
        blnMDSettingsChanged = True
        old_LOCALE_SCURRENCY = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SCURRENCY, " ")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    
    ' read decimal separator
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SDECIMAL, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SDECIMAL, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    If Symbol <> "." Then
        'change decimal separator
        blnMDSettingsChanged = True
        old_LOCALE_SDECIMAL = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SDECIMAL, ".")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If

    ' read thousand separator
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_STHOUSAND, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_STHOUSAND, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    
    If Symbol <> "," Then
        'change thousand separator
        blnMDSettingsChanged = True
        old_LOCALE_STHOUSAND = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_STHOUSAND, ",")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    
    ' read decimal separator for currency
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SMONDECIMALSEP, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SMONDECIMALSEP, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    If Symbol <> "." Then
        'change decimal separator for currency
        blnMDSettingsChanged = True
        old_LOCALE_SMONDECIMALSEP = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SMONDECIMALSEP, ".")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    
    
    
' read thousand separator for currency
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SMONTHOUSANDSEP, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SMONTHOUSANDSEP, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    
    If Symbol <> "," Then
        'change thousand separator
        blnMDSettingsChanged = True
        old_LOCALE_SMONTHOUSANDSEP = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SMONTHOUSANDSEP, ",")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
' read short date
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    
    If Symbol <> "MM/dd/yyyy" Then
        'change thousand separator
        blnMDSettingsChanged = True
        old_LOCALE_SSHORTDATE = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SSHORTDATE, "MM/dd/yyyy")
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
End Sub

Public Sub restoreSettings()
'restore the original settings in cp
    If old_LOCALE_SCURRENCY <> vbNullString Then
    ' restore currency symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SCURRENCY, old_LOCALE_SCURRENCY)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    
    If old_LOCALE_SDECIMAL <> vbNullString Then
    ' restore decimal symbols
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SDECIMAL, old_LOCALE_SDECIMAL)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    If old_LOCALE_STHOUSAND <> vbNullString Then
    ' restore thousand separator
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_STHOUSAND, old_LOCALE_STHOUSAND)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    If old_LOCALE_SMONDECIMALSEP <> vbNullString Then
    ' restore decimal separator for currency
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SMONDECIMALSEP, old_LOCALE_SMONDECIMALSEP)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    If old_LOCALE_SMONTHOUSANDSEP <> vbNullString Then
    ' restore thousand separator for currency
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SMONTHOUSANDSEP, old_LOCALE_SMONTHOUSANDSEP)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
    
    If old_LOCALE_SSHORTDATE <> vbNullString Then
    ' restore short date
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SSHORTDATE, old_LOCALE_SSHORTDATE)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
End Sub

Public Sub RegionalSettingsChangeDateFormat(ByVal strNewDateFormat As String)
    ' read short date
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    If Symbol <> strNewDateFormat Then
        'change thousand separator
        blnMDSettingsChanged = True
        old_LOCALE_SSHORTDATE = Symbol
        LCID = GetUserDefaultLCID()
        Call SetLocaleInfo(LCID, LOCALE_SSHORTDATE, strNewDateFormat)
        Call PostMessage(HWND_BROADCAST, WM_SETTINGCHANGE, 0&, ByVal 0&)
    End If
End Sub

Public Function RegionalSettingsGetDateFormat() As String
    ' read short date
    LCID = GetUserDefaultLCID()
    iRet = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, lpLCDataVar, 0)
    Symbol = String$(iRet, 0)
    iRet2 = GetLocaleInfo(LCID, LOCALE_SSHORTDATE, Symbol, iRet)
    pos = InStr(Symbol, Chr$(0))
    If pos > 0 Then
        Symbol = Left$(Symbol, pos - 1)
    End If
    RegionalSettingsGetDateFormat = Symbol
End Function

Public Function ServerDateTime(Optional AdoConnection As ADODB.Connection = Nothing) As Date
On Local Error GoTo Err_Exit
    If AdoConnection Is Nothing Then
        Set AdoConnection = AdoConn
    End If
    With AdoConnection.Execute("SELECT CURRENT_TIMESTAMP AS TIME")
        ServerDateTime = .Fields("TIME")
        .Close
    End With
Exit Function
Err_Exit:
    ServerDateTime = Now()
End Function

Public Function SQLIntToDate(ByVal strSQLIntExpression As String) As String
    SQLIntToDate = "CONVERT(smalldatetime, " & strSQLIntExpression & " - 2, " & pSQLDateFormatStyle & ")"
End Function

Public Function SQLDateToInt(ByVal strSQLDateExpression As String) As String
    SQLDateToInt = "CONVERT(int, " & strSQLDateExpression & ") + 2"
End Function

Public Function SQLDate(ByVal strSQLDateExpression As String) As String
    SQLDate = "CONVERT(smalldatetime, " & strSQLDateExpression & ", " & SQLDateFormatStyleBritishFrench & ")"
End Function
