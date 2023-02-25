
-- SELECTING AND COUNTING DATA
----------------------------------------------------------------------------------------------------------------------

-- Count the number of observations in the film_id column of the reviews table
select count(film_id) as count_film_id
from IntermediateSQL..reviews;

-- Count the number of records in the people table
select count(id) as count_records
from IntermediateSQL..people;

-- Count the number of birthdates in the people table
select count(birthdate) as count_birthdate
from IntermediateSQL..people;

-- Count the languages and countries represented in the films table
select count(language) as count_language, count(country) as count_country
from IntermediateSQL..films;

-- Return the unique countries from the films table
select distinct(country)
from IntermediateSQL..films;

-- Count the distinct countries from the films table
select count(distinct(country)) as count_distinct_countries
from IntermediateSQL..films;


-- FILTERING NUMBERS
----------------------------------------------------------------------------------------------------------------------

-- Select film_ids and imdb_score with an imdb_score over 7.0 from the reviews table
select film_id, imdb_score
from reviews
where imdb_score > 7;

-- Select the film_id and facebook_likes of the first ten records with less than 1000 likes from the reviews table.
select top 10 film_id, facebook_likes
from reviews
where facebook_likes < 1000;

-- Count the records with at least 100,000 votes from the reviews table
select count(num_votes) as films_over_100k_votes
from reviews
where num_votes >= 100000;

-- Count the Spanish-language films from the films table
select count(language) as count_spanish
from films
where language = 'Spanish';

-- Select the title and release_year for all German-language films released before 2000 from the films table
select title, release_year
from films
where language = 'German' and release_year < 2000;

-- Select all records for German-language films released after 2000 and before 2010 from the films table
select *
from films
where language = 'German' 
		and release_year > 2000
		and release_year < 2010;

-- Find the title and year of films from the year 1990 or 1999 from the films table
-- Add a filter to see only English or Spanish-language films
-- Filter films with more than $2,000,000 gross
select title, release_year
from films
where (release_year = 1990 or release_year = 1999)
	and (language = 'Spanish' or language = 'English')
	and (gross > 2000000);

-- Select the title and release_year for films released between 1990 and 2000 from the films table
-- Narrow down the query to films with budgets > $100 million
-- Restrict the query to only Spanish or French language films
select title, release_year
from films
where (release_year between 1990 and 2000)
	and (budget > 100000000)
	and (language = 'Spanish' or language = 'French');

-- Select the names that start with B fromt the people table
select name
from people
where name like 'B%';

-- Select the names that have r as the second letter from the people table
select name
from people
where name like '_r%';

-- Select names that don't start with A
select name
from people
where name not like 'A%';

-- Find the title and release_year for all films over two hours in length released in 1990 and 2000 in the films table
select title, release_year
from films
where duration > 120
	and release_year in(1990, 2000);

-- Find the title and language of all films in English, Spanish, and French in the films table
select title, language
from films
where language in('English', 'Spanish', 'French');

-- Find the title, certification, and language of all films certified NC-17 or R that are in English, Italian, or Greek in the films table
select title, certification, language
from films
where language in('English', 'Italian', 'Greek')
	and certification in('NC-17', 'R');

-- Count the unique titles from the films table
-- Filter to release_years to between 1990 and 1999
-- Filter to English-language films
-- Narrow it down to G, PG, and PG-13 certifications
select count(distinct(title)) as nineties_english_films_for_teens
from films
where release_year between 1990 and 1999
	and language = 'English'
	and certification in ('G', 'PG', 'PG-13');

-- List all film titles with missing budgets from the films table
select title as no_budget_info
from films
where budget is null;

-- Count the number of films we have language data for
select count(*) as count_language_known
from films
where language is not null; 


-- AGGREGATE FUNCTIONS
----------------------------------------------------------------------------------------------------------------------

-- Query the sum of film durations from the films table
select sum(duration) as total_duration
from films;

-- Calculate the average duration of all films from the films table
select avg(duration) as average_duration
from films;

-- Find the latest release_year from the films table
select max(release_year) as latest_year
from films;

-- Find the duration of the shortest film from the films table
select min(duration) as shortest_film
from films;

-- Calculate the sum of gross from the year 2000 or later from the films table
select sum(gross) as total_gross
from films
where release_year >= 2000;

-- Calculate the average gross of films that start with A from the films table
select avg(gross) as avg_gross_A
from films
where title like 'A%';

-- Calculate the lowest gross film in 1994 from the films table
select min(gross) as lowest_gross
from films
where release_year = 1994;

-- Calculate the highest gross film released between 2000-2012 from the films table
select max(gross) as highest_gross
from films
where release_year between 2000 and 2012;

-- Round the average number of facebook_likes to one decimal place from the reviews table
select round(avg(facebook_likes), 1) as avg_facebook_likes
from reviews;

-- Calculate the average budget rounded to the thousands from the films table
select round(avg(budget), -3) as avg_budget_thousands
from films;

-- Calculate the title and duration_hours from films
select title, duration/60 as duration_hours
from films;

-- Calculate the percentage of people who are no longer alive from the people table
select (count(deathdate)*100.00)/count(*) as percentage_dead
from people;

-- Find the number of decades in the films table
select (max(release_year) - min(release_year)) / 10 as number_of_decades
from films;

-- Select the title and round duration_hours to two decimal places from the films table
select title, round(duration/60.0, 2) as duration_hours
from films;


-- SORTING AND GROUPING
----------------------------------------------------------------------------------------------------------------------

-- Select name from people and sort alphabetically
select name
from people 
order by name;

-- Select the title and duration from longest to shortest film from the films table
select title, duration
from films
order by duration desc;

-- Select the release year, duration, and title sorted by release year and duration from the films table
select release_year, duration, title
from films
order by release_year, duration;

-- Select the certification, release year, and title sorted by certification and release year
select certification, release_year, title
from films
order by certification, release_year;

-- Find the release_year and film_count of each year from the films table
select release_year, count(title) as film_count
from films
group by release_year;

-- Find the release_year and average duration of films for each year from the films table
select release_year, avg(duration) as avg_duration
from films
group by release_year;

-- Find the release_year, country, and max_budget, then group and order by release_year and country
select release_year, country, max(budget) as max_budget
from films
group by release_year, country
order by release_year, country;

-- Which release_year had the most language diversity?
select release_year, count(distinct(language)) as lang
from films 
group by release_year
order by lang desc;

-- Select the country and distinct count of certification as certification_count from the films table
-- Group by country
-- Filter results to countries with more than 10 different certifications
select country, count(distinct(certification)) as certification_count
from films 
group by country
having count(distinct(certification)) > 10;

-- Select the country and average_budget from films
-- Group by country
-- Filter to countries with an average_budget of more than one billion
-- Order by descending order of the aggregated budget
select country, avg(budget) as average_budget
from films 
group by country
having avg(budget) > 1000000000
order by average_budget desc;

-- Select the average budget for films released after 1990 grouped by year
select release_year, avg(budget) as avg_budget
from films 
group by release_year
having release_year > 1990
order by release_year desc

-- Select release year, average budget, and average gross from films and group by release year
-- Limit results to films released after the year 1990
-- limit results to films with an average budget of more than 60 million
-- Order the results from the highest average gross and limit to one.
SELECT top 1 release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
order by avg_gross desc 
