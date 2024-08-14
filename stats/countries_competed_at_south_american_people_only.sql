SELECT r.personId, r.personName, COUNT(DISTINCT co.countryId) paises, GROUP_CONCAT(DISTINCT co.countryId SEPARATOR ', ') lista
FROM Results r
    JOIN Persons p ON (r.personId = p.wca_id)
    JOIN Countries c ON (p.countryId = c.id)
    JOIN Competitions co ON (r.competitionId = co.id)
WHERE c.continentId = '_South America' AND co.countryId NOT IN ('XA','XE','XF','XM','XN','XO','XS','XW')
GROUP BY r.personId
ORDER BY 3 DESC
