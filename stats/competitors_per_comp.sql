# Comps with more competitors
SELECT c.id, COUNT(DISTINCT personId) competidores
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
WHERE c.countryId = 'Argentina'
GROUP BY c.id
ORDER BY COUNT(DISTINCT personId) DESC
