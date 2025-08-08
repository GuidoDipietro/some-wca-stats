# Most NRs/SARs/WRs/all

SELECT
    person_id, person_name,
    SUM(IF(regional_single_record='NR', 1, 0)+IF(regional_average_record='NR', 1, 0)) NRs,
    SUM(IF(regional_single_record='SAR', 1, 0)+IF(regional_average_record='SAR', 1, 0)) SARs,
    SUM(IF(regional_single_record='WR', 1, 0)+IF(regional_average_record='WR', 1, 0)) WRs,
    SUM(IF(regional_single_record IN ('NR','SAR','WR'), 1, 0)+IF(regional_average_record IN ('NR','SAR','WR'), 1, 0)) 'all'
FROM results r JOIN persons p ON (r.person_id = p.wca_id)
WHERE p.country_id=':country'
GROUP BY person_id, person_name
ORDER BY 6 DESC
