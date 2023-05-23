require 'glimmer-dsl-libui'
require 'D:\RubyProject\IndividualProject\Controllers\PatientTab\patients_controller.rb'
require_relative 'append_patient_view'
require_relative 'update_patient_view'
require 'D:\RubyProject\IndividualProject\Controllers\PatientTab\delete_patient_controller.rb'

class PatientsView
  include Glimmer

  attr_reader :arr, :patient_table
  attr_accessor :age_sort_clone, :sortable_column

  def initialize(main_view)
    @main_view = main_view
    @controller = PatientsController.new(self)
    @filters = {}
    @column_age_states = [:ascending, :descending, nil]
    @column_age_count = 0
  end

  def create
    tab_item('Пациенты') {
      grid{
        @patient_table = table {
          top 0
          left 3
          yspan 3
          vexpand true
          hexpand true
          sortable false
          text_column('№')
          text_column('ФИО')
          @sortable_column = text_column('Возраст') {
            on_clicked do |column|
              sort_by_age(column)
            end
          }
          cell_rows <= [self, :arr, column_attributes:
            {'№' => :arr[0], 'ФИО' => :arr[1], 'Возраст' => :arr[2]}]

          on_selection_changed do |tbl, selection, added_selection, removed_selection|
            @delete_button.enabled = true
            @update_button.enabled = true
          end
        }
        button('Добавить') {
          vexpand true
          top 0
          left 0
          on_clicked do
            on_clicked_append_but
          end
        }
        @update_button = button('Изменить') { |lb|
          vexpand true
          top 1
          left 0
          lb.enabled = false
          on_clicked do
            on_clicked_update_but
          end
        }
        @delete_button = button('  Удалить  ') { |lb|
          vexpand true
          top 2
          left 0
          lb.enabled = false
          on_clicked do
            on_clicked_delete_but
          end
        }
        vertical_separator {
          top 0
          left 1
        }
        vertical_separator {
          top 1
          left 1
        }
        vertical_separator {
          top 2
          left 1
        }
        vertical_box {
          xspan 1
          top 0
          left 2
          label('') {
            stretchy false
          }
          combobox {
            stretchy false
          }
          horizontal_separator { stretchy false }
        }
      }
    }
    @controller.on_patients_view_created
    @controller.refresh_data
  end

  def update(pure_values)
    if pure_values.n_rows > 0
      rows = pure_values.n_rows
      columns = pure_values.n_columns
      matrix = []
      (0...rows).each do |row|
        columns_val = []
        (0...columns).each { |column| columns_val << pure_values.get(row, column) }
        matrix << columns_val
      end
      @patient_table.cell_rows = matrix
    else
      @patient_table.cell_rows = Array.new(3) { [] }
    end
  end

  def reset_filters
    @filters = {}
  end

  def on_clicked_append_but
    @append_patient = AppendPatientView.new(self, @controller).display
  end

  def on_clicked_update_but
    current_select = @patient_table.cell_rows[@patient_table.selection].first
    @update_patient = UpdatePatientView.new(self, @controller, current_select).display
  end

  def on_clicked_delete_but
    current_select = @patient_table.cell_rows[@patient_table.selection].first
    @delete_patient = DeletePatientController.new(self, @controller, current_select).delete
  end

  def sort_by_age(column)
    @age_sort_clone ||= @patient_table.cell_rows
    state = column_state
    column.sort_indicator = state
    @patient_table.cell_rows = sort(@age_sort_clone, state)
  end

  def column_state
    @column_age_count = 0 if @column_age_count == 3
    result = @column_age_states[@column_age_count]
    @column_age_count += 1
    result
  end

  def sort(current_arr, sort_order)
    sorted = current_arr.sort_by { |field| [field[2]] }
    if sort_order == :ascending
      return sorted
    elsif sort_order
      return sorted.reverse
    end
    @age_sort_clone
  end
end
