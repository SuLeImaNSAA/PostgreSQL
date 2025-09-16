/* 
Question 6: Find jobs posted in January but not in March 
- Use january_jobs and march_jobs tables
- Why? It highlights jobs that disappeared month to month
*/
SELECT DISTINCT
    january_jobs.job_country
FROM 
    january_jobs
LEFT JOIN march_jobs 
    ON january_jobs.job_id = march_jobs.job_id
WHERE
    march_jobs.job_id IS NULL  -- only jobs not in March
    AND january_jobs.job_country IS NOT NULL;
