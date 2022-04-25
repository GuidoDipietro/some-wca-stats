# Most solves/comp
SELECT
    personId, personName,
    SUM(IF(value1>0, 1, 0) +
    IF(value2>0, 1, 0) +
    IF(value3>0, 1, 0) +
    IF(value4>0, 1, 0) +
    IF(value5>0, 1, 0)) / COUNT(DISTINCT r.competitionId) solves_por_torneo
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId = 'Argentina'
GROUP BY personId, personName
ORDER BY 3 DESC
