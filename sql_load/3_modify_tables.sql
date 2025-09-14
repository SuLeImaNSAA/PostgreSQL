-- SELECT * FROM job_postings_fact LIMIT 200;
-- -- Problem 1
-- SELECT 
--     AVG(salary_year_avg) AS avg_year_salary,
--     AVG(salary_hour_avg) AS avg_hour_salary,
--     EXTRACT(MONTH FROM job_posted_date) AS month,
--     EXTRACT(YEAR FROM job_posted_date) AS year,
--     EXTRACT(DAY FROM job_posted_date) AS day
-- FROM 
--     job_postings_fact
-- GROUP BY 
--     EXTRACT(MONTH FROM job_posted_date),
--     EXTRACT(YEAR FROM job_posted_date),
--     EXTRACT(DAY FROM job_posted_date)
-- HAVING 
--     EXTRACT(MONTH FROM job_posted_date) > 6 
--     AND EXTRACT(DAY FROM job_posted_date) > 1;
-- -- Problem 2
-- SELECT 
--     MIN(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS first_posted_ny,
--     EXTRACT(MONTH FROM job_posted_date) AS month,
--     EXTRACT(YEAR FROM job_posted_date) AS year,
--     COUNT(job_title_short) AS job_count
-- FROM job_postings_fact
-- GROUP BY
--     EXTRACT(MONTH FROM job_posted_date),
--     EXTRACT(YEAR FROM job_posted_date)
-- ORDER BY
--     year, month;
-- -- Problem 3
-- SELECT 
--     job_title_short,
--     job_posted_date,
--     job_via
-- FROM job_postings_fact
-- WHERE EXTRACT(YEAR FROM job_posted_date) = 2023
--   AND EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6;

-- -- January jobs
-- CREATE TABLE january_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- -- February jobs
-- CREATE TABLE february_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- -- March jobs
-- CREATE TABLE march_jobs AS
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- SELECT *
-- FROM march_jobs;

-- SELECT 
--     COUNT(job_id) AS number_of_jobs,
--     CASE
--         WHEN job_location='Anywhere' THEN 'Remote'
--         WHEN job_location='New York, NY' THEN 'Local'
--         ELSE 'Onsite'
--     END AS location_category
-- FROM job_postings_fact
-- WHERE
--     job_title_short='Data Analyst'
-- GROUP BY 
--     location_category;

-- -- Categorize Data Analyst salaries into buckets
-- SELECT 
--     job_id,
--     job_title_short,
--     salary_year_avg,
--     CASE
--         WHEN salary_year_avg < 60000 THEN 'Low'
--         WHEN salary_year_avg BETWEEN 60000 AND 120000 THEN 'Standard'
--         ELSE 'High'
--     END AS salary_category
-- FROM job_postings_fact
-- WHERE job_title_short = 'Data Analyst'
--   AND salary_year_avg IS NOT NULL
-- ORDER BY salary_year_avg DESC;


-- SELECT 
--     MIN(salary_year_avg) AS min_salary,
--     MAX(salary_year_avg) AS max_salary,
--     ROUND(AVG(salary_year_avg), 0) AS avg_salary
-- FROM job_postings_fact
-- WHERE job_title_short = 'Data Analyst'
--   AND salary_year_avg IS NOT NULL;

-- Count Data Analyst jobs by salary category
-- SELECT 
--     CASE
--         WHEN salary_year_avg < 60000 THEN 'Low'
--         WHEN salary_year_avg BETWEEN 60000 AND 120000 THEN 'Standard'
--         ELSE 'High'
--     END AS salary_category,
--     COUNT(*) AS number_of_jobs,
--     ROUND(AVG(salary_year_avg), 0) AS avg_salary
-- FROM job_postings_fact
-- WHERE job_title_short = 'Data Analyst'
--   AND salary_year_avg IS NOT NULL
-- GROUP BY salary_category
-- ORDER BY avg_salary;


-- SELECT 
--     AVG(salary_year_avg)::INTEGER,
--     job_title_short
-- FROM job_postings_fact
-- WHERE
--     job_title_short LIKE '%Data Analyst%'
-- GROUP BY job_title_short;

-- SELECT *
-- FROM (
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date)=1
-- )AS january_jobs;

