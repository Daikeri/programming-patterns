require_relative 'file_loader'
require 'D:/RubyProject/DoneApp/Models/student.rb'
require 'D:/RubyProject/DoneApp/Models/student_short.rb'
require 'D:/RubyProject/DoneApp/Manipulators/data_list_student_short.rb'
require 'D:/RubyProject/DoneApp/SourceManagement/Pagination/data_list_pagination'

class FileContent

  def initialize(source_path=nil)
    @file_loader = FileLoader.new
    set_value(source_path) if source_path
  end

  def read_from_file(source_path)
    set_value(source_path)
  end

  def write_to_file(source_path)
    @file_loader.write_to_file(source_path, @arr)
  end

  def get_k_n_student_short_list(list_number, quan_element, exist_data_list=nil)
    message = "В качестве необязатального аргумента может использоваться только объект типа DataListStudentShort!"
    stud_short_arr = list_number * quan_element > @arr.length ? @arr : @arr[(list_number - 1) * quan_element...list_number * quan_element]
    stud_short_arr.map! { |obj| StudentShort.from_object(obj)}
    if exist_data_list
      raise(ArgumentError, message) unless valid_data_list?(exist_data_list)
      exist_data_list.arr = stud_short_arr
      return exist_data_list
    end
    DataListStudentShort.new(stud_short_arr)
  end

  def sort_by_full_name
    @arr.sort_by! { |obj| [obj.last_name, obj.first_name, obj.patronymic]}
  end

  def get_by_id(id)
    @arr.find { |obj| obj.id == id }
  end

  def append(object)
    raise(ArgumentError,'Переданное значение должно быть типа Student!') unless valid_student?(object)
    object.id = id_count
    @arr.push(object)
  end

  def replace_by_id(id, object)
    raise(ArgumentError,'Переданное значение должно быть типа Student!') unless valid_student?(object)
    index = @arr.find_index { |obj|  obj.id == id}
    object.id = @arr[index].id
    @arr.fill(object, index, 1)
  end

  def delete_by_id(id)
    @arr.reject! { |obj| obj.id == id }
  end

  def get_student_count
    @arr.length
  end

  protected

  def set_value(source_path)
    @arr = @file_loader.read_from_file(source_path)
    @id_count = 1
    @arr.each do |obj|
      obj.id = @id_count
      @id_count += 1
    end
  end

  def id_count
    res = @id_count
    @id_count += 1
    res
  end

  def valid_data_list?(object)
    object.is_a?(DataListStudentShort)
  end

  def valid_student?(object)
    object.is_a?(Student)
  end

end

