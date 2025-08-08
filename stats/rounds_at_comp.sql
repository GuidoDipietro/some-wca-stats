# Rounds at a comp
SELECT id, COUNT(*) rounds FROM (
SELECT DISTINCT c.id, round_type_id, event_id
FROM results r JOIN competitions c ON (r.competition_id = c.id)
WHERE c.country_id = ':country'
) stat
GROUP BY id
ORDER BY COUNT(*) DESC
