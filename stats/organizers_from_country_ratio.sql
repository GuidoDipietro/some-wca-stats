WITH Organizadores AS (
SELECT COUNT(DISTINCT organizer_id) organizadores, p.countryId
FROM competition_organizers o JOIN users u ON (o.organizer_id = u.id)
JOIN Persons p ON (u.wca_id = p.id) JOIN Competitions c ON (o.competition_id = c.id)
WHERE cancelled_at IS NULL AND results_posted_at IS NOT NULL
GROUP BY p.countryId
),
Totales AS (SELECT COUNT(DISTINCT id) totales, countryId FROM Persons GROUP BY countryId)

SELECT organizadores, totales, organizadores/totales ratio, o.countryId
FROM Organizadores o JOIN Totales t ON (o.countryId = t.countryId)
WHERE totales > 1000
ORDER BY ratio DESC
