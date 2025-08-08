# Podiums divided by total possible podiums
SELECT
    person_id, person_name,
    SUM(IF(pos<4 AND best > 0, 1, 0)) podiums,
    COUNT(*) total_possible_podiums,
    100 * SUM(IF(pos<4, 1, 0)) / COUNT(*) 'ratio (%)'
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id = ':country' AND r.round_type_id IN ('c','f')
GROUP BY person_id, person_name
HAVING COUNT(*) > 10
ORDER BY 5 DESC
