WITH OrganizedComps AS (
SELECT competition_id competitionId, u.name
FROM competition_organizers c JOIN users u ON (c.organizer_id = u.id)
WHERE name = ':name'),
DelegatedComps AS (
SELECT competition_id competitionId, u.name
FROM competition_delegates c JOIN users u ON (c.delegate_id = u.id)
WHERE name = ':name'
),
AttendedComps AS (
SELECT DISTINCT competitionId, p.name
FROM Results r JOIN Persons p ON (r.personId = p.id)
WHERE name = ':name'
)

/* Todos los torneos delegados */
# SELECT * FROM DelegatedComps

/* Todos los torneos organizados */
# SELECT * FROM OrganizedComps

/* Todos los torneos asistidos */
SELECT * FROM AttendedComps

/* Asistidos sin delegar */
# SELECT * FROM AttendedComps a
# WHERE NOT EXISTS (SELECT 'x' FROM DelegatedComps d WHERE d.competitionId = a.competitionId)

/* Organizados sin asistir */
# SELECT * FROM OrganizedComps a
# WHERE NOT EXISTS (SELECT 'x' FROM AttendedComps d WHERE d.competitionId = a.competitionId)
