VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsUpgradeDatabase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public Sub Version_1_0()
On Local Error Resume Next
Dim lngID As Long, sSql As String, fldTmp As ADODB.Field
    Screen.MousePointer = vbHourglass
    'Code for Version Updation
1   ExeStatement = "1001#ALTER TABLE [dbo].[HELP] ALTER COLUMN Description varchar(5000) NOT NULL"
    ExeStatement = "1002#CREATE TABLE [dbo].[ObjectTypes] ([ObjectTypeID] [tinyint] NOT NULL, [ObjectTypeName] [varchar] (50) NOT NULL," & _
                   "CONSTRAINT [PK_ObjectTypes] PRIMARY KEY CLUSTERED([ObjectTypeID])) ON [PRIMARY]"
    ExeStatement = "1003#CREATE TABLE [dbo].[Reports] ([ReportID] [int] NOT NULL, [PeriodID] [smallint] NULL, [PaperSize] [int] NOT NULL," & _
                   "[ReportName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ," & _
                   "[LeftMargin] [int] NOT NULL, [TopMargin] [int] NOT NULL ,[RightMargin] [int] NOT NULL ,[BottomMargin] [int] NULL" & _
                   "CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED ([ReportID])) ON [PRIMARY]"
    ExeStatement = "1004#CREATE TABLE [dbo].[ReportsObjects] ([ReportID] [int] NOT NULL, [ObjSlNo] [int] NOT NULL, [ObjectTypeID] [tinyint] NOT NULL," & _
                   "[ObjectName] [varchar] (50) NOT NULL, [TextRtf] [varchar] (8000) NOT NULL, [Orientation] [bit] NOT NULL, [Picture] [image] NULL," & _
                   "[ObjLeft] [int] NOT NULL, [ObjTop] [int] NOT NULL, [ObjWidth] [int] NOT NULL, [ObjHeight] [int] NOT NULL,[SpaceBefore] [int] NULL , [PageBreak] [bit] NULL ,[BorderTypeID] [int] NOT NULL," & _
                   "[NoOfRows] [int] NOT NULL, [NoOfCols] [int] NOT NULL,[TableType] [tinyint] NOT NULL  CONSTRAINT [PK_ReportsObjects] PRIMARY KEY CLUSTERED ([ReportID], [ObjSlNo]), " & _
                   "CONSTRAINT [FK_ReportsSubObjects_ObjectTypes] FOREIGN KEY ([ObjectTypeID]) REFERENCES [dbo].[ObjectTypes] ([ObjectTypeID]), CONSTRAINT " & _
                   "[FK_ReportsSubObjects_Reports] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Reports] ([ReportID])) ON [PRIMARY]"
    ExeStatement = "1005#CREATE TABLE [dbo].[ReportsObjectsSub] ([ReportID] [int] NOT NULL, [SubSlNo] [int] NOT NULL, [ObjSlNo] [int] NOT NULL, " & _
                   "[TextRtf] [varchar] (8000) NOT NULL, [Row] [int] NOT NULL, [Col] [int] NOT NULL, [BackColor] [int] NOT NULL, [ForeColor] [int] NOT NULL," & _
                   "[ColWidth] [int] NULL ,[Underline] [tinyint] NULL ,[IsBold] [bit] NULL ,[FontSize] [tinyint] NULL, [IsItalic] [bit] NULL, [Alignment] [tinyint] NULL, " & _
                   "[FontName] [varchar] (30) NOT NULL, [RowHeight] [int] NOT NULL, " & _
                   "CONSTRAINT [PK_ReportsObjectsSub] PRIMARY KEY CLUSTERED ([ReportID], [SubSlNo]), CONSTRAINT [FK_ReportsObjectsSub_ReportsObjects] FOREIGN KEY ([ReportID]," & _
                   "[ObjSlNo]) REFERENCES [dbo].[ReportsObjects] ([ReportID], [ObjSlNo])) ON [PRIMARY]"
    ExeStatement = "1006#CREATE TABLE [dbo].[TOC] ([TOCID] [int]  NOT NULL ,[SlNo] [tinyint] NOT NULL ,[Content] [varchar] (50)  NOT NULL) ON [PRIMARY]"

    ExeStatement = "1007#CREATE TABLE [dbo].[DocumentBin] ([DocumentID] [int] NOT NULL ,[DocumentCode] [varchar] (20)  NULL ," & _
                   "[CompanyID] [smallint] NOT NULL ,[DocFile] [image] NULL ,[FileName] [varchar] (250)  NOT NULL , " & _
                   "[FileExt] [varchar] (10)  NULL ,[Description] [varchar] (250) NULL ,[Metafile] [varchar] (5000)  NULL , " & _
                   "[CollectedVia] [varchar] (50)  NULL ,[CollectedDate] [smalldatetime] NULL ,[CreateDate] [smalldatetime] NOT NULL ," & _
                   "[UpdateDate] [smalldatetime] NOT NULL ,[CreateUser] [smallint] NOT NULL ,[UpdateUser] [smallint] NOT NULL ," & _
                   "[Assigned] [bit] NULL ,[IsRead] [bit] NULL ,[IsCheckOut] [bit] NULL , [CheckOutPath] [varchar] (50) NULL , " & _
                   "[CheckOutFileName] [varchar] (50) NULL ,[CheckOutUser] [int] NULL ,[CheckOutDate] [smalldatetime] NULL , " & _
                   "[CheckInDate] [smalldatetime] NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]"
    ExeStatement = "1008#CREATE TABLE [dbo].[ReportTags] ([TagID] [smallint] NOT NULL, [TagName] [varchar] (50) NOT NULL, [TagSQL] [varchar] (8000) NOT NULL, [CreateDate] [smalldatetime] NOT NULL, [UpdateDate] [smalldatetime] NOT NULL, [CreateUser] [smallint] NOT NULL, [UpdateUser] [smallint] NOT NULL, CONSTRAINT [PK_ReportTags] PRIMARY KEY CLUSTERED ([TagID]), CONSTRAINT [IX_ReportTags_TagName] UNIQUE NONCLUSTERED ([TagName]), CONSTRAINT [FK_ReportTags_Users] FOREIGN KEY ([CreateUser]) REFERENCES [dbo].[Users] ([UserID]), CONSTRAINT [FK_ReportTags_Users1] FOREIGN KEY ([UpdateUser]) REFERENCES [dbo].[Users] ([UserID]))"
    
2   ExeStatement = "2001#CREATE TABLE [dbo].[Schedules] ([AcTypeID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , " & _
                   "[ScheduleTypeID] [tinyint] NOT NULL , [NoteNo] [varchar] (20)  NULL , [IsFinished] [bit] NOT NULL , " & _
                   "[CreateDate] [smalldatetime] NOT NULL , [CreateUser] [smallint] NOT NULL , [UpdateDate] [smalldatetime] NOT NULL , [UpdateUser] [SmallInt] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2002#CREATE TABLE [dbo].[ScheduleTypes] ([ScheduleTypeID] [tinyint] NOT NULL , [ScheduleTypeName] [VarChar](50) NOT NULL) ON [PRIMARY]"
    ExeStatement = "2003#CREATE TABLE [dbo].[SchedulesSubBalanceSheet] ([AcTypeID] [int] NOT NULL ,[PeriodID] [smallint] NOT NULL , [NoteNo] [varchar] (20)  NOT NULL , [DAmt] [float] NOT NULL ,[CAmt] [Float] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2004#CREATE TABLE [dbo].[SchedulesSubGeneral] ([AcTypeID] [int] NOT NULL ,[PeriodID] [smallint] NOT NULL , " & _
                   "[ScheduleTypeID] [tinyint] NOT NULL , [SlNo] [tinyint] NOT NULL , [SubAcTypeID] [int] NULL , [SubAcID] [int] NULL , [Amount] [Float] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2005#ALTER TABLE [dbo].[Schedules] ADD CONSTRAINT [PK_Schedules] PRIMARY KEY  CLUSTERED " & _
                   "([AcTypeID], [PeriodID], [ScheduleTypeID])  ON [PRIMARY]"
    ExeStatement = "2006#ALTER TABLE [dbo].[ScheduleTypes] ADD CONSTRAINT [PK_ScheduleTypes] PRIMARY KEY  CLUSTERED " & _
                   "([ScheduleTypeID]) ON [PRIMARY]"
    ExeStatement = "2007#ALTER TABLE [dbo].[SchedulesSubBalanceSheet] ADD CONSTRAINT [PK_SchedulesSubBalanceSheet] PRIMARY KEY  CLUSTERED " & _
                   "([AcTypeID], [PeriodID]) ON [PRIMARY]"
    ExeStatement = "2008#ALTER TABLE [dbo].[SchedulesSubGeneral] ADD CONSTRAINT [PK_SchedulesSubGeneral] PRIMARY KEY  CLUSTERED " & _
                   "([AcTypeID], [PeriodID], [ScheduleTypeID], [SlNo]) ON [PRIMARY]"
    ExeStatement = "2009#ALTER TABLE [dbo].[Schedules] ADD CONSTRAINT [FK_Schedules_AcTypes] FOREIGN KEY " & _
                   "([AcTypeID] ) REFERENCES [dbo].[AcTypes] ( [AcTypeID] ), CONSTRAINT [FK_Schedules_Periods] FOREIGN KEY  " & _
                   "([PeriodID] ) REFERENCES [dbo].[Periods] ( [PeriodID] ), CONSTRAINT [FK_Schedules_SchedulesSubBalanceSheet] FOREIGN KEY " & _
                   "([AcTypeID], [PeriodID] ) REFERENCES [dbo].[SchedulesSubBalanceSheet] ([AcTypeID], [PeriodID]), CONSTRAINT [FK_Schedules_ScheduleTypes] FOREIGN KEY " & _
                   "([ScheduleTypeID]) REFERENCES [dbo].[ScheduleTypes] ([ScheduleTypeID])"
    ExeStatement = "2010#ALTER TABLE [dbo].[SchedulesSubGeneral] ADD CONSTRAINT [FK_SchedulesSubGeneral_AcHeads] FOREIGN KEY([SubAcID]) REFERENCES [dbo].[AcHeads]([AcID]), " & _
                   "CONSTRAINT [FK_SchedulesSubGeneral_AcTypes] FOREIGN KEY([SubAcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID]), CONSTRAINT [FK_SchedulesSubGeneral_Schedules] FOREIGN KEY " & _
                   "([AcTypeID],[PeriodID],[ScheduleTypeID]) REFERENCES [dbo].[Schedules] ([AcTypeID],[PeriodID],[ScheduleTypeID])"

3   ExeStatement = "2011#DROP Table [dbo].[SchedulesSubGeneral]"
    ExeStatement = "2012#ALTER Table [dbo].[Schedules] ADD DerivedAmount Float NULL "
    ExeStatement = "2013#ALTER Table [dbo].[Schedules] ALTER COLUMN DerivedAmount Float NOT NULL "
    
4   ExeStatement = "2014#ALTER Table [dbo].[Schedules] ADD IsDetailed Bit NULL "
    ExeStatement = "2015#ALTER Table [dbo].[Schedules] ALTER COLUMN IsDetailed Bit NOT NULL "
    
5   ExeStatement = "2016#CREATE TABLE [dbo].[FixedAssetScheduleItems]([AcTypeID] [int] NOT NULL ,[ItemID] [smallint] NOT NULL ,[Description] [varchar] (100) NOT NULL ," & _
                   "[Format] [varchar] (50) NOT NULL) ON [PRIMARY]"

    ExeStatement = "2017#CREATE TABLE [dbo].[FixedAssetSchedules] ([AcTypeID] [int] NOT NULL ,[PeriodID] [smallint] NOT NULL ,[ItemID] [smallint] NOT NULL , " & _
                   "[AcID] [smallint] NULL , [Amount] [Float] NOT NULL) ON [PRIMARY]"

    ExeStatement = "2018#ALTER TABLE [dbo].[FixedAssetScheduleItems] ADD CONSTRAINT [PK_FixedAssetScheduleItems] PRIMARY KEY  CLUSTERED " & _
                   "([AcTypeID], [ItemID])  ON [PRIMARY] "

    ExeStatement = "2019#ALTER TABLE [dbo].[FixedAssetSchedules] ADD CONSTRAINT [PK_FixedAssetSchedules] PRIMARY KEY  CLUSTERED " & _
                   "([AcTypeID], [PeriodID], [ItemID]) ON [PRIMARY] "
                   
