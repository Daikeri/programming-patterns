require 'D:\RubyProject\DoneApp\View\create_student_view.rb'
require 'D:\RubyProject\DoneApp\Models\student.rb'

class CreateStudentController
  def initialize(senior_controller)
    @senior_controller = senior_controller
  end

  def append(hash)
    hash[:id] = @senior_controller.student_list_obj.id_count
    obj = Student.from_hash(hash)
    @senior_controller.student_list_obj.append(obj)
    @senior_controller.refresh_data
  end
end
