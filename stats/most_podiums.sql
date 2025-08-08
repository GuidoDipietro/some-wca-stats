# Most podiums
SELECT person_name, COUNT(*) podios
FROM results
WHERE country_id = ':country' AND round_type_id IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY person_name
ORDER BY COUNT(*) DESC
