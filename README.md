# SQL_PortfolioProject
COVID-19 Data Exploration
This repository contains a SQL file for data exploration of a COVID-19 dataset. The SQL queries perform various data analysis tasks such as filtering, aggregation, and joining tables.

Dataset
The dataset used in these queries is stored in the Sql_PortfolioProject database and includes two tables: Covid_Death and Covid_Vaccination. The Covid_Death table contains information about COVID-19 cases and deaths, while the Covid_Vaccination table contains information about COVID-19 vaccinations.

Queries
The SQL file includes several queries that perform different types of data analysis:

Basic Filtering: The first query selects all records from the Covid_Death table where the continent is not NULL.
Selecting Specific Attributes: The second query selects specific attributes such as Location, date, new_cases, total_cases, total_deaths, and population from the Covid_Death table.
Calculating Death Percentage: The third query calculates the death percentage for a specific location (e.g., ‘Afghanistan’).
Calculating Infection Rate: The fourth query calculates the infection rate with respect to the population for a specific location (e.g., ‘Pakistan’).
Finding Highest Infection Rate: The fifth query finds the locations with the highest infection rate with respect to the population.
Calculating Death Rate: The sixth and seventh queries calculate the death rate for each location and continent, respectively.
Calculating Global Numbers: The eighth query calculates the total number of cases, total number of deaths, and death percentage globally.
Joining Tables: The ninth query joins the Covid_Death and Covid_Vaccination tables based on Location and date.
Analyzing Vaccination Data: The tenth to twelfth queries analyze the vaccination data, including the number of people vaccinated per day in a specific country (e.g., ‘Canada’) and the cumulative sum of vaccinations.
Using Common Table Expressions (CTEs): The last query uses a CTE to calculate the cumulative sum of vaccinations for each location.
Usage
To use these queries, you need to have access to the Sql_PortfolioProject database and the Covid_Death and Covid_Vaccination tables. You can run these queries in any SQL client or database management tool that supports SQL.

Please note that these queries are for data exploration purposes and the results may vary depending on the data in your tables.
