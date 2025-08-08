# Best single or avg until a given year

WITH until AS (SELECT person_id, person_name, :type
FROM results r JOIN competitions c ON (r.competition_id = c.id)
WHERE event_id = ':event' AND :type>0 AND :type<:max_bound AND SUBSTRING(c.end_date,1,4) <= :year)

SELECT person_id, person_name, MIN(:type)/100 best_until_:year:type
FROM until
GROUP BY person_name, person_id
ORDER BY 3
