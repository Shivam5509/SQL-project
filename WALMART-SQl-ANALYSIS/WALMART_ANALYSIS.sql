use shivam;
--1.Write a query to display all columns for every record in the dataset.
select * from walmart;

--2.Write a query to display only InvoiceID, Branch, and City from the table.
select invoice_id,branch,city from walmart;

--3.Write a query to find all records where the City is "New York".
select * from walmart where city='New york';

--4.Write a query to display all records where the Quantity is greater than 10.
select * from walmart where quantity>10;

--5.Write a query to display all records where the Payment method is "Cash".
select * from walmart where payment_method='cash';

--6.Write a query to display all columns, ordering the results by Rating in descending order.
select * from walmart order by rating desc;

--7.Write a query to filter the records where UnitPrice is greater than 50.
select * from walmart where unit_price>50;

--8.Write a query to display distinct values of the ProductLine.
select distinct category from walmart;

--9.Write a query to find the total tax collected across all transactions.
select sum(unit_price*quantity*0.1) as tax from walmart;

--10.Write a query to count the number of records where the City is "New York".
select count(*) as no_of_records from walmart where city='New york';

--11.Write a query to list all records from the table where the Date is after '2023-01-01'.
select * from walmart where date>'2023-01-01';

--12.Write a query to show the average UnitPrice for all records.
select avg(unit_price) as avg_price from walmart;

--13.Write a query to find the top 5 records with the highest Total sales.
select top 5 unit_price from walmart order by unit_price desc;

--14.Write a query to display the total Quantity sold in each City.
select  category, sum(quantity) as total_quantity_sold from walmart group by category;

--15.Write a query to calculate the average Rating for each Branch.
select category, avg(rating) as avg_rating from walmart group by category;

--16.Write a query to find the maximum Total sales for each ProductLine.
select category as productline , max(unit_price*quantity) as maximum_total_sale 
	from walmart group by category ;

--17.Write a query to display the InvoiceID, ProductLine, and Total, 
--only for sales where the Tax is above 5.
select invoice_id,category as productline, sum(unit_price*quantity*0.1) as tax from walmart 
	group by invoice_id,category
	having sum(unit_price*quantity*0.1)>5;

--18.Write a query to count the total number of transactions for each Payment method.
select payment_method , count(payment_method) as total_no_of_transactions from walmart 
	group by payment_method;

--19.Write a query to find the Branch with the lowest average Rating.
select top 1 category, avg(rating) as avg_rating from walmart 
	group by category
	order by avg(rating) asc;

--20.Write a query to find the top 3 ProductLine categories 
--based on the total Total sales amount.
select top 3 category as productline , sum(quantity*unit_price) as total_sale from
	walmart group by category
	order by sum(quantity*unit_price) desc;

--21.Write a query to display all customers from Georgetown
--   who purchased more than 10 units of any product.
select branch,category, sum(quantity)as total from walmart where city='Georgetown'
	group by branch,category
	having sum(quantity)>10;

--22.Write a query to find the City where the total Quantity sold is the highest.
select  top 1 city , sum(quantity) as total_quantity_sold from walmart 
	group by city
	order by sum(quantity) desc;

--23.Write a query to count the total number of sales where the Payment method was 
--   either "Cash" or "Ewallet".
select payment_method, sum(quantity) as total_no_of_sales from walmart 
	where payment_method in ('Cash' , 'Ewallet')
	group by payment_method;

--24.Write a query to find the total Total sales made by the 
--   "Health and Beauty" product line.
select sum(quantity*unit_price) as total_no_of_sales from walmart 
	where category ='Health and Beauty';

--25.Write a query to calculate the total Total sales and 
--   group the results by payment_method and City.
select city,payment_method, sum(quantity*unit_price) as total_no_of_sales from walmart
group by city,payment_method;

--26.Write a query to find the cumulative Total sales per day using a window function.
select invoice_id , branch, city, 
		sum(unit_price*quantity) over 
		(order by date rows between unbounded preceding and current row) as cumulative_Total_sales
		from walmart;

--27.Write a query to find the running total of Total sales for each Branch using a window function.
select invoice_id , branch, city, 
		sum(unit_price*quantity) over 
		(partition by branch order by date rows between unbounded preceding and current row) as cumulative_Total_sales
		from walmart;

--28.Write a query to calculate the rank of each City based on its total Total sales.
select  city,
        sum(unit_price*quantity) as total_sales,
		rank() over (order by sum(unit_price*quantity) desc)as ranking 
		from walmart
		group by city;

--29.Write a query to calculate the percentage contribution of each 
-----ProductLine to the overall Total sales.
select
     distinct category,
	(sum(unit_price*quantity) over (partition by category) ) *100 / (sum(unit_price*quantity) over() ) as percentage_contribution 
	from walmart;

--30.Write a query to find the difference between the maximum 
--   and minimum Total sales for each Branch.
select  distinct branch , 
	max(unit_price*quantity) over (partition by branch) - 
	min(unit_price*quantity) over(partition by branch) as difference__in_sales
	from walmart;

--31.Write a query to find the month-over-month growth in total Total sales.
with cte as(
select month(date) as month,
       year(date) as year,
	   sum(unit_price*quantity) as total_sales 
	   from walmart
	   group by month(date),year(date))
select month,year, total_sales,
       lag(total_sales,1) over (order by month,year) as previous_month_sales,
	   ((total_sales - lag(total_sales,1) over (order by month,year) / lag(total_sales,1) over (order by month,year))* 100 ) as month_over_month_growth
	   from cte;

--32.Write a query to display the top 3 Branches with the 
-----highest number of transactions using a window function.
with cte as (
select  distinct branch,
	count(payment_method) over (partition by branch) as no_of_transaction
	from walmart )
	select top 3 branch , no_of_transaction from cte 
	order by no_of_transaction desc;

--33.Write a query to list all sales where the UnitPrice is within 
-----20% of the maximum UnitPrice across all transactions.(20% = 1/5)
select unit_price from walmart 
	where unit_price < (select max(unit_price)/5 as max_unit_price from walmart);

--34.Write a query to find the average Rating of all transactions, partitioned by Gender and ProductLine.
select category, payment_method,
	avg(rating) over (partition by payment_method , category ) as avg_rating
	from walmart;

--35.Write a query to display the Branch and City with the most transactions using a subquery.
select branch , city from walmart 
	group by branch , city
	having count(*)=( 
	select max(transaction_count) from (
	select count(*) as transaction_count
	from walmart group by branch,city) 
	as subquery);









	
		

