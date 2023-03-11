# frozen_string_literal: true

class DataList
  def initialize(source_array)
    source_array.sort!
    @arr = source_array
    @select = []
  end

  def sel(numbers)
    begin
    numbers.is_a?(Array) ? @select += numbers.each { |el| Integer(el) } : @select += [Integer(numbers)]
    rescue ArgumentError
      puts "Переданное(-ые) значение(-ия) должно(-ы) быть целочисленным(и)!"
    end
  end

  def get_selected
    @select.inject([]) { |acc, el| acc + @arr[el]  }
  end

  def get_names
  end

  def get_data
  end
end
