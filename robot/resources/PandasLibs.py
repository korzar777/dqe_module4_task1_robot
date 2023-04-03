import pandas as pd
from robot.api.deco import library, keyword


@library(scope='GLOBAL', auto_keywords=True)
class PandasLibs:

    @keyword
    def get_table_result(query):
        return pd.DataFrame(query.fetchall())

    @keyword
    def check_number_of_rows(self,data,expectedrowcount=0):
        return True if len(data) == expectedrowcount else False,len(data), \
               None if len(data) == expectedrowcount else data

    @keyword
    def check_all_records_correspond_dictionary(self,data, expecteddict: dict):
        result = [each for each in data.to_dict('split')['data'] if not (each[0] in expecteddict and each[1]==expecteddict[each[0]])]
        return True if len(result) == 0 else False,len(result), \
               None if len(result) == 0 else result