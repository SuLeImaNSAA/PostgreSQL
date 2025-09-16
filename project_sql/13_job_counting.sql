/* 
Question 8: Count the number of job postings for each job_schedule_type
- Use GROUP BY job_schedule_type
- Why? This helps us compare full-time, part-time, and contractor roles
*/
SELECT
    COUNT(*) AS job_postings,
    job_schedule_type
FROM job_postings_fact
GROUP BY
    job_schedule_type