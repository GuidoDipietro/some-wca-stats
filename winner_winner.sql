# People who've won every round at a comp
SELECT personId, personName, stat.competitionId, stat.total_rounds_at_comp, stat.first_places
FROM (
    SELECT
        personId, personName, r.competitionId,
        SUM(IF(pos=1 AND best>0, 1, 0)) first_places,
        (
            SELECT COUNT(DISTINCT CONCAT(CONCAT(r1.competitionId, r1.eventId), r1.roundTypeId))
            FROM Results r1 WHERE r1.competitionId = r.competitionId
        ) total_rounds_at_comp
    FROM Results r WHERE r.countryId = 'Argentina'
    GROUP BY personId, personName, r.competitionId
    ORDER BY 5 DESC
) stat
WHERE stat.total_rounds_at_comp = stat.first_places
ORDER BY stat.total_rounds_at_comp DESC
