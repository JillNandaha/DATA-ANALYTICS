CREATE SCHEMA hospital;

set search_path to hospital;

show search_path;


-- CREATE PATIENT DIMENSION TABLE

CREATE TABLE patient (
    patient_key SERIAL PRIMARY KEY,
    patient_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    age INT,
    city VARCHAR(50),
    registration_date DATE
);

-- INSERT PATIENT DATA

INSERT INTO patient (patient_id, first_name, last_name, gender, date_of_birth, age, city, registration_date) VALUES
('P001','Brian','Kamau','Male','1995-06-10',30,'Nairobi','2025-01-05'),
('P002','Faith','Achieng','Female','2001-03-18',24,'Kisumu','2025-01-10'),
('P003','Kevin','Mutua','Male','1988-11-25',36,'Machakos','2025-01-15'),
('P004','Mercy','Wanjiku','Female','1992-07-14',32,'Nakuru','2025-01-18'),
('P005','John','Otieno','Male','1985-01-30',40,'Mombasa','2025-02-01'),
('P006','Susan','Naliaka','Female','1998-09-09',26,'Eldoret','2025-02-05'),
('P007','Peter','Mwangi','Male','1979-12-12',45,'Nairobi','2025-02-10'),
('P008','Alice','Chebet','Female','2003-05-22',21,'Kericho','2025-02-12'),
('P009','Daniel','Omondi','Male','1990-08-17',34,'Kisumu','2025-02-20'),
('P010','Janet','Muthoni','Female','1987-04-03',37,'Thika','2025-03-01');



-- CREATE DEPARTMENT TABLE

CREATE TABLE department (
    department_key SERIAL PRIMARY KEY,
    department_id VARCHAR(20) UNIQUE NOT NULL,
    department_name VARCHAR(100)
);

-- INSERT DEPARTMENT DATA

INSERT INTO department (department_id, department_name) VALUES
('D001','Cardiology'),
('D002','Pediatrics'),
('D003','Orthopedics'),
('D004','Radiology'),
('D005','General Medicine'),
('D006','Gynecology');



-- CREATE DOCTOR TABLE

CREATE TABLE doctor (
    doctor_key SERIAL PRIMARY KEY,
    doctor_id VARCHAR(20) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    department_key INT REFERENCES department(department_key),
    hire_date DATE
);

-- INSERT DOCTOR DATA

INSERT INTO doctor (doctor_id, first_name, last_name, specialization, department_key, hire_date) VALUES
('DR001','James','Mwangi','Cardiologist',1,'2023-01-15'),
('DR002','Mercy','Atieno','Pediatrician',2,'2022-07-11'),
('DR003','David','Otieno','Orthopedic Surgeon',3,'2021-05-20'),
('DR004','Ann','Wanjiku','General Physician',5,'2024-02-10'),
('DR005','Samuel','Kiptoo','Radiologist',4,'2020-10-05'),
('DR006','Grace','Njeri','Gynecologist',6,'2023-06-18'),
('DR007','Paul','Ochieng','General Physician',5,'2022-09-12'),
('DR008','Lydia','Chepkemoi','Pediatrician',2,'2021-11-01');


select * from doctor;
-- CREATE DATE DIMENSION TABLE

CREATE TABLE date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    day_number INT,
    day_name VARCHAR(20),
    week_number INT,
    month_number INT,
    month_name VARCHAR(20),
    quarter_number INT,
    year_number INT
);

-- INSERT DATE DATA

INSERT INTO date VALUES
(20250210,'2025-02-10',10,'Monday',7,2,'February',1,2025),
(20250211,'2025-02-11',11,'Tuesday',7,2,'February',1,2025),
(20250212,'2025-02-12',12,'Wednesday',7,2,'February',1,2025),
(20250301,'2025-03-01',1,'Saturday',9,3,'March',1,2025),
(20250303,'2025-03-03',3,'Monday',10,3,'March',1,2025),
(20250305,'2025-03-05',5,'Wednesday',10,3,'March',1,2025),
(20250308,'2025-03-08',8,'Saturday',10,3,'March',1,2025),
(20250310,'2025-03-10',10,'Monday',11,3,'March',1,2025),
(20250312,'2025-03-12',12,'Wednesday',11,3,'March',1,2025),
(20250315,'2025-03-15',15,'Saturday',11,3,'March',1,2025),
(20250318,'2025-03-18',18,'Tuesday',12,3,'March',1,2025);



