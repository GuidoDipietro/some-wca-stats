# NRs if your worst time counted instead of your best one

WITH antiPRs AS (
SELECT MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5))))) antiPR, eventId, p.name, personId
FROM Results r JOIN Persons p ON (r.personId=p.id)
WHERE p.countryId=':countryId'
GROUP BY eventId, personId, p.name
HAVING MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5)))))>0
ORDER BY MAX(GREATEST(value1,GREATEST(value2,GREATEST(value3,GREATEST(value4,value5)))))
),
antiNRs AS (
SELECT MIN(antiPR) antiNR, eventId
FROM antiPRs
GROUP BY eventId
)

SELECT wca_statistics_time_format(p.antiPR,p.eventId,'single') antiNR, p.eventId, p.name, p.personId
FROM antiNRs a JOIN antiPRs p ON (a.antiNR = p.antiPR AND a.eventId = p.eventId)
WHERE p.eventId != '333mbo'
ORDER BY p.eventId
