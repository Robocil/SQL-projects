--use [Blood Bank Management System project]
--drop table BB_manager

-- Creating and inserting tables and data
CREATE TABLE BB_Manager
( M_id int NOT NULL Primary Key,
 mName varchar(max) NOT NULL,
 m_phNo bigint
);

INSERT into BB_Manager
VALUES(102,'Jack', 4693959671),
(103,'Peter', 4693959601),
(104,'Mark', 4693959677),
(105,'Jason', 4693957671),
(106,'Steve', 4694959671),
(107,'Jason', 4695959671),
(108,'Stella', 4663959671),
(109,'Monika', 4673959671),
(110,'John', 4693859671);

Insert into BB_Manager
Values (101, 'Daily', 4697369672)

select * from BB_Manager
----------------------------------------------------------------

CREATE TABLE Blood_Donor
( bd_ID int NOT NULL Primary Key,
 bd_name varchar(max) NOT NULL,
 bd_age varchar(max),
 bd_sex varchar(max),
 bd_Bgroup varchar(10),
 bd_reg_date date,
 reco_ID int NOT NULL,
 City_ID int NOT NULL
);INSERT into Blood_Donor
VALUES(150221,'Mark',25,'M','B+','2015-12-17',101212,1100),
(160011,'Abdul',35,'F','A+','2016-11-22',101212,1100),
(160101,'Smith',22,'M','O+','2016-01-04',101312,1200),
(150011,'Pat',29,'M','O+','2015-07-19',101412,1300),
(150021,'Shyam',42,'F','A-','2015-12-24',101412,1300),
(150121,'Dan',44,'M','AB+','2015-08-28',101212,1200),
(160031,'Mike',33,'F','AB-','2016-02-06',101212,1400),
(160301,'Elisa',31,'F','AB+','2016-09-10',101312,1200),
(160091,'Carrol',24,'M','B-','2016-10-15',101312,1500),
(160401,'Mark',29,'M','O-','2016-12-17',101212,1200);
select * from Blood_Donor------------------------------------------------------------------------------------Drop table Bloodspecimen
CREATE TABLE BloodSpecimen
( specimen_number int  NOT NULL,
 b_group varchar (10) NOT NULL,
 status int,
 dfind_ID int NOT NULL,
 M_id int NOT NULL
 Primary Key (specimen_number, b_group)
);INSERT into BloodSpecimen
VALUES(1001, 'B+', 1,11,101),
(1002, 'O+', 1,12,102),
(1003, 'AB+', 1,11,102),
(1004, 'O-', 1,13,103),
(1005, 'A+', 0,14,101),
(1006, 'A-', 1,13,104),
(1007, 'AB-', 1,15,104),
(1008, 'AB-', 0,11,105),
(1009, 'B+', 1,13,105),
(1010, 'O+', 0,12,105),
(1011, 'O+', 1,13,103),
(1012, 'O-', 1,14,102),
(1013, 'B-', 1,14,102),
(1014, 'AB+', 0,15,101);
Select * from BloodSpecimen----------------------------------------------------------------------------CREATE TABLE City
( City_ID int Primary KEy NOT NULL,
 City_name varchar(max) NOT NULL,
);INSERT into City
VALUES(1200,'Austin'),
(1300,'Irving'),
(1400,'Houston'),
(1500,'Richardson'),
(1600,'Plano'),
(1700,'Frisco'),
(1800,'Arlington'),
(1900,'San Antonio'),
(2000,'Tyler');


Insert into city Values(1100, 'Dallas')

select * from City
-------------------------------------------------------------------------CREATE TABLE DiseaseFinder
( dfind_ID int Primary Key NOT NULL,
 dfind_name varchar(max) NOT NULL,
 dfind_PhNo bigint
);INSERT into DiseaseFinder
VALUES(11,'Peter',4693804223),
(12,'Park',4693804223),
(13,'Jerry',4693804223),
(14,'Mark',4693804223),
(15,'Monika',4693804223),
(16,'Ram',4693804123),
(17,'Swathi',4693804223),
(18,'Gautham',4693804323),
(19,'Ashwin',4693804423),
(20,'Yash',4693804523);

select * from DiseaseFinder ---------------------------------------------------------CREATE TABLE Hospital_Info_1
( hosp_ID int Primary Key NOT NULL,
 hosp_name varchar(max) NOT NULL,
 City_ID int NOT NULL,
 M_id int NOT NULL

);INSERT into Hospital_Info_1
VALUES(1,'MayoClinic',1100,101),
(2,'CleavelandClinic',1200,103),
(3,'NYU',1300,103),
(4,'Baylor',1400,104),
(5,'Charlton',1800,103),
(6,'Greenoaks',1300,106),
(7,'Forestpark',1300,102),
(8,'Parkland',1200,106),
(9,'Pinecreek',1500,109),
(10,'WalnutHill',1700,105);

