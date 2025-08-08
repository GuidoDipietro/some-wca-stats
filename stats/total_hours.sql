WITH fmc_attempts AS (
   SELECT person_id, SUM(
      IF(value1>0, 1, 0) +
      IF(value2>0, 1, 0) +
      IF(value3>0, 1, 0)
   ) attempts
   FROM results r JOIN persons p ON (r.person_id = p.wca_id) JOIN competitions c ON (r.competition_id = c.id)
   WHERE event_id = '333fm' AND p.country_id = ':country_id'
   GROUP BY person_id
),
mbld_total_time AS (
   SELECT person_id, 100 * SUM(
      IF(value1>0, CAST(SUBSTRING(value1, 3, 5) AS UNSIGNED), 0) +
      IF(value2>0, CAST(SUBSTRING(value2, 3, 5) AS UNSIGNED), 0) +
      IF(value3>0, CAST(SUBSTRING(value3, 3, 5) AS UNSIGNED), 0)
   ) total_time
   FROM results r JOIN persons p ON (r.person_id = p.wca_id) JOIN competitions c ON (r.competition_id = c.id)
   WHERE event_id = '333mbf' AND p.country_id = ':country_id'
   GROUP BY person_id
)

SELECT r.person_id, p.name, (SUM(
   IF(value1>0, value1, 0) +
   IF(value2>0, value2, 0) +
   IF(value3>0, value3, 0) +
   IF(value4>0, value4, 0) +
   IF(value5>0, value5, 0)
  ) + COALESCE(f.attempts*360000,0) + COALESCE(m.total_time,0))/360000 hours
FROM results r JOIN persons p ON (r.person_id = p.wca_id) 
     JOIN competitions c ON (r.competition_id = c.id)
     LEFT JOIN fmc_attempts f ON (f.person_id = r.person_id)
     LEFT JOIN mbld_total_time m ON (m.person_id = r.person_id)
WHERE p.country_id = ':country_id' AND event_id <> '333mbf' AND event_id <> '333fm'
GROUP BY r.person_id, p.name
ORDER BY 3 DESC
