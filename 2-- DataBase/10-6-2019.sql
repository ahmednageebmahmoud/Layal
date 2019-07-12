USE [master]
GO
/****** Object:  Database [Layan]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[AccountTypes]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[Cities]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[EnquiryFormNotes]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[EnquiryForms]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[EnquiryTypes]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[Languages]    Script Date: 6/10/2019 11:44:46 PM ******/
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
/****** Object:  Table [dbo].[Pages]    Script Date: 6/10/2019 11:44:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKWord_Id] [bigint] NOT NULL,
	[Url] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPrivileges]    Script Date: 6/10/2019 11:44:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPrivileges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FKPage_Id] [int] NOT NULL,
	[FkUser_Id] [bigint] NOT NULL,
 CONSTRAINT [PK_UserPrivileges] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/10/2019 11:44:46 PM ******/
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
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Words]    Script Date: 6/10/2019 11:44:46 PM ******/
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
SET IDENTITY_INSERT [dbo].[Languages] ON 
GO
INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (1, N'en', N'English')
GO
INSERT [dbo].[Languages] ([Id], [Code], [Name]) VALUES (2, N'ar', N'Arabic')
GO
SET IDENTITY_INSERT [dbo].[Languages] OFF
GO
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
/****** Object:  StoredProcedure [dbo].[Users_Insert]    Script Date: 6/10/2019 11:44:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Users_Insert]
			@UserName nvarchar(50),
           @Email nvarchar(50),
           @PhoneNo nvarchar(50),
           @FKAccountType_Id int,
           @Address nvarchar(250),
           @FkCountry_Id int,
           @FkCity_Id int,
           @Password nvarchar(50),
           @ActiveCode nvarchar(50)
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
           ,[ActiveCode])
     VALUES
           (@UserName,
           @Email, 
           @PhoneNo,
           @FKAccountType_Id, 
           @Address, 
           @FkCountry_Id,
           @FkCity_Id,
           @Password, 
           @ActiveCode)

end 
GO
/****** Object:  StoredProcedure [dbo].[Users_SelectByPk]    Script Date: 6/10/2019 11:44:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Users_SelectByUserNameAndPassword]    Script Date: 6/10/2019 11:44:47 PM ******/
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
USE [master]
GO
ALTER DATABASE [Layan] SET  READ_WRITE 
GO
