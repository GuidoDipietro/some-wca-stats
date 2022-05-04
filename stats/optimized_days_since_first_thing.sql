# Like days_since_first_thing.sql but faster, harder to tweak
WITH Qualifiers AS (
    SELECT personId
    FROM RanksSingle
    WHERE eventId = '333' AND best > 0 AND best < 600
), PersonsFirstDate AS (
    SELECT q.personId, MIN(end_date) first_date
    FROM Qualifiers q JOIN Results r ON (q.personId = r.personId)
         JOIN Competitions c ON (r.competitionId = c.id)
    GROUP BY q.personId
),  PersonsFirstThing AS (
    SELECT q.personId, MIN(end_date) date_of_first_thing
    FROM Qualifiers q JOIN Results r ON (q.personId = r.personId)
         JOIN Competitions c ON (r.competitionId = c.id)
    WHERE eventId = '333' AND best > 0 AND best < 600
    GROUP BY q.personId
)

SELECT
   p.personId,
   date_of_first_thing, first_date date_of_first_comp,
   DATEDIFF(date_of_first_thing, first_date) days_elapsed
FROM PersonsFirstThing p JOIN PersonsFirstDate pd ON (p.personId = pd.personId)
ORDER BY days_elapsed DESC