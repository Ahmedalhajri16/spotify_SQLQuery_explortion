-- Get column names for the 'spotify_tracks' table
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'spotify_tracks';

-- Get the count of tracks by language, ordered by track count in descending order
SELECT language, COUNT(*) AS track_count
FROM dbo.spotify_tracks
GROUP BY language
ORDER BY track_count DESC;

-- Get the count of tracks and popularity for each artist, ordered by track count
SELECT artist_name, COUNT(*) AS artistName, popularity
FROM dbo.spotify_tracks
GROUP BY artist_name, popularity
ORDER BY artistName DESC;

-- Get the count of tracks and maximum popularity for each track name, ordered by max popularity
SELECT track_name, COUNT(*) AS song_count, MAX(popularity) AS max_popularity
FROM dbo.spotify_tracks
GROUP BY track_name
ORDER BY max_popularity DESC;

-- Get the count of tracks for each track name, duration, and year where there are duplicates, ordered by song count
SELECT track_name, duration_ms, year, COUNT(*) AS songs
FROM dbo.spotify_tracks
GROUP BY track_name, duration_ms, year
HAVING COUNT(*) > 1
ORDER BY songs DESC;

-- Get duplicates of 'Love Yourself' track, showing its popularity, name, duration, and year
SELECT popularity, track_name, duration_ms, year, COUNT(*) AS duplicate_count
FROM dbo.spotify_tracks
WHERE track_name = 'Love Yourself'
GROUP BY track_name, duration_ms, year, popularity
HAVING COUNT(*) > 1;

-- Analyze average popularity and features for the top 5 languages (excluding 'Unknown')
SELECT 
    language,
    AVG(popularity) AS avg_popularity, 
    AVG(CAST(duration_ms AS BIGINT)) AS avg_duration,  -- Cast duration_ms to BIGINT to avoid overflow
    AVG(CAST(loudness AS FLOAT)) AS avg_loudness,      -- Cast loudness to FLOAT if it's a numeric type
    AVG(CAST(tempo AS FLOAT)) AS avg_tempo,            -- Cast tempo to FLOAT
    AVG(CAST(instrumentalness AS FLOAT)) AS avg_instrumentalness  -- Cast instrumentalness to FLOAT
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')  -- Top 5 languages
GROUP BY language
ORDER BY avg_popularity DESC;

-- Descriptive statistics for each feature in the dataset (for top 5 languages)
SELECT 
    language,
    AVG(CAST(popularity AS FLOAT)) AS avg_popularity,  -- Cast popularity to FLOAT to avoid overflow
    MIN(popularity) AS min_popularity,
    MAX(popularity) AS max_popularity,
    STDEV(CAST(popularity AS FLOAT)) AS stdev_popularity, -- Standard deviation of popularity
    AVG(CAST(duration_ms AS BIGINT)) AS avg_duration,  -- Cast duration_ms to BIGINT to avoid overflow
    MIN(duration_ms) AS min_duration,
    MAX(duration_ms) AS max_duration,
    STDEV(CAST(duration_ms AS BIGINT)) AS stdev_duration -- Standard deviation of duration_ms
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')  -- Filter for top 5 languages
GROUP BY language
ORDER BY avg_popularity DESC;

-- Count distinct values for artist_name, album_name, and track_name in each language
SELECT 
    language,
    COUNT(DISTINCT artist_name) AS distinct_artists,
    COUNT(DISTINCT album_name) AS distinct_albums,
    COUNT(DISTINCT track_name) AS distinct_tracks
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')
GROUP BY language
ORDER BY distinct_artists DESC;

-- Get the distribution of popularity in each language
SELECT 
    language,
    COUNT(*) AS track_count,
    MIN(popularity) AS min_popularity,
    MAX(popularity) AS max_popularity,
    AVG(popularity) AS avg_popularity
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')
GROUP BY language
ORDER BY avg_popularity DESC;

-- Get the average popularity per year for the top 5 languages
SELECT 
    language,
    year,
    AVG(popularity) AS avg_popularity
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')
GROUP BY language, year
ORDER BY year DESC;

-- Check for missing values in each column of the table
SELECT 
    COLUMN_NAME, 
    COUNT(*) - COUNT(COLUMN_NAME) AS null_count
FROM INFORMATION_SCHEMA.COLUMNS
CROSS JOIN dbo.spotify_tracks
GROUP BY COLUMN_NAME;

-- Get the top 10 tracks based on popularity
SELECT TOP 10 
    track_name, popularity
FROM dbo.spotify_tracks
ORDER BY popularity DESC;

-- Count distinct values for artists and albums by language
SELECT 
    language,
    COUNT(DISTINCT artist_name) AS distinct_artists,
    COUNT(DISTINCT album_name) AS distinct_albums
FROM dbo.spotify_tracks
GROUP BY language;

-- Calculate the average track duration for each year
SELECT 
    year,
    AVG(duration_ms) AS avg_duration
FROM dbo.spotify_tracks
GROUP BY year
ORDER BY year DESC;

-- Identify tracks with high instrumentalness and calculate their average duration
SELECT 
    track_name,
    AVG(instrumentalness) AS avg_instrumentalness,
    AVG(duration_ms) AS avg_duration
FROM dbo.spotify_tracks
GROUP BY track_name
HAVING AVG(instrumentalness) > 0.5
ORDER BY avg_instrumentalness DESC;

-- Count the number of tracks in each album
SELECT 
    album_name,
    COUNT(*) AS track_count
FROM dbo.spotify_tracks
GROUP BY album_name
ORDER BY track_count DESC;

