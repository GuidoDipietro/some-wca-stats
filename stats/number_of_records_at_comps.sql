# Number and type of records at a competition
SELECT
   competition_id,
   RIGHT(competition_id, 4) year,
   SUM(
      IF(regional_single_record IS NOT NULL, 1, 0) +
      IF(regional_average_record IS NOT NULL, 1, 0)
   ) records,
   SUM(
      IF(regional_single_record='NR', 1, 0) +
      IF(regional_average_record='NR', 1, 0)
   ) NRs,
   SUM(
      IF(regional_single_record IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0) +
      IF(regional_average_record IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0)
   ) CRs,
   SUM(
      IF(regional_single_record='WR', 1, 0) +
      IF(regional_average_record='WR', 1, 0)
   ) WRs,
   ROW_NUMBER() OVER (PARTITION BY RIGHT(competition_id, 4) ORDER BY SUM(
      IF(regional_single_record IS NOT NULL, 1, 0) +
      IF(regional_average_record IS NOT NULL, 1, 0)
   ) DESC) AS rank
FROM results r JOIN competitions c ON (r.competition_id = c.id)
WHERE c.country_id = ':country_id' AND (regional_single_record IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR') OR regional_average_record IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR'))
GROUP BY competition_id
ORDER BY 2 DESC, 3 DESC
