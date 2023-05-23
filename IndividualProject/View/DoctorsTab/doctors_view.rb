require 'glimmer-dsl-libui'
require 'D:\RubyProject\IndividualProject\Controllers\DoctorsTab\doctors_controller.rb'
require 'D:\RubyProject\IndividualProject\Controllers\DoctorsTab\delete_doctor_controller.rb'
require_relative 'append_doctor_view'
require_relative 'update_doctor_view'

class DoctorsView
  include Glimmer

  attr_reader :arr, :doctors_table
  attr_accessor :full_name_sort_clone, :sortable_column

  def initialize(main_view)
    @main_view = main_view
    @controller = DoctorsController.new(self)
    @filters = {}
    @column_full_name_states = [:ascending, :descending, nil]
    @column_full_name_count = 0
  end

  def create
    tab_item('Специалисты') {
      grid{
        @doctors_table = table {
          top 0
          left 3
          yspan 3
          sortable false
          vexpand true
          hexpand true
          text_column('№')
          @sortable_column = text_column('ФИО') {
            on_clicked do |column|
              sort_by_full_name(column)
            end
          }
          text_column('Специальность')
          cell_rows <= [self, :arr, column_attributes:
            {'№' => :arr[0], 'ФИО' => :arr[1], 'Специальность' => :arr[2]}]

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
        @update_button = button('Изменить') { |but|
          vexpand true
          top 1
          left 0
          but.enabled = false
          on_clicked do
            on_clicked_update_but
          end
        }
        @delete_button = button('  Удалить  ') { |but|
          vexpand true
          top 2
          left 0
          but.enabled = false
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
    @controller.on_doctors_view_created
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
      @doctors_table.cell_rows = matrix
    else
      @doctors_table.cell_rows = Array.new(3) { [] }
    end
  end

  def reset_filters
    @filters = {}
  end

  def on_clicked_append_but
    @append_doctor = AppendDoctorView.new(self, @controller).display
  end

  def on_clicked_update_but
    current_select = @doctors_table.cell_rows[@doctors_table.selection].first
    @update_doctor = UpdateDoctorView.new(self, @controller, current_select).display
  end

  def on_clicked_delete_but
    current_select = @doctors_table.cell_rows[@doctors_table.selection].first
    @delete_doctor = DeleteDoctorController.new(self, @controller, current_select).delete
  end

  def sort_by_full_name(column)
    @full_name_sort_clone ||= @doctors_table.cell_rows
    state = column_state
    column.sort_indicator = state
    @doctors_table.cell_rows = sort_by_name(@full_name_sort_clone, state)
  end

  def column_state
    @column_full_name_count = 0 if @column_full_name_count == 3
    result = @column_full_name_states[@column_full_name_count]
    @column_full_name_count += 1
    result
  end

  def sort_by_name(current_arr, sort_order)
    sorted = current_arr.sort_by { |field| [field[1]] }
    if sort_order == :ascending
      return sorted
    elsif sort_order
      return sorted.reverse
    end
    @full_name_sort_clone
  end
end
