CREATE function [dbo].[EnquiryPayments_CheckIfPaymentDeposit](@EnquiryId bigint) returns bit

as begin
if (select sum(Amount) from EnquiryPayments 
where IsDeposit=1 and  FKEnquiry_Id=@EnquiryId and IsAcceptFromManger=1) > 0
return 1;
return 0
end 
GO
/****** Object:  UserDefinedFunction [dbo].[EnquiryPayments_TotalPayments]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[EnquiryPayments_TotalPayments](@EnquiryId bigint) returns decimal(18,2)

as begin
return (select sum(Amount) from EnquiryPayments where FKEnquiry_Id=@EnquiryId)
end 
GO
/****** Object:  UserDefinedFunction [dbo].[EnquiryPayments_TotalPaymentsActive]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[EnquiryPayments_TotalPaymentsActive](@EnquiryId bigint) returns decimal(18,2)

as begin
return (select sum(Amount) from EnquiryPayments where FKEnquiry_Id=@EnquiryId and IsAcceptFromManger=1)
end 
GO
/****** Object:  UserDefinedFunction [dbo].[Events_CheckIfWorkFinshed]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Events_CheckIfWorkFinshed](@eventId bigint, @workTypeId int,@UserId bigint)returns bit
as begin

if((select top 1 count(*) from EventWorksStatusHistory 
where FKEvent_Id=@eventId and FKWorkType_Id=@workTypeId and IsFinshed=1 and FKUsre_Id=@UserId )>0)
return 1;

return 0

end 
GO
/****** Object:  UserDefinedFunction [dbo].[EventWorksStatusIsFinsed_CheckIfFinshedFun]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[EventWorksStatusIsFinsed_CheckIfFinshedFun](@eventId bigint,@workTypeId int) returns bit
as begin
/* Works Types
	Booking                =1  , DataPerfection         =2  ,
	Coordination           =3  , Implementation         =4  ,
	ArchivingAndSaveing    =5  , ProductProcessing      =6  ,
	Chooseing              =7  , DigitalProcessing      =8  ,
	PreparingForPrinting   =9  , Manufacturing          =10 ,
	QualityAndReview       =11 , Packaging              =12 ,
	TransmissionAndDelivery=13 , Archiving              =14 ,*/

	 
