WITH DelegatesComps AS (
   SELECT competition_id, delegate_id FROM competition_delegates UNION
   SELECT competition_id, trainee_delegate_id delegate_id FROM competition_trainee_delegates
)
SELECT competition_id, u.name, (results_posted_at IS NOT NULL) is_past_comp, (cancelled_at IS NOT NULL) cancelled
FROM DelegatesComps d JOIN users u ON (d.delegate_id = u.id)
     JOIN Competitions c ON (d.competition_id = c.id)
WHERE u.name = ':name'