
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


--Looking at total population vs vaccination


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.Location ORDER by dea.location, dea.Date) 
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100 
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order By 2,3

--Use CTE
With PopVsVac (Continent, Location, Date, Population,New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.Location ORDER by dea.location, dea.Date) 
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100 
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order By 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--Temp table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccination numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.Location ORDER by dea.location, dea.Date) 
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100 
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order By 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for later visualization

--use [Portfolio Project]
--Drop View PercentPopulationVaccinated

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.Location ORDER by dea.location, dea.Date) 
as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100 
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order By 2,3

Create View CasesVsDeaths as
Select Location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%states%'
--order by 1,2

Create View CasesPercentage as
Select Location, date,  population, total_cases, (total_cases/population)*100 as CasesPercentage
From [Portfolio Project]..CovidDeaths
Where location like '%states%'
--order by 1,2

Create View PercentPopulationInfected as
-- Looking at countries with highest infection rate compared to population
Select Location,  population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Group By Location, Population
--order by PercentPopulationInfected Desc

Create View TotalDeathCount as
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group By Location
--order by TotalDeathCount Desc

Create view ContinentDeathCount as
Select continent, Max(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project]..CovidDeaths
Where continent is not null
Group by continent
--ORDER BY TotalDeathCount DESC


Create view DeathPercentage as
Select  date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(New_Deaths as int))/SUM(New_cases) *100 as DeathPercentage
From [Portfolio Project]..CovidDeaths
WHERE continent is not null
GROUP BY date
--Order By 1,2