if(@WorkTypeId = 1)		  return (select top 1 Booking					from EventWorksStatusIsFinshed 	 where EventId=@EventId	)
else if(@WorkTypeId = 2)  return (select top 1 DataPerfection			from EventWorksStatusIsFinshed  where EventId=@EventId	)
else if(@WorkTypeId = 3)  return (select top 1 Coordination				from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 4)  return (select top 1 Implementation			from EventWorksStatusIsFinshed  where EventId=@EventId	)
else if(@WorkTypeId = 5)  return (select top 1 ArchivingAndSaveing		from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 6)  return (select top 1 ProductProcessing		from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 7)  return (select top 1 Chooseing				from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 8)  return (select top 1 DigitalProcessing		from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 9)  return (select top 1 PreparingForPrinting		from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 10) return (select top 1 Manufacturing			from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 11) return (select top 1 QualityAndReview			from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 12) return (select top 1 Packaging				from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 13) return (select top 1 TransmissionAndDelivery	from EventWorksStatusIsFinshed where EventId=@EventId	)
else if(@WorkTypeId = 14) return (select top 1 Archiving				from EventWorksStatusIsFinshed where EventId=@EventId	)
return 0;
end
GO
/****** Object:  UserDefinedFunction [dbo].[GetNotificationsCountIsNotRead]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[GetNotificationsCountIsNotRead](@CuurentUserLoggadId bigint
) returns int
as begin
return (Select ISNULL(Count(Id),0) from NotificationsUser where FKUser_Id=@CuurentUserLoggadId and IsRead=0)
end
GO
/****** Object:  UserDefinedFunction [dbo].[UserPayments_CheckIsClosed]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[UserPayments_CheckIsClosed](@isAcceptFromManger bit , @paymentImage nvarchar(max))returns bit
as begin 
if(
 (@isAcceptFromManger =1 and  @paymentImage is not null) or (@isAcceptFromManger =0))
 return 1; --Return As Closed

 return 0;
end
GO
/****** Object:  Table [dbo].[Words]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Words](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Ar] [nvarchar](max) NULL,
	[En] [nvarchar](max) NULL,
 CONSTRAINT [PK_Words] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkWord_Id] [bigint] NULL,
 CONSTRAINT [PK_AccountTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AccountTypes_Select]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[AccountTypes_Select]
as     
select AccountTypes.*,
Words.Ar,
Words.En 
from AccountTypes
join Words on Words.Id=AccountTypes.FkWord_Id 
  

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[IsoCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CountriesView]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CountriesView]
as 
select Countries.*,Words.Ar,
Words.En from  Countries join Words on Words.Id=Countries.Id
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[FKCountry_Id] [int] NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CitiesView]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CitiesView]
as 
select Cities.*,Words.Ar,
Words.En from  Cities join Words on Words.Id=Cities.Id
GO
/****** Object:  Table [dbo].[AlbumTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_AlbumTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branches]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[FkCountry_Id] [int] NOT NULL,
	[FKCity_Id] [int] NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[IsBasic] [bit] NOT NULL,
	[FKArchivingAndSaveingEmployee_Id] [bigint] NULL,
	[FKImplementationEmployeeId_Id] [bigint] NULL,
	[FKCoordinationEmployee_Id] [bigint] NULL,
	[FKArchivingAndSaveingAnotherBranch_Id] [int] NULL,
 CONSTRAINT [PK_Branches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeDistributionWorks]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeDistributionWorks](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FKWorkType_Id] [int] NOT NULL,
	[FKEmployee_Id] [bigint] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[IsAnotherBranch] [bit] NOT NULL,
	[FKBranch_Id] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeDistributionWorks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeesWorks]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeesWorks](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FkWorkType_Id] [int] NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EmpoyeesWorks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enquires]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enquires](
	[Id] [bigint] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[FkCountry_Id] [int] NOT NULL,
	[FkCity_Id] [int] NOT NULL,
	[FKEnquiryType_Id] [int] NULL,
	[FKUserCreated_Id] [bigint] NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[Day] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[FKBranch_Id] [int] NOT NULL,
	[IsLinkedClinet] [bit] NULL,
	[IsClosed] [bit] NULL,
	[ClosedDateTime] [datetime] NULL,
	[IsWithBranch] [bit] NOT NULL,
	[FkClinet_Id] [bigint] NULL,
	[IsCreatedEvent] [bit] NOT NULL,
	[FKPhoneCountry_Id] [int] NOT NULL,
 CONSTRAINT [PK_EnquiryForms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryPayments]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryPayments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[IsDeposit] [bit] NOT NULL,
	[IsBankTransfer] [bit] NOT NULL,
	[TransferImage] [nvarchar](max) NULL,
	[IsAcceptFromManger] [bit] NULL,
	[DateTime] [datetime] NOT NULL,
	[FKEnquiry_Id] [bigint] NOT NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EnquiryPayments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryStatus]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryStatus](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[DateTime] [datetime] NOT NULL,
	[ScheduleVisitDateTime] [datetime] NULL,
	[FKEnquiry_Id] [bigint] NOT NULL,
	[FKEnquiryStatus_Id] [int] NOT NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
	[FKEnquiryPayment_Id] [bigint] NULL,
	[ScheduleVisitDateClendarEventId] [nvarchar](max) NULL,
 CONSTRAINT [PK_EnquiryStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryStatusTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryStatusTypes](
	[Id] [int] NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EnquiryStatusTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EnquiryTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventArchiveDetails]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventArchiveDetails](
	[Id] [bigint] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[FKEventArchive_Id] [int] NOT NULL,
	[MemoryId] [nvarchar](50) NOT NULL,
	[MemoryType] [nvarchar](50) NOT NULL,
	[PhotoStartName] [nvarchar](50) NOT NULL,
	[PhotoNumberFrom] [int] NOT NULL,
	[PhotoNumberTo] [int] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[DateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EventArchivesDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[FKEvent_Id] ASC,
	[FKEventArchive_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventArchives]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventArchives](
	[Id] [int] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[HardDiskNumber] [nvarchar](50) NOT NULL,
	[FolderName] [nvarchar](50) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EventArchives] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[FKEvent_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventCoordinations]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventCoordinations](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TaskNumber] [int] NOT NULL,
	[Task] [nvarchar](50) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EventCoordination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventPhotographers]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventPhotographers](
	[Id] [bigint] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[FKEvent_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[Id] [bigint] NOT NULL,
	[IsClinetCustomLogo] [bit] NULL,
	[LogoFilePath] [nvarchar](max) NULL,
	[IsNamesAr] [bit] NULL,
	[NameGroom] [nvarchar](50) NULL,
	[NameBride] [nvarchar](50) NULL,
	[FKPrintNameType_Id] [int] NULL,
	[EventDateTime] [datetime] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[FKPackage_Id] [int] NOT NULL,
	[FKClinet_Id] [bigint] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[FKUserCreaed_Id] [bigint] NOT NULL,
	[FKBranch_Id] [int] NOT NULL,
	[ClendarEventId] [nvarchar](max) NULL,
	[PackagePrice] [decimal](18, 2) NOT NULL,
	[PackageNamsArExtraPrice] [decimal](18, 2) NOT NULL,
	[VistToCoordinationDateTime] [datetime] NULL,
	[VistToCoordinationClendarEventId] [nvarchar](max) NULL,
	[NamesPrintingPrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventSurveies]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventSurveies](
	[Id] [bigint] NOT NULL,
	[FKClinet_Id] [bigint] NOT NULL,
	[IsSatisfied] [bit] NOT NULL,
 CONSTRAINT [PK_EventSurveies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventSurveyQuestionAnswerer]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventSurveyQuestionAnswerer](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FKEventSurveyQuestion_Id] [bigint] NOT NULL,
	[Answerer] [nvarchar](max) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[FKSurveyQuestionType_Id] [int] NOT NULL,
	[FKEventSurvey_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EventPoolQuestionAnswers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventSurveyQuestions]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventSurveyQuestions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsDefault] [bit] NULL,
	[FKSurveyQuestionType_Id] [int] NOT NULL,
	[FKEvent_Id] [bigint] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_EventPoolQuestions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventSurveyQuestionTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventSurveyQuestionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[InputType] [int] NULL,
 CONSTRAINT [PK_PoolQuestionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventWorksStatusHistory]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventWorksStatusHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsFinshed] [bit] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
	[FKWorkType_Id] [int] NOT NULL,
	[FKUsre_Id] [bigint] NOT NULL,
	[FKAccountType_Id] [int] NOT NULL,
	[FKBranch_Id] [int] NOT NULL,
 CONSTRAINT [PK_EventWorksStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventWorksStatusIsFinshed]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventWorksStatusIsFinshed](
	[EventId] [bigint] NOT NULL,
	[Booking] [bit] NULL,
	[DataPerfection] [bit] NULL,
	[Coordination] [bit] NULL,
	[Implementation] [bit] NULL,
	[ArchivingAndSaveing] [bit] NULL,
	[ProductProcessing] [bit] NULL,
	[Chooseing] [bit] NULL,
	[DigitalProcessing] [bit] NULL,
	[PreparingForPrinting] [bit] NULL,
	[Manufacturing] [bit] NULL,
	[QualityAndReview] [bit] NULL,
	[Packaging] [bit] NULL,
	[TransmissionAndDelivery] [bit] NULL,
	[Archiving] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilesReceivedTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesReceivedTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_FilesReceivedTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CssClass] [nvarchar](50) NOT NULL,
	[OrderByNumber] [int] NOT NULL,
	[Parent_Id] [int] NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Target_Id] [bigint] NULL,
	[FKPage_Id] [int] NOT NULL,
	[FKUser_Id] [bigint] NULL,
	[FkWord_Id] [bigint] NOT NULL,
	[FKDescriptionWord_Id] [bigint] NOT NULL,
	[RedirectUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationsUser]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationsUser](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FKNotify_Id] [bigint] NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
	[IsRead] [bit] NOT NULL,
 CONSTRAINT [PK_NotificationsUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackageDetails]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[FKPackageInputType_Id] [int] NOT NULL,
	[FKPackage_Id] [int] NOT NULL,
 CONSTRAINT [PK_PackageDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PackageInputTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PackageInputTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_PackageInputTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Packages]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkWordName_Id] [bigint] NOT NULL,
	[IsPrintNamesFree] [bit] NOT NULL,
	[FkWordDescription_Id] [bigint] NOT NULL,
	[FKAlbumType_Id] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[NamsArExtraPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Packages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[Url] [nvarchar](50) NOT NULL,
	[FkMenu_Id] [int] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
	[IsForClient] [bit] NULL,
	[IsForAdmin] [bit] NULL,
	[IsHide] [bit] NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrintNamesTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrintNamesTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_PrintNamesTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialAccountTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialAccountTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_SocialAccountTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPayments]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPayments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[IsAcceptFromManger] [bit] NULL,
	[FKUserTo_Id] [bigint] NOT NULL,
	[FKUserFrom_Id] [bigint] NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[PaymentImage] [nvarchar](max) NULL,
	[IsBankTransfer] [bit] NULL,
 CONSTRAINT [PK_UserPayments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPrivileges]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPrivileges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKPage_Id] [int] NOT NULL,
	[FkUser_Id] [bigint] NOT NULL,
	[CanAdd] [bit] NOT NULL,
	[CanEdit] [bit] NOT NULL,
	[CanDelete] [bit] NOT NULL,
	[CanDisplay] [bit] NOT NULL,
 CONSTRAINT [PK_UserPrivileges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[Password] [nvarchar](50) NOT NULL,
	[ActiveCode] [nvarchar](50) NULL,
	[FKAccountType_Id] [int] NOT NULL,
	[FkCountry_Id] [int] NULL,
	[FkCity_Id] [int] NULL,
	[FKLanguage_Id] [int] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[FKPranch_Id] [int] NULL,
	[IsActiveEmail] [bit] NOT NULL,
	[DateOfBirth] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[FullName] [nvarchar](150) NULL,
	[NationalityNumber] [nvarchar](20) NULL,
	[WebSite] [nvarchar](500) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSocialAccounts]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSocialAccounts](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FKSocialAccountType_Id] [int] NOT NULL,
	[Link] [nvarchar](max) NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_UserSocialAccounts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkTypes]    Script Date: 8/30/2019 7:12:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTypes](
	[Id] [int] NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[PageUrl] [nvarchar](50) NULL,
 CONSTRAINT [PK_WorkTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON 
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (1, 1)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (2, 4)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (3, 5)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (4, 6)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (5, 20180)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (6, 30258)
GO
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (7, 30266)
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[AlbumTypes] ON 
GO
INSERT [dbo].[AlbumTypes] ([Id], [FKWord_Id]) VALUES (10, 20153)
GO
INSERT [dbo].[AlbumTypes] ([Id], [FKWord_Id]) VALUES (12, 30237)
GO
INSERT [dbo].[AlbumTypes] ([Id], [FKWord_Id]) VALUES (13, 40474)
GO
SET IDENTITY_INSERT [dbo].[AlbumTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Branches] ON 
GO
INSERT [dbo].[Branches] ([Id], [Address], [PhoneNo], [FkCountry_Id], [FKCity_Id], [FKWord_Id], [IsBasic], [FKArchivingAndSaveingEmployee_Id], [FKImplementationEmployeeId_Id], [FKCoordinationEmployee_Id], [FKArchivingAndSaveingAnotherBranch_Id]) VALUES (7, N'سي', N'01025249400', 15, 10, 40455, 0, 20057, 20056, 20055, 8)
GO
INSERT [dbo].[Branches] ([Id], [Address], [PhoneNo], [FkCountry_Id], [FKCity_Id], [FKWord_Id], [IsBasic], [FKArchivingAndSaveingEmployee_Id], [FKImplementationEmployeeId_Id], [FKCoordinationEmployee_Id], [FKArchivingAndSaveingAnotherBranch_Id]) VALUES (8, N'سيسي', N'01025249400', 15, 11, 40506, 1, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Branches] OFF
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 
GO
INSERT [dbo].[Cities] ([Id], [FKWord_Id], [FKCountry_Id]) VALUES (10, 30222, 15)
GO
INSERT [dbo].[Cities] ([Id], [FKWord_Id], [FKCountry_Id]) VALUES (11, 30223, 15)
GO
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 
GO
INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (15, 30221, N'02')
GO
INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (16, 40353, N'563')
GO
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeDistributionWorks] ON 
GO
INSERT [dbo].[EmployeeDistributionWorks] ([Id], [FKWorkType_Id], [FKEmployee_Id], [FKEvent_Id], [IsAnotherBranch], [FKBranch_Id]) VALUES (31, 3, 20055, 27, 0, 7)
GO
INSERT [dbo].[EmployeeDistributionWorks] ([Id], [FKWorkType_Id], [FKEmployee_Id], [FKEvent_Id], [IsAnotherBranch], [FKBranch_Id]) VALUES (32, 4, 20056, 27, 0, 7)
GO
INSERT [dbo].[EmployeeDistributionWorks] ([Id], [FKWorkType_Id], [FKEmployee_Id], [FKEvent_Id], [IsAnotherBranch], [FKBranch_Id]) VALUES (33, 5, 20057, 27, 0, 7)
GO
SET IDENTITY_INSERT [dbo].[EmployeeDistributionWorks] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeesWorks] ON 
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (10082, 4, 20056)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (10085, 5, 20057)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (10086, 3, 20055)
GO
SET IDENTITY_INSERT [dbo].[EmployeesWorks] OFF
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (26, N'تجربة من المدير0', N'تجربة من المدير', N'01025249400', 15, 10, 15, 5, CAST(N'2019-08-28T22:26:46.627' AS DateTime), 29, 8, 2019, 7, 0, NULL, NULL, 0, 5, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (27, N'sdsd', N'lklk', N'5010254940', 15, 10, 16, NULL, CAST(N'2019-08-29T20:03:44.717' AS DateTime), 29, 8, 2019, 7, 1, 0, CAST(N'2019-08-29T20:16:57.120' AS DateTime), 1, 20059, 1, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (28, N'fggf', N'df', N'5010254940', 15, 10, NULL, 20059, CAST(N'2019-08-29T22:39:40.733' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (29, N'ww', N'ee', N'5010254940', 15, 10, NULL, 20059, CAST(N'2019-08-29T22:41:24.180' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (30, N'سسي', N'سسي', N'010252494', 15, 10, NULL, 20059, CAST(N'2019-08-29T22:57:03.197' AS DateTime), 31, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (31, N'سيسيسيس', N'سيسيس', N'01013056698', 15, 10, NULL, 20059, CAST(N'2019-08-29T22:58:12.387' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (32, N'يسي', N'سيسي', N'01013056698', 15, 10, NULL, 20059, CAST(N'2019-08-29T23:03:25.073' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (33, N'سششس', N'سسي', N'5010254940', 15, 10, NULL, 20059, CAST(N'2019-08-29T23:03:58.447' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [FkClinet_Id], [IsCreatedEvent], [FKPhoneCountry_Id]) VALUES (34, N'شس', N'شس', N'01013056698', 15, 10, NULL, 20059, CAST(N'2019-08-29T23:06:29.457' AS DateTime), 29, 8, 2019, 7, 1, NULL, NULL, 1, 20059, 0, 16)
GO
SET IDENTITY_INSERT [dbo].[EnquiryPayments] ON 
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10025, CAST(55.00 AS Decimal(18, 2)), 1, 0, NULL, 1, CAST(N'2019-08-29T20:46:11.920' AS DateTime), 27, 20058)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10026, CAST(50.00 AS Decimal(18, 2)), 0, 1, N'/Files/Enquiries/Payments/Imaged7871b9e-434a-4e48-b2c1-24d343d24a2a.jpg', 0, CAST(N'2019-08-29T21:22:15.123' AS DateTime), 27, 20058)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10027, CAST(50.00 AS Decimal(18, 2)), 0, 0, NULL, 1, CAST(N'2019-08-29T21:22:20.430' AS DateTime), 27, 20058)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10028, CAST(55.00 AS Decimal(18, 2)), 0, 0, NULL, 1, CAST(N'2019-08-29T21:23:10.487' AS DateTime), 27, 20058)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10029, CAST(500.00 AS Decimal(18, 2)), 0, 0, NULL, 1, CAST(N'2019-08-29T21:23:19.917' AS DateTime), 27, 20058)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10030, CAST(500.00 AS Decimal(18, 2)), 0, 0, NULL, 1, CAST(N'2019-08-29T21:23:51.910' AS DateTime), 27, 20058)
GO
SET IDENTITY_INSERT [dbo].[EnquiryPayments] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryStatus] ON 
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10056, NULL, CAST(N'2019-08-29T20:16:26.120' AS DateTime), NULL, 27, 1, 20058, NULL, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10057, NULL, CAST(N'2019-08-29T20:16:32.557' AS DateTime), NULL, 27, 2, 20058, NULL, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10059, NULL, CAST(N'2019-08-29T20:19:53.730' AS DateTime), NULL, 27, 1, 5, NULL, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10060, NULL, CAST(N'2019-08-29T20:44:25.597' AS DateTime), NULL, 27, 1, 20058, NULL, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10061, NULL, CAST(N'2019-08-29T20:45:59.513' AS DateTime), NULL, 27, 4, 5, NULL, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id], [ScheduleVisitDateClendarEventId]) VALUES (10062, NULL, CAST(N'2019-08-29T20:46:11.910' AS DateTime), NULL, 27, 7, 20058, 10025, NULL)
GO
SET IDENTITY_INSERT [dbo].[EnquiryStatus] OFF
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (1, 78)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (2, 79)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (3, 80)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (4, 81)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (5, 82)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (6, 92)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (7, 93)
GO
INSERT [dbo].[EnquiryStatusTypes] ([Id], [FKWord_Id]) VALUES (8, 94)
GO
SET IDENTITY_INSERT [dbo].[EnquiryTypes] ON 
GO
INSERT [dbo].[EnquiryTypes] ([Id], [FKWord_Id]) VALUES (7, 42)
GO
INSERT [dbo].[EnquiryTypes] ([Id], [FKWord_Id]) VALUES (8, 43)
GO
INSERT [dbo].[EnquiryTypes] ([Id], [FKWord_Id]) VALUES (9, 44)
GO
INSERT [dbo].[EnquiryTypes] ([Id], [FKWord_Id]) VALUES (15, 30226)
GO
INSERT [dbo].[EnquiryTypes] ([Id], [FKWord_Id]) VALUES (16, 40456)
GO
SET IDENTITY_INSERT [dbo].[EnquiryTypes] OFF
GO
INSERT [dbo].[EventArchiveDetails] ([Id], [FKEvent_Id], [FKEventArchive_Id], [MemoryId], [MemoryType], [PhotoStartName], [PhotoNumberFrom], [PhotoNumberTo], [Notes], [DateTime]) VALUES (1, 24, 1, N'2454', N'54', N'sd', 5, 2, NULL, CAST(N'2019-08-23T23:30:19.390' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[EventCoordinations] ON 
GO
INSERT [dbo].[EventCoordinations] ([Id], [TaskNumber], [Task], [StartTime], [EndTime], [Notes], [FKEvent_Id], [FKUserCreated_Id]) VALUES (2, 1, N'sdsd', CAST(N'11:06:00' AS Time), CAST(N'00:06:00' AS Time), NULL, 27, 20055)
GO
INSERT [dbo].[EventCoordinations] ([Id], [TaskNumber], [Task], [StartTime], [EndTime], [Notes], [FKEvent_Id], [FKUserCreated_Id]) VALUES (3, 2, N'asas', CAST(N'01:00:00' AS Time), CAST(N'01:00:00' AS Time), NULL, 27, 20058)
GO
SET IDENTITY_INSERT [dbo].[EventCoordinations] OFF
GO
INSERT [dbo].[Events] ([Id], [IsClinetCustomLogo], [LogoFilePath], [IsNamesAr], [NameGroom], [NameBride], [FKPrintNameType_Id], [EventDateTime], [CreateDateTime], [FKPackage_Id], [FKClinet_Id], [Notes], [FKUserCreaed_Id], [FKBranch_Id], [ClendarEventId], [PackagePrice], [PackageNamsArExtraPrice], [VistToCoordinationDateTime], [VistToCoordinationClendarEventId], [NamesPrintingPrice]) VALUES (27, NULL, NULL, NULL, N'd55', N'd', 9, CAST(N'2021-08-06T00:00:00.000' AS DateTime), CAST(N'2019-08-29T21:06:35.590' AS DateTime), 6, 20059, NULL, 20058, 7, N'1adr74s1cb28of65ifb439bvm0', CAST(5.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2019-01-01T06:00:00.000' AS DateTime), N'd8k98vacgmnnucm8j98k6el2cg', CAST(500.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[EventSurveyQuestions] ON 
GO
INSERT [dbo].[EventSurveyQuestions] ([Id], [IsDefault], [FKSurveyQuestionType_Id], [FKEvent_Id], [IsActive]) VALUES (7, 1, 4, NULL, 1)
GO
INSERT [dbo].[EventSurveyQuestions] ([Id], [IsDefault], [FKSurveyQuestionType_Id], [FKEvent_Id], [IsActive]) VALUES (8, 1, 3, NULL, 1)
GO
INSERT [dbo].[EventSurveyQuestions] ([Id], [IsDefault], [FKSurveyQuestionType_Id], [FKEvent_Id], [IsActive]) VALUES (9, 1, 5, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[EventSurveyQuestions] OFF
GO
SET IDENTITY_INSERT [dbo].[EventSurveyQuestionTypes] ON 
GO
INSERT [dbo].[EventSurveyQuestionTypes] ([Id], [FKWord_Id], [InputType]) VALUES (3, 30307, 0)
GO
INSERT [dbo].[EventSurveyQuestionTypes] ([Id], [FKWord_Id], [InputType]) VALUES (4, 30308, 0)
GO
INSERT [dbo].[EventSurveyQuestionTypes] ([Id], [FKWord_Id], [InputType]) VALUES (5, 30310, 0)
GO
SET IDENTITY_INSERT [dbo].[EventSurveyQuestionTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[EventWorksStatusHistory] ON 
GO
INSERT [dbo].[EventWorksStatusHistory] ([Id], [IsFinshed], [DateTime], [FKEvent_Id], [FKWorkType_Id], [FKUsre_Id], [FKAccountType_Id], [FKBranch_Id]) VALUES (10024, 1, CAST(N'2019-08-29T22:12:18.350' AS DateTime), 27, 3, 20055, 5, 7)
GO
SET IDENTITY_INSERT [dbo].[EventWorksStatusHistory] OFF
GO
INSERT [dbo].[EventWorksStatusIsFinshed] ([EventId], [Booking], [DataPerfection], [Coordination], [Implementation], [ArchivingAndSaveing], [ProductProcessing], [Chooseing], [DigitalProcessing], [PreparingForPrinting], [Manufacturing], [QualityAndReview], [Packaging], [TransmissionAndDelivery], [Archiving]) VALUES (27, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[FilesReceivedTypes] ON 
GO
INSERT [dbo].[FilesReceivedTypes] ([Id], [FKWord_Id]) VALUES (2, 30317)
GO
INSERT [dbo].[FilesReceivedTypes] ([Id], [FKWord_Id]) VALUES (3, 30318)
GO
SET IDENTITY_INSERT [dbo].[FilesReceivedTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Languages] ON 
GO
INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (1, N'en', N'English')
GO
INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (2, N'ar', N'Arabic')
GO
SET IDENTITY_INSERT [dbo].[Languages] OFF
GO
SET IDENTITY_INSERT [dbo].[Menus] ON 
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (1, N'fas fa-cogs', 1, NULL, 2)
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (2, N'fas fa-users-cog', 2, NULL, 7)
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (3, N'fab fa-wpforms', 3, NULL, 33)
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (4, N'flaticon2-photo-camera
', 5, NULL, 10142)
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (5, N'fas fa-hand-holding-heart', 4, NULL, 20149)
GO
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (6, N'fa fa-chart-line', 1, 4, 30304)
GO
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30144, CAST(N'2019-08-29T20:16:26.157' AS DateTime), 27, 5, 20058, 40457, 40458, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30145, CAST(N'2019-08-29T20:16:32.587' AS DateTime), 27, 5, 20058, 40459, 40460, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30146, CAST(N'2019-08-29T20:16:57.087' AS DateTime), 27, 5, 20058, 40461, 40462, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30147, CAST(N'2019-08-29T20:19:53.787' AS DateTime), 27, 5, 5, 40463, 40464, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30148, CAST(N'2019-08-29T20:44:25.673' AS DateTime), 27, 5, 20058, 40465, 40466, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30149, CAST(N'2019-08-29T20:45:59.567' AS DateTime), 27, 5, 5, 40467, 40468, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30150, CAST(N'2019-08-29T20:46:11.987' AS DateTime), 27, 19, 20058, 40469, 40470, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30151, CAST(N'2019-08-29T20:46:12.037' AS DateTime), 27, 5, 20058, 40471, 40472, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30152, CAST(N'2019-08-29T21:06:37.740' AS DateTime), 27, 12, 20058, 40478, 40479, N'/Enquires/EnquiryInformation?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30153, CAST(N'2019-08-29T21:22:15.247' AS DateTime), 27, 19, 20058, 40480, 40481, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30154, CAST(N'2019-08-29T21:22:20.493' AS DateTime), 27, 19, 20058, 40482, 40483, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30155, CAST(N'2019-08-29T21:23:10.597' AS DateTime), 27, 19, 20058, 40484, 40485, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30156, CAST(N'2019-08-29T21:23:19.987' AS DateTime), 27, 19, 20058, 40486, 40487, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30157, CAST(N'2019-08-29T21:23:51.957' AS DateTime), 27, 19, 20058, 40488, 40489, N'/EnquiryPayments/Payments?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30158, CAST(N'2019-08-29T22:12:18.623' AS DateTime), 27, 5, 20055, 40490, 40491, N'/WorkFlow?id=27&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30159, CAST(N'2019-08-29T22:39:40.807' AS DateTime), 28, 5, 20059, 40492, 40493, N'/Enquires/EnquiryInformation?id=28&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30160, CAST(N'2019-08-29T22:41:24.207' AS DateTime), 29, 5, 20059, 40494, 40495, N'/Enquires/EnquiryInformation?id=29&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30161, CAST(N'2019-08-29T22:57:03.333' AS DateTime), 30, 5, 20059, 40496, 40497, N'/Enquires/EnquiryInformation?id=30&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30162, CAST(N'2019-08-29T22:58:12.413' AS DateTime), 31, 5, 20059, 40498, 40499, N'/Enquires/EnquiryInformation?id=31&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30163, CAST(N'2019-08-29T23:03:25.160' AS DateTime), 32, 5, 20059, 40500, 40501, N'/Enquires/EnquiryInformation?id=32&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30164, CAST(N'2019-08-29T23:03:58.460' AS DateTime), 33, 5, 20059, 40502, 40503, N'/Enquires/EnquiryInformation?id=33&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30165, CAST(N'2019-08-29T23:06:29.560' AS DateTime), 34, 5, 20059, 40504, 40505, N'/Enquires/EnquiryInformation?id=34&notifyId=')
GO
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationsUser] ON 
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30146, 30144, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30147, 30145, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30148, 30146, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30149, 30147, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30150, 30148, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30151, 30149, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30152, 30150, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30153, 30151, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30154, 30152, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30155, 30153, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30156, 30154, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30157, 30155, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30158, 30156, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30159, 30157, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30160, 30158, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30161, 30159, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30162, 30160, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30163, 30161, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30164, 30162, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30165, 30163, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30166, 30164, 20058, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30167, 30165, 20058, 0)
GO
SET IDENTITY_INSERT [dbo].[NotificationsUser] OFF
GO
SET IDENTITY_INSERT [dbo].[PackageDetails] ON 
GO
INSERT [dbo].[PackageDetails] ([Id], [FKWord_Id], [FKPackageInputType_Id], [FKPackage_Id]) VALUES (17, 40383, 9, 5)
GO
SET IDENTITY_INSERT [dbo].[PackageDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[PackageInputTypes] ON 
GO
INSERT [dbo].[PackageInputTypes] ([Id], [FKWord_Id]) VALUES (6, 10099)
GO
INSERT [dbo].[PackageInputTypes] ([Id], [FKWord_Id]) VALUES (9, 30244)
GO
INSERT [dbo].[PackageInputTypes] ([Id], [FKWord_Id]) VALUES (10, 40473)
GO
SET IDENTITY_INSERT [dbo].[PackageInputTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Packages] ON 
GO
INSERT [dbo].[Packages] ([Id], [FkWordName_Id], [IsPrintNamesFree], [FkWordDescription_Id], [FKAlbumType_Id], [Price], [NamsArExtraPrice]) VALUES (5, 40381, 1, 40382, 10, CAST(50.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Packages] ([Id], [FkWordName_Id], [IsPrintNamesFree], [FkWordDescription_Id], [FKAlbumType_Id], [Price], [NamsArExtraPrice]) VALUES (6, 40476, 0, 40477, 10, CAST(5.00 AS Decimal(18, 2)), CAST(1111.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Packages] OFF
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (1, 3, N'/UsersPrivileges', 2, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (2, 12, N'/Users', 2, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (3, 13, N'/Countries', 1, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (4, 34, N'/EnquiryTypes', 3, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (5, 41, N'/Enquires', 3, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (6, 45, N'/Branches', 1, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (7, 50, N'/MyEnquires', 3, 1, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (8, 51, N'/MyEnquires/AddAndUpdate', 3, 2, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (9, 51, N'/Enquires/AddAndUpdate', 3, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (10, 85, N'/', 2, 3, 0, 1, 1)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (11, 10088, N'/PrintNamesTypes', 5, 3, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (12, 10141, N'/Events', 4, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (13, 10141, N'/MyEvents', 4, 1, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (14, 20147, N'/Packages', 5, 4, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (15, 20148, N'/AlbumTypes', 5, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (16, 20150, N'/PackageInputTypes', 5, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (17, 30260, N'/SocialAccountTypes', 1, 5, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (18, 30269, N'/UserPayments/Payments', 2, 4, 0, 1, 1)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (19, 30270, N'/EnquiryPayments/Payments', 3, 4, 0, 1, 1)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (20, 30303, N'/EventSurveyQuestionTypes', 6, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (21, 30309, N'/EventSurveyQuestions', 6, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (22, 30315, N'/FilesReceivedTypes', 1, 4, 0, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[PrintNamesTypes] ON 
GO
INSERT [dbo].[PrintNamesTypes] ([Id], [FKWord_Id], [Price]) VALUES (9, 40384, CAST(500.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[PrintNamesTypes] ([Id], [FKWord_Id], [Price]) VALUES (10, 40475, CAST(55.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[PrintNamesTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[SocialAccountTypes] ON 
GO
INSERT [dbo].[SocialAccountTypes] ([Id], [FKWord_Id]) VALUES (1, 30259)
GO
SET IDENTITY_INSERT [dbo].[SocialAccountTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[UserPayments] ON 
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (20, CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-07-31T23:59:38.367' AS DateTime), 1, 10028, 10020, NULL, N'/Files/Users/Payments/Image1a1ca705-e368-4ce6-821b-ba56072b2f17.JPG', NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (21, CAST(22.00 AS Decimal(18, 2)), CAST(N'2019-08-01T00:02:40.277' AS DateTime), 0, 10028, 10020, N'yyyy', NULL, NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (22, CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-08-01T00:16:24.327' AS DateTime), 1, 10028, 10020, NULL, NULL, 1)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (23, CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-08-01T00:30:34.047' AS DateTime), 1, 10028, 5, NULL, N'/Files/Users/Payments/Image091ed1bc-15b9-4378-99d0-b72d9b6f5445.jpg', 1)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (24, CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-08-01T00:30:42.780' AS DateTime), 1, 10028, 5, NULL, NULL, NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10017, CAST(50.00 AS Decimal(18, 2)), CAST(N'2019-08-03T14:30:06.423' AS DateTime), 1, 20025, 10020, NULL, N'/Files/Users/Payments/Image02c0c190-9483-4125-9981-04a85a610bbe.jpg', NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10018, CAST(100.00 AS Decimal(18, 2)), CAST(N'2019-08-03T14:45:15.727' AS DateTime), 1, 20025, 10020, NULL, N'/Files/Users/Payments/Imageefee2a83-68cb-4c4d-8c77-24497ae676cb.jpg', 1)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10019, CAST(80.00 AS Decimal(18, 2)), CAST(N'2019-08-03T15:10:34.530' AS DateTime), 1, 20025, 5, NULL, N'/Files/Users/Payments/Image5c582081-e0b0-42fa-8eba-ec97f22fb9a6.jpg', NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10020, CAST(90.00 AS Decimal(18, 2)), CAST(N'2019-08-03T15:18:28.203' AS DateTime), 1, 20025, 5, NULL, N'/Files/Users/Payments/Imagefa9d1a10-476e-4544-80a8-56b20acedb8a.jpg', 1)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10021, CAST(55.00 AS Decimal(18, 2)), CAST(N'2019-08-03T18:43:38.443' AS DateTime), 1, 10024, 5, NULL, NULL, NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10022, CAST(55.00 AS Decimal(18, 2)), CAST(N'2019-08-03T18:43:44.273' AS DateTime), 1, 10024, 5, NULL, NULL, NULL)
GO
INSERT [dbo].[UserPayments] ([Id], [Amount], [DateTime], [IsAcceptFromManger], [FKUserTo_Id], [FKUserFrom_Id], [Notes], [PaymentImage], [IsBankTransfer]) VALUES (10023, CAST(56666.00 AS Decimal(18, 2)), CAST(N'2019-08-03T18:43:53.120' AS DateTime), 1, 10024, 5, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[UserPayments] OFF
GO
SET IDENTITY_INSERT [dbo].[UserPrivileges] ON 
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (33, 12, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (34, 16, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (35, 15, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (36, 11, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (37, 14, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (38, 5, 20058, 1, 1, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (39, 19, 20058, 1, 0, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (40, 2, 20058, 1, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[UserPrivileges] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (5, N'ahmed', N'a0hed@gmail.com', N'01025249400', N'dfdfdfdfdffdfdfdfssssd', N'123456', NULL, 1, NULL, NULL, 2, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, 0, NULL, 1, N'lmmmmmmmmmmmm', N'11111111111112', N'http://localhost:33752/Users/ProfileUpdate')
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (20055, N'emp1', N'shahnda2017@gmail.com', N'0102549400', N'sdsd', N'123456', N'C-10533', 5, 15, 10, 2, CAST(N'2019-08-28T22:18:05.260' AS DateTime), 7, 0, CAST(N'2020-09-30' AS Date), 1, N'موظف اعداد', N'4526987452', NULL)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (20056, N'as2', NULL, NULL, NULL, N'123456', NULL, 5, 15, 10, 2, CAST(N'2019-08-28T22:18:34.690' AS DateTime), 7, 0, NULL, 1, N'موظق تنفيذ', NULL, NULL)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (20057, N'em3', N'a0hmed@gmail.com', N'010252494', NULL, N'123456', N'C-11699', 5, 15, 10, 2, CAST(N'2019-08-28T22:19:19.897' AS DateTime), 7, 0, CAST(N'2020-09-30' AS Date), 1, N'موظف ارشفة وحفظ', N'5485158698', NULL)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (20058, N'br', N'sezer.info.0@gmail.com2', N'010252459400', NULL, N'123456', N'C-19147', 3, 15, 10, 2, CAST(N'2019-08-29T20:06:31.903' AS DateTime), 7, 0, CAST(N'2019-01-01' AS Date), 1, N'ahmed', N'0102524990', NULL)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive], [FullName], [NationalityNumber], [WebSite]) VALUES (20059, N'sdsd', N'ahmed@ahmed.co52', N'5010254940', NULL, N'123456', N'C-19240', 4, 15, 10, 2, CAST(N'2019-08-29T20:58:13.350' AS DateTime), 7, 0, CAST(N'2020-09-30' AS Date), 1, N's', N'4522987452', NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[UserSocialAccounts] ON 
GO
INSERT [dbo].[UserSocialAccounts] ([Id], [FKSocialAccountType_Id], [Link], [FKUser_Id]) VALUES (9, 1, N'http://localhost:33752/Users/ProfileUpdate', 5)
GO
SET IDENTITY_INSERT [dbo].[UserSocialAccounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Words] ON 
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (1, N'مدير المشروع', N'Project Manager ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (2, N'الاعدادت', N'Setting')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (3, N'صلاحيات الستخدم', N'Users Privileges')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (4, N'مشرف', N'Supervisor')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (5, N'مدير فرع', N'Branch Manager')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (6, N'عميل', N'Clinet')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (7, N'المستخدمين', N'Users')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (8, N'مصر', N'Egypt')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (9, N'الكويت', N'kuwait')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10, N'القاهرة', N'cairo')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (12, N'المستخدمين', N'Users')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (13, N'الدول', N'Countries')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (33, N'الاستفسارات', N'Enquires')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (34, N'انواع الاستفسارات', N'Enquiry Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (41, N'الاستفسارات', N'Enquires')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (42, N'عبر الواتساب', N'By Whatssp')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (43, N'عبر الفيس بوك', N'By FaceBook')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (44, N'عبر الهاتف', N'By Phone')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (45, N'فروع الشركة', N'Branches')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (47, N'جدة', N'Gada')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (48, N'المدينة المنورة', N'Medina')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (50, N'استفسارتى', N'My Enquires')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (51, N'اضافة استفسار جديد', N'Add New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (52, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (53, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (54, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (55, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (56, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (57, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (58, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (59, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (60, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (61, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (62, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (63, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (64, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (65, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (66, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (67, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (68, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (69, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (70, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (71, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (72, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (73, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (74, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (75, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (76, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (77, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (78, N'العميل لم يرد', N'Not Answer ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (79, N'تم التواصل مع العميل ', N'Customer Contacted')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (80, N'رفض الخدمة ', N'Reject Service')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (81, N'الموافقة التامة', N'Full Approval')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (82, N'تحديد موعد للزيارة ', N' Schedule a Visit')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (83, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (84, N'لقد قام العميل ahmed10  بنشاء استفسار جديد', N'ahmed10 Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (85, N'معلومات المستخدم', N'User Information')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (86, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (87, N'لقد قامت الآدارة بنشاء استفسار جديد', N'Manger Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (88, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (89, N'لقد قامت الآدارة تحويل استفسار جديد لك', N'Manger Has been Convert New Enqiry For You')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (90, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (91, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (92, N'يحتاج للتفكير ', N'Needs To Think')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (93, N'الحجز بواسطة الدفع الكاش', N'Book By Cash')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (94, N'الحجز بواسطة الحوالة البنكية', N'Book By Bank Transfer')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10088, N'انواع حفر الاسماء', N'Print Names Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10089, N'dfdf', N'dfdf')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10090, N'dssd', N'sdsd`')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10091, N'sd', N'dsdضضضض')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10092, N'سي', N'سيسي')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10096, N'sdsd', N'dfdf')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10099, N'حفر 1', N'p1')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10100, N'حفر 2', N'p2sddddddddd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10101, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10102, N'لقد قام المدير بنشاء استفسار جديد', N'Manger Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10103, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10104, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10105, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10106, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10107, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10108, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10109, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10110, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10111, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10112, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10113, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10114, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10115, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10116, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10117, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10118, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10119, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10120, N'لقد قام المدير بنشاء استفسار جديد', N'Manger Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10121, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10122, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10123, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10124, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10125, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10126, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10127, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10128, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10129, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10130, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10131, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10132, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10133, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10134, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10135, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10136, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10137, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10138, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10139, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10140, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10141, N'المناسبات', N'Events')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10142, N'المناسبات', N'Events')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10143, N'تجربة', N'tese')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10144, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10145, N'لقد قام مدير فرع جدة بـ انشاء حدث جديد ', N'Gada Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10146, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10147, N'لقد قام مدير فرع جدة بـ انشاء حدث جديد ', N'Gada Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20146, N'مناسباتى', N'MyEvents')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20147, N'الباكيجات', N'Packages')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20148, N'انواع الالبومات', N'Album Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20149, N'الباكيجات', N'Packages')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20150, N'انواع مدخلت الباكيجات', N'Package Input Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20151, N'سيسي', N'سيسي')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20152, N'سيسي', N'يسيسي\')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20153, N'البوم 1', N'album 1')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20154, N'asas', N'sdsdsdsdsd55522')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20155, N'fdf', N'dfdf')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20156, N'cvcv000000', N'fdf')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20157, N'dfdfq', N',fdklfj')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20158, N'idojfdlfnl', N'dsdfkjsf')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20159, N'dsdsd', N'vv')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20161, N'صث', N'صث')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20162, N'صث', N'صث')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20163, N'صث', N'صث')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20164, N'd', N'ds')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20165, N'd', N'ds')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20166, N'd', N'ds')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20167, N'يسسي', N'sasas')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20168, N'dsd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20169, N'sdsd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20170, N'sd', N'sd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20179, N'sdsd', N'ssdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20180, N'موظف', N'Employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20181, N'الحجز', N'Booking')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20182, N'اكمال البيانات', N'Data Perfection')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20183, N'الاعداد والتنسيق', N'Coordination')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20184, N'التنفيذ', N'Implementation')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20185, N'الأرشفة و الحفظ', N'Archiving and Saveing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20186, N'تجهيز المنتاجات', N'Product processing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20187, N'الاختيار', N'Chooseing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20188, N'المعالجة الرقمية', N'Digital processing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20189, N'الاعداد للطباعة', N'Preparing for printing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20190, N'التصنيع', N'Manufacturing')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20191, N'الجودة و المراجعة', N'Quality and review')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20192, N'التغليف', N'Packaging')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20193, N'الارسال و التسليم', N'Transmission and delivery
')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20194, N'الأرشفة', N'Archiving')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20195, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20196, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 20', N'branch Has been Add Payment Process By Bank Transfer And It Is Valaue 20')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20197, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20198, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 20', N'branch Has been Add Payment Process By Bank Transfer And It Is Valaue 20')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20199, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20200, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20201, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20202, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20203, N'بيانات المدفوعات', N'Payments Informations')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20204, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20205, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 2000', N'branch Has been Add Payment Process By Bank Transfer And It Is Valaue 2000')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20206, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20207, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20208, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20209, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 50', N'branch Has been Add Payment Process By Bank Transfer And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20210, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20211, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 51', N'branch Has been Add Payment Process By Cash Payment And It Is Valaue 51')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20212, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20213, N'لقد قام الموظف   ahmed باضافة عملية دفع عن طريق دفع نقدا وقيمتها 55', N'ahmed Has been Add Payment Process By Cash Payment And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20214, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20215, N'لقد قام المدير  باضافة عملية دفع عن طريق دفع نقدا وقيمتها 54', N'Manger Has been Add Payment Process By Cash Payment And It Is Valaue 54')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20216, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20217, N'لقد قام مدير فرع جدة بـ انشاء حدث جديد ', N'Gada Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20218, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20219, N'لقد قام مدير فرع جدة بـ انشاء حدث جديد ', N'Gada Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20220, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20221, N'لقد قام المدير بنشاء استفسار جديد', N'Manger Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20222, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20223, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 10', N'branch Has been Add Payment Process By Cash Payment And It Is Valaue 10')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20224, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20225, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20226, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20227, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 10', N'branch Has been Add Payment Process By Cash Payment And It Is Valaue 10')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20228, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20229, N'لقد قام branch بـ وضع حالة جديد   ', N'branch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20230, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20231, N'لقد قام مدير فرع جدة بـ انشاء حدث جديد ', N'Gada Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20232, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20233, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 30', N'branch Has been Add Payment Process By Bank Transfer And It Is Valaue 30')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20234, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20235, N'لقد قام الموظف   branch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 20', N'branch Has been Add Payment Process By Cash Payment And It Is Valaue 20')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30220, N'مصر', N'eygept')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30221, N'مصر', N'egypt')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30222, N'القاهرة', N'cairo')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30223, N'المنصورة', N'mansoura')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30224, N'فرع المنصورة 1', N'mansoura branch 1')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30225, N'فرع القاهرة 1', N'cairo branch 1')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30226, N'عبر الاميل', N'by Email')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30227, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30228, N'لقد قام المدير بنشاء استفسار جديد', N'Manger Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30229, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30230, N'لقد قام AhmedMansBranch بـ وضع حالة جديد   ', N'AhmedMansBranch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30231, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30232, N'لقد قام AhmedMansBranch بـ وضع حالة جديد   ', N'AhmedMansBranch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30233, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30234, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process By Bank Transfer And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30235, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30236, N'لقد قام AhmedMansBranch بـ وضع حالة جديد   ', N'AhmedMansBranch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30237, N'البوم 2', N'album 2')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30238, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30239, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30240, N'dsds', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30241, N'ssd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30242, N'باجك جديد', N'new package')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30243, N'باجك جديد
باجك جديد
باجك جديد', N'new package
new package
new package')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30244, N'عدد الصور', N'image count')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30245, N'5', N'5')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30246, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30247, N'لقد قام مدير فرع فرع القاهرة 1 بـ انشاء حدث جديد ', N'cairo branch 1 Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30248, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30249, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع عن طريق حولة بنكية وقيمتها 200', N'AhmedMansBranch Has been Add Payment Process By Bank Transfer And It Is Valaue 200')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30250, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30251, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 200', N'AhmedMansBranch Has been Add Payment Process By Cash Payment And It Is Valaue 200')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30252, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30253, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process By Cash Payment And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30254, N' الانتهاء من الاعداد والتنسيق', N'Coordinations Finshed')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30255, N'لقد قام الموظف emp بـ انهاء مهام الاعداد والتنسيق للمناسبة ', N'emp Has been finshed coordinations for event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30256, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30257, N'لقد قام العميل clinet  بنشاء استفسار جديد', N'clinet Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30258, N'متعاون', N'Helper')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30259, N'فيس بوك', N'FaceBook')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30260, N'انواع حسابات التواصل الاجتماعى', N'Social Media Account Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30261, N'sd', N'sd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30262, N'df', N'we')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30263, N'dsd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30264, N'df', N'we`')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30265, N'sd', N'asas')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30266, N'مصور', N'Photographer')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30267, N' الانتهاء من الاعداد والتنسيق', N'Coordinations Finshed')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30268, N'لقد قام الموظف emp بـ انهاء مهام الاعداد والتنسيق للمناسبة ', N'emp Has been finshed coordinations for event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30269, N'مدفوعات الموظف', N'Employee Payments')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30270, N'مدفوعات الاستفسار والمناسبة', N'Enquiry And Event Payments')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30271, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30272, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30273, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30274, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 55', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30275, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30276, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 78', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 78')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30277, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30278, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 0', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 0')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30279, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30280, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 22', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 22')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30281, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30282, N'لقد تم دفع لك دفعة مالية عن طريق تحويل لنكى وقبمتها 50 ريال ', N'You have new payment by bank transfer and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30283, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30284, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30285, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30286, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30287, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30288, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 55', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30289, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30290, N'لقد تمت الموافقة على الدفع الكاش لـ الموظف HLL', N'has been accept for cash payment for HLL employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30291, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30292, N'لقد تمت الموافقة على الدفع الكاش لـ الموظف HLL', N'has been accept for cash payment for HLL employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30293, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30294, N'لقد تم دفع لك دفعة مالية عن طريق دفع كاش وقبمتها 55 ريال ', N'You have new payment by cash payment and it is value 55 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30295, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30296, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف HLL وقيمتها 66', N'AhmedMansBranch Has been Add Payment Process Fro HLL Employee And It Is Valaue 66')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30297, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30298, N'لقد تم دفع لك دفعة مالية عن طريق تحويل لنكى وقبمتها 66 ريال ', N'You have new payment by bank transfer and it is value 66 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30299, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30300, N'لقد تم دفع لك دفعة مالية عن طريق تحويل بنكى وقبمتها 50 ريال ', N'You have new payment by bank transfer and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30301, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30302, N'هناك عملية دفع للموظف HLL وقيمتها 66 ريال', N'you have new paymetn to HLL employee and it is value 66  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30303, N'انواع اسئلة الاستبيان', N'Survey Question Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30304, N'اعدادات الاستبيان', N'Survey Setting')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30307, N'ما رئيك فى الشركة', N'ما رئيك فى الشركة')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30308, N'ما رئيك فى المصور الاول', N'ما رئيك فى المصور الاول')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30309, N'اسئلة استبيان المناسبة الافتراضبة', N'Event Survey Questions Defult')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30310, N'ما رئيك فى المعاملات المالية', N'ما رئيك فى المعاملات المالية')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30311, N' الانتهاء من الاعداد والتنسيق', N'Coordinations Finshed')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30312, N'لقد قام الموظف HLL بـ انهاء مهام الاعداد والتنسيق للمناسبة ', N'HLL Has been finshed coordinations for event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30313, N' الانتهاء من الاعداد والتنسيق', N'Coordinations Finshed')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30314, N'لقد قام الموظف HLL بـ انهاء مهام الاعداد والتنسيق للمناسبة ', N'HLL Has been finshed coordinations for event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30315, N'انواع تسليم الملفات', N'Files Received Types')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30317, N'USB', N'USB')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30318, N'دروب بوك', N'DopBox')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30319, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30320, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30321, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30322, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 20', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 20')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30323, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30324, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30325, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30326, N'لقد تمت الموافقة على الدفع الكاش لـ الموظف hekp33', N'has been accept for cash payment for hekp33 employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30327, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30328, N'لقد تم دفع لك دفعة مالية عن طريق دفع كاش وقبمتها 50 ريال ', N'You have new payment by cash payment and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30329, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30330, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30331, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30332, N'لقد تمت الموافقة على الدفع الكاش لـ الموظف hekp33', N'has been accept for cash payment for hekp33 employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30333, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30334, N'لقد تم دفع لك دفعة مالية عن طريق دفع كاش وقبمتها 50 ريال ', N'You have new payment by cash payment and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30335, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30336, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 22', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 22')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30337, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30338, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف hekp33 وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro hekp33 Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30339, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30340, N'لقد تمت الموافقة على الدفع بالتحويل البنكى لـ الموظف hekp33', N'has been accept for bank transfer payment for hekp33 employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30341, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30342, N'لقد تم دفع لك دفعة مالية عن طريق تحويل بنكى وقبمتها 50 ريال ', N'You have new payment by bank transfer and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30343, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30344, N'هناك عملية دفع للموظف hekp33 وقيمتها 50 ريال', N'you have new paymetn to hekp33 employee and it is value 50  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40315, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40316, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف heel وقيمتها 50', N'AhmedMansBranch Has been Add Payment Process Fro heel Employee And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40317, N'عملية دفع مقبولة', N'New Payment Process Accepted')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40318, N'لقد تمت الموافقة على الدفع الكاش لـ الموظف heel', N'has been accept for cash payment for heel employee')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40319, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40320, N'لقد تم دفع لك دفعة مالية عن طريق دفع كاش وقبمتها 50 ريال ', N'You have new payment by cash payment and it is value 50 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40321, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40322, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع لـ الموظف heel وقيمتها 100', N'AhmedMansBranch Has been Add Payment Process Fro heel Employee And It Is Valaue 100')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40323, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40324, N'لقد تم دفع لك دفعة مالية عن طريق تحويل لنكى وقبمتها 100 ريال ', N'You have new payment by bank transfer and it is value 100 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40325, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40326, N'هناك عملية دفع للموظف heel وقيمتها 80 ريال', N'you have new paymetn to heel employee and it is value 80  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40327, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40328, N'لقد تم دفع لك دفعة مالية عن طريق دفع كاش وقبمتها 80 ريال ', N'You have new payment by cash payment and it is value 80 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40329, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40330, N'لقد تم دفع لك دفعة مالية عن طريق تحويل بنكى وقبمتها 90 ريال ', N'You have new payment by bank transfer and it is value 90 ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40331, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40332, N'هناك عملية دفع للموظف HLL وقيمتها 55 ريال', N'you have new paymetn to HLL employee and it is value 55  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40333, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40334, N'هناك عملية دفع للموظف HLL وقيمتها 55 ريال', N'you have new paymetn to HLL employee and it is value 55  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40335, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40336, N'هناك عملية دفع للموظف HLL وقيمتها 56666 ريال', N'you have new paymetn to HLL employee and it is value 56666  ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40341, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40342, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40343, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40344, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40345, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40346, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40347, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40348, N'لقد قام العميل clinet  بـ انشاء استفسار جديد', N'clinet Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40349, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40350, N'لقد قام العميل clinet  بـ انشاء استفسار جديد', N'clinet Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40351, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40352, N'لقد قام العميل clinet  بـ انشاء استفسار جديد', N'clinet Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40353, N'السعودية', N'soudi')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40354, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40355, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40356, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40357, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40358, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40359, N'لقد قام شخص ما بـ انشاء استفسار جديد', N'Some people has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40360, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40361, N'لقد قام العميل clinet  بـ انشاء استفسار جديد', N'clinet Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40362, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40363, N'لقد قام الموظف   AhmedMansBranch باضافة عملية دفع عن طريق دفع نقدا وقيمتها 22', N'AhmedMansBranch Has been Add Payment Process By Cash Payment And It Is Valaue 22')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40364, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40365, N'لقد قام AhmedMansBranch بـ وضع حالة جديد   ', N'AhmedMansBranch Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40366, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40367, N'لقد قام مدير فرع فرع القاهرة 1 بـ انشاء حدث جديد ', N'cairo branch 1 Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40368, N'sdsd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40369, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40370, N'لقد قام المدير  باضافة عملية دفع عن طريق دفع نقدا وقيمتها 55', N'Manger Has been Add Payment Process By Cash Payment And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40371, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40372, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40373, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40374, N'لقد قام المدير  باضافة عملية دفع عن طريق دفع نقدا وقيمتها 56', N'Manger Has been Add Payment Process By Cash Payment And It Is Valaue 56')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40375, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40376, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40377, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40378, N'لقد قام المدير  باضافة عملية دفع عن طريق دفع نقدا وقيمتها 50', N'Manger Has been Add Payment Process By Cash Payment And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40379, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40380, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40381, N'العرض الاول مع الحفر مجانى', N'العرض الاول مع الحفر مجانى')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40382, N'سيس', N'سيس')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40383, N'5', N'5')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40384, N'حفر فضى', N'حفر فضى')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40385, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40386, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40387, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40388, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40389, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40390, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40391, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40392, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40393, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40394, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40395, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40396, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40397, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40398, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40399, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40400, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40401, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40402, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40403, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40404, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40405, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40406, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40407, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40408, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40409, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40410, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40411, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40412, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40413, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40414, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40415, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40416, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40417, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40418, NULL, NULL)
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40419, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40420, N'لقد قام المدير بـ انشاء استفسار جديد', N'Manger has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40421, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40422, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40423, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40424, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40425, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40426, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40427, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40428, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40429, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40430, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40431, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40432, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40433, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40434, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40435, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40436, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40437, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40438, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40439, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40440, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40441, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40442, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40443, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40444, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40445, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40446, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40447, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40448, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40449, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40450, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40451, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40452, N'لقد قام المدير  باضافة عملية دفع عن طريق دفع نقدا وقيمتها 500', N'Manger Has been Add Payment Process By Cash Payment And It Is Valaue 500')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40453, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40454, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40455, N'فرع قاهرة 1', N'فرع قاهرة 1')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40456, N'نوع جديد', N'new type')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40457, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40458, N'لقد قام br بـ وضع حالة جديد   ', N'br Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40459, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40460, N'لقد قام br بـ وضع حالة جديد   ', N'br Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40461, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40462, N'لقد قام br بـ وضع حالة جديد   ', N'br Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40463, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40464, N'لقد قام المدير بـ وضع حالة جديد   ', N'المدير Has Been Add New Status')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40465, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40466, N'لقد تم اضافة حالة العميل لم يرد على استفسار sdsd lklk', N'Ahmed has been adde status Not Answer  on enquiry sdsd lklk')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40467, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40468, N'لقد تم اضافة حالة الموافقة التامة على استفسار sdsd lklk', N'Ahmed has been adde status Full Approval on enquiry sdsd lklk')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40469, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40470, N'لقد قام الموظف   br باضافة عملية دفع عن طريق دفع نقدا وقيمتها 55', N'br Has been Add Payment Process By Cash Payment And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40471, N'اضافة حالة جديدة على استفسار ما', N'Add New Status On Some Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40472, N'لقد تم اضافة حالة الحجز بواسطة الدفع الكاش على استفسار sdsd lklk', N'Ahmed has been adde status Book By Cash on enquiry sdsd lklk')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40473, N's', N's')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40474, N'sd', N'sd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40475, N'dsd', N'sdsd')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40476, N'rer`', N'wwe')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40477, N'21', N'212')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40478, N'لقج تم انشاء حدث جديد', N'Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40479, N'لقد قام مدير فرع فرع قاهرة 1 بـ انشاء حدث جديد ', N'فرع قاهرة 1 Branch Manger Has Been Created New Event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40480, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40481, N'لقد قام الموظف   br باضافة عملية دفع عن طريق حولة بنكية وقيمتها 50', N'br Has been Add Payment Process By Bank Transfer And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40482, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40483, N'لقد قام الموظف   br باضافة عملية دفع عن طريق دفع نقدا وقيمتها 50', N'br Has been Add Payment Process By Cash Payment And It Is Valaue 50')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40484, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40485, N'لقد قام الموظف   br باضافة عملية دفع عن طريق دفع نقدا وقيمتها 55', N'br Has been Add Payment Process By Cash Payment And It Is Valaue 55')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40486, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40487, N'لقد قام الموظف   br باضافة عملية دفع عن طريق دفع نقدا وقيمتها 500', N'br Has been Add Payment Process By Cash Payment And It Is Valaue 500')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40488, N'عملية دفع جديدة', N'New Payment Process')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40489, N'لقد قام الموظف   br باضافة عملية دفع عن طريق دفع نقدا وقيمتها 500', N'br Has been Add Payment Process By Cash Payment And It Is Valaue 500')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40490, N' الانتهاء من الاعداد والتنسيق', N'Coordinations Finshed')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40491, N'لقد قام الموظف emp1 بـ انهاء مهام الاعداد والتنسيق للمناسبة ', N'emp1 Has been finshed coordinations for event')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40492, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40493, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40494, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40495, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40496, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40497, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40498, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40499, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40500, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40501, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40502, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40503, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40504, N' استفسار جدبد', N'New Enquiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40505, N'لقد قام العميل sdsd  بـ انشاء استفسار جديد', N'sdsd Has been created new enqiry')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (40506, N'منصورة', N'منصوة')
GO
SET IDENTITY_INSERT [dbo].[Words] OFF
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (1, 20181, N'')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (2, 20182, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (3, 20183, N'/EEW/Coordinations')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (4, 20184, N'/EEW/Implementations')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (5, 20185, N'/EEW/ArchivingAndSaveing')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (6, 20186, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (7, 20187, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (8, 20188, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (9, 20189, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (10, 20190, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (11, 20191, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (12, 20192, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (13, 20193, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (14, 20194, NULL)
GO
/****** Object:  Index [IX_PoolQuestionTypes]    Script Date: 8/30/2019 7:12:27 PM ******/
CREATE NONCLUSTERED INDEX [IX_PoolQuestionTypes] ON [dbo].[EventSurveyQuestionTypes]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Enquires] ADD  CONSTRAINT [DF_Enquires_IsCreatedEvent]  DEFAULT ((0)) FOR [IsCreatedEvent]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActiveEmail]  DEFAULT ((0)) FOR [IsActiveEmail]
GO
ALTER TABLE [dbo].[AccountTypes]  WITH CHECK ADD  CONSTRAINT [FK_AccountTypes_Words] FOREIGN KEY([FkWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountTypes] CHECK CONSTRAINT [FK_AccountTypes_Words]
GO
ALTER TABLE [dbo].[AlbumTypes]  WITH CHECK ADD  CONSTRAINT [FK_AlbumTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AlbumTypes] CHECK CONSTRAINT [FK_AlbumTypes_Words]
GO
ALTER TABLE [dbo].[Branches]  WITH CHECK ADD  CONSTRAINT [FK_Branches_Cities] FOREIGN KEY([FKCity_Id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Branches] CHECK CONSTRAINT [FK_Branches_Cities]
GO
ALTER TABLE [dbo].[Branches]  WITH CHECK ADD  CONSTRAINT [FK_Branches_Countries] FOREIGN KEY([FkCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Branches] CHECK CONSTRAINT [FK_Branches_Countries]
GO
ALTER TABLE [dbo].[Branches]  WITH CHECK ADD  CONSTRAINT [FK_Branches_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Branches] CHECK CONSTRAINT [FK_Branches_Words]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Countries] FOREIGN KEY([FKCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Countries]
GO
ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_Words]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Words]
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDistributionWorks_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks] CHECK CONSTRAINT [FK_EmployeeDistributionWorks_Branches]
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDistributionWorks_Events] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks] CHECK CONSTRAINT [FK_EmployeeDistributionWorks_Events]
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDistributionWorks_Users] FOREIGN KEY([FKEmployee_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks] CHECK CONSTRAINT [FK_EmployeeDistributionWorks_Users]
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDistributionWorks_WorkTypes] FOREIGN KEY([FKWorkType_Id])
REFERENCES [dbo].[WorkTypes] ([Id])
GO
ALTER TABLE [dbo].[EmployeeDistributionWorks] CHECK CONSTRAINT [FK_EmployeeDistributionWorks_WorkTypes]
GO
ALTER TABLE [dbo].[EmployeesWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeesWorks_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EmployeesWorks] CHECK CONSTRAINT [FK_EmployeesWorks_Users]
GO
ALTER TABLE [dbo].[EmployeesWorks]  WITH CHECK ADD  CONSTRAINT [FK_EmployeesWorks_WorkTypes] FOREIGN KEY([FkWorkType_Id])
REFERENCES [dbo].[WorkTypes] ([Id])
GO
ALTER TABLE [dbo].[EmployeesWorks] CHECK CONSTRAINT [FK_EmployeesWorks_WorkTypes]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_Enquires_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_Enquires_Branches]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_Enquires_Countries] FOREIGN KEY([FKPhoneCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_Enquires_Countries]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Cities] FOREIGN KEY([FkCity_Id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_EnquiryForms_Cities]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Countries] FOREIGN KEY([FkCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_EnquiryForms_Countries]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_EnquiryTypes] FOREIGN KEY([FKEnquiryType_Id])
REFERENCES [dbo].[EnquiryTypes] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_EnquiryForms_EnquiryTypes]
GO
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_EnquiryForms_Users]
GO
ALTER TABLE [dbo].[EnquiryPayments]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryPayments_Enquires] FOREIGN KEY([FKEnquiry_Id])
REFERENCES [dbo].[Enquires] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryPayments] CHECK CONSTRAINT [FK_EnquiryPayments_Enquires]
GO
ALTER TABLE [dbo].[EnquiryPayments]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryPayments_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EnquiryPayments] CHECK CONSTRAINT [FK_EnquiryPayments_Users]
GO
ALTER TABLE [dbo].[EnquiryStatus]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryStatus_Enquires] FOREIGN KEY([FKEnquiry_Id])
REFERENCES [dbo].[Enquires] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryStatus] CHECK CONSTRAINT [FK_EnquiryStatus_Enquires]
GO
ALTER TABLE [dbo].[EnquiryStatus]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryStatus_EnquiryPayments] FOREIGN KEY([FKEnquiryPayment_Id])
REFERENCES [dbo].[EnquiryPayments] ([Id])
GO
ALTER TABLE [dbo].[EnquiryStatus] CHECK CONSTRAINT [FK_EnquiryStatus_EnquiryPayments]
GO
ALTER TABLE [dbo].[EnquiryStatus]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryStatus_EnquiryStatusTypes] FOREIGN KEY([FKEnquiryStatus_Id])
REFERENCES [dbo].[EnquiryStatusTypes] ([Id])
GO
ALTER TABLE [dbo].[EnquiryStatus] CHECK CONSTRAINT [FK_EnquiryStatus_EnquiryStatusTypes]
GO
ALTER TABLE [dbo].[EnquiryStatus]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryStatus_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EnquiryStatus] CHECK CONSTRAINT [FK_EnquiryStatus_Users]
GO
ALTER TABLE [dbo].[EnquiryStatusTypes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryStatusTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryStatusTypes] CHECK CONSTRAINT [FK_EnquiryStatusTypes_Words]
GO
ALTER TABLE [dbo].[EnquiryTypes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryTypes] CHECK CONSTRAINT [FK_EnquiryTypes_Words]
GO
ALTER TABLE [dbo].[EventArchives]  WITH CHECK ADD  CONSTRAINT [FK_EventArchives_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EventArchives] CHECK CONSTRAINT [FK_EventArchives_Users]
GO
ALTER TABLE [dbo].[EventCoordinations]  WITH CHECK ADD  CONSTRAINT [FK_EventCoordination_Events] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventCoordinations] CHECK CONSTRAINT [FK_EventCoordination_Events]
GO
ALTER TABLE [dbo].[EventCoordinations]  WITH CHECK ADD  CONSTRAINT [FK_EventCoordination_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EventCoordinations] CHECK CONSTRAINT [FK_EventCoordination_Users]
GO
ALTER TABLE [dbo].[EventPhotographers]  WITH CHECK ADD  CONSTRAINT [FK_EventPhotographers_Events] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventPhotographers] CHECK CONSTRAINT [FK_EventPhotographers_Events]
GO
ALTER TABLE [dbo].[EventPhotographers]  WITH CHECK ADD  CONSTRAINT [FK_EventPhotographers_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EventPhotographers] CHECK CONSTRAINT [FK_EventPhotographers_Users]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Branches]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Enquires] FOREIGN KEY([Id])
REFERENCES [dbo].[Enquires] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Enquires]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Packages] FOREIGN KEY([FKPackage_Id])
REFERENCES [dbo].[Packages] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Packages]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_PrintNamesTypes] FOREIGN KEY([FKPrintNameType_Id])
REFERENCES [dbo].[PrintNamesTypes] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_PrintNamesTypes]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Users] FOREIGN KEY([FKClinet_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Users]
GO
ALTER TABLE [dbo].[EventSurveies]  WITH CHECK ADD  CONSTRAINT [FK_EventSurveies_Events] FOREIGN KEY([Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventSurveies] CHECK CONSTRAINT [FK_EventSurveies_Events]
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer]  WITH CHECK ADD  CONSTRAINT [FK_EventPoolQuestionAnswers_EventPoolQuestionAnswers] FOREIGN KEY([FKEventSurveyQuestion_Id])
REFERENCES [dbo].[EventSurveyQuestions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer] CHECK CONSTRAINT [FK_EventPoolQuestionAnswers_EventPoolQuestionAnswers]
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer]  WITH CHECK ADD  CONSTRAINT [FK_EventSurveyQuestionAnswers_EventSurveies] FOREIGN KEY([FKEventSurvey_Id])
REFERENCES [dbo].[EventSurveies] ([Id])
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer] CHECK CONSTRAINT [FK_EventSurveyQuestionAnswers_EventSurveies]
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer]  WITH CHECK ADD  CONSTRAINT [FK_EventSurveyQuestionAnswers_EventSurveyQuestionTypes] FOREIGN KEY([FKSurveyQuestionType_Id])
REFERENCES [dbo].[EventSurveyQuestionTypes] ([Id])
GO
ALTER TABLE [dbo].[EventSurveyQuestionAnswerer] CHECK CONSTRAINT [FK_EventSurveyQuestionAnswers_EventSurveyQuestionTypes]
GO
ALTER TABLE [dbo].[EventSurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_EventPoolQuestions_EventPools] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventSurveyQuestions] CHECK CONSTRAINT [FK_EventPoolQuestions_EventPools]
GO
ALTER TABLE [dbo].[EventSurveyQuestions]  WITH CHECK ADD  CONSTRAINT [FK_EventPoolQuestions_PoolQuestionTypes] FOREIGN KEY([FKSurveyQuestionType_Id])
REFERENCES [dbo].[EventSurveyQuestionTypes] ([Id])
GO
ALTER TABLE [dbo].[EventSurveyQuestions] CHECK CONSTRAINT [FK_EventPoolQuestions_PoolQuestionTypes]
GO
ALTER TABLE [dbo].[EventSurveyQuestionTypes]  WITH CHECK ADD  CONSTRAINT [FK_PoolQuestionTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventSurveyQuestionTypes] CHECK CONSTRAINT [FK_PoolQuestionTypes_Words]
GO
ALTER TABLE [dbo].[EventWorksStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatus_AccountTypes] FOREIGN KEY([FKAccountType_Id])
REFERENCES [dbo].[AccountTypes] ([Id])
GO
ALTER TABLE [dbo].[EventWorksStatusHistory] CHECK CONSTRAINT [FK_EventWorksStatus_AccountTypes]
GO
ALTER TABLE [dbo].[EventWorksStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatus_Events] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventWorksStatusHistory] CHECK CONSTRAINT [FK_EventWorksStatus_Events]
GO
ALTER TABLE [dbo].[EventWorksStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatus_Users] FOREIGN KEY([FKUsre_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EventWorksStatusHistory] CHECK CONSTRAINT [FK_EventWorksStatus_Users]
GO
ALTER TABLE [dbo].[EventWorksStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatus_WorkTypes] FOREIGN KEY([FKWorkType_Id])
REFERENCES [dbo].[WorkTypes] ([Id])
GO
ALTER TABLE [dbo].[EventWorksStatusHistory] CHECK CONSTRAINT [FK_EventWorksStatus_WorkTypes]
GO
ALTER TABLE [dbo].[EventWorksStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatusHistory_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[EventWorksStatusHistory] CHECK CONSTRAINT [FK_EventWorksStatusHistory_Branches]
GO
ALTER TABLE [dbo].[EventWorksStatusIsFinshed]  WITH CHECK ADD  CONSTRAINT [FK_EventWorksStatusIsFinshed_Events] FOREIGN KEY([EventId])
REFERENCES [dbo].[Events] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EventWorksStatusIsFinshed] CHECK CONSTRAINT [FK_EventWorksStatusIsFinshed_Events]
GO
ALTER TABLE [dbo].[FilesReceivedTypes]  WITH CHECK ADD  CONSTRAINT [FK_FilesReceivedTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilesReceivedTypes] CHECK CONSTRAINT [FK_FilesReceivedTypes_Words]
GO
ALTER TABLE [dbo].[Menus]  WITH CHECK ADD  CONSTRAINT [FK_Menus_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Menus] CHECK CONSTRAINT [FK_Menus_Words]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Notifications] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Notifications]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Pages] FOREIGN KEY([FKPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Pages]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Words] FOREIGN KEY([FkWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Words]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Words1] FOREIGN KEY([FKDescriptionWord_Id])
REFERENCES [dbo].[Words] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Words1]
GO
ALTER TABLE [dbo].[NotificationsUser]  WITH CHECK ADD  CONSTRAINT [FK_NotificationsUser_Notifications] FOREIGN KEY([FKNotify_Id])
REFERENCES [dbo].[Notifications] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationsUser] CHECK CONSTRAINT [FK_NotificationsUser_Notifications]
GO
ALTER TABLE [dbo].[NotificationsUser]  WITH CHECK ADD  CONSTRAINT [FK_NotificationsUser_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[NotificationsUser] CHECK CONSTRAINT [FK_NotificationsUser_Users]
GO
ALTER TABLE [dbo].[PackageDetails]  WITH CHECK ADD  CONSTRAINT [FK_PackageDetails_PackageInputTypes] FOREIGN KEY([FKPackageInputType_Id])
REFERENCES [dbo].[PackageInputTypes] ([Id])
GO
ALTER TABLE [dbo].[PackageDetails] CHECK CONSTRAINT [FK_PackageDetails_PackageInputTypes]
GO
ALTER TABLE [dbo].[PackageDetails]  WITH CHECK ADD  CONSTRAINT [FK_PackageDetails_Packages] FOREIGN KEY([FKPackage_Id])
REFERENCES [dbo].[Packages] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageDetails] CHECK CONSTRAINT [FK_PackageDetails_Packages]
GO
ALTER TABLE [dbo].[PackageDetails]  WITH CHECK ADD  CONSTRAINT [FK_PackageDetails_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageDetails] CHECK CONSTRAINT [FK_PackageDetails_Words]
GO
ALTER TABLE [dbo].[PackageInputTypes]  WITH CHECK ADD  CONSTRAINT [FK_PackageInputTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PackageInputTypes] CHECK CONSTRAINT [FK_PackageInputTypes_Words]
GO
ALTER TABLE [dbo].[Packages]  WITH CHECK ADD  CONSTRAINT [FK_Packages_AlbumTypes] FOREIGN KEY([FKAlbumType_Id])
REFERENCES [dbo].[AlbumTypes] ([Id])
GO
ALTER TABLE [dbo].[Packages] CHECK CONSTRAINT [FK_Packages_AlbumTypes]
GO
ALTER TABLE [dbo].[Pages]  WITH CHECK ADD  CONSTRAINT [FK_Pages_Menus] FOREIGN KEY([FkMenu_Id])
REFERENCES [dbo].[Menus] ([Id])
GO
ALTER TABLE [dbo].[Pages] CHECK CONSTRAINT [FK_Pages_Menus]
GO
ALTER TABLE [dbo].[Pages]  WITH CHECK ADD  CONSTRAINT [FK_Pages_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
GO
ALTER TABLE [dbo].[Pages] CHECK CONSTRAINT [FK_Pages_Words]
GO
ALTER TABLE [dbo].[PrintNamesTypes]  WITH CHECK ADD  CONSTRAINT [FK_PrintNamesTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PrintNamesTypes] CHECK CONSTRAINT [FK_PrintNamesTypes_Words]
GO
ALTER TABLE [dbo].[SocialAccountTypes]  WITH CHECK ADD  CONSTRAINT [FK_SocialAccounts_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SocialAccountTypes] CHECK CONSTRAINT [FK_SocialAccounts_Words]
GO
ALTER TABLE [dbo].[UserPrivileges]  WITH CHECK ADD  CONSTRAINT [FK_UserPrivileges_Pages] FOREIGN KEY([FKPage_Id])
REFERENCES [dbo].[Pages] ([Id])
GO
ALTER TABLE [dbo].[UserPrivileges] CHECK CONSTRAINT [FK_UserPrivileges_Pages]
GO
ALTER TABLE [dbo].[UserPrivileges]  WITH CHECK ADD  CONSTRAINT [FK_UserPrivileges_Users] FOREIGN KEY([FkUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserPrivileges] CHECK CONSTRAINT [FK_UserPrivileges_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_AccountTypes] FOREIGN KEY([FKAccountType_Id])
REFERENCES [dbo].[AccountTypes] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_AccountTypes]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Branches] FOREIGN KEY([FKPranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Branches]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Cities] FOREIGN KEY([FkCity_Id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Cities]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Countries] FOREIGN KEY([FkCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Countries]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Languages] FOREIGN KEY([FKLanguage_Id])
REFERENCES [dbo].[Languages] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Languages]
GO
ALTER TABLE [dbo].[UserSocialAccounts]  WITH CHECK ADD  CONSTRAINT [FK_UserSocialAccounts_Users] FOREIGN KEY([FKUser_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserSocialAccounts] CHECK CONSTRAINT [FK_UserSocialAccounts_Users]
GO
ALTER TABLE [dbo].[WorkTypes]  WITH CHECK ADD  CONSTRAINT [FK_WorkTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
GO
ALTER TABLE [dbo].[WorkTypes] CHECK CONSTRAINT [FK_WorkTypes_Words]
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AlbumTypes_CheckIfUsed] 
@Id int
as begin

select count(*)  from Packages where FKAlbumType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AlbumTypes_Delete]
@Id bigint,
@WordId bigint
as begin


