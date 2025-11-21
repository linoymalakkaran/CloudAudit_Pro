VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCompany"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Dim mCompanyID As Long, mCompanyName As String, mCompanyCode As String, mCompanyShortName As String
Dim mJobCode As String, mStatusID As Long, mCompanyAdd1 As String, mCompanyAdd2 As String
Dim mCompanyAdd3 As String, mCompanyPhone As String, mCompanyFax As String, mCompanyEmail As String
Dim mCompanyUrl As String, mContactPerson As String, mContPerDesignation As String
Dim mContPerPhone As String, mContPerEmail As String, mStatusName As String
Dim mlngCurrencyID As Long, mstrCurrencyName As String, mstrCurrencyShortName As String
Dim mstrDetachedBy As String, mstrDetachedDate As String

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Property Get CompanyName() As String
    CompanyName = mCompanyName
End Property

Public Property Let CompanyName(ByVal vNewValue As String)
    mCompanyName = vNewValue
End Property

Public Property Get CompanyCode() As String
    CompanyCode = mCompanyCode
End Property

Public Property Let CompanyCode(ByVal vNewValue As String)
    mCompanyCode = vNewValue
End Property

Public Property Get CompanyShortName() As String
    CompanyShortName = mCompanyShortName
End Property

Public Property Let CompanyShortName(ByVal vNewValue As String)
    mCompanyShortName = vNewValue
End Property

Public Property Get JobCode() As String
    JobCode = mJobCode
End Property

Public Property Let JobCode(ByVal vNewValue As String)
    mJobCode = vNewValue
End Property

Public Property Get StatusName() As String
    StatusName = mStatusName
End Property

Public Property Get StatusID() As StatusConstants
    StatusID = mStatusID
End Property

Public Property Let StatusID(ByVal vNewValue As StatusConstants)
    mStatusID = vNewValue
End Property

Public Property Get CompanyAdd1() As String
    CompanyAdd1 = mCompanyAdd1
End Property

Public Property Let CompanyAdd1(ByVal vNewValue As String)
    mCompanyAdd1 = vNewValue
End Property

Public Property Get CompanyAdd2() As String
    CompanyAdd2 = mCompanyAdd2
End Property

Public Property Let CompanyAdd2(ByVal vNewValue As String)
    mCompanyAdd2 = vNewValue
End Property

Public Property Get CompanyAdd3() As String
    CompanyAdd3 = mCompanyAdd3
End Property

Public Property Let CompanyAdd3(ByVal vNewValue As String)
    mCompanyAdd3 = vNewValue
End Property

Public Property Get CompanyPhone() As String
    CompanyPhone = mCompanyPhone
End Property

Public Property Let CompanyPhone(ByVal vNewValue As String)
    mCompanyPhone = vNewValue
End Property

Public Property Get CompanyFax() As String
    CompanyFax = mCompanyFax
End Property

Public Property Let CompanyFax(ByVal vNewValue As String)
    mCompanyFax = vNewValue
End Property

Public Property Get CompanyEmail() As String
    CompanyEmail = mCompanyEmail
End Property

Public Property Let CompanyEmail(ByVal vNewValue As String)
    mCompanyEmail = vNewValue
End Property

Public Property Get CompanyUrl() As String
    CompanyUrl = mCompanyUrl
End Property

Public Property Let CompanyUrl(ByVal vNewValue As String)
    mCompanyUrl = vNewValue
End Property

Public Property Get ContactPerson() As String
    ContactPerson = mContactPerson
End Property

Public Property Let ContactPerson(ByVal vNewValue As String)
    mContactPerson = vNewValue
End Property

Public Property Get ContPerDesignation() As String
    ContPerDesignation = mContPerDesignation
End Property

Public Property Let ContPerDesignation(ByVal vNewValue As String)
    mContPerDesignation = vNewValue
End Property

Public Property Get ContPerPhone() As String
    ContPerPhone = mContPerPhone
End Property

Public Property Let ContPerPhone(ByVal vNewValue As String)
    mContPerPhone = vNewValue
End Property

Public Property Get ContPerEmail() As String
    ContPerEmail = mContPerEmail
End Property

Public Property Let ContPerEmail(ByVal vNewValue As String)
    mContPerEmail = vNewValue
End Property

Public Property Get CurrencyID() As Long
    CurrencyID = mlngCurrencyID
End Property

Public Property Let CurrencyID(ByVal lngNewValue As Long)
    mlngCurrencyID = lngNewValue
End Property

Public Property Get CurrencyName() As String
    CurrencyName = mstrCurrencyName
End Property

Public Property Let CurrencyName(ByVal strNewValue As String)
    mstrCurrencyName = strNewValue
End Property

Public Property Get CurrencyShortName() As String
    CurrencyShortName = mstrCurrencyShortName
End Property

Public Property Let CurrencyShortName(ByVal strNewValue As String)
    mstrCurrencyShortName = strNewValue
End Property

