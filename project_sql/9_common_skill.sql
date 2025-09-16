/* 
Question 4: What is the most common skill required for Data Analyst roles? 
- Only consider postings with job_title_short = 'Data Analyst'
- Why? It identifies the top in-demand skill for analysts
*/
WITH most_req AS (
    SELECT 
        skills_dim.skills,
        COUNT(*) AS most_requsted_skill
    FROM skills_dim
    INNER JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY skills_dim.skills
)
SELECT *
FROM most_req
ORDER BY most_requ DESC
LIMIT 1;
