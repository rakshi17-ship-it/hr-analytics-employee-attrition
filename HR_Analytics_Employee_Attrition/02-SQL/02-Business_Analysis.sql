 SELECT * FROM hr_employee_cleaned; 

-- =====================================================
-- Q1. OVERALL EMPLOYEE ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- What is the total number of employees, how many
-- have left the company, and what is the attrition rate?
-- =====================================================

SELECT
    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM hr_employee_cleaned; 

-----Business interpretation
-----16.12% of the employees in this dataset have left the company, while 83.88% have stayed.
--------------------------------------------------------------------------------------------------
-- =====================================================
-- Q2. DEPARTMENT-WISE ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- Which department has the highest employee attrition
-- rate, and how many employees have left each department?
-- =====================================================
SELECT
    department,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM hr_employee_cleaned

GROUP BY department

ORDER BY attrition_rate DESC;

---Business interpretation
----Sales has the highest attrition rate.
----Human Resources has the second-highest rate.
----Research & Development has the lowest rate.
----------------------------------------------------------------------
-- =====================================================
-- Q3. JOB ROLE-WISE ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- Which job roles have the highest attrition rate?
-- PURPOSE:
-- Identify job roles that may require better employee
-- retention strategies.
-- =====================================================

SELECT
    jobrole,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM hr_employee_cleaned

GROUP BY jobrole

ORDER BY attrition_rate DESC;

---Business interpretation
------Three interesting findings:
---1. Sales Representatives have the highest attrition rate at 39.76%.
---2. Laboratory Technicians have the second-highest rate at 23.94%.
---3. Research Directors have the lowest rate at 2.50%.
---------------------------------------------------------------------------------

-- =====================================================
-- Q4. AGE GROUP-WISE ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- Which age group has the highest employee attrition?
-- PURPOSE:
-- Understand employee attrition patterns across
-- different age groups.
-- =====================================================

WITH age_analysis AS (
    SELECT
        CASE
            WHEN age BETWEEN 18 AND 24 THEN '18-24'
            WHEN age BETWEEN 25 AND 34 THEN '25-34'
            WHEN age BETWEEN 35 AND 44 THEN '35-44'
            WHEN age BETWEEN 45 AND 54 THEN '45-54'
            ELSE '55+'
        END AS age_group,

        attrition

    FROM hr_employee_cleaned
)

SELECT
    age_group,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM age_analysis

GROUP BY age_group

ORDER BY
    CASE age_group
        WHEN '18-24' THEN 1
        WHEN '25-34' THEN 2
        WHEN '35-44' THEN 3
        WHEN '45-54' THEN 4
        ELSE 5
    END;

---Business interpretation
-----Three interesting findings:
---1. Employees aged 18–24 have the highest attrition rate (39.18%).
---2. Employees aged 35–44 have the lowest attrition rate (10.10%).
---3. Attrition is considerably higher among younger employees in this dataset.
----------------------------------------------------------------------------------------------------

-- =====================================================
-- Q5. MONTHLY INCOME AND ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- Which salary group has the highest employee attrition?
-- PURPOSE:
-- Analyze the relationship between monthly income
-- and employee retention.
-- =====================================================


WITH salary_analysis AS (
    SELECT
        CASE
            WHEN monthlyincome <= 3000 THEN 'Below 3,000'
            WHEN monthlyincome <= 6000 THEN '3,001-6,000'
            WHEN monthlyincome <= 10000 THEN '6,001-10,000'
            ELSE 'Above 10,000'
        END AS salary_group,

        attrition

    FROM hr_employee_cleaned
)

SELECT
    salary_group,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM salary_analysis

GROUP BY salary_group

ORDER BY
    CASE salary_group
        WHEN 'Below 3,000' THEN 1
        WHEN '3,001-6,000' THEN 2
        WHEN '6,001-10,000' THEN 3
        ELSE 4
    END;

---Business interpretation
----Three important observations:
---1. Employees earning below 3,000 have the highest attrition rate (28.61%).
---2. Employees earning above 10,000 have the lowest attrition rate (8.90%).
---3. Attrition rates generally decrease as salary groups increase.
-----------------------------------------------------------------------------------------

-- =====================================================
-- Q6. OVERTIME AND EMPLOYEE ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- Do employees working overtime have a higher
-- attrition rate than employees not working overtime?
-- PURPOSE:
-- Analyze the relationship between overtime and
-- employee retention.
-- =====================================================

SELECT
    overtime,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM hr_employee_cleaned

GROUP BY overtime

ORDER BY attrition_rate DESC;

---Business interpretation
---Three important findings:
----1. Employees working overtime have a 30.53% attrition rate.
---2. Employees not working overtime have a 10.44% attrition rate.
----3. The overtime group has approximately 2.92 times the attrition rate of the non-overtime group.
------------------------------------------------------------------------------------------------------------

