Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write an SQL query to report the patient_id, patient_name all conditions of patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
insert into patients values(1,'Daniel','YFEV COUGH');
insert into patients values(2,'Alice','');
insert into patients values(3,'Bob','DIAB100 MYOP');
insert into patients values(4,'George','ACNE DIAB100');
insert into patients values(5,'Alain','DIAB201');
insert into patients values(5,'John','SDIAB101');
+------------+--------------+--------------+
Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.

+--solution

create table patients (patent_id int, patient_name varchar(50), conditions varchar(100));

select * from patients where conditions like '% DIAB1%'
or  conditions like 'DIAB1%'