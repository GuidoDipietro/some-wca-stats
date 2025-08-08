# How many 4th places for each podium?

SELECT person_name, SUM(IF(pos IN (1,2,3), 1, 0)) podiums, SUM(IF(pos=4, 1, 0)) misses, SUM(IF(pos=4, 1, 0)) / SUM(IF(pos IN (1,2,3), 1, 0)) misses_per_podium
FROM results r
WHERE r.country_id = ':country' AND round_type_id IN ('c','f') AND best > 0 AND pos <= 4
GROUP BY person_name
HAVING SUM(IF(pos IN (1,2,3), 1, 0)) > :min_podiums
ORDER BY 4 DESC
