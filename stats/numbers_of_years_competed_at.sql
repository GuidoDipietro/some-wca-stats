SELECT p.wca_id, p.name, COUNT(DISTINCT RIGHT(r.competition_id, 4)) years
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
AND p.country_id = ':country'
GROUP BY p.wca_id, p.name
ORDER BY 3 DESC
