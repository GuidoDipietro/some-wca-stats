WITH organizers AS (
SELECT COUNT(DISTINCT organizer_id) num_organizers, p.country_id
FROM competition_organizers o JOIN users u ON (o.organizer_id = u.id)
JOIN persons p ON (u.wca_id = p.wca_id) JOIN competitions c ON (o.competition_id = c.id)
WHERE cancelled_at IS NULL AND results_posted_at IS NOT NULL
GROUP BY p.country_id
),
everyone AS (SELECT COUNT(DISTINCT id) total_people, country_id FROM persons GROUP BY country_id)

SELECT num_organizers, total_people, num_organizers/total_people ratio, o.country_id
FROM organizers o JOIN everyone t ON (o.country_id = t.country_id)
WHERE total_people > 1000
ORDER BY ratio DESC
