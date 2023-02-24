
class Student

  attr_accessor :last_name, :first_name,
                :patronymic, :id,
                :phone, :telegram,
                :email, :git

  def initialize(arg = {})
    arg.default = 'unknown'

    @last_name = arg[:last_name]
    @first_name = arg[:first_name]
    @patronymic = arg[:patronymic]
    @id = arg[:id]
    @phone = arg[:phone]
    @telegram = arg[:telegram]
    @email = arg[:email]
    @git = arg[:git]

  end

  def get_info
    puts "\nLast Name - #{self.last_name}\nFirst Name - #{self.first_name}\nPatronymic - #{self.patronymic}\nID - #{self.id}\nPhone - #{self.phone}\nTelegram - #{self.telegram}\nEmail - #{self.email}\nGit - #{self.git}\n"
  end

end
