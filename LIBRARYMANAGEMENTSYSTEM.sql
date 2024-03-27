USE master
GO
DROP  DATABASE IF EXISTS Library
GO
CREATE DATABASE Library
go
--create login for project database

CREATE LOGIN [TAMZID] WITH PASSWORD=N'123456', DEFAULT_DATABASE=Library
GO


ALTER SERVER ROLE [dbcreator] ADD MEMBER [TAMZID]
GO

USE Library
GO
--create user for project database
CREATE USER [TAMZID] FOR LOGIN [TAMZID] WITH DEFAULT_SCHEMA = [dbo]
GO
grant select, insert , update, delete, execute
on schema:: dbo
to [TAMZID]
GO
USE Library
CREATE TABLE Books 
(
BookID INT PRIMARY KEY , 
Title VARCHAR(30) , 
PublisherName VARCHAR(30)
);

CREATE TABLE Authors 
(
BookID INT REFERENCES Books (BookID)  ,
AuthorName VARCHAR(30)
);

CREATE TABLE Borrower 
(
CardNo INT PRIMARY KEY ,
Name VARCHAR(30) ,
Address VARCHAR(50) NULL ,
Phone VARCHAR(10) NULL
);

CREATE TABLE Branch 
(
BranchID INT PRIMARY KEY ,
BranchName VARCHAR(30) ,
Address VARCHAR(30)
);
CREATE TABLE Copies 
(
BookID INT REFERENCES Books (BookID) ,
BranchID INT REFERENCES Branch (BranchID),
No_Of_Copies INT
);
CREATE TABLE Loans 
(
BookID INT REFERENCES Books (BookID),
BranchID INT REFERENCES Branch (BranchID) ,
CardNo INT REFERENCES Borrower (CardNo) ,
DateOut DATE ,
DueDate DATE
);
CREATE TABLE Publisher 
(
Name VARCHAR(30) ,
Address VARCHAR(30) NULL ,
Phone VARCHAR(15) NULL
)

GO

 --create index
CREATE INDEX BOOK_index
ON BOOKS([BookID],[Title],[PublisherName]);

GO

CREATE PROC spInsertBook
@BookID INT ,
@Title VARCHAR(50) ,
@PublisherName VARCHAR(30) =NULL
AS 
INSERT INTO Books
VALUES (@BookID,@Title, @PublisherName)

