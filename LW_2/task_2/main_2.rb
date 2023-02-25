require_relative 'student.rb'

test4 = Student.from_string('-, Кудрявцев, Матвей, Артёмович, +79561231001, -, -, https://github.com/Daikeri')
puts test4.get_info