Public Function Validate() As Boolean
On Local Error GoTo Err_Exit
    If Trim(mCompanyName) = "" Then
        pMVE.MsgBox "Company name not specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Trim(mJobCode) = "" Then
        pMVE.MsgBox "Job code not specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    Validate = True
Exit Function
Err_Exit:
    Validate = False
End Function

Public Function Save(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String, rsSave As New Recordset
Dim IsNew As Boolean
    If Not Validate Then
        Save = False
        Exit Function
    End If
    '-----------------------------------------------------------
    sSql = "Select * From Companies Where CompanyID = " & lngID
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If .EOF Then
            .AddNew
            mCompanyID = GetMaxNo("Companies", "CompanyID")
            lngID = mCompanyID
            .Fields("CompanyID") = mCompanyID
            IsNew = True
        End If
        .Fields("CompanyName") = mCompanyName
        .Fields("CompanyCode") = mCompanyCode
        .Fields("CompanyShortName") = mCompanyShortName
        .Fields("JobCode") = mJobCode
        .Fields("StatusID") = mStatusID
        .Fields("CompanyAdd1") = mCompanyAdd1
        .Fields("CompanyAdd2") = mCompanyAdd2
        .Fields("CompanyAdd3") = mCompanyAdd3
        .Fields("CompanyPhone") = mCompanyPhone
        .Fields("CompanyFax") = mCompanyFax
        .Fields("CompanyEmail") = mCompanyEmail
        .Fields("CompanyUrl") = mCompanyUrl
        .Fields("ContactPerson") = mContactPerson
        .Fields("ContPerDesignation") = mContPerDesignation
        .Fields("ContPerPhone") = mContPerPhone
        .Fields("ContPerEmail") = mContPerEmail
        .Fields("CurrencyID") = mlngCurrencyID
        SaveDateAndUser rsSave, IsNew
        .Update
        .Close
        ReOrganizeCompanyDefaultData mCompanyID
    End With
    AdoConn.CommitTrans
    Save = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Save = False
End Function

Public Function Collect(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String
    Clear
    sSql = "Select CMP.*, ST.StatusName, CM.CurrencyName, CM.CurrencyShortName From Companies CMP, Status ST, CurrencyMaster CM Where ST.StatusID = CMP.StatusID AND CM.CurrencyID = CMP.CurrencyID AND CMP.CompanyID = " & lngID
    With GetRecords(sSql)
        If .EOF Then
            pMVE.MsgBox "Not a valid record!", msgOK, "AuditMate", msgExclamation, True
        Else
            mCompanyID = .Fields("CompanyID")
            mCompanyName = .Fields("CompanyName") & ""
            mCompanyCode = .Fields("CompanyCode") & ""
            mCompanyShortName = .Fields("CompanyShortName") & ""
            mJobCode = .Fields("JobCode") & ""
            mStatusID = .Fields("StatusID") & ""
            mStatusName = .Fields("StatusName") & ""
            mCompanyAdd1 = .Fields("CompanyAdd1") & ""
            mCompanyAdd2 = .Fields("CompanyAdd2") & ""
            mCompanyAdd3 = .Fields("CompanyAdd3") & ""
            mCompanyPhone = .Fields("CompanyPhone") & ""
            mCompanyFax = .Fields("CompanyFax") & ""
            mCompanyEmail = .Fields("CompanyEmail") & ""
            mCompanyUrl = .Fields("CompanyUrl") & ""
            mContactPerson = .Fields("ContactPerson") & ""
            mContPerDesignation = .Fields("ContPerDesignation") & ""
            mContPerPhone = .Fields("ContPerPhone") & ""
            mContPerEmail = .Fields("ContPerEmail") & ""
            mlngCurrencyID = .Fields("CurrencyID") & ""
            mstrCurrencyName = .Fields("CurrencyName") & ""
            mstrCurrencyShortName = .Fields("CurrencyShortName") & ""
            mstrDetachedBy = .Fields("DetachedBy") & ""
            mstrDetachedDate = .Fields("DetachedDate") & ""
        End If
        .Close
    End With
    Collect = True
Exit Function
Err_Exit:
    ShowError
    Collect = False
End Function

Public Function Delete(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim sSql As String, IsInTran As Boolean
    AdoConn.BeginTrans
    sSql = "Delete from Companies Where CompanyID = " & lngID
    AdoConn.CommitTrans
    Clear
    Delete = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Delete = False
End Function

Public Sub Clear()
On Local Error Resume Next
    mCompanyID = 0
    mCompanyName = ""
    mCompanyCode = ""
    mCompanyShortName = ""
    mJobCode = ""
    mStatusID = ""
    mCompanyAdd1 = ""
    mCompanyAdd2 = ""
    mCompanyAdd3 = ""
    mCompanyPhone = ""
    mCompanyFax = ""
    mCompanyEmail = ""
    mCompanyUrl = ""
    mContactPerson = ""
    mContPerDesignation = ""
    mContPerPhone = ""
    mContPerEmail = ""
End Sub
