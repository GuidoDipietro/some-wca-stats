# Competitors from a country

SELECT COUNT(DISTINCT id)
FROM persons
WHERE country_id = ':country'