delete  AlbumTypes 
where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[AlbumTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[AlbumTypes]
           ([FKWord_Id]
           )
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AlbumTypes_SelectAll] 
as begin 

select AlbumTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from AlbumTypes

join Words on Words.Id= AlbumTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AlbumTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select AlbumTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from AlbumTypes

join Words on Words.Id= AlbumTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[AlbumTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 
end


GO
/****** Object:  StoredProcedure [dbo].[Branches_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Branches_CheckIfUsed] 
@Id bigint
as begin

select count(*) from Enquires where Enquires.FKBranch_Id=@Id
union
select count(*) from Users    where Users.FKpranch_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_CheckIsBasicBranch]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Branches_CheckIsBasicBranch]
@BranchId int 
as begin 

select count(*) from Branches where Id=@BranchId and IsBasic =1
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Branches_Delete]
@Id bigint
as begin
delete  Branches where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  proc [dbo].[Branches_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@Address nvarchar(max),
@Phone nvarchar(50),
@CountryId int , 
@CityId int ,
@WordId int output,
@IsBasic bit
as begin
-- Reset All Branches IsBasic
 if(@IsBasic =1)
		   update Branches set IsBasic=0

-- Insert Word 
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn


-- Insert Target
INSERT INTO [dbo].[Branches]
           ([Address]
           ,PhoneNo
           ,[FkCountry_Id]
           ,[FKCity_Id]
           ,[FKWord_Id],
		   IsBasic)
		   values (@Address,@Phone,@CountryId,@CityId,@WordId,
		   @IsBasic)

		  

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[Branches_SelectByAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Branches_SelectByAll]
as begin 
select 
		Branches.*,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn

from Branches
join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Branches_SelectByFilter]
--Paging
	@Skip int , 
	@Take int 

as begin 
select 
		Branches.*,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn,
		(select COUNT(Id) from Enquires where FKBranch_Id=Branches.Id) as EnquiresCount

from Branches

join Countries on Countries.Id=Branches.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Branches.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id
 
join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id

	order by Branches.Id desc
	offset @Skip rows
	Fetch next @Take Rows Only

end
GO
/****** Object:  StoredProcedure [dbo].[Branches_SelectByPk]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Branches_SelectByPk]
@Id bigint 
as begin 
select 
		Branches.*,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		BrancheWord.Ar as BrancheNameAr,
		BrancheWord.En as BrancheNameEn
 
from Branches

join Countries on Countries.Id=Branches.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Branches.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id

join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id

 
where Branches.Id = @Id
end 
GO
/****** Object:  StoredProcedure [dbo].[Branches_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  proc [dbo].[Branches_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@Address nvarchar(max),
@Phone nvarchar(50),
@CountryId int , 
@CityId int ,
@WordId bigint,
@IsBasic bit,
@FKArchivingAndSaveingEmployee_Id bigint,
@FKImplementationEmployeeId_Id bigint,
@FKCoordinationEmployee_Id bigint,
@FKArchivingAndSaveingAnotherBranch_Id int


as begin
-- Reset All Branches IsBasic
 if(@IsBasic =1)
		   update Branches set IsBasic=0;

-- Update Word 
exec  dbo.Words_Update @WordId, @NameAr,@NameEn

declare @BranchIsBeforUsed int;
exec @BranchIsBeforUsed=[dbo].[Branches_CheckIfUsed] @Id; 
-- Insert Target

--لا يمكن تعديل الدولة والمدينة اذا  كانت مستخدمة من قبل
if(@BranchIsBeforUsed =0)
update [dbo].[Branches]
           set [Address]=@Address
           ,PhoneNo=@Phone
           ,[FkCountry_Id]= @CountryId
           ,[FKCity_Id]=    @CityId,
		    IsBasic=@IsBasic,
			FKArchivingAndSaveingEmployee_Id=	@FKArchivingAndSaveingEmployee_Id,
			FKCoordinationEmployee_Id=	@FKCoordinationEmployee_Id,
			FKImplementationEmployeeId_Id=		@FKImplementationEmployeeId_Id,
			FKArchivingAndSaveingAnotherBranch_Id=@FKArchivingAndSaveingAnotherBranch_Id

			where Branches.Id=@Id
else
			update [dbo].[Branches]
           set [Address]=@Address
           ,PhoneNo=@Phone,
		    IsBasic=@IsBasic,
			FKArchivingAndSaveingEmployee_Id=	@FKArchivingAndSaveingEmployee_Id,
			FKCoordinationEmployee_Id=	@FKCoordinationEmployee_Id,
			FKImplementationEmployeeId_Id=		@FKImplementationEmployeeId_Id,
			FKArchivingAndSaveingAnotherBranch_Id=@FKArchivingAndSaveingAnotherBranch_Id

			where Branches.Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[Cities_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Cities_CheckIfUsed] 
@Id bigint
as begin

select 
count(*)from Users where FkCity_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Cities_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Cities_Delete]
@Id bigint
as begin
delete  Cities where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Cities_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[Cities_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@CountryId int

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[Cities]
           ([FKWord_Id]
           ,FKCountry_Id)
     VALUES
           (@WordId,@CountryId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[Cities_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Cities_SelectAll] 

as begin 
select Cities.* ,
Words.Ar,
Words.En
from Cities
join Words on Words.Id=Cities.FKWord_Id
end 

 
GO
/****** Object:  StoredProcedure [dbo].[Cities_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Cities_SelectByFilter] 
@CountryId int
as begin 
select Cities.* ,
Words.Ar,
Words.En
from Cities
join Words on Words.Id=Cities.FKWord_Id
where FKCountry_Id=@CountryId
end 

 
GO
/****** Object:  StoredProcedure [dbo].[Cities_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[Cities_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 
end


GO
/****** Object:  StoredProcedure [dbo].[Countries_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Countries_CheckIfUsed] 
@Id bigint
as begin
declare @count int ;
select 
(count(*)-1) as countr from countries 
left join users on users.FkCountry_Id=countries.Id
left join Branches on Branches.FkCountry_Id=countries.Id

where countries.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Countries_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Countries_Delete]
@Id bigint
as begin


delete Cities where FKCountry_Id=@Id
delete  Countries where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Countries_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[Countries_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@IsoCode nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[Countries]
           ([FKWord_Id]
           ,[IsoCode])
     VALUES
           (@WordId,@IsoCode)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[Countries_IsoCodeBeforUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Countries_IsoCodeBeforUsed] 
@Id bigint,
@IsoCode nvarchar(50)
as begin

select count(*) from Countries where IsoCode=@IsoCode
and (@Id = 0 or @Id is null or Id!=@Id) 

end
GO
/****** Object:  StoredProcedure [dbo].[Countries_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Countries_SelectAll] 

as begin 
select Countries.* ,
Words.Ar,
Words.En
from Countries
join Words on Words.Id=Countries.FKWord_Id
end 

 
GO
/****** Object:  StoredProcedure [dbo].[Countries_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Countries_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select Countries.*,
Words.Ar as NameAr,
Words.En as NameEn from Countries

join Words on Words.Id= Countries.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[Countries_SelectWithCitiesByPk]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Countries_SelectWithCitiesByPk] 
@Id int 
as begin 
select Countries.* ,
Words.Ar as CountryNameAr,
Words.En as CountryNameEn ,

Cities.Id as CityId, 
Cities.FKWord_Id as CityFkWord_Id,
CityWord.Ar as CityNameAr,
CityWord.En as CityNameEn 

from Countries
join Words on Words.Id=Countries.FKWord_Id
left join Cities on Cities.FKCountry_Id=Countries.Id
left join Words as CityWord on CityWord.Id=Cities.FKWord_Id

where Countries.Id=@Id
end 

 
GO
/****** Object:  StoredProcedure [dbo].[Countries_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[Countries_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@IsoCode nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
update Countries 
set IsoCode=@IsoCode
where Id=@Id

end


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_CheckIfInserted]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeeDistributionWorks_CheckIfInserted]
 
@WorkTypeId int,
--@EmployeeId bigint,
@EventId bigint,
@BranchId int,
@IsAnotherBranch bit
as begin
select  count(*) from  [dbo].[EmployeeDistributionWorks]
where [FKWorkType_Id]=@WorkTypeId 
--and	  [FKEmployee_Id]=@EmployeeId
and   FKEvent_Id=@EventId
and FKBranch_Id=@BranchId
and IsAnotherBranch=@isAnotherBranch
		    
end


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EmployeeDistributionWorks_Delete]
@Id bigint
as begin
DELETE FROM [dbo].[EmployeeDistributionWorks]
      where Id=@Id
end 


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeeDistributionWorks_Insert]
@Id	bigint	output,
@WorkTypeId int,
@EmployeeId bigint,
@EventId bigint,
@IsAnotherBranch bit,
@BranchId int
as begin
INSERT INTO [dbo].[EmployeeDistributionWorks]
           ([FKWorkType_Id]
           ,[FKEmployee_Id],
		   FKEvent_Id,
		   IsAnotherBranch,
		   FKBranch_Id)
     VALUES
           (@WorkTypeId,@EmployeeId,@EventId,
		   @IsAnotherBranch,
		   @BranchId)

		   select @Id=@@IDENTITY



		   select EmployeeDistributionWorks.*,
Users.UserName,
Users.FKAccountType_Id,
	CONVERT(bit,0) as IsFinshed,
	 words.Ar as BranchNameAr,
	 words.En as BranchNameEn
		from  EmployeeDistributionWorks
		join Users on users.Id = EmployeeDistributionWorks.FKEmployee_Id
		join Branches on Branches.Id=EmployeeDistributionWorks.FKBranch_Id
		join words on words.Id=Branches.FKWord_Id
where EmployeeDistributionWorks.Id=@Id


end


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_SelectByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeeDistributionWorks_SelectByEventId] 
@EventId bigint

as begin 

select EmployeeDistributionWorks.*,
Users.UserName,
Users.FKAccountType_Id,
	ISNULL((select top 1 IsFinshed from EventWorksStatusHistory
	where FKEvent_Id=@EventId 
	and FKWorkType_Id=EmployeeDistributionWorks.FKWorkType_Id 
	and FKUsre_Id=EmployeeDistributionWorks.FKEmployee_Id	
	 ),0)	as IsFinshed,
	 words.Ar as BranchNameAr,
	 words.En as BranchNameEn
		from  EmployeeDistributionWorks
		

		join Users on users.Id = EmployeeDistributionWorks.FKEmployee_Id
		join Branches on Branches.Id=EmployeeDistributionWorks.FKBranch_Id
		join words on words.Id=Branches.FKWord_Id
where FKEvent_Id=@EventId

end 
GO
/****** Object:  StoredProcedure [dbo].[Employees_CheckAllowAccessToEventForUpdateWorks]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Employees_CheckAllowAccessToEventForUpdateWorks] 
@IsAdmin bit , 
@IsClint bit,
@IsBranchManger bit , 
@eventId bigint,
@workTypeId int,
@userLoggedId bigint,
@BranchId int 
as begin 

--اذا كان المدير العام فيجب يرجع بـ ترو
if(@IsAdmin=1) select 1
--اذا كان عميل فيجب ان يكون هوا صاحب تلك المناسبة
else if (@IsClint=1)
select count(*) from Events where Id=@eventId and FKClinet_Id=@userLoggedId

-- اذا كان مدير فرع اذا يجب ان يكون هوا مدير على هذة المناسبة
else if (@IsBranchManger=1)
select count(*) from Events where Id=@eventId and FKBranch_Id=@BranchId

/*
او التحقق من اى شخص موجود لهذا المناسبة مثل الشخص المتعاون او الموظق او المصور
*/
else  
select count(*) from EmployeeDistributionWorks 
where FKEvent_Id=@eventId
and FKWorkType_Id=@workTypeId
and FKEmployee_Id=@userLoggedId
 



end
GO
/****** Object:  StoredProcedure [dbo].[Employees_SelectWorks]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Employees_SelectWorks]
@EmpId bigint
as begin 
select EmployeesWorks.*,
Words.Ar as WorkNameAr,
Words.En as WorkNameEn,
WorkTypes.PageUrl,

(select count(Id) from EmployeeDistributionWorks 
		where 
		FKWorkType_Id=EmployeesWorks.FKWorkType_Id 
		and FKEmployee_Id=@EmpId  
		--يجب ان يكون هذة المناسبة انتهت فى المهمة السابقة
		and  dbo.EventWorksStatusIsFinsed_CheckIfFinshedFun(EmployeeDistributionWorks.FKEvent_Id,EmployeeDistributionWorks.FKWorkType_Id-1) = 1 ) as WorksCount

from WorkTypes 
  join EmployeesWorks on EmployeesWorks.FKUser_Id=@EmpId and EmployeesWorks.FkWorkType_Id=WorkTypes.Id
  join Words on Words.Id=WorkTypes.FKWord_Id

end
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_CheckIfInserted]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeesWorks_CheckIfInserted]

@WorkTypeId int ,
@UserId bigint
as begin 

select count(*)  from EmployeesWorks 
 where FkWorkType_Id=@WorkTypeId and FKUser_Id=@UserId 

end 
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeesWorks_Delete]
@UserId bigint
as begin 
delete EmployeesWorks where FKUser_Id=@UserId

end 
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeesWorks_Insert]
@WorkType_Id	int, 
@UserId	bigint 
as begin 
insert EmployeesWorks (FkWorkType_Id,FKUser_Id)values(@WorkType_Id,@UserId)
end 
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_SelectByUserId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeesWorks_SelectByUserId] 
@UserId bigint

as begin 

select * from EmployeesWorks where FKUser_Id=@UserId

end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_CheckFromOwner]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquires_CheckFromOwner]
@EnquiryOrEventId bigint,
@UsereLoggadId bigint 
as begin
select count(*) from Enquires where FkClinet_Id=@UsereLoggadId and Id=@EnquiryOrEventId

end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_CheckIfCreatedEvent]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquires_CheckIfCreatedEvent]
@EnquiryId bigint 

as begin 
select count(*) from Events where Id=@EnquiryId

end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_CheckIfWithBranch]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquires_CheckIfWithBranch]
@EnquiryId bigint
as begin 

select count(*) from Enquires where Id=@EnquiryId and IsWithBranch=1

end
GO
/****** Object:  StoredProcedure [dbo].[Enquires_Closed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquires_Closed]
@EnquiryId bigint ,
@DateTime datetime
as begin 
--اغلاق الاستفسار
 update Enquires
	  set IsClosed=1 , 
	  ClosedDateTime = @DateTime,
	  IsWithBranch=1
	  
	  where Id=@EnquiryId 


	  --ارجاع معرفات جوجل من اجل حذفهم
 select 
	           events.ClendarEventId as Event_ClendarEventId,
			   events.VistToCoordinationClendarEventId,
			   EnquiryStatus.ScheduleVisitDateClendarEventId
	from events 
	join EnquiryStatus on EnquiryStatus.FKEnquiry_Id=Events.Id and ScheduleVisitDateClendarEventId is not null
	  where events.Id=@EnquiryId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Enquires_Delete]
 @Id bigint 
 as begin
 delete Enquires where Id =@Id
 delete EventArchives where FKEvent_Id=@Id
 
end

GO
/****** Object:  StoredProcedure [dbo].[Enquires_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Enquires_Insert]
 @Id bigint output,
 @FirstName nvarchar(50),
 @LastName nvarchar(50),
 @PhoneNo nvarchar(50),
 @Day int ,
 @Month int , 
 @Year int ,
 @FkCountry_Id int,
 @FkCity_Id int,
 @FKEnquiryType_Id int,
 @FKUserCreated_Id bigint,
 @Clinet_Id bigint,
 @CreateDateTime datetime,
 @BranchId int,
 @IsLinkedClinet bit,
 @IFWithBranch  bit,
 @PhoneCountryId int


 as begin
 set @Id= (select Isnull(max(Id),0)+1 from Enquires);
 if(@FKEnquiryType_Id =0)
	set @FKEnquiryType_Id=null
 
 if(@BranchId =0)
	set @BranchId=null
	
INSERT INTO [dbo].[Enquires]
           (Id,[FirstName]
           ,[LastName]
           ,[PhoneNo]
           ,[FkCountry_Id]
           ,[FkCity_Id]
           ,[FKEnquiryType_Id]
           ,[FKUserCreated_Id]
           ,[CreateDateTime],
		   [Day],
		   [Month],
		   [Year],
		   FKBranch_Id,
		   IsLinkedClinet,
		   FkClinet_Id,
		   IsWithBranch,FKPhoneCountry_Id
		   )
     VALUES
          (@Id,@FirstName,  
           @LastName,
           @PhoneNo,
           @FkCountry_Id, 
           @FkCity_Id,
           @FKEnquiryType_Id, 
           @FKUserCreated_Id,
           @CreateDateTime,
		   @Day,
		   @Month,
		   @Year,
		   @BranchId,
		   @IsLinkedClinet,
		   @Clinet_Id,
		   @IFWithBranch,@PhoneCountryId 
		   )

end

GO
/****** Object:  StoredProcedure [dbo].[Enquires_IsClosed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquires_IsClosed] 
@EnquiryId bigint 
as begin 

select count(*) from Enquires where Id=@EnquiryId and IsClosed=1

end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquires_SelectByFilter]
--Paging
	@Skip int , 
	@Take int ,
--Filter
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Phone nvarchar(50),
	@Day int ,
	@Month int ,
	@Year int ,
	@CreateDateTimeFrom datetime,
	@CreateDateTimeTo datetime,
	@CountryId int , 
	@CityId int ,
	@EnquiryId int, 
	@BranchId int,
	@IsForCurrentUser bit,
	@CurrentUserLoggadId bigint,
	@IsLinkedClinet bit,
	@CurrentUserBranch bit
	


as begin 
select 
		Enquires.*,
		PhoneCountry.IsoCode as PhoneIsoCode,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		EnquiryTypeWord.Ar as EnquiryTypeNameAr,
		EnquiryTypeWord.En as EnquiryTypeNameEn,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn,
		UserCreated.UserName as EnquiryCreatedUserName,
				dbo.EnquiryPayments_CheckIfPaymentDeposit(Enquires.Id) as IsDepositPaymented

from Enquires

join Countries PhoneCountry on PhoneCountry.Id=Enquires.FKPhoneCountry_Id
join Countries on Countries.Id=Enquires.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Enquires.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id

left join EnquiryTypes on EnquiryTypes.Id=Enquires.FKEnquiryType_Id
left join Words EnquiryTypeWord on EnquiryTypeWord.Id=EnquiryTypes.FKWord_Id

left join Branches on Branches.Id=Enquires.FKBranch_Id
left join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id


left join Users as UserCreated on UserCreated.Id=Enquires.FKUserCreated_Id

where 
	(@IsLinkedClinet is null  or  [Enquires].IsLinkedClinet=@IsLinkedClinet)
 	and 
 	(@IsForCurrentUser = 0 or [Enquires].FKUserCreated_Id=@CurrentUserLoggadId or [Enquires].FkClinet_Id=@CurrentUserLoggadId)
	
	and
	(@EnquiryId is null  or Enquires.FKEnquiryType_Id=@EnquiryId) 
	and 				 
	(@CountryId is null  or Enquires.FkCountry_Id=@CountryId) 
	and 
	(@CityId is null   or Enquires.FkCity_Id=@CityId) 
	and 
	(@Day is null  or [Enquires].[Day]=@Day)
	and 
	(@Month is null  or [Enquires].[Month]=@Month)
	and 
	(@Year is null  or [Enquires].[Year]=@Year)
	and 
	(@CreateDateTimeFrom is null  or Enquires.CreateDateTime>=@CreateDateTimeFrom) 
	and 
	(@CreateDateTimeTo is null  or Enquires.CreateDateTime<=@CreateDateTimeTo) 
	and 
	(@Phone = ''  or Enquires.PhoneNo like '%'+@Phone+'%') 
	and 
	(@FirstName = ''  or Enquires.FirstName like '%'+@FirstName+'%') 
	and 
	(@LastName = ''  or Enquires.LastName like '%'+@LastName+'%') 
	and 
	/*
	مدير الفرع يمكنة مشاهدة الاستفسارات الذى تخص الفرع الخاص بة او الذى قام بـ اشنئها فقط 
	وايضا نظهر فقط الاستفسارات الذى لم تربط بـ مناسبات
	*/	
  (@CurrentUserBranch is null  
   or (Enquires.FKBranch_Id =@BranchId or  Enquires.FKUserCreated_Id=@CurrentUserLoggadId) )
	


	order by Enquires.Id desc
	offset @Skip rows
	Fetch next @Take Rows Only

end
GO
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByPk]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquires_SelectByPk]
@EnquiyId bigint 
as begin 
select 
		Enquires.*,
		PhoneCountry.IsoCode as PhoneIsoCode,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		EnquiryTypeWord.Ar as EnquiryTypeNameAr,
		EnquiryTypeWord.En as EnquiryTypeNameEn,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn,
		UserCreated.UserName as EnquiryCreatedUserName,
		dbo.EnquiryPayments_CheckIfPaymentDeposit(Enquires.Id) as IsDepositPaymented

