
Select *
From [Portfolio Project]..CovidDeaths
Where continent is not null
Order By 3,4

--Select * 
--From [Portfolio Project]..CovidVaccinations
--Order By 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, New_cases, total_deaths, population
From [Portfolio Project]..CovidDeaths
order by 1,2

-- looking at total cases vs total deaths
-- Shows likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%states%'
order by 1,2

-- Looking at total cases vs population
-- Shows what percentage of population got covid
Select Location, date,  population, total_cases, (total_cases/population)*100 as CasesPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%states%'
order by 1,2

-- Looking at countries with highest infection rate compared to population
Select Location,  population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Group By Location, Population
order by PercentPopulationInfected Desc
-- Looking at countries with highest Infection Count
Select Location,  population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Group By Location, Population
order by HighestInfectionCount Desc

-- Showing Countries with highest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group By Location
order by TotalDeathCount Desc

-- LET'S BREAK THINGS DOWN BY CONTINENT


-- Showing continents with the highest death count per population

Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
Where continent is not null
Group by continent
ORDER BY TotalDeathCount DESC



-- GLOBAL NUMBERS

Select  date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(New_Deaths as int))/SUM(New_cases) *100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
WHERE continent is not null
GROUP BY date
Order By 1,2