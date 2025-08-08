# Best 3BLD podiums with no DNFs
SELECT event_id, competition_id, avg_of_mean FROM (
    SELECT event_id, round_type_id, competition_id, AVG(average)/100 avg_of_mean, COUNT(*)
    FROM results
    WHERE   event_id = "333bf" AND
            round_type_id IN ("c","f") AND
            pos <= 3 AND
            average > 0
    GROUP BY competition_id, round_type_id
    HAVING COUNT(*) >= 3
    ORDER BY AVG(average)
) a
