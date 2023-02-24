require_relative 'student.rb'

test1 = Student.new({last_name:'Алешина', first_name:'Василиса', patronymic:'Денисовна',
                     phone:'+7 924 209 16 11'})
test1.get_info

test2 = Student.new({last_name:'Крылов', first_name:'Григорий', patronymic:'Евгеньевич',
                     telegram:'@picklePop', id:43, email: 'krilov@yandex.ru'})
test2.get_info

test3 = Student.new({last_name:'Богомолов', first_name:'Александр', patronymic:'Романович', phone: '+384 136 809'})

test3.get_info




