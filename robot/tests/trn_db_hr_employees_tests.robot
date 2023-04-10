*** Settings ***
Documentation  Contains DQE tests for the TRN DB , table hr.employees
Resource       ../resources/variables.resource
Resource       ../resources/common_keywords.resource
Force Tags     trn  employees
Test Template   Verify suit cases


*** Test Cases ***
Table hr.employees has no duplicates as expected
    [Tags]   TC#1
    [Documentation]
    ...  | *Case verifies that no duplicate rows exist in hr.employees table*
    ...  | *Setup:*
    ...  | 0. In testcase prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is 0
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]  Evaluate this sql  "${TABLE_CHECKS_SQL_GROUP1}".format('employee_id,count(*)', '${TRN_DB}','${TRN_TABLE_EMPLOYEES}','employee_id','count(*)>1')
    ${EVALUATEDQUERY}   0     duplicate

Salary is positive for all employees in hr.employees as expected
    [Tags]   TC#2
    [Documentation]
    ...  | *Case verifies that salary in hr.employees table is positive (>0) for all records*
    ...  | *Setup:*
    ...  | 0. In testcase prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is <=0
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]   Evaluate this sql   "${TABLE_CHECKS_SQL_SELECT1}".format('*', '${TRN_DB}','${TRN_TABLE_EMPLOYEES}','salary <= 0')
    ${EVALUATEDQUERY}   0    rows with non-positive salary


*** Keywords ***
Verify suit cases
    [Documentation]
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is expected (see case requiremnt)
    ...  | 2. Each returned records (Failed) must be logged
    [Arguments]    ${QUERY}   ${EXPVALUE}  ${DESCR}
    ${DQ_RESULTS}=    Select DQ results for the table    ${QUERY}
    ${passed}  ${rownum}  ${rows}=   Number of rows is correct   ${DQ_RESULTS}   ${EXPVALUE}
    IF  not ${passed}
        Log   FAILED RESPONSE DATA\r\n+${rows}   ERROR   ${False}
        Fail   hr.employees has ${rownum} ${DESCR}. All can be found in log
    END
}