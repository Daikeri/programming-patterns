require_relative 'student.rb'
require_relative 'student_short.rb'

array_test1 = Student.read_from_txt
array_test1.each { |obj| puts obj.get_info }
