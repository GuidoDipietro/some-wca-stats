# Number and type of records at a competition
SELECT
   competitionId,
   SUM(
      IF(regionalSingleRecord IS NOT NULL, 1, 0) +
      IF(regionalAverageRecord IS NOT NULL, 1, 0)
   ) records,
   SUM(
      IF(regionalSingleRecord='NR', 1, 0) +
      IF(regionalAverageRecord='NR', 1, 0)
   ) NRs,
   SUM(
      IF(regionalSingleRecord IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0) +
      IF(regionalAverageRecord IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0)
   ) CRs,
   SUM(
      IF(regionalSingleRecord='WR', 1, 0) +
      IF(regionalAverageRecord='WR', 1, 0)
   ) WRs
FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
WHERE c.countryId = ':countryId' AND (regionalSingleRecord IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR') OR regionalAverageRecord IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR'))
GROUP BY competitionId
ORDER BY 2 DESC
