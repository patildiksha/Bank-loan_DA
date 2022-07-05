CREATE DATABASE excelr_project;
USE excelr_project;

SELECT * FROM finance_1;

SELECT count(*)FROM finance_2;

/*-------------------------------------------------------------------------------------------------------------------*/

#                                                        KPI'S


# 1 Year wise Loan amount stats

# Finance 1: issue_d & loan amount

SELECT YEAR(issue_d) as Year,SUM(loan_amnt) as Loan_Amount FROM finance_1
GROUP BY YEAR(issue_d)
ORDER BY YEAR(issue_d);

/*--------------------------------------------------------------------------------------------------------------------------*/

# 2 Grade and sub grade wise revol_bal

# Finance 1:grade & subgrade , Finance 2: Revol_bal

SELECT f1.grade as Grade,f1.sub_grade as Sub_Grade,SUM(f2.revol_bal) as Revol_Balance
FROM finance_1 f1
LEFT JOIN finance_2 f2 
ON f1.id = f2.id
GROUP BY f1.grade,f1.sub_grade
order by f1.grade,f1.sub_grade;

/*---------------------------------------------------------------------------------------------------------------------------------*/

# 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status

# Finance 1: verified status , Finance 2: Total Payment

SELECT f1.verification_status as Verification_Status,ROUND(SUM(f2.total_pymnt),1) AS Total_Payment
FROM finance_1 f1
LEFT JOIN finance_2 f2
ON f1.id = f2.id
WHERE f1.verification_status != 'Source Verified'
GROUP BY f1.verification_status
ORDER BY f1.verification_status;

/*-------------------------------------------------------------------------------------------------------------------------------------------*/

# 4. State wise and month wise loan status

SELECT f1.addr_state as State,MONTH(f2.last_credit_pull_d) AS Month,f1.loan_status as Loan_Status,COUNT(f2.last_credit_pull_d) as Count_Credit_Pull
FROM finance_1 f1
JOIN finance_2 f2
ON f1.id = f2.id
GROUP BY MONTH(f2.last_credit_pull_d),f1.loan_status,f1.addr_state
ORDER BY f1.addr_state,MONTH(f2.last_credit_pull_d),f1.loan_status;

/*--------------------------------------------------------------------------------------------------------------------------------------------*/

# 5. Home ownership v/s last payment date stats

SELECT YEAR(f2.last_pymnt_d) AS Year,f1.home_ownership as Home_Ownership,COUNT(YEAR(f2.last_pymnt_d)) AS Count_Last_Payment_d,ROUND(SUM(f2.last_pymnt_amnt),2) AS Payment_Amount
FROM finance_1 f1
JOIN finance_2 f2
ON f1.id = f2.id
GROUP BY f1.home_ownership,YEAR(f2.last_pymnt_d)
ORDER BY YEAR(f2.last_pymnt_d)desc;

























