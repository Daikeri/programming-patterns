require 'D:\RubyProject\IndividualProject\Controllers\TreatmentsTab\treatments_controller.rb'
require 'D:\RubyProject\IndividualProject\Controllers\TreatmentsTab\delete_treatments_controller.rb'
require_relative 'open_treatment_view'
require_relative 'append_treatment_view'
require_relative 'update_treatment_view'

class TreatmentsView
  include Glimmer

  attr_reader :arr, :treatments_table

  def initialize(main_view)
    @main_view = main_view
    @controller = TreatmentsController.new(self)
  end

  def create
   tab_item('Процедуры/Консультации') {
      grid{
        @treatments_table = table {
          top 0
          left 3
          yspan 4
          vexpand true
          hexpand true
          selection_mode :zero_or_many
          text_column('№')
          text_column('Описание')
          text_column('Стоимость')
          text_column('Дата')
          cell_rows <= [self, :arr, column_attributes:
            {'№' => :arr[0], 'Описание' => :arr[1], 'Стоимость' => :arr[2], 'Дата' => :arr[3]}]

          on_selection_changed do |tbl, selection, added_selection, removed_selection|
            if selection.is_a?(Array)
              if selection.length == 1
                @delete_button.enabled = true
                @update_button.enabled = true
                @open_button.enabled = true
              else
                @delete_button.enabled = true
                @update_button.enabled = false
                @open_button.enabled = false
              end
            end
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
            number = @treatments_table.cell_rows[@treatments_table.selection.first].first
            on_clicked_update_but(number)
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
        @open_button = button('Открыть') { |but|
          vexpand true
          top 3
          left 0
          but.enabled = false
          on_clicked do
            number = @treatments_table.cell_rows[@treatments_table.selection.first].first
            on_clicked_open_but(number)
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
        vertical_separator {
          top 3
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
    @controller.on_treatments_view_created
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
      @treatments_table.cell_rows = matrix
    else
      @treatments_table.cell_rows = Array.new(4) { [] }
    end
  end

  def on_clicked_open_but(number)
    @open_treatment = OpenTreatmentView.new(number, @controller).display
  end

  def on_clicked_append_but
    @append_patient = AppendTreatmentView.new(@controller).display
  end

  def on_clicked_update_but(number)
    @update_patient = UpdateTreatmentView.new(number, @controller).display
  end

  def on_clicked_delete_but
    number = @treatments_table.cell_rows[@treatments_table.selection.first].first
    @delete_patient = DeleteTreatmentsController.new(number, @controller).delete
  end
end
