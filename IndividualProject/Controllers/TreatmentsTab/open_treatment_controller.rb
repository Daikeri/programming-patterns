require 'D:\RubyProject\IndividualProject\DBSystem\db_adapter.rb'
require 'D:\RubyProject\IndividualProject\Manipulators\clinic_journal.rb'

class OpenTreatmentController
  def initialize(open_view, treatment_number, senior_controller)
    @open_view = open_view
    @senior_controller = senior_controller
    @selected_treatment = get_selected_treatment(treatment_number)
  end

  def fill_view
    begin
    doctor = get_doctor(@selected_treatment.doctor_id)
    patient = get_patient(@selected_treatment.patient_id)
    treatment = extract_treatment
    [doctor, patient, treatment].each do |hash|
      hash.each do |key, value|
        obj = @open_view.instance_variable_get("@#{key}")
        obj.text = value
      end
    end
    rescue => error
      print "#{error}"
    end
  end

  protected

  def get_selected_treatment(number)
    @senior_controller.obj_list.select(number)
    id = @senior_controller.obj_list.get_selected.first
    @senior_controller.obj_list.clear_selected
    @senior_controller.clinic_journal.get_by_id(id)
  end

  def get_doctor(id)
    obj = DBAdapter.new(:doctors).get_by_id(id)
    fields = obj.instance_variables.map { |attr| attr.to_s.gsub(/@/, '')}
    fields.shift
    fields.map! { |attr| obj.send(attr) }
    @open_view.doctor_labels.zip(fields).to_h
  end

  def get_patient(id)
    obj = DBAdapter.new(:patients).get_by_id(id)
    fields = obj.instance_variables.map { |attr| attr.to_s.gsub(/@/, '')}
    fields.shift
    fields.map! { |attr| obj.send(attr) }
    result = @open_view.patient_labels.zip(fields).to_h
    result[:pat_attr4] = result[:pat_attr4].to_s
    result
  end

  def extract_treatment
    fields = [@selected_treatment.diagnosis, @selected_treatment.cost, @selected_treatment.treatment_date]
    @open_view.treatment_labels.zip(fields).to_h
  end
end
