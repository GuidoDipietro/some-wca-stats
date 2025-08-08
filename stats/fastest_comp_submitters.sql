WITH avg_submission_delegates AS (
SELECT COUNT(c.id) comps, AVG(DATEDIFF(results_submitted_at, end_date)) submission_days, delegate_id
FROM competitions c JOIN competition_delegates d ON (c.id = d.competition_id)
WHERE results_posted_at IS NOT NULL
GROUP BY delegate_id
)

SELECT comps, submission_days, u.name
FROM avg_submission_delegates a JOIN users u ON (a.delegate_id = u.id) JOIN persons p ON (u.wca_id = p.wca_id) JOIN countries co ON (p.country_id = co.id)
WHERE co.continent_id = '_South America'
ORDER BY submission_days
