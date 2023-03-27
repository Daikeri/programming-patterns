require_relative 'students_list_base'
require 'yaml'

class StudentsListYAML < StudentsListBase

  public_class_method :new

  def initialize(path='D:/RubyProject/LW_2/task_4/read_yaml.yaml')
    super
  end

  def write_to_file(path='D:/RubyProject/LW_2/task_4/write_yaml.yaml')
    begin
      @arr.map! { |obj| obj.as_hash }
      File.open(path, 'w') do |file|
        file.write @arr.to_yaml
      end
    rescue SystemCallError
      puts 'Не найден файл по заданному пути!'
    rescue => error
      puts error
    end
  end

  protected

  def set_value(path)
    begin
      count_obj = 1
      str = IO.read(path).chomp
      hash_arr = YAML.load(str, symbolize_names: true)
      id_temp_arr = @id_range.sample(hash_arr.length)
      hash_arr.each { |hash| hash[:id] = id_temp_arr.shift }
      hash_arr.each do |hash|
        temp_obj = Student.from_hash(hash)
        @arr.push(temp_obj)
        count_obj += 1
      end
    rescue SystemCallError
      puts 'Не найден файл по заданному пути!'
    rescue => error
      puts "#{error}\n№ Объекта: #{count_obj}"
    end
  end

end
