

class DoctorLight

  attr_accessor :id, :full_name, :specialty

  def self.from_object(obj)
    full_name = "#{obj.last_name} #{obj.first_name[0]}.#{obj.patronymic[0]}."
    new(obj.id, full_name, obj.specialty)
  end

  def initialize(id, full_name, specialty)
    self.id = id
    self.full_name = full_name
    self.specialty = specialty
  end

  def to_s
    "#{full_name} #{specialty}"
  end
end
