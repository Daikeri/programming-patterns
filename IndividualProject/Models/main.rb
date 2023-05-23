require_relative 'patient'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_patient.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\pure_values.rb'
require 'D:\RubyProject\IndividualProject\Models\treatment.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_treatment.rb'

=begin
patient = Patient.new(
  id: 1,
  last_name: 'Smith',
  first_name: 'John',
  patronymic: 'Doe',
  age: 35
)

patient1 = Patient.new(
  id: 2,
  last_name: 'Sara',
  first_name: 'Stat',
  patronymic: 'Some',
  age: 35
)

# id, doctor_id, patient_id, diagnosis, cost, treatment_date
pure_val = ObjListPatient.new([patient.get_light, patient1.get_light]).pure_values

matrix = []
(0...pure_val.n_rows).each do |i|
  row = []
  (0...pure_val.n_columns).each { |j|  row << pure_val.get(i,j) }
  matrix << row
end
print matrix
=end
=begin
operation1 = Treatment.new(id: 190, 1, 2, 'nedotrax', '1899', '19.01.2012')
operation2 = Treatment.new(34, 2, 2, 'popix', '2700', '10.05.2009')

pure_val = ObjListTreatment.new([operation1, operation2]).pure_values

matrix = []
(0...pure_val.n_rows).each do |i|
  row = []
  (0...pure_val.n_columns).each { |j|  row << pure_val.get(i,j) }
  matrix << row
end
print matrix
=end