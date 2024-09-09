# Building a Database solution for a call centre
	
Before designing the database, it's crucial to have a clear understanding of the call center's specific needs and processes. This involves identifying the types of data that need to be stored, the relationships between different data entities, and the workflows that will interact with the database.

### Creating a Data Flow Diagram (DFD)
#### Level 0 DFD:

This high-level diagram provides an overview of the entire system.
It typically shows the major processes, data stores, and external entities involved.
For a call center, this might include processes like incoming calls, customer service, and reporting.
#### Level 1 DFD:

This diagram breaks down the Level 0 processes into more detailed subprocesses.
It shows the flow of data between these subprocesses and the data stores.
For a call center, Level 1 might include subprocesses like customer authentication, issue resolution, and call logging.
<img width="506" alt="ERD" src="https://github.com/Data-samrex/Call-center/blob/main/DFD%20level%200.PNG">

### Creating an Entity-Relationship Diagram (ERD)
Identify entities: These are the main objects or concepts that will be stored in the database. For a call center, entities might include:
Customer
Call
Agent
Issue
Resolution
Define attributes: These are the properties or characteristics of each entity. For example, the Customer entity might have attributes like customer ID, name, contact information, and purchase history.
Establish relationships: Determine how the entities relate to each other. For instance, a Customer entity might have a one-to-many relationship with the Call entity, meaning one customer can have many calls.
Create the ERD: Visually represent the entities and their relationships using standard ERD notation.

### ENTITY-RELATIONSHIP DIAGRAM (ERD)
An entity relationship diagram (ERD) serves as a comprehensive and structured depiction of data storage, showcasing the relationships and constraints that logically connect them. Its primary purpose is to organise data effectively, revealing the intricate relationships between entities within the schema. 


<img width="506" alt="ERD" src="https://github.com/user-attachments/assets/2b2d16d1-6e04-4b20-9b57-ac15c412abfc">

### Database Design and Implementation
Choose a database management system (DBMS): Select a suitable DBMS based on the scale of the database, performance requirements, and organizational preferences.
Create the database schema: Define the tables, columns, data types, and relationships based on the ERD.
Populate the database: Insert initial data into the tables.
Develop database applications: Create applications that interact with the database to perform tasks like data entry, retrieval, and updates.
### Testing and Optimization
Test the database: Thoroughly test the database to ensure it functions correctly and meets the requirements.
Optimize performance: Identify and address any performance bottlenecks to ensure the database can handle the expected workload.
Implement security measures: Protect the database from unauthorized access and data breaches.
By following these steps and tailoring the database design to the specific needs of the call center, you can create a robust and efficient solution for managing customer data and interactions.	

### CREATING DATABASE 
```sql

--delete db if it exists
IF DB_ID('Callcenterdb') IS NOT NULL	--check if db exists
	DROP DATABASE [Callcenterdb]
GO

--create db
IF DB_ID('Callcenterdb') IS NULL		--check if db does not exists
	CREATE DATABASE [Callcenterdb]
GO
```

