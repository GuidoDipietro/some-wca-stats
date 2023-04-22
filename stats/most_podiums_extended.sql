# Most podiums, showing how many are gold, silver, and bronze

SELECT personName, SUM(IF(pos=1, 1, 0)) golds, SUM(IF(pos=2, 1, 0)) silvers, SUM(IF(pos=3, 1, 0)) bronzes, COUNT(*) total
FROM Results
WHERE countryId = ':countryId' AND roundTypeId IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY personName
ORDER BY COUNT(*) DESC
