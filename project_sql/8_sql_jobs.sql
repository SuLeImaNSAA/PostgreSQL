/* 
Question 3: Which jobs require SQL skills? 
- Focus on roles where SQL appears in the skills list
- Why? SQL is a core requirement for most data roles
*/
WITH sql_jobs AS (
    SELECT skills_job_dim.job_id, skills_dim.skills
    FROM skills_dim
    INNER JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
)

SELECT DISTINCT
    job_postings_fact.job_title_short
FROM 
    job_postings_fact
INNER JOIN sql_jobs 
    ON job_postings_fact.job_id = sql_jobs.job_id
WHERE LOWER(sql_jobs.skills) = 'sql';
