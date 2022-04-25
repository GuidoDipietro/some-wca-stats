# Percentage of non-binary competitors by country
SELECT pall.total, pnb.nonbin, 100*pnb.nonbin/pall.total pct, pall.countryId
FROM (
    SELECT COUNT(id) total, countryId
    FROM Persons
    GROUP BY countryId
) pall JOIN (
    SELECT COUNT(id) nonbin, countryId
    FROM Persons
    WHERE gender NOT IN ('m','f') AND name <> 'Anonymous'
    GROUP BY countryId
) pnb ON (pall.countryId = pnb.countryId)
ORDER BY 3 DESC
