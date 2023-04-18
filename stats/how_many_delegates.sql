WITH Delegados AS (SELECT COUNT(*) delegados, countryId
FROM users u JOIN Persons p ON (u.wca_id = p.id)
WHERE delegate_status IS NOT NULL
GROUP BY countryId),
Totales AS (SELECT COUNT(DISTINCT id) totales, countryId FROM Persons GROUP BY countryId)

SELECT delegados, totales, delegados/totales ratio, d.countryId
FROM Delegados d JOIN Totales t ON (d.countryId = t.countryId)
WHERE totales > 250
ORDER BY ratio DESC
