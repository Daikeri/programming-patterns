require 'glimmer-dsl-libui'
require 'D:\RubyProject\DoneApp\Controllers\student_list_controller.rb'
require 'D:\RubyProject\DoneApp\Controllers\data_list_contract.rb'
require 'D:\RubyProject\DoneApp\Manipulators\data_table.rb'

class StudentListView
  include Glimmer
  include DataListContract

  attr_accessor :arr

  def initialize
    @controller = StudentListController.new(self)

    @current_page = 1
    @quan_rows = 10

    @column_state = [:ascending, :descending, nil]
    @column_count = 0

    @arr_sort_clone
    @table_search_clone
  end

  def on_create(data_source=nil)
    @controller.on_student_list_view_created(data_source)
    @controller.refresh_data(@current_page, @quan_rows)
  end

  def update(data_table_obj)
    rows = data_table_obj.n_rows
    columns = data_table_obj.n_columns
    arr = []
    (0...rows).each do |i|
      temp = []
      (0...columns).each { |j| temp << data_table_obj.get(i,j) }
      arr << temp
    end
    @table_zone.cell_rows = arr
  end

  def update_total_count(actual_count)
    @total_count = actual_count
    @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
  end

  def quan_pages(total_count, quan_rows)
    total_count % quan_rows != 0 ? total_count / quan_rows + 1 : total_count / quan_rows
  end

  def column_state
    @column_count = 0 if @column_count == 3
    result = @column_state[@column_count]
    @column_count += 1
    result
  end

  def reset_all
    @current_page = 1
    @quan_rows = 10
    @pagination_entry.text = '10'
    @pagination_label.text = "Страница № 0 из 0"
    @table_zone.cell_rows = Array.new(5) { [] }
  end

  def sort_by_name(current_arr, sort_order)
    return sort_order == :ascending ? current_arr.sort_by { |field| [field[1]] } : (current_arr.sort_by { |field| [field[1]] }).reverse if sort_order
    @arr_sort_clone
  end

  def create
    @students_tab = tab_item('Список студентов') {

      vertical_box {

        @pagination_zone = horizontal_box {
          stretchy false

          button('<') {
            stretchy false
            on_clicked do
              if @current_page > 1
                @current_page -= 1
                @full_name_column.sort_indicator = nil
                @arr_sort_clone = nil
                @column_count = 3
                @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                @controller.refresh_data(@current_page, @quan_rows)
              end
            end
          }

          button('>') {
            stretchy false
            on_clicked do
              if @current_page && @quan_rows > 0
                if @total_count % @quan_rows == 0
                  if @current_page < @total_count / @quan_rows
                  @current_page += 1
                  @full_name_column.sort_indicator = nil
                  @arr_sort_clone = nil
                  @column_count = 3
                  @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                  @controller.refresh_data(@current_page, @quan_rows)
                  end
                else
                  if @current_page <= @total_count / @quan_rows
                    @current_page += 1
                    @full_name_column.sort_indicator = nil
                    @arr_sort_clone = nil
                    @column_count = 3
                    @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                    @controller.refresh_data(@current_page, @quan_rows)
                  end
                end
              end
            end
          }

          label('Количество строк') { stretchy false}

          @pagination_entry = entry { |en|
            stretchy false
            en.text = "#{@quan_rows}"
            on_changed do |entry|
              if entry.text == '' || entry.text == '0'
                @current_page = 0
                @quan_rows = 0
                @pagination_label.text = "Страница № #{@current_page} из #{@quan_rows}"
                @table_zone.cell_rows = Array.new(5) { [] }
              elsif en.text.match?(/\b\d+\b/)
                @current_page = 1
                @quan_rows = entry.text.to_i
                @pagination_label.text = "Страница № #{@current_page} из #{quan_pages(@total_count, @quan_rows)}"
                @controller.refresh_data(@current_page, @quan_rows)
              end
            end
          }

          @pagination_label = label('')
        }

        @table_zone = table { |table|
          selection_mode :zero_or_many

          text_column('№')

          @full_name_column = text_column('ФИО') {
            on_clicked do |column|
              @arr_sort_clone ||= table.cell_rows
              state = column_state
              column.sort_indicator = state
              table.cell_rows = sort_by_name(table.cell_rows, state)
            end
          }

          text_column('Git')
          text_column('Контакты')

          cell_rows <= [self, :arr, column_attributes: {'№' => :arr[0],
                                                        'ФИО' => :arr[1],
                                                        'Git' => :arr[2],
                                                        'Контакт' => :arr[3]}]

          on_selection_changed do |tbl, selection, added_selection, removed_selection|
            if selection.is_a?(Array)
              if selection.length == 1
                @delete_button.enabled = true
                @update_button.enabled = true
              else
                @delete_button.enabled = true
                @update_button.enabled = false
              end
            end
          end
        }

        @manipulators_zone = horizontal_box {
          stretchy false

          @labels_box = vertical_box {
            stretchy false
            label('Фамилия и инициалы')
            label('Наличие Git')
            label("Наличие номера телефона")
            label("Наличие Telegram")
            label("Наличие Email")
          }

          vertical_separator { stretchy false }

          @combos_box = vertical_box {
            stretchy false

            combo_items = %w[Да Нет Неважно]

            combobox

            @git_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }

            @phone_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }

            @telegram_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }

            @email_combo = combobox { |combo|
              items combo_items
              selected combo.items[2]
            }
          }

          vertical_separator { stretchy false }

          @search_box = vertical_box {
            @unified_search = search_entry { |search|
              on_changed do
                filter_value = search.text
                filter_value.force_encoding("UTF-8")
                @table_search_clone ||= @table_zone.cell_rows
                @table_zone.cell_rows = @table_search_clone.dup
                if filter_value.empty?
                  @table_search_clone = nil
                else
                  @table_zone.cell_rows = @table_zone.cell_rows.filter do |row_data|
                    row_data.any? do |cell|
                      cell.to_s.downcase.include?(filter_value.downcase)
                    end
                  end
                end
              end
            }

            button('Отменить выбор') {
              on_clicked do
                @table_zone.selection = []
                @update_button.enabled = false
                @delete_button.enabled = false
              end
            }

            button('Сбросить фильтры') {
              on_clicked do
                item = 'Неважно'
                @git_combo.selected item
                @phone_combo.selected item
                @telegram_combo.selected item
                @email_combo.selected item
              end
            }

            horizontal_box {

              @load_button = button('Обзор') {
                |but| but.enabled = false
                on_clicked do
                  path = open_file
                  on_create({json_file: path}) if path
                end
              }

              label('Источник данных')  { stretchy false }

              combobox { |combo|
                items ['База данных', 'JSON-файл']
                on_selected do
                  reset_all
                  if combo.selected == 0
                    @load_button.enabled = false
                    on_create
                  elsif combo.selected == 1
                    @load_button.enabled = true
                    @table_zone.cell_rows
                  end
                end
              }
            }
          }

          vertical_separator { stretchy false }

          @button_box = vertical_box {
            button('Добавить') {}
            @update_button = button('Изменить') { |but| but.enabled = false }
            @delete_button = button('Удалить') { |but| but.enabled = false }
            button('Обновить')
          }
        }
      }
    }
  end

end

