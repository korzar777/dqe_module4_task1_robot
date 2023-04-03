from sqlalchemy import create_engine
import pandas as pd
from sqlalchemy.sql import text
import urllib

server = 'localhost,57175' # to specify an alternate port
port='57175'
database = 'TRN'
username = 'DQTestUser'
password = 'DQTesting111'

#params = urllib.parse.quote_plus("'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost,57175;DATABASE=TRN;UID=DQTestUser;PWD=DQTesting111'")

url = 'mssql+pyodbc://{}:{}@{}:{}/{}?driver={}'.format(username,password,server,port,database,'SQL+Server')


#engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % params)


#url = 'mssql+pyodbc://?odbc_connect=DQTestUser:DQTesting111@localhost:57175/TRN'
#url = 'mssql+pyodbc://?odbc_connect=DQTestUser:DQTesting111@localhost:57175/TRN'
engine = create_engine(url)

sql = '''
    SELECT * FROM trn.hr.employees;
'''
with engine.connect().execution_options(autocommit=True) as conn:
    query = conn.execute(text(sql))
    df = pd.DataFrame(query.fetchall())

var1 = ''
print(df.to_string())
