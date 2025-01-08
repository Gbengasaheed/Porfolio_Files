-- Exploratory Data Analysis

SELECT *
FROM covid_19;

-- Checking for the Country with the highest deaths and it's Province

SELECT 
	`Country/Region`,`Province/State`, MAX(Deaths)
FROM 
	covid_19
GROUP BY 
	`Country/Region`,`Province/State`
ORDER BY 
	MAX(Deaths) DESC;

-- OR Using cte 

WITH RankedCountries AS (
    SELECT 
        `Country/Region`, `Province/State`, Deaths,
        ROW_NUMBER() OVER (PARTITION BY `Country/Region`,`Province/State` ORDER BY Deaths DESC) AS rank_num
    FROM 
        covid_19
)
SELECT 
   `Country/Region`, `Province/State`, Deaths
FROM employee_demographics
    RankedCountries
WHERE 
    rank_num = 1
ORDER BY 
    Deaths DESC;


-- Summing up death counts in each country in descending order

SELECT 
	`Country/Region`, SUM(Deaths)
FROM 
	covid_19
GROUP BY 
	`Country/Region`
ORDER BY
	SUM(Deaths) DESC;


-- Checking for the country with the highest recovery 

with HighestRecovery AS
(
SELECT 
`Country/Region`, `Province/State`, Recovered,
ROW_NUMBER() OVER(PARTITION BY `Country/Region`, `Province/State` ORDER BY RECOVERED DESC) AS Row_num
FROM covid_19
)
SELECT
 `Country/Region`, `Province/State`, Recovered
FROM 
	HighestRecovery
WHERE
	Row_num = 1
ORDER BY 
	Recovered DESC;
    
    
-- Summing up Recovery counts in each country in descending order

SELECT  
	`Country/Region`, SUM(Recovered)
FROM
	covid_19
GROUP BY 
	 `Country/Region`
ORDER BY SUM(Recovered) DESC;
