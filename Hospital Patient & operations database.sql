-- HOSPITAL PATIENT & OPERATIONS DATABASE
-- Task 1 - Database Setup

CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- Create Departments Table

CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(80) NOT NULL,
    floor_no INT
);

-- Create Doctors Table

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(80),
    dept_id INT,
    join_date DATE,
    consult_fee DECIMAL(8,2),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Create Patients Table

CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender ENUM('Male','Female','Other'),
    blood_group VARCHAR(5),
    contact VARCHAR(15),
    city VARCHAR(50)
);

-- Create Admissions Table

CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    dept_id INT,
    admit_date DATE NOT NULL,
    discharge_date DATE,
    ward VARCHAR(30),
    diagnosis VARCHAR(200),
    status ENUM('Admitted','Discharged','ICU') DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Create Billing Table

CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT UNIQUE,
    room_charges DECIMAL(10,2) DEFAULT 0,
    doctor_fee DECIMAL(10,2) DEFAULT 0,
    medicine_charges DECIMAL(10,2) DEFAULT 0,
    lab_charges DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2),
    paid_status ENUM('Paid','Pending','Partial') DEFAULT 'Pending',
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

-- Create Feedback Table

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    doctor_id INT,
    rating TINYINT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Insert Departments

INSERT INTO departments (dept_name, floor_no)
VALUES
('Cardiology',3),
('Orthopaedics',2),
('Neurology',4),
('General Medicine',1),
('Paediatrics',2),
('Oncology',5);

-- Insert Doctors

INSERT INTO doctors
(name,specialization,dept_id,join_date,consult_fee)
VALUES
('Dr. Arvind Shah','Cardiologist',1,'2018-06-01',1500.00),
('Dr. Priya Menon','Orthopaedic Surg',2,'2019-03-15',1200.00),
('Dr. Rajesh Nair','Neurologist',3,'2017-09-10',1800.00),
('Dr. Sunita Desai','General Physician',4,'2020-01-20',800.00),
('Dr. Amit Bose','Paediatrician',5,'2016-11-05',1000.00),
('Dr. Kavya Reddy','Oncologist',6,'2021-07-12',2000.00),
('Dr. Vikram Joshi','Cardiologist',1,'2015-04-22',1600.00),
('Dr. Neha Kapoor','Orthopaedic Surg',2,'2022-08-30',1100.00);

-- Insert Patients

INSERT INTO patients
(name,dob,gender,blood_group,contact,city)
VALUES
('Ramesh Iyer','1965-04-12','Male','O+','9841001001','Chennai'),
('Lakshmi Devi','1978-11-30','Female','A+','9841001002','Bangalore'),
('Mohan Verma','1990-07-22','Male','B+','9841001003','Delhi'),
('Sunita Patil','1955-02-14','Female','AB+','9841001004','Pune'),
('Arjun Krishnan','1988-09-05','Male','O-','9841001005','Mumbai'),
('Geeta Sharma','1972-03-18','Female','A-','9841001006','Jaipur'),
('Deepak Nambiar','1995-12-25','Male','B-','9841001007','Kochi'),
('Pooja Malhotra','2001-06-08','Female','O+','9841001008','Chandigarh'),
('Suresh Rajan','1960-01-19','Male','A+','9841001009','Hyderabad'),
('Ananya Sen','1983-08-27','Female','AB-','9841001010','Kolkata'),
('Hari Prasad','1945-05-03','Male','O+','9841001011','Lucknow'),
('Rekha Choudhary','1968-10-11','Female','B+','9841001012','Nagpur');

-- Insert Admissions

