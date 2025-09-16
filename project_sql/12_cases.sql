/* 
Question 7: Classify jobs into 'Senior', 'Analyst', or 'Other' based on title
- Use CASE to categorize by job_title_short
- Why? It helps segment the roles by seniority level
*/
SELECT 
    job_title_short,
CASE
    WHEN job_title_short LIKE '%Senior%' THEN 'Senior'    
    WHEN job_title_short LIKE '%Analyst%' THEN 'Analyst' 
    ELSE 'Other'
    END AS job_category
FROM job_postings_fact   