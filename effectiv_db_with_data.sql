USE [master]
GO
/****** Object:  Database [effectiv_db]    Script Date: 8/23/2016 2:07:48 PM ******/
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
/****** Object:  Table [dbo].[acc_account_period]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_charts_of_account]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_general_journal]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_general_ledger]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_journal_entry]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_journal_entry_account]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[acc_ledger_entry]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[account_channel_group]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[app_messaging]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[app_messaging_comment]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[app_messaging_recipient_list]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[app_notification]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[crm_customer]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[crm_customer_contact]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[crm_customer_document]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[currency_conversion]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[currency_policy]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_contacts]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_document]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_document_details]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_medicals]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_medicals_details]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_employee_profile]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_recruitement_setup]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_recruitement_setup_details]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_recruitment_personnel_accepted]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[hr_recruitment_personnel_enrollment]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[identity_store]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[identity_store_preference]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_category]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_group_attribute_list]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_log]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_log_detail]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_storage_type]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[item_unitStock_log]    Script Date: 8/23/2016 2:07:49 PM ******/
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
 CONSTRAINT [PK_item_unitStock_log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[itrex_auth_objectAccessAudit]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[itrex_auth_roleDefinition]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[itrex_auth_rolePermission]    Script Date: 8/23/2016 2:07:49 PM ******/
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
	[description] [nvarchar](550) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[itrex_auth_usersInRole]    Script Date: 8/23/2016 2:07:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itrex_auth_usersInRole](
	[id] [nvarchar](50) NOT NULL,
	[userId] [nvarchar](50) NULL,
	[roleName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[org_business_channels]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_company_profile]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_global_settings]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_item_attribute_group]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_item_definition_store]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_item_inventory_stock]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_media_store]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_tax_policy]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_warehouse_doc_inventory_stock]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_warehouse_stock_doc]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[org_warehouses]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[po_purchase_item]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[po_purchase_order]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[sales_discount_policy]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[sales_order]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[sales_order_item]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[sales_payment_detail]    Script Date: 8/23/2016 2:07:49 PM ******/
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
/****** Object:  Table [dbo].[sales_payment_info]    Script Date: 8/23/2016 2:07:49 PM ******/
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
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'ALWELL-FASHIONABLES', N'Alwell Fashionables', N'uploaded_files/crm\pictures/c3824b07-24d1-4d7a-8e19-083438ae6c30.jpg', N'', N'12B Sambisa street Douglas road owerri', N'Imo', NULL, N'00632362333', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A64000F171D4 AS DateTime), NULL, NULL, NULL, NULL, N'0002_AKWA', N'innocent')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'AMAKA-EPC', N'Oyedepo HODCS', N'/uploaded_files/crm/pictures/ee18ceb8-3d22-42f5-af28-5138253923cb.png', N'/images/user_avar_male.png', NULL, N'Owerri', NULL, N'0806789909', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A650010A3EB4 AS DateTime), CAST(0x0000A650010A3EB5 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'APANJO-OFEMANU', N'Apanjo Ofemanu', N'/uploaded_files/crm/pictures/e064ff85-274c-400e-9321-aed1c7f5524f.jpg', N'/images/user_avar_male.png', N'Badman Company limited (APC chairman)', N'Lagos', NULL, N'08073219122', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65700FA768A AS DateTime), CAST(0x0000A65700FA768C AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'asom-services-limited', N'Asom Services Nigeria', N'/uploaded_files/crm/pictures/dc556198-a4cc-473d-89d6-9334825c822f.png', N'/images/user_avar_male.png', N'105 IHI Island', N'Imo', NULL, N'08069273479', NULL, NULL, N'RETAIL', 0, 1, 1, CAST(100000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A65200A4957B AS DateTime), CAST(0x0000A65200A4957F AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'ASSHILA-OKAFOR', N'Asshila Okafor', N'uploaded_files/crm\pictures/69e89140-b921-4b53-b5ec-f56362f0a468.png', N'', N'Azu Royal Appitite Hotel nnewi', N'Anambra', NULL, N'0806633273', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63E009179BA AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'barry-isowuja', N'Barry Isowuja', N'uploaded_files/crm\pictures/0346a7b9-45f8-4624-ba94-0a5b329acd7f.png', N'/images/user_avar_male.png', N'island road ph', N'Rivers', NULL, N'07033222193', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A64500C5ED93 AS DateTime), CAST(0x0000A64500C5ED95 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'benneth-uchendu', N'Benneth Uchendu', N'uploaded_files/crm\pictures/80e5f198-3b33-4ec9-96a8-7c48ee983efb.jpg', N'', NULL, NULL, NULL, N'08033621344', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62D004EEA0A AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CHARLES-PROGRAMMER', N'Charles Programmer', N'', N'', NULL, N'Imo', NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65300FF88A7 AS DateTime), NULL, NULL, NULL, NULL, N'0002_AKWA', N'somkene')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CHIDI-APARTMENT', N'Chidi Apartment', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A64000D54FFD AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CHIDOSKY-EHENE', N'Chidosky Ehene', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A640010D15FA AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CHIDOZIE', N'Chidozie', N'/uploaded_files/crm/pictures/19a8d247-48a3-4772-b12a-2ccb24e60b94.png', N'/images/user_avar_male.png', N'Adroid Software Inc', NULL, NULL, N'08077832902', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65000DF3083 AS DateTime), CAST(0x0000A65000DF3084 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CHIGOZIE-SONET', N'Chigozie Sonet', N'', N'', N'Ihiagwa owerri west', N'Imo', NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65C00E07483 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'chioma-okafor', N'Chioma Okafor', N'uploaded_files/crm\pictures/ce279375-5ca4-4180-aee7-b5379ea99a22.jpg', N'/images/user_avar_male.png', N'Umuerim Village Nekede Ihiagwa', N'Anambra', NULL, N'080672833662', NULL, N'okeysons@yahoo.com', N'WHOLESALE', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62B01525994 AS DateTime), CAST(0x0000A62B01525995 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CUS-0001', N'John Umeh', N'uploaded_files/crm\pictures/446109ee-30bc-46db-b3b7-13846c6c3652.jpg', N'/images/user_avar_male.png', N'Ihiagwa Nekede Owerri', N'Imo', N'Ihiagwa', N'08067778900', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63900DAB08A AS DateTime), CAST(0x0000A63900DAB08C AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CUS-0002', N'Sunic Resturant Limited', N'/images/user_avar_male.png', N'/images/user_avar_male.png', N'World bank housing estate Owerri', N'Imo', N'World bank', N'08063442123', NULL, NULL, N'RETAIL', 0, 1, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65000DF68EF AS DateTime), CAST(0x0000A65000DF68F1 AS DateTime), N'Reliable Representative from Sunic Resturant at World bank branch', NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'CUSTOMER-X-ACCOUNT', N'Customer X Account', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A633011D8500 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'DELPIERO-BRAZIL', N'Delpiero brazil', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63200ED65E6 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'demo-customer-company', N'Demo Customer Company 001', N'uploaded_files/crm\pictures/22c5cfcd-555c-4748-b015-305fcc702732.png', N'/images/user_avar_male.png', N'1033 ibariobggba', N'Abuja', NULL, N'08032389293', N'http://www.democompanywebsite.com', NULL, N'RETAIL', 0, 1, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A64000B362CD AS DateTime), CAST(0x0000A64000B362CE AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'epc-solution', N'EPC Solution', N'', N'', N'NEKEDE POLY', N'Imo', NULL, N'0806454431', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63001137BB4 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'ERIC-ANOZIE', N'Eric Anozie', N'uploaded_files/crm\pictures/5411dfd3-93df-4acc-b7bf-bd87e411d495.jpg', N'/images/user_avar_male.png', N'Fedpoly Nekede', N'Imo', NULL, N'08137303511', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A64E00DC4732 AS DateTime), CAST(0x0000A64E00DC4735 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'felix-uchechukwu', N'Felix Uchechukwu', N'uploaded_files/crm\pictures/c8e5406a-555f-40b8-bc62-a6344a4ed6fe.gif', N'', N'Umuchima road nekede', N'Imo', NULL, NULL, NULL, N'felix@gmail.com', N'RETAIL', 0, 0, 1, CAST(200000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A6250085ECB2 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'greenhouse-church', N'Greenhouse church', N'uploaded_files/crm\pictures/7e20b3da-d730-46c2-a72b-8ed458b4a02e.png', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 1, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62700EE06B2 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'IFENNA-OKAFOR', N'Ifenna Okafor', N'', N'', N'Nnewi machine parts Nkwo', N'Anambra', NULL, N'08063232111', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63400907A7B AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'iyke-fedinald', N'Iyke Fedinald', N'/uploaded_files/crm/pictures/f03254b1-3291-478f-9ee7-021c1fa8100b.jpg', N'/images/user_avar_male.png', NULL, N'IMO', NULL, N'08067372822', NULL, N'iykekfeddy@gmail.com', N'DISTRIBUTOR', 0, 0, 1, CAST(110000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A669007A995F AS DateTime), CAST(0x0000A669007A996E AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'iyke-ibe', N'Iyke Ibe', N'uploaded_files/crm\pictures/a8af3342-7ed5-44db-b7a6-f81d481b907e.png', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A6280107386B AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'JACOB-ZUMA', N'Jacob Zuma', N'uploaded_files/crm\pictures/9daca9cd-2d21-47b8-b6ec-6a8c94a17f0f.jpg', N'/images/user_avar_male.png', N'South Africa Presidential residence Cape town', N'South Africa', NULL, N'08073232711', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A630014004DD AS DateTime), CAST(0x0000A630014004DE AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'kkc-udoh', N'Kkc udoh', N'uploaded_files/crm\pictures/7d48a21c-8e9c-4393-8af9-6054c6d47037.jpg', N'/images/user_avar_male.png', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62C007151FF AS DateTime), CAST(0x0000A62C007151FF AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'life-is-good-lg', N'Life is Good(LG)', N'/images/user_avar_male.png', N'/images/user_avar_male.png', N'Mbari street Owerri', N'Imo', NULL, N'00763272323', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65000FAC081 AS DateTime), CAST(0x0000A65000FAC08E AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'mario-brunei', N'Mario bruneil', N'/uploaded_files/crm/pictures/57a44622-e73c-4e54-9675-0ec9969f3f1b.png', N'/images/user_avar_male.png', NULL, N'Italy', NULL, N'+23 455 98767558', N'http://www.mariobrunei.it', NULL, N'RETAIL', 1, 1, 1, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A6330057B03D AS DateTime), CAST(0x0000A6330057B04C AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'MATHEW-SYNAX', N'Mathew Synax', N'uploaded_files/crm\pictures/0ba9cf1e-1a13-480d-b0d4-78035220d58b.jpg', N'', N'15D rumumasi road, portharcourt', N'Rivers', NULL, N'08062719912', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65000F7E37E AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'maxli-automobile-industries-limited', N'Maxli Automobile Industries Limited', N'uploaded_files/crm\pictures/80f9df3e-53b9-4bfa-b82a-eba9dc84e867.png', N'', N'123 Ikenebu road ihiagwa Nnewi', N'Anambra', NULL, N'08023612111', NULL, NULL, N'RETAIL', 0, 1, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62700F4D33A AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'naliss-nekede', N'NALISS NEKEDE', N'uploaded_files/crm\pictures/7343ac4f-0598-41ce-bd86-21846e4a64cc.jpg', N'', N'Fed poly nekede owerri', N'Imo', NULL, N'0084332813', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A628006EE553 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'nnayelugo-obialo', N'Nnayelugo Obialo', N'/uploaded_files/crm/pictures/280d3151-9f1e-4510-926d-6a4e039c7343.jpg', N'/images/user_avar_male.png', N'Ihiagwa Road owerri West', N'Imo', NULL, N'0805636362', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A649012B7200 AS DateTime), CAST(0x0000A649012B7200 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'OBI-MACBEE-INTERNALTIONAL', N'Obi Macbee Internaltional', N'uploaded_files/crm\pictures/68a7179f-81da-4359-88d0-82cd4ccf4679.gif', N'', NULL, N'Rivers', NULL, NULL, NULL, NULL, N'DISTRIBUTOR', 0, 1, 1, CAST(10000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A652012FC70F AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'okafor-nonso', N'Okafor Nonso', N'uploaded_files/crm\pictures/df3b3ae7-e384-4720-a069-056c6737dbb9.jpg', N'', NULL, NULL, NULL, N'08036213882', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62700C3F04B AS DateTime), NULL, NULL, NULL, NULL, N'0002_AKWA', N'innocent')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'OKECHUKWU-MMADU', N'Okechukwu Mmadu', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A63200CB393F AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'okechukwu-umeh', N'Okechukwu Umeh', N'uploaded_files/crm\pictures/4366f950-2121-4ed7-9a8c-223d57a36d04.jpg', N'', NULL, NULL, NULL, N'08065544433', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62F00D1F5C0 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'olivia-obialo', N'Olivia Obialo', N'', N'', NULL, NULL, NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62D010E6A80 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'PAAGO-AUTOMOBILE-NIGERIA-LIMITED', N'Paago Automobile Nigeria Limited', N'/uploaded_files/crm/pictures/5d8229c3-9182-438d-975a-40aa517030a6.jpg', N'/images/user_avar_male.png', N'177 Avenue paago estate', N'Israel', NULL, N'+77 836721993', NULL, NULL, N'WHOLESALE', 0, 1, 1, CAST(50000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A65500756BAF AS DateTime), CAST(0x0000A65500756BB1 AS DateTime), N'Paago enterprise deals on arms', NULL, NULL, N'0002_AKWA', N'innocent')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'PETER-ILO', N'Gopek Super Genuine Auto Parts', N'/uploaded_files/crm/pictures/66e9f381-7246-4e03-8842-03ce6b76d9a8.png', N'/images/user_avar_male.png', N'Nnewi', N'Anambra', NULL, N'8066372532', NULL, N'peterilo@gmail.com', N'WHOLESALE', 0, 1, 1, CAST(86000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A656012D4149 AS DateTime), CAST(0x0000A656012D414D AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'PHIPLIP-OKOCHA', N'Phiplip Okocha', N'uploaded_files/crm\pictures/cd8533ab-6c1d-45c0-84e8-cf5c48328e96.jpg', N'/images/user_avar_male.png', N'kazare avanue sabon-gari Kano', N'Kano', NULL, N'09018823323', NULL, NULL, N'WHOLESALE', 0, 0, 1, CAST(50000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A64E00C169ED AS DateTime), CAST(0x0000A64E00C16A02 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'somkene-maryann-obialo', N'Somkene Maryann Obialo', N'uploaded_files/crm\pictures/af4828b6-9074-40e7-81dc-77a208fc9fc2.jpg', N'/images/user_avar_male.png', N'Ibeto avenue nnewi', N'Anambra', NULL, N'08067729923', N'', NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62C00776055 AS DateTime), CAST(0x0000A62C00776057 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'STANLEY-NDUBUEZE', N'Stanley Ndubueze', N'', N'', NULL, NULL, NULL, N'0701065873', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A650010F215D AS DateTime), NULL, NULL, NULL, NULL, N'0002_AKWA', N'somkene')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'the-promise-fast-food', N'The Promise Fast Food', N'/uploaded_files/crm/pictures/eb36fef0-b294-4c7b-9dcf-7e32ac94aefb.png', N'/images/user_avar_male.png', N'Ph', N'Rivers', NULL, N'0808992002, 07052617222', NULL, NULL, N'RETAIL', 0, 1, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62B01726698 AS DateTime), CAST(0x0000A62B017266B1 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'tonimas-automobile-limited', N'Tonimas Automobile Nig Limited', N'/uploaded_files/crm/pictures/f4ffcf1d-9983-4735-8849-7125aec9c0d9.png', N'/images/user_avar_male.png', N'21 Lagos Street Ariaria Aba', N'Abia', NULL, N'08062211332, 09018821266', NULL, N'info@tonimasltd.com', N'WHOLESALE', 0, 1, 1, CAST(100000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A65500E3BD73 AS DateTime), CAST(0x0000A65500E3BD74 AS DateTime), NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'trademit-co-international', N'Trademit & Co. International', N'uploaded_files/crm\pictures/ea7e1b43-9b99-4ebb-b772-8c6a2f870131.png', N'', N'12B3 Isoku Road Victoria Island', N'Lagos', NULL, N'08072525177', N'http://www.trademit.com', N'trademitnig@gmail.com', N'RETAIL', 0, 1, 1, CAST(790000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A62700CC7C82 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'UCHE-OKAFOR', N'Uche Okafor', N'', N'', N'Nekede Owerri', N'Lagos', NULL, N'08038733892', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A6490129D778 AS DateTime), NULL, NULL, NULL, NULL, N'0002_AKWA', N'nonsoval')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'UD-CHESS-MASTER', N'UD Chess Master', N'uploaded_files/crm\pictures/e82fff93-aad5-4245-ad0f-e4613df3f3c0.gif', N'', N'Federal Polytechnic Nekede Owerri', N'Imo', NULL, N'0805 3632 322', NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A65700F8CB84 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'UNION-BANK-OF-AFRICA', N'Union Bank Of Africa', N'/uploaded_files/crm/pictures/c3a42a1a-38fc-44c2-8764-5907a2f859c4.png', N'/images/user_avar_male.png', N'Victoria Island Lagos', N'Lagos', NULL, N'09072331882', N'http://www.uba.com.ng', NULL, N'WHOLESALE', 0, 1, 1, CAST(30000 AS Decimal(18, 0)), 1, 1, CAST(0x0000A656009852E0 AS DateTime), CAST(0x0000A656009852E2 AS DateTime), N'Uba has being a Promising Client for the company, for any details contact there various representative in the contact Section', NULL, NULL, N'0002_AKWA', N'innocent')
INSERT [dbo].[crm_customer] ([id], [company_name], [company_logo_url], [company_signature_url], [company_address], [location], [city], [phone_number], [website_address], [email_address], [customer_type], [is_supplier], [is_company], [has_account], [credit_limit], [is_credit_worthy], [isActive], [dateCreated], [dateUpdate], [memo], [allow_online_login], [login_id], [created_at_channel_id], [created_by]) VALUES (N'yaradua-abubakar', N'Yaradua Abubakar', N'uploaded_files/crm\pictures/1b9ed113-76a4-45b1-8547-557e5d94ee61.jpg', N'', N'Kano road sabon ggari', N'Kano', NULL, NULL, NULL, NULL, N'RETAIL', 0, 0, 0, CAST(0 AS Decimal(18, 0)), 0, 1, CAST(0x0000A62D011080B0 AS DateTime), NULL, NULL, NULL, NULL, N'ORG_CODE_0001', N'alfred')
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'06e71f9c-a4c7-4a0f-9db9-5a2ea2303e9d', N'Femi', N'Adesina', N'uploaded_files/crm\pictures/9198868b-36b4-4254-a3f8-4692ea45845c.jpg', 1, N'08062232551', N'UNION-BANK-OF-AFRICA', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'1367b58f-5b68-4e2b-ac52-7a8b4ce8d2b9', N'Maryann', N'Obialo', N'uploaded_files/crm\pictures/dec2df58-087b-4c6e-bdce-3d88b4e15ac8.jpg', 1, N'08064327645', N'mario-brunei', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'1494b818-f149-4ebb-a5bc-54d1a5cc05b6', N'Felicity', N'Mbamalu', N'uploaded_files/crm\pictures/1887a651-869e-4d7b-b31e-a67680434d79.JPG', 1, N'08032554453', N'trademit-co-international', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'1eef65a0-c880-46b5-a773-249df47d8328', N'Prisca', N'Okafor', N'uploaded_files/crm\pictures/02b96798-4058-4a1c-8efd-efef5cf346af.png', 1, N'08063334808', N'mario-brunei', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'2db084d0-41de-4c5a-aea3-43ff797f662c', N'Chioma', N'Okonkwo', N'uploaded_files/crm\pictures/dfa2cc0f-a1e6-4d3e-bf9c-5fc50e55d2ce.jpg', 1, N'08034251223', N'UNION-BANK-OF-AFRICA', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'4bdf813e-ce5a-4596-9f5b-a73f55711aed', N'Ayo', N'Dele', N'uploaded_files/crm\pictures/d5cc1007-8c25-4340-b615-9b2f2e8cf0be.jpg', 1, N'08053236361', N'UNION-BANK-OF-AFRICA', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'5c720eda-0e77-4e30-9006-8eb085737c3b', N'Maxwel', N'Ifeanyi', N'uploaded_files/crm\pictures/a0712677-80ee-4b5f-83fc-497244e1c09c.jpg', 1, N'0239991290', N'maxli-automobile-industries-limited', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'78b210dd-c33f-41f7-b8fc-9b1a44f63b0f', N'Bello', N'Musa', N'uploaded_files/crm\pictures/80d4ba34-28d5-42b2-8fb6-d20301eb6110.jpg', 1, N'080324436621', N'trademit-co-international', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'838061d3-de74-4c91-b0b6-678104b02651', N'Chidi', N'Ezidiegwu', N'uploaded_files/crm\pictures/829129e9-b2c8-4308-b3a3-2f597da646a3.jpg', 1, N'09027773291', N'maxli-automobile-industries-limited', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'8bbe04f8-71c0-4e34-a0c2-00dcd4cc95f7', N'Cyntia', N'Okeke', N'uploaded_files/crm\pictures/76a1a571-951c-45da-8da7-a7d605473150.jpg', 1, N'2382834389', N'maxli-automobile-industries-limited', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'b7336cfa-5d62-4f5b-9a98-3dcf55498790', N'Sutain', N'Akmed', N'uploaded_files/crm\pictures/5689979a-ce00-4dea-a32a-2abd54afd328.jpg', 1, N'0803663262', N'PAAGO-AUTOMOBILE-NIGERIA-LIMITED', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'c6728302-9a35-41f8-a530-fd0fa6d8b6a8', N'Chioma', N'Fedinald', N'uploaded_files/crm\pictures/360b30e9-9969-4a69-bbb7-d8764a1258b1.png', 1, N'08031738221', N'iyke-fedinald', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'cbbb6b9b-91eb-4ee8-873b-5b29172bce4b', N'James', N'Uche', N'uploaded_files/crm\pictures/9ba95caf-db70-447f-a91c-d22b9857e886.jpg', 1, N'08072221663', N'tonimas-automobile-limited', NULL)
INSERT [dbo].[crm_customer_contact] ([id], [first_name], [last_name], [picture_url], [isActive], [phone_number], [customer_id], [job_title]) VALUES (N'e62edfd6-b19c-46e8-b12a-e5bf80c9b024', N'Peter', N'Ilo', N'uploaded_files/crm\pictures/339d6b8c-4bd8-42e8-a7ad-fc07a9d4adc4.jpg', 1, N'08067738193', N'the-promise-fast-food', NULL)
INSERT [dbo].[hr_employee_contacts] ([id], [empId], [contactName], [address], [phone], [email], [fax]) VALUES (N'68b75ec8-4a63-47e2-bbc4-57121ffb7b7a', N'EMP-2015/04-001', N'Innocent Ibe', N'Rumuokota 120B Portharcourt', N'08056332781', N'innocentamahaotu@gmail.com', NULL)
INSERT [dbo].[hr_employee_contacts] ([id], [empId], [contactName], [address], [phone], [email], [fax]) VALUES (N'734bbe82-a5ac-4749-a0b7-4f537c75c991', N'EMP-2015/04-001', N'Alfred Ikechukwku', N'105 Famous house nekede owerri', N'08069273479', N'alfredcsdinc@gmail.com', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'11293', N'Onyemachi', N'Ejim', N'Chioma', N'Miss', N'Female', CAST(0x0000758800735B40 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/ccfec4f7-3045-4288-aaf4-07217073ab82.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Aboh-Mbaise', N'Oboama', N'innocent', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60600D464AC AS DateTime), NULL, NULL, N'innocent', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0001-2016-05', N'Innocent', N'Amahaotu', N'Ibe', N'Mr', N'Male', CAST(0x00006E2B017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/c3d7c159-2b4b-48b8-abb1-905d712e06c4.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Ahiazu-Mbaise', N'Ndulu', N'olivia', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FD015D3A1D AS DateTime), NULL, NULL, N'olivia', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00010-2016-05', N'onyeuwoma', N'chibuikem', N'john', N'Mr', N'Male', CAST(0x000084B6017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/92daf78f-a1dc-4a42-917f-337eb02a90f6.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Ezinihitte', N'owutu', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FE00F99171 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00011-2016-05', N'Victor', N'Ogene', N'Afam', N'Engr', N'Male', CAST(0x0000563A017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/200100fe-a22f-4371-893b-6eaaa974cd91.jpg', NULL, NULL, NULL, N'Ebonyi', N'Nigeria', N'Afikpo South', N'Nmanuka', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FE0127A852 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00012-2016-05', N'Dokubo', N'Asari', N'Musa', N'Mr', N'Male', CAST(0x00006983017B0740 AS DateTime), N'Married', N'/uploaded_files/employee-profile/pictures/c85a0408-a502-416c-bdb4-d2189989725c.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Bayelsa', N'Nigeria', N'Nembe', N'Nkisoa', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60200AF8FA2 AS DateTime), NULL, CAST(0x0000A60200AF8FA2 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00013-2016-05', N'Olusegun', N'Obasanjo', N'Obj', N'Mr', N'Male', CAST(0x00002E7B017B0740 AS DateTime), N'Seperated', N'uploaded_files/employee-profile\pictures/4fad8a5b-9a80-41bc-8aeb-f0ea31bd3bf4.jpg', NULL, NULL, NULL, N'Ogun', N'Nigeria', N'Ogun Waterside', N'Ota', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FE0128D998 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00014-2016-05', N'Chukuma', N'Soludo', N'Jude', N'Prof', N'Male', CAST(0x00004464017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/a6b007e9-13e1-4a9e-b02f-fc78deb930de.jpg', NULL, NULL, NULL, N'Anambra', N'Nigeria', N'Awka North', N'Idembe', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FE01295981 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00015-2016-05', N'Fani', N'Kayode', N'Kemi', N'Mr', N'Male', CAST(0x0000495F017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/5727c7c7-2eb5-47d4-adce-2366d6db0107.jpg', NULL, NULL, NULL, N'Lagos', N'Nigeria', N'Amuwo-Odofin', N'Killina', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FE0129BD32 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00016-2016-05', N'Lamido', N'Sanusi', N'Lamido', N'Prof', N'Male', CAST(0x00003A13017B0740 AS DateTime), N'Married', N'/uploaded_files/employee-profile/pictures/09c2e146-8d9e-4b26-864d-41662df753ec.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Kano', N'Nigeria', N'Garko', N'Mulata', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60A00E2A15F AS DateTime), NULL, CAST(0x0000A60A00E2A15F AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00017-2016-05', N'Timisan', N'Okoyone', N'Mejhi', N'Dr', N'Male', CAST(0x0000381E017B0740 AS DateTime), N'Married', N'/uploaded_files/employee-profile/pictures/73bbccde-7fa2-40d8-817c-b30f1c19082f.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Edo', N'Nigeria', N'Oredo', N'Mkiskpo', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60600F328A8 AS DateTime), NULL, CAST(0x0000A60600F328A8 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00018-2016-05', N'Dasuki', N'Onyecriminal', N'Armsdeal', N'Mr', N'Male', CAST(0x00004B38017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/796681c8-860e-4bad-a3ac-90c251cfb40a.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Kano', N'Nigeria', N'Garko', N'Mkiloa', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60200D551D1 AS DateTime), NULL, CAST(0x0000A60200D551D2 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00019-2016-05', N'Kemezie', N'Okoye', N'Chinedu', N'Mr', N'Male', CAST(0x00007025017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/104f4d97-7c47-4cab-872e-c865cab54a12.jpg', NULL, NULL, NULL, N'Anambra', N'Nigeria', N'Ihiala', N'Oliolp', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A5FF0152317C AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0002-2016-05', N'Linda', N'Okoye', N'Ebere', N'Miss', N'Female', CAST(0x00007EE9017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/5caebba7-6c5c-4355-8790-b2ca3219239f.jpg', N'/images/user_avar_female.png', N'/images/user_avar_female.png', NULL, N'Anambra', N'Nigeria', N'Ekwusigo', N'Mbasiji', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60200ADB773 AS DateTime), NULL, CAST(0x0000A60200ADB773 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00021-2016-05', N'Emeka', N'Okoro', N'John', N'Mr', N'Male', CAST(0x00007686017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/9c3a76ad-4016-4087-a791-d59f980fcf67.png', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Anambra', N'Nigeria', N'Awka North', N'Onitsha', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60100B29798 AS DateTime), NULL, CAST(0x0000A60100B29798 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00022-2016-05', N'Christian', N'Ojiakor', N'Nnanedum', N'Mr', N'Male', CAST(0x00006A11017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/627103a2-1caf-4032-ac12-437aa1270685.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Orlu', N'Ekwuilo', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A602012F9C85 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00023-2016-05', N'Francess', N'Udochukwu', N'Chidimma', N'Miss', N'Female', CAST(0x000083C5017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/33fa6017-0a7f-4836-8410-fe569c18ddc7.jpg', NULL, NULL, NULL, N'Abia', N'Nigeria', N'Ugwunagbo', N'Mukoli', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60401039BCA AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00024-2016-05', N'Gaberiel', N'Onyemaechi', N'Chinedu', N'Mr', N'Male', CAST(0x00008703017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/ef2341f6-e638-4caa-9061-1af5cda11178.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Ebonyi', N'Nigeria', N'Ebonyi', N'Umobiol', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A6240090A978 AS DateTime), NULL, CAST(0x0000A6240090A978 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00025-2016-05', N'Festus', N'Madu', N'Chinedu', N'Mr', N'Male', CAST(0x00006FDE017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/a2341a9a-349a-4244-8dbf-48d8f9b2ca84.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Ikeduru', N'ibenato', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A619011BEAAF AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-00026-2016-05', N'Doris', N'Okonkwo', N'Eberechi', N'Miss', N'Female', CAST(0x00007FA4017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/53105a0e-b2c4-4769-bff0-72f6b22034da.jpg', NULL, NULL, NULL, N'Imo', N'Nigeria', N'Orlu', N'Umuna', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A62000DD9FF0 AS DateTime), NULL, NULL, N'alfred', NULL)
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0003-2016-05', N'Maryann', N'Atuegbu', N'Onyi', N'Miss', N'Female', CAST(0x0000817A017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/0ce2aa01-9e96-44f0-aaf7-fc4833889871.jpg', N'/images/user_avar_female.png', N'/images/user_avar_female.png', NULL, N'Anambra', N'Nigeria', N'Ekwusigo', N'Ijinkakor', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60B00B12FC8 AS DateTime), NULL, CAST(0x0000A60B00B12FC8 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0004-2016-05', N'Alfred', N'Obialo', N'Ikechukwu', N'Mr', N'Male', CAST(0xFFFFFF75017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/cf1f9e65-14be-410a-afd1-d2187eeb4856.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Imo', N'Nigeria', N'Nkwerre', N'Umuokpu', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A63200FB5416 AS DateTime), NULL, CAST(0x0000A63200FB5416 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0005-2016-05', N'Olivia', N'Obialo', N'Chinoyerem', N'Miss', N'Female', CAST(0x0000A448017B0740 AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/3e4dce70-9764-4417-bb9b-ae00260ecd60.jpg', N'/images/user_avar_female.png', N'/images/user_avar_female.png', NULL, N'Imo', N'Nigeria', N'Nkwerre', N'Umuokpu', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A61400907109 AS DateTime), NULL, CAST(0x0000A61400907109 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0006-2016-05', N'Valentine', N'Okafor', N'Nonso', N'Mr', N'Male', CAST(0x00007CB7017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/e40f4e24-345e-46d8-9412-a3c45b0b1045.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Anambra', N'Nigeria', N'Idemili south', N'Ikolma', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60801040117 AS DateTime), NULL, CAST(0x0000A60801040117 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0007-2016-05', N'Christian', N'Juwe', N'Chijioke', N'Mr', N'Male', CAST(0x0000748B017B0740 AS DateTime), N'Single', N'/uploaded_files/employee-profile/pictures/7f30a186-3d22-4a45-b7c8-d064d3904fa2.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Delta', N'Nigeria', N'Ughelli North', N'Kiosn', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60200ABD43A AS DateTime), NULL, CAST(0x0000A60200ABD43A AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0008-2016-05', N'Maryann', N'Obialo', N'Somkenechukwu', N'Mrs', N'Female', CAST(0x00008184017B0740 AS DateTime), N'Married', N'uploaded_files/employee-profile\pictures/e6c9e924-fb50-4fa5-b518-2143c39a8d9d.jpg', N'/images/user_avar_female.png', N'/images/user_avar_female.png', NULL, N'Imo', N'Nigeria', N'Nkwerre', N'Umuokpu', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A624009A3BEC AS DateTime), NULL, CAST(0x0000A624009A3BEC AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-0009-2016-05', N'Austine', N'EPC', N'John', N'Mr', N'Male', CAST(0x00007CB7017B0740 AS DateTime), N'Married', N'/uploaded_files/employee-profile/pictures/f308056a-9023-4cd8-8e62-f1a05d387f44.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Imo', N'Nigeria', N'Ideato South', N'Akinwo', N'alfred', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A60A00E28DA8 AS DateTime), NULL, CAST(0x0000A60A00E28DA8 AS DateTime), N'alfred', N'Employee Profile Updated')
INSERT [dbo].[hr_employee_profile] ([id], [firstName], [lastName], [middleName], [titleOfCoursey], [gender], [dateOfBirth], [maritalStatus], [passportUrl], [leftSidePicUrl], [rightSidePicUrl], [loginAccId], [stateOfOrigin], [nationality], [lga], [homeTown], [createdBy], [org_id], [createdAt_channelId], [deployedAt_channelId], [isActive], [dateCreated], [note], [lastUpdated], [lastUpdatedBy], [lastUpdateNote]) VALUES (N'EMP-2015/04-001', N'James', N'Okoye', N'Uchechukwu', N'Mr', N'Male', CAST(0x0000757501410FCC AS DateTime), N'Single', N'uploaded_files/employee-profile\pictures/c41016fe-1994-4925-8043-8899bf650e1b.jpg', N'/images/user_avar_male.png', N'/images/user_avar_male.png', NULL, N'Enugu', N'Nigeria', N'Nkanu', N'Ukwana', N'innocent', N'ORG_CODE_0001', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, CAST(0x0000A601006364AE AS DateTime), N'Joined the Company in 2015', CAST(0x0000A601006364AE AS DateTime), N'innocent', N'Employee Profile Updated')
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'alfred', N'RYaq4h+P3IBAYQC0PId3ew==', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, 0, NULL, CAST(0x0000A5DB00CE79A9 AS DateTime), NULL, NULL, NULL, NULL, N'System Admin', N'uploaded_files/user-profile\passport/a1dfab51-c3e6-4f83-96cc-ee67ef4c1b01.JPG', N'SYSADMIN', NULL, N'MALE', NULL)
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'ibestan', N'qVIcubQPY53CeTrenDRJkQ==', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, 0, NULL, CAST(0x0000A60901016F7C AS DateTime), NULL, NULL, NULL, NULL, N'Ibe Stanley', N'uploaded_files/user-profile\passport/cecce81a-7447-4e45-99ca-c001216e09a1.JPG', N'SYSUSER', NULL, N'MALE', NULL)
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'innocent', N'6QMQJhmOUzdMcQLACnVHIA==', N'ORG_CODE_0001', N'0002_AKWA', 1, 0, NULL, CAST(0x0000A5F401313203 AS DateTime), N'What do you like Doing the most.', N'Programming', NULL, NULL, N'Amahaotu Innocent', N'uploaded_files/user-profile\passport/2b5b45d9-bef1-4e1b-954a-2230fccebb25.jpg', NULL, NULL, N'MALE', NULL)
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'nonsoval', N'HpQpub+3GahbTNy6+1L9gQ==', N'ORG_CODE_0001', N'0002_AKWA', 1, 0, NULL, CAST(0x0000A60000CBB22C AS DateTime), N'Online Project Application for Student', N'Classgist', NULL, NULL, N'Nonso Valentine', N'uploaded_files/user-profile\passport/81170491-b5c7-4b0b-a834-f64c207e63c5.jpg', NULL, NULL, N'MALE', NULL)
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'olivia', N'RYaq4h+P3IBAYQC0PId3ew==', N'ORG_CODE_0001', N'ORG_CODE_0001', 1, 0, NULL, CAST(0x0000A5E200F23097 AS DateTime), NULL, NULL, NULL, NULL, N'Olivia Obialo', N'uploaded_files/user-profile\passport/9c03dff9-36cc-4059-ad38-6d2f860b15bb.jpg', N'SYSUSER', NULL, N'FEMALE', NULL)
INSERT [dbo].[identity_store] ([user_id], [password], [org_id], [channel_id], [is_active], [is_blocked], [activation_code], [date_created], [security_question], [security_answer], [phone_number], [email_address], [display_name], [picture_url], [obj_type], [created_by], [gender], [date_of_birth]) VALUES (N'somkene', N'lzlD6M6tjdChUP6zQ2pcAg==', N'ORG_CODE_0001', N'0002_AKWA', 1, 0, NULL, CAST(0x0000A649012A8CEC AS DateTime), NULL, NULL, NULL, NULL, N'Maryann Somkene Obialo', N'uploaded_files/user-profile\passport/e4c4f47b-980b-47c0-bb80-4110279fc0d3.JPG', N'SYSCHANNEL', NULL, N'FEMALE', NULL)
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'0d779864-448b-4f44-b445-71a450b119df', N'alfred', N'hr_list_view', N'3', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'1c04865c-0de6-4211-951d-9fd2ed6a9db0', N'somkene', N'crm_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'249a616e-eb69-4ef1-b295-b7f12fa15a57', N'innocent', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'25092b97-c5f9-4a44-baf9-0c0ac0b0074c', N'innocent', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'2d2fff47-4356-490a-913d-56c1c4aa4ff4', N'nonsoval', N'crm_list_view', N'3', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'36245976-23e1-40a1-b789-a1fc3c01457b', N'olivia', N'hr_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'38db1195-6036-42da-9206-aa74d5197356', N'somkene', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'3aeaabc0-1060-4c42-9ac8-754779cb9c88', N'innocent', N'crm_list_view', N'3', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'3f3b7544-8be1-449c-ad53-f31d0f025ed0', N'alfred', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'4a26f1a3-987d-4e7b-bbf2-5096a723be61', N'nonsoval', N'hr_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'59074474-fb88-4ca5-8f5e-f7c538139f89', N'ibestan', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'5d2a0df2-ed55-432b-afa6-4de1c75f6b44', N'alfred', N'crm_list_view', N'3', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'6bfd965e-938a-4edf-8238-7a8c0ea56cac', N'olivia', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'6f31a7fc-dd25-462d-8c43-d1f8e619042b', N'nonsoval', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'76d9fd59-8951-4f29-8bdf-8e1ce52361d4', N'ibestan', N'crm_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'7a11f397-aa73-4104-8bdf-63222aeb7e38', N'ibestan', N'hr_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'84b23f6a-a86c-47e5-924c-2151f3c4930d', N'somkene', N'hr_list_view', N'3', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'8625fbf1-02b6-4b36-a779-71c5fab13ec8', N'olivia', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'86bd38e4-1a60-46f5-af2e-eb8832573534', N'alfred', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'8f41646d-1564-42fc-83da-4e2519d70dc9', N'olivia', N'crm_list_view', N'3', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'906ae324-51f8-4715-ac14-5d9bdf079dcb', N'ibestan', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'992ee312-9ef7-461c-b49f-787fd8736601', N'nonsoval', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'aec67893-f273-4b57-a82f-9d43333995a7', N'olivia', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'b046cc75-6696-483f-b2e4-0ce3fb8197e8', N'innocent', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'b9f26191-b4af-4a56-a892-7e4b388fa862', N'nonsoval', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'bd366745-8238-4b83-a7b8-20c21180d7bc', N'alfred', N'sales_list_view', N'1', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'c528ceeb-f238-4252-8ae0-6d9438ab2ba0', N'ibestan', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'c6cd674c-2ef5-41a4-be37-00155c921c90', N'somkene', N'theme', N'Biafra', N'String')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'e83cbd00-dacb-4b48-bfa5-d3c69b3d20eb', N'somkene', N'inventory_list_view', N'1', N'Integer')
INSERT [dbo].[identity_store_preference] ([id], [user_id], [pref_key], [pref_value], [data_type]) VALUES (N'ee58edb6-bbcf-409b-ae69-c3d0b481322e', N'innocent', N'hr_list_view', N'1', N'Integer')
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'airtel-recharge-card', N'ORG_CODE_0001', N'Airtel Recharge Card', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'brake-shoe', N'ORG_CODE_0001', N'Brake Shoe', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'clothes', N'ORG_CODE_0001', N'Clothes', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'creame', N'ORG_CODE_0001', N'Creame', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'dell-systems', N'ORG_CODE_0001', N'Dell Systems', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'gaskets', N'ORG_CODE_0001', N'Gaskets', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'glo-recharge-card', N'ORG_CODE_0001', N'Glo Recharge Card', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'jewels', N'ORG_CODE_0001', N'Jewels', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'makeup', N'ORG_CODE_0001', N'Makeup', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'misc', N'ORG_CODE_0001', N'Misc', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'motor-oil', N'ORG_CODE_0001', N'Motor Oil', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'mtn-recharge-card', N'ORG_CODE_0001', N'MTN Recharge Card', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'phones', N'ORG_CODE_0001', N'Phones', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'service', N'ORG_CODE_0001', N'Service', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'shoes', N'ORG_CODE_0001', N'Shoes', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'shoprite', N'ORG_CODE_0001', N'Shoprite', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'smart-tvs', N'ORG_CODE_0001', N'Smart TVs', 0, NULL)
INSERT [dbo].[item_category] ([id], [org_id], [name], [is_child], [parent_id]) VALUES (N'watches', N'ORG_CODE_0001', N'Watches', 0, NULL)
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Bag', N'Bag', N'Bag', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Carton', N'Carton', N'Carton', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Dozen', N'Dozen', N'Dozen', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Gallon', N'Gallon', N'Gallon', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Gross', N'Gross', N'Gross', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Kg', N'Kg', N'Kg', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Per', N'Per', N'Per', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Psc', N'Psc', N'Psc', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Sack', N'Sack', N'Sack', N'ORG_CODE_0001')
INSERT [dbo].[item_storage_type] ([id], [unit], [description], [org_id]) VALUES (N'Unit', N'Unit', N'Unit', N'ORG_CODE_0001')
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'0d7d38ac-6c97-4d63-8d85-5d04ed915ad6', N'mac_shower_gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', CAST(10.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66600875AFE AS DateTime), N'alfred', CAST(10.0 AS Decimal(15, 1)), NULL, CAST(13000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'1589c91c-b3ca-4310-9ca3-25c3483bd475', N'889f8b06-a584-43b1-a188-637a0881d571', N'b33c3b2f-5038-409c-9e93-6562b15f1422', CAST(6.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6660086AF20 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(6700.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'298b21a4-c648-4434-a5be-aadcafb9e093', N'EngineOIL', N'engineOil_10Litre_Gallon', CAST(10.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6670143F06D AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(4200.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'32e1ef85-748c-4601-b866-450233678eec', N'889f8b06-a584-43b1-a188-637a0881d571', N'1293a03f-d4c8-4bd6-b217-6c6371c39ea8', CAST(-4.0 AS Decimal(14, 1)), N'SO-3939531', N'SALES', N'Unit Deducted from Sales : ID: SO-3939531', CAST(0x0000A667014467E2 AS DateTime), N'alfred', CAST(12.0 AS Decimal(15, 1)), NULL, CAST(4500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'382e33f9-a5bf-4132-a848-6297004fc716', N'889f8b06-a584-43b1-a188-637a0881d571', N'1293a03f-d4c8-4bd6-b217-6c6371c39ea8', CAST(12.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6660086A72A AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(4500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'40c112b9-055b-440f-8980-00ef4bcfa1ff', N'1200444566', N'2408c82e-8768-4340-a36f-113c1a76e48c', CAST(-2.0 AS Decimal(14, 1)), N'SO-5843700', N'SALES', N'Unit Deducted from Sales : ID: SO-5843700', CAST(0x0000A6660083A6B2 AS DateTime), N'alfred', CAST(5.0 AS Decimal(15, 1)), NULL, CAST(35500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'462ea3ed-86bb-4b07-b083-fdcd0e46f589', N'mac_shower_gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', CAST(-20.0 AS Decimal(14, 1)), N'SO-3939531', N'SALES', N'Unit Deducted from Sales : ID: SO-3939531', CAST(0x0000A667014467E2 AS DateTime), N'alfred', CAST(28.0 AS Decimal(15, 1)), NULL, CAST(13000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'4cb2d5f2-7b5b-41ee-a430-7268e05dbcc0', N'1200444566', N'2408c82e-8768-4340-a36f-113c1a76e48c', CAST(5.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6660082E3B8 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(34500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'548b715e-38ba-4e0b-a149-5c33573ddedf', N'mac_shower_gel', N'adde0111-445a-4398-a00c-94ae827b1562', CAST(12.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66600875CEF AS DateTime), N'alfred', CAST(12.0 AS Decimal(15, 1)), NULL, CAST(1600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'5dc502d8-a960-4018-ad5d-3e0368eb872f', N'mac_shower_gel', N'4e00f283-5f6a-4046-9829-0108f2854389', CAST(10.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66600875906 AS DateTime), N'alfred', CAST(10.0 AS Decimal(15, 1)), NULL, CAST(15500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'5e8ff5c2-23e6-4f40-9ffd-c868de506646', N'mac_shower_gel', N'4e00f283-5f6a-4046-9829-0108f2854389', CAST(20.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66900837D81 AS DateTime), N'alfred', CAST(30.0 AS Decimal(15, 1)), NULL, CAST(15600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'7123fc19-ecc2-4316-b3ce-b1e70a386a51', N'1200444566', N'e422aae7-2c49-4d09-9df1-26a2c6098879', CAST(6.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A669008A6DB1 AS DateTime), N'somkene', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(30000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'7c394162-ce19-4a8d-9f7b-5bdd2d945c47', N'mac_shower_gel', N'adde0111-445a-4398-a00c-94ae827b1562', CAST(12.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A66600875C25 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(1600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'7d0d4663-ee84-461f-ba23-12d99ad36f85', N'889f8b06-a584-43b1-a188-637a0881d571', N'b33c3b2f-5038-409c-9e93-6562b15f1422', CAST(-2.0 AS Decimal(14, 1)), N'SO-1335151', N'SALES', N'Unit Deducted from Sales : ID: SO-1335151', CAST(0x0000A6660087C3B1 AS DateTime), N'alfred', CAST(6.0 AS Decimal(15, 1)), NULL, CAST(6700.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'978aac2d-8936-4153-a5c0-c884b3bde64d', N'mac_shower_gel', N'4e00f283-5f6a-4046-9829-0108f2854389', CAST(10.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A66600875858 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(15500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'986c8654-194b-40e1-a2ca-3ca59eab328a', N'1200444566', N'64c27dc8-efb9-4ac6-af17-41d66d0ade12', CAST(-1.0 AS Decimal(14, 1)), N'SO-5843700', N'SALES', N'Unit Deducted from Sales : ID: SO-5843700', CAST(0x0000A6660083A6B2 AS DateTime), N'alfred', CAST(3.0 AS Decimal(15, 1)), NULL, CAST(45600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'9a7e8a1b-ba40-4fa5-9111-635191bb85d4', N'mac_shower_gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', CAST(10.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A66600875A56 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(13000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'9ef7a6f8-6ebc-4a62-a7c8-e4eed6f68685', N'dell-xps-14-with-5th-gen-intel-core-processor', N'28735284-222e-4b1d-aaa8-d4a85c3a974d', CAST(4.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A669008A4578 AS DateTime), N'somkene', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(170000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'a311348c-27fc-495e-aed1-65220c96d311', N'dell-xps-14-with-5th-gen-intel-core-processor', N'28735284-222e-4b1d-aaa8-d4a85c3a974d', CAST(-1.0 AS Decimal(14, 1)), N'SO-24612', N'SALES', N'Unit Deducted from Sales : ID: SO-24612', CAST(0x0000A669008B5D84 AS DateTime), N'somkene', CAST(4.0 AS Decimal(15, 1)), NULL, CAST(170000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'b40ca217-09c4-4ea0-b317-9693c2f25674', N'1200444566', N'e422aae7-2c49-4d09-9df1-26a2c6098879', CAST(-2.0 AS Decimal(14, 1)), N'SO-24612', N'SALES', N'Unit Deducted from Sales : ID: SO-24612', CAST(0x0000A669008B5D84 AS DateTime), N'somkene', CAST(6.0 AS Decimal(15, 1)), NULL, CAST(30000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'bb234a41-7da1-49c6-9381-edf6ea563a1d', N'1200444566', N'64c27dc8-efb9-4ac6-af17-41d66d0ade12', CAST(3.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6660082E470 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(45600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'c49796dd-50b4-4f7f-b5de-906c129a3d81', N'1200444566', N'01e70aa0-3d18-4a7b-872a-5e0ca288b2c1', CAST(5.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A669008A6C8B AS DateTime), N'somkene', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'cb242618-c721-4491-a24f-d72b36980da4', N'EngineOIL', N'engineOil_25Litre_Gallon', CAST(-6.0 AS Decimal(14, 1)), N'SO-3939531', N'SALES', N'Unit Deducted from Sales : ID: SO-3939531', CAST(0x0000A667014467E2 AS DateTime), N'alfred', CAST(10.0 AS Decimal(15, 1)), NULL, CAST(12700.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'cb728441-c97b-48e4-a3bb-a55081bbceb9', N'mac_shower_gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', CAST(-2.0 AS Decimal(14, 1)), N'SO-1335151', N'SALES', N'Unit Deducted from Sales : ID: SO-1335151', CAST(0x0000A6660087C3B1 AS DateTime), N'alfred', CAST(30.0 AS Decimal(15, 1)), NULL, CAST(13000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'd131bc5e-9d8e-4a45-86c7-bb78abcbef8c', N'mac_shower_gel', N'adde0111-445a-4398-a00c-94ae827b1562', CAST(12.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66600875D68 AS DateTime), N'alfred', CAST(24.0 AS Decimal(15, 1)), NULL, CAST(1600.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'd48b2796-61ad-4d42-b9ec-ddf3420de180', N'mac_shower_gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', CAST(10.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A66600875B99 AS DateTime), N'alfred', CAST(20.0 AS Decimal(15, 1)), NULL, CAST(13000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'd595b0ff-d150-4bcd-bf68-6732585439bf', N'dell-xps-14-with-5th-gen-intel-core-processor', N'c61656f1-56db-43cd-a060-6c51e8f59d66', CAST(3.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A669008A48BA AS DateTime), N'somkene', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(140000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'dbca6fd7-3a4f-4cf9-aab6-902fff61f9e1', N'mac_shower_gel', N'4e00f283-5f6a-4046-9829-0108f2854389', CAST(10.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A666008759B7 AS DateTime), N'alfred', CAST(20.0 AS Decimal(15, 1)), NULL, CAST(15500.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'e8c61713-9e2d-4062-812e-8f4fa2dfe19b', N'dell-xps-14-with-5th-gen-intel-core-processor', N'2898b72d-054d-4673-b334-139653fc822f', CAST(6.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A669008A4743 AS DateTime), N'somkene', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(150000.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'ec17f24d-fd01-4a71-8512-6ca0f5a254ee', N'EngineOIL', N'engineOil_25Litre_Gallon', CAST(10.0 AS Decimal(14, 1)), NULL, N'BEGINNING STOCK', N'Unit Stock Created', CAST(0x0000A6670143F413 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(12700.00 AS Decimal(18, 2)))
INSERT [dbo].[item_unitStock_log] ([id], [item_id], [item_unit_measure_id], [unit], [trans_id], [trans_type], [note], [dateCreated], [createdBy], [prevQty], [unit_on_order], [item_cost]) VALUES (N'f3dbc68c-6771-4ebb-9d27-359540463b0a', N'EngineOIL', N'engineOil_10Litre_Gallon', CAST(10.0 AS Decimal(14, 1)), NULL, N'STOCK ADDED', N'Unit Stock Created', CAST(0x0000A6670143F1C7 AS DateTime), N'alfred', CAST(0.0 AS Decimal(15, 1)), NULL, CAST(4200.00 AS Decimal(18, 2)))
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'BRANCH_ADMIN', N'Has Full access to all Business Channel Activities.', 1, 0, CAST(0x0000A65A013FE59F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'CRM_MANAGER', N'Has Full access to all Customer Record, invoices, purchases event/meetings and lot more.', 1, 0, CAST(0x0000A65A013FEB21 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'GLOBAL_ACCOUNT_MANAGER', N'Manages Financial Accounting Detail of the organization: Create Journals manually, Ledgers, Chart of Accounts, manages Financial reports', 1, 0, CAST(0x0000A65A013FF441 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'HR_MANAGER', N'Has Full access to all Employee Record, Payroll, Activities recruitment etc.', 1, 0, CAST(0x0000A65A013FED58 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'INVENTORY_MANAGER', N'Manages Inventory record, Categories, Costing and Stock etc', 1, 0, CAST(0x0000A65A013FF0C6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'MANAGE_USER_ACCOUNTS', N'Can create and Manage User account in an organization but restricted to assigning critical ROLES to users.', 1, 0, CAST(0x0000A65A013FF924 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'SALES_MANAGER', N'Manages Sales and Purchases of goods and services. can recieve payment and approve transactions.', 1, 0, CAST(0x0000A65A013FEE3F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'SALES_QUEUE', N'Just for Sales Persons who can only create Sales order without receiving money.', 1, 0, CAST(0x0000A65A013FFCA5 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 0, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'SECURITY_MANAGER', N'Has full Access to all Security Settings in the system. Can create and Manage User account and Roles in an organization. can also extend application features with License Extenders, and attach a license for the application', 1, 0, CAST(0x0000A65A013FFA15 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'SIMPLE_ACTION', N'Limited Functionalities: Can make sales, create inventory, accept payments', 1, 0, CAST(0x0000A65A013FFB1F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'SUPER_ADMIN', N'Has Full access to all application Components.', 1, 0, CAST(0x0000A65A013FD6B2 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 1, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_roleDefinition] ([roleName], [roleDescription], [isActive], [IsExpirable], [DateCreated], [ExipiresOn], [IsSystemDefined], [isAdmin], [GroupName]) VALUES (N'WAREHOUSE_MANAGER', N'Manages Company warehouses, also manages stock movement and transfer from various locations.', 1, 0, CAST(0x0000A65A013FF2FF AS DateTime), CAST(0x002D247F018B81FF AS DateTime), 1, 0, N'ORG_CODE_0001')
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'db1b7ab9-574f-46f2-a60c-e381c74e9c2e', N'SUPER_ADMIN', N'CRM_VIEW_DOCUMENTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dcde7fd5-2b5e-498e-99bb-2f00e389e807', N'SUPER_ADMIN', N'TRANSACTIONS_APPROVE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dd0c4532-5f8b-4f0e-bceb-61fa2d43dbdc', N'SUPER_ADMIN', N'AUTHORIZATION_EDIT_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'deced544-da3d-4812-9e98-df8d19078d99', N'SUPER_ADMIN', N'HR_VIEW_EMPLOYEE_ACTIVITY_DETAILS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e3c70577-8f95-4c19-b80d-3c21ab8cb2ad', N'SUPER_ADMIN', N'ACCOUNTING_UI_VIEW_INCOME_STATEMENT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'eab2e4dd-5492-45ac-953a-027609fa3d11', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_TAX_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ee416530-0465-4133-a042-28439e227d47', N'SUPER_ADMIN', N'ACCOUNTING_EDIT_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f22d7f4c-512f-44d4-a6e1-51e7a62cfeb6', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_ISBOUGHT_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f6938eb6-8d77-4c2b-8ced-6e8b94b86cc3', N'SUPER_ADMIN', N'CRM_EDIT_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fa904d04-f66d-47f2-bfdc-6741a584a693', N'SUPER_ADMIN', N'ACCOUNTING_UI_VIEW_LEDGERS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fbd1626f-7cd6-46b0-b02a-03ed7da3e0ce', N'SUPER_ADMIN', N'AUTHORIZATION_MANAGE_SYS_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fc608670-2d14-4d2c-b7fc-28de0268b49d', N'SUPER_ADMIN', N'CRM_VIEW_EVENTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9d65cd99-8ac9-43c6-844f-55620b45b80e', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_TAX_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9dc772c6-7285-4fbc-abe6-8cac59332477', N'BRANCH_ADMIN', N'CRM_VIEW_EVENTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a29dd3da-5f8a-4a98-8e5e-7cebb58ae3ee', N'BRANCH_ADMIN', N'ACCOUNTING_EDIT_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a6b6cfe3-63a1-4df0-bbce-c42e9e224b20', N'BRANCH_ADMIN', N'HR_EDIT_OWN_RECORD', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a6e66d87-03e5-46ea-ba83-3906fe86e9da', N'BRANCH_ADMIN', N'TRANSACTIONS_CREATE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a85aba01-f895-4530-a73d-ab763e0209a9', N'BRANCH_ADMIN', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b2f883d9-e9e9-4110-8fab-095e471bf043', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_DISCOUNT_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b7c29076-281c-4b92-bdbe-675d81749d28', N'BRANCH_ADMIN', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b8153070-786c-4cdd-971d-5a12b8db9b13', N'BRANCH_ADMIN', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'be1559bd-7ad8-43bd-9dae-d5543e1a8b65', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_FORSALE_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ca5ea4ad-a342-407b-82ce-1950f56bc547', N'BRANCH_ADMIN', N'INVENTORY_UI_MANAGE_ACTIVE_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'caa6b028-e696-488c-a1f4-18e19d3108fd', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_QTY_DEDUCTION_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'cd02d537-1532-4b16-bbaa-5ea1dd4974df', N'BRANCH_ADMIN', N'INVENTORY_CREATE_ITEM', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd088e8f9-964a-446e-aa6e-ea6cc7b5e505', N'BRANCH_ADMIN', N'AUTHORIZATION_EDIT_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd30646db-fb75-4490-b0f8-868f72b253fa', N'BRANCH_ADMIN', N'ACCOUNTING_CREATE_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd35c622c-e3fa-475d-ab49-5b9d363c9dcc', N'BRANCH_ADMIN', N'TRANSACTIONS_VIEW_CHANNEL_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd6919295-d125-41d7-9fb1-cb58c4937d46', N'BRANCH_ADMIN', N'CRM_UI_EDIT_PRICE_LEVEL', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd750a762-08ec-4b6e-91b0-1948eb1b4e40', N'BRANCH_ADMIN', N'HR_VIEW_EMPLOYEE_LIST', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'daac8d20-21cc-48b1-80d3-3e70c7188217', N'BRANCH_ADMIN', N'ACCOUNTING_UI_VIEW_TRIBALANCE', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dae7f5b6-0529-4151-90c8-ec28ff30a444', N'BRANCH_ADMIN', N'REMOVE_WAREHOUSE', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ddb10f08-8ac2-43c1-9771-2db2392ed8a0', N'BRANCH_ADMIN', N'MANAGE_WAREHOUSE_STOCK_TRANSFER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dded9c3e-239c-4f2c-879b-e30b9858c5b2', N'BRANCH_ADMIN', N'CRM_DROP_CUSTOMER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dfa29fab-6042-4fe4-8f70-be3019958227', N'BRANCH_ADMIN', N'AUTHORIZATION_DROP_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e7c6fc20-05f0-4ba1-9c13-09424546a37c', N'BRANCH_ADMIN', N'CRM_VIEW_DOCUMENTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e9c54d30-bf27-4058-a151-932b26dce9d8', N'BRANCH_ADMIN', N'CRM_EDIT_DOCUMENTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ed8108a0-9e24-40c1-9190-fe079f07edef', N'BRANCH_ADMIN', N'TRANSACTIONS_APPROVE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ee11ad98-ef91-4cb6-8475-720ea78d1112', N'BRANCH_ADMIN', N'TRANSACTIONS_UI_EDIT_ITEM_AMOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f2e9f876-ac92-41dd-bf2f-67448ca32302', N'BRANCH_ADMIN', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f5facf7c-7dda-481d-98e6-21315aa368df', N'BRANCH_ADMIN', N'TRANSACTIONS_EDIT_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f9b32fbc-f510-422e-a91c-987b62624ada', N'BRANCH_ADMIN', N'INVENTORY_UPDATE_ITEM_STOCK', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fab20b51-8251-404f-9742-1d4324fbb5aa', N'BRANCH_ADMIN', N'CRM_UI_EDIT_CREDIT_LIMIT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fff69f2d-f7eb-4331-be28-8df8361f7498', N'BRANCH_ADMIN', N'AUTHORIZATION_BLOCK_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0a743d57-d3e6-4b04-9d65-24c2d377c1d2', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_DROP_SALES_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0bae12e0-8bc1-4be2-a763-73f6dead22f9', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_EDIT_DOCUMENTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0e11d66b-a832-493b-bc12-8a1a1df05c47', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1b640e1a-425e-431f-a81b-124dfd557a2c', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_VIEW_EVENTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'22cad09c-e8d4-42b7-9859-5ee9ecfd6246', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_EDIT_EVENTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'292e705c-00f2-4eb6-ad7a-cf8d5a4c1b15', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_APPLY_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2c5f9bb1-4d12-4612-b5be-39657c8e489d', N'GLOBAL_ACCOUNT_MANAGER', N'HR_VIEW_OWN_RECORD', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2d1a3879-cf0d-4bdd-a905-a3ec3137d074', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_DROP_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'33b0c89f-a5c0-47bc-81b2-001b4b42a4a0', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_RECIEVE_SALES_PAYMENT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'34ad254d-a209-4bd5-8297-9febec9c22ed', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UPDATE_ITEM_STOCK', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3751c2f3-1bd5-4a43-9434-1eb65a47a11c', N'GLOBAL_ACCOUNT_MANAGER', N'MANAGE_WAREHOUSE_STOCK_TRANSFER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'38780c4d-80b5-4b0b-8a45-c8402716df7f', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_APPROVE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3fd6b268-7f61-4ba6-be78-3d7e8ea44498', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_EDIT_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'40f39f36-b00b-4b94-8c9e-b05b11c4ee73', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_VIEW_ACCOUNTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'449fbd27-f504-45a7-8f88-dc288e2d9b5f', N'GLOBAL_ACCOUNT_MANAGER', N'HR_VIEW_EMPLOYEE_ACTIVITY_DETAILS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4928083d-03fd-4eb6-9e0a-380f860bf805', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_EDIT_ACCOUNTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'497b051f-8573-4b32-b95d-7d6c24f45254', N'GLOBAL_ACCOUNT_MANAGER', N'HR_MANAGE_RECRUITMENT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4dd49ba7-443e-4b1f-9e5a-d11d0401291e', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_QTY_DEDUCTION_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'521fca7a-37bd-4ecd-a8c0-daeb0a4f3a48', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_CREATE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5378aae9-f473-4bea-ae71-adfdfa9c7931', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_CREATE_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'53c3d8a9-c5d6-4926-aa29-2e4914addef1', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_UI_EDIT_CREDIT_LIMIT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'598f398c-1e67-4dee-b7dc-d26fd3e479dd', N'GLOBAL_ACCOUNT_MANAGER', N'HR_EDIT_OWN_RECORD', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5b260f3c-4c59-4125-9a33-29dfbbccf882', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_DISCOUNT_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5d99161a-d5cc-4ed0-88f3-8f399cb56f8f', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_VIEW_CHANNEL_SALES_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'66e5c5b4-d042-44a5-a4b5-9fc2b6178992', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_EDIT_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6a2b8f5d-9081-4ac9-8105-45b72f3c4420', N'GLOBAL_ACCOUNT_MANAGER', N'HR_VIEW_EMPLOYEE_PAY_DETAILS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6a8da1fd-9b1d-4efb-88fd-6f6ce73b36b6', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6bfb0a3b-1eca-4a27-bff3-de30c2df48ee', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6c12a9e3-134e-41be-b1aa-8718a892e361', N'GLOBAL_ACCOUNT_MANAGER', N'HR_CREATE_EMPLOYEE', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7031f226-458c-4fe7-a4f4-ab72677058c5', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_VIEW_LEDGERS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'73b1fe1b-30b5-4036-b572-8b7f05f1a7a8', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'78201d22-1073-4ef3-a153-e8101eb42da8', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_UI_EDIT_PRICE_LEVEL', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7c475fbf-1e74-4d96-a9d2-8a9b31507930', N'GLOBAL_ACCOUNT_MANAGER', N'HR_EDIT_EMPLOYEE', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8026dc45-f006-44a7-acf3-8b59b0278591', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'814659e3-cf05-4577-8872-50dfb051fd74', N'GLOBAL_ACCOUNT_MANAGER', N'ADD_WAREHOUSES', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'892fe6a3-eded-4f20-b395-36c2a4d5f136', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_EDIT_CHARTS_OF_ACC', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'64054b10-4bdf-4e86-8b4b-85f18687315c', N'SECURITY_MANAGER', N'AUTHORIZATION_DROP_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'86ca2f76-4a57-4ff4-aeba-620e71cde120', N'SECURITY_MANAGER', N'AUTHORIZATION_MANAGE_SYS_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8b659ea1-2e06-4b58-878d-480f6586ce28', N'SECURITY_MANAGER', N'LICENSE_EXTEND_APPLICATION_FEATURES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'92b45080-007a-4e8c-9ae9-beeb6a23f1c5', N'SECURITY_MANAGER', N'AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9ccbe860-d5eb-48e5-910e-59f1834807b3', N'SECURITY_MANAGER', N'AUTHORIZATION_BLOCK_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a10caffc-6b27-4a9c-ae94-40a59e4b4365', N'SECURITY_MANAGER', N'AUTHORIZATION_CREATE_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a4b0efeb-b990-4be8-ae33-c7c1f3f693f6', N'SECURITY_MANAGER', N'AUTHORIZATION_ADD_USER_ADMIN_ROLE', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b38aaf81-fdec-48eb-bc22-231c53a3c295', N'SECURITY_MANAGER', N'AUTHORIZATION_EDIT_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'baa5f38e-28e7-4024-81c5-855779ba327b', N'SECURITY_MANAGER', N'LICENSE_ATTACH_APPLICATION_LICENSE', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fdf1191b-6201-4a82-a7e3-88e1d8c1f51a', N'SECURITY_MANAGER', N'AUTHORIZATION_CREATE_USERS', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'05147083-3e48-47e1-b3bb-ae5631184f13', N'SIMPLE_ACTION', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0cd2d136-de8c-4cc1-bb51-a5aeecc859e5', N'SIMPLE_ACTION', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'181a54a2-8321-4e56-bdb5-8b163a6d77fb', N'SIMPLE_ACTION', N'TRANSACTIONS_EDIT_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'32875a20-64c1-4742-ab9c-0927b7b12eda', N'SIMPLE_ACTION', N'TRANSACTIONS_RECIEVE_SALES_PAYMENT', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4ddeeaa9-3081-4230-b384-cb59a7b96eff', N'SIMPLE_ACTION', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'553d0345-28be-44a0-8cc1-6a0bc912754d', N'SIMPLE_ACTION', N'AUTHORIZATION_EDIT_OWN_ACCOUNT', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'58feb9f1-5fc8-4733-ac46-02bd1d72f1d7', N'SIMPLE_ACTION', N'HR_VIEW_OWN_RECORD', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'632d2784-cccd-4be0-8b41-79e2a223cb70', N'SIMPLE_ACTION', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'658a645f-6931-4314-ae4f-eb600ffc53ef', N'SIMPLE_ACTION', N'HR_EDIT_OWN_RECORD', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'662dba9e-fc40-4ba0-b17b-f5037f9f780b', N'SIMPLE_ACTION', N'INVENTORY_DROP_ITEM', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
GO
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'67d5df87-23b6-4e17-a769-9919b14bad99', N'SIMPLE_ACTION', N'INVENTORY_UI_EDIT_ITEM_DISCOUNT_OPTION', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6fa0757e-f20b-4032-9f9b-2c19a4b7a670', N'SIMPLE_ACTION', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'72e5a345-06aa-4ef1-9576-5cea0024ad68', N'SIMPLE_ACTION', N'INVENTORY_DROP_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ac82c57a-cebd-4993-81c1-a4f9d7bcd034', N'SIMPLE_ACTION', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b01407d1-4f1e-45a3-b56b-842327d001a0', N'SIMPLE_ACTION', N'CRM_EDIT_CUSTOMER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'bd077869-9db0-415b-beea-87ce19c36806', N'SIMPLE_ACTION', N'CRM_DROP_CUSTOMER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'be630057-77f0-41df-a80f-d74011eb6a13', N'SIMPLE_ACTION', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c2ce19fa-bdb3-4510-a5cf-1f15fb1614b8', N'SIMPLE_ACTION', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'cda093d2-1d39-45da-acb8-ad66c6ceb692', N'SIMPLE_ACTION', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dff707e0-519c-4ded-a2d2-f950d857cc18', N'SIMPLE_ACTION', N'TRANSACTIONS_CREATE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f5e636c1-4f77-4d9a-beb8-6b373104c80e', N'SIMPLE_ACTION', N'INVENTORY_CREATE_ITEM', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f693458b-73fa-4161-b28a-8df08e197474', N'SIMPLE_ACTION', N'TRANSACTIONS_DROP_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'fe27609a-ffdd-4ffa-a288-83633e627e8d', N'SIMPLE_ACTION', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FFBF4 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'28f36ca9-2b75-4301-a306-ba4b13f4677f', N'SALES_QUEUE', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FFCC1 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c5b06256-9641-48ff-a330-8a333744ec03', N'SALES_QUEUE', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FFCC1 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e19b5c4b-0caf-4339-903c-26b2b30a57d4', N'SALES_QUEUE', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FFCC1 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ef04570d-afab-496c-88ef-dceb84561fce', N'SALES_QUEUE', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FFCC1 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'051b6b02-3349-472e-a818-6bd2cf7b1422', N'BRANCH_ADMIN', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'095e1e4e-82c5-46de-900e-8f3be469a4ca', N'BRANCH_ADMIN', N'MANAGE_WAREHOUSE_STOCK_DOCUMENT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0b63b823-e955-44ab-8b74-a929c244f77b', N'BRANCH_ADMIN', N'CRM_VIEW_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0d62f84c-25a9-42f4-9b73-2886931b0cfe', N'BRANCH_ADMIN', N'AUTHORIZATION_EDIT_OWN_ACCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1213d3b4-b6fa-4d59-b435-98de2f7aba7d', N'BRANCH_ADMIN', N'AUTHORIZATION_VIEW_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'15714a54-9942-420a-94fb-395d681ff2d4', N'BRANCH_ADMIN', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1ea12bbe-ad54-46e3-9057-836f2b3c30d7', N'BRANCH_ADMIN', N'ACCOUNTING_EDIT_CHARTS_OF_ACC', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'207b8afa-3285-4ae0-9a1e-81bd13328980', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_STOCKABLE_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'212726b6-364f-4aea-85b5-8ba10db4e4b8', N'BRANCH_ADMIN', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2ae633bc-5e63-4c2a-8f04-7a9bd4ba9bba', N'BRANCH_ADMIN', N'ACCOUNTING_UI_VIEW_ACCOUNT_DETAILS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'37335c6b-2991-4c3b-9751-ef017ac69f28', N'BRANCH_ADMIN', N'TRANSACTIONS_APPROVE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3b30132e-9942-4a59-bab1-d2f225751232', N'BRANCH_ADMIN', N'AUTHORIZATION_ADD_USERS_ROLE', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3e728ac7-c893-44e9-810b-a6d882faa662', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_COST', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4096c27d-5963-4d7e-bbea-38ceee805a8b', N'BRANCH_ADMIN', N'CRM_EDIT_EVENTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'470f029c-97e9-4019-b41a-192f57b6f6ee', N'BRANCH_ADMIN', N'EDIT_WAREHOUSES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4ab8b1dc-13cf-45ec-90a2-72e43ce857f8', N'BRANCH_ADMIN', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4adfda9d-9ec5-4264-b42b-9f01e87527c6', N'BRANCH_ADMIN', N'TRANSACTIONS_RECIEVE_SALES_PAYMENT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'562b6fc8-bfe5-41cf-8bf1-ca050f429023', N'BRANCH_ADMIN', N'TRANSACTIONS_DROP_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'58be40cb-9014-44c1-be68-bb615bf83724', N'BRANCH_ADMIN', N'TRANSACTIONS_CREATE_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5b9cf379-af6a-4834-a2e8-ffcaa3ad1af9', N'BRANCH_ADMIN', N'INVENTORY_DROP_CATEGORY', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'627bc09a-085c-460d-ae4e-7dac399dda3c', N'BRANCH_ADMIN', N'HR_VIEW_OWN_RECORD', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'674f2441-a321-466e-9914-008d486072e3', N'BRANCH_ADMIN', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6a48ae22-ed7e-4d1f-9ef3-f06a2c3583ba', N'BRANCH_ADMIN', N'ACCOUNTING_UI_VIEW_LEDGERS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6e4196bd-5773-423b-b5b6-2513c5f29fc3', N'BRANCH_ADMIN', N'INVENTORY_UI_EDIT_ITEM_ISBOUGHT_OPTION', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'73815de3-241e-442b-8cae-ae066f655e0a', N'BRANCH_ADMIN', N'CRM_VIEW_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'74c9e948-1aa2-4a87-96b4-d1e5cb937ea8', N'BRANCH_ADMIN', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7681c18f-1690-4c7e-a5c3-b5fde1866176', N'BRANCH_ADMIN', N'ADD_WAREHOUSES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7e419354-bc9d-4c46-93b4-bb97661c8ffb', N'BRANCH_ADMIN', N'CRM_EDIT_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'810acbe7-cbed-4ed4-b4d1-09be5b2bf1f7', N'BRANCH_ADMIN', N'CRM_EDIT_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8620f5bd-e45c-4d8c-af91-cfe1320969fc', N'BRANCH_ADMIN', N'CRM_EDIT_CUSTOMER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'893fdc37-4e42-4e6b-8052-1b5cca0ba397', N'BRANCH_ADMIN', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8a501c74-1360-46e9-880f-d7480e853713', N'BRANCH_ADMIN', N'TRANSACTIONS_DROP_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8bfecb13-1d6f-4682-9182-b7cca1788f29', N'BRANCH_ADMIN', N'ACCOUNTING_CREATE_NEW_ACCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8c3fd8fa-a4e2-4fde-9c90-4efeb00a51da', N'BRANCH_ADMIN', N'TRANSACTIONS_DROP_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8d913339-8b39-4a9e-b9c2-78ba21c870da', N'BRANCH_ADMIN', N'TRANSACTIONS_APPLY_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'90bf7836-20dc-42d9-8537-cdc27445e905', N'BRANCH_ADMIN', N'ACCOUNTING_UI_VIEW_INCOME_STATEMENT', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9190e4d9-b45e-4d62-9e83-d4b904497237', N'BRANCH_ADMIN', N'INVENTORY_UI_VIEW_ITEM_COST', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'93b1eb76-c21a-4267-9a35-de42d1a2abb2', N'BRANCH_ADMIN', N'INVENTORY_DROP_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'99df9b25-d86a-46b8-8a6c-2c5a7383cdce', N'BRANCH_ADMIN', N'ACCOUNTING_UI_VIEW_BALANCE_SHEET', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9b46a9af-a229-4745-b806-dac1dfa23c5f', N'BRANCH_ADMIN', N'AUTHORIZATION_CREATE_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9b7d63e2-aa8c-4617-9ec9-c55688e036d1', N'BRANCH_ADMIN', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9bd2719d-5559-4834-8cb1-3cf45a786ec0', N'BRANCH_ADMIN', N'AUTHORIZATION_VIEW_SYS_ROLES', 1, 0, CAST(0x0000A65A013FE85A AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'04840d2c-f200-4e8a-93e3-9e465626a7f3', N'CRM_MANAGER', N'ACCOUNTING_UI_VIEW_ACCOUNT_DETAILS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0e0c7c5a-e8c3-4f6b-93ff-2004c418eddc', N'CRM_MANAGER', N'CRM_EDIT_CUSTOMER', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'10371e66-ab2e-4c91-9361-b1dcab6aa897', N'CRM_MANAGER', N'CRM_EDIT_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1397174d-3955-4792-ad01-27569f06931d', N'CRM_MANAGER', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'22e92af0-48d5-45e0-b681-28676c2cd091', N'CRM_MANAGER', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2cd46749-3fe0-4516-9a87-b68c909a7f6a', N'CRM_MANAGER', N'ACCOUNTING_CREATE_NEW_ACCOUNT', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3882804b-ce3e-47a6-a54f-1b01a83af0f4', N'CRM_MANAGER', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3b890084-3859-44fc-ba81-b91c7a471ad5', N'CRM_MANAGER', N'CRM_VIEW_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3ca615d9-4517-43b2-8bb4-462acabb18a1', N'CRM_MANAGER', N'CRM_DROP_CUSTOMER', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7939e971-4c73-4221-8bb6-6ebde33ac39c', N'CRM_MANAGER', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'815f1a44-b8f6-4e44-9a8c-d950c13e3a08', N'CRM_MANAGER', N'CRM_UI_EDIT_PRICE_LEVEL', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'859310be-cb2c-47dc-a39d-05b9fa8b95eb', N'CRM_MANAGER', N'CRM_EDIT_DOCUMENTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8be69dfa-d289-42e6-8626-8cc80f724789', N'CRM_MANAGER', N'CRM_VIEW_ACCOUNTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9a3789b6-9fc8-4424-9271-5b12a7c333b8', N'CRM_MANAGER', N'CRM_UI_EDIT_CREDIT_LIMIT', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a0f0f014-759f-4d04-bcb4-fa6a00bc94a4', N'CRM_MANAGER', N'CRM_EDIT_EVENTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ae9abece-02a2-498a-8ae3-7b5ca2758195', N'CRM_MANAGER', N'CRM_VIEW_DOCUMENTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c7ac8807-8215-4954-baff-91f1cb6933dc', N'CRM_MANAGER', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd6c34fcb-0104-4b23-829b-b7e365288f09', N'CRM_MANAGER', N'CRM_EDIT_ACCOUNTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e03fb1a8-c5ce-4d4d-aa4f-b56a98af86aa', N'CRM_MANAGER', N'CRM_VIEW_EVENTS', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f0ba6b93-898b-40f4-9ef3-221f8c0c3269', N'CRM_MANAGER', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FEBDE AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0639def5-1ba1-4518-a070-e0a8e6ef820b', N'HR_MANAGER', N'HR_DROP_EMPLOYEE', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'11380e4c-9404-436f-967b-7e9688873305', N'HR_MANAGER', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'19fe9b3d-470c-4e0a-8f3b-2e620d473234', N'HR_MANAGER', N'HR_VIEW_EMPLOYEE_LIST', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'65aadb60-25da-4dce-aad0-ea9d83a2a67b', N'HR_MANAGER', N'HR_EDIT_EMPLOYEE', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'67e808f7-0861-4268-ae8e-0416cfdba88f', N'HR_MANAGER', N'HR_VIEW_OWN_RECORD', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6d3fe88d-98fd-4252-8d61-8d34350529e1', N'HR_MANAGER', N'ACCOUNTING_CREATE_NEW_ACCOUNT', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7184a904-351d-4ee7-94e6-e3bda60a4ad3', N'HR_MANAGER', N'ACCOUNTING_UI_VIEW_ACCOUNT_DETAILS', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7c8d8ab9-5f13-49f0-bcb5-3c648435d34b', N'HR_MANAGER', N'HR_CREATE_EMPLOYEE', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7e5b4bfe-2a28-473b-919b-6d48b707f23a', N'HR_MANAGER', N'HR_MANAGE_PAYROLL', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'961ed350-b054-4bfd-9743-25c903128be3', N'HR_MANAGER', N'HR_VIEW_EMPLOYEE_ACTIVITY_DETAILS', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b381bcbb-1ea0-4a50-aaeb-9f180fc6cfc8', N'HR_MANAGER', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd1714e86-6c51-4a82-a915-d42bd79a60eb', N'HR_MANAGER', N'HR_MANAGE_RECRUITMENT', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd842cda7-8f24-4ae7-b7d4-486298754757', N'HR_MANAGER', N'HR_VIEW_EMPLOYEE_PAY_DETAILS', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dd1d30c4-6943-4b8e-9de3-1d3cd2858410', N'HR_MANAGER', N'HR_EDIT_OWN_RECORD', 1, 0, CAST(0x0000A65A013FEDCD AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd1e62a7f-5607-4b3c-a12c-268e4844692f', N'SALES_MANAGER', N'CRM_UI_EDIT_CREDIT_LIMIT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dc6ce3f6-bbc9-42cd-8c89-78b5d496cce3', N'SALES_MANAGER', N'CRM_UI_EDIT_PRICE_LEVEL', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ddf93ea8-b409-4e0e-995f-e82fdfaf63dc', N'SALES_MANAGER', N'TRANSACTIONS_DROP_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'df009b5e-1ca8-494d-b73e-42c25615135e', N'SALES_MANAGER', N'TRANSACTIONS_EDIT_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e5ad784c-2754-484f-b929-668e9929c9d4', N'SALES_MANAGER', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e806eede-a1f5-4ce9-88e4-2c9f8ab4c972', N'SALES_MANAGER', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f032ab0a-5b51-4910-956a-c660fbeaff9e', N'SALES_MANAGER', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
GO
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3704759c-1a19-4b2a-9fe8-13429b528a0f', N'INVENTORY_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'41c0001c-f47d-4659-ae11-c70deeedfbf5', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_STOCKABLE_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'45437778-6479-46be-9874-195227c9660c', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_FORSALE_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5642cc70-058b-4430-9aa5-2aee0dfa9b3e', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_ISBOUGHT_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'57c241f7-3a97-4e76-90cf-fc272bdfd256', N'INVENTORY_MANAGER', N'INVENTORY_DROP_ITEM', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5cfacfcd-0386-4ea9-9a20-55bd48de8b37', N'INVENTORY_MANAGER', N'INVENTORY_DROP_CATEGORY', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6887d495-5543-4b7d-a889-e9103a6d69f1', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_DISCOUNT_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6cce439c-355a-4daf-93b5-afa52a58c9e9', N'INVENTORY_MANAGER', N'INVENTORY_CREATE_ITEM', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7a8a8585-c510-4acd-ae2e-6e7f6e8b94f5', N'INVENTORY_MANAGER', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'850ab066-c972-49a6-b4db-05f8d7ad7fec', N'INVENTORY_MANAGER', N'MANAGE_WAREHOUSE_STOCK_DOCUMENT', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'96c51b34-07f2-4576-8f85-f1fc23beea02', N'INVENTORY_MANAGER', N'INVENTORY_DROP_ALL_ITEMS', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b7333ba6-a317-4ee5-9350-42897a85013d', N'INVENTORY_MANAGER', N'MANAGE_WAREHOUSE_STOCK_TRANSFER', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b8cb6db5-9c06-4dd9-9ff8-ad46a28ecb38', N'INVENTORY_MANAGER', N'INVENTORY_UI_MANAGE_ACTIVE_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ba31c7b2-99cd-4686-afba-6e1b5e3980d6', N'INVENTORY_MANAGER', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c9b131d5-e671-497e-b925-17b4a708bcea', N'INVENTORY_MANAGER', N'INVENTORY_DROP_ALL_CATEGORY', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd4744cf0-7142-4a0b-b302-202df621db09', N'INVENTORY_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'daf01631-bfc1-46ee-84f4-c0f244170423', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_TAX_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dbd99a96-9452-4102-8b8d-3bf287db44dd', N'INVENTORY_MANAGER', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e3070c08-9565-4654-b2b1-ae285d0850f5', N'INVENTORY_MANAGER', N'INVENTORY_UI_VIEW_ITEM_COST', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'021c6be5-22f7-44e3-afe9-8d8f97f119ca', N'SALES_MANAGER', N'CRM_VIEW_DOCUMENTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1a643eec-ccfa-4dda-8c63-31f4495a99da', N'SALES_MANAGER', N'CRM_EDIT_EVENTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2d510cf5-c53f-475e-93f8-8ea525748461', N'SALES_MANAGER', N'TRANSACTIONS_UI_EDIT_ITEM_AMOUNT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'32c41426-4632-4b87-a593-c5df6e0aebe6', N'SALES_MANAGER', N'CRM_VIEW_ACCOUNTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3c78f786-d48c-4584-8169-4700547deeae', N'SALES_MANAGER', N'TRANSACTIONS_DROP_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'41e43963-18ed-4638-a705-7e7cb5ff9fff', N'SALES_MANAGER', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'453caba5-855a-48a3-920c-8d07c4f163c6', N'SALES_MANAGER', N'TRANSACTIONS_APPLY_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4e346353-75e3-4a46-bfd4-fb97407ad114', N'SALES_MANAGER', N'CRM_EDIT_DOCUMENTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4f680880-4440-4dbf-91d7-521e41436f57', N'SALES_MANAGER', N'CRM_EDIT_ACCOUNTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5605c520-16bb-47c5-bb22-d9bbfeb3b90f', N'SALES_MANAGER', N'TRANSACTIONS_DROP_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'57794d45-f76c-4d3d-9b3d-de3a5f2d44df', N'SALES_MANAGER', N'CRM_VIEW_EVENTS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5bd742d9-0dff-4c24-b3d0-88469d529cc8', N'SALES_MANAGER', N'TRANSACTIONS_CREATE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5f5eb229-bd48-4ade-8f31-95ea79db2461', N'SALES_MANAGER', N'ACCOUNTING_UI_VIEW_LEDGERS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6b5b3b9e-5486-4bd7-a351-11ace068aa56', N'SALES_MANAGER', N'CRM_VIEW_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6c9f6543-c10d-4b08-9167-029b6e5e0d07', N'SALES_MANAGER', N'TRANSACTIONS_APPROVE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6f212f51-4122-4f02-a51c-bd6705eba257', N'SALES_MANAGER', N'CRM_EDIT_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7a7d17cb-a2d4-4e88-b24f-6f1d12ae74f4', N'SALES_MANAGER', N'TRANSACTIONS_APPROVE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'97381e48-9279-4e1a-ad60-32e8122173f4', N'SALES_MANAGER', N'TRANSACTIONS_RECIEVE_SALES_PAYMENT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a8b5cdd4-2f04-442d-9030-2b9d05bd515a', N'SALES_MANAGER', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ac859052-f1ee-4b19-a060-6fccc4f307fc', N'SALES_MANAGER', N'TRANSACTIONS_CREATE_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'afae291e-060f-428d-b7b2-cab6c3a9f090', N'SALES_MANAGER', N'TRANSACTIONS_VIEW_CHANNEL_SALES_ORDER', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'bdb18a32-67b1-435d-9463-24bce508fcad', N'SALES_MANAGER', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FEF4F AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0e1a9bc2-faf6-4a9b-a440-5077a2eca554', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_QTY_DEDUCTION_OPTION', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'120ef49a-284b-46b0-ba58-77a9b9762ac4', N'INVENTORY_MANAGER', N'INVENTORY_UI_EDIT_ITEM_COST', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2629ae77-ed8e-4b50-bb3b-2ad231534917', N'INVENTORY_MANAGER', N'INVENTORY_DROP_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2ec7b09e-e3c8-4f62-84d9-82ee52ecc349', N'INVENTORY_MANAGER', N'INVENTORY_UPDATE_ITEM_STOCK', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'355cb141-c5b4-421d-b550-3e19aa09f60e', N'INVENTORY_MANAGER', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FF1AA AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'04289db8-fd7a-46dd-92ce-e4a7f229e62a', N'WAREHOUSE_MANAGER', N'INVENTORY_DROP_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0ac1aee2-547d-4ec7-a458-4ff457c7bb40', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_MANAGE_ACTIVE_OPTION', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'27a52a49-f5e4-41ff-89ec-7d597bd87ef6', N'WAREHOUSE_MANAGER', N'EDIT_WAREHOUSES', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'313a78f9-4cf3-4a85-910f-25ba137a13a3', N'WAREHOUSE_MANAGER', N'INVENTORY_CREATE_ITEM', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'38eed87c-5ae3-4f5e-9470-0f9d4ae18587', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'40578a92-16c6-4aff-9bd8-b9c3e965d1bc', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'48ab047e-3f19-42bf-908b-6332aeb16599', N'WAREHOUSE_MANAGER', N'MANAGE_WAREHOUSE_STOCK_DOCUMENT', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5674675e-1f64-4488-94ec-4b9b7e57366c', N'WAREHOUSE_MANAGER', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'66b32641-7adb-4031-a458-d3c3b782cc6d', N'WAREHOUSE_MANAGER', N'INVENTORY_DROP_CATEGORY', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6d8d8c56-1644-4a9f-80d1-1e710f3232aa', N'WAREHOUSE_MANAGER', N'INVENTORY_DROP_ALL_CATEGORY', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'794aae56-f311-49f6-9dc3-aeac97f4ab00', N'WAREHOUSE_MANAGER', N'INVENTORY_DROP_ITEM', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8ee190b7-ad6e-4719-8887-ae9cbec86c7f', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'913a9e16-765a-4a44-bbee-164623b2fe70', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_EDIT_ITEM_STOCKABLE_OPTION', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'94246df8-8d83-4116-931b-d42d958b8692', N'WAREHOUSE_MANAGER', N'MANAGE_WAREHOUSE_STOCK_TRANSFER', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a4250ba2-a912-4163-9af9-5974044b6cca', N'WAREHOUSE_MANAGER', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b309d980-1b5c-4634-affe-78b923d0feca', N'WAREHOUSE_MANAGER', N'INVENTORY_UPDATE_ITEM_STOCK', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b3cb0a25-65ed-479b-a917-ea03faed868b', N'WAREHOUSE_MANAGER', N'REMOVE_WAREHOUSE', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c01c475c-2088-47a4-88b9-f50cff48d221', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_VIEW_ITEM_COST', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c9e22c55-abb8-4a67-8044-066e487b2f84', N'WAREHOUSE_MANAGER', N'INVENTORY_DROP_ALL_ITEMS', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd98b9ee5-e507-4071-8da3-52faccc9d0ef', N'WAREHOUSE_MANAGER', N'INVENTORY_UI_EDIT_ITEM_ISBOUGHT_OPTION', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dd384519-2202-4d07-bea3-d58b44bbda34', N'WAREHOUSE_MANAGER', N'ADD_WAREHOUSES', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e77ff49f-d533-4079-818d-a7963633d7c6', N'WAREHOUSE_MANAGER', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FF387 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8ce074de-2bd5-4e13-baca-c05e8202136a', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_ISBOUGHT_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8d67ea16-0948-4041-b797-00e96241eb52', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_CREATE_NEW_ACCOUNT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'93052d70-88b7-4d45-9c92-3ffefbff97c0', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_CREATE_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9308d21a-9623-4297-9ef6-bd56511dd283', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'943432e5-03eb-49f2-acec-e7a547a607ef', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'94f255dc-a8b6-476e-ae34-58e2eed7d6fb', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_VIEW_ITEM_COST', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'95c07033-f6c3-494f-b7be-36ff3d2acb11', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_VIEW_BALANCE_SHEET', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a7d587ef-ced4-4cb3-9fb3-25fb57e57640', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_VIEW_TRIBALANCE', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a9289a78-5f13-4c0b-a0ec-66209f57ac35', N'GLOBAL_ACCOUNT_MANAGER', N'HR_VIEW_EMPLOYEE_LIST', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ace2d364-71e4-4cd7-921a-8181ead28d07', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ad663f1d-71fa-4b05-bb92-a0d0b6c133b0', N'GLOBAL_ACCOUNT_MANAGER', N'HR_MANAGE_PAYROLL', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b1053ce3-c935-4e02-9592-3d46865b3834', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_FORSALE_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b2253320-4112-4b6f-abb0-e3cc51ef2202', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_TAX_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b8005820-36b4-4c8e-832a-0de364b516e5', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_VIEW_DOCUMENTS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b914c36b-942a-4050-a10b-a4275b82fbd2', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_VIEW_ACCOUNT_DETAILS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c3bfaa89-0869-442e-a838-3cfc260e2b4c', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_APPROVE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c471d722-85d8-4a26-ac9a-0d9ffcdc21ac', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_MANAGE_ACTIVE_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'cc3935c9-4cb3-4ace-a142-2f46d7ac1f64', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ce5d6612-2e7b-4ed0-bed7-c62dd23b4b24', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'cf73bfce-afce-413a-a4e9-c26388104a47', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd3bcea0b-278d-42a0-901b-d590234f4c89', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd698ca3e-ad1a-4a84-9896-22b577e476be', N'GLOBAL_ACCOUNT_MANAGER', N'MANAGE_WAREHOUSE_STOCK_DOCUMENT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'dacdb292-65ba-4fe6-afb2-caae1ec28a12', N'GLOBAL_ACCOUNT_MANAGER', N'INVENTORY_UI_EDIT_ITEM_STOCKABLE_OPTION', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e11ef717-8d9c-471c-b211-f7cf762fa746', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_EDIT_CUSTOMER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e2b79628-c390-4e75-9d44-968d7a92864d', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_DROP_CUSTOMER', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e372f5c3-a970-478d-81a0-daca553c8350', N'GLOBAL_ACCOUNT_MANAGER', N'ACCOUNTING_UI_VIEW_INCOME_STATEMENT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e41e628e-fe56-4eca-a3c5-e552f2c0d27a', N'GLOBAL_ACCOUNT_MANAGER', N'EDIT_WAREHOUSES', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e8a62fc7-3944-4daa-9fb1-a3cace927524', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_EDIT_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ec295bfa-a6d2-426e-81af-fe1359ede799', N'GLOBAL_ACCOUNT_MANAGER', N'REMOVE_WAREHOUSE', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f0812993-dd81-4413-9365-209cf41d752d', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_DROP_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f2be12a4-a2d0-4753-8860-319d981d38e7', N'GLOBAL_ACCOUNT_MANAGER', N'CRM_VIEW_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'f5421399-7951-4a05-b6e8-006c2fc184c2', N'GLOBAL_ACCOUNT_MANAGER', N'TRANSACTIONS_UI_EDIT_ITEM_AMOUNT', 1, 0, CAST(0x0000A65A013FF676 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
GO
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'099e63e7-79ca-40cd-b3ae-a155bb987c5b', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_VIEW_SYS_ROLES', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'266b2e52-55ea-4180-9bd9-1edf49791b28', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_EDIT_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'346cafea-c4ae-480f-ad0e-21bea2b92189', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_ADD_USER_ADMIN_ROLE', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'34e6f869-3d10-4c37-a736-f626f1d97848', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_EDIT_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'587c9550-20f6-4036-ab9c-1441d53c37c6', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_CREATE_USERS', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'94f2d2ae-8f45-42c2-b1f3-b8bb13837389', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_ADD_USERS_ROLE', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9705a80c-62e0-40d5-8856-cf3ef7ba2af7', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_VIEW_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a489ff46-e052-4433-9de1-dc964b7bec07', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_BLOCK_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'ac8ca686-4d9c-41e6-a854-5c38da768b6e', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_EDIT_OWN_ACCOUNT', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'bdea1e76-0f1c-4d9b-b48f-1c8a63d8f235', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_CREATE_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd1d49c36-9f93-4466-b329-e8dd3100b1be', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_DROP_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'e15baf6d-832d-4a7e-8faa-58c168ada268', N'MANAGE_USER_ACCOUNTS', N'AUTHORIZATION_DROP_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FF9A6 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0603a00f-0dbb-4e87-a182-5937d65737d8', N'SECURITY_MANAGER', N'AUTHORIZATION_EDIT_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0ab905ea-fd3f-4f77-aa68-0ac4c609a189', N'SECURITY_MANAGER', N'AUTHORIZATION_VIEW_SYS_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'10692875-3fc9-4b96-8f5a-70d064204d8f', N'SECURITY_MANAGER', N'AUTHORIZATION_EDIT_OWN_ACCOUNT', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'12160a27-30cd-4445-a1cb-a5402ea94d0d', N'SECURITY_MANAGER', N'AUTHORIZATION_VIEW_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'499ce7bf-028d-478d-8498-91614cc2f38f', N'SECURITY_MANAGER', N'AUTHORIZATION_ADD_USERS_ROLE', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5d082292-1e75-469f-8fd2-c03e483a4d66', N'SECURITY_MANAGER', N'AUTHORIZATION_DROP_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FFA8D AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'752fe3fb-9fe0-4016-9eac-f217fb72f2d1', N'SUPER_ADMIN', N'AUTHORIZATION_EDIT_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'758ef0f5-8250-48af-a0f5-1c1b3c049b5a', N'SUPER_ADMIN', N'AUTHORIZATION_ADD_USER_ADMIN_ROLE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'76a4528d-40a3-4e0a-a68c-ea956fe9933e', N'SUPER_ADMIN', N'HR_MANAGE_RECRUITMENT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'76b38c6b-27d4-4040-b07c-7fff839c2c2d', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_COST', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'772678d7-8dd7-4fd5-84ee-e1d1145378a9', N'SUPER_ADMIN', N'CRM_EDIT_EVENTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'78831ad5-d86f-4d1b-8798-00e9d3ea2586', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_QTY_DEDUCTION_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7910a52e-a5c0-4cd1-b8c5-1dcd8d164a3c', N'SUPER_ADMIN', N'TRANSACTIONS_APPROVE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7a7d96dc-b54f-4464-b343-f01ee6ce94e6', N'SUPER_ADMIN', N'INVENTORY_GET_ITEMS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7ae993b9-204b-4f97-869a-069939fa76d5', N'SUPER_ADMIN', N'INVENTORY_UI_VIEW_ITEM_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'7e51c3a5-a3a9-410f-a8f0-8ea7052c2175', N'SUPER_ADMIN', N'TRANSACTIONS_UI_EDIT_ITEM_AMOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'802907be-9dae-4610-a79a-221b4b9615fe', N'SUPER_ADMIN', N'LICENSE_EXTEND_APPLICATION_FEATURES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'83ccfb33-707c-4425-b9ab-8eadad72cb35', N'SUPER_ADMIN', N'CRM_DROP_CUSTOMER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'863e4916-f764-4497-b551-cdccbaef733e', N'SUPER_ADMIN', N'AUTHORIZATION_DROP_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8689fe50-5d49-47ed-bc4e-93aac9f1c118', N'SUPER_ADMIN', N'HR_MANAGE_PAYROLL', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'899d4437-0cfc-43eb-9071-f6a2eb05189d', N'SUPER_ADMIN', N'TRANSACTIONS_CREATE_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8b19c064-3d6a-461d-ac98-0499c8e5dcc4', N'SUPER_ADMIN', N'INVENTORY_UI_VIEW_ITEM_COST', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8b808569-314b-4aa5-93bf-95ddef464179', N'SUPER_ADMIN', N'INVENTORY_UPDATE_ITEM', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'8c155fa3-72d0-46d2-968c-ef232243df58', N'SUPER_ADMIN', N'LICENSE_ATTACH_APPLICATION_LICENSE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'90d43c69-8a00-4499-8a48-dbcee9110e46', N'SUPER_ADMIN', N'AUTHORIZATION_ADD_USERS_ROLE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'966a67df-e8ad-4ea2-8c07-8bf605591ad0', N'SUPER_ADMIN', N'TRANSACTIONS_DROP_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'996e33f2-04a5-47ca-afe0-84ac670ce9fd', N'SUPER_ADMIN', N'REMOVE_WAREHOUSE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'998b2211-db95-436c-8820-3b88ee2381cc', N'SUPER_ADMIN', N'EDIT_WAREHOUSES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9c5e2978-fe32-4fb4-b93d-96ee0db54e13', N'SUPER_ADMIN', N'ACCOUNTING_UI_VIEW_TRIBALANCE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9d248539-d3ba-4015-9360-b410a449ccb2', N'SUPER_ADMIN', N'AUTHORIZATION_DROP_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'9e2b62c2-dad6-4a22-a5bc-dbe73d87d146', N'SUPER_ADMIN', N'TRANSACTIONS_CREATE_CUSTOMER_BASIC_DATA', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a0eaad9d-2cd7-4f49-af82-bdefb5779992', N'SUPER_ADMIN', N'TRANSACTIONS_VIEW_CHANNEL_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a25024fb-f4fc-4748-a181-66cd0e699c2f', N'SUPER_ADMIN', N'ACCOUNTING_UI_VIEW_ACCOUNT_DETAILS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a380239e-84ed-4b9f-8803-5f76808ba750', N'SUPER_ADMIN', N'TRANSACTIONS_CREATE_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a5e769b4-b856-463d-a021-ad4857d65c2d', N'SUPER_ADMIN', N'MANAGE_WAREHOUSE_STOCK_TRANSFER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a81b2e6e-838c-4002-9f96-6455b98fefe9', N'SUPER_ADMIN', N'INVENTORY_DROP_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'a81fbfd7-1af0-4730-922e-408c77423c83', N'SUPER_ADMIN', N'AUTHORIZATION_VIEW_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'aa87d0ac-9ef8-4087-9e79-4799bc47c137', N'SUPER_ADMIN', N'AUTHORIZATION_VIEW_SYS_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'b9eaa3b7-d069-48be-81d2-439dc723163d', N'SUPER_ADMIN', N'TRANSACTIONS_DROP_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'bc87291a-ee33-4e32-940d-c3d086063fc2', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_STOCKABLE_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c38c4bea-bf8d-4b53-aed1-386aff1c90e3', N'SUPER_ADMIN', N'INVENTORY_UI_MANAGE_ACTIVE_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c591b064-c1a6-4be2-881e-82316f24854d', N'SUPER_ADMIN', N'MANAGE_WAREHOUSE_STOCK_DOCUMENT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'c6ef789b-43c5-4807-a800-cb3654d26546', N'SUPER_ADMIN', N'CRM_UI_EDIT_PRICE_LEVEL', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'cd9d7bac-b484-4f6f-a895-fbeb2d113be1', N'SUPER_ADMIN', N'TRANSACTIONS_RECIEVE_SALES_PAYMENT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd1dad1ef-5c3b-46c4-8feb-c1191f422794', N'SUPER_ADMIN', N'DROP_ORG_PROFILE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd20416b5-a455-490e-8e88-776217773bf4', N'SUPER_ADMIN', N'TRANSACTIONS_DROP_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd3a21762-bc67-42f2-8756-a17d2e8c157e', N'SUPER_ADMIN', N'CRM_EDIT_CUSTOMER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'd92cbfe4-4431-4a80-a1a6-f418e346a26f', N'SUPER_ADMIN', N'CRM_VIEW_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'00dec409-c255-46b5-9d0f-b7d8c2d0ad85', N'SUPER_ADMIN', N'AUTHORIZATION_ADD_USER_SUPER_ADMIN_ROLE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0286d22a-427e-45fa-b6f4-7588612022ed', N'SUPER_ADMIN', N'INVENTORY_DROP_ALL_ITEMS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0378e265-56a4-42ea-9e1e-fae6f678416a', N'SUPER_ADMIN', N'ACCOUNTING_EDIT_CHARTS_OF_ACC', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'05ce715e-de47-4f67-900e-2aab1ce6b748', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_DISCOUNT_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0a8b076b-84bf-4161-83d4-cd19a9e9828c', N'SUPER_ADMIN', N'TRANSACTIONS_APPLY_SALES_DISCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'0f210642-d572-44b9-af7e-409e24061269', N'SUPER_ADMIN', N'HR_EDIT_EMPLOYEE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'13a0420f-7213-44fc-ad62-421600c274c8', N'SUPER_ADMIN', N'INVENTORY_DROP_ITEM', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1cad5d63-5ea7-475a-b89e-f982b4db94f9', N'SUPER_ADMIN', N'INVENTORY_CREATE_ITEM', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1cce3703-b764-4cfa-bdf4-15a2bca73b98', N'SUPER_ADMIN', N'ACCOUNTING_UI_VIEW_BALANCE_SHEET', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1d13ff39-efda-48bb-a354-2de4f461b914', N'SUPER_ADMIN', N'ACCOUNTING_CREATE_ACCOUNT_PERIOD', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'1d8d4f39-4c38-4d1f-aef9-10f7cd923b54', N'SUPER_ADMIN', N'AUTHORIZATION_BLOCK_USERS_ACCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'213d52f9-917f-4e66-8a6a-7e77c0a7671c', N'SUPER_ADMIN', N'AUTHORIZATION_CREATE_CUSTOM_ROLES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'27a0342a-ae98-4526-bb5c-ae6e8ae9b9ff', N'SUPER_ADMIN', N'INVENTORY_UPDATE_ITEM_STOCK', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2af167ec-b06e-4025-ba19-e953c1cecf7b', N'SUPER_ADMIN', N'CRM_EDIT_ACCOUNTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'2f7ecf9b-1ddf-412b-b36d-ded1cfb832e8', N'SUPER_ADMIN', N'CRM_VIEW_TRANSACTIONS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'30287bac-5851-45ed-bd7e-cd2419911251', N'SUPER_ADMIN', N'INVENTORY_DROP_CATEGORY', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3506852d-2389-4b6d-9b8a-cf3a31df0d77', N'SUPER_ADMIN', N'MANAGE_APP_SETTINGS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'35bda796-35d8-492b-8120-6c00ed57d9af', N'SUPER_ADMIN', N'TRANSACTIONS_CREATE_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'38a52632-005f-469c-a6b6-5b8084fb8198', N'SUPER_ADMIN', N'INVENTORY_UI_EDIT_ITEM_FORSALE_OPTION', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'39d7af00-0f57-4890-afcd-9632389ac416', N'SUPER_ADMIN', N'INVENTORY_UI_VIEW_ITEM_SUPPLIERS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3a523377-4f9a-45fe-9fbf-8b39113bdd9a', N'SUPER_ADMIN', N'HR_DROP_EMPLOYEE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'3ce6d816-c595-42ad-aa6b-9043f9419dbf', N'SUPER_ADMIN', N'HR_VIEW_EMPLOYEE_LIST', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4707a916-4375-41e8-a6e0-89bd0e0cc204', N'SUPER_ADMIN', N'ACCOUNTING_UI_POST_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'489a0bdd-3c58-4405-8396-d091ea78bd54', N'SUPER_ADMIN', N'ADD_WAREHOUSES', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'490f0c8f-af43-40e4-b17a-df0227bf051e', N'SUPER_ADMIN', N'MANAGE_BUSINESS_CHANNEL', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'4a35349e-303f-48fd-8f4b-5cd01c526174', N'SUPER_ADMIN', N'HR_VIEW_EMPLOYEE_PAY_DETAILS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'53877d90-030c-4976-81fd-b0ad089002d9', N'SUPER_ADMIN', N'CRM_UI_EDIT_CREDIT_LIMIT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'562d22cc-53de-46fb-aacb-d1d60ffe0aca', N'SUPER_ADMIN', N'ACCOUNTING_CREATE_NEW_ACCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'56d92e2f-e3c7-44ca-9477-a7fe763dccbd', N'SUPER_ADMIN', N'AUTHORIZATION_EDIT_OWN_ACCOUNT', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5760b957-c0b5-4a86-8181-b867ecd34806', N'SUPER_ADMIN', N'DROP_BUSINESS_CHANNELS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5884f54d-1f1e-43b7-b0b6-f2e5ce2475e4', N'SUPER_ADMIN', N'EDIT_ORG_PROFILE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'59a1077e-b4e6-4e14-a04f-f8f941848120', N'SUPER_ADMIN', N'HR_EDIT_OWN_RECORD', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'5a2c0f85-0430-4fbc-ba4a-0aa8af7883f2', N'SUPER_ADMIN', N'CRM_EDIT_DOCUMENTS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6161a051-23ca-43ea-bf79-d1f9388bb9b1', N'SUPER_ADMIN', N'AUTHORIZATION_CREATE_USERS', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'62a3a50b-295c-461c-9aae-1e76904d6cec', N'SUPER_ADMIN', N'INVENTORY_UPDATE_ITEM_STORAGE_TYPE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'647ed363-bc8f-44b1-ba73-e1b22d916714', N'SUPER_ADMIN', N'INVENTORY_UI_VIEW_ITEM_SALES_HISTORY', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6650309d-1fb9-442d-9aa4-7f020de2ecf2', N'SUPER_ADMIN', N'ACCOUNTING_UI_DROP_JOURNAL_RAW', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'67555009-49f6-47e4-a7a3-e6bbb1edaf7d', N'SUPER_ADMIN', N'CRM_CREATE_CUSTOMER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'680b97a8-077e-41ce-b3b8-36417f7bcf23', N'SUPER_ADMIN', N'TRANSACTIONS_EDIT_SALES_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6851c62b-4d8d-499f-9cd6-38ed2fbe3862', N'SUPER_ADMIN', N'HR_CREATE_EMPLOYEE', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
GO
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6c21468c-f2f9-45fa-bb96-fa94b1434e5c', N'SUPER_ADMIN', N'TRANSACTIONS_EDIT_PURCHASE_ORDER', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'6c797f78-4c11-4c3b-8815-83dec031b67b', N'SUPER_ADMIN', N'INVENTORY_DROP_ALL_CATEGORY', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_rolePermission] ([id], [roleName], [permissionName], [IsActive], [IsExpirable], [DateCreated], [ExpiresOn], [description]) VALUES (N'71fc9af1-67e8-4996-bf0e-c625e3bdb0c6', N'SUPER_ADMIN', N'HR_VIEW_OWN_RECORD', 1, 0, CAST(0x0000A65A013FE0B0 AS DateTime), CAST(0x002D247F018B81FF AS DateTime), NULL)
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'01110e45-2dd3-4365-a90e-09784b5169a3', N'ibestan', N'SIMPLE_ACTION')
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'15233b40-c50d-4e68-9cce-b127a0fc71c0', N'olivia', N'SIMPLE_ACTION')
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'74e5e34f-e25e-4576-90c3-0902e9806eb3', N'nonsoval', N'SALES_QUEUE')
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'0554eadb-8777-4c41-836c-2aff198af490', N'somkene', N'BRANCH_ADMIN')
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'7a59bee8-473a-4654-962e-f4374be20287', N'alfred', N'SUPER_ADMIN')
INSERT [dbo].[itrex_auth_usersInRole] ([id], [userId], [roleName]) VALUES (N'1e84b293-c702-4c10-bd5a-8abd54fa5897', N'innocent', N'SIMPLE_ACTION')
INSERT [dbo].[org_business_channels] ([id], [location], [address], [city], [phoneNo], [isActive], [isHeadOffice], [tag], [org_id], [extra_data1], [extra_data2], [extra_data3], [extra_data4]) VALUES (N'0002_AKWA', N'Anambra', N'Nnamdi Azikwe Avenue Unizik, Awka', N'Awka', N'0806 32333222', 1, 0, NULL, N'ORG_CODE_0001', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_business_channels] ([id], [location], [address], [city], [phoneNo], [isActive], [isHeadOffice], [tag], [org_id], [extra_data1], [extra_data2], [extra_data3], [extra_data4]) VALUES (N'ORG_CODE_0001', N'Lagos', N'15 Nekede Old road owerri', N'Lagos Island', N'0806 9273479', 1, 1, NULL, N'ORG_CODE_0001', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_company_profile] ([id], [name], [slogan], [logoUrl], [signatureUrl], [secondaryLogoUrl], [logoBlob], [signatureBlob], [dateCreated], [note], [email], [website]) VALUES (N'ORG_CODE_0001', N'Asom Software Development Services', N'best in fashionable services', N'/11081980_27092014_05101990/00pub/dpub/df87c1f9-0453-492f-ae96-302030afc0ab.png', N'/11081980_27092014_05101990/00pub/dpub/54196e20-66ae-496e-a895-50f28064ac0c.png', N'/11081980_27092014_05101990/00pub/dpub/a0b4f676-e9ab-4ecd-9312-4fbcee60e0f2.png', NULL, NULL, CAST(0x0000A599010DF646 AS DateTime), N'We Sell High quality Men, Women and Kids wears', N'alfredcsdinc@gmail.com', N'http://www.xclusivewardrobe.com')
INSERT [dbo].[org_global_settings] ([id], [org_id], [block_failed_user_login_attempt], [allowed_login_attempt], [application_theme], [currency_symbol], [currency_name], [currency_name_abbrv], [isActive], [viewMode], [showItemImageInCart], [notifyIfItemIsOutOfStock], [showCompanyLogoInReport], [showSecondaryLogoInReport], [invoiceTemplateType], [invoiceTitle], [invoiceFooter], [showInvoiceFooter], [showInvoiceTitle], [fontColorCode], [bgColorCode], [fontColorCodeFaded], [bgColorCodeFaded]) VALUES (N'ORG_SETTING_1000', N'ORG_CODE_0001', 0, 3, N'Coder', N'₦', N'Naira', N'NGR', 1, 3, 0, 1, 1, 1, NULL, NULL, NULL, 1, 1, N'#000000', N'#dbdbdb', N'#000000', N'#fefefe')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'000a5-service-packaging', N'000A5 Service Packaging', N'Testing Storage type', NULL, N'Ungrouped', N'SERV', 0, 1, 1, 1, 1, 0, 1, NULL, CAST(0x0000A61900AB2159 AS DateTime), CAST(0x0000A61E00E4D91F AS DateTime), N'ORG_CODE_0001', N'/images/effectv/def_image.png', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'1200444566', N'Blackberry Smart Phone QWERTY Keyboard', N'this product is from USA & London Use with QWERTY Keyboard', NULL, N'Phones', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A61800D450F4 AS DateTime), CAST(0x0000A6300112C771 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/dbce3a77-dc1b-48a6-85bd-cdc85ac58f80.jpg', N'innocent', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'889f8b06-a584-43b1-a188-637a0881d571', N'Blackgoon Designer Jean', N'High quality Jean from blackgoon designers', NULL, N'Clothes', N'PROD.', 1, 1, 1, 1, 1, 1, 1, NULL, NULL, CAST(0x0000A65D01627CB4 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/f881c1db-055a-441e-a69f-b58bc4537c43.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'another-watch', N'OLR Engine Watch', NULL, NULL, N'Ungrouped', N'PROD.', 1, 1, 1, 1, 1, 1, 1, NULL, CAST(0x0000A618007B98E5 AS DateTime), CAST(0x0000A618007B98E8 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/cfac49bd-14a6-4f6d-aaaa-3a34d850d97b.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'beauti-wear-ladies-dress', N'Beauti Wear Ladies Dress', NULL, N'Beauti Wear', N'Clothes', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A634009BFA45 AS DateTime), NULL, N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/71241d53-dbcc-444c-9a3c-1f48d73986eb.jpg', N'alfred', NULL, NULL, N'ORG_CODE_0001')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'chained-for-love-wrist-watch_copy', N'Banhu Watch', N'This a Copied version with thesame Image', NULL, N'Watches', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/e974a96a-9adb-4222-b4b6-456d00a0da29.jpg', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'cleaning-service', N'Cleaning Service', N'Cleaning services at Xclusive', NULL, N'Service', N'SERV', 0, 0, 1, 0, 0, 1, 1, NULL, CAST(0x0000A63200EC37A3 AS DateTime), CAST(0x0000A66300D320AB AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/d37ae177-353e-420b-b898-2d5c43ec0840.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', N'Best Office horse power laptop from dell', N'DELL Inc', N'Dell Systems', N'PROD.', 1, 0, 1, 1, 0, 1, 1, NULL, CAST(0x0000A6490140776C AS DateTime), CAST(0x0000A64F01318732 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/2fd462ec-18fb-4cec-8a56-751a69b20dbc.jpg', N'somkene', N'innocent', N'0002_AKWA', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'dolmak-jeans', N'Dolmak Jeans', N'High quality Jean from blackgoon designers', NULL, N'Clothes', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A63301303803 AS DateTime), CAST(0x0000A6330132AA70 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/d12e2f48-c995-4016-80bc-b60814296b08.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'duracell-battery', N'Duracell Battery', NULL, NULL, N'Shoprite', N'PROD.', 1, 1, 1, 1, 1, 1, 1, NULL, CAST(0x0000A63E00D29B64 AS DateTime), NULL, N'ORG_CODE_0001', N'', N'alfred', NULL, NULL, N'ORG_CODE_0001')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'EngineOIL', N'KXT Engine Oil', N'Best engine oil from KOTEC Automobile Nigeria Limited', NULL, N'Motor Oil', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A5B600E42311 AS DateTime), CAST(0x0000A63400A3BA92 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/dcf8454d-3b38-4df8-a965-80bd285d6df7.png', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'ghile-designers-foot-wear', N'Ghile Designers Foot wear', N'For the classic and fashion lady', N'Sinai Designers', N'Shoes', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A63301352E53 AS DateTime), CAST(0x0000A63600A3B0F2 AS DateTime), N'ORG_CODE_0001', N'/effectiv/images/effectv/def_image.png', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'Glo_PINS_001', N'200 Naira Glo Recharge Voucher', N'100 Naira Globacom Nigeria Recharge card voucher', NULL, N'Ungrouped', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A59B00F6F39B AS DateTime), CAST(0x0000A631010DE861 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/0a31cecf-2195-4815-950b-ffb4ccf1e469.png', N'alfred', N'innocent', N'0002_AKWA', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'iman-bb-lotion', N'IMAN  BB Lotion', N'The best for gentle', NULL, N'Makeup', N'PROD.', 0, 1, 1, 1, 1, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/9a06904b-a1a5-4b5d-9bfa-7652407746e7.jpeg', N'innocent', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'ja-jil-watch', N'Ja & Jil Watch', N'Nice Watch', NULL, N'Watches', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/0a0a5cb4-88ab-4861-b13e-4452e2649ae2.jpg', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'johnson-baby-oil', N'Johnson Baby Oil', NULL, NULL, N'Shoprite', N'PROD.', 1, 1, 1, 1, 1, 1, 1, NULL, CAST(0x0000A63E00D3477B AS DateTime), NULL, N'ORG_CODE_0001', N'', N'alfred', NULL, NULL, N'ORG_CODE_0001')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', N'Make up at cost price', NULL, N'Makeup', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, CAST(0x0000A66600876472 AS DateTime), N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/27304714-fde4-4e7b-a6a9-4692cedef202.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'mayo-bama', N'Mayo Bama', NULL, NULL, N'Shoprite', N'PROD.', 1, 0, 1, 1, 1, 1, 1, NULL, CAST(0x0000A63E00D17C98 AS DateTime), CAST(0x0000A63E00D2226A AS DateTime), N'ORG_CODE_0001', N'/images/effectv/def_image.png', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'might-eagle', N'Aveenog', NULL, NULL, N'Ungrouped', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, CAST(0x0000A62F00E6725F AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/ae1d68df-0f2d-4874-8e0f-6ac46296a00c.jpeg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'MTN_PINS_001', N'100 Naira MTN Recharge Voucher', N'100 Naira Mtn Nigeria Recharge card voucher', NULL, N'MTN Recharge Card', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A59A00A9DDBE AS DateTime), NULL, N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/79c62ea2-8f2f-4552-a8d8-067ac43debbe.png', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'nice-leather-watch', N'Nice Leather Watch', N'Kalsco Nags', NULL, N'Watches', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/eb1bc22f-ca5e-48bc-b724-0a2f3e77b017.jpg', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'phone-repairs-service', N'Phone Repairs Service', N'All Smart Phone Repairs', N'PhoneRepairs', N'Phones', N'SERV', 0, 1, 1, 1, 0, 0, 1, NULL, CAST(0x0000A61900D1AA51 AS DateTime), NULL, N'ORG_CODE_0001', N'', N'alfred', NULL, NULL, N'ORG_CODE_0001')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'platinum-earrings', N'Platinum Earrings', N'Best qulaity', NULL, N'Jewels', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'uploaded_files/inventory\product_images/b5efc814-a4c3-4cc8-ba3b-65c589646ce8.jpg', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'quartz-slik-wrist-watch', N'Quartz slik Wrist watch', N'Best watches for ladies and Gentlemen', NULL, N'Watches', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, CAST(0x0000A632012AC876 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/683840fd-3d06-4c4f-b429-f86ff74f99bd.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'simdy-leather-foot-wear', N'Simdy Leather foot wear', N'For the gentle men', N'Simdy', N'Shoes', N'PROD.', 1, 1, 1, 1, 1, 1, 1, NULL, CAST(0x0000A6330136DB7F AS DateTime), CAST(0x0000A63901383B37 AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/d76cb02d-1c08-48b8-8d98-2fe0801fd639.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'sinai-female-shoe', N'Sinai Female Shoe', N'Leather shoe from sainai', N'Sinai Designers', N'Shoes', N'PROD.', 0, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A618007CB410 AS DateTime), CAST(0x0000A62F0118C41B AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/29d6d5fa-3c16-4dd7-8051-843b6c694a73.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'superfit', N'Superfit', N'Brake shoe', NULL, N'Brake Shoe', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, CAST(0x0000A62600E1826D AS DateTime), NULL, N'ORG_CODE_0001', N'', N'alfred', NULL, NULL, N'ORG_CODE_0001')
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N't-shirt-turkey', N'Turkey T-Shirt', NULL, NULL, N'Ungrouped', N'PROD.', 0, 1, 1, 1, 1, 1, 1, NULL, NULL, CAST(0x0000A655008E650C AS DateTime), N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/df14d5f8-3468-4cdb-857a-8d09cc4b4626.jpg', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'twin-klac-wrist-watch', N'Twin Klac Wrist Watch', N'20 Carat Gold Coalted Wrisk watch from Klac', NULL, N'Watches', N'PROD.', 1, 1, 1, 1, 0, 1, 1, NULL, NULL, NULL, N'ORG_CODE_0001', N'/uploaded_files/inventory/product_images/e9a19315-f6ac-42f8-8a62-4a1821f89488.jpg', N'alfred', NULL, NULL, NULL)
INSERT [dbo].[org_item_definition_store] ([id], [name], [description], [make], [category], [item_type], [is_countable], [is_stockable], [is_forsale], [is_discountable], [is_taxable], [is_bought], [isActive], [tax_code], [dateCreated], [dateUpdate], [org_id], [picture_url], [created_by], [updated_by], [updated_at_channel], [create_at_channel]) VALUES (N'wheat-bread-sweet', N'Wheat Bread Sweet', NULL, NULL, N'Shoprite', N'PROD.', 1, 0, 1, 1, 0, 1, 1, NULL, CAST(0x0000A63E00D0FBA8 AS DateTime), CAST(0x0000A63E00D35CE3 AS DateTime), N'ORG_CODE_0001', N'/images/effectv/def_image.png', N'alfred', N'alfred', N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'01e70aa0-3d18-4a7b-872a-5e0ca288b2c1', N'0002_AKWA', N'1200444566', N'Blackberry curve 3V', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(70000.00 AS Decimal(18, 2)), CAST(65000.00 AS Decimal(18, 2)), CAST(67000.00 AS Decimal(18, 2)), N'white color', N'innocent', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'1293a03f-d4c8-4bd6-b217-6c6371c39ea8', N'ORG_CODE_0001', N'889f8b06-a584-43b1-a188-637a0881d571', N'Blackgoon Designer Jean', CAST(1.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(4500.00 AS Decimal(18, 2)), CAST(9000.00 AS Decimal(18, 2)), CAST(6800.00 AS Decimal(18, 2)), CAST(7500.00 AS Decimal(18, 2)), N'Blackgoon XL', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'12bf502c-678e-4485-99eb-5a602008808b', N'ORG_CODE_0001', N't-shirt-turkey', N'Turkey T-Shirt', CAST(4.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(3400.00 AS Decimal(18, 2)), CAST(4400.00 AS Decimal(18, 2)), CAST(3800.00 AS Decimal(18, 2)), CAST(4100.00 AS Decimal(18, 2)), N'XXL Extra Large', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'17253841-c9cc-457b-9c72-b81e776d5016', N'ORG_CODE_0001', N'ghile-designers-foot-wear', N'Ghile Designers Foot wear', CAST(1.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(7000.00 AS Decimal(18, 2)), CAST(11400.00 AS Decimal(18, 2)), CAST(9770.00 AS Decimal(18, 2)), CAST(10500.00 AS Decimal(18, 2)), N'Short Heel', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'1b483613-a4ff-4da0-90b3-48d5c2b6adac', N'ORG_CODE_0001', N'johnson-baby-oil', N'Johnson Baby Oil', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(779.99 AS Decimal(18, 2)), CAST(779.99 AS Decimal(18, 2)), CAST(779.99 AS Decimal(18, 2)), CAST(779.99 AS Decimal(18, 2)), N'500ML', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'20641dae-8799-4214-bf55-ce3d0e72f154', N'ORG_CODE_0001', N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', CAST(8.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(200000.00 AS Decimal(18, 2)), CAST(277900.00 AS Decimal(18, 2)), CAST(240000.00 AS Decimal(18, 2)), CAST(255000.00 AS Decimal(18, 2)), N'Intel Corei7, 8GB RAM, 4GB GDDR5 Graphics Card Win10 Pro', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'23a55912-b23f-4623-817a-7355ed13aad6', N'ORG_CODE_0001', N'Glo_PINS_001', N'200 Naira Glo Recharge Voucher', CAST(10.00 AS Decimal(14, 2)), N'Pck', CAST(0.00 AS Decimal(14, 2)), CAST(3800.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), CAST(4200.00 AS Decimal(18, 2)), CAST(4100.00 AS Decimal(18, 2)), N'One Pack of 200 Credit', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'2408c82e-8768-4340-a36f-113c1a76e48c', N'ORG_CODE_0001', N'1200444566', N'Blackberry curve 3V', CAST(5.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(35500.00 AS Decimal(18, 2)), CAST(42200.00 AS Decimal(18, 2)), CAST(40200.00 AS Decimal(18, 2)), CAST(40500.00 AS Decimal(18, 2)), N'Curve 9001', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'28735284-222e-4b1d-aaa8-d4a85c3a974d', N'0002_AKWA', N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(170000.00 AS Decimal(18, 2)), CAST(219000.00 AS Decimal(18, 2)), CAST(209000.00 AS Decimal(18, 2)), CAST(213000.00 AS Decimal(18, 2)), N'8GB RAM 760GB Storage 5th Gen core i7', N'somkene', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'2898b72d-054d-4673-b334-139653fc822f', N'0002_AKWA', N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(150000.00 AS Decimal(18, 2)), CAST(197000.00 AS Decimal(18, 2)), CAST(188000.00 AS Decimal(18, 2)), CAST(190000.00 AS Decimal(18, 2)), N'8GB RAM 500GB Storage 5th Gen core i5', N'somkene', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'394b46f5-633a-4300-957c-3c99462fc0ff', N'ORG_CODE_0001', N'twin-klac-wrist-watch', N'Twin Klac Wrist Watch', CAST(1.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(39900.00 AS Decimal(18, 2)), CAST(56900.00 AS Decimal(18, 2)), CAST(49900.00 AS Decimal(18, 2)), CAST(52900.00 AS Decimal(18, 2)), N'Gold Coated Klac', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'3d681cf9-afd0-4fc0-9e53-aeaa3c541e08', N'ORG_CODE_0001', N'platinum-earrings', N'Platinum Earrings', CAST(1.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(21300.00 AS Decimal(18, 2)), CAST(18000.00 AS Decimal(18, 2)), CAST(19400.00 AS Decimal(18, 2)), N'Platinuim Variant', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'42c9351f-d578-4d0e-857b-8517d5a7dba7', N'ORG_CODE_0001', N'cleaning-service', N'Cleaning Service', CAST(1.00 AS Decimal(14, 2)), N'Job', CAST(0.00 AS Decimal(14, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), N'Hourly Rate', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'49948807-31ea-401e-b469-e7636b405711', N'ORG_CODE_0001', N'cleaning-service', N'Cleaning Service', CAST(1.00 AS Decimal(14, 2)), N'Job', CAST(0.00 AS Decimal(14, 2)), CAST(40000.00 AS Decimal(18, 2)), CAST(40000.00 AS Decimal(18, 2)), CAST(40000.00 AS Decimal(18, 2)), CAST(40000.00 AS Decimal(18, 2)), N'Monthly Rate', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'4a3838bd-5843-4771-bc57-c549775e94a8', N'ORG_CODE_0001', N'simdy-leather-foot-wear', N'Simdy Leather foot wear', CAST(2.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(4000.00 AS Decimal(18, 2)), CAST(4000.00 AS Decimal(18, 2)), N'Size 40'' Brown', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'4e00f283-5f6a-4046-9829-0108f2854389', N'ORG_CODE_0001', N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', CAST(10.00 AS Decimal(14, 2)), N'Dozen', CAST(0.00 AS Decimal(14, 2)), CAST(15600.00 AS Decimal(18, 2)), CAST(17700.00 AS Decimal(18, 2)), CAST(17400.00 AS Decimal(18, 2)), CAST(17550.00 AS Decimal(18, 2)), N'Goal Milk White Gel', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'4f05f88e-0f4a-4db9-a8c4-e46143d9e47b', N'ORG_CODE_0001', N'might-eagle', N'Might Eagle', CAST(10.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(2400.00 AS Decimal(18, 2)), CAST(4200.00 AS Decimal(18, 2)), CAST(2400.00 AS Decimal(18, 2)), CAST(3700.00 AS Decimal(18, 2)), N'Normal M-E', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', N'ORG_CODE_0001', N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', CAST(10.00 AS Decimal(14, 2)), N'Dozen', CAST(0.00 AS Decimal(14, 2)), CAST(13000.00 AS Decimal(18, 2)), CAST(15500.00 AS Decimal(18, 2)), CAST(14400.00 AS Decimal(18, 2)), CAST(14700.00 AS Decimal(18, 2)), N'Carrot Orange Gel', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'5b565e33-9de6-4792-8b1c-beab8c6b0827', N'ORG_CODE_0001', N'cleaning-service', N'Cleaning Service', CAST(1.00 AS Decimal(14, 2)), N'Job', CAST(0.00 AS Decimal(14, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), N'Weekly Rate', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'629e3339-3759-473e-8b2b-599aefe9aac6', N'ORG_CODE_0001', N'000a5-service-packaging', N'000A5 Service Packaging', CAST(1.00 AS Decimal(14, 2)), N'g', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(400.00 AS Decimal(18, 2)), CAST(400.00 AS Decimal(18, 2)), CAST(400.00 AS Decimal(18, 2)), N'10g Packaging', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'6338ab56-8bb4-459c-938e-3f1512d06b02', N'ORG_CODE_0001', N'cleaning-service', N'Cleaning Service', CAST(1.00 AS Decimal(14, 2)), N'Job', CAST(0.00 AS Decimal(14, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(250.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), N'Minute', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'64096a96-22fe-48a7-aebc-979ef20f93ed', N'0002_AKWA', N'quartz-slik-wrist-watch', N'Quartz slik Wrist watch', CAST(2.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(34000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(47600.00 AS Decimal(18, 2)), N'Gold Plated', N'innocent', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'64c27dc8-efb9-4ac6-af17-41d66d0ade12', N'ORG_CODE_0001', N'1200444566', N'Blackberry curve 3V', CAST(3.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(45600.00 AS Decimal(18, 2)), CAST(58300.00 AS Decimal(18, 2)), CAST(53400.00 AS Decimal(18, 2)), CAST(54600.00 AS Decimal(18, 2)), N'Bold 5 model 11900', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'674408d5-d51a-42c1-a7ad-1f6568aab751', N'0002_AKWA', N'Glo_PINS_001', N'200 Naira Glo Recharge Voucher', CAST(10.00 AS Decimal(14, 2)), N'Pck', CAST(70.00 AS Decimal(14, 2)), CAST(1800.00 AS Decimal(18, 2)), CAST(2500.00 AS Decimal(18, 2)), CAST(2200.00 AS Decimal(18, 2)), CAST(2100.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'693d7110-0199-4d5d-852d-7e160eee18bc', N'ORG_CODE_0001', N'simdy-leather-foot-wear', N'Simdy Leather foot wear', CAST(1.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(3100.00 AS Decimal(18, 2)), CAST(5100.00 AS Decimal(18, 2)), CAST(4100.00 AS Decimal(18, 2)), CAST(4100.00 AS Decimal(18, 2)), N'Size 40'' Black', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'6edb22b8-9498-43b6-9d1a-c163cacba090', N'ORG_CODE_0001', N'phone-repairs-service', N'Phone Repairs Service', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(23500.00 AS Decimal(18, 2)), CAST(23500.00 AS Decimal(18, 2)), CAST(23500.00 AS Decimal(18, 2)), N'Samsung Galaxy s4 hardware fix', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'72b4fe35-54b2-4cf8-b20c-201447b3ce23', N'ORG_CODE_0001', N'chained-for-love-wrist-watch_copy', N'Chained For Love Wrist Watch', CAST(3.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(3800.00 AS Decimal(18, 2)), CAST(5700.00 AS Decimal(18, 2)), CAST(5300.00 AS Decimal(18, 2)), CAST(5500.00 AS Decimal(18, 2)), N'Silver', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'7de97b96-ae71-4684-bdbb-519b9ea6484a', N'ORG_CODE_0001', N'wheat-bread-sweet', N'Wheat Bread Sweet', CAST(2.00 AS Decimal(14, 2)), N'Loaf', CAST(0.00 AS Decimal(14, 2)), CAST(299.99 AS Decimal(18, 2)), CAST(299.99 AS Decimal(18, 2)), CAST(299.99 AS Decimal(18, 2)), CAST(299.99 AS Decimal(18, 2)), N'Not Sliced', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'8539c92f-7d93-4ad0-903e-c0a657c5a87d', N'ORG_CODE_0001', N'beauti-wear-ladies-dress', N'Beauti Wear Ladies Dress', CAST(2.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(7000.00 AS Decimal(18, 2)), CAST(11000.00 AS Decimal(18, 2)), CAST(9000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'Black Stripe silk', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'86632ae0-7b11-46ae-a743-01594edcbdf9', N'ORG_CODE_0001', N'000a5-service-packaging', N'000A5 Service Packaging', CAST(1.00 AS Decimal(14, 2)), N'Kg', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1300.00 AS Decimal(18, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(1200.00 AS Decimal(18, 2)), N'50Kg Packaging', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'867a7d1b-9099-4947-893a-abf9eb787ef1', N'ORG_CODE_0001', N'chained-for-love-wrist-watch_copy', N'Chained For Love Wrist Watch', CAST(2.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(7100.00 AS Decimal(18, 2)), CAST(6700.00 AS Decimal(18, 2)), CAST(6900.00 AS Decimal(18, 2)), N'Gold', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'89472739-09b4-4d5d-9949-17893f126abf', N'ORG_CODE_0001', N'phone-repairs-service', N'Phone Repairs Service', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15600.00 AS Decimal(18, 2)), CAST(15600.00 AS Decimal(18, 2)), CAST(15600.00 AS Decimal(18, 2)), N'Samsung Galaxy S3 Hardware repairs', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'8c53bbf9-5079-4344-afaf-a8964fb1d8c6', N'ORG_CODE_0001', N'quartz-slik-wrist-watch', N'Quartz slik Wrist watch', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(37800.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(36620.00 AS Decimal(18, 2)), N'Gold Plated Slik', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'9a5b46d2-fe48-4531-9e4e-ce308167ffd6', N'ORG_CODE_0001', N'sinai-female-shoe', N'Sinai Female Shoe', CAST(3.00 AS Decimal(14, 2)), N'Per', CAST(0.00 AS Decimal(14, 2)), CAST(6700.00 AS Decimal(18, 2)), CAST(10700.00 AS Decimal(18, 2)), CAST(8400.00 AS Decimal(18, 2)), CAST(9700.00 AS Decimal(18, 2)), N'Brown Sinai leather brand', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'ab51b242-c73d-4849-979b-d27c8f517fcf', N'ORG_CODE_0001', N't-shirt-turkey', N'Turkey T-Shirt', CAST(2.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(2900.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), CAST(2000.00 AS Decimal(18, 2)), N'XL (Large)', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'adde0111-445a-4398-a00c-94ae827b1562', N'ORG_CODE_0001', N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', CAST(12.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(1600.00 AS Decimal(18, 2)), CAST(2300.00 AS Decimal(18, 2)), CAST(1900.00 AS Decimal(18, 2)), CAST(2100.00 AS Decimal(18, 2)), N'Single Psc with Carrot', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'b33c3b2f-5038-409c-9e93-6562b15f1422', N'ORG_CODE_0001', N'889f8b06-a584-43b1-a188-637a0881d571', N'Blackgoon Designer Jean', CAST(3.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(6700.00 AS Decimal(18, 2)), CAST(12500.00 AS Decimal(18, 2)), CAST(10500.00 AS Decimal(18, 2)), CAST(11600.00 AS Decimal(18, 2)), N'Blackgoon XXL', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'bfe9686d-06b2-4463-8bbd-3ab0c87bf9c1', N'ORG_CODE_0001', N'mayo-bama', N'Mayo Bama', CAST(2.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(999.99 AS Decimal(18, 2)), CAST(999.99 AS Decimal(18, 2)), CAST(999.99 AS Decimal(18, 2)), CAST(999.99 AS Decimal(18, 2)), N'Medium Size', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'c08aad3d-a2b3-4506-9668-bd50f3df3012', N'ORG_CODE_0001', N'superfit', N'Superfit', CAST(1.00 AS Decimal(14, 2)), N'Carton', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'2023 Large Size', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'c61656f1-56db-43cd-a060-6c51e8f59d66', N'0002_AKWA', N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', CAST(1.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(140000.00 AS Decimal(18, 2)), CAST(180000.00 AS Decimal(18, 2)), CAST(170000.00 AS Decimal(18, 2)), CAST(175000.00 AS Decimal(18, 2)), N'6GB RAM 500GB Storage 5th Gen core i5', N'somkene', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'caa260d3-04b9-469b-9089-5cbdb418d736', N'ORG_CODE_0001', N'another-watch', N'Another Watch', CAST(2.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(8000.00 AS Decimal(18, 2)), CAST(11700.00 AS Decimal(18, 2)), CAST(10300.00 AS Decimal(18, 2)), CAST(10700.00 AS Decimal(18, 2)), N'Silver Linning', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'cb63eb84-e4b6-45f1-9b89-7a4a4f044171', N'0002_AKWA', N'iman-bb-lotion', N'IMAN  BB Lotion', CAST(1.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(1850.00 AS Decimal(18, 2)), CAST(1500.00 AS Decimal(18, 2)), CAST(1600.00 AS Decimal(18, 2)), N'Normal Lotion', N'innocent', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'd40aff09-b1f3-4ee4-9fca-90172524ee65', N'ORG_CODE_0001', N'ja-jil-watch', N'Ja & Jil Watch', CAST(2.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), CAST(4500.00 AS Decimal(18, 2)), N'Silver Leather', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'd7f5a5cf-22bd-4e13-96e4-a8e14a1bb839', N'ORG_CODE_0001', N'ghile-designers-foot-wear', N'Ghile Designers Foot wear', CAST(3.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(12000.00 AS Decimal(18, 2)), CAST(19000.00 AS Decimal(18, 2)), CAST(17000.00 AS Decimal(18, 2)), CAST(18000.00 AS Decimal(18, 2)), N'High Heel Brand', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'dcfd026a-fced-40bd-92aa-de2b75c80743', N'ORG_CODE_0001', N'Glo_PINS_001', N'200 Naira Glo Recharge Voucher', CAST(10.00 AS Decimal(14, 2)), N'Psc', CAST(0.00 AS Decimal(14, 2)), CAST(190.00 AS Decimal(18, 2)), CAST(200.00 AS Decimal(18, 2)), CAST(195.00 AS Decimal(18, 2)), CAST(197.00 AS Decimal(18, 2)), N'Single Piece of 200 Credit', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'e4080627-d7f7-4a3a-82a1-5c7eeccf6bcc', N'ORG_CODE_0001', N'might-eagle', N'Might Eagle', CAST(4.00 AS Decimal(14, 2)), N'Carton', CAST(0.00 AS Decimal(14, 2)), CAST(32000.00 AS Decimal(18, 2)), CAST(40000.00 AS Decimal(18, 2)), CAST(36000.00 AS Decimal(18, 2)), CAST(37500.00 AS Decimal(18, 2)), N'4X4 16 Pack', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'e422aae7-2c49-4d09-9df1-26a2c6098879', N'0002_AKWA', N'1200444566', N'Blackberry Smart Phone', CAST(3.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(36000.00 AS Decimal(18, 2)), CAST(33500.00 AS Decimal(18, 2)), CAST(34500.00 AS Decimal(18, 2)), N'London Used Bold 5', N'innocent', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'ee688dd8-1840-4e41-8689-12e4f9dc89cc', N'ORG_CODE_0001', N'000a5-service-packaging', N'000A5 Service Packaging', CAST(1.00 AS Decimal(14, 2)), N'Kg', CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(2100.00 AS Decimal(18, 2)), CAST(2100.00 AS Decimal(18, 2)), CAST(2100.00 AS Decimal(18, 2)), N'100Kg Packaging', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'engineOil_10Litre_Gallon', N'ORG_CODE_0001', N'EngineOIL', N'KXT Engine Oil', CAST(10.00 AS Decimal(14, 2)), N'Gallon', CAST(0.00 AS Decimal(14, 2)), CAST(4200.00 AS Decimal(18, 2)), CAST(6200.00 AS Decimal(18, 2)), CAST(5200.00 AS Decimal(18, 2)), CAST(5700.00 AS Decimal(18, 2)), N'10 liter Gallon of Engine Oil MotorMAX', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'engineOil_25Litre_Gallon', N'ORG_CODE_0001', N'EngineOIL', N'KXT Engine Oil', CAST(10.00 AS Decimal(14, 2)), N'Gallon', CAST(0.00 AS Decimal(14, 2)), CAST(12700.00 AS Decimal(18, 2)), CAST(16900.00 AS Decimal(18, 2)), CAST(15200.00 AS Decimal(18, 2)), CAST(15800.00 AS Decimal(18, 2)), N'25 liter Gallon of Engine Oil MotorMAX', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'f03787c6-2a61-42ea-8fa1-54f968d84255', N'ORG_CODE_0001', N'dolmak-jeans', N'Dolmak Jeans', CAST(1.00 AS Decimal(14, 2)), N'Pair', CAST(0.00 AS Decimal(14, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), CAST(3000.00 AS Decimal(18, 2)), N'Size 20 Blue L', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'f228199b-fd68-4550-a167-3f199f7c4f32', N'ORG_CODE_0001', N'another-watch', N'Another Watch', CAST(4.00 AS Decimal(14, 2)), N'Unit', CAST(0.00 AS Decimal(14, 2)), CAST(16700.00 AS Decimal(18, 2)), CAST(22300.00 AS Decimal(18, 2)), CAST(20100.00 AS Decimal(18, 2)), CAST(21600.00 AS Decimal(18, 2)), N'Gold coalted', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'f64bcda9-7a6d-486f-954d-6b8b9e73d4c4', N'ORG_CODE_0001', N'duracell-battery', N'Duracell Battery', CAST(1.00 AS Decimal(14, 2)), N'Pack', CAST(0.00 AS Decimal(14, 2)), CAST(549.99 AS Decimal(18, 2)), CAST(549.99 AS Decimal(18, 2)), CAST(549.99 AS Decimal(18, 2)), CAST(549.99 AS Decimal(18, 2)), N'AA4 4PK', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'f79a11e8-3931-4065-9e28-8b8a979b0a9d', N'0002_AKWA', N'EngineOIL', N'KXT Engine Oil', CAST(4.00 AS Decimal(14, 2)), N'Gallon', CAST(0.00 AS Decimal(14, 2)), CAST(45000.00 AS Decimal(18, 2)), CAST(58900.00 AS Decimal(18, 2)), CAST(52800.00 AS Decimal(18, 2)), CAST(54200.00 AS Decimal(18, 2)), N'50 Litres of Motor MaxOil', N'innocent', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_item_inventory_stock] ([id], [for_channel_id], [item_id], [item_tag], [reorder_level], [unit_measure], [unit_in_stock], [cost_price], [retail_price], [wholesale_price], [distributor_price], [note], [created_by], [barcode], [barcodeType], [expiresOn], [alertOnExpiration]) VALUES (N'fa09647d-6fca-4bf5-bf2e-8ff63fbcc5e4', N'ORG_CODE_0001', N'duracell-battery', N'Duracell Battery', CAST(1.00 AS Decimal(14, 2)), N'Pack', CAST(0.00 AS Decimal(14, 2)), CAST(719.00 AS Decimal(18, 2)), CAST(719.00 AS Decimal(18, 2)), CAST(719.00 AS Decimal(18, 2)), CAST(719.00 AS Decimal(18, 2)), N'AA8 8PK', N'alfred', NULL, NULL, NULL, NULL)
INSERT [dbo].[org_warehouses] ([id], [name], [description], [location], [address], [isActive], [org_id], [created_by]) VALUES (N'WH_MBAISE', N'MBAISE_WAREHOUSE', NULL, N'Owerri', N'Mbaise Street', 1, N'ORG_CODE_0001', NULL)
INSERT [dbo].[org_warehouses] ([id], [name], [description], [location], [address], [isActive], [org_id], [created_by]) VALUES (N'WH_NNEWISOUTH', N'NNEWI_SOUTH_WAREHOUSE', NULL, N'Owerri', N'i01 Umuahia street owr', 1, N'ORG_CODE_0001', NULL)
INSERT [dbo].[sales_order] ([id], [order_date], [delivery_date], [delivery_status], [sale_person_id], [channel_id], [customer_id], [is_cancelled], [shipping_name], [shipping_address], [shipping_method], [shipping_location], [shipping_charge], [shipping_phone_number], [date_updated], [trans_status_code], [vat], [discount], [sales_total], [amt_received], [note], [due_date], [status], [currency_code], [is_invoiced], [customer_name], [customer_address], [customer_phone], [items_dispatch_channel_id], [dispatch_channelType], [dispatch_code]) VALUES (N'SO-1335151', CAST(0x0000A66600771681 AS DateTime), CAST(0x0000A66600771681 AS DateTime), N'NOT DELIVERED', N'alfred', N'ORG_CODE_0001', N'greenhouse-church', 0, N'Greenhouse church', NULL, NULL, NULL, CAST(0.00 AS Decimal(18, 2)), NULL, CAST(0x0000A6660077490E AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(88100.00 AS Decimal(18, 2)), CAST(88100.00 AS Decimal(18, 2)), N'Goods were received in good condition', CAST(0x0000A66D00771681 AS DateTime), N'INVOICED', NULL, 1, N'Greenhouse church', NULL, NULL, N'ORG_CODE_0001', N'CHANNEL', N'123d25f9-c35a-4e98-be48-d185de288864')
INSERT [dbo].[sales_order] ([id], [order_date], [delivery_date], [delivery_status], [sale_person_id], [channel_id], [customer_id], [is_cancelled], [shipping_name], [shipping_address], [shipping_method], [shipping_location], [shipping_charge], [shipping_phone_number], [date_updated], [trans_status_code], [vat], [discount], [sales_total], [amt_received], [note], [due_date], [status], [currency_code], [is_invoiced], [customer_name], [customer_address], [customer_phone], [items_dispatch_channel_id], [dispatch_channelType], [dispatch_code]) VALUES (N'SO-24612', CAST(0x0000A6690079F9CC AS DateTime), CAST(0x0000A6690079F9CC AS DateTime), N'NOT DELIVERED', N'somkene', N'0002_AKWA', N'iyke-fedinald', 0, N'Iyke Fedinald', NULL, NULL, N'IMO', CAST(0.00 AS Decimal(18, 2)), N'08067372822', CAST(0x0000A669007AE30E AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(285200.00 AS Decimal(18, 2)), CAST(180000.00 AS Decimal(18, 2)), N'Goods were received in good condition', CAST(0x0000A6700079F9CC AS DateTime), N'INVOICED', NULL, 1, N'Iyke Fedinald', NULL, N'08067372822', N'0002_AKWA', N'CHANNEL', N'9363d6d8-5ae9-4fa6-ab87-4b9f9c647407')
INSERT [dbo].[sales_order] ([id], [order_date], [delivery_date], [delivery_status], [sale_person_id], [channel_id], [customer_id], [is_cancelled], [shipping_name], [shipping_address], [shipping_method], [shipping_location], [shipping_charge], [shipping_phone_number], [date_updated], [trans_status_code], [vat], [discount], [sales_total], [amt_received], [note], [due_date], [status], [currency_code], [is_invoiced], [customer_name], [customer_address], [customer_phone], [items_dispatch_channel_id], [dispatch_channelType], [dispatch_code]) VALUES (N'SO-3939531', CAST(0x0000A66701338603 AS DateTime), CAST(0x0000A66701338603 AS DateTime), N'NOT DELIVERED', N'alfred', N'ORG_CODE_0001', N'nnayelugo-obialo', 0, N'Nnayelugo Obialo', N'Ihiagwa Road owerri West', NULL, N'Imo', CAST(0.00 AS Decimal(18, 2)), N'0805636362', CAST(0x0000A6670133EDB0 AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(5760.00 AS Decimal(14, 2)), CAST(441640.00 AS Decimal(18, 2)), CAST(441640.00 AS Decimal(18, 2)), N'Goods were received in good condition', CAST(0x0000A66E01338603 AS DateTime), N'INVOICED', NULL, 1, N'Nnayelugo Obialo', N'Ihiagwa Road owerri West', N'0805636362', N'ORG_CODE_0001', N'CHANNEL', N'56baca58-1872-4da3-90be-a72d74c25950')
INSERT [dbo].[sales_order] ([id], [order_date], [delivery_date], [delivery_status], [sale_person_id], [channel_id], [customer_id], [is_cancelled], [shipping_name], [shipping_address], [shipping_method], [shipping_location], [shipping_charge], [shipping_phone_number], [date_updated], [trans_status_code], [vat], [discount], [sales_total], [amt_received], [note], [due_date], [status], [currency_code], [is_invoiced], [customer_name], [customer_address], [customer_phone], [items_dispatch_channel_id], [dispatch_channelType], [dispatch_code]) VALUES (N'SO-5843700', CAST(0x0000A666007301D6 AS DateTime), CAST(0x0000A666007301D6 AS DateTime), N'NOT DELIVERED', N'alfred', N'ORG_CODE_0001', N'JACOB-ZUMA', 0, N'Jacob Zuma', N'South Africa Presidential residence Cape town', NULL, N'South Africa', CAST(0.00 AS Decimal(18, 2)), N'08073232711', CAST(0x0000A66600732C34 AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(143100.00 AS Decimal(18, 2)), CAST(143100.00 AS Decimal(18, 2)), N'Goods were received in good condition', CAST(0x0000A66D007301D6 AS DateTime), N'INVOICED', NULL, 1, N'Jacob Zuma', N'South Africa Presidential residence Cape town', N'08073232711', N'ORG_CODE_0001', N'CHANNEL', N'343c5cd2-0903-43e9-9aa8-c35329cb37bf')
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'0203b122-aa35-4d6b-a82a-29f32e97b47c', NULL, N'SO-1335151', N'PROD.', N'889f8b06-a584-43b1-a188-637a0881d571', N'Blackgoon Designer Jean', N'Blackgoon XXL', N'b33c3b2f-5038-409c-9e93-6562b15f1422', N'Pair', CAST(12500.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(6700.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(6.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'070427e8-d723-43b0-b49d-dfde53536e1d', NULL, N'SO-1335151', N'PROD.', N'sinai-female-shoe', N'Sinai Female Shoe', N'Brown Sinai leather brand', N'9a5b46d2-fe48-4531-9e4e-ce308167ffd6', N'Per', CAST(10700.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(6700.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(0.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'1733d964-0310-4df2-b1eb-8099b430a838', NULL, N'SO-3939531', N'PROD.', N'EngineOIL', N'KXT Engine Oil', N'25 liter Gallon of Engine Oil MotorMAX', N'engineOil_25Litre_Gallon', N'Gallon', CAST(16900.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(1419.60 AS Decimal(10, 2)), CAST(12700.00 AS Decimal(18, 2)), CAST(0xC23B0B00 AS Date), CAST(10.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'1c3d826e-701a-416e-925a-ebdba3d7fff4', NULL, N'SO-5843700', N'SERV', N'000a5-service-packaging', N'000A5 Service Packaging', N'10g Packaging', N'629e3339-3759-473e-8b2b-599aefe9aac6', N'g', CAST(400.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(0.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'3a61869d-6fad-4f5a-91d5-2d195ef4266e', NULL, N'SO-5843700', N'PROD.', N'1200444566', N'Blackberry Smart Phone QWERTY Keyboard', N'Bold 5 model 11900', N'64c27dc8-efb9-4ac6-af17-41d66d0ade12', N'Unit', CAST(58300.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(45600.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(3.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'3bda46a9-5e89-4a8c-a92d-347fa7adf8ae', NULL, N'SO-3939531', N'PROD.', N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', N'Carrot Orange Gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', N'Dozen', CAST(15500.00 AS Decimal(18, 2)), CAST(20.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(4340.00 AS Decimal(10, 2)), CAST(13000.00 AS Decimal(18, 2)), CAST(0xC23B0B00 AS Date), CAST(28.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'499fcabd-987c-4d58-9f12-5571c8c4c340', NULL, N'SO-24612', N'PROD.', N'1200444566', N'Blackberry Smart Phone QWERTY Keyboard', N'London Used Bold 5', N'e422aae7-2c49-4d09-9df1-26a2c6098879', N'Unit', CAST(34500.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(0xC43B0B00 AS Date), CAST(6.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'5a7c92dc-4527-49cc-b71a-00eda1f873dc', NULL, N'SO-5843700', N'PROD.', N'1200444566', N'Blackberry Smart Phone QWERTY Keyboard', N'Curve 9001', N'2408c82e-8768-4340-a36f-113c1a76e48c', N'Unit', CAST(42200.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(35500.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(5.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'65951919-6232-4c90-81bb-63853063cacb', NULL, N'SO-3939531', N'PROD.', N'889f8b06-a584-43b1-a188-637a0881d571', N'Blackgoon Designer Jean', N'Blackgoon XL', N'1293a03f-d4c8-4bd6-b217-6c6371c39ea8', N'Pair', CAST(9000.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(4500.00 AS Decimal(18, 2)), CAST(0xC23B0B00 AS Date), CAST(12.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'7294075d-c5f4-404d-bec1-8a649bec4c5b', NULL, N'SO-24612', N'PROD.', N'iman-bb-lotion', N'IMAN  BB Lotion', N'Normal Lotion', N'cb63eb84-e4b6-45f1-9b89-7a4a4f044171', N'Psc', CAST(1600.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(0xC43B0B00 AS Date), CAST(0.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'805d2d01-fe56-4fef-b05e-d9827fadf03e', NULL, N'SO-1335151', N'PROD.', N'mac_shower_gel', N'M.A.C Shower Gel With Goat Milk', N'Carrot Orange Gel', N'5757c5f2-fa3c-46f4-a1d0-1c593e133280', N'Dozen', CAST(15500.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(13000.00 AS Decimal(18, 2)), CAST(0xC13B0B00 AS Date), CAST(30.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_order_item] ([id], [attachedCode], [sales_order_id], [item_type], [item_id], [item_desc], [storage_type_tag], [storage_type_id], [unit_measure], [unit_price], [qty], [tax], [discount], [item_cost_price], [date_sold], [unit_b4_sales], [note], [discount_policy_label], [discount_policy_id], [tax_code]) VALUES (N'9c7f8b19-a9d9-4a8b-888d-03280eec18f0', NULL, N'SO-24612', N'PROD.', N'dell-xps-14-with-5th-gen-intel-core-processor', N'Dell Xps 14 With 5th Gen Intel Core Processor', N'8GB RAM 760GB Storage 5th Gen core i7', N'28735284-222e-4b1d-aaa8-d4a85c3a974d', N'Unit', CAST(213000.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(14, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(170000.00 AS Decimal(18, 2)), CAST(0xC43B0B00 AS Date), CAST(4.00 AS Decimal(14, 2)), NULL, NULL, NULL, NULL)
INSERT [dbo].[sales_payment_detail] ([id], [date_recieved], [amt_received], [received_by], [payment_method], [paid_into_account], [payment_info_id], [account_ref_code], [remark], [isApproved], [approved_by], [approval_note], [dateApproved], [evidence_image_url], [createdAtChannelId]) VALUES (N'09658561-c20b-467b-a00b-ab8bdfd110da', CAST(0x0000A666007748FC AS DateTime), CAST(88100.00 AS Decimal(18, 2)), N'alfred', N'CASH', NULL, N'a6a0bdbc-089d-4bdf-82d5-0b13efc3bad9', N'00001', N'ORG_CODE_0001', 1, NULL, NULL, CAST(0x0000A666007748FC AS DateTime), NULL, N'ORG_CODE_0001')
INSERT [dbo].[sales_payment_detail] ([id], [date_recieved], [amt_received], [received_by], [payment_method], [paid_into_account], [payment_info_id], [account_ref_code], [remark], [isApproved], [approved_by], [approval_note], [dateApproved], [evidence_image_url], [createdAtChannelId]) VALUES (N'cc3fb99f-836a-4fd1-aeff-6283cf627257', CAST(0x0000A6670133ED45 AS DateTime), CAST(441640.00 AS Decimal(18, 2)), N'alfred', N'CASH', NULL, N'bc412bf4-55d5-4b14-b98a-f47843295857', N'00001', N'ORG_CODE_0001', 1, NULL, NULL, CAST(0x0000A6670133ED45 AS DateTime), NULL, N'ORG_CODE_0001')
INSERT [dbo].[sales_payment_detail] ([id], [date_recieved], [amt_received], [received_by], [payment_method], [paid_into_account], [payment_info_id], [account_ref_code], [remark], [isApproved], [approved_by], [approval_note], [dateApproved], [evidence_image_url], [createdAtChannelId]) VALUES (N'd450ab04-5ace-4726-b4da-9e2b8fa5e84e', CAST(0x0000A669007AE2DE AS DateTime), CAST(180000.00 AS Decimal(18, 2)), N'somkene', N'CASH', NULL, N'00524e18-21ef-4fce-8afc-ec7bd6404403', N'00001', N'0002_AKWA', 1, NULL, NULL, CAST(0x0000A669007AE2DE AS DateTime), NULL, N'0002_AKWA')
INSERT [dbo].[sales_payment_detail] ([id], [date_recieved], [amt_received], [received_by], [payment_method], [paid_into_account], [payment_info_id], [account_ref_code], [remark], [isApproved], [approved_by], [approval_note], [dateApproved], [evidence_image_url], [createdAtChannelId]) VALUES (N'fb075765-68ec-4afd-bc6c-3b23974b7758', CAST(0x0000A66600732C1B AS DateTime), CAST(143100.00 AS Decimal(18, 2)), N'alfred', N'CASH', NULL, N'519da084-2d73-4e5f-baf9-0ef038844773', N'00001', N'ORG_CODE_0001', 1, NULL, NULL, CAST(0x0000A66600732C1B AS DateTime), NULL, N'ORG_CODE_0001')
INSERT [dbo].[sales_payment_info] ([id], [channel_id], [description], [trans_code], [trans_type], [trans_date], [trans_total], [payment_status], [created_by]) VALUES (N'00524e18-21ef-4fce-8afc-ec7bd6404403', N'0002_AKWA', N'Payment record for Sales Order: SO-24612 for Iyke Fedinald', N'SO-24612', N'SALES', CAST(0x0000A669008B5D84 AS DateTime), CAST(285200.00 AS Decimal(18, 2)), N'PART PAYMENT', N'somkene')
INSERT [dbo].[sales_payment_info] ([id], [channel_id], [description], [trans_code], [trans_type], [trans_date], [trans_total], [payment_status], [created_by]) VALUES (N'519da084-2d73-4e5f-baf9-0ef038844773', N'ORG_CODE_0001', N'Payment record for Sales Order: SO-5843700 for Jacob Zuma', N'SO-5843700', N'SALES', CAST(0x0000A6660083A6B2 AS DateTime), CAST(143100.00 AS Decimal(18, 2)), N'PAID', N'alfred')
INSERT [dbo].[sales_payment_info] ([id], [channel_id], [description], [trans_code], [trans_type], [trans_date], [trans_total], [payment_status], [created_by]) VALUES (N'a6a0bdbc-089d-4bdf-82d5-0b13efc3bad9', N'ORG_CODE_0001', N'Payment record for Sales Order: SO-1335151 for Greenhouse church', N'SO-1335151', N'SALES', CAST(0x0000A6660087C3B1 AS DateTime), CAST(88100.00 AS Decimal(18, 2)), N'PAID', N'alfred')
INSERT [dbo].[sales_payment_info] ([id], [channel_id], [description], [trans_code], [trans_type], [trans_date], [trans_total], [payment_status], [created_by]) VALUES (N'bc412bf4-55d5-4b14-b98a-f47843295857', N'ORG_CODE_0001', N'Payment record for Sales Order: SO-3939531 for Nnayelugo Obialo', N'SO-3939531', N'SALES', CAST(0x0000A667014467E2 AS DateTime), CAST(441640.00 AS Decimal(18, 2)), N'PAID', N'alfred')
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_itrex_auth_rolePermission]    Script Date: 8/23/2016 2:07:49 PM ******/
ALTER TABLE [dbo].[itrex_auth_rolePermission] ADD  CONSTRAINT [PK_itrex_auth_rolePermission] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_itrex_auth_userRole]    Script Date: 8/23/2016 2:07:49 PM ******/
ALTER TABLE [dbo].[itrex_auth_usersInRole] ADD  CONSTRAINT [PK_itrex_auth_userRole] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_item_definition_store]    Script Date: 8/23/2016 2:07:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_org_item_definition_store] ON [dbo].[org_item_definition_store]
(
	[name] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_media_store]    Script Date: 8/23/2016 2:07:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_org_media_store] ON [dbo].[org_media_store]
(
	[media_owner_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_org_warehouse_stock_doc]    Script Date: 8/23/2016 2:07:49 PM ******/
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