INSERT INTO admissions
(patient_id,doctor_id,dept_id,admit_date,discharge_date,ward,diagnosis,status)
VALUES
(1,1,1,'2023-01-10','2023-01-17','General','Acute Myocardial Infarction','Discharged'),
(2,2,2,'2023-01-22','2023-01-29','General','Fractured Femur','Discharged'),
(3,3,3,'2023-02-05','2023-02-12','Private','Migraine with Aura','Discharged'),
(4,1,1,'2023-02-14','2023-02-20','ICU','Hypertensive Crisis','Discharged'),
(5,4,4,'2023-03-01','2023-03-05','General','Typhoid Fever','Discharged'),
(6,5,5,'2023-03-18','2023-03-22','Paediatric','Dengue Fever','Discharged'),
(7,6,6,'2023-04-02','2023-04-15','Oncology','Lung Cancer Stage II','Discharged'),
(8,7,1,'2023-04-20','2023-04-25','ICU','Arrhythmia','Discharged'),
(9,2,2,'2023-05-08','2023-05-15','General','Knee Replacement','Discharged'),
(10,3,3,'2023-05-22','2023-05-28','Private','Epilepsy','Discharged'),
(1,1,1,'2023-06-05','2023-06-10','ICU','Cardiac Arrest','Discharged'),
(11,4,4,'2023-06-18','2023-06-23','General','Diabetes Complication','Discharged'),
(12,8,2,'2023-07-07','2023-07-14','General','Shoulder Dislocation','Discharged'),
(3,3,3,'2023-07-20','2023-07-25','Private','Post-op Neurological Check','Discharged'),
(5,6,6,'2023-08-10','2023-08-20','Oncology','Prostate Cancer Stage I','Discharged'),
(2,2,2,'2023-09-01','2023-09-08','General','Hip Replacement','Discharged');

-- Insert Billing

INSERT INTO billing
(admission_id,room_charges,doctor_fee,medicine_charges,lab_charges,total_amount,paid_status)
VALUES
(1,14000,9000,8500,4500,36000,'Paid'),
(2,14000,7200,5000,3000,29200,'Paid'),
(3,14000,10800,3500,5000,33300,'Partial'),
(4,18000,9000,12000,6000,45000,'Paid'),
(5,8000,4800,4000,2500,19300,'Paid'),
(6,8000,6000,5000,2000,21000,'Pending'),
(7,26000,12000,18000,8000,64000,'Paid'),
(8,10000,9600,7000,3500,30100,'Partial'),
(9,14000,7200,6000,4000,31200,'Paid'),
(10,12000,10800,4500,5500,32800,'Paid'),
(11,10000,9000,11000,5000,35000,'Paid'),
(12,10000,4800,3000,2000,19800,'Pending'),
(13,14000,6600,5500,3000,29100,'Paid'),
(14,10000,10800,3000,4000,27800,'Paid'),
(15,20000,12000,20000,10000,62000,'Partial'),
(16,14000,7200,7000,4500,32700,'Paid');

-- Insert Feedback

INSERT INTO feedback
(admission_id,doctor_id,rating,comments,feedback_date)
VALUES
(1,1,5,'Excellent care, Dr. Shah was very attentive','2023-01-18'),
(2,2,4,'Good treatment, quick recovery','2023-01-30'),
(3,3,5,'Very thorough diagnosis','2023-02-13'),
(4,1,4,'ICU care was excellent','2023-02-21'),
(5,4,3,'Average experience','2023-03-06'),
(7,6,5,'Dr. Reddy explained everything clearly','2023-04-16'),
(9,2,5,'Knee replacement went perfectly','2023-05-16'),
(11,4,4,'Good follow up care','2023-06-24'),
(13,8,4,'Efficient and professional','2023-07-15'),
(16,2,5,'Best orthopaedic surgeon!','2023-09-09');

-- Query 3a: Patient admissions with doctor and department details

SELECT
    p.name AS patient_name,
    p.gender,
    TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS age,
    d.name AS doctor_name,
    dept.dept_name,
    a.admit_date,
    a.discharge_date,
    DATEDIFF(a.discharge_date, a.admit_date) AS length_of_stay,
    a.diagnosis,
    a.ward
FROM admissions a
JOIN patients p
    ON a.patient_id = p.patient_id
JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN departments dept
    ON a.dept_id = dept.dept_id
ORDER BY a.admit_date;

-- Query 3b: Average length of stay per department

