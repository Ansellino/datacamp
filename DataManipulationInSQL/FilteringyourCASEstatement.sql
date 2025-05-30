SELECT 
	season,
    date,
	home_goal,
	away_goal
FROM matches_italy
WHERE 
	-- Find games where home_goal is more than away_goal
	CASE WHEN hometeam_id = 9857 AND home_goal > away_goal THEN 'Bologna Win'
		-- Find games where away_goal is more than home_goal
        WHEN awayteam_id = 9857 AND away_goal > home_goal THEN 'Bologna Win' 
        -- Exclude games not won by Bologna
		END IS NOT NULL;