6   ExeStatement = "2020#ALTER Table [dbo].[AcTypes] ADD IsFixedAssetParent Bit NULL "

7   ExeStatement = "2021#ALTER TABLE [dbo].[FixedAssetScheduleItems] DROP CONSTRAINT [PK_FixedAssetScheduleItems]"
    ExeStatement = "2022#ALTER TABLE [dbo].[FixedAssetScheduleItems] DROP COLUMN AcTypeID"
    ExeStatement = "2023#ALTER TABLE [dbo].[FixedAssetScheduleItems] ADD CONSTRAINT [PK_FixedAssetScheduleItems] PRIMARY KEY  CLUSTERED " & _
                   "([ItemID])  ON [PRIMARY] "
8   ExeStatement = "2024#ALTER TABLE [dbo].[FixedAssetSchedules] DROP COLUMN ScheduleTypeID"
    ExeStatement = "2025#ALTER TABLE [dbo].[FixedAssetSchedules] DROP COLUMN NoteNo"

9   ExeStatement = "2026#CREATE TABLE [dbo].[CashFlowItems] ([SectionID] [smallint] NOT NULL ,[ItemID] [smallint] NOT NULL , " & _
                   "[Description] [varchar] (100) NOT NULL , [IsEditable] [bit] NULL , [IsTotal] [bit] NULL, [IsBold] [bit] NULL) ON [PRIMARY] "
    ExeStatement = "2027#ALTER TABLE [dbo].[CashFlowItems] ADD CONSTRAINT [PK_CashFlowItems] PRIMARY KEY  CLUSTERED " & _
                   "([SectionID],[ItemID]) ON [PRIMARY] "

10  ExeStatement = "2028#CREATE TABLE [dbo].[CashFlowDetails] ([PeriodID] [smallint] NOT NULL ,[ItemID] [smallint] NOT NULL , " & _
                   "[DisplayID] [smallint] NOT NULL , [Description] [varchar] (100) NOT NULL , [Amount] [Float] NULL) ON [PRIMARY] "
    ExeStatement = "2029#ALTER TABLE [dbo].[CashFlowDetails] ADD CONSTRAINT [PK_CashFlowDetails] PRIMARY KEY  CLUSTERED " & _
                   "([PeriodID],[ItemID],[DisplayID]) ON [PRIMARY] "

11  ExeStatement = "2030#CREATE TABLE [dbo].[ConsoleRootObjects] ( " & _
                   "[ObjectID] [smallint] NOT NULL , [ObjectName] [varchar] (50)   NOT NULL , " & _
                   "[DisplayName] [varchar] (50)   NULL ,[FontName] [varchar] (50)   NULL , " & _
                   "[FontSize] [float] NULL , [IsBold] [bit] NOT NULL , [IsItalic] [bit] NOT NULL , " & _
                   "[IsUnderlined] [bit] NOT NULL , [ForeColor] [int] NULL , [BackColor] [int] NULL ) ON [PRIMARY] "

12  ExeStatement = "2031#CREATE TABLE [dbo].[ObjectPrivileges] ( " & _
                   "[PrvlID] [smallint] NOT NULL ,[ObjectID] [smallint] NOT NULL , " & _
                   "[PrvlName] [varchar] (50)   NOT NULL , [DisplayName] [varchar] (250)   NULL , " & _
                   "[Command] [varchar] (20)   NOT NULL , [ParentPrvlID] [smallint] NULL , [DisplayOrder] [smallint] NULL , " & _
                   "[IsObjectPrvl] [bit] NOT NULL , [FontName] [varchar] (50)   NULL , [FontSize] [float] NULL , " & _
                   "[IsBold] [bit] NULL , [IsItalic] [bit] NULL , [IsUnderlined] [bit] NULL , [ForeColor] [int] NULL , " & _
                   "[BackColor] [int] NULL ) ON [PRIMARY]"

13  ExeStatement = "2032#ALTER TABLE [dbo].[ConsoleRootObjects]   ADD CONSTRAINT [PK_ConsoleRootObjects] PRIMARY KEY  CLUSTERED " & _
                   "([ObjectID])  ON [PRIMARY]"
    ExeStatement = "2033#ALTER TABLE [dbo].[ObjectPrivileges]   ADD CONSTRAINT [PK_ObjectPrivileges] PRIMARY KEY  CLUSTERED " & _
                   "([PrvlID])  ON [PRIMARY] "
    ExeStatement = "2034#ALTER TABLE [dbo].[ObjectPrivileges] ADD CONSTRAINT [FK_ObjectPrivileges_ConsoleRootObjects] FOREIGN KEY " & _
                   "([ObjectID]) REFERENCES [dbo].[ConsoleRootObjects] ([ObjectID])"

14  ExeStatement = "2035#ALTER TABLE [dbo].[ConsoleRootObjects] ADD ParentObjectID smallint NULL"
    ExeStatement = "2036#ALTER TABLE [dbo].[ConsoleRootObjects] ADD DisplayOrder smallint NULL"

15  ExeStatement = "2037#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN FontName"
    ExeStatement = "2038#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN FontSize"
    ExeStatement = "2039#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN IsBold"
    ExeStatement = "2040#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN IsItalic"
    ExeStatement = "2041#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN IsUnderlined"
    ExeStatement = "2042#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN ForeColor"
    ExeStatement = "2043#ALTER TABLE [dbo].[ObjectPrivileges] DROP COLUMN BackColor"
    ExeStatement = "2044#ALTER TABLE [dbo].[ObjectPrivileges] ADD IsHidden bit not null"

16  ExeStatement = "2045#ALTER TABLE [dbo].[ProcedureSubColumns] ADD ColForecolor int null"
    ExeStatement = "2046#ALTER TABLE [dbo].[ProcedureSubColumns] ADD ColBackcolor int null"
    ExeStatement = "2047#ALTER TABLE [dbo].[ProcedureSubColumns] ADD ColAlign tinyint null"
    ExeStatement = "2048#ALTER TABLE [dbo].[ProcedureSubColumns] ADD ColIsLocked bit null"

    ExeStatement = "2049#ALTER TABLE [dbo].[ProcedureSubDefaults] ADD IsDesign bit null"
    ExeStatement = "2050#DROP TABLE [dbo].[TOC]"
    ExeStatement = "2051#CREATE TABLE [dbo].[TableTypes] ([TableTypeID] tinyint NOT NULL, [TableTypeName] varchar(50) NOT NULL, [ScheduleTypeID] tinyint NULL, CONSTRAINT [PK_TableTypes] PRIMARY KEY CLUSTERED([TableTypeID]), CONSTRAINT [IX_TableTypes_TableTypeName] UNIQUE NONCLUSTERED ([TableTypeName]), CONSTRAINT [FK_TableTypes_ScheduleTypes] FOREIGN KEY ([ScheduleTypeID]) REFERENCES [dbo].[ScheduleTypes] ([ScheduleTypeID]))"
    ExeStatement = "2052#ALTER TABLE [dbo].[ReportsObjects] ADD [TableTypeID] tinyint NULL, [AcTypeID] int NULL, CONSTRAINT [FK_ReportsObjects_TableTypes] FOREIGN KEY ([TableTypeID]) REFERENCES [dbo].[TableTypes] ([TableTypeID]), CONSTRAINT [FK_ReportsObjects_AcTypes] FOREIGN KEY ([AcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID])"
    ExeStatement = "2053#CREATE TABLE [dbo].[ReportTypes] ([ReportTypeID] tinyint NOT NULL, [ReportTypeName] varchar(50) NOT NULL, CONSTRAINT [PK_ReportTypes] PRIMARY KEY CLUSTERED([ReportTypeID]), CONSTRAINT [IX_ReportTypes_ReportTypeName] UNIQUE NONCLUSTERED ([ReportTypeName]))"
    ExeStatement = "2054#ALTER TABLE [dbo].[Reports] ADD [ReportTypeID] tinyint NULL, CONSTRAINT [FK_Reports_ReportTypes] FOREIGN KEY ([ReportTypeID]) REFERENCES [dbo].[ReportTypes] ([ReportTypeID]), CONSTRAINT [IX_Reports_ReportTypeID_ReportName] UNIQUE NONCLUSTERED ([ReportTypeID], [ReportName])"
    '25th October 2007, Thursday
    ExeStatement = "2055#CREATE TABLE [dbo].[ReportTemplates] ([TemplateID] smallint NOT NULL, [TemplateName] varchar(50) NOT NULL, [TextRTF] varchar(8000) NOT NULL, CONSTRAINT [PK_ReportTemplates] PRIMARY KEY CLUSTERED([TemplateID]), CONSTRAINT [IX_ReportTemplates_TemplateName] UNIQUE NONCLUSTERED ([TemplateName]))"

17  ExeStatement = "2056#ALTER TABLE [dbo].[FilingSubSection] ADD AcTypeID] int null"

18  ExeStatement = "2057#ALTER TABLE [dbo].[FilingSubSection] DROP CONSTRAINT PK_FilingSubSection"
    ExeStatement = "2058#ALTER TABLE [dbo].[FilingSubSection] DROP COLUMN PeriodID"
    ExeStatement = "2059#ALTER TABLE [dbo].[FilingSubSection] ADD CONSTRAINT PK_FilingSubSection PRIMARY KEY CLUSTERED ([SubSectionID])"

19  ExeStatement = "2060#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT UK_QUESTIONIDDESC UNIQUE(QuestionID, Description)"

20  ExeStatement = "2061#CREATE TABLE [dbo].[SubSectionProcedures] ([ProcedureSlNo] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , [QuestionID] [smallint] NOT NULL , [AnswerID] [SmallInt] NOT NULL) ON [PRIMARY] "
    ExeStatement = "2062#ALTER TABLE [dbo].[SubSectionProcedures]  ADD CONSTRAINT [PK_SubSectionProcedures] PRIMARY KEY  CLUSTERED ([ProcedureSlNo], [PeriodID], [SubSectionID] )  ON [PRIMARY]"
    ExeStatement = "2063#ALTER TABLE [dbo].[SubSectionProcedures] ADD CONSTRAINT [FK_SubSectionProcedures] FOREIGN KEY ([SubSectionID] ) REFERENCES [dbo].[FilingSubSection] ([SubSectionID] ), CONSTRAINT [FK_SubSectionProcedures_Periods] FOREIGN KEY (" & _
                   "[PeriodID] ) REFERENCES [dbo].[Periods] ( [PeriodID] ), CONSTRAINT [FK_SubSectionProcedures_ProcedureAnswers] FOREIGN KEY ( [QuestionID], [AnswerID] ) REFERENCES [dbo].[ProcedureAnswers] ([QuestionID], [AnswerID] )"