SELECT
    dept.dept_name,
    COUNT(a.admission_id) AS total_admissions,
    ROUND(AVG(DATEDIFF(a.discharge_date, a.admit_date)),1) AS avg_stay_days,
    MAX(DATEDIFF(a.discharge_date, a.admit_date)) AS max_stay_days,
    MIN(DATEDIFF(a.discharge_date, a.admit_date)) AS min_stay_days
FROM admissions a
JOIN departments dept
    ON a.dept_id = dept.dept_id
WHERE a.discharge_date IS NOT NULL
GROUP BY
    dept.dept_id,
    dept.dept_name
ORDER BY avg_stay_days DESC;

-- Query 3c: Total billing by department and payment status

SELECT
    dept.dept_name,
    b.paid_status,
    COUNT(*) AS num_bills,
    SUM(b.total_amount) AS total_billed,
    ROUND(AVG(b.total_amount),2) AS avg_bill
FROM billing b
JOIN admissions a
    ON b.admission_id = a.admission_id
JOIN departments dept
    ON a.dept_id = dept.dept_id
GROUP BY
    dept.dept_name,
    b.paid_status
ORDER BY
    dept.dept_name,
    total_billed DESC;
    
-- CTE 1a: Find patients readmitted within 30 days of discharge

WITH discharged_patients AS (
    SELECT
        patient_id,
        admission_id,
        discharge_date,
        diagnosis
    FROM admissions
    WHERE status = 'Discharged'
      AND discharge_date IS NOT NULL
)

SELECT
    p.name AS patient_name,
    d1.discharge_date AS first_discharge,
    d1.diagnosis AS first_diagnosis,
    d2.admit_date AS readmission_date,
    DATEDIFF(d2.admit_date, d1.discharge_date) AS days_between
FROM discharged_patients d1
JOIN admissions d2
    ON d1.patient_id = d2.patient_id
   AND d2.admit_date > d1.discharge_date
   AND DATEDIFF(d2.admit_date, d1.discharge_date) <= 30
JOIN patients p
    ON d1.patient_id = p.patient_id
ORDER BY days_between;

-- CTE 1b: Doctor performance summary

WITH doctor_patients AS (
    SELECT
        doctor_id,
        COUNT(DISTINCT patient_id) AS unique_patients,
        COUNT(admission_id) AS total_admissions
    FROM admissions
    GROUP BY doctor_id
),

doctor_ratings AS (
    SELECT
        doctor_id,
        ROUND(AVG(rating),2) AS avg_rating,
        COUNT(rating) AS feedback_count
    FROM feedback
    GROUP BY doctor_id
),

doctor_revenue AS (
    SELECT
        a.doctor_id,
        SUM(b.total_amount) AS total_revenue
    FROM admissions a
    JOIN billing b
        ON a.admission_id = b.admission_id
    GROUP BY a.doctor_id
)

SELECT
    d.name AS doctor_name,
    d.specialization,
    dp.total_admissions,
    dp.unique_patients,
    COALESCE(dr.avg_rating,'No rating') AS avg_rating,
    drev.total_revenue
FROM doctors d
JOIN doctor_patients dp
    ON d.doctor_id = dp.doctor_id
LEFT JOIN doctor_ratings dr
    ON d.doctor_id = dr.doctor_id
JOIN doctor_revenue drev
    ON d.doctor_id = drev.doctor_id
ORDER BY drev.total_revenue DESC;

-- Window Function 2a: Running total of monthly revenue

SELECT
    YEAR(a.admit_date) AS yr,
    MONTHNAME(a.admit_date) AS month_name,
    MONTH(a.admit_date) AS month_num,
    SUM(b.total_amount) AS monthly_revenue,
    SUM(SUM(b.total_amount))
        OVER (
            ORDER BY YEAR(a.admit_date),
                     MONTH(a.admit_date)
        ) AS running_total
FROM billing b
JOIN admissions a
    ON b.admission_id = a.admission_id
GROUP BY
    YEAR(a.admit_date),
    MONTH(a.admit_date),
    MONTHNAME(a.admit_date)
ORDER BY
    yr,
    month_num;

-- Window Function 2b: Rank doctors within each department

