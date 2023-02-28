require_relative 'student.rb'
require_relative 'student_short.rb'

test1 = StudentShort.new(45, 'Кот Д.О., https://github.com/Daikeri, +7 918 156 97 81; -; -')

#test2 = StudentShort.new(109, 'Мозговой Д.В., https://github.com/adept_redana, -; -; -')

test3 = StudentShort.new(121, 'Мозговой Д.В., https://github.com/ogyrchik, -; @popkamamonta; -')

temp1 = Student.new({id: 90, last_name:'Богомолов', first_name:'Александр', patronymic:'Романович',
                     git: 'https://github.com/adept_redana', phone: '+7 928 222 17 01'})

test4 = StudentShort.from_object(temp1)

puts test4.get_info

