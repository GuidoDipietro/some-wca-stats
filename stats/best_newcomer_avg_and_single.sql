# Best avg/single done by a competitor on their first comp (slow for big countries)
WITH Country AS (SELECT 'Argentina' value), /* change to desired country       */
     Type AS (SELECT 'single' value),       /* change to 'single' or 'average' */
     FirstDate AS (
         SELECT personId, MIN(end_date) first_date
         FROM Results r JOIN Competitions c ON (r.competitionID = c.id)
              JOIN Persons p ON (r.personId = p.id)
         WHERE p.countryId = (SELECT value FROM Country)
         GROUP BY personId
     ),
     FirstResults AS (
         SELECT r.personId, personName, eventId, MIN(IF((SELECT value FROM Type)='single',best,average)) first_pr
         FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
              JOIN FirstDate fc ON (fc.personId = r.personId)
              JOIN Persons p ON (r.personId = p.id)
         WHERE p.countryId = (SELECT value FROM Country)
               AND IF((SELECT value FROM Type)='single',best,average) > 0
               AND c.end_date = fc.first_date
         GROUP BY r.personId, personName, eventId
     )

SELECT eventId, personId, personName, newcomer_nr
FROM (
    SELECT
        personId, personName, eventId, first_pr,
        MIN(first_pr) OVER (PARTITION BY eventId) newcomer_nr
    FROM FirstResults
) stat
WHERE stat.first_pr = stat.newcomer_nr
