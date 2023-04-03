*** Settings ***
Documentation  Contains DQE tests for the TRN DB , table hr.employees
Resource       ../resources/variables.resource
Resource       ../resources/common_keywords.resource
Force Tags     trn  locations
Test Template   Verify suit cases


*** Test Cases ***
Table coutryid has correct formatting
    [Tags]   TC#5
    [Documentation]
    ...  | *Case verifies that coutryid has correct formatting
    ...  | *Checking: ID length is 2 symbols and uppercase *
    ...  | *Setup:*
    ...  | 0. In testcase prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is =0
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]  Evaluate this sql  "${TABLE_CHECKS_SQL_SELECT1}".format('TRIM(country_id)', '${TRN_DB}','${TRN_TABLE_LOCATIONS}','len(TRIM(country_id))!=2 or upper(country_id) != country_id COLLATE Latin1_General_BIN2')
    ${EVALUATEDQUERY}   0     coutryids with bad formatting

Adress length is less than column size as expected
    [Tags]   TC#6
    [Documentation]
    ...  | *Case verifies that length of text in address column in hr.locations table is less than size of column*
    ...  | *Potentially this case can be issue*
    ...  | *Treated as Failed if address length is the same as column length*
    ...  | *Setup:*
    ...  | 0. In testcase prepare query based on predefined sample (based on testcase) by setting input values to it
    ...  | *Test Steps:*
    ...  | 1. Execute prepared query and migrate to pandas DataFrame
    ...  | 2. Check number of rows returned is correct
    ...  | *Expected result:*
    ...  | 1. Number of records returned by query is 0
    ...  | 2. Each returned records (Failed) must be logged
    [Setup]   Evaluate this sql   "${TABLE_CHECKS_SQL_SELECT1}".format('location_id,street_address', '${TRN_DB}','${TRN_TABLE_LOCATIONS}','len([street_address])>=40')
    ${EVALUATEDQUERY}   0    rows with max allowed length of address


*** Keywords ***
Verify suit cases
    [Documentation]
    ...  | *Setup:*
    ...  | 0. In testcase prepare query based on predefined sample (based on testcase) by setting input values to it
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
        Fail   hr.locations has ${rownum} ${DESCR}. All can be found in log
    END