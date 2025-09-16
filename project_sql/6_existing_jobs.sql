/* 
Question 1: How many job postings exist in each country? 
- Look at the distribution of job postings by job_country
- Why? This helps us see which regions are most active in hiring
*/
SELECT 
    job_country,
    COUNT(*) AS total_jobs
FROM job_postings_fact
WHERE job_country IS NOT NULL
GROUP BY job_country
ORDER BY total_jobs DESC;
