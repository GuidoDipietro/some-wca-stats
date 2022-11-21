SELECT p.name, p.id, SUM(
   IF(value1>0 AND value1<3000, 1, 0) +
   IF(value2>0 AND value2<3000, 1, 0) +
   IF(value3>0 AND value3<3000, 1, 0) +
   IF(value4>0 AND value4<3000, 1, 0) +
   IF(value5>0 AND value5<3000, 1, 0)
) sub30s, SUM(
   IF(value1>0 AND value1<2900, 1, 0) +
   IF(value2>0 AND value2<2900, 1, 0) +
   IF(value3>0 AND value3<2900, 1, 0) +
   IF(value4>0 AND value4<2900, 1, 0) +
   IF(value5>0 AND value5<2900, 1, 0)
) sub29s, SUM(
   IF(value1>0 AND value1<2800, 1, 0) +
   IF(value2>0 AND value2<2800, 1, 0) +
   IF(value3>0 AND value3<2800, 1, 0) +
   IF(value4>0 AND value4<2800, 1, 0) +
   IF(value5>0 AND value5<2800, 1, 0)
) sub28s, SUM(
   IF(value1>0 AND value1<2700, 1, 0) +
   IF(value2>0 AND value2<2700, 1, 0) +
   IF(value3>0 AND value3<2700, 1, 0) +
   IF(value4>0 AND value4<2700, 1, 0) +
   IF(value5>0 AND value5<2700, 1, 0)
) sub27s, SUM(
   IF(value1>0 AND value1<2600, 1, 0) +
   IF(value2>0 AND value2<2600, 1, 0) +
   IF(value3>0 AND value3<2600, 1, 0) +
   IF(value4>0 AND value4<2600, 1, 0) +
   IF(value5>0 AND value5<2600, 1, 0)
) sub26s
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE r.best > 0 AND r.best < 3000 AND r.eventId = ':eventId'
ORDER BY 3 DESC
