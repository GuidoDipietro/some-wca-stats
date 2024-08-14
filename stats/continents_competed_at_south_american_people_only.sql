SELECT r.personId, r.personName, COUNT(DISTINCT c1.continentId) continentes, GROUP_CONCAT(DISTINCT c1.continentId SEPARATOR ', ') lista
FROM Results r
    JOIN Persons p ON (r.personId = p.wca_id)
    JOIN Countries c ON (p.countryId = c.id)
    JOIN Competitions co ON (r.competitionId = co.id)
    JOIN Countries c1 ON (co.countryId = c1.id)
WHERE c.continentId = '_South America' AND c1.continentId <> '_Multiple Continents'
GROUP BY r.personId
ORDER BY 3 DESC
