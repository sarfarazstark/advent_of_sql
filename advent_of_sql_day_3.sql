SELECT
    UNNEST(food_items) as items,
    COUNT(*) as frequency
FROM (
    SELECT
        CASE
            WHEN xmlexists('//total_count/text()' PASSING BY REF menu_data) = 'true' THEN (xpath('//total_count/text()', menu_data)::varchar[]::integer[])[1]
            WHEN xmlexists('//total_guests/text()' PASSING BY REF menu_data) = 'true' THEN (xpath('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
            WHEN xmlexists('//guestCount/text()' PASSING BY REF menu_data) = 'true' THEN (xpath('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
            ELSE 0
        END AS guest_count,
        xpath('//food_item_id/text()', menu_data)::varchar[] AS food_items
    FROM christmas_menus
) as gcfi
WHERE guest_count > 78
GROUP BY items
ORDER BY frequency DESC
LIMIT 1;