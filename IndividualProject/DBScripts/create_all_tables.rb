require 'sqlite3'

db = SQLite3::Database.new('D:\RubyProject\IndividualProject\polyclinic.db')

db.execute <<-SQL
  CREATE TABLE Doctors (
    id INTEGER PRIMARY KEY,
    last_name TEXT,
    first_name TEXT,
    patronymic TEXT,
    specialty TEXT,
    qualification TEXT
  );
SQL

db.execute <<-SQL
  CREATE TABLE Patients (
    id INTEGER PRIMARY KEY,
    last_name TEXT,
    first_name TEXT,
    patronymic TEXT,
    age INTEGER
  );
SQL

db.execute <<-SQL
  CREATE TABLE Treatments (
    id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    doctor_id INTEGER,
    diagnosis TEXT,
    cost TEXT,
    treatment_date TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
  );
SQL