-- SELECT job_title_short, COUNT(*)
-- FROM (
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- ) AS january_jobs
-- GROUP BY job_title_short;
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- GROUP BY job_title_short;

-- WITH january_jobs AS (
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) =1
-- )

-- SELECT *
-- FROM january_jobs;

-- SELECT company_id,
-- name AS company_name
-- FROM company_dim
-- WHERE company_id IN (
--     SELECT
--             company_id
--     FROM 
--             job_postings_fact
--     WHERE
--             job_no_degree_mention=true
--     ORDER BY company_id
-- )

-- WITH company_job_count AS(
--     SELECT 
--             company_id,
--             COUNT(*) AS total_jobs
--     FROM
--             job_postings_fact
--     GROUP BY
--             company_id
-- )

-- SELECT 
--     company_dim.name AS company_name,
--     company_job_count.total_jobs
-- FROM company_dim
-- LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
-- ORDER BY 
--         total_jobs DESC

-- SELECT * FROM skills_dim
-- SELECT * FROM skills_job_dim LIMIT 100
-- SELECT * FROM job_postings_fact LIMIT 100
-- SELECT job_title_short
-- FROM job_postings_fact
-- WHERE job_location='Lebanon'

-- SELECT company_id,
-- name AS company_name
-- FROM company_dim
-- WHERE company_id IN (
--     SELECT
--             company_id
--     FROM 
--             job_postings_fact
--     WHERE
--             job_no_degree_mention=true
--     ORDER BY company_id
-- )
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/
WITH remote_job_skills AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id=skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home=TRUE AND
        job_postings.job_title_short='Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id=remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

SELECT * FROM job_postings_fact LIMIT 100 
SELECT * FROM skills_job_dim LIMIT 100 
SELECT * FROM skills_dim LIMIT 100
-- SELECT job_title_short, COUNT(*)
-- FROM (
--     SELECT *
--     FROM job_postings_fact
--     WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- ) AS january_jobs
-- GROUP BY job_title_short;
-- SELECT *
-- FROM job_postings_fact
-- WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- GROUP BY job_title_short;
SELECT * FROM(
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) AS skills_count
SELECT skills FROM skills_dim 
INNER JOIN skills_count ON skills.skill_id=skills_count.skill_id
ORDER BY skill_count DESC
LIMIT 5

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    skills_count.skill_count
FROM (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
) AS skills_count
INNER JOIN skills_dim 
    ON skills_dim.skill_id = skills_count.skill_id
ORDER BY skills_count.skill_count DESC
LIMIT 5;

WITH number_of_jobs_per_company AS (
    SELECT 
        COUNT(*) AS number_jobs,
        company_id 
    FROM job_postings_fact 
    GROUP BY company_id
)
SELECT 
    number_jobs,
    CASE
        WHEN number_jobs < 10 THEN 'Small'
        WHEN number_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS category
FROM number_of_jobs_per_company;

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs
UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

/*
Find job postings from the first quarter that have a salary greater than $70k
- Combine job posting tables from the first quarter of 2023(Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::date,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC

-- #########################################
SELECT * FROM skills_dim LIMIT 100
SELECT * FROM skills_job_dim LIMIT 100
WITH quarter1_job_postings AS(
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
WITH skills AS(
    SELECT * 
    FROM skills_dim
    LEFT JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id LIMIT 50
)
SELECT 
    quarter1_job_postings.job_posted_date::date,
    quarter1_job_postings.salary_year_avg,
    skills.skills,
    skills.type
FROM skills_dim
LEFT JOIN quarter1_job_postings ON quarter1_job_postings.job_id=skills.job_id
WHERE 
    quarter1_job_postings.salary_year_avg > 70000

WITH quarter1_job_postings AS (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
),
skills AS (
    SELECT sd.skill_id, sd.skills, sd.type, sjd.job_id
    FROM skills_dim sd
    LEFT JOIN skills_job_dim sjd 
        ON sd.skill_id = sjd.skill_id
)
SELECT 
    q.job_posted_date::date,
    q.salary_year_avg,
    s.skills,
    s.type
FROM quarter1_job_postings q
LEFT JOIN skills s 
    ON q.job_id = s.job_id
WHERE q.salary_year_avg > 70000;
