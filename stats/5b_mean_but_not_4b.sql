WITH 4b AS (SELECT personId, best FROM RanksAverage WHERE eventId = '444bf'),
     5b AS (SELECT personId, best FROM RanksAverage WHERE eventId = '555bf')

SELECT name, CONCAT(CONCAT(best DIV 6000,':'), best%6000/100) time
FROM 5b JOIN Persons p ON (5b.personId = p.id)
WHERE NOT EXISTS (SELECT 'ben' FROM 4b WHERE 4b.personId = 5b.personId)
