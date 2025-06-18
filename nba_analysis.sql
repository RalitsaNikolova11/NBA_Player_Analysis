-- Average height and weight by position
SELECT POSITION, ROUND(AVG(HEIGHT_CM), 2) AS avg_height,
ROUND(AVG(WEIGHT_KG), 2) AS avg_weight
FROM stats
GROUP BY POSITION
ORDER BY avg_height DESC, avg_weight DESC;

-- Top 10 scorers and their position
SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points
FROM stats
GROUP BY PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
ORDER BY total_points DESC
LIMIT 10;

-- Top 10 all around players and their position
SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION,
	SUM(PTS) AS total_points,
    SUM(REB) AS total_reb,
    SUM(AST) AS total_ast,
ROUND((SUM(PTS) + SUM(REB) + SUM(AST)), 1) AS total_contribution
FROM stats
GROUP BY PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
ORDER BY total_contribution DESC
LIMIT 10;

-- Top 5 scorers among Guards
SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points
FROM stats
WHERE POSITION LIKE '%G%'
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
ORDER BY total_points DESC
LIMIT 5;

-- Top 5 scorers among Forwards
SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points
FROM stats
WHERE POSITION LIKE '%F%'
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
ORDER BY total_points DESC
LIMIT 5;

-- Top 5 scorers among Centers
SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points
FROM stats
WHERE POSITION LIKE '%C%'
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
ORDER BY total_points DESC
LIMIT 5;

-- Which colleges produced the most players
SELECT COLLEGE, COUNT(PERSON_ID) AS cnt
FROM stats
GROUP BY COLLEGE
ORDER BY cnt DESC
LIMIT 10;

-- Which countries produced the most players besides USA
SELECT COUNTRY, COUNT(PERSON_ID) AS cnt
FROM stats
WHERE COUNTRY != 'USA'
GROUP BY COUNTRY
ORDER BY cnt DESC
LIMIT 10;

-- Which teams had the highest total points contributed by all their players
SELECT TEAM_NAME, ROUND(SUM(PTS), 1) AS total_points
FROM stats
GROUP BY TEAM_NAME
ORDER BY total_points DESC
LIMIT 5;