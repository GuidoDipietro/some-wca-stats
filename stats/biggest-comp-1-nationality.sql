# Biggest comp with 1 nationality

WITH NationalitiesAtComp AS (
   SELECT COUNT(DISTINCT countryId) nationalities, competitionId
   FROM Results
   GROUP BY competitionId
),
CompetitorsAtComp AS (
   SELECT COUNT(DISTINCT personId) persons, competitionId
   FROM Results
   GROUP BY competitionId
)

SELECT n.competitionId, nationalities, persons
FROM NationalitiesAtComp n JOIN CompetitorsAtComp c ON (n.competitionId = c.competitionId)
WHERE nationalities = 1
ORDER BY persons DESC