21  ExeStatement = "2064#CREATE TABLE [dbo].[ProcedureQuestions] ([ProcedureTypeID] [smallint] NOT NULL , [QuestionID] [smallint] NOT NULL , [QuestionCode] [smallint] NOT NULL , [Question] [varchar] (200) NOT NULL , " & _
                   "[CreateDate] [smalldatetime] NOT NULL , [UpdateDate] [smalldatetime] NOT NULL , [CreateUser] [smallint] NOT NULL , [UpdateUser] [SmallInt] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2065#ALTER TABLE [dbo].[ProcedureQuestions] ADD CONSTRAINT [PK_ProcedureQuestions] PRIMARY KEY  CLUSTERED ([ProcedureTypeID], [QuestionID])  ON [PRIMARY]"
    ExeStatement = "2066#CREATE TABLE [dbo].[ProcedureAnswers] ([QuestionID] [smallint] NOT NULL , [AnswerID] [smallint] NOT NULL , [Description] [varchar] (500) NOT NULL , [ForeColor] [int] NULL , " & _
                   "[IsFavourable] [bit] NULL , [TemplateFile] [image]  NULL) ON [PRIMARY]"
    ExeStatement = "2067#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT [PK_ProcedureAnswers] PRIMARY KEY  CLUSTERED ([QuestionID], [AnswerID]) ON [PRIMARY]"
    ExeStatement = "2068#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT [UK_QUESTIONIDDESC] UNIQUE  NONCLUSTERED ([QuestionID], [Description]) ON [PRIMARY]"
    ExeStatement = "2069#DROP TABLE [dbo].[ProcedureAnswers]"

    ExeStatement = "2070#CREATE TABLE [dbo].[ProcedureAnswers] ([QuestionID] [smallint] NOT NULL , [AnswerID] [smallint] NOT NULL , [Description] [varchar] (500) NOT NULL , [ForeColor] [int] NULL , " & _
                   "[IsFavourable] [bit] NULL , [TemplateFile] [image] NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]"
    ExeStatement = "2071#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT [PK_ProcedureAnswers] PRIMARY KEY  CLUSTERED ([QuestionID], [AnswerID]) ON [PRIMARY]"
    ExeStatement = "2072#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT [UK_QUESTIONIDDESC] UNIQUE  NONCLUSTERED ([QuestionID], [Description])  ON [PRIMARY]"

22  ExeStatement = "2073:1#ALTER TABLE [dbo].[DocumentBin] ADD IsCheckOut BIT NULL, CheckOutPath Varchar(500) NULL, CheckOutFileName Varchar(500) NULL, CheckOutUser smallInt null, CheckOutDate smalldatetime null, CheckInDate smalldatetime null"
    ExeStatement = "2074:1#ALTER TABLE [dbo].[DocumentBin] ADD IsRead BIT NULL"

23  ExeStatement = "2075#ALTER TABLE [dbo].[ProcedureAnswers] ADD FileName VARCHAR(50) NULL"

24  ExeStatement = "2076#ALTER TABLE [dbo].[SubSectionProcedures] ADD TemplateFile image NULL"
    ExeStatement = "2077#ALTER TABLE [dbo].[SubSectionProcedures] ADD FileName VARCHAR(50) NULL"

25  ExeStatement = "2078#CREATE TABLE [dbo].[Reviews] ([ReviewID] [int] NOT NULL , [AcTypeID] [int] NOT NULL ,[ProcedureID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL ,  [Question] [varchar] (100) NOT NULL , " & _
                   "[Answer] [varchar] (200) NULL , [CreateUser] [smallint] NOT NULL , [CreateDate] [smalldatetime] NOT NULL , [UpdateUser] [smallint] NULL , [UpdateDate] [smalldatetime] NULL) ON [PRIMARY]"
    ExeStatement = "2079#ALTER TABLE [dbo].[Reviews] WITH NOCHECK ADD CONSTRAINT [PK_Reviews] PRIMARY KEY  CLUSTERED ([ReviewID], [AcTypeID], [ProcedureID])  ON [PRIMARY]"
    ExeStatement = "2080#ALTER TABLE [dbo].[Reviews] ADD AcHeadID int Null"

26  ExeStatement = "2081#ALTER TABLE [dbo].[CashFlowDetails] ADD AcTypeID int Null"
    ExeStatement = "2082#ALTER TABLE [dbo].[CashFlowDetails] DROP CONSTRAINT PK_CashFlowDetails"
    ExeStatement = "2083#ALTER TABLE [dbo].[CashFlowDetails] ADD CashFlowID int NULL"
    ExeStatement = "2084#ALTER TABLE [dbo].[CashFlowDetails] ALTER COLUMN CashFlowID int NOT NULL"
    ExeStatement = "2085#ALTER TABLE [dbo].[CashFlowDetails] ADD CONSTRAINT [PK_CashFlowDetails] PRIMARY KEY CLUSTERED ([CashFlowID])"
    ExeStatement = "2086#ALTER TABLE [dbo].[CashFlowDetails] DROP COLUMN ItemID"
    ExeStatement = "2087#ALTER TABLE [dbo].[CashFlowItems] DROP CONSTRAINT PK_CashFlowItems"
    ExeStatement = "2088#ALTER TABLE [dbo].[CashFlowItems] DROP COLUMN ItemID"
    ExeStatement = "2089#ALTER TABLE [dbo].[CashFlowDetails] DROP COLUMN DisplayID"
    ExeStatement = "2090#ALTER TABLE [dbo].[CashFlowItems] DROP COLUMN SectionID"
    ExeStatement = "2091#ALTER TABLE [dbo].[CashFlowDetails] ADD IsBold Bit NULL"
    ExeStatement = "2092#ALTER TABLE [dbo].[CashFlowDetails] ADD IsTotal Bit NULL"
    ExeStatement = "2093#ALTER TABLE [dbo].[CashFlowItems] ADD ID smallint NULL"
    ExeStatement = "2094#ALTER TABLE [dbo].[CashFlowItems] ALTER COLUMN ID smallint NOT NULL"
    ExeStatement = "2095#ALTER TABLE [dbo].[CashFlowItems] ADD CONSTRAINT [PK_CashFlowItems] PRIMARY KEY CLUSTERED ([ID])"

27  ExeStatement = "2096#CREATE TABLE [dbo].[Remarks] ([RemarkId] [smallint] NOT NULL , [SubSectionID] [smallint] NULL , " & _
                   "[Observations] [varchar] (200) NULL , [CreateUser] [smallint] NOT NULL , [CreateDate] [smalldatetime] NOT NULL , " & _
                   "[UpdateUser] [smallint] NULL , [UpdateDate] [smalldatetime] NULL) ON [PRIMARY]"
    ExeStatement = "2097#ALTER TABLE [dbo].[Remarks] ADD CONSTRAINT [PK_Remarks] PRIMARY KEY  CLUSTERED ([RemarkId], [SubSectionID]) "
    ExeStatement = "2098#ALTER TABLE [dbo].[Remarks] ADD Actions Varchar(200) NULL"

28  ExeStatement = "2099#CREATE TABLE [dbo].[SubSectionData] ([PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[Data1] [varchar] (7500) NULL , [Data2] [varchar] (7500) NULL , [Data3] [varchar] (7500) NULL) ON [PRIMARY]"
    ExeStatement = "2100#ALTER TABLE [dbo].[SubSectionData] ADD CONSTRAINT [PK_SubSectionData] PRIMARY KEY  CLUSTERED " & _
                   "([PeriodID], [SubSectionID]) ON [PRIMARY]"
29  ExeStatement = "2101#ALTER TABLE [dbo].[FilingSections] ADD IsStringData Bit NULL"
    ExeStatement = "2102#UPDATE [dbo].[FilingSections] SET  IsStringData = 1 WHERE SectionID <=4"
    ExeStatement = "2103#UPDATE [dbo].[FilingSections] SET  IsStringData = 0 WHERE SectionID > 4"
    ExeStatement = "2104#ALTER TABLE [dbo].[FilingSections] ALTER COLUMN IsStringData Bit NOT NULL"
30  ExeStatement = "2105#ALTER TABLE [dbo].[SubSectionData] ADD Data4 Varchar(7500) NULL"

31  ExeStatement = "2106#CREATE TABLE [dbo].[SubSectionDataExtension] ([PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL ," & _
                   "[SubSlNo] [tinyint] NOT NULL , [DataExtension] [varchar] (8000) NOT NULL) ON [PRIMARY]"
    ExeStatement = "2107#ALTER TABLE [dbo].[SubSectionDataExtension] ADD CONSTRAINT [PK_SubSectionDataSub] PRIMARY KEY  CLUSTERED ([PeriodID], [SubSectionID], [SubSlNo]) ON [PRIMARY]"
    ExeStatement = "2108#ALTER TABLE [dbo].[SubSectionDataExtension] ADD CONSTRAINT [FK_SubSectionDataSub_SubSectionData] FOREIGN KEY ([PeriodID], [SubSectionID]) " & _
                   "REFERENCES [dbo].[SubSectionData] ([PeriodID], [SubSectionID])"
    ExeStatement = "2109#ALTER TABLE [dbo].[SubSectionData] DROP COLUMN Data1"
    ExeStatement = "2110#ALTER TABLE [dbo].[SubSectionData] DROP COLUMN Data2"
    ExeStatement = "2111#ALTER TABLE [dbo].[SubSectionData] DROP COLUMN Data3"
    ExeStatement = "2112#ALTER TABLE [dbo].[SubSectionData] DROP COLUMN Data4"
    ExeStatement = "2113#ALTER TABLE [dbo].[SubSectionData] ADD Data Varchar(8000)"

32  ExeStatement = "2114#ALTER TABLE [dbo].[EntrySubAccounts] DROP CONSTRAINT PK_EntrySubAccounts"
    ExeStatement = "2115#ALTER TABLE [dbo].[EntrySubAccounts] ALTER COLUMN AcSlNo SmallInt"
    ExeStatement = "2116#ALTER TABLE [dbo].[EntrySubAccounts] ALTER COLUMN AcSlNo SmallInt NOT NULL"
    ExeStatement = "2117#ALTER TABLE [dbo].[EntrySubAccounts] ADD CONSTRAINT PK_EntrySubAccounts PRIMARY KEY CLUSTERED (EntryID,AcSlNo)"

33  ExeStatement = "2118#ALTER TABLE [dbo].[SubSectionData] ADD IsTemplate Bit NULL"
    ExeStatement = "2119#UPDATE [dbo].[SubSectionData] SET IsTemplate = 0 WHERE SubSectionID >0"
    ExeStatement = "2120#ALTER TABLE [dbo].[SubSectionData] ALTER COLUMN IsTemplate Bit NOT NULL"

34  ExeStatement = "2121#CREATE TABLE [dbo].[CurrencyMaster] ([CurrencyID] [smallint] NOT NULL , [CurrencyName] [varchar] (50) NOT NULL , [CurrencyShortName] [char] (10) NOT NULL) ON [PRIMARY]"
    ExeStatement = "2122#ALTER TABLE [dbo].[CurrencyMaster] ADD CONSTRAINT [PK_CurrencyMaster] PRIMARY KEY  CLUSTERED([CurrencyID]) ON [PRIMARY]"
    ExeStatement = "2123#CREATE TABLE [dbo].[BankMaster] ([BankID] [smallint] NOT NULL , [BankName] [varchar] (50) NOT NULL) ON [PRIMARY]"
    ExeStatement = "2124#ALTER TABLE [dbo].[BankMaster] ADD CONSTRAINT [PK_BankMaster] PRIMARY KEY  CLUSTERED ([BankID])  ON [PRIMARY]"

35  ExeStatement = "2125#ALTER TABLE [dbo].[CurrencyMaster] ADD CompanyID smallint null"
    ExeStatement = "2126#Update [dbo].[CurrencyMaster]  set CompanyID = 1 Where CompanyID is null"
    ExeStatement = "2127#ALTER TABLE [dbo].[CurrencyMaster] ALTER COLUMN CompanyID smallint Not null"
    ExeStatement = "2128#ALTER TABLE [dbo].[CurrencyMaster] ALTER COLUMN CurrencyShortName VARCHAR(10)"

    ExeStatement = "2129#ALTER TABLE [dbo].[BankMaster] ADD CompanyID smallint null"
    ExeStatement = "2130#Update [dbo].[BankMaster]  set CompanyID = 1 Where CompanyID is null"
    ExeStatement = "2131#ALTER TABLE [dbo].[BankMaster] ALTER COLUMN CompanyID smallint Not null"

