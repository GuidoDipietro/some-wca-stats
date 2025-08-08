SELECT p.name, p.id, SUM(
   IF(value1>0 AND value1<:subX, 1, 0) +
   IF(value2>0 AND value2<:subX, 1, 0) +
   IF(value3>0 AND value3<:subX, 1, 0) +
   IF(value4>0 AND value4<:subX, 1, 0) +
   IF(value5>0 AND value5<:subX, 1, 0)
) subXs
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE r.best > 0 AND r.best < :subX AND r.event_id = ':event_id'
GROUP BY p.name, p.id
ORDER BY 3 DESC