from Enquires

join Countries PhoneCountry on PhoneCountry.Id=Enquires.FKPhoneCountry_Id
join Countries on Countries.Id=Enquires.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Enquires.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id

left join EnquiryTypes on EnquiryTypes.Id=Enquires.FKEnquiryType_Id
left join Words EnquiryTypeWord on EnquiryTypeWord.Id=EnquiryTypes.FKWord_Id

left join Branches on Branches.Id=Enquires.FKBranch_Id
left join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id

left join Users as UserCreated on UserCreated.Id=Enquires.FKUserCreated_Id




where Enquires.Id = @EnquiyId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByPk_SimpleData]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquires_SelectByPk_SimpleData] 
@EnauiryId bigint 
as begin 
select Enquires.*,

		dbo.EnquiryPayments_CheckIfPaymentDeposit(Enquires.Id) as IsDepositPaymented


from Enquires where Id=@EnauiryId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Enquires_Update]
 @Id bigint,
 @FirstName nvarchar(50),
 @LastName nvarchar(50),
 @PhoneNo nvarchar(50),
 @Day int , 
 @Month int ,
 @Year int,
 @FkCountry_Id int,
 @FkCity_Id int,
 @FKEnquiryType_Id int,
 @NotesCreateDateTime datetime,
 @NotesFkUsereCreatedId bigint,
 @BranchId int,
 @IsWithBranch bit

 as begin
 UPDATE [dbo].[Enquires]
   SET [FirstName] =@FirstName  ,
      [LastName] =@LastName ,
      [PhoneNo] = @PhoneNo,
      [FkCountry_Id] =@FkCountry_Id ,
      [FkCity_Id] =@FkCity_Id ,
      [FKEnquiryType_Id] =@FKEnquiryType_Id,
	  [Day]=@Day,
	  [Month]=@Month,
	  [Year]=@Year,
	  FKBranch_Id=@BranchId,
	  IsWithBranch=@IsWithBranch
    
 WHERE Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[Enquiries_ChangeCreateEventState]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquiries_ChangeCreateEventState]
