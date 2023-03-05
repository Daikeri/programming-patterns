require_relative 'student_super.rb'
require_relative 'student.rb'

class StudentShort < StudentSuper

  def StudentShort.from_string(id, str)
    hash = super(id, str)
    new(Student.new(hash))
  end

  attr_reader :id, :full_name,
              :git, :contacts

  protected :last_name, :first_name, :patronymic,
            :phone, :telegram, :email,
            :last_name=, :first_name=, :patronymic=,
            :phone=, :telegram=, :email=

  def initialize(obj)
    @id = obj.id
    @full_name = "#{obj.last_name} #{obj.first_name[0]}.#{obj.patronymic[0]}."
    @git = obj.git
    @contacts = "#{obj.phone ? obj.phone : '-'}, #{obj.telegram ? obj.telegram : '-'}, #{obj.email ? obj.email : '-'}"
  end

  def get_info
    "#{@id}, #{@full_name}, #{@git}, #{@contacts}"
  end
end
