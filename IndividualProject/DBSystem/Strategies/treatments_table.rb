require 'D:\RubyProject\IndividualProject\Models\treatment.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\obj_list_treatment.rb'

class TreatmentsTable

  attr_reader :count_id

  def initialize(db_connect)
    @db_connect = db_connect
    set_count_id
  end

  def get_by_id(id)
    query = <<~SQL
      SELECT id, patient_id, doctor_id, diagnosis, cost, treatment_date
      FROM Treatments
      WHERE id = ?;
    SQL
    to_treatment(@db_connect.get_cursor.execute(query, id).first)
  end

  def append(treatment)
    query = <<~SQL
      INSERT INTO Treatments (patient_id, doctor_id, diagnosis, cost, treatment_date)
      VALUES (?, ?, ?, ?, ?);
    SQL
    @db_connect.get_cursor.execute(query, treatment.patient_id, treatment.doctor_id, treatment.diagnosis, treatment.cost, treatment.treatment_date)
    set_count_id
  end

  def update_by_id(id, treatment)
    query = <<~SQL
      UPDATE Treatments
      SET patient_id = ?, doctor_id = ?, diagnosis = ?, cost = ?, treatment_date = ?
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, treatment.patient_id, treatment.doctor_id, treatment.diagnosis, treatment.cost, treatment.treatment_date, id)
  end

  def delete_by_id(id)
    query = <<~SQL
      DELETE FROM Treatments
      WHERE id = ?;
    SQL
    @db_connect.get_cursor.execute(query, id)
    set_count_id
  end

  def get_all(exist_obj_list=nil)
    query = <<~SQL
      SELECT id, patient_id, doctor_id, diagnosis, cost, treatment_date
      FROM treatments;
    SQL
    result = to_arr_treatment(@db_connect.get_cursor.execute(query))
    if exist_obj_list
      exist_obj_list.arr = result
      return exist_obj_list
    end
    ObjListTreatment.new(result)
  end

  def get_all_id
    @db_connect.get_cursor.execute("SELECT id FROM Treatments").map! { |hash| hash['id'] }
  end

  protected

  def symbolize_keys(hash)
    hash.transform_keys(&:to_sym)
  end

  def to_treatment(hash)
    symbolized_hash = symbolize_keys(hash)
    Treatment.new(**symbolized_hash)
  end

  def to_arr_treatment(hashes)
    hashes.map! { |hash| to_treatment(hash) }
  end

  def set_count_id
    hash = @db_connect.get_cursor.execute("select max(id) from Treatments").first
    @count_id = hash['max(id)'].nil? ? 1 : hash['max(id)'] + 1
  end
end
