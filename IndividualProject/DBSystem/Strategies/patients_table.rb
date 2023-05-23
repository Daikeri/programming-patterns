require 'D:\RubyProject\IndividualProject\Models\patient.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_patient.rb'

class PatientsTable

  attr_reader :count_id

  def initialize(db_connect)
    @db_connect = db_connect
    set_count_id
  end

  def get_by_id(id)
    query = <<~SQL
      SELECT id, last_name, first_name, patronymic, age
      FROM Patients
      WHERE id = ?;
    SQL
    to_patient(@db_connect.get_cursor.execute(query, id).first)
  end

  def append(patient)
    query = <<~SQL
      INSERT INTO Patients (last_name, first_name, patronymic, age)
      VALUES (?, ?, ?, ?);
    SQL
    @db_connect.get_cursor.execute(query, patient.last_name, patient.first_name, patient.patronymic, patient.age)
    set_count_id
  end

  def update_by_id(id, patient)
    query = <<~SQL
      UPDATE Patients
      SET last_name = ?, first_name = ?, patronymic = ?, age = ?
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, patient.last_name, patient.first_name, patient.patronymic, patient.age, id)
  end

  def delete_by_id(id)
    query = <<~SQL
      DELETE FROM Patients
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, id)
    set_count_id
  end

  def get_all(exist_obj_list=nil)
    query = <<~SQL
      SELECT id, last_name, first_name, patronymic, age
      FROM Patients;
    SQL
    result = to_arr_patient_light(@db_connect.get_cursor.execute(query))
    if exist_obj_list
      exist_obj_list.arr = result
      return exist_obj_list
    end
    ObjListPatient.new(result)
  end

  def get_all_id
    @db_connect.get_cursor.execute("SELECT id FROM Patients").map! { |hash| hash['id'] }
  end

  protected

  def symbolize_keys(hash)
    hash.transform_keys(&:to_sym)
  end

  def to_patient(hash)
    Patient.from_hash(symbolize_keys(hash))
  end

  def to_patient_light(hash)
    to_patient(hash).get_light
  end

  def to_arr_patient_light(hashes)
    hashes.map! { |hash| to_patient_light(hash) }
  end

  def set_count_id
    hash = @db_connect.get_cursor.execute("select max(id) from Patients").first
    @count_id = hash['max(id)'].nil? ? 1 : hash['max(id)'] + 1
  end
end
