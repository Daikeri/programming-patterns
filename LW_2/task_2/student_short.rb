require_relative 'student.rb'

class StudentShort < Student

  def StudentShort.from_object(obj)
    id = obj.id
    str = obj.get_info
    new(id, str)
  end

  attr_reader :id, :full_name,
              :git, :contact

  def initialize(id, str)
    begin
      @id = Integer(id)
      value = str.split(', ').map! { |val| val == '-' ? nil : val }
    rescue ArgumentError
      puts 'Полю ID должно быть присвоено целочисленное значение!'
    rescue NoMethodError
      puts 'Переданное строка не подлежит парсингу!'
    end

    @full_name = value[0]
    raise(ArgumentError, 'Фамилия и инициалы - обязательный параметр!') unless @full_name

    set_contacts(value[1], value[2])
  end

  def get_info
    "#{@id} #{@full_name} #{@git} #{@contact}"
  end

  protected :last_name, :first_name, :patronymic,
            :phone, :telegram, :email,
            :last_name=, :first_name=, :patronymic=,
            :phone=, :telegram=, :email=

  protected

  def set_contacts(git, contact)
    value = contact.split('; ').map! { |val| val == '-' ? nil : val }
    phone, telegram, email = value

    #Git и конкретизированные контакты инициализируется методом родительского класса
    super(phone, telegram, email, git)
    validate

    @contact = get_contact
    @phone, @telegram, @email = nil
  end
end
