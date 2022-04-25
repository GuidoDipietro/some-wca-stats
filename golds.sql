# Most wins
SELECT personId, personName, COUNT(*) oros
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
     JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId='Argentina' AND r.roundTypeId IN ('c','f') AND pos = 1 AND best > 0
GROUP BY personId, personName
ORDER BY COUNT(*) DESC
