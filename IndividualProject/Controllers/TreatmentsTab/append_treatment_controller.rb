require 'D:\RubyProject\IndividualProject\DBSystem\db_adapter.rb'
require 'D:\RubyProject\IndividualProject\Models\treatment.rb'

class AppendTreatmentController
  def initialize(append_view, senior_controller)
    @append_view = append_view
    @senior_controller = senior_controller
  end

  def fill_view
    begin
    @append_view.doctors_combo.items = get_all_doctors
    @append_view.patients_combo.items = get_all_patients
    rescue => error
      puts "#{error}\nappend_controller"
    end
  end

  def append(entered_values)
    fields = [:id, :doctor_id, :patient_id, :diagnosis, :cost, :treatment_date]
    val = [@senior_controller.clinic_journal.count_id]
    val << @doctors_id[@append_view.doctors_combo.selected]
    val << @patients_id[@append_view.patients_combo.selected]
    val += entered_values
    obj = Treatment.new(**fields.zip(val).to_h)
    @senior_controller.clinic_journal.append(obj)
    @senior_controller.refresh_data
  end

  protected

  def get_all_doctors
    db = DBAdapter.new(:doctors)
    @doctors_id = db.get_all_id
    @doctors_id.map { |id| db.get_by_id(id).get_light.to_s }
  end

  def get_all_patients
    db = DBAdapter.new(:patients)
    @patients_id = db.get_all_id
    @patients_id.map { |id| db.get_by_id(id).get_light.to_s }
  end
end