@Id bigint,
@IsCreatedEvent bit
as begin 
update Enquires 
	   set IsCreatedEvent=@IsCreatedEvent 
	   where Id=   @Id    
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_AcceptFromManger]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryPayments_AcceptFromManger]
@Id	bigint,
@IsDeposit bit,
@EnquiryId bigint
as begin

update [dbo].[EnquiryPayments]
      set [IsAcceptFromManger]=1
	  where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_CheckIfPaymentedDeposit]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryPayments_CheckIfPaymentedDeposit]
@EnquiryId bigint 
as begin 

select dbo.EnquiryPayments_CheckIfPaymentDeposit(@EnquiryId)
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryPayments_Insert]
@Id	bigint output,
@Amount  decimal(18,2),
@IsDeposit bit,
@IsBankTransfer bit,
@TransferImage nvarchar(max),
@IsAcceptFromManger bit,
@DateTime datetime,
@FKEnquiry_Id bigint,
@FKUserCreated_Id bigint
		   
as begin
-- اذا كان هذا دفع كاش اذا يعتبر المدير موافق تلقائى 
if(@IsBankTransfer =0)
set @IsAcceptFromManger=1

INSERT INTO [dbo].[EnquiryPayments]
           ([Amount]
           ,[IsDeposit]
           ,[IsBankTransfer]
           ,[TransferImage]
           ,[IsAcceptFromManger]
           ,[DateTime]
           ,[FKEnquiry_Id]
           ,[FKUserCreated_Id])
     VALUES
           (@Amount,
           @IsDeposit,
           @IsBankTransfer,
           @TransferImage,  
           @IsAcceptFromManger,
           @DateTime, 
           @FKEnquiry_Id,
           @FKUserCreated_Id)

		   select @Id=@@IDENTITY
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_SelectByEnquiryId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryPayments_SelectByEnquiryId]
@EnquiryId bigint

as begin

select 
EnquiryPayments.*, 
Users.UserName as UserCreatedName
from EnquiryPayments  
join Users on Users.Id=EnquiryPayments.FKUserCreated_Id

where FKEnquiry_Id=@EnquiryId

order by Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatus_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryStatus_Insert]
@Notes nvarchar(max),
@DateTime datetime , 
@EnquiryId bigint,
@EnquiryStatusId int, 
@ScheduleVisitDateTime datetime,

@UserCreatedId bigint,
@IFWithBranch  bit,
@EnquiryPaymentId bigint
as begin
INSERT INTO [dbo].[EnquiryStatus]
           ([Notes]
           ,[DateTime]
           ,[FKEnquiry_Id]
           ,[FKEnquiryStatus_Id]
           ,[ScheduleVisitDateTime],
		   FKUserCreated_Id,
		   FKEnquiryPayment_Id)
     VALUES (@Notes,@DateTime,@EnquiryId,@EnquiryStatusId,@ScheduleVisitDateTime,@UserCreatedId,@EnquiryPaymentId)


if(@IFWithBranch is not null)
 update Enquires
	  set IsWithBranch=@IFWithBranch where Id=@EnquiryId 
   
           
		   
end

GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatus_ResetClendersIdsToNull]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryStatus_ResetClendersIdsToNull]
@EnquiryId bigint 
as begin 
update EnquiryStatus set ScheduleVisitDateClendarEventId=null
where FKEnquiry_Id=@EnquiryId
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatus_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryStatus_SelectByFilter]
@EnquiryId bigint ,
@StatusId int
as begin 
select * from EnquiryStatus where FKEnquiry_Id=@EnquiryId 
and (@StatusId is null or  FKEnquiryStatus_Id=@StatusId)
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatus_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryStatus_Update]
@Id bigint ,
@ScheduleVisitDateClendarEventId nvarchar(max)
as begin 
--نقوم بتحديث معرف التاريخ  الخاص بكلندر جوجول
update EnquiryStatus set ScheduleVisitDateClendarEventId=@ScheduleVisitDateClendarEventId
where Id=@Id
--ومعنى ذالك ان المعرفات  الاخرى ملغية لانة يجب  ان تكون زيارة واحدة فقط هى الذى موجودة فى الكلندر 
--ونحن نحذفها حتى نحذفها مرة آخرى من جوجل

update EnquiryStatus set ScheduleVisitDateClendarEventId=null
where Id!=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatusTypes_SelectByEnquiryId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[EnquiryStatusTypes_SelectByEnquiryId]
@EnquiyId bigint 
as begin 
select 
		EnquiryStatus.Id as Status_Id,
		WordEnquiryStatusType.Ar as Status_NameAr,
		WordEnquiryStatusType.En as Status_NameEn,
		EnquiryStatus.Notes as Status_Notes,
		EnquiryStatus.DateTime as Status_CreateDateTime,
		EnquiryStatus.ScheduleVisitDateTime as Status_ScheduleVisitDateTime,
		EnquiryStatus.FKUserCreated_Id as Status_UserCreatedId,
		EnquiryStatus.FKEnquiryPayment_Id	as Status_EnquiryPaymentId,
		EnquiryPayments.Amount,
		UserCreatedStatus.UserName as Status_CreatedUserName

from EnquiryStatus
 
 join Users as UserCreatedStatus on UserCreatedStatus.Id=EnquiryStatus.FKUserCreated_Id

 join EnquiryStatusTypes on EnquiryStatusTypes.Id=EnquiryStatus.FKEnquiryStatus_Id
 join Words  as WordEnquiryStatusType on WordEnquiryStatusType.Id=EnquiryStatusTypes.FKWord_Id
left join EnquiryPayments on EnquiryPayments.Id=EnquiryStatus.FKEnquiryPayment_Id

where EnquiryStatus.FKEnquiry_Id = @EnquiyId
order by EnquiryStatus.Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryStatusTypes_SelectByPK]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryStatusTypes_SelectByPK]
@Id int
as begin

select Words.Ar,Words.En from EnquiryStatusTypes 
join Words on Words.Id=EnquiryStatusTypes.FKWord_Id
where EnquiryStatusTypes.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryTypes_CheckIfUsed] 
@Id bigint
as begin

select 
count(*)from Enquires where FKEnquiryType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryTypes_Delete]
@Id bigint,
@WordId bigint
as begin

delete  EnquiryTypes where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[EnquiryTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[EnquiryTypes]
           ([FKWord_Id])
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create proc [dbo].[EnquiryTypes_SelectAll] 

as begin 

select EnquiryTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from EnquiryTypes

join Words on Words.Id= EnquiryTypes.FKWord_Id

order by Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select EnquiryTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from EnquiryTypes

join Words on Words.Id= EnquiryTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[EnquiryTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 

end


GO
/****** Object:  StoredProcedure [dbo].[EventArchives_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventArchives_Insert] 
@Id					bigint	output,
@FKEvent_Id			bigint	,
@HDNumber			nvarchar(50)	,
@FolderName			nvarchar(50)	,
@DateTime			datetime,
@UserId				bigint
as begin

set @Id   =(select ISNULL(max(Id),0)+1 from EventArchives where FKEvent_Id=@FKEvent_Id);

insert EventArchives   (
Id					,
FKEvent_Id			,
HardDiskNumber			,
FolderName,
DateTime			,
FKUser_Id				
)
values (
@Id					,
@FKEvent_Id			,
@FolderName,
@HDNumber			,
@DateTime			,
@UserId				
)


end 
GO
/****** Object:  StoredProcedure [dbo].[EventArchives_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventArchives_SelectAll]
@EventId bigint,
@UserId bigint
as begin

select 
		ev.Id				as EV_Id,
		ev.FKEvent_Id		as EV_EventId,
		ev.FKUser_Id   	 	as EV_UserId,
		ev.FolderName		as EV_FolderName,
		ev.HardDiskNumber	as EV_HardDiskName,
		ev.DateTime			as EV_DateTime,
		
		evd.Id					as EVD_Id,
		evd.DateTime			as EVD_DateTime,
		evd.MemoryId			as EVD_MemoryId,
		evd.MemoryType			as EVD_MemoryType,
		evd.Notes				as EVD_Notes,
		evd.PhotoNumberFrom		as EVD_PhotoNumberFrom,
		evd.PhotoNumberTo		as EVD_PhotoNumberTo,
		evd.PhotoStartName		as EVD_PhotoStartName

from EventArchives ev
left join EventArchiveDetails evd on evd.FKEventArchive_Id=ev.Id and evd.FKEvent_Id=ev.FKEvent_Id
where ev.FKEvent_Id=@EventId and ev.FKUser_Id=@UserId


end 
GO
/****** Object:  StoredProcedure [dbo].[EventArchives_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventArchives_Update] 
@Id					int	 ,
@FKEvent_Id			bigint	,
@HDNumber			nvarchar(50)	,
@FolderName			nvarchar(50)	
as begin


update EventArchives   

set HardDiskNumber	=@HDNumber		,
FolderName =@FolderName

where 
Id					=@Id and 
FKEvent_Id			=@FKEvent_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[EventArchivesDetails_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventArchivesDetails_Delete] 
@Id					bigint,
@EventId bigint ,
@EventArchifId int
as begin

delete EventArchiveDetails where Id=@Id and FKEvent_Id=@EventId and FKEventArchive_Id=@EventArchifId


end 
GO
/****** Object:  StoredProcedure [dbo].[EventArchivesDetails_Inserrt]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventArchivesDetails_Inserrt] 
@Id	bigint outPut,
@EventId bigint ,
@EventArchiveId int,
@MemoryId nvarchar(50),
@MemoryType nvarchar(50),
@PhotoStartName	nvarchar(50),
@PhotoNumberFrom int ,
@PhotoNumberTo int,
@Notes nvarchar(max),
@DateTime datetime
as begin

set @Id=(select ISNULL(max(Id),0)+1 from EventArchiveDetails where FKEvent_Id=@EventId and FKEventArchive_Id=@EventArchiveId);

insert EventArchiveDetails	 
(Id,FKEvent_Id,FKEventArchive_Id,MemoryId,MemoryType,PhotoStartName,PhotoNumberFrom,PhotoNumberTo,Notes,DateTime)
values
(@Id,@EventId,@EventArchiveId,@MemoryId,@MemoryType,@PhotoStartName,@PhotoNumberFrom,@PhotoNumberTo,@Notes,@DateTime)


end 
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventCoordinations_Delete]
			 
            @Id bigint
			as begin
delete [dbo].[EventCoordinations]
where Id=@Id
			end
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventCoordinations_Insert]
			@TaskNumber int,
            @Task nvarchar(50),
            @StartTime time(7),
            @EndTime time(7),
            @Notes nvarchar(max),
            @FKEvent_Id bigint,
            @FKUserCreated_Id bigint
			as begin
INSERT INTO [dbo].[EventCoordinations]
           (TaskNumber
           ,[Task]
           ,[StartTime]
           ,[EndTime]
           ,[Notes]
           ,[FKEvent_Id]
           ,[FKUserCreated_Id])
     VALUES
           (@TaskNumber  ,
 			@Task ,
			@StartTime,
			@EndTime ,
			@Notes ,
			@FKEvent_Id ,
			@FKUserCreated_Id )

			end
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_SelectByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventCoordinations_SelectByEventId]
			 
            @EventId bigint
			as begin
select EventCoordinations.*,Users.UserName,
EventWorksStatusIsFinshed.* from 
EventCoordinations
join Users on Users.Id=EventCoordinations.FKUserCreated_Id
join EventWorksStatusIsFinshed on EventWorksStatusIsFinshed.EventId=@EventId
where EventCoordinations.FKEvent_Id=@EventId
			end
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_SelectTasksNumber]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventCoordinations_SelectTasksNumber]
			 
            @EventId bigint
			as begin
select EventCoordinations.TaskNumber from 
EventCoordinations

where EventCoordinations.FKEvent_Id=@EventId
			end
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_CheckCanBeAccess]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventPhotographers_CheckCanBeAccess]
@UsereId bigint ,
@EventId bigint
as begin 

/*
لـ نتتحقق بـ ان المصور الحالى يمكنة الوصول الى المناسبة 
ويجب على هذة المناسبة ان تكون مكتملة الاعداد والتنسيق
*/

select count(*) from EventPhotographers 
join EventWorksStatusIsFinshed f on  f.EventId=@EventId
where FKEvent_Id=@EventId and FKUser_Id=@UsereId and f.Coordination=1

end 
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventPhotographers_Delete]

@FKEvent_Id bigint 

as begin

delete EventPhotographers where FKEvent_Id=@FKEvent_Id
end 
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventPhotographers_Insert]

@Id bigint output,
@FKEvent_Id bigint ,
@FkUser_Id bigint , 
@CreateDateTime DateTime 

as begin

set @Id=(select isnull(MAX(Id),0)+1 from EventPhotographers where FKEvent_Id=@FKEvent_Id);

insert EventPhotographers values(@Id,@FKEvent_Id,@FkUser_Id,@CreateDateTime)

end 
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_SelectAllByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventPhotographers_SelectAllByEventId]

@FKEvent_Id bigint 

as begin
select * from EventPhotographers where FKEvent_Id=@FKEvent_Id
end 
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_SelectAllUsers]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventPhotographers_SelectAllUsers]

@FKEvent_Id bigint 

as begin
select users.*,
EventPhotographers.CreateDateTime as EveCreateDateTime,
EventPhotographers.Id as EveId
		from users 
