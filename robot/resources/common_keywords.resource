*** Settings ***
Resource  variables.resource
Library   PandasLibs.py
Library   DbLib.py
Library   extended_variables.py

*** Keywords ***
Select DQ results for the table
    [Arguments]   ${QUERY}
    [Documentation]  Query results from local database.
    ${DQ_RESULTS} =  EXECUTE SQL    ${QUERY}
    [return]  ${DQ_RESULTS}


Number of rows is correct
    [Arguments]  ${tabledata}  ${expectedrowcount}
    ${boolresult}  ${rownum}  ${rows}=   CHECK NUMBER OF ROWS   ${tabledata}   ${expectedrowcount}
    [return]  ${boolresult}  ${rownum}  ${rows}

Evaluate this sql
    [Arguments]  ${txtquery}
    ${value}=  evaluate  ${txtquery}
    set test variable  ${EVALUATEDQUERY}   ${value}

Get py variable
    ${value}=  Jobid Jobtitle Pairs
    [return]   ${value}
