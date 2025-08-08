# Number and type of records at a competition, per year
WITH records_by_comp AS (
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
      ) nrs,
      SUM(
         IF(regional_single_record IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0) +
         IF(regional_average_record IN ('AfR','AsR','ER','NAR','OcR','SAR'), 1, 0)
      ) crs,
      SUM(
         IF(regional_single_record='WR', 1, 0) +
         IF(regional_average_record='WR', 1, 0)
      ) wrs
   FROM results r JOIN competitions c ON (r.competition_id = c.id)
   WHERE c.country_id = ':country_id' AND (regional_single_record IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR') OR regional_average_record IN ('NR','AfR','AsR','ER','NAR','OcR','SAR','WR'))
   GROUP BY competition_id
),
max_records_by_year AS (
   SELECT year, MAX(records) max_records
   FROM records_by_comp
   GROUP BY year
)
SELECT r.competition_id, r.year, r.records, r.nrs, r.crs, r.wrs
FROM records_by_comp r
JOIN max_records_by_year m ON r.year = m.year AND r.records = m.max_records
ORDER BY r.year DESC, r.records DESC