-- =====================================================
-- Q7. JOB SATISFACTION AND ATTRITION ANALYSIS
-- BUSINESS QUESTION:
-- How does employee job satisfaction relate to
-- employee attrition?
-- PURPOSE:
-- Identify whether employees with lower satisfaction
-- ratings experience higher attrition rates.
-- =====================================================

SELECT
    jobsatisfaction,

    COUNT(*) AS total_employees,

    SUM(CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,

    SUM(CASE
        WHEN attrition = 'No' THEN 1
        ELSE 0
    END) AS employees_stayed,

    ROUND(
        100.0 * SUM(CASE
            WHEN attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*), 2
    ) AS attrition_rate

FROM hr_employee_cleaned

GROUP BY jobsatisfaction

ORDER BY attrition_rate DESC;

------Business interpretation
------1. Employees with satisfaction rating 1 have the highest attrition rate (22.84%).
-----2. Employees with rating 4 have the lowest attrition rate (11.33%).
-----3. Lower satisfaction is associated with higher employee attrition in this dataset.
------------------------------------------------------------------------------------------------

-- =====================================================
-- Q8: WORK-LIFE BALANCE AND EMPLOYEE ATTRITION
-- BUSINESS QUESTION:
-- Does work-life balance have a relationship with
-- employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across different
-- work-life balance ratings.
-- =====================================================

SELECT
    worklifebalance,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employee_cleaned
GROUP BY worklifebalance
ORDER BY worklifebalance;

---Step 4: Business insight
---- Employees with a rating of 1 (Bad) have the highest attrition rate: 31.25%.
---- Employees with a rating of 3 (Better) have the lowest attrition rate: 14.22%.
---- The rating of 4 does not have the lowest attrition rate, so the relationship is not perfectly linear.
---------------------------------------------------------------------------------------------------------------

-- =====================================================
-- Q9: YEARS AT COMPANY AND EMPLOYEE ATTRITION
-- BUSINESS QUESTION:
-- Does employee tenure have a relationship with
-- employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across different
-- employee tenure groups.
-- =====================================================

WITH tenure_analysis AS (
    SELECT
        CASE
            WHEN yearsatcompany BETWEEN 0 AND 2 THEN '0-2 Years'
            WHEN yearsatcompany BETWEEN 3 AND 5 THEN '3-5 Years'
            WHEN yearsatcompany BETWEEN 6 AND 10 THEN '6-10 Years'
            WHEN yearsatcompany BETWEEN 11 AND 20 THEN '11-20 Years'
            ELSE 'Above 20 Years'
        END AS tenure_group,
        attrition
    FROM hr_employee_cleaned
)

SELECT
    tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM tenure_analysis
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-2 Years' THEN 1
        WHEN '3-5 Years' THEN 2
        WHEN '6-10 Years' THEN 3
        WHEN '11-20 Years' THEN 4
        ELSE 5
    END;

--Business interpretation :
---Look for the tenure group with the highest attrition rate. 
--This can help an HR team investigate whether employee retention needs more attention
--during the early years of employment.
-------------------------------------------------------------------------------------------------
-- =====================================================
-- Q10: YEARS IN CURRENT ROLE AND EMPLOYEE ATTRITION
-- BUSINESS QUESTION:
-- Does the number of years spent in the current role
-- have a relationship with employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across different
-- current-role experience groups.
-- =====================================================

WITH role_tenure_analysis AS (
    SELECT
        CASE
            WHEN yearsincurrentrole BETWEEN 0 AND 2 THEN '0-2 Years'
            WHEN yearsincurrentrole BETWEEN 3 AND 5 THEN '3-5 Years'
            WHEN yearsincurrentrole BETWEEN 6 AND 10 THEN '6-10 Years'
            ELSE 'Above 10 Years'
        END AS role_tenure_group,
        attrition
    FROM hr_employee_cleaned
)

SELECT
    role_tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM role_tenure_analysis
GROUP BY role_tenure_group
ORDER BY
    CASE role_tenure_group
        WHEN '0-2 Years' THEN 1
        WHEN '3-5 Years' THEN 2
        WHEN '6-10 Years' THEN 3
        ELSE 4
    END;

---Business Interpretation:
---Employees with fewer years in their current role may have a higher attrition rate.
---HR should focus on career development, role satisfaction and employee support to improve retention.
--------------------------------------------------------------------------------------------------------------------

-- =====================================================
-- Q11: YEARS SINCE LAST PROMOTION AND ATTRITION
-- BUSINESS QUESTION:
-- Does the time since an employee's last promotion
-- have a relationship with employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across promotion periods.
-- =====================================================

WITH promotion_analysis AS (
    SELECT
        CASE
            WHEN yearssincelastpromotion BETWEEN 0 AND 1 THEN '0-1 Years'
            WHEN yearssincelastpromotion BETWEEN 2 AND 3 THEN '2-3 Years'
            WHEN yearssincelastpromotion BETWEEN 4 AND 5 THEN '4-5 Years'
            ELSE 'Above 5 Years'
        END AS promotion_group,
        attrition
    FROM hr_employee_cleaned
)

SELECT
    promotion_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM promotion_analysis
GROUP BY promotion_group
ORDER BY
    CASE promotion_group
        WHEN '0-1 Years' THEN 1
        WHEN '2-3 Years' THEN 2
        WHEN '4-5 Years' THEN 3
        ELSE 4
    END;

---Business Interpretation: 
--Employees who have not received promotions for a longer period may experience limited career growth, 
---which could be associated with higher attrition.
-------------------------------------------------------------------------------------------------------------

-- =====================================================
-- Q12: BUSINESS TRAVEL AND EMPLOYEE ATTRITION
-- BUSINESS QUESTION:
-- Does business travel frequency have a relationship
-- with employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across business travel
-- categories.
-- =====================================================

SELECT
    businesstravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employee_cleaned
GROUP BY businesstravel
ORDER BY attrition_rate DESC;

--Business Interpretation :
---Employees who travel frequently have the highest attrition rate (24.91%),
---while non-travelling employees have the lowest (8%).
---Frequent business travel may be associated with higher employee attrition.
--------------------------------------------------------------------------------------------

-- =====================================================
-- Q13: DISTANCE FROM HOME AND EMPLOYEE ATTRITION
-- BUSINESS QUESTION:
-- Does commuting distance have a relationship with
-- employee attrition?
--
-- PURPOSE:
-- Compare attrition rates across different
-- home-to-work distance groups.
-- =====================================================

WITH distance_analysis AS (
    SELECT
        CASE
            WHEN distancefromhome BETWEEN 1 AND 5 THEN '1-5 KM'
            WHEN distancefromhome BETWEEN 6 AND 10 THEN '6-10 KM'
            WHEN distancefromhome BETWEEN 11 AND 20 THEN '11-20 KM'
            ELSE 'Above 20 KM'
        END AS distance_group,
        attrition
    FROM hr_employee_cleaned
)

SELECT
    distance_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM distance_analysis
GROUP BY distance_group
ORDER BY
    CASE distance_group
        WHEN '1-5 KM' THEN 1
        WHEN '6-10 KM' THEN 2
        WHEN '11-20 KM' THEN 3
        ELSE 4
    END;

--Business Interpretation :
---Employees living more than 20 km from work have the highest attrition rate (22.06%),
---while those living within 1–5 km have the lowest (13.77%).
----Longer commuting distances may be associated with higher employee attrition.

-- =====================================================
-- Q14: MARITAL STATUS, EDUCATION AND ATTRITION
-- BUSINESS QUESTION:
-- How do marital status and education level relate
-- to employee attrition?
--
-- PURPOSE:
-- Compare employee attrition across marital status
-- and education categories.
-- =====================================================

SELECT
    maritalstatus,
    education,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed,
    ROUND(
        100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS attrition_rate
FROM hr_employee_cleaned
GROUP BY maritalstatus, education
ORDER BY maritalstatus, education;

--Business Interpretation:
--Single employees show higher attrition rates across most education levels, 
--while married employees generally have lower attrition. This suggests marital status may be associated with employee attrition. 
--Education level does not show a consistent pattern


-- =====================================================
-- Q15: OVERALL EMPLOYEE ATTRITION SUMMARY
-- BUSINESS QUESTION:
-- How do employees who left differ from those
-- who stayed in the company?
--
-- PURPOSE:
-- Compare employee count, age, salary, experience
-- and distance from home based on attrition.
-- =====================================================

SELECT
    attrition,
    COUNT(*) AS total_employees,
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(monthlyincome), 2) AS average_monthly_income,
    ROUND(AVG(yearsatcompany), 2) AS average_years_at_company,
    ROUND(AVG(yearsincurrentrole), 2) AS average_years_in_current_role,
    ROUND(AVG(distancefromhome), 2) AS average_distance_from_home
FROM hr_employee_cleaned
GROUP BY attrition
ORDER BY attrition;

--Business Interpretation :
--Employees who left the company were younger (33.61 years), 
--earned a lower average monthly salary (4,787.09),
--and had fewer years of company experience (5.13 years) than employees who stayed.
--They also had a longer average distance from home (10.63 km).

------------------------------------------------------------------------------------------

-- =====================================================
-- PROJECT CONCLUSION
--
-- The analysis identified an overall employee attrition
-- rate of 16.12%.
--
-- Sales Representatives showed the highest job-role
-- attrition rate (39.76%).
--
-- Employees working overtime and those travelling
-- frequently showed higher attrition rates.
--
-- Employees who left had lower average monthly income
-- and fewer years of company experience.
--
-- RECOMMENDATIONS:
-- 1. Improve employee retention strategies.
-- 2. Review overtime and workload distribution.
-- 3. Provide better career growth opportunities.
-- 4. Focus on high-attrition job roles.
-- 5. Improve employee satisfaction and support.
--
-- =====================================================
-- END OF BUSINESS ANALYSIS
-- =====================================================



