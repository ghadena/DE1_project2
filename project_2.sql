
#creating schema 
drop schema if exists project_2;
create schema project_2; 
use project_2; 

#creating country table 
DROP TABLE IF EXISTS country;
CREATE TABLE country (
	id integer not null,
    country_name varchar(225) not null,  
    country_code varchar(10) not null,  
    Region varchar(100) not null,        
    Year integer not null,          
    gdp_current_usd DECIMAL(20, 2),
    gdp_growth_annual_percent DECIMAL(5, 2),
    gdp_per_capita_current_usd DECIMAL(20, 2),
    gdp_per_capita_growth_annual_percent DECIMAL(5, 2),
    population_growth_annual_percent DECIMAL(5, 2),
    population_total DECIMAL(20, 2),
	PRIMARY KEY (id)
);

 # loading data into country table
LOAD DATA INFILE '/tmp/country_clean2.csv' 
INTO TABLE country
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, country_name, country_code, region, year, @gdp_current_usd, @gdp_growth_annual_percent, @gdp_per_capita_current_usd, @gdp_per_capita_growth_annual_percent, @population_growth_annual_percent, @population_total)
SET
    gdp_current_usd = NULLIF(@gdp_current_usd, ''),
    gdp_growth_annual_percent = NULLIF(@gdp_growth_annual_percent, ''),
    gdp_per_capita_current_usd = NULLIF(@gdp_per_capita_current_usd, ''),
    gdp_per_capita_growth_annual_percent = NULLIF(@gdp_per_capita_growth_annual_percent, ''),
    population_growth_annual_percent = NULLIF(@population_growth_annual_percent, ''),
    population_total = NULLIF(@population_total, '');
    

select * from country;


# creating healthcare spending table 
DROP TABLE IF EXISTS healthcare_spending;
CREATE TABLE healthcare_spending (
	id integer not null,
    country_name VARCHAR(225) NOT NULL,
    country_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    year INTEGER NOT NULL,
    current_health_expenditure_gdp DECIMAL(5, 2),
    health_expenditure_per_capita DECIMAL(20, 2),
    gov_health_expenditure DECIMAL(5, 2),
    private_health_expenditure DECIMAL(5, 2),
    external_health_expenditure DECIMAL(5, 2),
    out_of_pocket_expenditure DECIMAL(5, 2),
    PRIMARY KEY (id)
);

# Loading data into the healthcare spending table
LOAD DATA INFILE '/tmp/spending_clean2.csv'
INTO TABLE healthcare_spending
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id,country_name, country_code, region, year, @current_health_expenditure_gdp, @health_expenditure_per_capita, @gov_health_expenditure, @private_health_expenditure, @external_health_expenditure, @out_of_pocket_expenditure)
SET

    current_health_expenditure_gdp = NULLIF(@current_health_expenditure_gdp, ''),
    health_expenditure_per_capita = NULLIF(@health_expenditure_per_capita, ''),
    gov_health_expenditure = NULLIF(@gov_health_expenditure, ''),
    private_health_expenditure = NULLIF(@private_health_expenditure, ''),
    external_health_expenditure = NULLIF(@external_health_expenditure, ''),
    out_of_pocket_expenditure = NULLIF(@out_of_pocket_expenditure, '');

select * from healthcare_spending;

CREATE TABLE merged_table AS
SELECT 
    c.id AS country_id, 
    c.country_name, 
    c.region, 
    c.year, 
    c.gdp_current_usd,
    c.gdp_growth_annual_percent,
    c.gdp_per_capita_current_usd,
    c.gdp_per_capita_growth_annual_percent,
    c.population_growth_annual_percent,
    c.population_total,
    hs.id,
    hs.current_health_expenditure_gdp, 
    hs.health_expenditure_per_capita,
    hs.gov_health_expenditure,
    hs.private_health_expenditure,
    hs.external_health_expenditure,
    hs.out_of_pocket_expenditure
FROM 
    country c
LEFT JOIN 
    healthcare_spending hs
ON 
    c.id = hs.id;
    
select * from merged_table;

