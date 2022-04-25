# Numbers of years competed at
SELECT personId, personName, COUNT(DISTINCT c.year) vejez
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
     JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId='Argentina'
GROUP BY personId, personName
ORDER BY COUNT(DISTINCT year) DESC
