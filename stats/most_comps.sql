# Most comps
SELECT person_id, person_name, COUNT(DISTINCT c.id) comps
FROM results r JOIN competitions c ON (r.competition_id = c.id)
     JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id=':country'
GROUP BY person_id, person_name
ORDER BY COUNT(DISTINCT c.id) DESC
