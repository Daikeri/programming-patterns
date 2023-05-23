

class UpdateDoctorController
  def initialize(update_view, main_view, senior_controller, number)
    @update_view = update_view
    @main_view = main_view
    @senior_controller = senior_controller
    @current_select = number
  end

  def fill_view
    @doctor = get_selected_doctor
    all_entry = get_entry
    values = @doctor.instance_variables.map! { |field| @doctor.instance_variable_get(field) }
    values.shift
    (0...values.length).each { |item| all_entry[item].text = values[item] }
  end

  def update(entered_values)
    hash = @doctor.instance_variables.map! { |field| field.to_s.gsub(/@/,'') }
    hash.shift
    hash = hash.zip(entered_values).to_h
    hash.each_pair { |key, values| @doctor.send("#{key}=".to_sym, values) }
    @senior_controller.clinic_journal.update_by_id(@doctor.id, @doctor)
    @senior_controller.refresh_data
    @main_view.full_name_sort_clone = nil
    @main_view.sortable_column.sort_indicator = nil
  end

  protected

  def get_selected_doctor
    #number = @main_view.doctors_table.selection + 1
    @senior_controller.obj_list.select(@current_select)
    result = @senior_controller.clinic_journal.get_by_id(@senior_controller.obj_list.get_selected)
    @senior_controller.obj_list.clear_selected
    result
  end

  def get_entry
    all_entry = @update_view.instance_variables.select { |var| var.to_s.end_with?('entry') }
    all_entry.map! { |sym| @update_view.instance_variable_get(sym) }
  end
end