36  ExeStatement = "2132#ALTER TABLE [dbo].[Users] ADD IsSuperUser bit null"
    ExeStatement = "2133#UPDATE [dbo].[Users] SET IsSuperUser = 0 WHERE IsSuperUser is null"
    ExeStatement = "2134#ALTER TABLE [dbo].[Users] ALTER COLUMN IsSuperUser bit not null"

37  ExeStatement = "2135#CREATE TABLE [dbo].[DocumentSubLinks] (" & _
                   "[DocLinkID] [int] NOT NULL , [DocumentID] [int] NOT NULL , " & _
                   "[PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[ProcedureID] [smallint] NULL , [AcTypeID] [int] NULL , [AcID] [int] NULL) ON [PRIMARY]"

    ExeStatement = "2136#ALTER TABLE [dbo].[DocumentSubLinks] ADD CONSTRAINT [PK_DocumentSubLinks] PRIMARY KEY  CLUSTERED ([DocLinkID])  ON [PRIMARY]"
    ExeStatement = "2137#ALTER TABLE [dbo].[DocumentSubLinks] ADD CONSTRAINT [FK_DocumentSubLinks_Periods] FOREIGN KEY " & _
                   "([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "2138#ALTER TABLE [dbo].[ProcedureQuestions] DROP CONSTRAINT PK_ProcedureQuestions"
    ExeStatement = "2139#ALTER TABLE [dbo].[ProcedureQuestions] ADD CONSTRAINT PK_ProcedureQuestions PRIMARY KEY CLUSTERED ([QuestionID]) ON [PRIMARY]"

38  ExeStatement = "2140#ALTER TABLE [dbo].[DocumentSubLinks] ADD RefNo Varchar(20) null"
    ExeStatement = "2141#ALTER TABLE [dbo].[DocumentSubLinks] ADD Description Varchar(250) null"
    ExeStatement = "2140#ALTER TABLE [dbo].[DocumentSubLinks] ALTER COLUMN RefNo Varchar(20) NOT null"

39  ExeStatement = "2141#ALTER TABLE [dbo].[SubSectionProcedures] DROP CONSTRAINT PK_SubSectionProcedures"
    ExeStatement = "2142#ALTER TABLE [dbo].[SubSectionProcedures] ADD ProcedureTypeID smallint NULL"
    ExeStatement = "2143#UPDATE [dbo].[SubSectionProcedures] SET ProcedureTypeID = 1 WHERE QuestionID <> 0"
    ExeStatement = "2144#ALTER TABLE [dbo].[SubSectionProcedures] ALTER COLUMN ProcedureTypeID smallint NOT NULL"
    ExeStatement = "2145#ALTER TABLE [dbo].[SubSectionProcedures] ADD CONSTRAINT PK_SubSectionProcedures PRIMARY KEY CLUSTERED ([ProcedureSlNo], [PeriodID], [SubSectionID], [ProcedureTypeID])"
    ExeStatement = "2147#ALTER TABLE [dbo].[SubSectionProcedures] ALTER COLUMN AnswerID smallint NULL"
    ExeStatement = "2148#ALTER TABLE [dbo].[ProcedureAnswers] DROP COLUMN TemplateFile"
    ExeStatement = "2149#ALTER TABLE [dbo].[ProcedureAnswers] DROP COLUMN FileName"

    ExeStatement = "2150#ALTER TABLE [dbo].[ProcedureQuestions] ADD TemplateFile BINARY"
    ExeStatement = "2151#ALTER TABLE [dbo].[ProcedureQuestions] ADD FileName VARCHAR(100)"
    ExeStatement = "2152#ALTER TABLE [dbo].[ProcedureQuestions] ALTER COLUMN TemplateFile image"

    '05th January 2008, Saturday
40  ExeStatement = "2153#ALTER TABLE [dbo].[ReportsObjectsSub] ALTER COLUMN FontSize real NULL"

    '06th January 2008, Sunday
41  ExeStatement = "2154#ALTER TABLE [dbo].[SubSectionProcedures] DROP CONSTRAINT PK_SubSectionProcedures"
    ExeStatement = "2155#ALTER TABLE [dbo].[SubSectionProcedures] ADD CONSTRAINT PK_SubSectionProcedures PRIMARY KEY CLUSTERED ([PeriodID], [SubSectionID], [ProcedureTypeID], [QuestionID])"

42  ExeStatement = "2156#ALTER TABLE [dbo].[SubSectionProcedures] ADD IsCheckedOut Bit Null"
    ExeStatement = "2157#UPDATE [dbo].[SubSectionProcedures] SET IsCheckedOut = 0 WHERE IsCheckedOut IS NULL"
    ExeStatement = "2158#ALTER TABLE [dbo].[SubSectionProcedures] ALTER COLUMN IsCheckedOut Bit Not Null"
    
    ExeStatement = "2159#CREATE TABLE [dbo].[ProcedureQuestionsSub] (" & _
                   "[QuestionID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2160#ALTER TABLE [dbo].[ProcedureQuestionsSub] ADD CONSTRAINT PK_ProcedureQuestionsSub PRIMARY KEY CLUSTERED ([QuestionID], [SubSectionID])"
    
43  ExeStatement = "2164:1#UPDATE [dbo].[DocumentBin] SET IsCheckOut = 0 WHERE IsCheckOut IS NULL"
    ExeStatement = "2165:1#ALTER TABLE [dbo].[DocumentBin] ALTER COLUMN IsCheckOut Bit Not Null"
    
    ExeStatement = "2166#ALTER TABLE [dbo].[Reviews] DROP CONSTRAINT PK_Reviews"
    ExeStatement = "2167#ALTER TABLE [dbo].[Reviews] ALTER COLUMN Question Varchar(2000)"
    ExeStatement = "2168#ALTER TABLE [dbo].[Reviews] ALTER COLUMN Answer Varchar(2000)"
    ExeStatement = "2169#ALTER TABLE [dbo].[Reviews] DROP COLUMN  AcHeadID"
    ExeStatement = "2170#ALTER TABLE [dbo].[Reviews] ADD AcID int null"
    ExeStatement = "2171#ALTER TABLE [dbo].[Reviews] ALTER COLUMN AcTypeID int null"
    ExeStatement = "2172#ALTER TABLE [dbo].[Reviews] ALTER COLUMN ProcedureID smallint null"
    ExeStatement = "2173#ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT [PK_Reviews] PRIMARY KEY  CLUSTERED " & _
                   "([ReviewID])  ON [PRIMARY]"

44  ExeStatement = "2176#ALTER TABLE [dbo].[ProcedureQuestionsSub] ADD " & _
                   "CONSTRAINT [FK_ProcedureQuestionsSub_FilingSubSection] FOREIGN KEY " & _
                   "([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID]), " & _
                   "CONSTRAINT [FK_ProcedureQuestionsSub_ProcedureQuestions] FOREIGN KEY " & _
                   "([QuestionID]) REFERENCES [dbo].[ProcedureQuestions] ([QuestionID])"
45  ExeStatement = "2177#UPDATE [dbo].[CashFlowItems] SET IsTotal = 1 Where ID = 19"

    '15th January 2008, Tuesday
    'Detach Tables
46  ExeStatement = "2178#CREATE TABLE [dbo].[DetachTables] ([TableID] [smallint] NOT NULL, [TableName] [varchar] (50) NOT NULL, [ParentTableID] [smallint] NULL, [TableOrder] [smallint] NOT NULL, IsCompanyOrPeriodID [bit] NOT NULL, CONSTRAINT [PK_DetachTables] PRIMARY KEY CLUSTERED ([TableID]), CONSTRAINT [IX_DetachTables_TableName] UNIQUE NONCLUSTERED ([TableName]), CONSTRAINT [FK_DetachTables_DetachTables] FOREIGN KEY ([ParentTableID]) REFERENCES [dbo].[DetachTables] ([TableID])) ON [PRIMARY]"

47  ExeStatement = "2179#ALTER TABLE [dbo].CashFlowDetails DROP CONSTRAINT PK_CashFlowDetails"
    ExeStatement = "2180#ALTER TABLE [dbo].CashFlowDetails ADD CONSTRAINT PK_CashFlowDetails PRIMARY KEY CLUSTERED ([CashFlowID], [PeriodID]) ON [PRIMARY]"

    '19th January 2008, Saturday
    'Detach Tables
48  ExeStatement = "2181#ALTER TABLE [dbo].[ReportsObjects] DROP CONSTRAINT [FK_ReportsObjects_AcTypes]"

    ExeStatement = "2182#ALTER TABLE [dbo].[Companies] ADD DetachedBy Varchar(50) NULL"
    ExeStatement = "2183#ALTER TABLE [dbo].[Companies] ADD DetachedDate smalldatetime NULL"

49  ExeStatement = "2184#CREATE TABLE [dbo].[FilingAccountRemarks] ([RemarkID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL, [SubSectionID] [smallint] NOT NULL , [AcTypeID] [smallint] NULL , [AcID] [smallint] NULL , [Description] [varchar] (1000) NULL, " & _
                   "[CreateUser] [smallint] NOT NULL, [CreateDate] [smalldatetime] NOT NULL, [UpdateUser] [smallint] NOT NULL, [UpdateDate] [smalldatetime] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2185#ALTER TABLE [dbo].[FilingAccountRemarks] ADD CONSTRAINT [PK_FilingAccountRemarks] PRIMARY KEY  CLUSTERED ([RemarkID]) ON [PRIMARY]"

    '21st January 2008, Monday
    'Currency in companies
50  ExeStatement = "2186#ALTER TABLE [dbo].[CurrencyMaster] DROP COLUMN CompanyID"
    ExeStatement = "2187#TRUNCATE TABLE CurrencyMaster"
    ExeStatement = "2188#INSERT INTO CurrencyMaster (CurrencyID, CurrencyName, CurrencyShortName) VALUES (1, 'Arab Emirates Dirhams', 'AED')"
    ExeStatement = "2189#ALTER TABLE [dbo].[Companies] ADD CurrencyID smallint NULL"
    ExeStatement = "2190#ALTER TABLE [dbo].[Companies] ADD CONSTRAINT [FK_Companies_CurrencyMaster] FOREIGN KEY ([CurrencyID]) REFERENCES [dbo].[CurrencyMaster] ([CurrencyID])"
    ExeStatement = "2191#UPDATE Companies SET CurrencyID = 1 WHERE CurrencyID IS NULL"
    ExeStatement = "2192#ALTER TABLE [dbo].[Companies] ALTER COLUMN CurrencyID smallint NOT NULL"

51  ExeStatement = "2193#ALTER TABLE [dbo].[CashFlowDetails] ADD PreviousAmount Float NULL"

    '21st February 2008, Thursday
52  ExeStatement = "2194#CREATE TABLE [dbo].[Nations] ([NationID] [tinyint] NOT NULL , [NationName] [varchar] (100) NOT NULL , [StatusID] [SmallInt] Not Null ) ON [PRIMARY]"
    ExeStatement = "2195#ALTER TABLE [dbo].[Nations]  ADD CONSTRAINT [PK_Nations] PRIMARY KEY  CLUSTERED ([NationID])  ON [PRIMARY]"
    ExeStatement = "2196#ALTER TABLE [dbo].[Nations] ADD CONSTRAINT [FK_Nations_Status] FOREIGN KEY ( [StatusID] ) REFERENCES [dbo].[Status] ( [StatusID] ) "
    
53  ExeStatement = "2197#ALTER TABLE [dbo].[BankMaster] DROP COLUMN CompanyID"
    ExeStatement = "2198#ALTER TABLE [dbo].[BankMaster] ADD StatusID smallint NULL"
    ExeStatement = "2199#UPDATE BankMaster SET StatusID = 1 WHERE StatusID IS NULL"
    ExeStatement = "2200#ALTER TABLE [dbo].[BankMaster] ALTER COLUMN StatusID smallint NOT NULL"

    '24th February 2008, Sunday
