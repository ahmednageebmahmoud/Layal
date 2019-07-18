USE [master]
GO
/****** Object:  Database [Layal]    Script Date: 7/18/2019 11:54:44 AM ******/
CREATE DATABASE [Layal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Layan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Layan.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Layan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Layan_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Layal] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Layal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Layal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Layal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Layal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Layal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Layal] SET ARITHABORT OFF 
GO
ALTER DATABASE [Layal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Layal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Layal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Layal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Layal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Layal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Layal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Layal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Layal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Layal] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Layal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Layal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Layal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Layal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Layal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Layal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Layal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Layal] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Layal] SET  MULTI_USER 
GO
ALTER DATABASE [Layal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Layal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Layal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Layal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Layal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Layal] SET QUERY_STORE = OFF
GO
USE [Layal]
GO
/****** Object:  UserDefinedFunction [dbo].[GetNotificationsCountIsNotRead]    Script Date: 7/18/2019 11:54:44 AM ******/
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
/****** Object:  Table [dbo].[Words]    Script Date: 7/18/2019 11:54:44 AM ******/
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
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  View [dbo].[AccountTypes_Select]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  View [dbo].[CountriesView]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CountriesView]
as 
select Countries.*,Words.Ar,
Words.En from  Countries join Words on Words.Id=Countries.Id
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  View [dbo].[CitiesView]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CitiesView]
as 
select Cities.*,Words.Ar,
Words.En from  Cities join Words on Words.Id=Cities.Id
GO
/****** Object:  Table [dbo].[AlbumTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Branches]    Script Date: 7/18/2019 11:54:45 AM ******/
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
 CONSTRAINT [PK_Branches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeDistributionWorks]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeDistributionWorks](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FKWorkType_Id] [int] NOT NULL,
	[FKEmployee_Id] [bigint] NOT NULL,
	[FKEvent_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EmployeeDistributionWorks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeesWorks]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Enquires]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enquires](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[FkCountry_Id] [int] NOT NULL,
	[FkCity_Id] [int] NOT NULL,
	[FKEnquiryType_Id] [int] NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[Day] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[FKBranch_Id] [int] NULL,
	[IsLinkedClinet] [bit] NULL,
	[IsClosed] [bit] NULL,
	[ClosedDateTime] [datetime] NULL,
	[IsWithBranch] [bit] NOT NULL,
	[ClendarEventId] [nvarchar](max) NULL,
	[IsDepositPaymented] [bit] NULL,
	[FkClinet_Id] [bigint] NULL,
	[IsCreatedEvent] [bit] NOT NULL,
 CONSTRAINT [PK_EnquiryForms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryNotes]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryNotes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[FKEnquiryForm_Id] [bigint] NOT NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_EnquiryFormNotes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryPayments]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[EnquiryStatus]    Script Date: 7/18/2019 11:54:45 AM ******/
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
 CONSTRAINT [PK_EnquiryStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryStatusTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[EnquiryTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[EventCoordinations]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventCoordinations](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[WorkNumber] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Events]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsClinetCustomLogo] [bit] NULL,
	[LogoFilePath] [nvarchar](max) NULL,
	[IsNamesAr] [bit] NULL,
	[NameGroom] [nvarchar](50) NULL,
	[NameBride] [nvarchar](50) NULL,
	[FKPrintNameType_Id] [int] NULL,
	[EventDateTime] [datetime] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[FkEnquiryForm_Id] [bigint] NULL,
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
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Menus]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Notifications]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Target_Id] [bigint] NULL,
	[FKPage_Id] [int] NOT NULL,
	[FKUser_Id] [bigint] NOT NULL,
	[FkWord_Id] [bigint] NOT NULL,
	[FKDescriptionWord_Id] [bigint] NOT NULL,
	[RedirectUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationsUser]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[PackageDetails]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[PackageInputTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Packages]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FkWordName_Id] [bigint] NOT NULL,
	[IsAllowPrintNames] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[Pages]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[PrintNamesTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrintNamesTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_PrintNamesTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPrivileges]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 7/18/2019 11:54:45 AM ******/
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
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkTypes]    Script Date: 7/18/2019 11:54:45 AM ******/
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
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[AlbumTypes] ON 
GO
INSERT [dbo].[AlbumTypes] ([Id], [FKWord_Id]) VALUES (10, 20153)
GO
SET IDENTITY_INSERT [dbo].[AlbumTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Branches] ON 
GO
INSERT [dbo].[Branches] ([Id], [Address], [PhoneNo], [FkCountry_Id], [FKCity_Id], [FKWord_Id]) VALUES (2, N'28 شارع جدة فى المدينة المنصورة', N'0102524940', 1, 1, 47)
GO
INSERT [dbo].[Branches] ([Id], [Address], [PhoneNo], [FkCountry_Id], [FKCity_Id], [FKWord_Id]) VALUES (3, N'28 شارع جدة فى المدينة المنصورة', N'0102524940', 1, 1, 48)
GO
SET IDENTITY_INSERT [dbo].[Branches] OFF
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 
GO
INSERT [dbo].[Cities] ([Id], [FKWord_Id], [FKCountry_Id]) VALUES (1, 10, 1)
GO
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 
GO
INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (1, 8, N'02')
GO
INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (2, 9, N'259')
GO
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeDistributionWorks] ON 
GO
INSERT [dbo].[EmployeeDistributionWorks] ([Id], [FKWorkType_Id], [FKEmployee_Id], [FKEvent_Id]) VALUES (19, 3, 15, 11)
GO
SET IDENTITY_INSERT [dbo].[EmployeeDistributionWorks] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeesWorks] ON 
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (42, 3, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (43, 5, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (44, 6, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (45, 7, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (46, 8, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (47, 9, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (48, 10, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (49, 11, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (50, 12, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (51, 13, 15)
GO
INSERT [dbo].[EmployeesWorks] ([Id], [FkWorkType_Id], [FKUser_Id]) VALUES (52, 14, 15)
GO
SET IDENTITY_INSERT [dbo].[EmployeesWorks] OFF
GO
SET IDENTITY_INSERT [dbo].[Enquires] ON 
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [ClendarEventId], [IsDepositPaymented], [FkClinet_Id], [IsCreatedEvent]) VALUES (1, N'fdf', N'fdf', N'0010254940', 1, 1, 9, 15, CAST(N'2019-06-27T00:36:22.397' AS DateTime), 1, 5, 2019, 2, 0, 0, NULL, 1, N'lq23agssmmtgq9bfp8khicjoik', 1, 18, 0)
GO
INSERT [dbo].[Enquires] ([Id], [FirstName], [LastName], [PhoneNo], [FkCountry_Id], [FkCity_Id], [FKEnquiryType_Id], [FKUserCreated_Id], [CreateDateTime], [Day], [Month], [Year], [FKBranch_Id], [IsLinkedClinet], [IsClosed], [ClosedDateTime], [IsWithBranch], [ClendarEventId], [IsDepositPaymented], [FkClinet_Id], [IsCreatedEvent]) VALUES (2, N'احم', N'يبيب', N'01025249400', 1, 1, 8, 5, CAST(N'2019-07-04T19:39:38.587' AS DateTime), 2, 7, 2019, 2, 1, 0, CAST(N'2019-07-16T22:31:21.873' AS DateTime), 1, NULL, 1, 19, 1)
GO
SET IDENTITY_INSERT [dbo].[Enquires] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryNotes] ON 
GO
INSERT [dbo].[EnquiryNotes] ([Id], [Notes], [CreateDateTime], [FKEnquiryForm_Id], [FKUserCreated_Id]) VALUES (23, N'sd', CAST(N'2019-06-27T00:36:22.397' AS DateTime), 1, 15)
GO
INSERT [dbo].[EnquiryNotes] ([Id], [Notes], [CreateDateTime], [FKEnquiryForm_Id], [FKUserCreated_Id]) VALUES (24, N'ملحوظة', CAST(N'2019-07-04T19:39:38.587' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryNotes] ([Id], [Notes], [CreateDateTime], [FKEnquiryForm_Id], [FKUserCreated_Id]) VALUES (25, N'يبيبيب', CAST(N'2019-07-04T19:39:57.170' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryNotes] ([Id], [Notes], [CreateDateTime], [FKEnquiryForm_Id], [FKUserCreated_Id]) VALUES (26, N'نيبينبتيب', CAST(N'2019-07-04T19:40:03.560' AS DateTime), 2, 5)
GO
SET IDENTITY_INSERT [dbo].[EnquiryNotes] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryPayments] ON 
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (1, CAST(20.00 AS Decimal(18, 2)), 1, 1, N'/Files/Enquiries/Payments/Image71ac2ef6-f31f-4b6d-8a0c-4300668228e9.jpg', 1, CAST(N'2019-07-13T17:14:51.870' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (2, CAST(20.00 AS Decimal(18, 2)), 1, 1, N'/Files/Enquiries/Payments/Image5788eac8-b72c-4b06-934c-2d0a7563425e.jpg', 1, CAST(N'2019-07-13T17:14:53.823' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (3, CAST(2000.00 AS Decimal(18, 2)), 1, 1, N'/Files/Enquiries/Payments/Image1273c700-f85f-4158-8c96-286231084952.jpg', 1, CAST(N'2019-07-13T20:04:38.323' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (4, CAST(50.00 AS Decimal(18, 2)), 0, 1, N'/Files/Enquiries/Payments/Imaged18aaed0-6aad-4643-a18d-9b4c741cdc79.jpg', 1, CAST(N'2019-07-14T00:32:21.223' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (5, CAST(50.00 AS Decimal(18, 2)), 0, 1, N'/Files/Enquiries/Payments/Image24e05c57-464c-4b67-9e5b-3988366cba08.jpg', 1, CAST(N'2019-07-14T00:43:52.733' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (6, CAST(55.00 AS Decimal(18, 2)), 0, 1, N'/Files/Enquiries/Payments/Imagefecddfb3-cd45-4115-a1a1-4901dc8fbf61.jpg', 1, CAST(N'2019-07-14T00:44:51.593' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (7, CAST(51.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T00:46:26.697' AS DateTime), 2, 16)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (8, CAST(55.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T00:47:47.273' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (9, CAST(558.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T00:55:25.377' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (10, CAST(888.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T00:58:52.423' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (11, CAST(888.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T00:59:27.813' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (12, CAST(8888.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T01:00:47.497' AS DateTime), 2, 5)
GO
INSERT [dbo].[EnquiryPayments] ([Id], [Amount], [IsDeposit], [IsBankTransfer], [TransferImage], [IsAcceptFromManger], [DateTime], [FKEnquiry_Id], [FKUserCreated_Id]) VALUES (13, CAST(54.00 AS Decimal(18, 2)), 0, 0, NULL, 0, CAST(N'2019-07-14T01:02:18.200' AS DateTime), 2, 5)
GO
SET IDENTITY_INSERT [dbo].[EnquiryPayments] OFF
GO
SET IDENTITY_INSERT [dbo].[EnquiryStatus] ON 
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (16, N'dfljdakf', CAST(N'2019-07-04T20:30:58.097' AS DateTime), CAST(N'2019-07-05T01:00:00.000' AS DateTime), 1, 5, 16, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (17, N'dsdsd', CAST(N'2019-07-04T20:33:45.630' AS DateTime), NULL, 1, 7, 16, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (27, N'دفع عربون', CAST(N'2019-07-04T20:53:46.733' AS DateTime), NULL, 2, 7, 16, NULL)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (28, N'asas', CAST(N'2019-07-13T17:14:51.833' AS DateTime), NULL, 2, 8, 16, 1)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (29, N'asas', CAST(N'2019-07-13T17:14:53.813' AS DateTime), NULL, 2, 8, 16, 2)
GO
INSERT [dbo].[EnquiryStatus] ([Id], [Notes], [DateTime], [ScheduleVisitDateTime], [FKEnquiry_Id], [FKEnquiryStatus_Id], [FKUserCreated_Id], [FKEnquiryPayment_Id]) VALUES (30, N'سيسي', CAST(N'2019-07-13T20:04:38.270' AS DateTime), NULL, 2, 8, 16, 3)
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
SET IDENTITY_INSERT [dbo].[EnquiryTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Events] ON 
GO
INSERT [dbo].[Events] ([Id], [IsClinetCustomLogo], [LogoFilePath], [IsNamesAr], [NameGroom], [NameBride], [FKPrintNameType_Id], [EventDateTime], [CreateDateTime], [FkEnquiryForm_Id], [FKPackage_Id], [FKClinet_Id], [Notes], [FKUserCreaed_Id], [FKBranch_Id], [ClendarEventId], [PackagePrice], [PackageNamsArExtraPrice], [VistToCoordinationDateTime], [VistToCoordinationClendarEventId]) VALUES (11, NULL, NULL, 1, N'يبيب', N'يسي', 6, CAST(N'2019-02-01T06:00:00.000' AS DateTime), CAST(N'2019-07-14T20:42:04.060' AS DateTime), 2, 1, 19, NULL, 16, 2, NULL, CAST(50.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2019-01-02T05:00:00.000' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[Events] OFF
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
SET IDENTITY_INSERT [dbo].[Menus] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (1, CAST(N'2019-06-24T23:15:56.647' AS DateTime), 4, 5, 15, 52, 53, N'/Enquires/EnquiryInformation?id=4&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (2, CAST(N'2019-06-25T20:37:29.467' AS DateTime), 5, 5, 15, 54, 55, N'/Enquires/EnquiryInformation?id=5&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (3, CAST(N'2019-06-25T20:38:11.430' AS DateTime), 6, 5, 15, 56, 57, N'/Enquires/EnquiryInformation?id=6&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (4, CAST(N'2019-06-25T20:39:11.657' AS DateTime), 7, 5, 15, 58, 59, N'/Enquires/EnquiryInformation?id=7&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (5, CAST(N'2019-06-25T21:15:16.920' AS DateTime), 8, 5, 15, 60, 61, N'/Enquires/EnquiryInformation?id=8&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (6, CAST(N'2019-06-25T21:17:31.970' AS DateTime), 9, 5, 15, 62, 63, N'/Enquires/EnquiryInformation?id=9&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (7, CAST(N'2019-06-25T21:20:57.613' AS DateTime), 10, 5, 15, 64, 65, N'/Enquires/EnquiryInformation?id=10&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (8, CAST(N'2019-06-25T21:23:08.843' AS DateTime), 11, 5, 15, 66, 67, N'/Enquires/EnquiryInformation?id=11&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (9, CAST(N'2019-06-25T21:24:21.480' AS DateTime), 12, 5, 15, 68, 69, N'/Enquires/EnquiryInformation?id=12&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10, CAST(N'2019-06-25T21:25:43.647' AS DateTime), 13, 5, 15, 70, 71, N'/Enquires/EnquiryInformation?id=13&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (11, CAST(N'2019-06-25T21:27:13.950' AS DateTime), 14, 5, 15, 72, 73, N'/Enquires/EnquiryInformation?id=14&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (12, CAST(N'2019-06-25T23:10:16.777' AS DateTime), 15, 5, 15, 74, 75, N'/Enquires/EnquiryInformation?id=15&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (13, CAST(N'2019-06-25T23:15:24.107' AS DateTime), 16, 5, 15, 76, 77, N'/Enquires/EnquiryInformation?id=16&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (14, CAST(N'2019-06-27T00:36:22.457' AS DateTime), 1, 5, 15, 83, 84, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (15, CAST(N'2019-06-27T01:17:46.447' AS DateTime), 1, 5, 5, 86, 87, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (16, CAST(N'2019-06-27T01:42:20.463' AS DateTime), 1, 5, 5, 88, 89, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (17, CAST(N'2019-06-27T01:50:32.037' AS DateTime), 1, 5, 16, 90, 91, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (18, CAST(N'2019-07-04T19:39:38.963' AS DateTime), 2, 5, 5, 10101, 10102, N'/Enquires/EnquiryInformation?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (19, CAST(N'2019-07-04T20:16:03.987' AS DateTime), 1, 5, 16, 10103, 10104, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (20, CAST(N'2019-07-04T20:16:32.687' AS DateTime), 1, 5, 16, 10105, 10106, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (21, CAST(N'2019-07-04T20:18:22.610' AS DateTime), 1, 5, 16, 10107, 10108, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (22, CAST(N'2019-07-04T20:22:21.610' AS DateTime), 1, 5, 16, 10109, 10110, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (23, CAST(N'2019-07-04T20:22:38.363' AS DateTime), 1, 5, 16, 10111, 10112, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (24, CAST(N'2019-07-04T20:25:22.643' AS DateTime), 1, 5, 16, 10113, 10114, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (25, CAST(N'2019-07-04T20:30:58.217' AS DateTime), 1, 5, 16, 10115, 10116, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (26, CAST(N'2019-07-04T20:33:45.643' AS DateTime), 1, 5, 16, 10117, 10118, N'/Enquires/EnquiryInformation?id=1&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (27, CAST(N'2019-07-04T20:48:57.357' AS DateTime), 3, 5, 5, 10119, 10120, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (28, CAST(N'2019-07-04T20:49:56.473' AS DateTime), 3, 5, 16, 10121, 10122, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (29, CAST(N'2019-07-04T20:50:58.560' AS DateTime), 3, 5, 16, 10123, 10124, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (30, CAST(N'2019-07-04T20:51:06.120' AS DateTime), 3, 5, 16, 10125, 10126, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (31, CAST(N'2019-07-04T20:51:07.857' AS DateTime), 3, 5, 16, 10127, 10128, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (32, CAST(N'2019-07-04T20:51:12.357' AS DateTime), 3, 5, 16, 10129, 10130, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (33, CAST(N'2019-07-04T20:51:14.583' AS DateTime), 3, 5, 16, 10131, 10132, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (34, CAST(N'2019-07-04T20:51:17.237' AS DateTime), 3, 5, 16, 10133, 10134, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (35, CAST(N'2019-07-04T20:51:17.967' AS DateTime), 3, 5, 16, 10135, 10136, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (36, CAST(N'2019-07-04T20:51:18.343' AS DateTime), 3, 5, 16, 10137, 10138, N'/Enquires/EnquiryInformation?id=3&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (37, CAST(N'2019-07-04T20:53:47.023' AS DateTime), 2, 5, 16, 10139, 10140, N'/Enquires/EnquiryInformation?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (38, CAST(N'2019-07-07T00:55:44.947' AS DateTime), 8, 12, 16, 10144, 10145, N'/Events/EventInformation?id=8&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (39, CAST(N'2019-07-07T19:56:10.300' AS DateTime), 9, 12, 16, 10146, 10147, N'/Events/EventInformation?id=9&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10039, CAST(N'2019-07-13T17:14:53.743' AS DateTime), 2, 5, 16, 20195, 20196, N'/EnquiryPayments/PaymentsInformations?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10040, CAST(N'2019-07-13T17:14:53.830' AS DateTime), 2, 5, 16, 20197, 20198, N'/EnquiryPayments/PaymentsInformations?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10041, CAST(N'2019-07-13T17:14:53.860' AS DateTime), 2, 5, 16, 20199, 20200, N'/Enquires/EnquiryInformation?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10042, CAST(N'2019-07-13T17:14:53.867' AS DateTime), 2, 5, 16, 20201, 20202, N'/Enquires/EnquiryInformation?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10043, CAST(N'2019-07-13T20:04:39.053' AS DateTime), 2, 5, 16, 20204, 20205, N'/EnquiryPayments/PaymentsInformations?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10044, CAST(N'2019-07-13T20:04:39.303' AS DateTime), 2, 5, 16, 20206, 20207, N'/Enquires/EnquiryInformation?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10045, CAST(N'2019-07-14T00:43:52.780' AS DateTime), 2, 5, 16, 20208, 20209, N'/EnquiryPayments/Payments?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10046, CAST(N'2019-07-14T00:46:26.723' AS DateTime), 2, 5, 16, 20210, 20211, N'/EnquiryPayments/Payments?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10047, CAST(N'2019-07-14T00:47:47.293' AS DateTime), 2, 5, 5, 20212, 20213, N'/EnquiryPayments/Payments?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10048, CAST(N'2019-07-14T01:02:18.227' AS DateTime), 2, 5, 5, 20214, 20215, N'/EnquiryPayments/Payments?id=2&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10049, CAST(N'2019-07-14T20:35:38.753' AS DateTime), 10, 12, 16, 20216, 20217, N'/Events/EventInformation?id=10&notifyId=')
GO
INSERT [dbo].[Notifications] ([Id], [DateTime], [Target_Id], [FKPage_Id], [FKUser_Id], [FkWord_Id], [FKDescriptionWord_Id], [RedirectUrl]) VALUES (10050, CAST(N'2019-07-14T20:42:10.003' AS DateTime), 11, 12, 16, 20218, 20219, N'/Events/EventInformation?id=11&notifyId=')
GO
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationsUser] ON 
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (1, 1, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (2, 2, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (3, 3, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (4, 4, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (5, 5, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (6, 6, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (7, 7, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (8, 8, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (9, 9, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10, 10, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (11, 11, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (12, 12, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (13, 13, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (14, 14, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (15, 15, 16, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (16, 16, 16, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (17, 17, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (18, 18, 16, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (19, 19, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (20, 20, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (21, 21, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (22, 22, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (23, 23, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (24, 24, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (25, 25, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (26, 26, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (27, 27, 16, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (28, 28, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (29, 29, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (30, 30, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (31, 31, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (32, 32, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (33, 33, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (34, 34, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (35, 35, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (36, 36, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (37, 37, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (38, 38, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (39, 39, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10039, 10039, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10040, 10040, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10041, 10041, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10042, 10042, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10043, 10043, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10044, 10044, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10045, 10045, 5, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10046, 10046, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10047, 10047, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10048, 10048, 16, 1)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10049, 10049, 5, 0)
GO
INSERT [dbo].[NotificationsUser] ([Id], [FKNotify_Id], [FKUser_Id], [IsRead]) VALUES (10050, 10050, 5, 0)
GO
SET IDENTITY_INSERT [dbo].[NotificationsUser] OFF
GO
SET IDENTITY_INSERT [dbo].[PackageDetails] ON 
GO
INSERT [dbo].[PackageDetails] ([Id], [FKWord_Id], [FKPackageInputType_Id], [FKPackage_Id]) VALUES (15, 20179, 6, 1)
GO
SET IDENTITY_INSERT [dbo].[PackageDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[PackageInputTypes] ON 
GO
INSERT [dbo].[PackageInputTypes] ([Id], [FKWord_Id]) VALUES (6, 10099)
GO
INSERT [dbo].[PackageInputTypes] ([Id], [FKWord_Id]) VALUES (8, 20155)
GO
SET IDENTITY_INSERT [dbo].[PackageInputTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Packages] ON 
GO
INSERT [dbo].[Packages] ([Id], [FkWordName_Id], [IsAllowPrintNames], [FkWordDescription_Id], [FKAlbumType_Id], [Price], [NamsArExtraPrice]) VALUES (1, 10143, 1, 20156, 10, CAST(50.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Packages] OFF
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (1, 3, N'/UsersPrivileges', 2, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (2, 12, N'/Users', 2, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (3, 13, N'/Countries', 1, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (4, 34, N'/EnquiryTypes', 3, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (5, 41, N'/Enquires', 3, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (6, 45, N'/Branches', 1, 3, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (7, 50, N'/MyEnquires', 3, 1, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (8, 51, N'/MyEnquires/AddAndUpdate', 3, 2, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (9, 51, N'/Enquires/AddAndUpdate', 3, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (10, 85, N'/', 2, 3, 0, 1, 1)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (11, 10088, N'/PrintNamesTypes', 1, 4, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (12, 10141, N'/Events', 4, 1, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (13, 10141, N'/MyEvents', 4, 1, 1, 0, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (14, 20147, N'/Packages', 5, 3, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (15, 20148, N'/AlbumTypes', 5, 2, 0, 1, 0)
GO
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber], [IsForClient], [IsForAdmin], [IsHide]) VALUES (16, 20150, N'/PackageInputTypes', 5, 1, 0, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[PrintNamesTypes] ON 
GO
INSERT [dbo].[PrintNamesTypes] ([Id], [FKWord_Id]) VALUES (6, 10099)
GO
INSERT [dbo].[PrintNamesTypes] ([Id], [FKWord_Id]) VALUES (7, 10100)
GO
SET IDENTITY_INSERT [dbo].[PrintNamesTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[UserPrivileges] ON 
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (13, 5, 16, 0, 0, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (16, 2, 16, 1, 0, 0, 0)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (17, 10, 16, 0, 0, 0, 1)
GO
INSERT [dbo].[UserPrivileges] ([Id], [FKPage_Id], [FkUser_Id], [CanAdd], [CanEdit], [CanDelete], [CanDisplay]) VALUES (18, 12, 16, 1, 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[UserPrivileges] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive]) VALUES (5, N'ahmed', N'a0hed@gmail.com', N'01025249400', N'dfdfdfdfdffdfdfdfssssd', N'123456', NULL, 1, 1, 1, 2, CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, 0, NULL, 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive]) VALUES (15, N'ahmed10', N'a0hmed@gmail.com', N'010252494', N'sdsd', N'123456', NULL, 5, 1, 1, 2, CAST(N'2019-06-22T22:33:57.323' AS DateTime), 2, 0, NULL, 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive]) VALUES (16, N'branch', N'branch@gmail.com', N'0102524900', N'sdsd', N'123456', NULL, 3, 1, 1, 2, CAST(N'2019-06-24T23:19:06.467' AS DateTime), 2, 0, NULL, 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive]) VALUES (18, N'fdf', N'a55550hmed@gmail.com55', N'0010254940', N'sdsdsd', N'123456', N'C-13893', 5, 1, 1, 1, CAST(N'2019-06-30T18:13:13.637' AS DateTime), 2, 1, NULL, 1)
GO
INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime], [FKPranch_Id], [IsActiveEmail], [DateOfBirth], [IsActive]) VALUES (19, N'testUser', N'shahnda2017@gmail.com', N'1236454215', NULL, N'123456', N'C-19904', 4, 1, 1, 2, CAST(N'2019-07-04T20:57:04.583' AS DateTime), 2, 1, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
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
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (93, N'الرغبة فى الحجز', N'Desire To Book ')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (94, N'عربون حوالة بنكية', N'Bank Transfer Deposit')
GO
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10088, N'انواع طباعة  الاسماء', N'Print Names Types')
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
SET IDENTITY_INSERT [dbo].[Words] OFF
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (1, 20181, N'')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (2, 20182, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (3, 20183, N'/EventCoordinations')
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (4, 20184, NULL)
GO
INSERT [dbo].[WorkTypes] ([Id], [FKWord_Id], [PageUrl]) VALUES (5, 20185, NULL)
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
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Words]
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
ALTER TABLE [dbo].[Enquires]  WITH CHECK ADD  CONSTRAINT [FK_Enquires_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[Enquires] CHECK CONSTRAINT [FK_Enquires_Branches]
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
ALTER TABLE [dbo].[EnquiryNotes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryFormNotes_EnquiryForms] FOREIGN KEY([FKEnquiryForm_Id])
REFERENCES [dbo].[Enquires] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryNotes] CHECK CONSTRAINT [FK_EnquiryFormNotes_EnquiryForms]
GO
ALTER TABLE [dbo].[EnquiryNotes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryFormNotes_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EnquiryNotes] CHECK CONSTRAINT [FK_EnquiryFormNotes_Users]
GO
ALTER TABLE [dbo].[EnquiryPayments]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryPayments_Enquires] FOREIGN KEY([FKEnquiry_Id])
REFERENCES [dbo].[Enquires] ([Id])
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
ALTER TABLE [dbo].[EventCoordinations]  WITH CHECK ADD  CONSTRAINT [FK_EventCoordination_Events] FOREIGN KEY([FKEvent_Id])
REFERENCES [dbo].[Events] ([Id])
GO
ALTER TABLE [dbo].[EventCoordinations] CHECK CONSTRAINT [FK_EventCoordination_Events]
GO
ALTER TABLE [dbo].[EventCoordinations]  WITH CHECK ADD  CONSTRAINT [FK_EventCoordination_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EventCoordinations] CHECK CONSTRAINT [FK_EventCoordination_Users]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Branches] FOREIGN KEY([FKBranch_Id])
REFERENCES [dbo].[Branches] ([Id])
GO
ALTER TABLE [dbo].[Events] CHECK CONSTRAINT [FK_Events_Branches]
GO
ALTER TABLE [dbo].[Events]  WITH CHECK ADD  CONSTRAINT [FK_Events_Enquires] FOREIGN KEY([FkEnquiryForm_Id])
REFERENCES [dbo].[Enquires] ([Id])
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
ALTER TABLE [dbo].[WorkTypes]  WITH CHECK ADD  CONSTRAINT [FK_WorkTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
GO
ALTER TABLE [dbo].[WorkTypes] CHECK CONSTRAINT [FK_WorkTypes_Words]
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AlbumTypes_CheckIfUsed] 
@Id int
as begin

select 
isnull(count(*),0)  from Packages where FKAlbumType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[AlbumTypes_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Cities where Id=@Id)
delete  AlbumTypes where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AlbumTypes_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AlbumTypes_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[AlbumTypes_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Branches_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Branches_CheckIfUsed] 
@Id bigint
as begin

select (count(*)-1)as countr from Branches
left join Enquires on Enquires.FKBranch_Id=Branches.Id
where Branches.Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Branches_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Branches where Id=@Id)
delete  Branches where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Branches_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
@WordId int output


as begin
-- Insert Word 
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[Branches]
           ([Address]
           ,PhoneNo
           ,[FkCountry_Id]
           ,[FKCity_Id]
           ,[FKWord_Id])
		   values (@Address,@Phone,@CountryId,@CityId,@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[Branches_SelectByAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Branches_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Branches_SelectByFilter]
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
/****** Object:  StoredProcedure [dbo].[Branches_SelectByPk]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Branches_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
@WordId bigint


as begin
-- Update Word 
exec  dbo.Words_Update @WordId, @NameAr,@NameEn
-- Insert Target
update [dbo].[Branches]
           set [Address]=@Address
           ,PhoneNo=@Phone
           ,[FkCountry_Id]=@CountryId
           ,[FKCity_Id]=@CityId
end


GO
/****** Object:  StoredProcedure [dbo].[Cities_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Cities_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Cities where Id=@Id)
delete  Cities where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Cities_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Countries_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Cities where FKCountry_Id=@Id)
delete Words where Words.Id in (select  FKWord_Id from Countries where Id=@Id)


delete Cities where FKCountry_Id=@Id
delete  Countries where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Countries_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_IsoCodeBeforUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectWithCitiesByPk]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_CheckIfInserted]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EmployeeDistributionWorks_CheckIfInserted]
 
@WorkTypeId int,
@EmployeeId bigint,
@EventId bigint
as begin
select  count(*) from  [dbo].[EmployeeDistributionWorks]
where [FKWorkType_Id]=@WorkTypeId 
and	  [FKEmployee_Id]=@EmployeeId
and   FKEvent_Id=@EventId

		    
end


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeeDistributionWorks_Insert]
@Id	bigint	output,
@WorkTypeId int,
@EmployeeId bigint,
@EventId bigint
as begin
INSERT INTO [dbo].[EmployeeDistributionWorks]
           ([FKWorkType_Id]
           ,[FKEmployee_Id],
		   FKEvent_Id)
     VALUES
           (@WorkTypeId,@EmployeeId,@EventId)

		   select @Id=@@IDENTITY
end


GO
/****** Object:  StoredProcedure [dbo].[EmployeeDistributionWorks_SelectByEventId]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EmployeeDistributionWorks_SelectByEventId]
@EventId bigint

as begin 
select * from  EmployeeDistributionWorks 
where FKEvent_Id=@EventId

end 
GO
/****** Object:  StoredProcedure [dbo].[Employees_CheckAllowAccessToEventByWorkTypeId]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Employees_CheckAllowAccessToEventByWorkTypeId] 
@eventId bigint,
@workTypeId int,
@employeeId bigint
as begin 


select count(*) from EmployeeDistributionWorks 
where FKEvent_Id=@eventId
and FKWorkType_Id=@workTypeId
and FKEmployee_Id=@employeeId

end
GO
/****** Object:  StoredProcedure [dbo].[Employees_SelectWorks]    Script Date: 7/18/2019 11:54:45 AM ******/
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

(select count(Id) from EmployeeDistributionWorks where FKWorkType_Id=EmployeesWorks.FKWorkType_Id and FKEmployee_Id=@EmpId ) as WorksCount
from WorkTypes 
join EmployeesWorks on EmployeesWorks.FKUser_Id=@EmpId and EmployeesWorks.FkWorkType_Id=WorkTypes.Id
join Words on Words.Id=WorkTypes.FKWord_Id

end
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_CheckIfInserted]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EmployeesWorks_CheckIfInserted]
@WorkTypeId int ,
@UserId bigint
as begin 

select ISNULL(count(*),0)  from EmployeesWorks 
 where FkWorkType_Id=@WorkTypeId and FKUser_Id=@UserId 

end 
GO
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EmployeesWorks_SelectByUserId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Enquires_Closed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
	  Select Enquires.ClendarEventId as Enquiry_ClendarEventId,
	           events.ClendarEventId as Event_ClendarEventId,
			   events.VistToCoordinationClendarEventId
	  from Enquires 
	 left join events on events.FkEnquiryForm_Id=Enquires.Id
	  where Enquires.Id=@EnquiryId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[Enquires_Delete]
 @Id bigint 
 as begin
 delete Enquires where Id =@Id
end

GO
/****** Object:  StoredProcedure [dbo].[Enquires_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
 @CreateDateTime datetime,
 @Notes nvarchar(max),
 @BranchId int,
 @IsLinkedClinet bit,
 @IFWithBranch  bit

 as begin
 
 if(@FKEnquiryType_Id =0)
	set @FKEnquiryType_Id=null
 
 if(@BranchId =0)
	set @BranchId=null
	
INSERT INTO [dbo].[Enquires]
           ([FirstName]
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
		   IsLinkedClinet,IsWithBranch )
     VALUES
          (@FirstName,  
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
		   @IsLinkedClinet,@IFWithBranch 
		   )
select @Id = @@IDENTITY

 if(@Notes is not null)
insert EnquiryNotes (Notes,CreateDateTime,FKEnquiryForm_Id,FKUserCreated_Id)
values (@Notes,@CreateDateTime,@Id,@FKUserCreated_Id)
end

GO
/****** Object:  StoredProcedure [dbo].[Enquires_IsClosed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
	@IsWithBranch bit
	


as begin 
select 
		Enquires.*,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		EnquiryTypeWord.Ar as EnquiryTypeNameAr,
		EnquiryTypeWord.En as EnquiryTypeNameEn,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn,
		UserCreated.UserName as EnquiryCreatedUserName,
		events.Id as EventId
from Enquires

join Countries on Countries.Id=Enquires.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Enquires.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id

left join EnquiryTypes on EnquiryTypes.Id=Enquires.FKEnquiryType_Id
left join Words EnquiryTypeWord on EnquiryTypeWord.Id=EnquiryTypes.FKWord_Id

left join Branches on Branches.Id=Enquires.FKBranch_Id
left join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id

left join events  on events.FkEnquiryForm_Id=Enquires.Id

join Users as UserCreated on UserCreated.Id=Enquires.FKUserCreated_Id

where 
	(@IsLinkedClinet is null  or  [Enquires].IsLinkedClinet=@IsLinkedClinet)
	and 
	(@IsForCurrentUser = 0 or [Enquires].FKUserCreated_Id=@CurrentUserLoggadId or [Enquires].FkClinet_Id=@CurrentUserLoggadId)
	and
	(@BranchId is null or @BranchId =0  or [Enquires].FKBranch_Id=@BranchId)
	and
	(@BranchId is null or @BranchId !=0  or [Enquires].FKBranch_Id is null)
	and
	(@EnquiryId is null or @EnquiryId =0 or Enquires.FKEnquiryType_Id=@EnquiryId) 
	and 
	(@CountryId is null or @CountryId =0 or Enquires.FkCountry_Id=@CountryId) 
	and 
	(@CityId is null or @CityId =0 or Enquires.FkCity_Id=@CityId) 
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
	(@IsWithBranch is null  or Enquires.IsWithBranch =@IsWithBranch) 

	
	
	order by Enquires.Id desc
	offset @Skip rows
	Fetch next @Take Rows Only

end
GO
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByPk]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Enquires_SelectByPk]
@EnquiyId bigint 
as begin 
select 
		Enquires.*,
		CountryWord.Ar as CountryNameAr,
		CountryWord.En as CountryNameEn,
		CityWord.Ar as CityNameAr,
		CityWord.En as CityNameEn,
		EnquiryTypeWord.Ar as EnquiryTypeNameAr,
		EnquiryTypeWord.En as EnquiryTypeNameEn,
		BrancheWord.Ar as BranchNameAR,
		BrancheWord.En as BranchNameEn,
		UserCreated.UserName as EnquiryCreatedUserName,
		events.Id as EventId

from Enquires

join Countries on Countries.Id=Enquires.FkCountry_Id
join Words CountryWord on CountryWord.Id=Countries.FKWord_Id

join Cities on Cities.Id=Enquires.FkCity_Id
join Words CityWord on CityWord.Id=Cities.FKWord_Id

left join EnquiryTypes on EnquiryTypes.Id=Enquires.FKEnquiryType_Id
left join Words EnquiryTypeWord on EnquiryTypeWord.Id=EnquiryTypes.FKWord_Id

left join Branches on Branches.Id=Enquires.FKBranch_Id
left join Words BrancheWord on BrancheWord.Id=Branches.FKWord_Id

join Users as UserCreated on UserCreated.Id=Enquires.FKUserCreated_Id


left join events  on events.FkEnquiryForm_Id=Enquires.Id


where Enquires.Id = @EnquiyId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_SelectByPk_SimpleData]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquires_SelectByPk_SimpleData] 
@EnauiryId bigint 
as begin 
select * from Enquires where Id=@EnauiryId
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquires_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
 @Notes nvarchar(max),
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
 if(@Notes is not null)
 insert EnquiryNotes 
 (CreateDateTime,FKEnquiryForm_Id,FKUserCreated_Id,Notes)
 values (@NotesCreateDateTime,@Id,@NotesFkUsereCreatedId,@Notes)
end

GO
/****** Object:  StoredProcedure [dbo].[Enquiries_ChangeCreateEventState]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Enquiries_ChangeCreateEventState]
@Id bigint,
@IsCreatedEvent bit
as begin 
update Enquires 
	   set IsCreatedEvent=@IsCreatedEvent 
	   where Id=   @Id    
end 
GO
/****** Object:  StoredProcedure [dbo].[Enquiries_UpdateCalendarEventId]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[Enquiries_UpdateCalendarEventId]
 @EnquiryId bigint,
 @ClendarEventId nvarchar(max)
 as begin

 update Enquires
 set ClendarEventId=@ClendarEventId
 where Id=@EnquiryId

 end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryNote_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[EnquiryNote_Insert]
@Notes nvarchar(max),
@CreateDateTime datetime , 
@FKEnquiryForm_Id bigint,
@FKUserCreated_Id bigint
as begin
INSERT INTO [dbo].[EnquiryNotes]
           ([Notes]
           ,[CreateDateTime]
           ,[FKEnquiryForm_Id]
           ,[FKUserCreated_Id])
     VALUES
           (@Notes,@CreateDateTime,@FKEnquiryForm_Id,@FKUserCreated_Id)
end


GO
/****** Object:  StoredProcedure [dbo].[EnquiryNotes_SelectByEnquiryId]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryNotes_SelectByEnquiryId]
@EnquiryId bigint 
as begin
select
	EnquiryNotes.*, UserCreatedNotes.UserName
from EnquiryNotes
left join Users as UserCreatedNotes on UserCreatedNotes.Id=EnquiryNotes.FKUserCreated_Id
where EnquiryNotes.FKEnquiryForm_Id = @EnquiryId
order by Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_AcceptFromManger]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryPayments_AcceptFromManger]
@Id	bigint,
@IsDeposit bit,
@EnquiryId bigint
as begin

update [dbo].[EnquiryPayments]
      set [IsAcceptFromManger]=1
	  where Id=@Id

	  --اذا كان هذا العربون وقد تم تاكيدة من المدير لانة ان حولة بكية 
	  --اذا نقوم الان بتفعيل عملية دفع العربون فى الاستفسار 
	  if(@IsDeposit =1)
	  update Enquires set IsDepositPaymented=1 where Enquires.Id=@EnquiryId

end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryPayments_SelectByEnquiryId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryStatus_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryStatusTypes_SelectByEnquiryId]    Script Date: 7/18/2019 11:54:45 AM ******/
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

		UserCreatedStatus.UserName as Status_CreatedUserName

from EnquiryStatus
 
 join Users as UserCreatedStatus on UserCreatedStatus.Id=EnquiryStatus.FKUserCreated_Id

 join EnquiryStatusTypes on EnquiryStatusTypes.Id=EnquiryStatus.FKEnquiryStatus_Id
 join Words  as WordEnquiryStatusType on WordEnquiryStatusType.Id=EnquiryStatusTypes.FKWord_Id


where EnquiryStatus.FKEnquiry_Id = @EnquiyId
order by EnquiryStatus.Id desc
end 
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryTypes_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from EnquiryTypes where Id=@Id)

delete  EnquiryTypes where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EventCoordinations_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventCoordinations_Delete]
			 
            @Id bigint
			as begin
delete [dbo].[EventCoordinations]
where Id=@Id
			end
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EventCoordinations_Insert]
			@WorkNumber int,
            @Task nvarchar(50),
            @StartTime time(7),
            @EndTime time(7),
            @Notes nvarchar(max),
            @FKEvent_Id bigint,
            @FKUserCreated_Id bigint
			as begin
INSERT INTO [dbo].[EventCoordinations]
           ([WorkNumber]
           ,[Task]
           ,[StartTime]
           ,[EndTime]
           ,[Notes]
           ,[FKEvent_Id]
           ,[FKUserCreated_Id])
     VALUES
           (@WorkNumber  ,
 			@Task ,
			@StartTime,
			@EndTime ,
			@Notes ,
			@FKEvent_Id ,
			@FKUserCreated_Id )

			end
GO
/****** Object:  StoredProcedure [dbo].[EventCoordinations_SelectByEventId]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EventCoordinations_SelectByEventId]
			 
            @EventId bigint
			as begin
select EventCoordinations.*,Users.UserName from 
EventCoordinations
join Users on Users.Id=EventCoordinations.FKUserCreated_Id

where EventCoordinations.FKEvent_Id=@EventId
			end
GO
/****** Object:  StoredProcedure [dbo].[Events_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_Insert]
		   @Id	bigint output,
		   @IsClinetCustomLogo            bit,
           @LogoFilePath               nvarchar(max),
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @EventDateTime			   datetime,
           @CreateDateTime			   datetime,
           @FkEnquiryForm_Id		   bigint,
           @FKPackage_Id				int,
           @FKPrintNameType_Id			int,
           @FKClinet_Id					bigint,
           @Notes						nvarchar(max),
           @FKUserCreaed_Id				bigint,
           @FKBranch_Id					int,
		   @PackagePrice decimal(18,2),
		   @PackageNamsArExtraPrice decimal(18,2),
		   @VistToCoordinationDateTime datetime

as begin
INSERT INTO [dbo].[Events]
           ([IsClinetCustomLogo]
           ,[LogoFilePath]
           ,[IsNamesAr]
           ,[NameGroom]
           ,[NameBride]
           ,[EventDateTime]
           ,[CreateDateTime]
           ,[FkEnquiryForm_Id]
           ,[FKPackage_Id]
           ,[FKPrintNameType_Id]
           ,[FKClinet_Id]
           ,[Notes]
           ,[FKUserCreaed_Id]
           ,[FKBranch_Id],
		   PackagePrice ,
		   PackageNamsArExtraPrice ,
		   VistToCoordinationDateTime)
     VALUES
           (@IsClinetCustomLogo     ,
			@LogoFilePath           ,
			@IsNamesAr              ,
			@NameGroom				,
			@NameBride				,
			@EventDateTime			,
			@CreateDateTime			,
			@FkEnquiryForm_Id		,
			@FKPackage_Id			,
			@FKPrintNameType_Id		,
			@FKClinet_Id			,	
			@Notes					,
			@FKUserCreaed_Id		,	
			@FKBranch_Id,
			@PackagePrice ,
		    @PackageNamsArExtraPrice,
			@VistToCoordinationDateTime)

			set @Id=@@IDENTITY
end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
WordPrintNamesType.En	as WordPrintNamesType_NameEn
	from Events

left	join Enquires on Enquires.Id = Events.FkEnquiryForm_Id
	
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
/****** Object:  StoredProcedure [dbo].[Events_SelectByFilterForEmployee]    Script Date: 7/18/2019 11:54:45 AM ******/
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
		   @EmplolyeeId bigint

		   
as begin 

select Events.* ,
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
 	join Enquires on Enquires.Id = Events.FkEnquiryForm_Id
	
	join Branches   on Branches.Id = Events.FKBranch_Id
	join Packages   on Packages.Id = Events.FKPackage_Id
left	join PrintNamesTypes   on PrintNamesTypes.Id = Events.FKPrintNameType_Id

	join Words as WordBranche   on WordBranche.Id = Branches.FKWord_Id
	join Words as WordPackage   on WordPackage.Id = Packages.FkWordName_Id
left	join Words as WordPrintNamesType   on WordPrintNamesType.Id = PrintNamesTypes.FKWord_Id

	where 
	Enquires.IsClosed=0 and 
	-- التحق
	(     @IsClinetCustomLogo	is null or	Events.IsClinetCustomLogo	=@IsClinetCustomLogo	)																					
	and(  @IsNamesAr           	is null or	Events.IsNamesAr           	=@IsNamesAr				)					
	and(  @NameGroom			is null or	Events.NameGroom			=@NameGroom				)					
	and(  @NameBride			is null or	Events.NameBride			=@NameBride				)					
	and(  @EventDateTimeFrom	is null or	Events.EventDateTime>=		@EventDateTimeFrom			)					
	and(  @EventDateTimeTo		is null or	Events.EventDateTime<=		@EventDateTimeTo			)					
	and(  @FKPackage_Id			is null or	Events.FKPackage_Id			=@FKPackage_Id			)					
	and(  @FKPrintNameType_Id	is null or	Events.FKPrintNameType_Id	=@FKPrintNameType_Id	)					


	order by Id  desc
	Offset @skip rows
	Fetch Next @Take rows only



end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectByPK]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectByPK]
@Id bigint
as begin 

select Events.*,
(select IsNull(sum(Amount),0) from EnquiryPayments)as TotalPayments,
(select IsNull(sum(Amount),0) from EnquiryPayments where EnquiryPayments.IsBankTransfer =0  or EnquiryPayments.IsAcceptFromManger=1)as TotalPaymentsActivated
from Events

	where Events.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Events_SelectInformation]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SelectInformation]
@Id bigint
as begin 

select Events.* ,
	   Enquires.FirstName +' '+ Enquires.LastName as EnquiryName ,
	   Enquires.IsClosed ,
	   PackageWord.Ar as Package_NameAr,
	   PackageWord.En as Package_NameEn ,
	   Packages.IsAllowPrintNames as Package_IsAllowPrintNames,
	   PrintNameTypeWord.Ar as PrintNameType_NameAr,
	   PrintNameTypeWord.En as PrintNameType_NameEn ,
	    
	   BranchWord.Ar as Branch_NameAr,
	   BranchWord.En as Branch_NameEn ,
	   
	   Clinet.UserName as Clinet_UserName,
	   UserCreated.UserName as UserCreated_UserName,
	   (select IsNull(sum(Amount),0) from EnquiryPayments)as TotalPayments,
(select IsNull(sum(Amount),0) from EnquiryPayments where EnquiryPayments.IsBankTransfer =0  or EnquiryPayments.IsAcceptFromManger=1)as TotalPaymentsActivated

	   
	from Events

left	join Enquires on Enquires.Id = Events.FkEnquiryForm_Id
	
	join Packages on Packages.Id = Events.FKPackage_Id
	join Words as PackageWord  on PackageWord.Id = Packages.FkWordName_Id
	
	join PrintNamesTypes on PrintNamesTypes.Id = Events.FKPrintNameType_Id
	join Words as PrintNameTypeWord  on PrintNameTypeWord.Id = PrintNamesTypes.FKWord_Id
	
	 
	join Branches on Branches.Id = Events.FKBranch_Id
	join Words as BranchWord  on BranchWord.Id = Branches.FKWord_Id


	join Users as Clinet  on Clinet.Id = Events.FKClinet_Id
	join Users as UserCreated  on UserCreated.Id = Events.FKUserCreaed_Id

	where Events.Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Events_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
		   @VistToCoordinationDateTime datetime

as begin
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
			VistToCoordinationDateTime=@VistToCoordinationDateTime
   

			where Id=@Id
end									
			 
			 
			 
			 
			
			
			
			
			
			
			
				
				
			
				
			
GO
/****** Object:  StoredProcedure [dbo].[Events_Update2]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Events_Update2]
		   @Id	bigint  ,
		   @IsClinetCustomLogo            bit,
           @LogoFilePath               nvarchar(max),
           @IsNamesAr                  bit,
           @NameGroom				   nvarchar(50),
           @NameBride				   nvarchar(50),
           @FKPrintNameType_Id			int,
		      @PackagePrice decimal(18,2),
		   @PackageNamsArExtraPrice decimal(18,2)

as begin
update [dbo].[Events]
          set [IsClinetCustomLogo]  =@IsClinetCustomLogo    										 
           ,[LogoFilePath]			=@LogoFilePath           
           ,[IsNamesAr]				=@IsNamesAr              
           ,[NameGroom]				=@NameGroom				 
           ,[NameBride]				=@NameBride				 
           ,[FKPrintNameType_Id]	=@FKPrintNameType_Id	,	 
		     PackagePrice= @PackagePrice ,
		  PackageNamsArExtraPrice= @PackageNamsArExtraPrice 
   

			where Id=@Id
end									
			 
			 
			 
			 
			
			
			
			
			
			
			
				
				
			
				
			
GO
/****** Object:  StoredProcedure [dbo].[Events_UpdateCalendarEventId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Menus_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllByUser_Id]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllForUserCanBeAccess]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Notifications_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Notifications_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[NotificationsUser_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[NotificationsUser_Read]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Package_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageDetails_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageDetails_DeleteAllByPackageId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageDetails_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PackageInputTypes_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
@IsAllowPrintNames bit,
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
           ,[IsAllowPrintNames]
           ,[FkWordDescription_Id]
           ,[FKAlbumType_Id],Price,NamsArExtraPrice
            )
     VALUES
           (@WordNameId,@IsAllowPrintNames,@WordDescriptionId,
		   @AlbumTypeId,@Price,@NamsArExtraPrice)
		   select @Id=@@IDENTITY
end


GO
/****** Object:  StoredProcedure [dbo].[Packages_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_SelectByPaging]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_SelectByPK]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Packages_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
@IsAllowPrintNames bit,
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
           [IsAllowPrintNames]=@IsAllowPrintNames
           ,[FKAlbumType_Id]=@AlbumTypeId,
		   Price =@Price ,
		   NamsArExtraPrice=@NamsArExtraPrice

where Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllByUser_Id]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllForUserCanBeAccess]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_CheckIfUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PrintNamesTypes_Delete]
@Id bigint
as begin
delete Words where Words.Id in (select  FKWord_Id from Cities where Id=@Id)
delete  PrintNamesTypes where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create  proc [dbo].[PrintNamesTypes_Insert]
@Id int output , 
@NameAr nvarchar(50),
@NameEn nvarchar(50)

as begin
-- Insert Word 
declare @WordId int ;
exec @WordId =   dbo.Words_Insert @NameAr,@NameEn

-- Insert Target
INSERT INTO [dbo].[PrintNamesTypes]
           ([FKWord_Id]
           )
     VALUES
           (@WordId)

		 select  @Id=@@identity
end


GO
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[PrintNamesTypes_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PrintNamesTypes_Update]
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
/****** Object:  StoredProcedure [dbo].[PrintNameTypes_SelectAll]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[User_EmailBeforUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[User_EmailBeforUsed] 
@UserId bigint,
@Email nvarchar(50)
as begin

select count(*) from Users where Email=@Email 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[User_PhoneNumberBeforUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[User_PhoneNumberBeforUsed] 
@UserId bigint,
@PhoneNumber nvarchar(50)
as begin

select count(*) from Users where PhoneNo=@PhoneNumber 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[User_UserNameBeforUsed]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[User_UserNameBeforUsed] 
@UserId bigint,
@UserName nvarchar(50)
as begin

select count(*) from Users where UserName=@UserName 
and (@UserId = 0 or @UserId is null or Id!=@UserId) 

end
GO
/****** Object:  StoredProcedure [dbo].[UserPrivileges_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UserPrivileges_RemoveByMenuIdAndUserId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UserPrivileges_SelectByUserId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_ActiveEmail]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_CheckFromActiveCode]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_CheckIfEmailActivated]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
		   @DateOfBirth  date
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
		   DateOfBirth)
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
		   @DateOfBirth)

		   --نقوم بتحيث الاستفسار الان
		   if(@EnquiryId is not null)
		   update Enquires set IsLinkedClinet=1 , FkClinet_Id =@@IDENTITY where Enquires.Id=@EnquiryId


select @Id= @@IDENTITY


end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAllEmployees]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectByBranchId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
join EmployeesWorks on EmployeesWorks.FKUser_Id=Users.Id
Where FKPranch_Id=@BranchId and FKAccountType_Id=@AccountTypeId
end
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByFilter]    Script Date: 7/18/2019 11:54:45 AM ******/
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
@LanguageId int
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
(@UserName		= ''  or @UserName		 is null or users.UserName like '%'+@UserName+'%')and
(@Email  		= ''  or @Email  		 is null or users.Email like '%'+@Email+'%')and
(@PhoneNumber   = ''  or @PhoneNumber    is null or users.PhoneNo like '%'+@PhoneNumber+'%')and
(@Adddress		= ''  or @Adddress		  is null or users.Address like '%'+@Adddress+'%')and
(@CreateDateTo  	is null or users.CreateDateTime<=@CreateDateTo )and
(@CreateDateFrom  	is null or users.CreateDateTime>=@CreateDateFrom)and
(@CountryId 		is null or users.FkCountry_Id=@CountryId)and
(@CityId  			is null or users.FkCity_Id=@CityId)and
(@AccountTypeId 	is null or users.FKAccountType_Id=@AccountTypeId)and
(@LanguageId 		is null or users.FKLanguage_Id=@LanguageId) 




order by Id Desc
Offset @Skip rows
fetch next @Take rows only
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByPk]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectByUserNameAndPassword]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_SelectByUserNameAndPassword]
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
/****** Object:  StoredProcedure [dbo].[Users_UpateActiveCodeAndEmail]    Script Date: 7/18/2019 11:54:45 AM ******/
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

--تحديث الاميل فى اول مرة فقط يقوم بتعديل بها الاميل لان نفس الدالة تستخدم فى تحديث البروفيل ايضا
Update Users 
set Email=@Email
where Id=@UserId and Email is null
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
		   @IsActive bit
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
		   IsActive=@IsActive

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
		   IsActive=@IsActive

   where Id=@Id and @Password is  null
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateLangage]    Script Date: 7/18/2019 11:54:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Users_UpdateLangage]
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
/****** Object:  StoredProcedure [dbo].[UsersPrivileges_SelectByMenuId]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Words_Delete]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Words_Insert]    Script Date: 7/18/2019 11:54:45 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Words_Update]    Script Date: 7/18/2019 11:54:45 AM ******/
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
