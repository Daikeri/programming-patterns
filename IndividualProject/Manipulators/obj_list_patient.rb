require_relative 'obj_list_base'
require 'D:\RubyProject\IndividualProject\Models\patient_light.rb'

class ObjListPatient < ObjListBase
  protected

  def valid_array_hook?(array)
    return true if array.empty?
    array.all? { |obj| obj.is_a?(PatientLight) }
  end
end
