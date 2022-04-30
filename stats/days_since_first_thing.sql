# Days since first occurence of something and the first comp of the competitor (example with sub10 3x3 ao5)
WITH PersonsFirstDate AS (
    SELECT personId, MIN(end_date) first_date
    FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
         JOIN Persons p ON (r.personId = p.id)
    WHERE p.countryId = 'Argentina'
    GROUP BY personId
),  PersonsFirstThing AS (
    SELECT personId, personName, MIN(end_date) date_of_first_thing
    FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
         JOIN Persons p ON (r.personId = p.id)
    WHERE p.countryId = 'Argentina' AND eventId = '333' AND average > 0 AND average < 1000
    GROUP BY personId, personName
)

SELECT
   p.personId, personName,
   date_of_first_thing, first_date date_of_first_comp,
   DATEDIFF(date_of_first_thing, first_date) days_elapsed
FROM PersonsFirstThing p JOIN PersonsFirstDate pd ON (p.personId = pd.personId)
ORDER BY days_elapsed DESC