require 'sqlite3'
require 'D:/RubyProject/DoneApp/Models/student.rb'
require 'D:/RubyProject/DoneApp/Models/student_short.rb'
require 'D:/RubyProject/DoneApp/Manipulators/data_list_student_short'
require 'D:/RubyProject/DoneApp/SourceManagement/DBSystem/db_connection'
require 'D:/RubyProject/DoneApp/SourceManagement/Pagination/data_list_pagination'

class DBAdapter

  def initialize
    @database_object = DBConnection.instance
  end

  def get_by_id(id)
    request = @database_object.get_cursor.execute "select * from Students where id=#{id}"
    to_student(*request)
  end

  def get_k_n_student_short_list(list_number, quan_element, exist_data_list=nil)
    message = "В качестве необязатального аргумента может использоваться только объект типа DataListStudentShort!"
    request_result = @database_object.get_cursor.execute "select * from Students limit #{(list_number - 1) * quan_element}, #{quan_element}"
    if exist_data_list
      raise(ArgumentError, message) unless valid_data_list?(exist_data_list)
      exist_data_list.arr = to_student_short_arr(request_result)
      return exist_data_list
    end
    to_data_list_student_short(request_result)
  end

  def append(object)
    temp = object.to_s.split(', ').map! { |el| el == '-' ? 'null' : el}
    values = ""
    temp.each { |el| values += "'#{el}',"}
    @database_object.get_cursor.execute "insert into Students (#{self.attr}) values (#{values[0..values.length - 2]})"
  end

  def replace_by_id(id, object)
    hash = object.as_hash
    hash.delete("id")
    hash.transform_values! { |value| value.nil? ? 'null' : value }
    request = ''
    hash.each_pair { |key, value| request += "#{key.to_s} = '#{value}',"}
    @database_object.get_cursor.execute "update Students set #{request[0..request.length-2]} where id = #{id}"
  end

  def delete_by_id(id)
    @database_object.get_cursor.execute "delete from Students where id=#{id}"
  end

  def get_student_count
    hash = @database_object.get_cursor.execute  "select count(*) from Students"
    hash.first.values.first
  end

  protected

  def valid_data_list?(object)
    object.is_a?(DataListStudentShort)
  end

  def attr
    "last_name, first_name, patronymic, git, phone, telegram, email"
  end

  def to_student(hash)
    hash.transform_keys! { |key| key.to_sym }
    Student.from_hash(hash)
  end

  def to_student_short_arr(arr_hash)
    arr_hash.map! { |hash| to_student(hash) }
    arr_hash.map! { |stud_obj| StudentShort.from_object(stud_obj) }
  end

  def to_data_list_student_short(arr_hash)
    to_student_short_arr(arr_hash)
    DataListStudentShort.new(arr_hash)
  end

end
