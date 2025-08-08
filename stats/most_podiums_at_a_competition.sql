# Most podiums at a competition
SELECT person_name, competition_id, COUNT(*) podios
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id = ':country' AND round_type_id IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY person_name, competition_id
ORDER BY COUNT(*) DESC
