-- Select the title and duration from longest to shortest film
SELECT title, duration
FROM films
ORDER BY duration DESC;