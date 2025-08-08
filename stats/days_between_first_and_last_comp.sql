# Days between first and last comp
SELECT person_id, person_name, DATEDIFF(MAX(end_date), MIN(start_date)) days, MAX(end_date) last_day, MIN(start_date) first_day
FROM results r JOIN competitions c ON (r.competition_id = c.id)
     JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id=':country'
GROUP BY person_id, person_name
ORDER BY DATEDIFF(MAX(end_date),MIN(start_date)) DESC
