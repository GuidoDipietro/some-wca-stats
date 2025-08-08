# NRs if your worst time counted instead of your best one

WITH anti_prs AS (
SELECT MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5))))) anti_pr, event_id, p.name, person_id
FROM results r JOIN persons p ON (r.person_id=p.wca_id)
WHERE p.country_id=':country_id'
GROUP BY event_id, person_id, p.name
HAVING MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5)))))>0
ORDER BY MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5)))))
),
anti_nrs AS (
SELECT MIN(anti_pr) anti_nr, event_id
FROM anti_prs
GROUP BY event_id
)

SELECT wca_statistics_time_format(p.anti_pr,p.event_id,'single') anti_nr, p.event_id, p.name, p.person_id
FROM anti_nrs a JOIN anti_prs p ON (a.anti_nr = p.anti_pr AND a.event_id = p.event_id)
WHERE p.event_id != '333mbo'
ORDER BY p.event_id
