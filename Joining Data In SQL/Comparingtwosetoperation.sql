#1 
```bash
-- Query that determines all pairs of code and year from economies and populations, without duplicates
SELECT country_code, year
FROM populations
UNION 
SELECT code, year
FROM economies;
```

#2
```bash
SELECT code, year
FROM economies
-- Set theory clause
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;
```
