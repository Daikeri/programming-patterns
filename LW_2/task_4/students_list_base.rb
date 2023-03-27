require_relative 'D:/RubyProject/LW_2/task_2/student.rb'
require_relative 'D:/RubyProject/LW_2/task_2/student_short.rb'
require_relative 'D:/RubyProject/LW_2/task_3/data_list_student_short.rb'
require_relative 'D:/RubyProject/LW_2/task_3/data_table.rb'

class StudentsListBase

  private_class_method :new

  def initialize(path=nil)
    @arr = []
    @id_range = (100..999).to_a
    set_value(path)
  end

  def write_to_file(path)
  end

  def get_k_n_student_short_list(list_number, quan_element, exist_data_list=nil)
    message_one = "В текущем списке недостаточно элементов, чтобы получить #{list_number}-й список из #{quan_element}-ти элементов!"
    message_two = "В качестве необязатального аргумента может использоваться только объект типа DataListStudentShort!"

    if exist_data_list
      raise(ArgumentError, message_two) unless valid_data_list?(exist_data_list)
      additional_arr = convert_to_student_short(exist_data_list)
      @arr += additional_arr
      @arr.uniq! { |obj| obj.id }
    end

    raise(ArgumentError, message_one) unless valid_k_n?(list_number, quan_element)
    student_short_arr = @arr.map { |obj| obj.is_a?(Student) ? StudentShort.from_object(obj) : obj }
    student_short_arr = student_short_arr[(list_number - 1) * quan_element...list_number * quan_element]
    DataListStudentShort.new(student_short_arr)
  end

  def sort_by_full_name
    @arr.sort_by! { |obj| [obj.last_name, obj.first_name, obj.patronymic]}
  end

  def get_by_id(id)
    @arr.find { |obj| obj.id == id }
  end

  def append(object)
    raise(ArgumentError,'Переданное значение должно быть типа Student!') unless valid_student?(object)
    object.id = get_count_id
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

  def set_value(path)
  end

  def get_count_id
    @id_range.sample
  end

  def convert_to_student_short(data_list_obj)
    matrix_only_data = extract_data_table(data_list_obj)
    matrix_with_id = matching_with_id(data_list_obj, matrix_only_data)
    tuple_arr = convert_to_tuple(matrix_with_id)
    tuple_arr.map { |id, str| StudentShort.new(id, str)}
  end

  def extract_data_table(data_list_obj)
    data_table_obj = data_list_obj.data
    rows = data_table_obj.n_rows
    columns = data_table_obj.n_columns
    matrix = []

    (0...rows).each do |i|
      temp_arr = []
      (0...columns).each { |j| temp_arr.push data_table_obj.get(i, j) }
      matrix.push(temp_arr)
    end
    matrix
  end

  def matching_with_id(data_list_obj, matrix_only_data)
    matrix_only_data.map! do |arr|
      arr.shift
      arr
    end
    quan_objects = matrix_only_data.length
    (1..quan_objects).each { |number| data_list_obj.sel(number) }
    id_arr = data_list_obj.get_selected
    [id_arr, matrix_only_data]
  end

  def convert_to_tuple(matrix_with_id)
    id_arr, matrix_only_data = matrix_with_id
    matrix_only_data.map! { |arr| "#{arr[0]}, #{arr[1]}, #{arr[2]}"}
    id_arr.zip(matrix_only_data)
  end

  def valid_k_n?(list_number, quan_element)
    k_lists_of_n_items = @arr.length / quan_element
    list_number > k_lists_of_n_items ? false : true
  end

  def valid_data_list?(object)
    object.is_a?(DataListStudentShort) ? true : false
  end

  def valid_student?(object)
    object.is_a?(Student) ? true : false
  end

end
