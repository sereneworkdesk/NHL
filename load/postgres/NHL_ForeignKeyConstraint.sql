-- Table 3: game
-- Add foreign key for away_team_id in the game table
ALTER TABLE game
ADD CONSTRAINT fk_away_team
FOREIGN KEY (away_team_id)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

-- Add foreign key for home_team_id in the game table
ALTER TABLE game
ADD CONSTRAINT fk_home_team
FOREIGN KEY (home_team_id)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

-- Query the information_schema.table_constraints and 
-- information_schema.key_column_usage tables to list
-- foreign keys for game table
SELECT 
    tc.constraint_name, 
    kcu.column_name, 
    ccu.table_name AS referenced_table, 
    ccu.column_name AS referenced_column
FROM 
    information_schema.table_constraints AS tc
JOIN 
    information_schema.key_column_usage AS kcu
ON 
    tc.constraint_name = kcu.constraint_name
JOIN 
    information_schema.constraint_column_usage AS ccu
ON 
    ccu.constraint_name = tc.constraint_name
WHERE 
    tc.table_name = 'game'
    AND tc.constraint_type = 'FOREIGN KEY';
-----

-- Table 4: game_plays
--- game_plays.game_id → game.game_id
-- Add foreign key for game_id in the game_plays table
ALTER TABLE game_plays
ADD CONSTRAINT fk_game_id
FOREIGN KEY (game_id)
REFERENCES game(game_id)
ON DELETE CASCADE;

--- Table 4: game_plays
--- game_plays.team_id_for → team_info.team_id
-- Add foreign key for team_id in the game_plays table
ALTER TABLE game_plays
ADD CONSTRAINT fk_team_id_for
FOREIGN KEY (team_id_for)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

--- Table 4: game_plays
--- game_plays.team_id_against → team_info.team_id
-- Add foreign key for team_id in the game_plays table
ALTER TABLE game_plays
ADD CONSTRAINT fk_team_id_against
FOREIGN KEY (team_id_against)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

-- Query the information_schema.table_constraints and 
-- information_schema.key_column_usage tables to list
-- foreign keys for game table
SELECT 
    tc.constraint_name, 
    kcu.column_name, 
    ccu.table_name AS referenced_table, 
    ccu.column_name AS referenced_column
FROM 
    information_schema.table_constraints AS tc
JOIN 
    information_schema.key_column_usage AS kcu
ON 
    tc.constraint_name = kcu.constraint_name
JOIN 
    information_schema.constraint_column_usage AS ccu
ON 
    ccu.constraint_name = tc.constraint_name
WHERE 
    tc.table_name = 'game_plays'
    AND tc.constraint_type = 'FOREIGN KEY';

--- Table 5: game_plays_players
--- game_plays_players.play_id → game_plays.play_id
-- Add foreign key for play_id in the game_plays table
ALTER TABLE game_plays_players
ADD CONSTRAINT fk_play_id
FOREIGN KEY (play_id)
REFERENCES game_plays(play_id)
ON DELETE CASCADE;

--- Table 5 : game_plays_players
--- game_plays_players.game_id → game.game_id
-- Add foreign key for game_id in the game table
ALTER TABLE game_plays_players
ADD CONSTRAINT fk_game_id
FOREIGN KEY (game_id)
REFERENCES game(game_id)
ON DELETE CASCADE;

--- Table 5: game_plays_players
--- game_plays_players.player_id → player_info.player_id
-- Add foreign key for player_id in the player_info table
ALTER TABLE game_plays_players
ADD CONSTRAINT fk_player_id
FOREIGN KEY (player_id)
REFERENCES player_info(player_id)
ON DELETE CASCADE;

--- Table 6: game_goals
--- game_goals.play_id -> game_plays.play_id
-- Add foreign key for play_id in the game_goals table
ALTER TABLE game_goals
ADD CONSTRAINT fk_play_id
FOREIGN KEY (play_id)
REFERENCES game_plays(play_id)
ON DELETE CASCADE;

--- Table 7: game_goalie_stats
--- game_goalie_stats.game_id -> game.game_id
-- Add foreign key for game_id in the game_goalie_stats table
ALTER TABLE game_goalie_stats
ADD CONSTRAINT fk_game_id
FOREIGN KEY (game_id)
REFERENCES game(game_id)
ON DELETE CASCADE;

--- Table 7: game_goalie_stats
--- game_goalie_stats.player_id -> player_info.player_id
-- Add foreign key for player_id in the game_goalie_stats table
ALTER TABLE game_goalie_stats
ADD CONSTRAINT fk_player_id
FOREIGN KEY (player_id)
REFERENCES player_info(player_id)
ON DELETE CASCADE;

--- Table 7: game_goalie_stats
-- game_goalie_stats.team_id -> team_info.team_id
-- Add foreign key for team_id in the game_goalie_stats table
ALTER TABLE game_goalie_stats
ADD CONSTRAINT fk_team_id
FOREIGN KEY (team_id)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

--- Table 8: game_team_stats
--- game_team_stats.game_id -> game.game_id
-- Add foreign key for game_id in the game_team_stats table
ALTER TABLE game_team_stats
ADD CONSTRAINT fk_game_id
FOREIGN KEY (game_id)
REFERENCES game(game_id)
ON DELETE CASCADE;

--- Table 8: game_team_stats
--- game_team_stats.team_id -> team_info.team_id
-- Add foreign key for team_id in the game_team_stats table
ALTER TABLE game_team_stats
ADD CONSTRAINT fk_team_id
FOREIGN KEY (team_id)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

--- Table 9: game_skater_stats
--- game_skater_stats.team_id -> team_info.team_id
-- Add foreign key for team_id in the game_skater_stats table
ALTER TABLE game_skater_stats
ADD CONSTRAINT fk_team_id
FOREIGN KEY (team_id)
REFERENCES team_info(team_id)
ON DELETE CASCADE;

--- Table 9: game_skater_stats
--- game_skater_stats.game_id -> game.game_id
ALTER TABLE game_skater_stats
ADD CONSTRAINT fk_game_id
FOREIGN KEY (game_id)
REFERENCES game(game_id)
ON DELETE CASCADE;

--- Table 9: game_skater_stats
--- game_skater_stats.player_id -> player_info.player_id
ALTER TABLE game_skater_stats
ADD CONSTRAINT fk_player_id
FOREIGN KEY (player_id)
REFERENCES player_info(player_id)
ON DELETE CASCADE;
