require_relative 'db_adapter'
require 'D:/RubyProject/DoneApp/SourceManagement/Pagination/data_list_pagination'

test1 = DBAdapter.new
data_list = test1.get_k_n_student_short_list(2, 50) # c 51 по 100
result_self = DataListPagination.convert(data_list, 1, 25)
result_comp = test1.get_k_n_student_short_list(1, 25, data_list) # 51 - 75
