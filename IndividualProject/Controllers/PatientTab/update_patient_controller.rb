

class UpdatePatientController
  def initialize(update_view, main_view, senior_controller, number)
    @update_view = update_view
    @main_view = main_view
    @senior_controller = senior_controller
    @current_select = number
  end

  def fill_view
    begin
    @patient = get_selected_patient
    all_entry = get_entry
    values = @patient.instance_variables.map! { |field| @patient.instance_variable_get(field) }
    values.shift
    (0...values.length).each { |item| all_entry[item].text = values[item].to_s }
    rescue  => error
      print "#{error}\n"
    end
  end

  def update(entered_values)
    hash = @patient.instance_variables.map! { |field| field.to_s.gsub(/@/,'') }
    hash.shift
    hash = hash.zip(entered_values).to_h
    hash['age'] = hash['age'].to_i
    hash.each_pair { |key, values| @patient.send("#{key}=".to_sym, values) }
    @senior_controller.clinic_journal.update_by_id(@patient.id, @patient)
    @senior_controller.refresh_data
    @main_view.age_sort_clone = nil
    @main_view.sortable_column.sort_indicator = nil
  end

  protected

  def get_selected_patient
    begin
      #number = @main_view.patient_table.selection + 1
    @senior_controller.obj_list.select(@current_select)
    result = @senior_controller.clinic_journal.get_by_id(@senior_controller.obj_list.get_selected)
    @senior_controller.obj_list.clear_selected
    result
    rescue  => error
      print "#{error}\n"
    end
  end

  def get_entry
    all_entry = @update_view.instance_variables.select { |var| var.to_s.end_with?('entry') }
    all_entry.map! { |sym| @update_view.instance_variable_get(sym) }
  end
end