left join EventPhotographers on EventPhotographers.FKUser_Id = Users.Id and FKEvent_Id=@FKEvent_Id
where  
  Users.FKAccountType_Id=7 or --Photograhper 
  Users.FKAccountType_Id=6 --	Helper
and Users.FKPranch_Id=(select top 1 FKPranch_Id from events where Id=@FKEvent_Id)   

end 
GO
/****** Object:  StoredProcedure [dbo].[EventPhotographers_SelectEventsByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create proc [dbo].[EventPhotographers_SelectEventsByFilter]
		   --Paging
		   @Skip int , 
		   @Take int ,
		   --Filter
		   @IsClinetCustomLogo            bit,
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTimeTo			   datetime,
           @EventDateTimeFrom			   datetime,
           @FKPackage_Id				int,
		   @EmplolyeeId bigint
as begin 

select Events.* ,
	   EventWorksStatusIsFinshed.*,
	   Enquires.FirstName +' '+ Enquires.LastName as EnquiryName ,
	   Enquires.IsClosed ,
	   WordBranche.Ar	as Branch_NameAr, 
	   WordBranche.En	as Branch_NameEn,
	   WordPackage.Ar	as Package_NameAr, 
	   WordPackage.En	as Package_NameEn,
	   WordPrintNamesType.Ar	as WordPrintNamesType_NameAr, 
	   WordPrintNamesType.En	as WordPrintNamesType_NameEn

	from Events
	
	join EventPhotographers 
	on EventPhotographers.FKUser_Id=@EmplolyeeId and EventPhotographers.FKEvent_Id=Events.Id
 	join Enquires on Enquires.Id = Events.Id
	join Branches   on Branches.Id = Events.FKBranch_Id
	join Packages   on Packages.Id = Events.FKPackage_Id
	left join PrintNamesTypes   on PrintNamesTypes.Id = Events.FKPrintNameType_Id
	join Words as WordBranche   on WordBranche.Id = Branches.FKWord_Id
	join Words as WordPackage   on WordPackage.Id = Packages.FkWordName_Id
	left join Words as WordPrintNamesType   on WordPrintNamesType.Id = PrintNamesTypes.FKWord_Id
	join EventWorksStatusIsFinshed on EventWorksStatusIsFinshed.EventId=Events.Id
	where 
	--جلب المناسبات الذى لم تغلق فقط
	(Enquires.IsClosed=0 or Enquires.IsClosed is null)  and 
	--التحقق بان المهمة السابقة قد انتهت
 EventWorksStatusIsFinshed.Coordination             	=1
	and
	-- الفيلتر
	(     @IsClinetCustomLogo	is null or	Events.IsClinetCustomLogo	=@IsClinetCustomLogo	)																					
	and(  @IsNamesAr           	is null or	Events.IsNamesAr           	=@IsNamesAr				)					
	and(  @NameGroom			is null or	Events.NameGroom			=@NameGroom				)					
	and(  @NameBride			is null or	Events.NameBride			=@NameBride				)					
	and(  @EventDateTimeFrom	is null or	Events.EventDateTime>=		@EventDateTimeFrom			)					
	and(  @EventDateTimeTo		is null or	Events.EventDateTime<=		@EventDateTimeTo			)					
	and(  @FKPackage_Id			is null or	Events.FKPackage_Id			=@FKPackage_Id			)					
	


	order by Id  desc
	Offset @skip rows
	Fetch Next @Take rows only



end
GO
/****** Object:  StoredProcedure [dbo].[Events_CheckFromDateEventIsFinshed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_CheckFromDateEventIsFinshed]--27,null
@EventId bigint,
@DateTime DateTime
as begin 

select count(*) from Events where Id=@EventId and Events.EventDateTime<@DateTime
end
GO
/****** Object:  StoredProcedure [dbo].[Events_CheckFromDateEventIsFinshedBranchId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Events_CheckFromDateEventIsFinshedBranchId]
@EventId bigint,
@BranchId int
as begin 
select count(*) from Events where Id=@EventId and FKBranch_Id=@BranchId
end
GO
/****** Object:  StoredProcedure [dbo].[Events_CountsByYear]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Events_CountsByYear]
@Year int
as begin
select count(*)
		from Events
		where year(Events.EventDateTime)=@Year
end
GO
/****** Object:  StoredProcedure [dbo].[Events_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Insert]
		   @Id	bigint  ,
		   @IsClinetCustomLogo            bit,
           @LogoFilePath               nvarchar(max),
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTime			   datetime,
           @CreateDateTime			   datetime,
           @FKPackage_Id				int,
           @FKPrintNameType_Id			int,
           @FKClinet_Id					bigint,
           @Notes						nvarchar(max),
           @FKUserCreaed_Id				bigint,
           @FKBranch_Id					int,
		   @PackagePrice decimal(18,2),
		   @PackageNamsArExtraPrice decimal(18,2),
		   @VistToCoordinationDateTime datetime,
		   @NamesPrintingPrice decimal(18,2)

as begin
--نتحقق هل هوا استكمل البيانات ام لاء
declare @IsDataPerfection bit ;
if(@NameGroom is not null and @NameBride is not null )
set @IsDataPerfection=1;

INSERT INTO [dbo].[Events]
           (Id,[IsClinetCustomLogo] ,[LogoFilePath]
           ,[IsNamesAr],[NameGroom],[NameBride],[EventDateTime]
           ,[CreateDateTime],[FKPackage_Id]
           ,[FKPrintNameType_Id],[FKClinet_Id],[Notes]
           ,[FKUserCreaed_Id],[FKBranch_Id],PackagePrice ,PackageNamsArExtraPrice ,
		   VistToCoordinationDateTime,NamesPrintingPrice)
     VALUES
           (@Id,@IsClinetCustomLogo,@LogoFilePath,
			@IsNamesAr,@NameGroom,
			@NameBride,@EventDateTime,
			@CreateDateTime,@FKPackage_Id,
			@FKPrintNameType_Id,@FKClinet_Id,	
			@Notes,@FKUserCreaed_Id,	
			@FKBranch_Id,@PackagePrice ,
		    @PackageNamsArExtraPrice,@VistToCoordinationDateTime,
			@NamesPrintingPrice)

		
insert EventWorksStatusIsFinshed (EventId,Booking,DataPerfection)
values (@Id,1,@IsDataPerfection)

			 
end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectByFilter]
		   --Paging
		   @Skip int , 
		   @Take int ,
		   --Filter
		   @IsClinetCustomLogo            bit,
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTimeTo			   datetime,
           @EventDateTimeFrom			   datetime,
           @CreateDateTimeTo			   datetime,
           @CreateDateTimeFrom			   datetime,
           @FKPackage_Id				int,
           @FKPrintNameType_Id			int,
           @FKBranch_Id					int,
		   @IsForCurrentClinet bit,
		   @CurrentClinetId bigint


		   
as begin 

select Events.* ,
	   Enquires.FirstName +' '+ Enquires.LastName as EnquiryName ,
	   Enquires.IsClosed ,
	   WordBranche.Ar	as Branch_NameAr, 
	   WordBranche.En	as Branch_NameEn,
	   WordPackage.Ar	as Package_NameAr, 
	   WordPackage.En	as Package_NameEn,
		WordPrintNamesType.Ar	as WordPrintNamesType_NameAr, 
		WordPrintNamesType.En	as WordPrintNamesType_NameEn,
	   dbo.EnquiryPayments_CheckIfPaymentDeposit(Events.Id) as IsDepositPaymented,
	 dbo.EnquiryPayments_TotalPaymentsActive(Events.Id) as   TotalPaymentsActivated

	from Events

left	join Enquires on Enquires.Id = Events.Id
	
	join Branches   on Branches.Id = Events.FKBranch_Id
	join Packages   on Packages.Id = Events.FKPackage_Id
left	join PrintNamesTypes   on PrintNamesTypes.Id = Events.FKPrintNameType_Id

	join Words as WordBranche   on WordBranche.Id = Branches.FKWord_Id
	join Words as WordPackage   on WordPackage.Id = Packages.FkWordName_Id
left	join Words as WordPrintNamesType   on WordPrintNamesType.Id = PrintNamesTypes.FKWord_Id

	where 
	(     @IsClinetCustomLogo	is null or	Events.IsClinetCustomLogo	=@IsClinetCustomLogo	)																					
	and(  @IsNamesAr           	is null or	Events.IsNamesAr           	=@IsNamesAr				)					
	and(  @NameGroom			is null or	Events.NameGroom			=@NameGroom				)					
	and(  @NameBride			is null or	Events.NameBride			=@NameBride				)					
	and(  @EventDateTimeFrom	is null or	Events.EventDateTime>=		@EventDateTimeFrom			)					
	and(  @EventDateTimeTo		is null or	Events.EventDateTime<=		@EventDateTimeTo			)					
	and(  @CreateDateTimeFrom	is null or	Events.CreateDateTime>=		@CreateDateTimeFrom		)					
	and(  @CreateDateTimeTo		is null or	Events.CreateDateTime<=		@CreateDateTimeTo		)					
	and(  @FKPackage_Id			is null or	Events.FKPackage_Id			=@FKPackage_Id			)					
	and(  @FKPrintNameType_Id	is null or	Events.FKPrintNameType_Id	=@FKPrintNameType_Id	)					
	and(  @FKBranch_Id			is null or	Events.FKBranch_Id			=@FKBranch_Id			)						
	and(  @IsForCurrentClinet	is null or	Events.FKClinet_Id =@CurrentClinetId)					


	order by Id  desc
	Offset @skip rows
	Fetch Next @Take rows only



end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectByFilterForEmployee]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE proc [dbo].[Events_SelectByFilterForEmployee]
		   --Paging
		   @Skip int , 
		   @Take int ,
		   --Filter
		   @IsClinetCustomLogo            bit,
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTimeTo			   datetime,
           @EventDateTimeFrom			   datetime,
           @FKPackage_Id				int,
           @FKPrintNameType_Id			int,
		   @WorkTypeId	int,
		   @EmplolyeeId bigint,
		   @IsFinshed bit
as begin 

select Events.* ,
	   EventWorksStatusIsFinshed.*,
	   Enquires.FirstName +' '+ Enquires.LastName as EnquiryName ,
	   Enquires.IsClosed ,
	   WordBranche.Ar	as Branch_NameAr, 
	   WordBranche.En	as Branch_NameEn,
	   WordPackage.Ar	as Package_NameAr, 
	   WordPackage.En	as Package_NameEn,
	   WordPrintNamesType.Ar	as WordPrintNamesType_NameAr, 
	   WordPrintNamesType.En	as WordPrintNamesType_NameEn

	from Events
	
	join EmployeeDistributionWorks
	on EmployeeDistributionWorks.FKEvent_Id=Events.Id and 
	EmployeeDistributionWorks.FKEmployee_Id=@EmplolyeeId and 
	EmployeeDistributionWorks.FKWorkType_Id=@WorkTypeId

 	join Enquires on Enquires.Id = Events.Id
	join Branches   on Branches.Id = Events.FKBranch_Id
	join Packages   on Packages.Id = Events.FKPackage_Id
	left join PrintNamesTypes   on PrintNamesTypes.Id = Events.FKPrintNameType_Id
	join Words as WordBranche   on WordBranche.Id = Branches.FKWord_Id
	join Words as WordPackage   on WordPackage.Id = Packages.FkWordName_Id
	left join Words as WordPrintNamesType   on WordPrintNamesType.Id = PrintNamesTypes.FKWord_Id
	join EventWorksStatusIsFinshed on EventWorksStatusIsFinshed.EventId=Events.Id
	where 
	--جلب المناسبات الذى لم تغلق فقط
	(Enquires.IsClosed=0 or Enquires.IsClosed is null)  and 
	--التحقق بان المهمة السابقة قد انتهت
	(
	--التحقق بان مثلا اذا كانت هذة عملية التنسيق فيجب عملية استكمال البيانات تكون انتهت
	(@WorkTypeId =3 and EventWorksStatusIsFinshed. DataPerfection           	=1)
or	(@WorkTypeId =4 and EventWorksStatusIsFinshed. Coordination             	=1)
or	(@WorkTypeId =5 and EventWorksStatusIsFinshed. Implementation           	=1)
or	(@WorkTypeId =6 and EventWorksStatusIsFinshed. ArchivingAndSaveing      	=1)
or	(@WorkTypeId =7 and EventWorksStatusIsFinshed. ProductProcessing        	=1)
or	(@WorkTypeId =8 and EventWorksStatusIsFinshed. Chooseing                	=1)
or	(@WorkTypeId =9 and EventWorksStatusIsFinshed. DigitalProcessing        	=1)
or	(@WorkTypeId =10 and EventWorksStatusIsFinshed.PreparingForPrinting     	=1)
or	(@WorkTypeId =11 and EventWorksStatusIsFinshed.Manufacturing            	=1)
or	(@WorkTypeId =12 and EventWorksStatusIsFinshed.QualityAndReview         	=1)
or	(@WorkTypeId =13 and EventWorksStatusIsFinshed.Packaging                	=1)
or	(@WorkTypeId =14 and EventWorksStatusIsFinshed.TransmissionAndDelivery  	=1)
	) 
	--/التحقق بان المهمة السابقة قد انتهت
	and
	-- الفيلتر
	(     @IsClinetCustomLogo	is null or	Events.IsClinetCustomLogo	=@IsClinetCustomLogo	)																					
	and(  @IsNamesAr           	is null or	Events.IsNamesAr           	=@IsNamesAr				)					
	and(  @NameGroom			is null or	Events.NameGroom			=@NameGroom				)					
	and(  @NameBride			is null or	Events.NameBride			=@NameBride				)					
	and(  @EventDateTimeFrom	is null or	Events.EventDateTime>=		@EventDateTimeFrom			)					
	and(  @EventDateTimeTo		is null or	Events.EventDateTime<=		@EventDateTimeTo			)					
	and(  @FKPackage_Id			is null or	Events.FKPackage_Id			=@FKPackage_Id			)					
	and(  @FKPrintNameType_Id	is null or	Events.FKPrintNameType_Id	=@FKPrintNameType_Id	)
	and(  @IsFinshed			is null or	dbo.Events_CheckIfWorkFinshed(Events.Id,@WorkTypeId,@EmplolyeeId)=@IsFinshed	)
	

	


	order by Id  desc
	Offset @skip rows
	Fetch Next @Take rows only



end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectByPK]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectByPK]
@Id bigint
as begin 

select Events.*,
dbo.EnquiryPayments_TotalPayments(@Id) as TotalPayments,
dbo.EnquiryPayments_TotalPaymentsActive(@Id) as TotalPaymentsActivated

from Events

	where Events.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectInformation]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectInformation]
@Id bigint
as begin 

select Events.* ,
EventWorksStatusIsFinshed.* ,
	   Enquires.FirstName +' '+ Enquires.LastName as EnquiryName ,
	   Enquires.IsClosed ,
	   PackageWord.Ar as Package_NameAr,
	   PackageWord.En as Package_NameEn ,
	   Packages.IsPrintNamesFree as Package_IsPrintNamesFree,
	   PrintNameTypeWord.Ar as PrintNameType_NameAr,
	   PrintNameTypeWord.En as PrintNameType_NameEn ,
	    
	   BranchWord.Ar as Branch_NameAr,
	   BranchWord.En as Branch_NameEn ,
	   
	   Clinet.UserName as Clinet_UserName,
	   UserCreated.UserName as UserCreated_UserName,
	   dbo.EnquiryPayments_TotalPayments(@Id) as TotalPayments,
dbo.EnquiryPayments_TotalPaymentsActive(@Id) as TotalPaymentsActivated
	   
	from Events

left	join Enquires on Enquires.Id = Events.Id
	
	join Packages on Packages.Id = Events.FKPackage_Id
	join Words as PackageWord  on PackageWord.Id = Packages.FkWordName_Id
	
left	join PrintNamesTypes on PrintNamesTypes.Id = Events.FKPrintNameType_Id
left	join Words as PrintNameTypeWord  on PrintNameTypeWord.Id = PrintNamesTypes.FKWord_Id
	
	 
	join Branches on Branches.Id = Events.FKBranch_Id
	join Words as BranchWord  on BranchWord.Id = Branches.FKWord_Id


	join Users as Clinet  on Clinet.Id = Events.FKClinet_Id
	join Users as UserCreated  on UserCreated.Id = Events.FKUserCreaed_Id
join EventWorksStatusIsFinshed on EventWorksStatusIsFinshed.EventId=Events.Id

	where Events.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Events_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Update]
		   @Id	bigint  ,
		   @IsClinetCustomLogo            bit,
           @LogoFilePath               nvarchar(max),
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTime			   datetime,
           @FKPackage_Id				int,
           @FKPrintNameType_Id			int,
           @Notes						nvarchar(max),
		   @PackagePrice decimal(18,2),
		   @PackageNamsArExtraPrice decimal(18,2),
		   @VistToCoordinationDateTime datetime,
		   @NamesPrintingPrice decimal(18,2)

as begin

--نتحقق هل هوا استكمل البيانات ام لاء
declare @IsDataPerfection bit ;
if(@NameGroom is not null and @NameBride is not null )
set @IsDataPerfection=1;

update [dbo].[Events]
          set [IsClinetCustomLogo]  =@IsClinetCustomLogo    										 
           ,[LogoFilePath]			=@LogoFilePath           
           ,[IsNamesAr]				=@IsNamesAr              
           ,[NameGroom]				=@NameGroom				 
           ,[NameBride]				=@NameBride				 
           ,[EventDateTime]			=@EventDateTime			 
           ,[FKPackage_Id]			=@FKPackage_Id			 
           ,[FKPrintNameType_Id]	=@FKPrintNameType_Id		 
           ,[Notes]					=@Notes	,
		    PackagePrice= @PackagePrice ,
		    PackageNamsArExtraPrice= @PackageNamsArExtraPrice ,
			VistToCoordinationDateTime=@VistToCoordinationDateTime,
			NamesPrintingPrice=@NamesPrintingPrice
			where Id=@Id
   
   -- نقوم بتحديث مرحلة استكمال البيانات بانها انتهت
   if(@IsDataPerfection =1)
    exec EventWorksStatusIsFinshed_Update @Id,1,2


end									
			 
			 
			 
			 
			
			
			
			
			
			
			
				
				
			
				
			
GO
/****** Object:  StoredProcedure [dbo].[Events_Update2]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Update2]
		   @Id	bigint  ,
		   @IsClinetCustomLogo            bit,
           @LogoFilePath               nvarchar(max),
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @FKPrintNameType_Id			int,
		      @PackagePrice decimal(18,2),
		   @PackageNamsArExtraPrice decimal(18,2),
		   @NamesPrintingPrice decimal(18,2)

as begin
--نتحقق هل هوا استكمل البيانات ام لاء
declare @IsDataPerfection bit ;
if(@NameGroom is not null and @NameBride is not null )
set @IsDataPerfection=1;

update [dbo].[Events]
          set [IsClinetCustomLogo]  =@IsClinetCustomLogo    										 
           ,[LogoFilePath]			=@LogoFilePath           
           ,[IsNamesAr]				=@IsNamesAr              
           ,[NameGroom]				=@NameGroom				 
           ,[NameBride]				=@NameBride				 
           ,[FKPrintNameType_Id]	=@FKPrintNameType_Id	,	 
		     PackagePrice= @PackagePrice ,
		  PackageNamsArExtraPrice= @PackageNamsArExtraPrice ,
		  NamesPrintingPrice=@NamesPrintingPrice
   
			where Id=@Id
   
   -- نقوم بتحديث مرحلة استكمال البيانات بانها انتهت
   if(@IsDataPerfection =1)
   exec EventWorksStatusIsFinshed_Update @Id,1,2

end									
			 
			 
			 
			 
			
			
			
			
			
			
			
				
				
			
				
			
GO
/****** Object:  StoredProcedure [dbo].[Events_UpdateCalendarEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc [dbo].[Events_UpdateCalendarEventId]
 @EventId bigint,
 @ClendarEventId nvarchar(max),
 @VistToCoordinationClendarEventId nvarchar(max),
 @IsUpdateVistClendar bit,
 @IsUpdateClendar bit

 as begin

 if(@IsUpdateClendar =1)
 update Events
 set ClendarEventId=@ClendarEventId
 where Id=@EventId

 if(@IsUpdateVistClendar=1)
  update Events
 set VistToCoordinationClendarEventId=@VistToCoordinationClendarEventId
 where Id=@EventId
  

 end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveies_ChartByYear]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveies_ChartByYear]
@Year int
as begin
select 
		Events.EventDateTime,
		(select count(*) from EventSurveies where Id=Events.Id and IsSatisfied=1)as CountIsSatisfied
		from Events
		where year(Events.EventDateTime)=@Year
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveies_DeleteByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveies_DeleteByEventId]
@EventID bigint
as begin
delete EventSurveies where Id=@EventID

		   end

GO
/****** Object:  StoredProcedure [dbo].[EventSurveies_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveies_Insert]
@EventId bigint,
@ClinetId bigint, 
@IsSatisfied bit
as begin 
INSERT INTO [dbo].[EventSurveies]
           ([Id]
           ,[FKClinet_Id]
           ,[IsSatisfied])
     VALUES
           (@EventId,@ClinetId,@IsSatisfied)
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveies_Insert_DeleteByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveies_Insert_DeleteByEventId]
@EventId bigint
as begin
delete EventSurveies where Id=@EventId

		   end

GO
/****** Object:  StoredProcedure [dbo].[EventSurveies_SelectByPK]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveies_SelectByPK]
@EventId bigint 
as begin 
select * from EventSurveies where Id=@EventId
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurvey_CheckIfIsInserted]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurvey_CheckIfIsInserted] 
@EventId bigint
as begin 
select count(*) from EventSurveyQuestionAnswerer where FKEventSurvey_Id=@EventId 

end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionAnswerer_DeleteByEventSurveyId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestionAnswerer_DeleteByEventSurveyId]
@EventSurveyId bigint
as begin
delete EventSurveyQuestionAnswerer where FKEventSurvey_Id=@EventSurveyId

		   end

GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionAnswerer_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestionAnswerer_Insert]
@EventSurveyQuestionId bigint,
@Answer nvarchar(max),
@DateTime DateTime,
@SurveyQuestionTypeId int,
@EventSurveyId bigint
as begin
INSERT INTO [dbo].[EventSurveyQuestionAnswerer]
           ([FKEventSurveyQuestion_Id]
           ,Answerer
           ,[DateTime]
           ,[FKSurveyQuestionType_Id]
           ,[FKEventSurvey_Id])
     VALUES
           (@EventSurveyQuestionId,@Answer,@DateTime,@SurveyQuestionTypeId,@EventSurveyId)

		   end

GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_CheckIfInserted]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveyQuestions_CheckIfInserted]
@SurveyQuestionTypeId int 
as begin 
select count(*) from EventSurveyQuestions  where EventSurveyQuestions.IsDefault=1 and FKSurveyQuestionType_Id=@SurveyQuestionTypeId
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestions_CheckIfUsed]
@Id bigint 
as begin

select count(*) from EventSurveyQuestionAnswerer 
where FKEventSurveyQuestion_Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveyQuestions_Delete]
@Id bigint 
as begin

delete [dbo].[EventSurveyQuestions]
		   where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestions_Insert]
@Id bigint output,
@IsDefault bit ,
@FKSurveyQuestionType_Id int,
@FKEvent_Id bigint,
@IsActive bit
as begin

INSERT INTO [dbo].[EventSurveyQuestions]
           ([IsDefault]
           ,[FKSurveyQuestionType_Id]
           ,[FKEvent_Id],
		   IsActive)
     VALUES
           (@IsDefault,@FKSurveyQuestionType_Id,@FKEvent_Id,@IsActive)

		   Select @Id=@@IDENTITY
end


GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_RemoveByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveyQuestions_RemoveByEventId]
@EventId bigint 
as begin 

delete EventSurveyQuestions where FKEvent_Id = @EventId

end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveyQuestions_SelectAll]
as begin
select EventSurveyQuestions.*,
 Words.Ar as SurveyQuestionNameAr,
 Words.En as SurveyQuestionNameEn
 from EventSurveyQuestions
join EventSurveyQuestionTypes on EventSurveyQuestionTypes.Id = EventSurveyQuestions.FKSurveyQuestionType_Id
join Words on Words.Id=EventSurveyQuestionTypes.FKWord_Id
where IsDefault=1	
end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_SelectByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestions_SelectByEventId]
@EventId bigint 
as begin 

select EventSurveyQuestions.Id,
		EventSurveyQuestionTypes.Id as SurveyQuestionTypeId,
		Words.Ar					as SurveyQuestionTypeNameAr,
		Words.En					as SurveyQuestionTypeNameEn,
		EventSurveyQuestionAnswerer.Answerer
		from EventSurveyQuestions

join EventSurveyQuestionTypes on EventSurveyQuestionTypes.Id=EventSurveyQuestions.FKSurveyQuestionType_Id
join Words on Words.Id=EventSurveyQuestionTypes.FKWord_Id

left join EventSurveyQuestionAnswerer on EventSurveyQuestionAnswerer.FKEventSurvey_Id=@EventId and EventSurveyQuestionAnswerer.FKSurveyQuestionType_Id=EventSurveyQuestions.FKSurveyQuestionType_Id

where EventSurveyQuestions.FKEvent_Id=@EventId

end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_SelectDefault]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestions_SelectDefault]
@IsActive bit
as begin
select EventSurveyQuestions.*,
 Words.Ar as SurveyQuestionNameAr,
 Words.En as SurveyQuestionNameEn
 from EventSurveyQuestions
join EventSurveyQuestionTypes on EventSurveyQuestionTypes.Id = EventSurveyQuestions.FKSurveyQuestionType_Id
join Words on Words.Id=EventSurveyQuestionTypes.FKWord_Id
where IsDefault=1	and (@IsActive is null or IsActive=@IsActive)
end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventSurveyQuestions_Update]
@Id bigint ,
@IsDefault bit ,
@IsActive bit
as begin

update [dbo].[EventSurveyQuestions]
          set [IsDefault]=@IsDefault,
		   IsActive=@IsActive
		   where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestions_WithEvent]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestions_WithEvent] 
@EventId bigint 

as begin 

select  distinct 
	EventSurveyQuestionTypes.Id as SurveyQuestionTypeId ,
	@EventId as FKEvent_Id,
	isnull(EventSurveyQuestions.Id,0) as IsSelected,
	Words.Ar as SurveyQuestionTypeAr, 
	Words.En as SurveyQuestionTypeEn

from EventSurveyQuestionTypes
left join EventSurveyQuestions on EventSurveyQuestions.FKSurveyQuestionType_Id=EventSurveyQuestionTypes.Id 
and EventSurveyQuestions.FKEvent_Id=@EventId
join Words on Words.Id=EventSurveyQuestionTypes.FKWord_Id
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE proc [dbo].[EventSurveyQuestionTypes_CheckIfUsed]
@Id int
as begin

select count(*)  from EventSurveyQuestions where FKSurveyQuestionType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE proc [dbo].[EventSurveyQuestionTypes_Delete]
@Id int,
@WordId bigint
as begin

delete  EventSurveyQuestionTypes 
where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  proc [dbo].[EventSurveyQuestionTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@InputType int

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].EventSurveyQuestionTypes
           ([FKWord_Id],InputType

           )
     VALUES
           (@WordId,@InputType)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestionTypes_SelectAll] 
as begin 

select EventSurveyQuestionTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from EventSurveyQuestionTypes

join Words on Words.Id= EventSurveyQuestionTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventSurveyQuestionTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select EventSurveyQuestionTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from EventSurveyQuestionTypes

join Words on Words.Id= EventSurveyQuestionTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[EventSurveyQuestionTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[EventSurveyQuestionTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint,
@InputType int

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
update EventSurveyQuestionTypes
set InputType=@InputType
where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusHistory_CheckIfTaskFinshedWithBranch]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc 
 [dbo].[EventWorksStatusHistory_CheckIfTaskFinshedWithBranch] 
 --24,5,5,0
 @EventId bigint,
 @BranchId int,
 @WorkTypeId int,
 @ForIsCurrentBranch bit
 as
 begin
 select isnull((
 select top 1 IsFinshed from EventWorksStatusHistory 
 where 
   FKEvent_Id=@EventId 
 and FKWorkType_Id=@WorkTypeId 
 and (@ForIsCurrentBranch =1 or FKBranch_Id!=@BranchId)
 and (@ForIsCurrentBranch =0 or FKBranch_Id=@BranchId)
 order by EventWorksStatusHistory.Id desc
 ),0)

 
 end
GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusHistory_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventWorksStatusHistory_Insert]
@IsFinshed bit,
@DateTime datetime,
@FKEvent_Id bigint,
@FKWorkType_Id int,
@FKUsre_Id  bigint,
@FKAccountType_Id int,
@BranchId int
as begin
INSERT INTO [dbo].EventWorksStatusHistory
           ([IsFinshed]
           ,[DateTime]
           ,[FKEvent_Id]
           ,[FKWorkType_Id]
           ,[FKUsre_Id]
           ,[FKAccountType_Id],
		   FKBranch_Id)
     VALUES
          (@IsFinshed ,
@DateTime ,
@FKEvent_Id ,
@FKWorkType_Id ,
@FKUsre_Id  ,
@FKAccountType_Id,
@BranchId)
end


GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusHistory_SelectByEventId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventWorksStatusHistory_SelectByEventId]
@eventId bigint
as begin 

select EventWorksStatusHistory.*,Users.UserName,
Word.Ar	as AccountTypeAr,
Word.En	as AccountTypeEn 
from EventWorksStatusHistory 
join Users on
Users.Id=EventWorksStatusHistory.FKUsre_Id

join AccountTypes on AccountTypes.Id=Users.FKAccountType_Id
join Words as Word on Word.Id=AccountTypes.FkWord_Id
where FKEvent_Id=@eventId

end 
GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusHistory_SelectLast]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventWorksStatusHistory_SelectLast]
@eventId bigint,
@WorkTypeId int
as begin 

select top 1 EventWorksStatusHistory.*,Users.UserName
from EventWorksStatusHistory 
join Users on
Users.Id=EventWorksStatusHistory.FKUsre_Id

where FKEvent_Id=@eventId and EventWorksStatusHistory.FKWorkType_Id=@WorkTypeId 

order by EventWorksStatusHistory.Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusIsFinsed_CheckIfFinshed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventWorksStatusIsFinsed_CheckIfFinshed] 
@eventId bigint,
@workTypeId int
as begin
/* Works Types
	Booking                =1  , DataPerfection         =2  ,
	Coordination           =3  , Implementation         =4  ,
	ArchivingAndSaveing    =5  , ProductProcessing      =6  ,
	Chooseing              =7  , DigitalProcessing      =8  ,
	PreparingForPrinting   =9  , Manufacturing          =10 ,
	QualityAndReview       =11 , Packaging              =12 ,
	TransmissionAndDelivery=13 , Archiving              =14 ,*/
	select ISNULL(dbo.[EventWorksStatusIsFinsed_CheckIfFinshedFun](@eventId,@workTypeId),0) 
	end
