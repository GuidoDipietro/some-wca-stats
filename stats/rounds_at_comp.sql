# Rounds at a comp
SELECT id, COUNT(*) rondas FROM (
SELECT DISTINCT c.id, roundTypeId, eventId
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
WHERE c.countryId = 'Argentina'
) stat
GROUP BY id
ORDER BY COUNT(*) DESC
