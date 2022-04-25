# Most NRs/SARs/both

SELECT
    personId, personName,
    SUM(IF(regionalSingleRecord='NR', 1, 0)+IF(regionalAverageRecord='NR', 1, 0)) NRs,
    SUM(IF(regionalSingleRecord='SAR', 1, 0)+IF(regionalAverageRecord='SAR', 1, 0)) SARs,
    SUM(IF(regionalSingleRecord='WR', 1, 0)+IF(regionalAverageRecord='WR', 1, 0)) WRs,
    SUM(IF(regionalSingleRecord IN ('NR','SAR','WR'), 1, 0)+IF(regionalAverageRecord IN ('NR','SAR','WR'), 1, 0)) 'all'
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE p.countryId='Argentina'
GROUP BY personId, personName
ORDER BY 3 DESC
