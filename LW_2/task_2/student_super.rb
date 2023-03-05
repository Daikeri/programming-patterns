

class StudentSuper
  GIT = /\Ahttps:\/\/github\.com\/\w+\z/
  PHONE = /^((8|\+7)[\- ]?)?(\(?\d{3}\)?[\- ]?)?[\d\- ]{7,10}$/
  TELEGRAM = /^@[A-Za-z\d_]{5,32}$/
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def StudentSuper.correct_git?(str)
    str.match?(GIT)
  end

  def StudentSuper.correct_phone?(str)
    str.match?(PHONE)
  end

  def StudentSuper.correct_telegram?(str)
    str.match?(TELEGRAM)
  end

  def StudentSuper.correct_email?(str)
    str.match?(EMAIL)
  end

  def StudentSuper.from_string(id, str)
    class_field = [:id, :last_name, :first_name, :patronymic, :git, :phone, :telegram, :email]

    begin
      value = str.split(', ')
      value.unshift(id)

      if value.size < class_field.size
        raise(ArgumentError,"Неверный формат переданной строки.\nПроверьте кол-во переданных значений.")
      end

      value = value.map { |val| val == '-' ? nil : val }
      arg = class_field.zip(value).to_h
    rescue NoMethodError
      puts 'Переданное значение не подлежит парсингу!'
    end
  end

  attr_accessor :id, :last_name,
                :first_name, :patronymic,
                :phone, :telegram,
                :email, :git

  protected

  def validate
    valid_id
    valid_full_name
    valid_git
    valid_contacts
  end

  def valid_id
    raise(ArgumentError, 'Обязательно должен быть указан ID!') unless @id
  end

  def valid_full_name
    raise(ArgumentError, 'ФИО - обязательные параметры!') unless @last_name && @first_name && @patronymic
  end

  def valid_git
    raise(ArgumentError, 'Обязательно должен быть указан Гит!') unless @git
  end

  def valid_contacts
    raise(ArgumentError, 'Должен быть указан хотя бы один контакт!') unless @phone || @telegram || @email
  end

  def set_contacts(git:, phone:, telegram:, email:)
    raise(ArgumentError, 'Неверный формат ссылки на Гит!') if git && !StudentSuper.correct_git?(git)
    raise(ArgumentError, 'Неверный формат номера телефона!') if phone && !StudentSuper.correct_phone?(phone)
    raise(ArgumentError, 'Неверный формат имени пользователя телеграмм!') if telegram && !StudentSuper.correct_telegram?(telegram)
    raise(ArgumentError, 'Неверный формат электронной почты!') if email && !StudentSuper.correct_email?(email)

    @git = git
    @phone = phone
    @telegram = telegram
    @email = email
  end
end
