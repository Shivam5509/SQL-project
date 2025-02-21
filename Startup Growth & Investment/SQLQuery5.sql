use shivam;
select top 50 * from startup ;
---------Easy SQl Questions---------
--1.Retrieve the names of all startups in the database.
select startup_name from startup;

--2.Query the industry types for all startups.
select  startup_name , industry from startup;

--3.List all startups founded in the year 2022.
select  * from startup where year_founded = 2012;

--4.Find all startups that belong to the "FinTech" industry.
select * from startup where industry = 'fintech';

--5.List startups that received funding greater than $10 million.
select * from startup where investment_amount_usd > 10000000;

--6.Retrieve all startups from a specific country (e.g., India).
select * from startup where country='india';

--7.Show startups in order of their valuation from highest to lowest.
select startup_name, industry,valuation_usd from startup 
	order by valuation_usd desc;

--8.List all startups by funding amount, starting with the lowest.
select startup_name, industry,investment_amount_usd from startup 
	order by investment_amount_usd ;

--9.Find the total number of startups in the database.
select count(*) as total_no_of_startup from startup;

--10.Calculate the average funding of startups in the "EdTech" industry.
select avg(investment_amount_usd) as avg_funding from startup;

--11.Find the maximum valuation of a startup in the "HealthTech" industry.
select startup_name, industry, max(valuation_usd) as maximum_valuation 
	from startup 
	where industry= 'EdTech';

--12.Count how many startups belong to each industry.
select industry, count(*) as total_startup from startup 
	group by industry;

--13.Group startups by country and 
--calculate the total funding for each country.
select country, sum(investment_amount_usd)as total_funding from startup 
	group by country;

--14.Retrieve a list of unique industry types available in the dataset.
select distinct industry from startup;

--15.Find all distinct years in which startups were founded.
select distinct year_founded from startup;




