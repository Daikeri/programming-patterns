require 'D:\RubyProject\IndividualProject\Models\doctor.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_doctor.rb'

class DoctorsTable

  attr_reader :count_id

  def initialize(db_connect)
    @db_connect = db_connect
    set_count_id
  end

  def get_by_id(id)
    query = <<~SQL
      SELECT id, last_name, first_name, patronymic, specialty, qualification
      FROM Doctors
      WHERE id = ?;
    SQL
    to_doctor(@db_connect.get_cursor.execute(query, id).first)
  end

  def append(doctor)
    query = <<~SQL
      INSERT INTO Doctors (last_name, first_name, patronymic, specialty, qualification)
      VALUES (?, ?, ?, ?, ?);
    SQL
    @db_connect.get_cursor.execute(query, doctor.last_name, doctor.first_name, doctor.patronymic, doctor.specialty, doctor.qualification)
    set_count_id
  end

  def update_by_id(id, doctor)
    query = <<~SQL
      UPDATE Doctors
      SET last_name = ?, first_name = ?, patronymic = ?, specialty = ?, qualification = ?
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, doctor.last_name, doctor.first_name, doctor.patronymic, doctor.specialty, doctor.qualification, id)
  end

  def delete_by_id(id)
    query = <<~SQL
      DELETE FROM Doctors
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, id)
    set_count_id
  end

  def get_all(exist_obj_list=nil)
    query = <<~SQL
      SELECT id, last_name, first_name, patronymic, specialty, qualification
      FROM Doctors;
    SQL
    result = to_arr_doctor_light(@db_connect.get_cursor.execute(query))
    if exist_obj_list
      exist_obj_list.arr = result
      return exist_obj_list
    end
    ObjListDoctor.new(result)
  end

  def get_all_id
    @db_connect.get_cursor.execute("SELECT id FROM Doctors").map! { |hash| hash['id'] }
  end

  protected

  def symbolize_keys(hash)
    hash.transform_keys(&:to_sym)
  end

  def to_doctor(hash)
    Doctor.new(**symbolize_keys(hash))
  end

  def to_doctor_light(hash)
    to_doctor(hash).get_light
  end

  def to_arr_doctor_light(hashes)
    hashes.map! { |hash| to_doctor_light(hash) }
  end

  def set_count_id
    hash = @db_connect.get_cursor.execute("select max(id) from Doctors").first
    @count_id = hash['max(id)'].nil? ? 1 : hash['max(id)'] + 1
  end
end
