SELECT COUNT(wca_id) newcomers, :year year, (SELECT COUNT(*) FROM competitions WHERE end_date LIKE ':year%' AND country_id = ':country') comps, COUNT(wca_id) / (SELECT COUNT(*) FROM competitions WHERE end_date LIKE ':year%' AND country_id = ':country') newcomers_per_comp
FROM persons
WHERE country_id = ':country'
AND wca_id LIKE ':year%'
