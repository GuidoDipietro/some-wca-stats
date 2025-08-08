# Who competed in the most different Argentinian provinces?

WITH Data as 
(SELECT DISTINCT
     r.person_id,
     r.person_name,
     r.competition_id,
     c.city_name,
     IF(c.city_name LIKE '%Buenos Aires, Buenos Aires%', ' CABA', SUBSTRING_INDEX(SUBSTRING_INDEX(c.city_name, ',', 2), ',', -1)) province,
     c.country_id comp_country
FROM results r
     JOIN persons p ON (r.person_id = p.wca_id)
     JOIN competitions c ON (r.competition_id = c.id)
WHERE c.country_id = 'Argentina'
ORDER BY person_name)

SELECT person_name, COUNT(DISTINCT province) regions, GROUP_CONCAT(DISTINCT province SEPARATOR ',') list
FROM Data
GROUP BY person_name
ORDER BY 2 DESC
