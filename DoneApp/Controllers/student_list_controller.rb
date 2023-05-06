require 'D:\RubyProject\DoneApp\Manipulators\student_list.rb'
require 'D:\RubyProject\DoneApp\SourceManagement\Adapters\db_adapter.rb'
require 'D:\RubyProject\DoneApp\Manipulators\data_list_student_short.rb'
require 'D:\RubyProject\DoneApp\SourceManagement\Adapters\file_content_adapter.rb'
require 'D:\RubyProject\DoneApp\View\student_list_view.rb'
require 'D:\RubyProject\DoneApp\Controllers\data_list_contract.rb'

class StudentListController

  attr_reader :student_list_obj

  def initialize(view_obj)
    @view_obj = view_obj
    @data_list_obj = DataListStudentShort.new([])
    @data_list_obj.subscribe(@view_obj)
  end

  def on_student_list_view_created(adapter_type)
    adapter = adapter_type.is_a?(Hash) ? FileContentAdapter.new(adapter_type.delete(:json_file)) : DBAdapter.new
    @student_list_obj = StudentList.new(adapter)
  end

  def refresh_data(page=@view_obj.current_page, quan_rows=@view_obj.quan_rows)
    @data_list_obj = @student_list_obj.get_k_n_student_short_list(page, quan_rows, @data_list_obj)
    @view_obj.update_total_count(@student_list_obj.get_student_count)
    @data_list_obj.notify
  end
end

