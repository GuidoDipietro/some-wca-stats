# Para Dafo

WITH single AS (
   SELECT person_id, best AS single
   FROM ranks_single
   WHERE event_id=':event_id' AND best<:single_sub
), avg AS (
   SELECT person_id, best AS avg
   FROM ranks_average
   WHERE event_id=':event_id' AND best>:avg_sup
)

SELECT s.person_id, name, country_id, single, avg
FROM single s JOIN avg a ON (s.person_id = a.person_id)
JOIN persons p ON (s.person_id = p.id)
ORDER BY single
