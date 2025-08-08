# Number of finals reached
# Not counting finals without a successful result (rip Guido)
# Only counting competitors with more than 15 events
# (example: signed up for 3x3 10 times and 2x2 6 times)

SELECT
    r.person_id, r.person_name,
    SUM(IF(round_type_id IN ('c','f'), 1, 0)) finals,
    totals.total_events,
    100*SUM(IF(round_type_id IN ('c','f'), 1, 0))/totals.total_events pct
FROM results r JOIN (
    SELECT person_id, COUNT(*) total_events
    FROM (
        SELECT DISTINCT person_id, event_id, competition_id
        FROM results r1 JOIN persons p ON (r1.person_id = p.wca_id)
        WHERE p.country_id = 'Argentina'
    ) a
    GROUP BY person_id
) totals ON (totals.person_id = r.person_id)
WHERE country_id = 'Argentina' AND (
    value1 > 0 OR
    value2 > 0 OR
    value3 > 0 OR
    value4 > 0 OR
    value5 > 0
) AND total_events > 15
GROUP BY person_id, person_name
ORDER BY pct DESC, finals DESC
