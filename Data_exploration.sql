
/* Covid 19 Data Exploration */


-- Select Data that we are going to be starting with
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeaths]
ORDER BY location, date;

SELECT *
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Total Cases vs Total Deaths
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [dbo].[CovidDeaths]
ORDER BY location, date;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT Location, date, total_cases,total_deaths, ROUND((total_deaths/total_cases)*100,2) as DeathPercentage
FROM [dbo].[CovidDeaths]
WHERE location LIKE '%states%'
AND continent IS NOT NULL 
ORDER BY location, date DESC;

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
SELECT location, date, population, total_cases, ROUND((total_cases/population)*100,2) as PercentPopulationInfected
FROM [dbo].[CovidDeaths]
WHERE location = 'Philippines'
ORDER BY location, date DESC;


-- Top 10 countries with Highest Infection Rate compared to Population
SELECT TOP 10 location, population, MAX(total_cases) as HighestInfectionCount,  
						ROUND(Max((total_cases/population))*100,2) as PercentPopulationInfected
FROM [dbo].[CovidDeaths]
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Top 10 countries with Highest Death Count per Population
SELECT TOP 10 location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population
SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM [dbo].[CovidDeaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;


-- GLOBAL NUMBERS
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, 
		ROUND(SUM(CAST(new_deaths AS INT))/SUM(New_Cases)*100,2) AS DeathPercentage
FROM [dbo].[CovidDeaths]
WHERE continent is not null 
ORDER BY total_cases, total_deaths;