-- CREATE APPOINTMENT FACT TABLE

CREATE TABLE appointment (
    appointment_key SERIAL PRIMARY KEY,
    appointment_id VARCHAR(20),
    patient_key INT REFERENCES patient(patient_key),
    doctor_key INT REFERENCES doctor(doctor_key),
    department_key INT REFERENCES department(department_key),
    appointment_date_key INT REFERENCES date(date_key),
    appointment_date DATE,
    appointment_time TIME,
    appointment_status VARCHAR(20),
    diagnosis VARCHAR(150),
    consultation_fee NUMERIC(10,2)
);

select * from patient;
-- INSERT APPOINTMENT DATA

INSERT INTO appointment VALUES
(DEFAULT,'A001',1,1,1,20250210,'2025-02-10','09:00','Completed','Hypertension',2500),
(DEFAULT,'A002',2,2,2,20250211,'2025-02-11','10:30','Completed','Malaria',1800),
(DEFAULT,'A003',3,4,5,20250212,'2025-02-12','14:00','Cancelled','General Checkup',1500),
(DEFAULT,'A004',1,4,5,20250301,'2025-03-01','11:00','Completed','Flu',1200),
(DEFAULT,'A005',4,6,6,20250303,'2025-03-03','08:30','Completed','Routine Review',2200),
(DEFAULT,'A006',5,3,3,20250305,'2025-03-05','13:15','Completed','Fracture',3000),
(DEFAULT,'A007',6,5,4,20250305,'2025-03-05','15:45','Completed','X-Ray Request',2000),
(DEFAULT,'A008',7,1,1,20250308,'2025-03-08','09:20','No-show','Chest Pain',2500),
(DEFAULT,'A009',8,8,2,20250310,'2025-03-10','10:10','Completed','Fever',1700),
(DEFAULT,'A010',9,7,5,20250312,'2025-03-12','12:40','Completed','Diabetes Review',2100);



-- CREATE BILLING FACT TABLE

CREATE TABLE billing (
    billing_key SERIAL PRIMARY KEY,
    bill_id VARCHAR(20),
    patient_key INT REFERENCES patient(patient_key),
    doctor_key INT REFERENCES doctor(doctor_key),
    department_key INT REFERENCES department(department_key),
    bill_date_key INT REFERENCES date(date_key),
    bill_date DATE,
    service_type VARCHAR(50),
    bill_status VARCHAR(20),
    total_amount NUMERIC(10,2),
    paid_amount NUMERIC(10,2),
    balance_amount NUMERIC(10,2),
    payment_method VARCHAR(30)
);

-- INSERT BILLING DATA

INSERT into billing VALUES
(DEFAULT,'B001',1,1,1,20250210,'2025-02-10','Consultation','Paid',4000,4000,0,'Cash'),
(DEFAULT,'B002',2,2,2,20250211,'2025-02-11','Consultation','Partial',3000,1500,1500,'Mobile Money'),
(DEFAULT,'B003',3,4,5,20250212,'2025-02-12','Consultation','Unpaid',1500,0,1500,'Cash'),
(DEFAULT,'B004',1,4,5,20250301,'2025-03-01','Consultation','Paid',1200,1200,0,'Card'),
(DEFAULT,'B005',4,6,6,20250303,'2025-03-03','Procedure','Paid',5000,5000,0,'Insurance'),
(DEFAULT,'B006',5,3,3,20250305,'2025-03-05','Procedure','Partial',8000,5000,3000,'Card'),
(DEFAULT,'B007',6,5,4,20250305,'2025-03-05','Lab','Paid',2500,2500,0,'Mobile Money'),
(DEFAULT,'B008',7,1,1,20250308,'2025-03-08','Consultation','Unpaid',2500,0,2500,'Cash'),
(DEFAULT,'B009',8,8,2,20250310,'2025-03-10','Consultation','Paid',1700,1700,0,'Cash'),
(DEFAULT,'B010',9,7,5,20250312,'2025-03-12','Consultation','Partial',4200,2000,2200,'Insurance');



