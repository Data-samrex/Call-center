use Callcenterdb;

			-- create customer table
CREATE TABLE Customers(
	[CustomerID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[Phone] [nvarchar](50) NULL,
	[BirthDate] [datetime] NULL,
	[Email] [nvarchar](50) NULL)

			-- create employee table
CREATE TABLE Employees(
	[EmployeeID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[Frist_name] [nvarchar](50) NOT NULL,
	[Last_name] [nvarchar](50) NOT NULL,
	[BirthDate] [datetime] NULL,
	[gender] [tinyint] NULL,
	[Job_title] [nvarchar](50) NULL,
	[Department] [nvarchar](50) NULL,
	[Salary] [int] NULL,
	[Hire_Date] [datetime] NULL,
	[email] [nvarchar](50) NULL,
	[Phone] [nvarchar](24) NULL,
	
	)

			-- create mobile plan
CREATE TABLE Mobile_plan(
	[PlanID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[PlanName] [nvarchar](20) NOT NULL,
	[MonthlyFee] [Int] NOT NULL,
	[Data_Allowance] [nvarchar](60) NULL,
	[Talktime_Allowance] [nvarchar](24) NULL,
	[Textmessage_Allowance] [nvarchar](24) NULL,
	
	);

			-- create products table
CREATE TABLE Products(
	[ProductID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[PlanID] [int] NOT NULL,
	[Model] [nvarchar](50) NUll,
	[Quantity] [int] NULL,
	[Price] [Int]  NULL,
	[Storage_Capacity] [nvarchar](20) NULL,

	CONSTRAINT fk_Products_PlanID
	 FOREIGN KEY (PlanID)
	 REFERENCES Mobile_Plan(PlanID)
	);

       -- create payments table
CREATE TABLE Transactions(
    [TransactionID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
    [CustomerID] [int] FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL,
    [ProductID] [int] FOREIGN KEY REFERENCES Products(ProductID) NULL,
    [EmployeeID] [int] FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
    [Upfront_payment] [Int]  NULL,
    [Remaining_bal] [Int]  NULL,
    [Payment_date] [datetime] NULL,
    [Payment_method] [nvarchar](50) NUll,
    [payment_status] [nvarchar](50) NUll,
		);

	-- create Order and service table
CREATE TABLE Orders_and_Services(
	[OrderID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] FOREIGN KEY REFERENCES Customers (CustomerID) NOT NULL,
	[PlanID] [int] FOREIGN KEY REFERENCES Mobile_plan(PlanID) NOT NULL,
	[ProductID] [int] FOREIGN KEY REFERENCES Products(ProductID) NULL,
	[Quantity] [int] NULL,
	[Activation Status] [nvarchar] (24) NULL,
	[Activation Date:] [nvarchar](24) NULL,
	
	);

			-- create Employee Performance Table
CREATE TABLE Employee_Performance(
	[EPID] [int] PRIMARY kEY IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
	[Call_Duration] [time] NULL,
	[Call_Outcome] [nvarchar](50) NULL,
	[Customer_Satisfaction] [int] NULL,
	[Call_Date] [datetime] NULL,
	[Call_Type] [nvarchar] (50) NULL,
	[Calls_abandoned] [int] NULL,
	[Performance_Rating] [int] NULL,

	);


	