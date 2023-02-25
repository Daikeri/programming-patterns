require_relative 'student.rb'

test1 = Student.new({last_name:'Алешина', first_name:'Василиса', patronymic:'Денисовна', phone:'+7 924 209 16 11',
                     git:'https://github.com/Daikeri'})

test2 = Student.new({last_name:'Крылов', first_name:'Григорий', patronymic:'Евгеньевич',
                     telegram:'@kitmamymav', id:43, email: 'krilov@yandex.ru'})

test3 = Student.new({last_name:'Богомолов', first_name:'Александр', patronymic:'Романович'})