-- CREATE ADMISSION FACT TABLE

CREATE TABLE admission (
    admission_key SERIAL PRIMARY KEY,
    admission_id VARCHAR(20),
    patient_key INT REFERENCES patient(patient_key),
    doctor_key INT REFERENCES doctor(doctor_key),
    department_key INT REFERENCES department(department_key),
    admission_date DATE,
    discharge_date DATE,
    ward_name VARCHAR(50),
    bed_number VARCHAR(20),
    admission_reason VARCHAR(150),
    discharge_status VARCHAR(30),
    length_of_stay INT,
    admission_cost NUMERIC(10,2)
);

-- INSERT ADMISSION DATA

INSERT INTO admission VALUES
(DEFAULT,'AD001',1,1,1,'2025-02-10','2025-02-14','Cardiac Ward','B01','Hypertension Monitoring','Discharged',4,18000),
(DEFAULT,'AD002',5,3,3,'2025-03-05','2025-03-10','Ortho Ward','B12','Fracture Management','Discharged',5,25000),
(DEFAULT,'AD003',10,6,6,'2025-03-12','2025-03-18','Maternity Ward','M03','Observation','Discharged',6,22000),
(DEFAULT,'AD004',7,1,1,'2025-03-08',NULL,'Cardiac Ward','B05','Chest Pain Observation','Ongoing',NULL,12000),
(DEFAULT,'AD005',9,7,5,'2025-03-10','2025-03-15','General Ward','G07','Diabetes Monitoring','Discharged',5,16000);

SELECT * FROM patient;

SELECT * FROM department;

SELECT * FROM doctor;

SELECT * FROM date;

SELECT * FROM appointment;

SELECT * FROM billing;

-- AGGREGATE FUNCTIONS

-- Q1 Determine the total number of patients registered in the hospital.
select  count(patient_id) from patient;

-- Q2 Find the average age of patients in the system.
select AVG(age) from patient p ;

-- Q3 Calculate the total revenue generated from all hospital bills.
select sum(total_amount) from billing b ;
-- Q4 Identify the highest single bill recorded in the hospital.
select MAX(total_amount) from billing b ;

-- Q5 Determine the total amount of money that has been paid by patients so far.
select SUM(paid_amount) from billing b ;

-- Q6 Calculate the total outstanding balance across all bills.
select SUM(balance_amount) from billing b ;

-- Q7 Find the average consultation fee charged during appointments.
select AVG(consultation_fee) from appointment a ;

-- Q8 Determine how many admissions have been recorded in the hospital.

select count(admission_id) from admission a ;

-- GROUP BY

-- Q9 Determine how many patients come from each city.
select city, count(patient_id) from patient p 
group by p.city ;

-- Q10 Find how many doctors work in each department.

select dp.department_name, count(d.doctor_id) 
from doctor d 
join  department dp on d.department_key = dp.department_key
group by department_name ;

-- Q11 Calculate the total number of appointments handled by each doctor.

-- Q12 Determine the number of appointments handled by each department.
select dp.department_name, count(a.appointment_id)
from department dp
join appointment a on dp.department_key = a.department_key 
group by department_name ;

-- Q13 Calculate the total revenue generated by each department.
select dp.department_name, sum(b.total_amount) as total_revenue
from department dp
join billing b on dp.department_key = b.department_key
group by department_name
order by total_revenue desc;

-- Q14 Determine the number of bills recorded under each billing status.
select bill_status, count(bill_id)
from billing b
group by bill_status ;

-- Q15 Find the total admission cost generated by each department.
select dp.department_key, dp.department_name, SUM(admission_cost) as adm_cost
from admission a 
join department dp on dp.department_key = a.department_key 
group by dp.department_key ,department_name ;

-- HAVING

