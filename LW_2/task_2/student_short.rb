require_relative 'student.rb'

class StudentShort

  def StudentShort.from_string(str)

    begin
      value = str.split(', ')
    rescue NoMethodError
      puts 'Переданное значение не подлежит парсингу!'
    end

    @id = value[0]
    @full_name = value[1]
    @git = value[2]
    @contact = value[3]
  end


  attr_reader :id, :full_name,
              :git, :contact

  def initialize(obj)
    @id = obj.id
    @full_name = obj.get_full_name
    @git = obj.get_git
    @contact = obj.get_contact
  end

end
