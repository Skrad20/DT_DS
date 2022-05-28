SELECT
    EXTRACT(week FROM flights.departure_time) as week_number
    , COUNT(ticket_no) as ticket_amount
    , subq.festival_week as festival_week
    , subq.festival_name as festival_name
FROM
    ticket_flights
JOIN flights ON flights.flight_id = ticket_flights.flight_id
JOIN airports ON airports.airport_code = flights.arrival_airport
LEFT JOIN
    (SELECT
        festival_name,
        EXTRACT(week FROM festival_date) as festival_week
    FROM
        festivals
    WHERE
        CAST(festival_date as date) BETWEEN '2018-07-23' AND '2018-09-30'
        AND festival_city = 'Москва'
    ) AS subq ON subq.festival_week = EXTRACT(week FROM flights.arrival_time)
WHERE
    CAST(flights.departure_time as date) BETWEEN '2018-07-23' AND '2018-09-30'
    AND airports.city = 'Москва'
GROUP BY
    week_number
    , subq.festival_week
    , subq.festival_name
ORDER BY
week_number