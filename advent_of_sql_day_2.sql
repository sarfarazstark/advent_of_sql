-- Day 2: Santa's jumbled letters 🎅, Date: 2024-12-03
CREATE OR REPLACE FUNCTION check_letter(value INT)
RETURNS TEXT AS
$$
BEGIN
	IF CHR(value) ~ '^[a-zA-Z !"''(),.-:;?]$' AND value != 47 THEN
		RETURN CHR(value);
	ELSE
		RETURN '';
	END IF;
END
$$ LANGUAGE plpgsql;

SELECT string_agg(check_letter(value), '') AS complete_sentence
FROM (SELECT value
      FROM letters_b
      UNION ALL
      SELECT value
      FROM letters_a) combined;
