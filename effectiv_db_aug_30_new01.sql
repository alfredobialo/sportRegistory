USE [master]
GO
/****** Object:  Database [effectiv_db]    Script Date: 8/30/2016 11:15:16 PM ******/
CREATE DATABASE [effectiv_db] ON  PRIMARY 
( NAME = N'effectiv_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\effectiv_db.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'effectiv_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\effectiv_db_log.ldf' , SIZE = 3072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [effectiv_db] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [effectiv_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [effectiv_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [effectiv_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [effectiv_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [effectiv_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [effectiv_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [effectiv_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [effectiv_db] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [effectiv_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [effectiv_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [effectiv_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [effectiv_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [effectiv_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [effectiv_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [effectiv_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [effectiv_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [effectiv_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [effectiv_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [effectiv_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [effectiv_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [effectiv_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [effectiv_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [effectiv_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [effectiv_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [effectiv_db] SET RECOVERY FULL 
GO
ALTER DATABASE [effectiv_db] SET  MULTI_USER 
GO
ALTER DATABASE [effectiv_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [effectiv_db] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'effectiv_db', N'ON'
GO
USE [effectiv_db]
GO
/****** Object:  Table [dbo].[acc_account_period]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_account_period](
	[id] [varchar](50) NOT NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[isActive] [bit] NULL,
	[isClose] [bit] NULL,
	[description] [nvarchar](300) NULL,
	[org_code] [varchar](50) NULL,
 CONSTRAINT [PK_acc_account_period] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_charts_of_account]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_charts_of_account](
	[id] [varchar](50) NOT NULL,
	[name] [varchar](70) NULL,
	[description] [nvarchar](250) NULL,
	[isActive] [bit] NULL,
	[account_type] [varchar](50) NULL,
	[is_sysdefined] [bit] NULL,
	[is_operating_account] [bit] NULL,
	[is_real_account] [bit] NULL,
	[is_child] [bit] NULL,
	[is_bank_account] [bit] NULL,
	[bank_logoUrl] [varchar](450) NULL,
	[parent_account_id] [varchar](50) NULL,
	[obj_ref_id] [varchar](50) NULL,
	[sort_order] [int] NULL,
	[obj_ref_type] [varchar](50) NULL,
	[channel_id] [varchar](50) NULL,
	[date_created] [datetime] NULL,
	[created_by] [varchar](50) NULL,
	[date_last_updated] [datetime] NULL,
	[updated_by] [varchar](50) NULL,
	[is_single_account] [bit] NULL,
 CONSTRAINT [PK_acc_charts_of_account] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_general_journal]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_general_journal](
	[id] [varchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[date] [datetime] NULL,
	[account_period_id] [varchar](50) NULL,
 CONSTRAINT [PK_acc_general_journal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_general_ledger]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_general_ledger](
	[id] [varchar](50) NOT NULL,
	[account_id] [varchar](50) NULL,
	[account_name] [varchar](70) NULL,
	[account_period_id] [varchar](50) NULL,
 CONSTRAINT [PK_acc_general_ledger] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_journal_entry]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_journal_entry](
	[general_journal_id] [varchar](50) NULL,
	[id] [int] IDENTITY(1000,1) NOT NULL,
	[description] [nvarchar](250) NULL,
	[date] [datetime] NULL,
	[is_beginning_bal] [bit] NULL,
 CONSTRAINT [PK_acc_journal_entry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_journal_entry_account]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_journal_entry_account](
	[id] [varchar](50) NOT NULL,
	[journal_entry_id] [int] NULL,
	[obj_code_is_account] [bit] NULL,
	[debit_account_id] [varchar](50) NULL,
	[debit_account_name] [varchar](70) NULL,
	[debit_amount] [decimal](18, 2) NULL,
	[credit_account_id] [varchar](50) NULL,
	[credit_account_name] [varchar](70) NULL,
	[credit_amount] [decimal](18, 2) NULL,
	[obj_code] [varchar](50) NULL,
	[obj_type] [varchar](50) NULL,
 CONSTRAINT [PK_acc_journal_entry_account] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[acc_ledger_entry]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[acc_ledger_entry](
	[id] [varchar](50) NOT NULL,
	[ledger_account_id] [varchar](50) NULL,
	[date] [datetime] NULL,
	[debit_account_id] [varchar](50) NULL,
	[debit_amount] [decimal](18, 2) NULL,
	[credit_account_id] [varchar](50) NULL,
	[credit_amount] [decimal](18, 2) NULL,
	[journal_ref_id] [int] NULL,
 CONSTRAINT [PK_acc_ledger_entry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[account_channel_group]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[account_channel_group](
	[id] [varchar](50) NOT NULL,
	[org_channel_id] [varchar](50) NULL,
	[isActive] [bit] NULL,
	[account_period_id] [varchar](50) NULL,
 CONSTRAINT [PK_account_channel_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[app_messaging]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[app_messaging](
	[id] [varchar](50) NOT NULL,
	[description] [nvarchar](max) NULL,
	[date_created] [datetime] NULL,
	[isActive] [bit] NULL,
	[message_group] [varchar](50) NULL,
	[message_group_tag] [varchar](50) NULL,
	[obj_id] [varchar](50) NULL,
	[posted_at_channel] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
	[is_directed_to_user] [bit] NULL,
	[allow_comments] [bit] NULL,
	[is_directed_to_everyone] [bit] NULL,
	[directed_to_everyone_in_channel] [varchar](50) NULL,
	[device_ip] [varchar](50) NULL,
	[device_type] [varchar](50) NULL,
 CONSTRAINT [PK_app_messaging] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[app_messaging_comment]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[app_messaging_comment](
	[id] [varchar](50) NOT NULL,
	[message_id] [varchar](50) NULL,
	[comment] [nvarchar](2000) NULL,
	[is_active] [bit] NULL,
	[image_url] [varchar](550) NULL,
	[date_posted] [datetime] NULL,
	[comment_by] [varchar](50) NULL,
	[is_child] [bit] NULL,
	[parent_id] [varchar](50) NULL,
 CONSTRAINT [PK_app_messaging_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[app_messaging_recipient_list]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[app_messaging_recipient_list](
	[id] [varchar](50) NOT NULL,
	[obj_id] [varchar](50) NULL,
	[user_id] [varchar](50) NULL,
	[obj_type] [varchar](50) NULL,
	[message_id] [varchar](50) NULL,
 CONSTRAINT [PK_app_messaging_recipient_list] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[app_notification]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[app_notification](
	[id] [varchar](50) NOT NULL,
	[image_url] [varchar](550) NULL,
	[description] [nvarchar](350) NULL,
	[is_done] [bit] NULL,
	[is_persisted] [bit] NULL,
	[date_created] [datetime] NULL,
	[context_type] [varchar](50) NULL,
	[context_type_id] [varchar](50) NULL,
	[context_url] [varchar](1500) NULL,
 CONSTRAINT [PK_app_notification] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crm_customer]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[crm_customer](
	[id] [varchar](50) NOT NULL,
	[company_name] [nvarchar](250) NULL,
	[company_logo_url] [varchar](350) NULL,
	[company_signature_url] [varchar](350) NULL,
	[company_address] [nvarchar](450) NULL,
	[location] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[phone_number] [varchar](150) NULL,
	[website_address] [varchar](450) NULL,
	[email_address] [varchar](50) NULL,
	[customer_type] [varchar](50) NULL,
	[is_supplier] [bit] NULL,
	[is_company] [bit] NULL,
	[has_account] [bit] NULL,
	[credit_limit] [decimal](18, 0) NULL,
	[is_credit_worthy] [bit] NULL,
	[isActive] [bit] NULL,
	[dateCreated] [datetime] NULL,
	[dateUpdate] [datetime] NULL,
	[memo] [nvarchar](2000) NULL,
	[allow_online_login] [bit] NULL,
	[login_id] [varchar](50) NULL,
	[created_at_channel_id] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_crm_customer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crm_customer_contact]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[crm_customer_contact](
	[id] [varchar](50) NOT NULL,
	[first_name] [nvarchar](50) NULL,
	[last_name] [nvarchar](50) NULL,
	[picture_url] [varchar](350) NULL,
	[isActive] [bit] NULL,
	[phone_number] [varchar](150) NULL,
	[customer_id] [varchar](50) NULL,
	[job_title] [varchar](50) NULL,
 CONSTRAINT [PK_crm_customer_contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[crm_customer_document]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[crm_customer_document](
	[id] [varchar](50) NOT NULL,
	[customer_id] [varchar](50) NULL,
	[doc_title] [nvarchar](150) NULL,
	[doc_description] [nvarchar](2050) NULL,
	[date_created] [datetime] NULL,
	[trans_type] [varchar](50) NULL,
	[trans_code] [varchar](50) NULL,
	[isActive] [bit] NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_crm_customer_document] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[currency_conversion]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[currency_conversion](
	[currency] [varchar](50) NOT NULL,
	[default_currency] [varchar](50) NULL,
	[default_currency_value] [decimal](18, 2) NULL,
	[isActive] [bit] NULL,
	[dateCreated] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
 CONSTRAINT [PK_currency_conversion] PRIMARY KEY CLUSTERED 
(
	[currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[currency_policy]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[currency_policy](
	[currency] [varchar](50) NOT NULL,
	[symbol] [nvarchar](5) NULL,
	[abbrv] [nvarchar](6) NULL,
	[country] [nvarchar](80) NULL,
 CONSTRAINT [PK_currency_policy] PRIMARY KEY CLUSTERED 
(
	[currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_contacts]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_contacts](
	[id] [varchar](50) NOT NULL,
	[empId] [varchar](50) NULL,
	[contactName] [nvarchar](150) NULL,
	[address] [nvarchar](550) NULL,
	[phone] [nvarchar](150) NULL,
	[email] [nvarchar](250) NULL,
	[fax] [nvarchar](150) NULL,
 CONSTRAINT [PK_hr_employee_contacts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_document]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_document](
	[empId] [varchar](50) NULL,
	[id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_document_details]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_document_details](
	[id] [varchar](50) NULL,
	[empId] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_medicals]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_medicals](
	[id] [nchar](10) NULL,
	[empId] [varchar](50) NULL,
	[id1] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_medicals_details]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_medicals_details](
	[empId] [varchar](50) NULL,
	[id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_employee_profile]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_employee_profile](
	[id] [varchar](50) NOT NULL,
	[firstName] [nvarchar](50) NOT NULL,
	[lastName] [nvarchar](50) NOT NULL,
	[middleName] [nvarchar](50) NULL,
	[titleOfCoursey] [varchar](10) NULL,
	[gender] [varchar](10) NULL,
	[dateOfBirth] [datetime] NULL,
	[maritalStatus] [varchar](20) NULL,
	[passportUrl] [varchar](450) NULL,
	[leftSidePicUrl] [varchar](450) NULL,
	[rightSidePicUrl] [varchar](450) NULL,
	[loginAccId] [varchar](50) NULL,
	[stateOfOrigin] [varchar](50) NULL,
	[nationality] [varchar](50) NULL,
	[lga] [varchar](100) NULL,
	[homeTown] [varchar](100) NULL,
	[createdBy] [varchar](50) NULL,
	[org_id] [varchar](50) NULL,
	[createdAt_channelId] [varchar](50) NULL,
	[deployedAt_channelId] [varchar](50) NULL,
	[isActive] [bit] NULL,
	[dateCreated] [datetime] NULL,
	[note] [nvarchar](2050) NULL,
	[lastUpdated] [datetime] NULL,
	[lastUpdatedBy] [varchar](50) NULL,
	[lastUpdateNote] [nvarchar](450) NULL,
 CONSTRAINT [PK_hr_employee_profile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_recruitement_setup]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_recruitement_setup](
	[empId] [varchar](50) NULL,
	[id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_recruitement_setup_details]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_recruitement_setup_details](
	[id] [varchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[description] [nvarchar](max) NULL,
	[dateCreated] [datetime] NULL,
	[datePublished] [datetime] NULL,
	[publishedBy] [varchar](50) NULL,
	[createdBy] [varchar](50) NULL,
	[isActive] [bit] NULL,
	[expiresOn] [datetime] NULL,
	[isExpirable] [bit] NULL,
	[availableSlots] [int] NULL,
 CONSTRAINT [PK_hr_recruitement_setup_details] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_recruitment_personnel_accepted]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_recruitment_personnel_accepted](
	[empId] [varchar](50) NULL,
	[id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hr_recruitment_personnel_enrollment]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hr_recruitment_personnel_enrollment](
	[empId] [varchar](50) NULL,
	[id] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[identity_store]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[identity_store](
	[user_id] [varchar](50) NOT NULL,
	[password] [varchar](50) NULL,
	[org_id] [varchar](50) NULL,
	[channel_id] [varchar](50) NULL,
	[is_active] [bit] NULL,
	[is_blocked] [bit] NULL,
	[activation_code] [varchar](50) NULL,
	[date_created] [datetime] NULL,
	[security_question] [varchar](70) NULL,
	[security_answer] [varchar](50) NULL,
	[phone_number] [varchar](50) NULL,
	[email_address] [varchar](70) NULL,
	[display_name] [nvarchar](70) NULL,
	[picture_url] [varchar](350) NULL,
	[obj_type] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
	[gender] [varchar](10) NULL,
	[date_of_birth] [datetime] NULL,
 CONSTRAINT [PK_identity_store] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[identity_store_preference]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[identity_store_preference](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[pref_key] [varchar](50) NULL,
	[pref_value] [varchar](max) NULL,
	[data_type] [varchar](50) NULL,
 CONSTRAINT [PK_identity_store_preference] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_category]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_category](
	[id] [varchar](50) NOT NULL,
	[org_id] [varchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[is_child] [bit] NULL,
	[parent_id] [varchar](50) NULL,
 CONSTRAINT [PK_item_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_group_attribute_list]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_group_attribute_list](
	[id] [varchar](50) NOT NULL,
	[group_id] [varchar](50) NULL,
	[attr_key] [varchar](50) NULL,
	[attr_value] [nvarchar](250) NULL,
	[tag] [varchar](50) NULL,
 CONSTRAINT [PK_item_group_attribute_list] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_log]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_log](
	[id] [varchar](50) NOT NULL,
	[title] [nvarchar](150) NULL,
	[description] [nvarchar](250) NULL,
	[created_by] [varchar](50) NULL,
	[date_created] [datetime] NULL,
	[is_closed] [bit] NULL,
 CONSTRAINT [PK_item_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_log_detail]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_log_detail](
	[id] [varchar](50) NOT NULL,
	[item_log_id] [varchar](50) NOT NULL,
	[item_id] [varchar](50) NOT NULL,
	[description] [nvarchar](450) NULL,
	[value] [decimal](18, 2) NULL,
	[dateCreated] [datetime] NULL,
	[um] [varchar](10) NULL,
 CONSTRAINT [PK_item_log_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_storage_type]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_storage_type](
	[id] [varchar](50) NOT NULL,
	[unit] [varchar](50) NOT NULL,
	[description] [varchar](50) NULL,
	[org_id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_item_storage_type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[item_unitStock_log]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[item_unitStock_log](
	[id] [varchar](50) NOT NULL,
	[item_id] [varchar](50) NULL,
	[item_unit_measure_id] [varchar](50) NULL,
	[unit] [decimal](14, 1) NULL,
	[trans_id] [varchar](50) NULL,
	[trans_type] [varchar](50) NULL,
	[note] [nvarchar](50) NULL,
	[dateCreated] [datetime] NULL,
	[createdBy] [varchar](50) NULL,
	[prevQty] [decimal](15, 1) NULL,
	[unit_on_order] [int] NULL,
	[item_cost] [decimal](18, 2) NULL,
	[unit_on_reserved] [decimal](18, 2) NULL,
 CONSTRAINT [PK_item_unitStock_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[itrex_auth_objectAccessAudit]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[itrex_auth_objectAccessAudit](
	[id] [nvarchar](50) NOT NULL,
	[roleUsed] [nvarchar](50) NULL,
	[PermissionsUsed] [varchar](450) NULL,
	[UserContext] [nvarchar](50) NULL,
	[dateAccessed] [datetime] NULL,
	[ActionDescription] [varchar](350) NULL,
 CONSTRAINT [PK_itrex_auth_objectAccessAudit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[itrex_auth_roleDefinition]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[itrex_auth_roleDefinition](
	[roleName] [nvarchar](50) NOT NULL,
	[roleDescription] [nvarchar](350) NULL,
	[isActive] [bit] NULL,
	[IsExpirable] [bit] NULL,
	[DateCreated] [datetime] NULL,
	[ExipiresOn] [datetime] NULL,
	[IsSystemDefined] [bit] NULL,
	[isAdmin] [bit] NULL,
	[GroupName] [varchar](50) NULL,
 CONSTRAINT [PK_itrex_auth_roleDefinition] PRIMARY KEY CLUSTERED 
(
	[roleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[itrex_auth_rolePermission]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itrex_auth_rolePermission](
	[id] [nvarchar](50) NOT NULL,
	[roleName] [nvarchar](50) NULL,
	[permissionName] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
	[IsExpirable] [bit] NULL,
	[DateCreated] [datetime] NULL,
	[ExpiresOn] [datetime] NULL,
	[description] [nvarchar](550) NULL,
 CONSTRAINT [PK_itrex_auth_rolePermission] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[itrex_auth_usersInRole]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itrex_auth_usersInRole](
	[id] [nvarchar](50) NOT NULL,
	[userId] [nvarchar](50) NULL,
	[roleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_itrex_auth_userRole] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[org_business_channels]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_business_channels](
	[id] [varchar](50) NOT NULL,
	[location] [nvarchar](50) NULL,
	[address] [nvarchar](350) NULL,
	[city] [nvarchar](30) NULL,
	[phoneNo] [varchar](100) NULL,
	[isActive] [bit] NULL,
	[isHeadOffice] [bit] NULL,
	[tag] [varchar](50) NULL,
	[org_id] [varchar](50) NULL,
	[extra_data1] [varchar](350) NULL,
	[extra_data2] [varchar](350) NULL,
	[extra_data3] [varchar](350) NULL,
	[extra_data4] [varchar](350) NULL,
 CONSTRAINT [PK_org_business_channels] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_company_profile]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_company_profile](
	[id] [varchar](50) NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[slogan] [nvarchar](250) NULL,
	[logoUrl] [varchar](550) NULL,
	[signatureUrl] [varchar](550) NULL,
	[secondaryLogoUrl] [varchar](550) NULL,
	[logoBlob] [varbinary](max) NULL,
	[signatureBlob] [varbinary](max) NULL,
	[dateCreated] [datetime] NULL,
	[note] [nvarchar](350) NULL,
	[email] [varchar](50) NULL,
	[website] [varchar](100) NULL,
 CONSTRAINT [PK_org_company_profile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_global_settings]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_global_settings](
	[id] [varchar](50) NOT NULL,
	[org_id] [varchar](50) NULL,
	[block_failed_user_login_attempt] [bit] NULL,
	[allowed_login_attempt] [tinyint] NULL,
	[application_theme] [varchar](150) NULL,
	[currency_symbol] [nvarchar](4) NULL,
	[currency_name] [nvarchar](20) NULL,
	[currency_name_abbrv] [nvarchar](5) NULL,
	[isActive] [bit] NULL,
	[viewMode] [tinyint] NULL,
	[showItemImageInCart] [bit] NULL,
	[notifyIfItemIsOutOfStock] [bit] NULL,
	[showCompanyLogoInReport] [bit] NULL,
	[showSecondaryLogoInReport] [bit] NULL,
	[invoiceTemplateType] [varchar](50) NULL,
	[invoiceTitle] [nvarchar](150) NULL,
	[invoiceFooter] [nvarchar](250) NULL,
	[showInvoiceFooter] [bit] NULL,
	[showInvoiceTitle] [bit] NULL,
	[fontColorCode] [varchar](10) NULL,
	[bgColorCode] [varchar](10) NULL,
	[fontColorCodeFaded] [varchar](10) NULL,
	[bgColorCodeFaded] [varchar](10) NULL,
 CONSTRAINT [PK_org_global_settings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_item_attribute_group]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_item_attribute_group](
	[id] [varchar](50) NOT NULL,
	[item_id] [varchar](50) NULL,
	[group_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_org_item_attribute_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_item_definition_store]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_item_definition_store](
	[id] [varchar](50) NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[description] [nvarchar](max) NULL,
	[make] [varchar](50) NULL,
	[category] [varchar](50) NULL,
	[item_type] [varchar](50) NULL,
	[is_countable] [bit] NULL,
	[is_stockable] [bit] NULL,
	[is_forsale] [bit] NULL,
	[is_discountable] [bit] NULL,
	[is_taxable] [bit] NULL,
	[is_bought] [bit] NULL,
	[isActive] [bit] NULL,
	[tax_code] [varchar](50) NULL,
	[dateCreated] [datetime] NULL,
	[dateUpdate] [datetime] NULL,
	[org_id] [varchar](50) NULL,
	[picture_url] [varchar](350) NULL,
	[created_by] [varchar](50) NULL,
	[updated_by] [varchar](50) NULL,
	[updated_at_channel] [varchar](50) NULL,
	[create_at_channel] [varchar](50) NULL,
 CONSTRAINT [PK_org_item_definition_store] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_item_inventory_stock]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_item_inventory_stock](
	[id] [varchar](50) NOT NULL,
	[for_channel_id] [varchar](50) NULL,
	[item_id] [varchar](50) NULL,
	[item_tag] [nvarchar](150) NULL,
	[reorder_level] [decimal](14, 2) NULL,
	[unit_measure] [varchar](30) NULL,
	[unit_in_stock] [decimal](14, 2) NULL,
	[cost_price] [decimal](18, 2) NULL,
	[retail_price] [decimal](18, 2) NULL,
	[wholesale_price] [decimal](18, 2) NULL,
	[distributor_price] [decimal](18, 2) NULL,
	[note] [nvarchar](200) NULL,
	[created_by] [varchar](50) NULL,
	[barcode] [nvarchar](50) NULL,
	[barcodeType] [varchar](50) NULL,
	[expiresOn] [datetime] NULL,
	[alertOnExpiration] [bit] NULL,
 CONSTRAINT [PK_org_item_inventory_stock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_media_store]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_media_store](
	[id] [varchar](50) NOT NULL,
	[media_type] [varchar](50) NULL,
	[media_file_url] [varchar](1050) NULL,
	[media_tag] [varchar](150) NULL,
	[is_active] [bit] NULL,
	[media_owner_id] [varchar](50) NULL,
	[media_owner_group] [varchar](50) NULL,
	[date_created] [datetime] NULL,
 CONSTRAINT [PK_org_media_store] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_tax_policy]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_tax_policy](
	[id] [varchar](50) NOT NULL,
	[org_id] [varchar](50) NULL,
	[tax_code] [varchar](50) NOT NULL,
	[is_percentage] [bit] NOT NULL,
	[value] [decimal](10, 2) NOT NULL,
	[description] [varchar](350) NULL,
	[isActive] [bit] NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_org_tax_policy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_warehouse_doc_inventory_stock]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_warehouse_doc_inventory_stock](
	[id] [varchar](50) NOT NULL,
	[documentId] [varchar](50) NULL,
	[item_id] [varchar](50) NULL,
	[item_description] [nvarchar](350) NULL,
	[storage_type_id] [varchar](50) NULL,
	[storage_type_description] [nvarchar](200) NULL,
	[storage_location_in_warehouse] [varchar](350) NULL,
	[note] [nvarchar](350) NULL,
	[unitMeasure] [varchar](50) NULL,
	[qty] [decimal](14, 2) NULL,
	[cost_price] [decimal](18, 2) NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_org_warehouse_doc_inventory_stock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_warehouse_stock_doc]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_warehouse_stock_doc](
	[id] [varchar](50) NOT NULL,
	[warehouseId] [varchar](50) NULL,
	[dateCreated] [datetime] NULL,
	[description] [nvarchar](200) NULL,
	[note] [nvarchar](1200) NULL,
	[isCancelled] [bit] NULL,
	[isActive] [bit] NULL,
	[cancelled_reason] [varchar](250) NULL,
	[acc_tracking_code] [varchar](350) NULL,
	[extra_data1] [varchar](350) NULL,
	[extra_data2] [varchar](350) NULL,
	[extra_data3] [varchar](350) NULL,
	[extra_data4] [varchar](350) NULL,
	[stock_type] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_org_warehouse_stock_doc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[org_warehouses]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[org_warehouses](
	[id] [varchar](50) NOT NULL,
	[name] [varchar](100) NULL,
	[description] [nvarchar](350) NULL,
	[location] [varchar](150) NULL,
	[address] [nvarchar](250) NULL,
	[isActive] [bit] NULL,
	[org_id] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_org_warehouses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[po_purchase_item]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[po_purchase_item](
	[id] [varchar](50) NOT NULL,
	[po_id] [varchar](50) NULL,
	[item_id] [varchar](50) NOT NULL,
	[item_description] [nvarchar](200) NULL,
	[storageTypeId] [varchar](50) NULL,
	[storageType] [nvarchar](200) NULL,
	[unit_measure] [varchar](50) NOT NULL,
	[unit_price] [decimal](16, 2) NULL,
	[qty] [decimal](14, 2) NULL,
	[tax_rate] [decimal](18, 2) NULL,
	[shippingCharges] [decimal](18, 2) NOT NULL,
	[discountReceived] [decimal](18, 2) NULL,
	[initial_cost_price] [decimal](16, 2) NULL,
	[date_purchased] [datetime] NULL,
	[date_received] [datetime] NULL,
	[recieved_by] [varchar](50) NULL,
	[is_received] [bit] NULL,
	[note] [nvarchar](250) NULL,
 CONSTRAINT [PK_po_purchase_item] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[po_purchase_order]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[po_purchase_order](
	[id] [varchar](50) NOT NULL,
	[vendor_id] [varchar](50) NOT NULL,
	[description] [nvarchar](250) NULL,
	[date_created] [datetime] NULL,
	[delivery_date] [datetime] NULL,
	[status] [varchar](20) NULL,
	[created_by] [varchar](50) NULL,
	[note] [nvarchar](1050) NULL,
	[isProcessed] [bit] NULL,
	[acc_tracking_code] [varchar](50) NULL,
	[moved_to_objId] [varchar](50) NULL,
	[moved_to_objType] [varchar](50) NULL,
	[currency_code] [varchar](50) NULL,
	[vendor_address] [nvarchar](250) NULL,
	[vendor_name] [nvarchar](100) NULL,
	[vendor_phone] [varchar](50) NULL,
 CONSTRAINT [PK_po_purchase_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales_discount_policy]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales_discount_policy](
	[id] [varchar](50) NOT NULL,
	[org_id] [varchar](50) NULL,
	[discount_code] [varchar](50) NOT NULL,
	[is_percentage] [bit] NOT NULL,
	[value] [decimal](10, 2) NOT NULL,
	[min_item_qty] [int] NOT NULL,
	[item_min_amt] [decimal](18, 2) NULL,
	[description] [varchar](350) NULL,
	[isActive] [bit] NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_sales_discount_policy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales_order]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales_order](
	[id] [varchar](50) NOT NULL,
	[order_date] [datetime] NULL,
	[delivery_date] [datetime] NULL,
	[delivery_status] [varchar](50) NULL,
	[sale_person_id] [varchar](50) NOT NULL,
	[channel_id] [varchar](50) NOT NULL,
	[customer_id] [varchar](50) NULL,
	[is_cancelled] [bit] NULL,
	[shipping_name] [varchar](70) NULL,
	[shipping_address] [nvarchar](150) NULL,
	[shipping_method] [varchar](50) NULL,
	[shipping_location] [varchar](50) NULL,
	[shipping_charge] [decimal](18, 2) NULL,
	[shipping_phone_number] [varchar](50) NULL,
	[date_updated] [datetime] NULL,
	[trans_status_code] [varchar](50) NULL,
	[vat] [decimal](18, 2) NULL,
	[discount] [decimal](14, 2) NULL,
	[sales_total] [decimal](18, 2) NULL,
	[amt_received] [decimal](18, 2) NULL,
	[note] [nvarchar](250) NULL,
	[due_date] [datetime] NULL,
	[status] [varchar](50) NULL,
	[currency_code] [varchar](50) NULL,
	[is_invoiced] [bit] NULL,
	[customer_name] [nvarchar](180) NULL,
	[customer_address] [nvarchar](350) NULL,
	[customer_phone] [nvarchar](70) NULL,
	[items_dispatch_channel_id] [varchar](50) NULL,
	[dispatch_channelType] [varchar](50) NULL,
	[dispatch_code] [varchar](50) NULL,
 CONSTRAINT [PK_sales_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales_order_item]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales_order_item](
	[id] [varchar](50) NOT NULL,
	[attachedCode] [varchar](50) NULL,
	[sales_order_id] [varchar](50) NULL,
	[item_type] [varchar](50) NULL,
	[item_id] [varchar](50) NULL,
	[item_desc] [nvarchar](250) NULL,
	[storage_type_tag] [nvarchar](150) NULL,
	[storage_type_id] [varchar](50) NULL,
	[unit_measure] [varchar](20) NULL,
	[unit_price] [decimal](18, 2) NULL,
	[qty] [decimal](14, 2) NULL,
	[tax] [decimal](14, 2) NULL,
	[discount] [decimal](10, 2) NULL,
	[item_cost_price] [decimal](18, 2) NULL,
	[date_sold] [date] NULL,
	[unit_b4_sales] [decimal](14, 2) NULL,
	[note] [nvarchar](150) NULL,
	[discount_policy_label] [varchar](50) NULL,
	[discount_policy_id] [varchar](50) NULL,
	[tax_code] [varchar](50) NULL,
 CONSTRAINT [PK_sales_order_item] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales_payment_detail]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales_payment_detail](
	[id] [varchar](50) NOT NULL,
	[date_recieved] [datetime] NULL,
	[amt_received] [decimal](18, 2) NULL,
	[received_by] [varchar](50) NULL,
	[payment_method] [varchar](50) NULL,
	[paid_into_account] [varchar](50) NULL,
	[payment_info_id] [varchar](50) NOT NULL,
	[account_ref_code] [varchar](50) NULL,
	[remark] [nvarchar](150) NULL,
	[isApproved] [bit] NULL,
	[approved_by] [varchar](50) NULL,
	[approval_note] [nvarchar](300) NULL,
	[dateApproved] [datetime] NULL,
	[evidence_image_url] [varchar](650) NULL,
	[createdAtChannelId] [varchar](50) NULL,
 CONSTRAINT [PK_sales_payment_detail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales_payment_info]    Script Date: 8/30/2016 11:15:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales_payment_info](
	[id] [varchar](50) NOT NULL,
	[channel_id] [varchar](50) NULL,
	[description] [nvarchar](250) NULL,
	[trans_code] [varchar](50) NULL,
	[trans_type] [varchar](50) NULL,
	[trans_date] [datetime] NULL,
	[trans_total] [decimal](18, 2) NULL,
	[payment_status] [varchar](50) NULL,
	[created_by] [varchar](50) NULL,
 CONSTRAINT [PK_sales_payment_info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_item_definition_store]    Script Date: 8/30/2016 11:15:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_org_item_definition_store] ON [dbo].[org_item_definition_store]
(
	[name] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_media_store]    Script Date: 8/30/2016 11:15:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_org_media_store] ON [dbo].[org_media_store]
(
	[media_owner_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_warehouse_stock_doc]    Script Date: 8/30/2016 11:15:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_org_warehouse_stock_doc] ON [dbo].[org_warehouse_stock_doc]
(
	[warehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[acc_account_period] ADD  CONSTRAINT [DF_acc_account_period_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[acc_account_period] ADD  CONSTRAINT [DF_acc_account_period_isClose]  DEFAULT ((0)) FOR [isClose]
GO
ALTER TABLE [dbo].[acc_journal_entry] ADD  CONSTRAINT [DF_acc_journal_entry_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[acc_journal_entry] ADD  CONSTRAINT [DF_acc_journal_entry_is_beginning_bal]  DEFAULT ((0)) FOR [is_beginning_bal]
GO
ALTER TABLE [dbo].[acc_journal_entry_account] ADD  CONSTRAINT [DF_acc_journal_entry_account_obj_code_is_account]  DEFAULT ((0)) FOR [obj_code_is_account]
GO
ALTER TABLE [dbo].[app_messaging] ADD  CONSTRAINT [DF_app_messaging_date_created]  DEFAULT (getdate()) FOR [date_created]
GO
ALTER TABLE [dbo].[app_messaging] ADD  CONSTRAINT [DF_app_messaging_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[app_messaging] ADD  CONSTRAINT [DF_app_messaging_is_directed_to_user]  DEFAULT ((1)) FOR [is_directed_to_user]
GO
ALTER TABLE [dbo].[app_messaging] ADD  CONSTRAINT [DF_app_messaging_allow_comments]  DEFAULT ((1)) FOR [allow_comments]
GO
ALTER TABLE [dbo].[app_messaging] ADD  CONSTRAINT [DF_app_messaging_is_directed_to_everyone]  DEFAULT ((0)) FOR [is_directed_to_everyone]
GO
ALTER TABLE [dbo].[app_messaging_comment] ADD  CONSTRAINT [DF_app_messaging_comment_is_active]  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[app_messaging_comment] ADD  CONSTRAINT [DF_app_messaging_comment_is_child]  DEFAULT ((0)) FOR [is_child]
GO
ALTER TABLE [dbo].[crm_customer] ADD  CONSTRAINT [DF_crm_customer_is_supplier]  DEFAULT ((0)) FOR [is_supplier]
GO
ALTER TABLE [dbo].[crm_customer] ADD  CONSTRAINT [DF_crm_customer_is_company]  DEFAULT ((1)) FOR [is_company]
GO
ALTER TABLE [dbo].[crm_customer] ADD  CONSTRAINT [DF_crm_customer_is_credit_worthy]  DEFAULT ((0)) FOR [is_credit_worthy]
GO
ALTER TABLE [dbo].[crm_customer] ADD  CONSTRAINT [DF_crm_customer_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[crm_customer] ADD  CONSTRAINT [DF_crm_customer_dateCreated]  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[crm_customer_contact] ADD  CONSTRAINT [DF_crm_customer_contact_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[crm_customer_document] ADD  CONSTRAINT [DF_crm_customer_document_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[currency_conversion] ADD  CONSTRAINT [DF_currency_conversion_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[identity_store] ADD  CONSTRAINT [DF_identity_store_gender]  DEFAULT ('Male') FOR [gender]
GO
ALTER TABLE [dbo].[item_unitStock_log] ADD  DEFAULT ((0)) FOR [unit_on_order]
GO
ALTER TABLE [dbo].[itrex_auth_roleDefinition] ADD  CONSTRAINT [DF_itrex_auth_roleDefinition_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[itrex_auth_roleDefinition] ADD  CONSTRAINT [DF_itrex_auth_roleDefinition_IsExpirable]  DEFAULT ((0)) FOR [IsExpirable]
GO
ALTER TABLE [dbo].[itrex_auth_roleDefinition] ADD  CONSTRAINT [DF_itrex_auth_roleDefinition_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[itrex_auth_roleDefinition] ADD  CONSTRAINT [DF_itrex_auth_roleDefinition_IsSystemDefined]  DEFAULT ((1)) FOR [IsSystemDefined]
GO
ALTER TABLE [dbo].[itrex_auth_roleDefinition] ADD  CONSTRAINT [DF_itrex_auth_roleDefinition_isAdmin]  DEFAULT ((0)) FOR [isAdmin]
GO
ALTER TABLE [dbo].[itrex_auth_rolePermission] ADD  CONSTRAINT [DF_itrex_auth_rolePermission_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[itrex_auth_rolePermission] ADD  CONSTRAINT [DF_itrex_auth_rolePermission_IsExpirable]  DEFAULT ((0)) FOR [IsExpirable]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_block_failed_login_attempt]  DEFAULT ((1)) FOR [block_failed_user_login_attempt]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_allowed_login_attempt]  DEFAULT ((3)) FOR [allowed_login_attempt]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_viewMode]  DEFAULT ((1)) FOR [viewMode]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_showItemImageInCart]  DEFAULT ((1)) FOR [showItemImageInCart]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_notifyIfItemIsOutOfStock]  DEFAULT ((1)) FOR [notifyIfItemIsOutOfStock]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_showCompanyLogoInReport]  DEFAULT ((1)) FOR [showCompanyLogoInReport]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_showSecondaryLogoInReport]  DEFAULT ((0)) FOR [showSecondaryLogoInReport]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_showInvoiceFooter]  DEFAULT ((1)) FOR [showInvoiceFooter]
GO
ALTER TABLE [dbo].[org_global_settings] ADD  CONSTRAINT [DF_org_global_settings_showInvoiceTitle]  DEFAULT ((1)) FOR [showInvoiceTitle]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_countable]  DEFAULT ((1)) FOR [is_countable]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_stockable]  DEFAULT ((1)) FOR [is_stockable]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_forsale]  DEFAULT ((1)) FOR [is_forsale]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_discountable]  DEFAULT ((0)) FOR [is_discountable]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_taxable]  DEFAULT ((0)) FOR [is_taxable]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_is_bought]  DEFAULT ((1)) FOR [is_bought]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_isActive]  DEFAULT ((1)) FOR [isActive]
GO
ALTER TABLE [dbo].[org_item_definition_store] ADD  CONSTRAINT [DF_org_item_definition_store_dateCreated]  DEFAULT (getdate()) FOR [dateCreated]
GO
ALTER TABLE [dbo].[org_item_inventory_stock] ADD  CONSTRAINT [DF_org_item_inventory_stock_alertOnExpiration]  DEFAULT ((1)) FOR [alertOnExpiration]
GO
ALTER TABLE [dbo].[org_tax_policy] ADD  CONSTRAINT [DF_org_tax_policy_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[org_warehouse_stock_doc] ADD  CONSTRAINT [DF_org_warehouse_stock_doc_isCancelled]  DEFAULT ((0)) FOR [isCancelled]
GO
ALTER TABLE [dbo].[sales_discount_policy] ADD  CONSTRAINT [DF_sales_discount_policy_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[sales_order] ADD  CONSTRAINT [DF_sales_order_is_invoiced]  DEFAULT ((0)) FOR [is_invoiced]
GO
ALTER TABLE [dbo].[acc_charts_of_account]  WITH CHECK ADD  CONSTRAINT [FK_acc_charts_of_account_account_channel_group] FOREIGN KEY([channel_id])
REFERENCES [dbo].[account_channel_group] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[acc_charts_of_account] CHECK CONSTRAINT [FK_acc_charts_of_account_account_channel_group]
GO
ALTER TABLE [dbo].[acc_journal_entry]  WITH CHECK ADD  CONSTRAINT [FK_acc_journal_entry_acc_general_journal] FOREIGN KEY([general_journal_id])
REFERENCES [dbo].[acc_general_journal] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[acc_journal_entry] CHECK CONSTRAINT [FK_acc_journal_entry_acc_general_journal]
GO
ALTER TABLE [dbo].[acc_journal_entry_account]  WITH CHECK ADD  CONSTRAINT [FK_acc_journal_entry_account_acc_journal_entry] FOREIGN KEY([journal_entry_id])
REFERENCES [dbo].[acc_journal_entry] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[acc_journal_entry_account] CHECK CONSTRAINT [FK_acc_journal_entry_account_acc_journal_entry]
GO
ALTER TABLE [dbo].[acc_ledger_entry]  WITH CHECK ADD  CONSTRAINT [FK_acc_ledger_entry_acc_general_ledger] FOREIGN KEY([ledger_account_id])
REFERENCES [dbo].[acc_general_ledger] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[acc_ledger_entry] CHECK CONSTRAINT [FK_acc_ledger_entry_acc_general_ledger]
GO
ALTER TABLE [dbo].[app_messaging_comment]  WITH CHECK ADD  CONSTRAINT [FK_app_messaging_comment_app_messaging] FOREIGN KEY([message_id])
REFERENCES [dbo].[app_messaging] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[app_messaging_comment] CHECK CONSTRAINT [FK_app_messaging_comment_app_messaging]
GO
ALTER TABLE [dbo].[app_messaging_recipient_list]  WITH CHECK ADD  CONSTRAINT [FK_app_messaging_recipient_list_app_messaging] FOREIGN KEY([message_id])
REFERENCES [dbo].[app_messaging] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[app_messaging_recipient_list] CHECK CONSTRAINT [FK_app_messaging_recipient_list_app_messaging]
GO
ALTER TABLE [dbo].[crm_customer_contact]  WITH CHECK ADD  CONSTRAINT [FK_crm_customer_contact_crm_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[crm_customer] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[crm_customer_contact] CHECK CONSTRAINT [FK_crm_customer_contact_crm_customer]
GO
ALTER TABLE [dbo].[crm_customer_document]  WITH CHECK ADD  CONSTRAINT [FK_crm_customer_document_crm_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[crm_customer] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[crm_customer_document] CHECK CONSTRAINT [FK_crm_customer_document_crm_customer]
GO
ALTER TABLE [dbo].[hr_employee_contacts]  WITH CHECK ADD  CONSTRAINT [FK_hr_employee_contacts_hr_employee_profile] FOREIGN KEY([empId])
REFERENCES [dbo].[hr_employee_profile] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[hr_employee_contacts] CHECK CONSTRAINT [FK_hr_employee_contacts_hr_employee_profile]
GO
ALTER TABLE [dbo].[identity_store_preference]  WITH CHECK ADD  CONSTRAINT [FK_identity_store_preference_identity_store] FOREIGN KEY([user_id])
REFERENCES [dbo].[identity_store] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[identity_store_preference] CHECK CONSTRAINT [FK_identity_store_preference_identity_store]
GO
ALTER TABLE [dbo].[item_category]  WITH CHECK ADD  CONSTRAINT [FK_item_category_org_company_profile] FOREIGN KEY([org_id])
REFERENCES [dbo].[org_company_profile] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item_category] CHECK CONSTRAINT [FK_item_category_org_company_profile]
GO
ALTER TABLE [dbo].[item_group_attribute_list]  WITH CHECK ADD  CONSTRAINT [FK_item_group_attribute_list_org_item_attribute_group] FOREIGN KEY([group_id])
REFERENCES [dbo].[org_item_attribute_group] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item_group_attribute_list] CHECK CONSTRAINT [FK_item_group_attribute_list_org_item_attribute_group]
GO
ALTER TABLE [dbo].[item_log_detail]  WITH CHECK ADD  CONSTRAINT [FK_item_log_detail_item_log] FOREIGN KEY([item_log_id])
REFERENCES [dbo].[item_log] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item_log_detail] CHECK CONSTRAINT [FK_item_log_detail_item_log]
GO
ALTER TABLE [dbo].[item_unitStock_log]  WITH CHECK ADD  CONSTRAINT [FK_item_unitStock_log_org_item_inventory_stock] FOREIGN KEY([item_unit_measure_id])
REFERENCES [dbo].[org_item_inventory_stock] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item_unitStock_log] CHECK CONSTRAINT [FK_item_unitStock_log_org_item_inventory_stock]
GO
ALTER TABLE [dbo].[itrex_auth_objectAccessAudit]  WITH CHECK ADD  CONSTRAINT [FK_itrex_auth_objectAccessAudit_itrex_auth_roleDefinition] FOREIGN KEY([roleUsed])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[itrex_auth_objectAccessAudit] CHECK CONSTRAINT [FK_itrex_auth_objectAccessAudit_itrex_auth_roleDefinition]
GO
ALTER TABLE [dbo].[itrex_auth_rolePermission]  WITH CHECK ADD  CONSTRAINT [FK_itrex_auth_rolePermission_itrex_auth_roleDefinition] FOREIGN KEY([roleName])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[itrex_auth_rolePermission] CHECK CONSTRAINT [FK_itrex_auth_rolePermission_itrex_auth_roleDefinition]
GO
ALTER TABLE [dbo].[itrex_auth_usersInRole]  WITH CHECK ADD  CONSTRAINT [FK_itrex_auth_usersInRole_itrex_auth_roleDefinition] FOREIGN KEY([roleName])
REFERENCES [dbo].[itrex_auth_roleDefinition] ([roleName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[itrex_auth_usersInRole] CHECK CONSTRAINT [FK_itrex_auth_usersInRole_itrex_auth_roleDefinition]
GO
ALTER TABLE [dbo].[org_business_channels]  WITH CHECK ADD  CONSTRAINT [FK_org_business_channels_org_company_profile] FOREIGN KEY([org_id])
REFERENCES [dbo].[org_company_profile] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_business_channels] CHECK CONSTRAINT [FK_org_business_channels_org_company_profile]
GO
ALTER TABLE [dbo].[org_global_settings]  WITH CHECK ADD  CONSTRAINT [FK_org_global_settings_org_company_profile] FOREIGN KEY([org_id])
REFERENCES [dbo].[org_company_profile] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_global_settings] CHECK CONSTRAINT [FK_org_global_settings_org_company_profile]
GO
ALTER TABLE [dbo].[org_item_attribute_group]  WITH CHECK ADD  CONSTRAINT [FK_org_item_attribute_group_org_item_definition_store] FOREIGN KEY([item_id])
REFERENCES [dbo].[org_item_definition_store] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_item_attribute_group] CHECK CONSTRAINT [FK_org_item_attribute_group_org_item_definition_store]
GO
ALTER TABLE [dbo].[org_item_inventory_stock]  WITH CHECK ADD  CONSTRAINT [FK_org_item_inventory_stock_org_business_channels] FOREIGN KEY([for_channel_id])
REFERENCES [dbo].[org_business_channels] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_item_inventory_stock] CHECK CONSTRAINT [FK_org_item_inventory_stock_org_business_channels]
GO
ALTER TABLE [dbo].[org_item_inventory_stock]  WITH CHECK ADD  CONSTRAINT [FK_org_item_inventory_stock_org_item_definition_store] FOREIGN KEY([item_id])
REFERENCES [dbo].[org_item_definition_store] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_item_inventory_stock] CHECK CONSTRAINT [FK_org_item_inventory_stock_org_item_definition_store]
GO
ALTER TABLE [dbo].[org_warehouse_doc_inventory_stock]  WITH CHECK ADD  CONSTRAINT [FK_org_warehouse_doc_inventory_stock_org_warehouse_stock_doc] FOREIGN KEY([documentId])
REFERENCES [dbo].[org_warehouse_stock_doc] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_warehouse_doc_inventory_stock] CHECK CONSTRAINT [FK_org_warehouse_doc_inventory_stock_org_warehouse_stock_doc]
GO
ALTER TABLE [dbo].[org_warehouse_stock_doc]  WITH CHECK ADD  CONSTRAINT [FK_org_warehouse_stock_doc_org_warehouses] FOREIGN KEY([warehouseId])
REFERENCES [dbo].[org_warehouses] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[org_warehouse_stock_doc] CHECK CONSTRAINT [FK_org_warehouse_stock_doc_org_warehouses]
GO
ALTER TABLE [dbo].[org_warehouses]  WITH CHECK ADD  CONSTRAINT [FK_org_warehouses_org_company_profile] FOREIGN KEY([org_id])
REFERENCES [dbo].[org_company_profile] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[org_warehouses] CHECK CONSTRAINT [FK_org_warehouses_org_company_profile]
GO
ALTER TABLE [dbo].[po_purchase_item]  WITH CHECK ADD  CONSTRAINT [FK_po_purchase_item_org_item_definition_store] FOREIGN KEY([item_id])
REFERENCES [dbo].[org_item_definition_store] ([id])
GO
ALTER TABLE [dbo].[po_purchase_item] CHECK CONSTRAINT [FK_po_purchase_item_org_item_definition_store]
GO
ALTER TABLE [dbo].[po_purchase_item]  WITH CHECK ADD  CONSTRAINT [FK_po_purchase_item_po_purchase_order] FOREIGN KEY([po_id])
REFERENCES [dbo].[po_purchase_order] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[po_purchase_item] CHECK CONSTRAINT [FK_po_purchase_item_po_purchase_order]
GO
ALTER TABLE [dbo].[sales_order]  WITH CHECK ADD  CONSTRAINT [FK_sales_order_crm_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[crm_customer] ([id])
GO
ALTER TABLE [dbo].[sales_order] CHECK CONSTRAINT [FK_sales_order_crm_customer]
GO
ALTER TABLE [dbo].[sales_order_item]  WITH CHECK ADD  CONSTRAINT [FK_sales_order_item_sales_order] FOREIGN KEY([sales_order_id])
REFERENCES [dbo].[sales_order] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_order_item] CHECK CONSTRAINT [FK_sales_order_item_sales_order]
GO
ALTER TABLE [dbo].[sales_payment_detail]  WITH CHECK ADD  CONSTRAINT [FK_sales_payment_detail_sales_payment_info] FOREIGN KEY([payment_info_id])
REFERENCES [dbo].[sales_payment_info] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_payment_detail] CHECK CONSTRAINT [FK_sales_payment_detail_sales_payment_info]
GO
USE [master]
GO
ALTER DATABASE [effectiv_db] SET  READ_WRITE 
GO