select * from Hospital_Info_1 ----------------------------------------------------------CREATE TABLE Hospital_Info_2
( hosp_ID int NOT NULL,
 hosp_name varchar(max) NOT NULL,
 hosp_needed_Bgrp varchar(10),
 hosp_needed_qnty int
 primary key(hosp_ID,hosp_needed_Bgrp)
);INSERT into Hospital_Info_2
VALUES(1,'MayoClinic','A+',20),
(1,'MayoClinic','AB+',0),
(1,'MayoClinic','A-',40),
(1,'MayoClinic','B-',10),
(1,'MayoClinic','AB-',20);

INSERT into Hospital_Info_2
VALUES(2,'CleavelandClinic','A+',40),
(2,'CleavelandClinic','AB+',20),
(2,'CleavelandClinic','A-',10),
(2,'CleavelandClinic','B-',30),
(2,'CleavelandClinic','B+',0),
(2,'CleavelandClinic','AB-',10);

INSERT into Hospital_Info_2
VALUES(3,'NYU','A+',0),
(3,'NYU','AB+',0),
(3,'NYU','A-',0),
(3,'NYU','B-',20),
(3,'NYU','B+',10),
(3,'NYU','AB-',0);

INSERT into Hospital_Info_2
VALUES(4,'Baylor','A+',10),
(5,'Charlton','B+',30),
(4,'Baylor','A-',40),
(7,'Forestpark','B-',40),
(8,'Parkland','B+',10),
(9,'Pinecreek','AB-',20);

select * from Hospital_Info_2-----------------------------------------------------------------CREATE TABLE Recipient
( reci_ID int Primary Key NOT NULL,
 reci_name varchar(max) NOT NULL,
 reci_age varchar(max),
 reci_Brgp varchar(max),
 reci_Bqnty float,
 reco_ID int NOT NULL,
 City_ID int NOT NULL,
 M_id int NOT NULL,
 reci_sex varchar(max),
 reci_reg_date date
);INSERT into Recipient
VALUES(10001,'Mark',25,'B+',1.5,101212,1100,101,'M','2015-12-17'),
(10002,'Dan',60,'A+',1,101312,1100,102,'M','2015-12-16'),
(10003,'Steve',35,'AB+',0.5,101312,1200,102,'M','2015-10-17'),
(10004,'Parker',66,'B+',1,101212,1300,104,'M','2016-11-17'),
(10005,'Jason',53,'B-',1,101412,1400,105,'M','2015-04-17'),
(10006,'Preetham',45,'O+',1.5,101512,1500,105,'M','2015-12-17'),
(10007,'Swetha',22,'AB-',1,101212,1500,101,'F','2015-05-17'),
(10008,'Swathi',25,'B+',2,101412,1300,103,'F','2015-12-14'),
(10009,'Lance',30,'A+',1.5,101312,1100,104,'M','2015-02-16'),
(10010,'Marsh',25,'AB+',3.5,101212,1200,107,'M','2016-10-17');
select * from Recipient-------------------------------------------------------------CREATE TABLE Recording_Staff
( reco_ID int Primary key NOT NULL,
 reco_Name varchar(max) NOT NULL,
 reco_phNo bigint
);

INSERT into Recording_Staff
VALUES(101212,'Walcot',4045806553),
(101312,'Henry',4045806553),
(101412,'Silva',4045806553),
(101512,'Adrian',4045806553),
(101612,'Mark',4045806553),
(101712,'Abdul',4045816553),
(101812,'Jerry',4045826553),
(101912,'Tim',4045836553),
(101012,'Lekha',4044846553),
(101112,'Mark',4045856553);

select * from Recording_Staff
-----------------------------------------------------------------
-- Alter tables to set Foreign keys

Alter Table Blood_Donor
Add Foreign Key (Reco_id) References Recording_staff(reco_id)

Alter Table Blood_Donor
Add Foreign Key (city_ID) References City(city_ID)
----------------------------------------------------------------------

Alter Table Hospital_info_1
Add Foreign Key (city_ID) References City(city_ID)

Alter Table Hospital_info_1
Add Foreign Key (M_id) References BB_Manager(M_id)
-----------------------------------------------------------------------

Alter Table Recipient
Add Foreign Key (Reco_id) References Recording_staff(reco_id)

Alter Table Recipient
Add Foreign Key (City_id) References City(city_id)

Alter Table Recipient
Add Foreign Key (M_id) References BB_Manager(M_id)
------------------------------------------------------------------------

Alter Table BloodSpecimen
Add Foreign Key (M_id) References BB_Manager(m_id)

Alter Table BloodSpecimen
Add Foreign Key (Dfind_id) References DiseaseFinder(Dfind_id)

update City set City_name = 'Allen' where City_ID = 2000

Select *
From Recording_Staff

