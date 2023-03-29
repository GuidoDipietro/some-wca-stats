With
Anios AS (
SELECT SUBSTRING(id, 1, 4) anio
FROM Persons
WHERE countryId = ':pais'
),
Torneos AS (
SELECT year, COUNT(DISTINCT id) torneos
FROM Competitions
WHERE countryId = ':pais' AND results_posted_at IS NOT NULL AND cancelled_at IS NULL
GROUP BY year
)

SELECT anio año, COUNT(*) nuevos, torneos, COUNT(*)/torneos nuevos_por_torneo
FROM Anios a JOIN Torneos t ON (a.anio=t.year)
GROUP BY anio
