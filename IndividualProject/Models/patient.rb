require_relative 'patient_light'

class Patient

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/

  attr_reader :id, :last_name, :first_name, :patronymic, :age

  def self.from_hash(hash)
    id = hash.delete(:id)
    last_name = hash.delete(:last_name)
    first_name = hash.delete(:first_name)
    patronymic = hash.delete(:patronymic)
    age = hash.delete(:age)
    new(id, last_name, first_name, patronymic, age)
  end

  def initialize(id, last_name, first_name, patronymic, age)
    message = 'id, last_name, first_name, patronymic, age - required fields!'
    raise(ArgumentError, message) unless  id && last_name && first_name && patronymic && age
    self.id = id
    self.last_name = last_name
    self.first_name = first_name
    self.patronymic = patronymic
    self.age = age
  end

  def get_light
    PatientLight.from_object(self)
  end

  def id=(val)
    msg = 'Полю ID должно быть присвоено целочисленное значение'
    raise(ArgumentError, msg) unless val.is_a?(Integer)
    @id = val
  end

  def last_name=(val)
    raise(ArgumentError, 'Неправильная фамилия пациента!') unless !val.nil? && val.match?(NAME)
    @last_name = val
  end

  def first_name=(val)
    raise(ArgumentError, 'Неправильное имя пациента!') unless !val.nil? && val.match?(NAME)
    @first_name = val
  end

  def patronymic=(val)
    raise(ArgumentError, 'Неправильное отчество пациента!') unless !val.nil? && val.match?(NAME)
    @patronymic = val
  end

  def age=(val)
    raise(ArgumentError, 'Неккоретный возраст пациента!') unless !val.nil? && val >= 0 && val <= 120
    @age = val
  end

  def to_s
    "#{self.last_name} #{self.first_name} #{self.patronymic} #{self.age}"
  end
end
