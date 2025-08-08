# People whove won every round at a comp
SELECT person_id, person_name, stat.competition_id, stat.total_rounds_at_comp, stat.first_places
FROM (
    SELECT
        person_id, person_name, r.competition_id,
        SUM(IF(pos=1 AND best>0, 1, 0)) first_places,
        (
            SELECT COUNT(DISTINCT CONCAT(CONCAT(r1.competition_id, r1.event_id), r1.round_type_id))
            FROM results r1 WHERE r1.competition_id = r.competition_id
        ) total_rounds_at_comp
    FROM results r WHERE r.country_id = ':country'
    GROUP BY person_id, person_name, r.competition_id
    ORDER BY 5 DESC
) stat
WHERE stat.total_rounds_at_comp = stat.first_places
ORDER BY stat.total_rounds_at_comp DESC
