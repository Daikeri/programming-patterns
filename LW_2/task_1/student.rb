
class Student

  attr_accessor :last_name, :first_name,
                :patronymic, :phone

  def initialize(_last_name, _first_name, _patronymic, _phone)
    @last_name = _last_name
    @first_name = _first_name
    @patronymic = _patronymic
    @phone = _phone
  end

  def get_info
    puts "Last Name - #{self.last_name} First Name - #{self.first_name} Patronymic - #{self.patronymic} Phone - #{self.phone}"
  end

end

