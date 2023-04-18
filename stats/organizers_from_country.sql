SELECT name FROM (SELECT DISTINCT organizer_id, p.id, p.name, p.countryId
FROM competition_organizers o JOIN users u ON (o.organizer_id = u.id)
JOIN Persons p ON (u.wca_id = p.id) JOIN Competitions c ON (o.competition_id = c.id)
WHERE p.countryId = ':countryId' AND cancelled_at IS NULL AND results_posted_at IS NOT NULL) a
