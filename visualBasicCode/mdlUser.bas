Attribute VB_Name = "mdlUser"
Option Explicit

Public Const cnstUserIDHAMT = 1
Public Const cnstUserIDAdmin = 2

Public Const cnstUserPrvlTypeMenu = 1
Public Const cnstUserPrvlTypePrevileges = 2
Public Const cnstUserPrvlTypeValidations = 3
Public Const cnstUserPrvlTypeReportTypes = 4
Public Const cnstUserPrvlTypeSearchTypes = 5
Public Const cnstUserPrvlTypeInvoiceTypes = 6
Public Const cnstUserPrvlTypeVoucherTypeGroups = 7

Public Const cnstActionAddUser = 0
Public Const cnstActionDisableUsers = 1
Public Const cnstActionErasePassword = 2
Public Const cnstActionChangePassword = 3
Public Const cnstActionPOSPassword = 4

Public Const cnstUserDefaultTypeCostCenters = 1
Public Const cnstUserDefaultTypeVchrTypes = 2

'---Constants for Base Menus----------
Public Enum BaseMenuConstants
    cnstMenuBegin = 1
    cnstMenuConfigure = 2
    cnstMenuTransactions = 3
    cnstMenuActivities = 4
    cnstMenuAnalysis = 5
    cnstMenuReports = 6
    cnstMenuUtilities = 7
End Enum

Public pUserName As String, pUserID As Long, pUserCode As String, pLastLoginTime As Date
Public pIsSuperUser As Boolean, pIsAdmin As Boolean, pIsHAMT As Boolean
Dim mStartDt As Date, mEndDt As Date, mLaststartDt As Date, mLastEndDt As Date
Public pstrDomain As String

Public Function EncryptDecrypt1(Expression As String) As String
On Local Error GoTo Err_Exit
Dim strTmp As String, strArr() As String, strOutput As String, Inc As Byte
Dim Less As Byte
    strTmp = StrReverse(Expression)
    If Len(strTmp) = 0 Then
        EncryptDecrypt1 = ""
        Exit Function
    End If
    If Len(strTmp) = 1 Then
        EncryptDecrypt1 = strTmp
        Exit Function
    End If
    strArr = Split(RSplitFormat(strTmp), ";")
    For Inc = Int(Len(strTmp) / 2) To UBound(strArr)
        strOutput = strOutput & strArr(Inc)
    Next
    For Inc = 0 To Int(Len(strTmp) / 2) '
        strOutput = strOutput & strArr(Inc)
    Next
    strOutput = Left(strOutput, Len(strOutput) - (Len(strOutput) - Len(strTmp)))
    EncryptDecrypt1 = strOutput
Exit Function
Err_Exit:
    EncryptDecrypt1 = "-1"
    'ReportError Err.Description
End Function

' To encrypt/decrypt a text string or a series of bytes read from a file
Function EncryptDecrypt(inData As Variant, Optional inPW As Variant = "") As Variant
On Local Error Resume Next
Dim arrSBox(0 To 255) As Integer, arrPW(0 To 255) As Integer
Dim BI As Integer, Bj As Integer
Dim mKey As Integer, mCode As Byte, mCodeSeries As Variant
Dim i As Integer, j As Integer
Dim X As Integer, Y As Integer

    EncryptDecrypt = ""
    If Trim(inData) = "" Then
        Exit Function
    End If

    If inPW <> "" Then
        j = 1
        For i = 0 To 255
            arrPW(i) = Asc(Mid$(inPW, j, 1))
            j = j + 1
            If j > Len(inPW) Then
                j = 1
            End If
        Next i
    Else
        For i = 0 To 255
            arrPW(i) = 0
        Next i
    End If

    ' Reseed arrSBox()
    For i = 0 To 255
        arrSBox(i) = i
    Next i

    j = 0
    For i = 0 To 255
        j = (arrSBox(i) + arrPW(i)) Mod 256
        'Swap
        X = arrSBox(i)
        arrSBox(i) = arrSBox(j)
        arrSBox(j) = X
    Next i

    mCodeSeries = ""
    BI = 0: Bj = 0
    For i = 1 To Len(inData)
        BI = (BI + 1) Mod 256
        Bj = (Bj + arrSBox(BI)) Mod 256
        'Swap
        X = arrSBox(BI)
        arrSBox(BI) = arrSBox(Bj)
        arrSBox(Bj) = X
        'Generate a key
        mKey = arrSBox((arrSBox(BI) + arrSBox(Bj)) Mod 256)
        'xor the key
        mCode = Asc(Mid$(inData, i, 1)) Xor mKey
        mCodeSeries = mCodeSeries & Chr(mCode)
    Next i
    EncryptDecrypt = mCodeSeries
