require 'glimmer-dsl-libui'
require 'D:\RubyProject\IndividualProject\Controllers\TreatmentsTab\open_treatment_controller.rb'

class OpenTreatmentView
  include Glimmer

  attr_reader :doctor_labels, :patient_labels, :treatment_labels

  def initialize(selected_treatment, senior_controller)
    @controller = OpenTreatmentController.new(self, selected_treatment, senior_controller)
    @count = 3
  end

  def display
    @open_window = window('Запись', 800, 400) { |wind|
      grid{
        vertical_separator{
          top 0
          left 0
          xspan 2
          hexpand true
        }
        label('Карточка врача'){
          top 1
          left 0
          xspan 2
          halign :center
        }
        vertical_separator{
          top 2
          left 0
          xspan 2
          hexpand true
        }
        set_doctor_labels

        vertical_separator{
          top 8
          left 0
          xspan 2
          hexpand true
        }
        label('Карточка пациента'){
          top 9
          left 0
          xspan 2
          halign :center
        }
        vertical_separator{
          top 10
          left 0
          xspan 2
          hexpand true
        }
        set_patient_labels

        vertical_separator{
          top 15
          left 0
          xspan 2
          hexpand true
        }
        label('Информация о записи'){
          top 16
          left 0
          xspan 2
          halign :center
        }
        vertical_separator{
          top 17
          left 0
          xspan 2
          hexpand true
        }
        set_treatment_labels

        button('Закрыть'){
          top 21
          left 0
          xspan 2
          on_clicked do
            wind.destroy
          end
        }
      }
    }
    @controller.fill_view
    @open_window.show
  end

  def set_doctor_labels
    @doctor_labels = [:doc_attr1, :doc_attr2, :doc_attr3, :doc_attr4, :doc_attr5]
    doctor_fields = %w[Фамилия: Имя: Отчество: Специальность: Квалификация:]
    @doctor_labels.zip(doctor_fields).to_h.each do |key, val|
      label(val){
        top @count
        left 0
        halign :end
      }
      lb = label('Значение'){
        top @count
        left 1
      }
      self.instance_variable_set("@#{key}".to_sym, lb)
      @count += 1
    end
    @count = 11
  end

  def set_patient_labels
    @patient_labels = [:pat_attr1, :pat_attr2, :pat_attr3, :pat_attr4]
    patient_fields = %w[Фамилия: Имя: Отчество: Возраст:]
    @patient_labels.zip(patient_fields).to_h.each do |key, val|
      label(val){
        top @count
        left 0
        halign :end
      }
      lb = label('Значение'){
        top @count
        left 1
      }
      self.instance_variable_set("@#{key}".to_sym, lb)
      @count += 1
    end
    @count = 18
  end

  def set_treatment_labels
    @treatment_labels = [:treat_attr1, :treat_attr2, :treat_attr3]
    treatment_fields = %w[Назначение: Стоимость: Дата:]
    @treatment_labels.zip(treatment_fields).to_h.each do |key, val|
      label(val){
        top @count
        left 0
        halign :end
      }
      lb = label('Значение'){
        top @count
        left 1
      }
      self.instance_variable_set("@#{key}".to_sym, lb)
      @count += 1
    end
  end
end