EXEC spInsertBook @BookID =01, @Title = 'The Lost Tribe',           @PublisherName = 'Jungle';
EXEC spInsertBook @BookID =02, @Title =	'How to Sew Buttons',       @PublisherName = 'Singer';
EXEC spInsertBook @BookID =03, @Title =	'The Terrible Night',       @PublisherName = 'GST';
EXEC spInsertBook @BookID =04, @Title =	'Mindy''s Mittens',         @PublisherName = 'Newton';
EXEC spInsertBook @BookID =05, @Title =	'Pizza and Donuts Diet',    @PublisherName = 'Loyly';
EXEC spInsertBook @BookID =06, @Title =	'101 Cat House Plans',      @PublisherName = 'Mews';
EXEC spInsertBook @BookID =07, @Title =	'Self-Help for Dummies',    @PublisherName = 'Dada';
EXEC spInsertBook @BookID =08, @Title =	'Land of Lemurs',           @PublisherName = 'Barr';
EXEC spInsertBook @BookID =09, @Title =	'Go For It!',               @PublisherName = 'Higham';
EXEC spInsertBook @BookID =10, @Title =	'Farming for Nerds',       	@PublisherName = 'Ten Ton';
EXEC spInsertBook @BookID =11, @Title =	'They Are Us',             	@PublisherName = 'Cosmo';
EXEC spInsertBook @BookID =12, @Title =	'Here We Go!',             	@PublisherName = 'Hello';
EXEC spInsertBook @BookID =13, @Title =	'Spanish for Nurses',      	@PublisherName = 'ANAA';
EXEC spInsertBook @BookID =14, @Title =	'Tacos Everyday',          	@PublisherName = 'Chance';
EXEC spInsertBook @BookID =15, @Title =	'One Minute Rule',         	@PublisherName = 'BizBooks';
EXEC spInsertBook @BookID =16, @Title =	'Apples to Oranges',       	@PublisherName = 'Famous';
EXEC spInsertBook @BookID =17, @Title =	'Tiger Mountain',          	@PublisherName = 'North';
EXEC spInsertBook @BookID =18, @Title =	'How Cookies Crumble',     	@PublisherName = 'Bibi';
EXEC spInsertBook @BookID =19, @Title =	'Bridge to Yesterday',     	@PublisherName = '1999';
EXEC spInsertBook @BookID =20, @Title =	'The Lemonade Stand',      	@PublisherName = 'Yaya';
EXEC spInsertBook @BookID =21, @Title =	'Hello World',             	@PublisherName = 'OOL';
EXEC spInsertBook @BookID =22, @Title =	'Yoga for Moms',           	@PublisherName = 'Hatha';
EXEC spInsertBook @BookID =23, @Title =	'The Red Balloon',         	@PublisherName = 'JKL';
EXEC spInsertBook @BookID =24, @Title =	'Make Art Not War',       	@PublisherName = 'Phantom';
EXEC spInsertBook @BookID =25, @Title =	'War of Words',          	@PublisherName = 'Trope';
EXEC spInsertBook @BookID =26, @Title =	'Green Smoothies for Kids',	@PublisherName = 'Pops';
EXEC spInsertBook @BookID =27, @Title =	'History of Jars',         	@PublisherName = 'Glass';
EXEC spInsertBook @BookID =28, @Title =	'365 Dinner Ideas',        	@PublisherName = 'Grub';
EXEC spInsertBook @BookID =29, @Title =	'Untitled Champion',       	@PublisherName = 'Hart';
EXEC spInsertBook @BookID =30, @Title =	'Running in Thailand',     	@PublisherName = 'Bangkok';

GO

CREATE PROC spInsertAuthor
@BookID int,
@AuthorName varchar(30)
AS
INSERT INTO Authors
VALUES (@BookID,@AuthorName)

EXEC spInsertAuthor @BookID = 01 , @AuthorName = 'John Smyth';
EXEC spInsertAuthor @BookID = 02 , @AuthorName = 'Jane Do';
EXEC spInsertAuthor @BookID = 03 , @AuthorName = 'Eleanor Mellors';
EXEC spInsertAuthor @BookID = 04 , @AuthorName = 'Heidi Holly';
EXEC spInsertAuthor @BookID = 05 , @AuthorName = 'Chef Jeff';
EXEC spInsertAuthor @BookID = 06 , @AuthorName = 'Bart Brat';
EXEC spInsertAuthor @BookID = 07 , @AuthorName = 'Jen Jones';
EXEC spInsertAuthor @BookID = 08 , @AuthorName = 'Carol Sims';
EXEC spInsertAuthor @BookID = 09 , @AuthorName = 'Li Li';
EXEC spInsertAuthor @BookID = 10 , @AuthorName = 'Dr. Dirt';
EXEC spInsertAuthor @BookID = 11 , @AuthorName = 'Mantek Klem';
EXEC spInsertAuthor @BookID = 12 , @AuthorName = 'Kit Townsend';
EXEC spInsertAuthor @BookID = 13 , @AuthorName = 'Laura Lloras';
EXEC spInsertAuthor @BookID = 14 , @AuthorName = 'Sara Carr';
EXEC spInsertAuthor @BookID = 15 , @AuthorName = 'Jens Kopek';
EXEC spInsertAuthor @BookID = 16 , @AuthorName = 'Jim Jordan';
EXEC spInsertAuthor @BookID = 17 , @AuthorName = 'Silas Lambert';
EXEC spInsertAuthor @BookID = 18 , @AuthorName = 'Barbara Bull';
EXEC spInsertAuthor @BookID = 19 , @AuthorName = 'Dan Bland';
EXEC spInsertAuthor @BookID = 20 , @AuthorName = 'Stephen King'
EXEC spInsertAuthor @BookID = 21 , @AuthorName = 'A. Nonymous'

