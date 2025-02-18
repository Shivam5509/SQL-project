use shivam;
--to get the all the data.
select * from students;

--Count the total number of students in the dataset.
select count(*) as total_students from students;

--List all unique majors in the dataset.
select distinct major from students;

--Find the students who have a GPA greater than or equal to 3.5.
select student_id, name, gpa from students 
    where gpa>=3.5;

--List all the students who are interested in "Artificial Intelligence."
select student_id, name , Interested_Domain from students 
    where Interested_Domain='Artificial Intelligence';

--Get the students who are majoring in "Computer Science" and 
--have "Strong" proficiency in Python.
select student_id, name, major, python from students 
    where major='computer science' and python='strong';

--Find the number of students with each proficiency 
--level (Strong, Average, Weak) in SQL.
select sql,count(student_id) as total_students from students 
    group by sql;

--Retrieve the names of students who have a GPA greater than 3.7.
select student_id, name from students
    where gpa>3.7;

--List all students who are interested in "Web Development" and 
--have a GPA above 3.5.
select student_id, name from students 
    where interested_domain='Web Development' and gpa >3.5;

--Count how many students are pursuing a career as a "Software Engineer."
select count(student_id) as total_students from students 
    where future_career='software engineer';

--Retrieve all students whose Future Career contains the word "Developer."
select student_id, name,future_career from students 
    where future_career like '%developer%';

-- Find the average GPA for students in each major.
select round(avg(gpa),2) as avg_gpa from students ;

--List the top 5 students with the highest GPA.
select top 5 student_id, name,gpa from students 
   order by gpa desc;

--Find the number of students per career domain 
--(e.g., Software Engineering, Cloud Computing).
select Interested_domain, count(*)from students 
   group by Interested_Domain;

--Get the students with GPA above 3.6 who are interested 
--in "Mobile App Development."
select student_id, name, gpa,interested_domain from students 
   where gpa>3.6 and Interested_Domain='mobile app development';

--List the students who are interested in 
--"Data Science" or "Machine Learning."
select student_id, name, interested_domain from students 
   where interested_domain in ('Data Science' , 'Machine Learning');

--Find the average age of students pursuing each career
--(e.g., Database Administrator, Machine Learning Engineer).
select future_career, avg(age) as avg_age from students 
   group by future_career;

--List all students with SQL proficiency labeled as "Average" or "Weak."
select student_id, name , sql as sql_proficiency from students 
   where sql in('average','weak');

--Find the students who are interested in 
--"Cloud Computing" and have the highest GPA.
select student_id, name, interested_domain , gpa from students 
   where interested_domain='cloud computing' and 
   gpa=(select max(gpa) from students);

--Rank students by GPA and display their rank for each major using ROW_NUMBER().
select name, gpa, 
	row_number() over (partition by major order by gpa desc) as ranking 
	from students;

--Retrieve the students with the strongest proficiency in "Java."
select student_id, name, java as java_proficiency from students
	where java= 'strong';

--Calculate the average GPA for each "Interested Domain" 
--(e.g., Artificial Intelligence, Web Development).
select interested_domain , avg(gpa) as avg_gpa from students 
	group by interested_domain;

--Use the RANK() function to rank students based on their GPA within their major.
select name,  major, gpa, 
	rank() over (order by gpa desc) as ranking 
	from students;

--Find the difference in GPA between the top 3 students and 
--the bottom 3 students within each major.
with cte as(
     select top 3 student_id, name,
     dense_rank() over (partition by major order by gpa desc) as from_highest,
	 dense_rank() over (partition by major order by gpa asc) as from_lowest 
	 from students)
	 select student_id, name,(from_highest-from_lowest) from cte;

--Using NTILE(4), divide students into 4 groups based on their GPA and 
--list the number of students in each quartile.
with cte as (
	select student_id, name, 
    ntile(4) over (  order by gpa ) as division from students)
	select division,
	count(student_id) as total_students_in_each_quartile
	from cte 
	group by division 
	order by division;

--Find the students who are interested in "Machine Learning" and 
--have a GPA greater than the average GPA for that domain.
select student_id, name, gpa, interested_domain from students
	where interested_domain ='Machine Learning' and
	GPA>(select avg(gpa) from students);

--Perform a self-join to find students who have the same major and 
--future career path but different proficiency levels in Java.
select a.student_id, a.name, a.major, a.future_career, 
	a.java AS java_proficiency_a
	from students a join students b on 
    a.future_career=b.future_career and a.major=b.major
    order by a.major, a.Future_Career;

--Use a LEAD() function to compare each student's GPA with
--the GPA of the next student in the dataset.
select student_id, name, 
     lead(gpa) over(order by gpa desc) as next_gpa,
     (gpa-lead(gpa) over(order by gpa desc) ) as comarison 
	 from students;

--For each student, calculate the difference between their GPA and 
--the average GPA for their major.
select student_id, name, major , 
	avg(gpa) over (partition by major),
	(gpa-avg(gpa) over (partition by major)) as diff from students

--Find the percentage of students in each career path with 
--"Strong" proficiency in Python using COUNT() and GROUP BY.
select  future_career,
     sum (case when python='strong' then 1 else 0 end) * 100 /
     count(*) as percentage_of_students 
	 from students 
	 group by future_career;

--Using a window function, calculate the cumulative GPA of students for each major and 
--display their running total GPA.
select sum(gpa) over(partition by major order by gpa 
     rows between unbounded preceding and current row) as running_total_gpa
	 from students ;