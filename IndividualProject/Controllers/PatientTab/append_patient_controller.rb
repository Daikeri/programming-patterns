require 'D:\RubyProject\IndividualProject\Models\patient.rb'

class AppendPatientController
  def initialize(append_view, main_view, senior_controller)
    @append_view = append_view
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def append(entered_values)
    begin
      patient = create_patient(entered_values)
      @senior_controller.clinic_journal.append(patient)
      @senior_controller.refresh_data
      @main_view.age_sort_clone = nil
      @main_view.sortable_column.sort_indicator = nil
    rescue => error
      print "#{error}\n"
    end
  end

  protected

  def create_patient(values)
    attr = [:id, :last_name, :first_name, :patronymic, :age]
    values.unshift(@senior_controller.clinic_journal.count_id)
    hash = attr.zip(values).to_h
    hash[:age] = hash[:age].to_i
    Patient.from_hash(hash)
  end
end