GO

CREATE PROC spInsertBorrower
@CardNo INT,
@Name VARCHAR(50),
@Address VARCHAR(50),
@Phone VARCHAR(10)=NULL
AS 
INSERT INTO Borrower
VALUES (@CardNo,@Name,@Address,@Phone)

EXEC spInsertBorrower @CardNo = 01 , @Name = 'Charlie Brown', @Address = '27 Main St'       ,  @Phone = '555-5123';
EXEC spInsertBorrower @CardNo = 02 , @Name = 'Rachel Rigby',  @Address = '101 Hwy 22'       ,  @Phone = '688-7711';
EXEC spInsertBorrower @CardNo = 03 , @Name = 'Nancy Drew',    @Address = '5678 Oak St'      ,  @Phone = '555-3467';
EXEC spInsertBorrower @CardNo = 04 , @Name = 'Derek Jones',   @Address = '6789 Ritmo Cir'   ,  @Phone = '222-1234';
EXEC spInsertBorrower @CardNo = 05 , @Name = 'Howie Han',     @Address = '111 First Ave'    ,  @Phone = '234-5678';
EXEC spInsertBorrower @CardNo = 06 , @Name = 'Tim Tegulpas',  @Address = '432 Nebraska Ave' ,  @Phone = '987-6543';
EXEC spInsertBorrower @CardNo = 07 , @Name = 'Sam Semel',     @Address = '7688 Hedge Ct'    ,  @Phone = '777-9898';
EXEC spInsertBorrower @CardNo = 08 , @Name = 'Evan Mann',     @Address = '4545 Court St'    ,  @Phone = '899-9090';
EXEC spInsertBorrower @CardNo = 09 , @Name = 'Sally Short',   @Address = '323 Remington St' ,  @Phone = '767-8991';
EXEC spInsertBorrower @CardNo = 10 , @Name = 'Bob Biggs',     @Address = '227 South St'     ,  @Phone = '767-8992'

GO

CREATE PROC spInsertBranch
@BranchID INT,
@BranchName VARCHAR(30),
@Address VARCHAR(50)
AS
INSERT INTO Branch
VALUES (@BranchID,@BranchName,@Address)

EXEC spInsertBranch @BranchID = 1, @BranchName = 'Central'    , @Address = '10 Main St';
EXEC spInsertBranch @BranchID = 2, @BranchName = 'Sharpstown' , @Address = '25 Pine St';
EXEC spInsertBranch @BranchID = 3, @BranchName = 'River'      , @Address = '333 River Rd';
EXEC spInsertBranch @BranchID = 4, @BranchName = 'Field'      , @Address = '45 Field St'

GO	

CREATE PROC spInsertCopies
@BookID INT,
@BranchID INT,
@No_Of_Copies INT
AS
INSERT INTO Copies
VALUES (@BookID,@BranchID,@No_Of_Copies)

EXEC spInsertCopies @BookID = 01 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 01 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 02 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 03 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 04 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 05 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 06 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 07 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 08 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 09 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 10 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 11 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 12 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 13 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 14 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 15 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 16 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 17 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 18 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 19 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 20 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 21 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 22 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 23 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 24 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 25 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 26 , @BranchID = 02 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 27 , @BranchID = 03 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 28 , @BranchID = 04 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 29 , @BranchID = 01 , @No_Of_Copies = 02;
EXEC spInsertCopies @BookID = 30 , @BranchID = 02 , @No_Of_Copies = 02
								 
GO

