
class Student

  attr_accessor :last_name, :first_name,
                :patronymic, :id,
                :phone, :telegram,
                :email, :git

  def initialize(_last_name, _first_name, _patronymic, _id:'unknown', _phone:'unknown',
                 _telegram:'unknown', _email:'unknown', _git:'unknown')

    @last_name = _last_name
    @first_name = _first_name
    @patronymic = _patronymic
    @id = _id
    @phone = _phone
    @telegram = _telegram
    @email = _email
    @git = _git

  end

  def get_info
    puts "\nLast Name - #{self.last_name}\nFirst Name - #{self.first_name}\nPatronymic - #{self.patronymic}\nID - #{self.id}\nPhone - #{self.phone}\nTelegram - #{self.telegram}\nEmail - #{self.email}\nGit - #{self.git}\n"
  end

end

