Select *
FROM [Project Portfolio02]..[covid death]

SELECT *
FROM [Project Portfolio02]..[covid vaccination]

-- select important data for analysis
Select Location, date, new_cases, total_cases, total_deaths, population
FROM [Project Portfolio02]..[covid death]
ORDER BY 1, 2

-- Total deaths Versus Total Cases
Select continent,location, date,total_deaths, total_cases, population, cast(total_deaths as float)/cast(total_cases AS float)*100 AS DeathPercentage
FROM [Project Portfolio02]..[covid death]
WHERE location like '%states%' and continent is not null
ORDER BY 1, 2


-- Explain the population by the total caeses (population VS Total cases)
Select continent, population, total_cases, 
		cast(total_cases AS float)/cast(Population AS float)*100 AS "Infected Population Percentage"
FROM [Project Portfolio02]..[covid death]
-- WHERE location like '%states%'
WHERE continent is not null
ORDER BY 2

-- Countries with higest infection rate
Select continent, population, MAX(total_cases) AS "Highest Infected Count", 
		MAX(cast(total_cases AS float)/cast(Population AS float))*100 AS "Infected Population Percentage"
FROM [Project Portfolio02]..[covid death]
-- WHERE location like '%states%'
WHERE continent is not null
GROUP BY population, continent
ORDER BY 4 DESC

-- Death Count per country population Group by continent
Select continent, MAX(CAST(total_deaths AS float)) AS "Highest Death Count" 
FROM [Project Portfolio02]..[covid death]
-- WHERE location like '%states%'
WHERE continent is Not NUll
GROUP BY continent
ORDER BY "Highest Death Count" DESC

-- showing continent with the highest death count
Select continent, MAX(CAST(total_deaths AS float)) AS "Highest Death Count" 
FROM [Project Portfolio02]..[covid death]
-- WHERE location like '%states%'
WHERE continent is Not NUll
GROUP BY continent
ORDER BY "Highest Death Count" DESC

-- total cases in the world each day 

Select date, SUM(CAST(new_cases AS float)) AS "Highest infected Count" , SUM(CAST(new_deaths AS float)) AS "Highest Death Count",
			(SUM(CAST(new_cases AS float))/SUM(CAST(nullif(new_deaths, 0) AS float)))*100 AS "Death Rate Percetage"
FROM [Project Portfolio02]..[covid death]
-- WHERE location like '%states%'
WHERE continent is Not NUll
GROUP BY date
ORDER BY "Highest infected Count" DESC

-- Global Metrics

 --Population that took the vaccination by continent
 SELECT dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations,
 SUM(CAST(vac.new_vaccinations AS Float)) OVER(Partition by dea.location order by dea.location, dea.date)
 FROM [Project Portfolio02]..[covid death] dea
LEFT JOin [Project Portfolio02]..[covid vaccination] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
order by 2, 3

-- Using CTE

WITH PopVsVac (continent, date, location, population, new_vaccinations, "Rolling people vaccinated")
AS
(
SELECT dea.continent, dea.date, dea.location, dea.population, vac.new_vaccinations,
 SUM(CAST(vac.new_vaccinations AS Float)) OVER(Partition by dea.location order by dea.location, dea.date) AS  "Rolling people vaccinated"
 FROM [Project Portfolio02]..[covid death] dea
LEFT JOin [Project Portfolio02]..[covid vaccination] vac
on dea.location = vac.location 
and dea.date = vac.date
where dea.continent is not null
--order by 2, 3
)
SELECT *, ("Rolling people vaccinated"/population)*100 AS "Rolling people vaccinated percentage"
From PopVsVAc



 -- Create temporary table to store data
CREATE TABLE #PercentagePopulationVaccinated (
    continent VARCHAR(100),
    date DATE,
    location VARCHAR(100),
    population FLOAT,
    new_vaccinations INT,
    [Rolling people vaccinated] FLOAT
);

-- Insert data into temporary table
INSERT INTO #PercentagePopulationVaccinated
SELECT 
    dea.continent, 
    dea.date, 
    dea.location, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER(PARTITION BY dea.location ORDER BY dea.date) AS [Rolling people vaccinated]
FROM 
    [Project Portfolio02]..[covid death] dea
JOIN 
    [Project Portfolio02]..[covid vaccination] vac ON dea.location = vac.location AND dea.date = vac.date
--WHERE  dea.continent IS NOT NULL;

-- Calculate percentage of population vaccinated
SELECT 
    *,
    ([Rolling people vaccinated] / population) * 100 AS [Rolling people vaccinated percentage]
FROM 
    #PercentagePopulationVaccinated;



-- Creating vew to store data for visualisation later
 CREATE VIEW PercentagePopulationVaccinated AS
 SELECT 
    dea.continent, 
    dea.date, 
    dea.location, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS FLOAT)) OVER(PARTITION BY dea.location ORDER BY dea.date) AS [Rolling people vaccinated]
FROM 
    [Project Portfolio02]..[covid death] dea
JOIN 
    [Project Portfolio02]..[covid vaccination] vac ON dea.location = vac.location AND dea.date = vac.date
WHERE  dea.continent IS NOT NULL;

SELECT *
FROM PercentagePopulationVaccinated