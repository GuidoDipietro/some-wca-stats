# GGG records
WITH ggg_singles AS (
   SELECT personId, eventId, best FROM RanksSingle # change RanksSingle to RanksAverage
   WHERE personId IN ('2013DIPI01','2017TUNG13','2014PAUL05','2014PAUL06','2016STEP05','2008SUNZ01','2015PEHR01','2012YUTA01','2016STRA05','2016BARO04')
),
    ggg_records AS (
   SELECT eventId, MIN(best) gr
   FROM ggg_singles GROUP BY eventId
)

SELECT DISTINCT eventId, name, best ggg_record
FROM ggg_singles gs JOIN Persons p ON (gs.personId = p.id)
WHERE gs.best = (SELECT gr FROM ggg_records grs WHERE grs.eventId = gs.eventId)
ORDER BY eventId