# Para Dafo

WITH Single AS (
   SELECT personId, best AS single
   FROM RanksSingle
   WHERE eventId=':eventId' AND best<:singleSub
), Avg AS (
   SELECT personId, best AS avg
   FROM RanksAverage
   WHERE eventId=':eventId' AND best>:avgSup
)

SELECT s.personId, name, countryId, single, avg
FROM Single s JOIN Avg a ON (s.personId = a.personId)
JOIN Persons p ON (s.personId = p.id)
ORDER BY single
