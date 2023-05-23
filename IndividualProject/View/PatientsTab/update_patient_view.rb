require 'D:\RubyProject\IndividualProject\Controllers\PatientTab\update_patient_controller.rb'
require 'glimmer-dsl-libui'

class UpdatePatientView
  include Glimmer

  NAME = /(^[А-Я][а-я]+$)|(^[A-Z][a-z]+$)/
  AGE = /^(?:[1-9]|[1-9][0-9]|1[01][0-9]|120)$/

  def initialize(main_view, senior_controller, number)
    @controller = UpdatePatientController.new(self, main_view, senior_controller, number)
    @required_fields = {
      last_name: true,
      first_name: true,
      patronymic: true,
      age: true,
    }
  end

  def display
    @update_window = window('Изменить пациента', 800, 200) {
      margined true
      grid {
        label('Фамилия') {
          top 1
          left 0
          valign :center
          halign :end
        }
        label('Имя'){
          top 3
          left 0
          valign :center
          halign :end
        }
        label('Отчество'){
          top 5
          left 0
          valign :center
          halign :end
        }
        label('Возраст'){
          top 7
          left 0
          valign :center
          halign :end
        }

        @last_name_entry = entry { |en|
          top 1
          left 1
          hexpand true
          on_changed do
            on_enter_values(en, @last_name_check, NAME, :last_name)
          end
        }
        @first_name_entry= entry { |en|
          top 3
          left 1
          on_changed do
            on_enter_values(en, @first_name_check, NAME, :first_name)
          end
        }
        @patronymic_entry = entry { |en|
          top 5
          left 1
          on_changed do
            on_enter_values(en, @patronymic_check, NAME, :patronymic)
          end
        }
        @age_entry = entry { |en|
          top 7
          left 1
          on_changed do
            on_enter_values(en, @age_check, AGE, :age)
          end
        }

        @last_name_check = label { |lb|
          top 0
          left 1
          lb.enabled = false
        }
        @first_name_check = label { |lb|
          top 2
          left 1
          lb.enabled = false
        }
        @patronymic_check = label { |lb|
          top 4
          left 1
          lb.enabled = false
        }
        @age_check = label { |lb|
          top 6
          left 1
          lb.enabled = false
        }

        @update_button = button('Изменить') { |but|
          vexpand true
          hexpand true
          top 10
          left 1
          on_clicked do
            self.input_scan
          end
        }
      }
    }
    @controller.fill_view
    @update_window.show
  end

  def input_scan
    begin
      all_entry_obj = self.instance_variables.select { |var| var.to_s.end_with?('entry') }
      all_entry_obj.map! { |sym| self.instance_variable_get(sym) }
      all_entry_obj.map! { |glimmer_obj| glimmer_obj.text.force_encoding("UTF-8") }
      all_entry_obj.map! { |text| text == '' ? nil : text }
      @controller.update(all_entry_obj)
      @update_window.destroy
    rescue => error
      print "#{error}\n"
    end
  end

  def label_set_mode(some_label, state)
    if state == :on
      some_label.enabled = true
      some_label.text = 'Неправильный формат введенной строки!'
    elsif state == :off
      some_label.enabled = false
      some_label.text = ''
    end
  end

  def on_enter_values(entry_obj, label_obj=nil, regex, symbol)
    filter_value = entry_obj.text
    filter_value.force_encoding("UTF-8")
    if filter_value != ''
      unless filter_value.match?(regex)
        label_set_mode(label_obj, :on)
        @required_fields[symbol] = false if @required_fields.key?(symbol)
        fields_check
      else
        label_set_mode(label_obj, :off)
        @required_fields[symbol] = true if @required_fields.key?(symbol)
        fields_check
      end
    else
      label_set_mode(label_obj, :off)
      @required_fields[symbol] = false if @required_fields.key?(symbol)
      fields_check
    end
  end

  def fields_check
    if @required_fields.values.all?(true)
      @update_button.enabled = true
    else
      @update_button.enabled = false
    end
  end
end
