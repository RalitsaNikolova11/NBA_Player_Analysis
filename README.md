# NBA_Player_Analysis ⛹️‍♂️

Using SQL to analyse NBA player statistics with a focus on player position


## Overview
The project analyses the NBA Players Database using MySQL for cleaning and analysis.
The goal is to understand trends based on player position, such as:
- Average height and weight by position
- Top 10 scorers and all-around player
- Top 5 scorers by position
- The colleges and countries that have produced the most players
- Top-scoring teams


## Tools Used
- MySQL for data cleaning and analysis


## Data Cleaning Steps
- Checked for null or empty values on important columns
- Checked for duplicates
- Standardised country names
- Converted height from feet-inches to centimetres and weight from pounds to kilograms for metric standardisation


## Analysis Queries

1. Average height and weight by position

SELECT POSITION, ROUND(AVG(HEIGHT_CM), 2) AS avg_height,  
ROUND(AVG(WEIGHT_KG), 2) AS avg_weight  
FROM stats  
GROUP BY POSITION  
ORDER BY avg_height DESC, avg_weight DESC;

2. Top 10 scorers and their position

SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points  
FROM stats  
GROUP BY PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION  
ORDER BY total_points DESC  
LIMIT 10;

3. Top 10 all-around players and their positions

SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION,  
    SUM(PTS) AS total_points,  
    SUM(REB) AS total_reb,  
    SUM(AST) AS total_ast,  
    ROUND((SUM(PTS) + SUM(REB) + SUM(AST)), 1) AS total_contribution  
FROM stats  
GROUP BY PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION  
ORDER BY total_contribution DESC  
LIMIT 10;

4. Top 5 scorers among Guards

SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points  
FROM stats  
WHERE POSITION LIKE '%G%'  
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION  
ORDER BY total_points DESC  
LIMIT 5;

5. Top 5 scorers among Forwards

SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points  
FROM stats  
WHERE POSITION LIKE '%F%'  
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION  
ORDER BY total_points DESC  
LIMIT 5;

6. Top 5 scorers among Centres

SELECT PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION, SUM(PTS) AS total_points  
FROM stats  
WHERE POSITION LIKE '%C%'  
GROUP BY PERSON_ID, PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION  
ORDER BY total_points DESC  
LIMIT 5;

7. Colleges that produced the most players

SELECT COLLEGE, COUNT(PERSON_ID) AS cnt  
FROM stats  
GROUP BY COLLEGE  
ORDER BY cnt DESC  
LIMIT 10;

8. Countries that produced the most players besides the USA

SELECT COUNTRY, COUNT(PERSON_ID) AS cnt  
FROM stats  
WHERE COUNTRY != 'USA'  
GROUP BY COUNTRY  
ORDER BY cnt DESC  
LIMIT 10;

9. Teams with the highest total points contributed by all their players

SELECT TEAM_NAME, ROUND(SUM(PTS), 1) AS total_points  
FROM stats  
GROUP BY TEAM_NAME  
ORDER BY total_points DESC  
LIMIT 5;  


## Key Insights
- Centres are the tallest (avg. 210 cm) and Centre-Forwards the heaviest players (avg. 114 kg), while Guards are the shortest (191 cm) and lightest (86 kg)  
- Forwards dominate the top scorers (all top 3), as well as the all-around players  
- Giannis Antetokounmpo (a Forward) is the top scorer and the best all-around player from the dataset
- Kareem Abdul-Jabbar ranks the top-scoring Centre and the 3rd best all-around player
- UCLA has produced the most players
- Nigeria leads among countries outside the USA in number of players  
- The Lakers are the team with the highest total points contributed by all players


## Dataset Information
**Source:** [NBA Players Database (via Kaggle)](https://www.kaggle.com/datasets/unsdsn/world-happiness/data)   
**Data Format:** CSV  
**Key Columns:**   
- PLAYER_FIRST_NAME, PLAYER_LAST_NAME, POSITION
- COUNTRY, COLLEGE, TEAM_NAME
- PTS, REB, AST, HEIGHT_CM, WEIGHT_KG


  