CREATE PROC spInsertLoans
@BookID INT,
@BranchID INT,
@CardNo INT,
@DateOut DATE,
@DueDate DATE
AS
INSERT INTO Loans
VALUES (@BookID,@BranchID,@CardNo,@DateOut,@DueDate)

EXEC spInsertLoans @BookID = 01 , @BranchID = 01 , @CardNo = 04 , @DateOut = '2023-08-19' , @DueDate = '2023-09-19';
EXEC spInsertLoans @BookID = 02 , @BranchID = 02 , @CardNo = 04 , @DateOut = '2023-08-19' , @DueDate = '2023-09-19';
EXEC spInsertLoans @BookID = 03 , @BranchID = 03 , @CardNo = 04 , @DateOut = '2023-08-19' , @DueDate = '2023-09-19';
EXEC spInsertLoans @BookID = 04 , @BranchID = 04 , @CardNo = 04 , @DateOut = '2023-08-19' , @DueDate = '2023-09-19';
EXEC spInsertLoans @BookID = 05 , @BranchID = 01 , @CardNo = 04 , @DateOut = '2023-08-19' , @DueDate = '2023-09-19';
EXEC spInsertLoans @BookID = 06 , @BranchID = 02 , @CardNo = 02 , @DateOut = '2023-09-18' , @DueDate = '2023-10-18';
EXEC spInsertLoans @BookID = 07 , @BranchID = 03 , @CardNo = 02 , @DateOut = '2023-09-18' , @DueDate = '2023-10-18';
EXEC spInsertLoans @BookID = 08 , @BranchID = 04 , @CardNo = 02 , @DateOut = '2023-09-18' , @DueDate = '2023-10-18';
EXEC spInsertLoans @BookID = 09 , @BranchID = 01 , @CardNo = 02 , @DateOut = '2023-09-18' , @DueDate = '2023-10-18';
EXEC spInsertLoans @BookID = 10 , @BranchID = 02 , @CardNo = 02 , @DateOut = '2023-09-18' , @DueDate = '2023-10-18';
EXEC spInsertLoans @BookID = 11 , @BranchID = 03 , @CardNo = 05 , @DateOut = '2023-09-11' , @DueDate = '2023-10-11';
EXEC spInsertLoans @BookID = 12 , @BranchID = 04 , @CardNo = 05 , @DateOut = '2023-09-11' , @DueDate = '2023-10-11';
EXEC spInsertLoans @BookID = 13 , @BranchID = 01 , @CardNo = 05 , @DateOut = '2023-09-11' , @DueDate = '2023-10-11';
EXEC spInsertLoans @BookID = 14 , @BranchID = 02 , @CardNo = 03 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 15 , @BranchID = 03 , @CardNo = 09 , @DateOut = '2023-09-11' , @DueDate = '2023-10-11';
EXEC spInsertLoans @BookID = 16 , @BranchID = 04 , @CardNo = 01 , @DateOut = '2023-05-12' , @DueDate = '2023-06-12';
EXEC spInsertLoans @BookID = 17 , @BranchID = 01 , @CardNo = 06 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 18 , @BranchID = 02 , @CardNo = 06 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 19 , @BranchID = 03 , @CardNo = 06 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 20 , @BranchID = 04 , @CardNo = 07 , @DateOut = '2023-09-12' , @DueDate = '2023-10-12';
EXEC spInsertLoans @BookID = 21 , @BranchID = 01 , @CardNo = 07 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 01 , @BranchID = 02 , @CardNo = 07 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 02 , @BranchID = 03 , @CardNo = 07 , @DateOut = '2023-09-13' , @DueDate = '2023-10-13';
EXEC spInsertLoans @BookID = 04 , @BranchID = 04 , @CardNo = 09 , @DateOut = '2023-09-09' , @DueDate = '2023-10-09';
EXEC spInsertLoans @BookID = 05 , @BranchID = 01 , @CardNo = 09 , @DateOut = '2023-09-09' , @DueDate = '2023-10-09';
EXEC spInsertLoans @BookID = 06 , @BranchID = 02 , @CardNo = 09 , @DateOut = '2023-09-09' , @DueDate = '2023-10-09';
EXEC spInsertLoans @BookID = 07 , @BranchID = 03 , @CardNo = 08 , @DateOut = '2023-09-10' , @DueDate = '2023-10-10';
EXEC spInsertLoans @BookID = 08 , @BranchID = 04 , @CardNo = 08 , @DateOut = '2023-09-10' , @DueDate = '2023-10-10';
EXEC spInsertLoans @BookID = 09 , @BranchID = 01 , @CardNo = 04 , @DateOut = '2023-09-08' , @DueDate = '2023-10-08';
EXEC spInsertLoans @BookID = 10 , @BranchID = 02 , @CardNo = 04 , @DateOut = '2023-09-08' , @DueDate = '2023-10-08';
EXEC spInsertLoans @BookID = 11 , @BranchID = 03 , @CardNo = 04 , @DateOut = '2023-09-08' , @DueDate = '2023-10-08';
EXEC spInsertLoans @BookID = 12 , @BranchID = 04 , @CardNo = 04 , @DateOut = '2023-09-08' , @DueDate = '2023-10-08';
EXEC spInsertLoans @BookID = 13 , @BranchID = 01 , @CardNo = 03 , @DateOut = '2023-09-07' , @DueDate = '2023-10-07';
EXEC spInsertLoans @BookID = 14 , @BranchID = 02 , @CardNo = 03 , @DateOut = '2023-09-07' , @DueDate = '2023-10-07';
EXEC spInsertLoans @BookID = 15 , @BranchID = 03 , @CardNo = 03 , @DateOut = '2023-09-07' , @DueDate = '2023-10-07';
EXEC spInsertLoans @BookID = 16 , @BranchID = 04 , @CardNo = 02 , @DateOut = '2023-09-05' , @DueDate = '2023-10-05';
EXEC spInsertLoans @BookID = 17 , @BranchID = 01 , @CardNo = 02 , @DateOut = '2023-09-05' , @DueDate = '2023-10-05';
EXEC spInsertLoans @BookID = 18 , @BranchID = 02 , @CardNo = 02 , @DateOut = '2023-09-05' , @DueDate = '2023-10-05';
EXEC spInsertLoans @BookID = 19 , @BranchID = 03 , @CardNo = 05 , @DateOut = '2023-09-04' , @DueDate = '2023-10-04';
EXEC spInsertLoans @BookID = 20 , @BranchID = 04 , @CardNo = 05 , @DateOut = '2023-09-04' , @DueDate = '2023-10-04';
EXEC spInsertLoans @BookID = 21 , @BranchID = 01 , @CardNo = 05 , @DateOut = '2023-09-04' , @DueDate = '2023-10-04';
EXEC spInsertLoans @BookID = 22 , @BranchID = 02 , @CardNo = 05 , @DateOut = '2023-09-04' , @DueDate = '2023-10-04';
EXEC spInsertLoans @BookID = 23 , @BranchID = 03 , @CardNo = 05 , @DateOut = '2023-09-04' , @DueDate = '2023-10-04';
EXEC spInsertLoans @BookID = 24 , @BranchID = 04 , @CardNo = 08 , @DateOut = '2023-09-03' , @DueDate = '2023-10-03';
EXEC spInsertLoans @BookID = 25 , @BranchID = 01 , @CardNo = 08 , @DateOut = '2023-09-03' , @DueDate = '2023-10-03';
EXEC spInsertLoans @BookID = 26 , @BranchID = 02 , @CardNo = 08 , @DateOut = '2023-09-03' , @DueDate = '2023-10-03';
EXEC spInsertLoans @BookID = 27 , @BranchID = 03 , @CardNo = 01 , @DateOut = '2023-05-12' , @DueDate = '2023-06-12';
EXEC spInsertLoans @BookID = 28 , @BranchID = 04 , @CardNo = 01 , @DateOut = '2023-05-12' , @DueDate = '2023-06-12';
EXEC spInsertLoans @BookID = 29 , @BranchID = 01 , @CardNo = 01 , @DateOut = '2023-05-12' , @DueDate = '2023-06-12';
EXEC spInsertLoans @BookID = 30 , @BranchID = 02 , @CardNo = 01 , @DateOut = '2023-05-12' , @DueDate = '2023-06-12'

