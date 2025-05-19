--create database
	create database HospitalDB

 --switch to the database
	\c HospitalDB

--create tables
	create table Hospital(
	Hospital_Name	varchar(50),
	Location	varchar(50),
	Department	varchar(50),
	Doctors_Count	int,
	Patients_Count	int,
	Admission_Date	date,
	Discharge_Date	date,
	Medical_Expenses numeric (10,2)
	)

select * from hospital;

--import data into hospital table 
	COPY hospital (Hospital_Name, Location, Department, Doctors_Count, Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses)
	FROM 'D:\SQL Exercise\Assignment\Hospital_Data1.csv'
	CSV HEADER ;

--1.Total Number of Patients
--Write an SQL query to find the total number of patients across all hospitals.

	select SUM(Patients_Count) AS  Total_Patients from hospital ;

--2.Average Number of Doctors per Hospital
--Retrieve the average count of doctors available in each hospital.

	select AVG(Doctors_Count) AS  Avg_Doctors from hospital ;

--3.Top 3 Departments with the Highest Number of Patients
--Find the top 3 hospital departments that have the highest number of patients.


	select hospital_name, department, patients_count
	from hospital 
	order by patients_count desc
	LIMIT 3;

--4.Hospital with the Maximum Medical Expenses
--Identify the hospital that recorded the highest medical expenses.

	SELECT Hospital_Name, Medical_Expenses
	FROM Hospital
	ORDER BY Medical_Expenses DESC
	LIMIT 1; 

--5.Daily Average Medical Expenses
--Calculate the average medical expenses per day for each hospital.

	
	SELECT Hospital_Name, Round(Medical_Expenses/(discharge_date - admission_date), 2)  As Daily_Avg_Expenses 
	FROM Hospital;

--6.Longest Hospital Stay
--Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.

	SELECT Hospital_Name, Department, discharge_date - admission_date  As Longest_Stay
	FROM Hospital
	ORDER BY Longest_Stay DESC
	LIMIT 1;

--7.Total Patients Treated Per City
--Count the total number of patients treated in each city.

	SELECT Location, SUM(Patients_Count) AS Total_Patients
	FROM Hospital
	GROUP BY Location;

--8.Average Length of Stay Per Department
--Calculate the average number of days patients spend in each department.

	SELECT Department, 
	       ROUND(AVG(Discharge_Date - Admission_Date),2) AS Avg_Length_of_Stay
	FROM Hospital
	GROUP BY Department;


--9.Identify the Department with the Lowest Number of Patients
--Find the department with the least number of patients.


	SELECT Department, SUM(Patients_Count) AS Total_Patients
	FROM Hospital
	GROUP BY Department
	ORDER BY Total_Patients ASC
	LIMIT 1;


--10.Monthly Medical Expenses Report
--Group the data by month and calculate the total medical expenses for each month.

	SELECT DATE_PART('month', Admission_Date) AS Month, 
	       SUM(Medical_Expenses) AS Total_Medical_Expenses
	FROM Hospital
	GROUP BY DATE_PART('month', Admission_Date)
	ORDER BY Month;