End Function

Public Function Bin2Dec(Num As String) As Long
Dim n As Integer, a As Integer, X As String
    n = Len(Num) - 1
    a = n
    Do While n > -1
        X = Mid(Num, ((a + 1) - n), 1)
        Bin2Dec = IIf((X = "1"), Bin2Dec + (2 ^ (n)), Bin2Dec)
        n = n - 1
    Loop
End Function

Public Function Dec2Bin(Num As String) As Long
Dim n As Integer
    n = Val(Num)
    While n > 1
        Dec2Bin = Dec2Bin & n Mod 2
        If n Mod 2 = 1 Then
             n = n - 1
        End If
        n = n / 2
    Wend
    Dec2Bin = Dec2Bin & n
End Function

Public Function RSplitFormat(Expression As String) As String
On Local Error Resume Next
Dim Inc As Byte, strTmp As String
    For Inc = 1 To Len(Expression)
        strTmp = strTmp & Mid(Expression, Inc, 1) & ";"
    Next
    strTmp = Left(strTmp, Len(strTmp) - 1)
    RSplitFormat = strTmp
End Function

Public Function Logout() As Boolean
    DisableAllMenu
    MDIFormMain.Caption = App.Title
    pLoginSucceeded = False
End Function

Public Sub DisableAllMenu(Optional IsDisableAll As Boolean = False)
On Local Error Resume Next
Dim Ctrl As Control, sSql As String, strMnuName As String
Dim lngIndexPos As Long, intIndex As Long, ctrlTmp As Control

End Sub

Public Sub EnableAllMenu()
On Local Error Resume Next
Dim Ctrl As Control

End Sub

Public Sub LogonMenu()
On Local Error Resume Next
Dim sSql As String, rsLogon As New clsRecordSet, Ctrl As Control, Inc As Long
Dim intIndex As Integer, strMnuName As String, lngIndexPos As Long, ctrlTmp As Control
End Sub

Public Sub DisableMenuBar()
On Local Error Resume Next
Dim Ctrl As Control, Ctrl1 As Control, Count As Long
End Sub

Public Function IsPermitted(lngID As Long, IDType As String) As Boolean
On Local Error GoTo Err_Exit
Dim strIds As String, lngGrpID As Long, arrIDs() As String, Inc As Long

    If pIsSuperUser Or Not pCllSystem("IsUserControl") Then
        IsPermitted = True
        Exit Function
    End If
    
    IsPermitted = False
    Select Case IDType
    Case "Voucher"
        lngGrpID = PickValue("VchrTypes", "VchrTypeGrpID", "VchrTypeID = " & lngID)
        strIds = GetPrivileges(IDType, lngGrpID)
        arrIDs = Split(strIds, ",")
        For Inc = 0 To UBound(arrIDs)
            If Val(arrIDs(Inc)) = lngID Then
                IsPermitted = True
                Exit For
            End If
        Next
    End Select
Exit Function
Err_Exit:
    IsPermitted = False
End Function

