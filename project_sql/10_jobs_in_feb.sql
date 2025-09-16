/* 
Question 5: Which countries posted jobs in February 2023? 
- Use the february_jobs table
- Why? It shows where opportunities opened during that month
*/
SELECT DISTINCT
    job_country
FROM 
    february_jobs
WHERE
    job_country IS NOT NULL
