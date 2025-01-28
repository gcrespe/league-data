------- CHAMPIONS TOTAL PICKS, PICK RATE, WINS AND WIN RATE BY LEAGUE, YEAR, SPLIT AND PLAYOFFS

WITH unpivot_picks AS (
  SELECT 
    league,
    year,
    split,
    playoffs,
    side,
    pick1 AS champion,
    participantid,
    result,
    gameid
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    year,
    split,
    playoffs,
    side,
    pick2 AS champion,
    participantid,
    result,
    gameid
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    year,
    split,
    playoffs,
    side,
    pick3 AS champion,
    participantid,
    result,
    gameid
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    year,
    split,
    playoffs,
    side,
    pick4 AS champion,
    participantid,
    result,
    gameid
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    year,
    split,
    playoffs,
    side,
    pick5 AS champion,
    participantid,
    result,
    gameid
  FROM `smooth-graph-323716.lol1.matches`
),
total_picks_and_games_per_group AS (
  SELECT 
    league,
    year,
    split,
    playoffs,
    COUNT(DISTINCT gameid) AS total_games
  FROM unpivot_picks
  WHERE champion IS NOT NULL
  GROUP BY league, year, split, playoffs
),
champion_stats AS (
  SELECT
    league,
    year,
    split,
    playoffs,
    champion,
    COUNT(*) AS total_picks,
    SUM(CASE WHEN (participantid = 100 AND result = 1) OR (participantid = 200 AND result = 1) THEN 1 ELSE 0 END) AS wins
  FROM unpivot_picks
  WHERE champion IS NOT NULL
  GROUP BY league, year, split, playoffs, champion
)
SELECT
  c.league,
  c.year,
  c.split,
  c.playoffs,
  t.total_games,
  c.champion,
  c.total_picks,
  ROUND(c.total_picks / t.total_games * 100, 2) AS pick_rate,
  c.wins,
  ROUND(c.wins / c.total_picks * 100, 2) AS win_rate
FROM champion_stats c
JOIN total_picks_and_games_per_group t
  ON c.league = t.league
  AND c.year = t.year
  AND c.split = t.split
  AND c.playoffs = t.playoffs
-- WHERE c.league = 'TCL' AND c.champion = 'Corki'
ORDER BY c.league DESC, c.year DESC, c.split, c.playoffs, pick_rate DESC, c.total_picks DESC;