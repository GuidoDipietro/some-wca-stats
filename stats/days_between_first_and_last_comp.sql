# Days between first and last comp
SELECT personId, personName, DATEDIFF(MAX(end_date), MIN(start_date)) "dias entre primer y ultimo torneo"
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
     JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId='Argentina'
GROUP BY personId, personName
ORDER BY DATEDIFF(MAX(end_date),MIN(start_date)) DESC
