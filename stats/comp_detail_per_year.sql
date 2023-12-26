/* Competitors and reg fee, to see how it impacts */

SELECT id, end_date, competitors, countryId, reg_fee, currency_code, GROUP_CONCAT(name) delegates, COUNT(DISTINCT name) n_delegates
FROM (
    SELECT a.id, end_date, competitors, countryId, reg_fee, currency_code, CONCAT(" ", u.name) name
    FROM (
        SELECT c.id, COUNT(DISTINCT r.personId) competitors, c.countryId, c.base_entry_fee_lowest_denomination/100 reg_fee, currency_code, c.end_date
        FROM Results r JOIN Competitions c ON (r.competitionId = c.id)
        WHERE c.countryId = ':countryId'
        GROUP BY c.id, c.base_entry_fee_lowest_denomination
    ) a JOIN competition_delegates cd ON (a.id = cd.competition_id)
        JOIN users u ON (cd.delegate_id = u.id)
) query
WHERE reg_fee IS NOT NULL AND id LIKE '%2023'
GROUP BY id, competitors, countryId, reg_fee
ORDER BY end_date
