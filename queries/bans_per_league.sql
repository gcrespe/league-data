WITH unpivot_bans AS (
  SELECT 
    league,
    ban1 as champion,
    CAST(ROUND(COUNT(ban1)/6, 0) as INT64) as qtd_ban ,
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, ban1
  UNION ALL
  SELECT 
    league,
    ban2 as champion,
    CAST(ROUND(COUNT(ban2)/6, 0) as INT64) as qtd_ban,
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, ban2
  UNION ALL
  SELECT 
    league,
    ban3 as champion,
    CAST(ROUND(COUNT(ban3)/6, 0) as INT64) as qtd_ban,
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, ban3
  UNION ALL
  SELECT 
    league,
    ban4 as champion,
    CAST(ROUND(COUNT(ban4)/6, 0) as INT64) as qtd_ban,
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, ban4
  UNION ALL
  SELECT 
    league,
    ban5 as champion,
    CAST(ROUND(COUNT(ban5)/6, 0) as INT64) as qtd_ban,
  FROM `smooth-graph-323716.lol1.matches`
  GROUP BY league, ban5
)
SELECT
  league,
  champion,
  SUM(qtd_ban) AS qtd_ban
FROM unpivot_bans
WHERE champion IS NOT NULL
GROUP BY league, champion
ORDER BY league DESC, qtd_ban DESC;