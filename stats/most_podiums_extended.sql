# Most podiums, showing how many are gold, silver, and bronze

SELECT person_name, SUM(IF(pos=1, 1, 0)) golds, SUM(IF(pos=2, 1, 0)) silvers, SUM(IF(pos=3, 1, 0)) bronzes, COUNT(*) total
FROM results
WHERE country_id = ':country' AND round_type_id IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY person_name
ORDER BY COUNT(*) DESC
