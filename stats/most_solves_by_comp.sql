# Most solves/comp
SELECT
    person_id, person_name,
    SUM(IF(value1>0, 1, 0) +
    IF(value2>0, 1, 0) +
    IF(value3>0, 1, 0) +
    IF(value4>0, 1, 0) +
    IF(value5>0, 1, 0)) / COUNT(DISTINCT r.competition_id) solves_per_comp
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id = ':country'
GROUP BY person_id, person_name
ORDER BY 3 DESC
