# GGG records
WITH ggg_singles AS (
   SELECT person_id, event_id, best FROM ranks_single # change ranks_single to ranks_average
   WHERE person_id IN ('2013DIPI01','2017TUNG13','2014PAUL05','2014PAUL06','2016STEP05','2008SUNZ01','2015PEHR01','2012YUTA01','2016STRA05','2016BARO04')
),
    ggg_records AS (
   SELECT event_id, MIN(best) gr
   FROM ggg_singles GROUP BY event_id
)

SELECT DISTINCT event_id, name, best ggg_record
FROM ggg_singles gs JOIN persons p ON (gs.person_id = p.wca_id)
WHERE gs.best = (SELECT gr FROM ggg_records grs WHERE grs.event_id = gs.event_id)
ORDER BY event_id
