VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAcHead"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Dim mAcID As Long, mCompanyID As Long, mAcTypeID As Long, mAcHeadCode As String, mAcHeadName As String
Dim mAcTypeName As String, mStatusName As String
Dim mTrialOrder As Long, mStatusID As Long

Public Property Get AcTypeName() As String
    AcTypeName = mAcTypeName
End Property

Public Property Get StatusName() As String
    StatusName = mStatusName
End Property

Public Property Get AcID() As Long
    AcID = mAcID
End Property

Public Property Let AcID(ByVal vNewValue As Long)
    mAcID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Property Get AcHeadName() As String
    AcHeadName = mAcHeadName
End Property

Public Property Let AcHeadName(ByVal vNewValue As String)
    mAcHeadName = vNewValue
End Property

Public Property Get AcHeadCode() As String
    AcHeadCode = mAcHeadCode
End Property

Public Property Let AcHeadCode(ByVal vNewValue As String)
    mAcHeadCode = vNewValue
End Property

Public Property Get AcTypeID() As Long
    AcTypeID = mAcTypeID
End Property

Public Property Let AcTypeID(ByVal vNewValue As Long)
    mAcTypeID = vNewValue
End Property

Public Property Get TrialOrder() As Long
    TrialOrder = mTrialOrder
End Property

Public Property Let TrialOrder(ByVal vNewValue As Long)
    mTrialOrder = vNewValue
End Property

Public Property Get StatusID() As Long
    StatusID = mStatusID
End Property

Public Property Let StatusID(ByVal vNewValue As Long)
    mStatusID = vNewValue
End Property

Public Function Validate() As Boolean
On Local Error GoTo Err_Exit
    If Trim(mAcHeadName) = "" Then
        pMVE.MsgBox "Account name not specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Val(mAcTypeID) = 0 Then
        pMVE.MsgBox "Account type not specified.", msgOK, "AuditMate", msgCritical
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
Dim IsInTran As Boolean, sSql As String, rsSave As New ADODB.Recordset
Dim blnIsNew As Boolean
Dim strCompanyCode As String
    If Not Validate Then
        Save = False
        Exit Function
    End If
    '-----------------------------------------------------------
    strCompanyCode = PickValue("Companies", "CompanyCode", "CompanyID = " & mCompanyID)
    sSql = "Select * From AcHeads Where AcID = " & lngID
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If lngID = 0 Then
            .AddNew
            'Ref No: 06 - August - 2009 ------------------
'            mAcID = GetRangeMaxNo("AcHeads", "AcID", mCompanyID * cnstAcHeadMaxCount, (mCompanyID * cnstAcHeadMaxCount) + cnstAcHeadMaxCount)
            mAcID = GetRangeMaxNo("AcHeads", "AcID", strCompanyCode * cnstAcHeadMaxCount, (strCompanyCode * cnstAcHeadMaxCount) + cnstAcHeadMaxCount)
            lngID = mAcID
            blnIsNew = True
            .Fields("AcID") = mAcID
        End If
        .Fields("CompanyID") = mCompanyID
        .Fields("AcTypeID") = mAcTypeID
        .Fields("AcCode") = mAcHeadCode
        .Fields("AcName") = mAcHeadName
        .Fields("TrialOrder") = mTrialOrder
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
    sSql = "SELECT AT.AcTypeName, Status.StatusName , AH.* " & _
           "FROM AcHeads AH INNER JOIN AcTypes AT ON AH.AcTypeID = AT.AcTypeID INNER JOIN Status ON AH.StatusID = Status.StatusID Where AH.AcID = " & lngID
    With GetRecords(sSql)
        If .EOF Then
            pMVE.MsgBox "Not a valid record!", msgOK, "AuditMate", msgExclamation, True
        Else
            mCompanyID = Val(.Fields("CompanyID") & "")
            mAcTypeID = Val(.Fields("AcTypeID") & "")
            mAcTypeName = .Fields("AcTypeName") & ""
            mAcHeadCode = .Fields("AcCode") & ""
            mAcHeadName = .Fields("AcName") & ""
            mTrialOrder = .Fields("TrialOrder") & ""
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

Public Function Delete(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String
Dim sSql1 As String
    If Not pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    sSql1 = "Select * From EntrySubAccounts Where AcID = " & lngID
    With GetRecords(sSql1)
        If Not .EOF Then
            pMVE.MsgBox "Cannot delete Account Head. Data exists.", msgOK, , msgInformation, True
        Else
            IsInTran = True
            sSql = "Delete From AcHeads Where AcID = " & lngID
            AdoConn.Execute sSql
        End If
    End With
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

Public Sub Clear()
On Local Error Resume Next
    mAcID = 0
    mCompanyID = ""
    mAcTypeID = ""
    mAcTypeName = ""
    mStatusName = ""
    mAcHeadCode = ""
    mAcHeadName = ""
    mTrialOrder = ""
    mStatusID = ""
End Sub
