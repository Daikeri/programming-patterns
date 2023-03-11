# frozen_string_literal: true

class DataList
  def initialize(source_array)
    source_array.sort!
    @arr = source_array
    @select = []
  end

  def sel(numbers)
    numbers.is_a?(Array) ? @select += numbers : @select += [numbers]
  end

  def get_selected
    @select.is_a?(Array) ? @arr[@select.first..@select.last] : @arr[@select]
  end

  def get_names
  end

  def get_data
  end
end