SELECT
    dept.dept_name,
    d.name AS doctor_name,
    COUNT(a.admission_id) AS admissions,
    RANK() OVER (
        PARTITION BY dept.dept_id
        ORDER BY COUNT(a.admission_id) DESC
    ) AS dept_rank
FROM admissions a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN departments dept
    ON a.dept_id = dept.dept_id
GROUP BY
    dept.dept_id,
    dept.dept_name,
    d.doctor_id,
    d.name
ORDER BY
    dept.dept_name,
    dept_rank;

-- Create View: Admission Summary

CREATE OR REPLACE VIEW vw_admission_summary AS

SELECT
    a.admission_id,
    p.name AS patient_name,
    TIMESTAMPDIFF(YEAR, p.dob, a.admit_date) AS age_at_admission,
    p.gender,
    p.blood_group,
    d.name AS doctor_name,
    d.specialization,
    dept.dept_name,
    a.admit_date,
    a.discharge_date,
    DATEDIFF(a.discharge_date, a.admit_date) AS stay_days,
    a.ward,
    a.diagnosis,
    a.status,
    b.total_amount AS bill_amount,
    b.paid_status
FROM admissions a
JOIN patients p
    ON a.patient_id = p.patient_id
JOIN doctors d
    ON a.doctor_id = d.doctor_id
JOIN departments dept
    ON a.dept_id = dept.dept_id
LEFT JOIN billing b
    ON a.admission_id = b.admission_id;

-- View Query 1

SELECT *
FROM vw_admission_summary
WHERE dept_name = 'Cardiology';

-- View Query 2

SELECT
    patient_name,
    doctor_name,
    diagnosis,
    bill_amount
FROM vw_admission_summary
WHERE bill_amount > 50000
ORDER BY bill_amount DESC;



-- Step 4: Stored Procedure – Automated Monthly Report

DELIMITER $$

CREATE PROCEDURE GenerateMonthlyReport(
    IN p_year INT,
    IN p_month INT
)

BEGIN

    -- Section 1: Monthly Report Title

    SELECT
        'MONTHLY HOSPITAL REPORT' AS report_title,
        p_year AS report_year,
        p_month AS report_month;

    -- Section 2: Admissions Count and Revenue

    SELECT COUNT(a.admission_id) AS total_admissions,
        SUM(b.total_amount) AS total_revenue,
        ROUND(AVG(b.total_amount), 2) AS avg_bill_per_patient,
        SUM(CASE
                WHEN b.paid_status = 'Paid'
                THEN b.total_amount
                ELSE 0
            END) AS paid_amount,
        SUM(CASE
                WHEN b.paid_status = 'Pending'
                THEN b.total_amount
                ELSE 0
            END) AS pending_amount
    FROM admissions a
    JOIN billing b
        ON a.admission_id = b.admission_id
    WHERE YEAR(a.admit_date) = p_year
      AND MONTH(a.admit_date) = p_month;

    -- Section 3: Admissions per Department

    SELECT
        dept.dept_name,
        COUNT(a.admission_id) AS admissions,
        SUM(b.total_amount) AS dept_revenue
    FROM admissions a
    JOIN departments dept
        ON a.dept_id = dept.dept_id
    JOIN billing b
        ON a.admission_id = b.admission_id
    WHERE YEAR(a.admit_date) = p_year
      AND MONTH(a.admit_date) = p_month
    GROUP BY
        dept.dept_id,
        dept.dept_name
    ORDER BY dept_revenue DESC;

    -- Section 4: Doctor Workload

    SELECT
        d.name AS doctor_name,
        COUNT(a.admission_id) AS patients_treated
    FROM admissions a
    JOIN doctors d
        ON a.doctor_id = d.doctor_id
    WHERE YEAR(a.admit_date) = p_year
      AND MONTH(a.admit_date) = p_month
    GROUP BY
        d.doctor_id,
        d.name
    ORDER BY patients_treated DESC;

END $$

DELIMITER ;

-- Call the Procedure for January 2023

CALL GenerateMonthlyReport(2023, 1);

-- Call the Procedure for May 2023

CALL GenerateMonthlyReport(2023, 5);

DROP PROCEDURE IF EXISTS GenerateMonthlyReport;

