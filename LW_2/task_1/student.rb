
class Student

  def initialize(_last_name, _first_name, _patronymic, _phone)
    @last_name = _last_name
    @first_name = _first_name
    @patronymic = _patronymic
    @phone = _phone
  end

  def last_name
    @last_name
  end

  def last_name=(val)
    @last_name = val
  end

  def first_name
    @first_name
  end

  def first_name=(val)
    @first_name = val
  end

  def patronymic
    @patronymic
  end

  def patronymic=(val)
    @patronymic = val
  end

  def phone
    @phone
  end

  def phone=(val)
    @phone = val
  end

  def get_info
    puts "Last Name - #{self.last_name} First Name - #{self.first_name} Patronymic - #{self.patronymic} Phone - #{self.phone}"
  end

end

