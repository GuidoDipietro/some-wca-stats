WITH 4b AS (SELECT person_id, best FROM ranks_average WHERE event_id = '444bf'),
     5b AS (SELECT person_id, best FROM ranks_average WHERE event_id = '555bf')

SELECT name, CONCAT(CONCAT(best DIV 6000,':'), best%6000/100) time
FROM 5b JOIN persons p ON (5b.person_id = p.id)
WHERE NOT EXISTS (SELECT 'ben' FROM 4b WHERE 4b.person_id = 5b.person_id)
