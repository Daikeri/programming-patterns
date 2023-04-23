require 'D:/RubyProject/DoneApp/Manipulators/student_list.rb'
require 'D:/RubyProject/DoneApp/SourceManagement/Adapters/db_adapter.rb'
require_relative 'student_list_view'

db_connect = DBAdapter.new
stud_list = StudentList.new(db_connect)
list = stud_list.get_k_n_student_short_list(1, 100)
view = StudentListView.new
view.visualization