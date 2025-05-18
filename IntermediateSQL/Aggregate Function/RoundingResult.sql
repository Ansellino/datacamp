-- Round duration_hours to two decimal places
SELECT title, ROUND(( duration / 60.0),2) AS duration_hours
FROM films;