-- Q16 Identify departments that have handled more than two appointments.
select dp.department_key, dp.department_name, count(a.appointment_id) as total_appts
from department dp
join appointment a on dp.department_key = a.department_key 
group by dp.department_key , dp.department_name 
having count(a.appointment_id) > 2;

-- Q17 Find doctors who have attended to at least two patients.
select d.doctor_id, concat(d.first_name, ' ', d.last_name) as full_name, count(a.patient_key) as patient_count
from doctor d 
join admission a on d.doctor_key = a.doctor_key
group by d.doctor_id , full_name 
having count(a.patient_key) >= 2;

-- Q18 Determine which cities have more than one registered patient.
select city, count(patient_id) as patient_count
from patient p 
group by city 
having count(patient_id) > 1;

-- Q19 Identify departments whose total billing amount exceeds 5,000.
select d.department_key, d.department_name, SUM(b.total_amount) as total_bill
from department d 
join billing b on d.department_key = b.department_key
group by d.department_key , d.department_name 
having SUM(b.total_amount) > 5000;

-- Q20 Find doctors whose patients have generated more than 4,000 in billing.
select d.doctor_id, concat(d.first_name, ' ', d.last_name) as full_name, concat(p.first_name, ' ', p.last_name) as patient_name, SUM(b.total_amount) as total_bill
from doctor d 
join billing b on d.doctor_key = b.doctor_key
join patient p on b.patient_key = p.patient_key
group by d.doctor_id , full_name , patient_name 
having SUM(b.total_amount) > 4000;


-- INNER JOINS

-- Q21 Produce a list showing each appointment along with the patient’s full name.
select a.*, concat(p.first_name, ' ', p.last_name) as patient_name
from appointment a  
join patient p on a.patient_key = p.patient_key ;

-- Q22 Show the doctor responsible for each appointment together with the diagnosis.
select concat(d.first_name, ' ', d.last_name) as full_name, a.appointment_key, a.diagnosis
from doctor d 
join appointment a on d.department_key = a.department_key ;

-- Q23 Display the department name for each doctor.
select concat(d.first_name, ' ', d.last_name) as full_name, dp.department_name
from department dp
join doctor d on dp.department_key = d.department_key;
-- Q24 Produce a list showing patient names, their doctors, and the department visited during appointments.
select concat(p.first_name, ' ', p.last_name) as patient_name,concat(d.first_name, ' ', d.last_name) as doctor_name,dp.department_name
from appointment a 
join patient p on a.patient_key = p.patient_key 
join doctor d on a.department_key = d.department_key 
join department dp on d.department_key = dp.department_key;


-- Q25 Show the bill details together with the patient names responsible for each bill.
select b. *, concat(p.first_name, ' ', p.last_name) as patient_name
from billing b 
join patient p on b.patient_key = p.patient_key;
-- Q26 Display the doctor who handled each billed service together with the total amount.
select concat(d.first_name, ' ', d.last_name) as doctor_name, b.bill_id , b.service_type ,  b.total_amount 
from billing b 
join doctor d on b.doctor_key = d.doctor_key;

-- LEFT JOINS

-- Q27 Produce a list of all patients and indicate whether they have had an appointment.
select p.*, a.appointment_key
from patient p 
join appointment a on p.patient_key = a.patient_key;

-- Q28 Display all doctors and show the appointments they have handled, including those with none.
select d.* , a.*
from doctor d 
left join appointment a on d.doctor_key = a.doctor_key;

-- Q29 Show every department and any appointments associated with them.
select d.*, a.appointment_key
from department d 
left join appointment a  on d.department_key = a.department_key;

-- Q30 Display all patients and their billing information, including patients who have never been billed.

select p.*, b.*
from patient p 
join billing b on p.patient_key = b.patient_key;

-- CASE

-- Q31 Categorize bills into payment groups such as fully paid, partially paid, or unpaid.
select bill_id, total_amount,paid_amount,
case 
	when paid_amount = total_amount then 'Fully Paid'
	when paid_amount > 0 then 'Partially Paid'
	else 'Unpaid'
end as payment_category
from billing;


