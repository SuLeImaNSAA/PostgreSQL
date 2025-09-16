/* 
Question 11: Show average salary by skill for Data Analyst roles 
- Only consider postings with a salary
- Why? Helps identify the highest paying skills
*/
SELECT
    s.skills,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary
FROM skills_dim AS s
INNER JOIN skills_job_dim sj ON s.skill_id = sj.skill_id
INNER JOIN job_postings_fact j ON j.job_id = sj.job_id
WHERE 
    j.job_title_short = 'Data Analyst' AND
    j.salary_year_avg IS NOT NULL
GROUP BY s.skills
ORDER BY avg_salary DESC;