GO
/****** Object:  StoredProcedure [dbo].[EventWorksStatusIsFinshed_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventWorksStatusIsFinshed_Update]
@EventId bigint,
@IsFinshed bit,
@WorkTypeId int
as begin 
	/* Works Types
	Booking                =1  , DataPerfection         =2  ,
	Coordination           =3  , Implementation         =4  ,
	ArchivingAndSaveing    =5  , ProductProcessing      =6  ,
	Chooseing              =7  , DigitalProcessing      =8  ,
	PreparingForPrinting   =9  , Manufacturing          =10 ,
	QualityAndReview       =11 , Packaging              =12 ,
	TransmissionAndDelivery=13 , Archiving              =14 ,*/

if(@WorkTypeId = 1)  UPDATE EventWorksStatusIsFinshed set Booking=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 2)  UPDATE EventWorksStatusIsFinshed set DataPerfection=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 3)  UPDATE EventWorksStatusIsFinshed set Coordination=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 4)  UPDATE EventWorksStatusIsFinshed set Implementation=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 5)  UPDATE EventWorksStatusIsFinshed set ArchivingAndSaveing=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 6)  UPDATE EventWorksStatusIsFinshed set ProductProcessing=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 7)  UPDATE EventWorksStatusIsFinshed set Chooseing=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 8)  UPDATE EventWorksStatusIsFinshed set DigitalProcessing=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 9)  UPDATE EventWorksStatusIsFinshed set PreparingForPrinting=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 10) UPDATE EventWorksStatusIsFinshed set Manufacturing=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 11) UPDATE EventWorksStatusIsFinshed set QualityAndReview=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 12) UPDATE EventWorksStatusIsFinshed set Packaging=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 13) UPDATE EventWorksStatusIsFinshed set TransmissionAndDelivery=@IsFinshed where EventId=@EventId
else if(@WorkTypeId = 14) UPDATE EventWorksStatusIsFinshed set Archiving=@IsFinshed where EventId=@EventId

end
GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FilesReceivedTypes_CheckIfUsed] 
@Id bigint
as begin

-- فيما بعد سوف نربط هذة
select 0 
 
