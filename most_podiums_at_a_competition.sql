# Most podiums at a competition
SELECT personName, competitionId, COUNT(*) podios
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId = 'Argentina' AND roundTypeId IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY personName, competitionId
ORDER BY COUNT(*) DESC
