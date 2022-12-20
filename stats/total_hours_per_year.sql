WITH FMCAttempts AS (
   SELECT personId, SUM(
      IF(value1>0, 1, 0) +
      IF(value2>0, 1, 0) +
      IF(value3>0, 1, 0)
   ) attempts
   FROM Results r JOIN Persons p ON (r.personId = p.id) JOIN Competitions c ON (r.competitionId = c.id)
   WHERE eventId = '333fm' AND p.countryId = ':countryId' AND c.year = :year
   GROUP BY personId
),
MbldTotalTime AS (
   SELECT personId, 100 * SUM(
      IF(value1>0, CAST(SUBSTRING(value1, 3, 5) AS UNSIGNED), 0) +
      IF(value2>0, CAST(SUBSTRING(value2, 3, 5) AS UNSIGNED), 0) +
      IF(value3>0, CAST(SUBSTRING(value3, 3, 5) AS UNSIGNED), 0)
   ) totalTime
   FROM Results r JOIN Persons p ON (r.personId = p.id) JOIN Competitions c ON (r.competitionId = c.id)
   WHERE eventId = '333mbf' AND p.countryId = ':countryId' AND c.year = :year
   GROUP BY personId
)

SELECT r.personId, p.name, (SUM(
   IF(value1>0, value1, 0) +
   IF(value2>0, value2, 0) +
   IF(value3>0, value3, 0) +
   IF(value4>0, value4, 0) +
   IF(value5>0, value5, 0)
  ) + COALESCE(f.attempts*360000,0) + COALESCE(m.totalTime,0))/360000 hours
FROM Results r JOIN Persons p ON (r.personId = p.id) 
     JOIN Competitions c ON (r.competitionId = c.id)
     LEFT JOIN FMCAttempts f ON (f.personId = r.personId)
     LEFT JOIN MbldTotalTime m ON (m.personId = r.personId)
WHERE p.countryId = ':countryId' AND eventId <> '333mbf' AND eventId <> '333fm' AND c.year = :year
GROUP BY r.personId, p.name
ORDER BY 3 DESC