GO

CREATE PROC spInsertPublisher
@Name VARCHAR(30),
@Address VARCHAR(30)=NULL,
@Phone VARCHAR(15)=NULL
AS
INSERT INTO Publisher
VALUES (@Name,@Address,@Phone)

EXEC  spInsertPublisher  @Name = 'Singer',    @Address = 'Germany'       ,  @Phone = '017-1234560' ;
EXEC  spInsertPublisher  @Name = 'Newton',    @Address = 'Boston'        ,  @Phone = '017-1234561' ;
EXEC  spInsertPublisher  @Name = 'GST',       @Address = 'New York'      ,  @Phone = '017-1234562' ;
EXEC  spInsertPublisher  @Name = 'Loyly',     @Address = 'Boston'        ,  @Phone = '017-1234563' ;
EXEC  spInsertPublisher  @Name = 'Mews',      @Address = 'Berkeley'      ,  @Phone = '017-1234564' ;
EXEC  spInsertPublisher  @Name = 'Manx',      @Address = 'Paris'         ,  @Phone = '017-1234565' ;
EXEC  spInsertPublisher  @Name = 'Barr',      @Address = 'New York'      ,  @Phone = '017-1234566' ;
EXEC  spInsertPublisher  @Name = 'Higham',    @Address = 'London'        ,  @Phone = '017-1234567' ;
EXEC  spInsertPublisher  @Name = 'Ten Ton',   @Address = 'Oakland'       ,  @Phone = '017-1234568' ;
EXEC  spInsertPublisher  @Name = 'Cosmo',     @Address = 'Portland'      ,  @Phone = '017-1234569' ;
EXEC  spInsertPublisher  @Name = 'Hello',     @Address = 'San Francisco' ,  @Phone = '017-1234571' ;
EXEC  spInsertPublisher  @Name = 'ANAA',      @Address = 'Los Angeles' 	 ,  @Phone = '017-1234572' ;
EXEC  spInsertPublisher  @Name = 'Chance',    @Address = 'New York'		 ,  @Phone = '017-1234573' ;
EXEC  spInsertPublisher  @Name = 'Biz',       @Address = 'New York'		 ,  @Phone = '017-1234574' ;
EXEC  spInsertPublisher  @Name = 'Famous',    @Address = 'Long Island'	 ,  @Phone = '017-1234575' ;
EXEC  spInsertPublisher  @Name = 'North',     @Address = 'Hartford'		 ,  @Phone = '017-1234576' ;
EXEC  spInsertPublisher  @Name = 'Bibi',      @Address = 'Chicago'		 ,  @Phone = '017-1234577' ;
EXEC  spInsertPublisher  @Name = '1999',      @Address = 'Chicago'		 ,  @Phone = '017-1234578' ;
EXEC  spInsertPublisher  @Name = 'Yaya',      @Address = 'Berkeley'		 ,  @Phone = '017-1234579' ;
EXEC  spInsertPublisher  @Name = 'Sunshine',  @Address = 'Palo Alto'	 ,  @Phone = '017-1234570'



