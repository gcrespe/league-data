WITH unpivot_picks AS (
  SELECT 
    league,
    pick1 AS champion,
    COUNT(pick1) AS pick_count
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, pick1
  UNION ALL
  SELECT 
    league,
    pick2 AS champion,
    COUNT(pick2) AS pick_count
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, pick2
  UNION ALL
  SELECT 
    league,
    pick3 AS champion,
    COUNT(pick3) AS pick_count
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, pick3
  UNION ALL
  SELECT 
    league,
    pick4 AS champion,
    COUNT(pick4) AS pick_count
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, pick4
  UNION ALL
  SELECT 
    league,
    pick5 AS champion,
    COUNT(pick5) AS pick_count
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, pick5
),
total_games_per_league AS (
  SELECT 
    league,
    COUNT(DISTINCT gameid) AS total_games
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league
)
SELECT
  p.league,
  p.champion,
  SUM(p.pick_count) AS total_picks,
  ROUND(SUM(p.pick_count) / t.total_games * 100, 2) AS pick_rate
FROM unpivot_picks p
JOIN total_games_per_league t
  ON p.league = t.league
WHERE p.champion IS NOT NULL
GROUP BY p.league, p.champion, t.total_games
ORDER BY p.league DESC, pick_rate DESC, total_picks DESC;
