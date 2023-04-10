*** Settings ***
Documentation  Contains DQE tests for the TRN DB , table hr.employees
Resource       ../resources/variables.resource
Resource       ../resources/common_keywords.resource
Library       ../resources/extended_variables.py
Force Tags     trn  jobs


*** Test Cases ***
Jobs table Min Salary is less or equal to Max Salary as expected
    [Tags]   TC#3
    [Documentation]
    ...  | *Case verifies that min_salary in hr.jobs table is less or equal to max_salary for all records*
    ...  | *Setup:*
    ...  | 0. Prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is expected (see case requiremnt)
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]   Evaluate this sql   "${TABLE_CHECKS_SQL_SELECT1}".format('*', '${TRN_DB}','${TRN_TABLE_JOBS}','min_salary is not null and max_salary is not null and min_salary > max_salary')
    #${EVALUATEDQUERY}   0    rows having min_salary > max_salary
    ${DQ_RESULTS}=    Select DQ results for the table    ${EVALUATEDQUERY}
    ${passed}  ${rownum}  ${rows}=   Number of rows is correct   ${DQ_RESULTS}   0
    IF  not ${passed}
        Log   FAILED RESPONSE DATA\r\n+${rows}   ERROR   0
        Fail   hr.employees has ${rownum} rows having min_salary > max_salary. All can be found in log
    END

Jobs table has expected job_id+job_title pairs
    [Tags]   TC#4
    [Documentation]
    ...  | *Case verifies that all combinations job_id+job_title in Jobs table ahve predefned values*
    ...  | *Setup:*
    ...  | 0. Prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is expected (see case requiremnt)
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]  Evaluate this sql  "${TABLE_CHECKS_SQL_SELECT0}".format('job_id,job_title', '${TRN_DB}','${TRN_TABLE_JOBS}')
    ${DQ_RESULTS}=    Select DQ results for the table    ${EVALUATEDQUERY}
    ${JOBTITLEXPECTEDEDICT}=   Get py variable
    ${passed}  ${rownum}  ${rows}=   Check all records correspond dictionary   ${DQ_RESULTS}    ${JOBTITLEXPECTEDEDICT}
    IF  not ${passed}
        Log   FAILED RESPONSE DATA\r\n+${rows}   ERROR   ${False}
        Fail   Jobs table has ${rownum} unexpected job_id+job_title pairs. All can be found in log
    END
