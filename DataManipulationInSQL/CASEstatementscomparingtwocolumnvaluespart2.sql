-- Select matches where Barcelona was the away team
SELECT  
	m.date,
	t.team_long_name AS opponent,
	CASE WHEN home_goal < away_goal THEN 'Barcelona win!'
        WHEN home_goal > away_goal THEN 'Barcelona loss :(' 
        ELSE 'Tie' END AS outcome
FROM matches_spain AS m
LEFT JOIN teams_spain AS t 
ON m.hometeam_id = t.team_api_id
-- Filter for Barcelona
WHERE m.awayteam_id = 8634;