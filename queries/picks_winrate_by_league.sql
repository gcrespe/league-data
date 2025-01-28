WITH unpivot_picks AS (
  SELECT 
    league,
    pick1 AS champion,
    participantid,
    result
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    pick2 AS champion,
    participantid,
    result
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    pick3 AS champion,
    participantid,
    result
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    pick4 AS champion,
    participantid,
    result
  FROM `smooth-graph-323716.lol1.matches`
  UNION ALL
  SELECT 
    league,
    pick5 AS champion,
    participantid,
    result
  FROM `smooth-graph-323716.lol1.matches`
),
total_games_per_league AS (
  SELECT 
    league,
    COUNT(DISTINCT gameid) AS total_games
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league
),
champion_stats AS (
  SELECT
    league,
    champion,
    COUNT(*) AS total_picks,
    SUM(CASE WHEN (participantid = 100 AND result = 1) OR (participantid = 200 AND result = 1) THEN 1 ELSE 0 END) AS wins
  FROM unpivot_picks
  WHERE champion IS NOT NULL
  GROUP BY league, champion
)
SELECT
  c.league,
  c.champion,
  c.total_picks,
  ROUND(c.total_picks / t.total_games * 100, 2) AS pick_rate,
  c.wins,
  ROUND(c.wins / c.total_picks * 100, 2) AS win_rate
FROM champion_stats c
JOIN total_games_per_league t
  ON c.league = t.league
ORDER BY c.league DESC, pick_rate DESC, c.total_picks DESC;