-- Q32 Create a category showing whether a patient is considered young, middle-aged, or senior based on age.
select 	patient_id, age,
case 
	when age < 30 then 'Young'
	when age between 30 and 50 then 'Middle Aged'
	else 'Senior'
end as age_category
from patient;



-- Q33 Classify admissions into short stay or long stay depending on the length of stay.
select admission_id, length_of_stay,
case 
	when length_of_stay <= 3 then 'Short Stay'
	else 'Long Stay'
end as stay_category
from admission a ;


-- Q34 Create a category that flags appointments as successful or unsuccessful based on their status.
select appointment_id, appointment_status,
case 
	when appointment_status = 'Completed' then 'Successful'
	else 'Unsuccessful'
end as appointment_outcome
from appointment a ;




-- ALIASES AND CALCULATED COLUMNS
select patient_id, concat(first_name, ' ', last_name) as full_name
from patient p;
-- Q35 Display patient names as a single column combining first and last name.
select patient_id, first_name || ' ' || last_name as full_name
from patient p ;
-- Q36 Create a column showing the total bill amount still owed for each billing record.
select bill_id, total_amount, paid_amount, (total_amount-paid_amount) as amount_owed
from billing b ;


-- Q37 Calculate the percentage of each bill that has been paid.
select bill_id, (paid_amount/total_amount)*100 as percent_paid
from billing b ;


-- Q38 Display the length of stay for each admission calculated from the admission and discharge dates.
select admission_id, admission_date, discharge_date,(discharge_date-admission_date) as calculated_stay
from admission;


-- SUBQUERIES

-- Q39 Find patients who are older than the average age of all patients.
select * from patient p 
where age > (select AVG(age) from patient);
-- Q40 Identify the doctor who handled the highest number of appointments.
select doctor_key, count(*) as total_appointments
from appointment a 
group by a.doctor_key 
order by total_appointments desc 
limit 1;

-- Q41 Find the patient responsible for the highest bill in the system.
select * from patient p 
where patient_key = (select patient_key from billing b 
					order by b.total_amount desc
					limit 1
);
-- Q42 Identify patients who have at least one admission recorded.
select * from patient p 
where patient_key in (select distinct patient_key from admission a );


-- Q43 Determine departments whose billing totals are above the hospital average.
select department_key, sum(total_amount) as total_billing
from billing b 
group by b.department_key 
having sum(total_amount) > (
select AVG(dept_total)
from 
(select sum(total_amount) as dept_total
from billing b
group by b.department_key )t
);


-- CTES

-- Q44 Calculate total billing per department and determine which department generates the most revenue.
WITH dept_revenue AS (
    SELECT department_key, SUM(total_amount) AS total_revenue
    FROM billing
    GROUP BY department_key
)
SELECT *
FROM dept_revenue
ORDER BY total_revenue DESC;
-- Q45 Calculate total appointments handled by each doctor and determine the top three doctors.
with doctor_appointments as (
	select doctor_key, count(*) as total_appointments
	from appointment a 
	group by doctor_key 
)
select * from doctor_appointments 
order by total_appointments desc
limit 3;
-- Q46 Compute the total payments received from each patient and list them in descending order.

with patient_payments as (
select patient_key, sum(paid_amount) as total_paid
from billing b 
group by b.patient_key 
)
select * from patient_payments 
order by total_paid desc;



-- WINDOW FUNCTIONS

-- Q47 Rank all doctors based on the number of appointments they have handled.
select doctor_key, 
	count(*) as total_appts,
	rank() over (order by count(*) desc ) as rank
from appointment
group by doctor_key;
-- Q48 Rank departments based on the revenue they have generated.

select department_key,
	sum(total_amount) as revenue,
	rank() over (order by sum(total_amount) desc) as rank
from billing b 
group by b.department_key ;

-- Q49 Assign a rank to patients based on the total billing amount associated with them.
select patient_key,
	sum(total_amount) as total_billing,
	rank() over (order by sum(total_amount) desc) as rank
from billing b 
group by b.patient_key ;
-- Q50 Determine how each bill compares to the average bill amount.
select bill_id,
	total_amount,
	AVG(total_amount) over() as avg_bill,
	total_amount - AVG(total_amount) over () as differnce
