require_relative 'student.rb'

test1 = Student.new('Алешина', 'Василиса', 'Денисовна',
                    _phone: '+7 924 209 16 11', _id: 101)
test2 = Student.new('Крылов', 'Григорий', 'Евгеньевич',
                    _telegram: '@picklePop', _id: 43, _email: 'krilov@yandex.ru')

test3 = Student.new('Богомолов', 'Александр', 'Романович')

test1.get_info
test2.get_info
test3.get_info