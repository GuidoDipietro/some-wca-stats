# Number of competitors that have a result in N events
SELECT  b.n_events, COUNT(*) competitors
FROM (
    SELECT COUNT(*) n_events, personId
    FROM (
        SELECT DISTINCT eventId, personId
        FROM RanksSingle
    ) a
    GROUP BY personId
) b
GROUP BY b.n_events
ORDER BY b.n_events DESC

# Who are they?
SELECT b.n_events, b.personId, p.name
FROM (
    SELECT COUNT(*) n_events, personId
    FROM (
        SELECT DISTINCT eventId, personId
        FROM RanksSingle
    ) a
    GROUP BY personId
    HAVING COUNT(*) = 21
) b JOIN Persons p ON (b.personId = p.id)
