# Best single done by a competitor on their first comp (slow for big countries)
SELECT eventId, personId, personName, competitionId, MIN(best_first_single)
FROM (
    SELECT eventId, personId, personName, competitionId, MIN(best) best_first_single
        FROM Results r JOIN Persons p ON (r.personId = p.id)
        WHERE best > 0 AND p.countryId = 'Argentina' AND
              competitionId = (SELECT competitionId FROM (
                  SELECT DISTINCT r1.competitionId, r1.personId, c.end_date
                  FROM Results r1 JOIN Competitions c ON (r1.competitionID = c.id)
                  WHERE r1.personId = r.personId
                  ORDER BY c.end_date
                  LIMIT 1
              ) first_comp)
        GROUP BY eventId, personId, personName, competitionId
        ORDER BY best_first_single
    ) stat
GROUP BY eventId
ORDER BY eventId
