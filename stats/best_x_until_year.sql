# Best single or avg until a given year

WITH Hasta AS (SELECT personId, personName, :type
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
WHERE eventId = ':event' AND :type>0 AND :type<:max_bound AND SUBSTRING(c.end_date,1,4) <= :year)

SELECT personId, personName, MIN(:type)/100 best_until_:year:type
FROM Hasta
GROUP BY personName, personId
ORDER BY 3
