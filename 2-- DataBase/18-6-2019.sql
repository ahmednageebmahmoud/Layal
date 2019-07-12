USE [master]
GO
/****** Object:  Database [Layan]    Script Date: 6/18/2019 12:50:00 AM ******/
CREATE DATABASE [Layan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Layan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Layan.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Layan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.AHMED\MSSQL\DATA\Layan_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Layan] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Layan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Layan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Layan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Layan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Layan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Layan] SET ARITHABORT OFF 
GO
ALTER DATABASE [Layan] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Layan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Layan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Layan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Layan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Layan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Layan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Layan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Layan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Layan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Layan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Layan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Layan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Layan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Layan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Layan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Layan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Layan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Layan] SET  MULTI_USER 
GO
ALTER DATABASE [Layan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Layan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Layan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Layan] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Layan] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Layan] SET QUERY_STORE = OFF
GO
USE [Layan]
GO
/****** Object:  Table [dbo].[Words]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  View [dbo].[AccountTypes_Select]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  View [dbo].[CountriesView]    Script Date: 6/18/2019 12:50:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CountriesView]
as 
select Countries.*,Words.Ar,
Words.En from  Countries join Words on Words.Id=Countries.Id
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  View [dbo].[CitiesView]    Script Date: 6/18/2019 12:50:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CitiesView]
as 
select Cities.*,Words.Ar,
Words.En from  Cities join Words on Words.Id=Cities.Id
GO
/****** Object:  Table [dbo].[EnquiryFormNotes]    Script Date: 6/18/2019 12:50:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryFormNotes](
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
/****** Object:  Table [dbo].[EnquiryForms]    Script Date: 6/18/2019 12:50:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnquiryForms](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[EventDate] [date] NOT NULL,
	[FkCountry_Id] [int] NOT NULL,
	[FkCity_Id] [int] NOT NULL,
	[FKEnquiryType_Id] [int] NOT NULL,
	[FKUserCreated_Id] [bigint] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_EnquiryForms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EnquiryTypes]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[Languages]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[Menus]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[Pages]    Script Date: 6/18/2019 12:50:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[Url] [nvarchar](50) NOT NULL,
	[FkMenu_Id] [int] NOT NULL,
	[OrderByNumber] [int] NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPrivileges]    Script Date: 6/18/2019 12:50:00 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 6/18/2019 12:50:00 AM ******/
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
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AccountTypes] ON 

INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (1, 1)
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (2, 4)
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (3, 5)
INSERT [dbo].[AccountTypes] ([Id], [FkWord_Id]) VALUES (4, 6)
SET IDENTITY_INSERT [dbo].[AccountTypes] OFF
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([Id], [FKWord_Id], [FKCountry_Id]) VALUES (1, 10, 1)
INSERT [dbo].[Cities] ([Id], [FKWord_Id], [FKCountry_Id]) VALUES (2, 11, 2)
SET IDENTITY_INSERT [dbo].[Cities] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (1, 8, N'02')
INSERT [dbo].[Countries] ([Id], [FKWord_Id], [IsoCode]) VALUES (2, 9, N'259')
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[Languages] ON 

INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (1, N'en', N'English')
INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (2, N'ar', N'Arabic')
SET IDENTITY_INSERT [dbo].[Languages] OFF
SET IDENTITY_INSERT [dbo].[Menus] ON 

INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (1, N'fas fa-cogs', 1, NULL, 2)
INSERT [dbo].[Menus] ([Id], [CssClass], [OrderByNumber], [Parent_Id], [FKWord_Id]) VALUES (2, N'fas fa-users-cog', 2, NULL, 7)
SET IDENTITY_INSERT [dbo].[Menus] OFF
SET IDENTITY_INSERT [dbo].[Pages] ON 

INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber]) VALUES (2, 3, N'/UsersPrivileges', 1, 1)
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber]) VALUES (3, 12, N'/Users', 2, 1)
INSERT [dbo].[Pages] ([Id], [FKWord_Id], [Url], [FkMenu_Id], [OrderByNumber]) VALUES (4, 13, N'/Countries', 1, 2)
SET IDENTITY_INSERT [dbo].[Pages] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [UserName], [Email], [PhoneNo], [Address], [Password], [ActiveCode], [FKAccountType_Id], [FkCountry_Id], [FkCity_Id], [FKLanguage_Id], [CreateDateTime]) VALUES (5, N'ahmed', N'a0hed@gmail.com', N'01025249400', N'dfdfdfdfdffdfdfdfssssd', N'123456', NULL, 1, 1, 1, 1, CAST(N'2020-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[Words] ON 

INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (1, N'مدير المشروع', N'Project Manager ')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (2, N'الاعدادت', N'Setting')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (3, N'صلاحيات الستخدم', N'Users Privileges')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (4, N'مشرف', N'Supervisor')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (5, N'مدير فرع', N'Branch Manager')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (6, N'عميل', N'Clinet')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (7, N'المستخدمين', N'Users')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (8, N'مصر', N'Egypt')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (9, N'الكويت', N'kuwait')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (10, N'القاهرة', N'cairo')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (11, N'الاسكندرية', N'Alx')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (12, N'المستخدمين', N'Users')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (13, N'الدول', N'Countries')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (15, N'New2019', N'New2019')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (16, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (17, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (18, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (19, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (20, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (21, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (22, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (23, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (24, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (25, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (26, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (27, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (28, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (29, N'q', N'e')
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (30, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (31, NULL, NULL)
INSERT [dbo].[Words] ([Id], [Ar], [En]) VALUES (32, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Words] OFF
ALTER TABLE [dbo].[AccountTypes]  WITH CHECK ADD  CONSTRAINT [FK_AccountTypes_Words] FOREIGN KEY([FkWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AccountTypes] CHECK CONSTRAINT [FK_AccountTypes_Words]
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
ALTER TABLE [dbo].[EnquiryFormNotes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryFormNotes_EnquiryForms] FOREIGN KEY([FKEnquiryForm_Id])
REFERENCES [dbo].[EnquiryForms] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryFormNotes] CHECK CONSTRAINT [FK_EnquiryFormNotes_EnquiryForms]
GO
ALTER TABLE [dbo].[EnquiryFormNotes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryFormNotes_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EnquiryFormNotes] CHECK CONSTRAINT [FK_EnquiryFormNotes_Users]
GO
ALTER TABLE [dbo].[EnquiryForms]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Cities] FOREIGN KEY([FkCity_Id])
REFERENCES [dbo].[Cities] ([Id])
GO
ALTER TABLE [dbo].[EnquiryForms] CHECK CONSTRAINT [FK_EnquiryForms_Cities]
GO
ALTER TABLE [dbo].[EnquiryForms]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Countries] FOREIGN KEY([FkCountry_Id])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[EnquiryForms] CHECK CONSTRAINT [FK_EnquiryForms_Countries]
GO
ALTER TABLE [dbo].[EnquiryForms]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_EnquiryTypes] FOREIGN KEY([FKEnquiryType_Id])
REFERENCES [dbo].[EnquiryTypes] ([Id])
GO
ALTER TABLE [dbo].[EnquiryForms] CHECK CONSTRAINT [FK_EnquiryForms_EnquiryTypes]
GO
ALTER TABLE [dbo].[EnquiryForms]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryForms_Users] FOREIGN KEY([FKUserCreated_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[EnquiryForms] CHECK CONSTRAINT [FK_EnquiryForms_Users]
GO
ALTER TABLE [dbo].[EnquiryTypes]  WITH CHECK ADD  CONSTRAINT [FK_EnquiryTypes_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EnquiryTypes] CHECK CONSTRAINT [FK_EnquiryTypes_Words]
GO
ALTER TABLE [dbo].[Menus]  WITH CHECK ADD  CONSTRAINT [FK_Menus_Words] FOREIGN KEY([FKWord_Id])
REFERENCES [dbo].[Words] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Menus] CHECK CONSTRAINT [FK_Menus_Words]
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
/****** Object:  StoredProcedure [dbo].[Cities_CheckIfUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_Delete]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Cities_Delete]
@Id bigint
as begin

delete  Cities where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Cities_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_SelectAll]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_SelectByFilter]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Cities_Update]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_CheckIfUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Countries_CheckIfUsed] 
@Id bigint
as begin

select 
count(*)from Users where FkCountry_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Countries_Delete]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Countries_Delete]
@Id bigint
as begin
delete Cities where FKCountry_Id=@Id
delete  Countries where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[Countries_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_IsoCodeBeforUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectAll]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectByFilter]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_SelectWithCitiesByPk]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Countries_Update]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_CheckIfUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnquiryTypes_CheckIfUsed] 
@Id bigint
as begin

select 
count(*)from EnquiryForms where FKEnquiryType_Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Delete]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EnquiryTypes_Delete]
@Id bigint
as begin

delete  EnquiryTypes where Id=@Id
 
end
GO
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_SelectByFilter]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[EnquiryTypes_Update]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[EnquiryTypes_Update]
@Id int  , 
@NameAr nvarchar(50),
@NameEn nvarchar(50),
@WordId int

as begin
-- Update Word 
exec dbo.Words_Update @WordId, @NameAr,@NameEn

-- Update Target
 

end


GO
/****** Object:  StoredProcedure [dbo].[Menus_SelectAll]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllByUser_Id]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Menus_SelectAllForUserCanBeAccess]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Menus_SelectAllForUserCanBeAccess]	 
 
@UserId bigint

as begin
if(@UserId is null or @UserId =0)
 select Menus.*,
		Words.Ar as MenuNameAr,
		Words.En as		MenuNameEn from Menus 
 join Words on Words.Id=Menus.FKWord_Id

		order by Menus.OrderByNumber 

 else
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
 order by Menus.OrderByNumber 
 end
GO
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllByUser_Id]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Pages_SelectAllForUserCanBeAccess]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[Pages_SelectAllForUserCanBeAccess]
   @UserId bigint
as begin 

 if(@UserId is null or @userId=0)
select 
	Pages.*,
	PageWord.Ar as PageNameAr,
	PageWord.En as PageNameEn
	
from Pages 
 join Words as PageWord on PageWord.Id=Pages.FKWord_Id
order by Id desc

else 
select 
	Pages.*,
	PageWord.Ar as PageNameAr,
	PageWord.En as PageNameEn
	
from Pages 

 join Words as PageWord on PageWord.Id=Pages.FKWord_Id
 join UserPrivileges on UserPrivileges.FkUser_Id=@UserId 
 and UserPrivileges.FkPage_Id=Pages.Id

order by Id desc
 end
GO
/****** Object:  StoredProcedure [dbo].[User_EmailBeforUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[User_PhoneNumberBeforUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[User_UserNameBeforUsed]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UserPrivileges_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UserPrivileges_RemoveByMenuIdAndUserId]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UserPrivileges_SelectByUserId]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
		   @LanguageId int
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
		   FKLanguage_Id)
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
		   @LanguageId)
select @Id= @@IDENTITY


end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectAllEmployees]    Script Date: 6/18/2019 12:50:01 AM ******/
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
	Users.FKAccountType_Id =2 or 
	Users.FKAccountType_Id =3

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByFilter]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectByPk]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectByUserNameAndPassword]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_Update]    Script Date: 6/18/2019 12:50:01 AM ******/
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
		   @LanguageId int
as begin
update [dbo].[Users] set
           [UserName]			= @UserName,		
           [Email]				=@Email ,
           [PhoneNo]			=@PhoneNo ,
           [Address]			=@Address ,
           [FkCountry_Id]		=@FkCountry_Id ,
           [FkCity_Id]			=@FkCity_Id ,
           [Password]			=@Password ,
		   FKLanguage_Id		=@LanguageId 
   where Id=@Id and @Password is not null

   update [dbo].[Users] set
           [UserName]			= @UserName,		
           [Email]				=@Email ,
           [PhoneNo]			=@PhoneNo ,
           [Address]			=@Address ,
           [FkCountry_Id]		=@FkCountry_Id ,
           [FkCity_Id]			=@FkCity_Id ,
		   FKLanguage_Id		=@LanguageId 
   where Id=@Id and @Password is  null
end 
GO
/****** Object:  StoredProcedure [dbo].[Users_UpdateLangage]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[UsersPrivileges_SelectByMenuId]    Script Date: 6/18/2019 12:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UsersPrivileges_SelectByMenuId]
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

where Pages.FkMenu_Id=@menuId

end 
GO
/****** Object:  StoredProcedure [dbo].[Words_Insert]    Script Date: 6/18/2019 12:50:01 AM ******/
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
/****** Object:  StoredProcedure [dbo].[Words_Update]    Script Date: 6/18/2019 12:50:01 AM ******/
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
ALTER DATABASE [Layan] SET  READ_WRITE 
GO
