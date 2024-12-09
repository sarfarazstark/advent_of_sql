SELECT c.name  AS child_name,
       g.name  AS gift_name,
       g.price AS gift_price
FROM children c
	     JOIN
     gifts g
     ON
	     g.child_id = c.child_id
WHERE (SELECT AVG(price) FROM gifts) < g.price
ORDER BY g.price;