54  ExeStatement = "2201#ALTER TABLE [dbo].[CurrencyMaster] ADD StatusID smallint NULL"
    ExeStatement = "2202#UPDATE CurrencyMaster SET StatusID =1 WHERE StatusID IS NULL"
    ExeStatement = "2203#ALTER TABLE [dbo].[CurrencyMaster] ALTER COLUMN StatusID smallint NOT NULL"

    '28th February 2008, Thursday
55  ExeStatement = "2204#ALTER TABLE [dbo].[Users] DROP COLUMN PeriodID"
    ExeStatement = "2205#ALTER TABLE [dbo].[Users] DROP COLUMN FormName"

56  ExeStatement = "2206#CREATE TABLE [dbo].[UserGroups] ([UserGroupID] [smallint] NOT NULL , [UserGroupName] [varchar] (100)NOT NULL) ON [PRIMARY]"
    ExeStatement = "2207#ALTER TABLE [dbo].[UserGroups] ADD CONSTRAINT [PK_UserGroups] PRIMARY KEY  CLUSTERED ([UserGroupID]) ON [PRIMARY]"
    ExeStatement = "2208#CREATE TABLE [dbo].[UserGroupUsers] ([UserID] [smallint] NOT NULL ,[UserGroupID] [SmallInt] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2209#ALTER TABLE [dbo].[UserGroupUsers] ADD CONSTRAINT [PK_UserGroupUsers] PRIMARY KEY  CLUSTERED ([UserID], [UserGroupID]) ON [PRIMARY]"
    ExeStatement = "2210#ALTER TABLE [dbo].[UserGroupUsers] ADD CONSTRAINT [FK_UserGroupUsers_UserGroups] FOREIGN KEY ([UserGroupID]) REFERENCES [dbo].[UserGroups] " & _
                   "([UserGroupID]), CONSTRAINT [FK_UserGroupUsers_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])"

    '01st March 2008, Saturday
57  ExeStatement = "2211#ALTER TABLE [dbo].[UserGroups] ADD OrderField smallint NULL"
    ExeStatement = "2212#UPDATE [UserGroups] SET OrderField = 1 WHERE UserGroupID = 1"
    ExeStatement = "2213#UPDATE [UserGroups] SET OrderField = 2 WHERE UserGroupID = 2"
    ExeStatement = "2214#UPDATE [UserGroups] SET OrderField = 3 WHERE UserGroupID = 3"
    ExeStatement = "2215#UPDATE [UserGroups] SET OrderField = 4 WHERE UserGroupID = 4"
    ExeStatement = "2216#UPDATE [UserGroups] SET OrderField = 5 WHERE UserGroupID = 5"
    ExeStatement = "2217#ALTER TABLE [dbo].[UserGroups] ALTER COLUMN OrderField smallint NOT NULL"

58  ExeStatement = "2218#CREATE TABLE [dbo].[UserAccess] ([UserAccessID] [smallint] NOT NULL , [UserAccessName] [varchar] (100) NOT NULL , " & _
                   "[UserAccessDescription] [varchar] (200) NOT NULL , [OrderField] [smallint] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2219#ALTER TABLE [dbo].[UserAccess] ADD CONSTRAINT [PK_UserAccess] PRIMARY KEY  CLUSTERED ([UserAccessID]) ON [PRIMARY]"
    ExeStatement = "2220#CREATE TABLE [dbo].[UserAccessDefaults] ([UserAccessID] [smallint] NOT NULL , [UserGroupID] [smallint] NOT NULL , " & _
                   "[IsAllowed] [bit] NULL) ON [PRIMARY]"
    ExeStatement = "2221#ALTER TABLE [dbo].[UserAccessDefaults] ADD CONSTRAINT [PK_UserAccessDefaults] PRIMARY KEY  CLUSTERED ([UserAccessID], " & _
                   "[UserGroupID]) ON [PRIMARY]"
    ExeStatement = "2222#ALTER TABLE [dbo].[UserAccessDefaults] ADD CONSTRAINT [FK_UserAccessDefaults_UserAccess] FOREIGN KEY ([UserAccessID]) " & _
                   "REFERENCES [dbo].[UserAccess] ([UserAccessID]), CONSTRAINT [FK_UserAccessDefaults_UserGroups] FOREIGN KEY ([UserGroupID]) " & _
                   "REFERENCES [dbo].[UserGroups] ([UserGroupID])"

    ExeStatement = "2223#CREATE TABLE [dbo].[UserPrivileges] ([PeriodID] [smallint] NOT NULL , [UserID] [smallint] NOT NULL , " & _
                   "[IsBlocked] [bit] NULL) ON [PRIMARY]"
    ExeStatement = "2224#ALTER TABLE [dbo].[UserPrivileges] ADD CONSTRAINT [PK_UserPrivileges] PRIMARY KEY CLUSTERED ([PeriodID], [UserID]) ON [PRIMARY]"
    ExeStatement = "2225#ALTER TABLE [dbo].[UserPrivileges] ADD CONSTRAINT [FK_UserPrivileges_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID]), " & _
                   "CONSTRAINT [FK_UserPrivileges_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])"
    ExeStatement = "2226#CREATE TABLE [dbo].[UserPrivilegesSub] ([UserID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [UserAccessID] [smallint] NOT NULL , " & _
                   "[IsAllowed] [bit] NULL) ON [PRIMARY]"
    ExeStatement = "2227#ALTER TABLE [dbo].[UserPrivilegesSub] ADD CONSTRAINT [PK_UserPrivilegesSub] PRIMARY KEY CLUSTERED ([UserID], [PeriodID], [UserAccessID]) ON [PRIMARY]"
    ExeStatement = "2228#ALTER TABLE [dbo].[UserPrivilegesSub] ADD CONSTRAINT [FK_UserPrivilegesSub_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID]), " & _
                   "CONSTRAINT [FK_UserPrivilegesSub_UserAccess] FOREIGN KEY ([UserAccessID]) REFERENCES [dbo].[UserAccess] ([UserAccessID]), CONSTRAINT [FK_UserPrivilegesSub_Users] " & _
                   "FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])"

    '03rd March 2008, Monday
59  ExeStatement = "2229#CREATE TABLE dbo.AuditReportObjects (PeriodID smallint NOT NULL, ObjSlNo smallint NOT NULL, ObjTypeID tinyint NOT NULL, Description varchar(50) NULL, TableTypeID tinyint NULL, AcTypeID int NULL, Data image NULL, ParentObjSlNo smallint NULL, CONSTRAINT [PK_AuditReportObjects] PRIMARY KEY CLUSTERED (PeriodID, ObjSlNo), CONSTRAINT [FK_AuditReportObjects_TableTypes] FOREIGN KEY (TableTypeID) REFERENCES dbo.TableTypes(TableTypeID), CONSTRAINT [FK_AuditReportObjects_AcTypes] FOREIGN KEY (AcTypeID) REFERENCES dbo.AcTypes(AcTypeID), CONSTRAINT [FK_AuditReportObjects_AuditReportObjects] FOREIGN KEY (PeriodID, ParentObjSlNo) REFERENCES dbo.AuditReportObjects(PeriodID, ObjSlNo)) "
    ExeStatement = "2230#CREATE TABLE dbo.AuditReportObjectTypes (ObjTypeID tinyint NOT NULL, ObjTypeName varchar(50) NOT NULL, ObjType varchar(10) NOT NULL, CONSTRAINT [PK_AuditReportObjectTypes] PRIMARY KEY CLUSTERED (ObjTypeID), CONSTRAINT [IX_AuditReportObjectTypes_ObjTypeName] UNIQUE NONCLUSTERED (ObjTypeName)) "
    ExeStatement = "2231#ALTER TABLE dbo.AuditReportObjects ADD CONSTRAINT [FK_AuditReportObjects_AuditReportObjectTypes] FOREIGN KEY (ObjTypeID) REFERENCES dbo.AuditReportObjectTypes(ObjTypeID)"

    '06th March 2008, Thursday
60  ExeStatement = "2232#ALTER TABLE [dbo].[AcTypes] ADD IsHidden Bit Null"
    ExeStatement = "2233#UPDATE [dbo].[AcTypes] SET IsHidden = 0 Where AcTypeID <> 0"
    ExeStatement = "2234#ALTER TABLE [dbo].[AcTypes] ALTER COLUMN IsHidden Bit NOT NULL"

61  ExeStatement = "2235#CREATE TABLE [dbo].[LiabilitySchedules] ([AcID] [int] NOT NULL , [AcTypeID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , [Amount] [Float] NOT NULL) ON [PRIMARY]"
    ExeStatement = "2236#ALTER TABLE [dbo].[LiabilitySchedules] ADD CONSTRAINT [PK_LiabilitySchedules] PRIMARY KEY  CLUSTERED ([AcID], [AcTypeID], [PeriodID])  ON [PRIMARY]"
    ExeStatement = "2237#ALTER TABLE [dbo].[LiabilitySchedules] ADD CONSTRAINT [FK_LiabilitySchedules_AcHeads] FOREIGN KEY ([AcID]) REFERENCES [dbo].[AcHeads] " & _
                   "([AcID]), CONSTRAINT [FK_LiabilitySchedules_AcTypes] FOREIGN KEY ([AcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID]), CONSTRAINT [FK_LiabilitySchedules_Periods] " & _
                   "FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '24th March 2008, Monday
62  ExeStatement = "2238#ALTER TABLE [dbo].[AuditReportObjects] DROP CONSTRAINT FK_AuditReportObjects_AuditReportObjects"
    ExeStatement = "2239#ALTER TABLE [dbo].[AuditReportObjects] ADD  CONSTRAINT [FK_AuditReportObjects_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "2240#ALTER TABLE [dbo].[ProcedureAnswers] ADD CONSTRAINT [FK_ProcedureAnswers_ProcedureQuestions] FOREIGN KEY ([QuestionID]) REFERENCES [dbo].[ProcedureQuestions] ([QuestionID])"

    Screen.MousePointer = vbDefault
End Sub

Public Sub Version_1_1()
On Local Error Resume Next
Dim lngID As Long, sSql As String
    Screen.MousePointer = vbHourglass
    'Code for Version Updation
    '25th March 2008, Tuesday
1   ExeStatement = "3001#ALTER TABLE [dbo].[Schedules] ADD Remarks  varchar(100) Null"

    '27th March 2008, Thursday
2   ExeStatement = "3002#ALTER TABLE dbo.AuditReportObjects ADD IsOrientationLandscape bit NULL"
    ExeStatement = "3003#UPDATE dbo.AuditReportObjects SET IsOrientationLandscape = 0 WHERE IsOrientationLandscape IS NULL"
    ExeStatement = "3004#ALTER TABLE dbo.AuditReportObjects ALTER COLUMN IsOrientationLandscape bit NOT NULL"

    '29th March 2008, Saturday
3   ExeStatement = "3005#ALTER TABLE dbo.AuditReportObjects ALTER COLUMN Description varchar(250) NULL"

   '31st March 2008, Monday
4   ExeStatement = "3006#ALTER TABLE [dbo].[CurrencyMaster] ADD CreateDate DateTime Null"
    ExeStatement = "3007#ALTER TABLE [dbo].[CurrencyMaster] ADD UpdateDate DateTime Null"
    ExeStatement = "3008#UPDATE [dbo].[CurrencyMaster] SET CreateDate = Current_TimeStamp WHERE CurrencyID Is Not Null"
    ExeStatement = "3009#ALTER TABLE [dbo].[CurrencyMaster] ALTER COLUMN CreateDate DateTime NOT NULL"
    ExeStatement = "3010#UPDATE [dbo].[CurrencyMaster] SET UpdateDate = Current_TimeStamp WHERE CurrencyID Is Not Null"
    ExeStatement = "3011#ALTER TABLE [dbo].[CurrencyMaster] ALTER COLUMN UpdateDate DateTime NOT NULL"

