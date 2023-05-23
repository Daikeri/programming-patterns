require 'D:\RubyProject\IndividualProject\Models\doctor.rb'

class AppendDoctorController
  def initialize(append_view, main_view, senior_controller)
    @append_view = append_view
    @main_view = main_view
    @senior_controller = senior_controller
  end

  def append(entered_values)
    begin
    doctor = create_doctor(entered_values)
    @senior_controller.clinic_journal.append(doctor)
    @senior_controller.refresh_data
    @main_view.full_name_sort_clone = nil
    @main_view.sortable_column.sort_indicator = nil
    rescue => error
      print "#{error}\n"
    end
  end

  protected

  def create_doctor(values)
    attr = [:id, :last_name, :first_name, :patronymic, :specialty, :qualification]
    values.unshift(@senior_controller.clinic_journal.count_id)
    hash = attr.zip(values).to_h
    Doctor.new(**hash)
  end
end
