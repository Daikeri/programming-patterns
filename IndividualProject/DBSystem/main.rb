require_relative 'db_adapter'
require 'D:\RubyProject\IndividualProject\Models\patient.rb'
require 'D:\RubyProject\IndividualProject\Models\treatment.rb'

db_adapter = DBAdapter.new(:doctors)
print db_adapter.get_all
=begin
print db_adapter.get_by_id(1)

treatment = Treatment.new(id: 190,
                          doctor_id: 1,
                          patient_id: 2,
                          diagnosis: 'nedotrax',
                          cost: '1899',
                          treatment_date: '19.01.2012')
db_adapter.append(treatment)

treatment = Treatment.new(id: 190,
                          doctor_id: 5,
                          patient_id: 7,
                          diagnosis: 'popchik',
                          cost: '2500',
                          treatment_date: '20.01.2019')
db_adapter.update_by_id(3, treatment)

db_adapter.delete_by_id(11)
=end

=begin
print db_adapter.get_by_id(1)
patient = Patient.from_hash({
                              id: 11,
                              last_name: 'Кот',
                              first_name: 'Дмитрий',
                              patronymic: 'Олегович',
                              age: 45
                            })

#db_adapter.append(patient)

patient = Patient.from_hash({
                              id: 140,
                              last_name: 'Мандыч',
                              first_name: 'Денис',
                              patronymic: 'Игоревич',
                              age: 12
                            })

db_adapter.update_by_id(2, patient)
db_adapter.delete_by_id(11)
=end

