require_relative 'students_list_unified'

txt = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_txt.txt')
txt.write_to_file('D:/RubyProject/LW_2/task_4/write_txt.txt')

json = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_json.json')
json.write_to_file('D:/RubyProject/LW_2/task_4/write_json.json')

yaml = StudentsListUnified.new('D:/RubyProject/LW_2/task_4/read_yaml.yaml')
yaml.write_to_file('D:/RubyProject/LW_2/task_4/write_yaml.yaml')