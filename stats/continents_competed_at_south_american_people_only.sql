SELECT r.person_id, r.person_name, COUNT(DISTINCT c1.continent_id) continentes, GROUP_CONCAT(DISTINCT c1.continent_id SEPARATOR ', ') lista
FROM results r
    JOIN persons p ON (r.person_id = p.wca_id)
    JOIN countries c ON (p.country_id = c.id)
    JOIN competitions co ON (r.competition_id = co.id)
    JOIN countries c1 ON (co.country_id = c1.id)
WHERE c.continent_id = '_South America' AND c1.continent_id <> '_Multiple Continents'
GROUP BY r.person_id
ORDER BY 3 DESC
