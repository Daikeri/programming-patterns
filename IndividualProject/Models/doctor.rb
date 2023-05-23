require_relative 'doctor_light'

class Doctor

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/

  attr_reader :id, :last_name, :first_name, :patronymic
  attr_accessor :specialty, :qualification

  def initialize(id:, last_name:, first_name:, patronymic:, specialty:, qualification:nil)
    message = 'id, last_name, first_name, patronymic, specialty - required fields!'
    raise(ArgumentError, message) unless  id && last_name && first_name && patronymic && specialty
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.patronymic = patronymic
    self.specialty = specialty
    self.qualification = qualification
  end

  def get_light
    DoctorLight.from_object(self)
  end

  def id=(val)
    msg = 'Полю ID должно быть присвоено целочисленное значение'
    raise(ArgumentError, msg) unless val.is_a?(Integer)
    @id = val
  end

  def last_name=(val)
    raise(ArgumentError, 'Неправильная фамилия доктора!') unless !val.nil? && val.match?(NAME)
    @last_name = val
  end

  def first_name=(val)
    raise(ArgumentError, 'Неправильное имя доктора!') unless !val.nil? && val.match?(NAME)
    @first_name = val
  end

  def patronymic=(val)
    raise(ArgumentError, 'Неправильное отчество доктора!') unless !val.nil? && val.match?(NAME)
    @patronymic = val
  end

  def to_s
    "#{self.last_name} #{self.first_name} #{self.patronymic} #{self.specialty}" + (self.qualification.nil? ? '' : " #{self.qualification}")
  end
end