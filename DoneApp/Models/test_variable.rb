require_relative 'student'
require_relative 'student_short'
require 'D:\RubyProject\DoneApp\Manipulators\data_table.rb'
require 'D:\RubyProject\DoneApp\Manipulators\data_list_student_short.rb'

std1 = Student.from_hash({
                           id: 45,
                           last_name: 'Кот',
                           first_name: 'Дмитрий',
                           patronymic: 'Олегович',
                           phone: nil
                         })

short = StudentShort.from_object(std1)
data_list = DataListStudentShort.new([short])
data_table = data_list.data

rows = data_table.n_rows
columns = data_table.n_columns
arr = []
(0...rows).each do |i|
  temp = []
  (0...columns).each { |j| temp << data_table.get(i,j) }
  arr << temp
end

#print arr[0]