### CREATING TABLES 
```sql

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
	
```
### POPULATING THE TABLES 
```sql

use Callcenterdb;

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Customers] ON
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(745813741,'Amory','McMenamin','7766 Roth Terrace','+4473982185432','1976/01/09','amcmenamin0@youtube.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(651152768,'Cheston','Van De Cappelle','437 Washington Center','+442721507811','1998/03/18','cvandecappelle1@ow.ly')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(795724745,'Biron','Berthouloume','1 Forest Run Crossing','+449008428177','1991/02/28','bberthouloume2@behance.net')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(34697856,'Bianca','Scallan','2455 Kensington Center','+442108911833','1977/10/11','boscallan3@hugedomains.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(608705670,'Bengt','Pamplin','44578 Northwestern Lane','+449251338035','1962/09/19','bpamplin4@youku.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(439669267,'Moll','Ottery','2091 Rieder Parkway','+446743175716','1997/09/19','mottery5@netvibes.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(527322811,'Terrance','Suaird','06563 Bashford Crossing','+444496609402','1995/08/24','tosuaird6@bravesites.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(628278858,'Ilysa','Tuxwell','7736 Sundown Alley','+443693785337','1986/09/01','ituxwell7@drupal.org')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(792873965,'Wilhelmina','Knotte','10 Northview Avenue','+448234159364','1996/10/12','wknotte8@woothemes.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(420544930,'Elenore','Dougary','2345 Mayfield Terrace','+446967068528','1963/12/15','edougary9@stumbleupon.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(916129275,'Guillaume','Goretti','303 Grim Street','+449686718150','1961/07/25','ggorettia@wordpress.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(221811479,'Morgana','Hansom','27080 Pearson Lane','+448358354460','1983/11/22','mhansomb@xing.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(906519860,'Loutitia','Crilly','483 Dixon Hill','+445942636078','1993/03/31','lcrillyc@weebly.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(820110712,'Ollie','Fridd','1508 Meadow Vale Center','+441659863215','1969/11/06','ofriddd@facebook.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(656737835,'Der','Gabey','41006 Helena Trail','+443986865458','1961/09/08','dgabeye@paypal.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(386045539,'Aubry','Taffee','91747 Vahlen Street','+447247348933','1976/12/30','ataffeef@networksolutions.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(189059293,'Heath','Robion','1194 Grover Crossing','+448093678620','1960/06/10','hrobiong@sohu.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(830847246,'Arv','Belden','856 Monica Parkway','+445194927462','1962/12/28','abeldenh@google.it')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(607091431,'Helen','Bernardotte','91724 Derek Terrace','+441766540064','1966/08/24','hbernardottei@hhs.gov')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(58184786,'Chadd','Parradine','9965 Ilene Center','+444242599599','1981/06/10','cparradinej@blogtalkradio.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(963816859,'Ephrem','Rustan','7002 Homewood Pass','+448293129814','1988/12/21','erustank@squidoo.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(65856761,'Noelle','Adnet','4708 Jana Place','+441694080114','2000/02/21','nadnetl@lulu.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(159433514,'Marta','Guillotin','77 Lyons Parkway','+444098962082','1973/08/12','mguillotinm@gizmodo.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(870732903,'Marysa','Charlet','868 Birchwood Place','+448965018425','1965/03/03','mcharletn@reference.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(448305269,'Douglass','Pisculli','3213 Spaight Alley','+442266557628','1980/09/01','dpiscullio@huffingtonpost.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(960865203,'Lucina','Carverhill','98031 Columbus Drive','+446042756536','1964/04/26','lcarverhillp@cpanel.net')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(623474771,'Web','Chilton','9525 Golf Course Junction','+449857758578','1974/06/13','wchiltonq@springer.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(316942274,'Wernher','Carr','2 Union Crossing','+441423075293','1962/07/14','wcarrr@phoca.cz')

INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(325476590,'Michele','Benes','4 Anniversary Point','+445408091006','1978/12/21','mbeness@feedburner.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(492630086,'Hobey','Mellmoth','7 Shelley Road','+444607414164','1979/04/09','hmellmotht@princeton.edu')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(123513514,'Damien','Otson','7439 Arkansas Junction','+449942608500','1964/09/09','dotsonu@noaa.gov')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(298226976,'Cornelle','Bossel','0909 Northview Lane','+447523960640','1987/06/06','cbosselv@pcworld.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(520951209,'Nonna','Gumbley','31 Sutteridge Crossing','+445839682383','1999/03/01','ngumbleyw@blogspot.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(122212060,'Moritz','Shotton','3 Summer Ridge Point','+446674697521','1987/09/22','mshottonx@ted.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(595112210,'Lindsay','Michal','41342 Grover Plaza','+441757550783','1964/08/27','lmichaly@china.com.cn')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(335071149,'Raffaello','Grice','634 Utah Hill','+442582085526','1966/06/19','rgricez@networksolutions.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(822395499,'Briney','Hacksby','9799 Surrey Way','+445299651621','1982/04/27','bhacksby10@bbb.org')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(723108961,'Nester','Anthonsen','85492 Dottie Lane','+449841077541','1998/07/28','nanthonsen11@scientificamerican.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(100124342,'Phip','Sleit','26439 Warrior Parkway','+441463501337','1987/03/14','psleit12@huffingtonpost.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(641629533,'Clemmy','Ehlerding','803 Walton Alley','+448255852232','1984/09/27','cehlerding13@mit.edu')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(199443599,'Elvina','Speakman','390 Longview Way','+442523580187','1991/10/02','espeakman14@spotify.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(336604371,'Kerrill','Daymond','216 Loomis Drive','+446797232947','1966/10/07','kdaymond15@alexa.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(78280375,'Phylys','Ratnage','33 Hermina Alley','+441076338240','1979/01/17','pratnage16@usatoday.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(595916963,'Sarina','Ladlow','3 Summit Avenue','+449906984620','1981/02/02','sladlow17@usda.gov')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(277105832,'Quintina','Lailey','9119 Golf View Drive','+449714508386','1991/04/29','qlailey18@yellowpages.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(337276553,'Margaret','Filyashin','616 Carey Circle','+443813130652','1961/09/15','mfilyashin19@theguardian.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(684053170,'Sibley','Glasbey','39 Memorial Plaza','+442672282566','1990/03/22','sglasbey1a@vistaprint.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(147726889,'Guendolen','Fowlestone','7411 Towne Plaza','+442856805764','1985/03/07','gfowlestone1b@apache.org')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(80920531,'Rriocard','Libbis','35647 John Wall Street','+445381900666','1997/04/30','rlibbis1c@jimdo.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(715134370,'Rab','Just','20 Banding Drive','+442151814284','1989/05/16','rjust1d@topsy.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(634154204,'Gifford','Teape','287 Waywood Lane','+448723772733','1977/05/14','gteape1e@time.com')
GO
INSERT INTO Customers ([CustomerID],[FirstName],[LastName],[Address],[Phone],[BirthDate],[Email]) Values(44848610,'Sabrina','Lulham','82 Mallory Parkway','+447287059746','1966/12/30','slulham1f@sourceforge.net')
GO
/* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Employees] ON
GO

INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(1,'Josi','Novkovic','1968/11/18',1,'Call Agent','Customer Service',£90531.16,'2020/09/30','jnovkovic0@wunderground.com','07498 362157')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(2,'Joella','Unthank',	'9/18/1980',1,'Data Coordinator','HR',£139281.95,'03/03/2011','junthank1@vkontakte.ru','07910 724 839')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(3,'Lorry','Dewes','10/29/1964',2,'Environmental Tech','HR',£50388.48,'5/29/2017','ldewes2@army.mil','07502 148 693')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(4,'Lorrie','Ulyet','5/14/1999',2,'Automation Specialist II','Finance',£31834.23,'08/12/2021','lulyet3@hugedomains.com','07856 431 207')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(5,'Rosaline','Poynton','10/08/1985',1,'Account Representative IV','HR',£120745.02,'10/03/2010','rpoynton4@adobe.com','07721 985 342')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(6,'Enid','McGirr','12/02/1973',1,'Clinical Specialist','Finance',£83593.97,'12/20/2018','emcgirr5@amazon.de','07634 019 578')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(7,'Lucian','Guite','07/01/1984',2,'Cost Accountant','IT',£83654.36,'07/12/2017','lguite6@yahoo.co.jp','07189 253 714')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(8,'Doroteya','Attwooll','5/30/1990',1,'Community Outreach Specialist','HR',£36770.27,'09/09/2011','dattwooll7@google.pl','07942 680 135')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(9,'Vanda','Meaney','10/09/1975',1,'Mechanical Systems Engineer','IT',£143832.67,'8/21/2018','vmeaney8@sakura.ne.jp','07597 314 861')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(10,'Abner','Yakovitch','8/20/1967',2,'Call Agent','Customer Service',£104790.64,'12/23/2014','ayakovitch9@mozilla.com','07820 547 296')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(11,'Mireielle','Pennazzi','11/08/1990',1,'Product Engineer','Marketing',£77373.79,'4/19/2013','mpennazzia@wufoo.com','07753 871 023')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(12,'Clemmie','Yukhnov','12/25/1994',2,'Call Agent','Customer Service',£135096.75,'01/03/2011','cyukhnovb@pagesperso-orange.fr','07606 104 358')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(13,'Wallie','Koenraad','2/24/1966',2,'Executive Secretary','Marketing',£56247.82,'5/15/2017','wkoenraadc@yellowpages.com','07139 437 184')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(14,'Ramsey','Gaskoin','12/20/1996',2,'VP Accounting','HR',£36638.83,'2/24/2021','rgaskoind@360.cn','07972 760 519')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(15,'Robb','De Cleyne','1/22/1980',2,'Call Agent','Customer Service',£134619.85,'04/06/2013','rdecleynee@independent.co.uk','07525 083 845')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(16,'Carly','Ironside','12/04/1989',2,'Structural Analysis Engineer','Marketing',£87707.20,'4/26/2012','cironsidef@mlb.com','07858 316 172')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(17,'Josefina','Duggan','6/15/1976',1,'Sales Associate','IT',£71055.56,'11/05/2012','jduggang@webmd.com','07701 649 407')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(18,'Debora','Attaway','6/26/1971',1,'Design Engineer','Finance',£65139.42,'3/21/2014','dattawayh@scribd.com','07634 972 730')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(19,'Archibaldo','Quainton','3/31/1994',2,'Occupational Therapist','Marketing',£49915.64,'6/22/2010','aquaintoni@nytimes.com','07167 206 056')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(20,'Lanae','Siddons','7/21/1988',1,'Project Manager','HR',£42161.12,'11/17/2016','lsiddonsj@google.cn','07900 539 383')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(21,'Darleen','Albery','05/06/1992',1,'Call Agent','Customer Service',£82651.67,'1/15/2018','dalberyk@dagondesign.com','07553 862 718')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(22,'Lyndel','Esmonde','9/20/1963',1,'Call Agent','Customer Service',£140168.56,'05/10/2010','lesmondel@yelp.com','07886 195 041')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(23,'Gustav','Guidelli','08/08/1996',2,'Environmental Tech','Marketing',£67720.99,'07/04/2013','gguidellim@aboutads.info','07731 428 374')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(24,'Conni','Mation','7/25/1997',1,'Speech Pathologist','HR',£40408.63,'03/02/2019','cmationn@home.pl','07664 751 609')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(25,'Pru','Alu','10/25/1975',1,'Programmer I','HR',£34471.80,'11/14/2019','paluo@dailymotion.com','07197 074 935')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(26,'Linnea','Usborn','10/22/1991',1,'Senior Editor','Marketing',£136595.06,'6/15/2010','lusbornp@e-recht24.de','07920 307 262')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(27,'Thorsten','Leyes','2/22/1978',2,'Call Agent','Customer Service',£147200.04,'07/06/2016','tleyesq@microsoft.com','07573 530 697')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(28,'Camella','Heggv','11/30/1985',1,'Senior Editor','Finance',£121327.31,'9/28/2021','cheggr@artisteer.com','07806 863 024')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(29,'Kimbell','Dyshart','4/29/1967',2,'Web Developer III','Finance',£124981.14,'6/19/2019','kdysharts@unc.edu','07749 196 351')
INSERT INTO Employees (EmployeeID,Frist_name,Last_name,BirthDate,gender,job_title,Department,Salary,Hire_Date,email,Phone) Values(30,'Carol-jean','Lovelady','8/16/1960',1,'Junior Executive','Finance',£74496.52,'07/04/2010','cloveladyt@soundcloud.com','07682 429 786')

/* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Mobile_plan] ON
GO

INSERT INTO Mobile_plan(PlanID,PlanName,MonthlyFee,Data_Allowance,Talktime_Allowance,Textmessage_Allowance) Values(1,'Bronze',45,'15GB','250 minutes','500')
INSERT INTO Mobile_plan(PlanID,PlanName,MonthlyFee,Data_Allowance,Talktime_Allowance,Textmessage_Allowance) Values(2,'Silver',55,'20GB','500 minutes','750')
INSERT INTO Mobile_plan(PlanID,PlanName,MonthlyFee,Data_Allowance,Talktime_Allowance,Textmessage_Allowance) Values(3,'Gold',60,'30GB','1000 minutes','1350')
INSERT INTO Mobile_plan(PlanID,PlanName,MonthlyFee,Data_Allowance,Talktime_Allowance,Textmessage_Allowance) Values(4,'Platinum',70,'Unlimited','Unlimited minutes','Unlimited' )

/* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Mobile_plan] OFF
GO

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Products] ON
GO
INSERT INTO Products (ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(748243,3,'Samsung s23',2642,£999,'128GB')
INSERT INTO Products(ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(843542,4,'Iphone 15 pro max',4954,£1199,'512GB')
INSERT INTO Products(ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(479491,1,'Samsung s20',7324,£190,'128GB')
INSERT INTO Products(ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(624522,4,'Iphone 15',3942,£1099,'512GB')
INSERT INTO Products(ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(348922,2,'Google Pixel',4873,£449,'128GB')
INSERT INTO Products(ProductID,PlanID,Model, Quantity,Price, Storage_Capacity) Values(542902,1,'Moto G34',2349,£150,'128GB')
	 /* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Products] OFF
GO

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Employee_Performance] ON
GO
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(1,1,'05:16:48','follow-up required',4,'12/28/2023','outbound',9,2)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(2,12,'04:33:36','successful',10,'5/23/2023','inbound',20,10)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(3,10,'14:24:00','follow-up required',9,'12/23/2023','outbound',12,4)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(4,22,'06:00:00','successful',7,'07/05/2023','outbound',10,10)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(5,15,'01:12:00','successful',9,'03/02/2024','outbound',7,10)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(6,27,'09:07:12','unsuccessful',5,'5/26/2023','outbound',1,10)
INSERT INTO Employee_Performance (EPID,EmployeeID,Call_Duration, Call_Outcome, Customer_Satisfaction, Call_Date, Call_Type, Calls_abandoned, Performance_Rating) Values(7,21,'06:00:00','unsuccessful',9,'02/08/2024','inbound',19,4)
	 /* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Employee_Performance] OFF
GO
--Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Transactions] ON
GO

INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (1, 34697856, 748243,1, 50, 949, 11/23/2022, 'credit card', 'failed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (2, 44848610, 843542,12, 78, 1121, 10/19/2022, 'debit card', 'pending');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (3, 58184786, 479491,10, 79, 111, 01/11/2022, 'credit card', 'processed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (4, 65856761, 624522,22, 53, 1046, 03/01/2022, 'bank transfer', 'pending');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (5, 78280375, 348922,1, 84, 365, 4/27/2022, 'debit card', 'processed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (6, 80920531, 542902,12, 70, 80, 01/08/2022, 'bank transfer', 'failed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (7, 100124342, 748243,10, 95, 904, 05/06/2022, 'bank transfer', 'failed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (8, 122212060, 843542,22, 92, 1107, 7/27/2022, 'bank transfer', 'failed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (9, 123513514, 479491,15, 90, 100, 12/16/2022, 'credit card', 'pending');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (10, 147726889, 624522,27, 63, 1036, 02/02/2022, 'debit card', 'failed');
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (11,159433514,348922,1,96,353,03/03/2022,'debit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (12,189059293,542902,10,66,84,1/24/2022,'credit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (13,199443599,348922,12,69,380,5/24/2022,'debit card','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (14,221811479,624522,22,91,1008,09/12/2022,'credit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (15,277105832,348922,15,96,353,09/03/2022,'debit card','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (16,298226976,542902,1,87,63,09/12/2022,'credit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (16,298226976,542902,12,87,63,09/12/2022,'credit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (16,298226976,542902,10,87,63,09/12/2022,'credit card','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (17,316942274,479491,22,54,136,7/13/2022,'credit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (18,325476590,624522,15,52,1047,08/07/2022,'bank transfer','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (19,335071149,348922,27,91,358,8/26/2022,'credit card','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (20,336604371,542902,21,97,53,2/17/2022,'bank transfer','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (21,337276553,843542,27,54,1145,6/17/2022,'credit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (22,386045539,479491,21,96,94,08/07/2022,'bank transfer','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (23,420544930,624522,1,98,1001,10/23/2022,'debit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (24,439669267,348922,12,76,373,9/27/2022,'bank transfer','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (25,448305269,748243,10,58,941,5/15/2022,'bank transfer','processed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (26,492630086,843542,22,100,1099,08/11/2022,'bank transfer','pending')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (27,520951209,479491,15,51,139,10/30/2022,'debit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (28,527322811,624522,27,83,1016,5/22/2022,'credit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (29,595112210,348922,1,81,368,12/21/2022,'debit card','failed')
INSERT INTO Transactions (TransactionID,CustomerID, ProductID, EmployeeID, Upfront_payment, Remaining_bal, Payment_date, Payment_method, payment_status) VALUES (30,595916963,542902,22,62,88,12/28/2022,'bank transfer','pending');

	 -- Turn Identity Insert OFF  
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO

/* Turn Identity Insert ON so records can be inserted in the Identity Column  */
SET IDENTITY_INSERT [dbo].[Orders_and_Services] ON
GO
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(1,34697856,4,843542,1,'completed','08/06/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(2,44848610,4,624522,1,'completed','07/04/2021')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(3,58184786,4,843542,1,'completed','26/05/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(4,65856761,4,843542,1,'completed','12/01/2021')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(5,78280375,4,624522,1,'processing','26/12/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(6,80920531,2,348922,1,'processing','16/10/2022')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(7,100124342,3,748243,1,'completed','22/01/2022')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(8,122212060,4,843542,1,'pending','01/09/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(9,123513514,1,479491,1,'completed','05/02/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(10,147726889,1,542902,1,'pending','04/10/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(11,159433514,4,843542,1,'completed','25/03/2021')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(12,189059293,2,348922,1,'completed','31/10/2021')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(13,199443599,4,843542,1,'processing','15/07/2021')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(14,221811479,3,748243,1,'processing','30/10/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(15,277105832,2,348922,1,'pending','13/01/2022')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(16,298226976,1,479491,1,'completed','14/03/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(17,316942274,2,348922,1,'processing','29/12/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(18,325476590,3,748243,1,'processing','01/04/2022')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(19,335071149,2,348922,1,'processing','08/04/2020')
INSERT INTO Orders_and_Services(OrderID,CustomerID, PlanID, ProductID, Quantity, [Activation Status], [Activation Date:]) Values(20,336604371,3,748243,1,'completed','27/09/2020')
     /* Turn Identity Insert OFF  */
SET IDENTITY_INSERT [dbo].[Orders_and_Services] OFF
GO


```
### SQL QUERY
```sql

use Callcenterdb;

--(1)Display first name, last name and phone number of customers who have their numbers end with ‘0’.
SELECT Firstname, LastName, Phone
FROM Customers
WHERE Phone LIKE '%0'

-- (2) Display all employees in Customer Service, HR, Marketing department.
SELECT *
FROM Employees
WHERE Department IN ('Customer Service', 'HR', 'Marketing');


--(3)Find all orders that are fully activated with the activation status completed
SELECT *
FROM Orders_and_Services
WHERE [Activation Status] = 'completed';


--(4)Find the most frequently ordered plan and give details about the plan ie plan name,  monthly fee, data allowance, talkime and text 
-- and arrange form the most frequent
SELECT mp.PlanID, mp.PlanName, mp.MonthlyFee, mp.Data_Allowance, 
       mp.Talktime_Allowance, mp.Textmessage_Allowance, COUNT(*) AS order_count
FROM Orders_and_Services ot
INNER JOIN Mobile_plan mp ON ot.PlanID = mp.PlanID
GROUP BY mp.PlanID, mp.PlanName, mp.MonthlyFee, mp.Data_Allowance, 
         mp.Talktime_Allowance, mp.Textmessage_Allowance
ORDER BY order_count DESC

--(5)Find the most recent order for each customer and display their fullname
SELECT c.CustomerID, CONCAT(cu.FirstName, ' ' ,cu.LastName) AS [Full Name] , o.OrderID, o.[Activation Date:]
FROM Orders_and_Services o
INNER JOIN Customers cu ON o.CustomerID = cu.CustomerID
INNER JOIN (
  SELECT cus.CustomerID, MAX([Activation Date:]) AS max_date
  FROM Orders_and_Services os
  INNER JOIN Customers cus ON os.CustomerID = cus.CustomerID  
  GROUP BY cus.CustomerID
) c ON o.CustomerID = c.CustomerID
AND o.[Activation Date:] = c.max_date;


-- (6)Find all employees who have made a successful transaction, the plan name and the amount paid upfront during the transactions.
SELECT e.EmployeeID, e.Frist_name, e.Last_name, p.PlanName, SUM(t.Upfront_payment) AS Total_Upfront_Payment
FROM Employees e
INNER JOIN Transactions t ON e.EmployeeID = t.EmployeeID
INNER JOIN Products pr ON t.ProductID = pr.ProductID
INNER JOIN Mobile_plan p ON pr.PlanID = p.PlanID  
WHERE t.payment_status = 'processed'  
GROUP BY e.EmployeeID, e.Frist_name, e.Last_name, p.PlanName
ORDER BY Total_Upfront_Payment DESC;

--  (7)Find all customers with their details, plan name, and upfront payment details for completed and processing orders.

SELECT c.CustomerID, c.FirstName, c.LastName, p.PlanName,
       t.Upfront_payment, t.Remaining_bal, o.[Activation Status]
FROM Customers c
INNER JOIN Orders_and_Services o ON c.CustomerID = o.CustomerID
INNER JOIN Transactions t ON o.CustomerID = t.CustomerID  
INNER JOIN Mobile_plan p ON o.PlanID = p.PlanID  
WHERE o.[Activation Status] IN ('completed', 'processing')
ORDER BY c.CustomerID, o.[Activation Status];

--(8) Calulate the monthly total revenue from each transation
SELECT
  o.CustomerID,  
  SUM(o.Quantity * mp.MonthlyFee) AS total_revenue
FROM Orders_and_Services o
INNER JOIN Mobile_plan mp ON o.PlanID = mp.PlanID
GROUP BY o.CustomerID; 

```
