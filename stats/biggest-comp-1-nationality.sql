# Biggest comp with 1 nationality

WITH nationalities_at_comp AS (
   SELECT COUNT(DISTINCT country_id) nationalities, competition_id
   FROM results
   GROUP BY competition_id
),
competitors_at_comp AS (
   SELECT COUNT(DISTINCT person_id) persons, competition_id
   FROM results
   GROUP BY competition_id
)

SELECT n.competition_id, nationalities, persons
FROM nationalities_at_comp n JOIN competitors_at_comp c ON (n.competition_id = c.competition_id)
WHERE nationalities = 1
ORDER BY persons DESC
