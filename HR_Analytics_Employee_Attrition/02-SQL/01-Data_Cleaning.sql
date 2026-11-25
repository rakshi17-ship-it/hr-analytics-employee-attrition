CREATE TABLE hr_employee (
    Age INTEGER,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INTEGER,
    Department VARCHAR(100),
    DistanceFromHome INTEGER,
    Education INTEGER,
    EducationField VARCHAR(100),
    EmployeeCount INTEGER,
    EmployeeNumber INTEGER,
    EnvironmentSatisfaction INTEGER,
    Gender VARCHAR(20),
    HourlyRate INTEGER,
    JobInvolvement INTEGER,
    JobLevel INTEGER,
    JobRole VARCHAR(100),
    JobSatisfaction INTEGER,
    MaritalStatus VARCHAR(30),
    MonthlyIncome INTEGER,
    MonthlyRate INTEGER,
    NumCompaniesWorked INTEGER,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INTEGER,
    PerformanceRating INTEGER,
    RelationshipSatisfaction INTEGER,
    StandardHours INTEGER,
    StockOptionLevel INTEGER,
    TotalWorkingYears INTEGER,
    TrainingTimesLastYear INTEGER,
    WorkLifeBalance INTEGER,
    YearsAtCompany INTEGER,
    YearsInCurrentRole INTEGER,
    YearsSinceLastPromotion INTEGER,
    YearsWithCurrManager INTEGER
);


SELECT * FROM hr_employee

SELECT COUNT(*) FROM hr_employee


SELECT
    "employeenumber",
    COUNT(*) AS duplicate_count
FROM hr_employee
GROUP BY "employeenumber"
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) - COUNT(age) AS missing_age,
    COUNT(*) - COUNT(attrition) AS missing_attrition,
    COUNT(*) - COUNT(department) AS missing_department,
    COUNT(*) - COUNT(monthlyincome) AS missing_income,
    COUNT(*) - COUNT(jobrole) AS missing_jobrole,
    COUNT(*) - COUNT(overtime) AS missing_overtime
FROM hr_employee;

SELECT
    attrition,
    COUNT(*) AS employee_count
FROM hr_employee
GROUP BY attrition
ORDER BY employee_count DESC;

SELECT
    department,
    COUNT(*) AS total_employees
FROM hr_employee
GROUP BY department
ORDER BY total_employees DESC;

SELECT
    COUNT(DISTINCT employeecount) AS employee_count_values,
    COUNT(DISTINCT over18) AS over18_values,
    COUNT(DISTINCT standardhours) AS standard_hours_values
FROM hr_employee;

CREATE TABLE hr_employee_cleaned AS
SELECT *
FROM hr_employee
WHERE employeenumber IS NOT NULL;

SELECT * FROM  hr_employee_cleaned

SELECT COUNT(*) AS total_cleaned_employees
FROM hr_employee_cleaned;

SELECT DISTINCT department
FROM hr_employee_cleaned;

SELECT DISTINCT attrition
FROM hr_employee_cleaned;

SELECT DISTINCT overtime
FROM hr_employee_cleaned;

SELECT DISTINCT gender
FROM hr_employee_cleaned;

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    MIN(monthlyincome) AS min_income,
    MAX(monthlyincome) AS max_income,
    MIN(yearsatcompany) AS min_years,
    MAX(yearsatcompany) AS max_years
FROM hr_employee_cleaned;













































