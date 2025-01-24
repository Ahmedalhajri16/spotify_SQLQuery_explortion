# **Spotify Tracks Analysis**

## **Introduction**
This project demonstrates an extensive analysis of the Spotify Tracks dataset using SQL. The queries focus on uncovering trends, insights, and patterns in music data, such as track popularity, artist contributions, language distributions, and audio features. The dataset includes details about tracks, artists, albums, popularity scores, languages, and more.

This repository contains SQL scripts for extracting meaningful insights and performing data analysis tasks on the Spotify Tracks dataset.

---

## **Dataset Overview**
The dataset contains information about Spotify tracks, including:
- 🎵 **Track Name**
- 🎤 **Artist Name**
- 💿 **Album Name**
- 🌐 **Language**
- ⭐ **Popularity**
- ⏳ **Duration (ms)**
- 📅 **Year**
- 🎼 **Audio Features** (e.g., tempo, loudness, instrumentalness)

---

## **Queries and Insights**

### **1. Schema Exploration**
```sql
-- Get column names for the 'spotify_tracks' table
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'spotify_tracks';

-- Check for missing values in each column of the table
SELECT 
    COLUMN_NAME, 
    COUNT(*) - COUNT(COLUMN_NAME) AS null_count
FROM INFORMATION_SCHEMA.COLUMNS
CROSS JOIN dbo.spotify_tracks
GROUP BY COLUMN_NAME;
```

### **2. Track and Artist Analysis**
```sql
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
```

### **3. Duplicate Analysis**
```sql
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
```

### **4. Language-Based Insights**
```sql
-- Analyze average popularity and features for the top 5 languages (excluding 'Unknown')
SELECT 
    language,
    AVG(popularity) AS avg_popularity, 
    AVG(CAST(duration_ms AS BIGINT)) AS avg_duration,
    AVG(CAST(loudness AS FLOAT)) AS avg_loudness,
    AVG(CAST(tempo AS FLOAT)) AS avg_tempo,
    AVG(CAST(instrumentalness AS FLOAT)) AS avg_instrumentalness
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')
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
```

### **5. Yearly Trends**
```sql
-- Calculate the average track duration for each year
SELECT 
    year,
    AVG(duration_ms) AS avg_duration
FROM dbo.spotify_tracks
GROUP BY year
ORDER BY year DESC;

-- Get the average popularity per year for the top 5 languages
SELECT 
    language,
    year,
    AVG(popularity) AS avg_popularity
FROM dbo.spotify_tracks
WHERE language IN ('English', 'Tamil', 'Korean', 'Hindi', 'Telugu')
GROUP BY language, year
ORDER BY year DESC;
```

### **6. Audio Feature Analysis**
```sql
-- Identify tracks with high instrumentalness and calculate their average duration
SELECT 
    track_name,
    AVG(instrumentalness) AS avg_instrumentalness,
    AVG(duration_ms) AS avg_duration
FROM dbo.spotify_tracks
GROUP BY track_name
HAVING AVG(instrumentalness) > 0.5
ORDER BY avg_instrumentalness DESC;
```

### **7. Album Insights**
```sql
-- Count the number of tracks in each album
SELECT 
    album_name,
    COUNT(*) AS track_count
FROM dbo.spotify_tracks
GROUP BY album_name
ORDER BY track_count DESC;
```

### **8. Top Tracks**
```sql
-- Get the top 10 tracks based on popularity
SELECT TOP 10 
    track_name, popularity
FROM dbo.spotify_tracks
ORDER BY popularity DESC;
```

---

## **Key Highlights**
1. **Language Trends**: Analyzes the dominance of English, Tamil, Korean, Hindi, and Telugu in the dataset.
2. **Artist Contributions**: Identifies top artists with the most tracks and their popularity scores.
3. **Duplicate Handling**: Highlights duplicate tracks and variations in their features.
4. **Audio Features**: Focuses on tracks with high instrumentalness and evaluates their durations.
5. **Yearly Trends**: Tracks changes in popularity and duration trends over time.

---



## **Future Work**
- Expand analysis to include additional audio features like danceability, energy, and key.
- Explore time series analysis of popularity trends.
- Build a visualization dashboard to complement the SQL queries.

