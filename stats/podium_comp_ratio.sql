# Average podiums per comp
SELECT
   person_id, person_name,
   COUNT(DISTINCT competition_id) comps,
   SUM(IF(pos <= 3 AND round_type_id IN ('c','f') AND best > 0, 1, 0)) podios,
   SUM(IF(pos <= 3 AND round_type_id IN ('c','f') AND best > 0, 1, 0)) / COUNT(DISTINCT competition_id) podiums_per_comp
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id = ':country'
GROUP BY person_id, person_name
ORDER BY podiums_per_comp DESC