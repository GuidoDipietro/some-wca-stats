# Most wins
SELECT person_id, person_name, COUNT(*) oros
FROM results r JOIN competitions c ON (r.competition_id = c.id)
     JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id=':country' AND r.round_type_id IN ('c','f') AND pos = 1 AND best > 0
GROUP BY person_id, person_name
ORDER BY COUNT(*) DESC
