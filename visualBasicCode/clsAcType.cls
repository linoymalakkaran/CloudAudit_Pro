VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAcType"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Dim mAcTypeID As Long, mCompanyID As Long, mAcTypeName As String, mAcTypeCode As String, mParentAcTypeID As Long
Dim mRefNo As String, mAccDepAcTypeID As Long, mAccCostAcTypeID As Long, mDeductionAcTypeID As Long
Dim mAllocationAcTypeID As Long, mTreeLevel As Long, mTrialOrder As Long, mTypeNature As String, mStatusID As Long
Dim mIsReserved As Boolean
Dim mAccDepAcTypeName As String, mAccCostAcTypeName As String, mDeductionAcTypeName As String, mAllocationAcTypeName As String
Dim mParentAcTypeName As String, mStatusName As String, mIsHidden As Boolean
Dim mAcTypeDescription As String

Public Property Get AccDepAcTypeName() As String
    AccDepAcTypeName = mAccDepAcTypeName
End Property

Public Property Let AccDepAcTypeName(ByVal vNewValue As String)
    mAccDepAcTypeName = vNewValue
End Property

Public Property Get AccCostAcTypeName() As String
    AccCostAcTypeName = mAccCostAcTypeName
End Property

Public Property Let AccCostAcTypeName(ByVal vNewValue As String)
    mAccCostAcTypeName = vNewValue
End Property

Public Property Get DeductionAcTypeName() As String
    DeductionAcTypeName = mDeductionAcTypeName
End Property

Public Property Let DeductionAcTypeName(ByVal vNewValue As String)
    mDeductionAcTypeName = vNewValue
End Property

Public Property Get AllocationAcTypeName() As String
    AllocationAcTypeName = mAllocationAcTypeName
End Property

Public Property Let AllocationAcTypeName(ByVal vNewValue As String)
    mAllocationAcTypeName = vNewValue
End Property

Public Property Get ParentAcTypeName() As String
    ParentAcTypeName = mParentAcTypeName
End Property

Public Property Let ParentAcTypeName(ByVal vNewValue As String)
    mParentAcTypeName = vNewValue
End Property

Public Property Get StatusName() As String
    StatusName = mStatusName
End Property

Public Property Let StatusName(ByVal vNewValue As String)
    mStatusName = vNewValue
End Property

Public Property Get IsReserved() As Boolean
    IsReserved = mIsReserved
End Property

Public Property Let IsReserved(ByVal vNewValue As Boolean)
    mIsReserved = vNewValue
End Property

Public Property Get AcTypeID() As Long
    AcTypeID = mAcTypeID
End Property

Public Property Let AcTypeID(ByVal vNewValue As Long)
    mAcTypeID = vNewValue
End Property

Public Property Get CompanyID() As Long
    CompanyID = mCompanyID
End Property

Public Property Let CompanyID(ByVal vNewValue As Long)
    mCompanyID = vNewValue
End Property

Public Property Get AcTypeName() As String
    AcTypeName = mAcTypeName
End Property

Public Property Let AcTypeName(ByVal vNewValue As String)
    mAcTypeName = vNewValue
End Property

Public Property Get AcTypeCode() As String
    AcTypeCode = mAcTypeCode
End Property

Public Property Let AcTypeCode(ByVal vNewValue As String)
    mAcTypeCode = vNewValue
End Property

Public Property Get ParentAcTypeID() As Long
    ParentAcTypeID = mParentAcTypeID
End Property

Public Property Let ParentAcTypeID(ByVal vNewValue As Long)
    mParentAcTypeID = vNewValue
End Property

Public Property Get RefNo() As String
    RefNo = mRefNo
End Property

Public Property Let RefNo(ByVal vNewValue As String)
    mRefNo = vNewValue
End Property

Public Property Get AccDepAcTypeID() As Long
    AccDepAcTypeID = mAccDepAcTypeID
End Property

Public Property Let AccDepAcTypeID(ByVal vNewValue As Long)
    mAccDepAcTypeID = vNewValue
End Property

Public Property Get AccCostAcTypeID() As Long
    AccCostAcTypeID = mAccCostAcTypeID
End Property

Public Property Let AccCostAcTypeID(ByVal vNewValue As Long)
    mAccCostAcTypeID = vNewValue
End Property

Public Property Get DeductionAcTypeID() As Long
    DeductionAcTypeID = mDeductionAcTypeID
End Property

