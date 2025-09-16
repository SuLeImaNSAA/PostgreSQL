/* 
Question 10: Which skills are mentioned across the most job postings overall? 
- Count distinct jobs per skill
- Why? Shows which skills are most versatile across roles
*/
WITH most_req AS (
    SELECT
        s.skills,
        COUNT(DISTINCT j.job_id) AS most_requested_skill
    FROM skills_dim s
    INNER JOIN skills_job_dim sj ON s.skill_id = sj.skill_id
    INNER JOIN job_postings_fact j ON j.job_id = sj.job_id
    WHERE j.job_title_short = 'Data Analyst'
    GROUP BY s.skills
)
SELECT *
FROM most_req
ORDER BY most_requested_skill DESC