5   ExeStatement = "3012#ALTER TABLE [dbo].[BankMaster] ADD CreateDate DateTime Null"
    ExeStatement = "3013#ALTER TABLE [dbo].[BankMaster] ADD UpdateDate DateTime Null"
    ExeStatement = "3014#UPDATE [dbo].[BankMaster] SET CreateDate = Current_TimeStamp WHERE BankID Is Not Null"
    ExeStatement = "3015#ALTER TABLE [dbo].[BankMaster] ALTER COLUMN CreateDate DateTime NOT NULL"
    ExeStatement = "3016#UPDATE [dbo].[BankMaster] SET UpdateDate = Current_TimeStamp WHERE BankID Is Not Null"
    ExeStatement = "3017#ALTER TABLE [dbo].[BankMaster] ALTER COLUMN UpdateDate DateTime NOT NULL"

6   ExeStatement = "3018#ALTER TABLE [dbo].[Nations] ADD CreateDate DateTime Null"
    ExeStatement = "3019#ALTER TABLE [dbo].[Nations] ADD UpdateDate DateTime Null"
    ExeStatement = "3020#UPDATE [dbo].[Nations] SET CreateDate = Current_TimeStamp WHERE NationID Is Not Null"
    ExeStatement = "3021#ALTER TABLE [dbo].[Nations] ALTER COLUMN CreateDate DateTime NOT NULL"
    ExeStatement = "3022#UPDATE [dbo].[Nations] SET UpdateDate = Current_TimeStamp WHERE NationID Is Not Null"
    ExeStatement = "3023#ALTER TABLE [dbo].[Nations] ALTER COLUMN UpdateDate DateTime NOT NULL"

7   ExeStatement = "3024#ALTER TABLE [dbo].[ProcedureAnswers] ADD CreateDate DateTime Null"
    ExeStatement = "3025#ALTER TABLE [dbo].[ProcedureAnswers] ADD UpdateDate DateTime Null"
    ExeStatement = "3026#UPDATE [dbo].[ProcedureAnswers] SET CreateDate = Current_TimeStamp WHERE QuestionID Is Not Null"
    ExeStatement = "3027#ALTER TABLE [dbo].[ProcedureAnswers] ALTER COLUMN CreateDate DateTime NOT NULL"
    ExeStatement = "3028#UPDATE [dbo].[ProcedureAnswers] SET UpdateDate = Current_TimeStamp WHERE QuestionID Is Not Null"
    ExeStatement = "3029#ALTER TABLE [dbo].[ProcedureAnswers] ALTER COLUMN UpdateDate DateTime NOT NULL"

8   ExeStatement = "3030#ALTER TABLE [dbo].[ProcedureQuestionsSub] ADD CreateDate DateTime Null"
    ExeStatement = "3031#ALTER TABLE [dbo].[ProcedureQuestionsSub] ADD UpdateDate DateTime Null"
    ExeStatement = "3032#UPDATE [dbo].[ProcedureQuestionsSub] SET CreateDate = Current_TimeStamp WHERE QuestionID Is Not Null"
    ExeStatement = "3033#ALTER TABLE [dbo].[ProcedureQuestionsSub] ALTER COLUMN CreateDate DateTime NOT NULL"
    ExeStatement = "3034#UPDATE [dbo].[ProcedureQuestionsSub] SET UpdateDate = Current_TimeStamp WHERE QuestionID Is Not Null"
    ExeStatement = "3035#ALTER TABLE [dbo].[ProcedureQuestionsSub] ALTER COLUMN UpdateDate DateTime NOT NULL"

    '01st April 2008, Tuesday
9   ExeStatement = "3036#ALTER TABLE [dbo].[ProcedureAnswers] DROP COLUMN CreateDate"
    ExeStatement = "3037#ALTER TABLE [dbo].[ProcedureAnswers] DROP COLUMN UpdateDate"
    ExeStatement = "3038#ALTER TABLE [dbo].[ProcedureQuestionsSub] DROP COLUMN CreateDate"
    ExeStatement = "3039#ALTER TABLE [dbo].[ProcedureQuestionsSub] DROP COLUMN UpdateDate"

10  ExeStatement = "3040#DROP TABLE [dbo].[Notes]"
    ExeStatement = "3041#CREATE TABLE [dbo].[Notes] ([NoteNo] [varchar] (25) NOT NULL , [PeriodID] [smallint] NOT NULL , " & _
                   "[Description] [varchar] (200) NULL , [CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL , " & _
                   "[CreateDate] [smalldatetime] NOT NULL , [UpdateDate] [smalldatetime] NOT NULL) ON [PRIMARY]"
    ExeStatement = "3042#ALTER TABLE [dbo].[Notes] ADD CONSTRAINT [PK_Notes] PRIMARY KEY  CLUSTERED ([NoteNo], [PeriodID]) ON [PRIMARY]"
    ExeStatement = "3043#ALTER TABLE [dbo].[Notes] ADD CONSTRAINT [FK_Notes_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '03rd April 2008, Thursday
    ExeStatement = "3044#CREATE TABLE [dbo].[LastUpdatedDetails] (TableName varchar(20) NOT NULL, LastUpdatedDate datetime NULL, CONSTRAINT PK_TableName PRIMARY KEY CLUSTERED (TableName))"
    ExeStatement = "3045#ALTER TABLE [dbo].[LastUpdatedDetails] ALTER COLUMN TableName varchar(30) NOT NULL"

    '06th April 2008, Sunday
11  ExeStatement = "3046#CREATE TABLE [dbo].[ReviewSubSections] ([SubSectionID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [ChkReview] [bit] NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [CreateDate] [datetime] NOT NULL , [UpdateUser] [smallint] NOT NULL , [UpdateDate] [DateTime] NOT NULL) ON [PRIMARY]"
    ExeStatement = "3047#ALTER TABLE [dbo].[ReviewSubSections] ADD CONSTRAINT [PK_ReviewSubSections] PRIMARY KEY  CLUSTERED ([SubSectionID], [PeriodID]) ON [PRIMARY]"
    ExeStatement = "3048#ALTER TABLE [dbo].[ReviewSubSections] ADD CONSTRAINT [FK_ReviewSubSections_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] " & _
                   "([SubSectionID]), CONSTRAINT [FK_ReviewSubSections_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

12  ExeStatement = "3049#ALTER TABLE [dbo].[Remarks] ADD PeriodID [smallint] Null"
    ExeStatement = "3050#Update [dbo].[Remarks] SET PeriodID = 46 Where SubSectionID Is Not Null"
    ExeStatement = "3051#ALTER TABLE [dbo].[Remarks] ALTER COLUMN PeriodID [smallint] NOT NULL"
    ExeStatement = "3052#ALTER TABLE [dbo].[Remarks] ADD CONSTRAINT [FK_Remarks_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '08th April 2008, Tuesday
13  ExeStatement = "3053#DROP TABLE [dbo].[Notes]"
    ExeStatement = "3054#CREATE TABLE [dbo].[Notes] ([NoteNo] [varchar] (25) NOT NULL , [PeriodID] [smallint] NOT NULL , [Description] [varchar] (200) NOT NULL , " & _
                   "[CreateDate] [datetime] NOT NULL , [UpdateDate] [datetime] NOT NULL, [CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL) ON [PRIMARY]"
    ExeStatement = "3055#ALTER TABLE [dbo].[Notes] ADD CONSTRAINT [PK_Notes] PRIMARY KEY  CLUSTERED ([NoteNo], [PeriodID], [Description]) ON [PRIMARY]"
    ExeStatement = "3056#ALTER TABLE [dbo].[Notes] ADD CONSTRAINT [FK_Notes_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '10th April 2008, Thursday
14  ExeStatement = "3057#CREATE TABLE [dbo].[VersionDetails] ([VersionNo] [smallint] NOT NULL , [VersionDetails] [varchar] (5000)  NOT NULL , [UpdateDate] [DateTime] NOT NULL) ON [PRIMARY]"
    ExeStatement = "3058#ALTER TABLE [dbo].[VersionDetails] ADD CONSTRAINT [PK_Version Details] PRIMARY KEY  CLUSTERED ([VersionNo]) ON [PRIMARY]"
    
    '13th April 2008, Sunday
15  ExeStatement = "3059#ALTER TABLE [dbo].[VersionDetails] DROP CONSTRAINT [PK_Version Details]"
    ExeStatement = "3060#ALTER TABLE [dbo].[VersionDetails] ALTER COLUMN VersionNo [varchar] (50) NOT NULL"
    ExeStatement = "3061#ALTER TABLE [dbo].[VersionDetails] ADD CONSTRAINT [PK_VersionDetails] PRIMARY KEY  CLUSTERED ([VersionNo]) ON [PRIMARY]"
    ExeStatement = "3062#ALTER TABLE [dbo].[VersionDetails] ADD OrderField [smallint] Null"
    
    '16th April 2008, Wednesday
17  ExeStatement = "3063#ALTER TABLE [dbo].[Notes] DROP CONSTRAINT [PK_Notes]"
    ExeStatement = "3064#ALTER TABLE [dbo].[Notes] ADD CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED ([NoteNo], [PeriodID])"

    '26th April 2008, Saturday
18  ExeStatement = "3065#ALTER TABLE [dbo].[ReviewSubSections] ADD CONSTRAINT [FK_ReviewSubSections_Users] FOREIGN KEY ([CreateUser]) REFERENCES [dbo].[Users] ([UserID])"

    '29th April 2008, Tuesday
19  ExeStatement = "3066#ALTER TABLE [dbo].[VersionDetails] ADD RefNo Varchar(100) Null"

20  '13 July 2008, Sunday
    ExeStatement = "3067#ALTER TABLE [dbo].[Remarks] DROP CONSTRAINT PK_Remarks"
    ExeStatement = "3068#ALTER TABLE [dbo].[Remarks] ADD CONSTRAINT [PK_Remarks] PRIMARY KEY CLUSTERED ([RemarkId], [SubSectionID], [PeriodID])"

    '14 July 2008, Monday
21  ExeStatement = "3069#ALTER TABLE [dbo].[AuditReportObjects] DROP CONSTRAINT FK_AuditReportObjects_AcTypes"

   '22 July 2008, Tuesday
22  ExeStatement = "3070#ALTER TABLE [dbo].[EntrySubAccounts] DROP CONSTRAINT PK_EntrySubAccounts"
    ExeStatement = "3071#ALTER TABLE [dbo].[EntrySubAccounts] DROP CONSTRAINT FK_EntrySubAccounts_Entries"
    ExeStatement = "3072#ALTER TABLE [dbo].[Entries] DROP CONSTRAINT PK_Entries"

    ExeStatement = "3073#ALTER TABLE [dbo].[EntrySubAccounts] ALTER COLUMN EntryID int"
    ExeStatement = "3074#ALTER TABLE [dbo].[EntrySubAccounts] ALTER COLUMN EntryID int NOT NULL"
    ExeStatement = "3075#ALTER TABLE [dbo].[Entries] ALTER COLUMN EntryID int"
    ExeStatement = "3076#ALTER TABLE [dbo].[Entries] ALTER COLUMN EntryID int NOT NULL"
    ExeStatement = "3077#ALTER TABLE [dbo].[EntrySubAccounts] ADD CONSTRAINT PK_EntrySubAccounts PRIMARY KEY CLUSTERED (EntryID,AcSlNo)"
    ExeStatement = "3078#ALTER TABLE [dbo].[Entries] ADD CONSTRAINT PK_Entries PRIMARY KEY CLUSTERED (EntryID)"
    ExeStatement = "3079#ALTER TABLE [dbo].[EntrySubAccounts] ADD CONSTRAINT [FK_EntrySubAccounts_Entries] FOREIGN KEY ([EntryID]) REFERENCES [dbo].[Entries] ([EntryID])"

23  '30 October 2008, Thursday
    ExeStatement = "3080#ALTER TABLE [dbo].[Users] ALTER COLUMN Password [varchar] (500) NOT NULL"

    '13 January 2009, Tuesday
