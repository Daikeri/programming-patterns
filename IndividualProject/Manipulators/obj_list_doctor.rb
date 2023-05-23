require_relative 'obj_list_base'
require 'D:\RubyProject\IndividualProject\Models\doctor_light.rb'

class ObjListDoctor < ObjListBase
  protected

  def valid_array_hook?(array)
    return true if array.empty?
    array.all? { |obj| obj.is_a?(DoctorLight) }
  end
end
