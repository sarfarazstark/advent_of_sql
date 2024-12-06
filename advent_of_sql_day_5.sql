SELECT production_date,
       toys_produced,
       LAG(toys_produced, 1) OVER (ORDER BY production_date)                                AS previous_day_production,
       COALESCE(toys_produced - (LAG(toys_produced, 1) OVER (ORDER BY production_date)), 0) AS daily_production_change,
       CASE
	       WHEN LAG(toys_produced) OVER (ORDER BY production_date) = 0 THEN NULL
	       ELSE ((toys_produced - LAG(toys_produced) OVER (ORDER BY production_date)) * 100.0 /
	             LAG(toys_produced) OVER (ORDER BY production_date))
	       END                                                                              AS percentage_change
FROM toy_production
ORDER BY percentage_change DESC NULLS LAST;