GO		

SELECT B.Title, Br.BranchName, C.No_Of_Copies
FROM Books B JOIN Copies C 
ON B.BookID=C.BookID
JOIN Branch Br 
ON C.BranchID=Br.BranchID
WHERE Br.BranchName='Sharpstown'
AND B.Title='The Lost Tribe'

SELECT Br.BranchName,C.No_Of_Copies
FROM Books B JOIN Copies C 
ON B.BookID=C.BookID
JOIN Branch Br 
ON C.BranchID=Br.BranchID
WHERE B.Title='The Lost Tribe'

SELECT BO.Name
FROM Borrower BO LEFT JOIN Loans L 
ON L.CardNo=BO.CardNo
WHERE L.BookID IS NULL

SELECT B.Title,Bo.Name,Bo.Address
FROM Loans L JOIN Branch Br 
ON L.BranchID=Br.BranchID
JOIN Borrower Bo 
ON L.CardNo=Bo.CardNo
JOIN Books B
ON L.BookID=B.BookID
WHERE BranchName='Sharpstown'
AND DueDate='2016-09-19'

SELECT BranchName, COUNT(BookID)
FROM Branch Br JOIN Loans L 
ON Br.BranchID=L.BranchID
GROUP BY BranchName

SELECT Bo.Name, Bo.Address, COUNT(BookID) AS NumberOfBooksOut
FROM Borrower Bo JOIN Loans L
ON Bo.CardNo=L.CardNo
GROUP BY Bo.Name, Bo.Address
HAVING COUNT(BookID)>5

