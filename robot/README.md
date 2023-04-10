# Environment setup

## Create virtual environment for tests execution
```cmd
cd robot
python3 -m venv venv 
venv\Scripts\activate
pip install -r robot/requirements.txt
```

## Deploy and configure Data Quality solution
Follow [instructions](README.md)

## Run robot tests
```bash
robot robot/tests/  ##to run all tests in etsts folder
robot robot/tests/ --include employees   ## to run test with tag employees
robot robot/tests/ --include TC#5   ## to run test with tag employees
robot  robot/tests/trn_db_hr_jobs_tests.robot  ##run cases in specified file
```

# Report portal integration with Robot Framework
For the integration library [robotframework-reportportal](https://github.com/reportportal/agent-Python-RobotFramework)
is used. This is an officially supported library for RF from report portal community.

To implement the integration you will need to add `robotframework-reportportal` dependency to your RF project and 
add some commands to the script of starting your test cases.

# Pandas library integration with Robot Framework
For the integration library pandas library need to be installed
```bash
pip install pandas
```

## Run RF tests execution with Report portal integration
Start RF tests with `robot` in one thread like this:
```
robot robot/tests/
or
robot robot/tests/trn_db_hr_employees_tests.robot
and so on
```
