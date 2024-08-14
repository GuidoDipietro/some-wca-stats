# Who competed in the most different Argentinian provinces?

WITH Data as 
(SELECT DISTINCT
     r.personId,
     r.personName,
     r.competitionId,
     c.cityName,
     IF(c.cityName LIKE '%Buenos Aires, Buenos Aires%', ' CABA', SUBSTRING_INDEX(SUBSTRING_INDEX(c.cityName, ',', 2), ',', -1)) province,
     c.countryId compCountry
FROM Results r
     JOIN Persons p ON (r.personId = p.wca_id)
     JOIN Competitions c ON (r.competitionId = c.id)
WHERE c.countryId = 'Argentina'
ORDER BY personName)

SELECT personName, COUNT(DISTINCT province) regiones, GROUP_CONCAT(DISTINCT province SEPARATOR ',') lista
FROM Data
GROUP BY personName
ORDER BY 2 DESC
