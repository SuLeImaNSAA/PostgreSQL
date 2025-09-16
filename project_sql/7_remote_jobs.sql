/* 
Question 2: Find all job postings that are remote (work from home) 
- Use job_work_from_home column
- Why? Remote work opportunities are important for job seekers
*/
SELECT
    job_title_short,
    COUNT(*) AS remote_jobs_count
FROM job_postings_fact
WHERE job_work_from_home = TRUE
GROUP BY job_title_short
ORDER BY remote_jobs_count DESC;
