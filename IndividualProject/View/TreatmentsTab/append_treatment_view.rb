require 'D:\RubyProject\IndividualProject\Controllers\TreatmentsTab\append_treatment_controller.rb'
require 'glimmer-dsl-libui'

class AppendTreatmentView
  include Glimmer

  DATE = /^(0[1-9]|[12]\d|3[01])\.(0[1-9]|1[0-2])\.(19\d\d|20\d\d|21\d\d|22\d\d|23\d\d)$/
  COST = /^(?:\d{1,3}(?:,\d{3})*|\d+)(?:\.\d{2})?$/

  attr_reader :doctors_combo, :patients_combo

  def initialize(senior_controller)
    @controller = AppendTreatmentController.new(self, senior_controller)
    @required_fields = {
      diagnosis: false,
      cost: false,
      treatment_date: false,
    }
  end

  def display
    @append_window = window('Записаться', 600, 200) {
      margined true
      grid{
        padded true

        label('Врач'){
          top 0
          left 0
          valign :center
          halign :end
        }
        @doctors_combo = combobox{ |combo|
          top 0
          left 1
          hexpand true
          on_selected do
            fields_check
          end
        }

        label('Пациент'){
          top 1
          left 0
          valign :center
          halign :end
        }
        @patients_combo = combobox{
          top 1
          left 1
          on_selected do
            fields_check
          end
        }

        label('Назначение/Диагноз'){
          top 2
          left 0
          valign :center
          halign :end
        }
        @diagnosis_entry = entry {
          top 2
          left 1
          on_changed do |en|
            on_enter_values(en, nil, //, :diagnosis)
          end
        }

        label('Стоимость'){
          top 5
          left 0
          valign :center
          halign :end
        }
        @cost_check = label('check') { |lb|
          top 4
          left 1
          lb.enabled = false
        }
        @cost_entry = entry{
          top 5
          left 1
          on_changed do |en|
            on_enter_values(en, @cost_check, COST, :cost)
          end
        }

        label('Дата'){
          top 7
          left 0
          valign :center
          halign :end
        }
        @treatment_date_check = label('check') { |lb|
          top 6
          left 1
          lb.enabled = false
        }
        @treatment_date_entry = entry {
          top 7
          left 1
          on_changed do |en|
            on_enter_values(en, @treatment_date_check, DATE, :treatment_date)
          end
        }
        @append_button = button('Добавить') { |but|
          top 8
          left 1
          but.enabled = false
          on_clicked do
            input_scan
          end
        }
      }
    }
    @controller.fill_view
    @append_window.show
  end

  def input_scan
    begin
      all_entry_obj = self.instance_variables.select { |var| var.to_s.end_with?('entry') }
      all_entry_obj.map! { |sym| self.instance_variable_get(sym) }
      all_entry_obj.map! { |glimmer_obj| glimmer_obj.text.force_encoding("UTF-8") }
      all_entry_obj.map! { |text| text == '' ? nil : text }
      @controller.append(all_entry_obj)
      @append_window.destroy
    rescue => error
      print "#{error}\nappend_view"
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
        label_set_mode(label_obj, :on) if label_obj
        @required_fields[symbol] = false if @required_fields.key?(symbol)
        fields_check
      else
        label_set_mode(label_obj, :off) if label_obj
        @required_fields[symbol] = true if @required_fields.key?(symbol)
        fields_check
      end
    else
      label_set_mode(label_obj, :off) if label_obj
      @required_fields[symbol] = false if @required_fields.key?(symbol)
      fields_check
    end
  end

  def fields_check
    if @required_fields.values.all?(true) && @doctors_combo.selected != -1 && @patients_combo.selected != -1
      @append_button.enabled = true
    else
      @append_button.enabled = false
    end
  end
end