SELECT B.Title, C.No_Of_Copies
FROM Books B JOIN Authors A 
ON B.BookID=A.BookID
JOIN Copies C ON C.BookID=B.BookID
JOIN Branch Br ON C.BranchID=Br.BranchID
WHERE A.AuthorName='Stephen King' AND Br.BranchName='Central'

GO

--Stored procedure for query NO-1, get number of copies of a book at a branch:
 
CREATE PROC spGetCopiesAtBranch
@BranchName varchar(30), @Title varchar(30)
AS
	SELECT B.Title, Br.BranchName, C.No_Of_Copies
	FROM Books B JOIN Copies C ON B.BookID=C.BookID
	JOIN Branch Br ON C.BranchID=Br.BranchID
	WHERE Br.BranchName LIKE '%'+@BranchName+'%'
	AND B.Title LIKE '%'+@Title+'%'

GO
-- TRIGGERS FOR INSERT AND UPDATE
CREATE TRIGGER BOOKS_INSERT_UPDATE
ON [dbo].[Books]
AFTER INSERT,UPDATE
AS
UPDATE [dbo].[Books]
SET [PublisherName] =UPPER([PublisherName])
WHERE [BookID] in (select [BookID] from inserted)

go

insert Books
values(31,'MongDU', 'Yang Jha')

GO
--SCALAR VALUED FUNCTION
CREATE FUNCTION fnBOOKS(@PUBLISHER VARCHAR(30))
    RETURNS INT
BEGIN
    RETURN (SELECT COUNT([PublisherName])
            FROM Books
            WHERE [PublisherName] =@PUBLISHER);
END;
go
SELECT  [dbo].[fnBOOKS] ('Jungle')

GO
--CREATE TRIGGER FOR DELETE FROM BOOKS TABLE
CREATE TABLE BOOKSARCHIVE
(BOOKID INT,
TITLE VARCHAR(30),
PUBLISHERNAME VARCHAR(30)
)
GO
CREATE TRIGGER BOOKS_DELETE
ON [Books]
AFTER DELETE
AS
INSERT INTO BOOKSARCHIVE 
(BOOKID,TITLE,PUBLISHERNAME)
SELECT [BookID],[Title],[PublisherName]
FROM Deleted;

GO
--VIEW FOR BOOKS TABLE
DROP VIEW IF EXISTS VBOOKS
GO
CREATE VIEW VBOOKS
WITH SCHEMABINDING
AS
SELECT [BookID],[Title],[PublisherName]
FROM [dbo].[Books]

GO
INSERT INTO [dbo].[VBOOKS]
    ([BookID],[Title],[PublisherName])
