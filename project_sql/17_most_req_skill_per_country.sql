/* 
Question 12: Find the top skill required in each country 
- Use ROW_NUMBER() over partition by country
- Why? It reveals the most in-demand skill per country
*/
WITH skill_counts AS (
    SELECT
        s.skills,
        j.job_country,
        COUNT(s.skills) AS most_requested_skill
    FROM skills_dim s
    INNER JOIN skills_job_dim sj ON s.skill_id = sj.skill_id
    INNER JOIN job_postings_fact j ON j.job_id = sj.job_id
    WHERE j.job_title_short = 'Data Analyst'
    GROUP BY s.skills, j.job_country
)
SELECT
    skills,
    job_country,
    most_requested_skill,
    ROW_NUMBER() OVER(
        PARTITION BY job_country 
        ORDER BY most_requested_skill DESC
    ) AS rn
FROM skill_counts;
