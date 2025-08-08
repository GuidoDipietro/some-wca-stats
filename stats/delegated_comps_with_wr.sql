WITH comps_with_wr AS (
   SELECT DISTINCT competition_id, 1 one
   FROM results
   WHERE regional_single_record='WR' OR regional_average_record='WR'
),
delegated_comps AS (
   SELECT DISTINCT competition_id, delegate_id
   FROM competition_delegates a
   JOIN competitions c ON (a.competition_id = c.id)
   WHERE c.cancelled_at IS NULL AND c.results_submitted_at IS NOT NULL
),
stat AS (
   SELECT name, COUNT(DISTINCT competition_id) delegated_comps, SUM(IF(EXISTS (SELECT 'x' FROM comps_with_wr w WHERE w.competition_id=dc.competition_id), 1, 0)) comps_with_wr
   FROM delegated_comps dc JOIN users u ON (u.id = dc.delegate_id)
   GROUP BY name
)

SELECT name, 100*comps_with_wr/delegated_comps gts
FROM stat
ORDER BY 2 DESC
