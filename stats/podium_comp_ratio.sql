# Average podiums per comp
SELECT
   personId, personName,
   COUNT(DISTINCT competitionId) comps,
   SUM(IF(pos <= 3 AND roundTypeId IN ('c','f') AND best > 0, 1, 0)) podios,
   SUM(IF(pos <= 3 AND roundTypeId IN ('c','f') AND best > 0, 1, 0)) / COUNT(DISTINCT competitionId) podios_por_comp
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId = 'Argentina'
GROUP BY personId, personName
ORDER BY podios_por_comp DESC