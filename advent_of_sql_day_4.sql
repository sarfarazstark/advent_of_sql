SELECT
  toy_id,
  toy_name,
  ARRAY(SELECT unnest(new_tags) EXCEPT SELECT unnest(previous_tags)) AS added_tags,
  array_length(ARRAY(SELECT unnest(new_tags) EXCEPT SELECT unnest(previous_tags)), 1) AS added_tags_length,
  ARRAY(SELECT unnest(previous_tags) INTERSECT SELECT unnest(new_tags)) AS unchanged_tags,
  array_length(ARRAY(SELECT unnest(previous_tags) INTERSECT SELECT unnest(new_tags)), 1) AS unchanged_tags_length,
  ARRAY(SELECT unnest(previous_tags) EXCEPT SELECT unnest(new_tags)) AS removed_tags,
  array_length(ARRAY(SELECT unnest(previous_tags) EXCEPT SELECT unnest(new_tags)), 1) AS removed_tags_length
FROM toy_production
ORDER BY added_tags_length DESC;
