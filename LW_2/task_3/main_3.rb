require_relative 'D:/RubyProject/LW_2/task_2/student.rb'
require_relative 'D:/RubyProject/LW_2/task_2/student_short.rb'
require_relative 'data_list_student_short.rb'
require_relative 'data_table'

test1 = Student.from_string(34, 'Крылов, Григорий, Евгеньевич, https://github.com/CVK_Cringe, -, @mamyel, -')
test2 = Student.from_string(31, 'Богомолов, Александр, Романович, https://github.com/Lays_s_krabom, -, -, keklol@yandex.ru')
test3 = Student.from_string(67, 'Алешина, Василиса, Денисовна, https://github.com/Popchik, +7 924 209 16 11, -, -')
test4 = StudentShort.new(test1)
test5 = StudentShort.new(test2)
test6 = StudentShort.new(test3)

student_arr = [test1, test2, test3, test4, test5, test6]

data_list = DataListStudentShort.new(student_arr)

puts 'get_selected'
data_list.sel(3)
print "#{data_list.get_selected}\n"

data_list.sel([1, 2, 3])
print "#{data_list.get_selected}\n"

data_list.sel([3, 1, 2])
print "#{data_list.get_selected}\n"

puts 'get_names'
data_list.get_names.each { |arr| print(arr, "\n") }

data_table = data_list.get_data
print "class: #{data_table.class}\nrows: #{data_table.n_rows}\ncolumns: #{data_table.n_columns}\n"

rows = data_table.n_rows
columns = data_table.n_columns

(0...rows).each do |arr|
  puts
  (0...columns).each { |el| print(data_table.get(arr, el),' ')}
end


