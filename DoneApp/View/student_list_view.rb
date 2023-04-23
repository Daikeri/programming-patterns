require 'glimmer-dsl-libui'

class StudentListView
  include Glimmer

  attr_accessor :arr

  def initialize
    self.arr = [
      ['Алешина', 'Василиса', 'Денисовна', 'https://github.com/Daikeri', '+7 924 209 16 11', '-', '-'],
      ['Верещагин', 'Роман', 'Демидович', 'https://github.com/Lays_s_crabom', '-', '-', 'boykisser@gmail.com'],
      ['Дубровин', 'Михаил', 'Гордеевич', 'https://github.com/CVK_Tvorojock', '-', '@chezabarhatnietagi', '-'],
      ['Крылов', 'Григорий', 'Евгеньевич', 'https://github.com/CVK_Cringe', '-', '@mamyel', '-'],
      ['Богомолов', 'Александр', 'Романович', 'https://github.com/Lays_s_krabom', '-', '-', 'papyel@yandex.ru'],
      ['Алешина', 'Василиса', 'Денисовна',' https://github.com/Daikeri', '+7 924 209 16 11', '-', '-']
    ]
    @column_state = [:ascending, :descending, nil]
    @column_count = 0
  end

  def column_state
    @column_count = 0 if @column_count == 3
    result = @column_state[@column_count]
    @column_count += 1
    result
  end

  def sort_by_name(sort_order)
    return sort_order == :ascending ? arr.sort_by { |field| [field[0]] } : (arr.sort_by { |field| [field[0]] }).reverse if sort_order
    @arr_clone
  end

  def visualization
    window("My App", 1600, 600) {
      margined true
      tab {
        tab_item('Студенты') {
          # главный бокс, где сначала таблица, потом в горизонтальном блоке фильтрация и CRUD
          vertical_box {

            @students_table = table { |table|
              selection_mode :zero_or_many
              text_column('Фамилия') {
                @arr_clone = arr.dup
                on_clicked do |column|
                  state = column_state
                  column.sort_indicator = state
                  table.cell_rows = sort_by_name(state)
                end
              }
              text_column('Имя') {}
              text_column('Отчество') {}
              text_column('Git') {}
              text_column('Phone') {}
              text_column('Telegram') {}
              text_column('Email') {}
              button_column('button')

              #cell_rows arr
            }

            horizontal_box {
              stretchy false

              @labels_box = vertical_box {
                stretchy false
                label('Фамилия и инициалы')

                label('Наличие Git')

                label("Наличие номера телефона")

                label("Наличие Telegram")

                label("Наличие Email")
              }

              vertical_separator {
                stretchy false
              }

              @combos_box = vertical_box {
                stretchy false
                combo_items = ['Да', 'Нет', 'Не важно']

                combobox

                combobox { |combo|
                  items combo_items
                  selected combo.items[2]

                  on_selected do
                    if ['Не важно', 'Нет'].include?(combo.selected_item)
                      @git_search.enabled = false
                      @git_search.text = ''
                      @git_label.enabled = false
                    else
                      @git_search.enabled = true
                      @git_label.enabled = true
                    end
                  end
                }

                combobox { |combo|
                  items combo_items
                  selected combo.items[2]

                  on_selected do
                    if ['Не важно', 'Нет'].include?(combo.selected_item)
                      @phone_search.enabled = false
                      @phone_search.text = ''
                      @phone_label.enabled = false
                    else
                      @phone_search.enabled = true
                      @phone_label.enabled = true
                    end
                  end
                }

                combobox { |combo|
                  items combo_items
                  selected combo.items[2]

                  on_selected do
                    if ['Не важно', 'Нет'].include?(combo.selected_item)
                      @telegram_search.enabled = false
                      @telegram_search.text = ''
                      @telegram_label.enabled = false
                    else
                      @telegram_search.enabled = true
                      @telegram_label.enabled = true
                    end
                  end
                }

                combobox { |combo|
                  items combo_items
                  selected combo.items[2]

                  on_selected do
                    if ['Не важно', 'Нет'].include?(combo.selected_item)
                      @email_search.enabled = false
                      @email_search.text = ''
                      @email_label.enabled = false
                    else
                      @email_search.enabled = true
                      @email_label.enabled = true
                    end
                  end
                }
              }

              @pointers_box = vertical_box {
                stretchy false
                label('->')
                @git_label = label('->') { |label| label.enabled = false}
                @phone_label = label('->') {|label| label.enabled = false}
                @telegram_label = label('->') {|label| label.enabled = false}
                @email_label = label('->') {|label| label.enabled = false}
              }

              vertical_separator { stretchy false }

              @search_box = vertical_box {
                stretchy true

                search_entry

                @git_search = search_entry { |search|
                  search.enabled = false
                }

                @phone_search = search_entry { |search|
                  search.enabled = false
                }

                @telegram_search = search_entry { |search|
                  search.enabled = false
                }

                @email_search = search_entry { |search|
                  search.enabled = false
                }
              }

              vertical_separator { stretchy false }


              @button_box = vertical_box {
                stretchy true
                button('Добавить')
                button('Изменить')
                button('Удалить')
                button('Обновить')
              }
            }
          }
        }

        tab_item('Вкладка № 2')
        tab_item('Вкладка № 3')
      }
    }.show
  end

end
