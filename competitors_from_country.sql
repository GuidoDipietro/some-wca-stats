# Competitors at a country
SELECT COUNT(DISTINCT id)
FROM Persons
WHERE countryId = 'Argentina'
