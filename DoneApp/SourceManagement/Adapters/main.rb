require_relative 'db_adapter'
require 'D:/RubyProject/DoneApp/SourceManagement/Pagination/data_list_pagination'

=begin
test1 = DBAdapter.new
data_list = test1.get_k_n_student_short_list(2, 50) # c 51 по 100
result_self = DataListPagination.convert(data_list, 1, 25)
result_comp = test1.get_k_n_student_short_list(1, 25, data_list) # 51 - 75
=end

adapter_one = DBAdapter.new
data_list = DataListStudentShort.new([])
adapter_one.get_k_n_student_short_list(1, 10, data_list)

data_table = data_list.data
matrix = []

(0...data_table.n_rows).each do |i|
  temp = []
  (0...data_table.n_columns).each { |j| temp << data_table.get(i, j) }
  matrix << temp
end

#matrix.each { |obj| print"#{obj}\n" }
print Array.new(5) { [] }