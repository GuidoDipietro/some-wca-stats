/* Competitors and reg fee, to see how it impacts */

SELECT id, end_date, competitors, country_id, reg_fee, currency_code, GROUP_CONCAT(name) delegates, COUNT(DISTINCT name) n_delegates
FROM (
    SELECT a.id, end_date, competitors, country_id, reg_fee, currency_code, CONCAT(" ", u.name) name
    FROM (
        SELECT c.id, COUNT(DISTINCT r.person_id) competitors, c.country_id, c.base_entry_fee_lowest_denomination/100 reg_fee, currency_code, c.end_date
        FROM results r JOIN competitions c ON (r.competition_id = c.id)
        WHERE c.country_id = ':country_id'
        GROUP BY c.id, c.base_entry_fee_lowest_denomination
    ) a JOIN competition_delegates cd ON (a.id = cd.competition_id)
        JOIN users u ON (cd.delegate_id = u.id)
) query
WHERE reg_fee IS NOT NULL AND id LIKE '%2023'
GROUP BY id, competitors, country_id, reg_fee
ORDER BY end_date
