/* 
Question 9: What are the top 5 countries with the most job postings? 
- Use a CTE to calculate total jobs per country
- Why? It highlights the global hotspots for hiring
*/
WITH most_countries_with_job_postings AS(
    SELECT
        job_location,
        COUNT(*) AS number_of_jobs
    FROM job_postings_fact
    WHERE job_location IS NOT NULL AND
    NOT job_location = 'Anywhere'
    GROUP BY job_location

)
SELECT 
    * 
FROM 
    most_countries_with_job_postings 
ORDER BY 
    number_of_jobs DESC 
LIMIT 5