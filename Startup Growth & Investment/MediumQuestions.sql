use shivam;
select top 100 * from startup;

--1.Join the startups table with the funding table and 
--display the startup name along with its total funding.
select startup_name , industry from startup 
	where industry in ('fintech', 'saas');

--2.List all startups that are NOT in the "HealthTech" industry.
 select startup_name , industry from startup 
	where industry  not in ('healthtech');

--3.Retrieve all startups whose name starts with 'S'.
select startup_name , industry from startup 
	where startup_name like 's%';

--4.Find all startups whose industry contains 'Tech' in the name.
select startup_name , industry from startup 
	where industry like '%tech%'; 

--5.Find the startup with the second-highest valuation.
select top 1 startup_name, valuation_usd as second_max_valuation from startup 
	where valuation_usd<(select max(valuation_usd) from startup)
	order by valuation_usd desc;

--6.Retrieve startups with a valuation greater than 
--the average valuation of all startups.
select startup_name from startup 
	group by startup_name
	having max(valuation_usd )>(select avg(valuation_usd)from startup);

--7.Group startups by industry and show only industries with 
--a total funding greater than $50 million.
select industry from startup 
	group by industry
	having investment_amount_usd>50000000;

--8.Find countries where the total number of startups exceeds 10.
select country from startup 
	group by country 
	having count(startup_name)>10;

--9.Display each startup's funding status as "High" if their 
--funding exceeds $20 million, otherwise "Low."
select startup_name, 
	case 
	when investment_amount_usd>200000000 then 'High' 
	else 'low' 
	end as funding_status 
	from startup;

--10.Assign categories to startups based on their valuation 
--(e.g., "Unicorn" for valuations above $100 billion).
select startup_name, 
	case 
	when valuation_usd>1000000000 then 'Unicorn'
	else 'Not Unicorn' 
	end as catogory 
	from startup;

--11.List the top 5 most-funded startups.
select top 5 startup_name, Investment_Amount_USD from startup 
	order by Investment_Amount_USD desc;

--12.Show the top 3 startups with the highest valuations.
select top 3 startup_name, Valuation_USD from startup 
	order by valuation_USD desc; 