-- Checking for null or empty values in important columns
SELECT COUNT(*) AS total_num,
	SUM(CASE WHEN PLAYER_FIRST_NAME IS NULL OR PLAYER_FIRST_NAME = '' THEN 1 ELSE 0 END) AS missing_first_name,
    SUM(CASE WHEN PLAYER_LAST_NAME IS NULL OR PLAYER_LAST_NAME = '' THEN 1 ELSE 0 END) AS missing_last_name,
    SUM(CASE WHEN POSITION IS NULL OR POSITION = '' THEN 1 ELSE 0 END) AS missing_position
FROM stats;

-- Checking for duplicates in player names
SELECT PERSON_ID, COUNT(*) AS cnt
FROM stats
GROUP BY PERSON_ID
HAVING cnt > 1;

-- Checking for duplicates in team names
SELECT TEAM_NAME, COUNT(DISTINCT TEAM_ID) AS team_ids
FROM stats
GROUP BY TEAM_NAME
ORDER BY team_ids DESC;
    
-- Checking for country variations
SELECT DISTINCT COUNTRY
FROM stats
ORDER BY COUNTRY;

-- Converting HEIGHT from feet-inches to centimeters and
-- WEIGHT from pounds to kilograms for standardization and metric analysis.

ALTER TABLE stats 
ADD COLUMN HEIGHT_CM DOUBLE;

UPDATE stats
SET HEIGHT_CM = (
  (CAST(SUBSTRING_INDEX(HEIGHT, '-', 1) AS UNSIGNED) * 12 + 
   CAST(SUBSTRING_INDEX(HEIGHT, '-', -1) AS UNSIGNED)) * 2.54
)
WHERE HEIGHT IS NOT NULL AND HEIGHT != '';


ALTER TABLE stats 
ADD COLUMN WEIGHT_KG DOUBLE;

UPDATE stats
SET WEIGHT_KG = WEIGHT * 0.453592
WHERE WEIGHT IS NOT NULL AND WEIGHT != '';