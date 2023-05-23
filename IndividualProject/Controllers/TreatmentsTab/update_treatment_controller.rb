require 'D:\RubyProject\IndividualProject\DBSystem\db_adapter.rb'

class UpdateTreatmentController
  def initialize(update_view, treatment_number, senior_controller)
    @update_view = update_view
    @senior_controller = senior_controller
    @selected_treatment = get_selected_treatment(treatment_number)
  end

  def fill_view
    begin
    @update_view.doctors_combo.items = get_all_doctors
    @update_view.patients_combo.items = get_all_patients
    set_past_selection
    set_past_entry
    rescue => error
      puts error
    end
  end

  def update(entered_values)
    val = [@doctors_id[@update_view.doctors_combo.selected]]
    val << @patients_id[@update_view.patients_combo.selected]
    val += entered_values
    fields = [:doctor_id, :patient_id, :diagnosis, :cost, :treatment_date].zip(val).to_h
    fields.each_pair { |field, value| @selected_treatment.send("#{field}=", value) }
    @senior_controller.clinic_journal.update_by_id(@selected_treatment.id, @selected_treatment)
    @senior_controller.refresh_data
  end

  protected

  def set_past_selection
    past_doc = @doctors_id.index { |id_doc| id_doc == @selected_treatment.doctor_id }
    past_pat = @patients_id.index { |id_pat| id_pat == @selected_treatment.patient_id }
    @update_view.doctors_combo.selected = past_doc
    @update_view.patients_combo.selected = past_pat
  end

  def set_past_entry
    val = [@selected_treatment.diagnosis, @selected_treatment.cost, @selected_treatment.treatment_date]
    all_entry_obj = @update_view.instance_variables.select { |var| var.to_s.end_with?('entry') }
    all_entry_obj.map! { |sym| @update_view.instance_variable_get(sym) }
    (0...val.length).each { |item| all_entry_obj[item].text = val[item ]}
  end

  def get_selected_treatment(number)
    @senior_controller.obj_list.select(number)
    id = @senior_controller.obj_list.get_selected.first
    @senior_controller.obj_list.clear_selected
    @senior_controller.clinic_journal.get_by_id(id)
  end

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
