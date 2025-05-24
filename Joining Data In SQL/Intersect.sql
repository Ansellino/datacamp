-- Return all cities with the same name as a country
SELECT c1.name
FROM cities AS c1
INTERSECT
SELECT c2.name
FROM countries AS c2;