Public Property Let DeductionAcTypeID(ByVal vNewValue As Long)
    mDeductionAcTypeID = vNewValue
End Property

Public Property Get AllocationAcTypeID() As Long
    AllocationAcTypeID = mAllocationAcTypeID
End Property

Public Property Let AllocationAcTypeID(ByVal vNewValue As Long)
    mAllocationAcTypeID = vNewValue
End Property

Public Property Get TreeLevel() As Long
    TreeLevel = mTreeLevel
End Property

Public Property Let TreeLevel(ByVal vNewValue As Long)
    mTreeLevel = vNewValue
End Property

Public Property Get TrialOrder() As Long
    TrialOrder = mTrialOrder
End Property

Public Property Let TrialOrder(ByVal vNewValue As Long)
    mTrialOrder = vNewValue
End Property

Public Property Get TypeNature() As String
    TypeNature = mTypeNature
End Property

Public Property Let TypeNature(ByVal vNewValue As String)
    mTypeNature = vNewValue
End Property

Public Property Get StatusID() As Long
    StatusID = mStatusID
End Property

Public Property Let StatusID(ByVal vNewValue As Long)
    mStatusID = vNewValue
End Property

Public Property Get IsHidden() As Boolean
    IsHidden = mIsHidden
End Property

Public Property Let IsHidden(ByVal vNewValue As Boolean)
    mIsHidden = vNewValue
End Property

Public Property Get AcTypeDescription() As String
    AcTypeDescription = mAcTypeDescription
End Property

Public Property Let AcTypeDescription(ByVal vNewValue As String)
    mAcTypeDescription = vNewValue
End Property

