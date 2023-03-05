require_relative 'student.rb'
require_relative 'student_short.rb'

array_test1 = Student.read_from_txt
array_test1.each { |obj| puts obj.get_info }
puts
Student.write_to_txt(array_test1)
array_test2 = Student.read_from_txt(path='D:\RubyProject\LW_2\task_2\write_file')
array_test2.each { |obj| puts obj.get_info }