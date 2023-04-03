*** Settings ***
#Library   PandasLibs

*** Keywords ***


*** Variables ***
#sql query samples
${TABLE_CHECKS_SQL_GROUP1}           SELECT {} FROM {}.{}
                              ...  group by {} having {};

${TABLE_CHECKS_SQL_SELECT0}           SELECT {} FROM {}.{};

${TABLE_CHECKS_SQL_SELECT1}           SELECT {} FROM {}.{}
                              ...  where {};

#db, tables
${TRN_DB}             TRN
${TRN_TABLE_EMPLOYEES}        hr.employees
${TRN_TABLE_JOBS}        hr.jobs
${TRN_TABLE_LOCATIONS}        hr.locations

#### database configuration
${DBUsername}   DQTestUser