from billing b ;


-- Q51 Display a running total of revenue collected over time based on bill dates.
select bill_date, 
	sum(total_amount)as daily_total,
	sum(sum(total_amount)) over (order by bill_date) as running_total
from billing
group by bill_date;

-- STORED PROCEDURES OR FUNCTIONS

-- Q52 Create a routine that returns all billing records for a specific patient.
CREATE OR REPLACE FUNCTION get_patient_bills(p_id INT)
RETURNS TABLE (*) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM billing WHERE patient_key = p_id;
END;
$$ LANGUAGE plpgsql;
-- Q53 Build a routine that calculates the total revenue generated by a given department.
CREATE OR REPLACE FUNCTION dept_revenue(d_id INT)
RETURNS NUMERIC AS $$
DECLARE total NUMERIC;
BEGIN
    SELECT SUM(total_amount) INTO total
    FROM billing
    WHERE department_key = d_id;
    
    RETURN total;
END;
$$ LANGUAGE plpgsql;
-- Q54 Create a routine that lists all appointments handled by a specific doctor.
CREATE OR REPLACE FUNCTION doctor_appointments(d_id INT)
RETURNS TABLE (*) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM appointment WHERE doctor_key = d_id;
END;
$$ LANGUAGE plpgsql;
-- Q55 Develop a routine that returns all unpaid bills in the hospital.
CREATE OR REPLACE FUNCTION unpaid_bills()
RETURNS TABLE (*) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM billing WHERE bill_status = 'Unpaid';
END;
$$ LANGUAGE plpgsql;
-- Q56 Create a routine that returns the top performing doctors based on number of appointments.
CREATE OR REPLACE FUNCTION top_doctors()
RETURNS TABLE (doctor_key INT, total_appointments INT) AS $$
BEGIN
    RETURN QUERY
    SELECT doctor_key, COUNT(*)
    FROM appointment
    GROUP BY doctor_key
    ORDER BY COUNT(*) DESC;
END;
$$ LANGUAGE plpgsql;

-- ADVANCED MULTI-CONCEPT QUESTIONS

-- Q57 Determine the total billing amount generated by each department and return the departments from highest to lowest revenue.
WITH dept_rev AS (
    SELECT d.department_name,
           SUM(b.total_amount) AS revenue
    FROM  billing b
    JOIN  department d USING (department_key)
    GROUP BY d.department_name
),
ranked AS (
    SELECT *,
           RANK() OVER (ORDER BY revenue DESC) AS rnk
    FROM  dept_rev
)
SELECT department_name, revenue, rnk
FROM  ranked
WHERE rnk = 3;
-- Which Department Generated the third highest income? and how much was it?
SELECT d.doctor_id,
       d.first_name || ' ' || d.last_name AS doctor_name,
       dep.department_name,
       COUNT(a.appointment_key)           AS total_appointments
FROM  doctor d
JOIN  department dep ON d.department_key = dep.department_key
LEFT JOIN appointment a ON d.doctor_key = a.doctor_key
GROUP BY d.doctor_key, d.first_name, d.last_name, dep.department_name
ORDER BY total_appointments DESC;
-- Q58 Find the total number of appointments handled by each doctor together with the department each doctor belongs to.
SELECT d.doctor_id,
       d.first_name || ' ' || d.last_name AS doctor_name,
       dep.department_name,
       COUNT(a.appointment_key)           AS total_appointments
FROM  doctor d
JOIN  department dep ON d.department_key = dep.department_key
LEFT JOIN appointment a ON d.doctor_key = a.doctor_key
GROUP BY d.doctor_key, d.first_name, d.last_name, dep.department_name
ORDER BY total_appointments DESC;
-- Q59 Identify patients whose total billing amount is greater than the overall average billing amount across all patients.
SELECT p.patient_id,
       p.first_name || ' ' || p.last_name AS patient_name,
       SUM(b.total_amount)                AS total_billing
