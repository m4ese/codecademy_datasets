

--First, we're gonna check out the two tables

SELECT * FROM chat
LIMIT 20;

/*
--columns are
time
device_id
login
channel
country
player
game
*/


SELECT * FROM stream
LIMIT 20;

/*
--columns:
time
device_id
login
channel
country
player
game
stream_format
subscriber
*/


--what are the unique games in stream table?

SELECT DISTINCT(game) FROM stream
WHERE game IS NOT NULL
ORDER BY 1; --putting them in alphabetical order

--unique channels in stream table?
SELECT DISTINCT(channel) FROM stream;




--most popular games in the stream table?
SELECT DISTINCT game,COUNT(*) AS 'number of streams' 
FROM stream
GROUP BY 1
ORDER BY 2 DESC;



--where are LoL viewers located?
SELECT DISTINCT country, COUNT(*) AS 'number of viewers per country' 
FROM stream
WHERE game = 'League of Legends'
GROUP BY 1
ORDER BY 2 DESC;



--how many players are streaming from each platform (iPhone, iPad, android, etc.)?
SELECT DISTINCT player, COUNT(*) AS 'number of players'
FROM stream
GROUP BY 1
ORDER BY 2 DESC;



--NEW COLUMN IN STREAM: genre
SELECT game, 
	CASE 
		WHEN game = 'League of Legends' THEN 'MOBA'
		WHEN game = 'Dota 2' THEN 'MOBA'
		WHEN game = 'Heroes of the Storm' THEN 'MOBA'
		WHEN game = 'Counter-Strike: Global Offensive' THEN 'FPS'
		WHEN game = 'DayZ' THEN 'Survival'
		WHEN game = 'Survival Evolved' THEN 'Survival'
		ELSE 'Other'
	END AS 'genre',
	COUNT(*)
FROM stream
GROUP BY 1
ORDER BY 3 DESC;



--time during the day queries
SELECT strftime('%H',time) AS 'hour',COUNT(*) AS 'counts'
FROM stream
WHERE country = 'US'
GROUP BY 1;


--Let's join the two tables now. They share the column device_id
SELECT * FROM stream AS s
JOIN chat AS c
	ON c.device_id = s.device_id
LIMIT 20;

	

