WITH CompsWithWR AS (
   SELECT DISTINCT competitionId, 1 one
   FROM Results
   WHERE regionalSingleRecord='WR' OR regionalAverageRecord='WR'
),
DelegatedComps AS (
   SELECT DISTINCT competition_id, delegate_id
   FROM (SELECT competition_id, trainee_delegate_id delegate_id FROM competition_trainee_delegates
         UNION SELECT competition_id, delegate_id FROM competition_delegates) a
   JOIN Competitions c ON (a.competition_id = c.id)
   WHERE c.cancelled_at IS NULL AND c.results_submitted_at IS NOT NULL
),
Stat AS (
   SELECT name, COUNT(DISTINCT competition_id) delegated_comps, SUM(IF(EXISTS (SELECT 'x' FROM CompsWithWR WHERE competitionId=competition_id), 1, 0)) comps_with_wr
   FROM DelegatedComps dc JOIN users u ON (u.id = dc.delegate_id)
   GROUP BY name
)

SELECT name, 100*comps_with_wr/delegated_comps GTS
FROM Stat
ORDER BY 2 DESC