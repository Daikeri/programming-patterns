

class DeleteTreatmentsController
  def initialize(number, senior_controller)
    @selected_treatment = number
    @senior_controller = senior_controller
  end

  def delete
    begin
      @senior_controller.obj_list.select(@selected_treatment)
      id_arr = @senior_controller.obj_list.get_selected
      @senior_controller.obj_list.clear_selected
      id_arr.each { |id| @senior_controller.clinic_journal.delete_by_id(id) }
      @senior_controller.refresh_data
    rescue => error
      print "#{error}\n"
    end
  end
end
