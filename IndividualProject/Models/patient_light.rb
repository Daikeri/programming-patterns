

class PatientLight

  attr_accessor :id, :full_name, :age

  def self.from_object(obj)
    full_name = "#{obj.last_name} #{obj.first_name[0]}.#{obj.patronymic[0]}."
    new(obj.id, full_name, obj.age)
  end

  def initialize(id, full_name, age)
    self.id = id
    self.full_name = full_name
    self.age = age
  end

  def to_s
    "#{full_name} #{age}"
  end
end

