SELECT release_year, COUNT(DISTINCT language) AS total_language
FROM films
GROUP BY release_year
ORDER BY total_language DESC;