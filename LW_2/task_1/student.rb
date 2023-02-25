
class Student

  PHONE = /^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/
  TELEGRAM = /^@[A-Za-z\d_]{5,32}$/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  GIT = /\Ahttps:\/\/github\.com\/\w+\z/

  def Student.correct_phone?(str)
    str.match?(PHONE)
  end

  def Student.correct_telegram?(str)
    str.match?(TELEGRAM)
  end

  def Student.correct_email?(str)
    str.match?(EMAIL)
  end

  def Student.correct_git?(str)
    str.match?(GIT)
  end

  attr_accessor :last_name, :first_name,
                :patronymic, :id,
                :phone, :telegram,
                :email, :git

  def initialize(arg = {})
    @last_name = arg[:last_name]
    @first_name = arg[:first_name]
    @patronymic = arg[:patronymic]
    @id = arg[:id]

    raise(ArgumentError, 'ФИО - обязательные параметры!') unless @last_name && @first_name && @patronymic

    set_contacts(arg[:phone], arg[:telegram], arg[:email], arg[:git])

    validate

  end

  def get_info
    puts "\nLast Name - #{last_name}\nFirst Name - #{first_name}\nPatronymic - #{patronymic}\nID - #{id}\nPhone - #{phone}\nTelegram - #{telegram}\nEmail - #{email}\nGit - #{git}\n"
  end

  protected

  def set_contacts(phone, telegram, email, git)
    raise(ArgumentError, 'Неверный формат номера телефона!') if phone && !Student.correct_phone?(phone)
    raise(ArgumentError, 'Неверный формат имени пользователя телеграмм!') if telegram && !Student.correct_telegram?(telegram)
    raise(ArgumentError, 'Неверный формат электронной почты!') if email && !Student.correct_email?(email)
    raise(ArgumentError, 'Неверный формат ссылки на Гит!') if git && !Student.correct_git?(git)

    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end

  def validate
    valid_git
    valid_other
  end

  def valid_git
    raise(ArgumentError, 'Обязательно должен быть указан Гит!') unless git
  end

  def valid_other
     raise(ArgumentError, 'Должен быть указан хотя бы один контакт!') unless phone || telegram || email
  end

end