Public Function Save(lngID As Long) As Boolean
On Local Error GoTo Err_Exit
Dim IsInTran As Boolean, sSql As String, rsSave As New Recordset
Dim blnIsNew As Boolean
    If Not Validate Then
        Save = False
        Exit Function
    End If
    '-----------------------------------------------------------
    sSql = "Select * From AcTypes Where AcTypeID = " & lngID
    AdoConn.BeginTrans
    IsInTran = True
    Set rsSave = GetRecords(sSql)
    With rsSave
        If lngID = 0 Then
            .AddNew
            mAcTypeID = GetRangeMaxNo("AcTypes", "AcTypeID", mCompanyID * cnstAcTypeMaxCount, (mCompanyID * cnstAcTypeMaxCount) + cnstAcTypeMaxCount)
            lngID = mAcTypeID
            blnIsNew = True
            .Fields("CompanyID") = mCompanyID
            .Fields("AcTypeID") = mAcTypeID
        End If
        .Fields("AcTypeName") = mAcTypeName
        .Fields("AcTypeCode") = mAcTypeCode
        .Fields("ParentAcTypeID") = IIf(mParentAcTypeID = 0, Null, mParentAcTypeID)
        .Fields("RefNo") = mRefNo
        .Fields("AccDepAcTypeID") = IIf(mAccDepAcTypeID = 0, Null, mAccDepAcTypeID)
        .Fields("AccCostAcTypeID") = IIf(mAccCostAcTypeID = 0, Null, mAccCostAcTypeID)
        .Fields("DeductionAcTypeID") = IIf(mDeductionAcTypeID = 0, Null, mDeductionAcTypeID)
        .Fields("AllocationAcTypeID") = IIf(mAllocationAcTypeID = 0, Null, mAllocationAcTypeID)
        .Fields("TreeLevel") = mTreeLevel
        .Fields("TrialOrder") = mTrialOrder
        .Fields("TypeNature") = mTypeNature
        .Fields("IsReserved") = mIsReserved
        .Fields("StatusID") = mStatusID
        .Fields("IsHidden") = mIsHidden
        .Fields("AcTypeDescription") = mAcTypeDescription
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
    sSql = "SELECT AT.*, AT1.AcTypeName AS ParentAcTypeName, AT2.AcTypeName AS AccDepAcTypeName, AT3.AcTypeName AS AccCostAcTypeName, AT4.AcTypeName AS DeductionAcTypeName, AT5.AcTypeName AS AllocationAcTypeName, " & _
           "Status.StatusName FROM AcTypes AT4 RIGHT OUTER JOIN AcTypes AT3 RIGHT OUTER JOIN AcTypes AT INNER JOIN " & _
           "Status ON AT.StatusID = Status.StatusID LEFT OUTER JOIN AcTypes AT2 ON AT.AccDepAcTypeID = AT2.AcTypeID LEFT OUTER JOIN " & _
           "AcTypes AT1 ON AT.ParentAcTypeID = AT1.AcTypeID ON AT3.AcTypeID = AT.AccCostAcTypeID ON AT4.AcTypeID = AT.DeductionAcTypeID LEFT OUTER JOIN " & _
           "AcTypes AT5 ON AT.AllocationAcTypeID = AT5.AcTypeID Where (AT.AcTypeID = " & lngID & ")"
    With GetRecords(sSql)
        If .EOF Then
            pMVE.MsgBox "Not a valid record!", msgOK, "AuditMate", msgExclamation, True
        Else
            mCompanyID = Val(.Fields("CompanyID") & "")
            mAcTypeID = Val(.Fields("AcTypeID") & "")
            mAcTypeName = .Fields("AcTypeName") & ""
            mAcTypeCode = .Fields("AcTypeCode") & ""
            mParentAcTypeID = Val(.Fields("ParentAcTypeID") & "")
            mRefNo = .Fields("RefNo") & ""
            mAccDepAcTypeID = Val(.Fields("AccDepAcTypeID") & "")
            mAccCostAcTypeID = Val(.Fields("AccCostAcTypeID") & "")
            mDeductionAcTypeID = Val(.Fields("DeductionAcTypeID") & "")
            mAllocationAcTypeID = Val(.Fields("AllocationAcTypeID") & "")
            mAccCostAcTypeID = Val(.Fields("AccCostAcTypeID") & "")
            mTreeLevel = Val(.Fields("TreeLevel"))
            mTrialOrder = Val(.Fields("TrialOrder"))
            mTypeNature = .Fields("TypeNature") & ""
            mIsReserved = IIf(.Fields("IsReserved") & "" = "True", True, False)
            mStatusID = Val(.Fields("StatusID") & "")
            
            mParentAcTypeName = .Fields("ParentAcTypeName") & ""
            mAccDepAcTypeName = .Fields("AccDepAcTypeName") & ""
            mAccCostAcTypeName = .Fields("AccCostAcTypeName") & ""
            mDeductionAcTypeName = .Fields("DeductionAcTypeName") & ""
            mAllocationAcTypeName = .Fields("AllocationAcTypeName") & ""
            mStatusName = .Fields("StatusName") & ""
            mIsHidden = IIf(.Fields("IsHidden") & "" = "True", True, False)
            mAcTypeDescription = .Fields("AcTypeDescription") & ""
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
    If Not pMVE.MsgBox("Are you sure to delete?", msgYesNo, "AuditMate", msgQuestion, True) Then
        Delete = False
        Exit Function
    End If
    sSql = "Select IsReserved From AcTypes Where AcTypeID = " & lngID
    With GetRecords(sSql)
        If .Fields("IsReserved") = True Then
            pMVE.MsgBox "Cannot delete reserved group items.", msgOK, "AuditMate", msgInformation, True
            Delete = False
            Exit Function
        End If
    End With
    '-----------------------------------------------------------
    AdoConn.BeginTrans
    IsInTran = True
    sSql = "Delete From AcTypes Where AcTypeID = " & lngID
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

Public Sub Clear()
On Local Error Resume Next
    mAcTypeID = 0
    mCompanyID = ""
    mAcTypeName = ""
    mAcTypeCode = ""
    mParentAcTypeID = ""
    mRefNo = ""
    mAccDepAcTypeID = ""
    mAccCostAcTypeID = ""
    mDeductionAcTypeID = ""
    mAllocationAcTypeID = ""
    mTreeLevel = ""
    mTrialOrder = ""
    mTypeNature = ""
    mStatusID = ""
End Sub

Public Function Validate() As Boolean
On Local Error GoTo Err_Exit
    If Trim(mAcTypeName) = "" Then
        pMVE.MsgBox "Name Not Specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Val(mParentAcTypeID) = 0 And mTreeLevel > 1 Then
        pMVE.MsgBox "Parent Type Not Specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Trim(mTypeNature) = "" Then
        pMVE.MsgBox "Nature Not Specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    If Val(mStatusID) = 0 Then
        pMVE.MsgBox "Status Not Specified.", msgOK, "AuditMate", msgCritical
        Validate = False
        Exit Function
    End If
    Validate = True
Exit Function
Err_Exit:
    Validate = False
End Function
