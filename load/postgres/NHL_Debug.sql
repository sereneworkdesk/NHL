---SELECT DISTINCT gp.team_id_for
---FROM game_plays gp
----LEFT JOIN team_info t
---ON gp.team_id_for = t.team_id
----WHERE gp.team_id_for IS NOT NULL AND t.team_id IS NULL;

---Table 3: game
--- Checking foreign key match primary key 
--- game.away_team_id → team.team_id
--- results : 88, 87, 90 are not in team.team_id
SELECT DISTINCT away_team_id
FROM game
WHERE away_team_id NOT IN (SELECT team_id FROM team_info);

---Action : Delete from table : game, where team_id is not in dim table : team_info
DELETE FROM game
WHERE away_team_id NOT IN (
    SELECT team_id
    FROM team_info
);

--- Table 3: game
--- Checking foreign key match primary key 
--- game.home_team_id → team.team_id
--- result : game.home_team_id matches values in team_info.team_id table
SELECT DISTINCT home_team_id
FROM game
WHERE home_team_id NOT IN (SELECT team_id FROM team_info);

--- Table 4: game_plays
--- Checking foreign key match primary key 
--- game_plays.game_id → game.game_id
--- results : 2019040651, 2019040653, 2018040643, 2018040642, 2019040652 are not found in game.game_id
SELECT DISTINCT game_id
FROM game_plays
WHERE game_id NOT IN (SELECT game_id FROM game);

---Action : Delete from table : game_plays, where game_id is not in dim table : game
DELETE FROM game_plays
WHERE game_id NOT IN (
    SELECT game_id
    FROM game
);

--- Table 4: game_plays
--- Checking foreign key match primary key 
--- game_plays.team_id_for → team_info.team_id
--- results : 'unknown' is not found in team_info
SELECT DISTINCT team_id_for
FROM game_plays
WHERE team_id_for NOT IN (SELECT team_id FROM team_info);

---Action : Delete from table : game_plays, where game_plays.team_id_for is not in dim table : team_info.team_info
DELETE FROM game_plays
WHERE team_id_for NOT IN (
    SELECT team_id
    FROM team_info
);

--- Table 4: game_plays
--- Checking foreign key match primary key 
--- game_plays.team_id_against → team_info.team_id
--- results : game_plays.team_id_against matches values in team_info.team_id
SELECT DISTINCT team_id_against
FROM game_plays
WHERE team_id_against NOT IN (SELECT team_id FROM team_info);

--- Table 5: game_plays_players
--- Checking foreign key match primary key 
--- game_plays_players.play_id → game_plays.play_id
--- results : 444 total missing play_ids from dim table game_plays.play_id
SELECT DISTINCT gpp.play_id
FROM game_plays_players gpp
LEFT JOIN game_plays gp
ON gpp.play_id = gp.play_id
WHERE gpp.play_id IS NOT NULL AND gp.play_id IS NULL;

--- Total number of distinct play_ids from game_plays_players that are missing in game_plays :444
SELECT COUNT(DISTINCT gpp.play_id) AS total_missing_play_ids
FROM game_plays_players gpp
LEFT JOIN game_plays gp ON gpp.play_id = gp.play_id
WHERE gpp.play_id IS NOT NULL AND gp.play_id IS NULL;

--- Count total rows in game_plays_players
--- Results : 6361947
SELECT COUNT(*) AS total_rows
FROM game_plays_players;

---Action : Delete from table : game_plays, where game_plays.play_id_for is not in dim table : game_play.play_id
DELETE FROM game_plays_players
WHERE play_id IN (
	SELECT DISTINCT gpp.play_id
	FROM game_plays_players gpp
	LEFT JOIN game_plays gp
	ON gpp.play_id = gp.play_id
	WHERE gpp.play_id IS NOT NULL AND gp.play_id IS NULL
);

--- Table 5: game_plays_players
--- Checking foreign key match primary key 
--- game_plays_players.game_id → game.game_id
--- results : game_plays_players.game_id matches values in game.game_id
SELECT DISTINCT gpp.game_id
FROM game_plays_players gpp
LEFT JOIN game g ON gpp.game_id = g.game_id
WHERE gpp.game_id IS NOT NULL AND g.game_id IS NULL;

--- Table 5: game_plays_players
--- Checking foreign key match primary key 
--- game_plays_players.player_id → player_info.player_id
--- results : game_plays_players.player_id matches values in player_info.player_id
SELECT DISTINCT gpp.player_id
FROM game_plays_players gpp
LEFT JOIN player_info pi ON gpp.player_id = pi.player_id
WHERE gpp.player_id IS NOT NULL AND pi.player_id IS NULL;

--- Table 6: game_goals
--- Checking foreign key match primary key 
--- game_goals.play_id -> game_plays.play_id
--- results : 64 total missing play_ids from dim table game_plays.play_id
SELECT DISTINCT gg.play_id
FROM game_goals gg
LEFT JOIN game_plays gp ON gg.play_id = gp.play_id
WHERE gg.play_id IS NOT NULL AND gp.play_id IS NULL;

--- Total number of distinct play_ids from game_goals that are missing in game_plays : 64
SELECT COUNT(DISTINCT gg.play_id) AS total_missing_play_ids
FROM game_goals gg
LEFT JOIN game_plays gp ON gg.play_id = gp.play_id
WHERE gg.play_id IS NOT NULL AND gp.play_id IS NULL;

--- Count total rows in game_goals
--- Results : 131437
SELECT COUNT(*) AS total_rows
FROM game_goals;

