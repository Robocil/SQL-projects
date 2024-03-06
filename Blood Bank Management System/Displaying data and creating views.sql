--use [Blood Bank Management System project]
-- Create a view of Donors that has type O
Create View Bloody_Type_O_Donors
AS
Select * From Blood_Donor
Where bd_Bgroup Like'O_'

Select * From Bloody_Type_O_Donors

-- Create a view of Donors that has type A
Create View Bloody_Type_A_Donors
AS
Select * From Blood_Donor
Where bd_Bgroup Like'A_'

Select * From Bloody_Type_A_Donors

-- Create a view of Donors that has type B
Create View Bloody_Type_B_Donors
AS
Select * From Blood_Donor
Where bd_Bgroup Like'B_'

Select * From Bloody_Type_B_Donors

-- Create a view of Donors that has type AB
Create View Bloody_Type_AB_Donors
AS
Select * From Blood_Donor
Where bd_Bgroup Like'AB_'

Select * From Bloody_Type_AB_Donors


--Create view of recipients and donors names and blood type that has the same blood group

Create View Blood_recipient_same_Bgroup
AS
Select Blood_Donor.bd_name, Blood_Donor.bd_Bgroup, Recipient.reci_name, Recipient.reci_Brgp, reco_name
from Recording_Staff
Inner join Blood_Donor on Recording_Staff.reco_ID = Blood_Donor.reco_ID
Inner join Recipient on Recording_Staff.reco_ID = Recipient.reco_ID
Where Blood_Donor.bd_Bgroup = Recipient .reci_Brgp

Select * From Blood_recipient_same_Bgroup

--Show Donors that has the same blood group and live in the same city along with the recipient
Create View Donors_in_the_samecity
AS
Select bd_id,bd_name, bd_Bgroup, reci_ID, reci_name, City_name From City
Inner join Blood_Donor on City.City_ID = Blood_Donor.City_ID
Inner join Recipient on City.City_ID = Recipient.City_ID
Where bd_Bgroup= reci_Brgp and Blood_Donor.City_ID = Recipient.City_ID

Select * From Donors_in_the_samecity

--Create view showing all the blood specimen that are pure
Create View bloodspecimen_pure
as
Select specimen_number, dfind_name, b_group from BloodSpecimen, DiseaseFinder
Where BloodSpecimen.dfind_id = DiseaseFinder.dfind_ID And status = 1

Select * from bloodspecimen_pure

Create view Bloodspecimen_contaminated
as
Select specimen_number, dfind_name, b_group from BloodSpecimen, DiseaseFinder
Where BloodSpecimen.dfind_id = DiseaseFinder.dfind_ID And status = 0

Select *
From Bloodspecimen_contaminated

-- Create view Displaying the information of Hospital_info_1 handle by BB_Manager whose ID is 103:
Create View Manager103_hospitals_handled
as
Select hosp_ID, hosp_name, City_Name, Hospital_Info_1.M_id, Mname from  Hospital_Info_1
Inner join City on Hospital_Info_1.City_ID = City.City_ID
Inner Join BB_Manager on Hospital_Info_1.M_ID = BB_Manager.M_id
Where BB_Manager.M_id = Hospital_Info_1.M_id and BB_Manager.M_id =103

Select * from Manager103_hospitals_handled

-- Show the total quantity of needed blood by Blood group
on all the hospitals

Select hosp_needed_Bgrp, Sum(hosp_needed_qnty) as Total_quantity_of_needed_Blood
From Hospital_Info_2
Group By hosp_needed_Bgrp