24  ExeStatement = "3081#CREATE TABLE [dbo].[Rules] ([RuleID] [varchar] (50) NOT NULL , [Description] [varchar] (5000) NOT NULL) ON [PRIMARY]"
    ExeStatement = "3082#ALTER TABLE [dbo].[Rules] ADD CONSTRAINT [PK_Rules] PRIMARY KEY  CLUSTERED ([RuleID])  ON [PRIMARY]"

    '19 January 2009, Monday
25  ExeStatement = "3083#ALTER TABLE [dbo].[FilingAccountRemarks] ADD ProcedureID int NULL"

    '14 February 2009, Saturday
26  ExeStatement = "3084#CREATE TABLE [dbo].[LockedObjects] ([LockID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [ObjectID] [smallint] NOT NULL , [IsLocked] [bit] NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [CreateDate] [smalldatetime] NOT NULL , [UpdateUser] [smallint] NULL , [UpdateDate] [smalldatetime] NULL ) ON [PRIMARY]"
    ExeStatement = "3085#ALTER TABLE [dbo].[LockedObjects] ADD CONSTRAINT [PK_LockedObjects] PRIMARY KEY  CLUSTERED ([LockID], [PeriodID], [ObjectID]) ON [PRIMARY]"
    ExeStatement = "3086#ALTER TABLE [dbo].[LockedObjects] ADD CONSTRAINT [FK_LockedObjects_ConsoleRootObjects] FOREIGN KEY ([ObjectID]) REFERENCES [dbo].[ConsoleRootObjects] ([ObjectID]), " & _
                   "CONSTRAINT [FK_LockedObjects_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

27  ExeStatement = "3087#ALTER TABLE [dbo].[FilingAccountRemarks] DROP CONSTRAINT PK_FilingAccountRemarks"
    ExeStatement = "3088#ALTER TABLE [dbo].[FilingAccountRemarks] ALTER COLUMN RemarkID int"
    ExeStatement = "3089#ALTER TABLE [dbo].[FilingAccountRemarks] ALTER COLUMN RemarkID int NOT NULL"
    ExeStatement = "3090#ALTER TABLE [dbo].[FilingAccountRemarks] ADD CONSTRAINT PK_FilingAccountRemarks PRIMARY KEY CLUSTERED ([RemarkID])"

28  ExeStatement = "3091#ALTER TABLE [dbo].[Reviews] DROP CONSTRAINT PK_Reviews"
    ExeStatement = "3092#ALTER TABLE [dbo].[Reviews] ALTER COLUMN ReviewID int"
    ExeStatement = "3093#ALTER TABLE [dbo].[Reviews] ALTER COLUMN ReviewID int NOT NULL"
    ExeStatement = "3094#ALTER TABLE [dbo].[Reviews] ADD CONSTRAINT PK_Reviews PRIMARY KEY CLUSTERED ([ReviewID])"

    '16 March 2009, Monday
29  ExeStatement = "3095#ALTER TABLE [dbo].[Remarks] ALTER COLUMN Observations [varchar] (1000) NULL"
    ExeStatement = "3096#ALTER TABLE [dbo].[Remarks] ALTER COLUMN Actions [varchar] (500) NULL"

    '25 March 2009, Wednesday
30  ExeStatement = "3097#ALTER TABLE [dbo].[CashFlowDetails] DROP CONSTRAINT PK_CashFlowDetails"
    ExeStatement = "3098#ALTER TABLE [dbo].[CashFlowDetails] ALTER COLUMN CashFlowID int"
    ExeStatement = "3099#ALTER TABLE [dbo].[CashFlowDetails] ALTER COLUMN CashFlowID int NOT NULL"
    ExeStatement = "3100#ALTER TABLE [dbo].[CashFlowDetails] ADD CONSTRAINT PK_CashFlowDetails PRIMARY KEY CLUSTERED ([PeriodID], [CashFlowID])"

    '13 April 2009, Monday
31  ExeStatement = "3101#Update [dbo].[FilingAccountRemarks] SET AcTypeID = Null Where AcTypeID = 0"
    ExeStatement = "3102#Update [dbo].[FilingAccountRemarks] SET AcID = Null Where AcID = 0"

    ExeStatement = "3103#ALTER TABLE [dbo].[FilingAccountRemarks] ADD  CONSTRAINT [FK_FilingAccountRemarks_AcHeads] FOREIGN KEY ([AcID]) REFERENCES [dbo].[AcHeads] ([AcID])"
    ExeStatement = "3104#ALTER TABLE [dbo].[FilingAccountRemarks] ADD  CONSTRAINT [FK_FilingAccountRemarks_AcTypes] FOREIGN KEY ([AcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID])"

    '30 April 2009, Thursday
32  ExeStatement = "3105#CREATE TABLE [dbo].[FilingBalSheetRemarks] ([RemarkID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[AcTypeID] [int] NOT NULL , [Description] [varchar] (1000) NULL , [CreateDate] [smalldatetime] NULL , [UpdateDate] [smalldatetime] NOT NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL ) ON [PRIMARY]"
    ExeStatement = "3106#ALTER TABLE [dbo].[FilingBalSheetRemarks] ADD CONSTRAINT [PK_FilingBalSheetRemarks] PRIMARY KEY  CLUSTERED ([RemarkID])  ON [PRIMARY]"
    ExeStatement = "3107#ALTER TABLE [dbo].[FilingBalSheetRemarks] ADD CONSTRAINT [FK_FilingBalSheetRemarks_AcTypes] FOREIGN KEY ([AcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID])"
    ExeStatement = "3108#ALTER TABLE [dbo].[FilingBalSheetRemarks] ADD CONSTRAINT [FK_FilingBalSheetRemarks_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "3109#ALTER TABLE [dbo].[FilingBalSheetRemarks] ADD CONSTRAINT [FK_FilingBalSheetRemarks_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID])"

33  '2 May 2009, Saturday
    ExeStatement = "3110#CREATE TABLE [dbo].[FilingIncomeRemarks] ([RemarkID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[AcTypeID] [int] NOT NULL , [Description] [varchar] (1000) NULL , [CreateDate] [smalldatetime] NULL , [UpdateDate] [smalldatetime] NOT NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL ) ON [PRIMARY]"
    ExeStatement = "3111#ALTER TABLE [dbo].[FilingIncomeRemarks] ADD CONSTRAINT [PK_FilingIncomeRemarks] PRIMARY KEY  CLUSTERED ([RemarkID])  ON [PRIMARY]"
    ExeStatement = "3112#ALTER TABLE [dbo].[FilingIncomeRemarks] ADD CONSTRAINT [FK_FilingIncomeRemarks_AcTypes] FOREIGN KEY ([AcTypeID]) REFERENCES [dbo].[AcTypes] ([AcTypeID])"
    ExeStatement = "3113#ALTER TABLE [dbo].[FilingIncomeRemarks] ADD CONSTRAINT [FK_FilingIncomeRemarks_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "3114#ALTER TABLE [dbo].[FilingIncomeRemarks] ADD CONSTRAINT [FK_FilingIncomeRemarks_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID])"

34  ExeStatement = "3115#CREATE TABLE [dbo].[FilingLiquidityRemarks] ([RemarkID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[LiquidityID] [smallint] NOT NULL , [Description] [varchar] (1000) NULL , [CreateDate] [smalldatetime] NULL , [UpdateDate] [smalldatetime] NOT NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL ) ON [PRIMARY]"
    ExeStatement = "3116#ALTER TABLE [dbo].[FilingLiquidityRemarks] ADD CONSTRAINT [PK_FilingLiquidityRemarks] PRIMARY KEY  CLUSTERED ([RemarkID])  ON [PRIMARY]"
    ExeStatement = "3118#ALTER TABLE [dbo].[FilingLiquidityRemarks] ADD CONSTRAINT [FK_FilingLiquidityRemarks_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "3119#ALTER TABLE [dbo].[FilingLiquidityRemarks] ADD CONSTRAINT [FK_FilingLiquidityRemarks_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID])"

35  ExeStatement = "3120#CREATE TABLE [dbo].[FilingProfitabilityRemarks] ([RemarkID] [int] NOT NULL , [PeriodID] [smallint] NOT NULL , [SubSectionID] [smallint] NOT NULL , " & _
                   "[ProfitabilityID] [smallint] NOT NULL , [Description] [varchar] (1000) NULL , [CreateDate] [smalldatetime] NULL , [UpdateDate] [smalldatetime] NOT NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [UpdateUser] [smallint] NOT NULL ) ON [PRIMARY]"
    ExeStatement = "3121#ALTER TABLE [dbo].[FilingProfitabilityRemarks] ADD CONSTRAINT [PK_FilingProfitabilityRemarks] PRIMARY KEY  CLUSTERED ([RemarkID])  ON [PRIMARY]"
    ExeStatement = "3122#ALTER TABLE [dbo].[FilingProfitabilityRemarks] ADD CONSTRAINT [FK_FilingProfitabilityRemarks_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"
    ExeStatement = "3123#ALTER TABLE [dbo].[FilingProfitabilityRemarks] ADD CONSTRAINT [FK_FilingProfitabilityRemarks_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID])"

    '01 September 2009, Tuesday
'36  ExeStatement = "3124#CREATE TABLE [dbo].[ReviewLeadSheet] ([SubSectionID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [AcTypeID] [int] NULL , [AcID] [int] NULL , [Reviewed] [bit] NULL , " & _
'                   "[CreateUser] [smallint] NOT NULL , [CreateDate] [datetime] NOT NULL , [UpdateUser] [smallint] NOT NULL , [UpdateDate] [DateTime] NOT NULL) ON [PRIMARY]"
'    ExeStatement = "3125#ALTER TABLE [dbo].[ReviewLeadSheet] ADD CONSTRAINT [PK_ReviewLeadSheet] PRIMARY KEY  CLUSTERED ([SubSectionID], [PeriodID])  ON [PRIMARY]"
'    ExeStatement = "3126#ALTER TABLE [dbo].[ReviewLeadSheet] ADD CONSTRAINT [FK_ReviewLeadSheet_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID]), " & _
'                   "CONSTRAINT [FK_ReviewLeadSheet_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '06 February 2010, Saturday
37  ExeStatement = "3127#ALTER Table [dbo].[Reviews] ADD SignedOff Bit NULL"
    ExeStatement = "3128#ALTER Table [dbo].[Reviews] ADD SignedBy Varchar(50) NULL"

    '23 February 2010, Tuesday
38  ExeStatement = "3129:1#ALTER TABLE [dbo].[DocumentBin] ADD DocumentType Bit NULL"
    ExeStatement = "3130:1#UPDATE [dbo].[DocumentBin] SET DocumentType = 0 WHERE DocumentID IS NOT NULL"
    ExeStatement = "3131:1#ALTER TABLE [dbo].[DocumentBin] ALTER COLUMN DocumentType Bit NOT NULL"

    '27 February 2010, Friday
39  ExeStatement = "3132#ALTER TABLE [dbo].[Periods] ADD Signedoff Bit NULL"
    ExeStatement = "3133#ALTER TABLE [dbo].[Periods] ADD AuditFile Bit NULL"
    
40  ExeStatement = "3134#CREATE TABLE [dbo].[Userlog] ([UserID] [smallint] NULL , [RecordedTime] [DateTime] NULL , " & _
                   "[CompanyID] [smallint] NULL , [PeriodID] [smallint] NULL , [IDNO] [numeric](18, 0) IDENTITY (1, 1) NOT NULL)  ON [PRIMARY]"
    ExeStatement = "3135#ALTER TABLE [dbo].[Userlog] ADD CONSTRAINT [FK_Userlog_Companies] FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Companies] ([CompanyID])"
    ExeStatement = "3136#ALTER TABLE [dbo].[Userlog] ADD CONSTRAINT [FK_Userlog_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