FROM  billing b
JOIN  patient p USING (patient_key)
GROUP BY p.patient_key, p.first_name, p.last_name
HAVING SUM(b.total_amount) > (
    SELECT AVG(patient_total)
    FROM  (
        SELECT SUM(total_amount) AS patient_total
        FROM  billing
        GROUP BY patient_key
    ) sub
)
ORDER BY total_billing DESC;
-- Q60 Find doctors whose total number of appointments is higher than the average number of appointments handled by all doctors.
WITH doc_counts AS (
    SELECT doctor_key, COUNT(*) AS total
    FROM  appointment
    GROUP BY doctor_key
)
SELECT d.doctor_id,
       d.first_name || ' ' || d.last_name AS doctor_name,
       dc.total
FROM  doc_counts dc
JOIN  doctor d USING (doctor_key)
WHERE dc.total > (SELECT AVG(total) FROM doc_counts)
ORDER BY dc.total DESC;
-- Q61 Calculate the total billing amount for each patient and rank patients from highest to lowest total billing.
SELECT p.patient_id,
       p.first_name || ' ' || p.last_name     AS patient_name,
       SUM(b.total_amount)                     AS total_billing,
       RANK() OVER (ORDER BY SUM(b.total_amount) DESC) AS rnk
FROM  billing b
JOIN  patient p USING (patient_key)
GROUP BY p.patient_key, p.first_name, p.last_name
ORDER BY rnk;
-- Q62 Compute total revenue for each department and assign a dense rank from the highest earning department to the lowest.
SELECT dep.department_name,
       SUM(b.total_amount)                          AS total_revenue,
       DENSE_RANK() OVER (ORDER BY SUM(b.total_amount) DESC) AS dense_rnk
FROM  billing b
JOIN  department dep USING (department_key)
GROUP BY dep.department_key, dep.department_name
ORDER BY dense_rnk;
-- Q63 Calculate the total number of appointments handled by each doctor and return the top three doctors based on workload.
WITH ranked_docs AS (
    SELECT d.doctor_id,
           d.first_name || ' ' || d.last_name   AS doctor_name,
           COUNT(a.appointment_key)             AS total_appointments,
           RANK() OVER (ORDER BY COUNT(a.appointment_key) DESC) AS rnk
    FROM  doctor d
    LEFT JOIN appointment a USING (doctor_key)
    GROUP BY d.doctor_key, d.first_name, d.last_name
)
SELECT doctor_id, doctor_name, total_appointments, rnk
FROM  ranked_docs
WHERE rnk <= 3
ORDER BY rnk;
-- Q64 Determine the total billing amount generated by each doctor, show the doctor's full name and department name, and rank doctors from highest to lowest revenue.
SELECT d.doctor_id,
       d.first_name || ' ' || d.last_name  AS doctor_name,
       dep.department_name,
       SUM(b.total_amount)                  AS total_revenue,
       RANK() OVER (ORDER BY SUM(b.total_amount) DESC) AS rnk
FROM  billing b
JOIN  doctor d   USING (doctor_key)
JOIN  department dep ON d.department_key = dep.department_key
GROUP BY d.doctor_key, d.first_name, d.last_name, dep.department_name
ORDER BY rnk;
-- Q65 Calculate the total billing amount for each patient, include the patient's city, and rank patients within each city from highest spender to lowest.
SELECT p.patient_id,
       p.first_name || ' ' || p.last_name  AS patient_name,
       p.city,
       SUM(b.total_amount)                  AS total_billing,
       RANK() OVER (
           PARTITION BY p.city
           ORDER BY     SUM(b.total_amount) DESC
       ) AS city_rank
