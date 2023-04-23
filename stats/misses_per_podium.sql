# How many 4th places for each podium?

SELECT personName, SUM(IF(pos IN (1,2,3), 1, 0)) podiums, SUM(IF(pos=4, 1, 0)) misses, SUM(IF(pos=4, 1, 0)) / SUM(IF(pos IN (1,2,3), 1, 0)) misses_per_podium
FROM Results r
WHERE r.countryId = 'Argentina' AND roundTypeId IN ('c','f') AND best > 0 AND pos <= 4
GROUP BY personName
HAVING SUM(IF(pos IN (1,2,3), 1, 0)) > :threshold
ORDER BY 4 DESC
