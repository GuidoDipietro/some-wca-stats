# How many times can someone get their current PB in the time they got just one the first time?
WITH Event AS (SELECT '333' val),         # edit this line
     Country AS (SELECT 'Argentina' val), # and this line
     FirstPB AS (
        SELECT DISTINCT personId, FIRST_VALUE(average) OVER (
           PARTITION BY personId
           ORDER BY
                end_date,
                roundTypeId DESC
        ) first_pb
        FROM Results r JOIN Persons p ON (r.personId = p.id)
             JOIN Competitions c ON (r.competitionId = c.id)
        WHERE eventId = (SELECT val FROM Event) AND
              p.countryId = (SELECT val FROM Country) AND
              average > 0
     ),
     Stat AS (
         SELECT DISTINCT r.personId, name, fpb.first_pb, r.best current_pb, fpb.first_pb/r.best ratio
         FROM FirstPB fpb JOIN RanksAverage r ON (fpb.personId = r.personId)
              JOIN Persons p ON (r.personId = p.id)
         WHERE eventId = (SELECT val FROM Event)
         ORDER BY ratio DESC
     )

SELECT * FROM Stat