41  ExeStatement = "3137#CREATE TRIGGER [UpdateDate] ON [dbo].[Userlog] FOR INSERT AS " & _
                   "UPDATE Userlog SET RECORDEDTIME = GETDATE() FROM USERLOG, INSERTED WHERE Userlog.IDNO = INSERTED.IDNO"

    '01 March 2010, Monday
42  ExeStatement = "3138#ALTER TABLE [dbo].[AuditReportObjects] ADD DraftIssued Bit NULL"
    ExeStatement = "3139#ALTER TABLE [dbo].[AuditReportObjects] ADD FinalIssued Bit NULL"
    ExeStatement = "3140#ALTER TABLE [dbo].[AuditReportObjects] ADD DraftIssuedDate smalldatetime NULL"
    ExeStatement = "3141#ALTER TABLE [dbo].[AuditReportObjects] ADD FinalIssuedDate smalldatetime NULL"
    ExeStatement = "3142#ALTER TABLE [dbo].[AuditReportObjects] ADD DraftIssuedUser smallint NULL"
    ExeStatement = "3143#ALTER TABLE [dbo].[AuditReportObjects] ADD FinalIssuedUser smallint NULL"

    '05 April 2010, Monday
43  ExeStatement = "3144#CREATE TABLE [dbo].[AuditInformation] ([InfoID] [varchar] (50) NOT NULL , [PeriodID] [smallint] NOT NULL , [AcTypeID] [int] NULL , " & _
                   "[AcID] [int] NULL , [Particulars] [varchar] (100) NOT NULL , [ThisYrTB] [float] NULL , [ThisYrAmt] [float] NULL , " & _
                   "[LastYrTB] [float] NULL , [LastYrAmt] [float] NULL , [IsBold] [bit] NULL) ON [PRIMARY]"
    ExeStatement = "3145#ALTER TABLE [dbo].[AuditInformation] ADD CONSTRAINT [PK_AuditInformation] PRIMARY KEY  CLUSTERED ([InfoID], [PeriodID]) ON [PRIMARY]"
    ExeStatement = "3146#ALTER TABLE [dbo].[AuditInformation] ADD CONSTRAINT [FK_AuditInformation_AcTypes] FOREIGN KEY ([AcTypeID]) " & _
                   "REFERENCES [dbo].[AcTypes] ([AcTypeID]), CONSTRAINT [FK_AuditInformation_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '17 April 2010, Saturday
44  ExeStatement = "3147#ALTER TABLE [dbo].[FilingAccountRemarks] DROP CONSTRAINT FK_FilingAccountRemarks_AcHeads"
    ExeStatement = "3148#ALTER TABLE [dbo].[FilingAccountRemarks] DROP CONSTRAINT FK_FilingAccountRemarks_AcTypes"

45  ExeStatement = "3149#CREATE TABLE [dbo].[ReviewLeadSheet] ([ReviewID] [int] NOT NULL, [SubSectionID] [smallint] NOT NULL , [PeriodID] [smallint] NOT NULL , [AcTypeID] [int] NULL , [AcID] [int] NULL , [Reviewed] [bit] NULL , " & _
                   "[CreateUser] [smallint] NOT NULL , [CreateDate] [datetime] NOT NULL , [UpdateUser] [smallint] NOT NULL , [UpdateDate] [DateTime] NOT NULL) ON [PRIMARY]"
    ExeStatement = "3150#ALTER TABLE [dbo].[ReviewLeadSheet] ADD CONSTRAINT [PK_ReviewLeadSheet] PRIMARY KEY  CLUSTERED ([ReviewID], [SubSectionID], [PeriodID])  ON [PRIMARY]"
    ExeStatement = "3151#ALTER TABLE [dbo].[ReviewLeadSheet] ADD CONSTRAINT [FK_ReviewLeadSheet_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID]), " & _
                   "CONSTRAINT [FK_ReviewLeadSheet_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

    '05 May 2010, Wednesday
46  ExeStatement = "3152#ALTER TABLE [dbo].[AuditInformation] ADD Treelevel tinyint NULL"
    ExeStatement = "3153#ALTER TABLE [dbo].[AuditInformation] ADD IsTotal bit NULL"

    '18 May 2010, Tuesday
47  ExeStatement = "3154#ALTER TABLE [dbo].[FilingSubSection] ADD TrialOrder tinyint NULL"

    '19 May 2010, Wednesday
48  ExeStatement = "3155#ALTER TABLE [dbo].[AcTypes] ADD AcTypeDescription varchar(100) NULL"

49  ExeStatement = "3156#ALTER TABLE [dbo].[AcTypes] ADD ActualAcTypeID int NULL"

    '28 July 2010, Wednesday
50  ExeStatement = "3157#CREATE TABLE [dbo].[Resources]([ResourceID] [smallint] NOT NULL, [ResourceName] [varchar](100) NOT NULL, [TemplateFile] [image] NOT NULL, " & _
                   "[SectionID] [smallint] NOT NULL, [SubSectionID] [smallint] NOT NULL, [CreateDate] [smalldatetime] NOT NULL, [UpdateDate] [smalldatetime] NOT NULL, " & _
                   "[CreateUser] [smallint] NOT NULL, [UpdateUser] [smallint] NOT NULL, CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED ([ResourceID]) ON [PRIMARY])"

    '16 August 2010, Monday
51  ExeStatement = "3158:1#ALTER TABLE [dbo].[DocumentBin] ADD DocSize varchar(100) NULL"

    '13 October 2010, Wednesday
52  ExeStatement = "3159:1#ALTER TABLE [dbo].[DocumentBin] ADD IsResource bit NULL"

53  ExeStatement = "3160#ALTER TABLE [dbo].[DocumentSubLinks] ADD ResourceID smallint NULL"

    '18 October 2010, Monday
54  ExeStatement = "3161#ALTER TABLE [dbo].[AcHeads] DROP CONSTRAINT PK_AcHeads"
    ExeStatement = "3162#ALTER TABLE [dbo].[AcHeads] ADD CONSTRAINT  PK_AcHeads PRIMARY KEY CLUSTERED ([AcID], [CompanyID])"

    '12 December 2010, Sunday
'55  ExeStatement = "3163#CREATE TABLE [dbo].[LegalDocDetails]([LegalDocID] [smallint] NOT NULL, [SubSectionID] [smallint] NOT NULL, " & _
'                   "[PeriodID] [smallint] NOT NULL, [Particulars] [varchar](1000) NOT NULL, [DocFile] [image] NULL, [FileName] [varchar](200) NULL, " & _
'                   "[CreateUser] [smallint] NOT NULL, [CreateDate] [smalldatetime] NOT NULL, [UpdateUser] [smallint] NOT NULL, [UpdateDate] [smalldatetime] NOT NULL, " & _
'                   "CONSTRAINT [PK_LegalDocDetails] PRIMARY KEY CLUSTERED ([LegalDocID], [SubSectionID], [PeriodID]) ON [PRIMARY])"
'    ExeStatement = "3164#ALTER TABLE [dbo].[LegalDocDetails] ADD CONSTRAINT [FK_LegalDocDetails_FilingSubSection] FOREIGN KEY ([SubSectionID]) REFERENCES [dbo].[FilingSubSection] ([SubSectionID]), " & _
'                   "CONSTRAINT [FK_LegalDocDetails_Periods] FOREIGN KEY ([PeriodID]) REFERENCES [dbo].[Periods] ([PeriodID])"

56  ExeStatement = "3165#ALTER TABLE [dbo].[DocumentSubLinks] ADD LegalDocID smallint NULL"

    '15 December 2010, Wednesday
57  ExeStatement = "3166#ALTER TABLE [dbo].[DocumentSubLinks] ADD Remarks varchar(1000) NULL"

    '18 January 2011, Tuesday
58  ExeStatement = "3167#ALTER TABLE [dbo].[ProcedureQuestions] ALTER COLUMN Question varchar(1200) NOT NULL"
    ExeStatement = "3168#DELETE FROM [dbo].[SubSectionProcedures] Where SubSectionID = 32"
    ExeStatement = "3169#DELETE FROM [dbo].[ReviewSubSections] Where SubSectionID = 32"
    ExeStatement = "3170#DELETE FROM [dbo].[ProcedureQuestionsSub] Where SubSectionID = 32"
    ExeStatement = "3171#DELETE FROM [dbo].[FilingSubSection] Where SubSectionID = 32"

    '30 January 2011, Sunday
59  ExeStatement = "3172#ALTER TABLE [dbo].[EntrySubAccounts] DROP CONSTRAINT FK_EntrySubAccounts_AcHeads"
    ExeStatement = "3173#ALTER TABLE [dbo].[LiabilitySchedules] DROP CONSTRAINT FK_LiabilitySchedules_AcHeads"
    ExeStatement = "3174#ALTER TABLE [dbo].[AcHeads] DROP CONSTRAINT PK_AcHeads"
    ExeStatement = "3175#ALTER TABLE [dbo].[AcHeads] ADD  CONSTRAINT PK_AcHeads PRIMARY KEY CLUSTERED ([AcID], [CompanyID]) ON [PRIMARY]"

'28     August 2011, Sunday
'60  ExeStatement = "3176#ALTER TABLE [dbo].[Periods] ADD FinalisedBy varchar(50) NULL"
'    ExeStatement = "3177#ALTER TABLE [dbo].[Periods] ADD FinalisedDate smallDateTime NULL"

    Screen.MousePointer = vbDefault
End Sub

Public Property Let ExeStatement(strStatement As String)
On Local Error Resume Next
Dim sSql As String, lngStatementID As Long, strTmp As String, IsDoc As Boolean
    strTmp = Mid(strStatement, 1, InStr(1, strStatement, "#"))
    lngStatementID = Val(Mid(strTmp, 1, InStr(1, strTmp, ":")))
    If lngStatementID = 0 Then
        lngStatementID = Val(Mid(strTmp, 1, InStr(1, strTmp, "#")))
    End If
    If InStr(1, strTmp, ":") <> 0 Then
        IsDoc = True
    End If
    strStatement = Mid(strStatement, InStr(1, strStatement, "#") + 1)
    If lngStatementID <> 0 Then
        sSql = "Select Count(*)AS Num from Statements Where StatementID = " & lngStatementID & " And IsExcecuted = 1"
        With AdoConn.Execute(sSql)
            If .Fields("Num") = 0 Then
                Err.Clear
                'Excecuting Statements
                If Not IsDoc Then
                    AdoConn.Execute strStatement
                Else
                    AdoConnDoc.Execute strStatement
                End If
                If Err.Number = 0 Then
                    AdoConn.Execute "Insert InTo Statements Values(" & lngStatementID & ", 1)"
                End If
            End If
            .Close
        End With
        sSql = "Select Count(*)AS Num from Statements Where StatementID = " & lngStatementID & " And IsExcecuted = 1"
        With AdoConnBak.Execute(sSql)
            If .Fields("Num") = 0 Then
                Err.Clear
                'Excecuting Statements
                If Not IsDoc Then
                    AdoConnBak.Execute strStatement
                Else
                    AdoConnDocBak.Execute strStatement
                End If
                If Err.Number = 0 Then
                    AdoConnBak.Execute "Insert InTo Statements Values (" & lngStatementID & ", 1)"
                End If
            End If
            .Close
        End With
        sSql = "Select Count(*)AS Num from Statements Where StatementID = " & lngStatementID & " And IsExcecuted = 1"
        With AdoConnLocalMainBak.Execute(sSql)
            If .Fields("Num") = 0 Then
                Err.Clear
                'Excecuting Statements
                If Not IsDoc Then
                    AdoConnLocalMainBak.Execute strStatement
                Else
                    AdoConnLocalDocBak.Execute strStatement
                End If
                If Err.Number = 0 Then
                    AdoConnLocalMainBak.Execute "Insert InTo Statements Values (" & lngStatementID & ", 1)"
                End If
            End If
            .Close
        End With
    End If
End Property
