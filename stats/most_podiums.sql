# Most podiums
SELECT personName, COUNT(*) podios
FROM Results
WHERE countryId = 'Argentina' AND roundTypeId IN ('c','f') AND best > 0 AND pos <= 3
GROUP BY personName
ORDER BY COUNT(*) DESC
