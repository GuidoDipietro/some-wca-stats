SELECT name FROM (SELECT DISTINCT organizer_id, p.id, p.name, p.country_id
FROM competition_organizers o JOIN users u ON (o.organizer_id = u.id)
JOIN persons p ON (u.wca_id = p.wca_id) JOIN competitions c ON (o.competition_id = c.id)
WHERE p.country_id = ':country_id' AND cancelled_at IS NULL AND results_posted_at IS NOT NULL) a
