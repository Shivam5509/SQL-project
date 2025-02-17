use shivam;
select * from Employees ;

--Write a query to find the total number of employees.
select count(*) as Total_employee from Employees;

--Write a query to find the total number of employees in each department.
select department, count(*) as Total_employee from employees group by department;

--Write a query to count how many employees are working in each job role.
select job_role, count(*) as Total_employee from employees group by job_role;

--Write a query to calculate the average age of employees.
select avg(age) as avg_age from employees;

--Write a query to retrieve the employees who have a job satisfaction score greater than 4.
select * from employees where job_satisfaction>4;

--Write a query to count how many employees have left the company (Attrition = 'Yes').
select count(emp_no) as left_employee from employees 
where attrition =1;

--Write a query to find the employee number of employees working in the "Sales" department.
select emp_no from employees 
where department = 'Sales';

--Write a query to calculate the number of male and female employees.
select gender, count(gender) as total_no from employees 
group by gender;

--Write a query to find out how many employees have each education field (e.g., Life Sciences, Medical).
select education_field, count(education_field) as Field_Distribution from employees
group by education_field;

--Write a query to list employees who frequently travel for business.
select * from employees where business_travel='Travel_Frequently';

--Write a query to list employees who frequently travel for business.
select age_band,count(age_band) as total_no_of_employee from employees 
group by age_band;

--Write a query to find the attrition rate for each department.
select department,
      sum(case when attrition= '1' then 1 else 0 end)*100/count (*) as attrition_rate 
	  from employees group by department;

--Write a query to calculate the average age for employees in each department.
select department,avg(age) as avg_age from employees group by department;

--Write a query to find the average job satisfaction score for each job role.
select job_role, avg(job_satisfaction) as average_score from employees 
group by job_role;

--Write a query to count how many employees of each education level work in each job role.
select job_role, education, count(education) as total_level from employees 
group by job_role,education;

--Write a query to find the names and ages of employees who have left the company and 
--had a job satisfaction score below 3.
select emp_no, age from employees 
where attrition=1 and job_satisfaction>3;

--Write a query to retrieve the employee who has been with the 
--company the longest (based on years with the company).
select top 1 emp_no , age as age from employees 
order by age desc;

--Write a query to find the average age of employees for each job role.
select job_role, avg(age) as avg_age from employees 
group by job_role;

--Write a query to count id grouped by age bands and gender.
select age_band,age,count(emp_no) as total_employees from employees 
group by age_band,age;

--Write a query to find the average job satisfaction of employees 
--who have left the company.
select avg (job_satisfaction) as avg_job_satisfaction from employees 
where attrition=1;

--Find the education level with the highest average job satisfaction 
--among employees who travel frequently.
select top 1 education, avg(job_satisfaction) as avg_job_satisfaction
from employees
where business_travel = 'Travel_Frequently'
group by education
order by avg_job_satisfaction desc;

--Identify the age band with the highest average job satisfaction
--among married employees ----
select top 1 age_band , avg(job_satisfaction) as avg_job_satisfaction
from employees 
where marital_status= 'Married'
group by age_band
order by avg(job_satisfaction) desc;

--Identify the departments with the highest and 
--lowest average job satisfaction ---
with cte as (
   select department, avg(job_satisfaction) as avg_job_satisfaction 
   from employees 
   group by department)
select department, avg_job_satisfaction from cte
where avg_job_satisfaction= (select  max(avg_job_satisfaction) from cte)
 and avg_job_satisfaction= (select  min(avg_job_satisfaction) from cte); 

 --Write a query to find the attrition rate by age group and job role.
 select age_band,job_role ,
 (sum(case when attrition=1 then 1 else 0 end)*100)/count(*) as attrition_rate  
 from employees 
 group by age_band, job_role
 order by age_band;

 ---Write a query to determine which job roles have the highest attrition rates.
select top 1 job_role, 
((sum(case when attrition=1 then 1 else 0 end)*100)/count(*)) as attrition_rate 
from employees
group by job_role;

--Write a query to find the attrition rate for employees at 
--each education level (e.g., Bachelor’s, Master’s).
select education, 
((sum(case when attrition=1 then 1 else 0 end)*100)/count(*)) as attrition_rate
from employees 
group by education;

--Write a query to find the average job satisfaction score 
--by gender and job role.
select job_role,gender, avg(job_satisfaction) as avg_job_satisfaction 
from employees
group by gender, job_role;