end
GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[FilesReceivedTypes_Delete]
@Id bigint,
@WordId bigint
as begin
delete  FilesReceivedTypes where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[FilesReceivedTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[FilesReceivedTypes]
           ([FKWord_Id]
           )
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[FilesReceivedTypes_SelectAll] 
as begin 

select FilesReceivedTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from FilesReceivedTypes

join Words on Words.Id= FilesReceivedTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[FilesReceivedTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select FilesReceivedTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from FilesReceivedTypes

join Words on Words.Id= FilesReceivedTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[FilesReceivedTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[FilesReceivedTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 
end


GO
/****** Object:  StoredProcedure [dbo].[Menus_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Menus_SelectAll]

as begin
 select 
		Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as MenuNameEn

		from Menus 
 join Words on Words.Id=Menus.FKWord_Id

 order by Menus.OrderByNumber 
 end
GO
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllByUser_Id]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Menus_SelectAllByUser_Id]
@UserId bigint
as begin
 select 
 Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as MenuNameEn,
		PageWord.Ar as PageNameAr,
		PageWord.En as PageNameEn
 from Menus 

 join Pages 
 on Pages.FkMenu_Id=Menus.Id 

 join Words on Words.Id=Menus.FKWord_Id
 join PageWord as PageWord on PageWord.Id=Pages.FKWord_Id

 join UsersPrivileges 
 on (@UserId is null or UsersPrivileges.FkEmployee_Id=@UserId	 	 )
 and UsersPrivileges.FkPage_Id=Pages.Id

 order by Menus.OrderByNumber 
 end
GO
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllForUserCanBeAccess]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Menus_SelectAllForUserCanBeAccess]	 
 
@UserId bigint ,
@IsPublicMenus bit

as begin
--نتحقق اذا كان يريد القوءم التى بها لـ المستخدم العادى نقوم بجلبها مباشرة اذا بها صفح ولا يوجد هنا تحققات لان المستخدم العادى ليس له صلاحيات وله صفح خاصة بة 
if(@IsPublicMenus =1 )
select distinct Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as		MenuNameEn from Menus 

 join Words on Words.Id=Menus.FKWord_Id 
 join Pages on Pages.FkMenu_Id=Menus.Id 
 where Pages.IsForClient=1 and Pages.IsHide=0

		order by Menus.OrderByNumber
--**********************************************************
--**********************************************************
else if(@UserId is null or @UserId =0 )
 select Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as		MenuNameEn from Menus 
 join Words on Words.Id=Menus.FKWord_Id

		order by Menus.OrderByNumber 

 else
--**********************************************************
--**********************************************************
 -- جلب كل القوائم التى يمكن المستخدم الوصول اليها بشكل مباشر
  select 
		Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as		MenuNameEn
		from Menus 

 join Pages on Pages.FkMenu_Id=Menus.Id 
 join Words on Words.Id=Menus.FKWord_Id
 join UserPrivileges on UserPrivileges.FkUser_Id=@UserId 
 and UserPrivileges.FkPage_Id=Pages.Id 
 where     Pages.IsHide=0

 union 
 -- جلب كل القوائم الرئيسية بناء ع القوائم الفرعية المسموح لها بـ الظهور
  select 
		Parent.*,
  		Words.Ar as MenuNameAr,
		Words.En as	MenuNameEn
		from Menus 

 join Menus as Parent on Parent.Id=Menus.Parent_Id 
 join Pages on Pages.FkMenu_Id=Menus.Id 
 join Words on Words.Id=Parent.FKWord_Id
 join UserPrivileges on UserPrivileges.FkUser_Id=@UserId 
      and UserPrivileges.FkPage_Id=Pages.Id

where 
 Menus.Parent_Id is not null   
 and Pages.IsHide=0

 order by Menus.OrderByNumber 
 end
GO
/****** Object:  StoredProcedure [dbo].[Notifications_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Notifications_Insert]
	@Id bigint output,
	@DateTime datetime,
	@TargetId bigint,
	@PageId bigint,
	@UserId bigint,
	@NameAr nvarchar(max),
	@NameEn nvarchar(max),
	@DescriptionAr nvarchar(max),
	@DescriptionEn nvarchar(max),
	@RedirectUrl nvarchar(max),
	@UserTargrtId bigint
as begin
declare @WordId bigint,
@WordDescriptionId bigint

exec @WordId = Words_Insert @NameAr,@NameEn;
exec @WordDescriptionId = Words_Insert @DescriptionAr,@DescriptionEn;

INSERT INTO [dbo].[Notifications]
           ([DateTime],[Target_Id],[FKPage_Id],[FKUser_Id],[FkWord_Id],[FKDescriptionWord_Id],RedirectUrl)
     VALUES (@DateTime,@TargetId,@PageId,@UserId,@WordId,@WordDescriptionId,@RedirectUrl)

select @id=@@IDENTITY
	 exec NotificationsUser_Insert @id,@UserTargrtId

end

GO
/****** Object:  StoredProcedure [dbo].[Notifications_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Notifications_SelectByFilter]
--Paging
@Skip int  ,
@Take int , 
--Filter
@PagedId int , 
@IsRead bit ,
@CuurentUserLoggadId bigint
as begin
declare @NotificationsCount int = dbo.GetNotificationsCountIsNotRead(@CuurentUserLoggadId)
select Notifications.* ,
TitleWord.Ar as TitleAr,
TitleWord.En as TitleEn,
DescWord.Ar as DescriptionAr,
DescWord.En as DescriptionEn,
@NotificationsCount as NotificationsCount,
NotificationsUser.IsRead
from NotificationsUser  
	join Notifications on Notifications.Id=NotificationsUser.FKNotify_Id
	join Words as  TitleWord on TitleWord.Id=Notifications.FkWord_Id
	join Words  as DescWord on DescWord.Id=Notifications.FKDescriptionWord_Id

where 
NotificationsUser.FKUser_Id=@CuurentUserLoggadId 
and 
(@PagedId is null or Notifications.FKPage_Id=@PagedId)
and 
(@IsRead is null or NotificationsUser.IsRead=@IsRead)

order by Notifications.Id desc
offset @Skip Rows
Fetch Next @Take Rows Only
end 
GO
/****** Object:  StoredProcedure [dbo].[NotificationsUser_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NotificationsUser_Insert]
@NotifyId bigint ,
@UserId bigint
as begin
INSERT INTO [dbo].[NotificationsUser]
           ([FKNotify_Id]
           ,[FKUser_Id]
           ,[IsRead])
     VALUES
           (@NotifyId,@UserId,0)
end

GO
/****** Object:  StoredProcedure [dbo].[NotificationsUser_Read]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[NotificationsUser_Read] 
@NotifyId bigint , 
@UserId	bigint
as begin

update NotificationsUser 
set IsRead=1
where FKNotify_Id=@NotifyId and FKUser_Id=@UserId

end
GO
/****** Object:  StoredProcedure [dbo].[Package_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Package_CheckIfUsed] 
@Id int
as begin

select 
isnull(count(*),0)  from Events where FKPackage_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[PackageDetails_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PackageDetails_Delete]
@Id int 

as begin
delete PackageDetails where Id=@Id
end 
GO
/****** Object:  StoredProcedure [dbo].[PackageDetails_DeleteAllByPackageId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PackageDetails_DeleteAllByPackageId]
@PackageId int 

as begin
delete PackageDetails where FKPackage_Id=@PackageId
end 
GO
/****** Object:  StoredProcedure [dbo].[PackageDetails_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PackageDetails_Insert]
@Id int output,
@Package_Id int , 
@ValueAr nvarchar(max),
@ValueEn nvarchar(max),
@PackageInputId int 
as begin
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @ValueAr,@ValueEn
INSERT INTO [dbo].[PackageDetails]
           ([FKWord_Id]
           ,[FKPackageInputType_Id]
           ,[FKPackage_Id])
     VALUES
           (@WordId,@PackageInputId,@Package_Id)
		   select @Id=@@IDENTITY
end 
GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PackageInputTypes_CheckIfUsed] 
@Id int
as begin

select 
isnull(count(*),0)  from PackageDetails where FKPackageInputType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PackageInputTypes_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Cities where Id=@Id)
delete  PackageInputTypes where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[PackageInputTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[PackageInputTypes]
           ([FKWord_Id]
           )
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PackageInputTypes_SelectAll] 
as begin 

select PackageInputTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from PackageInputTypes

join Words on Words.Id= PackageInputTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PackageInputTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select PackageInputTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from PackageInputTypes

join Words on Words.Id= PackageInputTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PackageInputTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 
end


GO
/****** Object:  StoredProcedure [dbo].[Packages_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Packages_Delete]
@Id int ,
@WordNameId bigint,
@WordDescriptionId bigint
as begin

delete Packages where Id=@Id
 exec dbo.Words_Delete  @WordNameId
 exec dbo.Words_Delete  @WordDescriptionId



end


GO
/****** Object:  StoredProcedure [dbo].[Packages_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Packages_Insert]
@Id int output,
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@DescriptionAr nvarchar(50),
@DescriptionEn nvarchar(50),
@IsPrintNamesFree bit,
@AlbumTypeId int,
@Price decimal(18,2),
@NamsArExtraPrice decimal(18,2)

as begin
declare @WordNameId bigint, 
@WordDescriptionId bigint;
exec @WordNameId =   dbo.Words_Insert @NameAr,@NameEn
exec @WordDescriptionId =   dbo.Words_Insert @DescriptionAr,@DescriptionEn


INSERT INTO [dbo].[Packages]
           ([FkWordName_Id]
           ,IsPrintNamesFree
           ,[FkWordDescription_Id]
           ,[FKAlbumType_Id],Price,NamsArExtraPrice
            )
     VALUES
           (@WordNameId,@IsPrintNamesFree,@WordDescriptionId,
		   @AlbumTypeId,@Price,@NamsArExtraPrice)
		   select @Id=@@IDENTITY
end


GO
/****** Object:  StoredProcedure [dbo].[Packages_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE proc [dbo].[Packages_SelectAll] 

as begin 

select Packages.*,
Words.Ar as NameAr,
Words.En as NameEn from Packages

join Words on Words.Id= Packages.FKWordName_Id

order by Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[Packages_SelectByPaging]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Packages_SelectByPaging] 
--Paging
@Skip int , 
@Take int 
as begin 

select Packages.*,
WordName.Ar as NameAr,
WordName.En as NameEn ,
WordDescription.Ar as DescriptionAr,
WordDescription.En as DescriptionEn

from Packages
join Words as WordName on WordName.Id= Packages.FKWordName_Id
join Words  as WordDescription on WordDescription.Id= Packages.FkWordDescription_Id

order by Id desc
Offset @Skip rows
Fetch next @Take rows only
end 
GO
/****** Object:  StoredProcedure [dbo].[Packages_SelectByPK]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE proc [dbo].[Packages_SelectByPK]  
@Id int
as begin 

select Packages.*,
	WordName.Ar as NameAr,
	WordName.En as NameEn ,
	WordDescription.Ar as DescriptionAr,
	WordDescription.En as DescriptionEn,
	PackageDetails.Id as PackageDetailsId,
	WordPackageDetail.Ar as PackageDetailValueAr ,
	WordPackageDetail.En as PackageDetailValueEn ,
	PackageDetails.FKPackageInputType_Id as FKPackageInputType_Id ,
	WordPackageInputType.Ar as PackageInputTypeAr,
	WordPackageInputType.En as PackageInputTypeEn,
              WordAlbumTypes.Ar as   AlbumType_NameAr,
              WordAlbumTypes.En as   AlbumType_NameEn
from Packages

join Words as WordName on WordName.Id= Packages.FKWordName_Id
join Words as WordDescription on WordDescription.Id= Packages.FkWordDescription_Id
left join PackageDetails on PackageDetails.FKPackage_Id=Packages.Id
left join PackageInputTypes on PackageInputTypes.Id=PackageDetails.FKPackageInputType_Id
left join Words as WordPackageInputType on WordPackageInputType.Id= PackageInputTypes.FKWord_Id
left join Words as WordPackageDetail on WordPackageDetail.Id= PackageDetails.FKWord_Id


left join AlbumTypes on AlbumTypes.Id=Packages.FKAlbumType_Id
left join Words as WordAlbumTypes on WordAlbumTypes.Id= AlbumTypes.FKWord_Id
where Packages.Id=@Id
end 
GO
/****** Object:  StoredProcedure [dbo].[Packages_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Packages_Update]
@Id int ,
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@DescriptionAr nvarchar(50),
@DescriptionEn nvarchar(50),
@IsPrintNamesFree bit,
@AlbumTypeId int,
@WordNameId bigint,
@WordDescriptionId bigint,

@Price decimal(18,2),
@NamsArExtraPrice decimal(18,2)
as begin

 exec dbo.Words_Update @WordNameId,@NameAr,@NameEn
 exec dbo.Words_Update @WordDescriptionId,@DescriptionAr,@DescriptionEn


update [Packages]
          set 
           IsPrintNamesFree=@IsPrintNamesFree
           ,[FKAlbumType_Id]=@AlbumTypeId,
		   Price =@Price ,
		   NamsArExtraPrice=@NamsArExtraPrice

where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllByUser_Id]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Pages_SelectAllByUser_Id]
@UserId bigint
as begin
 select Pages.*,
 PageWord.Ar as PageNameAr,
		PageWord.En as PageNameEn
		from  Pages 
 join PageWord as PageWord on PageWord.Id=Pages.FKWord_Id

 join UserPrivileges 
 on (@UserId is null or UserPrivileges.FkUser_Id=@UserId	 	 )
 and UserPrivileges.FkPage_Id=Pages.Id

 end
GO
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllForUserCanBeAccess]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[Pages_SelectAllForUserCanBeAccess]
   @UserId bigint,
@IsPublicMenus bit
as begin 
--نتحقق اذا كان يريد الصفح التى بها لـ المستخدم العادى نقوم بجلبها مباشرة  ولا يوجد هنا تحققات لان المستخدم العادى ليس له صلاحيات وله صفح خاصة بة 
if(@IsPublicMenus =1 )
select 
Pages.*,
	PageWord.Ar as PageNameAr,
	PageWord.En as PageNameEn
	
from Pages 
 join Words as PageWord on PageWord.Id=Pages.FKWord_Id
 where Pages.IsForClient=1 
 and pages.IsHide!=1

order by Pages.OrderByNumber

else if(@UserId is null or @userId=0)
select 
	Pages.*,
	PageWord.Ar as PageNameAr,
	PageWord.En as PageNameEn
	
from Pages 
 join Words as PageWord on PageWord.Id=Pages.FKWord_Id
 where Pages.IsForAdmin=1
 and pages.IsHide!=1

order by Pages.OrderByNumber

else 
select 
	Pages.*,
	PageWord.Ar as PageNameAr,
	PageWord.En as PageNameEn
	
from Pages 

 join Words as PageWord on PageWord.Id=Pages.FKWord_Id
 join UserPrivileges on UserPrivileges.FkUser_Id=@UserId 
 and UserPrivileges.FkPage_Id=Pages.Id
 where Pages.IsForAdmin=1
 and pages.IsHide!=1
order by Pages.OrderByNumber
 end
GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PrintNamesTypes_CheckIfUsed] 
@Id bigint
as begin

select 
isnull(count(*),0)  from Events where FKPrintNameType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PrintNamesTypes_Delete]
@Id bigint,
@WordId bigint
as begin
delete  PrintNamesTypes where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  proc [dbo].[PrintNamesTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@Price decimal(18,2)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[PrintNamesTypes]
           ([FKWord_Id],Price
           )
     VALUES
           (@WordId,@Price)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PrintNamesTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select PrintNamesTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from PrintNamesTypes

join Words on Words.Id= PrintNamesTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[PrintNamesTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint,
@Price decimal(18,2)

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn



-- Update Target
 update PrintNamesTypes set Price=@Price where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[PrintNameTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PrintNameTypes_SelectAll] 
as begin 

select PrintNamesTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from PrintNamesTypes

join Words on Words.Id= PrintNamesTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[PrintNameTypes_SelectByPK]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PrintNameTypes_SelectByPK]
@Id int 
as begin
select top 1 * from PrintNamesTypes where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_CheckIfUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SocialAccountTypes_CheckIfUsed] 
@Id int
as begin

select 
isnull(count(*),0)  from UserSocialAccounts where FKSocialAccountType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SocialAccountTypes_Delete]
@Id int,
@WordId bigint
as begin
delete  SocialAccountTypes where Id=@Id
delete Words where Words.Id =@WordId
 
end
GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE  proc [dbo].[SocialAccountTypes_Insert]  
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId bigint ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[SocialAccountTypes]
           ([FKWord_Id]
           )
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_SelectAll]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[SocialAccountTypes_SelectAll] 
as begin 

select SocialAccountTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from SocialAccountTypes

join Words on Words.Id= SocialAccountTypes.FKWord_Id

end 
GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SocialAccountTypes_SelectByFilter] 
@Skip int , 
@Take int 

as begin 

select SocialAccountTypes.*,
Words.Ar as NameAr,
Words.En as NameEn from SocialAccountTypes

join Words on Words.Id= SocialAccountTypes.FKWord_Id

order by Id desc
Offset @skip rows 
Fetch next @Take rows only 
end 
GO
/****** Object:  StoredProcedure [dbo].[SocialAccountTypes_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[SocialAccountTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId bigint

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 
end


GO
/****** Object:  StoredProcedure [dbo].[UserPayments_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPayments_Insert]
@Id bigint output,
@Amount  decimal(18,2),
@DateTime datetime,
@IsAcceptFromManger bit,
@FKUserTo_Id bigint,
@FKUserFrom_Id bigint,
 @Notes nvarchar(max),
 @IsBankTransfer bit,
 @PaymentImage nvarchar(max)
as begin 
INSERT INTO [dbo].[UserPayments]
           ([Amount]
           ,[DateTime]
           ,[IsAcceptFromManger]
           ,[FKUserTo_Id]
           ,[FKUserFrom_Id],
		   Notes  ,
		   IsBankTransfer ,
           PaymentImage )
		   values(
		   @Amount  ,
		   @DateTime ,
		   @IsAcceptFromManger ,
		   @FKUserTo_Id ,
		   @FKUserFrom_Id ,
		   @Notes ,
		   @IsBankTransfer ,
		   @PaymentImage 


		   )
select @Id=@@IDENTITY
end


GO
/****** Object:  StoredProcedure [dbo].[UserPayments_SelectByUserToId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPayments_SelectByUserToId]
@Id bigint,
@Skip int , 
@Take int 
as begin 
select UserPayments.*,
UserFrom.UserName,

 dbo.UserPayments_CheckIsClosed(UserPayments.IsAcceptFromManger,UserPayments.PaymentImage) as IsClosed
from UserPayments 
join Users UserFrom on UserFrom.Id=UserPayments.FKUserFrom_Id
where UserPayments.FKUserTo_Id=@Id


order by UserPayments.Id desc
offset @skip rows
fetch next @Take rows only
end


GO
/****** Object:  StoredProcedure [dbo].[UserPayments_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPayments_Update]
@Id bigint ,
@IsAcceptFromManger bit,
 @Notes nvarchar(max),
 @IsBankTransfer bit,
 @PaymentImage nvarchar(max)
as begin 
update [dbo].[UserPayments]
set
           IsAcceptFromManger= @IsAcceptFromManger,
		   Notes =@Notes				,
		   IsBankTransfer =@IsBankTransfer		,
           PaymentImage=@PaymentImage 

		   where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[UserPrivileges_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPrivileges_Insert]
	@PageId int ,
	@UserId bigint,
	@CanAdd bit , 
	@CanEdit bit , 
	@CanDelete bit ,
	@CanDisplay bit 

	as 
SET NOCOUNT ON;

BEGIN TRY
BEGIN TRAN


INSERT [dbo].[UserPrivileges]
(
		[FkUser_Id],
		[FkPage_Id],
		[CanAdd],
		[CanEdit],
		[CanDelete],
		[CanDisplay]
)
VALUES
(
		@UserId,
		@PageId,
		@CanAdd,
		@CanEdit,
		@CanDelete,
		@CanDisplay
)


COMMIT TRAN
END TRY

BEGIN CATCH
ROLLBACK TRAN

DECLARE @ErrorNumber_INT INT;
DECLARE @ErrorSeverity_INT INT;
DECLARE @ErrorProcedure_VC VARCHAR(200);
DECLARE @ErrorLine_INT INT;
DECLARE @ErrorMessage_NVC NVARCHAR(4000);

SELECT
		@ErrorMessage_NVC = ERROR_MESSAGE(),
		@ErrorSeverity_INT = ERROR_SEVERITY(),
		@ErrorNumber_INT = ERROR_NUMBER(),
		@ErrorProcedure_VC = ERROR_PROCEDURE(),
		@ErrorLine_INT = ERROR_LINE()

RAISERROR(@ErrorMessage_NVC,@ErrorSeverity_INT,1);

END CATCH
GO
/****** Object:  StoredProcedure [dbo].[UserPrivileges_RemoveByMenuIdAndUserId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPrivileges_RemoveByMenuIdAndUserId] 
	@MenuId int , 
	@UserId bigint
/*
حذف جميع الامتيازات بناء على المنيو

*/
	as begin 

	delete UserPrivileges 
	where 
	FkUser_Id=@UserId and 
	(select COUNT(*) from Pages 
	where Pages.Id=UserPrivileges.FkPage_Id and Pages.FkMenu_Id=@MenuId)>0

	end
GO
/****** Object:  StoredProcedure [dbo].[UserPrivileges_SelectByUserId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserPrivileges_SelectByUserId]
@pageId int , 
@userId bigint
as begin 

select * from UserPrivileges where FkUser_Id=@userId and FkPage_Id=@pageId

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_ActiveEmail]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_ActiveEmail] 
@UserId bigint,
@ActiveCode nvarchar(50)
as begin 
declare @OldActiveCode nvarchar(50) = (select top 1 ActiveCode from users where Id=@UserId);

if(@OldActiveCode =@ActiveCode)
	Update Users 
	set IsActiveEmail =1 
	where Id=@UserId

select * from users where Id=@UserId
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_CheckCompeleteAccountInformation]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc 
[dbo].[Users_CheckCompeleteAccountInformation] 
--10023,6
@UserId bigint ,
@AccountTypeId int 

as begin 
/*
نتحقق ان معلومات المستخدم المهمة تم ادخالها بناء على نوع الحساب الخاص بة
		ProjectManager = 1,
        Supervisor = 2,
        BranchManager = 3,
        Clinet = 4,
        Employee=5,
        Helper= 6,
        Photographer=7
*/

declare @counte int = (select count(*) from Users    

where Id=@UserId
and 
-- (
-- (@AccountTypeId =4 or @AccountTypeId= 6 or @AccountTypeId=7) 
-- and
-- (Email is null  or FullName is null or NationalityNumber is null or PhoneNo is null or DateOfBirth is  null )
-- )
--)
(
 Email is null  or FullName is null or NationalityNumber is null or PhoneNo is null or DateOfBirth is  null 
 ))
if(@counte > 0)
select 1;
else 
select 0

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_CheckFromActiveCode]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_CheckFromActiveCode]
@Id bigint , 
@ActiveCode nvarchar(50)
as begin

select ISNULL(count(*),0) from Users where Id=@Id and ActiveCode=@ActiveCode


end 
GO
/****** Object:  StoredProcedure [dbo].[Users_CheckIfActive]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_CheckIfActive]
@UserId bigint 
as begin 
select count(*) from Users where Id=@UserId and IsActive=1
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_CheckIfEmailActivated]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_CheckIfEmailActivated] 
@UserId bigint
as begin 
select isnull(IsActiveEmail,0) from Users where Id=@UserId

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_EmailBeforUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_EmailBeforUsed] 
@UserId bigint,
@Email nvarchar(50)
as begin

select count(*) from Users where LOWER(Email)=LOWER(@Email) 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_Insert]
			@Id bigint output,
			@UserName nvarchar(50),
           @Email nvarchar(50),
           @PhoneNo nvarchar(50),
           @FKAccountType_Id int,
           @Address nvarchar(250),
           @FkCountry_Id int,
           @FkCity_Id int,
           @Password nvarchar(50),
           @ActiveCode nvarchar(50),
		   @CreateDateTime datetime,
		   @LanguageId int,
		   @BranchId int,
		   @EnquiryId	bigint,
		   @DateOfBirth  date,
		   @IsActive bit,
		   @FullName nvarchar(150),
		  		   @NationalityNumber nvarchar(20) ,

		   @WebSite nvarchar(500)
as begin
INSERT INTO [dbo].[Users]
           ([UserName]
           ,[Email]
           ,[PhoneNo]
           ,[FKAccountType_Id]
           ,[Address]
           ,[FkCountry_Id]
           ,[FkCity_Id]
           ,[Password]
           ,[ActiveCode],
		   CreateDateTime,
		   FKLanguage_Id,
		   FKPranch_Id,
		   DateOfBirth,isActive,
		   
		   FullName,
		   NationalityNumber,
		   WebSite)
     VALUES
           (@UserName,
           @Email, 
           @PhoneNo,
           @FKAccountType_Id, 
           @Address, 
           @FkCountry_Id,
           @FkCity_Id,
           @Password, 
           @ActiveCode,
		  @CreateDateTime,
		   @LanguageId,
		   @BranchId,
		   @DateOfBirth,
		   @IsActive,
		   @FullName,
		   @NationalityNumber,
		   @WebSite)

		   --نقوم بتحيث الاستفسار الان
		   if(@EnquiryId is not null)
		   update Enquires set IsLinkedClinet=1 , FkClinet_Id =@@IDENTITY where Enquires.Id=@EnquiryId


select @Id= @@IDENTITY


end 
GO
/****** Object:  StoredProcedure [dbo].[Users_NationalityNumberBeforUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_NationalityNumberBeforUsed] 
@UserId bigint,
@NationalityNumber nvarchar(50)
as begin

select count(*) from Users where NationalityNumber=@NationalityNumber
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[Users_PhoneNumberBeforUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_PhoneNumberBeforUsed] 
@UserId bigint,
@PhoneNumber nvarchar(50)
as begin

select count(*) from Users where PhoneNo=@PhoneNumber 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAllEmployees]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_SelectAllEmployees]

as begin 

select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn

from Users

join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id

join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where 
	Users.IsActive=1 and 
	Users.FKAccountType_Id =2 or 
	Users.FKAccountType_Id =3 or 
	Users.FKAccountType_Id =5

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAllForUsersPrivileges]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_SelectAllForUsersPrivileges]
/*
  ProjectManager = 1,
        Supervisor = 2,
        BranchManager = 3,
        Clinet = 4,
        Employee=5,
        Helper= 6,
        Photographer=7
*/
as begin 

select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn

from Users

join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id

join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where 
	Users.IsActive=1 and 
	Users.FKAccountType_Id =2 or 
	Users.FKAccountType_Id =3 
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByBaicBranchWithWorkTypes]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_SelectByBaicBranchWithWorkTypes]  

as begin 
select 
	Users.*,
	ISNULL(EmployeesWorks.FkWorkType_Id,0) as FkWorkType_Id,
	Branches.IsBasic
from Users 
  join EmployeesWorks on EmployeesWorks.FKUser_Id=Users.Id
  join Branches on Branches.Id=Users.FKPranch_Id 
  where 
  Branches.IsBasic =1
  

  and IsActive=1
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByBranchId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_SelectByBranchId]
@BranchId int ,
@AccountTypeId int 
as begin
select Users.*,
EmployeesWorks.FkWorkType_Id
from Users 
left join EmployeesWorks on EmployeesWorks.FKUser_Id=Users.Id
Where FKPranch_Id=@BranchId and FKAccountType_Id=@AccountTypeId and IsActive=1
end
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByBranchIdWithWorkTypes]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_SelectByBranchIdWithWorkTypes]  
@BranchId bigint

as begin 
select 
	Users.*,
	ISNULL(EmployeesWorks.FkWorkType_Id,0) as FkWorkType_Id
from Users 
  join EmployeesWorks on EmployeesWorks.FKUser_Id=Users.Id
  
  where 
  users.FKPranch_Id=@BranchId
  

  and IsActive=1
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByFilter]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc   [dbo].[Users_SelectByFilter]
--Paging
@Skip  int ,
@Take int , 

--Filter
@UserName nvarchar(50),
@Email nvarchar(50),
@PhoneNumber nvarchar(50),
@Adddress nvarchar(50),
@CreateDateTo date,
@CreateDateFrom date,
@CountryId int,
@CityId int,
@AccountTypeId int,
@LanguageId int,
@BranchId bigint
as begin
select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn

from users 
join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id

join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where 
(@UserName		is null  or @UserName		 is null or users.UserName like '%'+@UserName+'%')and
(@Email  		is null  or @Email  		 is null or users.Email like '%'+@Email+'%')and
(@PhoneNumber   is null  or @PhoneNumber    is null or users.PhoneNo like '%'+@PhoneNumber+'%')and
(@Adddress		is null  or @Adddress		  is null or users.Address like '%'+@Adddress+'%')and
(@CreateDateTo  	is null or users.CreateDateTime<=@CreateDateTo )and
(@CreateDateFrom  	is null or users.CreateDateTime>=@CreateDateFrom)and
(@CountryId 		is null or users.FkCountry_Id=@CountryId)and
(@CityId  			is null or users.FkCity_Id=@CityId)and
(@AccountTypeId 	= 0 or users.FKAccountType_Id=@AccountTypeId)and
(@LanguageId 		= 0 or users.FKLanguage_Id=@LanguageId) and
(@BranchId 			= 0 or users.FKPranch_Id=@BranchId) 

order by Id Desc
Offset @Skip rows
fetch next @Take rows only
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByPk]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_SelectByPk]
@Id bigint as begin 

select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn

from Users

join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id

join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where Users.Id=@Id
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByUserNameAndPassword]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_SelectByUserNameAndPassword]
@UserName nvarchar(50),
@Password nvarchar(50) 
 as begin 
select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn
from Users
join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id
join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where Users.UserName=@UserName and Users.Password=@Password
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_UpateActiveCodeAndEmail]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_UpateActiveCodeAndEmail] 
@UserId bigint,
@ActiveCode nvarchar(50),
@Email nvarchar(50)
as begin 
--تحديث الكود
Update Users 
set ActiveCode =@ActiveCode 
where Id=@UserId

 
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_Update]
			@Id bigint  ,
			@UserName nvarchar(50),
           @Email nvarchar(50),
           @PhoneNo nvarchar(50),
           @Address nvarchar(250),
           @FkCountry_Id int,
           @FkCity_Id int,
           @Password nvarchar(50),
		   @LanguageId int,
		   @DateOfBirth date,
		   @IsActive bit,
		   @FullName nvarchar(150),
		   @NationalityNumber nvarchar(20) ,
		   @WebSite nvarchar(500)
as begin
update [dbo].[Users] set
           [UserName]			= @UserName,		
           [Email]				=@Email ,
           [PhoneNo]			=@PhoneNo ,
           [Address]			=@Address ,
           [FkCountry_Id]		=@FkCountry_Id ,
           [FkCity_Id]			=@FkCity_Id ,
           [Password]			=@Password ,
		   FKLanguage_Id		=@LanguageId ,
		   DateOfBirth=@DateOfBirth,
		   IsActive=@IsActive,
		     FullName=@FullName,
		   NationalityNumber=@NationalityNumber,
		   WebSite=@WebSite

   where Id=@Id and @Password is not null

   update [dbo].[Users] set
           [UserName]			= @UserName,		
           [Email]				=@Email ,
           [PhoneNo]			=@PhoneNo ,
           [Address]			=@Address ,
           [FkCountry_Id]		=@FkCountry_Id ,
           [FkCity_Id]			=@FkCity_Id ,
		   FKLanguage_Id		=@LanguageId ,
		   DateOfBirth=@DateOfBirth ,
		   IsActive=@IsActive,
		   FullName=@FullName,
		   NationalityNumber=@NationalityNumber,
		   WebSite=@WebSite

   where Id=@Id and @Password is  null
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateLangage]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_UpdateLangage]
@Id bigint,
@languageId int 
 as begin 
 update Users set FKLanguage_Id=@languageId where Id=@Id
select 
	Users.*,
	WordAccountType.Ar as AccountTypeNameAr,
	WordAccountType.En as AccountTypeNameEn,
	WordCountry.Ar as CountryNameAr,
	WordCountry.En as CountryNameEn,
	WordCity.Ar as CityNameAr,
	WordCity.En as CityNameEn

from Users

join AccountTypes on AccountTypes.Id=users.FKAccountType_Id
left join Countries on Countries.Id=users.FkCountry_Id
left join Cities on Cities.Id=users.FkCity_Id

join Words as WordAccountType on WordAccountType.Id=AccountTypes.FKWord_Id
left join Words as WordCountry on WordCountry.Id=Countries.FKWord_Id
left join Words as WordCity on WordCity.Id=Cities.FKWord_Id
where Users.Id=@Id
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_UserNameBeforUsed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_UserNameBeforUsed] 
@UserId bigint,
@UserName nvarchar(50)
as begin

select count(*) from Users where LOWER(UserName)=LOWER(@UserName) 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[UserSocialAccounts_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UserSocialAccounts_Delete]
@Id bigint
as begin

delete UserSocialAccounts where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[UserSocialAccounts_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UserSocialAccounts_Insert]
@Id bigint output,
@FKSocialAccountType_Id int , 
@Link nvarchar(max),
@FKUser_Id bigint
as begin

INSERT INTO [dbo].[UserSocialAccounts]
           ([FKSocialAccountType_Id]
           ,[Link]
           ,[FKUser_Id])
     VALUES
           (@FKSocialAccountType_Id,@Link,@FKUser_Id)
		   select @Id=@@IDENTITY
end
GO
/****** Object:  StoredProcedure [dbo].[UserSocialAccounts_SelectAllByUserId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UserSocialAccounts_SelectAllByUserId]
@UserId bigint
as begin

select 
UserSocialAccounts.*,
Words.Ar as AccountTypeNameAr,
Words.Ar as AccountTypeNameEn

from UserSocialAccounts
join SocialAccountTypes on SocialAccountTypes.Id=UserSocialAccounts.FKSocialAccountType_Id
join Words on Words.Id=SocialAccountTypes.FkWord_Id
where FKUser_Id=@UserId
end
GO
/****** Object:  StoredProcedure [dbo].[UsersPrivileges_ChekcIfIsClosed]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UsersPrivileges_ChekcIfIsClosed]
@Id bigint 
as begin 



select count(*) from UserPayments where Id=@Id 
and dbo.UserPayments_CheckIsClosed(UserPayments.IsAcceptFromManger,UserPayments.PaymentImage)  =1
end
GO
/****** Object:  StoredProcedure [dbo].[UsersPrivileges_SelectByMenuId]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UsersPrivileges_SelectByMenuId]
@menuId int , 
@userId bigint 
as begin 

select  
		Pages.Id as Page_Id , 
		Pages.Url as Pages_Url, 
		Pages.OrderByNumber as Pages_OrderByNumber,
		PageWord.Ar as Pages_NameAr,
		PageWord.En as Pages_NameEn,
		
		UserPrivileges.Id as UsersPrivileges_Id,
		UserPrivileges.CanAdd as UsersPrivileges_CanAdd,
		UserPrivileges.CanDelete as UsersPrivileges_CanDelete,
		UserPrivileges.CanDisplay as UsersPrivileges_CanDisplay,
		UserPrivileges.CanEdit as UsersPrivileges_CanEdit


from Pages

join Words as PageWord on PageWord.Id=Pages.FKWord_Id
left join UserPrivileges on UserPrivileges.FKPage_Id=Pages.Id and UserPrivileges.FkUser_Id=@userId

where 
Pages.FkMenu_Id=@menuId
and Pages.IsForAdmin =1
end 
GO
/****** Object:  StoredProcedure [dbo].[Words_Delete]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Words_Delete]
@Id bigint 
as begin 
delete Words where Id=@Id

end 
GO
/****** Object:  StoredProcedure [dbo].[Words_Insert]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Words_Insert] 
@ar nvarchar(max),@en nvarchar(max)
as begin
insert Words (Ar,En) values (@ar,@en)
return @@identity

end 
GO
/****** Object:  StoredProcedure [dbo].[Words_Update]    Script Date: 8/30/2019 7:12:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Words_Update]
@Id bigint,
@Ar nvarchar(max),
@En nvarchar(max)
as begin

update Words set Ar=@Ar,
En=@En
where Id=@Id

end
GO
USE [master]
GO
ALTER DATABASE [Layal] SET  READ_WRITE 
GO