---Action : Delete from table : game_goals, where game_goals.play_id_for is not in dim table : game_plays.play_id
DELETE FROM game_goals
WHERE play_id IN (
	SELECT DISTINCT gg.play_id
	FROM game_goals gg
	LEFT JOIN game_plays gp ON gg.play_id = gp.play_id
	WHERE gg.play_id IS NOT NULL AND gp.play_id IS NULL
);

--- Table 7: game_goalie_stats
--- Checking foreign key match primary key 
--- game_goalie_stats.game_id -> game.game_id
--- results : 4 missing values game_id
SELECT DISTINCT ggs.game_id
FROM game_goalie_stats ggs
LEFT JOIN game g ON ggs.game_id = g.game_id
WHERE ggs.game_id IS NOT NULL AND g.game_id IS NULL;

--- Total number of distinct game_id from game_goalie_stats that are missing in game : 4
SELECT COUNT(DISTINCT ggs.game_id) AS total_missing_play_ids
FROM game_goalie_stats ggs
LEFT JOIN game g ON ggs.game_id = g.game_id
WHERE ggs.game_id IS NOT NULL AND g.game_id IS NULL;

--- Count total rows in game_goalie_stats
--- Results : 51123
SELECT COUNT(*) AS total_rows
FROM game_goalie_stats;

---Action : Delete from table : game_goalie_stats, where game_goalie_stats.game_id not in dim table: game.game_id
DELETE FROM game_goalie_stats
WHERE game_id NOT IN (
    SELECT game_id
    FROM game
);

--- Table 7: game_goalie_stats
--- Checking foreign key match primary key 
--- game_goalie_stats.player_id -> player_info.player_id
--- results : game_goalie_stats.player_id matches player_info.player_id
SELECT DISTINCT ggs.player_id
FROM game_goalie_stats ggs
LEFT JOIN player_info pi ON ggs.player_id = pi.player_id
WHERE ggs.player_id IS NOT NULL AND pi.player_id IS NULL;

--- Table 7: game_goalie_stats
--- Checking foreign key match primary key 
--- game_goalie_stats.team_id -> team_info.team_id
--- results : 4 missing team_id values from table : team_info 
SELECT DISTINCT ggs.team_id
FROM game_goalie_stats ggs
LEFT JOIN team_info ti ON ggs.team_id = ti.team_id
WHERE ggs.team_id IS NOT NULL AND ti.team_id IS NULL;

---Action : Delete from table : game_goalie_stats, where game_goalie_stats.team_id not in dim table: team_info.team_id
DELETE FROM game_goalie_stats
WHERE team_id NOT IN (
    SELECT team_id
    FROM team_info
);

--- Table 8: game_team_stats
--- Checking foreign key match primary key 
--- game_team_stats.game_id -> game.game_id
--- results : 4 missing game_id values from table : game
SELECT DISTINCT gts.game_id
FROM game_team_stats gts
LEFT JOIN game g ON gts.game_id = g.game_id
WHERE gts.game_id IS NOT NULL AND g.game_id IS NULL;

--- Count total rows in game_team_stats
--- Results : 47442
SELECT COUNT(*) AS total_rows
FROM game_team_stats;

---Action : Delete from table : game_team_stats, where game_team_stats.game_id not in dim table: game
DELETE FROM game_team_stats
WHERE game_id NOT IN (
    SELECT game_id
    FROM game
);

--- Table 8: game_team_stats
--- Checking foreign key match primary key 
--- game_team_stats.team_id -> team_info.team_id
--- results : game_team_stats.team_id matches team_info.team_id
SELECT DISTINCT gts.team_id
FROM game_team_stats gts
LEFT JOIN team_info ti ON gts.team_id = ti.team_id
WHERE gts.team_id IS NOT NULL AND ti.team_id IS NULL;

--- Table 9: game_skater_stats
--- Checking foreign key match primary key 
--- game_skater_stats.team_id -> team_info.team_id
--- results : 90 missing game_skater_stats.team_id from team_info.team_id
SELECT DISTINCT gss.team_id
FROM game_skater_stats gss
LEFT JOIN team_info ti ON gss.team_id = ti.team_id
WHERE gss.team_id IS NOT NULL AND ti.team_id IS NULL;

SELECT gss.team_id
FROM game_skater_stats gss
LEFT JOIN team_info ti ON gss.team_id = ti.team_id
WHERE gss.team_id IS NOT NULL AND ti.team_id IS NULL;

--- Count total rows in game_skater_stats
--- Results : 853404
SELECT COUNT(*) AS total_rows
FROM game_skater_stats;

---Action : Delete from table : game_skater_stats, where game_skater_stats.team_id not in dim table: team_info
DELETE FROM game_skater_stats
WHERE team_id NOT IN (
    SELECT team_id
    FROM team_info
);

--- Table 9: game_skater_stats
--- Checking foreign key match primary key 
--- game_skater_stats.game_id -> game.game_id
--- results : game_skater_stats.game_id matches game.game_id
SELECT DISTINCT gss.game_id
FROM game_skater_stats gss
LEFT JOIN game g ON gss.game_id = g.game_id
WHERE gss.game_id IS NOT NULL AND g.game_id IS NULL;

--- Table 9: game_skater_stats
--- Checking foreign key match primary key 
--- game_skater_stats.player_id -> player_info.player_id
--- results : game_skater_stats.player_id matches player_info.player_id
SELECT DISTINCT gss.player_id
FROM game_skater_stats gss
LEFT JOIN player_info pi ON gss.player_id = pi.player_id
WHERE gss.player_id IS NOT NULL AND pi.player_id IS NULL;

