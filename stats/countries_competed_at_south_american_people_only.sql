SELECT r.person_id, r.person_name, COUNT(DISTINCT co.country_id) paises, GROUP_CONCAT(DISTINCT co.country_id SEPARATOR ', ') lista
FROM results r
    JOIN persons p ON (r.person_id = p.wca_id)
    JOIN countries c ON (p.country_id = c.id)
    JOIN competitions co ON (r.competition_id = co.id)
WHERE c.continent_id = '_South America' AND co.country_id NOT IN ('XA','XE','XF','XM','XN','XO','XS','XW')
GROUP BY r.person_id
ORDER BY 3 DESC
