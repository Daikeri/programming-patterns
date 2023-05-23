

class DeleteDoctorController
  def initialize(main_view, senior_controller, number)
    @main_view = main_view
    @senior_controller = senior_controller
    @current_select = number
  end

  def delete
    begin
    #number = @main_view.doctors_table.selection + 1
    @senior_controller.obj_list.select(@current_select)
    id_arr = @senior_controller.obj_list.get_selected
    @senior_controller.obj_list.clear_selected
    id_arr.each { |id| @senior_controller.clinic_journal.delete_by_id(id) }
    @senior_controller.refresh_data
    @main_view.full_name_sort_clone = nil
    @main_view.sortable_column.sort_indicator = nil
    rescue => error
      print "#{error}\n"
    end
  end
end
