# Best 3BLD podiums with no DNFs
SELECT eventId, competitionId, avg_of_mean FROM (
    SELECT eventId, roundTypeId, competitionId, AVG(average)/100 avg_of_mean, COUNT(*)
    FROM Results
    WHERE   eventId = "333bf" AND
            roundTypeId IN ("c","f") AND
            pos <= 3 AND
            average > 0
    GROUP BY competitionId, roundTypeId
    HAVING COUNT(*) >= 3
    ORDER BY AVG(average)
) a
