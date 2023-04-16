
class DataList

  protected

  attr_writer :data

  public

  attr_reader :names, :data

  def initialize(source_array)
    self.arr = source_array
    @select = []
  end

  def arr=(source_array)
    @arr = []
    count_obj = 1
    source_array.each do |obj|
      @arr.push([count_obj, obj])
      count_obj += 1
    end
    nil
  end

  def sel(number)
    @select.push(number)
    nil
  end

  def get_selected
    acc = []
    @select.each do |number|
      result = (@arr.find { |tuple| tuple[0] == number })
      acc.push(result[1].id)
    end
    acc
  end

  def clear_selected
    @select = []
    nil
  end

end
