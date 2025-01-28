-------- INFO SCHEMA FROM TABLE --------
SELECT * FROM lol1.INFORMATION_SCHEMA.TABLES;

-------- LEAGUES --------

SELECT DISTINCT league
FROM `smooth-graph-323716.lol1.matches`;

-------- TEAMS --------

SELECT DISTINCT teamname
-- WHERE LEAGUE = 'LPL'
FROM `smooth-graph-323716.lol1.matches`;