FROM  billing b
JOIN  patient p USING (patient_key)
GROUP BY p.patient_key, p.first_name, p.last_name, p.city
ORDER BY p.city, city_rank;
-- Q66 Determine the total appointments handled by each doctor, include the department name, and identify the top doctor in each department.
WITH dept_doc_counts AS (
    SELECT d.doctor_key,
           d.first_name || ' ' || d.last_name  AS doctor_name,
           dep.department_name,
           COUNT(a.appointment_key)             AS total_appointments,
           RANK() OVER (
               PARTITION BY dep.department_name
               ORDER BY     COUNT(a.appointment_key) DESC
           ) AS dept_rank
    FROM  doctor d
    JOIN  department dep ON d.department_key = dep.department_key
    LEFT JOIN appointment a USING (doctor_key)
    GROUP BY d.doctor_key, d.first_name, d.last_name, dep.department_name
)
SELECT department_name, doctor_name, total_appointments
FROM  dept_doc_counts
WHERE dept_rank = 1
ORDER BY department_name;
-- Q67 Calculate the total revenue generated by each department and show the difference between each department’s revenue and the highest department revenue.
SELECT dep.department_name,
       SUM(b.total_amount)                                      AS total_revenue,
       MAX(SUM(b.total_amount)) OVER ()                         AS max_revenue,
       MAX(SUM(b.total_amount)) OVER () - SUM(b.total_amount)  AS revenue_gap
FROM  billing b
JOIN  department dep USING (department_key)
GROUP BY dep.department_key, dep.department_name
ORDER BY total_revenue DESC;
-- Q68 Calculate the total billing amount for each patient, include patient and doctor details, and rank patients by total billing within each doctor’s patient list.
SELECT p.patient_id,
       p.first_name || ' ' || p.last_name  AS patient_name,
       d.first_name || ' ' || d.last_name  AS doctor_name,
       dep.department_name,
       SUM(b.total_amount)                  AS total_billing,
       RANK() OVER (
           PARTITION BY b.doctor_key
           ORDER BY     SUM(b.total_amount) DESC
       ) AS doctor_patient_rank
FROM  billing b
JOIN  patient    p   USING (patient_key)
JOIN  doctor     d   USING (doctor_key)
JOIN  department dep ON d.department_key = dep.department_key
GROUP BY b.doctor_key, p.patient_key, p.first_name, p.last_name,
         d.first_name, d.last_name, dep.department_name
ORDER BY doctor_name, doctor_patient_rank;
-- Q69 For each patient, compare their total billing amount to the hospital-wide average patient billing amount and label them as Above Average or Below Average.
WITH patient_billing AS (
    SELECT p.patient_id,
           p.first_name || ' ' || p.last_name  AS patient_name,
           SUM(b.total_amount)                  AS total_billing
    FROM  billing b
    JOIN  patient p USING (patient_key)
    GROUP BY p.patient_key, p.first_name, p.last_name
)
SELECT patient_id,
       patient_name,
       total_billing,
       ROUND(AVG(total_billing) OVER (), 2)   AS avg_billing,
       CASE
           WHEN total_billing > AVG(total_billing) OVER ()
               THEN 'Above Average'
           ELSE 'Below Average'
       END AS billing_label
FROM  patient_billing
ORDER BY total_billing DESC;
-- Q70 For each doctor, compare their total appointment count to the overall average appointment count and classify them as High Workload or Low Workload.
WITH doc_workload AS (
    SELECT d.doctor_id,
           d.first_name || ' ' || d.last_name  AS doctor_name,
           COUNT(a.appointment_key)             AS total_appointments
    FROM  doctor d
    LEFT JOIN appointment a USING (doctor_key)
    GROUP BY d.doctor_key, d.first_name, d.last_name
)
SELECT doctor_id,
       doctor_name,
       total_appointments,
       ROUND(AVG(total_appointments) OVER (), 2) AS avg_appointments,
       CASE
           WHEN total_appointments >= AVG(total_appointments) OVER ()
               THEN 'High Workload'
           ELSE 'Low Workload'
       END AS workload_label
FROM  doc_workload
ORDER BY total_appointments DESC;
-- Q71 Display each bill together with the patient name and department name and assign a rank to the bills from the highest amount to the lowest amount.
SELECT b.bill_id,
       p.first_name || ' ' || p.last_name  AS patient_name,
       dep.department_name,
       b.total_amount,
       RANK() OVER (ORDER BY b.total_amount DESC) AS bill_rank
FROM  billing b
JOIN  patient    p   USING (patient_key)
JOIN  department dep USING (department_key)
ORDER BY bill_rank;