# Comps with more competitors
SELECT c.id, COUNT(DISTINCT person_id) competidores
FROM results r JOIN competitions c ON (r.competition_id = c.id)
WHERE c.country_id = ':country'
GROUP BY c.id
ORDER BY COUNT(DISTINCT person_id) DESC
