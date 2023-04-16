require_relative 'student_super'

class StudentShort < StudentSuper

  public_class_method :new

  attr_accessor :full_name, :contact

  def StudentShort.from_object(obj)
    new(obj.id, obj.get_info)
  end

  def initialize(id, str)
    #puts str.nil?
    decompose_str = str.split(', ')
    #decompose_str.each { |obj| print "#{obj}\n"}
    self.id = id
    self.full_name = decompose_str[0]
    self.git = decompose_str[1] == '-' ? nil : decompose_str[1]
    self.contact = decompose_str[2] == '-' ? nil : decompose_str[2]
  end

end
