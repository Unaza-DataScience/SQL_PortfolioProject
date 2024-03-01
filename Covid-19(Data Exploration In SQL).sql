
SELECT *
FROM Sql_PortfolioProject . dbo.Covid_Death
where continent is not NULL
order by 2, 3,4

--Select the attributes you wanted to work on

Select Location, date,  new_cases, total_cases, total_deaths, population
FROM Sql_PortfolioProject . .Covid_Death
ORDER BY 1,2

--Total cases & total deaths in particular country


Select Location, date,  total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 AS DeathPercentage
FROM Sql_PortfolioProject . dbo.Covid_Death
Where Location like 'Afghanistan' and continent is not NULL
order by 1,2



--Total cases & population infected from covid in a particular country

Select Location, date, population, total_cases,  ( total_cases/  population)*100 AS PercentageInfectedPopulation
FROM Sql_PortfolioProject . dbo.Covid_Death
Where location like 'Pakistan' and continent is not NULL
order by 1,2

--Which countries got highest infection rate w.r.t population

Select Location, population, MAX(total_cases) as HighestInfected,  Max(( total_cases/  population))*100 AS PercentageInfectedPopulation
FROM Sql_PortfolioProject . dbo.Covid_Death
where continent is not NULL
Group by Location, population
order by PercentageInfectedPopulation DESC

Select Location, MAX(cast(total_deaths as int)) as DeathRate
FROM Sql_PortfolioProject . dbo.Covid_Death
where continent is NULL
Group by Location
order by DeathRate DESC

--Now split th data according to continent

Select continent, MAX(cast(total_deaths as int)) as DeathRate
FROM Sql_PortfolioProject . dbo.Covid_Death
where continent is not NULL
Group by continent
order by DeathRate DESC

--Global numbers

Select SUM(new_cases) as Total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Sql_PortfolioProject..Covid_Death
where continent is not null 
order by 1,2
--Joining two tables 
SELECT *
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date

--Analysis of total no.of people vaccinated vs total population

SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null
order by 2,3

--No. of Vaccinated people per day in any specific country

SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null and CD.location = 'Canada'
order by 2,3

SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations, SUM(convert(bigint, CV. new_vaccinations)) OVER (Partition by CD.location)
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null
order by 2,3


SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations, SUM(convert(bigint, CV. new_vaccinations)) OVER (Partition by CD.location ORDER BY CD.Location, CD.Date) as CommulativeSum
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null 
order by 2,3


--Use of Common Table Expression
With VaccVsPopu (Location, Continent, Date, Population, new_vaccination, CommulativeSum)
as (
SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations, SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.Date ROWS UNBOUNDED PRECEDING) as CommulativeSum
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null 
)
select * , (CommulativeSum/Population)*100
from VaccVsPopu

--Temp Tables
DROP TABLE if exists #VaccinatedPopulation
CREATE Table #VaccinatedPopulation(
Continent nvarchar(255), Location nvarchar(255), Date datetime, Population numeric, New_vaccinations numeric, CommulativeSum numeric)
INSERT INTO #VaccinatedPopulation
SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations,   SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.Date ROWS UNBOUNDED PRECEDING) as CommulativeSum
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
--where CD. continent is not null 
--order by 2,3

select * , (CommulativeSum/Population)*100 as 
from #VaccinatedPopulation

--DATA Visualization

Create view VaccinatedPopulation as
SELECT CD.Location, CD.Continent, CD.Date, CD.Population, CV.new_vaccinations,   SUM(CONVERT(bigint, CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CD.Date ROWS UNBOUNDED PRECEDING) as CommulativeSum
FROM Sql_PortfolioProject..Covid_Death CD
JOIN Sql_PortfolioProject..Covid_Vaccination    CV
ON CD.Location = CV.Location
and CD.date = CV.date
where CD. continent is not null 
--order by 2,3


Select *
from VaccinatedPopulation