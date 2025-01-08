-- Data Cleaning


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove Any Columns

select *
from 
	covid_19_clean_complete;

create table 
	covid_19
like
	covid_19_clean_complete;

select *
from 
	covid_19;

insert 
	covid_19
select *
from 
	covid_19_clean_complete; 

-- Checking for Duplicates

select *,
row_number()
over(partition by
 `Province/State`,`Country/Region`, Lat, `Long`, `Date`, Confirmed, Deaths, Recovered, `Active`, `WHO Region`
 ) as row_num
from 
	covid_19;


with duplicate_cte as 
(
select *,
row_number()
over(
partition by `Province/State`,`Country/Region`, Lat, `Long`, `Date`, Confirmed, Deaths, Recovered, `Active`, `WHO Region`
 ) as row_num
from 
	covid_19
)
select *
from 
	duplicate_cte
where 
	row_num > 1;

-- Result => Gives 0 rows with row_num > 1 i.e No duplicate found.



-- 2. Standardize the Data
select 
	distinct `Province/State`
from 
	covid_19
order by 
	1;

select distinct 
	`Country/Region`
from 
	covid_19
order by
	1;

select distinct 
	`Who Region`
from
	covid_19;


update 
	covid_19
set 
	`Province/State` = trim(`Province/State`),
	`Country/Region` = trim(`Country/Region`),
	`Who Region` = trim(`Who Region`);

update 
	covid_19
set 
	`Country/Region` = 'United States'
Where 
	`Country/Region` = 'US';

select 
	`Date`,
	str_to_date(`Date`, '%Y-%m-%d')
from
	covid_19;

update
	covid_19
set 
	`Date` = str_to_date(`Date`, '%Y-%m-%d');

alter table 
	covid_19
modify column `date` DATE;



-- 3. Null values or blank values

select *
from 
	covid_19;

select *
from 
	covid_19
where 
	`Country/Region`is null 
or `
	Country/Region`= '';

select *
from 
	covid_19
where 
	`WHO Region`is null 
or 
	`WHO Region`= '';

select *
from 
	covid_19
where 
	`Province/State`is null 
or 
	`Province/State`= '';

 -- Not enough information to adjust Provice/State columns which are NULL. Not advisable to delete the rows.
 
 
 -- 4. Remove Any Columns
 -- No column to remove