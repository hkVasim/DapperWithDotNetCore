USE [master]
GO
/****** Object:  Database [EmployeeDB]    Script Date: 02-05-2020 02:18:12 PM ******/
CREATE DATABASE [EmployeeDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EmployeeDB.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeeDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\EmployeeDB_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeeDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECOVERY FULL 
GO
ALTER DATABASE [EmployeeDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmployeeDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'EmployeeDB', N'ON'
GO
USE [EmployeeDB]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Age] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vasim Pathan
-- Create date: 02/05/2020
-- Description:	Get Employee by Id
-- =============================================
create procedure [dbo].[DeleteEmployee]    
(    
	@EmployeeId int
)    
As    
BEGIN    
    
DELETE FROM Employee where EmployeeId = @EmployeeId
  
END   

GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeByID]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vasim Pathan
-- Create date: 02/05/2020
-- Description:	Get Employee by Id
-- =============================================
Create procedure [dbo].[GetEmployeeByID]   
@Id int 
AS    
BEGIN    
     SELECT * FROM Employee where EmployeeId = @Id   
END 

GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeList]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vasim Pathan
-- Create date: 02/05/2020
-- Description:	Get List of Employee
-- =============================================
Create procedure [dbo].[GetEmployeeList]    
AS    
BEGIN    
     SELECT * FROM Employee    
END 

GO
/****** Object:  StoredProcedure [dbo].[InsertEmployee]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vasim Pathan
-- Create date: 02/05/2020
-- Description:	Get Employee by Id
-- =============================================
create procedure [dbo].[InsertEmployee]    
(    
    @FirstName varchar(50),    
    @LastName varchar(50),    
    @Email varchar(50),    
    @Age int    
)    
As    
BEGIN    
    
INSERT INTO [dbo].[Employee]
           ([FirstName]
           ,[LastName]
           ,[Email]
           ,[Age])
     VALUES
           (
				@FirstName,
				@LastName,
				@Email,
				@Age
		   )
  
END   

GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 02-05-2020 02:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vasim Pathan
-- Create date: 02/05/2020
-- Description:	Get Employee by Id
-- =============================================
create procedure [dbo].[UpdateEmployee]    
(    
	@EmployeeId int,
    @FirstName varchar(50),    
    @LastName varchar(50),    
    @Email varchar(50),    
    @Age int    
)    
As    
BEGIN    
    
UPDATE [dbo].[Employee]
   SET [FirstName] = @FirstName
      ,[LastName] =  @LastName
      ,[Email] = @Email
      ,[Age] = @Age
 WHERE EmployeeId = @EmployeeId
  
END   

GO
USE [master]
GO
ALTER DATABASE [EmployeeDB] SET  READ_WRITE 
GO
