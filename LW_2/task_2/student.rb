require_relative 'student_super.rb'

class Student < StudentSuper

  def Student.from_string(id, str)
    hash = super(id, str)
    new(hash)
  end

  def Student.read_from_txt(path='D:\RubyProject\LW_2\task_2\read_file')
    count_id = 1
    acc = []

    begin
    arr = IO.readlines(path)
    arr.map! { |str|str.chomp! }

    arr.each do |str_obj|
      temp = Student.from_string(count_id, str_obj)
      acc.push(temp)
      count_id += 1
    end

    acc
    rescue SystemCallError
      puts 'Не найден файл по заданному пути!'
    rescue => error
      puts "#{error}\nID Записи: #{count_id}"
    end
  end

  def initialize(arg = {})
    @id = arg[:id]
    @last_name = arg[:last_name]
    @first_name = arg[:first_name]
    @patronymic = arg[:patronymic]
    @git = arg[:git]
    @phone = arg[:phone]
    @telegram = arg[:telegram]
    @email = arg[:email]

    validate

    begin
      Integer(@id)
    rescue ArgumentError
      puts 'Полю ID должно быть присвоено целочисленное значение!'
    end

    set_contacts(git: @git, phone: @phone, telegram: @telegram, email: @email)
  end

  def get_info
    "#{@id}, #{get_full_name}, #{@git}, #{get_contacts}"
  end

  protected

  def get_full_name
    "#{@last_name} #{@first_name[0]}.#{@patronymic[0]}."
  end

  def get_contacts
    "#{@phone ? @phone: '-'}, #{@telegram ? @telegram : '-'}, #{@email ? @email : '-'}"
  end
end