VALUES (32, 'MARTIAL PEAK', 'WU KANG');

UPDATE [dbo].[VBOOKS]
SET[PublisherName] = 'WU KUANG'
WHERE Title = 'MARTIAL PEAK';

DELETE FROM [dbo].[VBOOKS]
WHERE BookID =32;

GO

--CASE

SELECT NAME,
CASE [Address]
WHEN 'Germany' THEN 'OUT OF THE U.S.A.'
ELSE 'INSIDE OF U.S.A.'
END AS ADDRESSES
FROM [dbo].[Publisher]

GO

--RANKING FUNCTION
SELECT ROW_NUMBER()  OVER (PARTITION BY [Address] ORDER BY [Name]) AS ROWNUMBER
FROM [dbo].[Publisher]
SELECT RANK()  OVER (PARTITION BY [Address] ORDER BY [Name]) AS ROWNUMBER
FROM [dbo].[Publisher]
SELECT DENSE_RANK()  OVER (PARTITION BY [Address] ORDER BY [Name]) AS ROWNUMBER
FROM [dbo].[Publisher]
SELECT NTILE(2)  OVER (PARTITION BY [Address] ORDER BY [Name]) AS ROWNUMBER
FROM [dbo].[Publisher]

GO

--TABLE VALUED FUNCTION
DROP FUNCTION IF EXISTS FFBooks
GO
CREATE FUNCTION  FFBooks
(
@DATEOUT DATE =NULL
)
RETURNS TABLE
RETURN
(SELECT [BookID],COUNT([BranchName]) AS BRANCHES
FROM Loans AS L JOIN Branch AS B
ON L.BranchID=B.BranchID
WHERE [DateOut]>=ISNULL(@DATEOUT, GETDATE())
GROUP BY [BookID]);
go
SELECT *
FROM [dbo].[FFBooks] ('2023-09-18')

GO

--ANALYTIC FUNCTION
SELECT *,
FIRST_VALUE([Name]) OVER (ORDER BY [Address]) AS FNAME,
LAST_VALUE([Name]) OVER (ORDER BY [Address])AS LNAME,
LEAD([Name]) OVER (ORDER BY [Address])AS LENAME,
LAG ([Name]) OVER (ORDER BY [Address])AS LANAME
FROM [dbo].[Publisher]
GO
-- Create the tabular function
CREATE FUNCTION GetBooks()
RETURNS @bOOK TABLE
(
 BookID INT,
 Title VARCHAR(30),
 PublisherName VARCHAR(30)
 )
AS 
BEGIN
INSERT INTO @bOOK
SELECT BookID, Title, PublisherName FROM Books
RETURN
END

GO

CREATE FUNCTION GetBooks2()
 RETURNS  TABLE     
AS 

RETURN (SELECT BookID, Title, PublisherName FROM Books)

GO
--CTE
 
 with ROWCTE(NAME,ROWNO) as  
(  
SELECT NAME,
ROW_NUMBER() OVER(ORDER BY name ASC) AS ROWNO
FROM [dbo].[Publisher]
WHERE [Address] = 'New York'
)  
 
SELECT * FROM ROWCTE 

GO

--AGGREGATE FUNCTION WITH SUMMARIZE DATA
SELECT  AUTHORNAME, COUNT([BookID])AS AUTHORCOUNT
FROM Authors
GROUP BY AuthorName WITH ROLLUP;

SELECT  AUTHORNAME, COUNT([BookID])AS AUTHORCOUNT
FROM Authors
GROUP BY AuthorName WITH CUBE;

SELECT NAME, COUNT([Name])AS BORROWERCOUNT
FROM [dbo].[Borrower]
GROUP BY  GROUPING SETS(NAME);

SELECT [Name],
COUNT([Name]) OVER (PARTITION BY [Phone]) AS BORROW_OVER
FROM [dbo].[Borrower]