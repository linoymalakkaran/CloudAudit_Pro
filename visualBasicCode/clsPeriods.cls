VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPeriod"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Dim mPeriodID As Long, mCompanyID As Long, mAuditType As Integer, mDescription As String, mAuditTypeName As String
Dim mShortName As String, mStartDt As Date, mEndDt As Date, mDerivedPeriodID As Long, mDerivedPeriodShortName As String
Dim mComparePeriodID As Long, mComparePeriodShortName As String, mStatusID As StatusConstants, mStatusName As String

Public Property Get PeriodID() As Long
    PeriodID = mPeriodID
End Property

Public Property Let PeriodID(ByVal vNewValue As Long)
    mPeriodID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Property Get AuditTypeName() As String
    AuditTypeName = mAuditTypeName
End Property

Public Property Get AuditType() As Integer
    AuditType = mAuditType
End Property

Public Property Let AuditType(ByVal vNewValue As Integer)
    mAuditType = vNewValue
End Property

Public Property Get Description() As String
    Description = mDescription
End Property

Public Property Let Description(ByVal vNewValue As String)
    mDescription = vNewValue
End Property

Public Property Get ShortName() As String
    ShortName = mShortName
End Property

Public Property Let ShortName(ByVal vNewValue As String)
    mShortName = vNewValue
End Property

Public Property Get StartDt() As Date
    StartDt = mStartDt
End Property

Public Property Let StartDt(ByVal vNewValue As Date)
    mStartDt = vNewValue
End Property

Public Property Get EndDt() As Date
    EndDt = mEndDt
End Property

Public Property Let EndDt(ByVal vNewValue As Date)
    mEndDt = vNewValue
End Property

Public Property Get DerivedPeriodShortName() As String
    DerivedPeriodShortName = mDerivedPeriodShortName
End Property

Public Property Get DerivedPeriodID() As Long
    DerivedPeriodID = mDerivedPeriodID
End Property

Public Property Let DerivedPeriodID(ByVal vNewValue As Long)
    mDerivedPeriodID = vNewValue
End Property

Public Property Get ComparePeriodShortName() As String
    ComparePeriodShortName = mComparePeriodShortName
End Property

Public Property Get ComparePeriodID() As Long
    ComparePeriodID = mComparePeriodID
End Property

Public Property Let ComparePeriodID(ByVal vNewValue As Long)
    mComparePeriodID = vNewValue
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

Public Function Delete(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
    If Not pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Delete from SubSectionDataExtension where PeriodID = " & lngID
    AdoConn.Execute sSql
    sSql = "Delete from SubSectionData where PeriodID = " & lngID
    AdoConn.Execute sSql
    sSql = "Delete from Periods where PeriodID = " & lngID
    AdoConn.Execute sSql
    AdoConn.CommitTrans
    Delete = True
Exit Function
Err_Exit:
    If IsInTran Then
        AdoConn.RollbackTrans
    End If
    ShowError
    Delete = False
End Function

Public Function Validate() As Boolean
On Local Error GoTo Err_Exit
    If Trim(mShortName) = "" Then
        pMVE.MsgBox "Period Short Name  Not Specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Val(mAuditType) = 0 Then
        pMVE.MsgBox "Audit type not mentioned.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Not (Format(mStartDt, "#") > 0 And Format(mEndDt, "#") > 0 And Format(mStartDt, "#") <= Format(mEndDt, "#")) Then
        pMVE.MsgBox "Invalid Period.", msgOK, "AuditMate", msgCritical
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
Dim IsInTran As Boolean, sSql As String, rsSave As New Recordset, blnIsNew As Boolean
    If Not Validate Then
        Save = False
        Exit Function
    End If
    '-----------------------------------------------------------
    sSql = "Select * From Periods Where PeriodID = " & lngID
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If lngID = 0 Then
            .AddNew
            mPeriodID = GetMaxNo("Periods", "PeriodID")
            blnIsNew = True
            lngID = mPeriodID
            .Fields("PeriodID") = mPeriodID
        End If
        .Fields("CompanyID") = mCompanyID
        .Fields("AuditTypeID") = mAuditType
        .Fields("Description") = mDescription
        .Fields("ShortName") = mShortName
        .Fields("StartDt") = Format(DateValue(mStartDt), "#")
        .Fields("EndDt") = Format(DateValue(mEndDt), "#")
        .Fields("DerivedPeriodID") = mDerivedPeriodID
        .Fields("ComparePeriodID") = mComparePeriodID
        .Fields("StatusID") = mStatusID
        SaveDateAndUser rsSave, blnIsNew
        .Update
        .Close
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
    sSql = "SELECT PER.*, PER1.ShortName AS DerivedPeriodShortName, PER2.ShortName AS ComparePeriodShortName, Status.StatusName AS StatusName, ADT.AuditTypeName AS AuditTypeName " & _
           "FROM AuditType ADT INNER JOIN Periods PER INNER JOIN Status ON PER.StatusID = Status.StatusID ON ADT.AuditTypeID = PER.AuditTypeID LEFT OUTER JOIN " & _
           "Periods PER1 ON PER.DerivedPeriodID = PER1.PeriodID LEFT OUTER JOIN Periods PER2 ON PER.ComparePeriodID = PER2.PeriodID Where PER.PeriodID = " & lngID
    With GetRecords(sSql)
        If .EOF Then
            pMVE.MsgBox "Not a valid record!", msgOK, "AuditMate", msgExclamation, True
        Else
            mPeriodID = Val(.Fields("PeriodID") & "")
            mCompanyID = Val(.Fields("CompanyID") & "")
            mAuditType = Val(.Fields("AuditTypeID") & "")
            mAuditTypeName = .Fields("AuditTypeName") & ""
            mDescription = .Fields("Description") & ""
            mShortName = .Fields("ShortName") & ""
            mStartDt = Val(.Fields("StartDt") & "")
            mEndDt = Val(.Fields("EndDt") & "")
            mDerivedPeriodID = .Fields("DerivedPeriodID")
            mDerivedPeriodShortName = .Fields("DerivedPeriodShortName") & ""
            mComparePeriodID = .Fields("ComparePeriodID")
            mComparePeriodShortName = .Fields("ComparePeriodShortName") & ""
            mStatusID = Val(.Fields("StatusID") & "")
            mStatusName = .Fields("StatusName") & ""
        End If
        .Close
    End With
    Collect = True
Exit Function
Err_Exit:
    ShowError
    Collect = False
End Function

Public Sub Clear()
On Local Error Resume Next
    mPeriodID = 0
    mCompanyID = 0
    mAuditType = 0
    mDescription = ""
    mShortName = ""
    mStartDt = 0
    mEndDt = 0
    mDerivedPeriodID = 0
    mDerivedPeriodShortName = ""
    mComparePeriodID = 0
    mComparePeriodShortName = ""
    mStatusID = 0
    mStatusName = ""
End Sub