Public Function NumberEncryption(ByVal IsEncrypt As Boolean, ByVal strKey As String, ByVal strPassword As String) As String
On Local Error GoTo Err_Exit
Dim strTmp As String, Inc As Long, strNumKey As String
    If Len(strPassword) = 0 Then
        Exit Function
    End If
    strNumKey = Format("1" & StringToNum(strKey), "#")
    If IsEncrypt Then
        NumberEncryption = strNumKey & "1" & StringToNum(strPassword)
    Else
        strPassword = Right(strPassword, Abs(Len(strPassword) - Len(strNumKey))) 'Trim key
        strPassword = Right(strPassword, Len(strPassword) - 1) 'Trim Parity
        NumberEncryption = NumToString(strPassword)
    End If
Exit Function
Err_Exit:
    NumberEncryption = ""
End Function

Public Function StringToNum(ByVal strSource As String) As String
On Local Error Resume Next
Dim strTmp As String, Inc As Long
    For Inc = 1 To Len(strSource)
        strTmp = strTmp & Format(Asc(Mid(strSource, Inc, 1)), "000")
    Next Inc
    StringToNum = strTmp
End Function

Public Function NumToString(ByVal strSource As String) As String
On Local Error Resume Next
Dim strTmp As String, strTmp1 As String, Inc As Long
    Do While True
        If Len(Trim(strSource)) = 0 Then
            Exit Do
        Else
            strTmp1 = Left(strSource, 3)
            strSource = Right(strSource, Len(strSource) - 3)
        End If
        strTmp = strTmp & Chr(Val(strTmp1))
    Loop
    NumToString = strTmp
End Function

Public Function Login(UserName As String, Password As String) As Boolean
'On Local Error Resume Next
Dim rsUser As New ADODB.Recordset, sSql As String, strUserName As String, strPassword As String
    strUserName = Trim(UserName)
'    sSql = "Select * From Users Where StatusID = " & cnstStatusActive & " And UserName = '" & strUserName & "'"
    sSql = "Select * From Users Where StatusID = " & cnstStatusActive & " And UserName = '" & strUserName & "'"
    With rsUser
        .Open sSql, AdoConn, adOpenKeyset, adLockOptimistic
        If Not .BOF Then
            strPassword = IIf(IsNull(!Password), "", !Password)
            If Password = NumberEncryption(False, "eAudit", strPassword) Then
                frmLogin.Hide
                pUserName = StrConv(UserName, vbProperCase)
                pUserID = Val(!UserID & "")
                pUserCode = !UserCode & ""
                pLastLoginTime = ServerDateTime
                pIsSuperUser = False: pIsAdmin = False: pIsHAMT = False
                If UCase(pUserName) = "ADMIN" Then
                    pIsSuperUser = True
                    pIsAdmin = True
                ElseIf UCase(pUserName) = "HAMT" Then
                    pIsSuperUser = True
                    pIsHAMT = True
                End If
                If pServer <> pServerLocal Then
                    pstrDomain = "Remote Server"
                Else
                    pstrDomain = "Local Server"
                End If
                DisableAllMenu
                LogonMenu
                RefreshAll
                MDIFormMain.Caption = App.Title & " : User - " + pUserName & "  Logged into : " + pstrDomain
                pLoginSucceeded = True
                Login = True
            Else
                Login = False
            End If
        Else
            pMVE.MsgBox "Invalid user.", , "AuditMate", msgExclamation, True
            Login = False
        End If
        .Close
    End With
End Function

Private Function ContainNumber(InputVal As String) As Boolean
On Local Error Resume Next
Dim HasNumber As Boolean, lngInc As Long
        

End Function

Private Function ContainAlphabet(InputVal As String) As Boolean
On Local Error Resume Next
Dim strPwd As String, Num As Double, HasAlph As Boolean, IsNum As Boolean
    strPwd = InputVal
    HasAlph = False


End Function

Private Function VerifyPassword(Password As String) As String
On Local Error Resume Next



End Function
