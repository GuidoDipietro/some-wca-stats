WITH AvgSubmissionDelegates AS (
SELECT COUNT(c.id) comps, AVG(DATEDIFF(results_posted_at, DATE_ADD(DATE_ADD(MAKEDATE(IF(month=12 && endMonth=1,year+1,year), 1), INTERVAL (endMonth)-1 MONTH), INTERVAL (endDay)-1 DAY))) submission_days, delegate_id
FROM Competitions c JOIN competition_delegates d ON (c.id = d.competition_id)
WHERE results_posted_at IS NOT NULL
GROUP BY delegate_id
),
AvgSubmissionTrainees AS (
SELECT COUNT(c.id) comps, AVG(DATEDIFF(results_posted_at, DATE_ADD(DATE_ADD(MAKEDATE(IF(month=12 && endMonth=1,year+1,year), 1), INTERVAL (endMonth)-1 MONTH), INTERVAL (endDay)-1 DAY))) submission_days, trainee_delegate_id
FROM Competitions c JOIN competition_trainee_delegates d ON (c.id = d.competition_id)
WHERE results_posted_at IS NOT NULL
GROUP BY trainee_delegate_id
)

SELECT comps, submission_days, u.name
FROM AvgSubmissionDelegates a JOIN users u ON (a.delegate_id = u.id) JOIN Persons p ON (u.wca_id = p.id) JOIN Countries co ON (p.countryId = co.id)
WHERE co.continentId = '_South America'
ORDER BY submission_days
