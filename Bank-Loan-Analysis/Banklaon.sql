/*BANK LOAN REPORT QUERY DOCUMENT*/

-- BANK LOAN REPORT | SUMMARY
-- KPI’s:--

-- Total Loan Applications
-- This query calculates the total number of loan applications.
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;

-- MTD Loan Applications
-- This query calculates the total number of loan applications for the current month.
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Loan Applications
-- This query calculates the total number of loan applications for the previous month.
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Total Funded Amount
-- This query calculates the total amount of funded loans.
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

-- MTD Total Funded Amount
-- This query calculates the total amount of funded loans for the current month.
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Total Funded Amount
-- This query calculates the total amount of funded loans for the previous month.
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Total Amount Received
-- This query calculates the total amount received in payments.
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data;

-- MTD Total Amount Received
-- This query calculates the total amount received in payments for the current month.
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Total Amount Received
-- This query calculates the total amount received in payments for the previous month.
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Average Interest Rate
-- This query calculates the average interest rate across all loans.
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data;

-- MTD Average Interest
-- This query calculates the average interest rate for the current month.
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Average Interest
-- This query calculates the average interest rate for the previous month.
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- Avg DTI
-- This query calculates the average Debt-to-Income (DTI) ratio across all loans.
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data;

-- MTD Avg DTI
-- This query calculates the average DTI ratio for the current month.
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

-- PMTD Avg DTI
-- This query calculates the average DTI ratio for the previous month.
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

-- GOOD LOAN ISSUED--
-- Good Loan Percentage
-- This query calculates the percentage of loans that are 'Fully Paid' or 'Current'.
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Good Loan Applications
-- This query calculates the number of loans that are 'Fully Paid' or 'Current'.
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
-- This query calculates the total funded amount for loans that are 'Fully Paid' or 'Current'.
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
-- This query calculates the total amount received in payments for loans that are 'Fully Paid' or 'Current'.
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- BAD LOAN ISSUED--
-- Bad Loan Percentage
-- This query calculates the percentage of loans that are 'Charged Off'.
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Applications
-- This query calculates the number of loans that are 'Charged Off'.
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
-- This query calculates the total funded amount for loans that are 'Charged Off'.
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
-- This query calculates the total amount received in payments for loans that are 'Charged Off'.
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- LOAN STATUS--
-- This query provides a summary of loan statuses, including count, total amount received, total funded amount, average interest rate, and average DTI.
SELECT
    loan_status,
    COUNT(id) AS LoanCount,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate * 100) AS Interest_Rate,
    AVG(dti * 100) AS DTI
FROM
    bank_loan_data
GROUP BY
    loan_status;

-- This query provides a summary of loan statuses for the current month, including total amount received and total funded amount.
SELECT 
    loan_status, 
    SUM(total_payment) AS MTD_Total_Amount_Received, 
    SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

-- B. BANK LOAN REPORT | OVERVIEW

-- MONTH--
-- This query provides a monthly overview, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    MONTH(issue_date) AS Month_Munber, 
    DATENAME(MONTH, issue_date) AS Month_name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

-- STATE--
-- This query provides an overview by state, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    address_state AS State, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state;

-- TERM--
-- This query provides an overview by loan term, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    term AS Term, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- EMPLOYEE LENGTH--
-- This query provides an overview by employee length, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    emp_length AS Employee_Length, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE--
-- This query provides an overview by loan purpose, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    purpose AS PURPOSE, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP--
-- This query provides an overview by home ownership status, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    home_ownership AS Home_Ownership, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership;

-- Note: We have applied multiple Filters on all the dashboards. You can check the results for the filters as well by modifying the query and comparing the results.
-- For example, see the results when we hit the Grade A in the filters for dashboards.

-- This query provides an overview by loan purpose for Grade A loans, including the total number of loan applications, total funded amount, and total amount received.
SELECT 
    purpose AS PURPOSE, 
    COUNT(id) AS Total
