WITH Ben AS (SELECT personId, SUM(best) mini_guildford, COUNT(*) events
FROM RanksSingle
WHERE eventId IN ('222','333','444','555','333oh','clock','minx','pyram','skewb','sq1')
GROUP BY personId),
Baron AS (
SELECT personId, name, mini_guildford, wca_statistics_time_format(mini_guildford, '333', 'single') time
FROM Ben JOIN Persons p ON (Ben.personId = p.id)
WHERE events=10
ORDER BY mini_guildford)

SELECT personId, name, time
FROM Baron