# Podiums divided by total possible podiums
SELECT
    personId, personName,
    SUM(IF(pos<4 AND best > 0, 1, 0)) podiums,
    COUNT(*) total_possible_podiums,
    100 * SUM(IF(pos<4, 1, 0)) / COUNT(*) 'ratio (%)'
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId = 'Argentina' AND r.roundTypeId IN ('c','f')
GROUP BY personId, personName
HAVING COUNT(*) > 10
ORDER BY 5 DESC
