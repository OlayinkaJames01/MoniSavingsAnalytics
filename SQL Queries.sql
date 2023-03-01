SELECT * FROM dataset;

DESCRIBE dataset;

-- What is the total amount of principal invested across all funding types and savings types?
SELECT SUM(principal_amount) AS total_principal_invested
FROM dataset;

-- What is the average interest rate for all the funding types
SELECT AVG(schedule_interest_per_day*365) AS avg_interest_rate_annual
FROM dataset;

-- What is the average interest rate based on different categories
SELECT CASE WHEN savings_type_id = 1 THEN 'Category 1'
			WHEN savings_type_id = 2 THEN 'Category 2'
			ELSE 'Category 3' END AS 'Savings Type Category',
			AVG(schedule_interest_per_day*365) AS avg_interest_rate_annual
FROM dataset
GROUP BY 1

-- What is the funding type based on average amount per frequency
SELECT DISTINCT(funding_primary_type), AVG(amount_per_frequency)
FROM dataset
GROUP BY 1
ORDER BY 2 DESC

-- What is the total target_amount and the total amount invested for each status_id?
SELECT status_id, 
SUM(target_amount) AS total_target_amount, 
SUM(principal_amount) AS total_principal_invested
FROM dataset
GROUP BY status_id;

-- - What is the total target_amount and the total amount invested for each savings_type_category?
SELECT CASE WHEN savings_type_id = 1 THEN 'Category 1'
			WHEN savings_type_id = 2 THEN 'Category 2'
			ELSE 'Category 3' END AS 'Savings Type Category', 
SUM(target_amount) AS total_target_amount, 
SUM(principal_amount) AS total_principal_invested
FROM dataset
GROUP BY 1;

-- - What is the total target_amount and the total amount invested for each savings_type_category in tandem with status ID?
SELECT CASE WHEN savings_type_id = 1 THEN 'Category 1'
			WHEN savings_type_id = 2 THEN 'Category 2'
			ELSE 'Category 3' END AS 'Savings Type Category', 
SUM(target_amount) AS total_target_amount, 
SUM(principal_amount) AS total_principal_invested
WHERE funding_primary_type IN ('card')
FROM dataset
GROUP BY 1;

-- Groupby Saving Type into Category
SELECT CASE WHEN savings_type_id = 1 THEN 'Category 1'
			WHEN savings_type_id = 2 THEN 'Category 2'
			ELSE 'Category 3' END AS 'Savings Type Category',
        COUNT(savings_type_id) as 'count_saving_type',
        savings_type_id
FROM dataset
GROUP BY savings_type_id
ORDER BY savings_type_id DESC

SELECT funding_primary_type FROM dataset;


-- Scheduled Frequency by Average Target Amount
SELECT 	CASE WHEN schedule_frequency = '"monthly"' THEN "monthly"
			 WHEN schedule_frequency = '"daily"' THEN "daily"
             WHEN schedule_frequency = '"weekly"' THEN "weekly"
             WHEN schedule_frequency = '"bi-weekly"' THEN "bi-weekly"
			 ELSE 'Not Specified' END AS 'Scheduled_freq',
        AVG(target_amount) AS 'Avg. Target Amount'
FROM dataset
-- WHERE funding_primary_type = '"card"' 
GROUP BY 1
ORDER BY 2 DESC

-- Total target amount based on Funding type by saving type category
SELECT  DISTINCT(funding_primary_type), 
		CASE WHEN savings_type_id = 1 THEN 'Category 1'
			 WHEN savings_type_id = 2 THEN 'Category 2'
			 ELSE 'Category 3' END AS 'Savings Type Category',
		SUM(target_amount) AS Total_target_amount
FROM dataset
GROUP BY 1, 2
ORDER BY Total_target_amount DESC


-- what is the average duration based on funding type
SELECT funding_primary_type, AVG(duration) AS avg_duration
FROM dataset
GROUP BY funding_primary_type;


-- -- what is the average duration based on savings type category
SELECT CASE WHEN savings_type_id = 1 THEN 'Category 1'
			 WHEN savings_type_id = 2 THEN 'Category 2'
			 ELSE 'Category 3' END AS 'Savings Type Category',
             AVG(duration) AS avg_duration
FROM dataset
GROUP BY 1;



