# Porcentaje de finales alcanzadas por argentinos
# No cuenta finales en las que no hubo ningún resultado exitoso (rip guido)
# Solo para competidores que hayan participado en mas de 15 eventos
# (p. ej. se hayan anotado en 3x3 10 veces y en 2x2 6 veces)

# Number of finals reached
# Not counting finals without a successful result (rip Guido)
# Only counting competitors with more than 15 events
# (example: signed up for 3x3 10 times and 2x2 6 times)

SELECT
    r.personId, r.personName,
    SUM(IF(roundTypeId IN ('c','f'), 1, 0)) finales,
    totales.categorias_totales,
    100*SUM(IF(roundTypeId IN ('c','f'), 1, 0))/totales.categorias_totales pct
FROM Results r JOIN (
    SELECT personId, COUNT(*) categorias_totales
    FROM (
        SELECT DISTINCT personId, eventId, competitionId
        FROM Results r1 JOIN Persons p ON (r1.personId = p.id)
        WHERE p.countryId = 'Argentina'
    ) a
    GROUP BY personId
) totales ON (totales.personId = r.personId)
WHERE countryId = 'Argentina' AND (
    value1 > 0 OR
    value2 > 0 OR
    value3 > 0 OR
    value4 > 0 OR
    value5 > 0
) AND categorias_totales > 15
GROUP BY personId, personName
ORDER BY pct DESC, finales DESC
