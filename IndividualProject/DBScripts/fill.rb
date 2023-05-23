require 'sqlite3'
require 'faker'

# Connect to the existing database
db = SQLite3::Database.open('polyclinic.db')

# Generate and insert data into the Doctors table
10.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  patronymic = Faker::Name.middle_name
  specialty = Faker::Job.title
  qualification = Faker::Job.position

  db.execute("INSERT INTO Doctors (last_name, first_name, patronymic, specialty, qualification) VALUES (?, ?, ?, ?, ?)", [last_name, first_name, patronymic, specialty, qualification])
end

# Generate and insert data into the Patients table

# Generate and insert data into the Treatments table
10.times do
  patient_id = Faker::Number.between(from: 1, to: 10)
  doctor_id = Faker::Number.between(from: 1, to: 10)
  diagnosis = Faker::Lorem.sentence
  cost = (Faker::Number.decimal(l_digits: 4, r_digits: 2)).to_s
  treatment_date = Faker::Date.between(from: '2000-01-01', to: '2023-12-31')
  treatment_date = treatment_date.strftime('%d.%m.%Y')
  db.execute("INSERT INTO Treatments (patient_id, doctor_id, diagnosis, cost, treatment_date) VALUES (?, ?, ?, ?, ?)", [patient_id, doctor_id, diagnosis, cost, treatment_date])
end


10.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  patronymic = Faker::Name.middle_name
  year_of_birth = Faker::Number.between(from: 0, to: 120)

  db.execute("INSERT INTO Patients (last_name, first_name, patronymic, age) VALUES (?, ?, ?, ?)", [last_name, first_name, patronymic, year_of_birth])
end

