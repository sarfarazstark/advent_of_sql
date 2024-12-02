-- Day 1: Santa's Gift List Parser, Date: 2024-12-02
SELECT name, wishes ->> 'first_choice' AS primary_wish, wishes ->> 'second_choice' AS backup_wish, wishes -> 'colors' ->> 0 AS favorite_color, json_array_length(wishes -> 'colors') AS color_count,
       CASE
	       WHEN toy_catalogue.difficulty_to_make = 1 THEN 'Simple Gift'
		   WHEN toy_catalogue.difficulty_to_make = 2 THEN 'Moderate Gift'
	       ELSE 'Complex Gift'
	   END AS gift_complexity,
	   CASE
	       WHEN toy_catalogue.category = 'outdoor' THEN 'Outside Workshop'
		   WHEN toy_catalogue.category = 'educational' THEN 'Learning Workshop'
	       ELSE 'General Workshop'
	   END AS workshop_assignment
       FROM children
JOIN wish_lists ON children.child_id = wish_lists.child_id
JOIN toy_catalogue ON toy_catalogue.toy_name = wish_lists.wishes ->> 'first_choice'
ORDER BY name
LIMIT 5;
