# Days since first occurence of something and the first comp of the competitor (example with sub10 3x3 ao5)
WITH persons_first_date AS (
    SELECT person_id, MIN(end_date) first_date
    FROM results r JOIN competitions c ON (r.competition_id = c.id)
         JOIN persons p ON (r.person_id = p.wca_id)
    WHERE p.country_id = 'Argentina'
    GROUP BY person_id
),  persons_first_thing AS (
    SELECT person_id, person_name, MIN(end_date) date_of_first_thing
    FROM results r JOIN competitions c ON (r.competition_id = c.id)
         JOIN persons p ON (r.person_id = p.wca_id)
    WHERE p.country_id = 'Argentina' AND event_id = '333' AND average > 0 AND average < 1000
    GROUP BY person_id, person_name
)

SELECT
   p.person_id, person_name,
   date_of_first_thing, first_date date_of_first_comp,
   DATEDIFF(date_of_first_thing, first_date) days_elapsed
FROM persons_first_thing p JOIN persons_first_date pd ON (p.person_id = pd.person_id)
ORDER BY days_elapsed DESC
