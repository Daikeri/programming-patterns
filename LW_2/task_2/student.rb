require_relative 'student_super.rb'

class Student < StudentSuper

  def Student.from_string(id, str)
    hash = super(id, str)
    new(hash)
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

  def  get_info
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
